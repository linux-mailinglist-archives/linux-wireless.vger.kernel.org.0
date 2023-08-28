Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F255D78AF92
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjH1MGN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjH1MFl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82013D
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mYtM32ObzMz/XKHnCCgMOKNqjyjJDvR49u/dHleXFeU=;
        t=1693224338; x=1694433938; b=kZUF5GWhhxRq2ygXB8cEDGWjsqpCVYEnrnB45wdlNDO9J4S
        30xN0+h29uSOkxYaQ9Z1rwnX0cMRNw/7P+wKjkS/ie850U0lR/PlI3sTOVcoDkQC/Qm/9CviwwPpx
        QoF2UEJl/lyU0KJz+5zHcgasQTosJKspVJ//CfXvNp9tB1xY4x3CBEYXtrHBhuB9Frs5HghsEu9NS
        ZjOYrgY5O7VFPJhm4IjmOhN73bPps0BMZ+eVNNBKezI17Kf9TYT9ikuoW9V88GlB+dLv8Cxz6VymT
        sxJ2OzoX9ksIL7KbuRO816Y66gr5NLizZzhPqbrMDqktYLkb4Ke3uxW+LqSuM0Ig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazw-00Gjgt-15;
        Mon, 28 Aug 2023 14:05:36 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 20/40] wifi: mac80211: move tspec work to wiphy work
Date:   Mon, 28 Aug 2023 13:59:48 +0200
Message-ID: <20230828135928.1786affceefa.I80a963e0788188502cfdd6cd8cf7307eae9ae14b@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

One more work that will now execute with the wiphy
locked, for future cleanups.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mlme.c        | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index c5a414b1fd0a..34f528f7c13e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -550,7 +550,7 @@ struct ieee80211_if_managed {
 	 * on the BE queue, but there's a lot of VO traffic, we might
 	 * get stuck in a downgraded situation and flush takes forever.
 	 */
-	struct delayed_work tx_tspec_wk;
+	struct wiphy_delayed_work tx_tspec_wk;
 
 	/* Information elements from the last transmitted (Re)Association
 	 * Request frame.
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f5544d94efcb..a35769dac162 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2489,8 +2489,10 @@ __ieee80211_sta_handle_tspec_ac_params(struct ieee80211_sub_if_data *sdata)
 					 ac);
 			tx_tspec->action = TX_TSPEC_ACTION_NONE;
 			ret = true;
-			schedule_delayed_work(&ifmgd->tx_tspec_wk,
-				tx_tspec->time_slice_start + HZ - now + 1);
+			wiphy_delayed_work_queue(local->hw.wiphy,
+						 &ifmgd->tx_tspec_wk,
+						 tx_tspec->time_slice_start +
+						 HZ - now + 1);
 			break;
 		case TX_TSPEC_ACTION_NONE:
 			/* nothing now */
@@ -2508,7 +2510,8 @@ void ieee80211_sta_handle_tspec_ac_params(struct ieee80211_sub_if_data *sdata)
 						  BSS_CHANGED_QOS);
 }
 
-static void ieee80211_sta_handle_tspec_ac_params_wk(struct work_struct *work)
+static void ieee80211_sta_handle_tspec_ac_params_wk(struct wiphy *wiphy,
+						    struct wiphy_work *work)
 {
 	struct ieee80211_sub_if_data *sdata;
 
@@ -3060,7 +3063,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	/* existing TX TSPEC sessions no longer exist */
 	memset(ifmgd->tx_tspec, 0, sizeof(ifmgd->tx_tspec));
-	cancel_delayed_work_sync(&ifmgd->tx_tspec_wk);
+	wiphy_delayed_work_cancel(local->hw.wiphy, &ifmgd->tx_tspec_wk);
 
 	sdata->vif.bss_conf.pwr_reduction = 0;
 	sdata->vif.bss_conf.tx_pwr_env_num = 0;
@@ -3128,7 +3131,8 @@ static void ieee80211_sta_tx_wmm_ac_notify(struct ieee80211_sub_if_data *sdata,
 
 		if (tx_tspec->downgraded) {
 			tx_tspec->action = TX_TSPEC_ACTION_STOP_DOWNGRADE;
-			schedule_delayed_work(&ifmgd->tx_tspec_wk, 0);
+			wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+						 &ifmgd->tx_tspec_wk, 0);
 		}
 	}
 
@@ -3140,7 +3144,8 @@ static void ieee80211_sta_tx_wmm_ac_notify(struct ieee80211_sub_if_data *sdata,
 	if (tx_tspec->consumed_tx_time >= tx_tspec->admitted_time) {
 		tx_tspec->downgraded = true;
 		tx_tspec->action = TX_TSPEC_ACTION_DOWNGRADE;
-		schedule_delayed_work(&ifmgd->tx_tspec_wk, 0);
+		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+					 &ifmgd->tx_tspec_wk, 0);
 	}
 }
 
@@ -6837,8 +6842,8 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	timer_setup(&ifmgd->timer, ieee80211_sta_timer, 0);
 	timer_setup(&ifmgd->bcn_mon_timer, ieee80211_sta_bcn_mon_timer, 0);
 	timer_setup(&ifmgd->conn_mon_timer, ieee80211_sta_conn_mon_timer, 0);
-	INIT_DELAYED_WORK(&ifmgd->tx_tspec_wk,
-			  ieee80211_sta_handle_tspec_ac_params_wk);
+	wiphy_delayed_work_init(&ifmgd->tx_tspec_wk,
+				ieee80211_sta_handle_tspec_ac_params_wk);
 
 	ifmgd->flags = 0;
 	ifmgd->powersave = sdata->wdev.ps;
-- 
2.41.0

