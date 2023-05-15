Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06B703F70
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 23:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245354AbjEOVPd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 17:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245308AbjEOVPc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 17:15:32 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E14DA27C
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 14:15:31 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 882C970007B
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 21:15:26 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id EA58213C2B0;
        Mon, 15 May 2023 14:15:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EA58213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684185326;
        bh=7Aztba1opyGoq8zbkB4ZnH5PiSepjILqor8LDujQ9Ck=;
        h=From:To:Cc:Subject:Date:From;
        b=IwVwJqmT6FX/3f2eiYokU7oY+A3Kqkw0Rd5QfzKhIAyyJVJ4mSbVVYFs2ZSWh8cTZ
         i+4gcP8ZDw1yLAgpo89kra+gUM9dVkIV144JpEaBnT64RbDt0IkldiF+y9JRxKs2Ki
         YiHs/LrOOR4CVG4feFJ5UWZHjYdwo6a7W+m1iCg4=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] iw:  Only print EHT info if fields are defined.
Date:   Mon, 15 May 2023 14:15:24 -0700
Message-Id: <20230515211524.470451-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1684185327-Q1gK2gZZ6qvF
X-MDID-O: us5;ut7;1684185327;Q1gK2gZZ6qvF;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Without this patch, a bunch of blank EHT fields are printed when
iw phy info is run against an /ax phy devices.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 util.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/util.c b/util.c
index 8a2ba10..31b0308 100644
--- a/util.c
+++ b/util.c
@@ -1588,6 +1588,7 @@ void print_eht_info(struct nlattr *nl_iftype, int band)
 	__u8 ppet[31] = { 0 };
 	__u16 he_phy_cap[6] = { 0 };
 	size_t len, mcs_len = 0, ppet_len = 0;
+	bool did_one = false;
 
 	nla_parse(tb, NL80211_BAND_IFTYPE_ATTR_MAX,
 		  nla_data(nl_iftype), nla_len(nl_iftype), NULL);
@@ -1595,11 +1596,8 @@ void print_eht_info(struct nlattr *nl_iftype, int band)
 	if (!tb[NL80211_BAND_IFTYPE_ATTR_IFTYPES])
 		return;
 
-	printf("\t\tEHT Iftypes: ");
-	print_iftype_line(tb[NL80211_BAND_IFTYPE_ATTR_IFTYPES]);
-	printf("\n");
-
 	if (tb[NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MAC]) {
+		did_one = true;
 		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MAC]);
 		if (len > sizeof(mac_cap))
 			len = sizeof(mac_cap);
@@ -1609,6 +1607,7 @@ void print_eht_info(struct nlattr *nl_iftype, int band)
 	}
 
 	if (tb[NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PHY]) {
+		did_one = true;
 		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PHY]);
 
 		if (len > sizeof(phy_cap))
@@ -1620,6 +1619,7 @@ void print_eht_info(struct nlattr *nl_iftype, int band)
 	}
 
 	if (tb[NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MCS_SET]) {
+		did_one = true;
 		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_EHT_CAP_MCS_SET]);
 		if (len > sizeof(mcs_set))
 			len = sizeof(mcs_set);
@@ -1632,6 +1632,7 @@ void print_eht_info(struct nlattr *nl_iftype, int band)
 	}
 
 	if (tb[NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE]) {
+		did_one = true;
 		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE]);
 		if (len > sizeof(ppet))
 			len = sizeof(ppet);
@@ -1651,6 +1652,13 @@ void print_eht_info(struct nlattr *nl_iftype, int band)
 		       len);
 	}
 
+	if (!did_one)
+		return;
+
+	printf("\t\tEHT Iftypes: ");
+	print_iftype_line(tb[NL80211_BAND_IFTYPE_ATTR_IFTYPES]);
+	printf("\n");
+
 	__print_eht_capa(band, mac_cap, phy_cap, mcs_set, mcs_len, ppet, ppet_len,
 			 he_phy_cap, true);
 }
-- 
2.40.0

