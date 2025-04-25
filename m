Return-Path: <linux-wireless+bounces-22079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AC8A9D03B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D0E3BBCF0
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A632321576A;
	Fri, 25 Apr 2025 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eUjC8g6O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A87215160;
	Fri, 25 Apr 2025 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604585; cv=none; b=bOyCHfy1Kr7ASxhnRsgda0bZQjZpheHuzksTuVgv0xXF7fW0M8mlgHJoafHJo2Jc55tSvclGrZiyXyjeh9SNcgPn5ZaJIKmbrm1RaGldFb5jcVlty40XV4DCaEx+9Qcp/5FY4FDqJHhno1COZEP5pCkuamoP6yLLAZQXXmoWTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604585; c=relaxed/simple;
	bh=pMELV2EHY1s4olryg5HS3dbdlw56dydOjSqV4AnBReg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KbtlHfz271ETG4hoU2q1aPWtZeRCaU6zVGfeDZetgJS7IsSKiGMnccSgPB5/AA7Arxj0IxQIn8stcFmbLZPGCzfRnRyYcGWmWRMrmwmTzlQsMNqaKOSwcijeoUmHPCxR7awOtLyb5PI4nOMk+npp5h/pVltj17uwlidk8fDqk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eUjC8g6O; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pmQvN/9Dfv4IzoRrIrpKUSf9ee8VerBr2wdD0jogigA=;
	t=1745604583; x=1746814183; b=eUjC8g6OpOt4jw48xC+khK9962jCZhjF/uVl1jW9++PNaOj
	Mqqo3jnp36bnNlqvPLsB/BMgxNU2N2mMa/Hy8WObE02EdNz2wtLFsQ6OAB30KiPSTUK1GZs88Mi9j
	ntMsMDpdu1qXVEDmoURVMvtDCdXcUmaCWzfe/yeN9Q+YsuZPst/axIc71dJMNxLF9EKDE6y37YUsW
	9YCRzhyIz2cuFAD8fD7yUK9Kv4cy2+ABqVATw+4x75PhIqt0vexFOCu10D+H4Y5YeirwLyASObkmj
	a4veI6S67rcUEL30tOM5pMlurgfYEziwhndDmsEHd/gpVnFeOva5bUEyG3SeCQDg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u8NUT-00000002FPo-1oRL;
	Fri, 25 Apr 2025 20:09:33 +0200
Message-ID: <67cac31400c485ffee3bac24728fbfe128b73f6b.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 2/2] wifi: Add Nordic nRF70 series Wi-Fi driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Artur Rojek <artur@conclusive.pl>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
 linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jakub Klama <jakub@conclusive.pl>, Wojciech
 Kloska	 <wojciech@conclusive.pl>, Ulf Axelsson <ulf.axelsson@nordicsemi.no>
Date: Fri, 25 Apr 2025 20:09:32 +0200
In-Reply-To: <CAGhaMFO_f_bvFB+39-z6xVF+y446ONwm1ROHQ=rXj=s4MnL54w@mail.gmail.com>
References: <20250422175918.585022-1-artur@conclusive.pl>
	 <20250422175918.585022-3-artur@conclusive.pl>
	 <45b74f9f0831294e783a019cd6a1437fdad4eb6a.camel@sipsolutions.net>
	 <CAGhaMFO_f_bvFB+39-z6xVF+y446ONwm1ROHQ=rXj=s4MnL54w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

> This is commercial work. I am employed by Conclusive Engineering, and
> was tasked with writing this driver. It was done for our internal needs
> (we sell hardware [1] with nRF70 on-board), however I was also asked to
> send the series upstream.

Makes sense.

> Nordic showed interest in this work, hence why their representative is
> CCd to this conversation. They agreed to use our hardware as a reference
> board for nRF70 used in Linux context.

:)

> I fully understand your concerns with maintenance (I am privately
> a kernel contributor as well), and discussed this topic internally with
> appropriate decision making people. They understand the responsibilities
> involved and agreed to allocate time for me to support this driver long
> term. As such, I will add myself to MAINTAINERS in v3.

Cool good to hear :)

> > https://lore.kernel.org/linux-wireless/21896d2788b8bc6c7fcb534cd43e7567=
1a57f494.camel@sipsolutions.net/
>=20
> Bearing in mind above time constraints, I have no objections to helping
> out. That said, this is my first Wi-Fi driver, and as such I am not that
> familiar with the cfg80211 subsystem (hence why this series is RFC), so
> my expertise will be limited at best.
> What sort of help would you expect from me with the reviews?

I'm just handwaving I guess ;-) It'd just be good to see people a bit
involved in the community. Some apparently don't even have anyone who
follows the list and what happens in the community at all.

But it's a bit of a tit-for-tat thing - why would anyone review your
code? Why would you even expect anyone to? The already overloaded
maintainer? But on the other hand PHBs often think that sending their
code upstream magically makes it better. There's real effort involved in
keeping that true. :)

> > That CPU_LITTLE_ENDIAN seems like a cop-out. Do we really want that?
> > Asking not specifically you I guess...
>=20
> I addressed this in the cover letter (Patch 0/2), but nRF70 communicates
> using little-endian, byte packed messages, where each message type has
> a unique set of fields.

Sorry. Reading comprehension: 1, Johannes: 0. Guess I should look at
that and reply there too.

> This makes it a challenge to prepare said
> messages on a big-endian system. I am aware of the packing API [2],

I'm not familiar with it, tbh.

> however a cursory look at it indicates that I would need to provide
> custom code for each and every message (there's almost 150 of those in
> total, even if the driver doesn't support all of them at the moment -
> take a look at nrf70_cmds.h).

Looking at this, I don't see why? They're all just fixed structures? The
packing API appears (I never saw it before) to be for some form of bit-
packing, I'd think?

Looking at how you define the structures and how you use them, I'd say
all you need to do is replace u32/s32 by __le32, u16 by __le16, and then
fix the resulting sparse warnings by doing cpu_to_leXY()?

> Unless the __packed attribute is guaranteed to align the bytes the same
> way regardless of the endianness, and so calling cpu_to_le* for every
> field of a message is good enough (these messages are byte packed, not
> bit packed)?

Now I'm confused, what did you think would happen? If you have=20

struct foo {
  u16 a;
  u32 b;
} __packed;

you will get the 6 bytes, regardless of whether that's __le16/__le32 or
u16/u32. 'a' will be two bytes, and 'b' will be 4 bytes, and all you
need to do is convert the individual fields?

Maybe I don't understand the question.

> > > +struct __packed nrf70_fw_img {
> > > +     u32 type;
> > > +     u32 length;
> > > +     u8 data[];
> > > +};
> >=20
> > making the u32's here __le32's (and fixing sparse) would probably go a
> > long way of making it endian clean. The __packed is also placed oddly.
>=20
> When declaring structure members for the messages (in nrf70_cmds.h),
> I noticed that this attribute has to go before the braces:
> > struct __packed { ... } name;
> rather than after braces:
> > struct { ... } __packed name;

Wait .. that syntax isn't right either way? But it can be

struct name { ... } __packed;

and that's what roughly everyone else does?

> > This sounds like you pretty much built the firmware for cfg80211 ;-)
>=20
> That's because the firmware *is* cfg80211.

Actually it appears to be also mac80211?

> Perhaps I am opening a can of worms here,

Heh, I guess.

>  but it has to be opened at some point during firmware
> upstream. From what I've seen, part of the nRF70 firmware (called UMAC)
> is derived from the cfg80211 project. Nordic makes the source code
> publicly available at this location [3]. I have also asked Nordic to
> provide a matching version of the source code for the fw blob they will
> be upstreaming to the linux-firmware project (I believe I will be
> assisting in that process as well). I hope everything there is dandy
> license-wise, as I am not a lawyer :)

Neither am I but the SFC says you have to have a way to build it. That
might be a real challenge since this integrates cfg80211/mac80211 (GPL)
and clearly unpublished proprietary code ("lmac").

Nordic folks might want to consult their lawyers on this.

johannes

