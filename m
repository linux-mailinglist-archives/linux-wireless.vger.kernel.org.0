Return-Path: <linux-wireless+bounces-27536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65004B8C8F4
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 15:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF5A1BC4167
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815627F010;
	Sat, 20 Sep 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Djak5IDG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AE211290;
	Sat, 20 Sep 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758374846; cv=none; b=LZ+KcklbkUoPOFQSWMjSFK1AiyR8zsqYWkHMvUyaa+DB/oeVcgYHDO2sbO5T6jP8x2Zf/QEeIwlhOTTPIH6LFkvPyzzojVZY0B9JztHC6JuzYMN40nQQoK9JyN9do65iXhBOUzbDTAimX4YHiJvsMK5FBhMqJhpxB1zxEF+cgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758374846; c=relaxed/simple;
	bh=CD9SXmWE4h7KIW3Je0GU+kRkkA+pvqpEQOswv0W+YKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYQmZ8XfPUDxBmmSDn8mP/lGyI4HfvYW9iH2Nz/t8VlRHOui1XBp2rwlEj2YQcHdig+XZux8t0Ymd5f/VAwd5/OnMcObuEFaS5fZCG4MotGi59BSB9XCw4FLz7mnqJ4V1RLDBupOvGmblYLtfFeQjECyzX3tZIrVC+GYpyhWIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Djak5IDG; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id B41804076179;
	Sat, 20 Sep 2025 13:27:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B41804076179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758374841;
	bh=XUyJoMmMqQxS2tpA1uO3LYm9RCdNFw3sL5eS53yF7es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Djak5IDGBR28G0NtI6IjAZ6eq4MMQAGl0G0RbpefOmiTvJbYDF6ryt3g2Jd52yDE+
	 LvYC2+Yt2Dt8simfdWDye2qPh+a4DpVC3zBEkjY5HihdI7wZ+pedmQr0UkhBB1riz4
	 sdT/a2FUZNYggcSJXWeF1c+35ROiGgyMBTUux0ns=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next 2/6] wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
Date: Sat, 20 Sep 2025 16:26:07 +0300
Message-ID: <20250920132614.277719-3-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920132614.277719-1-pchelkin@ispras.ru>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
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
---
 drivers/net/wireless/realtek/rtw89/usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 3435599f4740..bc0d5e48d39b 100644
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


