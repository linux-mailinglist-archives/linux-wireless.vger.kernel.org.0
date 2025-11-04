Return-Path: <linux-wireless+bounces-28536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61324C31598
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764CB3BA2AF
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6843B32AAA7;
	Tue,  4 Nov 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="RQ515C7W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6332A3F5;
	Tue,  4 Nov 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264673; cv=none; b=QbWVhz2URSaxY6iBDw3nRlHy4nR2k8LKJP97/wiUVH6ipihcOYZ+eK79KDTCYAP0qkwaGIc9oO9JNdE4UAdPVbVp/PDJCjefIWgkTuuyQDCf28UmA7LIv6IGG78bQcc0Nve4iAiN6PHAxC3aIhCtSwP2I1IVQX04LfMdfYnl1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264673; c=relaxed/simple;
	bh=DRD4b4F/E8tPiqZNqn21ILhoCT45JOwJZDkj11i2v/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCwvLzzy1MM0xqSR2M+iBDssmomqnZOz6g4w64ngSLSaquFhchXJRUSjPf05rvR58Q4obiworN1Pkc1ni9tR9bNfjZWcl8MeiuKM7b+eMAHleVu+UA6QrvYxLmDMwEdA51UQbD9Vdo1O37OPmLFlfDnB8XdYfw38TcLdkb1f9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=RQ515C7W; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id D1E5440777AD;
	Tue,  4 Nov 2025 13:57:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D1E5440777AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1762264662;
	bh=y/2+9jCkzxPS1fTCMcZwEOa6EgbWgYuncUnCq7uJKg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQ515C7WSP0QJO4O/+vJxIAJ/5I6+kOzSD8UijYQcJBAaxD2IdnUb73IwmFFFbeJ6
	 5XpZaRqe49SLayulP1lnDx+X8A850xScCaxzpClo3j9YGy4ZeicHQrPMqRHOlG7Tf5
	 Z/3dhvfb0d7SjGPWxUmyokZ3BaFIQTj4fPxSB/Uo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v5 02/10] wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
Date: Tue,  4 Nov 2025 16:57:09 +0300
Message-ID: <20251104135720.321110-3-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104135720.321110-1-pchelkin@ispras.ru>
References: <20251104135720.321110-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is an attempt to write data and RTW89_FLAG_UNPLUGGED is set,
this means device is disconnected and no urb is submitted.  Return
appropriate error code to the caller to properly free the allocated
resources.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 450631c77840..639b84ebe942 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -236,7 +236,7 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
 	int ret;
 
 	if (test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
-		return 0;
+		return -ENODEV;
 
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urb)
@@ -285,8 +285,9 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 		ret = rtw89_usb_write_port(rtwdev, txch, skb->data, skb->len,
 					   txcb);
 		if (ret) {
-			rtw89_err(rtwdev, "write port txch %d failed: %d\n",
-				  txch, ret);
+			if (ret != -ENODEV)
+				rtw89_err(rtwdev, "write port txch %d failed: %d\n",
+					  txch, ret);
 
 			skb_dequeue(&txcb->tx_ack_queue);
 			kfree(txcb);
-- 
2.51.0


