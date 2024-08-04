Return-Path: <linux-wireless+bounces-10899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0091946E6D
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 13:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA35BB21791
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 11:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B258315BA;
	Sun,  4 Aug 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="MHOFezC6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hQv0l9/r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F11D545;
	Sun,  4 Aug 2024 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722771456; cv=none; b=atlzOBPVSRUF2gNvt14wsFASeDaMdvXdX9ejbIC/ES2E6mV50vl69ujbL8gNQrIyWJRY+ZW5kzptziUm1WoJiMyIZ1rDq1bDy4OvnqptPpuYeNMAcw9vMLDqN1MJlF4tikjZcpXDkuMfyjEjUj8kgDnm1ak65Jx6ihY2qr5EwUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722771456; c=relaxed/simple;
	bh=g37Wf69tTH4xH8rvQsV/IUAbbexHf9wvb4dCxXTAPaU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uzPrQV8MQmgvMvfEP00C5qgc2UNs/KtlEtsAFaXrbS0NwSXDeRYbZS0OkzbqzAQV0XMS+vv/RoulpK41iYi16rono4+fYK5mQvzCGG1Nom2OJLjzSvKQaEhgqbBL2AKVzn1EVWGl5w/l0W4HQi27FrhSz3xeUacD2PpCiwPh4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=MHOFezC6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hQv0l9/r; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C26F81151863;
	Sun,  4 Aug 2024 07:37:33 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Sun, 04 Aug 2024 07:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722771453;
	 x=1722857853; bh=26q5jI2qsF7RvXCV2lbBdiYHgP9/3GB5SHJPHTkxESs=; b=
	MHOFezC6Y0k+8cPOgg5d/Imim0U03RV+tm2jp8cL0N1qwuAVKMgfuk0dzeunaxWe
	gxAudoa0O9cctTziMf289bbSYdyHpqWgJvSR8kQNEWhOM2ACxC1/netjdyGJNfrg
	uOo+MqR9Ap2/Or2uEa/HIf3y05Ce8jqWHBFFfAi/U/qIEhrub+0TIkMsz0sgoF51
	EaE9Fqi8UJPLw1MvjJ24b/82VhHru9Vh9MIaDDV9qzho/yEKtnFz2ro2OfQa5RGi
	SNGw4ib/aWZLwvyQHpBiSA2aZPC09AVwKZbdyrUh1FopyPBbSXpjmlWUYqfN8Irx
	PC6CGfCqlxcS3Op/kedAsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722771453; x=
	1722857853; bh=26q5jI2qsF7RvXCV2lbBdiYHgP9/3GB5SHJPHTkxESs=; b=h
	Qv0l9/rVHrM0HG9qEf6xYfhZg5WoZE+vLhMoRl3MgBHe4CfJr9CqRAO/fzLPl4i/
	1F+M+CurzfN7DH1job3cVexAJZltrxg/i2RAwGD6iqiqXmK7+iXMe9vPo5dknAmD
	H155Iz7gU0z98eW9hzlGzUDRVMD5e7zm6C1DyNyjfhV0iKUsLGb2YlawToBXRmQ5
	DQ0K42AdsXMlxxCWagPDxVJGVd98Xd4b11PGg3sHQrdE6T9f12q8RVMBxwSF0SCf
	7Wg8wkIIK698du7bCosSlTLhLMY440Z9Clqw2JnWkimVQhQXaRyGNxHfOLTqwwuT
	MVrhc1bFbIMIiYYNp/Uvw==
X-ME-Sender: <xms:_WevZgqhddbkNzK4J3nBoSJ518tjXF109mahhQixFp7_ow7kqNILnQ>
    <xme:_WevZmqp8mepihXnt_fCI6YQY2lJJ6ZYtqLuDZ83gvanLeUs4yLDmxdj1NnSkkI9Y
    mfpCQr_zf344zTs6fY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdflrghn
    nhgvucfirhhunhgruhdfuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrh
    hnpeetvddtlefgheetgfeukeefkedtueffieefieegffevjedtgeefteefhfeludefgeen
    ucffohhmrghinhepphgrshhtvggsihhnrdgtohhmpdifuddrfhhinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvght
    pdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:_WevZlO2n1f5jm4Qlj6Qsli9l14OFQOoaAqj8JoBOQi03A2rBFsn3A>
    <xmx:_WevZn6fNiALV4OHme-HFHYrby3EaDumdqsTexaEm5NMv4_2X_izSA>
    <xmx:_WevZv7g-FJhTbC_1Vm2P2YdF6ohfHNDgEsIGVC1BtjeLLCldqYWvw>
    <xmx:_WevZnicKh2FUCUuV0nx78pmxVn2TIB2-ASpsFvID9Rs7vbQDOBGZg>
    <xmx:_WevZji9AOL8za8NDtaEsIDVt6aiOcuQpcV4MYATLw1jfOF0uVa6TP4n>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 44C3119C0069; Sun,  4 Aug 2024 07:37:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 04 Aug 2024 13:37:13 +0200
From: "Janne Grunau" <j@jannau.net>
To: "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
 "Aditya Garg" <gargaditya08@live.com>,
 "devnull+j.jannau.net@kernel.org" <devnull+j.jannau.net@kernel.org>
Cc: asahi@lists.linux.dev,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Hector Martin" <marcan@marcan.st>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-Id: <ac9f0cb4-ba12-44f1-b32f-d17e24fe426a@app.fastmail.com>
In-Reply-To: <1911d0fdea8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: 
 <MA0P287MB021718EE92FC809CB2BB0F82B8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <306c3010-a6ac-4f8a-a986-88c1a137ed84@app.fastmail.com>
 <MA0P287MB021725DE596EF4E5294FA5DDB8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <1911d0fdea8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hej,

On Sun, Aug 4, 2024, at 13:04, Arend Van Spriel wrote:
> On August 4, 2024 8:27:04 AM Aditya Garg <gargaditya08@live.com> wrote:
>
>> Hi
>>
>> WPA3 is broken on T2 Macs (atleast on 4364) for a long time. I was under 
>> the impression brcmfmac doesn't support it.
>>
>> Anyways, I've asked a fedora user to compile a kernel with CONFIG_BRCMDBG.
>>
>> If you want logs without it, look over here:
>> https://pastebin.com/fnhH30JA
>
> Not sure what to make of this. The interface comes up without any obvious 
> error and then another interface is created by another driver:

I've bisected the authentication timeouts for WPA2-PSK and WPA3-SAE (and
probably every other authentication method) down to

https://w1.fi/cgit/hostap/commit/?id=41638606054a09867fe3f9a2b5523aa4678cbfa5

With that commit reverted on top of wpa_supplicant 2.11 both WPA2 and WPA3
work. Looks after cursory inspection if brcmfmac fails to notify wpa_supplicant
that it is authenticated.

best regards,
Janne

