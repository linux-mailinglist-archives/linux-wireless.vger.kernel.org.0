Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F36C7DBF
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 13:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCXMJc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 08:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjCXMJ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 08:09:28 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209DA16AE3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fOvWabSuRLP9OBhyLAI8L87vxn+Ghd+Lexe1ePH9NFc=; b=CXBbGeAIm9YbLxlMem7Ir5SPNO
        AoqtlyEn08JCe7JNHyCaQdjVb61VgW5gHkOhzjtW//Nl87cVqKI34Dc1SZVGXHLPk3vVI/EeSTCEb
        VGYsRBGWTWlgmbs3yTjcB/qlZ9JBj5ckqGOZqe4zPiaWmUFoZGVOltaM4exGbGz7MLn4=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pfgEX-006Liq-9f; Fri, 24 Mar 2023 13:09:25 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 2/3] wifi: mac80211: fix flow dissection for forwarded packets
Date:   Fri, 24 Mar 2023 13:09:23 +0100
Message-Id: <20230324120924.38412-2-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230324120924.38412-1-nbd@nbd.name>
References: <20230324120924.38412-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adjust the network header to point at the correct payload offset

Fixes: 986e43b19ae9 ("wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4be80c7dda95..bab839a0f59a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2850,7 +2850,7 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 		hdrlen += ETH_ALEN;
 	else
 		fwd_skb->protocol = htons(fwd_skb->len - hdrlen);
-	skb_set_network_header(fwd_skb, hdrlen);
+	skb_set_network_header(fwd_skb, hdrlen + 2);
 
 	info = IEEE80211_SKB_CB(fwd_skb);
 	memset(info, 0, sizeof(*info));
-- 
2.39.0

