Return-Path: <linux-wireless+bounces-23422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F3AC3DD0
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 12:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 401A07A71AA
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616601F463B;
	Mon, 26 May 2025 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pFIHv5KW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TVV0urUM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FCF1A2389;
	Mon, 26 May 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255144; cv=none; b=WPflRkCjQ7UYROvEY5G23G0QFp3Bv6ky0BeHJP/Vd2yTgaKhZojumJ/oe623c9cjkllm6So0TwTvESgvbyRCyKDuZm3GnWIiCFnNrP2K1FZbD2HOuc6q2CzSOYUWM3bvKL0GQlhRQwjt14tT6CiV/tznlLueeO/DMocHr79l5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255144; c=relaxed/simple;
	bh=wpYpfRibajhbsBFIKajU4Wqv7umJK6VTaJyKWuxTIzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLutzMumI7jBOOZQZRQAEGnmPWXfcMAzAW4XlUGSYjM4XtZGWTCEHsBxifdmL1wpRxLyuZVodQY5ZCzfuLVQudFiSCoJlsUDBVIUroapf8A3Ddoftj/tiP/qu456TYVEDC7yuiCrLdjYxtKlPzkCaRQAiRjzMrr4XxbRHsSlcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=pFIHv5KW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TVV0urUM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9DF452540167;
	Mon, 26 May 2025 06:25:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 26 May 2025 06:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748255139; x=1748341539; bh=gUmwzWFa+K
	A3n9fwudnjTG7WQzrbdsSG+HVDrsGvcUg=; b=pFIHv5KWvYsXr6TdntGmH0whSD
	NyHkFouvTbXEMiYmtH7E5disSOWhY/Qz1aDogJIdZQguZntLGeLtIz2xnBjoqR43
	Iu+BoisoN3X5A0If3lMaPy576V680ikfhIKoXxpZkG6p1r1Yawi8QCc7+Pt0JoDD
	kYK+5oZ6OFwUgu/CKxbOSQyoXRqXBD1K9ZTzPdgrspHJhximFi6w+4+66O26wlkF
	Jn1H1vtM9oAF1k7Tzs18A0y01V0gg7Z34b8YK09JaFNabac0dEzqqf3Ka/JS9Pnq
	5gRUc97Nh+yk/SHbqm3R5xbGv8sYllGNGMzHQgKF8ELUWaF4x5+FmjPvuL7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748255139; x=1748341539; bh=gUmwzWFa+KA3n9fwudnjTG7WQzrbdsSG+HV
	DrsGvcUg=; b=TVV0urUMT9sueGK/I4GJriU9pVidd5py0kWVH70znExO035oXjF
	PzhvXOYwRTGKEs5vLC+QX4uihOcAkFRmQCRHb59H3Y2lWkwHKqFxL+7rWecKMZOC
	OTXBch/II4fNBFJ4DhTaOGR5xOJ+fXBRqKCSQ6Mjc+rB3FWEZynlCEjyGS4FBRmU
	WbyhUezzOXqfxhOcDeVQq546sj/8uOaYlneHcFjCisDYMg7oZEG/cLtU+jJL0xmF
	O7CXnfQhcHjKFWBuTHNJYWVvKz8dXUydhSGI9wRCqZIWhc1baSGdS2MrJj+bnaLT
	GoC8Rh1YJ74F/IxN9hqepdRqH4sHdMjnqHQ==
X-ME-Sender: <xms:o0E0aDBxORqq41Z83fuJ3tfE5Ksc2dA3DDrytT7aCbI5EB4QHGSCrw>
    <xme:o0E0aJhtXAYPpD3im_YLIckWdSkhsOzN9doN114wBy1jfeMxvb7oHKOVMjb2ALKYF
    b9NbGpDA1mG3g>
X-ME-Received: <xmr:o0E0aOmRUY_-3qC1lsYlJi4363RmhwFbmW0RvivykcVVk0iByY46dNJdLhJhWOyUhM46wsuXvBYIja_CWkIiT54pGrG1ClM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujedvkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrh
    horghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeel
    tdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvsh
    esshhiphhsohhluhhtihhonhhsrdhnvghtpdhrtghpthhtohepvhhulhgrsgesihhstggr
    shdrrggtrdgtnhdprhgtphhtthhopehluhgtihgrnhhordgtohgvlhhhohesihhnthgvlh
    drtghomhdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:o0E0aFzigSSPMX0FH0jZ62rED7Sn0UC9CqT6quXhb0Wq8QgXVSKemg>
    <xmx:o0E0aITNv-0GZPhVRNKg2KU2GN03vjHO8xUdcpRqH8eI7qktwlNeuA>
    <xmx:o0E0aIa15ftg-kZfvx2e8OVI7Ymd70TZ6Mo7JObAE6vt984q7Q3yPQ>
    <xmx:o0E0aJQ_CqCYG9-JmU5K95iw083XGBBm-iUNt97Y9dOeCiil4yxVdw>
    <xmx:o0E0aLnY8Z9KugFS96NezSYwlFaAS0T5sLEEDCsMsVrsb55A2v_VVDUd>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 06:25:38 -0400 (EDT)
Date: Mon, 26 May 2025 12:25:37 +0200
From: Greg KH <greg@kroah.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Wentao Liang <vulab@iscas.ac.cn>, luciano.coelho@intel.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mac80211: Add null pointer check for
 ieee80211_link_get_chanctx()
Message-ID: <2025052607-hertz-duly-cca2@gregkh>
References: <20250526091903.587-1-vulab@iscas.ac.cn>
 <2025052614-spring-ether-8d09@gregkh>
 <2137c5905fc87e80698e6578ebf360be6d899f6f.camel@sipsolutions.net>
 <293fe5ea564a98113443bbe93e6022c5bb6dd747.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <293fe5ea564a98113443bbe93e6022c5bb6dd747.camel@sipsolutions.net>

On Mon, May 26, 2025 at 11:56:16AM +0200, Johannes Berg wrote:
> On Mon, 2025-05-26 at 11:50 +0200, Johannes Berg wrote:
> > 
> > I still very much disagree with you and _will_ keep adding warnings to
> > the wireless stack. This would be one of those places where it's totally
> > warranted, because it's actually impossible that this happens, for it to
> > something else would have to be changed to go wrong in how this is
> > called, for example.
> 
> And come to think of it, cases like this are exactly why some people
> decide to crash the system on warnings. It's things that the developers
> thought were impossible, but should be double-checked. If we stop
> putting warnings on such places, then the decision to crash on warnings
> becomes entirely meaningless. So seems to me that just lashing out
> against warnings all the time is actually detrimental to the intent of
> such configurations?

If you can detect a problem, like this, and properly handle the issue,
handle the issue, do NOT crash the machine which causes the issue to be
uable to be noticed at all (all that is noticed is that the machine
rebooted.)

Only do a WARN() if this is something that you can not recover from for
whatever reason (data is lost anyway, system is hosed, etc.)  If you
just sprinkle these WARN_ON() calls around to be defensive in the
programming, that's counter-productive as you are setting yourself up to
make angry users of the system if they ever fire.

I have no problem with logging the error/issue in the kernel log, but if
a wifi driver decides to panic the box for something that it did
properly detect and could handle just fine, that's just not nice.

thanks,

greg k-h

