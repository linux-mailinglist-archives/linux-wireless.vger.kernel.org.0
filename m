Return-Path: <linux-wireless+bounces-35638-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGITI9U88mlypAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35638-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 19:16:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DCC498158
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 19:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 696B23013000
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC30410D21;
	Wed, 29 Apr 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cj2kWvNP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0E402433
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482962; cv=none; b=Ejd02Nt5B6fKmdP7+BRC1tvGW9MiLKkRKWVHrftluy3OlX4eH9RctiI/fpl2zWOgI0Bko3kUVuGZ/0HaHpx70ymsOrLwURn9Poj722dx1AFXqxL3jtxKLwRubOcDtYjKLODiLiVJ+q3mhDdjdzxZatnIOlPAs2OV3TzACEvzuQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482962; c=relaxed/simple;
	bh=b8BmgDQogRwggORM8K4eREtWvgZJXefpsvQX1y50FaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLdeD09iu5kFBHSgdDH17l1mjKgPLegtjlxULl7Bzolh1aTTrePKh9y14b3igLKZlwXshqfoExyKjHpQ/4Wz1OMiDqIBUzB7WOqeCEDYlwazICK8OAIUvQ1X/4dSuvJQzo8kp6j8ZACKNcB87MPxK6fFFH+zVLZcH3kPIov5ZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cj2kWvNP; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso5323870c88.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777482960; x=1778087760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0rzy3HW8rz3SXfIkHgjI2UdkxSDPn+w/155JMT4UN7g=;
        b=Cj2kWvNPSZ8mFDgOVB9IQEtQHM1eqS27Yp//bGwnOK4bEjekHtTi+lUngWTFwqciYe
         9HD3EuMMV4lgNLYbuZeJ1k4stTstVnGZpcDBxxuUhBjRnbdoy7TTx0LCRivEnS8oH4jV
         bbcuYLe8HiPyalDNy7zruBgWoLbUCw3sMSvl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482960; x=1778087760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rzy3HW8rz3SXfIkHgjI2UdkxSDPn+w/155JMT4UN7g=;
        b=j0gkZkkfOarQ4yelVxDcWjzfyY48jYxUQEJYD8dqfAoI+d+7noFtARwRv5YGLDqI/s
         u4/rp4a2/qSLeGvYvYguHL5D3QY6vjI/gkmo8FLIjYR+EVzqXS2Tmaz3mGnf+9B7PnhK
         DFDygP+pKy5IwCClLAkK97RT4UtZCnqylXPvCenP5RedsWG4a3Dk4QxuHm/U07tCtYXp
         /3lBvbtJUcS9+VoQMvdsTVzMSWcyUC3FKJU7V0P9mYyZsJ3srRFGlend7Q4YndIhoFIW
         x+kfjFEkt3EJ3IfJtm3pfVJDLPlbsN1+KkwBW7zSPHb/OHucE1VIwDDF/aDgQTFIxRwD
         tJUw==
X-Forwarded-Encrypted: i=1; AFNElJ+GKsXMCv7ivc3oxMaWIhSFT+4q6F2npeog6k8dQ6IhqkKwI7ruH5HR4rqHFpwR4exaoDPH7u8oMqjOt89WrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT40ldFk7LGgAgMWfcXqTeCpqfwnYH9hMnac/VYHtqkiX4oT8J
	P/O9AB/e4pJhRRyA/PxYbD5zPqsibkAWrbc3lfdYROXwQt4CI7t+rGAmwIW+KwOaPA==
X-Gm-Gg: AeBDievhIim3vSQB9ayeVQsKZ3YTRG+3XgYRoMpnuc5a9JG1Kbhefd9/QCVo74vuaKp
	FIXacnQmomNfobCNcdVJOebpwguLeztWiagpUQAXLvfzbhhSUIFCjp2y97XUi2yeC9vfjJ10H8p
	F/J4fCUvrVKXYVfxECkapLnTAkwOFrm/jI9xUiYTZJDdG5e32/cXPU3mXimi2rhNLkm1cWyl4z+
	MgFFuH4E7hKRtWUoSsdI0BLgnBLh9WE4cXzMVllGYYkXV8xjwOyaCYoNtDz0NLDtdtriF/uYW3I
	+HYTmw4qJaeUMinPkYWVX1sUG4BMiPJ+wxWMdMBIrAfDJFudUAcn9ivQ26oOTsVHMbzXBM02LFV
	B4kPEJdIdUQ24KMcUknn3u0XLnR3fArkBeifEF4CetIiVX57JpJdBcKI6afQHRr7XFM/JzHdQU7
	leGPiDpfXMk60JhzSmgxmtC1oIdv8eus3ZQz66WB90CIyohSe9f6y7l+VJOzY7kiLANbgDB3cj
X-Received: by 2002:a05:7022:f8c:b0:12a:b39a:339f with SMTP id a92af1059eb24-12de2a546bamr2101891c88.21.1777482959913;
        Wed, 29 Apr 2026 10:15:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:b8df:3c88:ad8d:d3d4])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-12de32178cbsm2889982c88.6.2026.04.29.10.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 10:15:58 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:15:55 -0700
From: Brian Norris <briannorris@chromium.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org, Jeff Chen <jeff.chen_1@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, david@ixit.cz
Subject: Re: [DONOTAPPLY RFC PATCH v2 0/4] WiFi support for
 samsung,coreprimevelte
Message-ID: <afI8y70U7wFT_07h@google.com>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>
 <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
 <DI5L100Q1RKO.1A68EJIPWYSRC@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI5L100Q1RKO.1A68EJIPWYSRC@matfyz.cz>
X-Rspamd-Queue-Id: E3DCC498158
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35638-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[dolcini.it,sipsolutions.net,kernel.org,dujemihanovic.xyz,lunn.ch,bootlin.com,gmail.com,linaro.org,nxp.com,vger.kernel.org,lists.infradead.org,lists.sr.ht,ixit.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briannorris@chromium.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi,

On Wed, Apr 29, 2026 at 12:55:23PM +0200, Karel Balej wrote:
> Francesco Dolcini, 2025-11-28T18:05:37+01:00:
> > On Thu, Nov 27, 2025 at 04:29:12PM +0100, Karel Balej wrote:
> >> To reiterate, the firmware is generally available but is not part of
> >> linux-firmware and the entire process of upstreaming the chipset support is
> >> stuck on that.
> >
> > I'll try to see if any of my contact in NXP Wi-Fi group is able to help. Give
> > me a few days.
> 
> so I was in a long conversation over the past months with Jeff from NXP
> who was very helpful and tried to arrange for the upstreaming of the
> firmware. Unfortunately however, his efforts were ultimately rejected by
> the internal management.

:(

> We were directed to try to reach out to NXP via the customer support
> page which yielded nothing. The current situation is thus the same as a
> few months ago, summarized in my quote above.
> 
> Brian, what are the options here now? Would it be possible to make an
> exception and accept the patches without the firmware being in
> linux-firmware? This is an old device with no mainstream audience so I
> expect everyone who will want to use it will be able to supply the
> firmware themselves

I'm not really in the business of writing rules here nor their
exceptions. I was just pointing you at the existing rules, and how this
seemed to violate them. Since the websites have moved around a bit since
the last time, here's the page I referenced:

https://wireless.docs.kernel.org/en/latest/en/developers/documentation/submittingpatches.html#new-driver

I suppose maybe those rules are there so that we don't get drivers with
*no* legally-usable firmware, since it's about "New Drivers". This is
not a New Driver, so maybe that part doesn't have to apply.

I suppose I'll leave it up to Johannes on this part, and may be willing
to retract my NAK [1].

> and it would be great to not have to keep the
> patches in a fork, especially when trying to build on top of them
> further (such as to fix the driver-firmware incompatibilities discussed
> in one of the patches of this series).

Patch 3 is a different story. At the moment, it's definitely not
acceptable. But I tried to provide hints about how you can write proper
FW compatibility logic. I'm still not optimistic that'll be easy and
maintainable, and we still reserve the right to reject patches if they
make things unmaintainable.

(Marvell clearly didn't do any real work here on maintaining good FW
compatibility.)

Brian

> Francesco, would you perhaps still be able to help in any way?
> 
> Thank you, kind regards,
> K. B.

[1] I think you're referring to this:
    https://lore.kernel.org/all/ZUQN4Ua8byy-Fsy8@google.com/
    Re: [PATCH 0/2] net: mwifiex: add support for the SD8777 chipset

