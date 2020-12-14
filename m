Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E92D9630
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Dec 2020 11:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgLNKQu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Dec 2020 05:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbgLNKQt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Dec 2020 05:16:49 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67425C0613CF
        for <linux-wireless@vger.kernel.org>; Mon, 14 Dec 2020 02:16:09 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id o17so25826975lfg.4
        for <linux-wireless@vger.kernel.org>; Mon, 14 Dec 2020 02:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JkMpozUdIONw9BUFXHyjFSwxPs9kU49qBKnwnp6rFk=;
        b=a8Yy3xXJCCXtHBFjs9ehRlPui5PWuVms1YYHasuomhSx1/lXpjoHMW/oOxlJ+OEnUX
         ZhLXGcNlbeZ+PtYqy7flcvMinj0IW24EsnvPL+FOsJP5jhJcBp2a2HTO1cmdRuTILnHx
         GHvjSQrKM9FxfBJDjCfHO6C9Fw9eYHxhDXpPSegnNmtkxVjKxnOm+N153Bna7HEWWhiA
         +rhcJIOpDLhSQe15wpW8FVyOOWYjgbFXSgqly1l72JFsMgRQyQrE1JzX9lO8LoGvd3PJ
         QJ7wJKzaS3RFX/K45W+yMEhka30snOO/ihDMcEkUkByaZHa1akvtkCb4xJGmVAt6uy/D
         TpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3JkMpozUdIONw9BUFXHyjFSwxPs9kU49qBKnwnp6rFk=;
        b=IeNY9yYsQnsot72fI4eve6yB5rCdo8H6vA/SRqQOFKjXAwjitnTx1JwoUwxsytCywu
         /OFaX6QMDr2a2TVlz+DswF70LBlSotQboy9w8Pggu/5uk1mnZ3B5jRKYK9eH1FZ3O7mi
         vBnAvZYXNhTiDAXVFQHbQm69oS5vNNde9MloUM6IxLF7oeDfziR5NlU0l0n/iXuQldab
         XZiYbShSyuLZ7EdXokN7bOlGY9tE+Jx5gWvh/HWePNxBCqkWqAc7SIMSna3YDGOJeO47
         D7+iYzoqHwHfpbRQehP8L1aELudwhlunJ5fTYOmYe6HeEYr2z5mEH1H8EDTVagxJAqu8
         JxMQ==
X-Gm-Message-State: AOAM5318M2O3e2A/3+1ZaAJQAvbt3hMbPIb1A31Asv6WLVjRGiWsO+tP
        7rXAvp8IvIyXvOLDmBO1Dtk=
X-Google-Smtp-Source: ABdhPJx2ME4Pactvwr9d8P82YhDK6izjnFzadXvgoilOKYXE7iMl9KWHBhGHdZJ/4br7eQNBWDWLeQ==
X-Received: by 2002:a2e:a545:: with SMTP id e5mr1873827ljn.0.1607940967799;
        Mon, 14 Dec 2020 02:16:07 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id e25sm1083346lfc.40.2020.12.14.02.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 02:16:07 -0800 (PST)
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
Subject: [PATCH V2] brcmfmac: support BCM4365E with 43666 ChipCommon chip ID
Date:   Mon, 14 Dec 2020 11:15:53 +0100
Message-Id: <20201214101553.32097-1-zajec5@gmail.com>
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
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
V2: Enable support for BCM43666/4 and *further* revisions
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
index 45bc502fcb34..ad79e3b7e74a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -77,6 +77,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_4366_CHIP_ID, 0x0000000F, 4366B),
 	BRCMF_FW_ENTRY(BRCM_CC_4366_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
+	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
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

