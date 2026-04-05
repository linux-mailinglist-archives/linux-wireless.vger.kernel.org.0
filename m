Return-Path: <linux-wireless+bounces-34351-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CFJAS/z0WldRgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34351-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:29:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7362739D5E6
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D6F93007649
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2026 05:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AAF2773E4;
	Sun,  5 Apr 2026 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TufXiCgT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142EA23A9BD;
	Sun,  5 Apr 2026 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775366954; cv=none; b=KSLAu1ZXqEuYs78vwIFthpm15Q3k0YhJ0doqsfdfz2JHxbvEpF9sJajqszaMrFh0jIRsI3gi6rSbgXWqXNbL1NyLQY3H1HCzBwFTszCE946t8jDfF1Y6CYLHhkSXvionEwjwrp3GwDuMyJDVwlrskGnPCS9OQKusvlaNEhgy7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775366954; c=relaxed/simple;
	bh=mtqCr2tFcJG9s4u62lb2a/i+V6QgmAEzoWR0Jlk5UfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pV933hrqFolG3REPLAFjlNFV4y81/ZZ8B38HWZWMnaHHLqbAk/e9g9/fd/gEWXypUAOCrFmc8Ry9cPIPKT5EsctQlAA/lWD6EuIcNp0wZCASYzecUbCEfYxMqzxK3ODe9MLKQ/41dKEam6CDeExM0w4y3FuFUnZ3aX50gvh2hVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TufXiCgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D00FC116C6;
	Sun,  5 Apr 2026 05:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775366953;
	bh=mtqCr2tFcJG9s4u62lb2a/i+V6QgmAEzoWR0Jlk5UfE=;
	h=From:To:Cc:Subject:Date:From;
	b=TufXiCgTwPj6yFXSr17DwavLF9lq6DXNLd9I/5k/v+Tnq7DzjDzEeZQx+CG8nybUM
	 Vc6rdNusdAN5Uyaj3KT66oqQQz1J9Sepe7ekts9Ius56ZpKMn+GGRAVGAYp4HV0Skj
	 jMMG9In4ziH8nkUe4Khi8xoW9W0aVBGug1nc7iQsZhvEw0OnMh3b1rUcn/Zt9rIRIq
	 IFOvOMtsnHaRgPq5yn5H2kRGa1Chw1NWDMLSSRz793Je9Pu4zUtLw9YKbPTluO5Fj4
	 y/M0DxefTIEBmQpM3ejXcMAeHoMfero4N4jhWhhtxt7QvML77iW7F4Q/WrRrod22gK
	 a/T9Ze9SCzGxQ==
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH wireless-next 0/6] Consolidate Michael MIC code into mac80211
Date: Sat,  4 Apr 2026 22:27:28 -0700
Message-ID: <20260405052734.130368-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34351-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7362739D5E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Michael MIC is an inherently weak algorithm that is specific to WPA
TKIP, which itself was an interim security solution to replace the
broken WEP standard.

Currently, the primary implementation of Michael MIC in the kernel is
the one in the mac80211 module.  But there's also a duplicate
implementation in crypto/michael_mic.c which is exposed via the
crypto_shash API.  It's used only by a few wireless drivers.

Seeing as Michael MIC is specific to WPA TKIP and should never be used
elsewhere, this series migrates those few drivers to the mac80211
implementation of Michael MIC, then removes the crypto implementation of
Michael MIC.  This consolidates duplicate code and prevents other kernel
subsystems from accidentally using this insecure algorithm.

This series is targeting wireless-next.

Eric Biggers (6):
  wifi: mac80211: Export michael_mic()
  wifi: ath11k: Use michael_mic() from mac80211
  wifi: ath12k: Use michael_mic() from mac80211
  wifi: ipw2x00: Depend on MAC80211
  wifi: ipw2x00: Use michael_mic() from mac80211
  crypto: Remove michael_mic from crypto_shash API

 arch/arm/configs/omap2plus_defconfig          |   1 -
 arch/arm/configs/spitz_defconfig              |   1 -
 arch/arm64/configs/defconfig                  |   1 -
 arch/m68k/configs/amiga_defconfig             |   1 -
 arch/m68k/configs/apollo_defconfig            |   1 -
 arch/m68k/configs/atari_defconfig             |   1 -
 arch/m68k/configs/bvme6000_defconfig          |   1 -
 arch/m68k/configs/hp300_defconfig             |   1 -
 arch/m68k/configs/mac_defconfig               |   1 -
 arch/m68k/configs/multi_defconfig             |   1 -
 arch/m68k/configs/mvme147_defconfig           |   1 -
 arch/m68k/configs/mvme16x_defconfig           |   1 -
 arch/m68k/configs/q40_defconfig               |   1 -
 arch/m68k/configs/sun3_defconfig              |   1 -
 arch/m68k/configs/sun3x_defconfig             |   1 -
 arch/mips/configs/bigsur_defconfig            |   1 -
 arch/mips/configs/decstation_64_defconfig     |   1 -
 arch/mips/configs/decstation_defconfig        |   1 -
 arch/mips/configs/decstation_r4k_defconfig    |   1 -
 arch/mips/configs/gpr_defconfig               |   1 -
 arch/mips/configs/ip32_defconfig              |   1 -
 arch/mips/configs/lemote2f_defconfig          |   1 -
 arch/mips/configs/malta_qemu_32r6_defconfig   |   1 -
 arch/mips/configs/maltaaprp_defconfig         |   1 -
 arch/mips/configs/maltasmvp_defconfig         |   1 -
 arch/mips/configs/maltasmvp_eva_defconfig     |   1 -
 arch/mips/configs/maltaup_defconfig           |   1 -
 arch/mips/configs/mtx1_defconfig              |   1 -
 arch/mips/configs/rm200_defconfig             |   1 -
 arch/mips/configs/sb1250_swarm_defconfig      |   1 -
 arch/parisc/configs/generic-32bit_defconfig   |   1 -
 arch/parisc/configs/generic-64bit_defconfig   |   1 -
 arch/powerpc/configs/g5_defconfig             |   1 -
 arch/powerpc/configs/linkstation_defconfig    |   1 -
 arch/powerpc/configs/mvme5100_defconfig       |   1 -
 arch/powerpc/configs/powernv_defconfig        |   1 -
 arch/powerpc/configs/ppc64_defconfig          |   1 -
 arch/powerpc/configs/ppc64e_defconfig         |   1 -
 arch/powerpc/configs/ppc6xx_defconfig         |   1 -
 arch/powerpc/configs/ps3_defconfig            |   1 -
 arch/s390/configs/debug_defconfig             |   1 -
 arch/s390/configs/defconfig                   |   1 -
 arch/sh/configs/sh2007_defconfig              |   1 -
 arch/sh/configs/titan_defconfig               |   1 -
 arch/sh/configs/ul2_defconfig                 |   1 -
 arch/sparc/configs/sparc32_defconfig          |   1 -
 arch/sparc/configs/sparc64_defconfig          |   1 -
 crypto/Kconfig                                |  12 --
 crypto/Makefile                               |   1 -
 crypto/michael_mic.c                          | 176 ------------------
 crypto/tcrypt.c                               |   4 -
 crypto/testmgr.c                              |   6 -
 crypto/testmgr.h                              |  50 -----
 drivers/net/wireless/ath/ath11k/Kconfig       |   1 -
 drivers/net/wireless/ath/ath11k/dp.c          |   2 -
 drivers/net/wireless/ath/ath11k/dp_rx.c       |  60 +-----
 drivers/net/wireless/ath/ath11k/peer.h        |   1 -
 drivers/net/wireless/ath/ath12k/Kconfig       |   1 -
 drivers/net/wireless/ath/ath12k/dp.c          |   2 -
 drivers/net/wireless/ath/ath12k/dp_peer.h     |   1 -
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  55 +-----
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   4 -
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |   7 +-
 drivers/net/wireless/intel/ipw2x00/Kconfig    |   7 +-
 .../intel/ipw2x00/libipw_crypto_tkip.c        | 120 +-----------
 include/linux/ieee80211.h                     |   5 +
 net/mac80211/michael.c                        |   5 +-
 net/mac80211/michael.h                        |  22 ---
 net/mac80211/wpa.c                            |   1 -
 69 files changed, 32 insertions(+), 558 deletions(-)
 delete mode 100644 crypto/michael_mic.c
 delete mode 100644 net/mac80211/michael.h


base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
-- 
2.53.0


