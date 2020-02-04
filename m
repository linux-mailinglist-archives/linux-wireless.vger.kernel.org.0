Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D80511518E7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2020 11:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgBDKfX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Feb 2020 05:35:23 -0500
Received: from nbd.name ([46.4.11.11]:51970 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgBDKfX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Feb 2020 05:35:23 -0500
Received: from [149.224.158.146] (helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iyvY8-0000L5-Fo; Tue, 04 Feb 2020 11:35:20 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 2/3] mac80211: add support for setting fixed HE rate/gi/ltf
Date:   Tue,  4 Feb 2020 11:35:13 +0100
Message-Id: <20200204103514.18111-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204103514.18111-1-john@phrozen.org>
References: <20200204103514.18111-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miles Hu <milehu@codeaurora.org>

With nl80211 now able to receive fixed HE rate/gi/ltf settings we want to
propagate these further down the stack into the mac80211 drivers. This
patch copies the values into the sdata struct.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Miles Hu <milehu@codeaurora.org>
---
 net/mac80211/cfg.c         | 11 +++++++++++
 net/mac80211/ieee80211_i.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a11bd1669c13..5bf5f4754241 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2900,9 +2900,13 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
 		memcpy(sdata->rc_rateidx_vht_mcs_mask[i],
 		       mask->control[i].vht_mcs,
 		       sizeof(mask->control[i].vht_mcs));
+		memcpy(sdata->rc_rateidx_he_mcs_mask[i],
+		       mask->control[i].he_mcs,
+		       sizeof(mask->control[i].he_mcs));
 
 		sdata->rc_has_mcs_mask[i] = false;
 		sdata->rc_has_vht_mcs_mask[i] = false;
+		sdata->rc_has_he_mcs_mask[i] = false;
 		if (!sband)
 			continue;
 
@@ -2919,6 +2923,13 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
 				break;
 			}
 		}
+
+		for (j = 0; j < NL80211_HE_NSS_MAX; j++) {
+			if (~sdata->rc_rateidx_he_mcs_mask[i][j]) {
+				sdata->rc_has_he_mcs_mask[i] = true;
+				break;
+			}
+		}
 	}
 
 	return 0;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e3cf24cb4615..13868bdca772 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -963,6 +963,9 @@ struct ieee80211_sub_if_data {
 	bool rc_has_vht_mcs_mask[NUM_NL80211_BANDS];
 	u16 rc_rateidx_vht_mcs_mask[NUM_NL80211_BANDS][NL80211_VHT_NSS_MAX];
 
+	bool rc_has_he_mcs_mask[NUM_NL80211_BANDS];
+	u16 rc_rateidx_he_mcs_mask[NUM_NL80211_BANDS][NL80211_HE_NSS_MAX];
+
 	union {
 		struct ieee80211_if_ap ap;
 		struct ieee80211_if_wds wds;
-- 
2.20.1

