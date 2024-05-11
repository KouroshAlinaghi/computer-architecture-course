#include <stdio.h>

int main() {
	unsigned int a[10];

	unsigned int max_n = 0;
	for (int i = 0; i < 10; i++) {
		if (a[i] > max_n) {
			max_n = a[i];
		}
	}

	return 0;
}