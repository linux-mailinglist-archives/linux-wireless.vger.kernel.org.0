Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6102A5EEC57
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 05:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiI2DKX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 23:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiI2DKV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 23:10:21 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2DB58DF6
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 20:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664421020; x=1695957020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TJDOK4vXU+M/f0J/3WYbdeBU4QkEsiXXJ2ErwyijpPk=;
  b=Wn4CF/pEMDiIWn3dzTUEr66XNfupDYXT2dVB1rgKNOLWVgZGYoPgDsWt
   MQl7cDH/1u53oZ7dhlhVpF/vQrzWyItKARnewoaz4boesMWWw8ftiuP6N
   dCrmrUTdctyBXzJ+j8MK4z9Br88GoCRse7g+9fr3vOqPVYr7Pwu/JhVy2
   0=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="2365519"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="2365519"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 05:10:17 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 05:10:16 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 05:10:16 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 05:10:16 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="264141879"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="264141879"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 29 Sep 2022 05:10:15 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Wed, 28 Sep 2022
 22:10:14 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 6BB8F1004ED;
        Wed, 28 Sep 2022 22:10:10 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 67183980481; Wed, 28 Sep 2022 22:10:10 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 3/3] brcmfmac: dump dongle memory when attaching failed
Date:   Wed, 28 Sep 2022 22:10:01 -0500
Message-ID: <20220929031001.9962-4-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220929031001.9962-1-ian.lin@infineon.com>
References: <20220929031001.9962-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

To enhance FW debugging, we add dongle memory dump when hitting attaching
failure with PCIE bus. It can help developer to get more information
about dongle trap reason and root cause.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/core.c    |  3 ++-
 .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 10 +++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 595ae3ae561e..d354f79fd0ac 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1399,7 +1399,8 @@ void brcmf_fw_crashed(struct device *dev)
 
 	brcmf_dev_coredump(dev);
 
-	schedule_work(&drvr->bus_reset);
+	if (drvr->bus_reset.func)
+		schedule_work(&drvr->bus_reset);
 }
 
 void brcmf_detach(struct device *dev)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 1becd50038ab..cf564adc612a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2068,13 +2068,14 @@ static void brcmf_pcie_setup(struct device *dev, int ret,
 	struct brcmf_commonring **flowrings;
 	u32 i, nvram_len;
 
+	bus = dev_get_drvdata(dev);
+	pcie_bus_dev = bus->bus_priv.pcie;
+	devinfo = pcie_bus_dev->devinfo;
+
 	/* check firmware loading result */
 	if (ret)
 		goto fail;
 
-	bus = dev_get_drvdata(dev);
-	pcie_bus_dev = bus->bus_priv.pcie;
-	devinfo = pcie_bus_dev->devinfo;
 	brcmf_pcie_attach(devinfo);
 
 	fw = fwreq->items[BRCMF_PCIE_FW_CODE].binary;
@@ -2148,6 +2149,9 @@ static void brcmf_pcie_setup(struct device *dev, int ret,
 	return;
 
 fail:
+	brcmf_err(bus, "Dongle setup failed\n");
+	brcmf_pcie_bus_console_read(devinfo, true);
+	brcmf_fw_crashed(dev);
 	device_release_driver(dev);
 }
 
-- 
2.25.0

