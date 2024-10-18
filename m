Return-Path: <linux-wireless+bounces-14222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4239A467C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 21:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53DE1F23D99
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3976020408E;
	Fri, 18 Oct 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sQ54KQRq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aF12Kn2z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC717DFF2;
	Fri, 18 Oct 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278449; cv=none; b=aGIvfUjLjLGTRYahjIuS4J+D0mVTqyqaPcf01dGEM1M3yDnYmYQvvHGgGnyD/JHwltvs8myllFHF0xOC0Mey6GDeDlo326qdVWQQ+qUFoZqf1vVrec9n88joy4dwqgEbLrIn+ibST7shDZSYo4+BVS3ZX+e/zmrXiBSwIauhvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278449; c=relaxed/simple;
	bh=MUCnaqYtp6FUSHYWGi7XpYuc4fm9uYT9I4byykh5jGQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P56shw7p55ZlPYX8wRvCWDzDjkJ0b3NdKXTKMnwP4/ApvlED2UbEqmJPoBR49HWPdvbhD229FhfvG1g6ROax7fY8YKB+dOPmUqQE1fXzlVUgeIuOc/xcTabsZWFjpOm9pHGIdeFLwpZfKRcRSgGF+IiFXk3JUyEOPKCamPUwnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sQ54KQRq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aF12Kn2z; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DDA2D1140132;
	Fri, 18 Oct 2024 15:07:25 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 18 Oct 2024 15:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729278445;
	 x=1729364845; bh=NCDYgiCcmLhn3h92PgqbtX3OsVgoU9rUVw0S8go6zNA=; b=
	sQ54KQRq78Qb5wWyNRN2nGiw2NAttZnMlcO8oKskd1ZsxGWKBPBj+W6BRFYTZBP0
	6wlIuMjm2LReflJ5bm6BkiUZCpvBjZ3jgvAtZSOxdAh3E3trphVYAWYrFda47o4M
	L17jI0OJ5Zz80jWeml6EjIj0ZhQvUQR8XAK9b4zGi7jLxvVefHRQJT6FPFammJZJ
	ye/+D/RJczjj77vveD/RMELcZyGEBpzSXbdhirzgziTUHkL5SceY+6vWG/8JGd6x
	t/wH0A+Fj0Dxu0GwbazH+RooBTCU8NcUR8ZkI07KHBqbD1Oo5IcFFSWEsIxsj1gy
	vXiD3gZQ8teSqvldEC41LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729278445; x=
	1729364845; bh=NCDYgiCcmLhn3h92PgqbtX3OsVgoU9rUVw0S8go6zNA=; b=a
	F12Kn2zF0n/rOiJkddykWFQahiPeQa2JJ0jP7diOCdWozEd8CTrNdB6hfDjgasQ6
	s0lv4mdxqD0PFZZ8iL9LFOiP2GGmHrYi5GSM3Xt9JygPImgAeKP75az+XD5PAaZY
	O/kQ5kW6WfDEA39WgQ0lNyOFbf2kFg+Nn6GcIizDyiHAwnq/yKuKHlW2gC7uhA50
	MtxiIwtYOrAB5AJ/DytxS3NakWK0KYwTA9S+0rj2DhmA8dEaWUhVl9iiTjhunauy
	64HjI92bdEw6rEwjJ5gpzTbPtjUsk+VmyaVHCL0k2qHLZAB4oWsvQvcI6HVeytzA
	b3miTx6ozNpN6pq1Cr/aQ==
X-ME-Sender: <xms:7bESZ8oFHwgzf6XF_5O12erNLSdnTLrB_BGE_5oiWVBOO4PRe6CO8w>
    <xme:7bESZyoPlx7Nkpi_X-kK9n4C7xIGtYlaL0bkFgTqP_H1T8ZdeZRRJRUQMv_kccKnl
    u9YtWtm512zcKxO5d8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhhjrghmihhnrdgsvghrgh
    esihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrghgrsggrhiesihhnthgv
    lhdrtghomhdprhgtphhtthhopegvmhhmrghnuhgvlhdrghhruhhmsggrtghhsehinhhtvg
    hlrdgtohhmpdhrtghpthhtohepghhrvghgohhrhidrghhrvggvnhhmrghnsehinhhtvghl
    rdgtohhmpdhrtghpthhtohepihhlrghnrdhpvggvrhesihhnthgvlhdrtghomhdprhgtph
    htthhopehjohhhrghnnhgvshdrsggvrhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohep
    mhhirhhirghmrdhrrggthhgvlhdrkhhorhgvnhgslhhithesihhnthgvlhdrtghomhdprh
    gtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhvrghlohes
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7bESZxOJCRwtSaeZyCfnsKiRxSLH5JI8Mujmca_qH3rFMzxo1XhJVA>
    <xmx:7bESZz7bnZ0Z0G9nMI_nDJ1xDbIg4PFBhTlDaJL1XM5t9PXDjHpe6g>
    <xmx:7bESZ77RmwxuHnX3dg0Pwy_qGfTB05CCpcNIjwTyfMjJ6ANZgcsUEA>
    <xmx:7bESZzie1_yxdMcPZPZgDwfFu4ji35sDH-Uz-sWT7q1PNpjQG0impQ>
    <xmx:7bESZ4xPskXTfyF2OGcQ7GlehuKXf_PP7Y5BGImr_qG3YDPvdhyy6-Ym>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 81B0D2220071; Fri, 18 Oct 2024 15:07:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Oct 2024 19:07:05 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kalle Valo" <kvalo@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Miri Korenblit" <miriam.rachel.korenblit@intel.com>,
 "Johannes Berg" <johannes.berg@intel.com>,
 "Emmanuel Grumbach" <emmanuel.grumbach@intel.com>,
 "Gregory Greenman" <gregory.greenman@intel.com>,
 "Daniel Gabay" <daniel.gabay@intel.com>,
 "Benjamin Berg" <benjamin.berg@intel.com>, "Ilan Peer" <ilan.peer@intel.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <d78b5354-b265-4e45-9a6a-996273026402@app.fastmail.com>
In-Reply-To: <87a5f1qtts.fsf@kernel.org>
References: <20241018151841.3821671-1-arnd@kernel.org>
 <87a5f1qtts.fsf@kernel.org>
Subject: Re: [PATCH] iwlwifi: work around -Wenum-compare-conditional warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 18, 2024, at 16:06, Kalle Valo wrote:
> Arnd Bergmann <arnd@kernel.org> writes:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> This is one of only three -Wenum-compare-conditional warnings we get
>> in randconfig builds:
>>
>> drivers/net/wireless/intel/iwlwifi/mvm/sta.c:4331:17: error: conditional expression between different enumeration types ('enum iwl_fw_sta_type' and 'enum iwl_sta_type') [-Werror,-Wenum-compare-conditional]
>>  4331 |         u32 type = mld ? STATION_TYPE_PEER : IWL_STA_LINK;
>>       |                        ^ ~~~~~~~~~~~~~~~~~   ~~~~~~~~~~~~
>>
>> This is a false positive since the code works as intended, but the
>> warning is otherwise sensible, so slightly rewrite it in order to
>> not trigger the warning.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Is this and the other rtw89 patch for current release or -next?

Up to you, the warning has existed for a long time at W=1
level, so the patch applies to current and stable kernels
as well, but it's not a regression or particularly important.

It would be nice to turn on the warning by default in 6.13
once the three patches I sent get applied.

      Arnd

