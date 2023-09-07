Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EF5797801
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbjIGQjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245189AbjIGQio (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 12:38:44 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1A0273B
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 09:35:57 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58d31f142eeso12018947b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 Sep 2023 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694104497; x=1694709297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LiuEHdSEKcVIe8Q8MnZz4Af/RP8k3NN9qPaUUgT1FzQ=;
        b=iCWkVzNnPMtuv81xNiTlVSK0z/+p69PEoTppxKlPaOol6M33DqzzTkFBbQTTNXYAwx
         cWaVNtgsWv/TlVbP/ubFlDNtE+AyglRcDGh9koSXK02JZhNrzdVpofdYcUfKSXeSp4KA
         a1+yLlVZ2Bws2Z68MO5cRtO0L2zCcgicukm+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104497; x=1694709297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiuEHdSEKcVIe8Q8MnZz4Af/RP8k3NN9qPaUUgT1FzQ=;
        b=F52/jmqFKqMclwt9G8zRflkPEzMftIQ0IQl4vHbGcCrAqP7eMIaRckVTDpn1hFYGLj
         nS5zKwxF3u26SKzBD3pmZ1yaEYJxoJVvWQG2ARJWdmay25gYxNvLAvO5BV3lbVjzDxay
         GR0JjGzZUBFxnDMy1v5VtwTw6rHfUI5r/fwmuqJDBX5atUpNP3agYCjabeY3XAcL02qM
         VvLH1gbtQzZ55X++yGf6DCOHD0Go7upOFZ12KhpP5tKSgo7CgjkqeomqXRk6ZZQems+c
         h19ONg3lVDgzEgNJJG7YKh49TxSCVu+UyukrN4DzVb1k80/cOyBqdlZ4fQt/YxFdsGVL
         oQPg==
X-Gm-Message-State: AOJu0YwidV6Q5CTH7hvhAFYuxQSyAGzOaPQ+lYiCDaIA6jkc8DM96Iib
        mn/PMgeMLK7dg48iVoagJg400eCKaCNffT2kxY0=
X-Google-Smtp-Source: AGHT+IHbs3Su3hYcWJJVY3rw9f834g5Cdz/KMqEGCuMX4I9fejMg3ArwvMnXcKj04HNUtpeRrqa5QQ==
X-Received: by 2002:a92:c74b:0:b0:345:79eb:e001 with SMTP id y11-20020a92c74b000000b0034579ebe001mr19990613ilp.19.1694079571749;
        Thu, 07 Sep 2023 02:39:31 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:fa85:7903:e9e8:a27b])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a034100b0026d54b2abe9sm1193103pjf.37.2023.09.07.02.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:39:31 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Matthew Wang <matthewmwang@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
Date:   Thu,  7 Sep 2023 17:39:10 +0800
Message-ID: <20230907093927.400634-1-treapking@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Only skip the code path trying to access the rfc1042 headers when the
buffer is too small, so the driver can still process packets without
rfc1042 headers.

Fixes: 119585281617 ("wifi: mwifiex: Fix OOB and integer underflow when rx packets")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v2:
- Fix sizeof call (sizeof(rx_pkt_hdr) --> sizeof(*rx_pkt_hdr))

 drivers/net/wireless/marvell/mwifiex/sta_rx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index 65420ad67416..ebb65f3c086c 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -86,7 +86,8 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_len = le16_to_cpu(local_rx_pd->rx_pkt_length);
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
 
-	if (sizeof(*rx_pkt_hdr) + rx_pkt_off > skb->len) {
+	if (sizeof(rx_pkt_hdr->eth803_hdr) + sizeof(rfc1042_header) +
+	    rx_pkt_off > skb->len) {
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "wrong rx packet offset: len=%d, rx_pkt_off=%d\n",
 			    skb->len, rx_pkt_off);
@@ -95,12 +96,13 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 		return -1;
 	}
 
-	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
-		     sizeof(bridge_tunnel_header))) ||
-	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
-		     sizeof(rfc1042_header)) &&
-	     ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
-	     ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX)) {
+	if (sizeof(rx_pkt_hdr) + rx_pkt_off <= skb->len &&
+	    ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		      sizeof(bridge_tunnel_header))) ||
+	     (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		      sizeof(rfc1042_header)) &&
+	      ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
+	      ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX))) {
 		/*
 		 *  Replace the 803 header and rfc1042 header (llc/snap) with an
 		 *    EthernetII header, keep the src/dst and snap_type
-- 
2.42.0.283.g2d96d420d3-goog

