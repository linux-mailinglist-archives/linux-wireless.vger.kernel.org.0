Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691C0480F76
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Dec 2021 05:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhL2EAu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Dec 2021 23:00:50 -0500
Received: from smtp12.infineon.com ([217.10.52.106]:35702 "EHLO
        smtp12.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhL2EAu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Dec 2021 23:00:50 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Dec 2021 23:00:50 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1640750451; x=1672286451;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jf5dW9y17LfNXimn/oPMDAFuJwoZ0NI6Dg8EDDpDDDo=;
  b=MTRSlt9jniEeFa1vpxG+QOO4UhJys3Lmcb3Pv+sektITaNlcKZasExl6
   nnTA7BFVnH0ZFo/8rkt7BZMX+ni3yJZQfVMmfvhkLKBOjbgWiync0Vgz8
   9UHEYlXDat0qDPPn2NtOrGyJGL/kjvM+Jw4BqNZm2jyz6JKJ2qz5vhG6G
   M=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="275088866"
X-IronPort-AV: E=Sophos;i="5.88,244,1635199200"; 
   d="scan'208";a="275088866"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 29 Dec 2021 04:53:44 +0100
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 28 Dec 2021
 21:53:42 -0600
Received: from iot-wlan-dev-u01.aus.cypress.com (iot-wlan-dev-u01
 [10.248.81.191])       by inf2.aus.cypress.com (Postfix) with ESMTP id 4FA64100243;
        Tue, 28 Dec 2021 21:53:42 -0600 (CST)
Received: by iot-wlan-dev-u01.aus.cypress.com (Postfix, from userid 27991)      id
 42C941AC562; Tue, 28 Dec 2021 21:53:42 -0600 (CST)
From:   Ian Lin <ian.lin-ee@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@codeaurora.org>,
        <Chi-Hsien.Lin@infineon.com>, <Wright.Feng@infineon.com>,
        <Double.Lo@infineon.com>, Ian Lin <ian.lin-ee@infineon.com>
Subject: [PATCH v3] brcmfmac: add CYW43570 PCIE device
Date:   Tue, 28 Dec 2021 21:51:44 -0600
Message-ID: <20211229035144.9205-1-ian.lin-ee@infineon.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Soontak Lee <soontak.lee@cypress.com>

CYW43570 is a 3-antenna, 2x2 MIMO,802.11a/b/g/n/ac, PCIe 3.0 for WLAN.
It is BT/WIFI combo.

Signed-off-by: Soontak Lee <soontak.lee@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Ian Lin <ian.lin-ee@infineon.com>
---
Changes in v3:
  - Fix indentation
Changes in v2:
  - Add missing Signed-off-by in commit message

---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       | 1 +
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 8b149996fc00..ceeb1f10752a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2106,6 +2106,7 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_RAW_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4358_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4359_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_DEVICE_ID),
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 9d81320164ce..3bbe2388ec54 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -71,6 +71,7 @@
 #define BRCM_PCIE_4356_DEVICE_ID	0x43ec
 #define BRCM_PCIE_43567_DEVICE_ID	0x43d3
 #define BRCM_PCIE_43570_DEVICE_ID	0x43d9
+#define BRCM_PCIE_43570_RAW_DEVICE_ID	0xaa31
 #define BRCM_PCIE_4358_DEVICE_ID	0x43e9
 #define BRCM_PCIE_4359_DEVICE_ID	0x43ef
 #define BRCM_PCIE_43602_DEVICE_ID	0x43ba
-- 
2.25.0

