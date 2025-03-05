Return-Path: <linux-wireless+bounces-19806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B725A50374
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 16:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89953AB8E4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6F2505A1;
	Wed,  5 Mar 2025 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyQ9FkZ8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A424E4A0
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188444; cv=none; b=D+ZOPZB2132Ym554/uJ4KDJ/cqoL2Bg/u3OtgAKI3Zes70VDElSp3MP1TkTve9BGkTWv54TN0zFaGG/UIkMQAo9+soCY1TRt1ayi4RCtfS3QVZI2xMBlrdHJLznZtFONXLYHyFU29MJDaLZhAWIIwQ4i4sQmwFpWSnp/GH5GnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188444; c=relaxed/simple;
	bh=X6KPMQ2A0yoM8p8xiPkC0yNS2EymQbmn1r7XkppxvCM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=svaZI2Bo/YQQy0ASfyOlwx2mJhlA1ByNH03IvP0KtudvZYY1G+12R7A2Lxxi4IUTFeP9F5I5b92opU6qx0yOAxAUNygZmnLogc65E35xkmMkE2FxVIQlqZ+Tve3apks5nj6RS9cF2J3imywRy/XAoe3O7m8ei0rQBpntg1zGQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyQ9FkZ8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390eebcc371so3272290f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 05 Mar 2025 07:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741188440; x=1741793240; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUNOlfz4QA/sJfG98zHcorBM2yYfAKZgER92KCEyonA=;
        b=CyQ9FkZ8O2BXdqkYHOxbLXTNb8vT4Le0KFGUHBCft2Vq4zPcg/mWzx6MAp6Hg2Cfk7
         IGiCmdgYgxqn4jz4WwCe960oSjjzkwh6dn2HBeMpYkr1vHl5YGTVTu3J7C06zcufyH5Q
         A8H0INwXdcz4u+esmDfVPanOZq6GxF7gdMPk0Q70CpEYIGhvDc9e5/Tz96+lVIXsBxF2
         TcihNvXdMRyL8pQCWiBkyax8jMBiYp7LctTvaOv4ZmjnsidqK2Yg8vXNLIwquNnlOwQo
         DcDqdQrxPgkKd2IaVwbfwKvQnXAxgL8XlZN7I6sEyVNdHKc7m5UlVSUUufoGgpUW0njg
         WP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188440; x=1741793240;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUNOlfz4QA/sJfG98zHcorBM2yYfAKZgER92KCEyonA=;
        b=RgpNaCa6pmufEDSSd0OSa9CNwu77R0n5+mU5KQdmarhz5GozP8bSUphyVNJ5kVypbv
         w6T6+Xt8ZiPvVIaWTFyhuJ16jTzJ36zuZzlzhNqSWBu7Lte0VZPwC+FQqZw2+iqPG9Ob
         oyX5/mfIRLqNpzU1Df9V+sJT1V8PlN8ajglevhHrDFPt/cstJSPHibUdLMbBZ76cgm1y
         eZzfoBcny+AXoDEqJb3s0WDWzBSyN5WMes7iUrKLZvlfBg07AoTdXJQ5EncaEjE6YpBi
         a7xg8FLmxHD6ojo2j72iIK4VhRrskmN5/7MOwI2KgPWYmk6ZlXxz1bbnEiN8Ff854rn1
         X4GA==
X-Forwarded-Encrypted: i=1; AJvYcCVXopXb4jFwYD0W3JmEUGJCNNt4bnNGKhQFH5POZ8Hrn2NJQvVQfeugcBqX+j0UjUdFPNxwlpQIz8HrA56c+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0s93W7+mnz5C7nH080P0/NQYYfwL5mRz6iWW9hbhBzJ4CmFUv
	a7sGqW1uTZij6wwcVJ3KuRVMGcOoXw+WVGAK2s5npMdaRKCcU9CdwQMyAGM=
X-Gm-Gg: ASbGncuOrXfhcRQekP5UJOawJ8FjmXtxYdOS+o45oYBNKwWEewzVd2FwPaMPX+XebW2
	d2iuqdOKLJCB53QJ/oUK6Xvj2HPpDE0JEPmCA2X/hNmi4DKFpK5LTguZi2ONlJD25eKNhwz2kER
	YgqT1KGqabIitLezFvwWpT8hGV6r4Kewphnqcb7y6KSHtrsav3I50hMe94V10UrBPcqJ0bzDRQN
	0g/LzAQ5glzeJ/Y2MPWWp61Vg02vxR2NssbWO6Du7sNzPuY+Dzyi6Ka4SJxHlPt5mkqbkBG9kxJ
	98M8csLrilOrbnEh1ucZmT1fIGU2RKbENzCtHIgyhQebGfIrEDKvFTBcsDIdGUnSd6ZgDU9fA5s
	w9KyNXvxxPylKa9qzg2d/V15yPNsSsyY=
X-Google-Smtp-Source: AGHT+IGynrrO1AYCYWfxF5mTzcYIEuN10gQdVtirCk09RjQ6ik08z7m+wENAvlc52HD+ugmKX445VA==
X-Received: by 2002:a5d:5850:0:b0:391:4f9:a039 with SMTP id ffacd0b85a97d-3911f7400aamr3778136f8f.16.1741188440201;
        Wed, 05 Mar 2025 07:27:20 -0800 (PST)
Received: from winhome (cpc112753-pert6-2-0-cust678.16-4.cable.virginm.net. [86.18.22.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d906sm21573380f8f.90.2025.03.05.07.27.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Mar 2025 07:27:19 -0800 (PST)
From: <rmandrad@gmail.com>
To: <wens@kernel.org>
Cc: "'Nicolas Cavallari'" <nicolas.cavallari@green-communications.fr>,
	"'Dennis Bland'" <dennis@dbperformance.com>,
	"'Ping-Ke Shih'" <pkshih@realtek.com>,
	<linux-wireless@vger.kernel.org>,
	<wireless-regdb@lists.infradead.org>,
	"'Johannes Berg'" <johannes@sipsolutions.net>
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com> <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com> <ff6ad414457e4b1cb68e834978a553c3@realtek.com> <CAPRryQobXZe5OwR=F-X0KHYyfBwUpFsi=Y5pKnENcUXTN42xAA@mail.gmail.com> <002d01db8da7$daf2ed50$90d8c7f0$@gmail.com> <CAGb2v66Y+rTsuKfQDgv-qwRTOorOucM+qfBOia-gY5sPCJp5qQ@mail.gmail.com> <319c9de5-e26f-45c0-9200-747c86bce303@green-communications.fr> <001a01db8ddc$019e8890$04db99b0$@gmail.com> <CAGb2v6689=CmxqOk9rCSXPctg8iCZzOUgcaxdNeB9uHSHzk39Q@mail.gmail.com>
In-Reply-To: <CAGb2v6689=CmxqOk9rCSXPctg8iCZzOUgcaxdNeB9uHSHzk39Q@mail.gmail.com>
Subject: RE: wireless-regdb: Allow 6ghz in the US
Date: Wed, 5 Mar 2025 15:27:23 -0000
Message-ID: <000101db8de3$18727b10$49577130$@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMUrzCf8XdNoAU6+fu4ECJnDc0awgHIktuQAg9ms7MCOQTCTwHce3oJAeRkceYB16Yw4QG9HTMVAdpTHyuweFySQA==
Content-Language: en-gb

Thank you Wens for cc'ing Johannes

One of the issues [1] reported with one the openwrt devices ... my =
understanding / experience is that if there is NO-IR basically clients =
will not connect (I can't think of a use case where there's prior =
traffic)

[1] https://github.com/openwrt/openwrt/issues/18079


-----Original Message-----
From: Chen-Yu Tsai <wens@kernel.org>=20
Sent: 05 March 2025 15:11
To: rmandrad@gmail.com
Cc: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>; =
Dennis Bland <dennis@dbperformance.com>; Ping-Ke Shih =
<pkshih@realtek.com>; linux-wireless@vger.kernel.org; =
wireless-regdb@lists.infradead.org; Johannes Berg =
<johannes@sipsolutions.net>
Subject: Re: wireless-regdb: Allow 6ghz in the US

Cc-ing Johannes since I think this discussion also involves what =
cfg80211 does.

On Wed, Mar 5, 2025 at 10:36=E2=80=AFPM <rmandrad@gmail.com> wrote:
>
> See below
>
>
> [1] Beacon Hints
> " cfg80211 has a feature called beacon hinting to assist cfg80211 in =
allowing a card to lift passive-scan and no-beaconing flags. =
Passive-scan flags are used on channels to ensure that an interface will =
not issue a probe request out. The no-ir flag exists to allow regulatory =
domain definitions to disallow a device from initiating radiation of any =
kind and that includes using beacons, so for example AP/IBSS/Mesh/GO =
interfaces would not be able to initiate communication on these channels =
unless the channel does not have this flag. If either of these flags are =
present on a channel a device is prohibited from initiating =
communication on cfg80211."

Doesn't this do what the FCC rules say? No initiating communications =
unless prior traffic has been seen on the channel for client devices.

> ...
>
> " It is also important to note that the Linux kernel beacon hint =
mechanism only trusts beacons from 802.11 APs, not Mesh or IBSS."
>
> [1[ =20
> https://wireless.docs.kernel.org/en/latest/en/developers/regulatory/pr
> ocessing_rules.html
>
> My experience is with Openwrt and APs. We have users in the US=20
> complaining that they can't use 6GHz due to NO-IR

OK. It would have helped if you explained that it is the AP side that is =
not working.

Regarding that, AFAIK we don't really have a way to specify different =
rules for APs vs client devices. AFAIK all the power limits written in =
the database are for client devices, because clients seem to have more =
restrictions.

ChenYu

> -----Original Message-----
> From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
> Sent: 05 March 2025 12:19
> To: wens@kernel.org; rmandrad@gmail.com
> Cc: Dennis Bland <dennis@dbperformance.com>; Ping-Ke Shih=20
> <pkshih@realtek.com>; linux-wireless@vger.kernel.org;=20
> wireless-regdb@lists.infradead.org
> Subject: Re: wireless-regdb: Allow 6ghz in the US
>
> On 05/03/2025 09:58, Chen-Yu Tsai wrote:
> > On Wed, Mar 5, 2025 at 4:23=E2=80=AFPM <rmandrad@gmail.com> wrote:
> >>
> >> That is not specifying NO-IR which basically is denying any 6Ghz in =

> >> the US what it means in my opinion is
> >>
> >>
> >>
> >> Client devices (like phones, tablets, laptops) need to find Wi-Fi =
networks before they can join them.
> >>
> >> One-way devices do this is by sending out probe requests. These are =
little "Are you there?" signals that ask nearby access points (routers) =
to respond, so the device knows which networks are available.
> >
> > Section 122 says: The Commission therefore only permits a client=20
> > device to send a probe request to an access point after it has=20
> > detected a transmission from the access point. The client device=20
> > will be required to send the probe request on the same frequency as=20
> > the access point's transmission.
> >
> > I think this translates to "passive scanning only", which is what=20
> > NO_IR is meant to specify. NO-IR was previously called PASSIVE-SCAN, =

> > and was renamed when it was merged with NO-IBSS.
> >
> > Maybe the kernel's implementation needs work? I'm not a WiFi person=20
> > so I really don't know all the details.
> >
> >> That is why drivers use the non 6Ghz for allowing clients to=20
> >> identify the router has 6ghz capabilities=E2=80=A6 I don=E2=80=99t =
think is for=20
> >> wireless-regdb to take over the HW router compliance and=20
> >> certification which is what 122.  is about
> >
> > No, section 122 is definitely about client devices, which is what=20
> > Linux devices are.
>
> No, Linux also supports access point, IBSS, OBSS and mesh, not to =
mention monitor injection.
>
> If you remove NO-IR, you are allowing Linux to create access points, =
ad-hoc and mesh networks on the channel without conditions.
>


