Return-Path: <linux-wireless+bounces-10912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3842994752E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 08:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25861F21B94
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 06:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFC913D50B;
	Mon,  5 Aug 2024 06:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="WNr3s5s2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m1l8IFN2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C013C9D3;
	Mon,  5 Aug 2024 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839155; cv=none; b=VXG6kkGtWjfufM9vhOEguhCtlIcl7hsEfmGdSEfCTII6h4zWEAY2MMwYVUtgHc6MwDvxOZWrjiREN+BAdT6GQ/wx8MzlCOgz709UHYVMpsC2QIUAu607v+FgPH3CgqkeZCY9qH9CCCDT3ImJg7hjLJ1rOwNd94KHnJRP1oAiyYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839155; c=relaxed/simple;
	bh=NFKvwhMYxv6H12ucH+V7Tz+LDXlTONBEHssLV55FCFw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MWUrAC5ecueuQNGLpvZ3n0Ubtz0pMZ8FGHmpFEO1aTbxrnwqG/O+Lgo/uZFedtYuya5jOXgbiGPY8vI92EwSckQ1pY1gGO+dytwenazeBF9bCR0LTbwr/vYRudOIlftClEVW3KWrwD32ZsIN5uCTNuL8Wa8uvnO70H0RVm0PtEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=WNr3s5s2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m1l8IFN2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 87F711151E4E;
	Mon,  5 Aug 2024 02:25:52 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Mon, 05 Aug 2024 02:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722839152;
	 x=1722925552; bh=NFKvwhMYxv6H12ucH+V7Tz+LDXlTONBEHssLV55FCFw=; b=
	WNr3s5s2DNlO/DPFFhXdkIG/dxcIAVuFMJM2l+SFj35fqOei+irmzgAaaT8PwI/H
	QU89IPh/mdURGwcdrlR7ptwFmnfci0wnMpLLJL4uPkS1+rtkoaqFgWqTrdktb7X+
	K7zYdGFb1/KAzvuPexDtbaxKNYFPYryV78Jy4yO/dQOlA+OCb3O+7JLWipETbihg
	bWPjYkva17cWZvsQrOaMKvv06jYPRsocM8rm1exz6xQYyiosHD1reYMUSldm1gp6
	fcg11Ss6Ahzn4gmxosxGVnIq/qFYuO06xuh9VDTWgN65FpZKlzqxQETqx10cmFYJ
	V6qYFYCifMQGPZST1UTXWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722839152; x=
	1722925552; bh=NFKvwhMYxv6H12ucH+V7Tz+LDXlTONBEHssLV55FCFw=; b=m
	1l8IFN2VirG95gejjfEhwu3WzNrPE/oHDFzcl5YwkBEZJwM6oH9kAe2XNTV6/Cp2
	bfj6RRZHv+20UyW+pR9Vw2vWDnaMF5z1FbfqlfuhPmYFVX6i3A2H2yri4LWMHaFi
	vbhUnwV+tJ2B2mEaFcigv00ACnBmbqjLu0JMKh6391DYb+EvDTrxG7/aSDCn4Ynl
	IulAwdekeyVeKR0i8zhzTjMEp+dX6IjxmY2nT8vZT4uHRGmNR99xvK9F6aI+ZGSw
	36uLZ6AmoYBdSWkTKws97d0j53DBk1HbolD4pH4pAQUS1jPhxn9Z9UD2zO/KrTgc
	GnnRVjgE5X8+tsO6iQJ/g==
X-ME-Sender: <xms:b3CwZqKf3CXFc9I-9TyQ-S9ZsJiNVEvRDOdu2mT9PQBTPV3WA62fbA>
    <xme:b3CwZiKgqUPz6Ef9zdUsMIrpAZkA4ScCAD3byTolg7k1edVnERPq0oAVy6mB6Rvey
    IhiUx_preVx-jONlvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeehgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfgr
    nhhnvgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhephfeguddvheevvedtueelkefgfeeijeetgffffedtleetgfeuueetudelleffgeel
    necuffhomhgrihhnpehprghsthgvsghinhdrtghomhdpfidurdhfihdpihhnfhhrrgguvg
    grugdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:cHCwZqsS0EfwtTYHvBVuM8mf2Z1QLY7HB-cKdpjyAmv3olJMW8ECIw>
    <xmx:cHCwZvYA5UjO9dbEP04yPZBETxI17CV11Y2OD5zTnjyR1vVymocnKw>
    <xmx:cHCwZhYxajsE4Ut6xBLI1jh7axP13Hl3keLKyASnlCTPj57U8EKHnA>
    <xmx:cHCwZrBGf4mYCwfqAu1YUvvf-ipNZNJMwJwxyJn3vaZfXNLwOsCU4Q>
    <xmx:cHCwZnBlNC4tjCll2sg_DyeRp_MY81asWItW3wqX1F70uRLfZg-mxL6R>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E06E219C0069; Mon,  5 Aug 2024 02:25:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Aug 2024 08:25:31 +0200
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
Message-Id: <9ed78539-35ca-4643-9a38-ac2c0379f395@app.fastmail.com>
In-Reply-To: <ac9f0cb4-ba12-44f1-b32f-d17e24fe426a@app.fastmail.com>
References: 
 <MA0P287MB021718EE92FC809CB2BB0F82B8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <306c3010-a6ac-4f8a-a986-88c1a137ed84@app.fastmail.com>
 <MA0P287MB021725DE596EF4E5294FA5DDB8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <1911d0fdea8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <ac9f0cb4-ba12-44f1-b32f-d17e24fe426a@app.fastmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hej,

On Sun, Aug 4, 2024, at 13:37, Janne Grunau wrote:
> On Sun, Aug 4, 2024, at 13:04, Arend Van Spriel wrote:
>> On August 4, 2024 8:27:04 AM Aditya Garg <gargaditya08@live.com> wrote:
>>>
>>> WPA3 is broken on T2 Macs (atleast on 4364) for a long time. I was
>>> under the impression brcmfmac doesn't support it.
>>>
>>> Anyways, I've asked a fedora user to compile a kernel with
>>> CONFIG_BRCMDBG.
>>>
>>> If you want logs without it, look over here:
>>> https://pastebin.com/fnhH30JA
>>
>> Not sure what to make of this. The interface comes up without any
>> obvious error and then another interface is created by another
>> driver:
>
> I've bisected the authentication timeouts for WPA2-PSK and WPA3-SAE
> (and probably every other authentication method) down to
>
> https://w1.fi/cgit/hostap/commit/?id=41638606054a09867fe3f9a2b5523aa4678cbfa5

this is reported upstream in
http://lists.infradead.org/pipermail/hostap/2024-August/042893.html

Disabling offloading in brcmfmac with "brcmfmac.feature_disable=0x82000"
on the kernel command line works around both the kernel and
wpa_supplicant issue.

HTH,
Janne

