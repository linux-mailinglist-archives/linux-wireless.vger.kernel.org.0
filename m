Return-Path: <linux-wireless+bounces-38627-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5GVEJsLqSWrt8QAAu9opvQ
	(envelope-from <linux-wireless+bounces-38627-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 07:25:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E923E709016
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 07:25:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JGmJj32G;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38627-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38627-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B6973010511
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jul 2026 05:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5343526738C;
	Sun,  5 Jul 2026 05:25:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE0B2EBBB9
	for <linux-wireless@vger.kernel.org>; Sun,  5 Jul 2026 05:25:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783229118; cv=none; b=II2pslpbMaWwqBqA4qsl2BARl51zt+ksc0GB+3slvUO3JCxbbAiHhuuyMHMF66WZeB1KugbmUlYsP+AJ5Y5ayZQ9MHazyoZW0iF8dc+qUzOHPNLY7gMxT4/0k2nWOls9Bah+DFv4WXMcbvStBgSySKscscSWMxD3Rl/TRXOg9hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783229118; c=relaxed/simple;
	bh=O1+ENlUHG2dVn+CM9CHkYU8RJDakTHxXXVRv0M1G5dE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D9hQmBGsntA3pLE5tNc42WwecuJVB0Ks3Vfh376uFAk7JUxQ36xkmXBWriPi01+l2dOtrU98iU5lrytlsQyUf6obzPp1mmQLEQJ30+Cwl9DFiIMs/Y67QUkjZyh5eK8Bz2F/Gn8RxRCNVNzEbjsiZieGKUxKdUcJF0CPemBEyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGmJj32G; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-381065a7a03so1362191a91.0
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jul 2026 22:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783229115; x=1783833915; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5E91OTPvV+ZJz4uFncOkjNOPReoSP8zzTh43d9B2oQ=;
        b=JGmJj32GFu6WjNkqj9ff3szaicd+3vZipe4ZKeRw0Z3mHtOm3CK7wZZElGVNK+pqfX
         3oPneuZ6s6NoJ7eykRmXbBubp0AOPpA/8sm9hAjga41Z00OBdIyQyHbRkSznXFO28sRe
         3eGVspTRpbkovEj7XFUBTV9wpXSqZFy8gvzUwp9aR2Y/DIL9IOaupw8GsjYJJEh8Jcqn
         ztYFHBWFsscpYv0FYUW2TnmBm747AVNym9lZReaQfKQ2MeCU1ysR0SYvg0M9bUYA/XGY
         kwyJZ8tysBtM1KvT7IAGo9/wi2dKSeTN5ln2axTOgZEFtHg7m7rjKL/9NJfD139HOHwZ
         Nz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783229115; x=1783833915;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5E91OTPvV+ZJz4uFncOkjNOPReoSP8zzTh43d9B2oQ=;
        b=sr+xNy8NtbU5N011/zy8CN1LpuNX40N62FmMZLRUn8ARIzFL706UePdAAUUZ97uVHd
         hvEt3YWBMKJBFle7QYA19f7ubbkEQMhSdy85PXbeUndQwPs1UQdxgQoEGZQwrw5xiBCe
         MO4es3A7XYlS35xPS6gJnOxa2Q+Yw8QijIMyN3Jp7T9k0DRV+6l9NaSEr6IYSYTkHnS5
         P48k7FDq8Mgmc4EASlrSepj97ncIS+PeqoB9lDJ5ni/ixG03FUQipJxYoimQeBsNK4YO
         urgDESpymF1rQQIVgZ7sOvIwydHfNUkJdTrWuRx/fP9WzXUZ2LX7YrEJPlRBWtu84ywc
         HNSw==
X-Forwarded-Encrypted: i=1; AHgh+RqFeM26AVV9wTpS7UFZ7YAM8ch82quCN8NoXyuphvHAa9bG2EfT5bDTW2dTZV0dN0lMY9/cWXI+PZiwfG+rUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVeKpRbwbjloehDIVMXaFJqu510hi/0JzaNRM768QgGsQVh/i
	vmZS7VAdMNfAj6bIOErGLlUtbiZoBgZE6ho1H6SHpqc8Ubeu36c1d6OwKB45iA==
X-Gm-Gg: AfdE7clzNiSLbCo64SpE9fqiJdUUgrslON+1YPpGr3LziMHicB5mp9zXf9tLZBfuJZ9
	dCShiHja7kopj72C1Ui0Mz4lAKloYAceTW9LPwKfAsaKPilRT2wpQQWp8akPG1FSlWCS0C/ocuB
	1HGu7AiWrPpWYtEnVKI9QFCncvL4Cgmef9YthI4itNseXaY60sB1E7djtMZqQ8L18O8xdisB3AV
	2g4mfjVjLwbYBxrzrc+tQ1UDtusGB5pEmNUfHzVDmtQ/AMhSfxR2hY7Q54PAUcc/fBp9866QYcp
	glICX+yY+AaF0Kifst954kU6z8FpAthYmdBqVp2/G4EKLyew54mAwJuc/jztUeE2isXf60qlWwB
	H3uEKPxavt204YBV+CBc76cOAAPYutJY6hWk+HwpdBY+EvZU7eDDX/HPSgpazThHRrq3P+gWSL0
	Tq+bBJ97yR0VduRhX4SyfCgoCRJs+ekC15yAOq/h1xvbce3DqKDvvCT7pj8ZM7in6zIxTnNxhik
	cV2
X-Received: by 2002:a17:90b:4cca:b0:37f:fda5:8d9a with SMTP id 98e67ed59e1d1-3829f001825mr5075022a91.25.1783229115290;
        Sat, 04 Jul 2026 22:25:15 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:4560:aa1b:b33a:15b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a1bsm39035329eec.3.2026.07.04.22.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 22:25:14 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/3] MIPS: BCM47XX: convert buttons to software nodes
Date: Sat, 04 Jul 2026 22:25:07 -0700
Message-Id: <20260704-b4-bcm47xx-swnode-v1-0-730d59340237@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALPqSWoC/yXMSQ6DMAxA0asgr7EEKZjhKqgLEtzWSAQUd4iEu
 Dtpu3yL/3dQDsIKfbZD4LeorD6hzDNwj9HfGWVKBlMYKsg0aCu0bqmaGFE/fp0Yu669ENe1KYk
 gdVvgm8Tfc7j+rS87s3t+R3AcJ0DAQhh1AAAA
X-Change-ID: 20260627-b4-bcm47xx-swnode-99836e552166
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Michael Buesch <m@bues.ch>, Hauke Mehrtens <hauke@hauke-m.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org
X-Mailer: b4 0.16-dev-b242f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38627-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zajec5@gmail.com,m:m@bues.ch,m:hauke@hauke-m.de,m:tsbogend@alpha.franken.de,m:brgl@kernel.org,m:arnd@arndb.de,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dmitrytorokhov@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bues.ch,hauke-m.de,alpha.franken.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E923E709016

This series converts the legacy gpio-keys platform device on BCM47XX
boards to use software nodes and static properties.

To do this properly without relying on legacy name-based matching
(which is being removed from gpiolib), we introduce and register
software nodes for the underlying GPIO controllers (BCMA and SSB)
and reference them in the button properties.

The first two patches add the software nodes to bcma-gpio and
ssb-gpio respectively. The third patch performs the conversion
for the BCM47XX buttons.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (3):
      bcma: gpio: Add and register software node for GPIO controller
      ssb: gpio: Add and register software node for GPIO controller
      MIPS: BCM47XX: Convert buttons to software nodes

 arch/mips/bcm47xx/buttons.c | 434 +++++++++++++++++++++++++-------------------
 drivers/bcma/driver_gpio.c  |  17 +-
 drivers/ssb/driver_gpio.c   |  27 ++-
 include/linux/bcma/bcma.h   |   3 +
 include/linux/ssb/ssb.h     |   3 +
 5 files changed, 293 insertions(+), 191 deletions(-)
---
base-commit: 2b763db0c2763d6bf73d7d3e69665222d1f377cf
change-id: 20260627-b4-bcm47xx-swnode-99836e552166

Thanks.

-- 
Dmitry


