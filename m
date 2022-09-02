Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F9A5AB438
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbiIBOvp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbiIBOvH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956ABC103
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qk0IOSsBtizzp4wwm5hGHvqO/Th8CSjUSMGoCjNcRTs=;
        t=1662127991; x=1663337591; b=yFw8CdUYKyTRS/mlf5tIcwj7gCuBvIli8nSTXAOMa9Ga9A6
        oxCXICkM93tgtQZfVF7V0AZdNSejbNWyVVUbkgQcAhfy0LgUzIXi/aQ/y5FIYsvb6zZK60PjgiTKQ
        2IAWX+hkmyUdCYfPdoB/noc/vBpKtw+0NHCNOodDUbuMlc+6Q4SDSrGhfVPJFz7qyrhzFXhqKTkZq
        wniXXy/V1FxNvYSSE3ERToYx2RZQ2MGmDnAOIdlHHj2xUY8SKmE3Og8hNZphobBbRvfxhlKAwu5pE
        T9xKnTmiM0yg3/h12fRT/z0+RJ0PsI0qmiUOLCW0s+Jopm4q1CwjTHULIt261xPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Px-006Ch3-0j;
        Fri, 02 Sep 2022 16:13:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/27] wifi: mac80211: extend ieee80211_nullfunc_get() for MLO
Date:   Fri,  2 Sep 2022 16:12:47 +0200
Message-Id: <20220902161143.5c355f56ae0e.I0dfa6e8c5e2e4f8715aed9e47c4e4ca739c28430@changeid>
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

Add a link_id parameter to ieee80211_nullfunc_get() to be
able to obtain a correctly addressed frame.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath9k/channel.c |  2 +-
 drivers/net/wireless/realtek/rtw88/fw.c  |  4 +--
 drivers/net/wireless/st/cw1200/sta.c     |  4 +--
 drivers/net/wireless/ti/wl1251/main.c    |  2 +-
 drivers/net/wireless/ti/wlcore/cmd.c     |  4 +--
 include/net/mac80211.h                   |  5 ++-
 net/mac80211/mlme.c                      |  5 +--
 net/mac80211/tx.c                        | 43 +++++++++++++++---------
 8 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wireless/ath/ath9k/channel.c
index 6cf087522157..571062f2e82a 100644
--- a/drivers/net/wireless/ath/ath9k/channel.c
+++ b/drivers/net/wireless/ath/ath9k/channel.c
@@ -1113,7 +1113,7 @@ ath_chanctx_send_vif_ps_frame(struct ath_softc *sc, struct ath_vif *avp,
 		if (!avp->assoc)
 			return false;
 
-		skb = ieee80211_nullfunc_get(sc->hw, vif, false);
+		skb = ieee80211_nullfunc_get(sc->hw, vif, -1, false);
 		if (!skb)
 			return false;
 
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index babba68a7132..7f6fdebae203 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1082,10 +1082,10 @@ static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
 		skb_new = ieee80211_proberesp_get(hw, vif);
 		break;
 	case RSVD_NULL:
-		skb_new = ieee80211_nullfunc_get(hw, vif, false);
+		skb_new = ieee80211_nullfunc_get(hw, vif, -1, false);
 		break;
 	case RSVD_QOS_NULL:
-		skb_new = ieee80211_nullfunc_get(hw, vif, true);
+		skb_new = ieee80211_nullfunc_get(hw, vif, -1, true);
 		break;
 	case RSVD_LPS_PG_DPK:
 		skb_new = rtw_lps_pg_dpk_get(hw);
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index 26d3614519b1..8ef1d06b9bbd 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -195,7 +195,7 @@ void __cw1200_cqm_bssloss_sm(struct cw1200_common *priv,
 
 		priv->bss_loss_state++;
 
-		skb = ieee80211_nullfunc_get(priv->hw, priv->vif, false);
+		skb = ieee80211_nullfunc_get(priv->hw, priv->vif, -1, false);
 		WARN_ON(!skb);
 		if (skb)
 			cw1200_tx(priv->hw, NULL, skb);
@@ -2263,7 +2263,7 @@ static int cw1200_upload_null(struct cw1200_common *priv)
 		.rate = 0xFF,
 	};
 
-	frame.skb = ieee80211_nullfunc_get(priv->hw, priv->vif, false);
+	frame.skb = ieee80211_nullfunc_get(priv->hw, priv->vif,-1, false);
 	if (!frame.skb)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index 9144ef5538a8..289371689a8d 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -546,7 +546,7 @@ static int wl1251_build_null_data(struct wl1251 *wl)
 		size = sizeof(struct wl12xx_null_data_template);
 		ptr = NULL;
 	} else {
-		skb = ieee80211_nullfunc_get(wl->hw, wl->vif, false);
+		skb = ieee80211_nullfunc_get(wl->hw, wl->vif, -1, false);
 		if (!skb)
 			goto out;
 		size = skb->len;
diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index 138edd28b0de..a939fd89a7f5 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -1065,7 +1065,7 @@ int wl12xx_cmd_build_null_data(struct wl1271 *wl, struct wl12xx_vif *wlvif)
 	} else {
 		skb = ieee80211_nullfunc_get(wl->hw,
 					     wl12xx_wlvif_to_vif(wlvif),
-					     false);
+					     -1, false);
 		if (!skb)
 			goto out;
 		size = skb->len;
@@ -1092,7 +1092,7 @@ int wl12xx_cmd_build_klv_null_data(struct wl1271 *wl,
 	struct sk_buff *skb = NULL;
 	int ret = -ENOMEM;
 
-	skb = ieee80211_nullfunc_get(wl->hw, vif, false);
+	skb = ieee80211_nullfunc_get(wl->hw, vif,-1, false);
 	if (!skb)
 		goto out;
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 954cc029a9f9..bfa6a1625c5c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5298,6 +5298,9 @@ struct sk_buff *ieee80211_pspoll_get(struct ieee80211_hw *hw,
  * ieee80211_nullfunc_get - retrieve a nullfunc template
  * @hw: pointer obtained from ieee80211_alloc_hw().
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @link_id: If the vif is an MLD, get a frame with the link addresses
+ *	for the given link ID. For a link_id < 0 you get a frame with
+ *	MLD addresses, however useful that might be.
  * @qos_ok: QoS NDP is acceptable to the caller, this should be set
  *	if at all possible
  *
@@ -5315,7 +5318,7 @@ struct sk_buff *ieee80211_pspoll_get(struct ieee80211_hw *hw,
  */
 struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
-				       bool qos_ok);
+				       int link_id, bool qos_ok);
 
 /**
  * ieee80211_probereq_get - retrieve a Probe Request template
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index bbc62815b067..bf883f2e6de3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1546,8 +1546,9 @@ void ieee80211_send_nullfunc(struct ieee80211_local *local,
 	struct ieee80211_hdr_3addr *nullfunc;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
-	skb = ieee80211_nullfunc_get(&local->hw, &sdata->vif,
-		!ieee80211_hw_check(&local->hw, DOESNT_SUPPORT_QOS_NDP));
+	skb = ieee80211_nullfunc_get(&local->hw, &sdata->vif, -1,
+				     !ieee80211_hw_check(&local->hw,
+							 DOESNT_SUPPORT_QOS_NDP));
 	if (!skb)
 		return;
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 51d564c8742b..30293e49e444 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5469,33 +5469,39 @@ EXPORT_SYMBOL(ieee80211_pspoll_get);
 
 struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
-				       bool qos_ok)
+				       int link_id, bool qos_ok)
 {
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_link_data *link = NULL;
 	struct ieee80211_hdr_3addr *nullfunc;
-	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_local *local;
 	struct sk_buff *skb;
 	bool qos = false;
 
 	if (WARN_ON(vif->type != NL80211_IFTYPE_STATION))
 		return NULL;
 
-	sdata = vif_to_sdata(vif);
-	local = sdata->local;
+	skb = dev_alloc_skb(local->hw.extra_tx_headroom +
+			    sizeof(*nullfunc) + 2);
+	if (!skb)
+		return NULL;
 
+	rcu_read_lock();
 	if (qos_ok) {
 		struct sta_info *sta;
 
-		rcu_read_lock();
-		sta = sta_info_get(sdata, sdata->deflink.u.mgd.bssid);
+		sta = sta_info_get(sdata, vif->cfg.ap_addr);
 		qos = sta && sta->sta.wme;
-		rcu_read_unlock();
 	}
 
-	skb = dev_alloc_skb(local->hw.extra_tx_headroom +
-			    sizeof(*nullfunc) + 2);
-	if (!skb)
-		return NULL;
+	if (link_id >= 0) {
+		link = rcu_dereference(sdata->link[link_id]);
+		if (WARN_ON_ONCE(!link)) {
+			rcu_read_unlock();
+			kfree_skb(skb);
+			return NULL;
+		}
+	}
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
 
@@ -5516,9 +5522,16 @@ struct sk_buff *ieee80211_nullfunc_get(struct ieee80211_hw *hw,
 		skb_put_data(skb, &qoshdr, sizeof(qoshdr));
 	}
 
-	memcpy(nullfunc->addr1, sdata->deflink.u.mgd.bssid, ETH_ALEN);
-	memcpy(nullfunc->addr2, vif->addr, ETH_ALEN);
-	memcpy(nullfunc->addr3, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+	if (link) {
+		memcpy(nullfunc->addr1, link->conf->bssid, ETH_ALEN);
+		memcpy(nullfunc->addr2, link->conf->addr, ETH_ALEN);
+		memcpy(nullfunc->addr3, link->conf->bssid, ETH_ALEN);
+	} else {
+		memcpy(nullfunc->addr1, vif->cfg.ap_addr, ETH_ALEN);
+		memcpy(nullfunc->addr2, vif->addr, ETH_ALEN);
+		memcpy(nullfunc->addr3, vif->cfg.ap_addr, ETH_ALEN);
+	}
+	rcu_read_unlock();
 
 	return skb;
 }
-- 
2.37.2

