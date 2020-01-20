Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00744142480
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2020 08:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgATHvx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jan 2020 02:51:53 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:39738 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbgATHvx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jan 2020 02:51:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579506713; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=T4s/L5iOhLSFLCkVa6+Mg7g4jFfJfl4BxBR1PUob33g=; b=GyNI07r9VtJ/+i6uVAwgjUofWOYcLY7olWg8Cutu22bMUF2e5zaNcIPr4wlFtpaVub6CefZN
 DWYygJd/DzZaWUtuGRq1e9u8Zl5JEFR5yM6EPHBZjqzO9Wjij20PC+8EXaONY1NmTkB0p/aC
 hVPBzAxxIa01Rae5N5fkK71+Ixg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e255c16.7f584f531a40-smtp-out-n02;
 Mon, 20 Jan 2020 07:51:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B66C5C447A1; Mon, 20 Jan 2020 07:51:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28102C4479F;
        Mon, 20 Jan 2020 07:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28102C4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv10 6/6] mac80211: Add api to support configuring TID specific configuration
Date:   Mon, 20 Jan 2020 13:21:27 +0530
Message-Id: <1579506687-18296-7-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579506687-18296-1-git-send-email-tamizhr@codeaurora.org>
References: <1579506687-18296-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tamizh chelvam <tamizhr@codeaurora.org>

Implement drv_set_tid_config api to allow TID specific
configuration and drv_reset_tid_config api to reset peer
specific TID configuration. This per-TID onfiguration
will be applied for all the connected stations when MAC is NULL.

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 include/net/mac80211.h    |   10 ++++++++
 net/mac80211/cfg.c        |   56 +++++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/driver-ops.h |   27 ++++++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 6d4ea71..cd57d2d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3777,6 +3777,9 @@ enum ieee80211_reconfig_type {
  *
  * @start_pmsr: start peer measurement (e.g. FTM) (this call can sleep)
  * @abort_pmsr: abort peer measurement (this call can sleep)
+ * @set_tid_config: Apply TID specific configurations. This callback may sleep.
+ * @reset_tid_config: Reset TID specific configuration for the peer.
+ *	This callback may sleep.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4081,6 +4084,13 @@ struct ieee80211_ops {
 			  struct cfg80211_pmsr_request *request);
 	void (*abort_pmsr)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   struct cfg80211_pmsr_request *request);
+	int (*set_tid_config)(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_tid_config *tid_conf);
+	int (*reset_tid_config)(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta, u8 tid);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a11bd16..094422d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3945,6 +3945,60 @@ static int ieee80211_get_txq_stats(struct wiphy *wiphy,
 	return drv_abort_pmsr(local, sdata, request);
 }
 
+static int ieee80211_set_tid_config(struct wiphy *wiphy,
+				    struct net_device *dev,
+				    struct ieee80211_tid_config *tid_conf)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct sta_info *sta;
+	int ret;
+
+	if (!sdata->local->ops->set_tid_config)
+		return -EOPNOTSUPP;
+
+	if (!tid_conf->peer)
+		return drv_set_tid_config(sdata->local, sdata, NULL, tid_conf);
+
+	mutex_lock(&sdata->local->sta_mtx);
+
+	sta = sta_info_get_bss(sdata, tid_conf->peer);
+	if (!sta) {
+		mutex_unlock(&sdata->local->sta_mtx);
+		return -ENOENT;
+	}
+
+	ret = drv_set_tid_config(sdata->local, sdata, &sta->sta, tid_conf);
+	mutex_unlock(&sdata->local->sta_mtx);
+	return ret;
+}
+
+static int ieee80211_reset_tid_config(struct wiphy *wiphy,
+				      struct net_device *dev,
+				      const u8 *peer, u8 tid)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct sta_info *sta;
+	int ret;
+
+	if (!sdata->local->ops->reset_tid_config)
+		return -EOPNOTSUPP;
+
+	if (!peer)
+		return drv_reset_tid_config(sdata->local, sdata, NULL, tid);
+
+	mutex_lock(&sdata->local->sta_mtx);
+
+	sta = sta_info_get_bss(sdata, peer);
+	if (!sta) {
+		mutex_unlock(&sdata->local->sta_mtx);
+		return -ENOENT;
+	}
+
+	ret = drv_reset_tid_config(sdata->local, sdata, &sta->sta, tid);
+	mutex_unlock(&sdata->local->sta_mtx);
+	return ret;
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -4043,4 +4097,6 @@ static int ieee80211_get_txq_stats(struct wiphy *wiphy,
 	.start_pmsr = ieee80211_start_pmsr,
 	.abort_pmsr = ieee80211_abort_pmsr,
 	.probe_mesh_link = ieee80211_probe_mesh_link,
+	.set_tid_config = ieee80211_set_tid_config,
+	.reset_tid_config = ieee80211_reset_tid_config,
 };
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 2c9b3eb8..dcbd105 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1358,4 +1358,31 @@ static inline void drv_del_nan_func(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline int drv_set_tid_config(struct ieee80211_local *local,
+				     struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_sta *sta,
+				     struct ieee80211_tid_config *tid_conf)
+{
+	int ret;
+
+	might_sleep();
+	ret = local->ops->set_tid_config(&local->hw, &sdata->vif, sta,
+					 tid_conf);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
+
+static inline int drv_reset_tid_config(struct ieee80211_local *local,
+				       struct ieee80211_sub_if_data *sdata,
+				       struct ieee80211_sta *sta, u8 tid)
+{
+	int ret;
+
+	might_sleep();
+	ret = local->ops->reset_tid_config(&local->hw, &sdata->vif, sta, tid);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
 #endif /* __MAC80211_DRIVER_OPS */
-- 
1.7.9.5
