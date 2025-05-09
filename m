Return-Path: <linux-wireless+bounces-22790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E94BAAB15C8
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 15:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEE2189ACF1
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3794C8632C;
	Fri,  9 May 2025 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="A+XbDlxZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r26vCT76"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91150267B74
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798353; cv=none; b=Lz/WYZHkU/EqWSRTzKSmAT6hNQ3Ld0RIHw+IPiKq5mQm9P3e664SS0R9hN5mMFyrPJ5tgBVtRy3ZSSLD209V+x7Sit0uLGLjGLNS5+q1TsdE6/BX4iEGsza+wB+xDkaZL8S+q16EFuadVYTOl9cThnvQJlEpnCpPw6O6XHuuKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798353; c=relaxed/simple;
	bh=BrPK8k/DO3VHGWLMymAKRJriwZkP4LWX9Q5CIJlVdYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQkO1LRnk122BBekw+nNksw/i8JMwNb6CQCpU3NLJqPtd1EYzjdN2C3CCidEjwbLCtDYz7vK7gZh/pvH1arfYJ1/CJ5qFs6tPoO6M1093l6YpaaSP4pBoj4tfJcYhHWIx4+NUCo6ULdZ7toXBVYHCyXZWnR7Kf+4+b7tbCFh/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=A+XbDlxZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r26vCT76; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9730C1380291;
	Fri,  9 May 2025 09:45:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 09 May 2025 09:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746798349; x=1746884749; bh=UXHc7xHX9E
	ONnrGRxG53xhIsWzuFWwpFboRpg7vFIHI=; b=A+XbDlxZGd0Sm48QQY10nQvEhP
	MMwtE8hTnOtQtLz9Oo6fP4DFYK+iS71EHu+eitwXlF1+Ermp0nH4sNPvS7OfYPUi
	ci10bZPnu9hr/D5KUk/Ukhl3p1eLNv9w1S3Gc7HGbe3vUg+Zx7P+khArg0NTMVFM
	y5OzcJACD5NXbLW5M2qSZ4dQSp3rNyEwwBWnkhv8xsva4FtLiij+1TnjU1TFwiah
	X+wXiS/iprZMKnuhaMMqVBKgNwNYg0FTU1heUoSdXNNGDGNYhIA7yCqg/HTSngnA
	BPqO6b4bAAHxVB2dkOYeevM7rDXUnbOZnEir3o02NZN4SSEXNGJ7fLCN/xtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746798349; x=1746884749; bh=UXHc7xHX9EONnrGRxG53xhIsWzuFWwpFboR
	pg7vFIHI=; b=r26vCT76quwOrSv5LJfB/rsiyjkqv7WhGxwesCQ3H1ZxmAaG4Bu
	A3dHWULmjniJFXBZykjSH8of9iL6/PXlpPfdh/3paD9A/cCAuICbl8k1HqFjUkyq
	E6yM+hxogPKH/rB2C3PctPPEfoEzbGiyhXoDERZQGsFjHwtyDhNwylALPhCBADOy
	boTfnuMp3Z8ZOob/HPZMcqDBid3wOIbcaCcatEI1k6Jyq3b9gA7up2k9KFFwixKV
	iFqCVSGCBY6rHD3PHlMJc9kbUiaNq5ZhKom1Xyy89EsZcukk2ReekI2epbhFZcSu
	1K4CqGtExXN5XEoly19qp7vLbPpVgtpcu9g==
X-ME-Sender: <xms:DQceaKlrOmHLBB0ynw0GSUTAErg3K5BJlLMaxmZJN-tyGOWuOVnQ-w>
    <xme:DQceaB3JW_jdeMdajqVtkBlgMko90egTILlTFbWpKvZtVTf4TyEhF6i7ldET4t_9O
    N8OxI0yV8AQRzUwT88>
X-ME-Received: <xmr:DQceaIoH4bl1E5SfKPynfBcQFox8gBCXC0ctgeOZIeAH_yGmOW6LJekmtS6F7_ui26h7cEqKBIGhoDdmgBCk3Vwa2Rbq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvvefu
    kfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrg
    hrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpedukeeg
    ffdtfeeihfehteevvdeiueetteelgfefvdfhleeufeegieduieduhfekieenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhf
    rghrrhdrtggtpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehprhgvshhtfihojhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhig
    qdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmih
    hrihgrmhdrrhgrtghhvghlrdhkohhrvghnsghlihhtsehinhhtvghlrdgtohhmpdhrtghp
    thhtohepihifugeslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:DQceaOmdsTUBcNYqyxs5KUFHMqZrbsmvCYWyB4Es9xUAh6quTeXAsg>
    <xmx:DQceaI1Wj02C9D8jly7U5VphOfhR-bZqrc-te9oCqvG3nIX4n3KwQw>
    <xmx:DQceaFskrV7oUhM4wFKKvX3nsqZmeysQyw1L6YUAzCd8ufuxe0-f0A>
    <xmx:DQceaEXO476PLvPyYWI6aF_BFOTnEOHN5PRsuhisll5a9Mv7iijgnw>
    <xmx:DQceaORKVtJMQ-QMraXjnqtUh9q0lhyopezVObD7WNoXxXDRqgkrExDU>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 09:45:48 -0400 (EDT)
Date: Fri, 9 May 2025 15:45:47 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: James Prestwood <prestwoj@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	iwd@lists.linux.dev
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
Message-ID: <aB4HC8Iaa6wR5dj7@archlinux>
References: <aB30Ea2kRG24LINR@archlinux>
 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>

On 09 06:12:23, James Prestwood wrote:
> 
> One thing you could try easily right off the bat would be to try forcing the
> default SAE group in IWD's config. I've seen some APs really struggle with
> group negotiation which is why we added the ability to set this. In your
> network profile (/var/lib/iwd/ssid.psk) set this:
> 
> 
> [Settings]
> UseDefaultEccGroup=true
> 
> And see if that helps.

Thanks for the suggestion. It does not appear to change the behavior I'm
seeing. Also I'm pretty convinced that the AP is not at fault here. It
is sending the confirm, and the STA fails to ACK that and the confirm
never shows up in iwd.

Confirmed that the settings is applied using these logs from iwd:

[SAE]: Using SAE H2E
[SAE]: Using group 19

I assume group 19 is the default group?

Best Regards
Jan

