Return-Path: <linux-wireless+bounces-24305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB1AE22A4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 21:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA24F4A3CC3
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 19:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF762253BA;
	Fri, 20 Jun 2025 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmfteLn3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A91CBEB9
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446281; cv=none; b=B5NY4eo0DMt4yjXYPV+wPrdScIr6IHamPv5FK1CD4smnmNtZsZNjDAA5QV/gjJYHuZikZHisE+gu0xv70ULfvvn3Jgjo1hkRtnH1+xGgU/S63wZ9GywJVCpkKmiNTRA6NpHtRjGIICfBsojhnwi0+w1vH5Z98jY74LcxxMM7cdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446281; c=relaxed/simple;
	bh=GY/OII59YRkpgB4gOn9trb1Ft2l3q/o2GQKpHSR/FLE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q6oizPxLJzA7sWpwlYiNcWWAWlPYsbrSCzoHor8Yt39K67E34bvTZrkwc+QCiy2qqPLabYDrlQt5cZMKY9CusDd95TrBl7kf7ER6LO5Jj3TebIqEqpOktD2JB9wPZAF9Sjls1C4rPcKjq0fzBbRIAqlo+ra+S7riJqzOnSZqy5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmfteLn3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-441ab63a415so22904515e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750446276; x=1751051076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GNgF2DT/5AaIEzqxu9HFjM40hRMyTS/lNxdESipmPhU=;
        b=SmfteLn38QbIqwmD5yoqNiRrGwz/jV3eF2yOOP4QO9vUR1xL0+NLufUdHXPVJOnbTq
         NuNRHlTM8cjqNR1ydwMxQtrbY+RKeUKLUoKS8NgS/acdQOnveoWAyLaa/31KHGY6FlYj
         oyEX9mikOpPAW4Kb3Uc5Tb6hI28cFgPEmu4/09cMeusC8iBaoNGyZd4oVfALVzIqCVd4
         JG2OP7+7G3BCMqeS+4pQ+R7QSFj9kfaBssH1dm/4ehPcNSiJqGWVmDTL2KhgDj1UQIDG
         daiq1uNclxNySSypAQJVMhFuWSlZ9ifbIZ7SZNctEbERQSgmMEMv9ztMQuPflGl5Rgqv
         LhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750446276; x=1751051076;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNgF2DT/5AaIEzqxu9HFjM40hRMyTS/lNxdESipmPhU=;
        b=wNgLiLDWNuiecpFvbyYfKgwajdOqXM2N1/CruSs/h5cWzQexHZ0B2uQHDDE9inNKCR
         N/8p+SPjb0XVuCvhMJzqm0rXVbxpIZMpgiKP8myB+XgDze6okHpFoZs/mOy5QbNa0sFo
         UspBljoyJX+LcMKO6XdILFk763ZynnsEHTMCLCUjUy8IJGIJBCUyRa4hAGZap2CNnVn9
         50J9aDmAsvHEa4g+8YrZhdb2zBn0vD1ZQs3PZkXTyfI9r4tAhw3QWaM8sBtXtdSwDjwL
         dsFbbtOGxXPebV+WzrxzJUUm3bMiIOftBps1le9wX8n3yTvMfmUX9oWVkmegENjvvM7K
         l6PA==
X-Gm-Message-State: AOJu0Ywi4Zixub8qPaE0TtyY6WbhBwCT+OAfnpdV/Y9KmjYutgARowTO
	+00vexgJO47oxE7ATJwri3GrfdV8rd0bUEYqfeG9hx3TpjJTJw1YF8y2vO1k+A==
X-Gm-Gg: ASbGncuawqITS0xR77pSbkdndL6/G2q9EzCYzPfVI0CSJbeZKorIMjuaQyJECLOvTrV
	vPyj95MPtOzBUuguZzM1nJYFvOncSz1rEnk3lmJfvbuG+ST8hWpYRCgNwooKl+3fDiUOrBDhRb8
	ojHHUYOnlH+Memc4Q5qQWXrCFpii4A/mJz8b2YrrArffBhsYR2prmAOEJ2ZAJqKT/RjDhNXq/r7
	Nehk9+I5hCIR2tL0StMObCeeTlmRfhqb5eVmwnbLuKfwyG4QXXxe8ijBZtftWh69ioHlJGMw5KQ
	II7PHbrc7SxwzxvtZk6rN4YyHK91p3wQlvip/H1milK1jxwywjqliR2r2M9hgl73eCDC2g==
X-Google-Smtp-Source: AGHT+IHPe/Q31kNcOJcb4JLkltzPPdglnVW3/mY7tHKhLVPwp15yR+LmypdbKxpqWDQvkn2PTvB6ew==
X-Received: by 2002:a05:600c:5490:b0:44b:eb56:1d45 with SMTP id 5b1f17b1804b1-453655c30e4mr46521625e9.15.1750446275743;
        Fri, 20 Jun 2025 12:04:35 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97adf3sm66510175e9.8.2025.06.20.12.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 12:04:35 -0700 (PDT)
Message-ID: <4f456355-fdc5-4624-ab00-ed374f3b58a1@gmail.com>
Date: Fri, 20 Jun 2025 22:04:34 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 12/14] wifi: rtw89: Add usb.{c,h}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add very basic USB support. No TX/RX aggregation, no TX queues, no
switching to USB 3 mode.

RTL8851BU and RTL8832BU work.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Don't do vendor requests when unplugged.
 - Rename rtw89_get_usb_priv() to rtw89_usb_priv().
 - Move rtw89_usb_read_port_complete() forward declaration to the top
   of usb.c.
 - Remove unnecessary empty lines.
 - Rename "error" variable to "ret".
 - Don't call usb_kill_urb() in rtw89_usb_free_rx_bufs().
 - Use u32_get_bits() in rtw89_usb_vendorreq().
 - Initialise rtwdev->hci.dle_type.
 - Delete vendor_req_mutex.

v3:
 - Avoid skb_over_panic in rtw89_usb_fwcmd_submit() when the size is
   a multiple of 512. We can't just extend the skb by 4 bytes, it has
   to be copied. This was triggered by the hardware scan offload feature
   in the "00" regulatory domain.
 - Convert the warning in rtw89_usb_fwcmd_submit() into a debug message.
 - Delete empty line in rtw89_usb_fwcmd_submit().
 - Reschedule rx_work when rtw89_usb_rx_handler() finds more than 200
   frames in the queue.
 - Use sizeof(*rtwusb->vendor_req_buf) instead of sizeof(u32) in
   rtw89_usb_intf_init().
---
 drivers/net/wireless/realtek/rtw89/usb.c | 1031 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.h |   60 ++
 2 files changed, 1091 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.h

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
new file mode 100644
index 000000000000..f92ea6068c95
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -0,0 +1,1031 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2025  Realtek Corporation
+ */
+
+#include <linux/usb.h>
+#include "debug.h"
+#include "mac.h"
+#include "reg.h"
+#include "txrx.h"
+#include "usb.h"
+
+static void rtw89_usb_read_port_complete(struct urb *urb);
+
+static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
+				void *data, u16 len, u8 reqtype)
+{
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	struct usb_device *udev = rtwusb->udev;
+	unsigned int pipe;
+	u16 value, index;
+	int attempt, ret;
+
+	if (test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+		return;
+
+	value = u32_get_bits(addr, GENMASK(15, 0));
+	index = u32_get_bits(addr, GENMASK(23, 16));
+
+	for (attempt = 0; attempt < 10; attempt++) {
+		*rtwusb->vendor_req_buf = 0;
+
+		if (reqtype == RTW89_USB_VENQT_READ) {
+			pipe = usb_rcvctrlpipe(udev, 0);
+		} else { /* RTW89_USB_VENQT_WRITE */
+			pipe = usb_sndctrlpipe(udev, 0);
+
+			memcpy(rtwusb->vendor_req_buf, data, len);
+		}
+
+		ret = usb_control_msg(udev, pipe, RTW89_USB_VENQT, reqtype,
+				      value, index, rtwusb->vendor_req_buf,
+				      len, 500);
+
+		if (ret == len) { /* Success */
+			atomic_set(&rtwusb->continual_io_error, 0);
+
+			if (reqtype == RTW89_USB_VENQT_READ)
+				memcpy(data, rtwusb->vendor_req_buf, len);
+
+			break;
+		}
+
+		if (ret == -ESHUTDOWN || ret == -ENODEV)
+			set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
+		else if (ret < 0)
+			rtw89_warn(rtwdev,
+				   "usb %s%u 0x%x fail ret=%d value=0x%x attempt=%d\n",
+				   reqtype == RTW89_USB_VENQT_READ ? "read" : "write",
+				   len * 8, addr, ret,
+				   le32_to_cpup(rtwusb->vendor_req_buf),
+				   attempt);
+		else if (ret > 0 && reqtype == RTW89_USB_VENQT_READ)
+			memcpy(data, rtwusb->vendor_req_buf, len);
+
+		if (atomic_inc_return(&rtwusb->continual_io_error) > 4) {
+			set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
+			break;
+		}
+	}
+}
+
+static u32 rtw89_usb_read_cmac(struct rtw89_dev *rtwdev, u32 addr)
+{
+	u32 addr32, val32, shift;
+	__le32 data = 0;
+	int count;
+
+	addr32 = addr & ~0x3;
+	shift = (addr & 0x3) * 8;
+
+	for (count = 0; ; count++) {
+		rtw89_usb_vendorreq(rtwdev, addr32, &data, 4,
+				    RTW89_USB_VENQT_READ);
+
+		val32 = le32_to_cpu(data);
+		if (val32 != RTW89_R32_DEAD)
+			break;
+
+		if (count >= MAC_REG_POOL_COUNT) {
+			rtw89_warn(rtwdev, "%s: addr %#x = %#x\n",
+				   __func__, addr32, val32);
+			val32 = RTW89_R32_DEAD;
+			break;
+		}
+
+		rtw89_write32(rtwdev, R_AX_CK_EN, B_AX_CMAC_ALLCKEN);
+	}
+
+	return val32 >> shift;
+}
+
+static u8 rtw89_usb_ops_read8(struct rtw89_dev *rtwdev, u32 addr)
+{
+	u8 data = 0;
+
+	if (ACCESS_CMAC(addr))
+		return rtw89_usb_read_cmac(rtwdev, addr);
+
+	rtw89_usb_vendorreq(rtwdev, addr, &data, 1, RTW89_USB_VENQT_READ);
+
+	return data;
+}
+
+static u16 rtw89_usb_ops_read16(struct rtw89_dev *rtwdev, u32 addr)
+{
+	__le16 data = 0;
+
+	if (ACCESS_CMAC(addr))
+		return rtw89_usb_read_cmac(rtwdev, addr);
+
+	rtw89_usb_vendorreq(rtwdev, addr, &data, 2, RTW89_USB_VENQT_READ);
+
+	return le16_to_cpu(data);
+}
+
+static u32 rtw89_usb_ops_read32(struct rtw89_dev *rtwdev, u32 addr)
+{
+	__le32 data = 0;
+
+	if (ACCESS_CMAC(addr))
+		return rtw89_usb_read_cmac(rtwdev, addr);
+
+	rtw89_usb_vendorreq(rtwdev, addr, &data, 4,
+			    RTW89_USB_VENQT_READ);
+
+	return le32_to_cpu(data);
+}
+
+static void rtw89_usb_ops_write8(struct rtw89_dev *rtwdev, u32 addr, u8 val)
+{
+	u8 data = val;
+
+	rtw89_usb_vendorreq(rtwdev, addr, &data, 1, RTW89_USB_VENQT_WRITE);
+}
+
+static void rtw89_usb_ops_write16(struct rtw89_dev *rtwdev, u32 addr, u16 val)
+{
+	__le16 data = cpu_to_le16(val);
+
+	rtw89_usb_vendorreq(rtwdev, addr, &data, 2, RTW89_USB_VENQT_WRITE);
+}
+
+static void rtw89_usb_ops_write32(struct rtw89_dev *rtwdev, u32 addr, u32 val)
+{
+	__le32 data = cpu_to_le32(val);
+
+	rtw89_usb_vendorreq(rtwdev, addr, &data, 4, RTW89_USB_VENQT_WRITE);
+}
+
+static u32
+rtw89_usb_ops_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
+					    u8 txch)
+{
+	if (txch == RTW89_TXCH_CH12)
+		return 1;
+
+	return 42; /* TODO some kind of calculation? */
+}
+
+static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
+{
+	/* TODO later. for now transmit every frame right away in
+	 * rtw89_usb_ops_tx_write
+	 */
+}
+
+static u8 rtw89_usb_get_bulkout_id(u8 ch_dma)
+{
+	switch (ch_dma) {
+	case RTW89_DMA_ACH0:
+		return 3;
+	case RTW89_DMA_ACH1:
+		return 4;
+	case RTW89_DMA_ACH2:
+		return 5;
+	case RTW89_DMA_ACH3:
+		return 6;
+	default:
+	case RTW89_DMA_B0MG:
+		return 0;
+	case RTW89_DMA_B0HI:
+		return 1;
+	case RTW89_DMA_H2C:
+		return 2;
+	}
+}
+
+static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
+				void *data, int len, usb_complete_t cb,
+				void *context)
+{
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	struct usb_device *usbd = rtwusb->udev;
+	struct urb *urb;
+	u8 bulkout_id = rtw89_usb_get_bulkout_id(ch_dma);
+	unsigned int pipe;
+	int ret;
+
+	if (test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+		return 0;
+
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb)
+		return -ENOMEM;
+
+	pipe = usb_sndbulkpipe(usbd, rtwusb->out_pipe[bulkout_id]);
+
+	usb_fill_bulk_urb(urb, usbd, pipe, data, len, cb, context);
+	urb->transfer_flags |= URB_ZERO_PACKET;
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+
+	if (ret)
+		usb_free_urb(urb);
+
+	if (ret == -ENODEV)
+		set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
+
+	return ret;
+}
+
+static void rtw89_usb_write_port_complete_fwcmd(struct urb *urb)
+{
+	struct rtw89_usb_tx_ctrl_block *txcb = urb->context;
+	struct rtw89_dev *rtwdev = txcb->rtwdev;
+
+	switch (urb->status) {
+	case 0:
+	case -EPIPE:
+	case -EPROTO:
+	case -EINPROGRESS:
+	case -ENOENT:
+	case -ECONNRESET:
+		break;
+	default:
+		set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
+		break;
+	}
+
+	skb_queue_purge(&txcb->tx_ack_queue);
+	kfree(txcb);
+	usb_free_urb(urb);
+}
+
+static int rtw89_usb_fwcmd_submit(struct rtw89_dev *rtwdev,
+				  struct rtw89_core_tx_request *tx_req)
+{
+	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	struct rtw89_usb_tx_ctrl_block *txcb;
+	struct sk_buff *skb = tx_req->skb;
+	struct sk_buff *skb512;
+	int txdesc_size = rtwdev->chip->h2c_desc_size;
+	void *txdesc;
+	int ret;
+
+	if (((desc_info->pkt_size + txdesc_size) % 512) == 0) {
+		rtw89_info(rtwdev, "avoiding multiple of 512\n");
+
+		skb512 = dev_alloc_skb(txdesc_size + desc_info->pkt_size +
+				       RTW89_USB_MOD512_PADDING);
+		if (!skb512) {
+			rtw89_err(rtwdev, "%s: failed to allocate skb\n",
+				  __func__);
+
+			return -ENOMEM;
+		}
+
+		skb_pull(skb512, txdesc_size);
+		skb_put_data(skb512, skb->data, skb->len);
+		skb_put_zero(skb512, RTW89_USB_MOD512_PADDING);
+
+		dev_kfree_skb_any(skb);
+		skb = skb512;
+		tx_req->skb = skb512;
+
+		desc_info->pkt_size += RTW89_USB_MOD512_PADDING;
+	}
+
+	txcb = kmalloc(sizeof(*txcb), GFP_ATOMIC);
+	if (!txcb)
+		return -ENOMEM;
+
+	txdesc = skb_push(skb, txdesc_size);
+	memset(txdesc, 0, txdesc_size);
+	rtw89_chip_fill_txdesc_fwcmd(rtwdev, desc_info, txdesc);
+
+	txcb->rtwdev = rtwdev;
+	skb_queue_head_init(&txcb->tx_ack_queue);
+
+	skb_queue_tail(&txcb->tx_ack_queue, skb);
+
+	ret = rtw89_usb_write_port(rtwdev, RTW89_DMA_H2C, skb->data, skb->len,
+				   rtw89_usb_write_port_complete_fwcmd, txcb);
+	if (ret) {
+		rtw89_err(rtwdev, "%s failed: %d\n", __func__, ret);
+
+		skb_dequeue(&txcb->tx_ack_queue);
+		kfree(txcb);
+	}
+
+	return ret;
+}
+
+static void rtw89_usb_write_port_complete(struct urb *urb)
+{
+	struct rtw89_usb_tx_ctrl_block *txcb = urb->context;
+	struct rtw89_dev *rtwdev = txcb->rtwdev;
+	struct ieee80211_tx_info *info;
+	struct sk_buff *skb;
+
+	while (true) {
+		skb = skb_dequeue(&txcb->tx_ack_queue);
+		if (!skb)
+			break;
+
+		info = IEEE80211_SKB_CB(skb);
+		ieee80211_tx_info_clear_status(info);
+
+		if (urb->status == 0) {
+			if (info->flags & IEEE80211_TX_CTL_NO_ACK)
+				info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
+			else
+				info->flags |= IEEE80211_TX_STAT_ACK;
+		}
+
+		ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
+	}
+
+	switch (urb->status) {
+	case 0:
+	case -EPIPE:
+	case -EPROTO:
+	case -EINPROGRESS:
+	case -ENOENT:
+	case -ECONNRESET:
+		break;
+	default:
+		set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
+		break;
+	}
+
+	kfree(txcb);
+	usb_free_urb(urb);
+}
+
+static int rtw89_usb_ops_tx_write(struct rtw89_dev *rtwdev,
+				  struct rtw89_core_tx_request *tx_req)
+{
+	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_usb_tx_ctrl_block *txcb;
+	struct sk_buff *skb = tx_req->skb;
+	struct rtw89_txwd_body *txdesc;
+	u32 txdesc_size;
+	int ret, len;
+
+	if ((desc_info->ch_dma == RTW89_TXCH_CH12 ||
+	     tx_req->tx_type == RTW89_CORE_TX_TYPE_FWCMD) &&
+	    (desc_info->ch_dma != RTW89_TXCH_CH12 ||
+	     tx_req->tx_type != RTW89_CORE_TX_TYPE_FWCMD)) {
+		rtw89_err(rtwdev, "dma channel %d/TX type %d mismatch\n",
+			  desc_info->ch_dma, tx_req->tx_type);
+		return -EINVAL;
+	}
+
+	if (desc_info->ch_dma == RTW89_TXCH_CH12)
+		return rtw89_usb_fwcmd_submit(rtwdev, tx_req);
+
+	txcb = kmalloc(sizeof(*txcb), GFP_ATOMIC);
+	if (!txcb)
+		return -ENOMEM;
+
+	txdesc_size = chip->txwd_body_size;
+	if (desc_info->en_wd_info)
+		txdesc_size += chip->txwd_info_size;
+
+	txdesc = (struct rtw89_txwd_body *)(skb->data - txdesc_size);
+	len = skb->len + txdesc_size;
+	memset(txdesc, 0, txdesc_size);
+	rtw89_chip_fill_txdesc(rtwdev, desc_info, txdesc);
+
+	le32p_replace_bits(&txdesc->dword0, 1, RTW89_TXWD_BODY0_STF_MODE);
+
+	txcb->rtwdev = rtwdev;
+	skb_queue_head_init(&txcb->tx_ack_queue);
+
+	skb_queue_tail(&txcb->tx_ack_queue, skb);
+
+	ret = rtw89_usb_write_port(rtwdev, desc_info->ch_dma, txdesc, len,
+				   rtw89_usb_write_port_complete, txcb);
+	if (ret) {
+		rtw89_err(rtwdev, "%s failed: %d\n", __func__, ret);
+
+		skb_dequeue(&txcb->tx_ack_queue);
+		kfree(txcb);
+	}
+
+	return ret;
+}
+
+static void rtw89_usb_rx_handler(struct work_struct *work)
+{
+	struct rtw89_usb *rtwusb = container_of(work, struct rtw89_usb, rx_work);
+	struct rtw89_dev *rtwdev = rtwusb->rtwdev;
+	struct rtw89_rx_desc_info desc_info;
+	struct sk_buff *rx_skb;
+	struct sk_buff *skb;
+	u32 pkt_offset;
+	int limit;
+
+	for (limit = 0; limit < 200; limit++) {
+		rx_skb = skb_dequeue(&rtwusb->rx_queue);
+		if (!rx_skb)
+			break;
+
+		if (skb_queue_len(&rtwusb->rx_queue) >= RTW89_USB_MAX_RXQ_LEN) {
+			rtw89_warn(rtwdev, "rx_queue overflow\n");
+			dev_kfree_skb_any(rx_skb);
+			continue;
+		}
+
+		memset(&desc_info, 0, sizeof(desc_info));
+		rtw89_chip_query_rxdesc(rtwdev, &desc_info, rx_skb->data, 0);
+
+		skb = rtw89_alloc_skb_for_rx(rtwdev, desc_info.pkt_size);
+		if (!skb) {
+			rtw89_debug(rtwdev, RTW89_DBG_HCI,
+				    "failed to allocate RX skb of size %u\n",
+				    desc_info.pkt_size);
+			continue;
+		}
+
+		pkt_offset = desc_info.offset + desc_info.rxd_len;
+
+		skb_put_data(skb, rx_skb->data + pkt_offset,
+			     desc_info.pkt_size);
+
+		rtw89_core_rx(rtwdev, &desc_info, skb);
+
+		if (skb_queue_len(&rtwusb->rx_free_queue) >= RTW89_USB_RX_SKB_NUM)
+			dev_kfree_skb_any(rx_skb);
+		else
+			skb_queue_tail(&rtwusb->rx_free_queue, rx_skb);
+	}
+
+	if (limit == 200) {
+		rtw89_debug(rtwdev, RTW89_DBG_HCI,
+			    "left %d rx skbs in the queue for later\n",
+			    skb_queue_len(&rtwusb->rx_queue));
+		queue_work(rtwusb->rxwq, &rtwusb->rx_work);
+	}
+}
+
+static void rtw89_usb_rx_resubmit(struct rtw89_usb *rtwusb,
+				  struct rtw89_usb_rx_ctrl_block *rxcb,
+				  gfp_t gfp)
+{
+	struct rtw89_dev *rtwdev = rtwusb->rtwdev;
+	struct sk_buff *rx_skb;
+	int ret;
+
+	rx_skb = skb_dequeue(&rtwusb->rx_free_queue);
+	if (!rx_skb)
+		rx_skb = alloc_skb(RTW89_USB_RECVBUF_SZ, gfp);
+
+	if (!rx_skb)
+		goto try_later;
+
+	skb_reset_tail_pointer(rx_skb);
+	rx_skb->len = 0;
+
+	rxcb->rx_skb = rx_skb;
+
+	usb_fill_bulk_urb(rxcb->rx_urb, rtwusb->udev,
+			  usb_rcvbulkpipe(rtwusb->udev, rtwusb->in_pipe),
+			  rxcb->rx_skb->data, RTW89_USB_RECVBUF_SZ,
+			  rtw89_usb_read_port_complete, rxcb);
+
+	ret = usb_submit_urb(rxcb->rx_urb, gfp);
+	if (ret) {
+		skb_queue_tail(&rtwusb->rx_free_queue, rxcb->rx_skb);
+
+		if (ret == -ENODEV)
+			set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
+		else
+			rtw89_err(rtwdev, "Err sending rx data urb %d\n", ret);
+
+		if (ret == -ENOMEM)
+			goto try_later;
+	}
+
+	return;
+
+try_later:
+	rxcb->rx_skb = NULL;
+	queue_work(rtwusb->rxwq, &rtwusb->rx_urb_work);
+}
+
+static void rtw89_usb_rx_resubmit_work(struct work_struct *work)
+{
+	struct rtw89_usb *rtwusb = container_of(work, struct rtw89_usb, rx_urb_work);
+	struct rtw89_usb_rx_ctrl_block *rxcb;
+	int i;
+
+	for (i = 0; i < RTW89_USB_RXCB_NUM; i++) {
+		rxcb = &rtwusb->rx_cb[i];
+
+		if (!rxcb->rx_skb)
+			rtw89_usb_rx_resubmit(rtwusb, rxcb, GFP_ATOMIC);
+	}
+}
+
+static void rtw89_usb_read_port_complete(struct urb *urb)
+{
+	struct rtw89_usb_rx_ctrl_block *rxcb = urb->context;
+	struct rtw89_dev *rtwdev = rxcb->rtwdev;
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	struct sk_buff *skb = rxcb->rx_skb;
+
+	if (urb->status == 0) {
+		if (urb->actual_length > urb->transfer_buffer_length ||
+		    urb->actual_length < sizeof(struct rtw89_rxdesc_short)) {
+			rtw89_err(rtwdev, "failed to get urb length: %d\n",
+				  urb->actual_length);
+			skb_queue_tail(&rtwusb->rx_free_queue, skb);
+		} else {
+			skb_put(skb, urb->actual_length);
+			skb_queue_tail(&rtwusb->rx_queue, skb);
+			queue_work(rtwusb->rxwq, &rtwusb->rx_work);
+		}
+
+		rtw89_usb_rx_resubmit(rtwusb, rxcb, GFP_ATOMIC);
+	} else {
+		skb_queue_tail(&rtwusb->rx_free_queue, skb);
+
+		if (atomic_inc_return(&rtwusb->continual_io_error) > 4)
+			set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
+
+		switch (urb->status) {
+		case -EINVAL:
+		case -EPIPE:
+		case -ENODEV:
+		case -ESHUTDOWN:
+			set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
+			break;
+		case -EPROTO:
+		case -EILSEQ:
+		case -ETIME:
+		case -ECOMM:
+		case -EOVERFLOW:
+		case -ENOENT:
+			break;
+		case -EINPROGRESS:
+			rtw89_info(rtwdev, "URB is in progress\n");
+			break;
+		default:
+			rtw89_err(rtwdev, "%s status %d\n",
+				  __func__, urb->status);
+			break;
+		}
+	}
+}
+
+static void rtw89_usb_cancel_rx_bufs(struct rtw89_usb *rtwusb)
+{
+	struct rtw89_usb_rx_ctrl_block *rxcb;
+	int i;
+
+	for (i = 0; i < RTW89_USB_RXCB_NUM; i++) {
+		rxcb = &rtwusb->rx_cb[i];
+		usb_kill_urb(rxcb->rx_urb);
+	}
+}
+
+static void rtw89_usb_free_rx_bufs(struct rtw89_usb *rtwusb)
+{
+	struct rtw89_usb_rx_ctrl_block *rxcb;
+	int i;
+
+	for (i = 0; i < RTW89_USB_RXCB_NUM; i++) {
+		rxcb = &rtwusb->rx_cb[i];
+		usb_free_urb(rxcb->rx_urb);
+	}
+}
+
+static int rtw89_usb_alloc_rx_bufs(struct rtw89_usb *rtwusb)
+{
+	struct rtw89_usb_rx_ctrl_block *rxcb;
+	int i;
+
+	for (i = 0; i < RTW89_USB_RXCB_NUM; i++) {
+		rxcb = &rtwusb->rx_cb[i];
+
+		rxcb->rtwdev = rtwusb->rtwdev;
+		rxcb->rx_urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!rxcb->rx_urb) {
+			rtw89_usb_free_rx_bufs(rtwusb);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static int rtw89_usb_init_rx(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	struct sk_buff *rx_skb;
+	int i;
+
+	rtwusb->rxwq = alloc_workqueue("rtw89_usb: rx wq", WQ_BH, 0);
+	if (!rtwusb->rxwq) {
+		rtw89_err(rtwdev, "failed to create RX work queue\n");
+		return -ENOMEM;
+	}
+
+	skb_queue_head_init(&rtwusb->rx_queue);
+	skb_queue_head_init(&rtwusb->rx_free_queue);
+
+	INIT_WORK(&rtwusb->rx_work, rtw89_usb_rx_handler);
+	INIT_WORK(&rtwusb->rx_urb_work, rtw89_usb_rx_resubmit_work);
+
+	for (i = 0; i < RTW89_USB_RX_SKB_NUM; i++) {
+		rx_skb = alloc_skb(RTW89_USB_RECVBUF_SZ, GFP_KERNEL);
+		if (rx_skb)
+			skb_queue_tail(&rtwusb->rx_free_queue, rx_skb);
+	}
+
+	return 0;
+}
+
+static void rtw89_usb_deinit_rx(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+
+	skb_queue_purge(&rtwusb->rx_queue);
+
+	destroy_workqueue(rtwusb->rxwq);
+
+	skb_queue_purge(&rtwusb->rx_free_queue);
+}
+
+static void rtw89_usb_start_rx(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	int i;
+
+	for (i = 0; i < RTW89_USB_RXCB_NUM; i++)
+		rtw89_usb_rx_resubmit(rtwusb, &rtwusb->rx_cb[i], GFP_KERNEL);
+}
+
+static void rtw89_usb_ops_reset(struct rtw89_dev *rtwdev)
+{
+	/* TODO: anything to do here? */
+}
+
+static int rtw89_usb_ops_start(struct rtw89_dev *rtwdev)
+{
+	return 0; /* Nothing to do. */
+}
+
+static void rtw89_usb_ops_stop(struct rtw89_dev *rtwdev)
+{
+	/* Nothing to do. */
+}
+
+static void rtw89_usb_ops_pause(struct rtw89_dev *rtwdev, bool pause)
+{
+	/* Nothing to do? */
+}
+
+static void rtw89_usb_ops_switch_mode(struct rtw89_dev *rtwdev, bool low_power)
+{
+	/* Nothing to do. */
+}
+
+static int rtw89_usb_ops_deinit(struct rtw89_dev *rtwdev)
+{
+	return 0; /* Nothing to do. */
+}
+
+static int rtw89_usb_ops_mac_pre_init(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+
+	rtw89_write32_set(rtwdev, R_AX_USB_HOST_REQUEST_2, B_AX_R_USBIO_MODE);
+
+	/* fix USB IO hang suggest by chihhanli@realtek.com */
+	rtw89_write32_clr(rtwdev, R_AX_USB_WLAN0_1,
+			  B_AX_USBRX_RST | B_AX_USBTX_RST);
+
+	val32 = rtw89_read32(rtwdev, R_AX_HCI_FUNC_EN);
+	val32 &= ~(B_AX_HCI_RXDMA_EN | B_AX_HCI_TXDMA_EN);
+	rtw89_write32(rtwdev, R_AX_HCI_FUNC_EN, val32);
+
+	val32 |= B_AX_HCI_RXDMA_EN | B_AX_HCI_TXDMA_EN;
+	rtw89_write32(rtwdev, R_AX_HCI_FUNC_EN, val32);
+	/* fix USB TRX hang suggest by chihhanli@realtek.com */
+
+	return 0;
+}
+
+static int rtw89_usb_ops_mac_pre_deinit(struct rtw89_dev *rtwdev)
+{
+	return 0; /* Nothing to do. */
+}
+
+static int rtw89_usb_ops_mac_post_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	enum usb_device_speed speed;
+	u32 ep;
+
+	rtw89_write32_clr(rtwdev, R_AX_USB3_MAC_NPI_CONFIG_INTF_0,
+			  B_AX_SSPHY_LFPS_FILTER);
+
+	speed = rtwusb->udev->speed;
+
+	if (speed == USB_SPEED_SUPER)
+		rtw89_write8(rtwdev, R_AX_RXDMA_SETTING, USB3_BULKSIZE);
+	else if (speed == USB_SPEED_HIGH)
+		rtw89_write8(rtwdev, R_AX_RXDMA_SETTING, USB2_BULKSIZE);
+	else
+		rtw89_write8(rtwdev, R_AX_RXDMA_SETTING, USB11_BULKSIZE);
+
+	for (ep = 5; ep <= 12; ep++) {
+		if (ep == 8)
+			continue;
+
+		rtw89_write8_mask(rtwdev, R_AX_USB_ENDPOINT_0,
+				  B_AX_EP_IDX, ep);
+		rtw89_write8(rtwdev, R_AX_USB_ENDPOINT_2 + 1, NUMP);
+	}
+
+	return 0;
+}
+
+static void rtw89_usb_ops_recalc_int_mit(struct rtw89_dev *rtwdev)
+{
+	/* Nothing to do. */
+}
+
+static int rtw89_usb_ops_mac_lv1_rcvy(struct rtw89_dev *rtwdev,
+				      enum rtw89_lv1_rcvy_step step)
+{
+	u32 reg, mask;
+
+	switch (rtwdev->chip->chip_id) {
+	case RTL8851B:
+	case RTL8852A:
+	case RTL8852B:
+		reg = R_AX_USB_WLAN0_1;
+		mask = B_AX_USBRX_RST | B_AX_USBTX_RST;
+		break;
+	case RTL8852C:
+		reg = R_AX_USB_WLAN0_1_V1;
+		mask = B_AX_USBRX_RST_V1 | B_AX_USBTX_RST_V1;
+		break;
+	default:
+		rtw89_err(rtwdev, "%s: fix me\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	switch (step) {
+	case RTW89_LV1_RCVY_STEP_1:
+		rtw89_write32_set(rtwdev, reg, mask);
+
+		msleep(30);
+		break;
+	case RTW89_LV1_RCVY_STEP_2:
+		rtw89_write32_clr(rtwdev, reg, mask);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void rtw89_usb_ops_dump_err_status(struct rtw89_dev *rtwdev)
+{
+	rtw89_warn(rtwdev, "%s TODO\n", __func__);
+}
+
+static const struct rtw89_hci_ops rtw89_usb_ops = {
+	.tx_write	= rtw89_usb_ops_tx_write,
+	.tx_kick_off	= rtw89_usb_ops_tx_kick_off,
+	.flush_queues	= NULL, /* Not needed? */
+	.reset		= rtw89_usb_ops_reset,
+	.start		= rtw89_usb_ops_start,
+	.stop		= rtw89_usb_ops_stop,
+	.pause		= rtw89_usb_ops_pause,
+	.switch_mode	= rtw89_usb_ops_switch_mode,
+	.recalc_int_mit = rtw89_usb_ops_recalc_int_mit,
+
+	.read8		= rtw89_usb_ops_read8,
+	.read16		= rtw89_usb_ops_read16,
+	.read32		= rtw89_usb_ops_read32,
+	.write8		= rtw89_usb_ops_write8,
+	.write16	= rtw89_usb_ops_write16,
+	.write32	= rtw89_usb_ops_write32,
+
+	.mac_pre_init	= rtw89_usb_ops_mac_pre_init,
+	.mac_pre_deinit	= rtw89_usb_ops_mac_pre_deinit,
+	.mac_post_init	= rtw89_usb_ops_mac_post_init,
+	.deinit		= rtw89_usb_ops_deinit,
+
+	.check_and_reclaim_tx_resource = rtw89_usb_ops_check_and_reclaim_tx_resource,
+	.mac_lv1_rcvy	= rtw89_usb_ops_mac_lv1_rcvy,
+	.dump_err_status = rtw89_usb_ops_dump_err_status,
+	.napi_poll	= NULL,
+
+	.recovery_start = NULL,
+	.recovery_complete = NULL,
+
+	.ctrl_txdma_ch	= NULL,
+	.ctrl_txdma_fw_ch = NULL,
+	.ctrl_trxhci	= NULL,
+	.poll_txdma_ch_idle = NULL,
+
+	.clr_idx_all	= NULL,
+	.clear		= NULL,
+	.disable_intr	= NULL,
+	.enable_intr	= NULL,
+	.rst_bdram	= NULL,
+};
+
+static int rtw89_usb_parse(struct rtw89_dev *rtwdev,
+			   struct usb_interface *intf)
+{
+	struct usb_host_interface *host_interface = &intf->altsetting[0];
+	struct usb_interface_descriptor *intf_desc = &host_interface->desc;
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	struct usb_endpoint_descriptor *endpoint;
+	int num_out_pipes = 0;
+	u8 num;
+	int i;
+
+	if (intf_desc->bNumEndpoints > RTW89_MAX_ENDPOINT_NUM) {
+		rtw89_err(rtwdev, "found %d endpoints, expected %d max\n",
+			  intf_desc->bNumEndpoints, RTW89_MAX_ENDPOINT_NUM);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < intf_desc->bNumEndpoints; i++) {
+		endpoint = &host_interface->endpoint[i].desc;
+		num = usb_endpoint_num(endpoint);
+
+		if (usb_endpoint_dir_in(endpoint) &&
+		    usb_endpoint_xfer_bulk(endpoint)) {
+			if (rtwusb->in_pipe) {
+				rtw89_err(rtwdev,
+					  "found more than 1 bulk in endpoint\n");
+				return -EINVAL;
+			}
+
+			rtwusb->in_pipe = num;
+		}
+
+		if (usb_endpoint_dir_out(endpoint) &&
+		    usb_endpoint_xfer_bulk(endpoint)) {
+			if (num_out_pipes >= RTW89_MAX_BULKOUT_NUM) {
+				rtw89_err(rtwdev,
+					  "found more than %d bulk out endpoints\n",
+					  RTW89_MAX_BULKOUT_NUM);
+				return -EINVAL;
+			}
+
+			rtwusb->out_pipe[num_out_pipes++] = num;
+		}
+	}
+
+	if (num_out_pipes < 1) {
+		rtw89_err(rtwdev, "no bulk out endpoints found\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rtw89_usb_intf_init(struct rtw89_dev *rtwdev,
+			       struct usb_interface *intf)
+{
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	int ret;
+
+	ret = rtw89_usb_parse(rtwdev, intf);
+	if (ret)
+		return ret;
+
+	rtwusb->vendor_req_buf = kmalloc(sizeof(*rtwusb->vendor_req_buf),
+					 GFP_KERNEL);
+	if (!rtwusb->vendor_req_buf)
+		return -ENOMEM;
+
+	rtwusb->udev = usb_get_dev(interface_to_usbdev(intf));
+
+	usb_set_intfdata(intf, rtwdev->hw);
+
+	SET_IEEE80211_DEV(rtwdev->hw, &intf->dev);
+
+	return 0;
+}
+
+static void rtw89_usb_intf_deinit(struct rtw89_dev *rtwdev,
+				  struct usb_interface *intf)
+{
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+
+	usb_put_dev(rtwusb->udev);
+	kfree(rtwusb->vendor_req_buf);
+	usb_set_intfdata(intf, NULL);
+}
+
+int rtw89_usb_probe(struct usb_interface *intf,
+		    const struct usb_device_id *id)
+{
+	const struct rtw89_driver_info *info;
+	struct rtw89_dev *rtwdev;
+	struct rtw89_usb *rtwusb;
+	int ret;
+
+	info = (const struct rtw89_driver_info *)id->driver_info;
+
+	rtwdev = rtw89_alloc_ieee80211_hw(&intf->dev,
+					  sizeof(struct rtw89_usb),
+					  info->chip, info->variant);
+	if (!rtwdev) {
+		dev_err(&intf->dev, "failed to allocate hw\n");
+		return -ENOMEM;
+	}
+
+	rtwusb = rtw89_usb_priv(rtwdev);
+	rtwusb->rtwdev = rtwdev;
+
+	rtwdev->hci.ops = &rtw89_usb_ops;
+	rtwdev->hci.type = RTW89_HCI_TYPE_USB;
+
+	ret = rtw89_usb_intf_init(rtwdev, intf);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to initialise intf: %d\n", ret);
+		goto err_free_hw;
+	}
+
+	if (rtwusb->udev->speed == USB_SPEED_SUPER)
+		rtwdev->hci.dle_type = RTW89_HCI_DLE_TYPE_USB3;
+	else
+		rtwdev->hci.dle_type = RTW89_HCI_DLE_TYPE_USB2;
+
+	ret = rtw89_usb_alloc_rx_bufs(rtwusb);
+	if (ret)
+		goto err_intf_deinit;
+
+	ret = rtw89_usb_init_rx(rtwdev);
+	if (ret)
+		goto err_free_rx_bufs;
+
+	ret = rtw89_core_init(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to initialise core: %d\n", ret);
+		goto err_deinit_rx;
+	}
+
+	ret = rtw89_chip_info_setup(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to setup chip information\n");
+		goto err_core_deinit;
+	}
+
+	ret = rtw89_core_register(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to register core\n");
+		goto err_core_deinit;
+	}
+
+	rtw89_usb_start_rx(rtwdev);
+
+	set_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags);
+
+	return 0;
+
+err_core_deinit:
+	rtw89_core_deinit(rtwdev);
+err_deinit_rx:
+	rtw89_usb_deinit_rx(rtwdev);
+err_free_rx_bufs:
+	rtw89_usb_free_rx_bufs(rtwusb);
+err_intf_deinit:
+	rtw89_usb_intf_deinit(rtwdev, intf);
+err_free_hw:
+	rtw89_free_ieee80211_hw(rtwdev);
+
+	return ret;
+}
+EXPORT_SYMBOL(rtw89_usb_probe);
+
+void rtw89_usb_disconnect(struct usb_interface *intf)
+{
+	struct ieee80211_hw *hw = usb_get_intfdata(intf);
+	struct rtw89_dev *rtwdev;
+	struct rtw89_usb *rtwusb;
+
+	if (!hw)
+		return;
+
+	rtwdev = hw->priv;
+	rtwusb = rtw89_usb_priv(rtwdev);
+
+	rtw89_usb_cancel_rx_bufs(rtwusb);
+
+	rtw89_core_unregister(rtwdev);
+	rtw89_core_deinit(rtwdev);
+	rtw89_usb_deinit_rx(rtwdev);
+	rtw89_usb_free_rx_bufs(rtwusb);
+	rtw89_usb_intf_deinit(rtwdev, intf);
+	rtw89_free_ieee80211_hw(rtwdev);
+}
+EXPORT_SYMBOL(rtw89_usb_disconnect);
+
+MODULE_AUTHOR("Bitterblue Smith <rtl8821cerfe2@gmail.com>");
+MODULE_DESCRIPTION("Realtek USB 802.11ax wireless driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
new file mode 100644
index 000000000000..a2ab4e3f2115
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2025  Realtek Corporation
+ */
+
+#ifndef __RTW89_USB_H__
+#define __RTW89_USB_H__
+
+#define RTW89_USB_VENQT			0x05
+#define RTW89_USB_VENQT_READ		0xc0
+#define RTW89_USB_VENQT_WRITE		0x40
+
+#define RTW89_USB_RECVBUF_SZ		20480
+#define RTW89_USB_RXCB_NUM		8
+#define RTW89_USB_RX_SKB_NUM		16
+#define RTW89_USB_MAX_RXQ_LEN		512
+#define RTW89_USB_MOD512_PADDING	4
+
+#define RTW89_MAX_ENDPOINT_NUM		9
+#define RTW89_MAX_BULKOUT_NUM		7
+
+struct rtw89_usb_rx_ctrl_block {
+	struct rtw89_dev *rtwdev;
+	struct urb *rx_urb;
+	struct sk_buff *rx_skb;
+};
+
+struct rtw89_usb_tx_ctrl_block {
+	struct rtw89_dev *rtwdev;
+	struct sk_buff_head tx_ack_queue;
+};
+
+struct rtw89_usb {
+	struct rtw89_dev *rtwdev;
+	struct usb_device *udev;
+
+	__le32 *vendor_req_buf;
+
+	atomic_t continual_io_error;
+
+	u8 in_pipe;
+	u8 out_pipe[RTW89_MAX_BULKOUT_NUM];
+
+	struct workqueue_struct *rxwq;
+	struct rtw89_usb_rx_ctrl_block rx_cb[RTW89_USB_RXCB_NUM];
+	struct sk_buff_head rx_queue;
+	struct sk_buff_head rx_free_queue;
+	struct work_struct rx_work;
+	struct work_struct rx_urb_work;
+};
+
+static inline struct rtw89_usb *rtw89_usb_priv(struct rtw89_dev *rtwdev)
+{
+	return (struct rtw89_usb *)rtwdev->priv;
+}
+
+int rtw89_usb_probe(struct usb_interface *intf,
+		    const struct usb_device_id *id);
+void rtw89_usb_disconnect(struct usb_interface *intf);
+
+#endif
-- 
2.49.0


