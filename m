Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC35A22D62B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jul 2020 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgGYIph (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jul 2020 04:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGYIph (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jul 2020 04:45:37 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B4FC0619D3
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jul 2020 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZAheVPeNLygUtxQgCoGLzX2L+HWtpbgpsOmRMK+zrrk=; b=CNwI13jHY4DV2SnA1RsqoDs0NF
        NjNwztO6t8DwBHlx0x2vUr5Iz/FFpmiGBkoS9VKWKnv4uwSt0hD8CPVU4Fng+KOdqTOTToW4aWEkD
        gNm7tMDQuuyrx4qOP6VwFbw+6gZZQNnmxUXC42IiQrDh85LhynPS+lR7JyXBYeUX41mM=;
Received: from p5b206d80.dip0.t-ipconnect.de ([91.32.109.128] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jzFoF-0005Yr-5R; Sat, 25 Jul 2020 10:45:35 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: remove STA txq pending airtime underflow warning
Date:   Sat, 25 Jul 2020 10:45:33 +0200
Message-Id: <20200725084533.13829-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This warning can trigger if there is a mismatch between frames that were
sent with the sta pointer set vs tx status frames reported for the sta address.

This can happen due to race conditions on re-creating stations, or even
in the case of .sta_add/remove being used instead of .sta_state, which can cause
frames to be sent to a station that has not been uploaded yet.

If there is an actual underflow issue, it should show up in the device airtime
warning below, so it is better to remove this one.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/sta_info.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index cd8487bc6fc2..af4cc5fb678e 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1923,9 +1923,7 @@ void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 	if (sta) {
 		tx_pending = atomic_sub_return(tx_airtime,
 					       &sta->airtime[ac].aql_tx_pending);
-		if (WARN_ONCE(tx_pending < 0,
-			      "STA %pM AC %d txq pending airtime underflow: %u, %u",
-			      sta->addr, ac, tx_pending, tx_airtime))
+		if (tx_pending < 0)
 			atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending,
 				       tx_pending, 0);
 	}
-- 
2.24.0

