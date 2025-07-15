Return-Path: <linux-wireless+bounces-25434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C5AB04F87
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278EE17FC63
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 03:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B530B2D12E0;
	Tue, 15 Jul 2025 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rOmX9GXM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99F82D2381
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551615; cv=none; b=sDCHYZIefJieWNRDHGf1ahjvQxzg36I0wsevDT2UNvp96nYaWTDuCV1zCx9QWK5M+kNBbRkJQHfi2RmDSmyApwFm27ZmawkpKLjH4N+gKuN8PoL0g23Wsqbf6NsxHKlwM8KQPR7PLDXD+C6n61GRVfDA4kOpkNOgaYcAT8+upwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551615; c=relaxed/simple;
	bh=6q0aHT/OQu0d5S48Owc0dDCi2h4U0q5X6dPTmCTcCT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6T60Obg/VPhzowbp+A0tqGQBhaeTy3E7JJldiuh+eEbmVESc+hpMqiE0zfENeRCh8L8BVZP3VeHFbHeBnlT7MVJXaMAE37bcHuC3PsEFF9TOY/ceWrT4JEdfa3wU+538CF5fI3vLvzvXIcsKq8sC085/Asu6osL54NNpDiuP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rOmX9GXM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F3rVUj93971443, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752551611; bh=V5BX5Hzy1mI7iVDvMEFxuRiny4NtpnBqouPC6RjeBp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rOmX9GXMoXno/CWG5rY+Y+9IsHv6NVMRwsjAsiAS+65HmcgeVNRBaXTqBLgPY7mgL
	 B9OggR3a3qEwIm4w00MHUD0D91yn/HUPOiHSMXWjrXDjWMhL6yYsbze7WpafsKiX4j
	 Zp+vrpK+mpk12N/DQjQgkmGKJuRSzDYB9PtNY3nu+Nwb0Sgy4MrQctmFruPBYm3I63
	 OI/u6y22JtGf0YmxzqwPJb1RkeHTS1uGEwhIIo59sWf9F9m2L73A+pJQvqTi7ulGMn
	 xD3sD9vD0pLJDf5+nWxUhafBgTd8LmgqHo2arW9EExp7EDUxAWZc/2OCMpOS+kCLZS
	 LH2gq3+V2cfvg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F3rVUj93971443
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 11:53:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 11:53:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Jul
 2025 11:53:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 2/5] wifi: rtw89: mac: reduce PPDU status length for WiFi 6 chips
Date: Tue, 15 Jul 2025 11:52:56 +0800
Message-ID: <20250715035259.45061-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250715035259.45061-1-pkshih@realtek.com>
References: <20250715035259.45061-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chia-Yuan Li <leo.li@realtek.com>

Since the RX counter in the PPDU status is not used,
it is disabled to reduce the waste of DLE quota.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f6bbc796329c..3de3ea1e13ad 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5865,7 +5865,7 @@ int rtw89_mac_cfg_ppdu_status_ax(struct rtw89_dev *rtwdev, u8 mac_idx, bool enab
 
 	rtw89_write32(rtwdev, reg, B_AX_PPDU_STAT_RPT_EN |
 				   B_AX_APP_MAC_INFO_RPT |
-				   B_AX_APP_RX_CNT_RPT | B_AX_APP_PLCP_HDR_RPT |
+				   B_AX_APP_PLCP_HDR_RPT |
 				   B_AX_PPDU_STAT_RPT_CRC32);
 	rtw89_write32_mask(rtwdev, R_AX_HW_RPT_FWD, B_AX_FWD_PPDU_STAT_MASK,
 			   RTW89_PRPT_DEST_HOST);
-- 
2.25.1


