Return-Path: <linux-wireless+bounces-14586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9222D9B28BC
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 08:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493521F2144B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 07:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6C41922DF;
	Mon, 28 Oct 2024 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ER4Cq0y/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r8PIDNUt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9329191F87;
	Mon, 28 Oct 2024 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100632; cv=none; b=NtWHjZdMu9+UrVRIeViVF205RYoFCdOywOEMJOgPvj6q6xsGI1pJ9tCOJn1OAW4s3DDqunDXqFDeRNuetzHYpBz/RHBvsggO96I8yXkK9vyYz3X2C8dUwllQ0z90WMvqeNqHLET/F7Jsd37flwjomlXSaTkYQQ/PdoM0wJR9uzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100632; c=relaxed/simple;
	bh=gEj8hfRJixPu09d6XltWWSgaMWrrX/5Jug2d4qHrurE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jSnOeGo3bXilJtswZ7WnB8JPD8sZegUhhvXvSozm4uHEF9tY+aZaJl98B3DrYfiSyGpgNEHMlNftScZ0fKNtT47sbU5gAJJ/vqxdCxhT1YeEMzqAiLck5PZmXcMKlTlHl2fkSZgwTAfv6aYpTgtp0Yr0ecCIZtEup4Zl7yzAsHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ER4Cq0y/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r8PIDNUt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifpNs9cq3xZGK6onfKtgO1rlAC0KnSk/1Gk7YaYxPlc=;
	b=ER4Cq0y/of1ZLoZGKTw84WlastfotZEgHV6FOMqrgU8qNhjjcVkb9GqJBl0Cw9t1UJNTet
	1OSqD+0whpCn+OWgxShRlxDKkGCO4UUtMiYM9vEcnAHkw4D9V+TVe+tMEnEFx+33O7BdUJ
	j+D33yBQW8XaezLrrv0nhpxYU4Rqe/28SYRTb8blSrTIWew5RqhG01/c1xptTEtkReV1b0
	LAJuLubmZhWUWOm7cnLSUmT7WxM0Eg9oe07nCbh0HM+1ZzuzrQ1aHeCgKjjxyCJ2eS0fCY
	IL5u7hBl74tySDukQvucpzn9GAgxkhg4y7HCnq2+b1VFg5YXAcDaN/TkZEMaaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifpNs9cq3xZGK6onfKtgO1rlAC0KnSk/1Gk7YaYxPlc=;
	b=r8PIDNUt3md+Th6EFcTFkq2ttEqf6uJAmRYA9mg1UIXC2L2q4qrLguuBqagc61t1Viwda1
	xar03ytlja3g3cCA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 06/21] wifi: rt2x00: Remove redundant hrtimer_init()
Date: Mon, 28 Oct 2024 08:29:25 +0100
Message-Id: <b1279cd5bf0c77a9434a70a025701ec251a30f8e.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
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
---
Cc: Kalle Valo <kvalo@kernel.org>
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


