Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903671C36AA
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 12:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgEDKVB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 06:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728250AbgEDKU7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 06:20:59 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6277C061A0E
        for <linux-wireless@vger.kernel.org>; Mon,  4 May 2020 03:20:58 -0700 (PDT)
Received: from [149.224.141.1] (helo=bertha8.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jVYDY-0000o1-4d; Mon, 04 May 2020 12:20:56 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V4 2/3] mac80211: add support for setting fixed HE rate/gi/ltf
Date:   Mon,  4 May 2020 12:20:50 +0200
Message-Id: <20200504102051.6438-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504102051.6438-1-john@phrozen.org>
References: <20200504102051.6438-1-john@phrozen.org>
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

Signed-off-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/cfg.c         | 11 +++++++++++
 net/mac80211/ieee80211_i.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0f72813fed53..ea3791a930e8 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2829,9 +2829,13 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
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
 
@@ -2848,6 +2852,13 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
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
index f8ed4f621f7f..2502726d0a58 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -964,6 +964,9 @@ struct ieee80211_sub_if_data {
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

