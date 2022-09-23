Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FC35E71A5
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Sep 2022 03:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiIWB4A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 21:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiIWBz6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 21:55:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F34AD1EAD
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 18:55:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3452b545544so93758857b3.3
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 18:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=sxnOOJBAwzgFm5fMQp8qgSoOX1cblrvpJPOf5XuKf6w=;
        b=jNBPxpoFI7X8mM2ukhAI1QnyzA2JjatZpykqv/H43rTeJe3Jk4MsL+1U6oBGYGmUKG
         dDAL2g27js2wZ/WHdF1iglXf/3EPQt1ET3yYuRTgaTo/+1duTV3fmCwJ3jZhjUqlW+HT
         IK4D+u5W0O5WOsxxsJxXlzISKeOvlLD5dvVjb8RpymMDGr7b5QtKLvZpsskcDrfGmShm
         MqNY2utsbPGXpW1qleon9dFCLns7opKsM8GRCrhIQxqi70u+t7YQk2DLF4AJd+PjsdZt
         xmOBgZ+glf5h0hHR/kK4KXdxCZ+eOlQ1vLKtE/tS6I7lpWssbGQgub5KwleZu4LGtEJ+
         CXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=sxnOOJBAwzgFm5fMQp8qgSoOX1cblrvpJPOf5XuKf6w=;
        b=w6oFw01LUXVAKOhOjuz6KgdGwc6Xbi4GEY+vGJgc76njB4OjKV/KwC7fyAwyWn81TK
         9XPZ3R0Wt854Eri6DyRWUj9KBFDBOyBT/gfBzJNTECSxroUtu36W/wKXHzI1dfJGTVFV
         xnVWUJUU4mHRarQQ1p69TRPBkWRJnLfUVZoAJ3uQQ5rjJ4GapOkqMO6B31EljeNk6RqE
         3uDArkaarIcyhsS8NKfYbwF5IqomJs3e4JaQeOFontA9J5nNvgjMZ10LaHbrHoxSRRIh
         H+2TfzCWPR7gnOVurw7Q6qMDd+AERdJF8kceU8GN3gVLqkAdmsS5rJNqH6InwAHKp+lh
         gpPg==
X-Gm-Message-State: ACrzQf34Y02CYp5cwxiCumOHPO79JANwiidX/2fKyqvaDGM95Oocj//c
        47kgIEZchWWAMOsTLS8HGyR5z3EY1pU=
X-Google-Smtp-Source: AMsMyM6v9uFcUjM7N+ddJsu3jAQN7sp9zpYwtuWZ1jVhLQW5GwtBKyVB4hnOJkxp2k7sN7pOD9v0aXLhPA0=
X-Received: from jaewan.seo.corp.google.com ([2401:fa00:d:11:9163:eba9:8197:7223])
 (user=jaewan job=sendgmr) by 2002:a25:d47:0:b0:6b0:29ba:fc58 with SMTP id
 68-20020a250d47000000b006b029bafc58mr7200050ybn.496.1663898156586; Thu, 22
 Sep 2022 18:55:56 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:55:50 +0900
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220923015550.1292547-1-jaewan@google.com>
Subject: [PATCH] iw: info: print PMSR capabilities
From:   Jaewan Kim <jaewan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Jaewan Kim <jaewan@google.com>
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
 info.c |   3 ++
 iw.h   |   1 +
 util.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/info.c b/info.c
index 21ed07b..d13fc16 100644
--- a/info.c
+++ b/info.c
@@ -741,6 +741,9 @@ broken_combination:
 			pat->max_pattern_len, pat->max_pkt_offset, rule->max_delay);
 	}
 
+	if (tb_msg[NL80211_ATTR_PEER_MEASUREMENTS])
+		print_pmsr_capabilities(tb_msg[NL80211_ATTR_PEER_MEASUREMENTS]);
+
 	if (tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA])
 		printf("\tMaximum associated stations in AP mode: %u\n",
 		       nla_get_u16(tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA]));
diff --git a/iw.h b/iw.h
index e712c59..0707cb4 100644
--- a/iw.h
+++ b/iw.h
@@ -221,6 +221,7 @@ void print_vht_info(__u32 capa, const __u8 *mcs);
 void print_he_capability(const uint8_t *ie, int len);
 void print_he_info(struct nlattr *nl_iftype);
 void print_eht_info(struct nlattr *nl_iftype, int band);
+void print_pmsr_capabilities(const struct nlattr *pmsr_capa);
 
 char *channel_width_name(enum nl80211_chan_width width);
 const char *iftype_name(enum nl80211_iftype iftype);
diff --git a/util.c b/util.c
index 8a2ba10..18f6e71 100644
--- a/util.c
+++ b/util.c
@@ -1673,6 +1673,124 @@ void print_he_capability(const uint8_t *ie, int len)
 	__print_he_capa(mac_cap, phy_cap - 1, mcs_set, mcs_len, NULL, 0, false);
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
+			printf("\t\t\t" #NAME "=\n", \
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
+			printf(#V " "); \
+	} while (0)
+
+		uint32_t preambles =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_PREAMBLES]);
+		printf("\t\t\tPreambles=");
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
+			printf(#V " "); \
+	} while (0)
+
+		uint32_t bandwidth =
+			nla_get_u32(tb[NL80211_PMSR_FTM_CAPA_ATTR_BANDWIDTHS]);
+		printf("\t\t\tBandwidth=");
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
+void print_pmsr_capabilities(struct nlattr *pmsr_capa)
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
+		printf("\t\tMax peers=%d\n",
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
 void iw_hexdump(const char *prefix, const __u8 *buf, size_t size)
 {
 	size_t i;
-- 
2.37.3.998.g577e59143f-goog

