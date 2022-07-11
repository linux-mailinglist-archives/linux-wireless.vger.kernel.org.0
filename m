Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1007356D25F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiGKBJO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiGKBJN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:09:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACFD15A23
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fz10so3572088pjb.2
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nh259kpnKYV3BBVAWC0uC/nH7ZHNh5TP6sTi10lPBHs=;
        b=LuIkDiAw3AFZGIZme5IkAZBtvozjgZQ0W389V2TYtKjBE5fwBL87/nvVRfM9p8BUq6
         GKnFkN583fTW33WifoOTJVUzZuNPMvwb8MoweHN1FyonVgC2bXB7RvnqvPS2DQDhfU8j
         7gSmDev4rGs7yBzKULiNcKqjqdKukNH6dkuH3doMygPkD9QVZE/Tpr7L0nRNxuXesxry
         XD+o6zarrL7bnJozqb+SBHnEdYOzUBOfjmDMfh2xjb31cUOReyJ3epnFzbUT8LLjkKeE
         k41/ZbpvVr4tUcYXcElQ9Yemp8AarXWxn6k0ud6No4/YAuDaRtv2z6YbqdrNNnB0fmzE
         aWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nh259kpnKYV3BBVAWC0uC/nH7ZHNh5TP6sTi10lPBHs=;
        b=7rxdnn946Gy/5mLS1ShURVR8oo+PhfvPqTFCdR4u1Q/3++qiJGPO1mrakRo+y/E0C9
         fqm9ridV+M6EpBLoZ18/ceyVAnZewGBy6VgNRnZ/PaMmlcrh6sdI9hHYbSwyakrxCPqv
         LLmYWGkcDLMdtJpyFqXrdW5LenJXF+2TwtAYRY0tbardd1zHLW5MyotausjJ7oR0U8xA
         JAviy4bZkQfAVmiYGeGh+UAKDSiccSuIAU99PkOlUdytl57AtdamqcshI0c2RP62HqLu
         iMhjdpyICRtBgga0RDjPLvME8KnGpFZS0qEaFGPLUU9GOFkUY6qYhciQbiSpvmdJm8V7
         /GRQ==
X-Gm-Message-State: AJIora8OCvH9Kdf/XaGNfVSE5KW+E+Wm64VujLehB2+AH75VPCg9Mbq7
        E6xEGRRIw3aX7wOoAIOjrI5r5g==
X-Google-Smtp-Source: AGRyM1uwttwqrDnmrMTdiHwtH5v9Ad6ZQjcj2iiEERfL2vFwodAvvaCtumSNNpH+VGVjY8PxR6+x3g==
X-Received: by 2002:a17:902:8487:b0:16b:de14:43a7 with SMTP id c7-20020a170902848700b0016bde1443a7mr16197829plo.44.1657501749688;
        Sun, 10 Jul 2022 18:09:09 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:09:09 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH 06/12] mac80211: support ieee80211_ext format
Date:   Mon, 11 Jul 2022 01:08:10 +0000
Message-Id: <20220711010816.45927-7-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
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
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 net/mac80211/rx.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index d017ad14d7db..feab1d58e932 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4772,6 +4772,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_hdr *hdr;
+	struct ieee80211_ext *ext_hdr;
 	__le16 fc;
 	struct ieee80211_rx_data rx;
 	struct ieee80211_sub_if_data *prev;
@@ -4787,7 +4788,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	if (ieee80211_is_data(fc) || ieee80211_is_mgmt(fc))
 		I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
 
-	if (ieee80211_is_mgmt(fc)) {
+	if (ieee80211_is_mgmt(fc) || ieee80211_is_s1g_beacon(fc)) {
 		/* drop frame if too short for header */
 		if (skb->len < ieee80211_hdrlen(fc))
 			err = -ENOBUFS;
@@ -4802,13 +4803,16 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		return;
 	}
 
-	hdr = (struct ieee80211_hdr *)skb->data;
+	if (ieee80211_is_s1g_beacon(fc))
+		ext_hdr = (struct ieee80211_ext *)skb->data;
+	else
+		hdr = (struct ieee80211_hdr *)skb->data;
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
@@ -4868,7 +4872,10 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 			continue;
 		}
 
-		rx.sta = sta_info_get_bss(prev, hdr->addr2);
+		if (ieee80211_is_s1g_beacon(fc))
+			rx.sta = sta_info_get_bss(prev, ext_hdr->u.s1g_beacon.sa);
+		else
+			rx.sta = sta_info_get_bss(prev, hdr->addr2);
 		rx.sdata = prev;
 		ieee80211_prepare_and_rx_handle(&rx, skb, false);
 
@@ -4876,7 +4883,10 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	}
 
 	if (prev) {
-		rx.sta = sta_info_get_bss(prev, hdr->addr2);
+		if (ieee80211_is_s1g_beacon(fc))
+			rx.sta = sta_info_get_bss(prev, ext_hdr->u.s1g_beacon.sa);
+		else
+			rx.sta = sta_info_get_bss(prev, hdr->addr2);
 		rx.sdata = prev;
 
 		if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
-- 
2.25.1

