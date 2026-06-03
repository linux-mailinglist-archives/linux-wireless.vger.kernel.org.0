Return-Path: <linux-wireless+bounces-37344-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oYKlAuAXIGrQvgAAu9opvQ
	(envelope-from <linux-wireless+bounces-37344-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 14:02:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA492637491
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 14:02:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OlYONL+F;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37344-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37344-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41E6531B6D67
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 11:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB5346AF25;
	Wed,  3 Jun 2026 11:54:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CCB46AECD
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 11:54:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487682; cv=pass; b=Fjp+P+zsvF0wx7cNE19Xvy9lIBP+UlhzZ/8CuWfSQwXPKVOY8GhYFelD0LR924oX/R+IDUmr9MeS+sSEaZZ0/dpMKzGeeEIW3QfzWt6AWQQO0x1B7rrs0QbHUnK5uTLM7DvsessuGFpsqbMi+h1h5LDMPjjcwq90umM2yLoWAM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487682; c=relaxed/simple;
	bh=9MwB7iW5DldI+Lzk2gEofI7+ml4Huc1WezoCmEGBwv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhajUiRgYBRhT3EziRG5zfaRyWiL8YbKWBnK+BgvlMC+pIVa+PtwK5Yw0gPOuSRmPhBf/CgeRo2xmXfhgS7hsurwRrPWGxlboEEZpiqhv5AFI7Sxd102nxsYaRgDbe6hGUm2AXOtrCAejYI+YIOeeV6JLdH/UPFpE9RowgLhgRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlYONL+F; arc=pass smtp.client-ip=209.85.167.173
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-485fc256028so463943b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2026 04:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780487680; cv=none;
        d=google.com; s=arc-20240605;
        b=WHoOqm54FTV0EDq66pL4EzwH9ZsLdvKaLrxdLW7cXTtAHdt9cBqsjAQUclxjyYcLsE
         hYiPg6s1Eg7NNglSsiIdMSbzE33GINYyCUSd+a9+zk79AzV0FPrq18kz4lB5h0cQFyFO
         Qc/DiWF2vLFY2oP6v5lHkrYJhpJwGmfQHtxF5jQrag0ht5Y1ClRE64jGpPMqlOrG2SS4
         Js7ucuqRz4QDD40RYh+ieXf9xoO0HE4ip2vyHKafwx7OQ5PO3871nunEh5b5TvLN8F1s
         w32XeBq8yoCXgpiCcDYwLeryFfwEgtAgopR+QD6vRFF9TOImeQaEyarE/eJNi+eJcg74
         SkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9MwB7iW5DldI+Lzk2gEofI7+ml4Huc1WezoCmEGBwv8=;
        fh=EO0DRxBNgqCWuHfxKudH7xUQNNnpgRVtuVUgKwFJnpg=;
        b=EvV59inPGqLjr1M2Kt4RTAXn4k1nXucHJKV33DNgUutFrcumymkk/vnYhp47jTiWyl
         N+ex1WJb03S36Ynv/zCHgtOT29qWIPb/TgceACN1qzvfkEDYdxqguEIeYHkSGh6BKeWU
         3/MUzq25Z9Q6YHhS9YwHRnAsDrx6YItfjO1QvL5lpDxXlRnPzrVvmsKL8T6lMP7QupuV
         fT/EHCFtbN60IyfwaO519TA772J7e3yFtNwVNETxv1DdVkXeVq6FMYjPdSNUOhDkFfI3
         BipovGr+K8pDQxa+726RxMoV5YIT8bUCe4GYXeEn3j3u8Vf2bfshIvy9YpfjEL4r5rrV
         /RoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780487680; x=1781092480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MwB7iW5DldI+Lzk2gEofI7+ml4Huc1WezoCmEGBwv8=;
        b=OlYONL+FfqXfXl6maYpHskABjAtWPkHnQe+F/X7rlyGeblWUfp/rXGvGkJ1kl7jCbs
         CW5TLcgeEKR1S/NlU+/CFFdtX6u5ZYphUVD8s0jjCyFhBG+qhqRxwjmtjXbbSxVXGYSh
         1cV+HHYhezTSLNN5LlTzZz7EMq3veBTdd9lsFSL8eK+BdcXJm4wpPWBQ/Z6Hp3fhAjWm
         UW5iniKDnf1Xl0xGjTu50RHZ3+uSx9z6htPQbgSeVTXERF6jzCopy4zH+ec6tyCP7xB8
         67WtpBmpOaC954Ou3FeN9u1Gah7YesvvnYtruVV3FNYp+YoqBolXfVfWRQICSU4jZjyV
         ftBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780487680; x=1781092480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MwB7iW5DldI+Lzk2gEofI7+ml4Huc1WezoCmEGBwv8=;
        b=KSW810f5JnQbknt0eyfRTR7OMt7VMEpK0BArRdbVHy51Lr5wUL63nPZxzOG0S8CcaF
         mBkzaU/Y2hfcRM1DzCe6Ayjn2Nme9IuvXNfYoP75+gJdlx8+htunG9Sy0nI1at3bO1CT
         qyhftknOGwI2ADZy8jUajQ0opL+NNSisDcnTEcyTPKs0A1351UbBi3EUAwBNT73ZrojJ
         FN+qF3uyKmiq9EwYHaIkG7IX/AaGRY1es2s0d09hUZOLSiSHJ3Kr/DSP0CkRH+5koGUX
         yHgs2v1ciBYUx5ABKgvjVd27l/Ej2+UK4mRRQpzdoU3Vuz0JtEh58sOCvEKkd503NoFB
         RlUw==
X-Forwarded-Encrypted: i=1; AFNElJ+h2QteyCoMUDFa0MOFnxKZpYbGrqeMwbvXeDeeEe3tKvNoqy7thZUywQp7g8X9lb5bA8DznkCkSkiukVOJwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjhrIbNrjVfhh9gSw7eiBxi+nsLS+YDJdTHTngHokcRMq9z9Ca
	nO+cUxxlYdyjKBj+7pDEIc/LSFA9uW9MaEHTep9sQkeOk7LIQ4/Mb3oy/V5VGSQGTZ+0eeFCuG6
	C46Aw6dPZUej+nzj0b1JU1RXRsuKqN+4=
X-Gm-Gg: Acq92OGx+PI51t2bRWsd81P3syXRjGetdZrPYz1xXy+ciQwPyPP0G3qhGR6r4G4Xbwu
	hDJh6pq2+gMm570driZTDXdCxm7vBMrGTn8YZ5T1g/hbzmzh2xUpdNoThTt247mIj+eMnhfFT42
	fWn6gBdK8t38grRwmpKPzhDN5J9M2fgqDULEFZpv5jvB2NWYPof4oHElO+7I9oU5Rq9vA/HoFAL
	y461HwiJCZjFu8knW2cAiI5jqddPUHIwjL6Tzbp7EGWzk8tOJp/3DWMYVQWAcFk7GVHos0HsQsG
	RVrJRnb9H3RAy5j2Fp0=
X-Received: by 2002:a05:6808:1a19:b0:485:724c:36fa with SMTP id
 5614622812f47-4865aaf57c7mr1333684b6e.0.1780487679996; Wed, 03 Jun 2026
 04:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
 <20260519235713.49109-1-lucid_duck@justthetip.ca> <20260519235713.49109-2-lucid_duck@justthetip.ca>
 <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com>
 <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
 <CA+bbHrV3fFHWevyDGPtAS=2M2mc+LxP6=xA-5fXaiTKTD=R31g@mail.gmail.com>
 <739ba20fa3c88e92bf034d80383015b8bc78ebfe.camel@sipsolutions.net>
 <CA+bbHrUqh+nu_eKBMVaPH6Q8YxuKS=S0kON2Zsb+gRZHU=SBPA@mail.gmail.com>
 <e73634b3b52d9ebe6c4e339ea5f6c35cb6d433a7.camel@sipsolutions.net>
 <CA+bbHrXtEdHEDHDb+8KNaKu=ODvkYwjiEEOtU2HntSRb8-WZ5g@mail.gmail.com> <CA+bbHrVbDBwmQnDyEa-Mw1yH8vMSEQa0ZP5CyL+8oaT2rpqpOg@mail.gmail.com>
In-Reply-To: <CA+bbHrVbDBwmQnDyEa-Mw1yH8vMSEQa0ZP5CyL+8oaT2rpqpOg@mail.gmail.com>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Wed, 3 Jun 2026 13:54:29 +0200
X-Gm-Features: AVHnY4K3utIg3I6x4sZDLnt_FWV_RmlMsSVk-e9XyJxjPW7_VKnU5hzaspwrUxM
Message-ID: <CA+bbHrUqv=4y7OUQuaheLuoBjp9hnaxw_8WwFOY0o8J4xm-K0Q@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, fjhhz1997@gmail.com, 
	Brite <brite.airgeddon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37344-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lucid_duck@justthetip.ca,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:fjhhz1997@gmail.com,m:brite.airgeddon@gmail.com,m:briteairgeddon@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[oscaralfonsodiaz@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[justthetip.ca,vger.kernel.org,nbd.name,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RSPAMD_EMAILBL_FAIL(0.00)[johannes.sipsolutions.net:query timed out];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sipsolutions.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA492637491

Hi, after my yesterday's email with the tests results. As you can see,
all the cases are working but the 5ghz+VIF+DoS. Will this patch be
added anyway while looking for a fix for this specific case? if so,
from what kernel version will it be available? 7.0 I guess, just to
confirm and update airgeddon wiki-docs.

Thanks and Regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El mar, 2 jun 2026 a las 10:29, =C3=93scar Alfonso D=C3=ADaz
(<oscar.alfonso.diaz@gmail.com>) escribi=C3=B3:
>
> Hello, sorry for the delay, but here are the tests that were carried out:
>
> -Compiled kernel 7.0.11 using the suggested patch:
> https://patchwork.kernel.org/project/linux-wireless/patch/20260519235713.=
49109-2-lucid_duck@justthetip.ca/
>
> *Tests with Ralink RT3572:
> Standard DoS 2.4ghz -> working
> VIF DoS 2.4ghz -> working
> Standard DoS 5ghz -> working
> VIF DoS 5ghz -> working
>
> *Tests with MediaTek MT7921U:
> Standard DoS 2.4ghz -> working
> VIF DoS 2.4ghz -> working
> Standard DoS 5ghz -> working
> VIF DoS 5ghz -> not working (no freeze or error)
>
> -Compiled kernel 7.1-rc6 using same patch:
> https://patchwork.kernel.org/project/linux-wireless/patch/20260519235713.=
49109-2-lucid_duck@justthetip.ca/
>
> *Tests with Ralink RT3572:
> Standard DoS 2.4ghz -> working
> VIF DoS 2.4ghz -> working
> Standard DoS 5ghz -> working
> VIF DoS 5ghz -> working
>
> *Tests with MediaTek MT7921U:
> Standard DoS 2.4ghz -> working
> VIF DoS 2.4ghz -> working
> Standard DoS 5ghz -> working
> VIF DoS 5ghz -> not working (no freeze or error)
>
> So exactly the same behavior on both kernels.
>
> Hope it helps. Thanks and regards.
> --
> Oscar
>
> OpenPGP Key: DA9C60E9 ||
> https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
> 4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
> --
> El mi=C3=A9, 20 may 2026 a las 11:55, =C3=93scar Alfonso D=C3=ADaz
> (<oscar.alfonso.diaz@gmail.com>) escribi=C3=B3:
> >
> > Ok, I'll do the testing using this one you suggested:
> > https://patchwork.kernel.org/project/linux-wireless/patch/2026051923571=
3.49109-2-lucid_duck@justthetip.ca/
> >
> > Thanks.
> > --
> > Oscar
> >
> > OpenPGP Key: DA9C60E9 ||
> > https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
> > 4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
> > --
> >
> > El mi=C3=A9, 20 may 2026 a las 11:53, Johannes Berg
> > (<johannes@sipsolutions.net>) escribi=C3=B3:
> > >
> > > On Wed, 2026-05-20 at 11:51 +0200, =C3=93scar Alfonso D=C3=ADaz wrote=
:
> > > > Ok, let me do one final test using Johannes=E2=80=99 v2 patch. The =
expected
> > > > behavior is as follows:
> > > >
> > > > 6.18 or lower: no need to test, it will not work. It=E2=80=99s clea=
r now that
> > > > this does not matter, since the goal is only to fix newer kernel
> > > > versions.
> > > >
> > > > 6.19: some versions of the 6.19 will crash and others will not. The
> > > > crash was fixed at some point between 6.18.12 and 6.19.12. No need =
to
> > > > test.
> > > >
> > > > 7.0, or 7.1: the expected result is that there will be no crash, an=
d
> > > > VIF + deauth will work only on 2.4 GHz. It will not work on 5 GHz
> > > > (I'll test both, normal DoS and VIF+DoS). There should be no crash,
> > > > but it will not work.
> > > >
> > > > So I'll focus my testing on 7.0 and 7.1 and I'll get back to you wi=
th
> > > > the results. I'll be testing this patch (v2):
> > > > https://patchwork.kernel.org/project/linux-wireless/patch/202512161=
11909.25076-2-johannes@sipsolutions.net/
> > > >
> > >
> > > Thanks. For testing that one you'd have to revert the other first, I
> > > think, you could also just test this one:
> > >
> > > https://patchwork.kernel.org/project/linux-wireless/patch/20260519235=
713.49109-2-lucid_duck@justthetip.ca/
> > >
> > > But I think they're basically all equivalent.
> > >
> > > Since we eventually need a patch to apply w/o reverting, Devin's is
> > > probably better than my old one.
> > >
> > > johannes

