Return-Path: <linux-wireless+bounces-28376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C375EC1CE0F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 20:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4D81A2273B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 19:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FA03590BD;
	Wed, 29 Oct 2025 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="eVTWyWKi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F84358D3A;
	Wed, 29 Oct 2025 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764582; cv=none; b=R+t1Z0qQpxYqCQDrIFQb/LUbXjnOo32hyLm7YqpTekimVwjAgSrYNkCN1S20p0fZ7MZXkda9CoTh92HBBDcd9iHpC3Nyi3RnithDUHDrStRyILuNHNzdiaBwKNs6An5+jgDmfTNjgfZKVL2EJiuYlxndBiKtsJJYPgrZ30IWHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764582; c=relaxed/simple;
	bh=++JqY2xRgABgVWB1JTlQICX2Upy1cT/z7ThhUN/t6yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrL2eQ8Hm8VFazAR9xyfiWIuY2f9q+R+RVT6anbHjYG91259UCSfpQ93S7jKrRRXmUwjAco3302DKPFFOR0pRMVEeZT298N9g7eV5bfNAHFPdUQZk4nU3O4Ewbn8b9+ozb4rSy1USFX0rV+VnruFc49ptOYgM2MpmtbXdYEhDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=eVTWyWKi; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id A54224076B5F;
	Wed, 29 Oct 2025 19:02:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A54224076B5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761764577;
	bh=Dy/hIZdPh5Pv16L0oxcsQ5VJFKqKn0FbiTRBt6QMWVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVTWyWKilIV/ckhZTteHFJqhMzlU1zdn1wUFhYOIiok5Yryo64ZtiSbVRPb46f3oz
	 Y37I6VgSUmEh9IYwnUeUME1WKQEk7XHf2tu4LM5bKmRbCxqxpjFBuCps3IDNv0ViNz
	 2ppwpgbUUQ24UwzII7RsrKnf35UHWYZhAGsIUpjY=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v4 01/10] wifi: rtw89: usb: use common error path for skbs in rtw89_usb_rx_handler()
Date: Wed, 29 Oct 2025 22:02:29 +0300
Message-ID: <20251029190241.1023856-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029190241.1023856-1-pchelkin@ispras.ru>
References: <20251029190241.1023856-1-pchelkin@ispras.ru>
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
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---

v2: - do goto 'free_or_reuse' (Ping-Ke)

 drivers/net/wireless/realtek/rtw89/usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index afbd1fb79021..15fba22b4f5d 100644
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


