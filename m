Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631705EEC56
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 05:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiI2DKT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 23:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiI2DKS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 23:10:18 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8D848EBC
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 20:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664421017; x=1695957017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FgEb8itMMcv5RMX1o1c8HvKc7vPPRr1C9imbwlXyLTE=;
  b=nRKLHvF3JtVVd94K6tlgPvSpvfVn/LU6VhkGFDKjyPL6x84BcoAZElix
   JpY/MzWrWUxAW0FssHTytUN3BlAENRIeNVvYH9qbv15nJIpIiFdDi0NJU
   bFzFznvHO3XZfLSViEkw6sX1Dmvp8aLPp/w4XjFTAGqcsLbugY/6cNdFJ
   0=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="319464508"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="319464508"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 05:10:15 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 05:10:14 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 05:10:14 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 05:10:13 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="261294161"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="261294161"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 29 Sep 2022 05:10:12 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Wed, 28 Sep 2022
 22:10:12 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 4A83C1004E6;
        Wed, 28 Sep 2022 22:10:09 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 47C82980481; Wed, 28 Sep 2022 22:10:09 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 2/3] brcmfmac: return error when getting invalid max_flowrings from dongle
Date:   Wed, 28 Sep 2022 22:10:00 -0500
Message-ID: <20220929031001.9962-3-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220929031001.9962-1-ian.lin@infineon.com>
References: <20220929031001.9962-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

When firmware hit trap at initialization, host will read abnormal
max_flowrings number from dongle, and it will cause kernel panic when
doing iowrite to initialize dongle ring.
To detect this error at early stage, we directly return error when getting
invalid max_flowrings(>256).

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 2b7ebbd7b5b4..1becd50038ab 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1228,6 +1228,10 @@ static int brcmf_pcie_init_ringbuffers(struct brcmf_pciedev_info *devinfo)
 				BRCMF_NROF_H2D_COMMON_MSGRINGS;
 		max_completionrings = BRCMF_NROF_D2H_COMMON_MSGRINGS;
 	}
+	if (max_flowrings > 256) {
+		brcmf_err(bus, "invalid max_flowrings(%d)\n", max_flowrings);
+		return -EIO;
+	}
 
 	if (devinfo->dma_idx_sz != 0) {
 		bufsz = (max_submissionrings + max_completionrings) *
-- 
2.25.0

