Return-Path: <linux-wireless+bounces-33256-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DR/MML4tmldLAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33256-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 19:21:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEEF291E5F
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 19:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF509301700A
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C17373BEE;
	Sun, 15 Mar 2026 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzAlJRqp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED8B1D61BC
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773598912; cv=pass; b=tkWqwcI91lm5q/tOs1+sY8BYxSIdq7zcU96e/Afteay/oGGrxhU5MRJgBIdojOkM9YFMiHtGMiw/+TeIs498OdNR0rsL+jbA+/+wh/Fhpaje1AoncNfqCbdIb9H51jFVIu0F6dQYJI4eZoUP2obcK47iiTBbIgce/qeo0P70MbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773598912; c=relaxed/simple;
	bh=jDWU6AdGhvC5Yx0E6kUWqqP+61uOz52l7eF/UILatEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkq7SEyiqkERp1ej9LHL0gBmpjkFcLwlSUGlxuGViQzZMsGWPb9qIZV6fNQz2R9IE8vT4q+wL0Cw70od/uN3bsi3GNQkVqAaAQDaOBTQHJR1WKfCdJup5oZgm96QTcpGTs7kWKEM5L8/mj25Eq782m22FaSuupWCLHaxe5Qjer8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzAlJRqp; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c0c4194b2bso12316eec.2
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 11:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773598910; cv=none;
        d=google.com; s=arc-20240605;
        b=GZehw79TxtqlgMQddWlnrNMuw+d9ljiUZcypIRK+LNcgUW3DSSERv3BMPHyy2+V4QL
         jxlKkSgLmfrv+GpNMKe0G8DPTD8ACkhvsxDPEQ8CfVXNlUG4ciJbzwzTW9w+InV0/RtY
         azj7sol9ET9umLGcs/1JW0PG2JSw+/iWFLWEmedKMcx6lWtrdVua92scp7onsWQyp6ei
         bcTDcerXTjK9TgnyesuqfdmltwFgYpguL//RVjZQpiAmNts3fil0u9N+sIDqdFRMbDqG
         MMcW78N+XqMKKBhIe/kmqAwHwj1LwNplZllFfVUurb1Zx0Q9ajDUxOVcArS3P1s8QWrb
         xhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jDWU6AdGhvC5Yx0E6kUWqqP+61uOz52l7eF/UILatEI=;
        fh=tClKMcqAHWRIAejG78fceZCke/KLUYKViRKWitkjRwc=;
        b=NUeWZSmSIWfRQNO/L4wMNqOGWHt5PBZ8pHV4bu5gQOlBsQlKIKt1nPt2A9wk591St7
         LxBgfCPpONOEZ+bWq9XGEiYVEmH9X04TQID176ZRpp/ckympLrlEE/tLrABAd8q/Bodc
         +5B1WyzC2LccYF/fgBy8tc2dmkVM81nvDPrYh8FD5ebANc8CKb/Vf3B7V3QH+nrZ3vu+
         TO3a88mvVRNp1HszVLRIibIbT10VLaHx6ffHAMJ45Ti18YSHpBDuraC8nl5RLLdd/Tfv
         qHr7i0UncEl9VrYwWEjm+iIuERt1s0INkfuMGtx/9iwjZ0WBcugsykOU2JdNwNb+JSdj
         q0+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773598910; x=1774203710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDWU6AdGhvC5Yx0E6kUWqqP+61uOz52l7eF/UILatEI=;
        b=HzAlJRqpf00I5iuQt5ArG5L+zYSPg/yyi6fxZTlxjCp8CMRwrePyDzCKJL+Mh7EWTn
         4IJglDFQ2a/LlW0rB1AT2104r0NadyvffSV9BwRcGBMC5X8zdcvieSw6xmPf1J2w19CT
         MiZMlT1z7h5XQ1mjNI/XDQ3MWb9++Auq54bv+AQf90hLD1mZlQTgnWhbO+pjApY/+N8o
         7FxCHbVJDUTvRLiTdSjS8PEkoERw2lAkJFP4qHcP8JRq19iBMPtUVSy2U5oTHJ3cVLDE
         4zGE3LJSoWMPICo7qW7d6FcrHBxrUtnFzvbbGNGdtQdEN/vPrGdifYVq3oEgGc4FF4kQ
         zoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773598910; x=1774203710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDWU6AdGhvC5Yx0E6kUWqqP+61uOz52l7eF/UILatEI=;
        b=eWmq7n0ST0cf/3213BpJJzfDkJHtqaQDGR/d3Nr0M863V3f4tGtTAJ6dN8jyQ+T46n
         MHOJprRTEAQ+4/cq5uNwE/trv5hUPkxcUnsNszd9dCVa5DLy73AL/z8RU2opNAvcLDsL
         bEWR0NPW5EH9eXP6Ul7jWqlp07v2rRd8M2bbvDs/LJDq0f8qqaVp8g/MJYVoyHbR75eM
         gHA0QwbtDMVGgWa95DsB1i0u1Qo7kLMYoyhZZS15Xv+v/++SJ7SzorRUTbSRTp9RmKJD
         f676saUAq2FhK2uH1MFbcO9vCnN9AAvngdhxu0SqsHitqkLBme6B0GI5uWKZYUayU+VZ
         FFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1K+hOL9RyXmvlWXQMmwn+9mwqb2yfnxp65lAMeu/YXt3FA9ega3gVVKquRW2Fqe9tzGUuzVTOJcosw0Y5rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqBxJMZv6jW3p+LvBrdZNIoqM7McK6u7QHju1fJadGjg4o8c/T
	kIM82kAp1FV5WL+s3B3fXCRno1L6LO03A0TYSgPUm9krX+NUN+JPdjWzF8nB3JtJm76CX4woUMw
	wY8slveiG+tRmkHIsnzUKTiVBihk2WYg=
X-Gm-Gg: ATEYQzz6H6ZSkmB2tZy+XSffs+OxiPB8cpSePJiEBFVBZ9tpYLK37LbY1wGB7tREgC3
	NLEe7YRQylSCIPMbSs1iPLODBfiXORttKPgpJVOWzFZvKrND10fIGCiKm/R97SPLYzkXS1EFgnG
	J5YcOvDdWCFx1beFzdubbdUwVKH/bPYsXVd3hRA7de7tPCOZcdqls1WOqNDxaudxSye9DSM7KZM
	2NElRmCHMXBAiOSLKTImOszyAt9OOLkWYXCpPx9txlzPBrlBwRJqJVTF3Aqd0lEL3ic2/Tzb4JN
	4Ggm7eCg7nRgxDOQCeq9F6kIpX8iOKAkSoDbM/CGyDeCYn/9nFP+0EOcNKudl2emRkBXMgSBpPi
	dUmBqMskbWjgtahj7VnVOMRc=
X-Received: by 2002:a05:7300:4313:b0:2c0:bcca:e9ae with SMTP id
 5a478bee46e88-2c0bccaed2cmr503104eec.7.1773598909944; Sun, 15 Mar 2026
 11:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
In-Reply-To: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Mar 2026 19:21:37 +0100
X-Gm-Features: AaiRm504huR_jEPQjv25PhnCGlqvxnPL_8XhiojOoKqXdkJjPbWUaTm98aG9g50
Message-ID: <CANiq72kdfYLmhojMo=vOAc5tULjjB9V4bM=iUmm5cLGpF-zj=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Optimization and alignment for MMC, Rust and iwlwifi
To: =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?= <adriangarciacasado42@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Boqun Feng <boqun@kernel.org>, 
	linux-mmc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33256-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2AEEF291E5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 6:27=E2=80=AFPM Adri=C3=A1n Garc=C3=ADa Casado
<adriangarciacasado42@gmail.com> wrote:
>
> These changes were previously submitted as a single monolithic patch
> but have now been split into logical, atomic commits as requested.
> The code style has been verified against checkpatch.pl.

Thanks for splitting it and fixing the diff, this is way better.

However, it seems you sent v2 three times. Was that intentional?

In addition, it seems the patches here are independent from each
other, right? Patches that go together in the same series are supposed
to be related in some way and/or they need to be applied together, so
I would suggest sending them separately.

Splitting them into separate patches also means you will have a
smaller list of maintainers to Cc, since here everyone is Cc'd for
things that are unrelated to them.

By the way, I would suggest using the `--base-commit` Git option when
generating the patches (optional, but useful) and also Cc'ing
reviewers as well since that will increase the chances people will see
your patches (you may want to use `scripts/get_maintainer.pl`).

I hope that helps!

Cheers,
Miguel

