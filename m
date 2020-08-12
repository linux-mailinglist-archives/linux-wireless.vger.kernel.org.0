Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6234A2423A7
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 03:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHLBWs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Aug 2020 21:22:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13396 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgHLBWs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Aug 2020 21:22:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597195367; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=J7L+88nTc7qorjVMLxd3AfXEbIgR+jocig+WnzDXj98=; b=aPrFrW+XbxQUtTccHboPAfHXsfAgPbSabPln2mXQDVYlukyX9yAhEwYb/9zCL3mMMRDQqIax
 rTyQfRxFRJS2DbTjytwt71NoNXLteWC7O4eE+SHbKGL6up6KrUluQoYpb+fu+8LrRWRveh+0
 3yIArV5JXLYAUNdp2BzJPxutC8k=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f33445f440a07969a754e0a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 12 Aug 2020 01:22:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A0EBC433CA; Wed, 12 Aug 2020 01:22:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 319DCC433C9;
        Wed, 12 Aug 2020 01:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 319DCC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v4 2/2] mac80211: Unsolicited broadcast probe response support
Date:   Tue, 11 Aug 2020 18:22:26 -0700
Message-Id: <20200812012226.11347-3-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200812012226.11347-1-alokad@codeaurora.org>
References: <20200812012226.11347-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds mac80211 support to configure unsolicited
broadcast probe response transmission for in-band discovery in 6GHz.

Changes include functions to store and retrieve probe response template,
and packet interval (0 - 20 TUs).
Setting interval to 0 disables the unsolicited broadcast probe response
transmission.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v4: Addressed comments

 include/net/mac80211.h     | 24 ++++++++++++++++
 net/mac80211/cfg.c         | 57 ++++++++++++++++++++++++++++++++++----
 net/mac80211/debugfs.c     |  1 +
 net/mac80211/ieee80211_i.h |  7 +++++
 net/mac80211/main.c        |  6 ++++
 net/mac80211/tx.c          | 29 +++++++++++++++++++
 6 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 11d5610d2ad5..f43f23b13ab6 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -317,6 +317,8 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_TWT: TWT status changed
  * @BSS_CHANGED_HE_OBSS_PD: OBSS Packet Detection status changed.
  * @BSS_CHANGED_HE_BSS_COLOR: BSS Color has changed
+ * @BSS_CHANGED_UNSOL_BCAST_PROBE_RESP: Unsolicited broadcast probe response
+ *	status changed.
  *
  */
 enum ieee80211_bss_change {
@@ -350,6 +352,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_TWT			= 1<<27,
 	BSS_CHANGED_HE_OBSS_PD		= 1<<28,
 	BSS_CHANGED_HE_BSS_COLOR	= 1<<29,
+	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<30,
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -607,6 +610,8 @@ struct ieee80211_ftm_responder_params {
  * @he_oper: HE operation information of the AP we are connected to
  * @he_obss_pd: OBSS Packet Detection parameters.
  * @he_bss_color: BSS coloring settings, if BSS supports HE
+ * @unsol_bcast_probe_resp_interval: Unsolicited broadcast probe response
+ *	interval.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -674,6 +679,7 @@ struct ieee80211_bss_conf {
 	} he_oper;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	u32 unsol_bcast_probe_resp_interval;
 };
 
 /**
@@ -2325,6 +2331,9 @@ struct ieee80211_txq {
  *	aggregating MPDUs with the same keyid, allowing mac80211 to keep Tx
  *	A-MPDU sessions active while rekeying with Extended Key ID.
  *
+ * @IEEE80211_HW_SUPPORTS_UNSOL_BCAST_PROBE_RESP: Hardware/driver supports
+ *	unsolicited broadcast probe response transmission
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2377,6 +2386,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_MULTI_BSSID,
 	IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID,
 	IEEE80211_HW_AMPDU_KEYBORDER_SUPPORT,
+	IEEE80211_HW_SUPPORTS_UNSOL_BCAST_PROBE_RESP,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
@@ -6558,4 +6568,18 @@ u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
  */
 bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
 
+/**
+ * ieee80211_get_unsol_bcast_probe_resp_tmpl - Get unsolicited broadcast
+ *     probe response template.
+ * @hw: pointer obtained from ieee80211_alloc_hw().
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ *
+ * The driver is responsible for freeing the returned skb.
+ *
+ * Return: Unsolicited broadcast probe response template. %NULL on error.
+ */
+struct sk_buff *
+ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
+					  struct ieee80211_vif *vif);
+
 #endif /* MAC80211_H */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9b360544ad6f..b4b028599cff 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -837,6 +837,35 @@ static int ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static int
+ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
+				     struct cfg80211_unsol_bcast_probe_resp *params)
+{
+	struct unsol_bcast_probe_resp_data *new, *old = NULL;
+
+	if (!sdata->local->hw.wiphy->support_unsol_bcast_probe_resp)
+		return -EOPNOTSUPP;
+
+	if (!params->tmpl || !params->tmpl_len)
+		return -EINVAL;
+
+	old = sdata_dereference(sdata->u.ap.unsol_bcast_probe_resp, sdata);
+	new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+	new->len = params->tmpl_len;
+	memcpy(new->data, params->tmpl, params->tmpl_len);
+	rcu_assign_pointer(sdata->u.ap.unsol_bcast_probe_resp, new);
+
+	if (old)
+		kfree_rcu(old, rcu_head);
+
+	sdata->vif.bss_conf.unsol_bcast_probe_resp_interval =
+							params->interval;
+
+	return 0;
+}
+
 static int ieee80211_set_ftm_responder_params(
 				struct ieee80211_sub_if_data *sdata,
 				const u8 *lci, size_t lci_len,
@@ -1097,12 +1126,18 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL);
-	if (err < 0) {
-		ieee80211_vif_release_channel(sdata);
-		return err;
-	}
+	if (err < 0)
+		goto error;
 	changed |= err;
 
+	if (params->unsol_bcast_probe_resp.interval) {
+		err = ieee80211_set_unsol_bcast_probe_resp(sdata,
+							   &params->unsol_bcast_probe_resp);
+		if (err < 0)
+			goto error;
+		changed |= BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
+	}
+
 	err = drv_start_ap(sdata->local, sdata);
 	if (err) {
 		old = sdata_dereference(sdata->u.ap.beacon, sdata);
@@ -1110,8 +1145,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		if (old)
 			kfree_rcu(old, rcu_head);
 		RCU_INIT_POINTER(sdata->u.ap.beacon, NULL);
-		ieee80211_vif_release_channel(sdata);
-		return err;
+		goto error;
 	}
 
 	ieee80211_recalc_dtim(local, sdata);
@@ -1122,6 +1156,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		netif_carrier_on(vlan->dev);
 
 	return 0;
+
+error:
+	ieee80211_vif_release_channel(sdata);
+	return err;
 }
 
 static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
@@ -1158,6 +1196,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	struct ieee80211_local *local = sdata->local;
 	struct beacon_data *old_beacon;
 	struct probe_resp *old_probe_resp;
+	struct unsol_bcast_probe_resp_data *old_unsol_bcast_probe_resp;
 	struct cfg80211_chan_def chandef;
 
 	sdata_assert_lock(sdata);
@@ -1166,6 +1205,9 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	if (!old_beacon)
 		return -ENOENT;
 	old_probe_resp = sdata_dereference(sdata->u.ap.probe_resp, sdata);
+	old_unsol_bcast_probe_resp =
+		sdata_dereference(sdata->u.ap.unsol_bcast_probe_resp,
+				  sdata);
 
 	/* abort any running channel switch */
 	mutex_lock(&local->mtx);
@@ -1189,9 +1231,12 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	/* remove beacon and probe response */
 	RCU_INIT_POINTER(sdata->u.ap.beacon, NULL);
 	RCU_INIT_POINTER(sdata->u.ap.probe_resp, NULL);
+	RCU_INIT_POINTER(sdata->u.ap.unsol_bcast_probe_resp, NULL);
 	kfree_rcu(old_beacon, rcu_head);
 	if (old_probe_resp)
 		kfree_rcu(old_probe_resp, rcu_head);
+	if (old_unsol_bcast_probe_resp)
+		kfree_rcu(old_unsol_bcast_probe_resp, rcu_head);
 
 	kfree(sdata->vif.bss_conf.ftmr_params);
 	sdata->vif.bss_conf.ftmr_params = NULL;
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 54080290d6e2..18047db2e56f 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -408,6 +408,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_MULTI_BSSID),
 	FLAG(SUPPORTS_ONLY_HE_MULTI_BSSID),
 	FLAG(AMPDU_KEYBORDER_SUPPORT),
+	FLAG(SUPPORTS_UNSOL_BCAST_PROBE_RESP),
 #undef FLAG
 };
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ec1a71ac65f2..b54108ef3560 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -272,6 +272,12 @@ struct probe_resp {
 	u8 data[];
 };
 
+struct unsol_bcast_probe_resp_data {
+	struct rcu_head rcu_head;
+	int len;
+	u8 data[];
+};
+
 struct ps_data {
 	/* yes, this looks ugly, but guarantees that we can later use
 	 * bitmap_empty :)
@@ -287,6 +293,7 @@ struct ps_data {
 struct ieee80211_if_ap {
 	struct beacon_data __rcu *beacon;
 	struct probe_resp __rcu *probe_resp;
+	struct unsol_bcast_probe_resp_data __rcu *unsol_bcast_probe_resp;
 
 	/* to be used after channel switch. */
 	struct cfg80211_beacon_data *next_beacon;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b4a2efe8e83a..0c326d5616ae 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1168,6 +1168,12 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 				WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
 	}
 
+	/* mac80211 supports unsolicited broadcast probe response
+	 * transmission, if the driver supports it
+	 */
+	if (ieee80211_hw_check(&local->hw, SUPPORTS_UNSOL_BCAST_PROBE_RESP))
+		local->hw.wiphy->support_unsol_bcast_probe_resp = true;
+
 	local->hw.wiphy->max_num_csa_counters = IEEE80211_MAX_CSA_COUNTERS_NUM;
 
 	/*
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e9ce658141f5..49ca7227c9fa 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4998,6 +4998,35 @@ struct sk_buff *ieee80211_proberesp_get(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_proberesp_get);
 
+struct sk_buff *
+ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
+					  struct ieee80211_vif *vif)
+{
+	struct sk_buff *skb = NULL;
+	struct unsol_bcast_probe_resp_data *tmpl = NULL;
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	if (sdata->vif.type != NL80211_IFTYPE_AP)
+		return NULL;
+
+	rcu_read_lock();
+	tmpl = rcu_dereference(sdata->u.ap.unsol_bcast_probe_resp);
+	if (!tmpl) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	skb = dev_alloc_skb(sdata->local->hw.extra_tx_headroom + tmpl->len);
+	if (skb) {
+		skb_reserve(skb, sdata->local->hw.extra_tx_headroom);
+		skb_put_data(skb, tmpl->data, tmpl->len);
+	}
+
+	rcu_read_unlock();
+	return skb;
+}
+EXPORT_SYMBOL(ieee80211_get_unsol_bcast_probe_resp_tmpl);
+
 struct sk_buff *ieee80211_pspoll_get(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif)
 {
-- 
2.25.0

