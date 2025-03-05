Return-Path: <linux-wireless+bounces-19804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F66EA5033A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 16:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FE8164076
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B776207A37;
	Wed,  5 Mar 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COUU4FRt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469608635D
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187489; cv=none; b=BKflw+uQllzEpzaMNgEeBwjQ0nvTo3QPuYQQk4nth1cMV2TkGFk+RGSNrvE/ivuVHlX+FTM2YjEbiUxCNFEZMQgQuI7rq1ld7UAUapbIu+i2KMGx47KLRzQLf/W1y3RWfGaN580QZ/L6uViOYz/u4kQRd2mmkB6CTTY3sehoh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187489; c=relaxed/simple;
	bh=tB9GOxtavRA2qvmdaSxmmHsJMc9VVC6DLgW+JzGYUTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtZdcLb2IAZ/16R9CiYl36dMIDtShGhglXPEGh8OaCSbVNMTuGHx2qXUPFAUf/ORD7fazz8wXFJ7lqwf8J1dO7wMC0TDbPO78rOeyw9z3tmHP4tT3WvymGJwOsuBs/FrivrdtoDDzdEJasUDTQNHRms8B73j+5IefzOR0dwNkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COUU4FRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C086CC4CEEA
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741187488;
	bh=tB9GOxtavRA2qvmdaSxmmHsJMc9VVC6DLgW+JzGYUTI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=COUU4FRt3bQFBN7DJY7MnEy+aqrg300fmqveJIjNwiKSoW/XyfoEkJi+IHwvqrIjc
	 Z6UUZXrIltQV1Q3S8Zmf9NUm/LDJA90r6QX7/ZBj3Bf+oYIGBEUwz0vPiD3eWEH8L4
	 rDFR7bJ46cw2Gn4UTvCIdfvmlp8DTmGP5WTasBwiMAj713V+8n8O119bkr7UzNc1XT
	 y+6i3P29snKRrhP3lO4eut2y8avuKwd9wbr1i8RW8kLr1qeJ2kQyJkWnX7SBE0dpB+
	 mz9mc+uVaV9GYicscd1wuwk0PnMAEqiL5Z5deCKGjvzTGxIRMqHm2LZeqJzjG5nGHY
	 V1LZk13XEa9Yg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so71436001fa.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 Mar 2025 07:11:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkESIHyQMyFIM11KUymOZrskBgX/uuyTM9u2BtCrd3rC2PAoRQmJN2R9yjCnzF4nPSmXbNWe2JsJZT5T+TTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjw5tFGVoLjZs0OaIOj4Rdj+af3GGEmRTEeu3s1/DZvhwqcnR
	cmpUhkZnLxoDTtEv72S4aVx7J4pa/rO5RxX6CbEx47Frhg6kE6XXMfYoI3dieZnfJncsYgOXZCd
	Sb/HEHT1z0HDEdKdGyF7JN8zieck=
X-Google-Smtp-Source: AGHT+IFqp4PPBWjgNNVSE890qPKdF3ynsFSNjoXlnL14WLC8Te3d7te3csy3TC1xcQAjUXfKTMKKB31NcLUjvMJ3SxI=
X-Received: by 2002:a2e:a781:0:b0:30b:8c92:63ec with SMTP id
 38308e7fff4ca-30bd7b11c17mr15331551fa.32.1741187486977; Wed, 05 Mar 2025
 07:11:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com> <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com>
 <ff6ad414457e4b1cb68e834978a553c3@realtek.com> <CAPRryQobXZe5OwR=F-X0KHYyfBwUpFsi=Y5pKnENcUXTN42xAA@mail.gmail.com>
 <002d01db8da7$daf2ed50$90d8c7f0$@gmail.com> <CAGb2v66Y+rTsuKfQDgv-qwRTOorOucM+qfBOia-gY5sPCJp5qQ@mail.gmail.com>
 <319c9de5-e26f-45c0-9200-747c86bce303@green-communications.fr> <001a01db8ddc$019e8890$04db99b0$@gmail.com>
In-Reply-To: <001a01db8ddc$019e8890$04db99b0$@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 5 Mar 2025 23:11:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v6689=CmxqOk9rCSXPctg8iCZzOUgcaxdNeB9uHSHzk39Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpDvLPwTM8VPit-L5pglt24QglWLGT5ieoENaXVI_9p3KF0T-ysJNxJL7s
Message-ID: <CAGb2v6689=CmxqOk9rCSXPctg8iCZzOUgcaxdNeB9uHSHzk39Q@mail.gmail.com>
Subject: Re: wireless-regdb: Allow 6ghz in the US
To: rmandrad@gmail.com
Cc: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>, 
	Dennis Bland <dennis@dbperformance.com>, Ping-Ke Shih <pkshih@realtek.com>, 
	linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cc-ing Johannes since I think this discussion also involves what cfg80211
does.

On Wed, Mar 5, 2025 at 10:36=E2=80=AFPM <rmandrad@gmail.com> wrote:
>
> See below
>
>
> [1] Beacon Hints
> " cfg80211 has a feature called beacon hinting to assist cfg80211 in allo=
wing a card to lift passive-scan and no-beaconing flags. Passive-scan flags=
 are used on channels to ensure that an interface will not issue a probe re=
quest out. The no-ir flag exists to allow regulatory domain definitions to =
disallow a device from initiating radiation of any kind and that includes u=
sing beacons, so for example AP/IBSS/Mesh/GO interfaces would not be able t=
o initiate communication on these channels unless the channel does not have=
 this flag. If either of these flags are present on a channel a device is p=
rohibited from initiating communication on cfg80211."

Doesn't this do what the FCC rules say? No initiating communications
unless prior traffic has been seen on the channel for client devices.

> ...
>
> " It is also important to note that the Linux kernel beacon hint mechanis=
m only trusts beacons from 802.11 APs, not Mesh or IBSS."
>
> [1[  https://wireless.docs.kernel.org/en/latest/en/developers/regulatory/=
processing_rules.html
>
> My experience is with Openwrt and APs. We have users in the US complainin=
g that they can't use 6GHz due to NO-IR

OK. It would have helped if you explained that it is the AP side that
is not working.

Regarding that, AFAIK we don't really have a way to specify different
rules for APs vs client devices. AFAIK all the power limits written in
the database are for client devices, because clients seem to have more
restrictions.

ChenYu

> -----Original Message-----
> From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
> Sent: 05 March 2025 12:19
> To: wens@kernel.org; rmandrad@gmail.com
> Cc: Dennis Bland <dennis@dbperformance.com>; Ping-Ke Shih <pkshih@realtek=
.com>; linux-wireless@vger.kernel.org; wireless-regdb@lists.infradead.org
> Subject: Re: wireless-regdb: Allow 6ghz in the US
>
> On 05/03/2025 09:58, Chen-Yu Tsai wrote:
> > On Wed, Mar 5, 2025 at 4:23=E2=80=AFPM <rmandrad@gmail.com> wrote:
> >>
> >> That is not specifying NO-IR which basically is denying any 6Ghz in
> >> the US what it means in my opinion is
> >>
> >>
> >>
> >> Client devices (like phones, tablets, laptops) need to find Wi-Fi netw=
orks before they can join them.
> >>
> >> One-way devices do this is by sending out probe requests. These are li=
ttle "Are you there?" signals that ask nearby access points (routers) to re=
spond, so the device knows which networks are available.
> >
> > Section 122 says: The Commission therefore only permits a client
> > device to send a probe request to an access point after it has
> > detected a transmission from the access point. The client device will
> > be required to send the probe request on the same frequency as the
> > access point's transmission.
> >
> > I think this translates to "passive scanning only", which is what
> > NO_IR is meant to specify. NO-IR was previously called PASSIVE-SCAN,
> > and was renamed when it was merged with NO-IBSS.
> >
> > Maybe the kernel's implementation needs work? I'm not a WiFi person so
> > I really don't know all the details.
> >
> >> That is why drivers use the non 6Ghz for allowing clients to identify
> >> the router has 6ghz capabilities=E2=80=A6 I don=E2=80=99t think is for=
 wireless-regdb
> >> to take over the HW router compliance and certification which is
> >> what 122.  is about
> >
> > No, section 122 is definitely about client devices, which is what
> > Linux devices are.
>
> No, Linux also supports access point, IBSS, OBSS and mesh, not to mention=
 monitor injection.
>
> If you remove NO-IR, you are allowing Linux to create access points, ad-h=
oc and mesh networks on the channel without conditions.
>

