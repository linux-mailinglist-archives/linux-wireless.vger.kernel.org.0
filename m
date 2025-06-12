Return-Path: <linux-wireless+bounces-24081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B59AAD7B62
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 21:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB6C3A2972
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A085A2D1936;
	Thu, 12 Jun 2025 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gclIacj1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oXtljNtx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6101F5858;
	Thu, 12 Jun 2025 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757768; cv=none; b=kUmNLRXGEsj8Oet7ZGM1XsKDTmAWAYqAILZxje6AcVMe+0q7y550IQTbM+GLOV9E9KXdq3aPz6NW7IXSXSdBlM1XQV0bG8pl8wEbsQGHxCKukG27xRnBwH95ynPKKb2arG30Ksiifw2lLNhjiqFablGcjYFarWnDAq38FmZp2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757768; c=relaxed/simple;
	bh=gTjzw7DYnMfcfeme9pufjEyQVylrAdz2sEZRJifMjq8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V37irDY0hEZ0OA7VNpVAChOjgZulWZPU1QA4nuTFBzKRU1qbEfQU/YUu4UHTl6ufix67hH9cGBtLqaJvRr41Co8JbGWHBu1ddhERi1jH9GaZNtJviU1lH1W6/oM0bB5pWD3TunKcSnJ2vvRWD6GmqDlZLORfD4CDg3FMvoueFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gclIacj1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oXtljNtx; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2383711402D4;
	Thu, 12 Jun 2025 15:49:25 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 12 Jun 2025 15:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749757764;
	 x=1749844164; bh=xu/b7phdvNJx1K04NsqpXKd/hD3Y6fbxZ6wAb9spphk=; b=
	gclIacj1SuZZUcbY8iXzTAtIQgtQu4eFRJ2RwDNUYg1rEldPaQ8gb0VdWJhtpMwS
	wlMSwuDCdttJxrVdWbxkyVthnTH40is7IHW1ZhS9HLrgckbpa9xObZ5IWjK8GTPC
	i1RhedyGlJVOUUgpQZxGD3P3sjoSqmYhct8s13BuFw9y2wOwSNurCoBrHhNehBP2
	cVnLx1PxqSj6aaTog/QxaNGxk5hawZz7zE8Ojho6MgEIzPvrUVU/C5CzfgGoUnFD
	YWvpg3TQc5qy0bISq4tvYtqa8ylEBJbAclgUCutfznc1RyZFMQ+etRLMkTSub/z1
	DqEAJX7ymHzCC7cro33AIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749757764; x=
	1749844164; bh=xu/b7phdvNJx1K04NsqpXKd/hD3Y6fbxZ6wAb9spphk=; b=o
	XtljNtxF/QxGSyaGKAbc1KLSWCORNof4i1Fej6pOnn34HIbvhtDKFxbkqHce1Blo
	cfs7uK7nArue7C+v6D+ZdA2b47sXDQoPG5672P7G4qJGrqRodr2WyJxdm0YA/PEM
	Ra0ySXucMtsa4vzjk3XX48gkm27h9LNk3582c+kq5P//f4DAusbpJMiKTJbf6sEt
	wHsKXE0cz4gMPFiT3+0/YCYQHhujx0ZcMPTTK7YMDATpwZ2QkcLtQBXhxhS5EQ2z
	fKmFI2vymYIPdT8R12OFGrSIuvugcNIpEUHAfI6S4/RcgaI1d5eq4IeT4hbUCVmZ
	MVKmv6NHTRNqtDxKAguwQ==
X-ME-Sender: <xms:RC9LaEKUfD3SbFyWXRVqnXSIm_qDuH3VSVBkjhfuPCz0fgfrDpuDCg>
    <xme:RC9LaEKIDEyhPHKtXO1QMX0foCUw8ECbKLL6fUF_Lu2n688tXuljmme297tU1Mvfj
    hbrdq1Ug2bgqyj1hIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhrihgrmhdrrhgrtghhvghlrd
    hkohhrvghnsghlihhtsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghnuggvrhhsrdhr
    ohigvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnth
    gvrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhkfhhtsehlihhnrghrohdrohhr
    ghdprhgtphhtthhopehjohhhrghnnhgvshesshhiphhsohhluhhtihhonhhsrdhnvghtpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:RC9LaEuo-XPjUqyHwkurDvht5JriWzd0IS6UbyuEm4yuePIULp1F-Q>
    <xmx:RC9LaBZ2hyJTEobshnQHkbR8NvitzyfxonacpeblJyiRhbFy1hU5Cg>
    <xmx:RC9LaLbPUJQlq5KRcLaTGf4xsgt0t-hRbeSA26gCAp1-zXtM0Grhhw>
    <xmx:RC9LaNCQtJFadscUq2nywzFtViGAERoEojM_lSQLRtPRrPF0KKTTzg>
    <xmx:RC9LaHSMIs2ZGGoGvusXxzlKjv3_5yJ0sfWnDxaKBIKfVuFc_3_ncRYx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B5D1E700062; Thu, 12 Jun 2025 15:49:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T781adb4479eb08a1
Date: Thu, 12 Jun 2025 21:48:41 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anders Roxell" <anders.roxell@linaro.org>,
 "Johannes Berg" <johannes@sipsolutions.net>
Cc: "Miri Korenblit" <miriam.rachel.korenblit@intel.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Linaro Kernel Functional Testing" <lkft@linaro.org>
Message-Id: <ee7559eb-c26b-47c0-bf4c-f710e010a21b@app.fastmail.com>
In-Reply-To: <aEsrmH7sDVvsmgLs@monster>
References: <20250612130719.3878754-1-anders.roxell@linaro.org>
 <d2ea3f77ea2737aafc879f4fc291dee097867b61.camel@sipsolutions.net>
 <aEsrmH7sDVvsmgLs@monster>
Subject: Re: [PATCH] wifi: iwlwifi: pcie: ensure RX_QUEUE_CB_SIZE fits bitfield for
 gcc-8|9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 12, 2025, at 21:33, Anders Roxell wrote:
> On 2025-06-12 17:21, Johannes Berg wrote:
>
> Would it help if I indent like this?
>
> +	/* This should just be u32_encode_bits() but gcc-8 and gcc-9 fail to build */
> +	control_flags |= FIELD_PREP(IWL_CTXT_INFO_RB_CB_SIZE,
> +				    RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) &
> +				    FIELD_MAX(IWL_CTXT_INFO_RB_CB_SIZE));
>  	control_flags |= u32_encode_bits(rb_size, IWL_CTXT_INFO_RB_SIZE);

I still find it odd to mix FIELD_PREP() and u32_encode_bits() here,
as they do the same thing.

      Arnd

