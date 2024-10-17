Return-Path: <linux-wireless+bounces-14176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C319A2CCD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 20:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516A4282E90
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01390219496;
	Thu, 17 Oct 2024 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGRVk47B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E62194B1
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191377; cv=none; b=kv79mUbXoS91EYU7RsK5Kems8faie1RodbwhG//C0Z5PS8JPlyd42LkXLlUhqZoDl+hq1+uz5o5SfJeaS8QtKRtnpTRyQviovPLhm0+9HayudSHP2Lo+X+gKIg2y2R/c2W+tbgVplWWZs24TWtq6zSTiF0N+p0zi5v0inzBeNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191377; c=relaxed/simple;
	bh=LLSTou0LuSxYdH75hNyvcKnh3qNUeQ6vxgLVoglYEpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQj7CS5SE0R/vp6HjYCgsDnLaQ/xy322k/Lg3u1muljnaYg/cC6FFftWX645eEKKSte9/3G/AiQr3GqjtazPoEv5fVNihmiK32jW6U6OyQGx1TckiBPpcCAFPzfveFvUw8vkcZM+OwRlNib3+mlg2U3KMj58aMp7y0ppusA99e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGRVk47B; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso147662966b.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 11:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729191371; x=1729796171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8H1r+7LOE5cX5CPE4OXXYYweB44wOcIglCbWw1ZqJKU=;
        b=BGRVk47BiEmijDlbl6AZuV85nakLoKmB5XhOrIkAuN2CsHrAF26vaYpQAncNJ0z6zy
         DK2TrXqCFBnL9mzwauZ/ruTNeG0yc1DHnbu6xkP4Vuh1DxQ9z0fjsaRlqTX8H6b5W41m
         XZXI/84H+D9jLbOfK6IzSi9fxZzUse3ubFcWMF2u1zsIATpiC6pG277FDhi4MaljJta8
         +C19IcyYU5rd8h923bWtoJFL+l3oTYaHl6BkNK+Q4ubV9jMGvs2vzdOPUaeB/7wqGiIH
         CCqFZPGlifc/B9BAuNvs6Qw8iP1fL6Nhffs2HzD3mXPpAZB5OilJg51f7HWpDshp7ZeS
         KzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191371; x=1729796171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8H1r+7LOE5cX5CPE4OXXYYweB44wOcIglCbWw1ZqJKU=;
        b=pcgitncjlPNGE0TU2bTTOL6xWMqzo486u8WwDfkf79ltGMhbtVk3nFakMLLWjHBSFS
         N20626JM5RBVwv4FFRYmFXr6Le5Wchl5iy2KmMt/GCyz36olGqvN2kDfMnEppQCI2zLg
         hhnG3Vi3pwEPRk8354tI2Q7LGNuVJRNBebJM9+DNH/u5TdAvliSC7c7YKLJjdFH9KJAD
         AjjCSikyRONsObQCL58nYYt7BlcOUmU8RTLigC0gaQgrxWbK31ZcMZxa32WNf4xktKh6
         vFC1A+Oa+iaR5Ka0DkOQa9oKut8fGlJ8NwiNzWn6HaRxea9GEfMW3YtyAc8DNeds3QCx
         KnBw==
X-Forwarded-Encrypted: i=1; AJvYcCVvkuz4AvoZzYQYWQjbzTj0yrkhU+eVvseEt62f58Fz+I12YpNkssjQOisJGEUJFl454+1LkzAHEhc0nrqAVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJsJ+XcqD+vu5Fh38EKtitjQFkIc+DCw1w+VoHSYLjop5Oqr4
	UI0RSmIzrzw3PtCzQG27OCllmKaK2yIo/2SfAavmny7MRsIcTxsw+3o8N2J7ru+U4if9eTFJzJW
	Yu10LHgmopPYTGH6U69RnMVu3qu4=
X-Google-Smtp-Source: AGHT+IEXNJhHHQObHTVrJ5hm55WDgaX8FVlE3o/BRtle2RsCeXb2rt+V7W12+rATPMW3JR7/IS6k+ElfoNX63NoNozQ=
X-Received: by 2002:a17:907:d2cf:b0:a99:8178:f7ed with SMTP id
 a640c23a62f3a-a9a34c7d678mr712349966b.4.1729191370584; Thu, 17 Oct 2024
 11:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620100405.45117-1-gregory.greenman@intel.com>
 <20230620125813.b77a1574a0a7.Id4120c161fb7df6dedc70d5f3e3829e9117b8cb1@changeid>
 <d220c5b6-7c8f-19cd-12d0-ceb484e29e48@candelatech.com> <53612acba151d031f636626db20c1c60db09fdd0.camel@sipsolutions.net>
 <9f4c589a-2160-cedb-d79a-1f57ea5244da@candelatech.com> <6ee9c93cfa5a8f6dbb6e07dc2c72e26bb0e57121.camel@sipsolutions.net>
In-Reply-To: <6ee9c93cfa5a8f6dbb6e07dc2c72e26bb0e57121.camel@sipsolutions.net>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Thu, 17 Oct 2024 20:55:59 +0200
Message-ID: <CAFED-jnGvGcAuwN_R2nKvmiy6PU_Ezfpicma0ORHsCa804aqyQ@mail.gmail.com>
Subject: Re: [PATCH 10/19] wifi: iwlwifi: limit EHT capabilities based on PCIe
 link speed
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ben Greear <greearb@candelatech.com>, gregory.greenman@intel.com, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=9Br., 21 cze 2023 o 18:12 Johannes Berg <johannes@sipsolutions.net> nap=
isa=C5=82(a):
>
> On Wed, 2023-06-21 at 07:48 -0700, Ben Greear wrote:
> > On 6/21/23 4:57 AM, Johannes Berg wrote:
> > > On Tue, 2023-06-20 at 06:19 -0700, Ben Greear wrote:
> > > > On 6/20/23 3:03 AM, gregory.greenman@intel.com wrote:
> > > > > From: Johannes Berg <johannes.berg@intel.com>
> > > > >
> > > > > If a discrete NIC is connected to a PCIe link hat isn't at least
> > > > > Gen3 (8.0 GT/s), then we cannot sustain 320 MHz traffic, so remov=
e
> > > > > that from EHT capabilities in that case.
> > > > >
> > > > > While at it, also move setting 320 MHz beamformee to the right
> > > > > place in the code so it's not set while not supporting 320 MHz.
> > > >
> > > > Is there not an advantage to allowing 320Mhz for longer distance co=
nnections
> > > > where signal is relatively weak, so over-all tput would easily fit =
in lesser
> > > > pcie bus?  Especially on 6E band where the US regdom allows more ov=
er-all power
> > > > when using wider bandwidths?
> > > >
> > >
> > > I actually don't know. This surely isn't ideal, but it's the only way=
 to
> > > really force the AP to not send too much than the NIC can pass out, a=
nd
> > > it gets unhappy if it can't.
> >
> > So this is to work around hardware/firmware bug in NIC?  If so, that sh=
ould
> > be mentioned.
>
> I'm not sure that's really even a _bug_, it just doesn't have a lot of
> buffer space inside of it; as far as I know, given how the HW
> architecture works, the FW doesn't have a lot of options.
>
> > I have heard in the past that higher bandwidth works better than higher=
 NSS
> > in a lot of cases, so if HW/FW can be made to deal with floods in unlik=
ely
> > case that the RF is perfect enough to saturate the PCI bus, then I thin=
k you
> > should allow 320Mhz even on slower PCI bus configurations.
>
> Right. I don't think it's likely that the firmware will do, but hey, I
> can let them know :)
>

Could we revert this one?
In my noisy env after disarm this check, still get better results for
320 than 160:

janusz@e850:~/github/wifi_tests/tests/remote$ ./run-tests.py -c
cfg-janusz.py -d bpi-r4 -r be200 -t connect_6g_tp
DUT: bpi-r4
REF: be200
RUN check_devices
PASS
START - connect_6g_tp (1/1)
PASS (
       (6g/1/EHT320): ping pkt loss ap->sta: 0%, sta->ap: 0%
       (6g/1/EHT320): ap->sta: 1453 Mbits/sec, sta->ap: 2097 Mbits/sec
) - 69.055398s

janusz@e850:~/github/wifi_tests/tests/remote$ ./run-tests.py -c
cfg-janusz.py -d bpi-r4 -r be200 -t connect_6g_tp
DUT: bpi-r4
REF: be200
RUN check_devices
PASS
START - connect_6g_tp (1/1)
PASS (
       (6g/1/EHT160): ping pkt loss ap->sta: 0%, sta->ap: 0%
       (6g/1/EHT160): ap->sta: 1266 Mbits/sec, sta->ap: 1706 Mbits/sec
) - 69.324334s
janusz@e850:~/github/wifi_tests/tests/remote$

BR
Janusz

