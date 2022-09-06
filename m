Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03865ADE9D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 06:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiIFEtJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 00:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiIFEtI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 00:49:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C3696E5
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 21:49:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 73so9622485pga.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 21:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=N7kGX5xaT//6eWvGI4ewEIkNsO+zil6xVfa/eI991C8=;
        b=yI/DYOapE4n0Ne5gXB9766V91JiF6EdnbvYV5OCwbsntqxnUVZuR6FzjW/zss0XQiU
         eRVZj9CMVwwsgBTnrqYL1775nytskFC63DyamIley9DKDamgaU/66JyA4hY55WqSVf5H
         8QD67ltg2gGnlkwsKSKnwyaBUSw3Vtr1F4T5nwMmSjZOKPJJfOpSzFcsDFCpplYgDbwQ
         7GJhRGvCNniU6n95Rd0wxuLeI5p3CdJA24eaHcia90LfGDFiK3YUUSjBLcMQieHioL+3
         IPEIXCCZSI9HNlXnYfQuDCINO+TnxoPyrzR1I7te+TQfE1Hd4TnZ+ARUMIe6qmWRJAEn
         rc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=N7kGX5xaT//6eWvGI4ewEIkNsO+zil6xVfa/eI991C8=;
        b=NdDGRiBCiXLsYdHHvC+1okS86HEoEXrfsnTfbd0gRsYgFDplxGKCarQkxIpGNCBqFG
         057vaUGR+m8XPphS571G5V/0jvdpJCYpPHdKD5gqJGVKoeL+SiFx4QGr5oxRTb1eH2NF
         GXV6C0m9P1dy4+OOM3DQforaORKUAWZO5VovTQ1v6iLW2WIUtAsnO7uFbBxQlNQyhQ82
         59qPXTL1O+Uf7UJJkN1a+vnQeNMcN1B2G6tEU/61WPTD1FLF5VnuvoEsInwSP8IAymy7
         WB2DUPgedi41fVOquFWOiRtb27468gxfkECECbXZ4l7qUQuonPCL1GNiyugQxKLfSgT2
         9p7A==
X-Gm-Message-State: ACgBeo2Xt4oRYXIkOOmaKipP5s6qBkAER2y+6J3Cy+Xideqmh4u980Bl
        2wg1Y8LTqZHUQ4s7SPFifp/p+g==
X-Google-Smtp-Source: AA6agR66y+neQ+eILIKn194uHyUHE082BdizlwENEQQTcXmMbuPJr93zjQO2irDw6pkghP4uCTaP0g==
X-Received: by 2002:a63:4802:0:b0:41c:ac9e:1950 with SMTP id v2-20020a634802000000b0041cac9e1950mr45249987pga.376.1662439740449;
        Mon, 05 Sep 2022 21:49:00 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00176b66954a6sm2726822plb.121.2022.09.05.21.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:48:59 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v3 06/12] mac80211: support ieee80211_ext format
Date:   Tue,  6 Sep 2022 16:48:06 +1200
Message-Id: <20220906044812.7609-7-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ensure S1G beacons use the new ieee80211_ext format when required.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
---
 net/mac80211/rx.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 57df21e2170a..d46eeebedb4b 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4895,6 +4895,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_hdr *hdr;
+	struct ieee80211_ext *ext_hdr;
 	__le16 fc;
 	struct ieee80211_rx_data rx;
 	struct ieee80211_sub_if_data *prev;
@@ -4911,7 +4912,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	if (ieee80211_is_data(fc) || ieee80211_is_mgmt(fc))
 		I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
 
-	if (ieee80211_is_mgmt(fc)) {
+	if (ieee80211_is_mgmt(fc) || ieee80211_is_s1g_beacon(fc)) {
 		/* drop frame if too short for header */
 		if (skb->len < ieee80211_hdrlen(fc))
 			err = -ENOBUFS;
@@ -4926,13 +4927,17 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		return;
 	}
 
-	hdr = (struct ieee80211_hdr *)skb->data;
+	if (ieee80211_is_s1g_beacon(fc))
+		ext_hdr = (struct ieee80211_ext *)skb->data;
+	else
+		hdr = (struct ieee80211_hdr *)skb->data;
+
 	ieee80211_parse_qos(&rx);
 	ieee80211_verify_alignment(&rx);
 
-	if (unlikely(ieee80211_is_probe_resp(hdr->frame_control) ||
-		     ieee80211_is_beacon(hdr->frame_control) ||
-		     ieee80211_is_s1g_beacon(hdr->frame_control)))
+	if (unlikely(ieee80211_is_probe_resp(fc) ||
+		     ieee80211_is_beacon(fc) ||
+		     ieee80211_is_s1g_beacon(fc)))
 		ieee80211_scan_rx(local, skb);
 
 	if (ieee80211_is_data(fc)) {
@@ -4991,7 +4996,10 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 			prev = sdata;
 			continue;
 		}
-
+		if (ieee80211_is_s1g_beacon(fc))
+			rx.sta = sta_info_get_bss(prev, ext_hdr->u.s1g_beacon.sa);
+		else
+			rx.sta = sta_info_get_bss(prev, hdr->addr2);
 		rx.sdata = prev;
 		ieee80211_rx_for_interface(&rx, skb, false);
 
@@ -4999,6 +5007,10 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	}
 
 	if (prev) {
+		if (ieee80211_is_s1g_beacon(fc))
+			rx.sta = sta_info_get_bss(prev, ext_hdr->u.s1g_beacon.sa);
+		else
+			rx.sta = sta_info_get_bss(prev, hdr->addr2);
 		rx.sdata = prev;
 
 		if (ieee80211_rx_for_interface(&rx, skb, true))
-- 
2.34.1

