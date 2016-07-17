#include "stm32f10x.h"

#include "stm32f10x.h"
int main(void)
{
	RCC->APB2ENR |= RCC_APB2Periph_GPIOC; // включаем тактирование порта
	GPIOC->CRH |= (0x3 << 20); // ставим частоту 50 МГц
	GPIOC->CRH &= (~(0xC << 20)); // переводим ногу в режим выхода тяни-толкай
	volatile long i = 0;
	while(1)
	{
		GPIOC->BSRR = GPIO_BSRR_BR13;
		for(i = 0; i < 1000*1000*5; i++){;};
		GPIOC->BSRR = GPIO_BSRR_BS13;
		for(i = 0; i < 1000*1000*5; i++){;};
	}
}
