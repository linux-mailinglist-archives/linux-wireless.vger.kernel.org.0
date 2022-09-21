Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D275BF347
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 04:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiIUCFP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 22:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiIUCFM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 22:05:12 -0400
Received: from smtp15.infineon.com (smtp15.infineon.com [217.10.52.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720F440E0B
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 19:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663725906; x=1695261906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D1ripKl0lh1u56UxtHG6iaRULEy8zoBCB8mDlvMr+A0=;
  b=DNvLl9SZd7YG50noSye3tq6lSL+gh1XiF3KnD/FKImYRVAtksnFMpqmb
   HQdtM92fhXYDE1QkM0KM1G26e/qf+u8VZfKl8Yebo3+IliFnUqeFwD64q
   HjHgKGzSBikNIdZcKZLGU6wZjiiG+uKiE2Ct9NJCgJYc7r2irZphSvcVO
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="142118293"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="142118293"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 04:05:05 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 04:05:04 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 04:05:04 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Wed, 21 Sep 2022 04:05:04 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="261808029"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="261808029"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 21 Sep 2022 04:05:03 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 20 Sep 2022
 21:05:02 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 7FD5310055D;
        Tue, 20 Sep 2022 21:02:20 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 7B9269806AB; Tue, 20 Sep 2022 21:02:20 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 4/4] brcmfmac: Fix authentication latency caused by OBSS stats survey
Date:   Tue, 20 Sep 2022 21:01:00 -0500
Message-ID: <20220921020100.16752-5-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220921020100.16752-1-ian.lin@infineon.com>
References: <20220921020100.16752-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index c909284e126e..98f0319686e6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7715,6 +7715,12 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 
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

