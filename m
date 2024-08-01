Return-Path: <linux-wireless+bounces-10780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F4C943CCA
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735181C2100E
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D069520010A;
	Thu,  1 Aug 2024 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOvNHEvj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EA1200106;
	Thu,  1 Aug 2024 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471497; cv=none; b=SKJnXxJfBAhqpDG8b7dAH+F949O1qYwEC6QTuj6O1XmF4q6ECxvQC6k75IH156tsZ9LLGg6t0iZNAnsawYcNeQHxMSYRDpxw3TR4GzJbIkEkfz+KXikWHEsf4BcAz1MXrMws6fzCxAAhuOgOClZCfvZJlkwRfYy6AHeIjU1CM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471497; c=relaxed/simple;
	bh=2dbAlhQnnC06QCvYigvkWNjnDcUUWgPVvAw8cLKNxrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5RppSjrsKm6MQ2W0Bgtruj4k97CCqSCz6q5Tfvf6+dDz8OO5PliZhA1OlHBUe7xFD2/csBemdPUKeVWHzsaELgyeRFP96QFBgaDubTqOePJLchQkDF3jbbVihaThF0s5wczIf3436pBczI2G69yhpv47UGfS7BC7R3uXNOZnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOvNHEvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6370FC116B1;
	Thu,  1 Aug 2024 00:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471497;
	bh=2dbAlhQnnC06QCvYigvkWNjnDcUUWgPVvAw8cLKNxrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOvNHEvjNRX+3WP0WMHYEaUXUPGSVrTm0Bn5wMXKLAKLEx2xmrqZdlhVhz+Lely5r
	 ++QvvBbiFDgO5mHqczSLAg5+nSraGEkuj7iipWrSHonGOfqJzJszChHpCHEJmM40JI
	 1bzqCT8Nl+LV+lEGnGZ7w6bfLETrDqT35DjXONDd9dmHuCVCGePJ7SRvzIkSguP/G/
	 ASmHwpYAwBeR8ZwRDARp0LhrJf8NTQQiaRL5vEbIoDUTjaXVc0niZUQAIGoR0wW8lq
	 JlU8qSwBieC5eXcRiQKupMzMxpjNm93PSuaAOgclGlMWFHAm3ZEf+fsiICFSg0VZwz
	 utTzzx8ztSXhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>,
	Tim K <tpkuester@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.10 112/121] wifi: rtw88: usb: schedule rx work after everything is set up
Date: Wed, 31 Jul 2024 20:00:50 -0400
Message-ID: <20240801000834.3930818-112-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

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
index a0188511099a1..98f81e3ae13e7 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -740,7 +740,6 @@ static struct rtw_hci_ops rtw_usb_ops = {
 static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
-	int i;
 
 	rtwusb->rxwq = create_singlethread_workqueue("rtw88_usb: rx wq");
 	if (!rtwusb->rxwq) {
@@ -752,13 +751,19 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 
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
@@ -895,6 +900,8 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		goto err_destroy_rxwq;
 	}
 
+	rtw_usb_setup_rx(rtwdev);
+
 	return 0;
 
 err_destroy_rxwq:
-- 
2.43.0


