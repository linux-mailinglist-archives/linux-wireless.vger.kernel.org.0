Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6370A526675
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiEMPqd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 11:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiEMPqa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 11:46:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD1378906
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=/HfO9igH16wOqQfB6JAxr0ynOq6uUAL4wR354aq33fc=; t=1652456789; x=1653666389; 
        b=cg+0+fCKMY20CtDh/mcaRQCxIOGcValE85mdRhThVBLsHULxl6239ghDNRYIIF0gVei1JeBGWL0
        r8gF/jVq37xjlMUMKs8O1+44ZgDO3UIAdvPFdlf++wqUfzIiOqR2gmNCVHzSqvTN06b0lpd475OOT
        OQqZqIE6A8h/C2DoteLqijrcjHpKediTwqdstpTdMU+1o4qOBnV0X1w58zkLIoPUCPOI0kPkn04QY
        ze8X1ITMFcDO4iaYWfiWy2aS2X8CKIfBiNwRFELaqhjLJzlyEuAkR4nKnXDCJVTwrP6CUyARfecjs
        aquYZQ1LczSkVEnFh8ZG8y862wpBbKjO9ewA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1npXUp-00Aeu2-Ev;
        Fri, 13 May 2022 17:46:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] mac80211: remove unused argument to ieee80211_sta_connection_lost()
Date:   Fri, 13 May 2022 17:46:23 +0200
Message-Id: <20220513174623.a713706d6970.I43b954414c811cfcc6bc394809b31a6bb78d6d12@changeid>
X-Mailer: git-send-email 2.35.3
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

We never use the bssid argument to ieee80211_sta_connection_lost()
so we might as well just remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/main.c        |  4 ++--
 net/mac80211/mlme.c        | 10 ++++------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e58aa6fa58f2..d072f20e3c5a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1859,7 +1859,7 @@ void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_handle_tspec_ac_params(struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
-				   u8 *bssid, u8 reason, bool tx);
+				   u8 reason, bool tx);
 
 /* IBSS code */
 void ieee80211_ibss_notify_scan_completed(struct ieee80211_local *local);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 03f772c4ee42..5a385d4146b9 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -287,8 +287,8 @@ static void ieee80211_restart_work(struct work_struct *work)
 			if (sdata->vif.csa_active) {
 				sdata_lock(sdata);
 				ieee80211_sta_connection_lost(sdata,
-							      sdata->u.mgd.bssid,
-							      WLAN_REASON_UNSPECIFIED, false);
+							      WLAN_REASON_UNSPECIFIED,
+							      false);
 				sdata_unlock(sdata);
 			}
 		}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 26b4863ae1ea..e2637404ccd1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4503,7 +4503,7 @@ static void ieee80211_sta_timer(struct timer_list *t)
 }
 
 void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
-				   u8 *bssid, u8 reason, bool tx)
+				   u8 reason, bool tx)
 {
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
 
@@ -4758,7 +4758,7 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 				mlme_dbg(sdata,
 					 "No ack for nullfunc frame to AP %pM, disconnecting.\n",
 					 bssid);
-				ieee80211_sta_connection_lost(sdata, bssid,
+				ieee80211_sta_connection_lost(sdata,
 					WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
 					false);
 			}
@@ -4768,7 +4768,7 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 			mlme_dbg(sdata,
 				 "Failed to send nullfunc to AP %pM after %dms, disconnecting\n",
 				 bssid, probe_wait_ms);
-			ieee80211_sta_connection_lost(sdata, bssid,
+			ieee80211_sta_connection_lost(sdata,
 				WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY, false);
 		} else if (ifmgd->probe_send_count < max_tries) {
 			mlme_dbg(sdata,
@@ -4785,7 +4785,7 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 				 "No probe response from AP %pM after %dms, disconnecting.\n",
 				 bssid, probe_wait_ms);
 
-			ieee80211_sta_connection_lost(sdata, bssid,
+			ieee80211_sta_connection_lost(sdata,
 				WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY, false);
 		}
 	}
@@ -4940,7 +4940,6 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 		sdata->flags &= ~IEEE80211_SDATA_DISCONNECT_RESUME;
 		mlme_dbg(sdata, "driver requested disconnect after resume\n");
 		ieee80211_sta_connection_lost(sdata,
-					      ifmgd->bssid,
 					      WLAN_REASON_UNSPECIFIED,
 					      true);
 		sdata_unlock(sdata);
@@ -4951,7 +4950,6 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 		sdata->flags &= ~IEEE80211_SDATA_DISCONNECT_HW_RESTART;
 		mlme_dbg(sdata, "driver requested disconnect after hardware restart\n");
 		ieee80211_sta_connection_lost(sdata,
-					      ifmgd->bssid,
 					      WLAN_REASON_UNSPECIFIED,
 					      true);
 		sdata_unlock(sdata);
-- 
2.35.3

