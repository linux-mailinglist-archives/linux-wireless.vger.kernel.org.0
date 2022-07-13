Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F5B573326
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiGMJpO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiGMJpK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B73DBEB6C
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=n8SRNHKPwsrGiRMgove15knSSHCRuB3cvIAveckcbvo=;
        t=1657705508; x=1658915108; b=yDri8ZZsrG5suwcRkzbA4z9ZiSQ1MEUEF3D9bqhApkgqAxR
        kAwf6afIOPGf2H9U7QWVs+PSzr6Dy/jJiBwXquWeqH52xTz9UZWyQJO+aGeyi5cCR+oIzAX8kb0VY
        24lYrnFfELJcF9zhMw2tOwDwQjXQ9huTSgGHBj8vYH0wI7m7umqimrTcm8dOa6wHXe8+px3mdVQMM
        nAN3eShQW9OKesRsIt+6WXTqGh3d14YNdt6fl3oQoGPTz3+VDiZzQdTg3dmSQwuTzpiIOSLd7alXL
        y6xZcXhjd0Z1dq7UwlrU9IsRDU8sag8X5sjNjBP2vIZDj2p0Mg/iwOyOI5ZOWnOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvZ-00EgvB-BN;
        Wed, 13 Jul 2022 11:45:05 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/76] wifi: mac80211: consistently use sdata_dereference()
Date:   Wed, 13 Jul 2022 11:43:48 +0200
Message-Id: <20220713114425.d0af54df5907.Iddea3f3e887d53f5848389676fd3b07f97652ce3@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Instead of open-coding it, use sdata_dereference().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ibss.c | 12 ++++--------
 net/mac80211/mesh.c |  9 +++------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 65b6255c6747..d30a82f1620b 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -255,8 +255,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 		drv_leave_ibss(local, sdata);
 	}
 
-	presp = rcu_dereference_protected(ifibss->presp,
-					  lockdep_is_held(&sdata->wdev.mtx));
+	presp = sdata_dereference(ifibss->presp, sdata);
 	RCU_INIT_POINTER(ifibss->presp, NULL);
 	if (presp)
 		kfree_rcu(presp, rcu_head);
@@ -509,8 +508,7 @@ int ieee80211_ibss_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	rcu_read_unlock();
 	cfg80211_put_bss(sdata->local->hw.wiphy, cbss);
 
-	old_presp = rcu_dereference_protected(ifibss->presp,
-					  lockdep_is_held(&sdata->wdev.mtx));
+	old_presp = sdata_dereference(ifibss->presp, sdata);
 
 	presp = ieee80211_ibss_build_presp(sdata,
 					   sdata->vif.bss_conf.beacon_int,
@@ -714,8 +712,7 @@ static void ieee80211_ibss_disconnect(struct ieee80211_sub_if_data *sdata)
 	sdata->vif.cfg.ssid_len = 0;
 
 	/* remove beacon */
-	presp = rcu_dereference_protected(ifibss->presp,
-					  lockdep_is_held(&sdata->wdev.mtx));
+	presp = sdata_dereference(ifibss->presp, sdata);
 	RCU_INIT_POINTER(sdata->u.ibss.presp, NULL);
 	if (presp)
 		kfree_rcu(presp, rcu_head);
@@ -1530,8 +1527,7 @@ static void ieee80211_rx_mgmt_probe_req(struct ieee80211_sub_if_data *sdata,
 
 	sdata_assert_lock(sdata);
 
-	presp = rcu_dereference_protected(ifibss->presp,
-					  lockdep_is_held(&sdata->wdev.mtx));
+	presp = sdata_dereference(ifibss->presp, sdata);
 
 	if (ifibss->state != IEEE80211_IBSS_MLME_JOINED ||
 	    len < 24 + 2 || !presp)
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 13722a7f2254..6160211a7eee 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -993,8 +993,7 @@ ieee80211_mesh_rebuild_beacon(struct ieee80211_sub_if_data *sdata)
 	struct beacon_data *old_bcn;
 	int ret;
 
-	old_bcn = rcu_dereference_protected(sdata->u.mesh.beacon,
-					    lockdep_is_held(&sdata->wdev.mtx));
+	old_bcn = sdata_dereference(sdata->u.mesh.beacon, sdata);
 	ret = ieee80211_mesh_build_beacon(&sdata->u.mesh);
 	if (ret)
 		/* just reuse old beacon */
@@ -1084,8 +1083,7 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BEACON_ENABLED);
 
 	/* remove beacon */
-	bcn = rcu_dereference_protected(ifmsh->beacon,
-					lockdep_is_held(&sdata->wdev.mtx));
+	bcn = sdata_dereference(ifmsh->beacon, sdata);
 	RCU_INIT_POINTER(ifmsh->beacon, NULL);
 	kfree_rcu(bcn, rcu_head);
 
@@ -1380,8 +1378,7 @@ int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata)
 	ifmsh->chsw_ttl = 0;
 
 	/* Remove the CSA and MCSP elements from the beacon */
-	tmp_csa_settings = rcu_dereference_protected(ifmsh->csa,
-					    lockdep_is_held(&sdata->wdev.mtx));
+	tmp_csa_settings = sdata_dereference(ifmsh->csa, sdata);
 	RCU_INIT_POINTER(ifmsh->csa, NULL);
 	if (tmp_csa_settings)
 		kfree_rcu(tmp_csa_settings, rcu_head);
-- 
2.36.1

