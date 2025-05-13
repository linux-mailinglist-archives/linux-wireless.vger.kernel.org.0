Return-Path: <linux-wireless+bounces-22915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40082AB5708
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 16:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780A6189DF02
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4793A2BD00D;
	Tue, 13 May 2025 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="ffyAO/8y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DgVCmHeU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF321917C2
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747146310; cv=none; b=nqBxAi3TTvwijyWO53t7WL3esHtmyqA0TB3PNpYMJvcDQgDveKALHkD5Je6X1E3IyrPMQK+jdbtQWHNiG6z5xvjfehAEJY7hnFnYA5i8+ahODRiWSjiCTzYAHoIbDuLThcrNYCsC+KtFgD7R1hEoo/BWBrJLhVV0dzy7EEPV8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747146310; c=relaxed/simple;
	bh=lmx8RgUTBI6bef6A2gfjZF76O+7zIgQlfyMg9m44diU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKmxmEIqkQbbh4JXKOZXPD9eBsGHyv361EMBrN+VSpULjmHfC+ragEvLf+7WE1CYKzGbpNkksjD85LhRg9vx8+HyEVYfvJcM9w/IK51WnG/iZY6LXpz6N7aIV6eWh0ib+ZvhnO4dFsUUChQrwKI6VTdRFEX9xwW9J+qEE/AfKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=ffyAO/8y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DgVCmHeU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C7CD2540163;
	Tue, 13 May 2025 10:25:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 13 May 2025 10:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747146307; x=1747232707; bh=vCtF7YhDgs
	2WZWiSSactKcsJ5qKSu3nmlt5/29u6k0E=; b=ffyAO/8yMGLrQUq+pGd4/wUF+N
	lz86FfW4EEiZ2hJJ5mjiATQYsakNMRcy1+ymsJxDUkc4Tt6vFQPlPcI9e9nXuhsC
	eEv/ygJeQGdf7tM1genaXXqUR5Wqfk8KKkRM14EjkJmvcFHHuGzJuDnxdBwKfINc
	t/D+QrVEso37fWWG+kZZ9EzGpDYkd9sSiLjsUGkZUI1ANKBq3cv3F6Kcij/9b3YB
	28OXk5wxSa5BS9uDwDjZ/ONy3qY5OuciC1C18VOt6/zMZlrzlR1+GCuK4KFLGf0E
	ulSnWc6m0E+H1PuQiWtu7UCmhzS72Tg8mUa6tPIHv3JFz1eup9Vb81hWkZSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747146307; x=1747232707; bh=vCtF7YhDgs2WZWiSSactKcsJ5qKSu3nmlt5
	/29u6k0E=; b=DgVCmHeUbM/fHiujxkrxpp+LqHw8Qy3H4I4xaAQpmCb+KEgkCDT
	gnMhSURxStxRAFinovHFQX+xxDKSabhwserpmXr1gOp90JHtZoxFTwEqi1T0gHlx
	kPzLGrWit3pLdT9CumOzjUGwb8UAk6qiSOKnH9qJfPJWBMRrBm3UACSnZcU9/swG
	e0q5HLW8uoFLCRa7ynVZxugfpvthzAHjZqUE5tbjw0vlpl1ld62kSSZYEVSP5WqZ
	VUcdgMETq+WwyN6Tx0mQjpKOjNh6kmIzee5G6AEi8ItfUv/SD36g6fdlZVC4mfFK
	glZ0YEgaxTcq5XzcmN6rFdUB9EWZYbw28jw==
X-ME-Sender: <xms:Q1YjaGxgXcwUeDL9vwLRIZGqXFxAg-VX3cBtWJzv8lDRSrltyk2sQQ>
    <xme:Q1YjaCQy6bsUr8NuzRaWmMEfqANqQqntoVymJW8hZJwWp3KwhL6oXvXhJ9j2QDxvy
    i0F65hRNzPJCInKHN0>
X-ME-Received: <xmr:Q1YjaIUJ5-0C3GTZNHOuzeVsGlqWVxwrirgCiiPAKq-7uomScoznyedF9-ct-j7abdqKFJJbCV_vnJNrjAu0RhrFzPBX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvvefu
    kfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrg
    hrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeeugfet
    vdduiefgkeelgfettdfgfffftedtieduhfduhedvvddtveehtedtieeuheenucffohhmrg
    hinhepphgtrghpnhhgrdhithenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehkvghrnhgvlhesjhhfrghrrhdrtggtpdhnsggprhgtphhtthhope
    eipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghnkhgvnhiisehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghssehsihhpshholhhuthhiohhnshdrnh
    gvthdprhgtphhtthhopehprhgvshhtfihojhesghhmrghilhdrtghomhdprhgtphhtthho
    pehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmihhrihgrmhdrrhgrtghhvghlrdhkohhrvghnsghlihhtsehinhhtvghlrdgt
    ohhmpdhrtghpthhtohepihifugeslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:Q1YjaMj3az_ECeZHspb6PUqCn4hMceyJhNiyL6m7-3ZZdTpWLNiHDA>
    <xmx:Q1YjaID0ORo7Y2tpEDR2tqnqVhOG18mPZ0h4J4-STIEi5g2gmLTGvQ>
    <xmx:Q1YjaNK2PiNR_m2Qhdx5_DJumDGTQnduzd19qvsYC_-n2-5RRlTVuw>
    <xmx:Q1YjaPAUKnLuhp6xWvPqAbwwKpZ0sciISAbRw9N9gSgH9eeU0_0Ycw>
    <xmx:Q1YjaN4qe3abHlTYF0WwIrwOycYH1TRwW7SNDt6EhzwRo1RFKFHlGwzT>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 10:25:06 -0400 (EDT)
Date: Tue, 13 May 2025 16:25:03 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Denis Kenzior <denkenz@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	James Prestwood <prestwoj@gmail.com>,
	linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	iwd@lists.linux.dev
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
Message-ID: <aCNWP906m1ghPfNX@archlinux>
References: <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
 <aB4HC8Iaa6wR5dj7@archlinux>
 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
 <aB4hMsBfyawYatoj@archlinux>
 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
 <aB5onavenLymR-QJ@archlinux>
 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
 <aCMtCCYtNNl4dL5Q@archlinux>
 <562c4ac5-088d-4bab-9883-1d4f8eca2b2a@gmail.com>
 <aCNU2VieKTMasI6R@archlinux>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCNU2VieKTMasI6R@archlinux>

On 13 16:19:08, Jan Hendrik Farr wrote:
> On 13 09:03:54, Denis Kenzior wrote:
> > Hi Jan,
> > 
> > >
> > > There is a an SAE confirm sent by the AP. It's frame 170 in
> > > capture2.pcapng. It's also retried a number of times after that.
> > > 
> > 
> > What I also find interesting is that the kernel on the client side reports
> > sending the Authenticate-Confirm 3 times (according to dmesg and
> > trace2.dat), but only a single Confirm from the client is seen in the air
> > trace.  I'm guessing the retransmissions (attempt 2 & 3) are lost somehow?.
> 
> Yes this is weird. On my first capture I did see those additional
> confirm frames from the client (frame 4007 and 4052 in capture.pcapng).

Correction frame 879 and 940.

Those other frame number were from another capture I didn't send.

> So maybe the capture device missed them in the second capture? Although
> the RSSIs look good in the 2nd capture.
> 
> > 
> > [64414.164169] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 2/3)
> > [64415.063575] iwlwifi 0000:00:14.3: Not associated and the session
> > protection is over already...
> > [64415.063668] wlan0: Connection to AP 96:2a:6f:b6:d7:9f lost
> > [64416.215729] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 3/3)
> > 
> > Regards,
> > -Denis

