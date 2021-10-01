Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8141F588
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 21:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356025AbhJATNH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 15:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356034AbhJATNC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 15:13:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B817EC0613E5
        for <linux-wireless@vger.kernel.org>; Fri,  1 Oct 2021 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=2vwgUCKWjdxV00XqvtYiEdYgP7bjedhLFmpW/7OZ1os=; t=1633115476; x=1634325076; 
        b=jsJfxQgPJ2jZLMUArzK9q1odE5FtH6SFsUtglx2mdHrJskuID+NMphQbzBDholbAQ/QqOH5Ah2I
        YwPVjG8B93I23RTl5BMJPqH+YCrUvaZLUAKoKqXIh7HrCpWiIHFPZ7WeBkqCfCkV4jBCpwz1m2yRG
        awzEfwYbiRXmV5qQZSsMQPAH3uh5rj2kJLyduaUM8DppcNKKXkr8+Pc3+elGTFIDUv0vC2VhK2viL
        gnablwlYGFFWhXsS8fY+SzKGoiKtj+9dzitV6PX5YNke8rxA24Tf0NTb0PT12R7vkCwqG82M+ogS/
        HqEU/taosseZu2ZapZ+cxta02N0kFpcxc12Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mWNw7-00ELVc-IL;
        Fri, 01 Oct 2021 21:11:11 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: fix memory leaks with element parsing
Date:   Fri,  1 Oct 2021 21:11:08 +0200
Message-Id: <20211001211108.9839928e42e0.Ib81ca187d3d3af7ed1bfeac2e00d08a4637c8025@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

My previous commit 5d24828d05f3 ("mac80211: always allocate
struct ieee802_11_elems") had a few bugs and leaked the new
allocated struct in a few error cases, fix that.

Fixes: 5d24828d05f3 ("mac80211: always allocate struct ieee802_11_elems")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-rx.c |  3 ++-
 net/mac80211/ibss.c   | 10 +++++-----
 net/mac80211/mlme.c   | 36 ++++++++++++++++++------------------
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 94c65def102c..470ff0ce3dc7 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -498,13 +498,14 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 		elems = ieee802_11_parse_elems(mgmt->u.action.u.addba_req.variable,
 					       ies_len, true, mgmt->bssid, NULL);
 		if (!elems || elems->parse_error)
-			return;
+			goto free;
 	}
 
 	__ieee80211_start_rx_ba_session(sta, dialog_token, timeout,
 					start_seq_num, ba_policy, tid,
 					buf_size, true, false,
 					elems ? elems->addba_ext_ie : NULL);
+free:
 	kfree(elems);
 }
 
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 66b00046f0c2..0416c4d22292 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1659,11 +1659,11 @@ void ieee80211_ibss_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 				mgmt->u.action.u.chan_switch.variable,
 				ies_len, true, mgmt->bssid, NULL);
 
-			if (!elems || elems->parse_error)
-				break;
-
-			ieee80211_rx_mgmt_spectrum_mgmt(sdata, mgmt, skb->len,
-							rx_status, elems);
+			if (elems && !elems->parse_error)
+				ieee80211_rx_mgmt_spectrum_mgmt(sdata, mgmt,
+								skb->len,
+								rx_status,
+								elems);
 			kfree(elems);
 			break;
 		}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0ec183a92a01..40b29cfb7cfe 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3353,8 +3353,10 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			bss_ies = kmemdup(ies, sizeof(*ies) + ies->len,
 					  GFP_ATOMIC);
 		rcu_read_unlock();
-		if (!bss_ies)
-			return false;
+		if (!bss_ies) {
+			ret = false;
+			goto out;
+		}
 
 		bss_elems = ieee802_11_parse_elems(bss_ies->data, bss_ies->len,
 						   false, mgmt->bssid,
@@ -4331,13 +4333,11 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 					mgmt->u.action.u.chan_switch.variable,
 					ies_len, true, mgmt->bssid, NULL);
 
-			if (!elems || elems->parse_error)
-				break;
-
-			ieee80211_sta_process_chanswitch(sdata,
-						 rx_status->mactime,
-						 rx_status->device_timestamp,
-						 elems, false);
+			if (elems && !elems->parse_error)
+				ieee80211_sta_process_chanswitch(sdata,
+								 rx_status->mactime,
+								 rx_status->device_timestamp,
+								 elems, false);
 			kfree(elems);
 		} else if (mgmt->u.action.category == WLAN_CATEGORY_PUBLIC) {
 			struct ieee802_11_elems *elems;
@@ -4357,17 +4357,17 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 					mgmt->u.action.u.ext_chan_switch.variable,
 					ies_len, true, mgmt->bssid, NULL);
 
-			if (!elems || elems->parse_error)
-				break;
+			if (elems && !elems->parse_error) {
+				/* for the handling code pretend it was an IE */
+				elems->ext_chansw_ie =
+					&mgmt->u.action.u.ext_chan_switch.data;
 
-			/* for the handling code pretend this was also an IE */
-			elems->ext_chansw_ie =
-				&mgmt->u.action.u.ext_chan_switch.data;
+				ieee80211_sta_process_chanswitch(sdata,
+								 rx_status->mactime,
+								 rx_status->device_timestamp,
+								 elems, false);
+			}
 
-			ieee80211_sta_process_chanswitch(sdata,
-						 rx_status->mactime,
-						 rx_status->device_timestamp,
-						 elems, false);
 			kfree(elems);
 		}
 		break;
-- 
2.31.1

