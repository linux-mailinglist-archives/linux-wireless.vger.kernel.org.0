Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1553D2CDB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhGVSzy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 14:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhGVSzx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 14:55:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3846EC061575
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 12:36:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y42so10209752lfa.3
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ojab.ru; s=ojab;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jaMEi86/yRIF0nStxKvMT6tnJtS/t00o8y+9paLHic=;
        b=X5vNGwcPHmK39Sz/ZOY9rK5FOMkon7mIL6VGiwyEEzzWSybiBBIMLzUUHMif2LTtqU
         yEqELZv9aNUlhu0MBKg9PcotCpo1hpOCJwk9AJuKwxkpyRKzvYwuqZpuwGhpablx+8Ax
         zF/6t8I+ipzbTfQAc3Ur8Nbbr/b97Y4to0AOlgudq16Ze8JlRRv99HbBHqtj6QnUqMOn
         5RuZLfssgke8dR+fNMucQSDg0jRSwabJQIZZQHxfC3Kyk4AouHT3dAwhakGo86lD80fQ
         2cb1iRBSENupsQ7N4kcrsy/x8ROL5/zFwLS8EuUlZHvBiYegqTr4ag8J8p43uYOG3Ndt
         uEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jaMEi86/yRIF0nStxKvMT6tnJtS/t00o8y+9paLHic=;
        b=dhJ1iKj7wcopoEB0NXzIS3qOFQEMOBMX79bxMc9EgdUu3e+fWCXpTdZoAcD4XKOCC3
         ut2TT2s+4CMiNbQ00LkYCpSYH8rw1VlDnvx4bcJ8jhBq9z7gf8MmOiTWb6Dn8wNyeQf5
         sbNIAGgQw3nAWpuOis4FvjwvIASFoh3M0QdANK2pNbBgDbonotw5HqUq6Z4lpsFCJ9ow
         6rfQ9SXPQRUYFKMNDOcjfSaMysDBUzFeM+SoT7qfobwdj7gEp4LyiotDJxRKEaI9PDOM
         ZyvEUjKtnw80TxpbS+LHx0Mxab8vBclCaj4vuOmx5/A9iKIEUFRABv45TOsaOvRUFX2u
         jDHg==
X-Gm-Message-State: AOAM533FBjmtgnsHi/QsdUi8Xiz3XH/7kSw077SsOeLL2/92VEz0jKs4
        7ExxM2Qehtl/OloOZPqmKOWViA==
X-Google-Smtp-Source: ABdhPJyOCiVVxo9BvQ0t3cC1n/byEnaEHoXTNRxQm7kyHIjkLcm85M3Pt0R0CeGSJO/NFBRLNOox9g==
X-Received: by 2002:ac2:5684:: with SMTP id 4mr641352lfr.386.1626982585593;
        Thu, 22 Jul 2021 12:36:25 -0700 (PDT)
Received: from ojab.ru ([2a03:e2c0:1ce::2])
        by smtp.gmail.com with ESMTPSA id n8sm1813576lfk.198.2021.07.22.12.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 12:36:24 -0700 (PDT)
From:   ojab <ojab@ojab.ru>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     ojab <ojab@ojab.ru>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] ath10k: don't fail if IRAM write fails
Date:   Thu, 22 Jul 2021 19:35:00 +0000
Message-Id: <20210722193459.7474-1-ojab@ojab.ru>
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

Signed-off-by: Slava Kardakov <ojab@ojab.ru>
---
 Of course I forgot to sing off, since I don't use it by default because I
 hate my real name and kernel requires it

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
