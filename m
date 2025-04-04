Return-Path: <linux-wireless+bounces-21156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 418E8A7B805
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Apr 2025 08:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5733B58E9
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Apr 2025 06:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844917BB35;
	Fri,  4 Apr 2025 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOWoYcIG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A4944E
	for <linux-wireless@vger.kernel.org>; Fri,  4 Apr 2025 06:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743749753; cv=none; b=W7lR1emm/Je2aLhV7vIIARaaXXnTMRoLGDcW9ogUHZFNeWOfdnZKlYRLRBxWDZN30fFnmSaa862XAPc2BnRLwItp2g7sl0wngR7WHQpLjciPxdWLxFlCIw9sck7hpqB/S8eaUd+dXNYR+UjgD76iyVvAfsc2VAA1RHO65YIS+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743749753; c=relaxed/simple;
	bh=OJi8BO7isFkrab5eQWUCSNyy8OYQFfR+EnDP6/NiRik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgs1mwYAD79f4Z445EGKCyrWi8JgJ1eYiItfRj9RWoT1XR627HxMweKXow9psSkMrMjNi65gtzoeXpaJgRzFWyjJ9zwkVbzc/kzINw4ZA/WR42p44gPR7FwAwO5DFwHfWEixwurw89Eu+XpZpXaU8eVbHzccxiiM0LVhD4FJO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOWoYcIG; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7023843e467so17106437b3.2
        for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 23:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743749751; x=1744354551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaJ37qt+qE8K+0Grqd/otrxBaBZH3JDmlHmDcAaWvqE=;
        b=NOWoYcIGitWJinxNdLs1jyzCzxGndlg/arj5/Aww/JX+jpo2VA9FaC3j6sSRsHB7nd
         Pf+mOYkdcHHwqVMFzvKCK+fhZOqkCpN+/0U3mVvZhpISVuwsAA7PoPkAZgOEKIdUo7bE
         E/YlA3NXH+qPf585sUaBhBDbInHeY3kZChPXaPmxjSC6IGvtQjMGucsCUMzzIs9zZDtN
         Sen9fUfoQKah+0XLKAYEbJ4IeiyDrqt+nbyp5fafFaHd9jpI6NfUdxkPM5Sr36hh7qNl
         dLh1xbO+KPXBwd+/1n7HlpSCfs0+9KeOKJ8BKZuVl2m7IcL0hFHqymyFmlFi+2fhCE8U
         15KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743749751; x=1744354551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaJ37qt+qE8K+0Grqd/otrxBaBZH3JDmlHmDcAaWvqE=;
        b=HlPYsi2uOmZxW0zCt3PkCjyoRn76WFamrV7ckVKmnyummKTBB2UlUbFvm85cMBQmQx
         R2L/J7RQpwbFoOH3VL9Olj6NQMH4Aj3ejtWyU/bp8qnoIwDJ7/PWUTWDwCAxWAilnblq
         kJOFiDxWTV4FbS2n2i9e3QLUSBnPgt7H+1ivjre+u15aOp3q3beDHEuHOSeb1eO3tVhJ
         USHf/F6CmYv0UMXOlUyMaaRZp1aNK9giKf7smJxgmsqmMuOk+/qg5ldxXxWJjej0Jydt
         4VeSDqggEzG9gSCNITDC4otVt3/qc3JJdpTuCtmJQ/trX+fP+QF/vlC2uvkzso9/VxAR
         TOPQ==
X-Gm-Message-State: AOJu0YyyY7kxDl9RgmOu4RNi8MdPBAzLe9O0fpmbcibtFnSJYLaIv87B
	D//EjVoaMHrKV5Nji2P6xP972POPG8Db3VOXL8ZCoxFpTi6kxHoxOMuxmMlnQB/nN4LAbIsCodr
	/a/Xro09LH2AuSIllLkb2/trb4B4=
X-Gm-Gg: ASbGncsuwBR81u84xrg/5wHZtLekOuX36fWzWGiUx68bLl8unxP2j06Psg6Ot5h0gTo
	6w9zvvYu527nBB8Jx9iLdNBwYMLU22+DaKqat6exiqc7pEHIQvJxJhYGVLY6u91rxxgIPLDu0/G
	YpDb4Ysc7lzW2ZSTMa+DuhDUEW
X-Google-Smtp-Source: AGHT+IE3W875spr49H979Z64WVYeZqqK/kdle2rxGJWAGysQwXrHT5Whba/glqDHzKCLFo4OSxNU2IKiS5XgFHqgtTk=
X-Received: by 2002:a05:6902:2846:b0:e63:efca:6692 with SMTP id
 3f1490d57ef6-e6e1c25efeemr4137498276.6.1743749750697; Thu, 03 Apr 2025
 23:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5906467.e9J7NaK4W3@nessa>
In-Reply-To: <5906467.e9J7NaK4W3@nessa>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Fri, 4 Apr 2025 08:55:39 +0200
X-Gm-Features: AQ5f1JqIwHsP1WpyS-y8F3up58_DkZBUTiPJF1QFywJcMYNE0YacIpEm_Qndy6c
Message-ID: <CAOiHx=nxq-uc0LFoN8vxsUz_Rs+ZKNJV1gegm8fi4R8O11Azgg@mail.gmail.com>
Subject: Re: b43: Putting out feelers on adding support for BCM4360
To: Helga K <Strike0347@proton.me>
Cc: linux-wireless@vger.kernel.org, b43-dev <b43-dev@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Helga,

there is a b43-dev ML that may be more on topic, so I added it to CC:

On Sun, Mar 23, 2025 at 11:21=E2=80=AFAM Helga K <Strike0347@proton.me> wro=
te:
>
> Hi,
>
> I'm a C dev that works in network hardware testing and bringup.
> I'm extremely tired of the myriad issues of the broadcom-wl driver, and I=
'd like to add
> support for the BCM4360 card to b43 instead. The last few times this card=
 was mentioned
> by developers were:
>
> * Arend van Spriel in 2015 saying support would be unlikely because Broad=
com didn't
>   clear it and because it'd require adding VHT support to brcmsmac (that =
hasn't changed in
>   10 years - brcmsmac still doesn't support VHT+ hardware)
> * b43 developers adding a stub saying its PHY wasn't supported (but could=
 be in the future)
>
> AFAIK support for this card in b43 is feasible - it's only AC PHY operati=
ons that are missing.
>
> My questions are:
>
> * Is it possible to merge new functionality into the driver given its orp=
haned state? I'm
>   not capable of taking over maintaining b43.

Technically it would be possible, the issue would be finding someone
capable of (properly) reviewing and/or testing the code changes.

You may be able to lift some parts from brcmsmac, but the appropriate
handling for the 11AC core and PHY will need to come from somewhere
else. You will also need to add support for BCM2069 radio, which isn't
in b43 yet either, as the appropriate AC tables are also missing.

And there are likely checks missing in the common code for the AC PHY.
So you may find out that it is more work than expected. Not to
discourage you, just to make you aware of what else is missing.

> * Is anyone in the community broadly familiar with reverse-engineering Br=
oadcom hardware
>   and can bring me up to speed with the state of the art?

For b43 and its reverse engineering support there was a wiki [1],
though I don't know how far the effort went. Additionally, you may
find code fragments and part of the code in the original commit for
brcmsmac [2] before it was cleaned up.

Be aware that you will still be limited to 11g/a with b43. There is no
11n support in b43 yet, so no 11n rates, no 40 MHz, no aggregation, no
MIMO, even though 11n capable cores are supported.

If you are daring, you can try lifting the 11n support from brcmsmac
and port it to b43, but you will probably need a supported card for
that for testing before attempting to make it work for 11ac cores.

Best regards,
Jonas

[1] https://bcm-v4.sipsolutions.net/
[2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Da9533e7ea3c410fed2f4cd8b3e1e213e48529b75

>
> Thanks in advance,
> Helga

