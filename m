Return-Path: <linux-wireless+bounces-35872-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NpiEPe5+Gnh0AIAu9opvQ
	(envelope-from <linux-wireless+bounces-35872-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 17:23:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2580A4C09F8
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 17:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32FD8302D0CC
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 15:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52723D7D72;
	Mon,  4 May 2026 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMqI/RQM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA53E0220
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907075; cv=none; b=jJj3Mr5JRqZct57tQHOKbRSx/RWAHjta/KIhoZUSMOwTv1vjs9ec6TlY61CqtT/4m0scqbUupTgD4eATw3c4akiEt1UqR1dqjUTxBFECJLcFpnH+OwfFvW8H43hsH8m3H2d9IgZinJ/W1zo62sdHMuEuZn7jjXg2+ofG4jDwLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907075; c=relaxed/simple;
	bh=NTaHjuSfUDzXSe7mVT5Q/k8howPw9r2u0jmS+h9Imgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQuRDW82Qb+lUQ3hPjP5YcAkuCQhrckT8Ik26Sb2XuSbJ5sM63i6jYe9BV33QVQAa7zhRxNRs8ig+LB9w8QHYcpwRetvmOFmZjj0bMjUNefEOLaKbqpQMO0rcYaBnegmeeeDWaONuCxS8oELO/yuL3WCYlgHtHxll01gnLWvpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMqI/RQM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891b0786beso28773955e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777907073; x=1778511873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8lIbEov1W+WHekVnMeduQg/7VPH9cDJZStuG1ftJ5w=;
        b=PMqI/RQMHtH0bZZs6BD9TUXutWcDyircWneEBXTg5sBIDfZ+QGjusZcFq83g8oN7yl
         dWc8XvXhy5l+bUlGDTqop0yw4QYHFHRYUuKOVWZgDmMQSq8HjE7oLbd8EEoxxWQbtrNG
         gWEarD5QFY/B+12CuJn5gKRsmOVkDt+nm6NayZEOQL3EkEzlqFiMgL47Vc6o8lyp829t
         09JKuMz728OXP4ofvy0rIhw8OLgXfQfWCLihoH0qt1z/zk1gJSpTF6zwMU8ysi1aki63
         wCUBfK2rgnqPMz8W34SNCkzuviLdtZRkn+rx6VBHVHGBFXAKxG1BFw4uZvnPK40RV0zP
         bMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777907073; x=1778511873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L8lIbEov1W+WHekVnMeduQg/7VPH9cDJZStuG1ftJ5w=;
        b=OAJriBDPUeLx8Dv9oEL3n2c+efc+tEcjzfkxED7/wup95Rv2lq97TotqhjSxxgRIgV
         cwcOQqVFaj3R6vwpOefZRSKqK3sciqji/MsdBwsma6ywy9OKPUZSNGAF/XPagxL3BTtQ
         ldBhDMS5gy2PsMRYVUaFOOt31BTtckQ90CJ7v2mJIhLoAIJEyjT9pv6K+aL3dhpCQdwX
         j/4fPovUOBd9eJxO3lifyt5P8ScZ7YUraBPaeuwNBCpmqSK1S0JURnCwx930nxkKFipR
         zlvycwqjM5Cm0BiPceaYVNZb+P8ZJazseBp/Tz5WLXneLAPag10e7+6OCkFuejnUPxrf
         2lXg==
X-Forwarded-Encrypted: i=1; AFNElJ/1KxdyviMkmRIzZUmT/FvzPcUP1TEmcd76jHoN+zLnjWtidGQF1Z+5L5d5cNXtiP6XfxCI68/KtYBIGFapmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZAExNKnDwC3aUlp8PImnznKR2X2oh0A7LVpJ3HxEl4S0Ba9d
	ipYlbk8pubvVTERRKyM0ceKV9+iVRlb90u23riBz7cAA1vqd3Xi32Zc=
X-Gm-Gg: AeBDieu1JgEGHGxP9vZvzUFv/nTadJORfirTSeIDtTucVzx2dQXfO8oUYFz/M2T/yfY
	ArasNzJ5aN4FR1KetQgWS0XFneEa3e5MuEIXAIDELDJU++rfX89wQDIsSobS/CNA+LOS2aUJdqz
	xajxDv7neD/1mG0Ya8WVWMIixmDw7qdfCtRUMwMe1MZYLA7JVSjHfjAdI63VdkBFd+d/QSHyy/b
	+b0IpEUFWhkC/Wu60R1p6mszkXjA1jRTC+gAYQes0QfKmOiBhxWacilO3Bx5dUMY10uqFi9JfmA
	98TuFEnPrhldqjdkuqMKT6Rp6z1PFj0KKxImJEo6wyVD10Y+d2Tnrb/WMLfJmXB+VPZy9AN69RO
	toBwpwwN6qiW8tCIdXX7kBtD0kC3yK7BhP3cz24wTbVjVxM+RsThUJ9xmVyeBQD8rDp6D7V9Ntu
	XOf4h0qjILuOKMpTCVpr3dzFICdVCODsZSldKb+LGlITQmP+JMhXzA29jNEEZ/HrFHv6FlW68eP
	EDyD9rJqN7z3zcF/mu+8q6IblPP41EH7WCoXWkyD54=
X-Received: by 2002:a05:600c:608a:b0:488:acbc:b2e with SMTP id 5b1f17b1804b1-48a9865d2ddmr164473065e9.17.1777907072508;
        Mon, 04 May 2026 08:04:32 -0700 (PDT)
Received: from archtop.localdomain ([2a01:599:912:6541:1453:2633:891c:c05f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm462089755e9.0.2026.05.04.08.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:04:31 -0700 (PDT)
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
Subject: [resend PATCH v2 1/1] wifi: libertas: add wake_up() call to properly notify
Date: Mon,  4 May 2026 17:04:16 +0200
Message-ID: <20260504150416.4853-2-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504150416.4853-1-jakovnovak30@gmail.com>
References: <57275e905a67e789ea438bf637be0aeb442fc880.camel@sipsolutions.net>
 <20260504150416.4853-1-jakovnovak30@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2580A4C09F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,kernel.org,lists.infradead.org,vger.kernel.org,tuxdriver.com,linuxfoundation.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35872-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakovnovak30@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.989];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,c99d17aa44dbdba16ad2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]

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
 drivers/net/wireless/marvell/libertas/if_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 4fae0e335136..22f0bd6a141a 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -310,6 +310,7 @@ static void if_usb_disconnect(struct usb_interface *intf)
 	struct lbs_private *priv = cardp->priv;
 
 	cardp->surprise_removed = 1;
+	wake_up(&cardp->fw_wq);
 
 	if (priv) {
 		lbs_stop_card(priv);
-- 
2.54.0


