Return-Path: <linux-wireless+bounces-6253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C28A2DE7
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 14:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331AA1C20916
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 12:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0892502A7;
	Fri, 12 Apr 2024 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm3RAETE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83458D50F
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923295; cv=none; b=Xc3lW0UwNC/mYhuMXU5DoqcMh+E6Yc4oN6GJNdWokWEO6f6Enrdj6/HuyjbTQemq3TUau9aoggF/4W1OWgP9RS4DQoJzuG6qLzMA9Zv6QFB6wO715lhxe/u428KcmJa/fj/0Ix2Ebu+3/9VuKd5eu584luuYISdr1VI7Iu1ucSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923295; c=relaxed/simple;
	bh=R5TUZF7kgYOPpGMYvqvhvnz91hVzlqWLKGQ+Lv0E4BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brQv3vERN2Tl0HbSEMDTheL/yTfDYvfKH/3BK2umYEJypA49Vm4BCmrYASRGvLXEdUPRxwOTLJAo8UBvTrK1F3NzhpqCK77pCcwTCgNOVsyh7ab+N3I54rLynG9rl11cTHfMLsULDfkupTjAeltsCtE91gkMsIAj4goHK0GkgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mm3RAETE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso983863a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712923289; x=1713528089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CeCAE/QnruiTawWUprbCmFasjXRmO+GRxpSd//EBvAE=;
        b=Mm3RAETEtbRfHYlfFNYtLqTRO9YYzagSXEJv1NOH9sE7dCZRsYaaXoo8PHmIbqJ8CF
         5cqdlC3UHge9X1l3N3zyefzzZFY7Plnxt3raah5RHY5PJx0QMPf2ARvA0aKf0NgU5rno
         XbzFGqXFywlYYonoNUiUSk3TCR2LCXFBxsJAPuFlpDWE26EP/7ZNN4jmHu/PyoBVYAaS
         BSzfc2umGDYaOkHcftB3IEXDDAo8OEehmuBbyGR9JpreJpE6SHfzUUDyaI33Q5BomshH
         /Y4S/2BxTClnqLeVtCpRNl4t/jsOXf0zEpEKtPdUNT8Dzm/111uh/3eOv4Apd/uB7S0K
         FexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712923289; x=1713528089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CeCAE/QnruiTawWUprbCmFasjXRmO+GRxpSd//EBvAE=;
        b=Zual3chZQtQzUeCdpaSGaOcdsCwnul8ixNnHFTUel/JMU3pq8sM4LdgM+PxZQkuBz1
         9ZiFiDVN31xKf2PK9gPYhI+E58JEODM/CfZVqux8j1BJ+Nfu+n1aTGPHSNCZXj/vzF7T
         aBOAV5DDDsGs/dxFfofvtdJYZhp6hjHZIoVEif+2HtSp1rQAO1qTgwJwCDzmn8WFaZ/V
         wWyHJNpn/SxBSVHlbn7CvLGN2bayfU8rM3jqvtcafe6WfO/eolITFVnI8STkSYXJR3A+
         NV4GTDvU/jLatCxf57XK0246FfhEEhR9FTaqfPmw0n2O2szrlt1tzPnTVGjWoF9dn7EF
         ilrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKDYj1SE/LFbBaorzbazFaX76fmbLmvkcltDAR4+f23cd4aDQez5nQv0be73PgwbB+opnPDuADfc7cyh5Y2BPSLpGzrfX4uCrF/ul9lYU=
X-Gm-Message-State: AOJu0Yww3cFfJXtFW4xojgfHJYMPoQhYYTzanQ3nWLIYmHHOxQJHudYg
	gA+U15dnQmqE5vr4Vdv+FABeKca6USVI3HctaNzJQxurtHnm9eQfrsHXgbC5tkjq0F/xbsB52XD
	oLBvdIJ652n3Bue+4ziVx14bT9CY=
X-Google-Smtp-Source: AGHT+IGp9ewgZpGM/38Ui91s9NpGJHPzveZW2R9MOq9DG0E8jUtcxinpLDwpAwSkcBFFElG4ngUTL9FOj1YrjHUACT0=
X-Received: by 2002:a17:906:dac1:b0:a52:241b:b450 with SMTP id
 xi1-20020a170906dac100b00a52241bb450mr1886649ejb.36.1712923288360; Fri, 12
 Apr 2024 05:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com> <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com> <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
 <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com> <31f30c0e318904f3a082c7f213576ceb1f407141.camel@sipsolutions.net>
 <20b56e52-a5e2-70cd-a62a-8c4a3526c2cf@candelatech.com> <614bb8a8f1d9174ad7d87cf7636f657cda7b1ef9.camel@sipsolutions.net>
 <aa9e1d54-bb5f-37cc-335f-c9970ab13789@candelatech.com> <0cfe990b-182b-4ceb-b5b4-2989fefedb2f@quicinc.com>
 <29f7ecb6d7c208c3614f37616943d5f97bb134d3.camel@freebox.fr>
 <5fc2f2d2-7403-79d2-8909-ddda918ff8d5@quicinc.com> <af70ee81e583f58dada3dde87ac335137c4038b0.camel@freebox.fr>
 <6ff353e2-785a-f2ce-8d3b-acc8e79a64cf@quicinc.com> <D0HZ1KH5VJ8P.2TZZ7NNZXSJA8@gmail.com>
 <816770ca-fb30-e1cc-3f57-51d1fd35f141@quicinc.com>
In-Reply-To: <816770ca-fb30-e1cc-3f57-51d1fd35f141@quicinc.com>
From: James Dutton <james.dutton@gmail.com>
Date: Fri, 12 Apr 2024 13:00:51 +0100
Message-ID: <CAAMvbhFPdPUOYSnxhO36E0yYJ7cuQLUGt87EqoGhBc=sw7GgHw@mail.gmail.com>
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: Nicolas Escande <nico.escande@gmail.com>, mbizon@freebox.fr, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Ben Greear <greearb@candelatech.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 09:02, Vasanthakumar Thiagarajan
<quic_vthiagar@quicinc.com> wrote:
> On 4/12/2024 1:08 PM, Nicolas Escande wrote:
> > On Fri Apr 12, 2024 at 5:50 AM CEST, Vasanthakumar Thiagarajan wrote:
> >> On 4/11/2024 10:09 PM, Maxime Bizon wrote:
> >>>
> >>> On Thu, 2024-04-11 at 21:56 +0530, Vasanthakumar Thiagarajan wrote:
> >>>
> >>> Hello,
> >>>
> >>> Thanks for making it clear,
> >>>
> >>>
> >>>>> For example, starting a 5Ghz AP in ax-only mode, and at the same
> >>>>> time
> >>>>> creating a STA interface on 2.4GHz ?
> >>>
> >>>> Yes, such use cases continue to be supported in single wiphy mode.
> >>>
> >>> Understood, but I see some corner cases.
> >>>
> >>>
> >>> For example, assume two bands AP hardware, 2.4GHz and 5GHz.
> >>>
> >>> Previously:
> >>>     - phy0 is 2.4Ghz
> >>>     - phy1 is 5Ghz
> >>>     - iw phy phy0 interface create wlan0 type managed
> >>>     - iw dev wlan0 scan
> >>>
> >>> => will only scan 2.4Ghz
> >>>
> >>>
> >>> With single phy approach:
> >>>     - phy0 is 2.4Ghz + 5Ghz concurrent
> >>>     - # iw phy phy0 interface create wlan0 type managed
> >>>     - # iw dev wlan0 scan
> >>>
.> >>> => will scan both bands ?
> >>>
> >>
> >> Yes, both the bands will be scanned if freq list is not given
> >>
> >>>     - <starting from previous state>
> >>>     - # iw phy phy0 interface create wlan1 type __ap
> >>>     - # hostapd -i wlan1 <config>
> >>>     - # iw dev wlan0 scan
> >>>
> >>> => what will happen then ?
> >>>
> >>
> >> Scan will be carried out on all the radios including the one on which AP interface is
> >> running. Scan with freq list can be used not to disturb the radio of AP interface.
> >>
> >>>> Same goes for hostapd ACS, I assume specifying freqlist becomes
> >>> mandatory or we can't predict which band the AP will be on ?
> >>>
> >>
> >> If no freq list is given, ACS will run through all the bands and select a channel from any
> >> of the bands. But this can be optimized to do ACS and channels selection on a particular
> >> band using channellist/freqlist hostapd configurations.
> > Hello,
> >
> > And in a (very unlikely) case that there are two underlying radios that can
> > operate on the same frequencies, how would freqlist enable us to really select
> > the underlying radio ?
> >
>
> This can not be supported in this approach. As only the radios participating in MLO are
> supposed to be combined under one wiphy, not sure if we have real use case to combine
> radios of same frequencies.
>
> Vasanth
>

Looking at this discussion, I think it would really be helped with
some architectural diagrams describing the various combinations of
components in an RF chain.

Let us take a single example.
We have antennas, analogue front end, and ADCs (Analogue to digital converters)
The features of those two are:
1)  Antennas can be optimised for particular frequencies.
2) The analogue front end has many different parameters, but for this
discussion, the important one is:
a) frequencies it can tune to.
b) instantaneous bandwidth. I.e. When tuned to a particular frequency,
what is the bandwidth around that frequency that one can receive.
3) ADC
a) The Sample rate

Once the RF sample are in the digital domain one has the ADC ->
DIgital Processing -> Output data
If we assume that the ADC is set to receive the full instantaneous
bandwidth, the digital processing can do a number of things.
1) process the full instantaneous bandwidth into a single channel of data.
2) process the instantaneous bandwidth into multiple sub bands, or
multiple channels of data.

There is also the control endpoint that controls all these components.
There can be multiple front ends for each ADC. multiple ADCs per
Digital Processing.

A higher level process (maybe hostapd) can then speak to multiple
Digital Processing and ADC, RF Front end components and then somehow
has to manage and coordinate them all.

All these capabilities and varying arrangement of the various
components need to be reported up to a higher level, in a common way,
that can handle all possible arrangements.
Once the higher level process has all this information, it can then
manage to do everything necessary for Multi-Link operation (MLO).

So, to answer some of the questions in this thread.
Scanning: The high level process should know what capabilities are
available and what can be done in parallel or not. So it should be
able to convert a request from a user, into a more detailed request
down towards the hardware.
I.e. User asks for scan.  High level process tells which bits of the
hardware should do the scanning and across which frequencies.
While it might sound complicated, when implemented correctly, it is
just a matter of iterating over a  tree with a search match criteria.

My expertise is in managing far more complex RF hardware and not Wifi
specifically, but the concepts for managing the hardware across all
the available frequencies is the same. I am just offering a
perspective of where the problems discussed here have already been
solved in another domain.

