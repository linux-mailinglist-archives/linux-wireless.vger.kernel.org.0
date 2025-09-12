Return-Path: <linux-wireless+bounces-27262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2C8B5486E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 11:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6481A1890FC2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EA6287248;
	Fri, 12 Sep 2025 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LWBP4qvX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F905280035
	for <linux-wireless@vger.kernel.org>; Fri, 12 Sep 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670887; cv=none; b=V08jn2QHOIpuCvXMv7zqWVI08giipLOI4aNamutc2kKkVg6A8BEejvxk6rXetwTRDol9wNaifFV6d09d5uktJh0mA4AUJucX84Mpcv8S+zdGmVCDgiSPdxKRgDPUdGo+ZOE/QSUdu81TtSIdUHdOlMMtuSUls+WUSZhFNhylY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670887; c=relaxed/simple;
	bh=O6w+zdm0kpcd4g0brYBy2hvGPnf1RU+6ceAO0/TZ8jA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WedbZ1knTwgxcf2tsYGLvFz/QLRylLmF+Y1tSuvTGLvq2B7Pd8rOYEfyjUMbVfEnLNpZSrYbGpgavbtcavfD5IxAkI1F2U9nflok/e0hnIy8VVvkBOZzmkZDhXogOILkNbvHZ5w6xtSG6BjIGK3kT9/26s3thtB21JfPvvN19OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LWBP4qvX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58C9sZttD495143, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757670875; bh=Vu4cds/Lv6MZWTrzeJlbaYvNnatRf1Hfgv9RGxBj/t0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=LWBP4qvXEOpLuQGhgC5U6wt85cpdBneZV3DEvqXplMHTe5cluY51MN5Y8OoV7jNXZ
	 VZLIdgsnlF3VBVTNcnCroePZima67n3aJbAq/yhKgds9QQhGMPGSr4TaoWrhS6SkPZ
	 0ZBBmH1g3bxLxYjoTp3D7KJCuB5j4knoDaqgIUoD3wMvW72HneDgAXqMGgBBKghAQL
	 dVrdztJGyE/9To/5xJEnCAz0i4ddT9LxCPmr5nPbLVEJhg0xNo7BZBr8DZfbdCwPmI
	 RlJz6xxBeoJsxJszg7Mghrai35US52J+bU7FWPxFR/lHoiCDByYeLN4jfaaNoOV3yb
	 qoccjVy3BUmDg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58C9sZttD495143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 17:54:35 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Sep 2025 17:54:35 +0800
Received: from localhost.localhost (172.21.69.104) by RTEXMBS03.realtek.com.tw
 (172.21.6.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Sep
 2025 17:54:35 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] iw: bitrate: support link id
Date: Fri, 12 Sep 2025 17:54:23 +0800
Message-ID: <20250912095423.27266-6-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20250912095423.27266-1-kevin_yang@realtek.com>
References: <20250912095423.27266-1-kevin_yang@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Since nl80211 requires valid link id (NL80211_FLAG_MLO_VALID_LINK_ID),
support link-id field for MLD. For non-MLD, just as before, no need to
assign link-id field.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
 bitrate.c   | 29 +++++++++++++++++++++++++++--
 interface.c | 32 +++++++++++++++++++++++++++-----
 iw.h        |  2 +-
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/bitrate.c b/bitrate.c
index 16f118cce4ec..78d399d227e2 100644
--- a/bitrate.c
+++ b/bitrate.c
@@ -195,7 +195,7 @@ static int parse_eht_gi(char *eht_gi)
 
 int set_bitrates(struct nl_msg *msg,
 		 int argc, char **argv,
-		 enum nl80211_attrs attr)
+		 enum nl80211_attrs attr, int *link_id)
 {
 	struct nlattr *nl_rates, *nl_band;
 	int i, ret = 0;
@@ -242,6 +242,7 @@ int set_bitrates(struct nl_msg *msg,
 	char *he_gi_argv = NULL;
 	int eht_gi = 0, eht_ltf = 0;
 	char *eht_gi_argv = NULL;
+	bool has_link_id = false;
 
 	enum {
 		S_NONE,
@@ -250,6 +251,7 @@ int set_bitrates(struct nl_msg *msg,
 		S_VHT,
 		S_HE,
 		S_EHT,
+		S_LINK_ID,
 		S_GI,
 		S_HE_GI,
 		S_HE_LTF,
@@ -347,6 +349,11 @@ int set_bitrates(struct nl_msg *msg,
 			eht_argv = eht_argv_6;
 			eht_argc = &eht_argc_6;
 			have_eht_mcs_6 = true;
+		} else if (strcmp(argv[i], "link-id") == 0) {
+			if (has_link_id)
+				return 1;
+			parser_state = S_LINK_ID;
+			has_link_id = true;
 		} else if (strcmp(argv[i], "sgi-2.4") == 0) {
 			sgi_24 = 1;
 			parser_state = S_GI;
@@ -427,6 +434,11 @@ int set_bitrates(struct nl_msg *msg,
 				return 1;
 			eht_argv[(*eht_argc)++] = argv[i];
 			break;
+		case S_LINK_ID:
+			*link_id = strtol(argv[i], &end, 0);
+			if (*end != '\0')
+				return 1;
+			break;
 		case S_GI:
 			break;
 		case S_HE_GI:
@@ -618,7 +630,20 @@ static int handle_bitrates(struct nl80211_state *state,
 			   int argc, char **argv,
 			   enum id_input id)
 {
-	return set_bitrates(msg, argc, argv, NL80211_ATTR_TX_RATES);
+	int link_id = -1;
+	int ret;
+
+	ret = set_bitrates(msg, argc, argv, NL80211_ATTR_TX_RATES, &link_id);
+	if (ret)
+		return ret;
+
+	if (link_id >= 0)
+		NLA_PUT_U8(msg, NL80211_ATTR_MLO_LINK_ID, link_id);
+
+	return 0;
+
+ nla_put_failure:
+	return -ENOBUFS;
 }
 
 #define DESCR_LEGACY "[legacy-<2.4|5> <legacy rate in Mbps>*]"
diff --git a/interface.c b/interface.c
index 65a4006963e5..0f1e9647f0e4 100644
--- a/interface.c
+++ b/interface.c
@@ -796,10 +796,11 @@ static int toggle_tid_param(const char *argv0, const char *argv1,
 	return -ENOBUFS;
 }
 
-static int handle_tid_config(struct nl80211_state *state,
-			     struct nl_msg *msg,
-			     int argc, char **argv,
-			     enum id_input id)
+static int __handle_tid_config(struct nl80211_state *state,
+			       struct nl_msg *msg,
+			       int argc, char **argv,
+			       enum id_input id,
+			       int *link_id)
 {
 	struct nlattr *tids_array = NULL;
 	struct nlattr *tids_entry = NULL;
@@ -989,7 +990,7 @@ static int handle_tid_config(struct nl80211_state *state,
 				if (txrate_type != NL80211_TX_RATE_AUTOMATIC) {
 					attr = NL80211_TID_CONFIG_ATTR_TX_RATE;
 					ret = set_bitrates(msg, argc, argv,
-							   attr);
+							   attr, link_id);
 					if (ret < 2)
 						return 1;
 
@@ -1020,6 +1021,27 @@ nla_put_failure:
 	return -ENOBUFS;
 }
 
+static int handle_tid_config(struct nl80211_state *state,
+			     struct nl_msg *msg,
+			     int argc, char **argv,
+			     enum id_input id)
+{
+	int link_id = -1;
+	int ret;
+
+	ret = __handle_tid_config(state, msg, argc, argv, id, &link_id);
+	if (ret)
+		return ret;
+
+	if (link_id >= 0)
+		NLA_PUT_U8(msg, NL80211_ATTR_MLO_LINK_ID, link_id);
+
+	return 0;
+
+ nla_put_failure:
+	return -ENOBUFS;
+}
+
 COMMAND(set, tidconf, "[peer <MAC address>] tids <mask> [override] [sretry <num>] [lretry <num>] "
 	"[ampdu [on|off]] [amsdu [on|off]] [noack [on|off]] [rtscts [on|off]]"
 	"[bitrates <type [auto|fixed|limit]> [legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*]"
diff --git a/iw.h b/iw.h
index 145b058d86ba..5c4ab6b0b38e 100644
--- a/iw.h
+++ b/iw.h
@@ -302,7 +302,7 @@ void nan_bf(uint8_t idx, uint8_t *bf, uint16_t bf_len, const uint8_t *buf,
 char *hex2bin(const char *hex, char *buf);
 
 int set_bitrates(struct nl_msg *msg, int argc, char **argv,
-		 enum nl80211_attrs attr);
+		 enum nl80211_attrs attr, int *link_id);
 
 int calc_s1g_ch_center_freq(__u8 ch_index, __u8 s1g_oper_class);
 
-- 
2.39.0


