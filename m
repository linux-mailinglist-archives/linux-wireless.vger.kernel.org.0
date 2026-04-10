Return-Path: <linux-wireless+bounces-34619-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFQYLJIV2Wm7lwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34619-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 17:21:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EADB3D92B8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0619B30459FF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D3B3D9DAC;
	Fri, 10 Apr 2026 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQRfv3hP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556043D88FC;
	Fri, 10 Apr 2026 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834044; cv=none; b=gpgr7lzb9spY3gOIdofgYgwK0Kd6i0ZJPNyZgpAirXSmn/VjDcVjDXVZIXeJDOIDy8wCnYlsQ+tN/DSIc2bd05qaYN+EKsaKaW2PQ54kvnkMvR3PBOYnurqyqPFtWJ9255SgA7l4CCP1B0w0DmP49ZFsCHTVuhZ4aG8Pwl76RFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834044; c=relaxed/simple;
	bh=ZX44VkA/oGGdYrqGVtHG3BQ09eU0s5TAD8UsmKEvOJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AGz1vUoP8MTPzs+DH82yzUzCMeLVsUA8E9ihpsA94W30Pvzvmxpz6htpnzLWbOEQjfR1BZgD3Qw14EGnUUHYMqghdv4RAVArscyIJ+QCTikQ3yBG/ieYHQVo38XmP0V1Vr8v593YS5ziaQtFjMwPg3EwpOBmXFL/PBc/WQNcCPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQRfv3hP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA7DC19421;
	Fri, 10 Apr 2026 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834044;
	bh=ZX44VkA/oGGdYrqGVtHG3BQ09eU0s5TAD8UsmKEvOJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DQRfv3hPFw/TKa/ZakF0C/CvhlLPEsVqQv+2r4uwxdObvOGMMWr2s346gixb/wzYP
	 kH3jI1VGrMbPCg8bbeliLsWsv0WorMVV9pr65pzZbqt3ANfLMAZ3WpCzHo7EbPC0aw
	 sFqvG5W5Zh5Zl9hqpd/S10vk3SPDt4AvvXdP7MWFAVnJ1yy95RtrFN5r3P/n0YzraC
	 K1ddeqgVvP6yW3cqrHOPD+5bbhJuKzxhUEtkBkREvZCz2D1PF358eBsZtX1OaLotF8
	 mIrAdKqmlNIgawRmNAF5mT5jG8tytmCXBJPCuscrYjON8tMw7soKn19X1CoLhvhPBR
	 sIA/Sxe0F1CKA==
From: Thomas Gleixner <tglx@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
Cc: baolu.lu@linux.intel.com, x86@kernel.org, iommu@lists.linux.dev, Arnd
 Bergmann <arnd@arndb.de>, Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, Herbert Xu
 <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, Vlastimil
 Babka <vbabka@kernel.org>, linux-mm@kvack.org, David Woodhouse
 <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, Andrey
 Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer
 <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Richard Henderson
 <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Catalin
 Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, Jonas
 Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Paul Walmsley
 <pjw@kernel.org>, linux-riscv@lists.infradead.org, Heiko Carstens
 <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 09/38] iommu/vt-d: Use sched_clock() instead of
 get_cycles()
In-Reply-To: <9db9515b-08e8-47bd-aced-206ac183195a@linux.intel.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120318.187521447@kernel.org>
 <9db9515b-08e8-47bd-aced-206ac183195a@linux.intel.com>
Date: Fri, 10 Apr 2026 17:14:00 +0200
Message-ID: <87y0iuzw3r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34619-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,lists.linux.dev,arndb.de,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EADB3D92B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10 2026 at 21:45, Baolu Lu wrote:
> On 4/10/2026 8:19 PM, Thomas Gleixner wrote:
>> Calculating the timeout from get_cycles() is a historical leftover without
>> any functional requirement.
>> 
>> Use ktime_get() instead.
>
> The subject line says "Use sched_clock() ...", but the implementation
> actually uses ktime_get(). Is it a typo or anything I misunderstood?

Indeed. Leftover from an earlier version.

Thanks,

        tglx

