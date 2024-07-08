Return-Path: <linux-wireless+bounces-10084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B4292AA0C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 21:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1D81F21501
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 19:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB2A1DA5F;
	Mon,  8 Jul 2024 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="yenoeTyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="teJjY86y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4B1D52D
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468088; cv=none; b=WNNABqQQi+f2lx5S33sOQmBQyZ5DQt2pWFz6j3a0t2vMJH2c2hIl+28nkp3+12OjLivSozCTiv/WT+r0hLtRQiApprhE4hip1GvDAkftHnq6AFqohnJXQOFHHfDbSwWugUKm11pVLt4dFK99NjNyRZxKEc6/2B+k86gn1xFaV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468088; c=relaxed/simple;
	bh=BOaovcgbR9j7WvizTaX7GGraMZYCewmynRkiY80lXhE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Pia1XJVVIgu426P7I0QVZGBtQIX2vdsaCBSAXTgUAIjYp/O+kmzobJwXxfa0C0k8eSSbo9SxbxUOceKNylA/uzDWDEx5bbnSDynI2Sn5bFMYFu3cxjHgETou99lkyiCk4GmBwmo0I/2EIawxwTOV15wWJDj/z/cgXcNNkAUjVzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=yenoeTyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=teJjY86y; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1B1D0138050A;
	Mon,  8 Jul 2024 15:48:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Jul 2024 15:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720468086; x=1720554486; bh=8uKINBeW+4
	gCbuQ50TvRh1npwZdC1iST+0dwE9UFEZs=; b=yenoeTylzsBKXbZVmvDoXRrvKs
	8WGjT1Ps5A4r4srehRBfKREwvtdXSdDSGLAZsXWrmZi0ynQdn63nRZSbSjuCgGFp
	fZZlDNvjdbPhw8Xjs35F0sCLcUkT6ED8mMnhOgn8YwQ0owsSZdHRBFWsJZoXCRH2
	QWSA+h4RFXko1+pem0BpseAMvlEd8/PnECyLHaPcQ57Bja1qM+JQfxkcWxMQOWgg
	7u/wFDcCygMcmB2rnzHSQZvE2SojlZ79mpWXCVjJSwBW9zIHDl0hbKPr3wcDmho9
	cj0nnzPYiQr1+GyOBzS6dCSPEB2Q0QQCoHKPeCpOMJnipkWEy6Hd5t00SEUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720468086; x=1720554486; bh=8uKINBeW+4gCbuQ50TvRh1npwZdC
	1iST+0dwE9UFEZs=; b=teJjY86yZ3DdlHnBkBbBYeSBMXxLUBO57qhQDPC/0w9P
	Kty0OysCIRHqnQitBHLie/VE8dG/egUT7l72VKIQmM8vn5I/4ZV4UCqiKMMpn1tB
	uo8F4mX9mFD9JL3IQsiUwNiy53iaZsrRz6rQKZDRGS3ERH0L/1Vz65a9F4AzVAAL
	v4/segf1/EWiJMp5Tpdat91Fjwo+sx8ttURQdpV8ud/8RxnQyjlTtq5t238L4EVL
	DEiSvAujS32VYG9MUCK1NIhsM7yQjEV2Ex9wx9AkMTisZvrhOzIwGRbK9n0cYSiw
	x6HzDEs2s8Pl//Qi8+MMOtFav9l+EEfAsTzx/1L4Jw==
X-ME-Sender: <xms:dEKMZmg0BBf6oIWk_bDNUI_GZm1XOv80b8DgM84XO_OH0j1omA7lvA>
    <xme:dEKMZnDctVubWMPSI4gvUbZijAZl8YA8kDRug3aIOnG8r0IGOHljjphnjBZYUA2Oj
    7xPz3jThg8mbYbMiQU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dEKMZuHTG7_B3AQT_1R8dU7MX0pB4Z1dVa8MGHMlQYbW6ypcK9MwbA>
    <xmx:dEKMZvTIhBXIriiLDyUJOtvhE4OZutu2aZZ-ckqI5w9UW8tzkyTCXw>
    <xmx:dEKMZjyMSIsr0ZldDUkbchPWPzNtVaMaZ5veOUJCl2fhY7PnFJSjFw>
    <xmx:dEKMZt45GEzePkqerozn8uTSy-fAU32ed1Fo1T78ITmjb2NLSjsheA>
    <xmx:dkKMZj-9zv_RgVC0_AO6fu-qV5MCWWt2H2BeYmKu4Z0bCWcEnW6SU7NL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B8A7EB6008D; Mon,  8 Jul 2024 15:48:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <973f9a20-0807-4302-a286-d3ff6478529f@app.fastmail.com>
In-Reply-To: <202407081226.94B1FB24@keescook>
References: <20240704144341.207317-1-kvalo@kernel.org>
 <202407041551.1DC8C03D@keescook> <877cdvdgpz.fsf@kernel.org>
 <202407081226.94B1FB24@keescook>
Date: Mon, 08 Jul 2024 21:47:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>, "Kalle Valo" <kvalo@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC] wifi: ath12k: workaround fortify warnings in
 ath12k_wow_convert_8023_to_80211()
Content-Type: text/plain

On Mon, Jul 8, 2024, at 21:31, Kees Cook wrote:
> On Mon, Jul 08, 2024 at 06:51:52PM +0300, Kalle Valo wrote:
>
> I suspect this won't be the only place in the kernel where -Wrestrict
> will give weird results with GCC 11, and there are still plenty of folks
> using GCC 11. I think the best option would probably be to version-check
> GCC to gate the addition of -Wrestrict.
>
> Arnd, what do you think? This looks like a more extreme version of
> commit f9fc1ec28bae ("crypto: drivers - avoid memcpy size warning")

The f9fc1ec28bae patch was the other way around, it showed up
in new compilers but not old ones. I don't think I've seen
more gcc-11 -Wrestrict warnings during testing, but I'm currently
not set up to do a thorough search. If it's the only one, then
Kalle's suggested workaround is probably best, but if there
are additional warnings on gcc-11, making the warning depend
newer compilers is also fine. I just don't want to give up the
warning for new compilers altogether.

      Arnd

