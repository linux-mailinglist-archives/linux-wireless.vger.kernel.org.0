Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC322B74EC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Nov 2020 04:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgKRDmY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 22:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgKRDmX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 22:42:23 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67230C0613D4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Nov 2020 19:42:22 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id 5so247049plj.8
        for <linux-wireless@vger.kernel.org>; Tue, 17 Nov 2020 19:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0q7uTzWf+NvnLsIKiQv5WVy1jGL93/4S1PO8Gde9U2o=;
        b=EDWCwX4Liz49xKw5jFNq+kGUw+J4mUiu3Wpwcwn+fykUYBS+zY5nULzCJueB2kfuKL
         eOodKs+HRtJChUgjfI0kVAcJS7qnNHkl6ZhOT2zVfH8JGABjenfuBfBrAR6N+kDCQ8xx
         TCSJJHDl3bptVBnUda9JEKzlXAKJR16LK+aII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0q7uTzWf+NvnLsIKiQv5WVy1jGL93/4S1PO8Gde9U2o=;
        b=osK+9yOWfXVOCDXUfRrUe1G82OypzMOwp8T05ha3tI2LcqA4YFRdhyATXqqQKcsNwN
         kRveKGyY5bU70VdIPtTFH2CFp5bKFyRlls5SW9ei3v3TAs2nzACRlhS/X8SiyccH8cbg
         QZ6GTjALxmst6ATaTBCyH3e5swExxiryHUm+EgCz2VTfyUQP2Il1EYTzscqjNgemZrKb
         xoOMUMReqEZTgIaJndoeIKxg3A9MqYkIEPdIWyiZ+Bkhx7mHWRA62MNI4ZmXt5RqVUia
         WPRkKDBVmTb+QY/H8OjjNWoUfuQGekREkCaiD1TYchrykccOlckr6hNiyhhcaziitJAI
         saAg==
X-Gm-Message-State: AOAM532KTMoTaA+gwdyqbhLbY2JbtwAD+3Wz8JWBT8BmDcaapBYUtGyy
        vJXdzXRCA5S/rI0YAbGNje2Vgw==
X-Google-Smtp-Source: ABdhPJxioomSZ3J7VrUGlZB+bKoULpC8AXgrL2qz07+Mw25NmF1SoFdAr0Idwd+fTwj+FQSvNZU+Vw==
X-Received: by 2002:a17:90a:4093:: with SMTP id l19mr2177198pjg.65.1605670941976;
        Tue, 17 Nov 2020 19:42:21 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id w2sm16097617pfb.104.2020.11.17.19.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 19:42:21 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        David Poole <dpoole@cradlepoint.com>,
        Ben Greear <greearb@candelatech.com>,
        John Crispin <john@phrozen.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4/4] iw: scan: fixup HE caps whitespace
Date:   Tue, 17 Nov 2020 19:39:36 -0800
Message-Id: <20201118033936.3667788-5-briannorris@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201118033936.3667788-1-briannorris@chromium.org>
References: <20201118033936.3667788-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For scans, it's nicer to drop an indentation level, because we don't
have the "interface type" section that we do in the phy-info version.

The NSS print also had an extra level of indentation, and a spare
leading space, which made it a bit inconsistent with other sections.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 util.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/util.c b/util.c
index b09bcaf743fc..00f3755b1000 100644
--- a/util.c
+++ b/util.c
@@ -992,21 +992,23 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 static void __print_he_capa(const __u16 *mac_cap,
 			    const __u16 *phy_cap,
 			    const __u16 *mcs_set, size_t mcs_len,
-			    const __u8 *ppet, int ppet_len)
+			    const __u8 *ppet, int ppet_len,
+			    bool indent)
 {
 	size_t mcs_used;
 	int i;
+	const char *pre = indent ? "\t" : "";
 
 	#define PRINT_HE_CAP(_var, _idx, _bit, _str) \
 	do { \
 		if (_var[_idx] & BIT(_bit)) \
-			printf("\t\t\t\t" _str "\n"); \
+			printf("%s\t\t\t" _str "\n", pre); \
 	} while (0)
 
 	#define PRINT_HE_CAP_MASK(_var, _idx, _shift, _mask, _str) \
 	do { \
 		if ((_var[_idx] >> _shift) & _mask) \
-			printf("\t\t\t\t" _str ": %d\n", (_var[_idx] >> _shift) & _mask); \
+			printf("%s\t\t\t" _str ": %d\n", pre, (_var[_idx] >> _shift) & _mask); \
 	} while (0)
 
 	#define PRINT_HE_MAC_CAP(...) PRINT_HE_CAP(mac_cap, __VA_ARGS__)
@@ -1015,7 +1017,7 @@ static void __print_he_capa(const __u16 *mac_cap,
 	#define PRINT_HE_PHY_CAP0(_idx, _bit, ...) PRINT_HE_CAP(phy_cap, _idx, _bit + 8, __VA_ARGS__)
 	#define PRINT_HE_PHY_CAP_MASK(...) PRINT_HE_CAP_MASK(phy_cap, __VA_ARGS__)
 
-	printf("\t\t\tHE MAC Capabilities (0x");
+	printf("%s\t\tHE MAC Capabilities (0x", pre);
 	for (i = 0; i < 3; i++)
 		printf("%04x", mac_cap[i]);
 	printf("):\n");
@@ -1055,7 +1057,7 @@ static void __print_he_capa(const __u16 *mac_cap,
 	PRINT_HE_MAC_CAP(2, 11, "UL 2x996-Tone RU");
 	PRINT_HE_MAC_CAP(2, 12, "OM Control UL MU Data Disable RX");
 
-	printf("\t\t\tHE PHY Capabilities: (0x");
+	printf("%s\t\tHE PHY Capabilities: (0x", pre);
 	for (i = 0; i < 11; i++)
 		printf("%02x", ((__u8 *)phy_cap)[i + 1]);
 	printf("):\n");
@@ -1140,12 +1142,12 @@ static void __print_he_capa(const __u16 *mac_cap,
 
 		for (j = 0; j < 2; j++) {
 			int k;
-			printf("\t\t\tHE %s MCS and NSS set %s MHz\n", j ? "TX" : "RX", bw[i]);
+			printf("%s\t\tHE %s MCS and NSS set %s MHz\n", pre, j ? "TX" : "RX", bw[i]);
 			for (k = 0; k < 8; k++) {
 				__u16 mcs = mcs_set[(i * 2) + j];
 				mcs >>= k * 2;
 				mcs &= 0x3;
-				printf("\t\t\t\t\t %d streams: ", k + 1);
+				printf("%s\t\t\t%d streams: ", pre, k + 1);
 				if (mcs == 3)
 					printf("not supported\n");
 				else
@@ -1166,7 +1168,7 @@ static void __print_he_capa(const __u16 *mac_cap,
 	}
 
 	if (ppet_len && (phy_cap[3] & BIT(15))) {
-		printf("\t\t\tPPE Threshold ");
+		printf("%s\t\tPPE Threshold ", pre);
 		for (i = 0; i < ppet_len; i++)
 			if (ppet[i])
 				printf("0x%02x ", ppet[i]);
@@ -1245,7 +1247,8 @@ void print_he_info(struct nlattr *nl_iftype)
 		ppet_len = len;
 	}
 
-	__print_he_capa(mac_cap, phy_cap, mcs_set, mcs_len, ppet, ppet_len);
+	__print_he_capa(mac_cap, phy_cap, mcs_set, mcs_len, ppet, ppet_len,
+			true);
 }
 
 void print_he_capability(const uint8_t *ie, int len)
@@ -1263,7 +1266,7 @@ void print_he_capability(const uint8_t *ie, int len)
 	mcs_set = &ie[i];
 	mcs_len = len - i;
 
-	__print_he_capa(mac_cap, phy_cap - 1, mcs_set, mcs_len, NULL, 0);
+	__print_he_capa(mac_cap, phy_cap - 1, mcs_set, mcs_len, NULL, 0, false);
 }
 
 void iw_hexdump(const char *prefix, const __u8 *buf, size_t size)
-- 
2.29.2.299.gdc1121823c-goog

