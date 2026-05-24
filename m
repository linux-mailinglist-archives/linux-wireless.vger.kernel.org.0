Return-Path: <linux-wireless+bounces-36833-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJsNOTBvE2oCBAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36833-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:35:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1895C4621
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEE0830082A0
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 21:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A38C31F9A7;
	Sun, 24 May 2026 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="NjD8Q/Z4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd0641.aruba.it (smtpcmd0641.aruba.it [62.149.156.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1E3090C6
	for <linux-wireless@vger.kernel.org>; Sun, 24 May 2026 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779658541; cv=none; b=Y+gu6PK170/gN8VHQ9tE2J69GIryOQrstxNRnvxQf1jeqrKGVSL0NjBBGTCYnRoUTJjH6zfoKoggZYkFGY3LGfQvikLbEUmcCqyEzLaJBULVdkc8HeVUOB96GfQ/5TgcVSpDzp3OzoilckdkAKNWiACMvMGd7LvYvPFNAVoWQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779658541; c=relaxed/simple;
	bh=m0REJhaxcRJwCTBGdPDcGM5Fijd0rMwrvKjjNFNpgh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZztDt6F2lQpMjFA08rjpkqzcE0IG4fGRtRXf8gweM7tGAw1lxmrFpLjItsJShZxz4nYzWK9o5dJdHP0UKZgUNfIUk2cNueITIZgCypwdIcFHwkO5pZ89IAEeZqBCe06qFFwgtKEu9aP7PJLVlOj8IFvuzwyxaOR3GBzhZhz4trc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=NjD8Q/Z4; arc=none smtp.client-ip=62.149.156.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from fedora ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id RGQuwYwDbdarQRGQuwhVxX; Sun, 24 May 2026 23:32:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779658349; bh=m0REJhaxcRJwCTBGdPDcGM5Fijd0rMwrvKjjNFNpgh4=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=NjD8Q/Z4igszcbgU+YW1tkruvgdFro2O9hvqzzV8Q+YFHFar6oJxTBVEEX0TAk0hh
	 kgGtlPxmXWpAXZKRbGBLZMBK8JAWRkNk5a1uFdNAufnOXpDih1dYPWhLglNrSnJvNe
	 vgzqn4JY9cdYKzKKg/JepY7pM1LOngOBCwDXbLj9koRPeT0Jex08SNgjFcfgnJFpGm
	 rYqivDZ0UhBC+epWdXGIp1dTHuTxOXlc2UzCvptdwhb6luhsEvNx7a52L1D7oGdvJ+
	 m1+ieLrtyBz9AJRJu4s2Amz71pX/bMjnfx2ABXtkdlXcBQcLtbapH1pC7WFgOpinnt
	 ghTLiFR+vUPjA==
Date: Sun, 24 May 2026 23:32:28 +0200
From: Alessio Ferri <alessio.ferri@mythread.it>
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Alessio Ferri <alessio.ferri@mythread.it>
Subject: [PATCH v2 0/7] b43: complete N-PHY rev 8 + radio 2057 rev 8
Message-ID: <20260524233228.06b38dba@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-CMAE-Envelope: MS4xfHUUC3megLIxOwdKxOE5gl7Z8Rio0EGswsyT/jlAlmxiZ1Olxpd0bG0P0UKKR2z9hP7LeQyhsrokX65guCe4d7CgdCreziIOf8QR6IJHo62gZzKK1ZRJ
 XAWTixZlS00YIdGZtHlksI3ShvieXvFEXASkuIJ0RWyVSHAxKv87r4u9YuIpaBQgMyPZUivKVkuXQkfvr5Xa4pJaZn3X4s6fOVaEUytJwKwU0pZIP6ekh4k9
 yQCCrCNZJLEUQFtmnLhKKQNoWSxeHCwSaqeyZvYPS6ZHIY8JE6PuSqiaCIruV4iKIgPE8+NoeDid1YR0rGP2eg==
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36833-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[mythread.it:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5A1895C4621
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This series completes b43 support for the Broadcom N-PHY revision 8
paired with radio 2057 revision 8. b43 already supports the surrounding
PHY family - N-PHY rev 8 with radio 2057 rev 5 and rev 7 are handled,
and rev 16 with radio 2057 rev 9 is handled - but the rev 8 + rev 8
combination falls through four dispatcher gaps:

  - radio_2057.c, r2057_upload_inittabs(), case 8 lists radio_rev 5
    and 7 only;
  - radio_2057.c, r2057_get_chantabent_rev7(), case 8 lists radio_rev
    5 only;
  - tables_nphy.c, b43_nphy_get_ipa_gain_table(), case 8 lists
    radio_rev 5 only;
  - radio_2057.c carries r2057_rev8_init[] as a 54-entry stub commented
    out with "TODO: Which devices should use it?".

Two further pieces of plumbing are needed to reach those dispatchers
in the first place: d11 core revision 0x16 is missing from the b43
bcma id table, firmware name, and the corerev 22 / radio 2057
combination needs the 24-bit indirect radio access path that brcmsmac
uses for the same silicon generation (see brcmsmac/phy/phy_cmn.c=20
read_radio_reg() / write_radio_reg()).

The series:

  1/7  b43: add firmware and initvals names for rev22
  2/7  b43: add d11 core revision 0x16 to id table
  3/7  b43: route d11 corerev 22 to 24-bit indirect radio access
  4/7  b43: support radio 2057 rev 8
  5/7  b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
  6/7  b43: add channel info table for N-PHY r8 + radio 2057 r8
  7/7  b43: add RF power offset for N-PHY r8 + radio 2057 r8

Patches almost reveal the bringup, the first two are swapped, as=20
applying 2/7 without 1/7 generate an immediate kernel panic caused=20
by a null deref.
=46rom the third, each one fixes the next visible failure
in bring-up: 3/7 lets phy versioning read coherent radio identifiers,=20
4/7 unblocks the boot-time radio calibration that otherwise stalls,=20
and 5/7-7/7 fill the remaining 2.4 GHz dispatcher entries so
b43_nphy_set_channel completes to the default channel and core_init
proceeds past PHY init.

Tested on a D-Link DSL-3580L (Broadcom BCM6362 SoC, single-die 2.4 GHz
N-PHY rev 8 + radio 2057 rev 8 in 2.4 GHz IPA mode).

b43 is currently Orphan in MAINTAINERS. These patches do not add a
new chip family or PHY infrastructure; they fill four explicit
dispatcher gaps for a combination of an already-supported PHY and
an already-supported radio.

CHANGELOG:
v2:
  - Recovered the first patch of the series, so numbering is now /7
  - Added Assisted-By header
v1:
https://lore.kernel.org/linux-wireless/8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a=
@mythread.it/

Signed-off-by: Alessio <alessio.ferri@mythread.it>
---
Alessio Ferri (7):
      b43: add firmware mappings and remove comments wondering about
rev22 initvals b43: add d11 core revision 0x16 to id table
      b43: route d11 corerev 22 to 24-bit indirect radio access
      b43: support radio 2057 rev 8
      b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
      b43: add channel info table for N-PHY r8 + radio 2057 r8
      b43: add RF power offset for N-PHY r8 + radio 2057 r8

 drivers/net/wireless/broadcom/b43/main.c        |  22 ++-
 drivers/net/wireless/broadcom/b43/radio_2057.c  | 230
 ++++++++++++++++++++++--
 drivers/net/wireless/broadcom/b43/tables_nphy.c |  58 ++++++ 3 files
 changed, 290 insertions(+), 20 deletions(-) ---
base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
change-id:
 20260521-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-a3125f06e21e

--=20

