Return-Path: <linux-wireless+bounces-27570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107B8B8F38F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 09:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C018F3B0A74
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836792F0C7B;
	Mon, 22 Sep 2025 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ywmi13Dy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E21F91E3
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 07:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525055; cv=none; b=OTF7rZC5qVbbxEVKFkr8cAeXr4J29lJeVnZwOu+ckb+GY527L14yodqWEwwz+y7fgho+aYA+JjVFieYAmY6fx/A838Np3K0F1rnZvIEwzY3outckUdS67MCQ9UL8CaVgTVuYqG3HXiS8tcwMFVc6VaJAFt3rKabht9iVysEM2j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525055; c=relaxed/simple;
	bh=RCPcyfauKH5suSokJng1vqhJvcEMFoxF9REiakB6YdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItH2aK80WuiIJPsqGyJaZtN1QlsAhvuSf+CvqJTorILagZ9OcIPnj28K1kLYJRKnFBMw4uz8Noeek/KuV1QC1OLh2H0wPvidTb5zfytkWtJFXsbxjRO3xDrFXgaJzhyoJOFBGPCo4ccoMsyg54k6PJbx6VcGRZkw7gXSJEsdYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ywmi13Dy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58M7AbfM64015233, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758525037; bh=K2MPIWnEGvTfyQPwajjFy0Gs/LBbdeMBb7/5BFOpcCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ywmi13DyS/fQhuKdp+g2P+gDWxJHrlzQLmmdwPe9iYzjSAAZU8XlS8skOUU0KUjWN
	 jPJS0kFC1A2cht1RoECnrMYsmZ4D41azrRXrm91KU7CwnfYatwmpOD3BQUAr3oBNs0
	 z6Tn1jJI1MvV4ZysF5bjGZftpybJ1JU/GWyCSBa3saBNSPRKhr0yf4W1se8BPXhvv3
	 HNLcpGuTDR30ZOH/yjJbkTxJ2JLxxfc356nZH1t9bngFs6pMo17myb3PmiB86RIQ7y
	 MhyrV0lNeKHK+/arp8xGSnNhe1Jot4Xlt6d4/ElfLxbI7e5DzyaZ1JUjx+eVX/b59I
	 74zi4ptOEK0GQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58M7AbfM64015233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 15:10:37 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 22 Sep 2025 15:10:38 +0800
Received: from kevin-ThinkPad-T430s.realtek.com.tw (172.21.69.104) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Sep 2025 15:10:38 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <raja.mani@oss.qualcomm.com>
Subject: [PATCH v3 1/4] iw: util: support parsing link id
Date: Mon, 22 Sep 2025 15:10:14 +0800
Message-ID: <20250922071017.11954-2-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20250922071017.11954-1-kevin_yang@realtek.com>
References: <20250922071017.11954-1-kevin_yang@realtek.com>
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
is as below. To avoid mess where some fields could have "link-id" as a
value, this pattern is only parsed at the beginning of argv.

	[link-id <LINK ID>]

If found, put NL80211_ATTR_MLO_LINK_ID and remove the assignment from
the argv range.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
v3: parse it only at the beginning of argv
v2: newly added
---
 iw.h   |  1 +
 util.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/iw.h b/iw.h
index 145b058d86ba..df9ea1375dae 100644
--- a/iw.h
+++ b/iw.h
@@ -305,6 +305,7 @@ int set_bitrates(struct nl_msg *msg, int argc, char **argv,
 		 enum nl80211_attrs attr);
 
 int calc_s1g_ch_center_freq(__u8 ch_index, __u8 s1g_oper_class);
+int parse_link_id(struct nl_msg *msg, int *argc, char ***argv);
 
 /* sections */
 DECLARE_SECTION(ap);
diff --git a/util.c b/util.c
index 36c118513e3f..a96fbf968244 100644
--- a/util.c
+++ b/util.c
@@ -2378,3 +2378,34 @@ void print_s1g_capability(const uint8_t *caps)
 	/* Last 2 bits are reserved */
 #undef PRINT_S1G_CAP
 }
+
+int parse_link_id(struct nl_msg *msg, int *argc, char ***argv)
+{
+	unsigned int link_id;
+	char *endptr;
+
+	if (*argc < 1)
+		return 0;
+
+	if (strcmp((*argv)[0], "link-id") != 0)
+		return 0;
+
+	if (*argc == 1)
+		goto usage;
+
+	link_id = strtol((*argv)[1], &endptr, 0);
+	if (*endptr != '\0')
+		goto usage;
+
+	*argv += 2;
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


