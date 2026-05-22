Return-Path: <linux-wireless+bounces-36790-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIHfNUIUEGryTAYAu9opvQ
	(envelope-from <linux-wireless+bounces-36790-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 10:30:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 867775B09AD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 10:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0719301B718
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 08:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DCA3A7F62;
	Fri, 22 May 2026 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mVwc49J1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EUpK2Ma9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3163A782E;
	Fri, 22 May 2026 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438566; cv=none; b=XMVDNsOFWMNGK/U+dUZbXzWLKM5NReDiqfpyl9jAuvDXeTQxquSeZvdz2y831CC6Rba8lH8NR73vJzcNk00sg72K8z90OFZN/vF4yNnkZZc1//zF2tq9pbqfa0ZOuUzyYakyC9XjwQpryvyzHUVrJ+x9fidYDw9thSjhJR9ry/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438566; c=relaxed/simple;
	bh=S/W1IYFida+NA2QNwOCu8W2HVuY1ZiNPLNAJKV7ynfc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=T8Ot1vGhQAXfuorkXLJ2Q07UZtq8oW+Zohhuw9QhOFbrYENlbc6pjOok5Ydgev/uT834dJilujrHukQYkYI/ghvLTz9+OafjLk3bWWtFajMXgRDsKvxOVnoPIpA5piA7ScOVV4GgC5LqCJ+S8UmF9RnWFpIqKuwOvj/UzZUfahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mVwc49J1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EUpK2Ma9; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id A289D1300C0A;
	Fri, 22 May 2026 04:29:21 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 22 May 2026 04:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779438561;
	 x=1779445761; bh=K5cjv15MjjTF6ypOnMSrJMsfRdW4W+PPYBrqMoqvt/A=; b=
	mVwc49J1HBgWVrb4a/RQur0w8olfdgWprB68y5AQaHQKBXoXAw3WMCwEvlADbMZa
	woiU2CWyZVzvL2un+K4ZfXUVGVBgKvyaQ0waPfX2dovAGmipmnmch7wjsSyi/ggj
	ohAEcrvXX5Z0ybA87lR6nVxg8FUHxwcTSyOhBGWli/U5ZI3FFQHzJPoeA18Pj7tw
	WAaIfYhDuniH4wQYakbqBIqXipGGe7Q6iA/y8AH/jRUUp9jaJyz83OGlqauvsNRl
	rpMGWRSLrUqU7/F+jxwMoRP5CzwzEnViHkJJseLL5Q1bw4WbZj2UZdUWAHb3lRyb
	eisQnAsYJ9pqbcu6duBM7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779438561; x=
	1779445761; bh=K5cjv15MjjTF6ypOnMSrJMsfRdW4W+PPYBrqMoqvt/A=; b=E
	UpK2Ma9OrlBOcJrfk89xSalmv14z71Y742I7yR9JDliM14zAQQ2D0cod6aACcGDv
	or6qSJ5INamWzeACSQjuA5hI6ZLYdQEYo8D90K9A9ckq1h7ucOe4khbynAMoJmoU
	2jZlm1NbFEdfiEHDaHOQ9dyPCyfontUTL2xT5bKY2J3W3JULBFjZyHFEzd8Ffd/x
	r2c+GRqVhLktgnWrOX0BdRygD96QKeVSyX+h3cT02YUnqR8yUGFgvP2rhzjiicPB
	iFTzxEAz1miglA2jKtOukdD4J0Ev0bzzJWVVWN0LXq2Bzp53I6Bdp/yeUz4MI2RH
	/uj8Y5FZdiY/g20nRwOZA==
X-ME-Sender: <xms:3xMQahOCKCWvL9cv3XYQbv-EJY-5JR2Ia3Z8PelDswJneSd0az0qXQ>
    <xme:3xMQauxHL3Ysx8fPaX7uC9mP24hgJ3O2F6ot0-P89fFwGJCA-Pi66GK3iqAML5BWX
    DXESTg8zojzG3LmMWF90NYfAhSsRpPntHRCHDoS9Nqa7p6e3dONFos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehtshgsohhgvg
    hnugesrghlphhhrgdrfhhrrghnkhgvnhdruggvpdhrtghpthhtohepthhonhihsegrthho
    mhhiuggvrdgtohhmpdhrtghpthhtohepkhhhihhlmhgrnhessggrhihlihgsrhgvrdgtoh
    hmpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdr
    tghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpth
    htohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtphhtthho
    pehjohhnrghsrdhgohhrshhkihesghhmrghilhdrtghomhdprhgtphhtthhopehmrgiiii
    hivghsrggttghouhhnthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3xMQajUbzWzIk3zJRKelcJqH9lLTGk9j2eynxhQmHiq1OWCr-y2h7Q>
    <xmx:3xMQagPV0Bm4Ic_tW8YWwZ4nVopqiUkfLtl5ahxzvvDHs8X1byqK1A>
    <xmx:3xMQanj7n1H0NO7fxP9CXn6-QWSG6sJlhU37QwHWB4VHx5UbVNaABA>
    <xmx:3xMQaofwiLNKXI5cNztemqeU__Yl9-r92W2KmBm3ZqqMImvXPQDa6A>
    <xmx:4RMQahUK73IMw50Jbey2YC6mFhyLbz4f8YjWlvxlDLB-FK75_RuEeQg8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 708B7182007A; Fri, 22 May 2026 04:29:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArrYli9DFPON
Date: Fri, 22 May 2026 10:28:59 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Matti Vaittinen" <mazziesaccount@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Christian Lamparter" <chunkeey@googlemail.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Andreas Kemnade" <andreas@kemnade.info>,
 "Kevin Hilman" <khilman@baylibre.com>,
 "Roger Quadros" <rogerq@kernel.org>, "Tony Lindgren" <tony@atomide.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Lee Jones" <lee@kernel.org>, "Pavel Machek" <pavel@kernel.org>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Jonas Gorski" <jonas.gorski@gmail.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Vladimir Oltean" <olteanv@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, linux-wireless@vger.kernel.org,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, Netdev <netdev@vger.kernel.org>
Message-Id: <681f328c-bc8a-4410-b876-f8c5f116325d@app.fastmail.com>
In-Reply-To: <b79d8ad9-f36e-4769-9dc2-58baefe23000@gmail.com>
References: <20260520183815.2510387-1-arnd@kernel.org>
 <20260520183815.2510387-3-arnd@kernel.org>
 <b79d8ad9-f36e-4769-9dc2-58baefe23000@gmail.com>
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-36790-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlemail.com,sipsolutions.net,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,alpha.franken.de,physik.fu-berlin.de,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,app.fastmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arndb.de:email,arndb.de:dkim]
X-Rspamd-Queue-Id: 867775B09AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026, at 06:55, Matti Vaittinen wrote:
> On 20/05/2026 21:38, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
>> passing an IRQ number instead. In order to keep this working both with
>> and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
>> the gpio number if an IRQ is passed.
>> 
>
> I am (still) all fine with this, even though I like Dmitry's set. I 
> suppose you already have a plan for merging this, but I still have to 
> ask - why the MFD changes aren't in own patch? I feel it would have 
> simplified merging, backporting, reviewing and reverting if needed.

Splitting it out would break bisection: The gpio-leds change without
the mfd change causes a build failure when assigning the .gpio
field, and the reverse causes a runtime failure when .gpio=0 is
a valid line.

It would be possible to only do the gpio-led driver patch without
the header file change first. This would let us apply the last
patch in the series without regression, but it would risk having
not catching other drivers that incorrectly set the .gpio field
while CONFIG_GPIOLIB_LEGACY is disabled.

      Arnd

