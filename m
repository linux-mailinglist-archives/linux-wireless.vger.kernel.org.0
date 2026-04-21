Return-Path: <linux-wireless+bounces-35123-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM0DLZ1D52n55wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35123-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 11:30:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DED1438E3C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 11:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEF243014C0F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7623A5E9D;
	Tue, 21 Apr 2026 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP0YHrJK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8A63A5E68
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763671; cv=none; b=ayHhu2/h8AnY9AUJdlOY6mo0ZOQPzHEdY8UFAvjB8swxLz+NjwoPYkKWxw7EEff72Tbcpslhy2MhDa5okC4h62bNio3ZcVT3HXsNwGyJPqb7hfGz9xzz4/XWu6W1kRQ+JK7gTHj3nsOHFeZrjFLV0Tg2VXfWsbjcijRjy022gu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763671; c=relaxed/simple;
	bh=NWVPQ/ix6la1A9YnRnDlxRH64UYZgVvj6dWNHNlWfm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rz7SyG5o78ykdI7EkB7h8ayytXopgg+XKyoic0k1jVH+J30X5i/r6EkCHaIcqoPkIYIgPByZs2SByUOBLDoGbViNAFc+YrVsxd1Bt3lf2siaS4Kg2iKWBzcRGlL3iSiepN98x54lhftZHuz7xYawGCNQzVVZ2jEoDr2opPzlbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP0YHrJK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d73422431so3426591f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776763667; x=1777368467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SK+aw4ngOkm9hF+ynW9KrB9F3h620ajY5HNLbxZ/XI=;
        b=KP0YHrJKrICGVmlUQNpi+20Q7UPpVxplJOquT+Zqh5wyKP1DFRAT7kdVdPEmcAtOJU
         brV2ROn1BQQz1KG0Et0nKatui0DkB9eOcKqCe0j55c/oDql4jqlcVe2INgsEj0oYNzsv
         v4I5gJbI1rbqnzhgEyyCzaFL957VWDYW4GuiX9CSdJK+KYx8hbbz5XGalDkv4CZ0svzP
         Us87q4HoGBFt6XaW9f+srHB+DxtWbVlIqdrWBMgH57xVDqxUZVkdyFAxN8W0e9FeM1pw
         oUlSAwAmh3T6pilJgybq1eLs9wpLgcIqAn6PInRw+GpDo3f1p+g9kBingnGSBOlIcuB3
         OEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776763667; x=1777368467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2SK+aw4ngOkm9hF+ynW9KrB9F3h620ajY5HNLbxZ/XI=;
        b=XNR37PyHFwXDcWBvm4Uu8TpqkrXm/jqpZkAF+tmiACeFmfkQ5mwVfPf9MY9MGshvX1
         FcMKOXrSpNdmKEXG/hmfxMZgbXSrkLjDSXr4wUsGX6L3UB4X5elHSyNEogEMVTaU4Qf7
         jU5zSUHJtWVbMYQuqnYZJGkxaMmj/vs+13+ISf77ZACqjS4NQIwMeYgZkFQtiRbflOok
         SqNgeVqAZ0dNO1IWGRJiqo2wDIJ6sD636hejikCYTVkoCZt0wh3Y3xPrMlCrLmMlLxca
         LiSyASZafFuQaQAacSiLM94UMFtRKK0GeqtBz/uQZ0/MgbyfX0dnoAo39XJVf8oAeOxm
         95vw==
X-Forwarded-Encrypted: i=1; AFNElJ8tLX0eTomNn81A6xoLQsV8ivPQDYdBJ7aO3eSQmxAabmyGKA3T4OidbjQvqb8spEB6eVnDERQp6x4xDt6irA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAKzOfDXJNTmLK+BRkE2IWN8jx1sivQeV6mFf7OPRzjImaEA0
	8bWtmIDw647qoZOk7XLu+uFOy4eZZE495WOPTd+qB/gpSts/z3J/tODQ
X-Gm-Gg: AeBDievF9VoAaLz0pVFW5w0gHloUqH6AZI6zUS4tx51uW646UKlXwehOzGj5KunPRtg
	tHMNHAtZwGe55g9EXGqsXLhtbBy3uOQtDITnAU6JD3A1ePu0CUfV5PCoCZEpfPTJv3flHE5LTOD
	NDOLCgxRZMU7iMLFqtG4Ahn5onyhugfi1EX2VvSP2JQc+cEx4i0j4rD4iWbhQbH3WYJTr/o1X/9
	BEZa8lXfm/TK9X1OIDMfURrzqmFjiQar5WFMapppc6p+UcvA59o0EF8ifLamyKkkCT0/mEwCxPc
	Ufviq+cn4blfn7nxxtcxiDNH3zG5R31zeig31LR5Z/w5Kgsk9LVBhFFKR/7nlDck57wuG9tx9Ac
	A6vLxeoG6DJRxlbhhNO7aXE7E65lqf8BWvemQGG+h7pNu/3jKZ+cKdczbcOveLN0APAcszUjjgm
	Ajpif57CnmZDuD+6TNMmxZzOfbb94tnhzx2Pd5+0xME99z8eXZEoo4OOFqW8XJwf3wGpyaTaLRl
	JEqHMk0BkOfsg==
X-Received: by 2002:a05:6000:1a89:b0:43d:7125:e79f with SMTP id ffacd0b85a97d-43fe3e25c89mr27107393f8f.47.1776763666796;
        Tue, 21 Apr 2026 02:27:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm35116597f8f.4.2026.04.21.02.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:27:46 -0700 (PDT)
Date: Tue, 21 Apr 2026 10:27:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>, Richard Cochran
 <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Hans de Goede
 <hansg@kernel.org>, Linus Walleij <linusw@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Salah Triki <salah.triki@gmail.com>, Achim
 Gratz <Achim.Gratz@stromeko.de>, Ben Collins <bcollins@watter.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <20260421102744.6bd30e50@pumpkin>
In-Reply-To: <aeZocbNjbvzMZO8b@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	<20260417173621.368914-2-ynorov@nvidia.com>
	<20260420111940.GE3102624@noisy.programming.kicks-ass.net>
	<aeZocbNjbvzMZO8b@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35123-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DED1438E3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 13:54:57 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> On Mon, Apr 20, 2026 at 01:19:40PM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 17, 2026 at 01:36:12PM -0400, Yury Norov wrote:  
> > > The bitfields are designed in assumption that fields contain unsigned
> > > integer values, thus extracting the values from the field implies
> > > zero-extending.
> > > 
> > > Some drivers need to sign-extend their fields, and currently do it like:
> > > 
> > > 	dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> > > 	dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> > > 
> > > It's error-prone because it relies on user to provide the correct
> > > index of the most significant bit and proper 32 vs 64 function flavor.
> > > 
> > > Thus, introduce a FIELD_GET_SIGNED() macro, which is the more
> > > convenient and compiles (on x86_64) to just a couple instructions:
> > > shl and sar.
> > > 
> > > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > > ---
> > >  include/linux/bitfield.h | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> > > index 54aeeef1f0ec..35ef63972810 100644
> > > --- a/include/linux/bitfield.h
> > > +++ b/include/linux/bitfield.h
> > > @@ -178,6 +178,22 @@
> > >  		__FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
> > >  	})
> > >  
> > > +/**
> > > + * FIELD_GET_SIGNED() - extract a signed bitfield element
> > > + * @mask: shifted mask defining the field's length and position
> > > + * @reg:  value of entire bitfield
> > > + *
> > > + * Returns the sign-extended field specified by @_mask from the
> > > + * bitfield passed in as @_reg by masking and shifting it down.
> > > + */
> > > +#define FIELD_GET_SIGNED(mask, reg)					\
> > > +	({								\
> > > +		__BF_FIELD_CHECK(mask, reg, 0U, "FIELD_GET_SIGNED: ");	\
> > > +		 ((__signed_scalar_typeof(mask))((long long)(reg) <<	\
> > > +		 __builtin_clzll(mask) >> (__builtin_clzll(mask) +	\
> > > +						__builtin_ctzll(mask))));\
> > > +	})  
> > 
> > IIRC clz is count-leading-zeros and ctz is count-trailing-zeros. Most of
> > the other FIELD things use __bf_shf() which is defined in terms of ffs -
> > 1 (which is another way of writing ctz).
> > 
> > So how about you start by redefining __bf_shf() in ctz, and then add
> > another helper for the clz and write the thing something like:
> > 
> > 	((long long)(reg) << __bf_clz(mask)) >> (__bf_clz(mask) + __bf_shf(mask));  
> 
> So...
> 
> I like the shorter form, but whatever we add in the bitfield.h - we'll
> have to support it.
> 
> For example, __bf_shf() wasn't intended to be used outsize of the
> header, thus double underscored. But there's over 100 external users
> now. And to make it worse, it's broken for GCC 14 and earlier:

For anyone who hasn't followed the gory details it isn't 'very broken'.
Basically __builtin_ffsll() doesn't always generate an 'integer constant
expression' from constant input so you can get a compile fail.

> https://lore.kernel.org/all/20260409-field-prep-fix-v1-1-f0e9ae64f63c@imgtec.com/
> 
> So needs to get fixed.
> 
> The bitfield.h has two __bf macros: __bf_shf() and __bf_cast_unsigned().
> They are thin wrappers,

__bf_cast_unsigned() isn't exactly thin.

	David

> but after all do something with the corresponding
> builtins output. The __bf_cls() would be a pure renaming. I'm OK with
> that, but some people don't:
> 
> https://lore.kernel.org/all/20260303182845.250bb2de@kernel.org/
> 
> That's why I didn't make FIELD_GET_SIGNED() implementation looking nicer.
> If you strongly prefer the shorter version, I can do that in v2.
>  
> > Also, since the order of the shifts is rather important, I think it
> > makes sense to add this extra pair of (), even when not strictly needed,
> > just to make it easier to read.  
> 
> Sure, will do.
> 


