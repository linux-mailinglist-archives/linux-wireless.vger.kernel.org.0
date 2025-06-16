Return-Path: <linux-wireless+bounces-24137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 338E1ADAB78
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F6C188C968
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFA21FF1C4;
	Mon, 16 Jun 2025 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CH4Ch4s/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593F20CCC9
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064823; cv=none; b=bdn7VuHyXtLDo9FmpN0H+3j8lEGvsio2uY7BhJdS9ECwUdI+3N974BkqbazgIcdFAjAorA4Q2VeT0XsZfPDeYXM9R/5dI5IKy0Kygpxlm/QL6ooZEGJyA9gblR/SvaxNI1j09mU5MnL3e56hGMW+ccS99bm5jrrnzHQcFfYUyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064823; c=relaxed/simple;
	bh=PKl1pi9SzkUMCcmSTVNeZ2Rca1DCPdiovihp/NCEHzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNJ8w87X6Px0sCxiD4bPaBI/xbkdfg4jTLvT7Kb1o/p/R0lS772makeqsoaVlq5AR/omsrodb9McRTOVpt+Nu/8tecLjJBbNEWPV1iTmTMhtAAgsxogWPFpNcN8aLmCpKVLl+06YV0wauoWbCuSHUYBiLhDrkv8a1DRIBnrSMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CH4Ch4s/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G96xyL6178582, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750064819; bh=tyqCem+jXsXKlDDGF2z73zfd/F9g7cwPJAT9LEZHpBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=CH4Ch4s/JCLXriHsuMUraAMBC8RYsWjuRpqSNqvRK/gNMz8oUOPeib5rHDiL5IahD
	 wtAsTVaYqhnT0jYW1quoFhdCHsujf8kFPePuYSOX33k6kzSvN1Q8SdWmQPdM403H6G
	 6fo+3taQQAXCTAo/ijlldDV7VLBo+2NOTvQB1Jokr1KJGC3Ewy1MT5Xy5MRDIZ+Fdl
	 8EviICu/3lIRQ5GgkoSD5hOKSZ+vTlPr7jQICpp6YTK4Cv88acO9NAYtribgQdpTq0
	 jvcZ4AVu5eQjStKSjggyjEMjuCMsKe2WQ52EekBIkMuNuLP4vXBMIfIBErmtg+OFG8
	 Jjd6zVL2uwcNQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G96xyL6178582
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 17:06:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 17:03:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 17:03:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 02/11] wifi: rtw89: coex: Enable outsource info H2C command
Date: Mon, 16 Jun 2025 17:02:43 +0800
Message-ID: <20250616090252.51098-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616090252.51098-1-pkshih@realtek.com>
References: <20250616090252.51098-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

The before several patches collect driver information, then this patch
packet these information as outsource info and update to firmware by H2C
command.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index d95ddc928e3d..3c607f5548b8 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5561,6 +5561,16 @@ static void _action_common(struct rtw89_dev *rtwdev)
 		wl->scbd_change = false;
 		btc->cx.cnt_wl[BTC_WCNT_SCBDUPDATE]++;
 	}
+
+	if (btc->ver->fcxosi) {
+		if (memcmp(&dm->ost_info_last, &dm->ost_info,
+			   sizeof(dm->ost_info_last)) ||
+		    dm->run_reason == BTC_RSN_NTFY_INIT ||
+		    dm->run_reason == BTC_RSN_NTFY_RADIO_STATE) {
+			dm->ost_info_last = dm->ost_info;
+			_fw_set_drv_info(rtwdev, CXDRVINFO_OSI);
+		}
+	}
 	btc->dm.tdma_instant_excute = 0;
 	wl->pta_reg_mac_chg = false;
 }
-- 
2.25.1


