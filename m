Return-Path: <linux-wireless+bounces-34503-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jHaVAe7G1WnA9wcAu9opvQ
	(envelope-from <linux-wireless+bounces-34503-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 05:09:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA083B678F
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 05:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E371A301828C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 03:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6EA283FF5;
	Wed,  8 Apr 2026 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2ZK7+/O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA075223339;
	Wed,  8 Apr 2026 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617766; cv=none; b=lpyUSid/FjzkJTIBNutB4pFgDQsRQHVQkMgMAaMm+Ed5g43bQFkS1etiA/SZH/Xq5j8npUtwrokEfyVblmWv38RqBOUpUzuUs4NMpMwC8ZUe/jQxNcbSgrV3a7Y1zyYBZaXtSzJL9G5eRneTiIo7Avhm0RSve7+Lm523MR6fjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617766; c=relaxed/simple;
	bh=gjVB7UOe6sjEmlcCnMJkpyU172O0A0sAn9IoAUekkMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDooVc4WmLU2IDtQJOYf1k9W0vYwYyV7mN2/4pP+zlIo+gnQkFVlNAOYvLRMb67YnbLLPsLKV2EL8V1c5BITr9K5ZOuBopYC7pUOArnpTp0pYNzmGOqvDB6Eh8Ljyj3pkK8+oYLtxJj7JWLJt+vGMjhOO7mG3kOPhVkxdEp5ym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2ZK7+/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA3FC116C6;
	Wed,  8 Apr 2026 03:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775617766;
	bh=gjVB7UOe6sjEmlcCnMJkpyU172O0A0sAn9IoAUekkMk=;
	h=From:To:Cc:Subject:Date:From;
	b=f2ZK7+/Oc8ZJP8zcnrFkrN3NruD+v2DKOB92OTCKAjphkFx7hC33sLD+MapqOI+/6
	 BMZuA6AGPUDHNJxJdJCSPjB5iQI1OAPuI6/L2htQQgX5QygQAmkQkE0UKAW/05PhnJ
	 gc61QoL3xOIbNzyjMPcVN2wDcml3ppUmJ3TDXNCAyO32BETD+JEcQ9MuGBEDkwxVKb
	 dZGdqTxqMozHEcFPnxPqczGNQiEgF15u/ODe2JGgS+utfSQWzWSMMh61ngrhpkg9pU
	 Q71wM7Km6ZHaYGbi8075h8zKP8pSXcGXuaI/ObrUSHtEnqR5uGgcQQR3EWo8VRTrC2
	 rw7ioSKxJQIdg==
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH wireless-next v2 0/6] Consolidate Michael MIC code into cfg80211
Date: Tue,  7 Apr 2026 20:06:45 -0700
Message-ID: <20260408030651.80336-1-ebiggers@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34503-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7FA083B678F
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
elsewhere, this series removes the crypto subsystem's implementation of
Michael MIC, leaving just the wireless subsystem's implementation.  To
do that, it moves the latter implementation from mac80211 to cfg80211,
then converts the above-mentioned drivers to use it.

This consolidates duplicate code and prevents other kernel subsystems
from accidentally using this insecure algorithm.

Changed in v2:

    - Added preparatory patch to fix a bisection hazard.

    - Moved michael_mic() to cfg80211 so that ipw2x00 doesn't have to
      start depending on mac80211.

    - Adjusted the 'fips_enabled' error messages, and updated the commit
      messages to clarify that ath11k and ath12k don't actually work at
      all in FIPS mode but that these patches don't aim to fix that.

Eric Biggers (6):
  wifi: ipw2x00: Rename michael_mic() to libipw_michael_mic()
  wifi: mac80211, cfg80211: Export michael_mic() and move it to cfg80211
  wifi: ath11k: Use michael_mic() from cfg80211
  wifi: ath12k: Use michael_mic() from cfg80211
  wifi: ipw2x00: Use michael_mic() from cfg80211
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
 drivers/net/wireless/intel/ipw2x00/Kconfig    |   1 -
 .../intel/ipw2x00/libipw_crypto_tkip.c        | 120 +-----------
 include/linux/ieee80211.h                     |   5 +
 net/mac80211/Makefile                         |   1 -
 net/mac80211/michael.h                        |  22 ---
 net/mac80211/wpa.c                            |   1 -
 net/wireless/Makefile                         |   2 +-
 .../michael.c => wireless/michael-mic.c}      |   5 +-
 71 files changed, 30 insertions(+), 557 deletions(-)
 delete mode 100644 crypto/michael_mic.c
 delete mode 100644 net/mac80211/michael.h
 rename net/{mac80211/michael.c => wireless/michael-mic.c} (96%)


base-commit: aa5e9884a2d63aa20fc3396d369382c1ecd16109
-- 
2.53.0


