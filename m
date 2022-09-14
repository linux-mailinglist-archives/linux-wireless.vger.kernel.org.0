Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6B5B7F85
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 05:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiINDgo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 23:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiINDgk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 23:36:40 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2FB5FAFC
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 20:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663126599; x=1694662599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q8HJVLuJHxyX4P2FmYokWLh/0ca7blTABDVf3kWFK/I=;
  b=Qa7oA5yZ43RMO4YF599LgCRnGvKtCUePKKW7CNaBILhp6kDvvA7Bot+R
   m0SxA8w/clRXhklas14pAItm/BJbyBBqEodkGlUw262VtVcfmXcln14vW
   n1gBhTxZQVrudtLPk9uoAI7gvzOnGdCEDwlH+bXfX1QWW/HgzfrPL5aM/
   8=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="170974"
X-IronPort-AV: E=Sophos;i="5.93,313,1654552800"; 
   d="scan'208";a="170974"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 05:36:37 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 05:36:37 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 05:36:37 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Wed, 14 Sep 2022 05:36:37 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="258424460"
X-IronPort-AV: E=Sophos;i="5.93,313,1654552800"; 
   d="scan'208";a="258424460"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 14 Sep 2022 05:36:36 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 13 Sep 2022
 22:36:35 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 00B5D10033A;
        Tue, 13 Sep 2022 22:36:35 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 F275A980794; Tue, 13 Sep 2022 22:36:34 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 2/5] brcmfmac: Fix for when connect request is not success
Date:   Tue, 13 Sep 2022 22:36:17 -0500
Message-ID: <20220914033620.12742-3-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220914033620.12742-1-ian.lin@infineon.com>
References: <20220914033620.12742-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 7c72ea26a7d7..7e9354768cfe 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1417,6 +1417,8 @@ static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason,
 					      locally_generated, GFP_KERNEL);
 	}
 	clear_bit(BRCMF_VIF_STATUS_CONNECTING, &vif->sme_state);
+	clear_bit(BRCMF_VIF_STATUS_EAP_SUCCESS, &vif->sme_state);
+	clear_bit(BRCMF_VIF_STATUS_ASSOC_SUCCESS, &vif->sme_state);
 	clear_bit(BRCMF_SCAN_STATUS_SUPPRESS, &cfg->scan_status);
 	brcmf_btcoex_set_mode(vif, BRCMF_BTCOEX_ENABLED, 0);
 	if (vif->profile.use_fwsup != BRCMF_PROFILE_FWSUP_NONE) {
@@ -2269,6 +2271,8 @@ brcmf_cfg80211_disconnect(struct wiphy *wiphy, struct net_device *ndev,
 
 	clear_bit(BRCMF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state);
 	clear_bit(BRCMF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state);
+	clear_bit(BRCMF_VIF_STATUS_EAP_SUCCESS, &ifp->vif->sme_state);
+	clear_bit(BRCMF_VIF_STATUS_ASSOC_SUCCESS, &ifp->vif->sme_state);
 	cfg80211_disconnected(ndev, reason_code, NULL, 0, true, GFP_KERNEL);
 
 	memcpy(&scbval.ea, &profile->bssid, ETH_ALEN);
@@ -6063,6 +6067,10 @@ brcmf_bss_connect_done(struct brcmf_cfg80211_info *cfg,
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
@@ -6160,9 +6168,13 @@ brcmf_notify_connect_status(struct brcmf_if *ifp,
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

