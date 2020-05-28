Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40701E6B39
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406677AbgE1Thd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 15:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406620AbgE1Th3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 15:37:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6008C08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 12:37:29 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeOIq-0054OL-QA; Thu, 28 May 2020 21:34:56 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH v2 14/24] mac80211: check the correct bit for EMA AP
Date:   Thu, 28 May 2020 21:34:37 +0200
Message-Id: <20200528213443.4316121fa2a3.I9745582f8d41ad8e689dac0fefcd70b276d7c1ea@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

An AP supporting EMA (Enhanced Multi-BSSID advertisement) should set
bit 83 in the extended capabilities IE (9.4.2.26 in the 802.11ax D5 spec).
So the *3rd* bit of the 10th byte should be checked.
Also, in one place, the wrong byte was checked.
(cfg80211_find_ie returns a pointer to the beginning of the IE,
 so the data really starts at ie[2], so the 10th byte
 should be ie[12]. To avoid this confusion, use cfg80211_find_elem
 instead).

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h |  2 +-
 net/mac80211/mlme.c       | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 9580dfd9e2d1..1ecfd19f836d 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3082,7 +3082,7 @@ enum ieee80211_tdls_actioncode {
 #define WLAN_EXT_CAPA10_OBSS_NARROW_BW_RU_TOLERANCE_SUPPORT BIT(7)
 
 /* Defines support for enhanced multi-bssid advertisement*/
-#define WLAN_EXT_CAPA11_EMA_SUPPORT	BIT(1)
+#define WLAN_EXT_CAPA11_EMA_SUPPORT	BIT(3)
 
 /* TDLS specific payload type in the LLC/SNAP header */
 #define WLAN_TDLS_SNAP_RFTYPE	0x2
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index bc558d1d20fc..c534cd1bb9cd 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5596,7 +5596,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		assoc_data->timeout_started = true;
 		assoc_data->need_beacon = true;
 	} else if (beacon_ies) {
-		const u8 *ie;
+		const struct element *elem;
 		u8 dtim_count = 0;
 
 		ieee80211_get_dtim(beacon_ies, &dtim_count,
@@ -5613,15 +5613,15 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 			sdata->vif.bss_conf.sync_dtim_count = dtim_count;
 		}
 
-		ie = cfg80211_find_ext_ie(WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION,
-					  beacon_ies->data, beacon_ies->len);
-		if (ie && ie[1] >= 3)
-			sdata->vif.bss_conf.profile_periodicity = ie[4];
+		elem = cfg80211_find_ext_elem(WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION,
+					      beacon_ies->data, beacon_ies->len);
+		if (elem && elem->datalen >= 3)
+			sdata->vif.bss_conf.profile_periodicity = elem->data[2];
 
-		ie = cfg80211_find_ie(WLAN_EID_EXT_CAPABILITY,
-				      beacon_ies->data, beacon_ies->len);
-		if (ie && ie[1] >= 11 &&
-		    (ie[10] & WLAN_EXT_CAPA11_EMA_SUPPORT))
+		elem = cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY,
+					  beacon_ies->data, beacon_ies->len);
+		if (elem && elem->datalen >= 11 &&
+		    (elem->data[10] & WLAN_EXT_CAPA11_EMA_SUPPORT))
 			sdata->vif.bss_conf.ema_ap = true;
 	} else {
 		assoc_data->timeout = jiffies;
-- 
2.26.2

