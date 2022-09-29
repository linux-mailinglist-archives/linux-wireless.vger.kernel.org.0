Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35B25EEAE1
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 03:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiI2BZm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 21:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiI2BZk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 21:25:40 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B429B275FE
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 18:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664414739; x=1695950739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oANtvaftTrX4xvdJgHQSRH0fphstPM3K6XlPQwam5JM=;
  b=qNJ9G8+rzGpGkjqYmt+Z3C0tTXn/6LroFmYbaSKTiXm4DLllQBsQ06RW
   jrwUwe6rWRNFCSaTE0yuZ64XYVtiAmT6Cf7Y8BSWPtxtNYYg7glirF6rR
   uqGjwctD55Xiv4luPPhTUiO2qJej0jWxzjMGJ1FFmTAMdBMoGMjkniGHZ
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="2355178"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="2355178"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 03:25:38 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 03:25:37 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 03:25:37 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 03:25:37 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="264114145"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="264114145"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 29 Sep 2022 03:25:37 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Wed, 28 Sep 2022
 20:25:35 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id D88FA1004E2;
        Wed, 28 Sep 2022 20:25:34 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 D638A980853; Wed, 28 Sep 2022 20:25:34 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v3 4/4] brcmfmac: Fix authentication latency caused by OBSS stats survey
Date:   Wed, 28 Sep 2022 20:25:27 -0500
Message-ID: <20220929012527.4152-5-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220929012527.4152-1-ian.lin@infineon.com>
References: <20220929012527.4152-1-ian.lin@infineon.com>
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

From: Ramesh Rangavittal <ramesh.rangavittal@infineon.com>

Auto Channel Select feature of HostAP uses dump_survey to fetch
OBSS statistics. When the device is in the middle of an authentication
sequence or just at the end of authentication completion, running
dump_survey would trigger a channel change. The channel change in-turn
can cause packet loss, resulting in authentication delay. With this change,
dump_survey won't be run when authentication or association is in progress,
hence resolving the issue.

Signed-off-by: Ramesh Rangavittal <ramesh.rangavittal@infineon.com>
Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index c13c4c559e6e..362d8fd0af4e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7697,6 +7697,12 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 
 	brcmf_dbg(TRACE, "Enter: channel idx=%d\n", idx);
 
+	/* Do not run survey when VIF in CONNECTING / CONNECTED states */
+	if ((test_bit(BRCMF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state)) ||
+	    (test_bit(BRCMF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state))) {
+		return -EBUSY;
+	}
+
 	band = wiphy->bands[NL80211_BAND_2GHZ];
 	if (band && idx >= band->n_channels) {
 		idx -= band->n_channels;
-- 
2.25.0

