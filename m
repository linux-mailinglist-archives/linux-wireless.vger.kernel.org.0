Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1637CF17A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 09:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjJSHkv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 03:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjJSHku (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 03:40:50 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7994126
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 00:40:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27db9fdec0dso2355550a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1697701248; x=1698306048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iMXFMiqxRF4ZrXNIYCvGVYO9hGUxAK8o3g4c4gAh3KE=;
        b=nBaPH/ccJuIcnDd/R5tI5PgtnwYSsJiT34qmA0uUqQSMteOkp/zusfuvgNQLUVBVkN
         onj6Yypn70p0cC7vc6gG8a7ZAwS0fZCD82hOCJI72gpSyakQhKne9jeBzPs9fvw8HyRf
         6DCOv4GGFcAEAtmKvZTgMgyjODHLHnzUMRjMWfgR0EqwldLlPfAWbk5kPkN3IZ/B1209
         CWjbDKE3y/dzjKlg++LIVy5DxH7UA5LBQ0EAMNq5JcXbJ6TirQXN04hSq93hRAvNiWgx
         tK+zoddIXME75lLTiC/ZgrY6lrrueO3r76EZ6qqbJYPxb09V1nl1NGfr/zWGhLALZk45
         XB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697701248; x=1698306048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMXFMiqxRF4ZrXNIYCvGVYO9hGUxAK8o3g4c4gAh3KE=;
        b=CNZbPuS6d/7WNoIz+x5ahoQ4k2t33TSKD83iRXZyYzSNpEPy2xyTtB/tq1rF8nPq40
         EnZpn3Ow2tNVs4rCp+2/3XF9p34zT/jpV/jOB+KA9E0MuDlZ36pp5ZaNbDOeSp6o/ATa
         mRU5CKeqUzis1wFvSBqGgxXFv4Udp7uVlGQVRdoIS0D8lx908h2LUd6vuQ9Mw/WOcaHJ
         edTAy3IeQHP+mAQApe31EwRcnufaPQzKDGhOMBLy3XASxA8hodB79X+WRJxv8OMeYwVO
         3kEUUgbax8/IGi5zGt3MbIMWa4kXP2HGObX2eHve4sch718UhPACmGZz9vby1wu5WMN3
         D7hQ==
X-Gm-Message-State: AOJu0YwD9SixFL6PJpG5CszESN+xmAk8J7PzmjsXsYpb+Exp0EIovH6p
        MYcdOpUpnUjqAvxwXWkGlwQpggWBYpynYEaXT8WJIg==
X-Google-Smtp-Source: AGHT+IEbnIn01e5b95iRqFGhcFZQkgfgAMpHpqUewp8vZWEhmfzndViiagmXcqLeMU7Wxl1aNaWJ9g==
X-Received: by 2002:a17:90b:3c0f:b0:27d:e1c:5345 with SMTP id pb15-20020a17090b3c0f00b0027d0e1c5345mr1380758pjb.15.1697701247832;
        Thu, 19 Oct 2023 00:40:47 -0700 (PDT)
Received: from bassem.sydney.mm.lcl (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.googlemail.com with ESMTPSA id rj12-20020a17090b3e8c00b00262eb0d141esm980596pjb.28.2023.10.19.00.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 00:40:47 -0700 (PDT)
From:   Bassem Dawood <bassem@morsemicro.com>
To:     linux-wireless@vger.kernel.org
Cc:     Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH] iw: S1G: add 802.11ah support for link command display
Date:   Thu, 19 Oct 2023 18:40:19 +1100
Message-Id: <20231019074019.2246629-1-bassem@morsemicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Amending the link command which depends on kernal changes for
802.11ah bandwidths/MCS/NSS NL80211_RATE_INFO_ attributes.

S1G frequency offset being used as well for the MHz units print.

Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 link.c    |  9 +++++++--
 station.c | 10 ++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/link.c b/link.c
index a090100..a7ee963 100644
--- a/link.c
+++ b/link.c
@@ -29,6 +29,7 @@ static int link_bss_handler(struct nl_msg *msg, void *arg)
 	static struct nla_policy bss_policy[NL80211_BSS_MAX + 1] = {
 		[NL80211_BSS_TSF] = { .type = NLA_U64 },
 		[NL80211_BSS_FREQUENCY] = { .type = NLA_U32 },
+		[NL80211_BSS_FREQUENCY_OFFSET] = { .type = NLA_U32 },
 		[NL80211_BSS_BSSID] = { },
 		[NL80211_BSS_BEACON_INTERVAL] = { .type = NLA_U16 },
 		[NL80211_BSS_CAPABILITY] = { .type = NLA_U16 },
@@ -41,6 +42,7 @@ static int link_bss_handler(struct nl_msg *msg, void *arg)
 	char mac_addr[20], dev[20], link_addr[20];
 	int link_id = -1;
 	const char *indent = "\t";
+	int freq_offset = 0;
 
 	nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
 		  genlmsg_attrlen(gnlh, 0), NULL);
@@ -121,9 +123,12 @@ static int link_bss_handler(struct nl_msg *msg, void *arg)
 			  nla_len(bss[NL80211_BSS_INFORMATION_ELEMENTS]),
 			  false, result->mld ? PRINT_LINK_MLO_LINK : PRINT_LINK);
 
+	if (bss[NL80211_BSS_FREQUENCY_OFFSET])
+		freq_offset = nla_get_u32(bss[NL80211_BSS_FREQUENCY_OFFSET]);
+
 	if (bss[NL80211_BSS_FREQUENCY])
-		printf("%sfreq: %d\n", indent,
-			nla_get_u32(bss[NL80211_BSS_FREQUENCY]));
+		printf("%sfreq: %d.%d\n", indent,
+			nla_get_u32(bss[NL80211_BSS_FREQUENCY]), freq_offset);
 
 	if (nla_get_u32(bss[NL80211_BSS_STATUS]) != NL80211_BSS_STATUS_ASSOCIATED)
 		return NL_SKIP;
diff --git a/station.c b/station.c
index da1feae..bf7c0f5 100644
--- a/station.c
+++ b/station.c
@@ -241,6 +241,16 @@ void parse_bitrate(struct nlattr *bitrate_attr, char *buf, int buflen)
 		pos += snprintf(pos, buflen - (pos - buf), " 160MHz");
 	if (rinfo[NL80211_RATE_INFO_320_MHZ_WIDTH])
 		pos += snprintf(pos, buflen - (pos - buf), " 320MHz");
+	if (rinfo[NL80211_RATE_INFO_1_MHZ_WIDTH])
+		pos += snprintf(pos, buflen - (pos - buf), " 1MHz");
+	if (rinfo[NL80211_RATE_INFO_2_MHZ_WIDTH])
+		pos += snprintf(pos, buflen - (pos - buf), " 2MHz");
+	if (rinfo[NL80211_RATE_INFO_4_MHZ_WIDTH])
+		pos += snprintf(pos, buflen - (pos - buf), " 4MHz");
+	if (rinfo[NL80211_RATE_INFO_8_MHZ_WIDTH])
+		pos += snprintf(pos, buflen - (pos - buf), " 8MHz");
+	if (rinfo[NL80211_RATE_INFO_16_MHZ_WIDTH])
+		pos += snprintf(pos, buflen - (pos - buf), " 16MHz");
 	if (rinfo[NL80211_RATE_INFO_SHORT_GI])
 		pos += snprintf(pos, buflen - (pos - buf), " short GI");
 	if (rinfo[NL80211_RATE_INFO_VHT_NSS])
-- 
2.25.1

