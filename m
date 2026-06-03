Return-Path: <linux-wireless+bounces-37351-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ax6JEkIlIGp4xQAAu9opvQ
	(envelope-from <linux-wireless+bounces-37351-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 14:59:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 469A3637C9C
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 14:59:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MnY62cPL;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37351-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37351-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12F8E3030835
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 12:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA24B3E5A3B;
	Wed,  3 Jun 2026 12:53:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E746AEEF
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 12:53:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491221; cv=none; b=W0A/VjtBlbcQfIK0nOsivEeEf90h0cAyigxi0GSBtCZeOxZSHdwoOzPtsPGuVPYrmESumwGEmZURau7osDgIKEwq7i2YH4si/JhAglY53LmCThI2OPdPg9PNxn06CAOuLcPmhLEo0Lg1jz8qgtm4bmI7oiQImntnO3bjSuXcBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491221; c=relaxed/simple;
	bh=tw3B+H9jD5nskeOmMj1r0VbV1LssOSHmq4cYwMq7IXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mY1Ce29s9vGLdCeThyGusbdvsBDNpe3K9EogJLuBbG75tE51jcsqCEq38qcK50UkMokcnXmmrwVB/aZOG00pykr8gyRzLBiyUgEGhKuGifVPSQLrN7+ThIglk/pa1TI1VOEknWJmgT+iIuYCUvFZV8Rk2MJhgu90eT3iFLeOazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnY62cPL; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so24807105ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2026 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780491220; x=1781096020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6RUtxi7gFFBB2jFLI9gsgqqsOc9t5I3VJP9BfFAwjBc=;
        b=MnY62cPLvYhm1LdigdtW1LKvwEgS9K1nDRFy45BQqxru8GnQ6Ur8l70UoXAeqgQ1qr
         HPvEhYUjzXOMdZKkMIjYsWpNHlkv0mLv5Xuth4S+fUv9adzGxcakm0qnfKoHv1K12JjN
         HBvGg8nX7XCrZrpUdZksjFKX1wyq3AFdvq/NO17A7VCwepE706J/GvtfSR7jGY+P82yc
         CusQzbwyfxtbHkQGbU1Jo/5IX7cwA49cXlMqiQijW/kVeEui2VegFMK0m5f7DjpeMQSO
         qZjgZddbVmToWkkHFePqWt4D54nPxUE5NQrz5Me/xH1pLadCNsZ4P0tJNW2QYqiqT36Y
         d/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491220; x=1781096020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RUtxi7gFFBB2jFLI9gsgqqsOc9t5I3VJP9BfFAwjBc=;
        b=Al264v2imuYWwkxuQpKWbHf4yAcA4RTFOgfk8xEROVntKBdCuqnuBPzWJL7S1yPhTq
         9596h8GBi5jdj1qcTSrkOe2yvXkLXPXS5QSqcAZ4151tAoxsRbRZ/QfXU4wOjSM+jO0h
         TG0ZBA0r7PJZFx3YU2Qk8i8Bt1NyIOww+Lh87+Zyn/IdzHp9EmUAYgojpoTkLD6HgoJk
         tJNqnNUnaAw2TR4hILdnayknS7RWcv7ySMgcIh/gZY9VDnN8RE8ni9qmqejFDzFyZQI0
         aI62aOLebr44jw2ssqjtGCy2agluooiuHVM8NZa0yMv8tNwx8mfeP3hnFgQKCD/kY2bG
         Tmmg==
X-Gm-Message-State: AOJu0YyEx/8IO0/j1JtiL8OPKgTK4LF6MWh/02UjBOb+9fuWC9Z0Ki7Q
	I4uOSGnuSzJ8ts2E1Z/3uTCuuPL+bl2NA/dRLcM56pzRC8thUD8smtLf17JCRh7Bpsg=
X-Gm-Gg: Acq92OEle69IVIG7e2IGhn2NKDau5GB1mT365WX+VrLOiLClviBuVpze3w+eTZwL1OR
	l61/bnfhb/6Kx4rLh4kBh9KkyK6ZfxNKGawfsI1IvRlwKho5kRCB1YMWUiuXZ9q18158QGzXZdt
	FpRWufPujnz9NHQnfL7mizU2+fgLoxvMZ4DKKZ0ezo7A7vFK+tsVJYoNVUYeSKlC569M70yr1xQ
	7tD2OheFGtLbyWAyIgsfKWRG3SGHpL3hY+0CH2pEMfqZrLc9OpkS+slwf6XdamzLtMgpH2Gry2C
	gmCrE4YluTMQDLYpIuHw1i9DEsrJE0nE8Wb/qYUfXlBmAIlCqIwm37ydyYlWPBxXTOQe56Ol6mO
	bjISfJ+15Vu3p6uKzeS4ODrG9c8v9Ynh07wNImwYeIlClHMLkZTeDgSe1KlpW+wnopDzqPs1YAk
	w32bMrKSVXe8aFDulcEfKOwgy8TDqJI6qmIPPDV4zeUI2mqZea+jXI
X-Received: by 2002:a17:903:2409:b0:2c0:bb11:19c8 with SMTP id d9443c01a7336-2c1641be73fmr37291035ad.36.1780491219737;
        Wed, 03 Jun 2026 05:53:39 -0700 (PDT)
Received: from jeevaanandh.. ([223.187.113.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649ab01sm24449245ad.71.2026.06.03.05.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:53:39 -0700 (PDT)
From: Jeeva Anandh <anandhjeeva215@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: b43-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeeva Anandh <anandhjeeva215@gmail.com>
Subject: [PATCH] b43legacy: remove redundant mask bit set
Date: Wed,  3 Jun 2026 12:53:31 +0000
Message-ID: <20260603125331.6310-1-anandhjeeva215@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37351-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[anandhjeeva215@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:b43-dev@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:anandhjeeva215@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anandhjeeva215@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 469A3637C9C

mask is initialized to 0x0000001F, which already contains
the 0x0010 bit. Therefore the conditional OR operation is
redundant and can be removed.

Signed-off-by: Jeeva Anandh <anandhjeeva215@gmail.com>
---
 drivers/net/wireless/broadcom/b43legacy/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index 6b3e0b2bbca7..d32bffa6f009 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -1904,8 +1904,6 @@ static int b43legacy_gpio_init(struct b43legacy_wldev *dev)
 		mask |= 0x0200;
 		set |= 0x0200;
 	}
-	if (dev->dev->id.revision >= 2)
-		mask  |= 0x0010; /* FIXME: This is redundant. */
 
 #ifdef CONFIG_SSB_DRIVER_PCICORE
 	pcidev = bus->pcicore.dev;
-- 
2.43.0


