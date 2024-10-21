Return-Path: <linux-wireless+bounces-14239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAF69A5A64
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 08:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56728B20F66
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 06:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C07433A0;
	Mon, 21 Oct 2024 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uzrrO3Cu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26EDDA8
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492361; cv=none; b=MgZK2RlBT7V+pB4YkAADD7rknSP8Bfq9toqSMkm3BxPc8oqT6tjII0vKpF+zE4G5y1Y/BUo5jVHsqOMOx0VDLdkLvMzP/ZWm0leSGciiw7ql6cP3DF2Dh61UoCAk2ai2wQpHWfjSUPTGFKU1Gl6111PNwHVyCmaCqHtfgP4muzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492361; c=relaxed/simple;
	bh=yANGpz0328jo7W+Eye6jw/bjB9w05fdezicgR3FZw9Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M8W6jnE+8QbCTLDPze30ZGuI9MdTa/uZDyU75OBWgyrR3njUhgFQpcA9dFvh+415lEbWRVpWnEbh2KupOi1HmVPxDeoy2CLmfE+OIgmaCacX6hYqHsbrZ0+dDOQWMaabVWyv/Vb6L/zSdl4CCSEGn+5fHfvZNgC/gSxRQWQvPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uzrrO3Cu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49L6WZuF42015984, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729492355; bh=yANGpz0328jo7W+Eye6jw/bjB9w05fdezicgR3FZw9Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=uzrrO3Cu+ftGQTM3yQhr2kgxXoWMLKwQirAkfu73WWd+Au1UIXKRcr9tFcSWbW9qL
	 taTvb0NHJW+rrtaeiCvbwD0q+H7n2XRj+D4ySdRPp5SysQrtzs7PU/t0FRgEo+xRX9
	 MYXFUy3dXtTGILqd/b1TvPnyO3L+lBbBuFBkQP3cG9yjpdfpaOP9NNnFYZQ1mhXyeO
	 e8ll6apqJQKgrKRVGkcODvpODkuf4sxT71LTVbeCPaDiCwQUI0qUpry+op7Tk3VOje
	 2CWVydDeTQZqHfGxwIfYQROBWSxV3VlVqOHHBqPjAIfbxVNdlEh2LitazRjM9PZaKj
	 eDHIRtbIzGRAw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49L6WZuF42015984
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 14:32:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 14:32:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 21 Oct
 2024 14:32:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: [PATCH] wifi: rtw89: Fix TX fail with A2DP after scanning
Date: Mon, 21 Oct 2024 14:32:19 +0800
Message-ID: <20241021063219.22613-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

There might be some racing between BT and WiFi after scan. Since
one of the TX related register will be modified by both FW and
rtw89_set_channel() in driver, which could cause Tx fail. Reorder
the calling sequence to only notify coexistence mechanism after
rtw89_set_channel() is called, so that there are no concurrent
operations.

Fixes: 5f499ce69b8d ("wifi: rtw89: pause/proceed MCC for ROC and HW scan")
Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 744a8d277cfc..b1123a4ee999 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6675,6 +6675,8 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev,
 	if (!rtwvif_link)
 		return;
 
+	rtw89_chanctx_proceed(rtwdev);
+
 	rtwvif = rtwvif_link->rtwvif;
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
@@ -6692,8 +6694,6 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev,
 	scan_info->last_chan_idx = 0;
 	scan_info->scanning_vif = NULL;
 	scan_info->abort = false;
-
-	rtw89_chanctx_proceed(rtwdev);
 }
 
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev,
-- 
2.25.1


