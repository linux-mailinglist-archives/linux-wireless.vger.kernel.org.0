Return-Path: <linux-wireless+bounces-24420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FEDAE60F5
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 11:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A674189E67B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127D127AC28;
	Tue, 24 Jun 2025 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="kaeSgwkd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1F27A445
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757793; cv=none; b=WzseJVoPqHsPHoOI8SHsZMVIdEfWG5jjYQeAoDFATHiqQXSm4JwXIziVyOn3cH8HMnHuE75Zc00x3gLhG5MFQqVWduQFZ98ibQcIrKXAfL5xUyuxqpu66wljocBHZjfPeJ5O/a6ezMOxSg20fHmx5W8k1o3i6qZLYajaQdJ6Jfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757793; c=relaxed/simple;
	bh=sySRy8KlLGNFIBaDG6aOtQTMR8ZEGj4kTv7tb2uxqic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i6qY5WZl1VmQdE//G63qmlnAOtor8LclVSKiRBvGPz3IqztpHbTatFNEfrVg9lZoW/sp7VWJhjXaxNfdtwbMYJnJ2qo45OAt6OxS02jm731ZhTNKUAG/Tj6UTyatNe2oVwjyI8KqAmHp82yuED98v+++R4cz+btOv0MXhEDBc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=kaeSgwkd; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1750757791; x=1782293791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sySRy8KlLGNFIBaDG6aOtQTMR8ZEGj4kTv7tb2uxqic=;
  b=kaeSgwkdoYvtZlv+i5MVFHKNkBLwqp1sdX0DHLP9MVKa4FKN9lT4wWvc
   yZHRiUu88RL3iWe6K1mcmDzXunwvt8TEgenNROAMyfeoRlJU/Vm9/T7RJ
   H7HSoNE+SBxVDRIO4iqWKqdgiU4X4XStFz45Hnv6Ruu0D1wHOScjFlk6o
   0=;
X-CSE-ConnectionGUID: k73T5ljwRAGa6mBkFrKyOw==
X-CSE-MsgGUID: SMVbOx4bRfaAZeyQw+S8Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="55587175"
X-IronPort-AV: E=Sophos;i="6.16,261,1744063200"; 
   d="scan'208";a="55587175"
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 11:35:19 +0200
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 24 Jun
 2025 11:35:18 +0200
Received: from iot-wlan-dev-u03.aus.cypress.com (10.161.6.196) by
 MUCSE835.infineon.com (172.23.7.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 11:35:16 +0200
From: Ian Lin <ian.lin@infineon.com>
To: <johannes@sipsolutions.net>, <arend.vanspriel@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<carter.chen@infineon.com>, <double.lo@infineon.com>,
	<vinoth.sampath@infineon.com>, <gokulkumar.sivakumar@infineon.com>,
	<ian.lin@infineon.com>
Subject: [PATCH wireless-next] wifi: brcmfmac: support CYW54591 PCIE device
Date: Tue, 24 Jun 2025 04:34:53 -0500
Message-ID: <20250624093453.7264-1-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE821.infineon.com (172.23.29.47) To
 MUCSE835.infineon.com (172.23.7.107)

From: Double Lo <double.lo@cypress.com>

CYW54591 is a variant of BCM4355 silicon with the same chipid. In the
chipid-fwname mapping table, apply chiprev 13 to identify CYW54591.
Skip reading OTP process for CYW chip since it contains vendor specific
information which is not common for cypress.

Signed-off-by: Double Lo <double.lo@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 21 ++++++++++++++-----
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 9747928a3650..6327f4eca500 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -71,6 +71,7 @@ BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
 BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
 BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
 BRCMF_FW_CLM_DEF(4387C2, "brcmfmac4387c2-pcie");
+BRCMF_FW_CLM_DEF(54591, "brcmfmac54591-pcie");
 
 /* firmware config files */
 MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcmfmac*-pcie.txt");
@@ -88,6 +89,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0xFFFFFF00, 4350),
 	BRCMF_FW_ENTRY(BRCM_CC_43525_CHIP_ID, 0xFFFFFFF0, 4365C),
 	BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0x000007FF, 4355),
+	BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0x00002000, 54591),
 	BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0xFFFFF800, 4355C1), /* rev ID 12/C2 seen */
 	BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
 	BRCMF_FW_ENTRY(BRCM_CC_43567_CHIP_ID, 0xFFFFFFFF, 43570),
@@ -2522,10 +2524,19 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto fail_bus;
 
-	ret = brcmf_pcie_read_otp(devinfo);
-	if (ret) {
-		brcmf_err(bus, "failed to parse OTP\n");
-		goto fail_brcmf;
+	/* otp read operation */
+	switch (bus->fwvid) {
+	case BRCMF_FWVENDOR_WCC:
+	case BRCMF_FWVENDOR_BCA:
+		ret = brcmf_pcie_read_otp(devinfo);
+		if (ret) {
+			brcmf_err(bus, "failed to parse OTP\n");
+			goto fail_brcmf;
+		}
+		break;
+	case BRCMF_FWVENDOR_CYW:
+	default:
+		break;
 	}
 
 #ifdef DEBUG
@@ -2740,7 +2751,7 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC_SEED),
-
+	BRCMF_PCIE_DEVICE(CY_PCIE_54591_DEVICE_ID, CYW),
 	{ /* end: all zeroes */ }
 };
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index c1e22c589d85..5195c6c1a5b5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -99,6 +99,7 @@
 #define BRCM_PCIE_4377_DEVICE_ID	0x4488
 #define BRCM_PCIE_4378_DEVICE_ID	0x4425
 #define BRCM_PCIE_4387_DEVICE_ID	0x4433
+#define CY_PCIE_54591_DEVICE_ID		0x4417
 
 /* brcmsmac IDs */
 #define BCM4313_D11N2G_ID	0x4727	/* 4313 802.11n 2.4G device */
-- 
2.25.0


