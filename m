Return-Path: <linux-wireless+bounces-25965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0959FB0FE45
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 02:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC61F5A0CCE
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 00:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0226C2E0;
	Thu, 24 Jul 2025 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QxeYGqtQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DBEA48
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753318127; cv=none; b=CkE7VT5kfaIX23GFrIfIaM3SIwes6Ux+HhEsfs/jOO8DyQxaox5es1UFMU3DTewsmRSszfXmiVdLvUMxndKHfnaXE0RYzYdb/aw3Ve3i27+ji1lQzcpMfyy5ZoQUpC7WqlaQEHy6idOjuyUXj+8CGpiHPMbB65fSV8ggIQ7mMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753318127; c=relaxed/simple;
	bh=W9Bu0bmhoV9Xwtd9WfEwpg7T12x3yF2r3+tBJXlfqqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=id1IAVEOIpSABbd8T2rFg+V8rdSV/SmD8iO91KZnkHCo+7ID70NdOj2uw86X9WUSJoQflx8jRr25DMf6wEAxBN8yAX5YT4sOgugkGtcbDXTcRl5nU/d0IA9NX+XDX8PLI7CQdQHtxvPl/zu7CX0cwXqfq/kmaFkKa226HW9IZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QxeYGqtQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56O0mdejF3797115, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753318120; bh=civo+jiygDCDGkAiZXZ5ii+3o8qzs05cQGCQ2X2/Knc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=QxeYGqtQyBIFOTrk+qEWI34MyZFaoIdRA8BB1zY717N9al2uzt2wcplDhtj3A+Jjd
	 zCft/EnBbj5Dq/0KKFY8dUS/uSMtzOyyA3WsOg4jT7oW9vO5walVqVZ93X851tOryU
	 9893H56pyZE7pVhRWy2YwWQcnrccOMIa50W/5locjJdKjEenPR5nt8s6m8x7CSr+km
	 gRvHdvBr8XyKD5nkjxRM3eip7ercIGruDkxkSrJLjbqVBdMFsLbGCGI1hjarsPfA9k
	 ziPGNfLQKdYrM9JFHL5N+F45P8fC/fl8t9IvPSgyp6N+cnbBGDb98StLBBz4HSneiy
	 J9joNJI5dHoyQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56O0mdejF3797115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 08:48:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 08:48:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 24 Jul
 2025 08:48:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <piotr.oniszczuk@gmail.com>, <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device registers before power-on
Date: Thu, 24 Jul 2025 08:48:15 +0800
Message-ID: <20250724004815.7043-1-pkshih@realtek.com>
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

The register REG_SYS_CFG1 is used to determine chip basic information
as arguments of following flows, such as download firmware and load PHY
parameters, so driver read the value early (before power-on).

However, the direct IO is disallowed before power-on, or it causes wrong
values, which driver recognizes a chip as a wrong type RF_1T1R, but
actually RF_2T2R, causing driver warns:

  rtw88_8822cs mmc1:0001:1: unsupported rf path (1)

Fix it by using indirect IO before power-on.

Reported-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com/T/#t
Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index cc2d4fef3587..99d7c629eac6 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -144,6 +144,10 @@ static u32 rtw_sdio_to_io_address(struct rtw_dev *rtwdev, u32 addr,
 
 static bool rtw_sdio_use_direct_io(struct rtw_dev *rtwdev, u32 addr)
 {
+	if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags) &&
+	    !rtw_sdio_is_bus_addr(addr))
+		return false;
+
 	return !rtw_sdio_is_sdio30_supported(rtwdev) ||
 		rtw_sdio_is_bus_addr(addr);
 }
-- 
2.25.1


