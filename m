Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAFA2DE9A9
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Dec 2020 20:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgLRTQY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Dec 2020 14:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgLRTQY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Dec 2020 14:16:24 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD6EC0617A7
        for <linux-wireless@vger.kernel.org>; Fri, 18 Dec 2020 11:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pj9T7trL50a6AAE0LhTdxMlG+yYf9rsZC2Ilf+8naiw=; b=unJtlQlMkOEGJeBVsD1/FAP4Zu
        fiBDm1nh2zGSfzb96QV5GEUZCPvjvpe1LzLIqOokSDPSq36QLpv4mRSvO1pQE/4iHqujVBsaQS0Oq
        DWfQfX9zhkqne/pG+O63CfbPdzNyUGDML++3KjE90c+jeo79D/KIwAznU0g+lBMagsG8=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kqLDq-0001pC-Js; Fri, 18 Dec 2020 20:15:26 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>
Subject: [PATCH] mac80211: do not drop tx nulldata packets on encrypted links
Date:   Fri, 18 Dec 2020 20:15:25 +0100
Message-Id: <20201218191525.1168-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_tx_h_select_key drops any non-mgmt packets without a key when
encryption is used. This is wrong for nulldata packets that can't be
encrypted and are sent out for probing clients and indicating 4-address
mode.

Reported-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Fixes: a0761a301746 ("mac80211: drop data frames without key on encrypted links")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 39c7059c644f..b728a9507a87 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -649,7 +649,7 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 		if (!skip_hw && tx->key &&
 		    tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
 			info->control.hw_key = &tx->key->conf;
-	} else if (!ieee80211_is_mgmt(hdr->frame_control) && tx->sta &&
+	} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta &&
 		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
 		return TX_DROP;
 	}
-- 
2.28.0

