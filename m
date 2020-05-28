Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D351E6B33
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 21:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406665AbgE1ThN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 15:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406620AbgE1ThL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 15:37:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909EC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 12:37:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeOIt-0054OL-2G; Thu, 28 May 2020 21:34:59 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 21/24] mac80211: accept aggregation sessions on 6 GHz
Date:   Thu, 28 May 2020 21:34:44 +0200
Message-Id: <20200528213443.776d3c891b64.Ifa099d450617b50c691832b3c4aa08959fab520a@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On 6 GHz, stations don't have ht_supported set, but they can
still do aggregation since they must have HE, allow that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-rx.c | 5 +++--
 net/mac80211/agg-tx.c | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 4d1c335e06e5..7f245e9f114c 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018        Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  */
 
 /**
@@ -292,7 +292,8 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 		goto end;
 	}
 
-	if (!sta->sta.ht_cap.ht_supported) {
+	if (!sta->sta.ht_cap.ht_supported &&
+	    sta->sdata->vif.bss_conf.chandef.chan->band != NL80211_BAND_6GHZ) {
 		ht_dbg(sta->sdata,
 		       "STA %pM erroneously requests BA session on tid %d w/o QoS\n",
 		       sta->sta.addr, tid);
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index c2d5f512526d..b37c8a983d88 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -593,7 +593,8 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 		 "Requested to start BA session on reserved tid=%d", tid))
 		return -EINVAL;
 
-	if (!pubsta->ht_cap.ht_supported)
+	if (!pubsta->ht_cap.ht_supported &&
+	    sta->sdata->vif.bss_conf.chandef.chan->band != NL80211_BAND_6GHZ)
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(!local->ops->ampdu_action))
-- 
2.26.2

