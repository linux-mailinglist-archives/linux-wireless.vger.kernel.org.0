Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011AB23A14A
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgHCIvb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHCIva (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 04:51:30 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EAAC06174A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Aug 2020 01:51:30 -0700 (PDT)
Received: from [134.101.163.132] (helo=bertha9.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k2WBs-0002Pi-UR; Mon, 03 Aug 2020 10:51:29 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V5 2/3] mac80211: add support for setting fixed HE rate/gi/ltf
Date:   Mon,  3 Aug 2020 10:51:26 +0200
Message-Id: <20200803085127.180550-2-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803085127.180550-1-john@phrozen.org>
References: <20200803085127.180550-1-john@phrozen.org>
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
index 24e9e00decb8..efee1a4e0600 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2863,9 +2863,13 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
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
 
@@ -2882,6 +2886,13 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
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
index 0b1eaec6649f..19ff8a2ff7b6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -967,6 +967,9 @@ struct ieee80211_sub_if_data {
 	u32 beacon_rateidx_mask[NUM_NL80211_BANDS];
 	bool beacon_rate_set;
 
+	bool rc_has_he_mcs_mask[NUM_NL80211_BANDS];
+	u16 rc_rateidx_he_mcs_mask[NUM_NL80211_BANDS][NL80211_HE_NSS_MAX];
+
 	union {
 		struct ieee80211_if_ap ap;
 		struct ieee80211_if_wds wds;
-- 
2.25.1

