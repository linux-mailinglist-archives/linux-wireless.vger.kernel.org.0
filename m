Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75BCFE8460
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 10:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfJ2JZe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 05:25:34 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:60850 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731810AbfJ2JZe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 05:25:34 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iPNkq-0004yD-Du; Tue, 29 Oct 2019 10:25:32 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: sta: randomize BA session dialog token allocator
Date:   Tue, 29 Oct 2019 10:25:25 +0100
Message-Id: <20191029102515.0f0bf4af8f8c.Ia9fe90e75977caa1b6960c3f1438c9e3b4ee7e3f@changeid>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We currently always start the dialog token generator at zero,
so the first dialog token we use is always 1. This would be
OK if we had a perfect guarantee that we always do a proper
deauth/re-auth handshake, but in IBSS mode this doesn't always
happen properly.

To make problems with block ack (aggregation) sessions getting
stuck less likely, randomize the dialog token so if we start a
new session but the peer still has old state for us, it can
better detect this.

This is really just a workaround to make things a bit more
robust than they are now - a better fix would be to do a full
authentication handshake in IBSS mode upon having discovered a
new station, and on the receiver resetting the state (removing
and re-adding the station) on receiving the authentication
packet.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index bd11fef2139f..b6c8e6291920 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -324,6 +324,7 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	INIT_WORK(&sta->drv_deliver_wk, sta_deliver_ps_frames);
 	INIT_WORK(&sta->ampdu_mlme.work, ieee80211_ba_session_work);
 	mutex_init(&sta->ampdu_mlme.mtx);
+	sta->ampdu_mlme.dialog_token_allocator = prandom_u32_max(U8_MAX);
 #ifdef CONFIG_MAC80211_MESH
 	if (ieee80211_vif_is_mesh(&sdata->vif)) {
 		sta->mesh = kzalloc(sizeof(*sta->mesh), gfp);
-- 
2.20.1

