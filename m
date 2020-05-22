Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DA11DF1B9
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2020 00:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgEVWTk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 18:19:40 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:45962 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731062AbgEVWTk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 18:19:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590185979; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=FzjOS1vxDOnox3INQqTptHv7z1joj0WIK7xYbGR6j1o=; b=QT21dt3qcbMzZKE3sHcWHTBP0H089i0SVCV2BSg1GNYoZxjO2hjbH1+18NHDSbaz8yFUnjNZ
 XvCkpUt7F24o9Nl5YxssUO+ag68GnRcFOWt2pts+aaAXGebO1Q+awZ80/HEvFYucoAH9wYXc
 yIJeL9xfjGnOMYaCpSWYRbL/U9s=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ec84ff3eb073d5691236a4f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 22:19:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 697CAC433CA; Fri, 22 May 2020 22:19:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABF6AC433C6;
        Fri, 22 May 2020 22:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABF6AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH 2/2] mac80211: FILS disc/bcast probe resp config
Date:   Fri, 22 May 2020 15:19:21 -0700
Message-Id: <20200522221921.19347-3-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200522221921.19347-1-alokad@codeaurora.org>
References: <20200522221921.19347-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds mac80211 support to configure FILS discovery and
broadcast probe response in 6GHz for in-band discovery.

Changes include functions to store and retrieve FILS discovery,
broadcast probe response templates, and packet interval.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
 include/net/mac80211.h     | 17 ++++++++++++
 net/mac80211/cfg.c         | 57 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  8 ++++++
 net/mac80211/tx.c          | 30 ++++++++++++++++++++
 4 files changed, 112 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 78f7ce586287..768d6d9c47b6 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -317,6 +317,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_TWT: TWT status changed
  * @BSS_CHANGED_HE_OBSS_PD: OBSS Packet Detection status changed.
  * @BSS_CHANGED_HE_BSS_COLOR: BSS Color has changed
+ * @BSS_CHANGED_FD_BCASTPRESP: FILS Discovery/Bcast probe resp status changed.
  *
  */
 enum ieee80211_bss_change {
@@ -350,6 +351,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_TWT			= 1<<27,
 	BSS_CHANGED_HE_OBSS_PD		= 1<<28,
 	BSS_CHANGED_HE_BSS_COLOR	= 1<<29,
+	BSS_CHANGED_FD_BCASTPRESP	= 1<<30,
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -607,6 +609,7 @@ struct ieee80211_ftm_responder_params {
  * @he_oper: HE operation information of the AP we are connected to
  * @he_obss_pd: OBSS Packet Detection parameters.
  * @he_bss_color: BSS coloring settings, if BSS supports HE
+ * @fd_bcastpresp: FILS discovery and broadcast probe response configuration
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -674,6 +677,7 @@ struct ieee80211_bss_conf {
 	} he_oper;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	struct cfg80211_fd_bcastpresp fd_bcastpresp;
 };
 
 /**
@@ -6554,4 +6558,17 @@ u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
  */
 bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
 
+/**
+ * ieee80211_get_fd_bcastpresp_tmpl - Get FILS disc/Bcast probe resp template.
+ * @hw: pointer obtained from ieee80211_alloc_hw().
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @config: 1-FILS discovery, 2-Broadcast probe response.
+ *
+ * The driver is responsible for freeing the returned skb.
+ *
+ * Return: FILS discovery/broadcast probe response template. %NULL on error.
+ */
+struct sk_buff *ieee80211_get_fd_bcastpresp_tmpl(struct ieee80211_hw *hw,
+						 struct ieee80211_vif *vif,
+						 u8 config);
 #endif /* MAC80211_H */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 548a384b0509..234f2610256c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -837,6 +837,43 @@ static int ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static int ieee80211_set_fd_bcastpresp(struct ieee80211_sub_if_data *sdata,
+				       struct cfg80211_ap_settings *params)
+{
+	struct fd_bcastpresp *new, *old = NULL;
+	struct cfg80211_fd_bcastpresp *cfg;
+	struct cfg80211_beacon_data *bcn = &params->beacon;
+
+	cfg = &sdata->vif.bss_conf.fd_bcastpresp;
+	cfg->type = params->fd_bcastpresp.type;
+	cfg->interval = params->fd_bcastpresp.interval;
+
+	if (cfg->type == CFG80211_TYPE_FILS_DISCOVERY && bcn->fils_disc_len) {
+		new = kzalloc(sizeof(*new) + bcn->fils_disc_len, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+		new->len = bcn->fils_disc_len;
+		memcpy(new->data, bcn->fils_disc, bcn->fils_disc_len);
+		old = sdata_dereference(sdata->u.ap.fils_disc, sdata);
+		rcu_assign_pointer(sdata->u.ap.fils_disc, new);
+	} else if (cfg->type == CFG80211_TYPE_BCAST_PROBE_RESP &&
+		   bcn->bcast_presp_len) {
+		new = kzalloc(sizeof(*new) + bcn->bcast_presp_len, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+		new->len = bcn->bcast_presp_len;
+		memcpy(new->data, bcn->bcast_presp,
+		       bcn->bcast_presp_len);
+		old = sdata_dereference(sdata->u.ap.bcast_presp, sdata);
+		rcu_assign_pointer(sdata->u.ap.bcast_presp, new);
+	}
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
@@ -1103,6 +1140,16 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 	changed |= err;
 
+	if (params->fd_bcastpresp.type) {
+		err = ieee80211_set_fd_bcastpresp(sdata, params);
+		if (err < 0) {
+			ieee80211_vif_release_channel(sdata);
+			return err;
+		} else if (err == 0) {
+			changed |= BSS_CHANGED_FD_BCASTPRESP;
+		}
+	}
+
 	err = drv_start_ap(sdata->local, sdata);
 	if (err) {
 		old = sdata_dereference(sdata->u.ap.beacon, sdata);
@@ -1158,6 +1205,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	struct ieee80211_local *local = sdata->local;
 	struct beacon_data *old_beacon;
 	struct probe_resp *old_probe_resp;
+	struct fd_bcastpresp *old_bcast_probe_resp, *old_fils_disc;
 	struct cfg80211_chan_def chandef;
 
 	sdata_assert_lock(sdata);
@@ -1166,6 +1214,9 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	if (!old_beacon)
 		return -ENOENT;
 	old_probe_resp = sdata_dereference(sdata->u.ap.probe_resp, sdata);
+	old_bcast_probe_resp = sdata_dereference(sdata->u.ap.bcast_presp,
+						 sdata);
+	old_fils_disc = sdata_dereference(sdata->u.ap.fils_disc, sdata);
 
 	/* abort any running channel switch */
 	mutex_lock(&local->mtx);
@@ -1189,9 +1240,15 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 	/* remove beacon and probe response */
 	RCU_INIT_POINTER(sdata->u.ap.beacon, NULL);
 	RCU_INIT_POINTER(sdata->u.ap.probe_resp, NULL);
+	RCU_INIT_POINTER(sdata->u.ap.bcast_presp, NULL);
+	RCU_INIT_POINTER(sdata->u.ap.fils_disc, NULL);
 	kfree_rcu(old_beacon, rcu_head);
 	if (old_probe_resp)
 		kfree_rcu(old_probe_resp, rcu_head);
+	if (old_bcast_probe_resp)
+		kfree_rcu(old_bcast_probe_resp, rcu_head);
+	if (old_fils_disc)
+		kfree_rcu(old_fils_disc, rcu_head);
 
 	kfree(sdata->vif.bss_conf.ftmr_params);
 	sdata->vif.bss_conf.ftmr_params = NULL;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8cbae66b5cdb..f9c77dbeb29a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -270,6 +270,12 @@ struct probe_resp {
 	u8 data[0];
 };
 
+struct fd_bcastpresp {
+	struct rcu_head rcu_head;
+	int len;
+	u8 data[0];
+};
+
 struct ps_data {
 	/* yes, this looks ugly, but guarantees that we can later use
 	 * bitmap_empty :)
@@ -285,6 +291,8 @@ struct ps_data {
 struct ieee80211_if_ap {
 	struct beacon_data __rcu *beacon;
 	struct probe_resp __rcu *probe_resp;
+	struct fd_bcastpresp __rcu *bcast_presp;
+	struct fd_bcastpresp __rcu *fils_disc;
 
 	/* to be used after channel switch. */
 	struct cfg80211_beacon_data *next_beacon;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6dad67eb60b2..6dacd58d956d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4984,6 +4984,36 @@ struct sk_buff *ieee80211_proberesp_get(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_proberesp_get);
 
+struct sk_buff *ieee80211_get_fd_bcastpresp_tmpl(struct ieee80211_hw *hw,
+						 struct ieee80211_vif *vif,
+						 u8 config)
+{
+	struct sk_buff *skb = NULL;
+	struct fd_bcastpresp *tmpl = NULL;
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	if (sdata->vif.type != NL80211_IFTYPE_AP)
+		return NULL;
+
+	rcu_read_lock();
+
+	if (config == CFG80211_TYPE_FILS_DISCOVERY)
+		tmpl = rcu_dereference(sdata->u.ap.fils_disc);
+	else if (config == CFG80211_TYPE_BCAST_PROBE_RESP)
+		tmpl = rcu_dereference(sdata->u.ap.bcast_presp);
+
+	if (!tmpl || !tmpl->len)
+		goto out;
+
+	skb = dev_alloc_skb(tmpl->len);
+	if (skb)
+		skb_put_data(skb, tmpl->data, tmpl->len);
+out:
+	rcu_read_unlock();
+	return skb;
+}
+EXPORT_SYMBOL(ieee80211_get_fd_bcastpresp_tmpl);
+
 struct sk_buff *ieee80211_pspoll_get(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif)
 {
-- 
2.25.0

