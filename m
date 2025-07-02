Return-Path: <linux-wireless+bounces-24750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0048CAF098F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 06:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8B23BB01F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 04:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB313635E;
	Wed,  2 Jul 2025 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNfeZSAa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95486184
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 04:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751428960; cv=none; b=ohwVmHbbLpuDAWUVtuHTKs8BWxyujhp0B+QPgdIeqHr1sbDndqxmt4njP/394WnehBIxaoTSAa7w3JtlLKvM4Nc/HxmzAe5Lu5gvhizRIX+uZKPQjOjkvTqhIHpDb2QUiT54Jy41q4nfdJjdbE3dBRmPa3x0p/blF6knFrcExLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751428960; c=relaxed/simple;
	bh=N5qi2xSZtzlIQCm+RUtJbs0wH20MwYwBvnNTEpCCjqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C/Z59FHbBv+zeM/s2v8OszD+gP8AKYLoQHyFcOA5oHmUApioQW5pcI7RQfVGhFzM+/lvJhB/DbHVioXB9qxgJZCcoKdQ76Vp7p5Xg/KBbs1nT0dIQ6Z8R3g5cN719tLyIqJG6RwV0HhAcPceZUqs0oBgACqLgxYDHQuY/vFit+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNfeZSAa; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747e41d5469so4463760b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 21:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751428958; x=1752033758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DhSKO+rCbHnQTqHb6V9TXs+19XoxQEZozJ2vHkCgYcY=;
        b=mNfeZSAac+oKP0q4vHzaakraRmWVlMlwr2S0HgV1lD5avlpDEPjzyKK44EZeRVc/8e
         XIfUHBbhBDDkxh9FpDCU+LEpzO3+dOxzeY1oLl8OjFoyg4vt1lrIko46QZJMGQHVX445
         MgKPPYR3QdOPg6sf1/qRngl/ULG9mt+myC7pbspM3T4pXvzpKRBIsx/ID/zCfiOEiUhv
         y64dRyFaP4/b+59ozi3a3jlsJkzlzj1FnNXid7oD7Q9lCXh8dwg1YSvWbCoUnARhdMuz
         WKJ9P0i3dGwl8v4vgYQS8NfSu1/Z79jVkC0aLQs/K3RhlxkqpOW5qNwLRef7bY9UHe+c
         yUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751428958; x=1752033758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhSKO+rCbHnQTqHb6V9TXs+19XoxQEZozJ2vHkCgYcY=;
        b=Kc0amYst6ztXpelsYD+TUoSgJhAkY9bickmzU0bChZRC0EPMdiNCKZYM2TZlcTeySu
         PPnz5BbGSRwcmtaC6TPcfufEA/1SrqDmhv3c4dBD00UhzNJCcHdMiOKeoCKR6BTWsvmB
         VsbOvSaKyOc1KFmvDLIWegaPDo0dyieJDt+L2Mk6IFWySH3S5DgQa+wL33mKS9esFuvJ
         i44vWAolkADkwB+AAkmB0I3f6IAWvdfXOXiULx/rom3LwJkbAssW03DjPdvGmM/vGv1t
         FG9CFQX3mehKotJ9zlsAlqVZ2vzjJQ3S2hc81nh46DckUkYE2xaLmBHuBH/ixhob+HBd
         MCuA==
X-Forwarded-Encrypted: i=1; AJvYcCXpe3fItIp5ndz+LfZBP/kM4TYOmdSHH6yVh4+lTud9lmTS5fD+5X89NY/wenPbSqOb21I5rikYUGk18RqXTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPDkFS3gaaCr+uXZmAns0EpESGzYgTlUNTU/uo10w7CzTC6gs
	RmOOPfvZsVRHDtbDO2vQBS/3A4uetaRpNDPsE1CfOw0S4+MGwVKF4btJDH6J/Q==
X-Gm-Gg: ASbGncuPrxREDYDBIaJQZAb9FhbPogfFy5nCV+lACSKvgHfOTuUA1sf70CeNCTq8y7u
	GVI6y2uswOz6iaTEA5qYD+JOfGyq1+86Vlg41j8R+vE3Dt5rQxaz1QTBD6tJmpU7lLHY64Mu2M5
	NfGHZjCx4I/xucB9R8R3ogclymrybzlG2oDdbqzF9Rf/2jh525H1c2YHsbl10M0KuztYPoLrgFs
	gTRQSniwVulYOQjdR4ezd/TcGePUm3lEfXg+ApDm92x/pivi1uGV0NOW57+Wzl5bSO3Ph/C1MTX
	S7jG0yrgNwun8i4zUKfkojgQNbVed8zgR2LNRY3JmdJftifW4Yj3pHspjmXcCSdogo2LMDZnTlp
	z
X-Google-Smtp-Source: AGHT+IGFpuFkPao1EgLlXq+8JvGsgFJhUqPb/XMsVz/4FRSPiudUnDC4fwT6PR1p/UAEyYwpC4qh3w==
X-Received: by 2002:a05:6a00:2e1c:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-74b513196f4mr2005102b3a.8.1751428957704;
        Tue, 01 Jul 2025 21:02:37 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ca3f:f55b:cb90:6c59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541e5b6sm13924067b3a.54.2025.07.01.21.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 21:02:37 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kvalo@kernel.org
Cc: arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org,
	mgonzalez@freebox.fr,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] wifi: brcmfmac: Add support for the SDIO 43751 device
Date: Wed,  2 Jul 2025 01:02:28 -0300
Message-Id: <20250702040228.2452348-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SDIO ID and firmware matching for the SDIO 43751 device.

Based on the previous work from Marc Gonzalez <mgonzalez@freebox.fr>.

Tested on an i.MX6DL board connected to an AP6398SV chip with the
brcmfmac43752-sdio.bin firmware taken from:

https://source.puri.sm/Librem5/firmware-brcm43752-nonfree

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c     | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       | 2 ++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c       | 3 +++
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
 include/linux/mmc/sdio_ids.h                                  | 1 +
 5 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 6bc107476a2a..982b560a516a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -998,6 +998,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012, CYW),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43751, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
 	CYW_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 2ef92ef25517..f0f39fb68f82 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -738,6 +738,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
 	case BRCM_CC_4364_CHIP_ID:
 	case CY_CC_4373_CHIP_ID:
 		return 0x160000;
+	case CY_CC_43751_CHIP_ID:
 	case CY_CC_43752_CHIP_ID:
 	case BRCM_CC_4377_CHIP_ID:
 		return 0x170000;
@@ -1450,6 +1451,7 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
 		reg = chip->ops->read32(chip->ctx, addr);
 		return (reg & CC_SR_CTL0_ENABLE_MASK) != 0;
 	case BRCM_CC_4359_CHIP_ID:
+	case CY_CC_43751_CHIP_ID:
 	case CY_CC_43752_CHIP_ID:
 	case CY_CC_43012_CHIP_ID:
 		addr = CORE_CC_REG(pmu->base, retention_ctl);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index cf26ab15ee0c..49b8b4ce0c6c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -657,6 +657,7 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
 	BRCMF_FW_ENTRY(CY_CC_4373_CHIP_ID, 0xFFFFFFFF, 4373),
 	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012),
 	BRCMF_FW_ENTRY(CY_CC_43439_CHIP_ID, 0xFFFFFFFF, 43439),
+	BRCMF_FW_ENTRY(CY_CC_43751_CHIP_ID, 0xFFFFFFFF, 43752),
 	BRCMF_FW_ENTRY(CY_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752)
 };
 
@@ -3425,6 +3426,7 @@ static int brcmf_sdio_download_firmware(struct brcmf_sdio *bus,
 static bool brcmf_sdio_aos_no_decode(struct brcmf_sdio *bus)
 {
 	if (bus->ci->chip == CY_CC_43012_CHIP_ID ||
+	    bus->ci->chip == CY_CC_43751_CHIP_ID ||
 	    bus->ci->chip == CY_CC_43752_CHIP_ID)
 		return true;
 	else
@@ -4276,6 +4278,7 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 
 		switch (sdiod->func1->device) {
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
+		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43751:
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
 				  CY_4373_F2_WATERMARK);
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index c1e22c589d85..8975db60ac23 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -59,6 +59,7 @@
 #define CY_CC_4373_CHIP_ID		0x4373
 #define CY_CC_43012_CHIP_ID		43012
 #define CY_CC_43439_CHIP_ID		43439
+#define CY_CC_43751_CHIP_ID		43751
 #define CY_CC_43752_CHIP_ID		43752
 
 /* USB Device IDs */
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 7cddfdac2f57..bc94e373566b 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -76,6 +76,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
 #define SDIO_DEVICE_ID_BROADCOM_43439		0xa9af
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
+#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43751	0xaae7
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
 
 #define SDIO_VENDOR_ID_CYPRESS			0x04b4
-- 
2.34.1


