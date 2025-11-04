Return-Path: <linux-wireless+bounces-28527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 569F3C302FC
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 10:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA2518930F2
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06971153BED;
	Tue,  4 Nov 2025 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="oTx6iPC0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3734D3B9
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247475; cv=none; b=ioud9ZJ3dMgBbOe2p/lAcLxbklClWWjPLMhGGUB1gM/ApgbVSMQaUctT6e7b9IDCYJw+4NpjYyz2YcLT3OmTU23xtlR0/mGN9p8VDqjpnXI3SqkXSfksOzhKMSOy1n1VQM/ksE/De2sarj9/eOV30poa4e2eiGRyabEIBnu6sTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247475; c=relaxed/simple;
	bh=lNS6hFRd4tOcyqL1hCt7xhJSHOrkp9Q+7tXu0yqx5qc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDbr/YUHknLHiRSngYE9saxDtKADgrNu5QZesENcxzlGpBsTXa76magiyqBQZxakn3kIsbg6a7p3bHzpysEMClfvPex68qpdWqM9icnl3vuPFS/i25P2445gNtbdbrcAFH/66MrEPHVemys9zH58kwoPa0TC/zd60Tg9m68IevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=oTx6iPC0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A49BAUi83073526, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762247470; bh=6k1f2LEtOZ1s03ijVhYXVkp7RYNOThzcXloOoBFssP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=oTx6iPC0p++s8asJf4z8cachzjzKaSCoGxYVaQ/kp0/Dn8vvYnEazwSaax8QXENN7
	 CKQPfJ8yy/2TI00gxHNLjdmDZBtQ4hM1hjcX26kw2iI1UOd9gYlAYGQH+fahd7IXc4
	 xnABrfs0k1ehJvqzVcYBnFXc5JoZWvV+9LyCK00hs/CNbeSdVAn+XUw+6agAt6noKb
	 sW45B3iS5SNdkoWXz1LWH7Rx9e5Z805p5pkDhlSI2ac32h1jNk0iu1UrDgltPRMXBR
	 lMnsGiAMhja5SI0Gp5sDankj+Ib4NWa8qaqQcljyeEOomHMq9IpfojA/ctFOl+PvHb
	 qIVHIm560axkg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A49BAUi83073526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 17:11:10 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 17:11:11 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 17:11:10 +0800
Received: from [127.0.1.1] (172.21.146.58) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 4 Nov 2025 17:11:10 +0800
From: <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 5/8] wifi: rtw89: phy: fix out-of-bounds access in rtw89_phy_read_txpwr_limit()
Date: Tue, 4 Nov 2025 17:14:10 +0800
Message-ID: <1762247653-26864-6-git-send-email-pkshih@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
References: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Kuan-Chung Chen <damon.chen@realtek.com>

Coverity reported a potential out-of-bounds access when 'bw' exceeds the
valid range for the specified band. Add a helper `rtw89_bw_is_valid()`
to check bandwidth validity for each band before accessing limit tables.

Addresses-Coverity-ID: 1598844 ("Out-of-bounds access")
Addresses-Coverity-ID: 1598896 ("Out-of-bounds access")

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 23892c1359a5..28e2b15240a7 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2376,6 +2376,21 @@ static u8 rtw89_channel_to_idx(struct rtw89_dev *rtwdev, u8 band, u8 channel)
 	}
 }
 
+static bool rtw89_phy_validate_txpwr_limit_bw(struct rtw89_dev *rtwdev,
+					      u8 band, u8 bw)
+{
+	switch (band) {
+	case RTW89_BAND_2G:
+		return bw < RTW89_2G_BW_NUM;
+	case RTW89_BAND_5G:
+		return bw < RTW89_5G_BW_NUM;
+	case RTW89_BAND_6G:
+		return bw < RTW89_6G_BW_NUM;
+	default:
+		return false;
+	}
+}
+
 s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch)
 {
@@ -2400,6 +2415,11 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 	};
 	s8 cstr;
 
+	if (!rtw89_phy_validate_txpwr_limit_bw(rtwdev, band, bw)) {
+		rtw89_warn(rtwdev, "invalid band %u bandwidth %u\n", band, bw);
+		return 0;
+	}
+
 	switch (band) {
 	case RTW89_BAND_2G:
 		if (has_ant_gain)
-- 
2.25.1


