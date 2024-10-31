Return-Path: <linux-wireless+bounces-14789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8D99B7E0F
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF4E1C219C7
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1578619D08A;
	Thu, 31 Oct 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tJ6zgXnl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKtYgqgN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00101A3BDE;
	Thu, 31 Oct 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387707; cv=none; b=I+HkFFoWJHYP6gkpnXLJoq34SMevOCY7vQu8YKUsAVECbYBEfGwbIFDl0EsT/TLAcJaFGKkDVZpuMQlGkT/Nxi+o7FIkaD7h03impskU59UX7pD8z+3d+tXrZf8U0nmRBemKYdudv+PVXTldUAZxzQsJj5s68hpgNuZ8DTgBkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387707; c=relaxed/simple;
	bh=v22nMp0NCgMKpKQ34cvZP1/P6cf3rMn2mJFAvL3jUoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7AuLZYDxz/MVBkL65D9YHPhwriE4fRllfjSmHB00pjbZtvnsNH7XccNE8K+49Rj+K4Hc5qo83M7qKbzyhPjKdKCGdzByNUrWRKvdIv8MbCTLcc7X9N11gGaphNKgtsVcMj4rx1ktGisgW69IdXTjvyIc4JeKWU23mZUCu+OpPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tJ6zgXnl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NKtYgqgN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyuxFuHZyEAgLrnvafIRcWRKTeRTsVTMh2Dczz2F9rU=;
	b=tJ6zgXnltAPSCcx7THHEtdYpBg/DS8NrFZ02jd33CGDpy49sS9dp6ids4gtlsFpOONmg4I
	zn7HjwH+7fNNKyZ9cagv6Kt1OFfBeDlDOrmth8blvN+yVy+xht6MIY+Q/B1/+zT2jzy/a9
	YiMkkc2DZDsPJeuzo11TgZnctzGNyzlWwW58J/Lv6kGpv+PnU60BxSfsmV20IplsyYIg5b
	U6K/kLmz85Fp0mG2HKnsxIY7EwC0Qbhlo+TLxalXoz7+bRdS6BZvRqIknOLX3T5V8rYstH
	Nmf4KZmFGIZ3PRMD5OfEO6YII8zq0XXbIsT3x8DeaCR6Sbgaf86NjNOSd0y+lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyuxFuHZyEAgLrnvafIRcWRKTeRTsVTMh2Dczz2F9rU=;
	b=NKtYgqgNGk4bIoUpaptCn6O7NlJj+lp7jKGQCDEoVRKabClUHDqq3vxb7ws7xpabxmSEfj
	Vs0PJ7aVdW/esRDA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Nam Cao <namcao@linutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-wireless@vger.kernel.org
Subject: [RESEND PATCH v2 04/19] wifi: rt2x00: Remove redundant hrtimer_init()
Date: Thu, 31 Oct 2024 16:14:18 +0100
Message-Id: <66116057f788e18a6603d50a554417eee459e02c.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rt2x00usb_probe() executes a hrtimer_init() for txstatus_timer. Afterwards,
rt2x00lib_probe_dev() is called which also initializes this txstatus_timer
with the same settings.

Remove the redundant hrtimer_init() call in rt2x00usb_probe().

Signed-off-by: Nam Cao <namcao@linutronix.de>
Acked-by: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/w=
ireless/ralink/rt2x00/rt2x00usb.c
index 8fd22c69855f..a6d50149e0c3 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
@@ -823,8 +823,6 @@ int rt2x00usb_probe(struct usb_interface *usb_intf,
=20
 	INIT_WORK(&rt2x00dev->rxdone_work, rt2x00usb_work_rxdone);
 	INIT_WORK(&rt2x00dev->txdone_work, rt2x00usb_work_txdone);
-	hrtimer_init(&rt2x00dev->txstatus_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
=20
 	retval =3D rt2x00usb_alloc_reg(rt2x00dev);
 	if (retval)
--=20
2.39.5


