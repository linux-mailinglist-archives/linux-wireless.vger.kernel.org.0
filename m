Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25BA3759F1
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 20:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhEFSGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 14:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbhEFSGd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 14:06:33 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46DEC061761
        for <linux-wireless@vger.kernel.org>; Thu,  6 May 2021 11:05:34 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id o6-20020a0ccb060000b02901c0933b76e1so4786514qvk.8
        for <linux-wireless@vger.kernel.org>; Thu, 06 May 2021 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FEVlr4g3tZJxsFx0Sj9mnajiW44wOc9m7hmf42oy47c=;
        b=GOsjaWZqj/DzQeS+SFfhECtFoAUJji0FqqSZ8YEmeFnIKfmVyRiqowRmeRo+f8qK3h
         D7hBXUFDze4vtxESUTQz9sFcw/DOEcwOoowczIwoRq1zxeeT45kLxc/+7z0Xgyo93wGg
         vNSBZSZdOafv6VyHV4sRKpM23nZBL9B4EWB3wCcMjlaq2Xs0onQKbCBYge8PUoaGx/y+
         XcumHKkTtXQAgogXE6VPQrmokvQgY/zli6rJz8UGHPuNSXf//hwBPCfk12ua4sbocFZz
         /r29jNIcCGDGnc/wyVlhSLMBxCxuh281UUDxu3R260HFIf8o0BkXRkYclivyqJXo9Rtx
         HptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FEVlr4g3tZJxsFx0Sj9mnajiW44wOc9m7hmf42oy47c=;
        b=fVVNPMBgV83RWNKenIDycXMKyX+KvHidjbWkocr2CMr3/OpCAgq+lHlCSteoKuydqG
         6p0sXjxDu+ebUZPON7y/qBbDE4GXAR/E8RCvLlnEiWO8cnG8kfNwVicqfMriugCIq/b6
         ETKNyqOk35rMLEvB2YsF2mS9Fq5Y7YsWuHTmYpgEl6BUPNqOtdssde9LmA8I7a3rNN/e
         OsRX0jKEUMhkf4gss6877OXXaWJsZqZIYkONGjyHQ3FyI54+LC67Y+m6O4gPXoS/ew1f
         FIHGnDQiq6pQO2iZLgcM7t/tdKLpsQd6qH5WFgYRfTjEGsNeyUVG9KX4xjHE0h8pSPGA
         G5fw==
X-Gm-Message-State: AOAM532il8Hzj8+AKSQgzLik4CIw4KRje1jU48LyybSQrS724FfgYbfC
        Vmq1g3CI+bYo6szCJu9ht4eZFlM=
X-Google-Smtp-Source: ABdhPJzW8aLod+t5Wz6FHaDNS3U/7RtSC8JVgIJTc47WnDgAJ4hoM8Cv6QFeoutcaXsivgtAgT4A584=
X-Received: from wdu0.mtv.corp.google.com ([2620:15c:211:201:61b:49c:e610:2968])
 (user=wdu job=sendgmr) by 2002:a0c:fa8e:: with SMTP id o14mr5605862qvn.45.1620324333501;
 Thu, 06 May 2021 11:05:33 -0700 (PDT)
Date:   Thu,  6 May 2021 11:05:29 -0700
Message-Id: <20210506180530.3418576-1-wdu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v1] mac80211_hwsim: add concurrent channels scanning support
 over virtio
From:   Weilun Du <wdu@google.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Weilun Du <wdu@google.com>, kernel-team@android.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fixed the crash when setting channels to 2 or more when
communicating over virtio.

Signed-off-by: Weilun Du <wdu@google.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 48 +++++++++++++++++++++------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 51ce767eaf88..0c44ec0ab03f 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -626,6 +626,7 @@ struct mac80211_hwsim_data {
 	u32 ciphers[ARRAY_SIZE(hwsim_ciphers)];
 
 	struct mac_address addresses[2];
+	struct ieee80211_chanctx_conf *chanctx;
 	int channels, idx;
 	bool use_chanctx;
 	bool destroy_on_close;
@@ -1257,7 +1258,8 @@ static inline u16 trans_tx_rate_flags_ieee2hwsim(struct ieee80211_tx_rate *rate)
 
 static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 				       struct sk_buff *my_skb,
-				       int dst_portid)
+				       int dst_portid,
+				       struct ieee80211_channel *channel)
 {
 	struct sk_buff *skb;
 	struct mac80211_hwsim_data *data = hw->priv;
@@ -1312,7 +1314,7 @@ static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 	if (nla_put_u32(skb, HWSIM_ATTR_FLAGS, hwsim_flags))
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, HWSIM_ATTR_FREQ, data->channel->center_freq))
+	if (nla_put_u32(skb, HWSIM_ATTR_FREQ, channel->center_freq))
 		goto nla_put_failure;
 
 	/* We get the tx control (rate and retries) info*/
@@ -1659,7 +1661,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	_portid = READ_ONCE(data->wmediumd);
 
 	if (_portid || hwsim_virtio_enabled)
-		return mac80211_hwsim_tx_frame_nl(hw, skb, _portid);
+		return mac80211_hwsim_tx_frame_nl(hw, skb, _portid, channel);
 
 	/* NO wmediumd detected, perfect medium simulation */
 	data->tx_pkts++;
@@ -1770,7 +1772,7 @@ static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
 	mac80211_hwsim_monitor_rx(hw, skb, chan);
 
 	if (_pid || hwsim_virtio_enabled)
-		return mac80211_hwsim_tx_frame_nl(hw, skb, _pid);
+		return mac80211_hwsim_tx_frame_nl(hw, skb, _pid, chan);
 
 	mac80211_hwsim_tx_frame_no_nl(hw, skb, chan);
 	dev_kfree_skb(skb);
@@ -2509,6 +2511,11 @@ static int mac80211_hwsim_croc(struct ieee80211_hw *hw,
 static int mac80211_hwsim_add_chanctx(struct ieee80211_hw *hw,
 				      struct ieee80211_chanctx_conf *ctx)
 {
+	struct mac80211_hwsim_data *hwsim = hw->priv;
+
+	mutex_lock(&hwsim->mutex);
+	hwsim->chanctx = ctx;
+	mutex_unlock(&hwsim->mutex);
 	hwsim_set_chanctx_magic(ctx);
 	wiphy_dbg(hw->wiphy,
 		  "add channel context control: %d MHz/width: %d/cfreqs:%d/%d MHz\n",
@@ -2520,6 +2527,11 @@ static int mac80211_hwsim_add_chanctx(struct ieee80211_hw *hw,
 static void mac80211_hwsim_remove_chanctx(struct ieee80211_hw *hw,
 					  struct ieee80211_chanctx_conf *ctx)
 {
+	struct mac80211_hwsim_data *hwsim = hw->priv;
+
+	mutex_lock(&hwsim->mutex);
+	hwsim->chanctx = NULL;
+	mutex_unlock(&hwsim->mutex);
 	wiphy_dbg(hw->wiphy,
 		  "remove channel context control: %d MHz/width: %d/cfreqs:%d/%d MHz\n",
 		  ctx->def.chan->center_freq, ctx->def.width,
@@ -2532,6 +2544,11 @@ static void mac80211_hwsim_change_chanctx(struct ieee80211_hw *hw,
 					  struct ieee80211_chanctx_conf *ctx,
 					  u32 changed)
 {
+	struct mac80211_hwsim_data *hwsim = hw->priv;
+
+	mutex_lock(&hwsim->mutex);
+	hwsim->chanctx = ctx;
+	mutex_unlock(&hwsim->mutex);
 	hwsim_check_chanctx_magic(ctx);
 	wiphy_dbg(hw->wiphy,
 		  "change channel context control: %d MHz/width: %d/cfreqs:%d/%d MHz\n",
@@ -3124,6 +3141,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		hw->wiphy->max_remain_on_channel_duration = 1000;
 		data->if_combination.radar_detect_widths = 0;
 		data->if_combination.num_different_channels = data->channels;
+		data->chanctx = NULL;
 	} else {
 		data->if_combination.num_different_channels = 1;
 		data->if_combination.radar_detect_widths =
@@ -3633,6 +3651,7 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	int frame_data_len;
 	void *frame_data;
 	struct sk_buff *skb = NULL;
+	struct ieee80211_channel *channel = NULL;
 
 	if (!info->attrs[HWSIM_ATTR_ADDR_RECEIVER] ||
 	    !info->attrs[HWSIM_ATTR_FRAME] ||
@@ -3659,6 +3678,17 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	if (!data2)
 		goto out;
 
+	if (data2->use_chanctx) {
+		if (data2->tmp_chan)
+			channel = data2->tmp_chan;
+		else if (data2->chanctx)
+			channel = data2->chanctx->def.chan;
+	} else {
+		channel = data2->channel;
+	}
+	if (!channel)
+		goto out;
+
 	if (!hwsim_virtio_enabled) {
 		if (hwsim_net_get_netgroup(genl_info_net(info)) !=
 		    data2->netgroup)
@@ -3670,7 +3700,7 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 
 	/* check if radio is configured properly */
 
-	if (data2->idle || !data2->started)
+	if ((data2->idle && !data2->tmp_chan) || !data2->started)
 		goto out;
 
 	/* A frame is received from user space */
@@ -3683,18 +3713,16 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 		mutex_lock(&data2->mutex);
 		rx_status.freq = nla_get_u32(info->attrs[HWSIM_ATTR_FREQ]);
 
-		if (rx_status.freq != data2->channel->center_freq &&
-		    (!data2->tmp_chan ||
-		     rx_status.freq != data2->tmp_chan->center_freq)) {
+		if (rx_status.freq != channel->center_freq) {
 			mutex_unlock(&data2->mutex);
 			goto out;
 		}
 		mutex_unlock(&data2->mutex);
 	} else {
-		rx_status.freq = data2->channel->center_freq;
+		rx_status.freq = channel->center_freq;
 	}
 
-	rx_status.band = data2->channel->band;
+	rx_status.band = channel->band;
 	rx_status.rate_idx = nla_get_u32(info->attrs[HWSIM_ATTR_RX_RATE]);
 	rx_status.signal = nla_get_u32(info->attrs[HWSIM_ATTR_SIGNAL]);
 
-- 
2.31.1.607.g51e8a6a459-goog

