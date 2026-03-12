Return-Path: <linux-wireless+bounces-33167-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNcQHXwvs2nYSwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33167-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:26:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1161A279FCE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B5E230244C5
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE9C3CF045;
	Thu, 12 Mar 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aygrlITm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCBD3CCA07
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350778; cv=none; b=LTZ+bhKOEezhzbwgqekq9DkOvQcNgObns84iXCu0sJunyFNMkvDn5JXqu9t9x8hzAyLln9PX1aUhdl3KSCLuuv7OzfY6fDLxuyojUNFznhl5k44//wYy1cJLq5EyT8iCYyTfquYgO7euur27O5Caygrxtnz7PGtJ49ebbDI7VF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350778; c=relaxed/simple;
	bh=xUIy2uhl/IeF+uPdsWFxsYihJk69H8YHKd1X31lYEjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCkbgJoQ3H+dwKgPxh8IJYFuA6CGtDWuzd/qcUY+FvGg3LiiWxkg6DHC1mimu2draRhPR1fQg9LsU6fa7vraFe02lBqu48Rl1fWpF9tslobdQKYGkg2kTjcnI70ocI+9YK50++uDuO7lVlLJReZXGrZyfL3Jz851Nq7GGQ2z314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aygrlITm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FE3C4CEF7
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 21:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773350777;
	bh=xUIy2uhl/IeF+uPdsWFxsYihJk69H8YHKd1X31lYEjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aygrlITmy+0CfjTkaeZyhkKWIlh46ch2mj0a5YscT6FChOI4QxpBu9V5V9TmckaQ1
	 jSVrOVs+R6sZ0wpIY95Qc6ekgy9K8LCJzXjtVejRFHZxUIiwEzy7T5yOZTqP2PyOGW
	 xuljs+k586qNObWBWTzQI6vicIeTDOiwW3DNyAiD29rpbnwghqMttdhPXGfRd5M9gH
	 3+T8t3U/VjVVnUM992/RTMKwRUAkzFt3cocnpUd0JyIJ7v75ykyTi1tK4+XYQHuWji
	 0zQS1b0s84QP05uJtRjDk3frK7+mdaEpZFPxz+4wAamhSyoTJa0fIBs18j2N7DJxTh
	 Ye862IayBICRA==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ad8435f46so1867798d50.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 14:26:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfI0NZe9T9Uflx8bPK+3Fs8+ECtISRqctMwJiEcgFvBoXHOHzMNXP9d0b62YdVeOAUpVOvWruZSmc1xZy+3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9GbN8iksrxuxU2ikm/Zba8L+xoGHS8ehZjM6NU4gNrcwd6+mO
	KU0IT1Ux56hu6A1EHSWhlW8/DVwOnWlw83UI/uW0J4G0r+aAa6Cn7/a5xcRUzk5x+EHoT+peBDf
	y8mIOOMWsVOnZ/YE2kbpiEi9PNYBUCpA=
X-Received: by 2002:a05:690c:6887:b0:799:3e:8278 with SMTP id
 00721157ae682-79a1c0f2c69mr11415657b3.14.1773350777323; Thu, 12 Mar 2026
 14:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312-descriptors-wireless-v3-1-5230e0870c31@kernel.org> <abLomhQ4faipjIQu@ashevche-desk.local>
In-Reply-To: <abLomhQ4faipjIQu@ashevche-desk.local>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Mar 2026 22:26:06 +0100
X-Gmail-Original-Message-ID: <CAD++jLmerNFyjGXAH9n9MKNAkcTSy3swg53=PARMqsXKjT7R3w@mail.gmail.com>
X-Gm-Features: AaiRm50EDgeFuEUrQ8RpUMKwV0piX5TbK97bjeb7k4hKWP2s5rBIDu-872uX9fU
Message-ID: <CAD++jLmerNFyjGXAH9n9MKNAkcTSy3swg53=PARMqsXKjT7R3w@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: ath9k: Obtain system GPIOS from descriptors
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alban Bedel <albeu@free.fr>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	=?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, 
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33167-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,free.fr,bgdev.pl,toke.dk,kempniu.pl,vger.kernel.org,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1161A279FCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andy,

(I'll obviously fix all the syntax issues for v4)

On Thu, Mar 12, 2026 at 5:24=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Have you considered using software nodes instead?

That's the big question. And also: have I considered adding device
tree bindings to map to those look-ups, that would provide a way for
new users of these devices to actually do the right thing. I thought of bot=
h!

The big problem is that we don't have a handle on the device
and it's name, because it comes from the device tree and
could be named anything. Same thing with the GPIO controller.

If we register lookups or software nodes in the GPIO driver we
don't have a reference to the ath9k device or its name, and if we
register it in the ath9k device, we don't have a handle on the
GPIO controller or its name.

All of these GPIOs "should have" had bindings and "should have"
been in the device tree, but they are not, and I think some of those
device trees are even outside of the Linux kernel so we can't really
fix them either :( it's a mess, I'm just stirring the mud to try and
make it a bit better by removing the global GPIO numbers.

Yours,
Linus Walleij

