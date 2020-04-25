Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A991B8795
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 17:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgDYP6y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 11:58:54 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52231 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgDYP6y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 11:58:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587830333; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=x66QQIXMdW38dfssKSBtbBd+8d8TlSEkHIIN0zkMnl4=; b=GkSOmXEkImU+Ogdbnq4ZpX7+UiEUGC8/ZuYQRWpI0Gl3CMEb+52UnOYGIf9Jy4ZcBVBq1MBY
 lcICIZblw1SXwc8VQKyURsEU2PKIYzNlXMDhS8doBSrGJvIFvPqW7iD8N3gy0Xrre9R37DT3
 Tx7r3zM8dRwO1nkNvLDL1c2mCKA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea45e3d.7f3118bb37a0-smtp-out-n01;
 Sat, 25 Apr 2020 15:58:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1F81C43636; Sat, 25 Apr 2020 15:58:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (37-130-184-238.bb.dnainternet.fi [37.130.184.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 447B5C433CB;
        Sat, 25 Apr 2020 15:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 447B5C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 4/5] mac80211: TX legacy rate control for Beacon frames
Date:   Sat, 25 Apr 2020 18:57:12 +0300
Message-Id: <20200425155713.25687-4-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200425155713.25687-1-jouni@codeaurora.org>
References: <20200425155713.25687-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use the Beacon frame specific legacy rate configuration, if specified
for AP or mesh, instead of the generic rate mask when selecting the TX
rate for Beacon frames.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 net/mac80211/cfg.c         | 26 +++++++++++++++++++++++++-
 net/mac80211/ieee80211_i.h |  4 ++++
 net/mac80211/mesh.c        |  1 +
 net/mac80211/tx.c          |  5 ++++-
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ae3e06375a28..548a384b0509 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -994,7 +994,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		      BSS_CHANGED_TWT |
 		      BSS_CHANGED_HE_OBSS_PD |
 		      BSS_CHANGED_HE_BSS_COLOR;
-	int err;
+	int i, err;
 	int prev_beacon_int;
 
 	old = sdata_dereference(sdata->u.ap.beacon, sdata);
@@ -1085,6 +1085,17 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		sdata->vif.bss_conf.p2p_noa_attr.oppps_ctwindow |=
 					IEEE80211_P2P_OPPPS_ENABLE_BIT;
 
+	sdata->beacon_rate_set = false;
+	if (wiphy_ext_feature_isset(local->hw.wiphy,
+				    NL80211_EXT_FEATURE_BEACON_RATE_LEGACY)) {
+		for (i = 0; i < NUM_NL80211_BANDS; i++) {
+			sdata->beacon_rateidx_mask[i] =
+				params->beacon_rate.control[i].legacy;
+			if (sdata->beacon_rateidx_mask[i])
+				sdata->beacon_rate_set = true;
+		}
+	}
+
 	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL);
 	if (err < 0) {
 		ieee80211_vif_release_channel(sdata);
@@ -1189,6 +1200,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	ieee80211_free_keys(sdata, true);
 
 	sdata->vif.bss_conf.enable_beacon = false;
+	sdata->beacon_rate_set = false;
 	sdata->vif.bss_conf.ssid_len = 0;
 	clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED, &sdata->state);
 	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BEACON_ENABLED);
@@ -1949,6 +1961,7 @@ static int copy_mesh_setup(struct ieee80211_if_mesh *ifmsh,
 	const u8 *old_ie;
 	struct ieee80211_sub_if_data *sdata = container_of(ifmsh,
 					struct ieee80211_sub_if_data, u.mesh);
+	int i;
 
 	/* allocate information elements */
 	new_ie = NULL;
@@ -1987,6 +2000,17 @@ static int copy_mesh_setup(struct ieee80211_if_mesh *ifmsh,
 	sdata->vif.bss_conf.beacon_int = setup->beacon_interval;
 	sdata->vif.bss_conf.dtim_period = setup->dtim_period;
 
+	sdata->beacon_rate_set = false;
+	if (wiphy_ext_feature_isset(sdata->local->hw.wiphy,
+				    NL80211_EXT_FEATURE_BEACON_RATE_LEGACY)) {
+		for (i = 0; i < NUM_NL80211_BANDS; i++) {
+			sdata->beacon_rateidx_mask[i] =
+				setup->beacon_rate.control[i].legacy;
+			if (sdata->beacon_rateidx_mask[i])
+				sdata->beacon_rate_set = true;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d58f9acc90a3..fc3278b74977 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -962,6 +962,10 @@ struct ieee80211_sub_if_data {
 	bool rc_has_vht_mcs_mask[NUM_NL80211_BANDS];
 	u16 rc_rateidx_vht_mcs_mask[NUM_NL80211_BANDS][NL80211_VHT_NSS_MAX];
 
+	/* Beacon frame (non-MCS) rate (as a bitmap) */
+	u32 beacon_rateidx_mask[NUM_NL80211_BANDS];
+	bool beacon_rate_set;
+
 	union {
 		struct ieee80211_if_ap ap;
 		struct ieee80211_if_wds wds;
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 36978a0e5000..5930d07b1e43 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -994,6 +994,7 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 	/* stop the beacon */
 	ifmsh->mesh_id_len = 0;
 	sdata->vif.bss_conf.enable_beacon = false;
+	sdata->beacon_rate_set = false;
 	clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED, &sdata->state);
 	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BEACON_ENABLED);
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3dc1990e15c5..6dad67eb60b2 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4883,7 +4883,10 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 	txrc.bss_conf = &sdata->vif.bss_conf;
 	txrc.skb = skb;
 	txrc.reported_rate.idx = -1;
-	txrc.rate_idx_mask = sdata->rc_rateidx_mask[band];
+	if (sdata->beacon_rate_set && sdata->beacon_rateidx_mask[band])
+		txrc.rate_idx_mask = sdata->beacon_rateidx_mask[band];
+	else
+		txrc.rate_idx_mask = sdata->rc_rateidx_mask[band];
 	txrc.bss = true;
 	rate_control_get_rate(sdata, NULL, &txrc);
 
-- 
2.20.1
