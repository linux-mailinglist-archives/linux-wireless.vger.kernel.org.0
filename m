Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88622573356
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiGMJpz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiGMJpR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068EBFAEB
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Icl1V9WmB8V0WgUfIMD5I9jYYC/WlmNZadhTxeFQXqw=;
        t=1657705517; x=1658915117; b=dTCwgdYwkgV/xEJSbqmMZ2KFYNDoCBr2JlNfLgs9Vpnl9cn
        cErf9LXRHj3nJg+jw1xhx8PrUpJAmU7LQRza5Q6XQwE9NsN0E3MMvQdoMryAVjHcWt5D0gFI6xDol
        r0/PpZoY5RV66G74mvksz+ggLXLxCke4PVpjmGi6Hj/IkYKO/dJUsBU/xrtFAAkr+OrqDmR98QCi3
        4Wd2K9wduHwS3/ppYLVas2c1m/thdLdjHyj34QP9x7hkH8r0nEFla95eUsnKy6ytSd+gmtDyCvBUs
        SNWASn4sbHKLrro1DpQuqBO2/JGVtON8itf/s2Cf4al7WmEAwn/ghhM+1rXDjaTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvj-00EgvB-1V;
        Wed, 13 Jul 2022 11:45:15 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 34/76] wifi: mac80211: split IEEE80211_STA_DISABLE_WMM to link data
Date:   Wed, 13 Jul 2022 11:44:20 +0200
Message-Id: <20220713114425.f083fde05269.I31b8d276b9f1449cf445aed9f85bce80a728a734@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we decide to stop tracking QoS/WMM parameters, then
this should be a per-link decision. Move the flag to
the link instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/mlme.c        | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 20b9979d1506..3e360bcaa03b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -361,7 +361,6 @@ enum ieee80211_sta_flags {
 	IEEE80211_STA_MFP_ENABLED	= BIT(6),
 	IEEE80211_STA_UAPSD_ENABLED	= BIT(7),
 	IEEE80211_STA_NULLFUNC_ACKED	= BIT(8),
-	IEEE80211_STA_DISABLE_WMM	= BIT(14),
 	IEEE80211_STA_ENABLE_RRM	= BIT(15),
 };
 
@@ -883,6 +882,7 @@ struct ieee80211_link_data_managed {
 
 	bool have_beacon;
 	bool tracking_signal_avg;
+	bool disable_wmm_tracking;
 
 	bool csa_waiting_bcn;
 	bool csa_ignored_same_chan;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f3e901793ae1..80a31777922e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2539,6 +2539,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	link->u.mgd.have_beacon = false;
 	link->u.mgd.tracking_signal_avg = false;
+	link->u.mgd.disable_wmm_tracking = false;
 
 	ifmgd->flags = 0;
 	link->u.mgd.conn_flags = 0;
@@ -3794,21 +3795,21 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	link->u.mgd.wmm_last_param_set = -1;
 	link->u.mgd.mu_edca_last_param_set = -1;
 
-	if (ifmgd->flags & IEEE80211_STA_DISABLE_WMM) {
+	if (link->u.mgd.disable_wmm_tracking) {
 		ieee80211_set_wmm_default(link, false, false);
 	} else if (!ieee80211_sta_wmm_params(local, link, elems->wmm_param,
 					     elems->wmm_param_len,
 					     elems->mu_edca_param_set)) {
 		/* still enable QoS since we might have HT/VHT */
 		ieee80211_set_wmm_default(link, false, true);
-		/* set the disable-WMM flag in this case to disable
+		/* disable WMM tracking in this case to disable
 		 * tracking WMM parameter changes in the beacon if
 		 * the parameters weren't actually valid. Doing so
 		 * avoids changing parameters very strangely when
 		 * the AP is going back and forth between valid and
 		 * invalid parameters.
 		 */
-		ifmgd->flags |= IEEE80211_STA_DISABLE_WMM;
+		link->u.mgd.disable_wmm_tracking = true;
 	}
 	changed |= BSS_CHANGED_QOS;
 
@@ -4396,7 +4397,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 					 rx_status->device_timestamp,
 					 elems, true);
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_WMM) &&
+	if (!link->u.mgd.disable_wmm_tracking &&
 	    ieee80211_sta_wmm_params(local, link, elems->wmm_param,
 				     elems->wmm_param_len,
 				     elems->mu_edca_param_set))
-- 
2.36.1

