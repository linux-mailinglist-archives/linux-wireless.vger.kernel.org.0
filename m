Return-Path: <linux-wireless+bounces-22762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA8AAB077A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 03:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D344E228B
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 01:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E217FBAC;
	Fri,  9 May 2025 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CRvZwANp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6735942
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746754489; cv=none; b=u0ayBkPoz3QTtob9IDEwbNt1FSsKAHAlut2+Rh2ZQasiwx4mrvcecI6gpbDEUfMgAEDtOPf3M+KSKKR30wcybFfqjoCCdjS063u2+7PzDodZ0P86xXu48390Gq1il9GEVOEVfrNgwUQAMqAwFXyuVgTs5pAZajpBC/3IHlyXBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746754489; c=relaxed/simple;
	bh=s26mkkE1HWiyoWSkVxMdFtxrNDFHOcFdJjK9lQ2y73Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PPs+cbUo2QKbweo4KG8BA6sgDsw3L8DvEzO+hgRhrco7h2Ctr6D/t+bm1lzKtarQbSHW9Cy6HaPz2dhmkABITS/kgxVRA2pSTO/a/DI7W6MHrR47wfWF5cYw4nLLVSikBqKd6xLBa8ybr/IktqvLQ+UGjH/DXqsva4jty3GoSG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CRvZwANp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5491YgD823321731, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746754482; bh=s26mkkE1HWiyoWSkVxMdFtxrNDFHOcFdJjK9lQ2y73Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=CRvZwANpdLpxWgVaBYcMc96dGQNQ8smYLriEpEdrSNBdJ1+CVty6er8VPmA5fj5X+
	 SXZSN94bnAHlWG1Fv6NxN3vFB22uyPwswzCXYDjymTU2UHtYD3PWKtVeOWLo6m3Pqq
	 Do0FQEji7TYGMoVXHoNd5AL4fsOVtzQ+AyR2o1t76Am6icbViEIgjnwQn4nXDkVQPr
	 uTaiEbiTEHOR0/TRu5nF+kp6yp3VDxwZE12t6gbzJZBC2Ifk3aKnTQtvVArwy0OK78
	 2qZwGqAr3mO0bjFGvuRIfzFGnzmNSxCP9uNudF5ou6ooUNxH3wMhcRivxsmfLBcqqX
	 R+kh5Ku/IQKIw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5491YgD823321731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 09:34:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 May 2025 09:34:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 May
 2025 09:34:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <zohrlaffz@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw89: pci: enlarge retry times of RX tag to 1000
Date: Fri, 9 May 2025 09:34:33 +0800
Message-ID: <20250509013433.7573-1-pkshih@realtek.com>
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

RX tag is sequence number to ensure RX DMA is complete. On platform
Gigabyte X870 AORUS ELITE WIFI7, sometimes it needs longer retry times
to complete RX DMA, or driver throws warnings and connection drops:

  rtw89_8922ae 0000:07:00.0: failed to update 162 RXBD info: -11
  rtw89_8922ae 0000:07:00.0: failed to update 163 RXBD info: -11
  rtw89_8922ae 0000:07:00.0: failed to update 32 RXBD info: -11
  rtw89_8922ae 0000:07:00.0: failed to release TX skbs

Fixes: 0bc7d1d4e63c ("wifi: rtw89: pci: validate RX tag for RXQ and RPQ")
Reported-by: Samuel Reyes <zohrlaffz@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/f4355539f3ac46bbaf9c586d059a8cbb@realtek.com/T/#t
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c2fe5a898dc7..28e696476c5b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -228,7 +228,7 @@ int rtw89_pci_sync_skb_for_device_and_validate_rx_info(struct rtw89_dev *rtwdev,
 						       struct sk_buff *skb)
 {
 	struct rtw89_pci_rx_info *rx_info = RTW89_PCI_RX_SKB_CB(skb);
-	int rx_tag_retry = 100;
+	int rx_tag_retry = 1000;
 	int ret;
 
 	do {
-- 
2.25.1


