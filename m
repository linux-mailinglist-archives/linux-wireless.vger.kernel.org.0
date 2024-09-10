Return-Path: <linux-wireless+bounces-12746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA8972F65
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144B81C24AD1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74418C039;
	Tue, 10 Sep 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QpLghcPa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB283184101;
	Tue, 10 Sep 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961861; cv=none; b=LKXD5uY7XMI3vUeums2bG6+uQvWkpdfCCVBQcDGR8VDii7wWgVFSZT28HORkb4mppA4a/HCNbTt3cTrn8AiV/aol7wc6RiuCgj52eyqXfR6sTbMoyRm6+/B583tdWp347SQYFdJH0Uew8vIITJ8/omd8k+4UZvilycLSXgVwlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961861; c=relaxed/simple;
	bh=3Pj8QcmA0Z7A7wynd6iaoEDBiyrJZyhqJlkcETNNd40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJarnVaKC5dyyCeikJurmVXLMr+5ukPJMGM3+3rHXgxK3bIzxKvFAgY0ecDVElE4OO0fNty8IwWJTGdqK/Xn1LNZfAYCy6v3XliL457LVpSfHEoos8Qzyh3xGhXnbUd3tKFzP5xg0mnCrSwYqgy+LyN6HluQV0QeZchpMxS4oV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QpLghcPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6067C4CEC3;
	Tue, 10 Sep 2024 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961861;
	bh=3Pj8QcmA0Z7A7wynd6iaoEDBiyrJZyhqJlkcETNNd40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpLghcPayv8PaQIM1ZPqEfO1n7b9Rnjjmn90t+JEW9YtEMIp9hkaNjX1M6HiWlXvk
	 RcHgcwRUfn8ZCQfdw5ehTrkU1j7XvAocbjZnygioerVw/Ni90ksb5ykUwB09IwbrxT
	 PC5pvTDhpgZooHzC/7YGjg3LP1AYNQn1LoWw7+3I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>,
	Tim K <tpkuester@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 213/375] wifi: rtw88: usb: schedule rx work after everything is set up
Date: Tue, 10 Sep 2024 11:30:10 +0200
Message-ID: <20240910092629.679284973@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Ślusarz <mslusarz@renau.com>

[ Upstream commit adc539784c98a7cc602cbf557debfc2e7b9be8b3 ]

Right now it's possible to hit NULL pointer dereference in
rtw_rx_fill_rx_status on hw object and/or its fields because
initialization routine can start getting USB replies before
rtw_dev is fully setup.

The stack trace looks like this:

rtw_rx_fill_rx_status
rtw8821c_query_rx_desc
rtw_usb_rx_handler
...
queue_work
rtw_usb_read_port_complete
...
usb_submit_urb
rtw_usb_rx_resubmit
rtw_usb_init_rx
rtw_usb_probe

So while we do the async stuff rtw_usb_probe continues and calls
rtw_register_hw, which does all kinds of initialization (e.g.
via ieee80211_register_hw) that rtw_rx_fill_rx_status relies on.

Fix this by moving the first usb_submit_urb after everything
is set up.

For me, this bug manifested as:
[    8.893177] rtw_8821cu 1-1:1.2: band wrong, packet dropped
[    8.910904] rtw_8821cu 1-1:1.2: hw->conf.chandef.chan NULL in rtw_rx_fill_rx_status
because I'm using Larry's backport of rtw88 driver with the NULL
checks in rtw_rx_fill_rx_status.

Link: https://lore.kernel.org/linux-wireless/CA+shoWQ7P49jhQasofDcTdQhiuarPTjYEDa--NiVVx494WcuQw@mail.gmail.com/
Signed-off-by: Marcin Ślusarz <mslusarz@renau.com>
Cc: Tim K <tpkuester@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240528110246.477321-1-marcin.slusarz@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 0001a1ab6f38..edc1507514f6 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -744,7 +744,6 @@ static struct rtw_hci_ops rtw_usb_ops = {
 static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
-	int i;
 
 	rtwusb->rxwq = create_singlethread_workqueue("rtw88_usb: rx wq");
 	if (!rtwusb->rxwq) {
@@ -756,13 +755,19 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 
 	INIT_WORK(&rtwusb->rx_work, rtw_usb_rx_handler);
 
+	return 0;
+}
+
+static void rtw_usb_setup_rx(struct rtw_dev *rtwdev)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	int i;
+
 	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
 		struct rx_usb_ctrl_block *rxcb = &rtwusb->rx_cb[i];
 
 		rtw_usb_rx_resubmit(rtwusb, rxcb);
 	}
-
-	return 0;
 }
 
 static void rtw_usb_deinit_rx(struct rtw_dev *rtwdev)
@@ -899,6 +904,8 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		goto err_destroy_rxwq;
 	}
 
+	rtw_usb_setup_rx(rtwdev);
+
 	return 0;
 
 err_destroy_rxwq:
-- 
2.43.0




