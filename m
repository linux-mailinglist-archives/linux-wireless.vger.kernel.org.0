Return-Path: <linux-wireless+bounces-420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04D08053FB
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 13:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175CC1C20A7C
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 12:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DAA5B1F2;
	Tue,  5 Dec 2023 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="JvZbCqHa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RtLizhpQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF6C6
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 04:19:58 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 40D883200C81;
	Tue,  5 Dec 2023 07:19:55 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Tue, 05 Dec 2023 07:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1701778794; x=1701865194; bh=LYTagK/x6R2Jzf9idMqtInA320s+jpeKq7U
	532VcMYI=; b=JvZbCqHa5uT4cPtnMVJxB/t6Ght9Tf4uUIkjN7yR43zbK1vXYxC
	UXIP5AWdBl8AhUBlYL3NBw/zvGvxiuAQG6PABtslRRZGuXmp5EBzQAXfb9vR/5an
	yBTg5beLgfxdn8wdhNToIJGN0qSogZ2v2m70+YE4TF6rohPNMzgoh0Uswtd4wwml
	iZFWhSDdTgT7KSEQAYH2WPLI7wM6/A6Q6xl+FDfLFn+L1GYkWxyaTLVgtkMRsfGA
	FEvDCBydpBY5ySX9vKFtqxkfzgPxk4f2fcSax2OX0agF4IR/BP/GaoNaYcBACrEr
	T0MTqidz8q/MEU2zC69LqkaYsHtCar6w/wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701778794; x=1701865194; bh=LYTagK/x6R2Jzf9idMqtInA320s+jpeKq7U
	532VcMYI=; b=RtLizhpQ4fQ52yZ3eOTQNscV7kB0I3/gxJjl5MIlyKG/nLodqqr
	M6UY65B78FLW3PA27BS/6g7SwTrCprhCaX9XOreVpJpLqPW5aM2R0EpOLhTRhGSx
	+n+i8/1csTZYYC8yYorYg2lUoZ2ULgw3pSnZpvAwYeLz3oMQTI4JbZ8YTJ7/WjLH
	rS4sPqeCpdb7wYeD6Q2Xhkuuhhq3A/sLoCsUjsYdBmWtSAU7VMXw2hqxFsVZZ0wj
	WQ74skV6dixtcqSG93FSc+2CAPwFDvp5/rjFsAaHW8KVXXuwxgOUvt5TE3I2SnmX
	o5sTzSkO0TjzrDbzESQUEaedoAxcSozcIYA==
X-ME-Sender: <xms:ahVvZe-9ludV2myuZceyf05EEfbCPUI5mnL-kOIo0jfn87GPzF6kpw>
    <xme:ahVvZeu0HaymNFT7sB9svQz00cyL3vGAwLhbaqbk3tKUUMy9ATkurf77_p-yImhlv
    93epHvaBMlrvvX-sjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhn
    rdihrghnghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepkeelveffhe
    dtiefgkeefhffftdduffdvueevtdffteehueeihffgteelkeelkeejnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:ahVvZUCCNYMD8fAtBVnRjGZO54EfXsOIATHBqadAg5oobH3Q1Ce8zg>
    <xmx:ahVvZWdhschRzGdxaXjPJyK0SJcPKIas9XYwESlYSJQlmXXoLGyVRQ>
    <xmx:ahVvZTPHQCq8jbAGgrKJB-XBR1I14jU7pRW3QlZ_BRkZhOnJDxllkQ>
    <xmx:ahVvZVWnWOGEB3Hse6UL0g6q1HxSrX5Td6j5j3ws4GYiRSdFosOjIw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 75FBC36A0075; Tue,  5 Dec 2023 07:19:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2954b739-b711-4c81-a9a6-e4a1579dacf7@app.fastmail.com>
In-Reply-To: <170176747748.1180638.6206522543570761190.b4-ty@kernel.org>
References: <20231119182401.7630-1-jiaxun.yang@flygoat.com>
 <170176747748.1180638.6206522543570761190.b4-ty@kernel.org>
Date: Tue, 05 Dec 2023 12:19:34 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Chen-Yu Tsai" <wens@kernel.org>, linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for China (CN)
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82023=E5=B9=B412=E6=9C=885=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =E4=
=B8=8A=E5=8D=889:11=EF=BC=8CChen-Yu Tsai=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, 19 Nov 2023 18:24:01 +0000, Jiaxun Yang wrote:
>> China had updated regulations on 5150 MHz to 5350 MHz by
>> "=E4=B8=AD=E5=8D=8E=E4=BA=BA=E6=B0=91=E5=85=B1=E5=92=8C=E5=9B=BD=E5=B7=
=A5=E4=B8=9A=E5=92=8C=E4=BF=A1=E6=81=AF=E5=8C=96=E9=83=A8=E4=BB=A4=EF=BC=
=88=E7=AC=AC54=E5=8F=B7=EF=BC=89", which released
>> an update to "=E4=B8=AD=E5=8D=8E=E4=BA=BA=E6=B0=91=E5=85=B1=E5=92=8C=E5=
=9B=BD=E6=97=A0=E7=BA=BF=E7=94=B5=E9=A2=91=E7=8E=87=E5=88=92=E5=88=86=E8=
=A7=84=E5=AE=9A".
>>=20
>> The new regulation effectives from 1 July 2023.
>>=20
>> In updated regulation, footnote "CHN44" had restricted 5150 MHz to
>> 5350 MHz as in door only for Broadband Wireless Access systems.
>>=20
>> [...]
>
> Applied, thanks!
>
> [1/1] wireless-regdb: Update regulatory rules for China (CN)
>       commit: 8c784a10448e36dc387fe02ae6bf69f4ae0208d2

Hi Chen-Yu,

I didn't see this commit in[1], did you move upstream repo?
Better to update documents here[2] as well :-)

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-r=
egdb.git/
[2]: https://wireless.wiki.kernel.org/en/developers/regulatory/wireless-=
regdb

Thanks
- Jiaxun
>
> Best regards,
> --=20
> Chen-Yu Tsai <wens@kernel.org>

--=20
- Jiaxun

