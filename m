Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80455A5945
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiH3CVA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiH3CU6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:20:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF0B7F133
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so3340428pja.4
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZjqpoFg5F92iNpozG4jkmKHf9FAGoWr+LPzk3rQ1MkQ=;
        b=syKd2CVcSM0SymvP/sMg+3YRmaID5LA8wINKRCTx8cPPyKD/WJ8bsM/yogdsr3bTyT
         aBWutqmrCAuCU6dc6Lm5du9FdVjZyoJAOK7ShXOKIZICMsHNLGH4A+P56eHPnwdEOlRM
         HONB7IpzPjPWRR7o+1ZeLQXwvj2k+mikY016mxSjVnFg1muIVna29NmsXQxyFImsPS0m
         AsfaUr7xkBRmHlV8qxStK/dqz2VUHWBD6cpPW/J4X8GYVL/wJPBcZSFvSs4MyY6p9OqU
         aT8AfmXXl0TamuoT/zewRcBz3jVMh0txlb/gyB4lWp06a4+IMMGD9uDMlXSdjzsAIE/R
         seZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZjqpoFg5F92iNpozG4jkmKHf9FAGoWr+LPzk3rQ1MkQ=;
        b=iAd7vvaDviGwEu5ou2RUamDb6Xminfe5eF4GttqNo98KdduTp07qqEGB5+SDRj1ENz
         isht5syB08bOS+VnCdyynYmcTBYAqsMT5V0sIvfFYFWqeNIgfAv4fbvFX8uTki18Z6yu
         WwEbb8ft8XfVbI7rXbWeJ11WpChz9fJY85zPvfDQRia0nFLNlpUAmENTBHic+GwLsJ8H
         PRhRc3wNcnISscvugssA4EAPUeEr/szJ3rVTFGhWK3RkK1Ljt0U0dHGgrobuxj3TWNAz
         oAvbDdMkc4fRbjuis3THc4YqiZ4XzJH4wP8xgua+r2dNoVhn2hvc08OvubJgzQYk1tWE
         Qw+g==
X-Gm-Message-State: ACgBeo1wwwb1xtgX6UKutgDjZBQPwluPEilO9n22fipC3K+C5ha4H8+r
        52/GdKmlDGNZsT7Ns7Dd9bTJodz9OzeN5hwF
X-Google-Smtp-Source: AA6agR69Z1F54vIQ8ZehTUmOfb0lNjpxvq+uDYDyEtMWZK/REXIxI8bLFHNSFxssvhX0JroHVk9osQ==
X-Received: by 2002:a17:902:9006:b0:172:927e:c19a with SMTP id a6-20020a170902900600b00172927ec19amr19217534plp.162.1661826055206;
        Mon, 29 Aug 2022 19:20:55 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm8220050plb.25.2022.08.29.19.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:20:54 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v2 06/12] mac80211: support ieee80211_ext format
Date:   Tue, 30 Aug 2022 02:20:11 +0000
Message-Id: <20220830022017.51017-7-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
References: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
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
2.25.1

