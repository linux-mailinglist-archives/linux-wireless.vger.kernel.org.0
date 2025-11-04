Return-Path: <linux-wireless+bounces-28542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D854C315B9
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 15:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A0242643D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4243E32E734;
	Tue,  4 Nov 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Kn55oFh1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4232D0FD;
	Tue,  4 Nov 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264678; cv=none; b=m2fQlhQttZ7rq9tQUPIwy531Sm4mWVZJ60HL3llVMrk2v+eAcl/cxoEjbGrN94ROLbzuwIDjXEoO1X8sOf7InHzXABwyyi5wNpBnq4FfPKnOuoW3YaUL81XprIFhjAWuRJUwfLy+BdLpvVpzPAdJpKsCI7VPhkH54f5hZPy9580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264678; c=relaxed/simple;
	bh=0hOA4YqifgKa+G88+7C+k8omjopD/7Kl3SGQGRD7Zqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtS5y8Xiq/oviFUpWkNK+OZS9ClTyGH1MyE3tWcoIEStmIyNtw5oPD3cjxwnd0Qv3UNeFv23I8exHA7GDFKufD7ecTHAPGRIDcmZrfONVQ/KTclXgVemLbyuPHoeFCpu2K/2HEQUoslE0qgoB8dqiLmSpgGfhhJA/SO7bkx9sZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Kn55oFh1; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id C162640777BB;
	Tue,  4 Nov 2025 13:57:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C162640777BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1762264665;
	bh=PFS1uGSA5pLC2SX/iuo8kzk0SrHeL9HoDNBsMKCUqzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kn55oFh1MvuYkn5QFluHs/5cVL8E2evWPKL0UQJxZQfyM0xabJkycIF6hDFQq1YPn
	 Lzzf9Ix0tif4oaVqw/Mr8hQXctzpMh02KjU9kDeCB8mo8ZNScNBiKqF9788rjFUsAh
	 Bbq1+LNng1/KOQuZf3wc/zJI4d7KR9gWIwVxU0rM=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v5 07/10] wifi: rtw89: usb: anchor TX URBs
Date: Tue,  4 Nov 2025 16:57:14 +0300
Message-ID: <20251104135720.321110-8-pchelkin@ispras.ru>
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

During HCI reset all pending TX URBs should be canceled.  Use anchor to
keep track of them and have an ability to cancel them synchronously.

Note however that canceling RX URBs can't be done here in
rtw89_usb_ops_reset() as it breaks driver initialization.

Found by Linux Verification Center (linuxtesting.org).

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 24 ++++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/usb.h |  1 +
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 59cdee54feef..b7b981bac7bf 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -221,7 +221,6 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
 	}
 
 	kfree(txcb);
-	usb_free_urb(urb);
 }
 
 static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
@@ -247,10 +246,17 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
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
@@ -557,6 +563,11 @@ static void rtw89_usb_cancel_rx_bufs(struct rtw89_usb *rtwusb)
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
@@ -658,7 +669,9 @@ static void rtw89_usb_deinit_tx(struct rtw89_dev *rtwdev)
 
 static void rtw89_usb_ops_reset(struct rtw89_dev *rtwdev)
 {
-	/* TODO: anything to do here? */
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+
+	rtw89_usb_cancel_tx_bufs(rtwusb);
 }
 
 static int rtw89_usb_ops_start(struct rtw89_dev *rtwdev)
@@ -895,6 +908,8 @@ static int rtw89_usb_intf_init(struct rtw89_dev *rtwdev,
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
 	int ret;
 
+	init_usb_anchor(&rtwusb->tx_submitted);
+
 	ret = rtw89_usb_parse(rtwdev, intf);
 	if (ret)
 		return ret;
@@ -1021,6 +1036,7 @@ void rtw89_usb_disconnect(struct usb_interface *intf)
 	rtwusb = rtw89_usb_priv(rtwdev);
 
 	rtw89_usb_cancel_rx_bufs(rtwusb);
+	rtw89_usb_cancel_tx_bufs(rtwusb);
 
 	rtw89_core_unregister(rtwdev);
 	rtw89_core_deinit(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index 32cdbf5128e4..203ec8e993e9 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -60,6 +60,7 @@ struct rtw89_usb {
 	struct sk_buff_head rx_free_queue;
 	struct work_struct rx_work;
 	struct work_struct rx_urb_work;
+	struct usb_anchor tx_submitted;
 
 	struct sk_buff_head tx_queue[RTW89_TXCH_NUM];
 };
-- 
2.51.0


