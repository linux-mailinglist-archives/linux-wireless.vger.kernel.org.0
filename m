Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27908609D2E
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Oct 2022 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiJXIwv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJXIwp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 04:52:45 -0400
Received: from smtp15.infineon.com (smtp15.infineon.com [217.10.52.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002994F692
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 01:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1666601563; x=1698137563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yRElEf83Ys9bYymRxAfZCXp1JpRdTZ+uCyPNUFSVHNg=;
  b=qQsaKnzXKmqf60/G/bYXEbGPpEdnL8rj+LurFsLmodyMLUvn7yUHtCcz
   hEOikpLJNfh6gWDbBB74rqL23lshrY1zwuU95xmu2v/vH+bzfV2B2Qf9g
   6VUQkNQ84pn4t9rXoc7QCRg4mMoQH9FV0lgBSisVY7u1qwGnZIixmjYba
   0=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="146689275"
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="146689275"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 10:52:41 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 10:52:41 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.30; Mon, 24 Oct
 2022 10:52:40 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.30; Mon, 24 Oct 2022 10:52:40 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="268146232"
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="268146232"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 24 Oct 2022 10:52:40 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Mon, 24 Oct 2022
 03:52:37 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 69AA31004E0;
        Mon, 24 Oct 2022 03:52:38 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 67C949807CC; Mon, 24 Oct 2022 03:52:38 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v4 2/3] wifi: brcmfmac: Fix for when connect request is not success
Date:   Mon, 24 Oct 2022 03:52:14 -0500
Message-ID: <20221024085215.27616-3-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20221024085215.27616-1-ian.lin@infineon.com>
References: <20221024085215.27616-1-ian.lin@infineon.com>
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

From: Wataru Gohda <wataru.gohda@cypress.com>

Currently brcmfmac is expecting to be set for both
BRCMF_VIF_STATUS_EAP_SUCCESS and BRCMF_VIF_STATUS_EAP status bit based
on dongle event and those bits are cleared to complete connect request
successfully.

But when connect request is finished unsuccessfully, either
BRCMF_VIF_STATUS_EAP_SUCCESS / BRCMF_VIF_STATUS_EAP bits are not
cleared depending on how the connect fail event happens. These status
bits are carried over to following new connect request and this will lead
to generate below kernel warning for some case. Worst case status
mismatch happens between dongle and wpa_supplicant.

WARNING: ../net/wireless/sme.c:756 __cfg80211_connect_result+0x42c/0x4a0 [cfg80211]

The fix is to clear the BRCMF_VIF_STATUS_EAP_SUCCESS /
BRCMF_VIF_STATUS_EAP bits during the link down process and add to call
link down process when link down event received during
BRCMF_VIF_STATUS_CONNECTING as well as BRCMF_VIF_STATUS_CONNECTED
state.

Signed-off-by: Wataru Gohda <wataru.gohda@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c     | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 3f2336062217..14cbc30a3229 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1683,6 +1683,8 @@ static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason,
 					      locally_generated, GFP_KERNEL);
 	}
 	clear_bit(BRCMF_VIF_STATUS_CONNECTING, &vif->sme_state);
+	clear_bit(BRCMF_VIF_STATUS_EAP_SUCCESS, &vif->sme_state);
+	clear_bit(BRCMF_VIF_STATUS_ASSOC_SUCCESS, &vif->sme_state);
 	clear_bit(BRCMF_SCAN_STATUS_SUPPRESS, &cfg->scan_status);
 	brcmf_btcoex_set_mode(vif, BRCMF_BTCOEX_ENABLED, 0);
 	if (vif->profile.use_fwsup != BRCMF_PROFILE_FWSUP_NONE) {
@@ -2535,6 +2537,8 @@ brcmf_cfg80211_disconnect(struct wiphy *wiphy, struct net_device *ndev,
 
 	clear_bit(BRCMF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state);
 	clear_bit(BRCMF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state);
+	clear_bit(BRCMF_VIF_STATUS_EAP_SUCCESS, &ifp->vif->sme_state);
+	clear_bit(BRCMF_VIF_STATUS_ASSOC_SUCCESS, &ifp->vif->sme_state);
 	cfg80211_disconnected(ndev, reason_code, NULL, 0, true, GFP_KERNEL);
 
 	memcpy(&scbval.ea, &profile->bssid, ETH_ALEN);
@@ -6299,6 +6303,10 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
 				&ifp->vif->sme_state);
 			conn_params.status = WLAN_STATUS_SUCCESS;
 		} else {
+			clear_bit(BRCMF_VIF_STATUS_EAP_SUCCESS,
+				  &ifp->vif->sme_state);
+			clear_bit(BRCMF_VIF_STATUS_ASSOC_SUCCESS,
+				  &ifp->vif->sme_state);
 			conn_params.status = WLAN_STATUS_AUTH_TIMEOUT;
 		}
 		conn_params.links[0].bssid = profile->bssid;
@@ -6396,9 +6404,13 @@ brcmf_notify_connect_status(struct brcmf_if *ifp,
 	} else if (brcmf_is_linkdown(ifp->vif, e)) {
 		brcmf_dbg(CONN, "Linkdown\n");
 		if (!brcmf_is_ibssmode(ifp->vif) &&
-		    test_bit(BRCMF_VIF_STATUS_CONNECTED,
-			     &ifp->vif->sme_state)) {
-			if (memcmp(profile->bssid, e->addr, ETH_ALEN))
+		    (test_bit(BRCMF_VIF_STATUS_CONNECTED,
+			      &ifp->vif->sme_state) ||
+		     test_bit(BRCMF_VIF_STATUS_CONNECTING,
+			      &ifp->vif->sme_state))) {
+			if (test_bit(BRCMF_VIF_STATUS_CONNECTED,
+				     &ifp->vif->sme_state) &&
+			    memcmp(profile->bssid, e->addr, ETH_ALEN))
 				return err;
 
 			brcmf_bss_connect_done(cfg, ndev, e, false);
-- 
2.25.0

