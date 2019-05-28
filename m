Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFB02C5B6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 13:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfE1LuH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 07:50:07 -0400
Received: from nbd.name ([46.4.11.11]:55656 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfE1LuH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 07:50:07 -0400
Received: from p5dcfb1b7.dip0.t-ipconnect.de ([93.207.177.183] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hVacG-0005pk-RF; Tue, 28 May 2019 13:50:04 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH V2 2/6] mac80211: allow turning TWT responder support on and off via netlink
Date:   Tue, 28 May 2019 13:49:48 +0200
Message-Id: <20190528114952.838-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528114952.838-1-john@phrozen.org>
References: <20190528114952.838-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow the userland daemon to en/disable TWT support for an AP.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h       | 2 ++
 include/net/mac80211.h       | 3 +++
 include/uapi/linux/nl80211.h | 4 ++++
 net/mac80211/cfg.c           | 4 +++-
 net/wireless/nl80211.c       | 5 +++++
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 13bfeb712d36..044c519a008f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -876,6 +876,7 @@ enum cfg80211_ap_settings_flags {
  * @he_cap: HE capabilities (or %NULL if HE isn't enabled)
  * @ht_required: stations must support HT
  * @vht_required: stations must support VHT
+ * @twt_responder: Enable Target Wait Time
  * @flags: flags, as defined in enum cfg80211_ap_settings_flags
  */
 struct cfg80211_ap_settings {
@@ -902,6 +903,7 @@ struct cfg80211_ap_settings {
 	const struct ieee80211_vht_cap *vht_cap;
 	const struct ieee80211_he_cap_elem *he_cap;
 	bool ht_required, vht_required;
+	bool twt_responder;
 	u32 flags;
 };
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b41a9351434f..96359fd3d026 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -506,6 +506,8 @@ struct ieee80211_ftm_responder_params {
  * @he_support: does this BSS support HE
  * @twt_requester: does this BSS support TWT requester (relevant for managed
  *	mode only, set if the AP advertises TWT responder role)
+ * @twt_responder: does this BSS support TWT requester (relevant for managed
+ *	mode only, set if the AP advertises TWT responder role)
  * @assoc: association status
  * @ibss_joined: indicates whether this station is part of an IBSS
  *	or not
@@ -614,6 +616,7 @@ struct ieee80211_bss_conf {
 	u16 frame_time_rts_th;
 	bool he_support;
 	bool twt_requester;
+	bool twt_responder;
 	/* association related data */
 	bool assoc, ibss_joined;
 	bool ibss_creator;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b6e29161ec8b..07d3f1949f96 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2308,6 +2308,8 @@ enum nl80211_commands {
  * @NL80211_ATTR_AIRTIME_WEIGHT: Station's weight when scheduled by the airtime
  *	scheduler.
  *
+ * @NL80211_ATTR_TWT_RESPONDER: Enable target wait time responder support.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2759,6 +2761,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_AIRTIME_WEIGHT,
 
+	NL80211_ATTR_TWT_RESPONDER,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 09dd1c2860fc..8be2f32fedfc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -939,7 +939,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		      BSS_CHANGED_BEACON |
 		      BSS_CHANGED_SSID |
 		      BSS_CHANGED_P2P_PS |
-		      BSS_CHANGED_TXPOWER;
+		      BSS_CHANGED_TXPOWER |
+		      BSS_CHANGED_TWT;
 	int err;
 	int prev_beacon_int;
 
@@ -1009,6 +1010,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.dtim_period = params->dtim_period;
 	sdata->vif.bss_conf.enable_beacon = true;
 	sdata->vif.bss_conf.allow_p2p_go_ps = sdata->vif.p2p;
+	sdata->vif.bss_conf.twt_responder = params->twt_responder;
 
 	sdata->vif.bss_conf.ssid_len = params->ssid_len;
 	if (params->ssid_len)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 47e30a58566c..b4dbb6b56853 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -541,6 +541,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_PEER_MEASUREMENTS] =
 		NLA_POLICY_NESTED(nl80211_pmsr_attr_policy),
 	[NL80211_ATTR_AIRTIME_WEIGHT] = NLA_POLICY_MIN(NLA_U16, 1),
+	[NL80211_ATTR_TWT_RESPONDER] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -4531,6 +4532,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			return PTR_ERR(params.acl);
 	}
 
+	if (info->attrs[NL80211_ATTR_TWT_RESPONDER])
+		params.twt_responder =
+		    nla_get_flag(info->attrs[NL80211_ATTR_TWT_RESPONDER]);
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-- 
2.20.1

