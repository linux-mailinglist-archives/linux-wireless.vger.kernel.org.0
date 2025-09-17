Return-Path: <linux-wireless+bounces-27422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B848B80191
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 16:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9870A189D3B8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 05:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58B226F44D;
	Wed, 17 Sep 2025 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="b1cb8ebt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84F26D4F6
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088576; cv=none; b=sJ6WfGCGVLYQfgsfb/3wVc5Xjnuc49M5hQXiQrclpdC3mQ0notinjwsrUQ8BBK58y7tsk/jX1MDXb5vXg+7k0JBI+JKVbs4TK0LO6PcQ97Ki68A8zXKlOKrZCwt5kXk7DahdWzs4YF8np9VfJbJ3mEj9KnK1NmddNiMx04BMljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088576; c=relaxed/simple;
	bh=r810a3bz/hs3r42mlQyy4SUTYJ8yWNUSIJRdx3nGaAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYFRg564dGEmvN5Q7soBivdvm1AzEDWlCuRtVBKBq1Z05ezsE/+fKYut7eT3etMnQqvFI8kKhnutvGaJi4iPjQqCPF4DJvp1Sn3KpnRgHBeKwKy6TNvUpFGkk6UCRchTIEAnhM5AdcHvgtrUwbOIKCgTA2yA1QoRGUnTx10O4us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=b1cb8ebt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58H5u0hS53954264, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758088560; bh=PqYliesyPZBQQRtbCH9exuXqIVMZ4W+twpvEPFcUtmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=b1cb8ebtsAZfc3JcruxqvYLOp5xQiNyZHcdcNIvHav2CkHj8K9NSY0f4HPkY0JwmI
	 j+dQtTIlAu+ENshrHKnW6vHG3D13XjpKHYexFjDQ8RTxlmq+XYBwdYQO/xEpEaAoGO
	 cv6uLgOrdlCpP75Nzhccop2dF2pDdXmARCATc8+9fJaSuQ4jThq/RPDh2Hifa8+FHN
	 L4MD45k5bX4JG++90JyAdhz8HiSYbgvzBTc7megA9jvkmMSuvzRXNsQpxl3WA6gOZL
	 EOu87aM+de5xW+xAzJ+t74pi5OrcMumN+8Qcarv+3nLtqsLl0ch3U2VRRsoh0XSk3+
	 6ooIJUqoTYBEQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58H5u0hS53954264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:56:00 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 17 Sep 2025 13:56:00 +0800
Received: from kevin-ThinkPad-T430s.realtek.com.tw (172.21.69.104) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Sep 2025 13:56:00 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <raja.mani@oss.qualcomm.com>
Subject: [PATCH v2 3/6] iw: util: support parsing link id
Date: Wed, 17 Sep 2025 13:55:40 +0800
Message-ID: <20250917055543.27499-4-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20250917055543.27499-1-kevin_yang@realtek.com>
References: <20250917055543.27499-1-kevin_yang@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

For NL80211_FLAG_MLO_VALID_LINK_ID cases, MLD needs to assign link id,
but non-MLD doesn't. Add support of parsing link id where the pattern
is as below.

	[link-id <LINK ID>]

If found, put NL80211_ATTR_MLO_LINK_ID and remove the assignment from
the argv range.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
v2: newly added
---
 iw.h   |  1 +
 util.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/iw.h b/iw.h
index 145b058d86ba..1d87f011e7be 100644
--- a/iw.h
+++ b/iw.h
@@ -305,6 +305,7 @@ int set_bitrates(struct nl_msg *msg, int argc, char **argv,
 		 enum nl80211_attrs attr);
 
 int calc_s1g_ch_center_freq(__u8 ch_index, __u8 s1g_oper_class);
+int parse_link_id(struct nl_msg *msg, int *argc, char **argv);
 
 /* sections */
 DECLARE_SECTION(ap);
diff --git a/util.c b/util.c
index 36c118513e3f..ad265c1dc007 100644
--- a/util.c
+++ b/util.c
@@ -2378,3 +2378,43 @@ void print_s1g_capability(const uint8_t *caps)
 	/* Last 2 bits are reserved */
 #undef PRINT_S1G_CAP
 }
+
+int parse_link_id(struct nl_msg *msg, int *argc, char **argv)
+{
+	unsigned int link_id;
+	char *endptr;
+	int pos = -1;
+	int i;
+
+	for (i = 0; i < *argc; i++) {
+		if (strcmp(argv[i], "link-id") == 0) {
+			if (pos >= 0)
+				goto usage;
+
+			if (i + 1 >= *argc)
+				goto usage;
+
+			link_id = strtol(argv[i + 1], &endptr, 0);
+			if (*endptr != '\0')
+				goto usage;
+
+			pos = i;
+		}
+	}
+
+	if (pos == -1)
+		return 0;
+
+	memmove(argv + pos, argv + pos + 2,
+		sizeof(*argv) * (*argc - pos - 2));
+	*argc -= 2;
+
+	NLA_PUT_U8(msg, NL80211_ATTR_MLO_LINK_ID, link_id);
+	return 0;
+
+usage:
+	return HANDLER_RET_USAGE;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
-- 
2.39.0


