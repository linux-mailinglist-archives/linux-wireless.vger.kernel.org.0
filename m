Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F662B74EA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Nov 2020 04:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKRDmT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 22:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgKRDmT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 22:42:19 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C73C0613D4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Nov 2020 19:42:19 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id v21so262998pgi.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Nov 2020 19:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/LaYu7vNqtmnOmBx1mzr8JcKAfCDfyUf5hKrbUfA630=;
        b=GGupgtpXB6A2CKTMckO7UvMDqEJlEMiDtSCk8Ef7E+vWeWl5ustxu43PGARLBFq0FO
         VwMQx0Sp4ETW0ctOT3KsMPem/v08/64O4qlYAbzylnEJ3bP5WIuP+fRxONnEqG1KpxCn
         RuuSKSZlWPqklPVE4F6LG34GT+hypuFPAqOJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/LaYu7vNqtmnOmBx1mzr8JcKAfCDfyUf5hKrbUfA630=;
        b=BRYb2OivrUa63wODThQKNvlPSWblyHUpEC9ZBBqttAZSRTwIMrSOxrgwpl3Nx7Yuyv
         dXnHyIu6UlrLoJpQwFdAFV4Z0QLfwqLGmWBrXIMEKOgKvIt2Ryxrl2VVA1z10t5qoRHb
         kmrVq3EKh0IXOeClbkZZRPW9zFd58NnNW/Z1439d/FB9wXreaoo02Gi3rVBeeqbTq5P6
         Z5QYjrumO6ikvCSxeQO7C4aejXcd5PB0H5wTeNvyo29NS4QtxFEJisWjO6Isv35gVJVe
         ct8apMsE6MDmrpVb8JSrjL8q/HhHMJsws79WlJ6+mVVlz1Xp0GYtp4pRERh3nxop4k4o
         RmGw==
X-Gm-Message-State: AOAM532ZXpPyfRyWkgnXGehQbui3Hx1Xx8KOHPeAaqmHEjFErBx2IGn7
        UtiFF+2dL2w/QcAnaXd1I6ePsA==
X-Google-Smtp-Source: ABdhPJw/9azfJ5ND8OZb1jndZDMbKNV6Ql1uII33VN60ga/PjSzueXjA/BfvjMEldTD/zhiKM4j+4Q==
X-Received: by 2002:a63:c644:: with SMTP id x4mr6443717pgg.421.1605670938571;
        Tue, 17 Nov 2020 19:42:18 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id w2sm16097617pfb.104.2020.11.17.19.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 19:42:17 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        David Poole <dpoole@cradlepoint.com>,
        Ben Greear <greearb@candelatech.com>,
        John Crispin <john@phrozen.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/4] iw: util: factor out HE capability parser
Date:   Tue, 17 Nov 2020 19:39:34 -0800
Message-Id: <20201118033936.3667788-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201118033936.3667788-1-briannorris@chromium.org>
References: <20201118033936.3667788-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We're going to use this for scan parsing.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 util.c | 144 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 80 insertions(+), 64 deletions(-)

diff --git a/util.c b/util.c
index 0a9083c613a4..4591cbf77ec1 100644
--- a/util.c
+++ b/util.c
@@ -989,19 +989,11 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 	printf("\t\tVHT TX highest supported: %d Mbps\n", tmp & 0x1fff);
 }
 
-void print_he_info(struct nlattr *nl_iftype)
+static void __print_he_capa(const __u16 *mac_cap,
+			    const __u16 *phy_cap,
+			    const __u16 *mcs_set, size_t mcs_len,
+			    const __u8 *ppet, int ppet_len)
 {
-	struct nlattr *tb[NL80211_BAND_IFTYPE_ATTR_MAX + 1];
-	struct nlattr *tb_flags[NL80211_IFTYPE_MAX + 1];
-	char *iftypes[NUM_NL80211_IFTYPES] = {
-		"Unspec", "Adhoc", "Station", "AP", "AP/VLAN", "WDS", "Monitor",
-		"Mesh", "P2P/Client", "P2P/Go", "P2P/Device", "OCB", "NAN",
-	};
-	__u16 mac_cap[3] = { 0 };
-	__u16 phy_cap[6] = { 0 };
-	__u16 mcs_set[6] = { 0 };
-	__u8 ppet[25] = { 0 };
-	size_t len;
 	int i;
 
 	#define PRINT_HE_CAP(_var, _idx, _bit, _str) \
@@ -1022,30 +1014,6 @@ void print_he_info(struct nlattr *nl_iftype)
 	#define PRINT_HE_PHY_CAP0(_idx, _bit, ...) PRINT_HE_CAP(phy_cap, _idx, _bit + 8, __VA_ARGS__)
 	#define PRINT_HE_PHY_CAP_MASK(...) PRINT_HE_CAP_MASK(phy_cap, __VA_ARGS__)
 
-	nla_parse(tb, NL80211_BAND_IFTYPE_ATTR_MAX,
-		  nla_data(nl_iftype), nla_len(nl_iftype), NULL);
-
-	if (!tb[NL80211_BAND_IFTYPE_ATTR_IFTYPES])
-		return;
-
-	if (nla_parse_nested(tb_flags, NL80211_IFTYPE_MAX,
-			     tb[NL80211_BAND_IFTYPE_ATTR_IFTYPES], NULL))
-		return;
-
-	printf("\t\tHE Iftypes:");
-	for (i = 0; i < NUM_NL80211_IFTYPES; i++)
-		if (nla_get_flag(tb_flags[i]) && iftypes[i])
-			printf(" %s", iftypes[i]);
-	printf("\n");
-
-	if (tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC]) {
-		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC]);
-		if (len > sizeof(mac_cap))
-			len = sizeof(mac_cap);
-		memcpy(mac_cap,
-		       nla_data(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC]),
-		       len);
-	}
 	printf("\t\t\tHE MAC Capabilities (0x");
 	for (i = 0; i < 3; i++)
 		printf("%04x", mac_cap[i]);
@@ -1086,15 +1054,6 @@ void print_he_info(struct nlattr *nl_iftype)
 	PRINT_HE_MAC_CAP(2, 11, "UL 2x996-Tone RU");
 	PRINT_HE_MAC_CAP(2, 12, "OM Control UL MU Data Disable RX");
 
-	if (tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY]) {
-		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY]);
-
-		if (len > sizeof(phy_cap) - 1)
-			len = sizeof(phy_cap) - 1;
-		memcpy(&((__u8 *)phy_cap)[1],
-		       nla_data(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY]),
-		       len);
-	}
 	printf("\t\t\tHE PHY Capabilities: (0x");
 	for (i = 0; i < 11; i++)
 		printf("%02x", ((__u8 *)phy_cap)[i + 1]);
@@ -1165,15 +1124,6 @@ void print_he_info(struct nlattr *nl_iftype)
 	PRINT_HE_PHY_CAP(5, 4, "RX Full BW SU Using HE MU PPDU with Compression SIGB");
 	PRINT_HE_PHY_CAP(5, 5, "RX Full BW SU Using HE MU PPDU with Non-Compression SIGB");
 
-	if (tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET]) {
-		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET]);
-		if (len > sizeof(mcs_set))
-			len = sizeof(mcs_set);
-		memcpy(mcs_set,
-		       nla_data(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET]),
-		       len);
-	}
-
 	for (i = 0; i < 3; i++) {
 		__u8 phy_cap_support[] = { BIT(1) | BIT(2), BIT(3), BIT(4) };
 		char *bw[] = { "<= 80", "160", "80+80" };
@@ -1182,6 +1132,10 @@ void print_he_info(struct nlattr *nl_iftype)
 		if ((phy_cap[0] & (phy_cap_support[i] << 8)) == 0)
 			continue;
 
+		/* Supports more, but overflow? Abort. */
+		if ((i * 2 + 2) * sizeof(mcs_set[0]) >= mcs_len)
+			return;
+
 		for (j = 0; j < 2; j++) {
 			int k;
 			printf("\t\t\tHE %s MCS and NSS set %s MHz\n", j ? "TX" : "RX", bw[i]);
@@ -1199,7 +1153,76 @@ void print_he_info(struct nlattr *nl_iftype)
 		}
 	}
 
-	len = 0;
+	if (ppet_len && (phy_cap[3] & BIT(15))) {
+		printf("\t\t\tPPE Threshold ");
+		for (i = 0; i < ppet_len; i++)
+			if (ppet[i])
+				printf("0x%02x ", ppet[i]);
+		printf("\n");
+	}
+}
+
+void print_he_info(struct nlattr *nl_iftype)
+{
+	struct nlattr *tb[NL80211_BAND_IFTYPE_ATTR_MAX + 1];
+	struct nlattr *tb_flags[NL80211_IFTYPE_MAX + 1];
+	char *iftypes[NUM_NL80211_IFTYPES] = {
+		"Unspec", "Adhoc", "Station", "AP", "AP/VLAN", "WDS", "Monitor",
+		"Mesh", "P2P/Client", "P2P/Go", "P2P/Device", "OCB", "NAN",
+	};
+	__u16 mac_cap[3] = { 0 };
+	__u16 phy_cap[6] = { 0 };
+	__u16 mcs_set[6] = { 0 };
+	__u8 ppet[25] = { 0 };
+	size_t len;
+	int i;
+	int mcs_len = 0, ppet_len = 0;
+
+	nla_parse(tb, NL80211_BAND_IFTYPE_ATTR_MAX,
+		  nla_data(nl_iftype), nla_len(nl_iftype), NULL);
+
+	if (!tb[NL80211_BAND_IFTYPE_ATTR_IFTYPES])
+		return;
+
+	if (nla_parse_nested(tb_flags, NL80211_IFTYPE_MAX,
+			     tb[NL80211_BAND_IFTYPE_ATTR_IFTYPES], NULL))
+		return;
+
+	printf("\t\tHE Iftypes:");
+	for (i = 0; i < NUM_NL80211_IFTYPES; i++)
+		if (nla_get_flag(tb_flags[i]) && iftypes[i])
+			printf(" %s", iftypes[i]);
+	printf("\n");
+
+	if (tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC]) {
+		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC]);
+		if (len > sizeof(mac_cap))
+			len = sizeof(mac_cap);
+		memcpy(mac_cap,
+		       nla_data(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC]),
+		       len);
+	}
+
+	if (tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY]) {
+		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY]);
+
+		if (len > sizeof(phy_cap) - 1)
+			len = sizeof(phy_cap) - 1;
+		memcpy(&((__u8 *)phy_cap)[1],
+		       nla_data(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_PHY]),
+		       len);
+	}
+
+	if (tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET]) {
+		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET]);
+		if (len > sizeof(mcs_set))
+			len = sizeof(mcs_set);
+		memcpy(mcs_set,
+		       nla_data(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET]),
+		       len);
+		mcs_len = len;
+	}
+
 	if (tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE]) {
 		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE]);
 		if (len > sizeof(ppet))
@@ -1207,17 +1230,10 @@ void print_he_info(struct nlattr *nl_iftype)
 		memcpy(ppet,
 		       nla_data(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE]),
 		       len);
+		ppet_len = len;
 	}
 
-	if (len && (phy_cap[3] & BIT(15))) {
-		size_t i;
-
-		printf("\t\t\tPPE Threshold ");
-		for (i = 0; i < len; i++)
-			if (ppet[i])
-				printf("0x%02x ", ppet[i]);
-		printf("\n");
-	}
+	__print_he_capa(mac_cap, phy_cap, mcs_set, mcs_len, ppet, ppet_len);
 }
 
 void iw_hexdump(const char *prefix, const __u8 *buf, size_t size)
-- 
2.29.2.299.gdc1121823c-goog

