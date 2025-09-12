Return-Path: <linux-wireless+bounces-27263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12A8B5486D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 11:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF6E3BE6EC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 09:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BBD2874FE;
	Fri, 12 Sep 2025 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Wb61dl1F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88E27A92F
	for <linux-wireless@vger.kernel.org>; Fri, 12 Sep 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670888; cv=none; b=M+9dx3dLcShJYYovSWAu5taUwx3JIYu+gA0GbQgw9oevgl7T/WcuGU7dAck4z9xxQMg6dy2c8iNguiv+HRTIcZ49F6LQr0Dh/MVh9YT6Jo5V6R/T1ZM65ypxfPx6mYSere9Fboa97ri+maQvYXlISGrhllwQAmOf/boDfrz/YeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670888; c=relaxed/simple;
	bh=yJLrDnXc+u8XzXH7D0NZCJUQdG1g+VQ/VSeRRiS/r1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYKA2Jyw//iq+1p/S0wDOtHIcpWcE6zWAOntsMFCRjGS+En6mJi67T6vZbpTLfPYgHs6QNady18ac/ZyujKzGygQZpEdssF/6uUnL4Jrz8KuuqzgonJ0cy8RFB+GG5gxlH3UPwisjp+g3u5tGdNnZtAdKnSNosZF0yDFvzPUrxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Wb61dl1F; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58C9sYiR5495139, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757670874; bh=B9XXix4xQcndwqW2euab2by7UL6eUACqv57hnBEndus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Wb61dl1F9Kt6YYPKtd+A89pEMKlJ8xBgsnLO/iQvfKi8BbxkKnaX/RpRr72SUxbZW
	 g0bqxyWSKsbfXAE5YhxwM1JdTcQHjSdzKTyeFTeG92iUiMAC/aNp4mAI7U/QLZSMzh
	 vfUr9q4Xnd4G8bbbVQc+PwB2smckjne+ta0s1bMZjH1wwm2Xix3tEKzPERC9saYvbZ
	 92+QMr7Wq8VgyVz4UPMG/c795LFRA3VhQ94dXeT1jiisaRaOK1CP+E/y5nLfUtWxSe
	 B+G7cKrFWxs4koIB7z88JFQ0HH9Fe8LrJxLW081JjUYkhqH5qsfJw3RJi3MFdjZ2+u
	 AXfrDdvbBZwSw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58C9sYiR5495139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 17:54:34 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Sep 2025 17:54:35 +0800
Received: from localhost.localhost (172.21.69.104) by RTEXMBS03.realtek.com.tw
 (172.21.6.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Sep
 2025 17:54:34 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/5] iw: bitrate: refactor description
Date: Fri, 12 Sep 2025 17:54:21 +0800
Message-ID: <20250912095423.27266-4-kevin_yang@realtek.com>
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


