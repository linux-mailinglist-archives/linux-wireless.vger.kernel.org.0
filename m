Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C374AF3D4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 15:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiBIONw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 09:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiBIONv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 09:13:51 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA453C0613CA
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 06:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644416035; x=1675952035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SgfZoTpbJ+vtHHH9nljdF4CZCvNCNBdsIY/wBkAgJns=;
  b=iIaKHhfZeBRWQXGfAf3MVmycpaKPr/YdXjxgeQSTh3qWciXUdukOeNfH
   0WaSpln71aGwIM9ZAZlBHrXTPFHompFkX0DOystb/D9J1RgcaQ7bHrWcT
   Lfe4IUaJOZfKhwtJ96mmhytl6CLC9Taw7tNZpXZvt13SpD4sJYptNvQwB
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 Feb 2022 06:13:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 06:13:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 06:13:53 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 06:13:52 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCH 2/2] ath11k: fix radar detection in 160 Mhz
Date:   Wed, 9 Feb 2022 19:43:39 +0530
Message-ID: <1644416019-820-2-git-send-email-quic_vnaralas@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644416019-820-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1644416019-820-1-git-send-email-quic_vnaralas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Radar detection fails in the secondary 80 MHz when the
the AP's primary 80 MHz is in non-DFS region in 160 MHz.

This is due to WMI channel flag WMI_CHAN_INFO_DFS_FREQ2 is not set
properly in case of the primary 80 MHz is in non-DFS region.
HALPHY detects the radar pulses in the secondary 80 MHz only when
WMI_CHAN_INFO_DFS_FREQ2 is set.

Fix this issue by setting WMI channel flag WMI_CHAN_INFO_DFS_FREQ2
based on the radar_enabled flag from the channel context.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d5922a0..68754e9 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6630,12 +6630,13 @@ static void ath11k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 
 static int
 ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
-			      const struct cfg80211_chan_def *chandef,
+			      struct ieee80211_chanctx_conf *ctx,
 			      bool restart)
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_base *ab = ar->ab;
 	struct wmi_vdev_start_req_arg arg = {};
+	const struct cfg80211_chan_def *chandef = &ctx->def;
 	int he_support = arvif->vif->bss_conf.he_support;
 	int ret = 0;
 
@@ -6670,8 +6671,7 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 		arg.channel.chan_radar =
 			!!(chandef->chan->flags & IEEE80211_CHAN_RADAR);
 
-		arg.channel.freq2_radar =
-			!!(chandef->chan->flags & IEEE80211_CHAN_RADAR);
+		arg.channel.freq2_radar = ctx->radar_enabled;
 
 		arg.channel.passive = arg.channel.chan_radar;
 
@@ -6781,15 +6781,15 @@ static int ath11k_mac_vdev_stop(struct ath11k_vif *arvif)
 }
 
 static int ath11k_mac_vdev_start(struct ath11k_vif *arvif,
-				 const struct cfg80211_chan_def *chandef)
+				 struct ieee80211_chanctx_conf *ctx)
 {
-	return ath11k_mac_vdev_start_restart(arvif, chandef, false);
+	return ath11k_mac_vdev_start_restart(arvif, ctx, false);
 }
 
 static int ath11k_mac_vdev_restart(struct ath11k_vif *arvif,
-				   const struct cfg80211_chan_def *chandef)
+				   struct ieee80211_chanctx_conf *ctx)
 {
-	return ath11k_mac_vdev_start_restart(arvif, chandef, true);
+	return ath11k_mac_vdev_start_restart(arvif, ctx, true);
 }
 
 struct ath11k_mac_change_chanctx_arg {
@@ -6864,7 +6864,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 		 * If vdev is down then it expect vdev_stop->vdev_start.
 		 */
 		if (arvif->is_up) {
-			ret = ath11k_mac_vdev_restart(arvif, &vifs[i].new_ctx->def);
+			ret = ath11k_mac_vdev_restart(arvif, vifs[i].new_ctx);
 			if (ret) {
 				ath11k_warn(ab, "failed to restart vdev %d: %d\n",
 					    arvif->vdev_id, ret);
@@ -6878,7 +6878,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 				continue;
 			}
 
-			ret = ath11k_mac_vdev_start(arvif, &vifs[i].new_ctx->def);
+			ret = ath11k_mac_vdev_start(arvif, vifs[i].new_ctx);
 			if (ret)
 				ath11k_warn(ab, "failed to start vdev %d: %d\n",
 					    arvif->vdev_id, ret);
@@ -6967,7 +6967,8 @@ static void ath11k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 	if (WARN_ON(changed & IEEE80211_CHANCTX_CHANGE_CHANNEL))
 		goto unlock;
 
-	if (changed & IEEE80211_CHANCTX_CHANGE_WIDTH)
+	if (changed & IEEE80211_CHANCTX_CHANGE_WIDTH ||
+	    changed & IEEE80211_CHANCTX_CHANGE_RADAR)
 		ath11k_mac_update_active_vif_chan(ar, ctx);
 
 	/* TODO: Recalc radar detection */
@@ -6987,7 +6988,7 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 	if (WARN_ON(arvif->is_started))
 		return -EBUSY;
 
-	ret = ath11k_mac_vdev_start(arvif, &arvif->chanctx.def);
+	ret = ath11k_mac_vdev_start(arvif, &arvif->chanctx);
 	if (ret) {
 		ath11k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
 			    arvif->vdev_id, vif->addr,
@@ -7081,7 +7082,7 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		goto out;
 	}
 
-	ret = ath11k_mac_vdev_start(arvif, &ctx->def);
+	ret = ath11k_mac_vdev_start(arvif, ctx);
 	if (ret) {
 		ath11k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
 			    arvif->vdev_id, vif->addr,
-- 
2.7.4

