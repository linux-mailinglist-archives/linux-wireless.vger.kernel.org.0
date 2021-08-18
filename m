Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EAC3F03AB
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 14:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbhHRMXn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 08:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbhHRMXl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 08:23:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2FBC061764
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=DN2+KoIxTyDzDJQX6ceMAD/kOiZJly9ktsHN2IHvFgs=; t=1629289387; x=1630498987; 
        b=u9N5CheENvfsOaFqSOXVgoA3oJcFTrDkf+TsqXfUxU6c0213H/s7bfhhBowcFCSctciqOKhln/4
        DjTCxqG7QFYbo6FM1Fcd6xh1tWzkI/7gBA/DPoPGGrt6xexbgQnZB+ZsePxZXSFQtvZeiFTtQpEPY
        NVUUS4LShkuMHa8A4M385NhYocbyYUQG4PcQ88Q1VRxgHK2l03PY0Q4iNmpxyessTnwA1b27ll5N8
        C5vMGt0P1M8TBflcGYUGh/I5BHNH4PvVPMyKt2irbxeOKyWZyHHtF4OZv4ctFtVcz2TJ+o796ZFUx
        bT9mh+j0T79v2koGHU20N/A0iVhCC5Hwi5bw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mGKb2-00Chb1-BZ; Wed, 18 Aug 2021 14:23:04 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] iw: unify interface type list printing
Date:   Wed, 18 Aug 2021 14:22:57 +0200
Message-Id: <20210818142256.3325c72c65e4.I844f8e382b0ecee00c21886342d0bfd70e246a9f@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add two new functions print_iftype_list() and print_iftype_line()
to print interface lists, and use them where applicable.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 info.c | 30 +++++++++---------------------
 iw.h   |  2 ++
 util.c | 41 +++++++++++++++++++++++++++--------------
 3 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/info.c b/info.c
index ee2faebc2881..488466813a41 100644
--- a/info.c
+++ b/info.c
@@ -105,10 +105,9 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	struct nlattr *nl_band;
 	struct nlattr *nl_freq;
 	struct nlattr *nl_rate;
-	struct nlattr *nl_mode;
 	struct nlattr *nl_cmd;
 	struct nlattr *nl_if, *nl_ftype;
-	int rem_band, rem_freq, rem_rate, rem_mode, rem_cmd, rem_ftype, rem_if;
+	int rem_band, rem_freq, rem_rate, rem_cmd, rem_ftype, rem_if;
 	int open;
 	/*
 	 * static variables only work here, other applications need to use the
@@ -321,17 +320,13 @@ next:
 		       nla_get_u32(tb_msg[NL80211_ATTR_WIPHY_ANTENNA_TX]),
 		       nla_get_u32(tb_msg[NL80211_ATTR_WIPHY_ANTENNA_RX]));
 
-	if (tb_msg[NL80211_ATTR_SUPPORTED_IFTYPES]) {
-		printf("\tSupported interface modes:\n");
-		nla_for_each_nested(nl_mode, tb_msg[NL80211_ATTR_SUPPORTED_IFTYPES], rem_mode)
-			printf("\t\t * %s\n", iftype_name(nla_type(nl_mode)));
-	}
+	if (tb_msg[NL80211_ATTR_SUPPORTED_IFTYPES])
+		print_iftype_list("\tSupported interface modes", "\t\t",
+				  tb_msg[NL80211_ATTR_SUPPORTED_IFTYPES]);
 
-	if (tb_msg[NL80211_ATTR_SOFTWARE_IFTYPES]) {
-		printf("\tsoftware interface modes (can always be added):\n");
-		nla_for_each_nested(nl_mode, tb_msg[NL80211_ATTR_SOFTWARE_IFTYPES], rem_mode)
-			printf("\t\t * %s\n", iftype_name(nla_type(nl_mode)));
-	}
+	if (tb_msg[NL80211_ATTR_SOFTWARE_IFTYPES])
+		print_iftype_list("\tsoftware interface modes (can always be added)",
+				  "\t\t", tb_msg[NL80211_ATTR_SOFTWARE_IFTYPES]);
 
 	if (tb_msg[NL80211_ATTR_INTERFACE_COMBINATIONS]) {
 		struct nlattr *nl_combi;
@@ -373,8 +368,6 @@ next:
 			}
 
 			nla_for_each_nested(nl_limit, tb_comb[NL80211_IFACE_COMB_LIMITS], rem_limit) {
-				bool ift_comma = false;
-
 				err = nla_parse_nested(tb_limit, MAX_NL80211_IFACE_LIMIT,
 						       nl_limit, iface_limit_policy);
 				if (err || !tb_limit[NL80211_IFACE_LIMIT_TYPES]) {
@@ -385,13 +378,8 @@ next:
 				if (comma)
 					printf(", ");
 				comma = true;
-				printf("#{");
-
-				nla_for_each_nested(nl_mode, tb_limit[NL80211_IFACE_LIMIT_TYPES], rem_mode) {
-					printf("%s %s", ift_comma ? "," : "",
-						iftype_name(nla_type(nl_mode)));
-					ift_comma = true;
-				}
+				printf("#{ ");
+				print_iftype_line(tb_limit[NL80211_IFACE_LIMIT_TYPES]);
 				printf(" } <= %u", nla_get_u32(tb_limit[NL80211_IFACE_LIMIT_MAX]));
 			}
 			printf(",\n\t\t   ");
diff --git a/iw.h b/iw.h
index 7f7f4fcabb8d..f8a49697bc8b 100644
--- a/iw.h
+++ b/iw.h
@@ -218,6 +218,8 @@ void print_he_info(struct nlattr *nl_iftype);
 
 char *channel_width_name(enum nl80211_chan_width width);
 const char *iftype_name(enum nl80211_iftype iftype);
+void print_iftype_list(const char *name, const char *pfx, struct nlattr *attr);
+void print_iftype_line(struct nlattr *attr);
 const char *command_name(enum nl80211_commands cmd);
 int ieee80211_channel_to_frequency(int chan, enum nl80211_band band);
 int ieee80211_frequency_to_channel(int freq);
diff --git a/util.c b/util.c
index 9f21f5fba18e..3e3207b5c726 100644
--- a/util.c
+++ b/util.c
@@ -1176,20 +1176,39 @@ static void __print_he_capa(const __u16 *mac_cap,
 	}
 }
 
+void print_iftype_list(const char *name, const char *pfx, struct nlattr *attr)
+{
+	struct nlattr *ift;
+	int rem;
+
+	printf("%s:\n", name);
+	nla_for_each_nested(ift, attr, rem)
+		printf("%s * %s\n", pfx, iftype_name(nla_type(ift)));
+}
+
+void print_iftype_line(struct nlattr *attr)
+{
+	struct nlattr *ift;
+	bool first = true;
+	int rem;
+
+	nla_for_each_nested(ift, attr, rem) {
+		if (first)
+			first = false;
+		else
+			printf(", ");
+		printf("%s", iftype_name(nla_type(ift)));
+	}
+}
+
 void print_he_info(struct nlattr *nl_iftype)
 {
 	struct nlattr *tb[NL80211_BAND_IFTYPE_ATTR_MAX + 1];
-	struct nlattr *tb_flags[NL80211_IFTYPE_MAX + 1];
-	char *iftypes[NUM_NL80211_IFTYPES] = {
-		"Unspec", "Adhoc", "Station", "AP", "AP/VLAN", "WDS", "Monitor",
-		"Mesh", "P2P/Client", "P2P/Go", "P2P/Device", "OCB", "NAN",
-	};
 	__u16 mac_cap[3] = { 0 };
 	__u16 phy_cap[6] = { 0 };
 	__u16 mcs_set[6] = { 0 };
 	__u8 ppet[25] = { 0 };
 	size_t len;
-	int i;
 	int mcs_len = 0, ppet_len = 0;
 
 	nla_parse(tb, NL80211_BAND_IFTYPE_ATTR_MAX,
@@ -1198,14 +1217,8 @@ void print_he_info(struct nlattr *nl_iftype)
 	if (!tb[NL80211_BAND_IFTYPE_ATTR_IFTYPES])
 		return;
 
-	if (nla_parse_nested(tb_flags, NL80211_IFTYPE_MAX,
-			     tb[NL80211_BAND_IFTYPE_ATTR_IFTYPES], NULL))
-		return;
-
-	printf("\t\tHE Iftypes:");
-	for (i = 0; i < NUM_NL80211_IFTYPES; i++)
-		if (nla_get_flag(tb_flags[i]) && iftypes[i])
-			printf(" %s", iftypes[i]);
+	printf("\t\tHE Iftypes: ");
+	print_iftype_line(tb[NL80211_BAND_IFTYPE_ATTR_IFTYPES]);
 	printf("\n");
 
 	if (tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC]) {
-- 
2.31.1

