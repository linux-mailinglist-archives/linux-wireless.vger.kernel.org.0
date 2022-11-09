Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD56220E6
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 01:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiKIAiR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 19:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIAiQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 19:38:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80837627D1
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 16:38:15 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so383981pjc.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Nov 2022 16:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGnKSAb0utOTqpbE10ROhaV2F0LRtl+HSL1xxabD1nM=;
        b=7yWawy2nxYrfsV4XADQriB8jLIQdqpIboaHxp/f0UkJrEQY0wxWZyHODLtySulsmnJ
         Ncg9svONxE1+Q7yW7WIo/KK52Y4mG8BXxFPbjFsAJVNDc8E4sTl46xHB9+/5d6FbyLNm
         k6sCG6KdyjOqQ1vTLBaOREZordeN+n4oBLl0SteIZD3n9FxzZBK2icx6c4b3tOyY1OTI
         9fPk3isS05nfN0hV/d6guFBYCDfJvo5nb3OadPRpmMW37ieDqdlROyyL5bL4vAYpl8VY
         l2n5jUJmSx3h7ew/+Zbf0APzVcv6RA4bnMuUpjZzDvQvXr6F6nyQWltUEbmcpOwyTmcm
         PO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGnKSAb0utOTqpbE10ROhaV2F0LRtl+HSL1xxabD1nM=;
        b=y30YtPhYi/xuO9m1r7wK4IFpY+oReanAoUKtlOyItdwq5RayxWud5Nehg61ewvSVaw
         eRPmhP7lmSHdBBBTZALA4x1hRVYNX0WvbfF8oTZ5I1gfTSAuTR3Zk6wA01EzzbaShUeP
         tJir3LKkA11f3NinY94uQ5RLo2R9S2V8WJkWVlfYLVOqJXjXR5zOInSziKZ8YZAkC2DU
         V1zXrBUaQd6V8cA4hSr0i0PIKQeg4H/3Z4q4SeLd/3rY4qFh3upyiHyPFLGpY5BAzjGJ
         ZOv2ivzxACeyPuXsOjraVE2yBQcYzOhu7C9/gjHeQ17+HHttm49v6S7IYmI79rgw28PA
         BOSQ==
X-Gm-Message-State: ACrzQf1zPnFhwwN3xL7a8TB0iSs0vuEi881v9/r6nuEyshz/myQm3xVH
        fQ/36CSjln1gjDKwYCSIYyLMLg==
X-Google-Smtp-Source: AMsMyM5C0A1hJjb8z0uTHRg1Q6+G3/ycDca+m2eJXEOjNnUXeUJwNlpExygbtdQKOhBkZVPHdbsIZw==
X-Received: by 2002:a17:902:8ecc:b0:188:5f4b:260e with SMTP id x12-20020a1709028ecc00b001885f4b260emr29638120plo.111.1667954295025;
        Tue, 08 Nov 2022 16:38:15 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001714c36a6e7sm7502726plf.284.2022.11.08.16.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:38:14 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v2 1/4] wifi: cfg80211: Add long_beacon_interval and short_beacon_tail
Date:   Wed,  9 Nov 2022 13:37:24 +1300
Message-Id: <20221109003727.614882-1-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kieran Frewen <kieran.frewen@morsemicro.com>

Support variables to handle short beacon period and adding a
separate tail for them.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 include/net/cfg80211.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 11a370e64143..7f785b81b8e3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1179,8 +1179,11 @@ struct cfg80211_mbssid_elems {
  *	or %NULL if not changed
  * @tail: tail portion of beacon (after TIM IE)
  *	or %NULL if not changed
+ * @short_tail: short tail portion of beacon (after TIM IE)
+	or %NULL if not changed
  * @head_len: length of @head
  * @tail_len: length of @tail
+ * @short_tail_len: length of @short_tail
  * @beacon_ies: extra information element(s) to add into Beacon frames or %NULL
  * @beacon_ies_len: length of beacon_ies in octets
  * @proberesp_ies: extra information element(s) to add into Probe Response
@@ -1207,7 +1210,7 @@ struct cfg80211_mbssid_elems {
 struct cfg80211_beacon_data {
 	unsigned int link_id;
 
-	const u8 *head, *tail;
+	const u8 *head, *tail, *short_tail;
 	const u8 *beacon_ies;
 	const u8 *proberesp_ies;
 	const u8 *assocresp_ies;
@@ -1217,7 +1220,7 @@ struct cfg80211_beacon_data {
 	struct cfg80211_mbssid_elems *mbssid_ies;
 	s8 ftm_responder;
 
-	size_t head_len, tail_len;
+	size_t head_len, tail_len, short_tail_len;
 	size_t beacon_ies_len;
 	size_t proberesp_ies_len;
 	size_t assocresp_ies_len;
@@ -1328,7 +1331,7 @@ struct cfg80211_ap_settings {
 
 	struct cfg80211_beacon_data beacon;
 
-	int beacon_interval, dtim_period;
+	int beacon_interval, dtim_period, short_beacon_period;
 	const u8 *ssid;
 	size_t ssid_len;
 	enum nl80211_hidden_ssid hidden_ssid;

base-commit: 5c111ec204d15d1c7d00428b0afdda62ff118565
-- 
2.34.1

