Return-Path: <linux-wireless+bounces-23923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E944AD3317
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 12:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20417A70E1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 10:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC628C2CA;
	Tue, 10 Jun 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="GSapMKcU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1328BAAC
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549776; cv=none; b=NmLtRG/cgBElOGSHrdWQIAny8PzsMRoeB+HX2FIFKvto+rtllZIv6Ax7TJ4m+BKWqNjAD6ah66OpqVviSVlLWlV3lhq6aj/pKofiQVWHiuziuzCMPsf/5gP2vJ3ooKLY7JBl4ZPJYI0pathj50lWgnxo+NS0l6JTAbkntbGDI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549776; c=relaxed/simple;
	bh=OQmyMuiucc0AMGtZztLpM62hZz43TrU+tuzULLCTAWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwanPxyvjYF/RXhTEdFOYJ2wpn9jiHXqmY6KOIWeQdl0hXoWTWs56eG5Xv5MkKp+kC93Xs8kW6QZig5V4ETQVhapC/iIFLVB0yFUGMJKy/ltshUeJ0dzdaKmM7GmeiUUps0WfQnqfC5LtpZxzOT9JWvtmGbd94P3bGuns6JlEdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=GSapMKcU; arc=none smtp.client-ip=178.154.239.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward201a.mail.yandex.net (Yandex) with ESMTPS id 951D6658E9
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:02:44 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2ea0:0:640:5268:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 6465A60EA1;
	Tue, 10 Jun 2025 13:02:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id a2frMMWLhW20-JaiXGeZO;
	Tue, 10 Jun 2025 13:02:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1749549757; bh=LriDZuouPLpxDdZaevO/9RAPSOGV6sEk2oPZ4B07ogY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=GSapMKcUkgUvko/pAAo3j3dlVFYWNaS4tGFQD7huay3LvrIUcmRvzBK0dXtLdVqBG
	 7bxr9MpYLg3KQlc8u4nMO2mSvwAKPDTsQ6Fu52L28JUBtpXq4Y5KmVInY6st5OQhPN
	 5OQLuxsHeYsvm8KUt+4StXyzK6/meTgcjw46YwhQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: carl9170: do not ping device which has failed to load firmware
Date: Tue, 10 Jun 2025 13:02:08 +0300
Message-ID: <20250610100208.2282442-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
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
 drivers/net/wireless/ath/carl9170/usb.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index a3e03580cd9f..a0bfa0c477ee 100644
--- a/drivers/net/wireless/ath/carl9170/usb.c
+++ b/drivers/net/wireless/ath/carl9170/usb.c
@@ -438,13 +438,18 @@ static void carl9170_usb_rx_complete(struct urb *urb)
 
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
 
+			if (WARN_ON_ONCE(!ar->registered))
+				return;
 			ieee80211_queue_work(ar->hw, &ar->ping_work);
 		}
 	} else {
-- 
2.49.0


