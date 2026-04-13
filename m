Return-Path: <linux-wireless+bounces-34702-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PVKMOwC3Wk3YwkAu9opvQ
	(envelope-from <linux-wireless+bounces-34702-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 16:51:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 149E73ED8EB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 027633055DEA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D763E023E;
	Mon, 13 Apr 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VAzPN0Q8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qocQPWN5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBDF3CA486;
	Mon, 13 Apr 2026 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091526; cv=none; b=qfCFJLo2UT1IfjbWkw6tXi+qPRphCv9pL72bcs1grrq/R4cxEPWtZkWSXOm7S8UBxIMxAcS3lXAR101Cq94GNvdL6L3ZxLZbTgJ8vCu5lFxWj6R1lt4VmoCeYKsq6uqEYqaVH+jAINXmt8w0lv5X6pihjr0byXJmWuFpkm+DXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091526; c=relaxed/simple;
	bh=iEIJ4F5yrIkdMIyp14uCfyRaDhqYaE+/0qk0wW7NqVg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Zz0JlvyL0F9WWET0+0GyceNNKps+tOrz3gE1RGpzHUB64+ZZtEESxT47ASGAU2tGGGZY8RFloGWhCRSeDZUreOspMAa3J2kXdnTj8TjMhlC/4kIE/8sADGl2PWnHyQ8oEi3QPDJ7IoGHcF5ah7T65umSIqfrsdesqaMGAfivSH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VAzPN0Q8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qocQPWN5; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 63FD713004A2;
	Mon, 13 Apr 2026 10:45:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 10:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776091523;
	 x=1776098723; bh=I+t/kQciCWPYQ9TuTtwE8ePqtDE4emYgbGk8M0JrxkM=; b=
	VAzPN0Q8M06ZrISBiijyTlSN7zZjXii1iyjsU0Nd55Go1hDvnVgLbRCBducupWL/
	I7xPJiEoPevkjLJ80mYbEW/a8BVGP+DZJqRCjUfrjm3tX4hey3YtL6Qx00JZuF8v
	WjI3i2GDGrKOX6lfMDr3NkI8PTwxLuJCiP0sOV4NGpZgf3fzkLLYGy+I5Zeauesx
	Pa7bVz5nZwM+gS/NQ9njvgK3O3s/OSp/mqYNiLR905iGGN0vAev7wD2BsAy/ZN5n
	HSi20BHM/ZKZ23MgIDcWnPLPjukDeFEfSjoTKa2sxYcORDHf2CMGKzIaSruFiqz+
	oZNoQZjdZwrcCPF2MdR51w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776091523; x=
	1776098723; bh=I+t/kQciCWPYQ9TuTtwE8ePqtDE4emYgbGk8M0JrxkM=; b=q
	ocQPWN5vz5eOrV7RW4YLt61EpInPDUzfRCh54wFp6y2Qkmlnv6ZW6xi1Aoq7RlzZ
	r6AxqNsae7V2QoCSPbuAl0ssOCnVNF+Nwe1zzee6gqmSKirEjbwPzN/lznn6IgkI
	jFNhpABUlOOZaUVrUhHeH/vSP+NehNFWpty8kiiS8k4XWDW1V04VNj0ojxWNDsG/
	IfeL1IDdAfa9wVDrNQg30BEe1ROTtYd65N72SkxvxptAHs7jfN3985PGHUPTFvJI
	wKmIau3hzR296XeSLQyJhwIMCCxcc2mnbgbKz8VUFGlqAJo5mE6KGja1OZI6dhmy
	PrqiKmwzjhsEhLvP09Hgg==
X-ME-Sender: <xms:ggHdaTXgJGelzz_lzrVxB1-qyO567-GVmNc01ydITgap5FTeQTDzsg>
    <xme:ggHdaWbojY5ZlN23wxAxRcQ_6Dhj9KvjWf-KNsyKBcK8W8C_Dp62np5kJfJ8b515H
    9E3UwX-YmVDxTygAoDQVAtNvx28yeQKuUCb0K1tX4I6jWCY1o3q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepthdrshgrihhlvghrsegrlhhumhhnihdrvghthhiirdgthhdprhgtph
    htthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohep
    lhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhi
    ugdrrghupdhrtghpthhtoheprhihrggsihhnihhnrdgrrdgrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhl
    vghrsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghu
X-ME-Proxy: <xmx:ggHdaWvF06daWzpSpjs739v0aJtN6iuik26sDQBaw3w5gAf8SR2C_A>
    <xmx:ggHdaZ9awg7nUXhN5OpyKRMUZCbM9osYFN5RNP6GaSqeakIU3Racag>
    <xmx:ggHdacmWL1YHAZe8ol6oPFOZFwQU0SOjOVhuke7wt-o0cNx1zs0O2w>
    <xmx:ggHdaXZVfqhFVoJvGmfQg_vToEFHdnDFmb_H9i_ab2aUXdlRPO64dg>
    <xmx:gwHdabAQPN9OqlO9_5-GhrI_SeY-FYfEJ9AFMKsVeX_HsRytcY0IapPu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 88869700065; Mon, 13 Apr 2026 10:45:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APG-r6FMkt-Z
Date: Mon, 13 Apr 2026 16:45:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, "Baolu Lu" <baolu.lu@linux.intel.com>,
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
 "Michael Ellerman" <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 "Paul Walmsley" <pjw@kernel.org>, linux-riscv@lists.infradead.org,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Message-Id: <0166c8e1-b19a-44f8-aab6-f8f161c8542b@app.fastmail.com>
In-Reply-To: <20260410120320.163559629@kernel.org>
References: <20260410120044.031381086@kernel.org>
 <20260410120320.163559629@kernel.org>
Subject: Re: [patch 38/38] treewide: Remove asm/timex.h includes from generic code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-34702-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid,messagingengine.com:dkim,arndb.de:dkim,arndb.de:email]
X-Rspamd-Queue-Id: 149E73ED8EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026, at 14:21, Thomas Gleixner wrote:
> asm/timex.h does not provide any functionality for non-architecture code
> anymore.
>
> Remove the asm-generic fallback and all references in include and source
> files along with the random_get_entropy() #ifdeffery in timex.h.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/asm-generic/Kbuild  |    1 -
>  include/asm-generic/timex.h |   15 ---------------
>  include/linux/random.h      |    3 +++
>  include/linux/timex.h       |   26 --------------------------

Acked-by: Arnd Bergmann <arnd@arndb.de>

