Return-Path: <linux-wireless+bounces-29566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0566CAAF8B
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Dec 2025 00:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4A9E305830D
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3E52D94A3;
	Sat,  6 Dec 2025 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="qX5Mvk9w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LaYdSFCL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235D296BBD;
	Sat,  6 Dec 2025 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765065369; cv=none; b=OuD79atoicYwH82FMbZwlJ316ctf8D5FNL9APdyi914x5xflWXEF8QnKGRHT+07yINiMeBM0gD9x7HcB34ia8awY8FD5QfWrMtr+copkYS2vbLYPBAPft0QTPNoMOgKHUyJpPi8WUYhC8S+Su3OQgrhsIGnydMYhoz4vhP9BlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765065369; c=relaxed/simple;
	bh=x8gawTJSJnQBSfd+CrCAO5CNtstl5fhlN1ZgqaxYexY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCPe6C8t8fm5U8vzTbrByzk85XQmcVN3MNBpcR59kE9xw3ua1/k5tiddA60pzAydIgZqm10SyQv02VI5iom81fC1bcfQ0aCHW3mg6pa5iw9rLBIHiZr8H4z3MKoMkDi8kjudlzdrLC/+jz0fUV2D+b6Z0ss9L2tl3YCinaIKT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=qX5Mvk9w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LaYdSFCL; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 60A021300349;
	Sat,  6 Dec 2025 18:56:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 06 Dec 2025 18:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765065363; x=1765072563; bh=zqTOcdgbT+
	lgL4HdMVKIJeNlzxy58AJO4R3IqsnxAFI=; b=qX5Mvk9wzvHTb5CeOUHEwrKJqs
	n4/qcAKAyulWd1z8FuElN3a/jqlJaR/xKMdeofABQNGQ+JyiwUHUke3csINk38GL
	aa86e1Yruqf0k3jwRuCb54+3lkuBgc53CDZov2txmx3sK2B1G35BZcYsg+1Hk4fZ
	VhNBvLoBNNDeK/ZfmkDcMlCydebLtIGtUm6GLoXkeytDy+fAtGP+t5eAlnZ7BgtM
	0lfTX6dcM4irhh2NqLaUDSQc9WkN8LwrqMzC5BDN2s1Jm3urub2KQm6VHRCXVA0W
	OqlfvD7832jPmRqeFvWpsI1eu0vt4ELm6w6UdVAykWLo+CB/5t18MqeuxaVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765065363; x=1765072563; bh=zqTOcdgbT+lgL4HdMVKIJeNlzxy58AJO4R3
	IqsnxAFI=; b=LaYdSFCL5IGg/h8cWbNs52kEfCyfmIVCzuBaZFZlAroGKV3vJrf
	1uXA1AR40Yl/QojlWLDJo99Jn/7GczCnd67ZCshDU+2Io2C/YqVmHiCOFsRtWhJT
	oaG75SLT9NcQMQiaS3lDFrAqpem6B4LnuTkjHi46pLrCQNmt87HxNm0p+2bxHzJw
	FPWSTlrt4WM/w9mN72zMy611M33dlCLv5XLo1wcXDaIYoqhvFN7XJZW8vmE4/Kzx
	PL182SOZMT/Cit/P0Zrj2sLkg/UAR+am7naSdp2ufVSfbXf3hfDpmal/7c8x9pz/
	mlv2iME7zdNtVFIZ7YenJdnJXRcWP3lF67A==
X-ME-Sender: <xms:ksI0afsfo6NT2_LFcMDoLhsgat0baNOmlFYg3cpGJ_6uSNNLFQPHyA>
    <xme:ksI0aVUT5WJU-LGVFlwqtcItqyUWal6nVmnw1n2zPYKH7f8Vc1-KILy0FmFK-0xGk
    -qoitgGZFPqL2XMLy5sd-GraS6mUy_ZUWsTkuPjiTQr_CfbKEI>
X-ME-Received: <xmr:ksI0aQWqb8v8HI-YFYIxh7ct487axoYgxnrEDIjxkJQQWxKdNzIGAbQ9zFd1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgthhgrlhdrphgvtghiohesghhmrghilhdrtghomhdprhgtphhtthhopehrthhlke
    ekvddutggvrhhfvgdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhkshhhihhhsehr
    vggrlhhtvghkrdgtohhmpdhrtghpthhtohepiigvnhhmtghhvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhushhtrghvohesvghmsggvugguvgguohhrrdgtohhmpdhrtghp
    thhtohepjhgvshdrshhorhgvnhhsvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hushhtrghvohgrrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhh
    rghruggvnhhinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ksI0aQSyihDQ4r6XUyMCZOitRzIfnMApRMA7TBjwVd3RAZUW8MVyoQ>
    <xmx:ksI0afG89dbT94wmEnyhHP1cUwqLv4misSjK-sA7gdwQH-jpJo3JUQ>
    <xmx:ksI0aQRAuEhb5_wZaz4zHl2hgqFwjnNniImd_R-iJVvf0ezV4gl_9A>
    <xmx:ksI0aZoZZEQgtdXpevOGFQYWi4JFZs-7070hA-yLGEGJ9X7Ny_5l4g>
    <xmx:k8I0aQY_K5ZRqql3-20ds_mKw7xGWiLekIq805SV8ZdF-KEmhvT8x9Zp>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 18:56:01 -0500 (EST)
Date: Sun, 7 Dec 2025 08:55:59 +0900
From: Greg KH <greg@kroah.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>, Zenm Chen <zenmchen@gmail.com>,
	"gustavo@embeddedor.com" <gustavo@embeddedor.com>,
	"Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <2025120716-sway-hypnotic-8cb6@gregkh>
References: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
 <20251121111132.4435-1-zenmchen@gmail.com>
 <475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
 <c0d187d6fead4e5387db2a14129be96c@realtek.com>
 <44c9c325-14a8-4391-adce-4bbe8c68b446@gmail.com>
 <20251207001608.1f6940bf.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207001608.1f6940bf.michal.pecio@gmail.com>

On Sun, Dec 07, 2025 at 12:16:08AM +0100, Michal Pecio wrote:
> Hi,
> 
> > >> I got something. In my case everything seemed fine until I
> > >> unplugged the wifi adapter. And then the system still worked for a
> > >> few minutes before it froze.
> 
> Sounds like memory corruption.
> 
> > > Zenm and I tested below changes which can also reproduce the
> > > symptom, so I wonder driver might assume urb is the first member of
> > > struct, but unfortunately I can't find that.
> 
> That's what it seems to be doing, because it uses usb_init_urb()
> on urbs embedded in some struct and then usb_free_urb().
> 
> If you look what usb_free_urb() does, it decrements refcount and
> attempts to free urb. But here urb is a member of a larger struct,
> so I guess the whole struct is freed (and this was either intentional
> or a bug that didn't happen to blow up yet).

That's not ok at all, it's amazing this is working today.  urbs need to
be "stand alone" structures and never embedded into anything else.

So this needs to be fixed up no matter what.

thanks,

greg k-h

