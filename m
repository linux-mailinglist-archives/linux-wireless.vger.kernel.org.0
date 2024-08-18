Return-Path: <linux-wireless+bounces-11592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F12B955ED4
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 22:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE712814DE
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 20:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA5149E09;
	Sun, 18 Aug 2024 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="RgaHNLWB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA912B82
	for <linux-wireless@vger.kernel.org>; Sun, 18 Aug 2024 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724012167; cv=none; b=aWGxow51Wb5mgoKNPNG83CTeiMAtO9xP4XG3cxMhAzTJltzg3nNtrr2P1AfX/43yF1LGmH1wDI9JHG8HMGksfaxmUiCjKJu6sbctLcPwpX5F7d+PddB32N6LxHHpsvbkXlbpSM9h8YHbVJ75K6yHsXhzHkvcozbFaIvFH9L5pEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724012167; c=relaxed/simple;
	bh=2n7YuZ6pSiJ/UEyGULSuwguPojfoZhqCBQ1V2RtiS+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fGk6owzDY94IxKts+s0VBKEK0i2xYZYjw07mZ105K20BcHsoy9QFFcTu/kKd+jX2B5cBJltgDd/DnNp8sYSFOUYcJR2LcsDCQdhlgucbyeis88mucqIq1veAhSJthWO4OLzzvEDiOA+EznjBhKBeiwQ9fYZPUMq32BKoPLbJ40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=RgaHNLWB; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 50F8288327;
	Sun, 18 Aug 2024 22:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724012163;
	bh=rDuUrz5ODBclhRyRnkOB72gd8jL4nvufY4M1OPZWNao=;
	h=From:To:Cc:Subject:Date:From;
	b=RgaHNLWB6LsiraZ2//FwE5WI4fuOlO08kSm8QINJrWU/o2c8MWPnweaQJVgkDoORt
	 Wd4E16ddypEv3kZtf1ttVmlrO1etQqs7icWGlUOapAc6NuShldoqGqQt/rCxHtkjnv
	 xaBTkRPRbBQQvUvEE/dycnU77jqnhXiUju6DQxCFkEr7wc0Lj2+0UG0bE0VjDblbOe
	 kmFkP6Y+KkWgn1zJ6QvxT9WD/eqHC3d8Iz7It1qloZfyREh72OXA27p6dHVF7JpnDv
	 rLkmCM6p57fjA8T6iSHmMqQoiDcu7eGN8hukrvYolpNEg7/lMNQiJ8y/Ni/CoP/55e
	 K5gmtqZDDCKYA==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Chung-Hsien Hsu <stanley.hsu@cypress.com>,
	Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
	Marek Vasut <marex@denx.de>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Carter Chen <carter.chen@infineon.com>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Erick Archer <erick.archer@outlook.com>,
	Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mathias Krause <minipli@grsecurity.net>,
	Matthias Brugger <mbrugger@suse.com>,
	Owen Huang <Owen.Huang@infineon.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev
Subject: [PATCH 1/2] wifi: brcmfmac: add support for TRX firmware download
Date: Sun, 18 Aug 2024 22:12:25 +0200
Message-ID: <20240818201533.89669-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Chung-Hsien Hsu <stanley.hsu@cypress.com>

Add support to download TRX firmware for PCIe and SDIO.

Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
Signed-off-by: Marek Vasut <marex@denx.de> # Upport to current linux-next
---
NOTE: This is downstream upport from
      https://github.com/Infineon/ifx-wireless-drivers/
      branch RTM/v5.15.58-Indrik / tag release-v5.15.58-2024_0514
- ba34bf4816f9 ("brcmfmac: add support for TRX firmware download")
---
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "Rafał Miłecki" <zajec5@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Carter Chen <carter.chen@infineon.com>
Cc: Chung-Hsien Hsu <stanley.hsu@cypress.com>
Cc: Duoming Zhou <duoming@zju.edu.cn>
Cc: Erick Archer <erick.archer@outlook.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mathias Krause <minipli@grsecurity.net>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Owen Huang <Owen.Huang@infineon.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211@lists.linux.dev
Cc: linux-wireless@vger.kernel.org
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 12 +++++-
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 20 +++++++---
 .../broadcom/brcm80211/brcmfmac/trxhdr.h      | 38 +++++++++++++++++++
 3 files changed, 63 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/trxhdr.h

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ce482a3877e90..058a742d17eda 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -42,6 +42,7 @@
 #include "chip.h"
 #include "core.h"
 #include "common.h"
+#include "trxhdr.h"
 
 
 enum brcmf_pcie_state {
@@ -1684,6 +1685,8 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 					u32 nvram_len)
 {
 	struct brcmf_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
+	struct trx_header_le *trx = (struct trx_header_le *)fw->data;
+	u32 fw_size;
 	u32 sharedram_addr;
 	u32 sharedram_addr_written;
 	u32 loop_counter;
@@ -1697,8 +1700,13 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		return err;
 
 	brcmf_dbg(PCIE, "Download FW %s\n", devinfo->fw_name);
-	memcpy_toio(devinfo->tcm + devinfo->ci->rambase,
-		    (void *)fw->data, fw->size);
+	address = devinfo->ci->rambase;
+	fw_size = fw->size;
+	if (trx->magic == cpu_to_le32(TRX_MAGIC)) {
+		address -= sizeof(struct trx_header_le);
+		fw_size = le32_to_cpu(trx->len);
+	}
+	memcpy_toio(devinfo->tcm + address, (void *)fw->data, fw_size);
 
 	resetintr = get_unaligned_le32(fw->data);
 	release_firmware(fw);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 1461dc453ac22..08881e366cae2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -35,6 +35,7 @@
 #include "core.h"
 #include "common.h"
 #include "bcdc.h"
+#include "trxhdr.h"
 
 #define DCMD_RESP_TIMEOUT	msecs_to_jiffies(2500)
 #define CTL_DONE_TIMEOUT	msecs_to_jiffies(2500)
@@ -3346,17 +3347,26 @@ brcmf_sdio_verifymemory(struct brcmf_sdio_dev *sdiodev, u32 ram_addr,
 static int brcmf_sdio_download_code_file(struct brcmf_sdio *bus,
 					 const struct firmware *fw)
 {
+	struct trx_header_le *trx = (struct trx_header_le *)fw->data;
+	u32 fw_size;
+	u32 address;
 	int err;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
-	err = brcmf_sdiod_ramrw(bus->sdiodev, true, bus->ci->rambase,
-				(u8 *)fw->data, fw->size);
+	address = bus->ci->rambase;
+	fw_size = fw->size;
+	if (trx->magic == cpu_to_le32(TRX_MAGIC)) {
+		address -= sizeof(struct trx_header_le);
+		fw_size = le32_to_cpu(trx->len);
+	}
+	err = brcmf_sdiod_ramrw(bus->sdiodev, true, address,
+				(u8 *)fw->data, fw_size);
 	if (err)
 		brcmf_err("error %d on writing %d membytes at 0x%08x\n",
-			  err, (int)fw->size, bus->ci->rambase);
-	else if (!brcmf_sdio_verifymemory(bus->sdiodev, bus->ci->rambase,
-					  (u8 *)fw->data, fw->size))
+			  err, (int)fw_size, address);
+	else if (!brcmf_sdio_verifymemory(bus->sdiodev, address,
+					  (u8 *)fw->data, fw_size))
 		err = -EIO;
 
 	return err;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/trxhdr.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/trxhdr.h
new file mode 100644
index 0000000000000..0411c7c7ffb99
--- /dev/null
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/trxhdr.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (c) 2020 Cypress Semiconductor Corporation */
+
+#ifndef BRCMFMAC_TRXHDR_H
+#define BRCMFMAC_TRXHDR_H
+
+/* Bootloader makes special use of trx header "offsets" array */
+enum {
+	TRX_OFFSET_SIGN_INFO_IDX		= 0,
+	TRX_OFFSET_DATA_FOR_SIGN1_IDX		= 1,
+	TRX_OFFSET_DATA_FOR_SIGN2_IDX		= 2,
+	TRX_OFFSET_ROOT_MODULUS_IDX		= 3,
+	TRX_OFFSET_ROOT_EXPONENT_IDX		= 67,
+	TRX_OFFSET_CONT_MODULUS_IDX		= 68,
+	TRX_OFFSET_CONT_EXPONENT_IDX		= 132,
+	TRX_OFFSET_HASH_FW_IDX			= 133,
+	TRX_OFFSET_FW_LEN_IDX			= 149,
+	TRX_OFFSET_TR_RST_IDX			= 150,
+	TRX_OFFSET_FW_VER_FOR_ANTIROOLBACK_IDX	= 151,
+	TRX_OFFSET_IV_IDX			= 152,
+	TRX_OFFSET_NONCE_IDX			= 160,
+	TRX_OFFSET_SIGN_INFO2_IDX		= 168,
+	TRX_OFFSET_MAX_IDX
+};
+
+#define TRX_MAGIC	0x30524448		/* "HDR0" */
+#define TRX_VERSION	4			/* Version 4 */
+#define TRX_MAX_OFFSET	TRX_OFFSET_MAX_IDX	/* Max number of file offsets */
+
+struct trx_header_le {
+	__le32 magic;		/* "HDR0" */
+	__le32 len;		/* Length of file including header */
+	__le32 crc32;		/* CRC from flag_version to end of file */
+	__le32 flag_version;	/* 0:15 flags, 16:31 version */
+	__le32 offsets[TRX_MAX_OFFSET];	/* Offsets of partitions */
+};
+
+#endif /* BRCMFMAC_TRXHDR_H */
-- 
2.43.0


