Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2053D2CC0
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 21:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhGVSuE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 14:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhGVSuE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 14:50:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F420C06175F
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 12:30:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i5so10228945lfe.2
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 12:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ojab.ru; s=ojab;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ki3EP487cHlKuJ8BiqZxtwSYC7B4SnWzmdp/UL5pFnk=;
        b=mfpcCjAgt8VnvUgRMgumJXzjEXRNrkL3py5aTk+1LV/vsKMx0cqZvEixFsf0yc8KFe
         ETx+LR45QTT4sYGWN7VSFazuAe3C1x3wB9pazgl6tZDiTr9Kdd76pt1bCqhWcTXE0Ugm
         8CuS7rIlHJwhGjVad+BVJUQix1FuYzrJNbLzNfziUWy2b+7vBy3N5zg4gQ3VgEh612f1
         mS+mNWCOEHOPnOU0jSVAvvlIjgXnqgGkwPkyb0gOgllWevhGevwpIl3c3Po+CGYZjQlZ
         ipsBTzQrffsE67Sjbu9TjTyXCVUJ9zf1MX45+DmqLcseV7Ibbd/yhUCG/WQrP5CtjEUI
         JDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ki3EP487cHlKuJ8BiqZxtwSYC7B4SnWzmdp/UL5pFnk=;
        b=KtwqbEWkkzS/pv7l5lOOFUdSY6NdwUq6pyeblDphoX7I+VquwgcneRU/JxeSUPJRgg
         45Rhz3hM+rvnG4llx+NSkdAPIT9GrnFAmFsrXZ6UzhfF71xOJDNZpl5kjmH31moqo71x
         YaXjbDPYmSaU1zTC7lx2tBj+dir5VD86o+SnIihZJc9QbMK+CV33CUUTUnWFVYKdRvo3
         hHmnJaxW/kG4i++BlozXKQNQ+fav0oY2v3lKY5NyXIoB7n3f2o0d2/LU0mAomqDnunVs
         OscLQIoA7/BXdVMqoJhX/EipSgC8uJOr98T0rwoxcpCuT2PUeJM6aNbl8P2lvyfC8Xr8
         8Eug==
X-Gm-Message-State: AOAM533c0c1aETXvZQAqouZFa8IBg8iunJ0QXcgMWm+BIkFl81SSsSV5
        Ql/C6zNIpiKjxfPZO8cBWHrgx9MsJGoLlDTS
X-Google-Smtp-Source: ABdhPJwEsuMO5wqqYtkztd0Y+meQb5roqH3WyT+0VBq7dzbd2tAOaqH0lRXxnfnnpX20pzcB6cON4w==
X-Received: by 2002:a05:6512:3393:: with SMTP id h19mr649086lfg.58.1626982236011;
        Thu, 22 Jul 2021 12:30:36 -0700 (PDT)
Received: from ojab.ru ([2a03:e2c0:1ce::2])
        by smtp.gmail.com with ESMTPSA id e5sm3198061ljk.51.2021.07.22.12.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 12:30:35 -0700 (PDT)
From:   ojab <ojab@ojab.ru>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     ojab <ojab@ojab.ru>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ath10k: don't fail if IRAM write fails
Date:   Thu, 22 Jul 2021 19:29:37 +0000
Message-Id: <20210722192937.4847-1-ojab@ojab.ru>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After reboot with kernel & firmware updates I found `failed to copy
target iram contents:` in dmesg and missing wlan interfaces for both
of my QCA9984 compex cards. Rolling back kernel/firmware didn't fixed
it, so while I have no idea what's actually happening, I don't see why
we should fail in this case, looks like some optional firmware ability
that could be skipped.

Also with additional logging there is
```
[    6.839858] ath10k_pci 0000:04:00.0: No hardware memory
[    6.841205] ath10k_pci 0000:04:00.0: failed to copy target iram contents: -12
[    6.873578] ath10k_pci 0000:07:00.0: No hardware memory
[    6.875052] ath10k_pci 0000:07:00.0: failed to copy target iram contents: -12
```
so exact branch could be seen.
---
 drivers/net/wireless/ath/ath10k/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 2f9be182fbfb..d9fd5294e142 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2691,8 +2691,10 @@ static int ath10k_core_copy_target_iram(struct ath10k *ar)
 	u32 len, remaining_len;
 
 	hw_mem = ath10k_coredump_get_mem_layout(ar);
-	if (!hw_mem)
+	if (!hw_mem) {
+		ath10k_warn(ar, "No hardware memory");
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < hw_mem->region_table.size; i++) {
 		tmp = &hw_mem->region_table.regions[i];
@@ -2702,8 +2704,10 @@ static int ath10k_core_copy_target_iram(struct ath10k *ar)
 		}
 	}
 
-	if (!mem_region)
+	if (!mem_region) {
+		ath10k_warn(ar, "No memory region");
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < ar->wmi.num_mem_chunks; i++) {
 		if (ar->wmi.mem_chunks[i].req_id ==
@@ -2917,7 +2921,6 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
 		if (status) {
 			ath10k_warn(ar, "failed to copy target iram contents: %d",
 				    status);
-			goto err_hif_stop;
 		}
 	}
 
-- 
2.32.0

