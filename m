Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E4354ED75
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jun 2022 00:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378806AbiFPWmk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jun 2022 18:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377250AbiFPWmj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jun 2022 18:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755E3E5B
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jun 2022 15:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16A5B60B64
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jun 2022 22:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66586C34114;
        Thu, 16 Jun 2022 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655419355;
        bh=mRNrrO5b5BayroVsLoSBp3EFvl9j9Wt841MbL8ybe04=;
        h=From:To:Cc:Subject:Date:From;
        b=Gw6/zR2RyOK47b6Gluu9wLCTmyUOAs6rkqIuIKN/0yvU+Ufg0BlYet26ATgzsTxQj
         umTuwtt5znl8jyguXZAYsUKk0YJk2HYK9hvC7NhLH637BrUKcQYA5Pigm9Hj7SbXVf
         Fhm3TMkYF6Yng2UGU5ykY0z4G97dS99Oq01jFEiSyGmyv2639o5ulCqB/hg4dqP0ea
         KjxDzfRIiltDdIReQ2Sl/RbHfE2VC+ldgwDieA2091b3PkA0Fh2Q0zbsAlmvPhWTDr
         AjdiVFwbANl/CB4ImOPUZbAG2Fa8A/uXCQWlXe6rex0GebW5rvm3xhtquqpzGOgCYd
         X5IGj50aY3w0w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, johannes@sipsolutions.net,
        ryder.lee@mediatek.com
Subject: [PATCH wireless] mac80211: add gfp_t parameter to ieeee80211_obss_color_collision_notify
Date:   Fri, 17 Jun 2022 00:42:12 +0200
Message-Id: <02c990fb3fbd929c8548a656477d20d6c0427a13.1655419135.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce the capability to specify gfp_t parameter to
ieeee80211_obss_color_collision_notify routine since it runs in
interrupt context in ieee80211_rx_check_bss_color_collision().

Fixes: 6d945a33f2b0a ("mac80211: introduce BSS color collision detection")
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 3 ++-
 include/net/cfg80211.h                | 5 +++--
 include/net/mac80211.h                | 3 ++-
 net/mac80211/cfg.c                    | 4 ++--
 net/mac80211/rx.c                     | 3 ++-
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 84d1c7054013..7b1dc19c565e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -3822,7 +3822,8 @@ ath11k_wmi_obss_color_collision_event(struct ath11k_base *ab, struct sk_buff *sk
 
 	switch (ev->evt_type) {
 	case WMI_BSS_COLOR_COLLISION_DETECTION:
-		ieeee80211_obss_color_collision_notify(arvif->vif, ev->obss_color_bitmap);
+		ieeee80211_obss_color_collision_notify(arvif->vif, ev->obss_color_bitmap,
+						       GFP_KERNEL);
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
 			   "OBSS color collision detected vdev:%d, event:%d, bitmap:%08llx\n",
 			   ev->vdev_id, ev->evt_type, ev->obss_color_bitmap);
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6d02e12e4702..80f41446b1f0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8462,11 +8462,12 @@ int cfg80211_bss_color_notify(struct net_device *dev, gfp_t gfp,
  * cfg80211_obss_color_collision_notify - notify about bss color collision
  * @dev: network device
  * @color_bitmap: representations of the colors that the local BSS is aware of
+ * @gfp: allocation flags
  */
 static inline int cfg80211_obss_color_collision_notify(struct net_device *dev,
-						       u64 color_bitmap)
+						       u64 color_bitmap, gfp_t gfp)
 {
-	return cfg80211_bss_color_notify(dev, GFP_KERNEL,
+	return cfg80211_bss_color_notify(dev, gfp,
 					 NL80211_CMD_OBSS_COLOR_COLLISION,
 					 0, color_bitmap);
 }
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ebadb2103968..47642b020706 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6960,10 +6960,11 @@ ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  * @color_bitmap: a 64 bit bitmap representing the colors that the local BSS is
  *	aware of.
+ * @gfp: allocation flags
  */
 void
 ieeee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
-				       u64 color_bitmap);
+				       u64 color_bitmap, gfp_t gfp);
 
 /**
  * ieee80211_is_tx_data - check if frame is a data frame
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f7896f257e1b..4ddf297f40f2 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4468,14 +4468,14 @@ EXPORT_SYMBOL_GPL(ieee80211_color_change_finish);
 
 void
 ieeee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
-				       u64 color_bitmap)
+				       u64 color_bitmap, gfp_t gfp)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 
 	if (sdata->vif.color_change_active || sdata->vif.csa_active)
 		return;
 
-	cfg80211_obss_color_collision_notify(sdata->dev, color_bitmap);
+	cfg80211_obss_color_collision_notify(sdata->dev, color_bitmap, gfp);
 }
 EXPORT_SYMBOL_GPL(ieeee80211_obss_color_collision_notify);
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 3c08ae04ddbc..1675f8cb87f1 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3217,7 +3217,8 @@ ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);
 		if (color == bss_conf->he_bss_color.color)
 			ieeee80211_obss_color_collision_notify(&rx->sdata->vif,
-							       BIT_ULL(color));
+							       BIT_ULL(color),
+							       GFP_ATOMIC);
 	}
 }
 
-- 
2.36.1

