Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7510EA139D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 10:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfH2I1M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 04:27:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45605 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2I1M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 04:27:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so929337lff.12
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2019 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3srJCNAqJ/DePTpgn5ztlE8woeMdaWJS61PTrjiFD6U=;
        b=CufiLxcenwi7yQGmDBUlYwZn9HJLB2VoZGq58bqKZhfc8Mit+44Svo3+A95E8L6dgv
         UkuOoaKcufEIG5BKQrDfRxgZar5CvHE3SNg0yqwF/9qjPbt/EyjkwWPVzAYqg5OKhE1E
         XqfCZfvVSb6z4Xgq3/NyWAbERhmTHP6Y2yjGY51hOwXdXbvTqTgM/DSlrfNSJ4m3PNKS
         uQJ+AvvhTmj2aYTVc/kkUNGqXO/vRWOEFvaDGU9GGDaApADTuvKiAdburBUMyPlSz+Xo
         cXtWQSpefuvmj/EEBrOScr2Zov1dYepO7VvhF2Exf9pt8fHUSimAvl6NgkNhR2ISLRou
         lHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3srJCNAqJ/DePTpgn5ztlE8woeMdaWJS61PTrjiFD6U=;
        b=hw0QOmF5452PcGXlCHOOwEahzOY6TBmqZAvpqk5pq4Uw4MtW4oiDLMYWZbvon1JxG8
         cakHcf+USM78HeQetRuhcDXoiWAgktCKv5udKRN2SHzuIhYIqnYenEW2a7UbCbRNPSvA
         8tdiT5HJODBJr5EYjlHfMvioU4kTqOg8FyOg/XUUouX7WK+xPCiEFEvSR5dkq21CyCBh
         tqnGbWxWam9U+8MfMeDyODu5YQUrA/HK9Y9JWzX5XtGkMUtubaOdgl1TQXqLBEbJ5kGm
         pwb4btJBfENfPslcEixZ88CPC6na+7rsl/lvUa7AgAN1LO75u/JN9K6la4YSDME6Z6Qu
         U/Ng==
X-Gm-Message-State: APjAAAWzmY/h5wfdoecVUkW9WOIA/0YEvXyOVmYV9PnHzZvxuC1TI0Nm
        OBbfbWaQNzXfh/YZN2qPVIU=
X-Google-Smtp-Source: APXvYqwDbv4ooJeb3/c62iTEt5EQ4fgjKnoen1hANVTg5JUHF/n6LbpYpaiEsxhtIh6QoxMXnJ3odg==
X-Received: by 2002:ac2:47f4:: with SMTP id b20mr5122509lfp.86.1567067229630;
        Thu, 29 Aug 2019 01:27:09 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id m4sm245490ljj.78.2019.08.29.01.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:27:09 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH -next] brcmfmac: get chip's default RAM info during PCIe setup
Date:   Thu, 29 Aug 2019 10:27:01 +0200
Message-Id: <20190829082701.1715-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Getting RAM info just once per driver's lifetime (during chip
recognition) is not enough as it may get adjusted later (depending on
the used firmware). Subsequent inits may load different firmwares so a
full RAM recognition is required on every PCIe setup. This is especially
important since implementing hardware reset on a firmware crash.

Moreover calling brcmf_chip_get_raminfo() makes sure that RAM core is
up. It's important as having BCMA_CORE_SYS_MEM down on BCM4366 was
resulting in firmware failing to initialize and following error:
[   65.657546] brcmfmac 0000:01:00.0: brcmf_pcie_download_fw_nvram: Invalid shared RAM address 0x04000001

This change makes brcmf_chip_get_raminfo() call during chip recognition
redundant for PCIe devices but SDIO and USB still need it and it's a
very small overhead anyway.

Fixes: 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This is a refreshed version of previous:
[PATCH 2/4] brcmfmac: get RAM info right before downloading PCIe firmware
https://patchwork.kernel.org/patch/10830171/

After Arend's comment I did some extra research on driver's RAM info
code and updated commit properly.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c | 6 ++++--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 1ec48c4f4d4a..dd586a96b57a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -696,8 +696,10 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
 	return 0;
 }
 
-static int brcmf_chip_get_raminfo(struct brcmf_chip_priv *ci)
+int brcmf_chip_get_raminfo(struct brcmf_chip *pub)
 {
+	struct brcmf_chip_priv *ci = container_of(pub, struct brcmf_chip_priv,
+						  pub);
 	struct brcmf_core_priv *mem_core;
 	struct brcmf_core *mem;
 
@@ -979,7 +981,7 @@ static int brcmf_chip_recognition(struct brcmf_chip_priv *ci)
 		brcmf_chip_set_passive(&ci->pub);
 	}
 
-	return brcmf_chip_get_raminfo(ci);
+	return brcmf_chip_get_raminfo(&ci->pub);
 }
 
 static void brcmf_chip_disable_arm(struct brcmf_chip_priv *chip, u16 id)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h
index 206d7695d57a..7b00f6a59e89 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.h
@@ -69,6 +69,7 @@ struct brcmf_buscore_ops {
 	void (*activate)(void *ctx, struct brcmf_chip *chip, u32 rstvec);
 };
 
+int brcmf_chip_get_raminfo(struct brcmf_chip *pub);
 struct brcmf_chip *brcmf_chip_attach(void *ctx,
 				     const struct brcmf_buscore_ops *ops);
 void brcmf_chip_detach(struct brcmf_chip *chip);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 8d0e74416643..7ac945369762 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1770,6 +1770,12 @@ static void brcmf_pcie_setup(struct device *dev, int ret,
 	nvram_len = fwreq->items[BRCMF_PCIE_FW_NVRAM].nv_data.len;
 	kfree(fwreq);
 
+	ret = brcmf_chip_get_raminfo(devinfo->ci);
+	if (ret) {
+		brcmf_err(bus, "Failed to get RAM info\n");
+		goto fail;
+	}
+
 	/* Some of the firmwares have the size of the memory of the device
 	 * defined inside the firmware. This is because part of the memory in
 	 * the device is shared and the devision is determined by FW. Parse
-- 
2.21.0

