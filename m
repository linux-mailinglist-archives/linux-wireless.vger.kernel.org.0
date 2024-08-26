Return-Path: <linux-wireless+bounces-11955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D117195ECA3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808671F21DC6
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35964EAFA;
	Mon, 26 Aug 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Hy/uf7Sl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7911422AD
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663104; cv=none; b=Y3TsuELlj6aHhbFcU5wHKLrQjlhrtmcMzVhS72we8JzHjZe3pULLwdHP0f5dqfeaRuH2PftFAw8SeGJQPrWZORJOrKbnjUWQxGv7k3sKSqeaIeJ+Abj/52srX8pxefAGBk5o9cEFvY5wVvXYqdbzR+jBmiMSr/WKC4ksQ/aNnis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663104; c=relaxed/simple;
	bh=v2Mu5Aw3IrRQ6/BoeL+MPcMbkU9RNIpqhkXMjkk1NZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXU49BOPgEd01lUANpZsX1V1ePCt2P4sNWUeIfwtORffCYBswtOfzyoVk+wQRxnfDOrNwylOx2Ku8KtORCYoQrVMTmelMF6JlOpSHIaysSTbzF/CA70ckCNwJAw00AEnK1EifeYRIJB9SebuUcK12f/FMydgVMQRDMhrhawLcF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Hy/uf7Sl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47Q950Mx83828678, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724663100; bh=v2Mu5Aw3IrRQ6/BoeL+MPcMbkU9RNIpqhkXMjkk1NZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Hy/uf7Slm3HEG/PX+7gENXh/vD2p2psjqKsRHrdcbE1fr/yN9PtjuDQvZjv62bcGA
	 rxrDc5cC/sIbZs8DlM7AIKgSDA5+1M3qq/loeY2RFlhUyOW/A/uw5N2zLXurhNlCpq
	 EKHKVT1gZSaM1k47aAAlWQVegmi6joVGZqfO0Yd0k1aSW8j5PBNaXvVTVILoS3H66q
	 H0UbQFuYEC7rGcQitVR0+qRw2y1n3p11okUpW15VpvBArHTjC3iQNtLlALB9ecBd0j
	 Hi3e+mOUoeqfD+xU5aUHJ+NBeLpv36mnzPHh6mxXYn+qRx9kj6Bc8/UsXCf6b+eMTx
	 o3pfZI2qcTZkA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47Q950Mx83828678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 17:05:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 17:05:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Aug
 2024 17:04:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 3/4] wifi: rtw89: wow: add net-detect support for 8922ae
Date: Mon, 26 Aug 2024 17:04:38 +0800
Message-ID: <20240826090439.17242-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826090439.17242-1-pkshih@realtek.com>
References: <20240826090439.17242-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

Enable net-detect in WoWLAN stub of 8922a, and declare net-detect
support up to 8 SSIDs.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 7f4ac8b63e48..aa36e9cdee3d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2511,10 +2511,12 @@ static int rtw8922a_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
-	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT |
+		 WIPHY_WOWLAN_NET_DETECT,
 	.n_patterns = RTW89_MAX_PATTERN_NUM,
 	.pattern_max_len = RTW89_MAX_PATTERN_SIZE,
 	.pattern_min_len = 1,
+	.max_nd_match_sets = RTW89_SCANOFLD_MAX_SSID,
 };
 #endif
 
-- 
2.25.1


