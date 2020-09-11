Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61C52655F0
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 02:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725300AbgIKAFl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 20:05:41 -0400
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:48450
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgIKAFc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 20:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599782731;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=ziNFmY9ZV1mVAtJ5BeqVgTIyRD7+Ekg2USmzOfSQfgo=;
        b=DEnBcGJ+7PACMYbAAbv8tzMFra2HGVIid77ZW5+3XOZQHvImHvJir5LXIfm0+c9+
        RIBC6PR7UDNoUNWahX5FTvXv9FZvYgVlha0badYqLCUpMsc8ViRE1PEmIOaXEUJhSqj
        nXhwfnlV3MiiU+c/pjydDXdIKJ4AIn9hj8ohwSJk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599782731;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=ziNFmY9ZV1mVAtJ5BeqVgTIyRD7+Ekg2USmzOfSQfgo=;
        b=L0gz4EyQoOmgs4WanfBaRvpf5tSwTnUFOJWxzk3rgMUbQkY+bdNdzyYZVCw1AeSy
        Pa9rBqMGCy+bVVY6CZEdJvwWk0uMqpEOlq4ms9hAM2s1KwFYrY0Jq68yNXj4uRKD3tt
        TybHpQs6PtHOYyooRz1fYj2Azx9y745BfRx6g2kE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D6B9C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Aloka Dixit <alokad@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v6 2/2] mac80211: Add FILS discovery support
Date:   Fri, 11 Sep 2020 00:05:31 +0000
Message-ID: <010101747a7b3cbb-6edaa89c-436d-4391-8765-61456d7f5f4e-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200911000514.24242-1-alokad@codeaurora.org>
References: <20200911000514.24242-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.09.11-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds mac80211 support to configure FILS discovery
transmission.
Changes include functions to store and retrieve FILS discovery
template, minimum and maximum packet intervals.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
Link:
https://lore.kernel.org/r/20200805011838.28166-3-alokad@codeaurora.org
[remove SUPPORTS_FILS_DISCOVERY, driver can just set wiphy info]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     | 27 +++++++++++++++++++
 net/mac80211/cfg.c         | 54 +++++++++++++++++++++++++++++++++-----
 net/mac80211/ieee80211_i.h |  7 +++++
 net/mac80211/tx.c          | 28 ++++++++++++++++++++
 4 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ec148b3e9c41..a8defc2954e2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -317,6 +317,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_TWT: TWT status changed
  * @BSS_CHANGED_HE_OBSS_PD: OBSS Packet Detection status changed.
  * @BSS_CHANGED_HE_BSS_COLOR: BSS Color has changed
+ * @BSS_CHANGED_FILS_DISCOVERY: FILS discovery status changed.
  *
  */
 enum ieee80211_bss_change {
@@ -350,6 +351,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_TWT			= 1<<27,
 	BSS_CHANGED_HE_OBSS_PD		= 1<<28,
 	BSS_CHANGED_HE_BSS_COLOR	= 1<<29,
+	BSS_CHANGED_FILS_DISCOVERY      = 1<<30,
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -490,6 +492,18 @@ struct ieee80211_ftm_responder_params {
 	size_t civicloc_len;
 };
 
+/**
+ * struct ieee80211_fils_discovery - FILS discovery parameters from
+ * IEEE Std 802.11ai-2016, Annex C.3 MIB detail.
+ *
+ * @min_interval: Minimum packet interval in TUs (0 - 10000)
+ * @max_interval: Maximum packet interval in TUs (0 - 10000)
+ */
+struct ieee80211_fils_discovery {
+	u32 min_interval;
+	u32 max_interval;
+};
+
 /**
  * struct ieee80211_bss_conf - holds the BSS's changing parameters
  *
@@ -607,6 +621,7 @@ struct ieee80211_ftm_responder_params {
  * @he_oper: HE operation information of the AP we are connected to
  * @he_obss_pd: OBSS Packet Detection parameters.
  * @he_bss_color: BSS coloring settings, if BSS supports HE
+ * @fils_discovery: FILS discovery configuration
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -674,6 +689,7 @@ struct ieee80211_bss_conf {
 	} he_oper;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	struct ieee80211_fils_discovery fils_discovery;
 };
 
 /**
@@ -6593,4 +6609,15 @@ u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
  */
 bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
 
+/**
+ * ieee80211_get_fils_discovery_tmpl - Get FILS discovery template.
+ * @hw: pointer obtained from ieee80211_alloc_hw().
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ *
+ * The driver is responsible for freeing the returned skb.
+ *
+ * Return: FILS discovery template. %NULL on error.
+ */
+struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
+						  struct ieee80211_vif *vif);
 #endif /* MAC80211_H */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b4e39e31a985..5bcaf6b01e7e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -837,6 +837,33 @@ static int ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
+					struct cfg80211_fils_discovery *params)
+{
+	struct fils_discovery_data *new, *old = NULL;
+	struct ieee80211_fils_discovery *fd;
+
+	if (!params->tmpl || !params->tmpl_len)
+		return -EINVAL;
+
+	fd = &sdata->vif.bss_conf.fils_discovery;
+	fd->min_interval = params->min_interval;
+	fd->max_interval = params->max_interval;
+
+	old = sdata_dereference(sdata->u.ap.fils_discovery, sdata);
+	new = kzalloc(sizeof(*new) + params->tmpl_len, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+	new->len = params->tmpl_len;
+	memcpy(new->data, params->tmpl, params->tmpl_len);
+	rcu_assign_pointer(sdata->u.ap.fils_discovery, new);
+
+	if (old)
+		kfree_rcu(old, rcu_head);
+
+	return 0;
+}
+
 static int ieee80211_set_ftm_responder_params(
 				struct ieee80211_sub_if_data *sdata,
 				const u8 *lci, size_t lci_len,
@@ -1099,12 +1126,18 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL);
-	if (err < 0) {
-		ieee80211_vif_release_channel(sdata);
-		return err;
-	}
+	if (err < 0)
+		goto error;
 	changed |= err;
 
+	if (params->fils_discovery.max_interval) {
+		err = ieee80211_set_fils_discovery(sdata,
+						   &params->fils_discovery);
+		if (err < 0)
+			goto error;
+		changed |= BSS_CHANGED_FILS_DISCOVERY;
+	}
+
 	err = drv_start_ap(sdata->local, sdata);
 	if (err) {
 		old = sdata_dereference(sdata->u.ap.beacon, sdata);
@@ -1112,8 +1145,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		if (old)
 			kfree_rcu(old, rcu_head);
 		RCU_INIT_POINTER(sdata->u.ap.beacon, NULL);
-		ieee80211_vif_release_channel(sdata);
-		return err;
+		goto error;
 	}
 
 	ieee80211_recalc_dtim(local, sdata);
@@ -1124,6 +1156,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		netif_carrier_on(vlan->dev);
 
 	return 0;
+
+error:
+	ieee80211_vif_release_channel(sdata);
+	return err;
 }
 
 static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
@@ -1160,6 +1196,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	struct ieee80211_local *local = sdata->local;
 	struct beacon_data *old_beacon;
 	struct probe_resp *old_probe_resp;
+	struct fils_discovery_data *old_fils_discovery;
 	struct cfg80211_chan_def chandef;
 
 	sdata_assert_lock(sdata);
@@ -1168,6 +1205,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	if (!old_beacon)
 		return -ENOENT;
 	old_probe_resp = sdata_dereference(sdata->u.ap.probe_resp, sdata);
+	old_fils_discovery = sdata_dereference(sdata->u.ap.fils_discovery,
+					       sdata);
 
 	/* abort any running channel switch */
 	mutex_lock(&local->mtx);
@@ -1191,9 +1230,12 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	/* remove beacon and probe response */
 	RCU_INIT_POINTER(sdata->u.ap.beacon, NULL);
 	RCU_INIT_POINTER(sdata->u.ap.probe_resp, NULL);
+	RCU_INIT_POINTER(sdata->u.ap.fils_discovery, NULL);
 	kfree_rcu(old_beacon, rcu_head);
 	if (old_probe_resp)
 		kfree_rcu(old_probe_resp, rcu_head);
+	if (old_fils_discovery)
+		kfree_rcu(old_fils_discovery, rcu_head);
 
 	kfree(sdata->vif.bss_conf.ftmr_params);
 	sdata->vif.bss_conf.ftmr_params = NULL;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 6bf879660a93..e5b934c9eed3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -271,6 +271,12 @@ struct probe_resp {
 	u8 data[];
 };
 
+struct fils_discovery_data {
+	struct rcu_head rcu_head;
+	int len;
+	u8 data[];
+};
+
 struct ps_data {
 	/* yes, this looks ugly, but guarantees that we can later use
 	 * bitmap_empty :)
@@ -286,6 +292,7 @@ struct ps_data {
 struct ieee80211_if_ap {
 	struct beacon_data __rcu *beacon;
 	struct probe_resp __rcu *probe_resp;
+	struct fils_discovery_data __rcu *fils_discovery;
 
 	/* to be used after channel switch. */
 	struct cfg80211_beacon_data *next_beacon;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d2136007e2eb..f82caf113b1a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5000,6 +5000,34 @@ struct sk_buff *ieee80211_proberesp_get(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_proberesp_get);
 
+struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
+						  struct ieee80211_vif *vif)
+{
+	struct sk_buff *skb = NULL;
+	struct fils_discovery_data *tmpl = NULL;
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	if (sdata->vif.type != NL80211_IFTYPE_AP)
+		return NULL;
+
+	rcu_read_lock();
+	tmpl = rcu_dereference(sdata->u.ap.fils_discovery);
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
+EXPORT_SYMBOL(ieee80211_get_fils_discovery_tmpl);
+
 struct sk_buff *ieee80211_pspoll_get(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif)
 {
-- 
2.25.0

