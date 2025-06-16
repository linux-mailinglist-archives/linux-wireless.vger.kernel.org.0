Return-Path: <linux-wireless+bounces-24162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A94ADB895
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 20:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B9C171A40
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC4928934C;
	Mon, 16 Jun 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="aTg3cHZd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E7C28934B;
	Mon, 16 Jun 2025 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097626; cv=none; b=U9ao8ilU6pTsS/7XY42itt2yrMJ0Xa5s8FlmwHGxv7jpwsbY4qkKXYTHmYQtXbjinZJKltfESUU3K0o/Dha06wwjF7R+OKmd+MOSgYvL3MI5/dmfWzFw5zeMssOAgFPFDkQ2O7ly8ebBqmdAKwdC5zZ8Yd3A+uqdIMLMchiMoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097626; c=relaxed/simple;
	bh=tymtLNElu5H6BUGwL637Z+g9kriXkcN+o8fviwwUcqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IG+Q7LbU0dEm9YDphyouN4Iq88v6X4XWacQ5f52L6qDhw6vgHsf78ba0u8SW1YF3g2KKTScsDgHQaoGTNC+EPp6XJPRD2QSqGdOdbViYsVldSBxElP3RceY4Z6PKR9Mtc95M5F/0GbVGoPRH+9PDwJvogoCGuJ/Un/u+TAY8XVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=aTg3cHZd; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward205d.mail.yandex.net (Yandex) with ESMTPS id 043FA63E59;
	Mon, 16 Jun 2025 21:13:35 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:c90:0:640:54cb:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id B7B7960945;
	Mon, 16 Jun 2025 21:13:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QDQ0912LjCg0-HopOBlfi;
	Mon, 16 Jun 2025 21:13:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1750097606; bh=tXBDIyMNm1xKLt6KlE7DhyRzOIm2rOgvadV+TaA+Y8Q=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=aTg3cHZdyz1wZR1xN4uJ7JPDp+y+g4ZZOEyO+vBId665QPfPIYOkMT71GvksRB0pz
	 Ov9jDl2g2Jv3c0+GkOVPjTpbYT3Healu/UNvsWPpPcetQWpg9WGmD8+rVnKW8PFl23
	 xM6dQXZf0hnzbEDwuApIUyyHUOMtW+P3vFqKM+Og=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2] wifi: carl9170: do not ping device which has failed to load firmware
Date: Mon, 16 Jun 2025 21:12:05 +0300
Message-ID: <20250616181205.38883-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6bacdb9c-6064-43ea-9dfe-0eca496d1c9b@gmail.com>
References: <6bacdb9c-6064-43ea-9dfe-0eca496d1c9b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reports [1, 2] crashes caused by an attempts to ping
the device which has failed to load firmware. Since such a device
doesn't pass 'ieee80211_register_hw()', an internal workqueue
managed by 'ieee80211_queue_work()' is not yet created and an
attempt to queue work on it causes null-ptr-deref.

[1] https://syzkaller.appspot.com/bug?extid=9a4aec827829942045ff
[2] https://syzkaller.appspot.com/bug?extid=0d8afba53e8fb2633217
Fixes: e4a668c59080 ("carl9170: fix spurious restart due to high latency")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: prefer pr_warn_once() over WARN_ON_ONCE()
---
 drivers/net/wireless/ath/carl9170/usb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index a3e03580cd9f..564ca6a61985 100644
--- a/drivers/net/wireless/ath/carl9170/usb.c
+++ b/drivers/net/wireless/ath/carl9170/usb.c
@@ -438,14 +438,21 @@ static void carl9170_usb_rx_complete(struct urb *urb)
 
 		if (atomic_read(&ar->rx_anch_urbs) == 0) {
 			/*
-			 * The system is too slow to cope with
-			 * the enormous workload. We have simply
-			 * run out of active rx urbs and this
-			 * unfortunately leads to an unpredictable
-			 * device.
+			 * At this point, either the system is too slow to
+			 * cope with the enormous workload (so we have simply
+			 * run out of active rx urbs and this unfortunately
+			 * leads to an unpredictable device), or the device
+			 * is not fully functional after an unsuccessful
+			 * firmware loading attempts (so it doesn't pass
+			 * ieee80211_register_hw() and there is no internal
+			 * workqueue at all).
 			 */
 
-			ieee80211_queue_work(ar->hw, &ar->ping_work);
+			if (ar->registered)
+				ieee80211_queue_work(ar->hw, &ar->ping_work);
+			else
+				pr_warn_once("device %s is not registered\n",
+					     dev_name(&ar->udev->dev));
 		}
 	} else {
 		/*
-- 
2.49.0


