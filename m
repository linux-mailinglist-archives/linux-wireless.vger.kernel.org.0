Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930F6573372
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiGMJrD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiGMJpn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741E7F8954
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OVrJulzdmv+xJljI8iz3ZIxHw22zhSRRT79cUraY90U=;
        t=1657705532; x=1658915132; b=rZ5plagr9ZzNAyrLxLiCugjRiAQMNGvoD4A+5dMMPfqza1F
        OnxEi6BXLAdonvLPY+Gxd+LGrgqeRekpQOdcFEKKg5OqIvfoBsndUMi9GbNNfEXfgF740X5Q3HEQa
        5DCLMf1Nuv0ypCS8qXOvp8WCCKSmuFAg7Mh4yVdN6wZBbPciMg1LLbVqPoNrTOQBILpLjIbUbCwB9
        xudEAO0pBdstYBf5pZoU4EPZ3HsZQ6emaxmtQy9ZHYIWZfMubKy5iIkfWw6wjY8zXlvhf+6VMTY+r
        rU2faHZfixTG2XRUUyYf3/Se9cJOdF7nGwMSRFPTGBZVw++X81jjGZ/fwEp6UJOA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvy-00EgvB-Et;
        Wed, 13 Jul 2022 11:45:30 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 75/76] wifi: mac80211: remove link_id parameter from link_info_changed()
Date:   Wed, 13 Jul 2022 11:45:01 +0200
Message-Id: <20220713114426.8d57960ab08d.I6ffcc698ba8404ba06a21ffd52df205677b93722@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Since struct ieee80211_bss_conf already contains link_id,
passing link_id is not necessary.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 3 ++-
 include/net/mac80211.h                | 1 -
 net/mac80211/driver-ops.h             | 4 ++--
 net/mac80211/main.c                   | 5 ++---
 net/mac80211/trace.h                  | 6 +++---
 5 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 715661298f2a..adadd03c50e4 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2178,10 +2178,11 @@ static void mac80211_hwsim_vif_info_changed(struct ieee80211_hw *hw,
 static void mac80211_hwsim_link_info_changed(struct ieee80211_hw *hw,
 					     struct ieee80211_vif *vif,
 					     struct ieee80211_bss_conf *info,
-					     u32 link_id, u64 changed)
+					     u64 changed)
 {
 	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
 	struct mac80211_hwsim_data *data = hw->priv;
+	unsigned int link_id = info->link_id;
 	struct mac80211_hwsim_link_data *link_data = &data->link_data[link_id];
 
 	hwsim_check_magic(vif);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 6e5e0708cfff..8a69ef867e87 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4088,7 +4088,6 @@ struct ieee80211_ops {
 	void (*link_info_changed)(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_bss_conf *info,
-				  unsigned int link_id,
 				  u64 changed);
 
 	int (*start_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 0f06081c68ca..482f5c97a72b 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -190,10 +190,10 @@ static inline void drv_link_info_changed(struct ieee80211_local *local,
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-	trace_drv_link_info_changed(local, sdata, info, link_id, changed);
+	trace_drv_link_info_changed(local, sdata, info, changed);
 	if (local->ops->link_info_changed)
 		local->ops->link_info_changed(&local->hw, &sdata->vif,
-					      info, link_id, changed);
+					      info, changed);
 	else if (local->ops->bss_info_changed)
 		local->ops->bss_info_changed(&local->hw, &sdata->vif,
 					     info, changed);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 8d5b18318b20..26bb30606282 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -248,11 +248,10 @@ void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 
 		/* FIXME: should be for each link */
 		trace_drv_link_info_changed(local, sdata, &sdata->vif.bss_conf,
-					    0, changed);
+					    changed);
 		if (local->ops->link_info_changed)
 			local->ops->link_info_changed(&local->hw, &sdata->vif,
-						      &sdata->vif.bss_conf,
-						      0, ch);
+						      &sdata->vif.bss_conf, ch);
 	}
 
 	if (local->ops->bss_info_changed)
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 402110f439f8..9f4377566c42 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -449,9 +449,9 @@ TRACE_EVENT(drv_link_info_changed,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
 		 struct ieee80211_bss_conf *link_conf,
-		 int link_id, u64 changed),
+		 u64 changed),
 
-	TP_ARGS(local, sdata, link_conf, link_id, changed),
+	TP_ARGS(local, sdata, link_conf, changed),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
@@ -486,7 +486,7 @@ TRACE_EVENT(drv_link_info_changed,
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		__entry->changed = changed;
-		__entry->link_id = link_id;
+		__entry->link_id = link_conf->link_id;
 		__entry->shortpre = link_conf->use_short_preamble;
 		__entry->cts = link_conf->use_cts_prot;
 		__entry->shortslot = link_conf->use_short_slot;
-- 
2.36.1

