Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493752DC7E2
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 21:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgLPUoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 15:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgLPUoC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 15:44:02 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601BDC06179C
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 12:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6CdUC09+dNRuA/9QkbmE00OV3i1rxpHmbq2OQcJtuaY=; b=p+u872YdkUMNNfHw2BD0q9uY7t
        ueeNYvLAB5zH/mXib4uJoGp6qP4g51izOZx9jqnM+95PFmAxxhtg30k+GpHpsJ7qOcv8Ps798DIg3
        1Pox0A5IyjCIYleAsVjVtNu7kVpP/pFCS1PHAjahNEQLFeidGOTLXi8PYLfWQkhEvLQU=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpddn-0002eR-1y; Wed, 16 Dec 2020 21:43:19 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 6/7] mac80211: fix fast-rx encryption check
Date:   Wed, 16 Dec 2020 21:43:15 +0100
Message-Id: <20201216204316.44498-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201216204316.44498-1-nbd@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When using WEP, the default unicast key needs to be selected, instead of
the STA PTK.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 13b9bcc4865d..972895e9f22d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4176,6 +4176,8 @@ void ieee80211_check_fast_rx(struct sta_info *sta)
 
 	rcu_read_lock();
 	key = rcu_dereference(sta->ptk[sta->ptk_idx]);
+	if (!key)
+		key = rcu_dereference(sdata->default_unicast_key);
 	if (key) {
 		switch (key->conf.cipher) {
 		case WLAN_CIPHER_SUITE_TKIP:
-- 
2.28.0

