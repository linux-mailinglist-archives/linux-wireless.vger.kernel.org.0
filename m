Return-Path: <linux-wireless+bounces-34580-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGu5NS3r2GkFjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34580-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:21:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E7E3D6C25
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA6C7303C12A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EAC3C552B;
	Fri, 10 Apr 2026 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYJITPmd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0613BE641;
	Fri, 10 Apr 2026 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823526; cv=none; b=d+0G3opLrnTDTxnRRnCeBqrNjRHTlu5iL3dUtgwQJAxS/F2R8+k6kSXE25K/32/Y8YnPewP7AumrzS4NtrAprBJ5JkAJ1skRVTQ3+nb2Q/6iXrGFCBgmwxD5iviZJkqaSC6je3qKuLYv+wj/RXoA70mLCvK4xvoTEVVIYAEpBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823526; c=relaxed/simple;
	bh=OWF9pG0hQ95RygMnh7+vDhgeHyKnJRYOWEj0GBEdTEY=;
	h=Date:Message-ID:From:To:Subject:References:MIME-Version:
	 Content-Type:cc; b=OKMh6y6fSS910YwmmiPAxypbiUB1DxEjJ5wW23jEBHA2z45tNB+tamOFJ/+eiIkjHg/kfp2YozPwHWNlzX7FHKnb/hxmZ+2lPXP4kQ9DM8TYunRqORTLToK480cY3+8GXwAmrCIkMKHcz1RyxLYqImQXYPgkb3Uh3tbYvlbjfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYJITPmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EC1C2BCB0;
	Fri, 10 Apr 2026 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823526;
	bh=OWF9pG0hQ95RygMnh7+vDhgeHyKnJRYOWEj0GBEdTEY=;
	h=Date:From:To:Subject:References:cc:From;
	b=gYJITPmdy2GNPsbI6AD2iZ7zhMgePGS+gqPbXQCs7WsAhhu/qyX8hH+Xi69K/urPl
	 BoSeBlt4BbqU4ZnISQ8slAdj5VCjiDRcN9bfEzsBBE9dj/wWUHwDFECfvHb21gTPQ5
	 cvjmyUKF+jJ25R6iZ5vAzO3xaA8XXwp+1aea+F9V1esc/zHHX5PN7paJBTByHcDBl2
	 auQKRV9dXMsXdujNzqathwxe2n8RWyCswG/DXqH2EllhOxm/ndPsrTIJX4WzacriA/
	 t/DalYn89VnEQy6E+ROiviOqorgI/E12LPFkiSGiJSdwmaaiky6k8Wx7OG7Y+w6GUr
	 Ni5ruNMG7XCYg==
Date: Fri, 10 Apr 2026 14:18:42 +0200
Message-ID: <20260410120317.776571540@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 03/38] x86/apm: Remove last LATCH usage
References: <20260410120044.031381086@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
cc: Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org,
 "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>,
 linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34580-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E1E7E3D6C25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

LATCH is a historical leftover and has been replaced with PIT_LATCH in all
other places a decade ago. Replace the last holdout and remove the
definition from jiffies.h.

This allows to remove the otherwise unused CLOCK_TICK_RATE define in the
next step.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 arch/x86/kernel/apm_32.c |    4 ++--
 include/linux/jiffies.h  |    3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1196,9 +1196,9 @@ static void reinit_timer(void)
 	/* set the clock to HZ */
 	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
 	udelay(10);
-	outb_p(LATCH & 0xff, PIT_CH0);	/* LSB */
+	outb_p(PIT_LATCH & 0xff, PIT_CH0);	/* LSB */
 	udelay(10);
-	outb_p(LATCH >> 8, PIT_CH0);	/* MSB */
+	outb_p(PIT_LATCH >> 8, PIT_CH0);	/* MSB */
 	udelay(10);
 	raw_spin_unlock_irqrestore(&i8253_lock, flags);
 #endif
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -56,9 +56,6 @@
 #define SH_DIV(NOM,DEN,LSH) (   (((NOM) / (DEN)) << (LSH))              \
                              + ((((NOM) % (DEN)) << (LSH)) + (DEN) / 2) / (DEN))
 
-/* LATCH is used in the interval timer and ftape setup. */
-#define LATCH ((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */
-
 extern void register_refined_jiffies(long clock_tick_rate);
 
 /* TICK_USEC is the time between ticks in usec */


