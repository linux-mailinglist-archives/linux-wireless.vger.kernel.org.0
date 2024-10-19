Return-Path: <linux-wireless+bounces-14233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5899A4B8A
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2024 08:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F155B1F2352A
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2024 06:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4681CCB34;
	Sat, 19 Oct 2024 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QoDXVIq1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10D18C910
	for <linux-wireless@vger.kernel.org>; Sat, 19 Oct 2024 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729319511; cv=none; b=DEl1iJvQoGQPgPbRG4wbSIGtumfU0kNGPznBM+6aihkwOnvPr+dg+PyoaDXlKvwv5pdxSFDmqVUEEjjYjMSvDueLDX+w2wK4Ml3tZk/xZ+ybyFY3alwST2UcgCQYwHwomfnCn52T/knT6Omvz8+ue/XPe8BnXNr7y+ylpKkQA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729319511; c=relaxed/simple;
	bh=dSrj7xZYdBtRyrbg1RhHPpzbtGug5wYupjOHGJz2S2Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rX3HX4cvz0etkqz1khkx7Ii2iGhl1x2jOugBnEjSMhC0gbh6ZkOo1iQT+/Rv7CCPVXdPswP7F95aCTzVWHC7KRkvBvjkSaVz0g/Qz9MxznY1O2acY9g8EVUqKEuhElnKeknyUGxUzpK4gHYUwSysgSoysQOY5O7wRZmP8fmoaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QoDXVIq1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49J6VjchE3226386, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729319505; bh=dSrj7xZYdBtRyrbg1RhHPpzbtGug5wYupjOHGJz2S2Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=QoDXVIq1f1pE+ernA89uRNcTy5LUCuHYnPatru1Fx/wcdMdVTsZTWtMnyIJJfUKLK
	 0lVbkJIkCqSN0lFaaOH6jqlpAN3U4W5qJ8fgWv3+xaGBOwEO2Q5Tk37PqU8ER/XpPo
	 MPFQcjPc6zajK5tdohRatfAzXmER62DZA6Gi4EZeqFkAA4nhNqzfi0tRMod4vOuiR4
	 Yg1XMZbVDbHTIXS10BkRbtV6faHzESU/Bocvm4VXVoZMBHyTColvIMSsKJsQEA0eeW
	 X/xiiouR632yTfeX5gQRZWbHMrCKk0vXVu3TJhOYWplb37GCp8/orBD99dhhmw5W8N
	 lh9iDdcvXqQPg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49J6VjchE3226386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 19 Oct 2024 14:31:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 19 Oct 2024 14:31:45 +0800
Received: from [127.0.1.1] (172.16.22.200) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 19 Oct
 2024 14:31:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH] wifi: rtw89: coex: Set Wi-Fi/Bluetooth priority for Wi-Fi scan case
Date: Sat, 19 Oct 2024 14:31:31 +0800
Message-ID: <20241019063131.9462-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

The priority table should be changed according to what the in using
Bluetooth application is. To avoid Bluetooth audio + HID (mouse) will
trigger the lag experience, update the priority table.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 989e6e882c6e..8a65722dd1fd 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3853,7 +3853,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 				     s_def[CXST_ENULL].cxtbl, s_def[CXST_ENULL].cxtype);
 			break;
 		case BTC_CXP_OFFE_2GBWMIXB:
-			_slot_set(btc, CXST_E2G, 0, 0xea5a5555, SLOT_MIX);
+			_slot_set(btc, CXST_E2G, 0, tbl_w1, SLOT_MIX);
 			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			break;
-- 
2.25.1


