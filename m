Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7A7539E8C
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbiFAHkP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbiFAHkH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA29986FC
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=E6FxAdZRwnU0x/21mdftxr8Qq1+/Updvrs2CtRpUQ/0=;
        t=1654069206; x=1655278806; b=t6R2g+aDtFF+AfyT5nCv4stwi0ozl96tjY2J7HJJ6pswqum
        4/tBJFNlmZNmmQpiNxTupCLVwbDmfEhH0ukQGVTWsTyLsigNevvvjIQhHuvgKoU08BXLk7RpJ3vq7
        APxiha6DibDdDOE7svD3ziidxlyywcSOD/jZrHphI7AbFzIDVSl4G+CA8WP/8UVusYbk7mOkuKmJ9
        HnjPYhwq1v9g4kNuB70tgTWLG2m/OSQTyJv1u4t4g+0By6ehgmmLfPOJyY+WqiLU9Ao3DTI/2yxxD
        ISDlrpArHrzUzQy8Sn8i9q/VeWjb5mHIC/3lKc/L9TjdlpUnOJVPHC5eY/rj2csQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxX-00AJPK-Mo;
        Wed, 01 Jun 2022 09:40:03 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/15] mac80211: refactor some link setup code
Date:   Wed,  1 Jun 2022 09:39:52 +0200
Message-Id: <20220601093922.b3ae44127aae.If9fc716c4b91c31f74eb549757405a7f4b0f4236@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601073958.8345-1-johannes@sipsolutions.net>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
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

We don't need to setup lists and work structs every time
we switch the interface type, factor that out into a new
ieee80211_link_init() function and use it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 1764068a18d1..fa684d76a169 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1012,6 +1012,27 @@ static void ieee80211_set_default_queues(struct ieee80211_sub_if_data *sdata)
 	sdata->vif.cab_queue = IEEE80211_INVAL_HW_QUEUE;
 }
 
+static void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
+				unsigned int link_id,
+				struct ieee80211_link_data *link,
+				struct ieee80211_bss_conf *link_conf)
+{
+	sdata->vif.link_conf[link_id] = link_conf;
+	sdata->link[link_id] = link;
+
+	link->sdata = sdata;
+	link->link_id = link_id;
+
+	INIT_WORK(&link->csa_finalize_work,
+		  ieee80211_csa_finalize_work);
+	INIT_WORK(&link->color_change_finalize_work,
+		  ieee80211_color_change_finalize_work);
+	INIT_LIST_HEAD(&link->assigned_chanctx_list);
+	INIT_LIST_HEAD(&link->reserved_chanctx_list);
+	INIT_DELAYED_WORK(&link->dfs_cac_timer_work,
+			  ieee80211_dfs_cac_timer_work);
+}
+
 static void ieee80211_sdata_init(struct ieee80211_local *local,
 				 struct ieee80211_sub_if_data *sdata)
 {
@@ -1025,9 +1046,7 @@ static void ieee80211_sdata_init(struct ieee80211_local *local,
 	 * Note that we never change this, so if link ID 0 isn't used in an
 	 * MLD connection, we get a separate allocation for it.
 	 */
-	sdata->vif.link_conf[0] = &sdata->vif.bss_conf;
-	sdata->link[0] = &sdata->deflink;
-	sdata->deflink.sdata = sdata;
+	ieee80211_link_init(sdata, 0, &sdata->deflink, &sdata->vif.bss_conf);
 }
 
 int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
@@ -1678,12 +1697,6 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	skb_queue_head_init(&sdata->status_queue);
 	INIT_WORK(&sdata->work, ieee80211_iface_work);
 	INIT_WORK(&sdata->recalc_smps, ieee80211_recalc_smps_work);
-	INIT_WORK(&sdata->deflink.csa_finalize_work,
-		  ieee80211_csa_finalize_work);
-	INIT_WORK(&sdata->deflink.color_change_finalize_work,
-		  ieee80211_color_change_finalize_work);
-	INIT_LIST_HEAD(&sdata->deflink.assigned_chanctx_list);
-	INIT_LIST_HEAD(&sdata->deflink.reserved_chanctx_list);
 
 	switch (type) {
 	case NL80211_IFTYPE_P2P_GO:
@@ -2100,8 +2113,6 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 	INIT_LIST_HEAD(&sdata->key_list);
 
-	INIT_DELAYED_WORK(&sdata->deflink.dfs_cac_timer_work,
-			  ieee80211_dfs_cac_timer_work);
 	INIT_DELAYED_WORK(&sdata->dec_tailroom_needed_wk,
 			  ieee80211_delayed_tailroom_dec);
 
-- 
2.36.1

