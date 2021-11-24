Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB76345B79B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 10:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhKXJnj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 04:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhKXJnh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 04:43:37 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67108C061574
        for <linux-wireless@vger.kernel.org>; Wed, 24 Nov 2021 01:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ETbkScFOZRClLEnfE5Ov+GQNFQS7W8DUEWmqmGt/5OM=; b=KceRK5LBXpDneOvujOSxFmdI6x
        L5oSLpXKkQHMZ+5rNJKo+KtAdPFxJ/BpnBXxMzn2P49t2CJ1/yAqMU4JAmBnDFej0Rh8QuhJtOS32
        BdvN7WYk/hTAI8a8x/Sn+Qtmph4NJhH+YhBGfDTYHEYfY3tfkt1FIrX4Z/udLHVcoXqw=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mpolO-0002L9-B0; Wed, 24 Nov 2021 10:40:26 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, mordechay.goodstein@intel.com,
        cotequeiroz@gmail.com
Subject: [PATCH 5.16] mac80211: fix regression in SSN handling of addba tx
Date:   Wed, 24 Nov 2021 10:40:24 +0100
Message-Id: <20211124094024.43222-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some drivers that do their own sequence number allocation (e.g. ath9k) rely
on being able to modify params->ssn on starting tx ampdu sessions.
This was broken by a change that modified it to use sta->tid_seq[tid] instead.

Cc: stable@vger.kernel.org
Fixes: 31d8bb4e07f8 ("mac80211: agg-tx: refactor sending addba")
Reported-by: Eneas U de Queiroz <cotequeiroz@gmail.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/agg-tx.c   | 4 ++--
 net/mac80211/sta_info.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 430a58587538..c1558dd2d244 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -480,8 +480,7 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 
 	/* send AddBA request */
 	ieee80211_send_addba_request(sdata, sta->sta.addr, tid,
-				     tid_tx->dialog_token,
-				     sta->tid_seq[tid] >> 4,
+				     tid_tx->dialog_token, tid_tx->ssn,
 				     buf_size, tid_tx->timeout);
 
 	WARN_ON(test_and_set_bit(HT_AGG_STATE_SENT_ADDBA, &tid_tx->state));
@@ -523,6 +522,7 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 
 	params.ssn = sta->tid_seq[tid] >> 4;
 	ret = drv_ampdu_action(local, sdata, &params);
+	tid_tx->ssn = params.ssn;
 	if (ret == IEEE80211_AMPDU_TX_START_DELAY_ADDBA) {
 		return;
 	} else if (ret == IEEE80211_AMPDU_TX_START_IMMEDIATE) {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index ba2796782008..e7443fc4669c 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -199,6 +199,7 @@ struct tid_ampdu_tx {
 	u8 stop_initiator;
 	bool tx_stop;
 	u16 buf_size;
+	u16 ssn;
 
 	u16 failed_bar_ssn;
 	bool bar_pending;
-- 
2.30.1

