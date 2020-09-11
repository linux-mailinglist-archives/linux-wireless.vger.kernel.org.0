Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F8F265612
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 02:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgIKAdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 20:33:05 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:40038
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725784AbgIKAdC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 20:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599784381;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=AYhz6TO1Qf+wB0m4h23ua8ggKdpwY9d2kPoH8OPpa34=;
        b=Q3PQlqIWB0DBD4mBynwnnhJfagdW9VaFlkzg8P48hBD4vQWfVocx0LLiEJ2p69AD
        R8ZqP4VhwkcafNBD6mDsDmH93PiaN1tJXKOnI2FiRbW9+VovwL/pc2FwxOfu1y+oHNH
        6dvr2+1yKyPEkSRdf9svmAyYn2+x0vz+CuUZsRhY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599784381;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=AYhz6TO1Qf+wB0m4h23ua8ggKdpwY9d2kPoH8OPpa34=;
        b=Wmg2f9r7x7jgTW12QXXd8HnXnc8/+keEAupvkmucLerUaehGPbQPmyZzC1eX8+vt
        yv87rQmjRJrO2MuzSeQ5AP1RlFG7yEumQdkXKjkew6RQJwz522RYFS0AWcvlndWZGue
        bfXNS+vZGrPfTUDTiOQyZzwi1QZ+LlV23vEGvd8k=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F550C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH v5 2/2] mac80211: Unsolicited broadcast probe response support
Date:   Fri, 11 Sep 2020 00:33:01 +0000
Message-ID: <010101747a946b35-ad25858a-1f1f-48df-909e-dc7bf26d9169-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200911003251.7686-1-alokad@codeaurora.org>
References: <20200911003251.7686-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.09.11-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
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
 include/net/mac80211.h     | 20 +++++++++++++++++++
 net/mac80211/cfg.c         | 41 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  7 +++++++
 net/mac80211/tx.c          | 29 +++++++++++++++++++++++++++
 4 files changed, 97 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a8defc2954e2..517528c5f2e5 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -318,6 +318,8 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_HE_OBSS_PD: OBSS Packet Detection status changed.
  * @BSS_CHANGED_HE_BSS_COLOR: BSS Color has changed
  * @BSS_CHANGED_FILS_DISCOVERY: FILS discovery status changed.
+ * @BSS_CHANGED_UNSOL_BCAST_PROBE_RESP: Unsolicited broadcast probe response
+ *	status changed.
  *
  */
 enum ieee80211_bss_change {
@@ -352,6 +354,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_HE_OBSS_PD		= 1<<28,
 	BSS_CHANGED_HE_BSS_COLOR	= 1<<29,
 	BSS_CHANGED_FILS_DISCOVERY      = 1<<30,
+	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<31,
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -622,6 +625,8 @@ struct ieee80211_fils_discovery {
  * @he_obss_pd: OBSS Packet Detection parameters.
  * @he_bss_color: BSS coloring settings, if BSS supports HE
  * @fils_discovery: FILS discovery configuration
+ * @unsol_bcast_probe_resp_interval: Unsolicited broadcast probe response
+ *	interval.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -690,6 +695,7 @@ struct ieee80211_bss_conf {
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
 	struct ieee80211_fils_discovery fils_discovery;
+	u32 unsol_bcast_probe_resp_interval;
 };
 
 /**
@@ -6620,4 +6626,18 @@ bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
  */
 struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
 						  struct ieee80211_vif *vif);
+
+/**
+ * ieee80211_get_unsol_bcast_probe_resp_tmpl - Get unsolicited broadcast
+ *	probe response template.
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
 #endif /* MAC80211_H */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5bcaf6b01e7e..6d249cca8010 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -864,6 +864,32 @@ static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static int
+ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
+				     struct cfg80211_unsol_bcast_probe_resp *params)
+{
+	struct unsol_bcast_probe_resp_data *new, *old = NULL;
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
@@ -1138,6 +1164,14 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		changed |= BSS_CHANGED_FILS_DISCOVERY;
 	}
 
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
@@ -1197,6 +1231,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	struct beacon_data *old_beacon;
 	struct probe_resp *old_probe_resp;
 	struct fils_discovery_data *old_fils_discovery;
+	struct unsol_bcast_probe_resp_data *old_unsol_bcast_probe_resp;
 	struct cfg80211_chan_def chandef;
 
 	sdata_assert_lock(sdata);
@@ -1207,6 +1242,9 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	old_probe_resp = sdata_dereference(sdata->u.ap.probe_resp, sdata);
 	old_fils_discovery = sdata_dereference(sdata->u.ap.fils_discovery,
 					       sdata);
+	old_unsol_bcast_probe_resp =
+		sdata_dereference(sdata->u.ap.unsol_bcast_probe_resp,
+				  sdata);
 
 	/* abort any running channel switch */
 	mutex_lock(&local->mtx);
@@ -1231,11 +1269,14 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	RCU_INIT_POINTER(sdata->u.ap.beacon, NULL);
 	RCU_INIT_POINTER(sdata->u.ap.probe_resp, NULL);
 	RCU_INIT_POINTER(sdata->u.ap.fils_discovery, NULL);
+	RCU_INIT_POINTER(sdata->u.ap.unsol_bcast_probe_resp, NULL);
 	kfree_rcu(old_beacon, rcu_head);
 	if (old_probe_resp)
 		kfree_rcu(old_probe_resp, rcu_head);
 	if (old_fils_discovery)
 		kfree_rcu(old_fils_discovery, rcu_head);
+	if (old_unsol_bcast_probe_resp)
+		kfree_rcu(old_unsol_bcast_probe_resp, rcu_head);
 
 	kfree(sdata->vif.bss_conf.ftmr_params);
 	sdata->vif.bss_conf.ftmr_params = NULL;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e5b934c9eed3..8016a73159cc 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -277,6 +277,12 @@ struct fils_discovery_data {
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
@@ -293,6 +299,7 @@ struct ieee80211_if_ap {
 	struct beacon_data __rcu *beacon;
 	struct probe_resp __rcu *probe_resp;
 	struct fils_discovery_data __rcu *fils_discovery;
+	struct unsol_bcast_probe_resp_data __rcu *unsol_bcast_probe_resp;
 
 	/* to be used after channel switch. */
 	struct cfg80211_beacon_data *next_beacon;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index f82caf113b1a..127903742419 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5028,6 +5028,35 @@ struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_get_fils_discovery_tmpl);
 
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

