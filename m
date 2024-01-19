Return-Path: <linux-wireless+bounces-2228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF58832583
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7151C1C22479
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4561328E15;
	Fri, 19 Jan 2024 08:15:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63028E10
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652149; cv=none; b=jgtCCocxSGHlnin/fA2Xcm+zo1/2QNcLjKQ+8Y7lAjicphSLLB5XNLASP17ft8QPZDsZBi2ARpXXcAyt23dYI1ds1zUoXFXVjj3FnLy0LGLjtysBrYR/aeduB8qKtH9QmLtRKZIQcmROqPRbMOABgJFWrhmZIOfMVqeyPwqc1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652149; c=relaxed/simple;
	bh=QkPyr1Ne4T5rAFdXGE2zWXstW6H0E2hCxeze4CfytQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bb8YWXvCs4o6TVRIbvUZZ5d4o3vAfVO/vLSH7mHC7UhGc0dEM1MH/uy81HRgCsW3PmNKngz5SQ3szZA17sXtffqxAGBM73sa4gR35DQHUarCMMoQyEuhakXuwwmNmbSUXfAJ7roudQB598rmnkXy98UdGVmAwAbcTV/RnJRW2VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40J8FhWaA2212438, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40J8FhWaA2212438
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 16:15:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 19 Jan 2024 16:15:43 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jan
 2024 16:15:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/8] wifi: rtw89: disable RTS when broadcast/multicast
Date: Fri, 19 Jan 2024 16:14:57 +0800
Message-ID: <20240119081501.25223-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119081501.25223-1-pkshih@realtek.com>
References: <20240119081501.25223-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

RTS switch should not be enabled for broadcast and multicast. This
could cause incorrect behavior during AP mode, so we fix it.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index dfca642a7570..6e52c4f82011 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1176,7 +1176,8 @@ static __le32 rtw89_build_txwd_info2_v1(struct rtw89_tx_desc_info *desc_info)
 
 static __le32 rtw89_build_txwd_info4(struct rtw89_tx_desc_info *desc_info)
 {
-	u32 dword = FIELD_PREP(RTW89_TXWD_INFO4_RTS_EN, 1) |
+	bool rts_en = !desc_info->is_bmc;
+	u32 dword = FIELD_PREP(RTW89_TXWD_INFO4_RTS_EN, rts_en) |
 		    FIELD_PREP(RTW89_TXWD_INFO4_HW_RTS_EN, 1);
 
 	return cpu_to_le32(dword);
@@ -1329,7 +1330,8 @@ static __le32 rtw89_build_txwd_info2_v2(struct rtw89_tx_desc_info *desc_info)
 
 static __le32 rtw89_build_txwd_info4_v2(struct rtw89_tx_desc_info *desc_info)
 {
-	u32 dword = FIELD_PREP(BE_TXD_INFO4_RTS_EN, 1) |
+	bool rts_en = !desc_info->is_bmc;
+	u32 dword = FIELD_PREP(BE_TXD_INFO4_RTS_EN, rts_en) |
 		    FIELD_PREP(BE_TXD_INFO4_HW_RTS_EN, 1);
 
 	return cpu_to_le32(dword);
-- 
2.25.1


