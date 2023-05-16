Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66931705598
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjEPSCr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 14:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEPSCq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 14:02:46 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D27E0
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 11:02:45 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0DA1FB8006C
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 18:02:42 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 8805213C2B0;
        Tue, 16 May 2023 11:02:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8805213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684260161;
        bh=9wzoQXDCuK8zVJxElKPiOjahf8PcuvnqVfzJAFELXcg=;
        h=From:To:Cc:Subject:Date:From;
        b=VxRWtSllgcOzkSMFT3K534E2y4z02sjioiOviXMr5SfG+Rhlx1zwmtbJoX3e2ONc7
         ua2ia8wYujX5vLe9GR+8nuhl9q3tuO3vZtrP55nj9yjYfJ0LdnxGtIrIVJp8UGeZIu
         qSr3OUVrXpEYybaqlFeQu77rMFU8syGFsikRLdNc=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] iw:  Fix EHT rates printing.
Date:   Tue, 16 May 2023 11:02:38 -0700
Message-Id: <20230516180238.673624-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1684260162-hnxkoY8BPs7Z
X-MDID-O: us5;ut7;1684260162;hnxkoY8BPs7Z;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The 20Mhz rates thing is a union with the others, so print one or
the other.  This appears to fix the output of the mcs/bw printout.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 util.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/util.c b/util.c
index 31b0308..75f415e 100644
--- a/util.c
+++ b/util.c
@@ -1541,33 +1541,29 @@ static void __print_eht_capa(int band,
 			printf("%s\t\tEHT bw=20 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
 			       pre, mcs[i],
 			       mcs_set[i] & 0xf, mcs_set[i] >> 4);
-	}
-
-	mcs_set += 4;
-	if (he_phy_cap[0] & (BIT(2) << 8)) {
-		for (i = 0; i < 3; i++)
-			printf("%s\t\tEHT bw <= 80 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-			       pre, mcs[i + 1],
-			       mcs_set[i] & 0xf, mcs_set[i] >> 4);
-
-	}
-
-	mcs_set += 3;
-	if (he_phy_cap[0] & (BIT(3) << 8)) {
-		for (i = 0; i < 3; i++)
-			printf("%s\t\tEHT bw=160 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-			       pre, mcs[i + 1],
-			       mcs_set[i] & 0xf, mcs_set[i] >> 4);
-
-	}
+	} else {
+		if (he_phy_cap[0] & (BIT(2) << 8)) {
+			for (i = 0; i < 3; i++)
+				printf("%s\t\tEHT bw <= 80 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
+				       pre, mcs[i + 1],
+				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
+		}
+		mcs_set += 3;
 
-	mcs_set += 3;
-	if (band == NL80211_BAND_6GHZ && (phy_cap[0] & BIT(1))) {
-		for (i = 0; i < 3; i++)
-			printf("%s\t\tEHT bw=320 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-			       pre, mcs[i + 1],
-			       mcs_set[i] & 0xf, mcs_set[i] >> 4);
+		if (he_phy_cap[0] & (BIT(3) << 8)) {
+			for (i = 0; i < 3; i++)
+				printf("%s\t\tEHT bw=160 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
+				       pre, mcs[i + 1],
+				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
+		}
 
+		mcs_set += 3;
+		if (band == NL80211_BAND_6GHZ && (phy_cap[0] & BIT(1))) {
+			for (i = 0; i < 3; i++)
+				printf("%s\t\tEHT bw=320 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
+				       pre, mcs[i + 1],
+				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
+		}
 	}
 
 	if (ppet && ppet_len && (phy_cap[1] & BIT(11))) {
-- 
2.40.0

