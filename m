Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7A62D6604
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 20:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390497AbgLJTJ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 14:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393317AbgLJTJQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 14:09:16 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D461C0613D6
        for <linux-wireless@vger.kernel.org>; Thu, 10 Dec 2020 11:08:35 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id m13so7916515ljo.11
        for <linux-wireless@vger.kernel.org>; Thu, 10 Dec 2020 11:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tiGQOsA2klkv1qXekrlVwf/RUkwWp8joVEqz2IAnpjI=;
        b=dkGzcvNaF8MvQb5xdjQH8UUHB4R2PTkIBmbvBMfbsnfq27eyY5i36DrOPXxrGkwnQP
         csclMLt1Ex+Xb5a4jwUclj9/aoha9Bf3WdPY0D6d9D0FukvSmj/LtF/GVqQMSQjn8U8H
         B4I2pOo7BUfXnIgB/Ir8pq9i8/9s0oQBLjCG9l57eTn8V80h0f09Z/YyceZeWflDPT/W
         DWPijox8HFMQ2LqsxwAfgf0JoDcY0qnDMqnALsZBbaeBX+JinsCGrlC3R6S0rqvM8vzn
         DfjgoJfLA3Zr7+2sGebLIFp1x8LWkXzoT2GW5GlLRk/iiNcNsVvaoKmcfTyzv5WyYpfV
         rLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tiGQOsA2klkv1qXekrlVwf/RUkwWp8joVEqz2IAnpjI=;
        b=gVx8O+DeouZC1oVeMA/Uk/kXqGli608flYFrPMpQZvUSc3yCiiY0jZKliUz0lsEbw+
         zbTO/cM/zykzJxEeeitMrXRjyaMz2ZxTIhSYndgakaDEYxMOgmXaKCOWQaPCjPBAxza2
         FvoXARwey3G9OELZdg5+CUXRFBe5MF7sWFsahYlKPtLymmolhgaTuLWBGCBHqRrWsDil
         vVjjC9ORts1ioqjGhiVWI1oQmZzj8Kx0WccE69dcmHdhLJ6I9WWHsS33oUwAmgN/3g1k
         5JaHYQrdwSw7/e1J7KtKqMhAQ0tukcP9z4V0D4Rh6Qgrj02A5x6kucVYHzxBPrpQ5yHE
         meoQ==
X-Gm-Message-State: AOAM533n5ElLB1zSmmSxxDTAJkHGS/KILosIn36uXTzGMNEdXaDjqx4G
        DyMAbIb1TJTb8SUbeT/W7eA=
X-Google-Smtp-Source: ABdhPJz6GA5Da0wEKV6c4FvwykgABB09mB5UpLKQAA7Dx0awK+iGzWWYb/MqsEJybxxuDoJH/l0TVw==
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr3376178ljj.32.1607627313955;
        Thu, 10 Dec 2020 11:08:33 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id 187sm617962lfo.16.2020.12.10.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 11:08:33 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        sha-cyfmac-dev-list@infineon.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] brcmfmac: support BCM4365E with 43666 ChipCommon chip ID
Date:   Thu, 10 Dec 2020 20:08:19 +0100
Message-Id: <20201210190819.10444-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This adds support for the BCM43666/4 which seems to be using the same
firmware as BCM4366 (4366c0). I found it in the Netgear R8000P router.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       | 1 +
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 5bf11e46fc49..45037decba40 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -720,6 +720,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
 	case BRCM_CC_4365_CHIP_ID:
 	case BRCM_CC_4366_CHIP_ID:
 	case BRCM_CC_43664_CHIP_ID:
+	case BRCM_CC_43666_CHIP_ID:
 		return 0x200000;
 	case BRCM_CC_4359_CHIP_ID:
 		return (ci->pub.chiprev < 9) ? 0x180000 : 0x160000;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 45bc502fcb34..ff3721b20a9f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -77,6 +77,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_4366_CHIP_ID, 0x0000000F, 4366B),
 	BRCMF_FW_ENTRY(BRCM_CC_4366_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
+	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0x00000010, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
 };
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index c6c4be05159d..00309b272a0e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -48,6 +48,7 @@
 #define BRCM_CC_4365_CHIP_ID		0x4365
 #define BRCM_CC_4366_CHIP_ID		0x4366
 #define BRCM_CC_43664_CHIP_ID		43664
+#define BRCM_CC_43666_CHIP_ID		43666
 #define BRCM_CC_4371_CHIP_ID		0x4371
 #define CY_CC_4373_CHIP_ID		0x4373
 #define CY_CC_43012_CHIP_ID		43012
-- 
2.26.2

