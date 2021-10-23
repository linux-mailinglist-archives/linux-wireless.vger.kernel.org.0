Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED19343828F
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 11:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhJWJNt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 05:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhJWJNp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 05:13:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E329D6108B;
        Sat, 23 Oct 2021 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634980287;
        bh=aenAbiKE7EbsTZYvaSTrD04eYjePQWpWj05XdKgo9Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qP8jsu5T5OzXw2KgV5iChS39gFG6S3NCvx8P+NrtBjTZ4a3rdREkvt/YheI/bfzwK
         hZxP1OilkBIp2Ca8jbjG4WiCp/AXQzvW+nM6dxI8ZGjF76FJAtZ0grCphyCfS/tA4s
         5Ymd0kisAuZVFgx2R/WsFpifhQjtYCYMsrw3rFl6io0JVYQktodVKlQezws9Cgwkk9
         q9+bFnWgNkBJrRLdcmdroaXqXIo2a+bIkWSgeTrEoMHnI12eNMTSRzdZi5V7ou5kkd
         RtXNAy5hf9vukFNo6nYdg6nHRBq/5HBa/DLXyxwiedqYEL6gYhowl+6o4PIfLoy0Iz
         LlecGpGRPUubQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v2 mac80211-next 2/6] mac80211: introduce set_radar_offchan callback
Date:   Sat, 23 Oct 2021 11:10:51 +0200
Message-Id: <201110606d4f3a7dfdf31440e351f2e2c375d4f0.1634979655.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634979655.git.lorenzo@kernel.org>
References: <cover.1634979655.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to cfg80211, introduce set_radar_offchan callback in mac80211_ops
in order to configure a dedicated offchannel chain available on some hw
(e.g. mt7915) to perform offchannel CAC detection and avoid tx/rx downtime.

Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/mac80211.h | 10 ++++++++++
 net/mac80211/cfg.c     | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index dd757f0987b0..775dbb982654 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3944,6 +3944,14 @@ struct ieee80211_prep_tx_info {
  *	twt structure.
  * @twt_teardown_request: Update the hw with TWT teardown request received
  *	from the peer.
+ * @set_radar_offchan: Configure dedicated offchannel chain available for
+ *	radar/CAC detection on some hw. This chain can't be used to transmit
+ *	or receive frames and it is bounded to a running wdev.
+ *	Offchannel radar/CAC detection allows to avoid the CAC downtime
+ *	switching to a different channel during CAC detection on the selected
+ *	radar channel.
+ *	The caller is expected to set chandef pointer to NULL in order to
+ *	disable offchannel CAC/radar detection.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4272,6 +4280,8 @@ struct ieee80211_ops {
 			      struct ieee80211_twt_setup *twt);
 	void (*twt_teardown_request)(struct ieee80211_hw *hw,
 				     struct ieee80211_sta *sta, u8 flowid);
+	int (*set_radar_offchan)(struct ieee80211_hw *hw,
+				 struct cfg80211_chan_def *chandef);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e2b791c37591..1ab84830a38f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4379,6 +4379,18 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	return err;
 }
 
+static int
+ieee80211_set_radar_offchan(struct wiphy *wiphy,
+			    struct cfg80211_chan_def *chandef)
+{
+	struct ieee80211_local *local = wiphy_priv(wiphy);
+
+	if (!local->ops->set_radar_offchan)
+		return -EOPNOTSUPP;
+
+	return local->ops->set_radar_offchan(&local->hw, chandef);
+}
+
 const struct cfg80211_ops mac80211_config_ops = {
 	.add_virtual_intf = ieee80211_add_iface,
 	.del_virtual_intf = ieee80211_del_iface,
@@ -4483,4 +4495,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.reset_tid_config = ieee80211_reset_tid_config,
 	.set_sar_specs = ieee80211_set_sar_specs,
 	.color_change = ieee80211_color_change,
+	.set_radar_offchan = ieee80211_set_radar_offchan,
 };
-- 
2.31.1

