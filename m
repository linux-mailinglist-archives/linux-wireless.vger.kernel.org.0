Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA17231EE
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 13:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfETLCS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 07:02:18 -0400
Received: from nbd.name ([46.4.11.11]:47812 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732258AbfETLCQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 07:02:16 -0400
Received: from p548c87ba.dip0.t-ipconnect.de ([84.140.135.186] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hSg3Y-0003rt-7R; Mon, 20 May 2019 13:02:12 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH 6/7] mac80211: propagate spatial reuse info into ieee80211_sta
Date:   Mon, 20 May 2019 13:02:03 +0200
Message-Id: <20190520110204.27588-7-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520110204.27588-1-john@phrozen.org>
References: <20190520110204.27588-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Upon a successful assoc a station shall store the content of the SPR
element inside ieee80211_sta so that the driver can setup the hardware
accordingly.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h     |  1 +
 net/mac80211/he.c          | 24 ++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  4 ++++
 net/mac80211/mlme.c        |  1 +
 4 files changed, 30 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d81eea9140e5..f73a210b122b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1952,6 +1952,7 @@ struct ieee80211_sta {
 	struct ieee80211_sta_vht_cap vht_cap;
 	struct ieee80211_sta_he_cap he_cap;
 	struct ieee80211_he_operation he_operation;
+	struct ieee80211_he_obss_pd he_obss_pd;
 	u16 max_rx_aggregation_subframes;
 	bool wme;
 	u8 uapsd_queues;
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 62ef029e5c48..e41ee4a29257 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -67,3 +67,27 @@ ieee80211_he_op_ie_to_sta_he_op(struct ieee80211_sub_if_data *sdata,
 	}
 	memcpy(he_operation, he_op_ie_elem, sizeof(*he_operation));
 }
+
+void
+ieee80211_he_spr_ie_to_sta_he_obss_pd(struct ieee80211_sub_if_data *sdata,
+			      const struct ieee80211_he_spr *he_spr_ie_elem,
+			      struct sta_info *sta)
+{
+	struct ieee80211_he_obss_pd *he_obss_pd = &sta->sta.he_obss_pd;
+	const u8 *data = he_spr_ie_elem->optional;
+
+	memset(he_obss_pd, 0, sizeof(*he_obss_pd));
+
+	if (!he_spr_ie_elem)
+		return;
+
+	if (he_spr_ie_elem->he_sr_control &
+	    IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT)
+		data++;
+	if (he_spr_ie_elem->he_sr_control &
+	    IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT) {
+		he_obss_pd->max_offset = *data++;
+		he_obss_pd->min_offset = *data++;
+		he_obss_pd->enable = true;
+	}
+}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e931e114fba4..d82469754d34 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1870,6 +1870,10 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_supported_band *sband,
 				  const u8 *he_cap_ie, u8 he_cap_len,
 				  struct sta_info *sta);
+void
+ieee80211_he_spr_ie_to_sta_he_obss_pd(struct ieee80211_sub_if_data *sdata,
+				const struct ieee80211_he_spr *he_spr_ie_elem,
+				struct sta_info *sta);
 
 void
 ieee80211_he_op_ie_to_sta_he_op(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 996439a288c0..098335f34aa3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3377,6 +3377,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			bss_conf->uora_ocw_range = elems.uora_element[0];
 
 		ieee80211_he_op_ie_to_sta_he_op(sdata, elems.he_operation, sta);
+		ieee80211_he_spr_ie_to_sta_he_obss_pd(sdata, elems.he_spr, sta);
 		/* TODO: OPEN: what happens if BSS color disable is set? */
 	}
 
-- 
2.20.1

