Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43BF1EFD68
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 13:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbfKEMmE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 07:42:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388649AbfKEMmE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 07:42:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0095161491; Tue,  5 Nov 2019 12:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572957724;
        bh=htR+KJ6Zg79a6Ej6jVaiaPN3PLb10i3E86p881GBMAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVMyPmdYO5kaymcJEqiY00cLhF1MftMPXbDEs/oDMVtXw5c/xs7rVW0JBv/fEkzxy
         Kd6Ocp/sdLA5tGmXk3xNldKPcLgS36RemK0MpAiiXLxmA7nIm/73b7Qkx3OenpkPs8
         aIgYKdrRSRscHx7i8Fdtj5x0N1uMqmjrzxuZvfEc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14BFF6148C;
        Tue,  5 Nov 2019 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572957723;
        bh=htR+KJ6Zg79a6Ej6jVaiaPN3PLb10i3E86p881GBMAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uob5cGi/WryQ6R7sB2JFrWelfsgS3gxGkuTJnIXhX4j9zw/BXHaAYWuOgtyRF7/jJ
         r8GDJIM6wV39ZTJNO9ToPZxUPihZVCMRWOZCZ02YazxinLPcB+yaKm5/6Ne4Zd5Uo5
         NT7KJyHZ0fih/SKOBozYcupPBhJZd1YSgU9TL+8Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14BFF6148C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv8 6/6] mac80211: Add api to support configuring TID specific configuration
Date:   Tue,  5 Nov 2019 18:11:54 +0530
Message-Id: <1572957714-16085-7-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Implement drv_set_tid_config api to allow TID specific
configuration. This per-TID configuration
will be applied for all the connected stations when MAC is NULL.

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 include/net/mac80211.h    |    8 ++++++++
 net/mac80211/cfg.c        |   28 ++++++++++++++++++++++++++++
 net/mac80211/driver-ops.h |   15 +++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f599696..017bd44 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3756,6 +3756,10 @@ enum ieee80211_reconfig_type {
  *
  * @start_pmsr: start peer measurement (e.g. FTM) (this call can sleep)
  * @abort_pmsr: abort peer measurement (this call can sleep)
+ * @set_tid_config: TID specific configurations will be applied for a particular
+ *	station when @sta is non-NULL. When @sta is %NULL, then the
+ *	configuration will be for all the connected clients in the vif.
+ *	This callback may sleep.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4060,6 +4064,10 @@ struct ieee80211_ops {
 			  struct cfg80211_pmsr_request *request);
 	void (*abort_pmsr)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   struct cfg80211_pmsr_request *request);
+	int (*set_tid_config)(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_tid_config *tid_conf);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 70739e7..22aa640 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3942,6 +3942,33 @@ static int ieee80211_get_txq_stats(struct wiphy *wiphy,
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
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -4040,4 +4067,5 @@ static int ieee80211_get_txq_stats(struct wiphy *wiphy,
 	.start_pmsr = ieee80211_start_pmsr,
 	.abort_pmsr = ieee80211_abort_pmsr,
 	.probe_mesh_link = ieee80211_probe_mesh_link,
+	.set_tid_config = ieee80211_set_tid_config,
 };
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 2c9b3eb8..c4954c7 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1358,4 +1358,19 @@ static inline void drv_del_nan_func(struct ieee80211_local *local,
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
 #endif /* __MAC80211_DRIVER_OPS */
-- 
1.7.9.5

