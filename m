Return-Path: <linux-wireless+bounces-34798-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJI8GY6T32kiWQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34798-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:33:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD409404D3F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B657D308381C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F943AF66C;
	Wed, 15 Apr 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neGjvQtV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E023B3BF7
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259957; cv=none; b=UzQNDneGJIh0cTzZFOHpw6YopQw6yzdQzy5OzdWjg5ZR2md348vpvzwcLpr5vyR4pjg4oY5HGPU9LWyDZaS1ddJsWcUwAYoZ5NRgl87/fcj7TijBzy+Ws7C0Z1VrAXdvmnxCHUFX0noTWXJdvbCgFmPZh08yTIXvswTKxT9dBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259957; c=relaxed/simple;
	bh=xrCNSwVjVDKXltckPzvEePqEXPwg9HbwfWSN/2JSW5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udJgsCR4XyaoyZm1PfDcwRmQAJthk/Egf9OxBgHMnyF1HIfxEeW1CbF7izNWFKaR7nH0XWTNqHjNHXf/DW07S0g/fqWfOnxwBEpUf1NNiqjwqProVdp1Z1VfXgJD5n7TaOdnQvEIQCAWpJh+/Rd2CJIzISMWX4vudZlAxP7SqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neGjvQtV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483487335c2so75109895e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259954; x=1776864754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NmEA2H9yT1v8ldkiYgSp6xfvZWcRV5dr3KBw163IUM=;
        b=neGjvQtVtz/Y71A37YW0mObltfYioU9buiruoeaqosnEA40fwoy9nNOFKcYzJPlRW6
         OLNzoxAwK9qliBEhZ/pDjiOQG4S7UQFSAqxz6GdI4PzKdhdYTWYXX9ZNsYHNjZerdnRN
         T7+oEDqx6y8RJUKto/LkqR8TLYEz3OWpJe+v4kYfneKMw21yYr2qtattLfH0o2YbbSU3
         tRyVP6j7XaeSaK6TF87ufnilueQmFEASOtXB/jqb4yYWpcdpHu2SiMA2zL+MSflLFztm
         JIIjG7cHhjdxNIEbxsf0BzxhMaO+cSkPAzQhcD7OKf9MZK8UcWG1OO1hLMdDTEEi7ZX4
         lyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259954; x=1776864754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NmEA2H9yT1v8ldkiYgSp6xfvZWcRV5dr3KBw163IUM=;
        b=L35MQjTr+CVyNpWjTHE/g0LzVlgsxCZn5PSF0KTEK3CTuYx136AU6fWSvV5YWsjD0A
         fHeJ831uuGpAMERTahhrkVyyPWk9cZ5IfbEZV6elJo88GFBb4VMgjxGs/iCj4997OkdD
         gGJhTxj4/JSN/mOHSD8KEMeJsmQRDtcA7N2H/7sznvt22m/zK/2rfzJ9ZEsXOnIbRorU
         D35oiiHIgeTBhag/3OunHmBmPHKr1BFu52xxYQCimTpo4FsbnkVdOz3+WsXzeJ3y9As3
         Ud6sjy4cZZ4y58k8g56++s+ZXTAzpOYwoKmIV6jklqPqmgLfz36yk71emSEOx+XPqeoc
         FFFg==
X-Forwarded-Encrypted: i=1; AFNElJ+fBPtpxJa9V0XaSBFjRU10eT6ANdqzMTYgjTRj0B5ITQtkgPJxq0g4wtZp26a9dGl6iSkrXlJ1fT2BrpNIwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6yK/Ydtuz7jkqHs6DvM30/mmy6KejHVgJ4/Zv84tbc+yDumhM
	VkwN77032f7PW5HusSJlyxZYBLU/EHLbOz/RLR5JiugB1PnNxjXrrt2IkSUWICw=
X-Gm-Gg: AeBDiesNNZ5fHV+AAr2xawdg0c5zesXDcDDPHKITgkfUYZfdytfz0BLkD0ivf4Ogvgr
	eXCGIOdaShIc961069YAlyFccwCwfBDQS1LyGVsTUVo4KbkC3BoWo9EjmShSCPFK6M3FMEfQd4r
	dlFokP4/yMvuYhMtbCnSiYSQD/YliNdKlfGI3sdZ/XM3/kP9IjOtIWFOxD9Hj7laQuDc7w/r9hG
	YuDkg1OKdQ+PGXVrfBMHIYgCq6WIOPREbTfDFFnHYaIifRz5QZXZ9dxv04UTe1CZIcA3H/e37jO
	KiR+J7y5T5QQTnNrujXehDm8ATmaalOhlriu61aJovUhvXVQCu7/n4/t45h29jfYENwBYhf0SfI
	dLCKe2pWNDWrr+lMQDcEweugWQAWIdogOS0KqM2n4kZRs7Menr4MZcDKEZMw9O8G9ZUqtGe+avV
	tDkbt+H3rnqLfuLNV/4auf6zWUUjpIyPRTRnl7xjOS71v1XHWNe9vdX+YL6KQ0iy2z76OD/B4zz
	Zb/Hr9kSZ63Z6cDLoC+F8aH+3bhBhyryAXYA+4PHYKQ0giyCuw8PQ==
X-Received: by 2002:a05:600c:45cf:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-488d67b8dddmr283813955e9.6.1776259954109;
        Wed, 15 Apr 2026 06:32:34 -0700 (PDT)
Received: from archtop.localdomain (92-242-248-33.broadband.mtnet.hr. [92.242.248.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0eb43f6sm20604755e9.25.2026.04.15.06.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:32:33 -0700 (PDT)
From: Jakov Novak <jakovnovak30@gmail.com>
To: johannes@sipsolutions.net
Cc: dcbw@redhat.com,
	jakovnovak30@gmail.com,
	kees@kernel.org,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linville@tuxdriver.com,
	mingo@kernel.org,
	skhan@linuxfoundation.org,
	swilczek.lx@gmail.com,
	syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com,
	tglx@kernel.org
Subject: [PATCH v2 1/1] wifi: libertas: add wake_up() call to properly notify fw_wq during disconnect
Date: Wed, 15 Apr 2026 15:31:35 +0200
Message-ID: <20260415133134.167783-3-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415133134.167783-2-jakovnovak30@gmail.com>
References: <57275e905a67e789ea438bf637be0aeb442fc880.camel@sipsolutions.net>
 <20260415133134.167783-2-jakovnovak30@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,kernel.org,lists.infradead.org,vger.kernel.org,tuxdriver.com,linuxfoundation.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34798-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakovnovak30@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,c99d17aa44dbdba16ad2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD409404D3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is necessary because the thread would be stuck if the
firmware is not fully loaded before the if_usb_disconnect function is
called. In that case if_usb_prog_firmware would be stuck in
wait_event_interruptible and lbs_remove_card would also be stuck waiting
for firmware loading to be done which was the original bug reported.

Fixes: 954ee164f4f4 ("[PATCH] libertas: reorganize and simplify init sequence")
Reported-and-tested-by: syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c99d17aa44dbdba16ad2
Signed-off-by: Jakov Novak <jakovnovak30@gmail.com>
---
 drivers/net/wireless/marvell/libertas/if_usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 245c902a7e42..8a6bf1365cfa 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -310,7 +310,6 @@ static void if_usb_disconnect(struct usb_interface *intf)
 	struct lbs_private *priv = cardp->priv;
 
 	cardp->surprise_removed = 1;
-	wake_up(&cardp->fw_wq);
 
 	if (priv) {
 		lbs_stop_card(priv);
-- 
2.53.0


