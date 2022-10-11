Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D2D5FABED
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 07:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJKFeO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 01:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJKFeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 01:34:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B034E61E
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 22:34:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g15-20020a25af8f000000b006bcad4bf46aso12578207ybh.19
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 22:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKsfHmnJLYvmbgbf5lyjIE59UbCnOCuHyzEva1Da4lY=;
        b=cyQIMS8QC1IfyVG/WawjwOGGAoyrdYqXMyQewkyKazR1r5Jq8XhVIrDfCy/JIN6E9u
         9OCNneBaKnygj0OyPlq+gUUmZxOnn+SQpEwnhj4eZglI0cQThFWeMbG5e9u/J2ghFrDu
         HY1SjDn03yZfCeDSZPt9DQ01a7rkXBjIOWW4BTI1pQIESg/NLrnxxrkOs0bSaS5dJKwl
         drMP/2YM6bXPBn5oRyO3/tR7f0zHBxDL8hVjzK3SeghUzFOTCB8C/kuM99iWtdY2dSXE
         gIT3Xiwdyise4Y3gfUKVHJQIH1Wtfu77eOz56Prm+DC4HdVDvzmTQfQViwroIUrsGpYx
         lzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKsfHmnJLYvmbgbf5lyjIE59UbCnOCuHyzEva1Da4lY=;
        b=3G/Qm4CoqOCO1PW2p1Ro/Ee8/oRsXhVlTOLl+UX4yjE/8SAaLmTMhogNGhIn/QTFzl
         T+yURTQJ7ona8cZMhvmQMVeK0bIE8u9njR2qbB/P84O1E84bk+ccFDtpNszMpIgYYne0
         WmJgBUks3vuZXqYf/xqSZhRyPUe9Hm4ch+U3eEhcEu5WO3SpO6illvxH63lfnVolzz+T
         TA4vaGwZyyPd8ynnCjQmyrAfRfP5Hoknz9d4pQSXZP8tMioO3tCsJnDKLmPQKU+yE5S3
         yGvdMJY7S61BiaQfKfus9q7dxKBd89AB6DCLM0qoOpKi2Q8Dswj1u7uXwnHdkDQJDHCw
         fCRw==
X-Gm-Message-State: ACrzQf1cCEAHWyXGwJjOxf27CAZ+HGguJ1DvZPKsv/WFW9nEiapvWSue
        O2rXOrpqweAcO1wMY39c5KYVi6gOYU0=
X-Google-Smtp-Source: AMsMyM6m1C34PIFe/YFO9QtdLwTwRq3B4ES+piXtULXXXU8gheFFffycwRjat23wpHavYq5KD95bbs4DgYg=
X-Received: from jaewan.seo.corp.google.com ([2401:fa00:d:11:d139:8094:2bf9:de9a])
 (user=jaewan job=sendgmr) by 2002:a25:800d:0:b0:6be:eba9:2c79 with SMTP id
 m13-20020a25800d000000b006beeba92c79mr20963330ybk.573.1665466452272; Mon, 10
 Oct 2022 22:34:12 -0700 (PDT)
Date:   Tue, 11 Oct 2022 14:34:05 +0900
In-Reply-To: <20220923015550.1292547-1-jaewan@google.com>
Mime-Version: 1.0
References: <20220923015550.1292547-1-jaewan@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011053405.332375-1-jaewan@google.com>
Subject: [PATCH v2] iw: info: print PMSR capabilities
From:   Jaewan Kim <jaewan@google.com>
To:     johannes@sipsolutions.net
Cc:     jaewan@google.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Print PMSR and FTM capabilities if any.

Signed-off-by: Jaewan Kim <jaewan@google.com>
---
 info.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/info.c b/info.c
index 21ed07b..eb257f8 100644
--- a/info.c
+++ b/info.c
@@ -169,6 +169,124 @@ static void ext_feat_print(enum nl80211_ext_feature_index idx)
 	}
 }
 
+static void __print_ftm_capability(struct nlattr *ftm_capa)
+{
+#define PRINT_FTM_FLAG(T, NAME) \
+	do { \
+		if (T[NL80211_PMSR_FTM_CAPA_ATTR_##NAME]) \
+			printf("\t\t\t" #NAME "\n"); \
+	} while (0)
+
+#define PRINT_FTM_U8(T, NAME) \
+	do { \
+		if (T[NL80211_PMSR_FTM_CAPA_ATTR_##NAME]) \
+			printf("\t\t\t" #NAME ": %d\n", \
+				nla_get_u8(T[NL80211_PMSR_FTM_CAPA_ATTR_##NAME])); \
+	} while (0)
+
+	struct nlattr *tb[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1];
+	int ret;
+
+	printf("\t\tFTM (Fine time measurement or Flight time measurement)\n");
+
+	ret = nla_parse_nested(tb, NL80211_PMSR_FTM_CAPA_ATTR_MAX, ftm_capa,
+			       NULL);
+	if (ret)
+		return;
+
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PREAMBLES]) {
+#define PRINT_PREAMBLE(P, V) \
+	do { \
+		if (P | NL80211_PREAMBLE_##V) \
+			printf(" " #V); \
+	} while (0)
+
+		uint32_t preambles =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PREAMBLES]);
+		printf("\t\t\tPreambles:");
+
+		PRINT_PREAMBLE(preambles, LEGACY);
+		PRINT_PREAMBLE(preambles, HT);
+		PRINT_PREAMBLE(preambles, VHT);
+		PRINT_PREAMBLE(preambles, DMG);
+		printf("\n");
+#undef PRINT_PREAMBLE
+	}
+	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_BANDWIDTHS]) {
+#define PRINT_BANDWIDTH(B, V) \
+	do { \
+		if (B | NL80211_CHAN_WIDTH_##V) \
+			printf(" " #V); \
+	} while (0)
+
+		uint32_t bandwidth =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_BANDWIDTHS]);
+		printf("\t\t\tBandwidth:");
+		PRINT_BANDWIDTH(bandwidth, 20_NOHT);
+		PRINT_BANDWIDTH(bandwidth, 20);
+		PRINT_BANDWIDTH(bandwidth, 40);
+		PRINT_BANDWIDTH(bandwidth, 80);
+		PRINT_BANDWIDTH(bandwidth, 80P80);
+		PRINT_BANDWIDTH(bandwidth, 160);
+		PRINT_BANDWIDTH(bandwidth, 5);
+		PRINT_BANDWIDTH(bandwidth, 10);
+		PRINT_BANDWIDTH(bandwidth, 1);
+		PRINT_BANDWIDTH(bandwidth, 2);
+		PRINT_BANDWIDTH(bandwidth, 4);
+		PRINT_BANDWIDTH(bandwidth, 8);
+		PRINT_BANDWIDTH(bandwidth, 16);
+		PRINT_BANDWIDTH(bandwidth, 320);
+		printf("\n");
+#undef PRINT_BANDWIDTH
+	}
+	PRINT_FTM_U8(tb, MAX_BURSTS_EXPONENT);
+	PRINT_FTM_U8(tb, MAX_FTMS_PER_BURST);
+	PRINT_FTM_FLAG(tb, ASAP);
+	PRINT_FTM_FLAG(tb, NON_ASAP);
+	PRINT_FTM_FLAG(tb, REQ_LCI);
+	PRINT_FTM_FLAG(tb, REQ_CIVICLOC);
+	PRINT_FTM_FLAG(tb, TRIGGER_BASED);
+	PRINT_FTM_FLAG(tb, NON_TRIGGER_BASED);
+
+#undef PRINT_FTM_U8
+#undef PRINT_FTM_FLAG
+}
+
+static void print_pmsr_capabilities(struct nlattr *pmsr_capa)
+{
+	struct nlattr *tb[NL80211_PMSR_ATTR_MAX + 1];
+	struct nlattr *nla;
+	int size;
+	int ret;
+
+	printf("\tPeer measurement (PMSR)\n");
+	ret = nla_parse_nested(tb, NL80211_PMSR_ATTR_MAX, pmsr_capa, NULL);
+	if (ret) {
+		printf("\t\tMalformed PMSR\n");
+		return;
+	}
+
+	if (tb[NL80211_PMSR_ATTR_MAX_PEERS])
+		printf("\t\tMax peers: %d\n",
+		       nla_get_u32(tb[NL80211_PMSR_ATTR_MAX_PEERS]));
+	if (tb[NL80211_PMSR_ATTR_REPORT_AP_TSF])
+		printf("\t\tREPORT_AP_TSF\n");
+	if (tb[NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR])
+		printf("\t\tRANDOMIZE_MAC_ADDR\n");
+
+	if (tb[NL80211_PMSR_ATTR_TYPE_CAPA]) {
+		nla_for_each_nested(nla, tb[NL80211_PMSR_ATTR_TYPE_CAPA], size) {
+			switch (nla_type(nla)) {
+			case NL80211_PMSR_TYPE_FTM:
+				__print_ftm_capability(nla);
+				break;
+			}
+		}
+	} else {
+		printf("\t\tPMSR type is missing\n");
+	}
+}
+
 static int print_phy_handler(struct nl_msg *msg, void *arg)
 {
 	struct nlattr *tb_msg[NL80211_ATTR_MAX + 1];
@@ -741,6 +859,9 @@ broken_combination:
 			pat->max_pattern_len, pat->max_pkt_offset, rule->max_delay);
 	}
 
+	if (tb_msg[NL80211_ATTR_PEER_MEASUREMENTS])
+		print_pmsr_capabilities(tb_msg[NL80211_ATTR_PEER_MEASUREMENTS]);
+
 	if (tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA])
 		printf("\tMaximum associated stations in AP mode: %u\n",
 		       nla_get_u16(tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA]));
-- 
2.38.0.rc1.362.ged0d419d3c-goog

