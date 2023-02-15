Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E85697926
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 10:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjBOJk5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 04:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjBOJkx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 04:40:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D67736681
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 01:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=MyWNtJ4Q/0YiyJf1ju597Ck8HWMBuy5PxjqOFdAVIiU=; t=1676454045; x=1677663645; 
        b=wlqaYdvZcnEcdJfjTrhBJSk1GpKig9EU17XVd9eqiTztOWBa7+CLrFMg1Kh0uw7UTLHeTjjWlwG
        YTXl204nISi6v4m0YbR9waDoG3kpRRekQC8dPiEh3k/sPRbemFlRHe7IkGBeu0mpxpm1s1rOAjVrD
        +iWGqQZ0gioT1VXkUNDAiJdwco022I7rsAAo5YJvlZfq9Lt8neKk7I7PvX6o1lnDu2XuEzXv/g680
        Rz5Vxrht/5FuC+V+P4Pwy/BzTUii52fpcoRxRYz7cWPVcajHRlMZ8J4/LNC1h7YgWcmfpdJ0XMGRf
        dKlvNUNmz38e7BMlxHYgi8Vi5WRXG4zzcCyA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSEHL-00D0OY-2L;
        Wed, 15 Feb 2023 10:40:43 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: always initialize link_sta with sta
Date:   Wed, 15 Feb 2023 10:40:41 +0100
Message-Id: <20230215104040.51726349f367.I75c6d467e85928b2301aff08cef5dd40a9db7c30@changeid>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we have multiple interfaces receiving the same frame,
such as a multicast frame, one interface might have a sta
and the other not. In this case, link_sta would be set but
not cleared again.

Always set link_sta, so we keep an invariant that link_sta
and sta are either both set or both not set.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 69aa623163c6..f7fdfe710951 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4125,6 +4125,8 @@ static bool ieee80211_rx_data_set_sta(struct ieee80211_rx_data *rx,
 		if (!rx->sdata)
 			rx->sdata = sta->sdata;
 		rx->link_sta = &sta->deflink;
+	} else {
+		rx->link_sta = NULL;
 	}
 
 	if (link_id < 0)
-- 
2.39.1

