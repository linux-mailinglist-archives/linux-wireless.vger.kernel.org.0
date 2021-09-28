Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822BB41B2B7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 17:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbhI1PQ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 11:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241080AbhI1PQ3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 11:16:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 786B161213;
        Tue, 28 Sep 2021 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632842089;
        bh=v+V49tWKi/VIFSYT/JEoXDufOKDOr4jjxWVZI9ZcAdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3y5QFl5LZNLfXdl1vHAemFiaFJrLuQJUakqBBmWU3Wzv7n1R7355t+uXM2mlPAr9
         xEWOx6vl+/uAjmmG3xEHuristklJMb8VoSZSLykLfy5wxeB7Ii45YLTBGilgQbd3uY
         dTrNR2zSJF56qiCyirGJGj93h7tVUn8I4+oHXPpXFDRyPMxnIQ/AE+7Kihv9/IucdB
         a4xxMTx7ziN/Jt8qMhvC8xy0JMkghua2QgLYMJaslooAiRhQocPzfSAqXHqCHL03g+
         Yj/Gkdzeab4zr+27OMzDMOgwoIv8iP0W+3T6IcEtKP7r7eqlYR25imylgfYcQZpo3g
         8GFwPpC5XODdQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com, john@phrozen.org
Subject: [RFC 1/7] mac80211: introduce set_offchan_chain callback
Date:   Tue, 28 Sep 2021 17:14:32 +0200
Message-Id: <9c66c947784b754cba44fd9b2935c722498cb1f0.1632841652.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632841652.git.lorenzo@kernel.org>
References: <cover.1632841652.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce set_offchan_chain callback in cfg80211/mac80211_ops in order to
configure a dedicated chain available on some hw (e.g. mt7915) to perfrom
offchannel CAC detection.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/cfg80211.h  |  6 ++++++
 include/net/mac80211.h  |  5 +++++
 net/mac80211/cfg.c      | 13 +++++++++++++
 net/wireless/rdev-ops.h | 17 +++++++++++++++++
 net/wireless/trace.h    | 19 +++++++++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 62dd8422e0dc..fa31b0919be9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4018,6 +4018,10 @@ struct mgmt_frame_regs {
  * @set_sar_specs: Update the SAR (TX power) settings.
  *
  * @color_change: Initiate a color change.
+ *
+ * @set_offchan_chain: Configure dedicated chain available for radar detection
+ *	on some hw. The driver is supposed to implement CAC management in sw
+ *	or fw.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4348,6 +4352,8 @@ struct cfg80211_ops {
 	int	(*color_change)(struct wiphy *wiphy,
 				struct net_device *dev,
 				struct cfg80211_color_change_settings *params);
+	int	(*set_offchan_chain)(struct wiphy *wiphy,
+				     struct cfg80211_chan_def *chandef);
 };
 
 /*
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index af0fc13cea34..e7161850d091 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3933,6 +3933,9 @@ struct ieee80211_prep_tx_info {
  *	twt structure.
  * @twt_teardown_request: Update the hw with TWT teardown request received
  *	from the peer.
+ * @set_offchan_chain: Configure dedicated chain available for radar detection
+ *	on some hw. The driver is supposed to implement CAC management in sw
+ *	or fw.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4261,6 +4264,8 @@ struct ieee80211_ops {
 			      struct ieee80211_twt_setup *twt);
 	void (*twt_teardown_request)(struct ieee80211_hw *hw,
 				     struct ieee80211_sta *sta, u8 flowid);
+	int (*set_offchan_chain)(struct ieee80211_hw *hw,
+				 struct cfg80211_chan_def *chandef);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d69b31c20fe2..5eaa66b3886a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4341,6 +4341,18 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	return err;
 }
 
+static int
+ieee80211_set_offchan_chain(struct wiphy *wiphy,
+			    struct cfg80211_chan_def *chandef)
+{
+	struct ieee80211_local *local = wiphy_priv(wiphy);
+
+	if (!local->ops->set_offchan_chain)
+		return -EOPNOTSUPP;
+
+	return local->ops->set_offchan_chain(&local->hw, chandef);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -4445,4 +4457,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.reset_tid_config = ieee80211_reset_tid_config,
 	.set_sar_specs = ieee80211_set_sar_specs,
 	.color_change = ieee80211_color_change,
+	.set_offchan_chain = ieee80211_set_offchan_chain,
 };
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index ce6bf218a1a3..f24ae15fb9b3 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1381,4 +1381,21 @@ static inline int rdev_color_change(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int
+rdev_set_offchan_chain(struct cfg80211_registered_device *rdev,
+		       struct cfg80211_chan_def *chandef)
+{
+	struct wiphy *wiphy = &rdev->wiphy;
+	int ret;
+
+	if (!rdev->ops->set_offchan_chain)
+		return -EOPNOTSUPP;
+
+	trace_rdev_set_offchan_chain(wiphy, chandef);
+	ret = rdev->ops->set_offchan_chain(wiphy, chandef);
+	trace_rdev_return_int(wiphy, ret);
+
+	return ret;
+}
+
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 19b78d472283..4d905f584301 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3643,6 +3643,25 @@ TRACE_EVENT(cfg80211_bss_color_notify,
 		  __entry->color_bitmap)
 );
 
+TRACE_EVENT(rdev_set_offchan_chain,
+	TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chandef),
+
+	TP_ARGS(wiphy, chandef),
+
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		CHAN_DEF_ENTRY
+	),
+
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		CHAN_DEF_ASSIGN(chandef)
+	),
+
+	TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
+		  WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.31.1

