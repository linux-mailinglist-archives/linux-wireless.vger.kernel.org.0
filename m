Return-Path: <linux-wireless+bounces-28954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0C3C5B767
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711F83A5089
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F792DE719;
	Fri, 14 Nov 2025 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ntQzl8K4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE602DC791
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100165; cv=none; b=roaUYxsa+CxidoPOyEKZbA3quB56gH/US/qz+RlDTB2csXYzCfcWIMlktQHlfLM6rwF05IKobbAOcs0jJSlfCS3wo+7e9xmOWGgClgflC5eSYubQNCIeLHJDGMHvlD9a9WI08Hi45eL6aq46WKDf46JoB67dStImKR9B1UCTDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100165; c=relaxed/simple;
	bh=kF0pk0iyGEx3M8WEySw2SQDpg588oblcC29fWkIINE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7mYrQnPuSXPl5GJbvj+NbqpT/tg+8ZPVk0qTLU/m2MHHzux6AVmyKexcGicB14XEHo3gz7sLtvwYS0o0zo6j9cGjXSD/LbfF2xXa8IWe2tuwgwnnDCtc1BtyFgLAN7if/57timGjLoRlSR1NgejBRnFuExxueN0hLVu28EVyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ntQzl8K4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE62f7lA1038284, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100161; bh=5Dx++rA1uJu1xRSPr7GXVCqtXFPAFTC0JFkqX8qEZws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ntQzl8K4YkPACoIFNzq69E6mbXI5VpFUMIzjd9ny30kZeae/diIEkOdvRusj4BE1e
	 1Aso9A3TD437YtTkpxquzP3xZf6maWgtpeZZYNw0K3rD8cyPjjR9LKGG6JEo4qic95
	 tRWqL+BxtiBXyR9SHaKL1+KcBtgCjSRZD7AIhVPZQQnJZCgyLKwzmG00XZ9+laLyRe
	 OAu/5UiNVShHnQYVHXyPDCYjayF3/RgUsx/OqX/2Ye/4HwE5NMIVlLuY5mJJA1uLbf
	 +dipp3YLpNEIqfnllwf2a+GW3tWi2kAT7naoxTI2v7lkN8FbWh1SdyBukbUeOXsAAP
	 bEe6ODI1fzObQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE62f7lA1038284
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:02:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:42 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:02:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 07/14] wifi: rtw89: phy: consider type 15 in BB gain table
Date: Fri, 14 Nov 2025 14:01:21 +0800
Message-ID: <20251114060128.35363-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114060128.35363-1-pkshih@realtek.com>
References: <20251114060128.35363-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

BB gain table is a table to configure gain for certain channels. Newly
added type 15 is considered to write registers accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/phy_be.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 3316a38a62d0..bd17714f13d1 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -266,6 +266,10 @@ static void rtw89_phy_config_bb_gain_be(struct rtw89_dev *rtwdev,
 	case 3:
 		rtw89_phy_cfg_bb_gain_op1db_be(rtwdev, arg, reg->data);
 		break;
+	case 15:
+		rtw89_phy_write32_idx(rtwdev, reg->addr & 0xFFFFF, MASKHWORD,
+				      reg->data, RTW89_PHY_0);
+		break;
 	case 4:
 		/* This cfg_type is only used by rfe_type >= 50 with eFEM */
 		if (efuse->rfe_type < 50)
-- 
2.25.1


