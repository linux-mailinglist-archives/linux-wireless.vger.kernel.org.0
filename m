Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10E85AB42E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiIBOvk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiIBOvG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890AB60530
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TAWFtVhWDoDPRB6e3NDtIsgHfTgRF1yu5K9h2Y6oZ3s=;
        t=1662127991; x=1663337591; b=i2e8vZnAb+yuSVDW/9mgb4OtuiGzK599tFmA/Xbja0JL+Yt
        hOVqwoU8W1UWDx+569FAAkRBrPy2PExblC1DcVPgaQvDi6S1ajc+stG2EXdI/h/rk77DWd5LmXLAI
        NwQaKlG9sLXOI9KCwYG91lnMd3DosAFDHQL0dAWSgyUuMFei8cnCWUkmXov9oyeDRE0CFT6DYiqvb
        0YCu9AxpdKk1dMIDw31kckLyJuJmtORvf8QJNTxX3Lo8PCPZg2az0F15wY0CxSTZxGVDrHsgvvsfH
        BBDSpb0OHBUd4tZsK1vE/aOayz6lSpL9S6gehY0Kh3WtU2Bsb/tBoBWcMDmbcppw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Px-006Ch3-2W;
        Fri, 02 Sep 2022 16:13:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 17/27] wifi: mac80211_hwsim: fix multi-channel handling in netlink RX
Date:   Fri,  2 Sep 2022 16:12:49 +0200
Message-Id: <20220902161143.1b89d6566aa0.I01840ac7f950f5c06d5dac6c999d907dd9f7902a@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In netlink RX, now that we can actually have multiple
channel contexts for MLO, things don't work well as we
only keep a single pointer, and then on link switching
we might NULL it, and hit the return if the channel is
NULL.

However, we already use mac80211_hwsim_tx_iter() which
deals with all this, so remove the test and adjust the
remaining code a bit.

This then means we no longer use the chanctx pointer,
so remove it as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 18339a56316d..f464d3507fe9 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -653,7 +653,6 @@ struct mac80211_hwsim_data {
 	u32 ciphers[ARRAY_SIZE(hwsim_ciphers)];
 
 	struct mac_address addresses[2];
-	struct ieee80211_chanctx_conf *chanctx;
 	int channels, idx;
 	bool use_chanctx;
 	bool destroy_on_close;
@@ -2913,11 +2912,6 @@ static int mac80211_hwsim_croc(struct ieee80211_hw *hw,
 static int mac80211_hwsim_add_chanctx(struct ieee80211_hw *hw,
 				      struct ieee80211_chanctx_conf *ctx)
 {
-	struct mac80211_hwsim_data *hwsim = hw->priv;
-
-	mutex_lock(&hwsim->mutex);
-	hwsim->chanctx = ctx;
-	mutex_unlock(&hwsim->mutex);
 	hwsim_set_chanctx_magic(ctx);
 	wiphy_dbg(hw->wiphy,
 		  "add channel context control: %d MHz/width: %d/cfreqs:%d/%d MHz\n",
@@ -2929,11 +2923,6 @@ static int mac80211_hwsim_add_chanctx(struct ieee80211_hw *hw,
 static void mac80211_hwsim_remove_chanctx(struct ieee80211_hw *hw,
 					  struct ieee80211_chanctx_conf *ctx)
 {
-	struct mac80211_hwsim_data *hwsim = hw->priv;
-
-	mutex_lock(&hwsim->mutex);
-	hwsim->chanctx = NULL;
-	mutex_unlock(&hwsim->mutex);
 	wiphy_dbg(hw->wiphy,
 		  "remove channel context control: %d MHz/width: %d/cfreqs:%d/%d MHz\n",
 		  ctx->def.chan->center_freq, ctx->def.width,
@@ -2946,11 +2935,6 @@ static void mac80211_hwsim_change_chanctx(struct ieee80211_hw *hw,
 					  struct ieee80211_chanctx_conf *ctx,
 					  u32 changed)
 {
-	struct mac80211_hwsim_data *hwsim = hw->priv;
-
-	mutex_lock(&hwsim->mutex);
-	hwsim->chanctx = ctx;
-	mutex_unlock(&hwsim->mutex);
 	hwsim_check_chanctx_magic(ctx);
 	wiphy_dbg(hw->wiphy,
 		  "change channel context control: %d MHz/width: %d/cfreqs:%d/%d MHz\n",
@@ -4354,7 +4338,6 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		hw->wiphy->max_remain_on_channel_duration = 1000;
 		data->if_combination.radar_detect_widths = 0;
 		data->if_combination.num_different_channels = data->channels;
-		data->chanctx = NULL;
 	} else {
 		data->if_combination.num_different_channels = 1;
 		data->if_combination.radar_detect_widths =
@@ -4929,13 +4912,9 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	if (data2->use_chanctx) {
 		if (data2->tmp_chan)
 			channel = data2->tmp_chan;
-		else if (data2->chanctx)
-			channel = data2->chanctx->def.chan;
 	} else {
 		channel = data2->channel;
 	}
-	if (!channel)
-		goto out;
 
 	if (!hwsim_virtio_enabled) {
 		if (hwsim_net_get_netgroup(genl_info_net(info)) !=
@@ -4966,6 +4945,7 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 							  rx_status.freq);
 		if (!iter_data.channel)
 			goto out;
+		rx_status.band = iter_data.channel->band;
 
 		mutex_lock(&data2->mutex);
 		if (!hwsim_chans_compat(iter_data.channel, channel)) {
@@ -4978,11 +4958,13 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 			}
 		}
 		mutex_unlock(&data2->mutex);
+	} else if (!channel) {
+		goto out;
 	} else {
 		rx_status.freq = channel->center_freq;
+		rx_status.band = channel->band;
 	}
 
-	rx_status.band = channel->band;
 	rx_status.rate_idx = nla_get_u32(info->attrs[HWSIM_ATTR_RX_RATE]);
 	rx_status.signal = nla_get_u32(info->attrs[HWSIM_ATTR_SIGNAL]);
 
-- 
2.37.2

