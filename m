Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB2459C57
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 07:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhKWG2p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 01:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhKWG2p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 01:28:45 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Nov 2021 22:25:36 PST
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0E9C061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 22:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1637648737; x=1669184737;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=PcxZE3LiTtZz5qkKgdfO77BoKgaOK12rqAyX9WdT74U=;
  b=AgAgGi5pmV1lB2whCm4EfXG/S/2o6ilDAXHxuw5iRGYP3+l1LTPzUc/y
   TAAcZafvTyn56kyV/Ml+gbjKGrdUDq6mYh6M1NySmZgM2u4tJjV2vLBd/
   CW922rxX2p0b3cBxQdoEP1UwYiWRwnIdHWMzSuGy7OHRHQ4WeI1+xtMnX
   c=;
IronPort-SDR: q7C0GHU5cKGhGs8zS0dijk3dS4rmoFgxZYNJSblsevXdpDGL/+H+XLTDb3Hw3QAvxk8NqdFY6u
 PvPOxOxWh7mDhXySlwROOcS3fhb/09buedhn305Y7Sdxv2sFRc0O/egmM0Z0Kt8cFF11qbdscQ
 /YHJ0f6RgGv1mYB/AS3BPei8MQ1hv2BMhE53VYFTA0WkczBEvaWabJcPQbDCl3BtzzkM8hQfcM
 Hb/RfDuzv4YdL4sBmLu8+awhemnfnYkEslGmKeKTZ+TEZqFkUp3fd/PseB4NXLXVyfAFezN01D
 d7E=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="99674715"
X-IronPort-AV: E=Sophos;i="5.87,257,1631570400"; 
   d="scan'208";a="99674715"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 07:24:31 +0100
Received: from MUCSE814.infineon.com (MUCSE814.infineon.com [172.23.29.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Tue, 23 Nov 2021 07:24:31 +0100 (CET)
Received: from MUCSE704.infineon.com (172.23.7.78) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.15; Tue, 23 Nov
 2021 07:24:31 +0100
Received: from [10.234.36.221] (10.234.36.221) by MUCSE704.infineon.com
 (172.23.7.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2176.14; Tue, 23
 Nov 2021 07:24:29 +0100
Message-ID: <3f57f2b0-82c2-e339-ee6a-1569186143d6@infineon.com>
Date:   Tue, 23 Nov 2021 14:24:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
From:   "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin-ee@infineon.com>
Subject: [PATCH] brcmfmac: add CYW43570 PCIE device
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>,
        "Arend van Spriel" <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, <Chi-Hsien.Lin@infineon.com>
Content-Language: en-US
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
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Jira:SWLINUX-1213
---
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
