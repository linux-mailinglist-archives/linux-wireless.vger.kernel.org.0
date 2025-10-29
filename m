Return-Path: <linux-wireless+bounces-28380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA8FC1CE1E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 20:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1578188EBCC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 19:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D967359703;
	Wed, 29 Oct 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="O9+u1rCJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460023590AB;
	Wed, 29 Oct 2025 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764584; cv=none; b=O5QvTqRgConAoHS7xG+RsyMyz3W2Y6RdSbALOBa9MWtiLD7BIJjGuL/MRQzK1S9XJwNOC26TT17kX0nlg4VmhtLo5vHGlz9N2JZID5Z5KoX9MV53ZrFt0PLcgtPsSLU9PeQ74u4lSIHC58IfDLOhngqa3/amAAZyW0PstlxXCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764584; c=relaxed/simple;
	bh=1FtZW4U1ojwEyztWuRwA0Bae7MsM11HBqcUXmyFU5Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pnhev9jWP9oE4I8Yu1f2XdtHez79tdHoqMJF9Cso3JWCrTcsQf0kELEWJn7ikMCx1FzguBydU2DW+vfHQsEwj03oSRmKCgPFSptXjxQXdaZFLD93lFsVcSXS8UHnxWy97P2mK8P27GBcpPTmdEtQTn0lnkz0+jvH8/eG5XsLPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=O9+u1rCJ; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 58D0D40777A0;
	Wed, 29 Oct 2025 19:02:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 58D0D40777A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761764578;
	bh=OfAgYaOUI1AFIjwkIwYHMJ5+77hecm5s5YXZ1vh9cCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9+u1rCJS1rgqa1mCKytKYlzWq+fvWNitjDFaXHJYHus+tz62Vv50OKFZppIZRHUe
	 WYaUnSiilORgv+ljNbDubL/L0HTaLuGAufcQpYDLaAjb9jDN0UvQEtIWlegloX1TIY
	 Pd6NDkemgArPILXoMbMCy1OEFPNKbcsEG9kHnMX0=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v4 02/10] wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
Date: Wed, 29 Oct 2025 22:02:30 +0300
Message-ID: <20251029190241.1023856-3-pchelkin@ispras.ru>
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

When there is an attempt to write data and RTW89_FLAG_UNPLUGGED is set,
this means device is disconnected and no urb is submitted.  Return
appropriate error code to the caller to properly free the allocated
resources.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 15fba22b4f5d..1d9760e5eae7 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -256,7 +256,7 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
 	int ret;
 
 	if (test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
-		return 0;
+		return -ENODEV;
 
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urb)
@@ -305,8 +305,9 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
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


