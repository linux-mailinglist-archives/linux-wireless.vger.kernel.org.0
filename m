Return-Path: <linux-wireless+bounces-27286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F493B570AA
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BD63B5E3D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 06:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7104D2C028A;
	Mon, 15 Sep 2025 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FkKwI9hP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6B2C029B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919230; cv=none; b=CiMSCJ4OoU9RRFIy7pGK7AbzJK605TINzBwAnPQxCX4Xlh90pysb8K1gmRi8kQrbhWdk3fWGMeXAOSC2mpKyNXrj8BL3yyhoiA7+quZRYcTTfRw5CqL8OTlIi0QrQwDz9iA+RGMz/OA/mcdKzTnKofNyVJVLQFfHVDwbgVO3udc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919230; c=relaxed/simple;
	bh=fTKJaMfV+mwuG7/iTMXXNh986nZfPKTkvLfRs6OWWHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JngcP6yGO1kB01CE4pNW1/Bfl7ct7fgbWfmPrD6HsPsWeGn2FGMM04SFisBrZYWE3e14d0ZibLDAOQc7nD9dPDmLPTHPPkvCS4V/k9iAwq6b7YbQL7nOQ2R7ZTVY5U7n6dQPNwzrfZvoCHOpScB+U3f718sESPXoEwR5uoKo87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FkKwI9hP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58F6rjHS3591144, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757919225; bh=GBiDwaDK2IZVaaaccc2IF34tUmLWmHMeriLXtC/fJBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FkKwI9hP3Ud16ZWG6BnnZhtc8r+DxzHm5VLyQalmJZcYewR8/e2aEJO5snWzyUBjw
	 m1bPjEw3TEOX9a289FQJd2qCgo8tQm+uKJNAtGm6Sh2mOBdB6HMMgqaI29iFglKgRR
	 kfXTNjxO4BG+oFpkv1Yn/q8F061NDg6+rHQfBehK2iM1B/ASalcIIgj7iNjjnidlyx
	 uXq5OQQXDK9ePe8W6Uwico5FrlR3NzZYUmNr9O9429P+eXHlrEal8eP7JyEjbFOTj3
	 3Y8f1yf52bRgMn35m22a6mqy1PoVBkrCbM90Lpf0B2ojKmzF4ZcXtwU5RvTh/u3YqI
	 BjKyMko6/rTmg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58F6rjHS3591144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 14:53:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 15 Sep 2025 14:53:45 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 15 Sep
 2025 14:53:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/11] wifi: rtw89: disable RTW89_PHYSTS_IE09_FTR_0 for ppdu status
Date: Mon, 15 Sep 2025 14:52:05 +0800
Message-ID: <20250915065213.38659-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915065213.38659-1-pkshih@realtek.com>
References: <20250915065213.38659-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Chih-Kang Chang <gary.chang@realtek.com>

The IE length of RTW89_PHYSTS_IE09_FTR_0 is dynamic, need to calculate
more to get it. This IE is not necessary now, disable it to avoid get
wrong IE length to let the parse function check failed.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c3181a301f7c..0e9cb0558eb3 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6184,8 +6184,6 @@ static void __rtw89_physts_parsing_init(struct rtw89_dev *rtwdev,
 			val |= BIT(RTW89_PHYSTS_IE13_DL_MU_DEF) |
 			       BIT(RTW89_PHYSTS_IE01_CMN_OFDM);
 		} else if (i >= RTW89_CCK_PKT) {
-			val |= BIT(RTW89_PHYSTS_IE09_FTR_0);
-
 			val &= ~(GENMASK(RTW89_PHYSTS_IE07_CMN_EXT_PATH_D,
 					 RTW89_PHYSTS_IE04_CMN_EXT_PATH_A));
 
-- 
2.25.1


