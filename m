Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9149075E035
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jul 2023 09:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGWHIC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Jul 2023 03:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGWHH5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Jul 2023 03:07:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03A11BD1
        for <linux-wireless@vger.kernel.org>; Sun, 23 Jul 2023 00:07:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-267f8f36a3cso365040a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 23 Jul 2023 00:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690096073; x=1690700873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RPTaawMampB8RdvwrfDPokZ7/oEYhLgXuDoV4Vx7Y/M=;
        b=aMZxCKQzDFYXJjEVDT0G/DPOcKAPOyQatzh9GimtvKnJQtSrgGDAgfKecnu1izGL4J
         yREIV6O7Fo0nJcLwH6w4FpABhMI3A/W8OsI3ZaESbUqD350YYQcOpQDT0njNEnwb5Cir
         VkVy95ovvDcAXRJOhOTXrqdbpvCxhS9xURoihYXf07oLeGOuKQQOV4qKgARU+BE+PT7F
         M2lD+iDnO6Ez8AQpM1eXuEaP9THjGDGjULkqj/Elr2yTGLahmwBIxxsEJ/+bgdsL7obk
         NgCsGECDqforv5Vv0+zj97hDBdQGVP6m4/dVT+xVlmU2G1Z01DgjoKjwoOE8F7NFjBOc
         JPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690096073; x=1690700873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPTaawMampB8RdvwrfDPokZ7/oEYhLgXuDoV4Vx7Y/M=;
        b=M4d/tDZu7EB+HTbOT07s+7C8TJNEhGkMjW38DQmLKxod1ggbhaER01CnK7+6auZRqI
         DgrK49B/gT5kXe/kxODAUyILV52IaXHd0dYA40mZT+HEc4ns3d1lGkpR3ZeviDRWvKGl
         dycF8kr3JavRsW3WrFnEiaHTNnI8z9v+F4e1y1eTIUlZyIpIRv6mdhVGVyFGOB6Kwi0a
         Kfkp2luh6qAdv48U9LdHsmAqtK8sa4rDuTaXEv7a9VBl4WNEwsyj7LfpMyzu/hsVQ+si
         6ECgTVXWYoKwzquZne6r3Gf4JKQV34bA584BnLAfZl6Pt9JduUSaoFOWMAh4FfVHOOsm
         /SHg==
X-Gm-Message-State: ABy/qLY+iBiAhYFRGkZBzct0FyFKE8MkHB0I1EfujDeG159nl5Wb1FM5
        qkIC5LkWX/QxI7gEZqQMU8mWjWCDE/+8Qg==
X-Google-Smtp-Source: APBJJlFlrF4ptKIOjz/JRoKvWPagSULmYR36TptlotsY6FWMqDL3GtYbr2dyPnxGUWyvC2rTdFGOPQ==
X-Received: by 2002:a17:90a:e2c1:b0:268:2f2:cc88 with SMTP id fr1-20020a17090ae2c100b0026802f2cc88mr2471813pjb.12.1690096072979;
        Sun, 23 Jul 2023 00:07:52 -0700 (PDT)
Received: from localhost.localdomain ([221.231.189.81])
        by smtp.gmail.com with ESMTPSA id gd17-20020a17090b0fd100b00263dee538b1sm4744192pjb.25.2023.07.23.00.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 00:07:52 -0700 (PDT)
From:   Polaris Pi <pinkperfect2021@gmail.com>
To:     matthewmwang@chromium.org, briannorris@chromium.org,
        kuba@kernel.org, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Polaris Pi <pinkperfect2021@gmail.com>
Subject: [PATCH v7] wifi: mwifiex: Fix OOB and integer underflow when rx packets
Date:   Sun, 23 Jul 2023 07:07:41 +0000
Message-Id: <20230723070741.1544662-1-pinkperfect2021@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make sure mwifiex_process_mgmt_packet,
mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet,
mwifiex_uap_queue_bridged_pkt and mwifiex_process_rx_packet
not out-of-bounds access the skb->data buffer.

Fixes: 2dbaf751b1de ("mwifiex: report received management frames to cfg80211")
Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
---
V5: Follow chromeos comments: preserve the original flow of mwifiex_process_uap_rx_packet
V6: Simplify check in mwifiex_process_uap_rx_packet
V7: Fix drop packets issue when auotest V6, now pass manual and auto tests
---
 drivers/net/wireless/marvell/mwifiex/sta_rx.c | 11 ++++++++++-
 .../net/wireless/marvell/mwifiex/uap_txrx.c   | 19 +++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c   | 10 +++++++---
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index 13659b02ba88..f2899d53a43f 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -86,6 +86,14 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_len = le16_to_cpu(local_rx_pd->rx_pkt_length);
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
 
+	if (sizeof(*rx_pkt_hdr) + rx_pkt_off > skb->len) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "wrong rx packet offset: len=%d, rx_pkt_off=%d\n",
+			    skb->len, rx_pkt_off);
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+	}
+
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
 		     sizeof(bridge_tunnel_header))) ||
 	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
@@ -194,7 +202,8 @@ int mwifiex_process_sta_rx_packet(struct mwifiex_private *priv,
 
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_offset;
 
-	if ((rx_pkt_offset + rx_pkt_length) > (u16) skb->len) {
+	if ((rx_pkt_offset + rx_pkt_length) > skb->len ||
+	    sizeof(rx_pkt_hdr->eth803_hdr) + rx_pkt_offset > skb->len) {
 		mwifiex_dbg(adapter, ERROR,
 			    "wrong rx packet: len=%d, rx_pkt_offset=%d, rx_pkt_length=%d\n",
 			    skb->len, rx_pkt_offset, rx_pkt_length);
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index e495f7eaea03..04ff051f5d18 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -103,6 +103,15 @@ static void mwifiex_uap_queue_bridged_pkt(struct mwifiex_private *priv,
 		return;
 	}
 
+	if (sizeof(*rx_pkt_hdr) +
+	    le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len) {
+		mwifiex_dbg(adapter, ERROR,
+			    "wrong rx packet offset: len=%d,rx_pkt_offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+	}
+
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
 		     sizeof(bridge_tunnel_header))) ||
 	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
@@ -367,6 +376,16 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_type = le16_to_cpu(uap_rx_pd->rx_pkt_type);
 	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
 
+	if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	    sizeof(rx_pkt_hdr->eth803_hdr) > skb->len) {
+		mwifiex_dbg(adapter, ERROR,
+			    "wrong rx packet for struct ethhdr: len=%d, offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
 	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
 
 	if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 94c2d219835d..745b1d925b21 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -393,11 +393,15 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 	}
 
 	rx_pd = (struct rxpd *)skb->data;
+	pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
+	if (pkt_len < sizeof(struct ieee80211_hdr) + sizeof(pkt_len)) {
+		mwifiex_dbg(priv->adapter, ERROR, "invalid rx_pkt_length");
+		return -1;
+	}
 
 	skb_pull(skb, le16_to_cpu(rx_pd->rx_pkt_offset));
 	skb_pull(skb, sizeof(pkt_len));
-
-	pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
+	pkt_len -= sizeof(pkt_len);
 
 	ieee_hdr = (void *)skb->data;
 	if (ieee80211_is_mgmt(ieee_hdr->frame_control)) {
@@ -410,7 +414,7 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 		skb->data + sizeof(struct ieee80211_hdr),
 		pkt_len - sizeof(struct ieee80211_hdr));
 
-	pkt_len -= ETH_ALEN + sizeof(pkt_len);
+	pkt_len -= ETH_ALEN;
 	rx_pd->rx_pkt_length = cpu_to_le16(pkt_len);
 
 	cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
-- 
2.25.1

