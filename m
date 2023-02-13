Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C19C694255
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 11:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjBMKJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 05:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjBMKJc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 05:09:32 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D4EB71
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 02:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bJgyHZNZjCHkhArS26vaUM8o3Y39Mp5N/46zikf5C0U=; b=HHq8yky0TLoJb4T1FGU61zqnNw
        dvTee2EzG1dtXOdwYS70kimMjc/Dn6EKWsb22pEPkKBSLJEbWMEFzH4lgi4YBdypGHgWtkkiNNlE8
        tloI172ti8eAkzemi3U1BNsFfCm8urTLzlH2EZ7D2jyWEMPkydOBMqlMitQm4QLsNAKc=;
Received: from p200300daa73b49008dd6ef632c4ae296.dip0.t-ipconnect.de ([2003:da:a73b:4900:8dd6:ef63:2c4a:e296] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pRVld-007ay2-10; Mon, 13 Feb 2023 11:09:01 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 1/5] wifi: cfg80211: move A-MSDU check in ieee80211_data_to_8023_exthdr
Date:   Mon, 13 Feb 2023 11:08:51 +0100
Message-Id: <20230213100855.34315-1-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When parsing the outer A-MSDU header, don't check for inner bridge tunnel
or RFC1042 headers. This is handled by ieee80211_amsdu_to_8023s already.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/wireless/util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 38d3b434c18c..430962f97e74 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -631,8 +631,9 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 		break;
 	}
 
-	if (likely(skb_copy_bits(skb, hdrlen, &payload, sizeof(payload)) == 0 &&
-	           ((!is_amsdu && ether_addr_equal(payload.hdr, rfc1042_header) &&
+	if (likely(!is_amsdu &&
+		   skb_copy_bits(skb, hdrlen, &payload, sizeof(payload)) == 0 &&
+	           ((ether_addr_equal(payload.hdr, rfc1042_header) &&
 		     payload.proto != htons(ETH_P_AARP) &&
 		     payload.proto != htons(ETH_P_IPX)) ||
 		    ether_addr_equal(payload.hdr, bridge_tunnel_header)))) {
-- 
2.39.0

