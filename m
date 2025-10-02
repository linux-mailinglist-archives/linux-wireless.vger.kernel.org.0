Return-Path: <linux-wireless+bounces-27785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B322BB517C
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 22:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D9D913413D7
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 20:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AD6287245;
	Thu,  2 Oct 2025 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="kOXL0GmR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DB23771E;
	Thu,  2 Oct 2025 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435767; cv=none; b=TzIyPcWkJbc166zjUAj3vIC08AAcVUY+iGZ639dwIYzDiqcpi1ixoHuSmM0dp+ZBV66cUPNGZtpPArF0vy8U2XCyzKMoTDNl5PrA0/J1pa8BSCdAFsNx8qP4qN0IU38x66N0M6bEJg258nQ37wFX9jB+OCN/DE7JaWuPGKDM6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435767; c=relaxed/simple;
	bh=TS31Ll0MVhfsm2d8OsSMRdzNpY2B32YVtJIGpEZCsJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGJTqIxOuxdyW3pW2NKPllpSb63/JmegeK8g6tDzhkPTymjGp5HCkZHATXfIPvDSUTJPQ/wvra4rT0kgfyi2hFamZk2OplfBPOG1BA98SwBMDwu+N3JMCScnHaXqIqUmI0MFSKFCM2nB/rJ7n6+Wp0zuaG7BLRwq1nku9lYf4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=kOXL0GmR; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id C59B540762E9;
	Thu,  2 Oct 2025 20:09:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C59B540762E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1759435755;
	bh=BGdMXl5N68NrMBoJuq0iHqkTn8fos9U/ajx9IOp21OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOXL0GmRnc08EDDWtb0VTX/hrj167ux+qQ49axlXKg711myCGG3z5Y5Qf8tD/AFoG
	 EdKpeFYwXnCpSXuqwTE7w76StdzpHnqIc8Q8zcXvwLhWHqAAIEKeDTztlGeDGifeGK
	 AwZxp147KGJ3uZkZ5nbkKxLk7F9TOARLJrdutojE=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v2 1/7] wifi: rtw89: usb: use common error path for skbs in rtw89_usb_rx_handler()
Date: Thu,  2 Oct 2025 23:08:46 +0300
Message-ID: <20251002200857.657747-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002200857.657747-1-pchelkin@ispras.ru>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow adding rx_skb to rx_free_queue for later reuse on the common error
handling path, otherwise free it.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v2: - do goto 'free_or_reuse' (Ping-Ke)

 drivers/net/wireless/realtek/rtw89/usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 6cf89aee252e..e8e064cf7e0a 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -410,8 +410,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 
 		if (skb_queue_len(&rtwusb->rx_queue) >= RTW89_USB_MAX_RXQ_LEN) {
 			rtw89_warn(rtwdev, "rx_queue overflow\n");
-			dev_kfree_skb_any(rx_skb);
-			continue;
+			goto free_or_reuse;
 		}
 
 		memset(&desc_info, 0, sizeof(desc_info));
@@ -422,7 +421,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 			rtw89_debug(rtwdev, RTW89_DBG_HCI,
 				    "failed to allocate RX skb of size %u\n",
 				    desc_info.pkt_size);
-			continue;
+			goto free_or_reuse;
 		}
 
 		pkt_offset = desc_info.offset + desc_info.rxd_len;
@@ -432,6 +431,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 
 		rtw89_core_rx(rtwdev, &desc_info, skb);
 
+free_or_reuse:
 		if (skb_queue_len(&rtwusb->rx_free_queue) >= RTW89_USB_RX_SKB_NUM)
 			dev_kfree_skb_any(rx_skb);
 		else
-- 
2.51.0


