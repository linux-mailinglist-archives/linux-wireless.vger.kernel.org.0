Return-Path: <linux-wireless+bounces-24132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5020ADAB6A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7504E170F5D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B1519D06A;
	Mon, 16 Jun 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wKHPouJP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B21991CD
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064654; cv=none; b=SykR+Mu5qFufdH4Fd5fRnXN7W56p95dKe2WBqtEOASwGbFHFg1zpYpQL8PipCviTj3ykE6vqrrHHSKB2xBvIZBCimWi+Y5pflPHccyr2GacEf1avFFUaIbxvBhMdanHMNOnQL5FiZi0qXLeD3YPidRqK4FW6HbBjWt/RcYAMddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064654; c=relaxed/simple;
	bh=5dpcNOKtqLjEHA6+F+UvqkI7M367+CwlUV7FbQNzlcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKwPLr94IGvxUtkSH8gZAIitoHuqbmGn6LHfSqchIC1MCHhWZ+ANH4r4iseZUrtNFZZj+aISBar5bppJVWEOmfHLjOg6Kjxu+wfONZ8ajj1me6U4wNk747v1osFa1tLL6yJXt9PujBgEdOz4XTFXsd9bC2wo8JjfUgW2Z9kdBMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wKHPouJP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G94AG30175699, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750064650; bh=EZRzeLJ78fZ2Is2g2FL3QhnXCgD1XkXlItzWzADhquc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wKHPouJP2aHb3EYEWWssDX5L2yAj+KB+VrrXAK7KnZeo9IN6ZpRXaSkyakcfyVqqK
	 SrpzvEysOJfknzRYQAOYlN0VndXJ9ihAhv8RkmTdekg9FuK9sZaQz/4An7UFjuTAUh
	 I0jWo0FKY6rd3tBV6E8zxS4vXxvYa4nbgg/hxSP+r8fr8pwaKUh840WWYk4Ex0Vi/K
	 lPekN71CptA/llMM2Q1MBJ2wXxtMrFREJ4MTE4in37P8m/SG1UqZzmI0yhaPlJl1+l
	 8AThg2XcrxCacUHkYgDqjZOlnsphrhQh8O8rbvlh9VAku0C0csgiyde+vYsIOhbIGM
	 48Y5uJsBMz4hw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G94AG30175699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 17:04:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 17:03:45 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 17:03:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 09/11] wifi: rtw89: coex: Update Bluetooth slot length when Wi-Fi is scanning
Date: Mon, 16 Jun 2025 17:02:50 +0800
Message-ID: <20250616090252.51098-10-pkshih@realtek.com>
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

If Wi-Fi isn't connected to AP, the firmware scan will not switch to
operation channel. Bluetooth may not have enough time to TX data. This
patch extend the slot to let Bluetooth can TX more to avoid audio lag.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 60760512e93d..f6b482b20dc7 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -4160,7 +4160,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 				_slot_set(btc, CXST_E2G, 5, cxtbl[2], SLOT_MIX);
 			else
 				_slot_set(btc, CXST_E2G, 5, tbl_w1, SLOT_MIX);
-			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
+			_slot_set_le(btc, CXST_EBT, cpu_to_le16(40),
 				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
 			break;
 		case BTC_CXP_OFFE_WL: /* for 4-way */
-- 
2.25.1


