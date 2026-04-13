Return-Path: <linux-wireless+bounces-34714-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLsbHqZE3WkubQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34714-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 21:31:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 629473F2BEC
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 21:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F02B9301BA67
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 19:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FBE3932D0;
	Mon, 13 Apr 2026 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eBEb3+z4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fK2XbJ97"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1F3537FA;
	Mon, 13 Apr 2026 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776108701; cv=none; b=Wwv7ysAI3pZa7lDmJhUWwipeGdvAQG/VIJHrVKio0YixISKcp4kFNSwJuI+cF04dMmLnjN1bNEPjAkhySfUuWAhcnMaTFdQW1GsQGiGI9UDDxNJUYgMSU4d/m+xnPPgy4QL812kozcop5wedzTQxfknEW7TYLwA7uUfBdYGk1b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776108701; c=relaxed/simple;
	bh=WrrLF4ZuZDSSPdaipSZzrKXRH2qtrS74BAAAonCIRps=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n7g1Yx5W6plpXKy+rkozQ6xEgTTaO1xCblNw3ix8fDOKnFfVL16O7SZh497soJj3f4zqp/zSWU+KxfR5iG2eT19N4YiEsFirX1mWgV9neXuPLaq+B1XzLfWKQzwRina3cMiqA4CdgmYDmme3QAv4sOaeHSA6ZSdvV11+Z0V8qUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eBEb3+z4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fK2XbJ97; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 9BAA81380415;
	Mon, 13 Apr 2026 15:31:38 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 15:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776108698;
	 x=1776115898; bh=oF7+4SGRAImH9WMGSId2dJm+4RdrBt2YGrt25aFUZUA=; b=
	eBEb3+z4uCJ5XpVJfmMDtd+Hz4pTmn4rIKoszU8vf+435LUmCEc3EJdi4K0/oVv8
	C+yjXVYuraejFdA/rcQOSN6Zfi5pNlS43GslApllsudgHnK44npvkIwaUHWVTtuh
	Dw/4I/j/UNeqyr1LQlKmH5vdXZciz/2GPqFtFHFDNoaInKEsvm7hwh9DYdVnGoah
	lMAIbVhEjH95sryDmrUzci3AfaiCDHHYDZH3oXJ/R4+VlvsfKJPopXWx0JE7CxaE
	ognvTjwa06PAMT31z/DBGKMGBcoGUsjb6Y3k+6cm618rMbyQ7yCpT6T6pE5XH3Hf
	w2SGXNdq7Abx7TrcOF+CrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776108698; x=
	1776115898; bh=oF7+4SGRAImH9WMGSId2dJm+4RdrBt2YGrt25aFUZUA=; b=f
	K2XbJ97Y0jsbU1s6LswXOEcaT2AuIJQsZKTCiqB2bsDjsavXFxXjXN24HUjqmHPV
	30lUfZzPVJ0GZrRSLZsyTrPlhAwj+oOp7rzHIcW4Q+ggBxcGWjNT+roTWJQkS80p
	muhmPfZao8pyrAslQS6xE9YgbnnrpBmxpEViK0VuBn5kyHZfCSLFSApLiy8hZEkj
	X3o7U4xt3roWjYEf/0QsKGiNqeP3myXk/e3+BEa4KYIE59wmYsrhudiDwV46CB5d
	E8K4OFv0fHuOdK14nnUUxfff3rCPKj8vJw3X7p6M4i0BpN1E8RSwySIEaUf5sCqK
	alHtK1Rc5jgsKIF8k3s0A==
X-ME-Sender: <xms:l0TdaRMQ1ovC5UjXw9wB_riUJbJZBZQ47VcEC4ozPMlWVwTWyL-hPg>
    <xme:l0Tdaey9qAPkMkkSsq5ZowyLiVSaVZg3Aabqq1QUbhdAX-Y8VC29U600TE9HTIGWj
    W-h6ka_l-N0bKYGG_W-3bzXlHGY0ZcjcSbZR_zuoL-6Ds0X7Q55CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefledtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
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
X-ME-Proxy: <xmx:l0TdaTelOssYXt15-FK9p6saYLM_nmrvIO6c-_F3ZyF6_xfZywmCYA>
    <xmx:l0TdaUxOkh6ozfKMIVT4v_qdW_i5Tss0CLMqkf2F01TBmahdCnZo_w>
    <xmx:l0TdaUWn-LdWx2_7oUHRu6zzNshE3wCLw-aFKzbUUXN26D6Q-_6vLw>
    <xmx:l0TdacTwYVtUWJnf_Fdh14nt-sYvlNq7AaQbOTvOw2Uu221fQyzEjQ>
    <xmx:mkTdaTH5uGiAlbaAI17-uSN6CKxYeQsdeWCm3ruscf_j0l2LK_Chakad>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 04818700069; Mon, 13 Apr 2026 15:31:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMdy4yCH1GcR
Date: Mon, 13 Apr 2026 21:30:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Woodhouse" <dwmw2@infradead.org>,
 "Thomas Gleixner" <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, "Baolu Lu" <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev, "Michael Grzeschik" <m.grzeschik@pengutronix.de>,
 Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
 "Herbert Xu" <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
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
Message-Id: <07df88e5-208d-4aac-9668-a3b0c65ae529@app.fastmail.com>
In-Reply-To: <7a48b636cb3146f4f7134c6d4fe42070ac2edb43.camel@infradead.org>
References: <20260410120044.031381086@kernel.org>
 <20260410120318.592237447@kernel.org>
 <7a48b636cb3146f4f7134c6d4fe42070ac2edb43.camel@infradead.org>
Subject: Re: [patch 15/38] ptp: ptp_vmclock: Replace get_cycles() usage
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-34714-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arndb.de:dkim]
X-Rspamd-Queue-Id: 629473F2BEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026, at 17:33, David Woodhouse wrote:
> On Fri, 2026-04-10 at 14:19 +0200, Thomas Gleixner wrote:
>
> ... depend on TSC_RELIABLE=C2=B9, since if the guest doesn't believe t=
hat it
> is, then the guest shouldn't be trying to use it as the basis for
> precise timing.
>
> =C2=B9 (Or... one of the other zoo of TSC flags for the gradually redu=
cing
> brokenness over the years...)

It looks like this is sufficiently handled in the caller:

static int vmclock_get_crosststamp(struct vmclock_state *st,
                                   struct ptp_system_timestamp *sts,
                                   struct system_counterval_t *system_co=
unter,
                                   struct timespec64 *tspec)
{
....
#ifdef CONFIG_X86
        /*
         * We'd expect the hypervisor to know this and to report the clo=
ck
         * status as VMCLOCK_STATUS_UNRELIABLE. But be paranoid.
         */
        if (check_tsc_unstable())
                return -EINVAL;
#endif

With 486 and ELAN out of the way, Winchip6 seems to be the only
one without X86_FEATURE_TSC, so I think the next logical step would
be to turn off Winchip6 as well and remove all X86_FEATURE_TSC
and CONFIG_X86_TSC checks.

      Arnd

