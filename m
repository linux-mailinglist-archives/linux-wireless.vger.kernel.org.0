Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404E45AB432
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiIBOvn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiIBOvG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894A462A8B
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=rzcZD5si0tJLIfM5F3DMgNeVrx70fNNY4oJ6A7M/S94=;
        t=1662127991; x=1663337591; b=NtFS7RBdZhU2tznELSPd05BosdS4X9b4a2NNbH0cwJokM4g
        vrTj4pi8Kb4oQ4+EFFfBj532jJmTrz+lOEQIEKuN1063Zddj8URJJHq2vMFgDQvpF5huZnNrnL88d
        5Z1aIGmG5JxZ1jd8sKhv86KUEAX6FAjhEOKCwyHbJj8gBDwPvyxBfzLHrHNJUe+7lC11WQ3EUTFuj
        2A2O/vhptS+U/YvNOBWo4uyCHrnDwniFtlzjhR5yy4p25VnZ30nEWoiAJkNxixDDaPH+shJN9dGld
        V6CPnVzuIsLVfuHEg72PWKNGlGMLr2Bihv4q5lTQ1SrlCBT8pDOOvAhUwhSMhX/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pw-006Ch3-33;
        Fri, 02 Sep 2022 16:13:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/27] wifi: mac80211: mlme: refactor QoS settings code
Date:   Fri,  2 Sep 2022 16:12:46 +0200
Message-Id: <20220902161143.645481f0d71f.Idd077e09ab35a8eee01d885c4cbdebbd91a5368e@changeid>
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

Refactor the code to apply QoS settings to the driver so
we can call it on link switch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/mlme.c        | 39 +++++++++++++++++++++++++-------------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b41c49338cd3..977aea4467e0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1811,6 +1811,7 @@ void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
 				   u8 reason, bool tx);
 void ieee80211_mgd_setup_link(struct ieee80211_link_data *link);
 void ieee80211_mgd_stop_link(struct ieee80211_link_data *link);
+void ieee80211_mgd_set_link_qos_params(struct ieee80211_link_data *link);
 
 /* IBSS code */
 void ieee80211_ibss_notify_scan_completed(struct ieee80211_local *local);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 30edac8724d5..bbc62815b067 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2445,6 +2445,29 @@ static void ieee80211_sta_handle_tspec_ac_params_wk(struct work_struct *work)
 	ieee80211_sta_handle_tspec_ac_params(sdata);
 }
 
+void ieee80211_mgd_set_link_qos_params(struct ieee80211_link_data *link)
+{
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+	struct ieee80211_tx_queue_params *params = link->tx_conf;
+	u8 ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		mlme_dbg(sdata,
+			 "WMM AC=%d acm=%d aifs=%d cWmin=%d cWmax=%d txop=%d uapsd=%d, downgraded=%d\n",
+			 ac, params[ac].acm,
+			 params[ac].aifs, params[ac].cw_min, params[ac].cw_max,
+			 params[ac].txop, params[ac].uapsd,
+			 ifmgd->tx_tspec[ac].downgraded);
+		if (!ifmgd->tx_tspec[ac].downgraded &&
+		    drv_conf_tx(local, link, ac, &params[ac]))
+			link_err(link,
+				 "failed to set TX queue parameters for AC %d\n",
+				 ac);
+	}
+}
+
 /* MLME */
 static bool
 ieee80211_sta_wmm_params(struct ieee80211_local *local,
@@ -2576,20 +2599,10 @@ ieee80211_sta_wmm_params(struct ieee80211_local *local,
 		}
 	}
 
-	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		mlme_dbg(sdata,
-			 "WMM AC=%d acm=%d aifs=%d cWmin=%d cWmax=%d txop=%d uapsd=%d, downgraded=%d\n",
-			 ac, params[ac].acm,
-			 params[ac].aifs, params[ac].cw_min, params[ac].cw_max,
-			 params[ac].txop, params[ac].uapsd,
-			 ifmgd->tx_tspec[ac].downgraded);
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
 		link->tx_conf[ac] = params[ac];
-		if (!ifmgd->tx_tspec[ac].downgraded &&
-		    drv_conf_tx(local, link, ac, &params[ac]))
-			link_err(link,
-				 "failed to set TX queue parameters for AC %d\n",
-				 ac);
-	}
+
+	ieee80211_mgd_set_link_qos_params(link);
 
 	/* enable WMM or activate new settings */
 	link->conf->qos = true;
-- 
2.37.2

