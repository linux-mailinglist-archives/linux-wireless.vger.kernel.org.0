Return-Path: <linux-wireless+bounces-35279-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIIXFFyD62kONwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35279-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 16:51:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49146062F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 16:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78EAB3002F70
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1993E0258;
	Fri, 24 Apr 2026 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8dBtik0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8063DF017
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042261; cv=none; b=Z6m1FGBblfwgA6DUMFvGxskrRMMPu0q7CwVnPVCkQqTqXK+5Z+1tzllzyLRd5Jpx7RAKfCkfo7mSVI+gJx+9Rtiv/55j2ARSEY/xEcbVXlZKOnZd70rR05GC/kBliopHBv94/t3M2Xe+pfRMmgH1BfrS1Hd1pyr1cttewnAYWrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042261; c=relaxed/simple;
	bh=5DpfGg/7I3GkVZMMzWWKANoH36KXXpBqp0CbqHEpqqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GttOr9LtJBsWreE01z2i5tn6GeVzusc4r4FNiOgzrcIyYiA+O0gDe+onkwXYRHU2SW7cCpbaIRwRDXVwahnsm1QgPBOgCNGlFiOQuLRRCryqmf0PD0k0tryhkLpI0yGqHVE31r2mbxNr6U/3krL1nbNqgmpx1q2R4/Q0KxQLEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8dBtik0; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-95699e8e26aso1958679241.0
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042259; x=1777647059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBAWISZQQ83B65zp3ZGw7r9K/PhyBwFKKHiTM7zEE8s=;
        b=d8dBtik0Wi2WX9fYplTr1J5vYxjM5ADq55TEHUXUwHS9NwhvPg+t7YdNG4txUCB42W
         KMc6/OxMWVZuVwojSfwW1n3d59v+hXy92Djl6DMDzFeK2STgOEJIZ8uKl+9dRsAgYRRz
         wyp/mnlhIqfrVPRpaPeVdFdBIsGnVo2MIBmMy4np5tEDBf8kXG4AoIq/pa41xyzHYzuE
         gCEFsLIDufzX9kbBUBmY6iBcxl2l/gg2kikD0Z2iutF/wOzDE30FeT5mQLyxKmnm4lFn
         ugu1XxES3ZuL0syK7bBbnm/eZu3hTlReuc8RMc2h930+SRHIzcSztqI1FIC08bxxJZWI
         RCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042259; x=1777647059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SBAWISZQQ83B65zp3ZGw7r9K/PhyBwFKKHiTM7zEE8s=;
        b=Tff6+TVAjLbtacFsIcfJ2vp4dmEOU75aXMK8LV0AKBPM1Ev+3mVd2lWP8JUUwzAX8r
         TEecToL1Cz9x+hAtTckunNwS4d9RNKb5twW36k0YwRleLh1iWRn5ZUZepZAI98WgRh0p
         n1UV7ad6En9onbJYrxg4bR/3kq+zgwczT1+cfan05eULNFdcIzWDwTjqm6EKsO5YBwov
         pV5s1Lub8TGFPmkDApWeeEvIKMmMkWqGNLlHLXiw2zZYGQXoGvgh9+Kk4Z1iOX6g4x8K
         IzZiZFe6teW79opI6Q5zUjgIYDsVbzXP3XCyYW4HYGrLFZY5WsTxpapJMzm9sUag57FM
         akhA==
X-Forwarded-Encrypted: i=1; AFNElJ+oSjO6/d21alzjpHqlacC5qY/aHJJWzxr6EqHMQecGen/SnCD/Qo9f/e29N0UCtUSFJ1LnAUmPiWhdyU69Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlU9x0oP2L21V13tAXvbfCH2JJN9S1BGnsThF6f8j2LXEsMC6J
	CqUND6vGx1fPYErP6UYnJw/LlPfishcDpVDxujlVQQb51JauJSQfffRf
X-Gm-Gg: AeBDieuu2sNG7xtUUTPtox60VAWoJjbKcdjBGZC0Tbq0vJrv6oMDedw2mZBovN7BHby
	1ZsimdVn7MAnUBX6c0N47sKCklIO18nbt5KHkzAGTKlD9YrIel3MnMHL56zx+RR7ood2UxDGLzT
	dc14R5XVIwx8JvFo9k5mf+NCTnUV1TQIhn1G6efpRqX5Sc4gahH1Rtr2ZDEvO8ATSZn7bai/x6M
	pLJnv8486xIab1yxtWh6nqq/gN+KxbWi5JOYr312sN9X1ryVAFCZaskBUWIJBVoTIAjj6cTWZ/V
	m7wLLwQ0991PPY6EAFzZoUMvI/XpcIWo6t1OVSTNZV2VvjlPHnB+JeP61z7hWKX/IuhGUb6UFK8
	J6F/LlbxUAYq4+CPjseVX4MkgyUVqznY3WrqmRPJ0tSMoMmaALZmVPu8+EvgvixM3EA9zFR4diq
	2ylG60GL5i0yPyfsj4ONvzbLNh5oP4Rfuj1XoZFaxFEX7pGENPShqDFM5dLHXotnWo7pVYn3nE+
	S8=
X-Received: by 2002:a67:e711:0:b0:604:f849:462e with SMTP id ada2fe7eead31-616f8182663mr15135336137.25.1777042259406;
        Fri, 24 Apr 2026 07:50:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6174272f752sm11448711137.0.2026.04.24.07.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:50:58 -0700 (PDT)
Date: Fri, 24 Apr 2026 15:50:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Yury Norov <ynorov@nvidia.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen	
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski	 <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Ping-Ke Shih	 <pkshih@realtek.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn	 <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Hans de Goede	 <hansg@kernel.org>, Linus
 Walleij <linusw@kernel.org>, Sakari Ailus	 <sakari.ailus@linux.intel.com>,
 Salah Triki <salah.triki@gmail.com>, Achim Gratz <Achim.Gratz@Stromeko.DE>,
 Ben Collins <bcollins@watter.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <20260424155053.1a98bf61@pumpkin>
In-Reply-To: <6170788fcab2ec835597e3d7411928d36850c20a.camel@sipsolutions.net>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	<20260417173621.368914-2-ynorov@nvidia.com>
	<6170788fcab2ec835597e3d7411928d36850c20a.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6E49146062F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35279-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Mon, 20 Apr 2026 10:43:08 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

...
> I (personally) tend to prefer the "__MAKE_OP" versions (*_get_bits()
> etc.), in particular because WiFi and firmware interfaces deal a lot
> with fixed endian fields.
> 
> Any chance it'd be simple to generate u32_get_bits_signed() etc.? Could
> be especially useful for le32_get_bits_signed() for example, to have the
> endian conversion built-in unlike FIELD_GET_SIGNED().

The problem is that the number of options explodes.
You need PREP/GET/GET_SIGNED functions x_64() x_64le() x_64be() x_32() x_32le()
x_32be() x_16le() and x_16be().
I make that 24 functions.
For UPDATE you also need x_16() and x_8() for another 10.
So at least 34 definitions - it is all getting silly.
(And I've excluded the pointless 8/16 bit functions where the result
is promoted to signed int.)

Then you have the problem that some (common) architectures don't have
byteswap instructions, but do have byteswapping memory accesses (maybe not
16bit). Which means that is it generally better to byteswap the value
before passing to FIELD_GET() and after building the full 'word' using
FIELD_PREP() (and just | for single bits).
(Except it is probably always better to byteswap constants.)

It is also worth nothing that FIELD_PREP() will reject requests to
fill signed fields with negative constants.

	David

> 
> johannes
> 


