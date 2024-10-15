Return-Path: <linux-wireless+bounces-13954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2299E0F9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 10:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F63282E7D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 08:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444C91C82E6;
	Tue, 15 Oct 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sPouMTxm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D9utk6rq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D717335E;
	Tue, 15 Oct 2024 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980801; cv=none; b=jkZS2Zap9uvguxA4Can5rGdNqcqBHVvBXx5WsDzaDRSS6r7ellcSutYqrSj8tG0qv7E/jS2JOMg2CBM4+W0UGTDOEmTyqlykh7wyDyOQ1etdxWtG3XLz+1BE1icI7LdMsKUS5z604uQJSzPnMA2R8cKATVhVqVOTt6LR8PKQHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980801; c=relaxed/simple;
	bh=rI+G5pNEOkvsILXZjFPL7S//tggG3Bnow/b4xDlV3fc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jVI05oSb/I/5M0mJDEQNThUIoTM05etYR/WToD1WVSW0rTCHciVDaDpyU2GEZ7Y5+mFhbMpOFXlQz7KSAFesjRJIW74lW5fOyHat6yWDesvHj88kiofrp7IkKlBMHtGA50vnClqoiMSk3oJYIrRxkv4ffFD/+iRKqYyfRTu0IF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sPouMTxm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D9utk6rq; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A31DA1140099;
	Tue, 15 Oct 2024 04:26:37 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 15 Oct 2024 04:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728980797;
	 x=1729067197; bh=zc4AwB791GpNOqwMdNneorC41LSTgz6DIiF6gXAV7X8=; b=
	sPouMTxmUDH2/X3hTVfpUqw0XZPerjQh99sey8AJ675nJga6B0OJnTpnigHI/T6a
	XZO2HU3UD0YUQi3Rje9+uI7eScsIm+57kbMqrkF5LCT8TG6JmagmVgE2OGy6t5YW
	MHi3jQqgWQHbUDIu1lYs1JO6nttavKw9DbEub+orhsJP4ITQK65wFuaW+gtMQ1X6
	RMz7oRPkAJvr8CH2rIVR9fHImFiGb29pMbbw0oy4F3VBZ5dNhV3MHI6u0oSL0dO7
	OyvTYVbwWMR+6mzZ1MYtpnbDuRJZNoKhmXpJRz71qH9RA+RFeh21jyu77wg3SvT1
	uot9jDkkykmh4zT0OvumVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728980797; x=
	1729067197; bh=zc4AwB791GpNOqwMdNneorC41LSTgz6DIiF6gXAV7X8=; b=D
	9utk6rqFXqQMSfwLuoucs/iucNv6tOZjxv4NyzLu/hZn/Mb+2Vb3SDgxAUHZbqaH
	MQin2TkFwalv/le2YK8WesqeLEBsSyFwtIAYjVLvXdEmmGnK6rked4pmZ1b5WgyS
	U4HaCue2MAiF4i9gRP3kpl/6LTEkgIgQ1Pn0vUKwdfIYrDrd7ipV5hFyUc050r0A
	U6sN18T8uPN0Vp4BvpDlnxoAw3ZDFK3AFW6y5UZatq9p6QxyRCxd/xxb7FnCUXUZ
	isXV0Su9iXQEzeat3gHc/fiJ9jocAMOzRwCFNrG0eRzb7tEWkW9Eyfi3NeBrAbaM
	AFvWs6L/WcLr7ikw7xjNw==
X-ME-Sender: <xms:PScOZxhsenKtS-V4ii4rrfpAQYeMAPMWf3v4IhN7SvbPKjHe1JNaSw>
    <xme:PScOZ2CyU3kYjCAbUN6MfnCPgP4T46d-M9XZsBD-QtXA2zNgJZ0QZfXerOybRdrED
    8TMY_hZ7xgi-rj6r68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrghsrdihrghkohhvlhgvvhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhhvrghloheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvg
    hssehsihhpshholhhuthhiohhnshdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdifih
    hrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PScOZxGLxYLTsUwMrBKE-4wVItzijT5s3XPVcg4csIpN1-kDfmMRhw>
    <xmx:PScOZ2TonF8uVP7JDVy2QEDCiVztnxqoV3X9ZSCN2Y6TBKJhs1856A>
    <xmx:PScOZ-yODN-B8mWs79e0srsVoQzeA834XvG6m8P9cbtEYgfhQSolKA>
    <xmx:PScOZ85-NytzMxuBIMmXyChUFKaTPW__WZ7n46RHhZkcn4P7VMZvdQ>
    <xmx:PScOZ1osUXlcWSzVb00EsYSGDNV-O57NQLFtx9QBinem_gaTrKmHoDbB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4AC812220071; Tue, 15 Oct 2024 04:26:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 08:26:15 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Johannes Berg" <johannes@sipsolutions.net>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Stanislav Yakovlev" <stas.yakovlev@gmail.com>,
 "Kalle Valo" <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <0966392c-623d-4c96-86cd-5b25ca90d81c@app.fastmail.com>
In-Reply-To: 
 <a5c6a210cb6b83c7523b0e86b306a7cfa7e573fd.camel@sipsolutions.net>
References: <20241015073216.9443-1-arnd@kernel.org>
 <a5c6a210cb6b83c7523b0e86b306a7cfa7e573fd.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ipw2x00/lib80211: select ARC4 helper
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 15, 2024, at 07:45, Johannes Berg wrote:
>> +++ b/drivers/net/wireless/intel/ipw2x00/Kconfig
>> @@ -6,6 +6,7 @@
>>  config IPW2100
>>  	tristate "Intel PRO/Wireless 2100 Network Connection"
>>  	depends on PCI && CFG80211
>> +	select CRYPTO_LIB_ARC4
>> 
> I think this got to the wrong place?

Right, your versions is the correct one.

     Arnd

