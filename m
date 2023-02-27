Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B123D6A4F5E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 00:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjB0XBk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 18:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0XBj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 18:01:39 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD52594E
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 15:01:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso301987pjv.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 15:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HkIHJq3xE5S5peTHYfsS0nBk51ToEU9dr9IqKppwkWs=;
        b=W6R9pHySbDR3QVXnWe9HYnXDgfi3Nty99S1gayi/48MDLJNfJI/8OwtzMWpO+i8lbH
         TUs8IRM66dzA2SwytfWK4dOD6+vThSPQfcuRoLzdJOG+CizMPKZtNGnF24Q7FG2yiOO2
         mGBL6w7pb2Ks88At73e1FtFM0LVIIEtUbWIAn833rR9CrMtJSr2H32GwUuNN4IvUEsmv
         nJD7Is2TEwAaZmNkrCtLwTWblugPCAmXCfHtkCCF0DMpkQBuSe1AnI5Q1SbDTIdkfDnf
         jpmZ1wrG9kNk5oWCAO8t+N3lNL8MdwR3EQB9unajRnNIJ3dnRiBTufqfzdLlvwVF1mIA
         ICNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkIHJq3xE5S5peTHYfsS0nBk51ToEU9dr9IqKppwkWs=;
        b=EtvV2xKOgW9qw0gg5OHF5FQYEqzaRtEGN5yjoLwSvONkFXVZSyHuE2xKUDlb3bmN5f
         ZFt2+icygZPBr+DzfSICTjafKw2ylvOYHZQZ3TtkwMXc96YxgeR9lASpCEIat1blBHLz
         ldX73oeRlHBo1YBSK0CvU3T8f+Rwbrtm4zrPIa6/ciJd6+HzrGX1QPc/yK5N45cS1gmC
         ge8m3+aQ3L7FUkP474tGnpsQlF/sEzDGk8LU1b+yigYfe2eQe+px6WHZOvuNgyBOIAmz
         xx+OWSlL51ELd76vrg9HLJyGBiruLQFLIYx4bezAsWjFnObhbKq9dmgkX1a6wzzHX3k4
         puKA==
X-Gm-Message-State: AO0yUKXtgX2paHCs5r5BldkXIGD8T5Hi9xRc40dUIgVLSc+QZY6TfscG
        Qm7RUKr6ORUYORfc8rAguh81cXsLn2fzvEVj
X-Google-Smtp-Source: AK7set+9SLeDpTMqxxi/kL62J+zo5iJlGT2rOfv0AijLYpW46msBXwmWUUfemQ8mydOFvhaE4+vDig==
X-Received: by 2002:a17:902:ba83:b0:199:1b8a:42a8 with SMTP id k3-20020a170902ba8300b001991b8a42a8mr510239pls.6.1677538895743;
        Mon, 27 Feb 2023 15:01:35 -0800 (PST)
Received: from virs-pc-014.morsemicro.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id iz18-20020a170902ef9200b00192fe452e17sm5118298plb.162.2023.02.27.15.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 15:01:35 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
X-Google-Original-From: Gilad Itzkovitch <gilad.itzkovitch@virscient.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v2] iw: S1G: add parsing for 802.11ah scan IE's
Date:   Tue, 28 Feb 2023 12:01:27 +1300
Message-Id: <20230227230127.709496-1-gilad.itzkovitch@virscient.com>
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

From: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>

In order to support scan display for 802.11ah, this change adds
parsing for S1G capabilities, operation, and short beacon interval
information elements.

Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 iw.h   |   5 ++
 scan.c | 109 ++++++++++++++++++++++++++++-
 util.c | 218 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 330 insertions(+), 2 deletions(-)

diff --git a/iw.h b/iw.h
index e712c59..b15e6ca 100644
--- a/iw.h
+++ b/iw.h
@@ -221,6 +221,7 @@ void print_vht_info(__u32 capa, const __u8 *mcs);
 void print_he_capability(const uint8_t *ie, int len);
 void print_he_info(struct nlattr *nl_iftype);
 void print_eht_info(struct nlattr *nl_iftype, int band);
+void print_s1g_capability(const uint8_t *caps);
 
 char *channel_width_name(enum nl80211_chan_width width);
 const char *iftype_name(enum nl80211_iftype iftype);
@@ -256,6 +257,9 @@ int get_cf1(const struct chanmode *chanmode, unsigned long freq);
 
 int parse_random_mac_addr(struct nl_msg *msg, char *addrs);
 
+char *s1g_ss_max_support(__u8 maxss);
+char *s1g_ss_min_support(__u8 minss);
+
 #define SCHED_SCAN_OPTIONS "[interval <in_msecs> | scan_plans [<interval_secs:iterations>*] <interval_secs>] "	\
 	"[delay <in_secs>] [freqs <freq>+] [matches [ssid <ssid>]+]] [active [ssid <ssid>]+|passive] "	\
 	"[randomise[=<addr>/<mask>]] [coloc] [flush]"
@@ -269,6 +273,7 @@ char *hex2bin(const char *hex, char *buf);
 int set_bitrates(struct nl_msg *msg, int argc, char **argv,
 		 enum nl80211_attrs attr);
 
+int calc_s1g_ch_center_freq(__u8 ch_index, __u8 s1g_oper_class);
 
 /* sections */
 DECLARE_SECTION(ap);
diff --git a/scan.c b/scan.c
index dfc136a..a3280bc 100644
--- a/scan.c
+++ b/scan.c
@@ -1673,6 +1673,101 @@ static void print_mesh_conf(const uint8_t type, uint8_t len,
 		printf("\t\t\t Mesh Power Save Level\n");
 }
 
+static void print_s1g_capa(const uint8_t type, uint8_t len,
+			    const uint8_t *data,
+			    const struct print_ies_data *ie_buffer)
+{
+	printf("\n");
+	print_s1g_capability(data);
+}
+
+static void print_short_beacon_int(const uint8_t type, uint8_t len,
+			    const uint8_t *data,
+			    const struct print_ies_data *ie_buffer)
+{
+	printf(" %d\n", (data[1] << 8) | data[0]);
+}
+
+static void print_s1g_oper(const uint8_t type, uint8_t len,
+			    const uint8_t *data,
+			    const struct print_ies_data *ie_buffer)
+{
+	int oper_ch_width, prim_ch_width;
+	int prim_ch_width_subfield = data[0] & 0x1;
+
+	prim_ch_width = 2;
+
+	/* B1-B4 BSS channel width subfield */
+	switch ((data[0] >> 1) & 0xf) {
+	case 0:
+		oper_ch_width = 1;
+		prim_ch_width = 1;
+		if (!prim_ch_width_subfield) {
+			oper_ch_width = -1;
+			prim_ch_width = -1;
+		}
+	break;
+	case 1:
+		oper_ch_width = 2;
+		if (prim_ch_width_subfield)
+			prim_ch_width = 1;
+		break;
+	case 3:
+		oper_ch_width = 4;
+		if (prim_ch_width_subfield)
+			prim_ch_width = 1;
+		break;
+	case 7:
+		oper_ch_width = 8;
+		if (prim_ch_width_subfield)
+			prim_ch_width = 1;
+		break;
+	case 15:
+		oper_ch_width = 16;
+		if (prim_ch_width_subfield)
+			prim_ch_width = 1;
+		break;
+	default:
+		oper_ch_width = -1;
+		prim_ch_width = -1;
+		break;
+	}
+
+	printf("\n");
+	printf("\t\tChannel width:\n");
+	if (oper_ch_width == -1 || prim_ch_width == -1) {
+		printf("\t\t\tBSS primary channel width: invalid\n");
+		printf("\t\t\tBSS operating channel width: invalid\n");
+	} else {
+		printf("\t\t\tBSS primary channel width: %d MHz\n", prim_ch_width);
+		printf("\t\t\tBSS operating channel width: %d MHz\n", oper_ch_width);
+	}
+	if (data[0] & BIT(5))
+		printf("\t\t\t1 MHz primary channel located at the lower side of 2 MHz\n");
+	else
+		printf("\t\t\t1 MHz primary channel located at the upper side of 2 MHz\n");
+
+	if (data[0] & BIT(7))
+		printf("\t\t\tMCS 10 not recommended\n");
+
+	printf("\t\t* operating class: %d\n", data[1]);
+	printf("\t\t* primary channel number: %d\n", data[2]);
+
+	printf("\t\t* channel index: %d\n", data[3]);
+
+	printf("\t\tMax S1G MCS Map:\n");
+	printf("\t\t\tFor 1 SS: %s\n", s1g_ss_max_support((data[4] >> 2) & 0x3));
+	printf("\t\t\tFor 2 SS: %s\n", s1g_ss_max_support((data[4] >> 6) & 0x3));
+	printf("\t\t\tFor 3 SS: %s\n", s1g_ss_max_support((data[5] >> 2) & 0x3));
+	printf("\t\t\tFor 4 SS: %s\n", s1g_ss_max_support((data[5] >> 6) & 0x3));
+
+	printf("\t\tMin S1G MCS Map:\n");
+	printf("\t\t\tFor 1 SS: %s\n", s1g_ss_min_support(data[4] & 0x3));
+	printf("\t\t\tFor 2 SS: %s\n", s1g_ss_min_support((data[4] >> 4) & 0x3));
+	printf("\t\t\tFor 3 SS: %s\n", s1g_ss_min_support(data[5] & 0x3));
+	printf("\t\t\tFor 4 SS: %s\n", s1g_ss_min_support((data[5] >> 4) & 0x3));
+}
+
 struct ie_print {
 	const char *name;
 	void (*print)(const uint8_t type, uint8_t len, const uint8_t *data,
@@ -1745,6 +1840,9 @@ static const struct ie_print ieprinters[] = {
 	[108] = { "802.11u Advertisement", print_11u_advert, 0, 255, BIT(PRINT_SCAN), },
 	[111] = { "802.11u Roaming Consortium", print_11u_rcon, 2, 255, BIT(PRINT_SCAN), },
 	[195] = { "Transmit Power Envelope", print_tx_power_envelope, 2, 5, BIT(PRINT_SCAN), },
+	[214] = { "Short beacon interval", print_short_beacon_int, 2, 2, BIT(PRINT_SCAN), },
+	[217] = { "S1G capabilities", print_s1g_capa, 15, 15, BIT(PRINT_SCAN), },
+	[232] = { "S1G operation", print_s1g_oper, 6, 6, BIT(PRINT_SCAN), },
 };
 
 static void print_wifi_wpa(const uint8_t type, uint8_t len, const uint8_t *data,
@@ -2323,7 +2421,8 @@ void print_ies(unsigned char *ie, int ielen, bool unknown,
 	while (ielen >= 2 && ielen - 2 >= ie[1]) {
 		if (ie[0] < ARRAY_SIZE(ieprinters) &&
 		    ieprinters[ie[0]].name &&
-		    ieprinters[ie[0]].flags & BIT(ptype)) {
+		    ieprinters[ie[0]].flags & BIT(ptype) &&
+			    ie[1] > 0) {
 			print_ie(&ieprinters[ie[0]],
 				 ie[0], ie[1], ie + 2, &ie_buffer);
 		} else if (ie[0] == 221 /* vendor */) {
@@ -2416,6 +2515,7 @@ static int print_bss_handler(struct nl_msg *msg, void *arg)
 	static struct nla_policy bss_policy[NL80211_BSS_MAX + 1] = {
 		[NL80211_BSS_TSF] = { .type = NLA_U64 },
 		[NL80211_BSS_FREQUENCY] = { .type = NLA_U32 },
+		[NL80211_BSS_FREQUENCY_OFFSET] = { .type = NLA_U32 },
 		[NL80211_BSS_BSSID] = { },
 		[NL80211_BSS_BEACON_INTERVAL] = { .type = NLA_U16 },
 		[NL80211_BSS_CAPABILITY] = { .type = NLA_U16 },
@@ -2488,7 +2588,12 @@ static int print_bss_handler(struct nl_msg *msg, void *arg)
 	}
 	if (bss[NL80211_BSS_FREQUENCY]) {
 		int freq = nla_get_u32(bss[NL80211_BSS_FREQUENCY]);
-		printf("\tfreq: %d\n", freq);
+		if (bss[NL80211_BSS_FREQUENCY_OFFSET])
+			printf("\tfreq: %d.%d\n", freq,
+			    nla_get_u32(bss[NL80211_BSS_FREQUENCY_OFFSET]));
+		else
+			printf("\tfreq: %d\n", freq);
+
 		if (freq > 45000)
 			is_dmg = true;
 	}
diff --git a/util.c b/util.c
index 8a2ba10..b3cbe28 100644
--- a/util.c
+++ b/util.c
@@ -1765,3 +1765,221 @@ int parse_random_mac_addr(struct nl_msg *msg, char *addrs)
  nla_put_failure:
 	return -ENOBUFS;
 }
+
+char *s1g_ss_max_support(__u8 maxss)
+{
+	switch (maxss) {
+	case 0: return "Max S1G-MCS 2";
+	case 1: return "Max S1G-MCS 7";
+	case 2: return "Max S1G-MCS 9";
+	case 3: return "Not supported";
+	default: return "";
+	}
+}
+
+char *s1g_ss_min_support(__u8 minss)
+{
+	switch (minss) {
+	case 0: return "no minimum restriction";
+	case 1: return "MCS 0 not recommended";
+	case 2: return "MCS 0 and 1 not recommended";
+	case 3: return "invalid";
+	default: return "";
+	}
+}
+
+void print_s1g_capability(const uint8_t *caps)
+{
+#define PRINT_S1G_CAP(_cond, _str) \
+	do { \
+		if (_cond) \
+			printf("\t\t\t" _str "\n"); \
+	} while (0)
+
+	static char buf[20];
+	int offset = 0;
+	uint8_t cap = caps[0];
+
+	/* S1G Capabilities Information subfield */
+	if (cap)
+		printf("\t\tByte[0]: 0x%02x\n", cap);
+
+	PRINT_S1G_CAP((cap & BIT(0)), "S1G PHY: S1G_LONG PPDU Format");
+
+	if ((cap >> 1) & 0x1f) {
+		offset = sprintf(buf, "SGI support:");
+		offset += sprintf(buf + offset, "%s", ((cap >> 1) & 0x1) ? " 1" : "");
+		offset += sprintf(buf + offset, "%s", ((cap >> 1) & 0x2) ? " 2" : "");
+		offset += sprintf(buf + offset, "%s", ((cap >> 1) & 0x4) ? " 4" : "");
+		offset += sprintf(buf + offset, "%s", ((cap >> 1) & 0x8) ? " 8" : "");
+		offset += sprintf(buf + offset, "%s", ((cap >> 1) & 0x10) ? " 16" : "");
+		offset += sprintf(buf + offset, " MHz");
+		printf("\t\t\t%s\n", buf);
+	}
+
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x0, "Channel width: 1, 2 MHz");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x1, "Channel width: 1, 2, 4 MHz");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x2, "Channel width: 1, 2, 4, 8 MHz");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x3, "Channel width: 1, 2, 4, 8, 16 MHz");
+
+	cap = caps[1];
+
+	if (cap)
+		printf("\t\tByte[1]: 0x%02x\n", cap);
+
+	PRINT_S1G_CAP((cap & BIT(0)), "Rx LDPC");
+	PRINT_S1G_CAP((cap & BIT(1)), "Tx STBC");
+	PRINT_S1G_CAP((cap & BIT(2)), "Rx STBC");
+	PRINT_S1G_CAP((cap & BIT(3)), "SU Beamformer");
+	PRINT_S1G_CAP((cap & BIT(4)), "SU Beamformee");
+	if (cap & BIT(4))
+		printf("\t\t\tBeamformee STS: %d\n", (cap >> 5) + 1);
+
+	cap = caps[2];
+	printf("\t\tByte[2]: 0x%02x\n", cap);
+
+	if (caps[1] & BIT(3))
+		printf("\t\t\tSounding dimensions: %d\n", (cap & 0x7) + 1);
+
+	PRINT_S1G_CAP((cap & BIT(3)), "MU Beamformer");
+	PRINT_S1G_CAP((cap & BIT(4)), "MU Beamformee");
+	PRINT_S1G_CAP((cap & BIT(5)), "+HTC-VHT Capable");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x0, "No support for Traveling Pilot");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x1, "Supports 1 STS Traveling Pilot");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x3, "Supports 1 and 2 STS Traveling Pilot");
+
+	cap = caps[3];
+	printf("\t\tByte[3]: 0x%02x\n", cap);
+	PRINT_S1G_CAP((cap & BIT(0)), "RD Responder");
+	/* BIT(1) in Byte 3 or BIT(25) in all capabilities is reserved */
+	PRINT_S1G_CAP(((cap & BIT(2)) == 0x0), "Max MPDU length: 3895 bytes");
+	PRINT_S1G_CAP((cap & BIT(2)), "Max MPDU length: 7991 bytes");
+
+	if (compute_ampdu_length((cap >> 2) & 0x3)) {
+		printf("\t\t\tMaximum AMPDU length: %d bytes (exponent: 0x0%02x)\n",
+		       compute_ampdu_length((cap >> 2) & 0x3), (cap >> 2) & 0x3);
+	} else {
+		printf("\t\t\tMaximum AMPDU length: unrecognized bytes (exponent: %d)\n",
+		       (cap >> 2) & 0x3);
+	}
+
+	printf("\t\t\tMinimum MPDU time spacing: %s (0x%02x)\n",
+	       print_ampdu_space((cap >> 5) & 0x7), (cap >> 5) & 0x7);
+
+	cap = caps[4];
+	printf("\t\tByte[4]: 0x%02x\n", cap);
+	PRINT_S1G_CAP((cap & BIT(0)), "Uplink sync capable");
+	PRINT_S1G_CAP((cap & BIT(1)), "Dynamic AID");
+	PRINT_S1G_CAP((cap & BIT(2)), "BAT");
+	PRINT_S1G_CAP((cap & BIT(3)), "TIM ADE");
+	PRINT_S1G_CAP((cap & BIT(4)), "Non-TIM");
+	PRINT_S1G_CAP((cap & BIT(5)), "Group AID");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x0, "Sensor and non-sensor STAs");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x1, "Only sensor STAs");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x2, "Only non-sensor STAs");
+
+	cap = caps[5];
+	printf("\t\tByte[5]: 0x%02x\n", cap);
+	PRINT_S1G_CAP((cap & BIT(0)), "Centralized authentication control");
+	PRINT_S1G_CAP((cap & BIT(1)), "Distributed authentication control");
+	PRINT_S1G_CAP((cap & BIT(2)), "A-MSDU supported");
+	PRINT_S1G_CAP((cap & BIT(3)), "A-MPDU supported");
+	PRINT_S1G_CAP((cap & BIT(4)), "Asymmetric BA supported");
+	PRINT_S1G_CAP((cap & BIT(5)), "Flow control supported");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x0, "Sectorization operation not supported");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x1, "TXOP-based sectorization operation");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x2, "only group sectorization operation");
+	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x3, "Group and TXOP-based sectorization operations");
+
+	cap = caps[6];
+	if (cap)
+		printf("\t\tByte[6]: 0x%02x\n", cap);
+
+	PRINT_S1G_CAP((cap & BIT(0)), "OBSS mitigation");
+	PRINT_S1G_CAP((cap & BIT(1)), "Fragment BA");
+	PRINT_S1G_CAP((cap & BIT(2)), "NDP PS-Poll");
+	PRINT_S1G_CAP((cap & BIT(3)), "RAW operation");
+	PRINT_S1G_CAP((cap & BIT(4)), "Page slicing");
+	PRINT_S1G_CAP((cap & BIT(5)), "TXOP sharing smplicit Ack");
+
+	/* Only in case +HTC-VHT Capable is 0x1 */
+	if (caps[2] & BIT(5)) {
+		PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x0, "Not provide VHT MFB (No Feedback)");
+		PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x2, "Provides only unsolicited VHT MFB");
+		PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x3,
+				      "Provides both feedback and unsolicited VHT MFB");
+	}
+
+	cap = caps[7];
+	printf("\t\tByte[7]: 0x%02x\n", cap);
+	PRINT_S1G_CAP((cap & BIT(0)), "TACK support as PS-Poll response");
+	PRINT_S1G_CAP((cap & BIT(1)), "Duplicate 1 MHz");
+	PRINT_S1G_CAP((cap & BIT(2)), "MCS negotiation");
+	PRINT_S1G_CAP((cap & BIT(3)), "1 MHz control response preamble");
+	PRINT_S1G_CAP((cap & BIT(4)), "NDP beamforming report poll");
+	PRINT_S1G_CAP((cap & BIT(5)), "Unsolicited dynamic AID");
+	PRINT_S1G_CAP((cap & BIT(6)), "Sector training operation");
+	PRINT_S1G_CAP((cap & BIT(7)), "Temporary PS mode switch");
+
+	cap = caps[8];
+	if (cap)
+		printf("\t\tByte[8]: 0x%02x\n", cap);
+
+	PRINT_S1G_CAP((cap & BIT(0)), "TWT grouping");
+	PRINT_S1G_CAP((cap & BIT(1)), "BDT capable");
+	printf("\t\t\tColor: %u\n", (cap >> 2) & 0x7);
+	PRINT_S1G_CAP((cap & BIT(5)), "TWT requester");
+	PRINT_S1G_CAP((cap & BIT(6)), "TWT responder");
+	PRINT_S1G_CAP((cap & BIT(7)), "PV1 frame support");
+
+	cap = caps[9];
+	if (cap)
+		printf("\t\tByte[9]: 0x%02x\n", cap);
+
+	PRINT_S1G_CAP((cap & BIT(0)), "Link Adaptation without NDP CMAC PPDU capable");
+	/* Rest of byte 9 bits are reserved */
+
+	/* Supported S1G-MCS and NSS Set subfield */
+	/* Rx S1G-MCS Map */
+	cap = caps[10];
+	printf("\t\tMax Rx S1G MCS Map: 0x%02x\n", cap);
+	printf("\t\t\tFor 1 SS: %s\n", s1g_ss_max_support(cap & 0x3));
+	printf("\t\t\tFor 2 SS: %s\n", s1g_ss_max_support((cap >> 2) & 0x3));
+	printf("\t\t\tFor 3 SS: %s\n", s1g_ss_max_support((cap >> 4) & 0x3));
+	printf("\t\t\tFor 4 SS: %s\n", s1g_ss_max_support((cap >> 6) & 0x3));
+
+	/* Rx Long GI data rate field comprises of 9 bits */
+	cap = caps[11];
+	if (cap || caps[12] & 0x1)
+		printf("\t\t\tRx Highest Long GI Data Rate: %u Mbps\n",
+		       cap + ((caps[12] & 0x1) << 8));
+
+	/* Tx S1G-MCS Map */
+	cap = caps[12];
+	printf("\t\tMax Tx S1G MCS Map: 0x%02x\n", cap);
+	printf("\t\t\tFor 1 SS: %s\n", s1g_ss_max_support((cap >> 1) & 0x3));
+	printf("\t\t\tFor 2 SS: %s\n", s1g_ss_max_support((cap >> 3) & 0x3));
+	printf("\t\t\tFor 3 SS: %s\n", s1g_ss_max_support((cap >> 5) & 0x3));
+	printf("\t\t\tFor 4 SS: %s\n", s1g_ss_max_support(((cap >> 7) & 0x1) +
+	       ((caps[13] << 1) & 0x2)));
+
+	/* Tx Long GI data rate field comprises of 9 bits */
+	cap = caps[13];
+	if (((cap >> 7) & 0x7f) || (caps[14] & 0x3))
+		printf("\t\t\tTx Highest Long GI Data Rate: %u Mbps\n", ((cap >> 7) & 0x7f) +
+			((caps[14] & 0x3) << 7));
+
+	/* Rx and Tx single spatial streams and S1G MCS Map for 1 MHz */
+	cap = (caps[15] >> 2) & 0xf;
+	PRINT_S1G_CAP((cap & 0x3) == 0x0, "Rx single SS for 1 MHz: as in Rx S1G MCS Map");
+	PRINT_S1G_CAP((cap & 0x3) == 0x1, "Rx single SS for 1 MHz: single SS and S1G-MCS 2");
+	PRINT_S1G_CAP((cap & 0x3) == 0x2, "Rx single SS for 1 MHz: single SS and S1G-MCS 7");
+	PRINT_S1G_CAP((cap & 0x3) == 0x3, "Rx single SS for 1 MHz: single SS and S1G-MCS 9");
+	cap = (cap >> 2) & 0x3;
+	PRINT_S1G_CAP((cap & 0x3) == 0x0, "Tx single SS for 1 MHz: as in Tx S1G MCS Map");
+	PRINT_S1G_CAP((cap & 0x3) == 0x1, "Tx single SS for 1 MHz: single SS and S1G-MCS 2");
+	PRINT_S1G_CAP((cap & 0x3) == 0x2, "Tx single SS for 1 MHz: single SS and S1G-MCS 7");
+	PRINT_S1G_CAP((cap & 0x3) == 0x3, "Tx single SS for 1 MHz: single SS and S1G-MCS 9");
+	/* Last 2 bits are reserved */
+#undef PRINT_S1G_CAP
+}

base-commit: d6fd2757f7aab638022ffa635e32e21594ec382d
-- 
2.25.1

