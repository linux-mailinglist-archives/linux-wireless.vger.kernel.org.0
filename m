Return-Path: <linux-wireless+bounces-13746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390BD995C67
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EE71F253EA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 00:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C5C7462;
	Wed,  9 Oct 2024 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="h2EX2+Xv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CAA15E8B
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 00:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434612; cv=none; b=g5FZAnaGEeI2/TnRqcEL1RjulzelLhb0gXBlUlkd+CQZBufGLHThU6h7+jPR5M9ceKNIzmTGLUAsvO4lECs/eGw1Pt4BDA/zKFoFFaMMLBR42Mp/pQ7LFQNkbS8unrwjqKj1IFJPop6tL6HcLhsNRK1wfOh9HyqIMwFhfD+ZH7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434612; c=relaxed/simple;
	bh=rNj2oyA42DBPhYoR0d7YnCBE3Nj1lCpmC1pjcsEpFWk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsZLAPuYb91tLFXA96o+TvB2fc85OLGD6DczhQRWzgeu5WeX3q90A6623cHrCYlpXMadcUp7Ob5XLwvpSAz8KkaYZtPd3tJsoAzobVHjLyKRSZiCzzwA0Ae8/l/Q5mPTEAiGyyJdk81/9+aR2fjP/YsdRwNU/S5CD869E0dbfpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=h2EX2+Xv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4990hTLV14153816, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728434609; bh=rNj2oyA42DBPhYoR0d7YnCBE3Nj1lCpmC1pjcsEpFWk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=h2EX2+XvnISbFg667BjOdlQyGgUeWz/Cp7UKZm5YhIhJQbFWUQO/lXUWVvUcmvFMR
	 +sZ3Lr0pxKR8Su7D5dHuyt1p5WdWciyuDEqJB8M3XEQT4ohC6BUsCxvhKm7wLil5j/
	 4AR2PDPFOXHSG/ZA6p19Yn9HBFjDcsTdPYWFU0GE/TsxcLsM3cnZGMwmQ+/xdTU/Yp
	 X6I4y0N0ByfauqXs28yTmePaPyTKsBL7znkXpDt0vmQQ/hwAy9YZXERmGIv9Xu4OnB
	 L7IzAYQxtz3xy6eeDOFmMMa47upUK+m9YlD8aormronSrHYbzQMpf6Spg0faJYXR4k
	 6v6gjHFEe8rhw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4990hTLV14153816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Oct 2024 08:43:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 08:43:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Oct
 2024 08:43:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: 8852bt: use 'int' as return type of error code pwr_{on,off}_func()
Date: Wed, 9 Oct 2024 08:42:59 +0800
Message-ID: <20241009004300.8144-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009004300.8144-1-pkshih@realtek.com>
References: <20241009004300.8144-1-pkshih@realtek.com>
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

The return type of error code of rtw8852bt_pwr_{on,off}_func() and its
callee is 'int'. Correct it.

Addresses-Coverity-ID: 1630962 ("Overflowed constant")
Addresses-Coverity-ID: 1632126 ("Overflowed constant")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index dab7e71ec6a1..38545bf65072 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -244,7 +244,7 @@ static const u8 rtw89_btc_8852bt_bt_rssi_thres[BTC_BT_RSSI_THMAX] = {50, 40, 30,
 static int rtw8852bt_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
-	u32 ret;
+	int ret;
 
 	rtw89_write32_set(rtwdev, R_AX_LDO_AON_CTRL0, B_AX_PD_REGU_L);
 	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_AFSM_WLSUS_EN |
@@ -357,7 +357,7 @@ static int rtw8852bt_pwr_on_func(struct rtw89_dev *rtwdev)
 static int rtw8852bt_pwr_off_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
-	u32 ret;
+	int ret;
 
 	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_RFC2RF,
 				      XTAL_SI_RFC2RF);
-- 
2.25.1


