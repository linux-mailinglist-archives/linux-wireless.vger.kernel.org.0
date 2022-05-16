Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CF5528064
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiEPJIH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 05:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbiEPJIA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 05:08:00 -0400
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E191D0E5
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 02:07:57 -0700 (PDT)
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 3E9FB20238;
        Mon, 16 May 2022 11:07:56 +0200 (CEST)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 3C903202E4;
        Mon, 16 May 2022 11:07:56 +0200 (CEST)
Message-ID: <405f5ed2c434846f8ab2730b34288c5f649b8915.camel@freebox.fr>
Subject: [PATCH] iw: handle VHT extended NSS
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 16 May 2022 11:07:56 +0200
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon May 16 11:07:56 2022 +0200 (CEST)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No change in "Supported Channel Width" output format when extended NSS
is not supported.

Sample output for a PHY with 1/2 NSS ratio:

VHT Capabilities (0xb39b79f2):
	Max MPDU length: 11454
	Supported Channel Width: 160Mhz (1/2 NSS) 80+80Mhz (1/2 NSS)
	[...]
VHT extended NSS: supported

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 util.c | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 179 insertions(+), 5 deletions(-)

diff --git a/util.c b/util.c
index f8ab6ca..8a2ba10 100644
--- a/util.c
+++ b/util.c
@@ -922,9 +922,159 @@ void print_ht_mcs(const __u8 *mcs)
 	}
 }
 
+struct vht_nss_ratio {
+	bool valid;
+	int bw_20;
+	int bw_40;
+	int bw_80;
+	int bw_160;
+	int bw_80_80;
+};
+
+/*
+ * indexed by [chan_width][ext_nss_bw], ratio in 1/4 unit
+ */
+static const struct vht_nss_ratio nss_ratio_tbl[3][4] = {
+	{
+		/* chan_width == 0, ext_nss_bw == 0 */
+		{
+			.valid = true,
+			.bw_20 = 4,
+			.bw_40 = 4,
+			.bw_80 = 4,
+		},
+		/* chan_width == 0, ext_nss_bw == 1 */
+		{
+			.valid = true,
+			.bw_20 = 4,
+			.bw_40 = 4,
+			.bw_80 = 4,
+			.bw_160 = 2,
+		},
+		/* chan_width == 0, ext_nss_bw == 2 */
+		{
+			.valid = true,
+			.bw_20 = 4,
+			.bw_40 = 4,
+			.bw_80 = 4,
+			.bw_160 = 2,
+			.bw_80_80 = 2,
+		},
+		/* chan_width == 0, ext_nss_bw == 3 */
+		{
+			.valid = true,
+			.bw_20 = 4,
+			.bw_40 = 4,
+			.bw_80 = 4,
+			.bw_160 = 3,
+			.bw_80_80 = 3,
+		},
+	},
+	{
+		/* chan_width == 1, ext_nss_bw == 0 */
+		{
+			.valid = true,
+			.bw_20 = 4,
+			.bw_40 = 4,
+			.bw_80 = 4,
+			.bw_160 = 4,
+		},
+		/* chan_width == 1, ext_nss_bw == 1 */
+		{
+			.valid = true,
+			.bw_20 = 4,
+			.bw_40 = 4,
+			.bw_80 = 4,
+			.bw_160 = 4,
+			.bw_80_80 = 2,
+		},
+		/* chan_width == 1, ext_nss_bw == 2 */
+		{
+			.valid = true,
+			.bw_20 = 4,
+			.bw_40 = 4,
+			.bw_80 = 4,
+			.bw_160 = 4,
+			.bw_80_80 = 3,
+		},
+		/* chan_width == 1, ext_nss_bw == 3 */
+		{
+			.valid = true,
+			.bw_20 = 8,
+			.bw_40 = 8,
+			.bw_80 = 8,
+			.bw_160 = 8,
+			.bw_80_80 = 1,
+		},
+	},
+	{
+		/* chan_width == 2, ext_nss_bw == 0 */
+		{
+			.valid = true,
+			.bw_20 = 4,
+			.bw_40 = 4,
+			.bw_80 = 4,
+			.bw_160 = 4,
+			.bw_80_80 = 4,
+		},
+		/* chan_width == 2, ext_nss_bw == 1 */
+		{},
+		/* chan_width == 2, ext_nss_bw == 2 */
+		{},
+		/* chan_width == 2, ext_nss_bw == 3 */
+		{
+			.valid = true,
+			.bw_20 = 8,
+			.bw_40 = 8,
+			.bw_80 = 8,
+			.bw_160 = 4,
+			.bw_80_80 = 4,
+		},
+	},
+};
+
+static void print_nss_ratio_value(int ratio)
+{
+	const char *rstr;
+
+	switch (ratio) {
+	case 4:
+		return;
+	case 3:
+		rstr = "3/4";
+		break;
+	case 2:
+		rstr = "1/2";
+		break;
+	case 8:
+		rstr = "x2";
+		break;
+	default:
+		rstr = "undef";
+		break;
+	}
+
+	printf("(%s NSS) ", rstr);
+}
+
+static void print_nss_ratio(const char *str, bool force_show, int ratio)
+{
+	if (!ratio)
+		return;
+	if (ratio == 4) {
+		if (force_show)
+			printf("%s ", str);
+	} else {
+		printf("%s ", str);
+		print_nss_ratio_value(ratio);
+	}
+}
+
 void print_vht_info(__u32 capa, const __u8 *mcs)
 {
 	__u16 tmp;
+	__u32 supp_chan_width, ext_nss_bw;
+	const struct vht_nss_ratio *nss_tbl;
 	int i;
 
 	printf("\t\tVHT Capabilities (0x%.8x):\n", capa);
@@ -942,13 +1092,34 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 	case 2: printf("11454\n"); break;
 	case 3: printf("(reserved)\n");
 	}
+
 	printf("\t\t\tSupported Channel Width: ");
-	switch ((capa >> 2) & 3) {
-	case 0: printf("neither 160 nor 80+80\n"); break;
-	case 1: printf("160 MHz\n"); break;
-	case 2: printf("160 MHz, 80+80 MHz\n"); break;
-	case 3: printf("(reserved)\n");
+	supp_chan_width = (capa >> 2) & 3;
+	ext_nss_bw = (capa >> 30) & 3;
+	nss_tbl = &nss_ratio_tbl[supp_chan_width][ext_nss_bw];
+
+	if (!nss_tbl->valid)
+		printf("(reserved)\n");
+	else if (nss_tbl->bw_20 == 4 &&
+		 nss_tbl->bw_40 == 4 &&
+		 nss_tbl->bw_80 == 4 &&
+		 (!nss_tbl->bw_160 || nss_tbl->bw_160 == 4) &&
+		 (!nss_tbl->bw_80_80 || nss_tbl->bw_80_80 == 4)) {
+		/* old style print format */
+		switch (supp_chan_width) {
+		case 0: printf("neither 160 nor 80+80\n"); break;
+		case 1: printf("160 MHz\n"); break;
+		case 2: printf("160 MHz, 80+80 MHz\n"); break;
+		}
+	} else {
+		print_nss_ratio("20Mhz", false, nss_tbl->bw_20);
+		print_nss_ratio("40Mhz", false, nss_tbl->bw_40);
+		print_nss_ratio("80Mhz", false, nss_tbl->bw_80);
+		print_nss_ratio("160Mhz", false, nss_tbl->bw_160);
+		print_nss_ratio("80+80Mhz", false, nss_tbl->bw_80_80);
+		printf("\n");
 	}
+
 	PRINT_VHT_CAPA(4, "RX LDPC");
 	PRINT_VHT_CAPA(5, "short GI (80 MHz)");
 	PRINT_VHT_CAPA(6, "short GI (160/80+80 MHz)");
@@ -994,6 +1165,9 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 	}
 	tmp = mcs[6] | (mcs[7] << 8);
 	printf("\t\tVHT TX highest supported: %d Mbps\n", tmp & 0x1fff);
+
+	printf("\t\tVHT extended NSS: %ssupported\n",
+	       (tmp & (1 << 13)) ? "" : "not ");
 }
 
 static void __print_he_capa(const __u16 *mac_cap,
-- 
2.17.1


