Return-Path: <linux-wireless+bounces-37604-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zOHfN36UKGr/GQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37604-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 00:32:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B02966497E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 00:32:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=Ckt5g5mh;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37604-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37604-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E108309C541
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD38A4C77B8;
	Tue,  9 Jun 2026 22:25:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D910403B14
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 22:25:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043958; cv=none; b=QSDZ5Lyxz1IivL5Q/syKYBCLAZWHqn3wjmtGYdWVb5Atfy+A8rhWEaWteR8PY1XCdEtD/sKVgCWNu49L0ZslX2PrCnQEpKDJiy5mE9NdrcMK9LBYz9hoE3Hitjcu3Ej95twa5VAg1TYFKRlnpdS5S+VOi02Ry1UOD/4+L+D+0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043958; c=relaxed/simple;
	bh=gC5RijoMreJ37E+ZXnO6sSCfWOZUThbmrEidBKcTv9A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O6mw5X9aQkNIQ3AMWtSm71yMIj3+5VaX4tZrLiGYNgZdiYFgDGP7b9AjDycIJxzjonwIJtRX2CBpo6TPck1BiJDCT4RJEarSKvWSyICbo88eZAsnjyp+LfJ3cGb7zYFD/a9eAIN5y/hJdjdg/QuHIT4nqVgBMaVFvttE9jlqTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ckt5g5mh; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0b9328c4aso42244375ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781043956; x=1781648756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D7duqRcD3fdsTRow2UhPRWiLjw5TIDW3U11ZLjAtzg=;
        b=Ckt5g5mhS8YR2cizTWbJ5Fwk8gGj6VebB+0OEJgvf02706OxaHIh/MLoWUZkdc8W2v
         tDVO9ou14uqgirHWrZKF4TT22SL8Kw6c9cIfwgHoNv09ym9tEccqMSP/b5lQeWoqDES9
         4Y/1fE4bs5q1c26wMjvtkzwBbmD6R5ZssJo+Ql4XeIs+Yw9IhdJtj3WObSFvTKV2NsRh
         KdAHyJOP9ZzIAXpBIl9bEt8fkARYApQC8HuCBb+LFcyPHM7jM2nhfg7jU3w/egVF/fFg
         eqBE7VWfKHsswmA0XGrVNRgAu6OAU+Z/4WuvEPeIm2Pew6bt4mI47RFHA/Njj5qWoKdw
         N24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043956; x=1781648756;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6D7duqRcD3fdsTRow2UhPRWiLjw5TIDW3U11ZLjAtzg=;
        b=dpJ+yxIrUY3Hel0rmI0YDRBR65WF8cnwKemK7/LwNFfIyX/lgsg73e86C/C2VATOr4
         EPTX0R6hu1Di+Xf/GVeRz2pLbg7cGxDWLZTMIUEtdw1ZAea5Hl+y2jZYBOsMjrCRHEtb
         UNQpRIbrT4QYg2MWbgRncnzZHmL2zEloviZJalUc5RXMhNjcXek4Nc+pAVsA8KcIgbrD
         OguZR1wUokpv/dq+xHbdI2giXHhV9KE1Tu33vrdIco6ijkp2kOun/yhczkRRimKM2KnL
         DD5T76r9Y92xe3hMw/H71a2UrICQ36hE7omD2ojtO5ufSHgyTgk/Xx8G5N+vtQJ3Tk4Z
         MbGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8eQJ4mD+cqh1px5vHUoFFv6pDeavsbCbgDsPvs00cKpLu+0RmU5rLzzl3FkAu5TT/xT47V4Ad8xcE1EMqd5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCSLSVyg7LkpGFvDDZW/bDDHHXiUGIKrTVUIv8esjkbC0kEnDB
	TzwsqUms/sZBz3P4J1qzuHDfFw8u1nj7JjipNOV5yvb15a/+BvSmXAANX0O1TOGVimk=
X-Gm-Gg: Acq92OGl28zuYvmIhpsFGO3flz8vrNhrzDLkBfHA9Q/j7/tU/mjJfEu5B5z7Yld9vuq
	PAoNNN06VBuwKrP6Ohx/zdl3tu3BYjrNVIFfuxTJb+ixyC9G8qdPQBQPKLeUYCZIonD9yyKjoJk
	tfEN3SNKucOrRyIkhAxngTN7jLNqBKqxJESpOmQtihUqNy+dQfOevVB+tQPaR4RgsnWkMacL2/h
	H4jfoQDenOSEEtR0OzzZJ30dSYoPu9hC0CeSEeYqS27rl/d9fSgcT2sWijrdblj343lObXkfvc1
	8w+iZboR3uic99mnOHsMEyUw3XsGuPbPgrzZlSFX6V6FfQYuTQ7zzDr4pDxJV3fWxaNqCwGAyJC
	tNQ3RldhMq98yzL4K/aNmwQnE8DdvFeidxP63gMWqOQ7uA+7sGIU35fqY/mq3geCUqPNXZ6HkWP
	AQNM8N2u01wbUhrvEwBa0/FVj3hF3rR/A=
X-Received: by 2002:a17:903:2381:b0:2c2:27be:39a7 with SMTP id d9443c01a7336-2c2a1c9ac2emr57718625ad.29.1781043956535;
        Tue, 09 Jun 2026 15:25:56 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2c164f6e2adsm238181875ad.5.2026.06.09.15.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:25:56 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Lamparter <chunkeey@googlemail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20260520183815.2510387-1-arnd@kernel.org>
References: <20260520183815.2510387-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH v2 00/10] gpiolib: fence off legacy interfaces
Message-Id: <178104395573.234140.4413143072350533512.b4-ty@b4>
Date: Tue, 09 Jun 2026 15:25:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER(0.00)[khilman@baylibre.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORGED_RECIPIENTS(0.00)[m:linux-gpio@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:arnd@arndb.de,m:chunkeey@googlemail.com,m:johannes@sipsolutions.net,m:aaro.koskinen@iki.fi,m:andreas@kemnade.info,m:rogerq@kernel.org,m:tony@atomide.com,m:tsbogend@alpha.franken.de,m:glaubitz@physik.fu-berlin.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linusw@kernel.org,m:brgl@kernel.org,m:dmitry.torokhov@gmail.com,m:lee@kernel.org,m:pavel@kernel.org,m:mazziesaccount@gmail.com,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-wireless@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mips@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-leds@vger.kernel.org,m:netdev@vger.kernel.org,m:chunkeey@gmail.com
 ,m:dmitrytorokhov@gmail.com,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37604-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[baylibre.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,googlemail.com,sipsolutions.net,iki.fi,kemnade.info,kernel.org,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:dkim,baylibre.com:email,baylibre.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,arndb.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B02966497E


On Wed, 20 May 2026 20:38:05 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This is an update of all the patches that are still required before
> we can actually turn off CONFIG_GPIOLIB_LEGACY for most platforms
> in the final patch of this series.
> 
> I originally posted this as a series in
> https://lore.kernel.org/all/20250808151822.536879-1-arnd@kernel.org/
> 
> [...]

Applied, thanks!

[09/10] ARM: dts: omap2: add stlc4560 spi-wireless node
        commit: c5a0ac76b364bbd1d4fb7e440edabcd2a369343c

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>


