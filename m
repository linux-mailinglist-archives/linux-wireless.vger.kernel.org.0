Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4016C401819
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Sep 2021 10:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbhIFIhI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Sep 2021 04:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbhIFIhI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Sep 2021 04:37:08 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D872FC061575
        for <linux-wireless@vger.kernel.org>; Mon,  6 Sep 2021 01:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=T1HzOaR/qo+2dPtlAtB/kb5FO7LzIPRj4r+bznF/YY8=; b=lom1tIDdLZ7112sZU2i+pVUjfq
        MMxYTyXUOPQpyYVdQEATal63XCPfYieM1uFJjeewujhpkUpH1vNnKnPhtD4XLQjNCckBgZcZS+ZpP
        +56zECD3f4qgVH1O2b9W37EaqCpApydDgMsiUQO4ocyz0ekCVuWyU5Axpvanqb6IWoN4=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mNA6j-0007BF-Ct; Mon, 06 Sep 2021 10:36:01 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Philipp Borgers <borgers@mi.fu-berlin.de>
Subject: [PATCH] Revert "mac80211: do not use low data rates for data frames with no ack flag"
Date:   Mon,  6 Sep 2021 10:35:59 +0200
Message-Id: <20210906083559.9109-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit d333322361e7a099dc74df2498d3fa5fde5c4fa7.
Returning false early in rate_control_send_low breaks sending broadcast
packets, since rate control will not select a rate for it.
Before re-introducing a fixed version of this patch, we should probably also
make some changes to rate control to be more conservative in selecting rates
for no-ack packets and also prevent using probing rates on them, since we won't
get any feedback.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index e5935e3d7a07..8c6416129d5b 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -392,10 +392,6 @@ static bool rate_control_send_low(struct ieee80211_sta *pubsta,
 	int mcast_rate;
 	bool use_basicrate = false;
 
-	if (ieee80211_is_tx_data(txrc->skb) &&
-	    info->flags & IEEE80211_TX_CTL_NO_ACK)
-		return false;
-
 	if (!pubsta || rc_no_data_or_no_ack_use_min(txrc)) {
 		__rate_control_send_low(txrc->hw, sband, pubsta, info,
 					txrc->rate_idx_mask);
-- 
2.30.1

