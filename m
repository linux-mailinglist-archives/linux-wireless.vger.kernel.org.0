Return-Path: <linux-wireless+bounces-36749-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGUJAZrODmpoCQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36749-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:21:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5C05A237B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E581131C1787
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A953136A035;
	Thu, 21 May 2026 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5vof5ca"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB536998C
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353683; cv=pass; b=XtMMELQTPXsz/rDduFLCLyszOok9wCLlctdHnRDzV5fjbIKEi++IfpSj2cGDdx27Fdwcp5sm+QB90wYunN3eyNP1UsHMWHRlKtsZI7FOdch29gjo88IVOdmlNvtf4haN18BPqeT+LENsPXlDrUgnyy8UTdj3fNjRlU3GVpnhQ0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353683; c=relaxed/simple;
	bh=SBanORCkcQtSLwIZm1aOVDibtGKTc56WjhH7dLDseCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5+wAAtCUB89EVTim6bNm/mIM9hC/HabFSs2akXgbxVWNTqBFzHZ/cC8JEthVWyUbNFW8mm9H0zEH4jPT8W/AJ3k6O6AHD59eX8KfDP24UScOJvYHptEyttVba/l+0D2HwNpUJWT0V4IopxEvhuH1mhRzPgHc/mgAWhiXcMfGdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5vof5ca; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48fde648a71so41998565e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 01:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779353680; cv=none;
        d=google.com; s=arc-20240605;
        b=ZMEoUTp7PtuZcsHeFyz1dKJ5tQ8MTatB/vi2qQX6SlaT5lCOKghrm2aNqWup5yWdlF
         xlzUvxHacwImvkJN8e46Vv95TWYHcDYgi+XoI0Us/bo/7woOPEN1oloZy43L3D8jK4D2
         qX3HgjDCY5/HdGN4aM2fauYe9vIa0U3Ddj//U3mFI/YGKAY4iSPU8DGaVWvogPyGjY1o
         bef4jMlbtuZdxwghhbW6tTfR+0lhHI1bdq8IIahJZeduRO99Irw+7QtSP7VW9TNh6eLm
         jWtj7vz/mXS7UCMkNN8Zj3W+2bEynP9T+iD0FMs+2m7bysTUX368SHgcmkxve3mu1651
         BupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/uho/XOwJmzWn5t2mSNehnlFPvQky+SfYPZnzd22axc=;
        fh=n6rEljjcIGFGb7DCzP2HPy59u/j9D3RkEQmIu8lAtCQ=;
        b=bOTHaWh/yIjA1hhXlvbxF1rcscRKO3+dTPgV/H3EEzIpXGujLHFHGxno7JoDD4t+Ij
         H8ng73I66X34LPutRtK1a7c9M3EvyQ7gFomQ6kwt+2O+BpANwdW3qwl6a6kk0aMAu++H
         hPzQ6WjKBY3xlbaRoNKBJyzYJQksFwZvZYoXtx6kEzX2rITgvD1/LoDL6hVBodOpyIKq
         K29Cvs7CwuhTAcOvMdJ3gAJIMwv659n0oIap8KCNP6jFb0W/fb11IWsX76DuAVh4GFNv
         Qq9MVzkvCYojWo3cUdac9Jwu7ShKYNcoq1nQjCg473GSRcqG5pXOS5p2GMTkwuJeOBWe
         YIuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779353680; x=1779958480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uho/XOwJmzWn5t2mSNehnlFPvQky+SfYPZnzd22axc=;
        b=a5vof5caSI8ioQoSl0V1G3bpMUOgNvUdMUwmEensJ4sqRg34GsV7k+XhilXEAuCl2A
         YCewCDv9k0iLojFwwgbCzGberHC3xs68+3G19K790eFs1ZibhI/ufjSYN2zuAEso6tG0
         sV7exwEB4XL/KKVbvVf842SbV87SOPapCJi/rSsVqSZFrIn0sydWHYVfzE1K8OUGCCk9
         VSIdBqXg8OVX7P6F3DiksMafEwcsKnxG6rxcXghar01YsHhkEsbIOUIKtSQqaqfHk1l1
         CWNrb2sSP/VYoyDN2K5Nac6NsSUWfiewNEtVsAQgdpVfP42qhC3qFikKomNEeh8nHHGs
         S61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353680; x=1779958480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/uho/XOwJmzWn5t2mSNehnlFPvQky+SfYPZnzd22axc=;
        b=APZw7p2Ph5ZfQBYYRcKIdKcTsK4X31/nPkuSKpKNdvmT3HdMBNGXpwBBYwsODHGMXv
         6H9DfSTxyI+a4Ke9gbt2mzJURb411+rNfEwJyEJp+QbALfwM+Fjqqs2wMrlNN1KwKXoY
         f5w8fLhUlsYOAtropCQbjq/htBl8LuT42z2Dg2oFKcG1VWD8F2MA2Gp9kkJFx5mmg1cl
         ttMfwag+yhOrbGcaFNDZLpZd+CfCVQpiWkVZ3W181y+ssnpaphRohadpPButMrH6ral+
         6aTnTdvs0+ahGnAEoI/TbqwF5ogN5I7N5xgqfSr4tsohuStSzjisgtF/KhIN8BHG/N/6
         OyXg==
X-Gm-Message-State: AOJu0YwPJUBaTj9Sk+/6Nt1Sakr8CdSoRLNVP671dpcPgZgxrhMYrzoQ
	qcfE5pxe9crZn+xfz6GVMUQwxMB0GLCWSQegVR/P26JnSGfJSNFreE+PnvcvWLoxLMVhb9TSyzs
	KJajjwQfU7Ky3hXmvnY1DqjBpj/cOuIA=
X-Gm-Gg: Acq92OGvNVp6lHDBlqjxjGMmiHEaB1BnyfGJR6Fc0x7gRXh2n/VoeEWbgLHB+lTcw2n
	k21h6MIppgJNaYnmPXJ9CFv3iTl73u6ujP3CCxPZ8x6TC4G6ui94D2W6LdFJXh0/XsFVB36l/hY
	joYlIC9oYlrZlS8CeYfIIo5xeBdAtXq2OZtNZstEnp0n2JJoj8lNoL4HDDyrwgVbWynVgLdghUx
	YqtJdv9YWbupQCS/AO8nR3vUWbERkYgygrH4vg22pHt2JwohSRham/64L+6EuGMj3utj3V2SLQV
	axfE
X-Received: by 2002:a05:600d:8496:20b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-490360dc195mr13512365e9.15.1779353680367; Thu, 21 May 2026
 01:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515233839.86829-1-masashi.honma@gmail.com>
 <965eff7ec3b928f093f7891e4307ec4e4a080ac4.camel@sipsolutions.net>
 <d2c051127e384a918ff014da02e37e1e@realtek.com> <93ab81b4fb7130a4d4e1048581d886568086fe24.camel@sipsolutions.net>
 <7e1aac3afd714d448e5bfba4a9a113b0@realtek.com> <bf2081a986eccd28378b4019b2968c15e6659b7f.camel@sipsolutions.net>
 <9996dcdc12774caf835205040e18eaeb@realtek.com>
In-Reply-To: <9996dcdc12774caf835205040e18eaeb@realtek.com>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Thu, 21 May 2026 17:54:29 +0900
X-Gm-Features: AVHnY4Lwz1SYTjCGV_V1zHrFzKuRmYNIR6K_XwibZrKjBLBUcoSQxhrTZApwjqc
Message-ID: <CAFk-A4k83XQU2OfMndAH3RoyORQqOjmeUd6HkUWZbOCKHxw8rg@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] wifi: mac80211: Use struct instead of macro for
 PREQ frame
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Ping-Ke Shih <pkshih@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36749-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 4F5C05A237B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you so much. I fixed those.

2026=E5=B9=B45=E6=9C=8821=E6=97=A5(=E6=9C=A8) 16:53 Ping-Ke Shih <pkshih@re=
altek.com>:
>
> Johannes Berg <johannes@sipsolutions.net> wrote:
> > > In my tests with arm-gcc compiler, I did a special case:
> > >
> > > struct foo {
> > >       int a;
> > >       char b;
> > > } __packed;
> > >
> > > int bar(struct foo *foo)
> > > {
> > >       return foo->a;
> > > }
> > >
> > > It is obviously aligned (offset =3D 0), so I guessed arm-gcc can gene=
rate
> > > a single load instruction, but actually it doesn't (even with -O3).
> >
> > No, it cannot, because in addition it has to assume the pointer 'foo'
> > itself has no alignment. We use this a lot too, since a struct like you=
r
> > 'struct foo' could be in a frame element where we don't know what came
> > before it while parsing the elements, so we don't know that 'foo' has
> > any alignment.
> >
> > The reasons are related to what happens when you have a
> >
> >         struct foo array[N];
> >
> > I think, because then __packed means there's no padding at the end of
> > 'struct foo' either, and array[1] is a completely unaligned pointer.
> >
> > So no, the compiler couldn't assume alignment even for fields that look
> > aligned within 'struct foo'.
>
> I learned more. Super thank you. :)
>
> Ping-Ke
>

