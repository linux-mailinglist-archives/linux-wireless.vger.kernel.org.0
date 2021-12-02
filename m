Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D0D465EA3
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 08:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345415AbhLBHZd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 02:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbhLBHZc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 02:25:32 -0500
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA87C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 23:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1638429730; x=1669965730;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=CD8mx2yw+Ap1g1e27G2xHyry/tg0eea/jR6vUn7s9CE=;
  b=pYs0WKhvEpBX2VyrefKmjjU8OlErm3pxwbpjW6Zpd8j0MmkMbe9KWxfa
   q+Y/FIYmwZQn3kN9yfJ1kSR0yQIPegdlab55eV7d8zF9Wos/mgLpJXUSA
   ZotuFFnCEgJMPGcPqHPK77F38vTjNClP5keIsqqLRfynrgZUUICMvjiJR
   Q=;
IronPort-SDR: mU4xdrIzlMeAwlZIX0Oudi9YHFzz7cicTC9gMpyEHKX1gvo1EAR3qvYXKw2eCbsvyD/c439bUF
 /QAR1ut4muuA==
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="154415399"
X-IronPort-AV: E=Sophos;i="5.87,281,1631570400"; 
   d="scan'208";a="154415399"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 08:22:08 +0100
Received: from MUCSE822.infineon.com (MUCSE822.infineon.com [172.23.29.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Thu,  2 Dec 2021 08:22:08 +0100 (CET)
Received: from MUCSE704.infineon.com (172.23.7.78) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.15; Thu, 2 Dec 2021
 08:22:07 +0100
Received: from [10.234.36.221] (10.234.36.221) by MUCSE704.infineon.com
 (172.23.7.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2176.14; Thu, 2
 Dec 2021 08:22:05 +0100
Message-ID: <bbd6262b-8055-9a2f-55c5-81d6527014cb@infineon.com>
Date:   Thu, 2 Dec 2021 15:22:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        <Chi-Hsien.Lin@infineon.com>, <Wright.Feng@infineon.com>,
        <Double.Lo@infineon.com>
From:   "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin-ee@infineon.com>
Subject: [PATCH v2] brcmfmac: add CYW43570 PCIE device
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.234.36.221]
X-ClientProxiedBy: MUCSE717.infineon.com (172.23.7.74) To
 MUCSE704.infineon.com (172.23.7.78)
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
Changes in v2:
   - Add missing Signed-off-by in commit message

   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       | 1 +
   drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
   2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 8b149996fc00..ceeb1f10752a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2106,6 +2106,7 @@ static const struct pci_device_id 
brcmf_pcie_devid_table[] = {
       BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID),
       BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID),
       BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID),
+    BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_RAW_DEVICE_ID),
       BRCMF_PCIE_DEVICE(BRCM_PCIE_4358_DEVICE_ID),
       BRCMF_PCIE_DEVICE(BRCM_PCIE_4359_DEVICE_ID),
       BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_DEVICE_ID),
diff --git
a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 9d81320164ce..3bbe2388ec54 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -71,6 +71,7 @@
   #define BRCM_PCIE_4356_DEVICE_ID    0x43ec
   #define BRCM_PCIE_43567_DEVICE_ID    0x43d3
   #define BRCM_PCIE_43570_DEVICE_ID    0x43d9
+#define BRCM_PCIE_43570_RAW_DEVICE_ID    0xaa31
   #define BRCM_PCIE_4358_DEVICE_ID    0x43e9
   #define BRCM_PCIE_4359_DEVICE_ID    0x43ef
   #define BRCM_PCIE_43602_DEVICE_ID    0x43ba
--
2.25.0
