Return-Path: <linux-wireless+bounces-34958-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BKUG0SO4mkc7QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34958-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 21:47:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA741E5EA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 21:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 798A9305D144
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB034DCD7;
	Fri, 17 Apr 2026 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htHi75iS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD3A347FD3
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455041; cv=none; b=sOh7hpwpkjskeLuJWtSnQxlkPldQpnsFsGF69vZpLZjEaYStE7HSKFoK8V20Q/RdIDCGnYspEuxvf+PEnNyHwhOXVHLpTD4c+6u+d0lfN4Owe/PbRfhbdZVEcU3hBGy9buWby7CI9de/EKg0pvnh8VoAmM7wQ9M3cBi8EMOR+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455041; c=relaxed/simple;
	bh=KaFMDCFH9CdumsHQVkzpXcZ16qLlfuRi8NWo/FeNfgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSnedaTLqribmsgMlEuAfpSBEVcXKPJRmr6PGl+jMxXGHK187adqyw0QWLSMAFbpSVm6buK4STmmeujN4WxrhC9uab9JsI1Z9SsfpmMg9rM2RvOhK24fnJi33JhWu+GZHVcAlLoq6mWb9k8LzY79du6YSYg7oHqxgxfcAmVLlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htHi75iS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso10159345e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776455037; x=1777059837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSJKJdhPF/oSEv0Q3RwysZnU9Ji4VqpvQLZ2wVMqphA=;
        b=htHi75iSbURVMZ6Xk9C/IrGjBnOFBWNfL2XmrCASRM+7fW23utl/LnXbfsSHB5bDuY
         p+JrBm3aDjplc/i+J+r+5z3cqZYRptIqbxLk4d2Fs+yDPu6pdSVhKrJvJ+PsyNXkDq8Y
         g1KMYTwZhGj3NXZxDotQEs15pNW1EocuyHt11lGYxOUqKuT1I0nP1Z3vqRpAp+1nxcdn
         u5qYKEtx9eWSjtv+po3EklPDjX5B4dyPS8B3N301kbz6KWAK7z2PDbb39K3lJoEnTUyX
         97wf6Z+bFsq0LOcC+MBtKcORuqrcPUAoc9J2Btom1LDSSbQv8je6lVjNxJkMmHQyu4UJ
         Av+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776455037; x=1777059837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tSJKJdhPF/oSEv0Q3RwysZnU9Ji4VqpvQLZ2wVMqphA=;
        b=ZzW27sB7X0qvnRePnHb9ICFFR7MoA92ncuGWW+SuGmp69n7Zyy2ovBZ/7nT+su+Ktf
         IDaslQhqQH/Sq+NGPlGOtYmJ4xQ20bC0/lDkAYUGi/Z+xORgqpbfdW4Tr0cegYNe3OwG
         ZTERPnmn7dviOB82rnI8Y7l9WjEN1MTGqIYRAkqfmLiyvEy92PZBmM0vbCLZ1MmvkJDH
         hn1iht273KmO1ebbH9lju3nkFaR33gDJUPjhUFHHJOgjoHOqVOxJrowrkx7ZivCui9Em
         YQksMoDsj67dTWhW/sGHkyy/6n1x1HaRhNIilbJh1u2S0l144aNtNlLmcDf1NzfnEmes
         fUgA==
X-Forwarded-Encrypted: i=1; AFNElJ+61ykZzX4cwRSk/DV46PL36ee4D0JmZi1n+nYkvgreDAnRLnIRL+8/qQYlbnRamtm1jUSTVrAPw1HzL211gw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4wdZBoihi51QFmbNMcde+4VElsyw/DRWnGCUg5rGH4Ki+ggJN
	H2MJfhgnYO5vkUHNYXMMAAv49rowXNI9OTOdDPM5lgNDwhxZxh+ZTXQf
X-Gm-Gg: AeBDiesesEsk2roq6zVl66U5FkeUEBphuiR+M0dLcgqC/CaWX3gSCkN6UmdMK4XOSln
	kkOFi28UgTsfWem1OHDV/1eN7Vb2SBXOIcXdCVHc7YU+YIBi+JD98xzuV+ozVbsOA42g+bYki9M
	zuegrFdZHZCgiuAFszS5HZ6FnIhBIAqpabhhInLo/GlBMXJ+KOoHoWffugsejQWWRQKqka7veL1
	ErZUcqsDOOFdvppK+W2Q4VpSurBpMs4am1Yo1FrUr1rgPjqPIjArmCiAT9XpgEgXuTEcPiUZSXu
	pw2Sm7fjLLlq8xUhD5W4MfmlnnshJP2iMkWPzl9Eyk72G1s5VpsZFSiEQpZ52gAguV3ECoFUF4U
	U312xG6Tom2tfNtHtyH1jy/7emsofV9LMGiaEybGbvcL+5WunmqDjck+w9HIaFXI5C6UK4wYoPN
	5kdJ18IzBv8IaIyf+mKEJB10MlD25asV5zChw1XykGBER1j53ZcehIRoDNY9mvK9JF9obSbBlyk
	R0=
X-Received: by 2002:a05:600c:1c11:b0:488:9ed3:148f with SMTP id 5b1f17b1804b1-488fb782a93mr63697245e9.21.1776455037158;
        Fri, 17 Apr 2026 12:43:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc11ced7sm58174535e9.0.2026.04.17.12.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:43:56 -0700 (PDT)
Date: Fri, 17 Apr 2026 20:43:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Richard Cochran
 <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Hans de Goede
 <hansg@kernel.org>, Linus Walleij <linusw@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Salah Triki <salah.triki@gmail.com>, Achim
 Gratz <Achim.Gratz@Stromeko.DE>, Ben Collins <bcollins@watter.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <20260417204355.37fd960d@pumpkin>
In-Reply-To: <20260417173621.368914-2-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	<20260417173621.368914-2-ynorov@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34958-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CBA741E5EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 17 Apr 2026 13:36:12 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> The bitfields are designed in assumption that fields contain unsigned
> integer values, thus extracting the values from the field implies
> zero-extending.
> 
> Some drivers need to sign-extend their fields, and currently do it like:
> 
> 	dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> 	dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> 
> It's error-prone because it relies on user to provide the correct
> index of the most significant bit and proper 32 vs 64 function flavor.
> 
> Thus, introduce a FIELD_GET_SIGNED() macro, which is the more
> convenient and compiles (on x86_64) to just a couple instructions:
> shl and sar.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  include/linux/bitfield.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 54aeeef1f0ec..35ef63972810 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -178,6 +178,22 @@
>  		__FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
>  	})
>  
> +/**
> + * FIELD_GET_SIGNED() - extract a signed bitfield element
> + * @mask: shifted mask defining the field's length and position
> + * @reg:  value of entire bitfield
> + *
> + * Returns the sign-extended field specified by @_mask from the
> + * bitfield passed in as @_reg by masking and shifting it down.
> + */
> +#define FIELD_GET_SIGNED(mask, reg)					\
> +	({								\
> +		__BF_FIELD_CHECK(mask, reg, 0U, "FIELD_GET_SIGNED: ");	\
> +		 ((__signed_scalar_typeof(mask))((long long)(reg) <<	\
> +		 __builtin_clzll(mask) >> (__builtin_clzll(mask) +	\
> +						__builtin_ctzll(mask))));\

Have you looked at what that generates on a typical 32bit architecture?

It really a bad idea to use __signed_scalar_typeof() on anything that isn't
a simple variable.
The bloat from all this when 'mask' is an expansion of GENMASK() is horrid.
Indeed both signed_scalar_typeof() and unsigned_scalar_typeof() should
really not be used - there are generally much better ways.

In this case you can just write:
	({
		auto _mask = mask;
		unsigned int __sl = __builtin_clzll(_mask);
		unsigned int __sr = __sl + __builtin_ctzll(_mask);
		__builtin_chose_expr(sizeof(_mask) <= 4,
			(int)(reg) << __sl - 32 >> __sr - 32,
			((long long)(reg) << __sl >> __sr)
	})
and let the compiler do any more integer promotions (etc).

I'm also not convinced that the checks __BF_FIELD_CHECK() does
on 'reg' are in any sense worth the effort.

I have tried some simpler alternatives, eg:
	!__builtin_constant_p(reg) && statically_true((reg & mask) == 0)
however that throws up some false positives due to some of weird ways
people have used FIELD_GET() where it is nothing like the simplest
(or most obvious) way to do things.
That might have been the code that split a 32bit value into bytes
in a printf with:
	FIELD_GET(GENMASK(7, 0), val), FIELD_GET(GENMASK(15, 8), val),
	FIELD_GET(GENMASK(23, 16), val), FIELD_GET(GENMASK(31, 24), val),

	David

> +	})
> +
>  /**
>   * FIELD_MODIFY() - modify a bitfield element
>   * @_mask: shifted mask defining the field's length and position


