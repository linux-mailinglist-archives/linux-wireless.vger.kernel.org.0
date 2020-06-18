Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446961FEA9A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 07:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgFRFFM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 01:05:12 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:28292 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgFRFFM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 01:05:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592456705; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/8Y/sVvRaRNDRhv/269hughSV8fs/BU87Dx008Cro2A=; b=wLskDdQlMroRhcRpR90UzqcFyHvEX7gEXCJ0fSiH2zTU5wpctBTuUF7wca82MR/f1a6NNBUw
 y4aWVKPNFEFwtlC8wVs3g0qruXo4tozf8Aw5abR4g8GdnKEGD1DjTE63vEmd8T8iIYnFg7nD
 A2I6LHQHR5IGtbo3am2jvSz/HbM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5eeaf5e56f2ee827da2c5787 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Jun 2020 05:04:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8F8A8C433C9; Thu, 18 Jun 2020 05:04:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71ECCC433CB;
        Thu, 18 Jun 2020 05:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71ECCC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v4 2/2] mac80211: Add FILS discovery support
Date:   Wed, 17 Jun 2020 22:04:27 -0700
Message-Id: <20200618050427.5891-3-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200618050427.5891-1-alokad@codeaurora.org>
References: <20200618050427.5891-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds mac80211 support to configure FILS discovery
transmission.
Changes include functions to store and retrieve FILS discovery
template, minimum and maximum packet intervals.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v4: Removed attributes unrelated to FILS discovery -
    bcn_resp_win, omit_replicate_probe_resp and
    member named enabled in struct ieee80211_fils_discovery.

 include/net/mac80211.h     | 27 +++++++++++++++++++++++++
 net/mac80211/cfg.c         | 41 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  7 +++++++
 net/mac80211/tx.c          | 25 +++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 11d5610d2ad5..87d9570497fe 100644
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
@@ -6558,4 +6574,15 @@ u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
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
index 9b360544ad6f..dae054b769b5 100644
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
+	fd = &sdata->vif.bss_conf.fils_discovery;
+	fd->min_interval = params->min_interval;
+	fd->max_interval = params->max_interval;
+
+	if (!params->tmpl || !params->tmpl_len) /* Optional template */
+		return 0;
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
@@ -1103,6 +1130,14 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 	changed |= err;
 
+	err = ieee80211_set_fils_discovery(sdata, &params->fils_discovery);
+	if (err < 0) {
+		ieee80211_vif_release_channel(sdata);
+		return err;
+	} else if (err == 0) {
+		changed |= BSS_CHANGED_FILS_DISCOVERY;
+	}
+
 	err = drv_start_ap(sdata->local, sdata);
 	if (err) {
 		old = sdata_dereference(sdata->u.ap.beacon, sdata);
@@ -1158,6 +1193,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	struct ieee80211_local *local = sdata->local;
 	struct beacon_data *old_beacon;
 	struct probe_resp *old_probe_resp;
+	struct fils_discovery_data *old_fils_discovery;
 	struct cfg80211_chan_def chandef;
 
 	sdata_assert_lock(sdata);
@@ -1166,6 +1202,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	if (!old_beacon)
 		return -ENOENT;
 	old_probe_resp = sdata_dereference(sdata->u.ap.probe_resp, sdata);
+	old_fils_discovery = sdata_dereference(sdata->u.ap.fils_discovery,
+					       sdata);
 
 	/* abort any running channel switch */
 	mutex_lock(&local->mtx);
@@ -1189,9 +1227,12 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
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
index ec1a71ac65f2..479c1691630b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -272,6 +272,12 @@ struct probe_resp {
 	u8 data[];
 };
 
+struct fils_discovery_data {
+	struct rcu_head rcu_head;
+	int len;
+	u8 data[0];
+};
+
 struct ps_data {
 	/* yes, this looks ugly, but guarantees that we can later use
 	 * bitmap_empty :)
@@ -287,6 +293,7 @@ struct ps_data {
 struct ieee80211_if_ap {
 	struct beacon_data __rcu *beacon;
 	struct probe_resp __rcu *probe_resp;
+	struct fils_discovery_data __rcu *fils_discovery;
 
 	/* to be used after channel switch. */
 	struct cfg80211_beacon_data *next_beacon;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e9ce658141f5..9c1044782561 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4998,6 +4998,31 @@ struct sk_buff *ieee80211_proberesp_get(struct ieee80211_hw *hw,
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
+	skb = dev_alloc_skb(tmpl->len);
+	if (skb)
+		skb_put_data(skb, tmpl->data, tmpl->len);
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

