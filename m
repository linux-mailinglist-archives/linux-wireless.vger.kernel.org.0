Return-Path: <linux-wireless+bounces-27572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D3B8F395
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 09:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153B1189CAA4
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811592F2908;
	Mon, 22 Sep 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jTrznELR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E3221FCC
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525056; cv=none; b=MbrIchLh/4JfOjMtoEoKCvhUqERXzzKb3Mga7rbZ0f0D/WDfUB3uRXqc257r4HLVEmapf9p4HKKyhb5cydivX2VxTpAoeDs0HmXnJapo3LpQVDjx22RRHBG/+EhNAZV8DTohN8205yO2sXwMDLd9FKLZ+N5l4HmY6oAc18nKEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525056; c=relaxed/simple;
	bh=yJLrDnXc+u8XzXH7D0NZCJUQdG1g+VQ/VSeRRiS/r1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCRM9EkyyaZvBioxgknW/AAY5+oyx9rPjjh6fLoMFgNRzLmgt1SNMkKJEoba2cfWEH40T1anGjLdh0oQq/D5Ixj24mgweSvlU22yyjpmwc94fGgHUurWJKeO0bk7fBUu4a0RV/D+cMZk7uQ5cnOAcJoOG7KRFcAO7S+ez4qhY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jTrznELR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58M7AbAL24015236, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758525038; bh=B9XXix4xQcndwqW2euab2by7UL6eUACqv57hnBEndus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jTrznELRnaJy9Z7eMEPkvKvJKLpK01fXfZRUDoaUzb0mO1xKlRcVFpNg118DrT7vJ
	 nooIPFnFvsEOedV25pek0ZhH4bMUnEDIhntgKOWqe3/zOr15GcUVGfwV5vjbOqa29f
	 zJPDCQKNGxWjGkkgCrLGHoO7pYIVkSiGXOUxNli2Bww7cG1XbqwXXABgV+qgkmV0uB
	 sKXLhg2XCzm04V9tAShfxhXWe/JIEfirxtrIzT+rF6hWqlErktyWPhaP5qaVaaf9Nr
	 NsIoAyBeMESKHp+MUC1Z2YYfUdc9J4R0LsMyBT/afNnOPVbr/wP7BKjlhZGQ3oN9tN
	 Kq7cpXiq7196g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58M7AbAL24015236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 15:10:37 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 22 Sep 2025 15:10:38 +0800
Received: from kevin-ThinkPad-T430s.realtek.com.tw (172.21.69.104) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Sep 2025 15:10:38 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <raja.mani@oss.qualcomm.com>
Subject: [PATCH v3 2/4] iw: bitrate: refactor description
Date: Mon, 22 Sep 2025 15:10:15 +0800
Message-ID: <20250922071017.11954-3-kevin_yang@realtek.com>
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


