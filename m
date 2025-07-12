Return-Path: <linux-wireless+bounces-25329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A57B02D42
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 23:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A60F4A3EDD
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBFB19CC11;
	Sat, 12 Jul 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC6BOSHF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D603C3C
	for <linux-wireless@vger.kernel.org>; Sat, 12 Jul 2025 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752357243; cv=none; b=ZWJe9c5Np+kAotmmV6X6+S9u031vf9F3lzw93w0/oKg17HT0Wk5JF+jXtc4VxjEsmNY7/wN2uBmM3VXRPwzxk5s7qhQXSg4vTdY34R0238XZNvb10uYQmitGRiUbUhc3LpWOis9+NsXmH/4sWuzBNqTuR/3Huh2KHjrL+S8IZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752357243; c=relaxed/simple;
	bh=eHLst7r/Yl4oPkSrsG4+yDmp6MaT9apenwLTT2wuIys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uSuHIegRltyN/rahQfuZGdkB/eV0ZDZ46x5yeg0w+QTjEKD/tcCtObl5ZMzV9lt5gNICjZtgdwXRsgbK4vZ4UP/BRqIfthwgOiYi+QSMs4WcQDhrDJY1LUPgW3ERVLLouYlfFKTcYlFu4BSE9v7lxjwpCoRC++5IqaGRzrDIqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC6BOSHF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23c8a505177so30148975ad.2
        for <linux-wireless@vger.kernel.org>; Sat, 12 Jul 2025 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752357241; x=1752962041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9t2PTszHgzxnSRXUeSEU7gxzv48WwQ11r88H+C2sCmM=;
        b=AC6BOSHFSuslgkw90KeBBbCfvJz+xE4uAagJjxsycuWpqazwjjAeaRT+idFhOJmRYu
         WB5IIRnTG6EgIAs04a+WLh7RuuKHRVa1ww5nIfh5clJWq/Bd+oa8mOqa1lYI4NpGwn2c
         DX+34rG2ZvyWSfA2/jrMxsZ4HTguqB5qQgTMyTS0ES7TSOlLmAxKeF9gYi85W/jlhLdr
         DCBLSlGjzYhE1N5kYMogybUHuh8k7xOtLw0y6tNhivDGu/9csXDbYw2p3dDhNsZLGBtj
         4tcIrloP1L3qBxZwtpKursFCxYx7DoKZusC9IEA9XX3QvJJX7gmTttJi6bZQg/nzVr8N
         /cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752357241; x=1752962041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9t2PTszHgzxnSRXUeSEU7gxzv48WwQ11r88H+C2sCmM=;
        b=Wq4l+as5eI7FANDbV/l2Nem6E1t9NfiOESxqdXYH8ruk+A8HucJo0/GQK6iSelliHx
         Ql3HhlEXJ+D6sXrJ0RubHw6UcMJpprkkCIWZa0YfjWd7iJSw9XGvSUnHmFw/wwwGKfyI
         qhQ9gP84wmZ+01oXBVoyeFVFFGWRcESBQZ803NNsIEPcODuCH0Pp6J/VsabvaivoRrEx
         arBMrsX4Gyrz7kudqLzeDIm6XOSn8vXn9RqZpcv26G4zURkUM9dpf7jKNxz+xQoqHXJa
         S8Si49jU1KbycNIMObek8CxIhS2jUYoEnCtFKNpwPBfgV1sHSoO9fXmWpnEYHB93fTDX
         5EJg==
X-Forwarded-Encrypted: i=1; AJvYcCWnTtGGxM8r+biqkEd9abOSaeipI6iWAgUEKppust+fGpk4406Q8ZSVO225z9TORu80Yp065mebRLMnVyuyeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fCvLtcuI6mQRDo/m+HWjIouz7liGVI6yiNzMEofur0Iu307S
	qsKZi7OzESEIdvRZRFRnRKfCuF7OpfCOmQntqCJagWDNOOAePSUTcdiy
X-Gm-Gg: ASbGncv/tzIRecmUuT9KXfOD+rViyxiCGWGNiJ1Ek5gG8wmbeDEVEvgJmbWZfqaw4Hk
	tXl3z6hWGpuhkdCdtO6hCIJnemf4VwqVETWG8nb4Zvk+hZKHjxdGxw9WJxiAxrg4qaCYTX8ODgQ
	HljDOK3zYzJglKBsvrIxYx4OiBCxDnxMMLZhXa00h26LGgPXD3XwL8z6z0EFIZgiCpIPsTrqW9s
	znayuNQqeD7AqvyCmH3rsDSH0dIx3xZtPwrUfS4zAWiiDraHzMp2W6kfE4QHLieBjBB6+yc8JnI
	tO6UTnb42Etrcm7YmRSg0aoV5JoNkgMfNi+0ssyP7vyDYPKeslQQxURT418sgbJiBM4SjhkQsAa
	TtSHYSZKNQoE6/zium1gEELKluBVH1A6Ev6wd
X-Google-Smtp-Source: AGHT+IFVxpQuHYpwu2vXioi8JopinJbZ+EVp5uC4TI8rxfhDL9hiqSyGKTq9NPnQUNmnsQpL46PIzA==
X-Received: by 2002:a17:902:ef03:b0:235:e1e4:ec5e with SMTP id d9443c01a7336-23dedea54f2mr133457175ad.49.1752357240929;
        Sat, 12 Jul 2025 14:54:00 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:e872:391a:3cd2:8bd1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4366698sm71779115ad.246.2025.07.12.14.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:53:59 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kvalo@kernel.org
Cc: arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org,
	gokulkumar.sivakumar@infineon.com,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] wifi: brcmfmac: Add support for the SDIO 43751 device
Date: Sat, 12 Jul 2025 18:53:07 -0300
Message-Id: <20250712215307.1310802-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SDIO ID and firmware matching for the 43751 device.

Based on the previous work from Marc Gonzalez <mgonzalez@freebox.fr>.

Tested on an i.MX6DL board connected to an AP6398SV chip with the
brcmfmac43752-sdio.bin firmware taken from:

https://source.puri.sm/Librem5/firmware-brcm43752-nonfree

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Do not declare 43751 as a Infineon/Cypress device. (Gokul)

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c    | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c      | 2 ++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c      | 5 ++++-
 .../net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h    | 1 +
 include/linux/mmc/sdio_ids.h                                 | 1 +
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 6bc107476a2a..8ab7d1e34a6e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -996,6 +996,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43751, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 2ef92ef25517..9074ab49e806 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -739,6 +739,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
 	case CY_CC_4373_CHIP_ID:
 		return 0x160000;
 	case CY_CC_43752_CHIP_ID:
+	case BRCM_CC_43751_CHIP_ID:
 	case BRCM_CC_4377_CHIP_ID:
 		return 0x170000;
 	case BRCM_CC_4378_CHIP_ID:
@@ -1450,6 +1451,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
 		reg = chip->ops->read32(chip->ctx, addr);
 		return (reg & CC_SR_CTL0_ENABLE_MASK) != 0;
 	case BRCM_CC_4359_CHIP_ID:
+	case BRCM_CC_43751_CHIP_ID:
 	case CY_CC_43752_CHIP_ID:
 	case CY_CC_43012_CHIP_ID:
 		addr = CORE_CC_REG(pmu->base, retention_ctl);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index cf26ab15ee0c..8a0bad5119a0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -654,6 +654,7 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_4354_CHIP_ID, 0xFFFFFFFF, 4354),
 	BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
 	BRCMF_FW_ENTRY(BRCM_CC_4359_CHIP_ID, 0xFFFFFFFF, 4359),
+	BRCMF_FW_ENTRY(BRCM_CC_43751_CHIP_ID, 0xFFFFFFFF, 43752),
 	BRCMF_FW_ENTRY(CY_CC_4373_CHIP_ID, 0xFFFFFFFF, 4373),
 	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012),
 	BRCMF_FW_ENTRY(CY_CC_43439_CHIP_ID, 0xFFFFFFFF, 43439),
@@ -3424,7 +3425,8 @@ static int brcmf_sdio_download_firmware(struct brcmf_sdio *bus,
 
 static bool brcmf_sdio_aos_no_decode(struct brcmf_sdio *bus)
 {
-	if (bus->ci->chip == CY_CC_43012_CHIP_ID ||
+	if (bus->ci->chip == BRCM_CC_43751_CHIP_ID ||
+	    bus->ci->chip == CY_CC_43012_CHIP_ID ||
 	    bus->ci->chip == CY_CC_43752_CHIP_ID)
 		return true;
 	else
@@ -4275,6 +4277,7 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 				   bus->hostintmask, NULL);
 
 		switch (sdiod->func1->device) {
+		case SDIO_DEVICE_ID_BROADCOM_43751:
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index c1e22c589d85..6564616a57df 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -52,6 +52,7 @@
 #define BRCM_CC_43664_CHIP_ID		43664
 #define BRCM_CC_43666_CHIP_ID		43666
 #define BRCM_CC_4371_CHIP_ID		0x4371
+#define BRCM_CC_43751_CHIP_ID		43751
 #define BRCM_CC_43752_CHIP_ID		43752
 #define BRCM_CC_4377_CHIP_ID		0x4377
 #define BRCM_CC_4378_CHIP_ID		0x4378
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 7cddfdac2f57..fe3d6d98f8da 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -76,6 +76,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
 #define SDIO_DEVICE_ID_BROADCOM_43439		0xa9af
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
+#define SDIO_DEVICE_ID_BROADCOM_43751		0xaae7
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
 
 #define SDIO_VENDOR_ID_CYPRESS			0x04b4
-- 
2.34.1


