Return-Path: <linux-wireless+bounces-4725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA58B87B8F8
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 08:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C2128AD04
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 07:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3D05CDD3;
	Thu, 14 Mar 2024 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="XC3AcKV4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F725CDD0
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402890; cv=none; b=FQIF/xO5MI7N5lwmC6CPJ6E3/wxbuAEM1+O9opsY9Pq92zfH9/PQhw0jkpu/c+RQ0l+UytO2Qi8SbPzuEiSKhAZgDR0i8eeEx4zE4EN5lhdfvZQKsveHJo82d5J7s0HMarSO/SsHv6fjA1Alnpv3Lrn61Jaextpj59SiFbb/aPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402890; c=relaxed/simple;
	bh=cN7o+/qmYgcI6mfFvGvyMIK9dyOtURHv4+OCyOKUvZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jm65mdtYzU+3QKTdQyu/H24kC8HV1pEFdj4holoAZJIuZrnogfO69mYP4HtyL4QYw0LY2XHhisZh3JXXq2R+Nqhx1CL14Rpowh7fbHlkC9tXJW77w50FwDohaQnCa+KPmMrY2X/UDs6QrXIYBw2shh4e2fo2rutmV6Sdwg7ANOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=XC3AcKV4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso503519b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1710402887; x=1711007687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN7o+/qmYgcI6mfFvGvyMIK9dyOtURHv4+OCyOKUvZw=;
        b=XC3AcKV4+kOcgUso7TcT6Nhbm8l8ANQJRQH7ZJkv/DfrTBL5sdTUdo1eyZ1XYrCqZ3
         TaMcTrtXH0gIT4K4E5LqQ1t/Yqo2w7hR+ibArxDoKUEH0Pv9bw0ibOzqD54JTYoV6pm7
         PHLCQrrVaTi2Y990iQAmxKF7EwcttmsaVPqC+NIGe4cvnhGZPDlj8XuB5ERAPUjlqlCp
         XnZ7YGRkGe1HZ4c+2VbRzV8cjrgk6lfZMqeqL8lHpOuR5Wh7UbuxCHwMmOBmg+yXysCC
         BurgeOzuMLWvelbLc30SmqQS0YKfZgfSQ/rhzro0E2ZOrJAfJyBSl0C95a2NF3wamORf
         FS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710402887; x=1711007687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cN7o+/qmYgcI6mfFvGvyMIK9dyOtURHv4+OCyOKUvZw=;
        b=bOX4dQ61l2GiZjhm3bki91z8hQYAC2zM8C7+mWfLKdLnfxi48uV4DcAoVqGeHHyZKO
         5csKEVT0fUPBlOtWfa5CUhOpkaFQIZmHHcRsuHrbhhF341e+c+2CJg3Lc608vXSM1SdP
         qlh2pLOEr1jRCFb2FllMAfEP0RelPVmYrMJzsro04QG9aSnuj515EmnoJVDV7q6cogGI
         iMBMC/HP2219CWthmJreUo8xdy4nVtaDn14Vy8XrpTCGyxZwIHuSeWnMKgIWLAVXQ4nu
         ZKAKuOzgIiGCWrXByjS5q8CWYk8ZkLnDBffYSBSnGIsly/3yItcrmzl7KNa9QytfvM39
         5B/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFUQitKR7QPWcOcHTHmtfScyLic580p9DIxrVRtMMAwoTE64z15iM+fX50Oy1w6Z/zZ2DjpHtNM8pis6Cv9xN6hzOeUTgsepOmdVQEXxI=
X-Gm-Message-State: AOJu0Yy1hl+VRbniyJbq8Be2w98ewCp2RKHyJe1Y7TpcDEvmEaxcwJV6
	zYEPPNTddUpRbCpBJ8oVS23l5qmQABM51b3LSQwv7lFZsuwdiaPVDxwMl4yggUwm6PjC+l9oEp9
	eiSUOXYGuu89feT1sX8G+izj5Y6djVSoMhysqWA==
X-Google-Smtp-Source: AGHT+IG/lL1tGT8pUkeu0A2+qzoAZei3Uz5BJOvgcI6NI2QLRo2V2am+Q+iMK9F7GfX4WbiCWc94PrXdNrcRfpaX310=
X-Received: by 2002:a05:6a21:a596:b0:1a0:f2a4:40da with SMTP id
 gd22-20020a056a21a59600b001a0f2a440damr1353534pzc.6.1710402887344; Thu, 14
 Mar 2024 00:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
 <CA+HBbNFQ+25u_PK2j3vYtiCZwv+shVAVeAHKqQCwhyCopORt4Q@mail.gmail.com>
 <874jdigf76.fsf@kernel.org> <3b57d932-0848-40f4-ab2d-a8d4afe11df1@dd-wrt.com> <e1c3ba7e-b358-42a3-a8db-f9c098132350@quicinc.com>
In-Reply-To: <e1c3ba7e-b358-42a3-a8db-f9c098132350@quicinc.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 14 Mar 2024 08:54:36 +0100
Message-ID: <CA+HBbNGZJdvHBeP0cFwK4XgEWxggxqE1RGAXrJmavaExv6NH6A@mail.gmail.com>
Subject: Re: New staging repos for ath1*k firmware
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Sebastian Gottschall <s.gottschall@dd-wrt.com>, Kalle Valo <kvalo@kernel.org>, 
	ath10k <ath10k@lists.infradead.org>, ath11k <ath11k@lists.infradead.org>, 
	ath12k <ath12k@lists.infradead.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 8:32=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> On 3/9/2024 9:58 AM, Sebastian Gottschall wrote:
> >
> > Am 07.03.2024 um 17:49 schrieb Kalle Valo:
> >> Robert Marko <robert.marko@sartura.hr> writes:
> >>
> >>> On Wed, Mar 6, 2024 at 8:23=E2=80=AFPM Jeff Johnson <quic_jjohnson@qu=
icinc.com> wrote:
> >>>
> >>>> Historically, prior to being incorporated into the linux-firmware
> >>>> project, firmware for kernel.org ath1*k drivers has been first publi=
shed
> >>>> to Kalle's GitHub:
> >>>> https://github.com/kvalo/ath10k-firmware
> >>>> https://github.com/kvalo/ath11k-firmware
> >>>> (ath12k firmware was pushed to the ath11k-firmware repo on a tempora=
ry
> >>>> basis in anticipation of this move)
> >>>>
> >>>> But in order to have repos with multiple maintainers, as well as to =
have
> >>>> a hosting platform with more control, we have moved to CodeLinaro:
> >>>> https://git.codelinaro.org/clo/ath-firmware/ath10k-firmware
> >>>> https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware
> >>>> https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware
> >>>>
> >>>> Note that most people should not care about this -- normally you sho=
uld
> >>>> use the firmware that is in the official linux-firmware repo:
> >>>> https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware=
.git/
> >>>>
> >>>> You should only need to access the staging repos if you need a previ=
ous
> >>>> version to work around an issue, or if you are testing new firmware =
that
> >>>> is supposed to fix a problem that you've reported.
> >>>>
> >>>> Please let Kalle & I know if you have any issues with these new repo=
s!
> >>> Can I please ask for IPQ6018 firmware to be updated to 2.9.0.1 as wel=
l?
> >>>
> >>> We have added IPQ6018 support to OpenWrt but we are forced to use the=
 old 2.4
> >>> firmware since anything newer is crashing on IPQ6018, we had the same=
 issue on
> >>> IPQ8074 but it was fixed with 2.9.0.1 firmware.
> >>>
> >>> Even for IPQ8074, there is newer 2.9.0.1 firmware that is only
> >>> available as part of
> >>> QSDK and the community would benefit from being able to use it.
> >> We are working on getting the AP chipset firmwares updated but
> >> unfortunately no news yet.
> > why isnt qca releasing the latest firmwares at all. i mean we all know
> > that the qca networking tree contains way newer firmwares for all
> > chipsets since a long time
>
> Kalle & I are just the conduit, but I've relayed this thread to the folks
> responsible for feeding us the firmware releases.

Trust me,
the community knows that you are trying your best and a lot of things
are out of your control and we really appreciate that.

Regards,
Robert
>
> /jeff
>
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

