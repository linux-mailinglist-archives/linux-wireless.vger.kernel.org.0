Return-Path: <linux-wireless+bounces-19795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7FA4F959
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 09:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240C316A9C9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD05E1FECB8;
	Wed,  5 Mar 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FElOg0IH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92051FECB6
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165126; cv=none; b=ObFFRSEyR+O0f+BUDhya7pIVKcabT4p9nKbSr247dzOYFa/Uv2pT7Dq8u/81nG1ZZ6sxVitpKP8MVL5YnPbpy8s+2i9u3K7r0uS7GIIKidQGvtDvj196CwUfOwZUMgG80ZXpj5M+ysOKPhqfaNmBEMFik14pdrLiKGj/+kPeoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165126; c=relaxed/simple;
	bh=uczDGu4fwFp1bR2PxvIV2mVpk5KS9XI0kYiuclCsriI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2C9JN7tzyL77VUq2t/hHwzvl7fsqfcxKTfl3OWTqdUcXGUh1sj9bqNzvh0mvRNoAK2+deY3wbMZGVVdRV4EEw3vCfp7tEB1UyF3zDcG4sKxiczB0jg/3MSFgxql57Gvpk+juMN0BZVmuJKyAMObGKdG8cb988VFeKuzRPQiYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FElOg0IH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B615C4CEE2
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 08:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741165126;
	bh=uczDGu4fwFp1bR2PxvIV2mVpk5KS9XI0kYiuclCsriI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=FElOg0IHxNUaGHqDkJ69a83vuG9rjvVoJKvRdJdTGMaE/Oh0wg3gwT2HF4r6wNaKJ
	 VAQXCNC49+uZ3Z4LqoxAO0LdwpFU+mXgxHPxucI1ZKIEhNoqm8L3S/fGwsnQXgeHpp
	 42g3JU3P62n+tnLJ5afUXfvRYyy9WmuohV3lwLdBH06X/xwTFt/RxwysS8cerVIheg
	 oYsaEJtDATCPmWM9ixXqMCaONCavrEVZdiKclKK+FdOOwns9VmQwFM64RwP9jer7Yb
	 pZQH2ClAt9DUfQKbVHWNMvG+mvb7yg/xqScf+FXFG459k2cZ8x8eBuQK3FKNcDeaut
	 B547HFnRfUGng==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30ba92c846eso38637331fa.3
        for <linux-wireless@vger.kernel.org>; Wed, 05 Mar 2025 00:58:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5P0ZphrMrcUcsVfmNPcwX7YURfLHch5JdnkjCW+tSVDa4nGkHgWxWuul6ocola7ZlvJfwreVGVXIlB96XRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OZ1TfAezAY9YbcyakFH67uZZIvNT/Vt+AjKZ8qWPzG5KgL44
	36+UnqHQ9SMpTezqK3lyqRfBfKgeTU3NUM2Q3iKe1bnb4jzv1jIRTaR2nNRYznblwow5Qfx/6GB
	ta0b+HCU2SUhugLEl1jsdfn9KTpM=
X-Google-Smtp-Source: AGHT+IFgZbXpzH2QH+9ZXXRY2RfewTKeJVJBqLZP4EdcyaC6AlRjixk9HvegZ5fsi2Vz3IVaqebN3hmQDnyJnDUu6Ig=
X-Received: by 2002:a2e:a7ca:0:b0:30b:c3ce:ea38 with SMTP id
 38308e7fff4ca-30bd78a4207mr9717131fa.0.1741165124324; Wed, 05 Mar 2025
 00:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com> <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com>
 <ff6ad414457e4b1cb68e834978a553c3@realtek.com> <CAPRryQobXZe5OwR=F-X0KHYyfBwUpFsi=Y5pKnENcUXTN42xAA@mail.gmail.com>
 <002d01db8da7$daf2ed50$90d8c7f0$@gmail.com>
In-Reply-To: <002d01db8da7$daf2ed50$90d8c7f0$@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 5 Mar 2025 16:58:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Y+rTsuKfQDgv-qwRTOorOucM+qfBOia-gY5sPCJp5qQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqC29nXRDZQKM08wtkLMj9xnsEWRwwdF7T8fCXPdjN_4eiUly0ZNNINacE
Message-ID: <CAGb2v66Y+rTsuKfQDgv-qwRTOorOucM+qfBOia-gY5sPCJp5qQ@mail.gmail.com>
Subject: Re: wireless-regdb: Allow 6ghz in the US
To: rmandrad@gmail.com
Cc: Dennis Bland <dennis@dbperformance.com>, Ping-Ke Shih <pkshih@realtek.com>, 
	linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 4:23=E2=80=AFPM <rmandrad@gmail.com> wrote:
>
> That is not specifying NO-IR which basically is denying any 6Ghz in the U=
S what it means in my opinion is
>
>
>
> Client devices (like phones, tablets, laptops) need to find Wi-Fi network=
s before they can join them.
>
> One-way devices do this is by sending out probe requests. These are littl=
e "Are you there?" signals that ask nearby access points (routers) to respo=
nd, so the device knows which networks are available.

Section 122 says: The Commission therefore only permits a client
device to send a probe request to an access point after it has
detected a transmission from the access point. The client device
will be required to send the probe request on the same frequency
as the access point's transmission.

I think this translates to "passive scanning only", which is what
NO_IR is meant to specify. NO-IR was previously called PASSIVE-SCAN,
and was renamed when it was merged with NO-IBSS.

Maybe the kernel's implementation needs work? I'm not a WiFi person so
I really don't know all the details.

> That is why drivers use the non 6Ghz for allowing clients to identify the=
 router has 6ghz capabilities=E2=80=A6 I don=E2=80=99t think is for wireles=
s-regdb to take over the HW router compliance and certification which is  w=
hat 122.  is about

No, section 122 is definitely about client devices, which is what Linux
devices are.


Thanks
ChenYu

> From: Dennis Bland <dennis@dbperformance.com>
> Sent: 05 March 2025 05:49
> To: Ping-Ke Shih <pkshih@realtek.com>; wens@kernel.org
> Cc: rmandrad@gmail.com; linux-wireless@vger.kernel.org; wireless-regdb@li=
sts.infradead.org
> Subject: Re: wireless-regdb: Allow 6ghz in the US
>
>
>
> Hi everyone:
>
>
>
> Section 122 of Document 2020-11236 (Unlicensed Use of the 6 GHz Band) men=
tions the following, which formed the basis of the NO-IR requirement:
>
>
>
>   122. The Commission recognizes the utility of permitting probe requests=
 to enable client devices to join an access point's network. However, these=
 probe requests have the potential to cause harmful interference to license=
d operations. The Commission therefore only permits a client device to send=
 a probe request to an access point after it has detected a transmission fr=
om the access point.
>
>
>
> Best regards,
>
>
>
> Dennis
>
>
>
>
>
> On Wed, Feb 26, 2025 at 2:09=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com>=
 wrote:
>
> Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > > based on this remove NO-IR flag and allow 30 dBm max power
> >
> > The original submission mentioned NO-IR requirements, though I did not
> > find such wording. Dennis, do you have any ideas?
> >
>
> FYI. The description below in [1]
>
> In all cases, an exception exists for transmitting brief messages to an
> access point when attempting to join its network after detecting a signal
> that confirms that an access point is operating on a particular channel.
>
> [1] https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlic=
ensed-use-of-the-6-ghz-band
>

