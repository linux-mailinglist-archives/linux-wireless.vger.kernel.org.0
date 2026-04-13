Return-Path: <linux-wireless+bounces-34701-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kErhOSkB3Wk3YwkAu9opvQ
	(envelope-from <linux-wireless+bounces-34701-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 16:43:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0608B3ED703
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 16:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD83C300B9C2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2E73DF01E;
	Mon, 13 Apr 2026 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dThTVDJR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mKaUdPcE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F13B9D8F;
	Mon, 13 Apr 2026 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091423; cv=none; b=pEDcr7imf4UrxWjMpUBzWaO9NsjG21sFUH4LvE9W6pRSnbbXwyMby9O9C6Iut0WuVv3AwtAFHNaymdE+qvM8xQB4VJNMCKB5yYaFG1IBdaJ5G8ID9iWy5gxXgrW3yaqfSQZODLaFuOi7nmybtffWng6XqigPB+dr7gV3niRSlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091423; c=relaxed/simple;
	bh=CPqrtdPK1fzOFd0Y9/MDHGVDApYeKMdzUWsDXpmbjTE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HZ8/vLLocDj0PN6UYd6Vk+zcuu5YWWGMEKiloI06yamgCI/U1+GSp5Fn36MQdHyk07wF04xUkRs7HJIXt0X34bdCLXufOjhPXlzblL4pv6z//atM+4Y/EYcq//0vDD5GOTRVOGALIqUCm1Rxaxo2pSB18xFWTYY6131UEDQBX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dThTVDJR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mKaUdPcE; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 580C613004A2;
	Mon, 13 Apr 2026 10:43:39 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 10:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776091419;
	 x=1776098619; bh=CPqrtdPK1fzOFd0Y9/MDHGVDApYeKMdzUWsDXpmbjTE=; b=
	dThTVDJRrT61VUkRS+cdt7Y0Z5RRsLEBjlt5LbUT/Wkj3XuC1dVyKWZPgLth6rHI
	xbXnXmRzoJxvLeN5K5KTS4bLI9JTPMUMZHJQi9mq2+Mm0O8HtxzN6gdwi5dKMGzS
	o1z8qIdRudVgAnBmJYPys1vSE6iXXFJKhXBunGcqiXTQxSIZPwExbixipylrVyN9
	4kf4i5YSOQ5TyiEguuaQMFY1bjfsEzY4T5yjV+i49k3OFs/Vmf2QAO7EvG9pkkWh
	N8bT6ZPczJACaYt7v0DdNhd+Jcw1QSr4sfdnPLEq3qIenfqRfJd23mvz1BSPAcJy
	t7jf+cR2gTZwsPDeAUjd8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776091419; x=
	1776098619; bh=CPqrtdPK1fzOFd0Y9/MDHGVDApYeKMdzUWsDXpmbjTE=; b=m
	KaUdPcERkC+zzfJk9o14B4ADxV7hBFIrlwDzvbBZEzHm0PKs68AEHjccunfdwCIR
	xandwmc3ligmxNR3yrYrjDSRktpJmwg0D7TTzo3rAlmWy0gSHQXh1wFw4+NYGyVg
	zDlM8PgR4QH15XnDMMXbSfnGvjJh/j4eK/GlCalmtgkTknPnFph+dfWco8cTlWse
	WFEPDTU+OA38Yo/f8OVtqBAERl/dqEvgrfDqnngro8UiU3Du4URjogCH7u9C6eP/
	RYqA02k02M2VwiJpdNWH8HG6r4KmynyPDoJYdxTNeNoiAqYyt88JcV7BBjOLulpB
	DJUQhLG59C0zm2Z5pxrQg==
X-ME-Sender: <xms:GAHdaVYGCaKUPjfNsUorzxAck0ngCpZdPLdqJKjZEoxtd6QEkfV5yg>
    <xme:GAHdaXPKX2B9tilU84LfHthnj4XuzUMENgXV2EBsOOdx9XMImcZUEPIIzoIwFqvOh
    pcGkwnRvUUR4OUGZGU3iYkbbpFp25Dx9wq8LoeuFKlAv-Ydx1YT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepthdrshgrihhlvghrsegrlhhumhhnihdrvghthhiirdgthhdprhgtph
    htthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohep
    lhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhi
    ugdrrghupdhrtghpthhtoheprhihrggsihhnihhnrdgrrdgrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhl
    vghrsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghu
X-ME-Proxy: <xmx:GAHdadx3OaLmpgnQ-qR09fFSyphBizIiykQxx2Qr5HCiMADvCUw5LA>
    <xmx:GAHdabzajIhZOwZQz55Cqp-WmIPvMJl0Qeu3WJrRVrqO07JZC9K3bQ>
    <xmx:GAHdaSIxPmEuEecG1TMTc2ieeRuLkqK7w1Mgwy5a1Wj0e-ew_hD6MQ>
    <xmx:GAHdaVsDbvRI-p-Ezq237oUrDyOkdrmimmA3aH1JiaBrwsVneKVMbQ>
    <xmx:GwHdaelj14NT6xOHjmTv_huVndzlY2JM81Rr0b3-wFbundNAWyZ-7jZM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E9F8A700065; Mon, 13 Apr 2026 10:43:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaL_vZcj0OrJ
Date: Mon, 13 Apr 2026 16:43:14 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, "Baolu Lu" <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev, "Michael Grzeschik" <m.grzeschik@pengutronix.de>,
 Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
 "Herbert Xu" <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Bernie Thompson" <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
 "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Marco Elver" <elver@google.com>, "Dmitry Vyukov" <dvyukov@google.com>,
 kasan-dev@googlegroups.com, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Thomas Sailer" <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org, "Russell King" <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Huacai Chen" <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, "Dinh Nguyen" <dinguyen@kernel.org>,
 "Jonas Bonn" <jonas@southpole.se>,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 "Helge Deller" <deller@gmx.de>, linux-parisc@vger.kernel.org,
 "Paul Walmsley" <pjw@kernel.org>, linux-riscv@lists.infradead.org,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Message-Id: <3d7c3433-2325-4bb2-a8f6-ddd11c82f71d@app.fastmail.com>
In-Reply-To: <20260410120319.723429844@kernel.org>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.723429844@kernel.org>
Subject: Re: [patch 32/38] powerpc/spufs: Use mftb() directly
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-34701-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ellerman.id.au,lists.ozlabs.org,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,linux.ibm.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:email,messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0608B3ED703
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026, at 14:21, Thomas Gleixner wrote:
> There is no reason to indirect via get_cycles(), which is about to be
> removed.
>
> Use mftb() directly.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org

Acked-by: Arnd Bergmann <arnd@arndb.de>

