Return-Path: <linux-wireless+bounces-36019-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B0vCps++2nTYQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36019-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:14:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A35B4DACE1
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AACE3013D55
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F3B3EF65D;
	Wed,  6 May 2026 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="eDiRmJ95"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557C23D7FF
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073051; cv=none; b=Z6Fb/rx0kBoFU3oPBk+l0dDXYvioGFnCwI6TyrVbL1roRNVn5yEnW3qWJib6MOnn50XgZakm4Wh2wCongF+6YmaIpzZADJJZgUwTA0H8JWVfAZG/ksA2wFi7nOeJMNxpATrbT6f5XZxim9ZAEy0HxD0UeOu73/EPfh3HWR1JyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073051; c=relaxed/simple;
	bh=0GbHNaf/iUgzcZEpZpgfxTlbCjJUeEffWKaup192+Q0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcONZOYZpo5SrF4+O5MPfY/mgpUV+ym1RwFtbbCO8hJNcM5L/k38YBDhcNwHkGiLu4i258dEO9nSrobtNfB3pYyDLDZ7Qwvxat0cDcHMbEy/Pbt8xSdPfM5i4iVSbgiKRszi29iKvGKtF57Fp8s5x0gfGPVsHKR5YlP8VwzqwxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eDiRmJ95; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DAm8821987056, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073048; bh=B8fxowS7NmJBput09Aan5H3j+pMfqbAqWOoBCHypZXQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eDiRmJ95iL/I6YaEWQ97MSk0Q/HhsDZpqfZizB+ty1vCzVHW2Vti1Rr21jgyI7rJJ
	 HGAcQxRuqUAo1Nh9Ngcml+Z+QDBgM6VtWfyryKdtzrISK11sau/WH8DGbe9oWV/9qM
	 7++alNYI+stDaCRwog6rKWSj9A7l/mUrVZyPTzvlzZC9t/4VsJi6I+SzanMORMHdOK
	 FU8doyJ2G8PW89t+tk3qCfdHSud3GfM86Z930UGd6OMGUM4XFileHS+XuZHU9wFz4m
	 YSboxhpnwP0zCx8+wCDL5EgBhzYcMIiOIKNR4WtOKEVZC5NkAhoVRQPh83CZFu76/w
	 JHOw91P5B8S1g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DAm8821987056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:10:48 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 21:10:48 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:10:48 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 21:10:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 09/14] wifi: rtw89: debug: make implementation of beacon_info entry in order
Date: Wed, 6 May 2026 21:09:55 +0800
Message-ID: <20260506131000.1706298-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260506131000.1706298-1-pkshih@realtek.com>
References: <20260506131000.1706298-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 7A35B4DACE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36019-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

When adding more debugfs entries, the beacon_info entry becomes not in
order. Move to correct location. Don't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 142 ++++++++++-----------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 597052261974..6fe8e7254e80 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4919,6 +4919,77 @@ rtw89_debug_priv_mlo_mode_set(struct rtw89_dev *rtwdev,
 	return count;
 }
 
+static int rtw89_get_beacon_info(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
+				 char *buf, size_t bufsz)
+{
+	struct rtw89_pkt_stat *pkt_stat = &bb->last_pkt_stat;
+	char *p = buf, *end = buf + bufsz;
+
+	p += scnprintf(p, end - p, "[PHY %u]\n", bb->phy_idx);
+	p += scnprintf(p, end - p, "Beacon: %u\n", pkt_stat->beacon_nr);
+	p += scnprintf(p, end - p, "raw rssi: %lu\n", ewma_rssi_read(&bb->bcn_rssi));
+	p += scnprintf(p, end - p, "hw rate: %u\n", pkt_stat->beacon_rate);
+	p += scnprintf(p, end - p, "length: %u\n\n", pkt_stat->beacon_len);
+
+	return p - buf;
+}
+
+static ssize_t
+rtw89_debug_priv_beacon_info_get(struct rtw89_dev *rtwdev,
+				 struct rtw89_debugfs_priv *debugfs_priv,
+				 char *buf, size_t bufsz)
+{
+	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
+	struct rtw89_beacon_dist *bcn_dist = &bcn_stat->bcn_dist;
+	u16 upper, lower = bcn_stat->tbtt_tu_min;
+	char *p = buf, *end = buf + bufsz;
+	u16 *drift = bcn_stat->drift;
+	u8 bcn_num = bcn_stat->num;
+	struct rtw89_bb_ctx *bb;
+	u8 count;
+	u8 i;
+
+	rtw89_for_each_active_bb(rtwdev, bb)
+		p += rtw89_get_beacon_info(rtwdev, bb, p, end - p);
+
+	p += scnprintf(p, end - p, "[Beacon info]\n");
+	p += scnprintf(p, end - p, "interval: %u\n", bcn_track->beacon_int);
+	p += scnprintf(p, end - p, "dtim: %u\n", bcn_track->dtim);
+
+	p += scnprintf(p, end - p, "\n[Distribution]\n");
+	p += scnprintf(p, end - p, "tbtt\n");
+	for (i = 0; i < RTW89_BCN_TRACK_MAX_BIN_NUM; i++) {
+		upper = lower + RTW89_BCN_TRACK_BIN_WIDTH - 1;
+		if (i == RTW89_BCN_TRACK_MAX_BIN_NUM - 1)
+			upper = max(upper, bcn_stat->tbtt_tu_max);
+
+		p += scnprintf(p, end - p, "%02u - %02u: %u\n",
+			       lower, upper, bcn_dist->bins[i]);
+
+		lower = upper + 1;
+	}
+
+	p += scnprintf(p, end - p, "\ndrift\n");
+
+	for (i = 0; i < bcn_num; i += count) {
+		count = 1;
+		while (i + count < bcn_num && drift[i] == drift[i + count])
+			count++;
+
+		p += scnprintf(p, end - p, "%u: %u\n", drift[i], count);
+	}
+	p += scnprintf(p, end - p, "\nlower bound: %u\n", bcn_dist->lower_bound);
+	p += scnprintf(p, end - p, "upper bound: %u\n", bcn_dist->upper_bound);
+	p += scnprintf(p, end - p, "outlier count: %u\n", bcn_dist->outlier_count);
+
+	p += scnprintf(p, end - p, "\n[Tracking]\n");
+	p += scnprintf(p, end - p, "tbtt offset: %u\n", bcn_track->tbtt_offset);
+	p += scnprintf(p, end - p, "bcn timeout: %u\n", bcn_track->bcn_timeout);
+
+	return p - buf;
+}
+
 enum __diag_mac_cmd {
 	__CMD_EQUALV,
 	__CMD_EQUALO,
@@ -5255,77 +5326,6 @@ rtw89_debug_priv_diag_bb_get(struct rtw89_dev *rtwdev,
 	return p - buf;
 }
 
-static int rtw89_get_beacon_info(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
-				 char *buf, size_t bufsz)
-{
-	struct rtw89_pkt_stat *pkt_stat = &bb->last_pkt_stat;
-	char *p = buf, *end = buf + bufsz;
-
-	p += scnprintf(p, end - p, "[PHY %u]\n", bb->phy_idx);
-	p += scnprintf(p, end - p, "Beacon: %u\n", pkt_stat->beacon_nr);
-	p += scnprintf(p, end - p, "raw rssi: %lu\n", ewma_rssi_read(&bb->bcn_rssi));
-	p += scnprintf(p, end - p, "hw rate: %u\n", pkt_stat->beacon_rate);
-	p += scnprintf(p, end - p, "length: %u\n\n", pkt_stat->beacon_len);
-
-	return p - buf;
-}
-
-static ssize_t
-rtw89_debug_priv_beacon_info_get(struct rtw89_dev *rtwdev,
-				 struct rtw89_debugfs_priv *debugfs_priv,
-				 char *buf, size_t bufsz)
-{
-	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
-	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
-	struct rtw89_beacon_dist *bcn_dist = &bcn_stat->bcn_dist;
-	u16 upper, lower = bcn_stat->tbtt_tu_min;
-	char *p = buf, *end = buf + bufsz;
-	u16 *drift = bcn_stat->drift;
-	u8 bcn_num = bcn_stat->num;
-	struct rtw89_bb_ctx *bb;
-	u8 count;
-	u8 i;
-
-	rtw89_for_each_active_bb(rtwdev, bb)
-		p += rtw89_get_beacon_info(rtwdev, bb, p, end - p);
-
-	p += scnprintf(p, end - p, "[Beacon info]\n");
-	p += scnprintf(p, end - p, "interval: %u\n", bcn_track->beacon_int);
-	p += scnprintf(p, end - p, "dtim: %u\n", bcn_track->dtim);
-
-	p += scnprintf(p, end - p, "\n[Distribution]\n");
-	p += scnprintf(p, end - p, "tbtt\n");
-	for (i = 0; i < RTW89_BCN_TRACK_MAX_BIN_NUM; i++) {
-		upper = lower + RTW89_BCN_TRACK_BIN_WIDTH - 1;
-		if (i == RTW89_BCN_TRACK_MAX_BIN_NUM - 1)
-			upper = max(upper, bcn_stat->tbtt_tu_max);
-
-		p += scnprintf(p, end - p, "%02u - %02u: %u\n",
-			       lower, upper, bcn_dist->bins[i]);
-
-		lower = upper + 1;
-	}
-
-	p += scnprintf(p, end - p, "\ndrift\n");
-
-	for (i = 0; i < bcn_num; i += count) {
-		count = 1;
-		while (i + count < bcn_num && drift[i] == drift[i + count])
-			count++;
-
-		p += scnprintf(p, end - p, "%u: %u\n", drift[i], count);
-	}
-	p += scnprintf(p, end - p, "\nlower bound: %u\n", bcn_dist->lower_bound);
-	p += scnprintf(p, end - p, "upper bound: %u\n", bcn_dist->upper_bound);
-	p += scnprintf(p, end - p, "outlier count: %u\n", bcn_dist->outlier_count);
-
-	p += scnprintf(p, end - p, "\n[Tracking]\n");
-	p += scnprintf(p, end - p, "tbtt offset: %u\n", bcn_track->tbtt_offset);
-	p += scnprintf(p, end - p, "bcn timeout: %u\n", bcn_track->bcn_timeout);
-
-	return p - buf;
-}
-
 #define rtw89_debug_priv_get(name, opts...)			\
 {								\
 	.cb_read = rtw89_debug_priv_ ##name## _get,		\
-- 
2.25.1


