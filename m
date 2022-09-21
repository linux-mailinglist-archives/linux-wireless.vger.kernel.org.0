Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8818B5BF349
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 04:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiIUCFQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 22:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiIUCFM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 22:05:12 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF9226550
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 19:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663725910; x=1695261910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=84BY+ZexBPTeNL8NzDrt9M1fEgf96zmoLkXHGDfu8Co=;
  b=BTQJnbqngeDBPcx0qqWaEC02dnrfSaJ/xV2f9xrbSb5GH70Ab1N8hxP9
   0zo+tfaoBbX7uGekjiUPoqh/qQNIZEtfqzemiB4Yxwlq0/PHKPHLKSrUG
   kkhmCbKFiKoYEGcgTWM5JiuJncjzF1hPnWN0zrWaghN2ySI7PB6N+a+Rr
   Q=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="318191352"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="318191352"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 04:05:01 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 04:05:01 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 04:05:01 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Wed, 21 Sep 2022 04:05:00 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="258960043"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="258960043"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 21 Sep 2022 04:05:00 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 20 Sep 2022
 21:04:58 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id F40AC1004F7;
        Tue, 20 Sep 2022 21:02:17 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 F08389806AB; Tue, 20 Sep 2022 21:02:17 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 3/4] brcmfmac: fix CERT-P2P:5.1.10 failure
Date:   Tue, 20 Sep 2022 21:00:59 -0500
Message-ID: <20220921020100.16752-4-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220921020100.16752-1-ian.lin@infineon.com>
References: <20220921020100.16752-1-ian.lin@infineon.com>
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

From: Double Lo <double.lo@cypress.com>

This patch fix CERT-P2P:5.1.10 failure at step 18 Group formation failed
due to chip is under dump survey. Decrease the dump survery duration to
pass this certification case.

Signed-off-by: Double Lo <Double.Lo@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index cfe2f0e778f7..c909284e126e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -89,7 +89,7 @@
 #define BRCMF_PS_MAX_TIMEOUT_MS		2000
 
 /* Dump obss definitions */
-#define ACS_MSRMNT_DELAY		100
+#define ACS_MSRMNT_DELAY		80
 #define CHAN_NOISE_DUMMY		(-80)
 #define OBSS_TOKEN_IDX			15
 #define IBSS_TOKEN_IDX			15
@@ -7785,7 +7785,7 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 		SURVEY_INFO_TIME_BUSY | SURVEY_INFO_TIME_RX |
 		SURVEY_INFO_TIME_TX;
 
-	brcmf_dbg(INFO, "OBSS dump: channel %d: survey duraion %d\n",
+	brcmf_dbg(INFO, "OBSS dump: channel %d: survey duration %d\n",
 		  ieee80211_frequency_to_channel(chan->center_freq),
 		  ACS_MSRMNT_DELAY);
 	brcmf_dbg(INFO, "noise(%d) busy(%llu) rx(%llu) tx(%llu)\n",
-- 
2.25.0

