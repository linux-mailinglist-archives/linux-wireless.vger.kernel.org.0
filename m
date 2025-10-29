Return-Path: <linux-wireless+bounces-28381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CCFC1CE34
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 20:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3294C4E2794
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1935A13B;
	Wed, 29 Oct 2025 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="e682F4O5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3F359F82;
	Wed, 29 Oct 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764586; cv=none; b=HJwydAKpOlV/nt+OAwcMTuyRb8l5pQg2kWAbWy6lCYZ66A1NNimoiIzIjC0WMYjGWDd1V3BeKEFd/MmkI8RZ8odnlsTm85i6MOwNfWUxjhdJU0Q0Upjy/cmOz1E8/eHFbBcOQodTA0PllcB8OP0tIk9pCW4ULmwBU1hLTeR5Jm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764586; c=relaxed/simple;
	bh=4dtliad1hDVDUDG9X7pXCghu4QfFymCPJNzSElZI5EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvw4DoDWksdahG/CbgMFr9TTDLUhOiq91zNkgb9r0e3cYKi/Ve83EcqkTYMeOMLhZvRwMgp8/tAIZ4nDp/VlHWHFQTRSNqTrQkfn7rGt05ELF0c2DT9fcpKupMEBVeCa7tX0IJSZJRAsKKvngDrAoVg1vtNDuHmdNFl2Sc2IlfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=e682F4O5; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 015F840777B1;
	Wed, 29 Oct 2025 19:03:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 015F840777B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761764581;
	bh=anMhG7Ma5+cYRiOaaeXJ2RVavZMucYrc2CMe9I9gcgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e682F4O5MvqfueHwl6NsUq2V9XhTfwz1i8nkd1UXmjEr+l1Ql7w8+aruIgwyk99n1
	 Qng+2MTSrd/DW7u+vUrkfhtl/sdZCr6QFDb1al+JZ3DVKlcQGRR+dWZsDdF+q0efBU
	 tYDjOOHwV+pGCTQKlokHMBmzaj//Sk2zUmlNMYWk=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v4 07/10] wifi: rtw89: usb: anchor TX URBs
Date: Wed, 29 Oct 2025 22:02:35 +0300
Message-ID: <20251029190241.1023856-8-pchelkin@ispras.ru>
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

During HCI reset all pending TX URBs should be canceled.  Use anchor to
keep track of them and have an ability to cancel them synchronously.

Note however that canceling RX URBs can't be done here in
rtw89_usb_ops_reset() as it breaks driver initialization.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 24 ++++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/usb.h |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 93dc4e91c1d4..c359b469aabe 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -242,7 +242,6 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 	}
 
 	kfree(txcb);
-	usb_free_urb(urb);
 }
 
 static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
@@ -267,10 +266,17 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
 	usb_fill_bulk_urb(urb, usbd, pipe, data, len,
 			  rtw89_usb_write_port_complete, context);
 	urb->transfer_flags |= URB_ZERO_PACKET;
-	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	usb_anchor_urb(urb, &rtwusb->tx_submitted);
 
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
 	if (ret)
-		usb_free_urb(urb);
+		usb_unanchor_urb(urb);
+
+	/* release our reference to this URB, USB core will eventually free it
+	 * on its own after the completion callback finishes (or URB is
+	 * immediately freed here if its submission has failed)
+	 */
+	usb_free_urb(urb);
 
 	if (ret == -ENODEV)
 		set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
@@ -577,6 +583,11 @@ static void rtw89_usb_cancel_rx_bufs(struct rtw89_usb *rtwusb)
 	}
 }
 
+static void rtw89_usb_cancel_tx_bufs(struct rtw89_usb *rtwusb)
+{
+	usb_kill_anchored_urbs(&rtwusb->tx_submitted);
+}
+
 static void rtw89_usb_free_rx_bufs(struct rtw89_usb *rtwusb)
 {
 	struct rtw89_usb_rx_ctrl_block *rxcb;
@@ -678,7 +689,9 @@ static void rtw89_usb_deinit_tx(struct rtw89_dev *rtwdev)
 
 static void rtw89_usb_ops_reset(struct rtw89_dev *rtwdev)
 {
-	/* TODO: anything to do here? */
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+
+	rtw89_usb_cancel_tx_bufs(rtwusb);
 }
 
 static int rtw89_usb_ops_start(struct rtw89_dev *rtwdev)
@@ -911,6 +924,8 @@ static int rtw89_usb_intf_init(struct rtw89_dev *rtwdev,
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
 	int ret;
 
+	init_usb_anchor(&rtwusb->tx_submitted);
+
 	ret = rtw89_usb_parse(rtwdev, intf);
 	if (ret)
 		return ret;
@@ -1036,6 +1051,7 @@ void rtw89_usb_disconnect(struct usb_interface *intf)
 	rtwusb = rtw89_usb_priv(rtwdev);
 
 	rtw89_usb_cancel_rx_bufs(rtwusb);
+	rtw89_usb_cancel_tx_bufs(rtwusb);
 
 	rtw89_core_unregister(rtwdev);
 	rtw89_core_deinit(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index c1b4bfa20979..320002c1df42 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -49,6 +49,7 @@ struct rtw89_usb {
 	struct sk_buff_head rx_free_queue;
 	struct work_struct rx_work;
 	struct work_struct rx_urb_work;
+	struct usb_anchor tx_submitted;
 
 	struct sk_buff_head tx_queue[RTW89_TXCH_NUM];
 };
-- 
2.51.0


