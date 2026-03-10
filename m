Return-Path: <linux-wireless+bounces-32815-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP4sK77Qr2kfcgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32815-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:05:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A1E246EBC
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D3E30B2209
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4653E959E;
	Tue, 10 Mar 2026 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LKVLJ3Xt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C5F3ECBD2
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129748; cv=none; b=H2saestmcIW8/ClBGaQNicg/6ZmCEfAn7Kj/O9ffFh0UOriBtYdILm6epcABjyUlMS6ZKtQppsA7bczf2woycF3msiiCjD5DoMzBMiyX7guvte6vevvTHQVWpjolxjYULiarpBOVlWnIx2N4sVNFa0YD2eU2a+zoX9Ew0U5dtI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129748; c=relaxed/simple;
	bh=UhR87/1UTpP4ScZQ2tul70lBBNo7+4z/NZmX1Zvw27Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3cUmQZlDYqdqMa5JEu6pL/H42luiR/DZbiWgXNzF41WXUV5YEBZjKfJ2HInAVsyTlYOwGF/dRf9DIUlbDQvPcIapvA8YzB2bJK5Qh5jxKYoKmuYoFNStJJVRN5MrRIK/nuXckxKc2D0hi6CNa/2AG7SlypDCvhJiExj0ZID5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LKVLJ3Xt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A82QNH02210616, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773129746; bh=lPGDm6U+oluBN6xWXYkoRtUrqB1ZvGGn7daShl5DiR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=LKVLJ3Xt5ZAzjWJqxt4pM5rkPjooQR8etQoTIXGgpwowRGuusH9andEATJh7qPHuC
	 pMW1rpm3ChQ1R3iQn2PPSc3lFKYfLDkqNvOcXfeGef0WAN2a5zCvKHBZtnu0YH0OV8
	 mZtudYIGpHy+4N4hpChRQ/3wHIrdcr+CGyN6PrOUh1ml234Z52zfCnDt8tj4hpspMk
	 w5Cpmdra6rt1F1zVreHLbt5h9aHac8XStpVxxXfeeCZoUUvCfpMKoEEXb30zi2vQFQ
	 5LYvzKRob2E7FFKlN8c/gJ4c8TYcFUlK2GNFfIFzqwO2x3efJdzc21vGZnuKpGgHRK
	 6/JNXSx36tG0Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A82QNH02210616
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:02:26 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:26 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Mar 2026 16:02:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 06/13] wifi: rtw89: tweak settings of TX power and channel for Wi-Fi 7
Date: Tue, 10 Mar 2026 16:01:39 +0800
Message-ID: <20260310080146.31113-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260310080146.31113-1-pkshih@realtek.com>
References: <20260310080146.31113-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 13A1E246EBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32815-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The support_mlo flag depends on FW features, so it's determined at runtime.
Since Wi-Fi 7 chip now needs to initialize second HW band, if support_mlo
is not allowed, second HW band might act without settings of TX power and
channel. So, set that for Wi-Fi 7 chip.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 81004ef18168..6ab99a3577f3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -463,7 +463,7 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 	chan = rtw89_mgnt_chan_get(rtwdev, 0);
 	__rtw89_core_set_chip_txpwr(rtwdev, chan, RTW89_PHY_0);
 
-	if (!rtwdev->support_mlo)
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_AX)
 		return;
 
 	chan = rtw89_mgnt_chan_get(rtwdev, 1);
@@ -558,7 +558,7 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 	chan = rtw89_mgnt_chan_get(rtwdev, 0);
 	__rtw89_set_channel(rtwdev, chan, RTW89_MAC_0, RTW89_PHY_0);
 
-	if (!rtwdev->support_mlo)
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_AX)
 		return 0;
 
 	chan = rtw89_mgnt_chan_get(rtwdev, 1);
-- 
2.25.1


