Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8841D28CDB9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Oct 2020 14:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgJMMCL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Oct 2020 08:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgJMMCJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Oct 2020 08:02:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671D9C0613D0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Oct 2020 05:02:09 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kSJ0G-004tWW-2R; Tue, 13 Oct 2020 14:02:04 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Wen Gong <wgong@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: don't require VHT elements for HE on 2.4 GHz
Date:   Tue, 13 Oct 2020 14:01:57 +0200
Message-Id: <20201013140156.535a2fc6192f.Id6e5e525a60ac18d245d86f4015f1b271fce6ee6@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

After the previous similar bugfix there was another bug here,
if no VHT elements were found we also disabled HE. Fix this to
disable HE only on the 5 GHz band; on 6 GHz it was already not
disabled, and on 2.4 GHz there need (should) not be any VHT.

Fixes: 57fa5e85d53c ("mac80211: determine chandef from HE 6 GHz operation")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2e400b0ff696..0f30f50c46b1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5359,6 +5359,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 			struct cfg80211_assoc_request *req)
 {
 	bool is_6ghz = req->bss->channel->band == NL80211_BAND_6GHZ;
+	bool is_5ghz = req->bss->channel->band == NL80211_BAND_5GHZ;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_bss *bss = (void *)req->bss->priv;
@@ -5507,7 +5508,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	if (vht_ie && vht_ie[1] >= sizeof(struct ieee80211_vht_cap))
 		memcpy(&assoc_data->ap_vht_cap, vht_ie + 2,
 		       sizeof(struct ieee80211_vht_cap));
-	else if (!is_6ghz)
+	else if (is_5ghz)
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT |
 				IEEE80211_STA_DISABLE_HE;
 	rcu_read_unlock();
-- 
2.26.2

