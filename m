Return-Path: <linux-wireless+bounces-35644-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPlUCvp58mnjrgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35644-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 23:36:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F307149AA1A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 23:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 219F43034E28
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 21:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756843AF670;
	Wed, 29 Apr 2026 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Jr+R6Qpk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lH+dIeKq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B746277C9D;
	Wed, 29 Apr 2026 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498590; cv=none; b=OOmxWLN2QsHTwQeo6p6f8k+teshnh73wZAWfbNLzCibQrlMdr1OfyqtWgIeB7k/P3cxr/gXadkc627BRxD8jJ/nNCl9gNQo6JcSz3yvyFrGdLHB5RES7DPikQt3eE9MUkChTgcsLZwQt3LA9vjeqFoFrZkKppu0oGfcCVQIUti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498590; c=relaxed/simple;
	bh=klf0tstlaQQRwsbPlrG8dRk7UxgfXScT7I6Ug1NVWqo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ggtG+0VCwswovEzdH5WmOOnreU2mKXBGD+b8toIa4Fwu+ItbduLrHAgfN1t6eofq3ZQMxViySTbikThdUGYWvitAPL9XmQGNadm1IUxvE8gkIWkUIVY3mGqymUovYCUXYT/S1pfukX8LmxgGkHKsQFbuDMyjzfFGc4a2wYp6Npg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Jr+R6Qpk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lH+dIeKq; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id BF9B4130036A;
	Wed, 29 Apr 2026 17:36:26 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 29 Apr 2026 17:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777498586;
	 x=1777505786; bh=5c6EKeRaeRgw2IP6/aj0vwG5gMU6SBqRhc9H6l67RiQ=; b=
	Jr+R6QpkxIywS/7WcSX44vaN9mfpxh7lBC2ezZrvdvuA/yI+NBgPqA9p1STNkGxv
	+d48HacyNpKlIYgICiGd2MaHDc9qZjiR7fn+eFjIL70w+t2NjuHnAaHPu+W5YBJg
	ANsGVbscLAui2TZcyw/0j58ke/CfVlQCeQhDi4ZcbrBNt6Z9hu1LCHdKLJbIy//W
	9Wl16IcsT1sYF8P8bBxmIhuWzinkqAP0KyxuCpZY2eipNp6hADnDn89bKQlXLXPU
	+twHMtrBu3HzhxOv21mgHo069Hz4yZynJw3+ds/cBumeITKX3FxdSb/JRljN7qKL
	LrN53qX0XMZKZuAwWviCSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777498586; x=
	1777505786; bh=5c6EKeRaeRgw2IP6/aj0vwG5gMU6SBqRhc9H6l67RiQ=; b=l
	H+dIeKqoYkoZhzjlRFOgPwh6Y2FWWcE8/DB5spvkDaBfxAULdmlBIkLHMmkvMZwT
	gViu6vzN/tIYlHs2lUsOq1RZY94Lpo8XT9gxDpc8lM1EU49KKT1787DaKatfnIfu
	C8w3KTJqxEU2iZZlk86pBDCo6g3y6v3cyki8SnkAU7IQWMkpiXS37XAjhOxMHkNl
	iF8td4IVsEJ2gpictINOm+8jDDgXLno5xEX7JlFPNdIa0Y1PFdTDe6qO7r9/HsKE
	JygEHebypLDS5V2Nf3FvK2DixXjhRspCzvu6BeKxrIcMBU8Uvnj88RiMdn06lnwF
	pV8f4LNsk6g8tuO6FqGLw==
X-ME-Sender: <xms:2nnyae4igw8uVEMMztjiAbf_zsCdn6yhDMpsb1lqcNZA7PPowcjEuA>
    <xme:2nnyaSuHLt8KUulleeBoxX1S6dP-b1Gw_xoLfgASRLEQVlyK_4tx17HEAp0NdPaua
    94grnG3ddm8JJnAA229mKBXPmqyzQgMsMDH9RNU79Qj1PXshC7ztg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekheehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepthhonhihsegrthhomhhiuggvrdgtohhmpdhrtghpthhtohepsggtoh
    hushhsohhnsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehkhhhilhhmrghnsegs
    rgihlhhisghrvgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrd
    hnvghtpdhrtghpthhtoheptghhuhhnkhgvvgihsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtphhtthhope
    gvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprggrrhhordhkohhs
    khhinhgvnhesihhkihdrfhhipdhrtghpthhtoheprghnughrvggrsheskhgvmhhnrgguvg
    drihhnfhho
X-ME-Proxy: <xmx:2nnyaQVgbuPYwQ5PhORdbzIQH5UhjHsL72TZyvElKtkH1aaRbv438Q>
    <xmx:2nnyadxpkCobOu3ZukawY3SpbfPzxsOghsEgMP3SNhGL8Vb0cspQDQ>
    <xmx:2nnyaeibFjsc08s8EhBQwOqVh2QaA3ndmeaPDON86htoMSYXBjMHIA>
    <xmx:2nnyaQMltp_xmQ2nS6jRq7wyIVO4JwQcWZDKNPUXxJb4EIrvy47p3A>
    <xmx:2nnyaXavduEMWLUdY2sB7yCKpzJ24ICtTtce4Ut1i37Vrhc5Zf-xsmEA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EA351700065; Wed, 29 Apr 2026 17:36:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9F4XwaMmS3c
Date: Wed, 29 Apr 2026 23:35:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Andreas Kemnade" <andreas@kemnade.info>,
 "Bartosz Golaszewski" <brgl@kernel.org>,
 =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Eric Dumazet" <edumazet@google.com>, "Felipe Balbi" <balbi@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Kevin Hilman" <khilman@baylibre.com>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Linus Walleij" <linusw@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Rob Herring" <robh+dt@kernel.org>, "Roger Quadros" <rogerq@kernel.org>,
 "Tony Lindgren" <tony@atomide.com>, linux-wireless@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 "Christian Lamparter" <chunkeey@gmail.com>
Message-Id: <556b64c4-febb-4dc6-8d51-1b1c2d2c6aa6@app.fastmail.com>
In-Reply-To: <e4a7e9d8-7091-4520-a634-ff0a44eb5139@kernel.org>
References: <20260427142355.2532714-1-arnd@kernel.org>
 <20260427142355.2532714-4-arnd@kernel.org>
 <e4a7e9d8-7091-4520-a634-ff0a44eb5139@kernel.org>
Subject: Re: [PATCH v3 3/3] p54spi: convert to devicetree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F307149AA1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[iki.fi,kemnade.info,kernel.org,baylibre.com,davemloft.net,gmail.com,google.com,sipsolutions.net,redhat.com,atomide.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-35644-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]

On Wed, Apr 29, 2026, at 10:07, Krzysztof Kozlowski wrote:
> On 27/04/2026 16:23, Arnd Bergmann wrote:
>>  
>> -	ret = gpio_request(p54spi_gpio_power, "p54spi power");
>> -	if (ret < 0) {
>> -		dev_err(&priv->spi->dev, "power GPIO request failed: %d", ret);
>> +	priv->gpio_powerdown = gpiod_get(&spi->dev, "powerdown", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(priv->gpio_powerdown)) {
>> +		ret = PTR_ERR(priv->gpio_powerdown);
>> +		dev_err(&priv->spi->dev, "powerdown GPIO request failed: %d", ret);
>
> Binding said it is optional, so this cannot be a failure.
>
> Also, please use ret = dev_err_probe syntax.

Ok, fixed both.

>> @@ -686,10 +659,19 @@ static void p54spi_remove(struct spi_device *spi)
>>  	p54_free_common(priv->hw);
>>  }
>>  
>> +struct of_device_id p54spi_of_ids[] = {
>
> static const

I would have expected that to trigger a compile-time warning for a
missing declaration, not sure what happened here. Fixed now.

>> +	{ .compatible = "cnxt,3110x", },
>> +	{ .compatible = "isil,p54spi", },
>> +	{ .compatible = "st,stlc4550", },
>> +	{ .compatible = "st,stlc4560", },
>
> At least last two devices are then compatible, so this should be
> expressed in the binding with fallback and drop stlc4560 here. Maybe all
> of them are compatible.

The driver doesn't know the difference, so I assume they are
either all compatible, or the other ones don't actually work.
I've dropped everything except  "st,stlc4550" now, as that is the
one I used in the dts file. I kept the other identifiers
in the binding as:

  compatible:
    oneOf:
      - const: st,stlc4560
      - items:
          - enum:
              - cnxt,3110x
              - st,stlc4550
              - isil,p54spi
          - const: st,stlc4560

Not sure if that's the best way to express this.

       Arnd

