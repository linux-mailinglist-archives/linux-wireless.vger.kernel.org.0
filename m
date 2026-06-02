Return-Path: <linux-wireless+bounces-37296-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNEIE36XHmoAlQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37296-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 10:42:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B4362AC31
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 10:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 444FD3068F1F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9381E3C1418;
	Tue,  2 Jun 2026 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxO/07g5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16673C4576
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389005; cv=pass; b=BFR5C7D1Pqm+KHH+BqevWOXxn4FX0aO6TjALwmiVZ5QQ7VeJCp/1O0I6EKFvh6Do+Uk4a8aO/yMEDVrw6Ot+lN92ouoPdkpptU6SMop5F8bOWKisNlVUESpR3sKH+DshqRXiPCaxOxS4t2IN6N1cKl5UL6jiHdF0qXqirjUkbys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389005; c=relaxed/simple;
	bh=6SQlnHR5t0pbOUkzAXG5VRT9/Vc0Pf5j6VE73rnaPpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0xFr0nDdefcLSQZOcwgT5eiEXZV7FXjTrcwTyzeIhEYkd8Z15wIoaq1x237OVk871hNCKECjiEnSgGaS+Y6LFwuTe9F8PwifpkWemhYREyibsblvSiOZCbGblXJVL1arA5okkrMNZmK5w1s1/uSS26hjFy3+IfBOZp6VaniL7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxO/07g5; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6b5c374e5so2073570a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 01:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780389000; cv=none;
        d=google.com; s=arc-20240605;
        b=bqme6c0zmnSWu1XjstTTn7afZfQtl1S9GhUnTRcZDKi5aoJW/XhukX0qRCMxtg7nkm
         EUzIYpiS4S23JmLnin0bKGJwGP6K2RNLsHFxDrwGmRcqe0E+JpebVk/H97zwIrdoB46K
         1FY+YJZZGvoU5ZxkfQ++HYDdlR5rHH363UQLJyrmUO60JgtgppQd9H0eoyewYcI4RS4R
         OpGiBlYN+OZwVjMpKbQb2/FLFNubUUIg+FRgoUvr6gDfLTR48NRc0FZZwnlOmFFpe4td
         X5SpnnU565CWGOoVd5ZXoDvbUCaoKSpQbVLe98afhQ3I9Mutw3ahNHYy4h/Qwt1CXKcq
         9pqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6SQlnHR5t0pbOUkzAXG5VRT9/Vc0Pf5j6VE73rnaPpc=;
        fh=tESdKM2vRVpi3XVBHG9VB0Tnd9oTZKb6KrbSRezsf5c=;
        b=MhGKGYifd/TgIVdpNm6/52QryW6NhwrlGt2fL2W31iDdXZueNjEcUwvx3emkyT9Eay
         YhKieyZnDEHxxJQRjqaq7p4IFEU9e5Pe8OmRV/wV/0DHW9vvbx+wCLfUla7wJQgJmzV2
         Hy0JqY/h0j0tuIZQeOOECicQ6KncEEYAaOkosaF9FgSnc6M5AY+vysH8n6q+L0nAEHxn
         4wXlc+ezkBaqZyjeuVEjw7u3vsWE1mDowkra2XcwHa/1MfeyJlT6aRcBIRaNqUgrUiJC
         vZdgbCYZnY+PLaZIOKGrxsxSeNoH27Z1T8hl/0G662jlyswYPVcXvMrfJ9M1JSPQwtk9
         sEug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780389000; x=1780993800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SQlnHR5t0pbOUkzAXG5VRT9/Vc0Pf5j6VE73rnaPpc=;
        b=dxO/07g5TxblayyN+aRUcSPz7xFjn5hcFFXPtIZTYwX49JzIUm08qA7v80KvbsBsVk
         hEcvnir1d9TuWjJ9R24b7WdO8UkxC/8QESpGJRipfbx5Hg2cYH9iAiXqUcikjeLTYV17
         34uPP5v+eYZkfEzb/1vegBlIUI5cBCqkHN8iGg1LFk5OgpTrFVOwk1wCSe3I/nHHqToC
         7VzVyyrlQaLXWo/Zz1+pRkTyxt2mQBCb4fCIF1E0sZsxxtWvNlWcFrMIxaZOYJkn3gSN
         6kPFXf98l/Q5F8/WFGq3Dr1UbBPsl1Z+eK/C/ZJbpGNah7kzk6fgYTqd4cEG8ZidPYnp
         bc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780389000; x=1780993800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6SQlnHR5t0pbOUkzAXG5VRT9/Vc0Pf5j6VE73rnaPpc=;
        b=d7IFwp5vm5gFRfyibeDjpqpPN+cORO+vW7XBmlpD7cUbedypnWncst2eHdp5qxsUmd
         BO/AyEz/5qEon6mwqUCeLpEiHpK7/K5pq7xHCJI7/6U6vg7mb97oxn0fkRQ/jsinoaRM
         5AbKf8JMIPPEGSAta6LTXYIwCMSAafUSLU93g7c76k0nfcE4tOK5QwMSek0+avVzIKPC
         anhkeORmcv7I4BDuzfu/BSQMflYkLCd9F5Z68U9cZ+KJ3TYiYhkQ8pISiAm+5QQ4bWfZ
         4nyARctWxkZISam0q1losBU38lbQUwFWgFlloaGEVphCoos7U3fxyApdk9x4tjkZeZX+
         +/WQ==
X-Forwarded-Encrypted: i=1; AFNElJ83ioh0nzEHPe8Jw6nZy2lPQQKidbE+TbLpCY6R3KG/x644oV7zHrpLL+WuFbB1xiOMKlsabwZhPkurwcf/8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxwK+6Odh5pd/sHwvNmWjMoQIka/aaCOPxe/SglPrM8JvCsx9k
	A8d3dXdxcKdyRbNLqs5x9oNIrEI9MP2x/KMO8TNeeEVW1PxQ8mDXLI/8ZVcRa0tJELDsuanOEiB
	XEb0cWo2J2G/KLpHrmLbhN+tIIxuSqBw=
X-Gm-Gg: Acq92OGSv2eGeaRcFLHaWALZ2VxYYwSHJatuJQQNDrdJ8EaWdEZTj57EB5kMp1nGQqk
	scHBAAMAxIHv8L3j/vqB1w8klya0kqhoupupHnk4Dka8WbW6vdAnzMRAScbWoSRtbJaTqoYx8WX
	5yT1gGFinBkoxIsi5wfAk9r3k61iklA6kRfnRLxOCzBWq1s9LBlMSiZff3A8M3nN9+/mLos4xsV
	PXWCwx+O7d/jRzW7fwC64MjlBtuQtDVMWDuXY7hlD8E43FWRuPr9V9d70wz3BC3SG4qiQvbXiSk
	2jjMD3Ay1vK6oBX0w+olxri9zu6ysg==
X-Received: by 2002:a05:6830:6ed2:b0:7de:c870:46d4 with SMTP id
 46e09a7af769-7e6d21a2e4fmr1341740a34.1.1780389000536; Tue, 02 Jun 2026
 01:30:00 -0700 (PDT)
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
 <e73634b3b52d9ebe6c4e339ea5f6c35cb6d433a7.camel@sipsolutions.net> <CA+bbHrXtEdHEDHDb+8KNaKu=ODvkYwjiEEOtU2HntSRb8-WZ5g@mail.gmail.com>
In-Reply-To: <CA+bbHrXtEdHEDHDb+8KNaKu=ODvkYwjiEEOtU2HntSRb8-WZ5g@mail.gmail.com>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Tue, 2 Jun 2026 10:29:50 +0200
X-Gm-Features: AVHnY4KxO6mfQCrNzOiYYtrulc1IFovrcdX_UxK3eb-GAlxd_LDaTO4kf4jBHCs
Message-ID: <CA+bbHrVbDBwmQnDyEa-Mw1yH8vMSEQa0ZP5CyL+8oaT2rpqpOg@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, fjhhz1997@gmail.com, 
	Brite <brite.airgeddon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37296-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[justthetip.ca,vger.kernel.org,nbd.name,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sipsolutions.net:email]
X-Rspamd-Queue-Id: 54B4362AC31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello, sorry for the delay, but here are the tests that were carried out:

-Compiled kernel 7.0.11 using the suggested patch:
https://patchwork.kernel.org/project/linux-wireless/patch/20260519235713.49=
109-2-lucid_duck@justthetip.ca/

*Tests with Ralink RT3572:
Standard DoS 2.4ghz -> working
VIF DoS 2.4ghz -> working
Standard DoS 5ghz -> working
VIF DoS 5ghz -> working

*Tests with MediaTek MT7921U:
Standard DoS 2.4ghz -> working
VIF DoS 2.4ghz -> working
Standard DoS 5ghz -> working
VIF DoS 5ghz -> not working (no freeze or error)

-Compiled kernel 7.1-rc6 using same patch:
https://patchwork.kernel.org/project/linux-wireless/patch/20260519235713.49=
109-2-lucid_duck@justthetip.ca/

*Tests with Ralink RT3572:
Standard DoS 2.4ghz -> working
VIF DoS 2.4ghz -> working
Standard DoS 5ghz -> working
VIF DoS 5ghz -> working

*Tests with MediaTek MT7921U:
Standard DoS 2.4ghz -> working
VIF DoS 2.4ghz -> working
Standard DoS 5ghz -> working
VIF DoS 5ghz -> not working (no freeze or error)

So exactly the same behavior on both kernels.

Hope it helps. Thanks and regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--
El mi=C3=A9, 20 may 2026 a las 11:55, =C3=93scar Alfonso D=C3=ADaz
(<oscar.alfonso.diaz@gmail.com>) escribi=C3=B3:
>
> Ok, I'll do the testing using this one you suggested:
> https://patchwork.kernel.org/project/linux-wireless/patch/20260519235713.=
49109-2-lucid_duck@justthetip.ca/
>
> Thanks.
> --
> Oscar
>
> OpenPGP Key: DA9C60E9 ||
> https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
> 4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
> --
>
> El mi=C3=A9, 20 may 2026 a las 11:53, Johannes Berg
> (<johannes@sipsolutions.net>) escribi=C3=B3:
> >
> > On Wed, 2026-05-20 at 11:51 +0200, =C3=93scar Alfonso D=C3=ADaz wrote:
> > > Ok, let me do one final test using Johannes=E2=80=99 v2 patch. The ex=
pected
> > > behavior is as follows:
> > >
> > > 6.18 or lower: no need to test, it will not work. It=E2=80=99s clear =
now that
> > > this does not matter, since the goal is only to fix newer kernel
> > > versions.
> > >
> > > 6.19: some versions of the 6.19 will crash and others will not. The
> > > crash was fixed at some point between 6.18.12 and 6.19.12. No need to
> > > test.
> > >
> > > 7.0, or 7.1: the expected result is that there will be no crash, and
> > > VIF + deauth will work only on 2.4 GHz. It will not work on 5 GHz
> > > (I'll test both, normal DoS and VIF+DoS). There should be no crash,
> > > but it will not work.
> > >
> > > So I'll focus my testing on 7.0 and 7.1 and I'll get back to you with
> > > the results. I'll be testing this patch (v2):
> > > https://patchwork.kernel.org/project/linux-wireless/patch/20251216111=
909.25076-2-johannes@sipsolutions.net/
> > >
> >
> > Thanks. For testing that one you'd have to revert the other first, I
> > think, you could also just test this one:
> >
> > https://patchwork.kernel.org/project/linux-wireless/patch/2026051923571=
3.49109-2-lucid_duck@justthetip.ca/
> >
> > But I think they're basically all equivalent.
> >
> > Since we eventually need a patch to apply w/o reverting, Devin's is
> > probably better than my old one.
> >
> > johannes

