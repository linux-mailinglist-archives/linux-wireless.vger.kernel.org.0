Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1537B776B50
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 23:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjHIV6k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 17:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHIV6j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 17:58:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06936FE
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 14:58:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f94328a4so212882b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Aug 2023 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691618318; x=1692223118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnz6T5JaO9ndxPNG1QR0YwZEj2HeY50+n2mvPDGxhv4=;
        b=O/7xXLEv6i2Ef9MRCdt5kfPj99SSR/LFfnwD059ombOD0RtYg2jz7Opa1EvJO5dJEV
         kiuSyyoYcweH9EvspBCuzk7ml2wE/3JaTo1Y1Ul7qFIsiChxDg6etkj2mNfSHhZcghZl
         up0/oq9VOEh58d6bY8/wnt+w3Yw0xhMuZmKZPNF46AoB8L7bdseF9rvaEiCq7XitklvK
         Z4lCKaolQ8L6CkufcBQ5M8+TAwJFRwB0rJXD7EWSjyS5AeUSMB5AlkThetubfC9Nrc1C
         8VhXmQYUvjDWou40lQSoYI5H8dLQ/oWBNdVaRb1QRnRrm9YMT7hBN6Rgdkvc/NsKOMv0
         7CTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691618318; x=1692223118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnz6T5JaO9ndxPNG1QR0YwZEj2HeY50+n2mvPDGxhv4=;
        b=SlMlmvogds/RYiYjm6yiES6fBs+8tzwbHxIs5JS6BXjavMBC69IXMfQxRcDqYa8CcN
         f0ZspgVBiT5IK+zVC7MyChpKnCMrJGur/mqLRybhQAIM2TUFWJLkRrmLqFKfJeBOoT/5
         uDhc/nLr6U8BBlDKhy0Je65hc6n9NNCfD/c8aKx40n7M/tD+Un0qpDuS/wOON4tTveUT
         brEpBuGoIU/HkcItcjtPYmIxxhRrAQqY252202ArjSnNUTR7WtbRUSQ1SB25gERYmqXj
         9wczvAA8FMrlcV98J4TSLTZzJ75t0SW7RKy1ocjaBiZpEjz4vxjHCA9gRf6DZu3LMF+c
         3Sng==
X-Gm-Message-State: AOJu0YwbDR8579fbBKf1JRHp1wi+MMqrmZ5X9rQCpEXRqmTnUWq/GZRQ
        yJUr33CPf/3eEFXkzvuVM+3gbffPGjeTPK/L
X-Google-Smtp-Source: AGHT+IGKt2BZP2irdrUle5NAgRT0ugdR5jL6hcPETpxgSk4ewkHyn5PRY6FerGYfyzG5Vs1OgSqNnA==
X-Received: by 2002:a05:6a20:9187:b0:140:d536:d434 with SMTP id v7-20020a056a20918700b00140d536d434mr233800pzd.10.1691618317830;
        Wed, 09 Aug 2023 14:58:37 -0700 (PDT)
Received: from localhost.localdomain ([221.231.189.234])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b00666b3706be6sm71401pfm.107.2023.08.09.14.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:58:37 -0700 (PDT)
From:   Polaris Pi <pinkperfect2021@gmail.com>
To:     matthewmwang@chromium.org, briannorris@chromium.org,
        kuba@kernel.org, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Polaris Pi <pinkperfect2021@gmail.com>
Subject: [PATCH v8] wifi: mwifiex: Fix OOB and integer underflow when rx packets
Date:   Wed,  9 Aug 2023 21:58:17 +0000
Message-Id: <20230809215817.3080280-1-pinkperfect2021@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
V8: Fix missing return after free skb
---
 drivers/net/wireless/marvell/mwifiex/sta_rx.c | 12 ++++++++++-
 .../net/wireless/marvell/mwifiex/uap_txrx.c   | 20 +++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c   | 10 +++++++---
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index 13659b02ba88..65420ad67416 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -86,6 +86,15 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_len = le16_to_cpu(local_rx_pd->rx_pkt_length);
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
 
+	if (sizeof(*rx_pkt_hdr) + rx_pkt_off > skb->len) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "wrong rx packet offset: len=%d, rx_pkt_off=%d\n",
+			    skb->len, rx_pkt_off);
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return -1;
+	}
+
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
 		     sizeof(bridge_tunnel_header))) ||
 	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
@@ -194,7 +203,8 @@ int mwifiex_process_sta_rx_packet(struct mwifiex_private *priv,
 
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_offset;
 
-	if ((rx_pkt_offset + rx_pkt_length) > (u16) skb->len) {
+	if ((rx_pkt_offset + rx_pkt_length) > skb->len ||
+	    sizeof(rx_pkt_hdr->eth803_hdr) + rx_pkt_offset > skb->len) {
 		mwifiex_dbg(adapter, ERROR,
 			    "wrong rx packet: len=%d, rx_pkt_offset=%d, rx_pkt_length=%d\n",
 			    skb->len, rx_pkt_offset, rx_pkt_length);
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index e495f7eaea03..c1b8d41dd753 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -103,6 +103,16 @@ static void mwifiex_uap_queue_bridged_pkt(struct mwifiex_private *priv,
 		return;
 	}
 
+	if (sizeof(*rx_pkt_hdr) +
+	    le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len) {
+		mwifiex_dbg(adapter, ERROR,
+			    "wrong rx packet offset: len=%d,rx_pkt_offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
 		     sizeof(bridge_tunnel_header))) ||
 	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
@@ -367,6 +377,16 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
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

