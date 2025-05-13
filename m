Return-Path: <linux-wireless+bounces-22914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9882AB56E2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 16:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF5A3B72D9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3111607B4;
	Tue, 13 May 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="jV4Q/3Bp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GhiLDiZn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EFF2A1AA
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747145951; cv=none; b=eWb2IBjSetO7zzB6fvaWSVNxmkhskSkIP2IvSH1pDr9ze7APbPaxL6EHdWv+/Kye/bo/AfFxkbEnKmjAD0cH9B0d7h6nH5n8FkOKMh+3mU5oekPs86zdi8vBK9A1k6ry/KbZ/kEFOLavrK82Tm6Sesl61j9nNK7GYYRoskV/FZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747145951; c=relaxed/simple;
	bh=qI0l1jPkGmUc4iDvptp/RpoVvbNoY/49q4uJZxv6V7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhrwggufTop7NIxL3L8Y4kIrtDRRbjVFr4FkQUbdyEFVsgJx21M3ci3VOsQy9uwyT6KWdKJlcMuhZnJjdiDuTS0JEhaIVS2OkeVlKbvcVw2S6JKQ7qnhRrAIp4m4xY59SmArsZBdxCWdc/6kA6Hdoi3syGjB/0YzpB2VlqZ1Twc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=jV4Q/3Bp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GhiLDiZn; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4DEFC11400FA;
	Tue, 13 May 2025 10:19:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 May 2025 10:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747145948; x=1747232348; bh=geTc495hh2
	iyG6Y4r+X7LKSaUQIljkLtMJPSCSM09a0=; b=jV4Q/3Bp36bJ1TV2Eh6vX+3bp9
	aJltQJv9N8zFYkgHXDT+DrLx+fey292tjkWfn9E2oCGF/W4jpZyjzrb1a+BkfuR/
	C5Ty7y0zIOcj6fBcf4VmIWfz6QunuXbmztoqAbAm9VLzRfX8p8JAnhxcQeTu2uyQ
	WGrzMUnJo4zfWVKm80Xc/qdch/BP5rltfJN3ohBhnOxzFT/0XrXJCvnLK+3HpBI8
	MD5gieJ8Ccol4P9ALDYMKCBrDWXYNPCb00Fvs2FXe6LTsyOVqqcJKBngY2PCzoft
	miDtIWUnDdmuGuVWrigtkAiA034GNCp8rJWnpQE7huNNdOlw6UAEW627q/7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747145948; x=1747232348; bh=geTc495hh2iyG6Y4r+X7LKSaUQIljkLtMJP
	SCSM09a0=; b=GhiLDiZnG4hI7WosdzWng+WFUhYHbkjYBRfbqOlcRJ6zaYCO8BY
	IzRB3utWkpQ5D+fEhLGuK3gDyZDL7gxvWuQiBvaLRAkG/ox5m+5f26qGQgtMFkfY
	7UEKR1Os1f3F2j6TGxGODfCoyK5bFc8lKGBlHypF+U20mSC3eNhDcjK/0trHZ/LW
	rZmkg22oQJ8PLBd+nTOVppCJP7g9S24myKdWlqtS0kbDtVpIdkh2Su5sP/cjtePm
	JSKlb002jBqjLNOEtQ1fnnaqqZwf0ZAWh+cbUVN4QwcBf1eFHo+abDm1R5k9Mezc
	ioeUlD1QtgoT7ho084MbbjTRltWqaju2caw==
X-ME-Sender: <xms:21QjaEeAr9yFWBv6tlNM7EwQzNJz2BgMEPZJlcyjeSh-_nFK8Yuk6g>
    <xme:21QjaGOEY788THITSMpi3rPyzB8YwsghHizIqhjOkhBG4aiEZWCNolCy37xYvSEkG
    eYDI9k62B0XNv9lsWw>
X-ME-Received: <xmr:21QjaFio9MLbtQNJgAZjVgMac80sVWW2DEAcr6lbC92HQDg6aLgoTNgSTjvzps3o5hTN0Lc5xhALar83MZJzTfbrR55C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvvefu
    kfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrg
    hrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeefteel
    ieeffffhveeiieejgeegledtueejheetgeefkeeiudffffejhffgieetjeenucffohhmrg
    hinhepphgtrghpnhhgrdhithdpphgtrghpnhhgrdhsohenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhfrghrrhdrtggtpd
    hnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghn
    khgvnhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghssehsihhpsh
    holhhuthhiohhnshdrnhgvthdprhgtphhtthhopehprhgvshhtfihojhesghhmrghilhdr
    tghomhdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmihhrihgrmhdrrhgrtghhvghlrdhkohhrvghnsghl
    ihhtsehinhhtvghlrdgtohhmpdhrtghpthhtohepihifugeslhhishhtshdrlhhinhhugi
    druggvvh
X-ME-Proxy: <xmx:21QjaJ8pbpe4PqtNXqS0XthoEfDDacsmhvgfe0zeWfGgCwJjuDfa1A>
    <xmx:21QjaAtXJPC8vkO-S0R1-a1irRmJfeXTDIHJjWV7prixRaLaQB23ng>
    <xmx:21QjaAGOty7RDBcqvXwX0tEf3-_o80qdRUuGlo9Baaqe9I9JUIBhUw>
    <xmx:21QjaPPtRQeP5-jX52upNwKdLAMdFWBgMu9caRBQtsdW3yYo7mfMiA>
    <xmx:3FQjaKFFnHLBH3FsBsUFqviL2EpfnbNk_knI-Kwd2ZNNP29XUYpCUI6h>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 10:19:06 -0400 (EDT)
Date: Tue, 13 May 2025 16:19:05 +0200
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Denis Kenzior <denkenz@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	James Prestwood <prestwoj@gmail.com>,
	linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	iwd@lists.linux.dev
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
Message-ID: <aCNU2VieKTMasI6R@archlinux>
References: <aB30Ea2kRG24LINR@archlinux>
 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
 <aB4HC8Iaa6wR5dj7@archlinux>
 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
 <aB4hMsBfyawYatoj@archlinux>
 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
 <aB5onavenLymR-QJ@archlinux>
 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
 <aCMtCCYtNNl4dL5Q@archlinux>
 <562c4ac5-088d-4bab-9883-1d4f8eca2b2a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <562c4ac5-088d-4bab-9883-1d4f8eca2b2a@gmail.com>

On 13 09:03:54, Denis Kenzior wrote:
> Hi Jan,
> 
> >
> > There is a an SAE confirm sent by the AP. It's frame 170 in
> > capture2.pcapng. It's also retried a number of times after that.
> > 
> 
> What I also find interesting is that the kernel on the client side reports
> sending the Authenticate-Confirm 3 times (according to dmesg and
> trace2.dat), but only a single Confirm from the client is seen in the air
> trace.  I'm guessing the retransmissions (attempt 2 & 3) are lost somehow?.

Yes this is weird. On my first capture I did see those additional
confirm frames from the client (frame 4007 and 4052 in capture.pcapng).
So maybe the capture device missed them in the second capture? Although
the RSSIs look good in the 2nd capture.

> 
> [64414.164169] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 2/3)
> [64415.063575] iwlwifi 0000:00:14.3: Not associated and the session
> protection is over already...
> [64415.063668] wlan0: Connection to AP 96:2a:6f:b6:d7:9f lost
> [64416.215729] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 3/3)
> 
> Regards,
> -Denis

