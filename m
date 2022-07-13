Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086C9573A3B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiGMPe5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbiGMPep (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20AE3E759
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tSv1WmBbVAdt4ofDkoF1Oqmtk2vFmui+wpujQYU3ehw=;
        t=1657726484; x=1658936084; b=RQrxiTTuIsH9JCiM9EAoy55YfofyfKOOlgUrHkh12lO7twJ
        WLhu1SLxbjQTjft096Ixt7EpFWk5hkYRSVidE2F41r8nxqIGOGjripO3Z7rskqJbu3719wXEG1v8B
        r5izMFgsNQIabWqtIT2QuNREOwiLRVXCFCe+zt64UuJUxIa3E8sjP7bhJthxBgxXatwIa9QiTR7BC
        ObIPhZ5NZNY78uyaHFSZF0dTkorc/cGV6jvajeCXHv9qwPeJAwEizbKr0mgDd8ufjWQfl3jj/zjn5
        TL3eqsdrY40Ufb1NREErW6hAKsam0zcI6vLHo8PYUaJVhzY3T7QQu5KPciuR/Tcg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNu-00EnaA-J7;
        Wed, 13 Jul 2022 17:34:42 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 21/21] wifi: mac80211: mlme: refactor ieee80211_set_associated()
Date:   Wed, 13 Jul 2022 17:34:33 +0200
Message-Id: <20220713173301.98639a6d390e.I9562d40805f25728f9ac08102f91f202e198a590@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
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

Split out much of the code in ieee80211_set_associated()
into a new ieee80211_link_set_associated() which can be
called per link later for MLO.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 67 +++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0614712236de..d8e0ca4b316f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2387,29 +2387,27 @@ static u32 ieee80211_handle_bss_capability(struct ieee80211_link_data *link,
 	return changed;
 }
 
-static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
-				     struct cfg80211_bss *cbss,
-				     u32 bss_info_changed)
+static u32 ieee80211_link_set_associated(struct ieee80211_link_data *link,
+					 struct cfg80211_bss *cbss)
 {
-	struct ieee80211_bss *bss = (void *)cbss->priv;
-	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_link_data *link = &sdata->deflink;
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_bss_conf *bss_conf = link->conf;
-	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
+	struct ieee80211_bss *bss = (void *)cbss->priv;
+	u32 changed = 0;
 
-	bss_info_changed |= BSS_CHANGED_ASSOC;
-	bss_info_changed |= ieee80211_handle_bss_capability(link,
-		bss_conf->assoc_capability, bss->has_erp_value, bss->erp_value);
+	sdata->u.mgd.beacon_timeout =
+		usecs_to_jiffies(ieee80211_tu_to_usec(beacon_loss_count *
+						      bss_conf->beacon_int));
 
-	sdata->u.mgd.beacon_timeout = usecs_to_jiffies(ieee80211_tu_to_usec(
-		beacon_loss_count * bss_conf->beacon_int));
+	changed |= ieee80211_handle_bss_capability(link,
+						   bss_conf->assoc_capability,
+						   bss->has_erp_value,
+						   bss->erp_value);
+
+	ieee80211_check_rate_mask(link);
 
-	sdata->u.mgd.associated = true;
 	link->u.mgd.bss = cbss;
 	memcpy(link->u.mgd.bssid, cbss->bssid, ETH_ALEN);
-	memcpy(sdata->vif.cfg.ap_addr, cbss->bssid, ETH_ALEN);
-
-	ieee80211_check_rate_mask(link);
 
 	if (sdata->vif.p2p ||
 	    sdata->vif.driver_flags & IEEE80211_VIF_GET_NOA_UPDATE) {
@@ -2428,17 +2426,12 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 			if (ret >= 2) {
 				link->u.mgd.p2p_noa_index =
 					bss_conf->p2p_noa_attr.index;
-				bss_info_changed |= BSS_CHANGED_P2P_PS;
+				changed |= BSS_CHANGED_P2P_PS;
 			}
 		}
 		rcu_read_unlock();
 	}
 
-	/* just to be sure */
-	ieee80211_stop_poll(sdata);
-
-	ieee80211_led_assoc(local, 1);
-
 	if (link->u.mgd.have_beacon) {
 		/*
 		 * If the AP is buggy we may get here with no DTIM period
@@ -2448,18 +2441,40 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 		 */
 		bss_conf->dtim_period = link->u.mgd.dtim_period ?: 1;
 		bss_conf->beacon_rate = bss->beacon_rate;
-		bss_info_changed |= BSS_CHANGED_BEACON_INFO;
+		changed |= BSS_CHANGED_BEACON_INFO;
 	} else {
 		bss_conf->beacon_rate = NULL;
 		bss_conf->dtim_period = 0;
 	}
 
-	vif_cfg->assoc = 1;
-
 	/* Tell the driver to monitor connection quality (if supported) */
 	if (sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI &&
 	    bss_conf->cqm_rssi_thold)
-		bss_info_changed |= BSS_CHANGED_CQM;
+		changed |= BSS_CHANGED_CQM;
+
+	return changed;
+}
+
+static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
+				     struct cfg80211_bss *cbss,
+				     u32 bss_info_changed)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_link_data *link = &sdata->deflink;
+	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
+
+	bss_info_changed |= BSS_CHANGED_ASSOC;
+	bss_info_changed |= ieee80211_link_set_associated(link, cbss);
+
+	sdata->u.mgd.associated = true;
+	memcpy(sdata->vif.cfg.ap_addr, cbss->bssid, ETH_ALEN);
+
+	/* just to be sure */
+	ieee80211_stop_poll(sdata);
+
+	ieee80211_led_assoc(local, 1);
+
+	vif_cfg->assoc = 1;
 
 	/* Enable ARP filtering */
 	if (vif_cfg->arp_addr_cnt)
-- 
2.36.1

