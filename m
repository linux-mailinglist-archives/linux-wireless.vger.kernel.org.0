Return-Path: <linux-wireless+bounces-8191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0218D1917
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 13:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CF22888D7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF73E4E1B3;
	Tue, 28 May 2024 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJy9AHS2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B981D53C;
	Tue, 28 May 2024 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894186; cv=none; b=c4w2+pn/W8FSjpDkRy2BOb49O0uXYn/78aBv8rF9EdTaEqQ2bhakOyUY+tlMqgM7w4KLSchMEBD77nsxLaZa+318x41Z3WY1IHEtOBnXv6Hq3DzlSOkFPLEU8cMF+hAu+eSrIKFHk/xorLCYbE21ZgNDDmOlQWKyx0J2NgA8GMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894186; c=relaxed/simple;
	bh=Jz9DQ0A0ysEyx5ZFSqtxWV1Sz5lFahtNRCaIsOIGEQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJVo0Bw8gp3vhpUH8yy4CGkPsese/0aRM4L6d8dDER7N7NflyXUOifUPmZYK0OFOEfcxHUqmdyuVJY6akwVcEx9n5AHAV3WLRn6XjLHnmscZVU+2dRmoZpFs/0Ip8jb6/q5WZWvBFiWvsrcWevR4mVprIl+4RAU5m/5QtNoRmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJy9AHS2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5755fafa5a7so874780a12.1;
        Tue, 28 May 2024 04:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716894183; x=1717498983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDHBV4PBNxCVOs2tfUKZlVoZ23JQ58NVsz0DV0+bTVw=;
        b=HJy9AHS2CM5h59lTp+oFR8pfOeFNT93JLuYNu4+Q2495RcSoFgt47l/U+NpJzCKSxm
         I2cha9KMI4Zq4G5uHuMrENHB3ISvANhmzbJi1ql2mbdvF8iYowsY3v9MrSSZb/fqWCwP
         y6VJcdKCQY4eqvxFyD1OEdpA5kQf79wMlGBRXhJ3doJJe832yZiiZLUZzv5e/cJRtmFY
         ho7gl78cwtOeHNyAwwr0oApnh9UQT46EN95DIiJpr8BbBXoyXFKOYBqGnsZZtXIdMns+
         V08n8bDcdpj/a6Ylgrbg92gTv8CcAdDiXGpo4zSbP4P5r1IgEarPf6gAIDYERCY4cwr5
         g8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716894183; x=1717498983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDHBV4PBNxCVOs2tfUKZlVoZ23JQ58NVsz0DV0+bTVw=;
        b=eC5hEMrgksfnzxxkQO8RGfL7rfX/4yozFnjfJROTds1LQ7nrOVDg8hhhgMOTgQxx32
         TFSrDmLaSjHheK2QSoFZni48+Xnum8KjMuXpgKEoAu5kTj3V/DDUpdvJD7CY44EctB0h
         v0bHgfxboeoPQFU4AldHhbz7iqjtO0kfrO65YqoVPyEI59TGo+bSmAugLtnR0ZeIh8dr
         FxbRLlF0Ti3meVUV2OLQCJFTsh+bufjbANXcrXV1BAcOuWow52aEshoGARiO/nYA3lXA
         AVJf1j2yIokzdFLoEM2fa6qd8Dt9jwlEIpmTb0IbPZg1p1SKyzBwDjBxhV+sto4uDz/J
         rU3w==
X-Forwarded-Encrypted: i=1; AJvYcCXBDrsO88Pr5XaOgpSXHDkIx20kPh9sRXo+uXgWQZpl9CzSONMym3CE2tzonN1lxpWfn+0pIE9ODIlm/9LdODnjOJPvmVgwOp5RX/oy
X-Gm-Message-State: AOJu0YxVn9SLtQ+UiVaz1boP4FH0+HsRQ8K8Di44ZPAEA8/WAb48pH4n
	BFHMpzw00l5ns6/IXoR/Q25yvc+kSPX1C68C4CujwJwjPjU1SskhtNj2HJhO
X-Google-Smtp-Source: AGHT+IEs8A4GNA8a+Krzg1KRMCiQXCwDo/GSKeTC215xCUOuOLuMPnINMonu6zDEa3YxJIDbASNd9Q==
X-Received: by 2002:a50:955e:0:b0:579:bf5d:ac01 with SMTP id 4fb4d7f45d1cf-579bf5daca3mr5720838a12.15.1716894182709;
        Tue, 28 May 2024 04:03:02 -0700 (PDT)
Received: from mslusarz-hyperv.mshome.net (078088142095.jeleniagora.vectranet.pl. [78.88.142.95])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d5e3f995sm2515081a12.64.2024.05.28.04.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 04:03:02 -0700 (PDT)
From: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <marcin.slusarz@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>,
	Tim K <tpkuester@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kalle Valo <kvalo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Date: Tue, 28 May 2024 13:02:46 +0200
Message-Id: <20240528110246.477321-1-marcin.slusarz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <13e848c1544245e6aef4b89c3f38daf0@realtek.com>
References: <13e848c1544245e6aef4b89c3f38daf0@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marcin Ślusarz <mslusarz@renau.com>

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

Reported-by: Tim K <tpkuester@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CA+shoWQ7P49jhQasofDcTdQhiuarPTjYEDa--NiVVx494WcuQw@mail.gmail.com/
Signed-off-by: Marcin Ślusarz <mslusarz@renau.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/wireless/realtek/rtw88/usb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index a0188511099a..98f81e3ae13e 100644
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
2.25.1


