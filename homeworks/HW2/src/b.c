int main() {
    int arr[20];

    for (int i = 0; i < 20; i++) {
        for (int j = i + 1; j < 20; j++) {
            if (arr[i] > arr[j]) {
                int tmp = arr[j];
                arr[j] = arr[i];
                arr[i] = tmp;
            }
        }
    }

    return 0;
}
