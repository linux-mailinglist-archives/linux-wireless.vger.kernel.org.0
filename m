Return-Path: <linux-wireless+bounces-27425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11010B8009B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 16:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB06432534D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 05:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B41F27FB03;
	Wed, 17 Sep 2025 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ctqyx/6q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7EC26B2AD
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088577; cv=none; b=W6jpVpPxUR2/G8iNeXUC66K5ZmNTq8ZOsVf4IQz6zY3dw4bo2QWLp/tUEIM34d69+OuAWqSe03fKLDtpO+VQYPqQIuq46qD9Q5Zg9ecuuUcNc/TqOFHwcN/TSHoU2iKRndrzXOex1AK28CesEZyGAmD78JidDY4qqL4PfCNMkks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088577; c=relaxed/simple;
	bh=yJLrDnXc+u8XzXH7D0NZCJUQdG1g+VQ/VSeRRiS/r1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neab6s1lYc7PQBsNoAXezmNjdDIbio9Hzxu4XTA7O+LInvuy2Yb67kyYTtpAYJq66b7kdBbuEnHpEMJ/d4pzts/QeVr3h4gHdZj9Fewj0D1m/V9zGIiQQno18oYv6myJWAm/VL852oWD27SBiLAY/LwMcJ24KcgMvj8GPjgSKxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ctqyx/6q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58H5u0a453954266, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758088560; bh=B9XXix4xQcndwqW2euab2by7UL6eUACqv57hnBEndus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ctqyx/6qr1TOEcPY26wlfXa+93Zgqs2HaHgPmBLOJ9TxkSgRyEhQFFL0NNPdffLFY
	 qEqfDAg79RPeUeVfJEAvoWTHxBQl+sk0Rs+nfCS284OAi1hO9aIUAQX/nh0SNG9fFh
	 /1VnQuf3drYdB/MczBMArSD1Yxy5PazEuahayw5sPojlaofxCfl22lRlq+OVPJ1BHb
	 V5oq2RzzA9vEew4cF9/c6XgCY0+AzxQZ90AnpJkmouRFIGaNkBKSgX+fjdBmvyk+KH
	 7fQcVWx+ViJCFf1rMxMIJldCI9MmuKnvfa8NBEdgKA7TqIXSghl3eKV0uwfx5dG23Z
	 Kc0Oc7Vg38UQg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58H5u0a453954266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:56:00 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 17 Sep 2025 13:56:01 +0800
Received: from kevin-ThinkPad-T430s.realtek.com.tw (172.21.69.104) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Sep 2025 13:56:00 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <raja.mani@oss.qualcomm.com>
Subject: [PATCH v2 4/6] iw: bitrate: refactor description
Date: Wed, 17 Sep 2025 13:55:41 +0800
Message-ID: <20250917055543.27499-5-kevin_yang@realtek.com>
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

The description is too long to read, and some parameters
have been described incorrectly, e.g. vht-mcs.

Re-plan macro for description and use it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
 bitrate.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/bitrate.c b/bitrate.c
index 87146699937b..8c575b086eba 100644
--- a/bitrate.c
+++ b/bitrate.c
@@ -456,9 +456,22 @@ static int handle_bitrates(struct nl80211_state *state,
 }
 
 #define DESCR_LEGACY "[legacy-<2.4|5> <legacy rate in Mbps>*]"
-#define DESCR DESCR_LEGACY " [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5>  [he-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5]"
-
-COMMAND(set, bitrates, "[legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5> [he-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5] [he-gi-<2.4|5|6> <0.8|1.6|3.2>] [he-ltf-<2.4|5|6> <1|2|4>]",
+#define DESCR_HT " [ht-mcs-<2.4|5> <MCS index>*]"
+#define DESCR_VHT " [vht-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*]"
+#define DESCR_HE " [he-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*]"
+#define DESCR_GI " [sgi-2.4|lgi-2.4] [sgi-5|lgi-5] [he-gi-<2.4|5|6> <0.8|1.6|3.2>]"
+#define DESCR_LTF " [he-ltf-<2.4|5|6> <1|2|4>]"
+
+#define DESCR \
+	DESCR_LEGACY \
+	DESCR_HT \
+	DESCR_VHT \
+	DESCR_HE \
+	DESCR_GI \
+	DESCR_LTF \
+	/* end of DESCR */
+
+COMMAND(set, bitrates, DESCR,
 	NL80211_CMD_SET_TX_BITRATE_MASK, 0, CIB_NETDEV, handle_bitrates,
 	"Sets up the specified rate masks.\n"
 	"Not passing any arguments would clear the existing mask (if any).");
-- 
2.39.0


