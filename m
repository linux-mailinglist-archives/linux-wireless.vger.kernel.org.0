Return-Path: <linux-wireless+bounces-28022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22368BE7F14
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 12:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E27844E0EC2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E815030F7E4;
	Fri, 17 Oct 2025 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="gsYhMryw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19B30C62A;
	Fri, 17 Oct 2025 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695635; cv=none; b=OoOCYUHBuiN/2LconKEWaloqydmjiLm8PzWQr5NnE4GxQ0RVa7PCRpEawWHYD8edHlqEmsK7DPWWaB7EI5BHEP+lZ4ftNGGXqa9C9h+mbgiWUrctAZR8qOXw1gKf4XficsxMPMxqhyaJ0qix3kY8/ticrKrgbFxDQx30OsUSGGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695635; c=relaxed/simple;
	bh=Owah0fPebyWeGQ4yZJKcvA6j1KbcQatL+4/cPM8Fnfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqQeJ5jIKnuevevfJJ9f7o9JuabkrhjkT1IaADbZOaVnTueEHa2Bwbo7f0YOkXs3XgcHywJ9s0mpY0g4EeRL2KxKemkd6EHb3Kb8O/m9oRCPwBOSwiwylZ0WDPkPeln4O737N0CMZZ+mw0P/WBWVEe93toKL5Ja2UyV7MTrVSZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=gsYhMryw; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 308B94076733;
	Fri, 17 Oct 2025 10:07:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 308B94076733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760695631;
	bh=N8X6qtokggsPGsPa7HhA4JylXkwRkP73j8K7V8mb340=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsYhMrywrEyP6jpcIsZIny85t4h/++JwMkTdm66IGYtGLIS6gQcdbF2vXQk9RSzLH
	 uY7UkWxosEUuhzphCbysdZwgH+xzCCWHHepP8RufIzmlnohgIv38xK74C1Z8pQ8oWi
	 QBij2WjPyhLBEl1voyq/Cv5AYlL9EmTeGQw1wuVU=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v3 2/9] wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
Date: Fri, 17 Oct 2025 13:03:04 +0300
Message-ID: <20251017100658.66581-3-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017100658.66581-1-pchelkin@ispras.ru>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
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
index e8e064cf7e0a..512a46dd9d06 100644
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


