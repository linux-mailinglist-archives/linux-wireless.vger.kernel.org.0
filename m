Return-Path: <linux-wireless+bounces-29448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F6BC983C4
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 17:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 864A94E1EE6
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 16:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C875333469D;
	Mon,  1 Dec 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="Wh7fwvhJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D277E33343E;
	Mon,  1 Dec 2025 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606411; cv=none; b=kBu2A//J8p9OT++q91Ix1ZXyezkwy7UVhfXCEZCQ+iH5VHYIwkvAL2NsmlzaZ/iD8WgMpN/NWMqFRgE8Pkl1kjUZHOujSDcf5OawveN/IXfCv7252FWopdS1Sjqq4s+s7XrdswsIkbfbxoT0L4J4VgRX6xtl+2aVfOSDxyKdQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606411; c=relaxed/simple;
	bh=xYjd7tbJoh2y06N1DtuzIzlxdeNR0195+Wn0hvKR0ic=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=baJ5BqxWqHS12SLcOALJF9eeefBER0/W6W+OvylMYYKK+JQWBAhukw5jJvHaUwQJam7IlKqsplGOFRG5DUw3IPfbv7zpDiFkrkRJXfsBbkvlDYEnuMDea6ky3cXJhuzUinFsKZiA00eJZbMUAsS4b8DuKcnzJ5zHJbwgYJ0x22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=Wh7fwvhJ; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560+5C/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1764606330; x=1765906330;
	bh=xYjd7tbJoh2y06N1DtuzIzlxdeNR0195+Wn0hvKR0ic=; h=From;
	b=Wh7fwvhJEouVlTgDON3WupDZPYB7g4nvZwcCpS58k42c0vTl077ww5vK8jNWPhvEZ
	 yZXxieNs7zDu7Gzwwfrq5qOcG5gse/vVohNJBOtHzbBNm6Kad04k/nsZdTtE7h7Ugg
	 8yUk59ho8+vq2HHB5E6Z5LG4ZOKu2R4py1wYupLEusmu/8DA4nTUfuBHYoEO9BGTXe
	 OKU0IeE3kFJw1EMdCiZF4YGtrztWrQkkIiXiQv11x42DZg9WTwi4RbT5Ju4KO6QLrc
	 P/BMYHBe4f3B/+XU2wJvwvH6ZDba+5wrrKnB2WHf7sGW/AvnqRKkG8LozFOlwA85WB
	 jF+cuEvPP8OEg==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.18.1/8.18.1) with ESMTPS id 5B1GPSs0006348
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 17:25:29 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Dec 2025 17:25:27 +0100
Message-Id: <DEN0QJT6O8BU.3INUCXH1I0P0F@matfyz.cz>
Cc: "Johannes Berg" <johannes@sipsolutions.net>,
        "Rob Herring"
 <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje@dujemihanovic.xyz>,
        "Andrew Lunn" <andrew@lunn.ch>,
        "Gregory Clement"
 <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth"
 <sebastian.hesselbarth@gmail.com>,
        "Brian Norris"
 <briannorris@chromium.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, "Frank
 Li" <Frank.Li@nxp.com>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Jeff Chen" <jeff.chen_1@nxp.com>,
        "Peng Fan" <peng.fan@nxp.com>, <david@ixit.cz>
Subject: Re: [DONOTAPPLY RFC PATCH v2 0/4] WiFi support for
 samsung,coreprimevelte
To: "Francesco Dolcini" <francesco@dolcini.it>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>
 <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
In-Reply-To: <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
X-Spam-Level: ****

Hello, Francesco,

Francesco Dolcini, 2025-11-28T18:05:37+01:00:
> On Thu, Nov 27, 2025 at 04:29:12PM +0100, Karel Balej wrote:
>> To reiterate, the firmware is generally available but is not part of
>> linux-firmware and the entire process of upstreaming the chipset support=
 is
>> stuck on that.
>
> I'll try to see if any of my contact in NXP Wi-Fi group is able to help. =
Give
> me a few days.

that's great, thank you very much!

I have received a reply from Jeff in the meantime who has discussed the
matter with his managers and unfortunately, they are not interested in
supporting this chip as it's considered outdated and would pose
maintainance burden.

Jeff however thinks that you as their customer may perhaps have more
luck when talking to them.

I am also still trying to find out whether upstreaming the old firmware
version (available as part of the stock Android) would be an acceptable
compromise for them - I never really intended for this to be supported
officially and I wasn't too hopeful about getting an up to date version
of the firmware either (although it would be very useful as it would
likely solve the issue I'm hacking around in the third patch of this
series), I mainly just want to upstream the support for the chipset as
far as possible.

Please let me know when you have some news.

Thanks again and best regards,
K. B.

