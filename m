Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0618378990
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfG2KX7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 06:23:59 -0400
Received: from nbd.name ([46.4.11.11]:51530 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfG2KX7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 06:23:59 -0400
Received: from pd95fd89e.dip0.t-ipconnect.de ([217.95.216.158] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hs2ou-0005aM-4i; Mon, 29 Jul 2019 12:23:56 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH V6 2/2] mac80211: propagate HE operation info into bss_conf
Date:   Mon, 29 Jul 2019 12:23:42 +0200
Message-Id: <20190729102342.8659-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190729102342.8659-1-john@phrozen.org>
References: <20190729102342.8659-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Upon a successful assoc a station shall store the content of the HE
operation element inside bss_conf so that the driver can setup the
hardware accordingly.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 include/net/mac80211.h     |  2 ++
 net/mac80211/he.c          | 14 ++++++++++++++
 net/mac80211/ieee80211_i.h |  4 ++++
 net/mac80211/mlme.c        |  1 +
 4 files changed, 21 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9effd286c1ae..bd91388797fc 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -600,6 +600,7 @@ struct ieee80211_ftm_responder_params {
  *	nontransmitted BSSIDs
  * @profile_periodicity: the least number of beacon frames need to be received
  *	in order to discover all the nontransmitted BSSIDs in the set.
+ * @he_operation: HE operation information of the AP we are connected to
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -661,6 +662,7 @@ struct ieee80211_bss_conf {
 	u8 bssid_indicator;
 	bool ema_ap;
 	u8 profile_periodicity;
+	struct ieee80211_he_operation he_operation;
 };
 
 /**
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 219650591c79..5d3aa9c65fdf 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -50,3 +50,17 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	he_cap->has_he = true;
 }
+
+void
+ieee80211_he_op_ie_to_bss_conf(struct ieee80211_vif *vif,
+			const struct ieee80211_he_operation *he_op_ie_elem)
+{
+	struct ieee80211_he_operation *he_operation =
+					&vif->bss_conf.he_operation;
+
+	if (!he_op_ie_elem) {
+		memset(he_operation, 0, sizeof(*he_operation));
+		return;
+	}
+	memcpy(he_operation, he_op_ie_elem, sizeof(*he_operation));
+}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a5818ff0e2a4..ba1bc245678e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1873,6 +1873,10 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  const u8 *he_cap_ie, u8 he_cap_len,
 				  struct sta_info *sta);
 
+void
+ieee80211_he_op_ie_to_bss_conf(struct ieee80211_vif *vif,
+			const struct ieee80211_he_operation *he_op_ie_elem);
+
 /* Spectrum management */
 void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
 				       struct ieee80211_mgmt *mgmt,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a99ad0325309..2b8a7428973d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3381,6 +3381,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		if (elems.uora_element)
 			bss_conf->uora_ocw_range = elems.uora_element[0];
 
+		ieee80211_he_op_ie_to_bss_conf(&sdata->vif, elems.he_operation);
 		/* TODO: OPEN: what happens if BSS color disable is set? */
 	}
 
-- 
2.20.1

