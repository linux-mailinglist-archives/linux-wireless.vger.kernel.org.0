Return-Path: <linux-wireless+bounces-12752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E909734A8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7DE9B272BC
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C51819005B;
	Tue, 10 Sep 2024 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qNar1SuX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB6188CDC;
	Tue, 10 Sep 2024 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964388; cv=none; b=POfGplrM2c5QZDW6oBVz2Hjn7+tzI9iZF0TeO75uEGdXGzcxPZ/1C6SSH5thKAuSYX2DbXrUZRscMZqePgxyCv6FJJOlJs6E71Puu6CxIikdJh7mE2P0IhULoHjav7YHacZApAMKLCpctpcOZhoYp1/rKEZa+glbYeABIcWiy9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964388; c=relaxed/simple;
	bh=7D3jwrpP96Q5K7nglHD06YqlF5QzetIjOyhn7/Q2ols=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3nU2MO24EEndneQnMXfvUc2Fzaf/kz791WNrw/zDbAoVP6/Ro+x9kfPynAEKIU+bvQughkn3C+RGvc8pDmJeDwZFpR9gOGtaJ0woLcHp5hyAcPz2DnFvZ5+TklcpUegtLYEt1dW4b2citpwDs34pwcBb2PWvKxZYlESigpflRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qNar1SuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B74C4CEC6;
	Tue, 10 Sep 2024 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964387;
	bh=7D3jwrpP96Q5K7nglHD06YqlF5QzetIjOyhn7/Q2ols=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNar1SuX/8qC21E1JTJpp48JmTSlq7M4pWAhvuJeB0ufVDS+y7YNufqbxG3YcgYK5
	 ueCjwxAw7ZujIOyJMGdk2Qb/4xQN2+Tt7hV2T/TrzpTR0iabFYxp3JRAtaCuXPbT1n
	 HNFFgUPOaSxPstIx2fjtjTUD/3AQ+kkF0EKyPiRY=
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
Subject: [PATCH 6.6 148/269] wifi: rtw88: usb: schedule rx work after everything is set up
Date: Tue, 10 Sep 2024 11:32:15 +0200
Message-ID: <20240910092613.493714797@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index efd0c2915a05..04a64afcbf8a 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -742,7 +742,6 @@ static struct rtw_hci_ops rtw_usb_ops = {
 static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
-	int i;
 
 	rtwusb->rxwq = create_singlethread_workqueue("rtw88_usb: rx wq");
 	if (!rtwusb->rxwq) {
@@ -754,13 +753,19 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 
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
@@ -897,6 +902,8 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		goto err_destroy_rxwq;
 	}
 
+	rtw_usb_setup_rx(rtwdev);
+
 	return 0;
 
 err_destroy_rxwq:
-- 
2.43.0




