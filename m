Return-Path: <linux-wireless+bounces-34375-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIhSNGHZ02nUnAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34375-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 18:03:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE3E3A50E2
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 18:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0967300722B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EFA3876B8;
	Mon,  6 Apr 2026 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3Kr8Qcg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB0387595;
	Mon,  6 Apr 2026 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491419; cv=none; b=jQxkQirtU42O7Z9NnLAAGeye4t1YmKefcZLXJPAQ8bjTdwRJYFw3MRcpNaurhwVJUFlZO6X/rkLyanuLzMjtE2RWRAmKqPF8Qo0eF6DtxlQlEwguZm3v8JwaiOxRlYKDaNd7diWsv3Ep6DpQkvC5KXGomK77//KonbtypPLR7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491419; c=relaxed/simple;
	bh=moSxTLSlcEgLGb/DlZPRl4yYq3hZoxKz5Q8PgsIJFic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnKunMI1aSEJipEi5Y74Qahr3QMxDeERftAWnhwAjE3d0xk9UtNZu1f8GytSZIYpTFTWTdThxFBH0IsgAXQdsii4lJm1nMCR28Mr0qS/mElxA/Cii6X2Zl4CMLqbQaVXmrt9WBdM5/oGekvUCHrDi6FWzoStd70yx1xXrLXNppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3Kr8Qcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4494C4CEF7;
	Mon,  6 Apr 2026 16:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775491419;
	bh=moSxTLSlcEgLGb/DlZPRl4yYq3hZoxKz5Q8PgsIJFic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3Kr8QcgEZr0HYqBBYrfsB9A7lC7m7VhfHLzTdYUnrhLq0hg4AV1+XvKllwaYsVoI
	 rapyrU1y3bLwvhPddgtYLzlmB4VhwjtDpGbJIYr7jauEsE+rcDqVOGay+nTsGUXffp
	 ZIbKuDVhru1ZR8L1mBpbRIBkDZHoiQG7qDf0nBHu4i3wsNkbSQGfAdAP1afUYc50Vi
	 owMrQ+1DQuzq9FVkzkTy9dt/tJudd0OD4BdxX7gOt+QcJYizO2Vb6gQJafqaSwbMS5
	 lkVPNmtb7O+ZRKXAcT4GIG4IBU8yMZBMTWEEIEuLS3ZFYUuGKIp/ceihmr6MtYX/Ok
	 eR0zCUPesL43A==
Date: Mon, 6 Apr 2026 09:02:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH wireless-next 0/6] Consolidate Michael MIC code into
 mac80211
Message-ID: <20260406160222.GA2971@sol>
References: <20260405052734.130368-1-ebiggers@kernel.org>
 <01c3a67a-abd2-4eb3-b6dd-f87a4b33065b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c3a67a-abd2-4eb3-b6dd-f87a4b33065b@oss.qualcomm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34375-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDE3E3A50E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 08:59:43AM -0700, Jeff Johnson wrote:
> On 4/4/2026 10:27 PM, Eric Biggers wrote:
> > Michael MIC is an inherently weak algorithm that is specific to WPA
> > TKIP, which itself was an interim security solution to replace the
> > broken WEP standard.
> > 
> > Currently, the primary implementation of Michael MIC in the kernel is
> > the one in the mac80211 module.  But there's also a duplicate
> > implementation in crypto/michael_mic.c which is exposed via the
> > crypto_shash API.  It's used only by a few wireless drivers.
> > 
> > Seeing as Michael MIC is specific to WPA TKIP and should never be used
> > elsewhere, this series migrates those few drivers to the mac80211
> > implementation of Michael MIC, then removes the crypto implementation of
> > Michael MIC.  This consolidates duplicate code and prevents other kernel
> > subsystems from accidentally using this insecure algorithm.
> > 
> > This series is targeting wireless-next.
> > 
> > Eric Biggers (6):
> >   wifi: mac80211: Export michael_mic()
> >   wifi: ath11k: Use michael_mic() from mac80211
> >   wifi: ath12k: Use michael_mic() from mac80211
> >   wifi: ipw2x00: Depend on MAC80211
> >   wifi: ipw2x00: Use michael_mic() from mac80211
> >   crypto: Remove michael_mic from crypto_shash API
> > 
> >  arch/arm/configs/omap2plus_defconfig          |   1 -
> >  arch/arm/configs/spitz_defconfig              |   1 -
> >  arch/arm64/configs/defconfig                  |   1 -
> >  arch/m68k/configs/amiga_defconfig             |   1 -
> >  arch/m68k/configs/apollo_defconfig            |   1 -
> >  arch/m68k/configs/atari_defconfig             |   1 -
> >  arch/m68k/configs/bvme6000_defconfig          |   1 -
> >  arch/m68k/configs/hp300_defconfig             |   1 -
> >  arch/m68k/configs/mac_defconfig               |   1 -
> >  arch/m68k/configs/multi_defconfig             |   1 -
> >  arch/m68k/configs/mvme147_defconfig           |   1 -
> >  arch/m68k/configs/mvme16x_defconfig           |   1 -
> >  arch/m68k/configs/q40_defconfig               |   1 -
> >  arch/m68k/configs/sun3_defconfig              |   1 -
> >  arch/m68k/configs/sun3x_defconfig             |   1 -
> >  arch/mips/configs/bigsur_defconfig            |   1 -
> >  arch/mips/configs/decstation_64_defconfig     |   1 -
> >  arch/mips/configs/decstation_defconfig        |   1 -
> >  arch/mips/configs/decstation_r4k_defconfig    |   1 -
> >  arch/mips/configs/gpr_defconfig               |   1 -
> >  arch/mips/configs/ip32_defconfig              |   1 -
> >  arch/mips/configs/lemote2f_defconfig          |   1 -
> >  arch/mips/configs/malta_qemu_32r6_defconfig   |   1 -
> >  arch/mips/configs/maltaaprp_defconfig         |   1 -
> >  arch/mips/configs/maltasmvp_defconfig         |   1 -
> >  arch/mips/configs/maltasmvp_eva_defconfig     |   1 -
> >  arch/mips/configs/maltaup_defconfig           |   1 -
> >  arch/mips/configs/mtx1_defconfig              |   1 -
> >  arch/mips/configs/rm200_defconfig             |   1 -
> >  arch/mips/configs/sb1250_swarm_defconfig      |   1 -
> >  arch/parisc/configs/generic-32bit_defconfig   |   1 -
> >  arch/parisc/configs/generic-64bit_defconfig   |   1 -
> >  arch/powerpc/configs/g5_defconfig             |   1 -
> >  arch/powerpc/configs/linkstation_defconfig    |   1 -
> >  arch/powerpc/configs/mvme5100_defconfig       |   1 -
> >  arch/powerpc/configs/powernv_defconfig        |   1 -
> >  arch/powerpc/configs/ppc64_defconfig          |   1 -
> >  arch/powerpc/configs/ppc64e_defconfig         |   1 -
> >  arch/powerpc/configs/ppc6xx_defconfig         |   1 -
> >  arch/powerpc/configs/ps3_defconfig            |   1 -
> >  arch/s390/configs/debug_defconfig             |   1 -
> >  arch/s390/configs/defconfig                   |   1 -
> >  arch/sh/configs/sh2007_defconfig              |   1 -
> >  arch/sh/configs/titan_defconfig               |   1 -
> >  arch/sh/configs/ul2_defconfig                 |   1 -
> >  arch/sparc/configs/sparc32_defconfig          |   1 -
> >  arch/sparc/configs/sparc64_defconfig          |   1 -
> >  crypto/Kconfig                                |  12 --
> >  crypto/Makefile                               |   1 -
> >  crypto/michael_mic.c                          | 176 ------------------
> >  crypto/tcrypt.c                               |   4 -
> >  crypto/testmgr.c                              |   6 -
> >  crypto/testmgr.h                              |  50 -----
> >  drivers/net/wireless/ath/ath11k/Kconfig       |   1 -
> >  drivers/net/wireless/ath/ath11k/dp.c          |   2 -
> >  drivers/net/wireless/ath/ath11k/dp_rx.c       |  60 +-----
> >  drivers/net/wireless/ath/ath11k/peer.h        |   1 -
> >  drivers/net/wireless/ath/ath12k/Kconfig       |   1 -
> >  drivers/net/wireless/ath/ath12k/dp.c          |   2 -
> >  drivers/net/wireless/ath/ath12k/dp_peer.h     |   1 -
> >  drivers/net/wireless/ath/ath12k/dp_rx.c       |  55 +-----
> >  drivers/net/wireless/ath/ath12k/dp_rx.h       |   4 -
> >  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |   7 +-
> >  drivers/net/wireless/intel/ipw2x00/Kconfig    |   7 +-
> >  .../intel/ipw2x00/libipw_crypto_tkip.c        | 120 +-----------
> >  include/linux/ieee80211.h                     |   5 +
> >  net/mac80211/michael.c                        |   5 +-
> >  net/mac80211/michael.h                        |  22 ---
> >  net/mac80211/wpa.c                            |   1 -
> >  69 files changed, 32 insertions(+), 558 deletions(-)
> >  delete mode 100644 crypto/michael_mic.c
> >  delete mode 100644 net/mac80211/michael.h
> > 
> > 
> > base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
> 
> Note this series does not bisect cleanly since the introduction of the export
> in 1/6 causes build failures:
> 
> ../drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c:467:12: error: conflicting types for 'michael_mic'; have 'int(struct crypto_shash *, u8 *, u8 *, u8 *, size_t,  u8 *)' {aka 'int(struct crypto_shash *, unsigned char *, unsigned char *, unsigned char *, long unsigned int,  unsigned char *)'}
>   467 | static int michael_mic(struct crypto_shash *tfm_michael, u8 *key, u8 *hdr,
>       |            ^~~~~~~~~~~
> In file included from ../drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c:25:
> ../include/linux/ieee80211.h:1926:6: note: previous declaration of 'michael_mic' with type 'void(const u8 *, struct ieee80211_hdr *, const u8 *, size_t,  u8 *)' {aka 'void(const unsigned char *, struct ieee80211_hdr *, const unsigned char *, long unsigned int,  unsigned char *)'}
>  1926 | void michael_mic(const u8 *key, struct ieee80211_hdr *hdr,

Thanks!  I'll add a preparatory patch that temporarily renames the
michael_mic() in libipw_crypto_tkip.c.

- Eric

