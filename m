Return-Path: <linux-wireless+bounces-15014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229B19BF66F
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 20:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99407B20DDC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 19:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875F620968D;
	Wed,  6 Nov 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alfmarius.net header.i=@alfmarius.net header.b="I8jIXwmS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/d9Bv8s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F920967F
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921284; cv=none; b=ut6XXJNY4tyipfS3Z3lP8jLgrv3RXDppPFpIAbR9ZZOAnxYk9fRD4VgLtKnCMt+bZGRTbabqkIz2Mibcr5VNUiLXY23AgLWu77KzGPBbj8yMxpZLYVbPxTEiwLWRSKgbUG52/BGbHKrm55oi1EZqAeF8pI6Zzi+S0BqSJOchAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921284; c=relaxed/simple;
	bh=tlM/sZHStcrCKHsoFfOWzATgeMBo+hmNY87ZzsaLpJk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JI5Imp2ulHhwJsefhUpLMYfZp7XvPQJp1jnZCwfEp70ToJKCwmTvkegj6/zLXdpWBRGrDCI9zfKsFWBDsCozYLqS1390AmJ7PJdFENqGjhx4a7Ti7M+a6XrnZ0B3EbSUJ5Bj6kCL8JLZbXU1wohWOYO09NDhnYaVZ52b641SUs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alfmarius.net; spf=pass smtp.mailfrom=alfmarius.net; dkim=pass (2048-bit key) header.d=alfmarius.net header.i=@alfmarius.net header.b=I8jIXwmS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H/d9Bv8s; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alfmarius.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alfmarius.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B4BE254019A;
	Wed,  6 Nov 2024 14:28:01 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Wed, 06 Nov 2024 14:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alfmarius.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1730921281; x=1731007681; bh=BaEaFKaTnG703b9BvW3lVoDkejMPTTOS
	KfcihRJehvY=; b=I8jIXwmST4yh5uc1VzhfbX5ScuZooT75pgazQ2nZ1CQ01lng
	7FIoqt9aHJN9A9ym9CTHJhhEK5lchSFC7IAn23R7RzV3ZHBIhL6WYmM9CowVyBhv
	OsyAOquSydHrZGrAIj09MzYzcOrGOTnUGMWCRhr7J3115TJuZ7e/EeQJnWf4FcK0
	UKl9YTYkK03WHyvr401Fs3cmTf6l1zQY5jpXuBuoJiyVG6JbTsZAuxyA5GgjWFB6
	9ugmhoV21mBepDd2uMDf13ZBW961aTuCbgUzJatckLtlEU9vJz7RPYM9SDzoBxgM
	VR1Hsirmsir9+cuQx6Vrg5iMNTbsX0zfER5Q2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730921281; x=
	1731007681; bh=BaEaFKaTnG703b9BvW3lVoDkejMPTTOSKfcihRJehvY=; b=H
	/d9Bv8skKtcyi4DpqIUTzDqJ1A3HnFxid6My2EDjBoBQAc32oLwsGgXwQ1cqN7NA
	7erHq+JVLfa99xrdeNtrsHKnAQBqbND4ZUdA9KHOWzrKaM48PDNBJtkeE76acntE
	hCOuBPqf/+OJh8fqGrsjczklCqD4jwPqaDKt9nWw42AX4yf/PLGsxGuhkigVmDEk
	bMwHa6k+wEBoTU31YUA2HCvNCYP/rganO+74R5ZUX8cB3FYZ/NT7pyS4Ieg+AqsQ
	HfcGEzPd2ryKadgBmOTsgIFHo/Tx7ucRQGkwZhMnzGG7KjrOtCPJk8mT1wGpoPXc
	Ie4xihFt6LwMmGBbN/9Vg==
X-ME-Sender: <xms:QcMrZxgOleHOuu3Df8xUa9fL6gsiRM1i5UunMsmSDRnNKVmWsoLKrw>
    <xme:QcMrZ2CsNg3LMooFydswJQCgBTuEKTx4RV9hc_uxk-LGEQPMEOXZdI5SK-9vU8h-B
    p9bqwHXS3pJfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehlfhcuofgrrhhiuhhsfdcuoehpohhsthesrghlfhhmrghrihhush
    drnhgvtheqnecuggftrfgrthhtvghrnhepudehhfetgeejkeejhfehvdfftdehgfduteeg
    hefgffehteeggfetffelvdejfffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhoshhtsegrlhhfmhgrrhhiuhhsrdhnvghtpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghthihivghvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhvrghloheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprh
    gtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:QcMrZxH9Bd8QWgy4QEHsZuoSTPjcnG0vczHLzs2QR7ztlV1c_j7_LQ>
    <xmx:QcMrZ2RyeaWoJ-Rqz23OJLWC1Sco_hBUQ2AieJxac4ZQSzGhmqYNVQ>
    <xmx:QcMrZ-xQ7_mby2zfYe63c5HVMyQoQ8VlLq1ye3618Vv6cfxrWPNWuw>
    <xmx:QcMrZ84YEDAuQdWkHm90yDFTJJbG40FiAkh1I_27iRdHSP_3W6s8aA>
    <xmx:QcMrZy-K6Z6gaPnmU8yJc_OBWPKYTRGZELaPfMSf9tQjX0n9eEGOB0Bc>
Feedback-ID: ib5844192:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 25D4C18A0068; Wed,  6 Nov 2024 14:28:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 06 Nov 2024 20:27:40 +0100
From: "Alf Marius" <post@alfmarius.net>
To: "Andrey Batyiev" <batyiev@gmail.com>, "Kalle Valo" <kvalo@kernel.org>
Cc: regressions@lists.linux.dev, linux-wireless@vger.kernel.org
Message-Id: <4f689121-f2c1-45ec-bd5b-105a770af935@app.fastmail.com>
In-Reply-To: 
 <CAEQQxWx7PXw3O_j1FWn7G+DhUUXt3sEB0qDyA2+udRQ6r28FUA@mail.gmail.com>
References: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com>
 <87wmhg61yp.fsf@kernel.org>
 <CAEQQxWx7PXw3O_j1FWn7G+DhUUXt3sEB0qDyA2+udRQ6r28FUA@mail.gmail.com>
Subject: Re: [REGRESSION] The iwl4965 driver broke somewhere between 6.10.10 and 6.11.5
 (probably 6.11rc)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Good evening folks :)

[Andrey Batyiev]
> Hello everyone,
> I've only tested it on my 3945. I have no equipment to test it on 4965, sorry.

Yes the commit message says "Tested on iwl3945 only."
..which I did find a bit strange. Is it normal to deploy code to the mainline
that is untested? Why was this also applied to 4965?

I'm just asking questions here, as I have no direct knownledge of C or
kernel driver programming. I've 20 yrs of web-dev experience though
and know from experience that shipping untested code is a bad idea.

Anyway, not trying to point fingers here! Just curious to find those who
wrote the actual code, maybe get some info on why this was added
and if it is really important. If not, maybe a revert is in order

Regarding testing, I obviously have a laptop with the 4965 card and
I'm more than willing to test stuff out if needed.

-Alf
-- 
"The generation of random numbers is too important to be left to chance."

