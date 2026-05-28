Return-Path: <linux-wireless+bounces-37074-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKlSKDd/GGpBkggAu9opvQ
	(envelope-from <linux-wireless+bounces-37074-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 19:45:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0E95F5D7D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 19:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E28630498CE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01F43FCB06;
	Thu, 28 May 2026 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="l++jPRxu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpweb146.aruba.it (smtpweb146.aruba.it [62.149.158.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E553FD971
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989697; cv=none; b=ITTf+N7ZD2gTRFR2Dq8kye6WfByBr/2cfY9Xc0uzdXl+fM20MibRNPggmJzHvnxUqAXMXIi54QGOdZ3+VZZYggnVUWZONt1zWVqYT1KfqhPrkWjqbEaouQoy6JnDIoNatX82QYVkEzDV8/HkkdIgUEQH4aksrkQVrgRWnCbGGyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989697; c=relaxed/simple;
	bh=x/C7YXh4n4v0Noj27OMkH+Jht47ZFV6pK6P7tks4i4U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=lPMgOzimdiuEEpFZcvKu0/56nXYjWDLjaaOjf97sh8PSsR49sWZEq12qzqlgcHxQ35A2RrgvBx86BC5TYl0AM4UiJ6jVQgbddX5zXGvpA8Jv8AAXs7oBjBmue9SH5E1uqNOvRM3p7gefPPmt9/tpQhkKpcH/M/ZwdwfuokVAFyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=l++jPRxu; arc=none smtp.client-ip=62.149.158.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Sea5wczvrrbJKSea5w6A2x; Thu, 28 May 2026 19:31:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779989502; bh=x/C7YXh4n4v0Noj27OMkH+Jht47ZFV6pK6P7tks4i4U=;
	h=From:Subject:Date:MIME-Version:Content-Type:To;
	b=l++jPRxuiVCSwEHI4Z9PzE+zWObhL8lppF+zVAj4VOBRI8vBll3mfuYDSvBhpBYmI
	 OQ+kdWYCkRu5hNqLQMqODf1G5aTOG1Q6/kTxweMj40Qx5viYRoV3UXZHvPb6VrcZlE
	 A5ieRhHduhgbie2ubKEDiVde9s8yMlX+HcBY61Yyc4L59rEi+NmyRS/h6+NA/TaFyl
	 xA534Ft/kGSc/vJtUD7PUVcx6w6RVH614MUXIxg1q1Zj2zGz/e+0B/gAFeHZ5/7eTR
	 Z7D/EF6HKhdAacOYoe+GUj8+06lufoxLMIaMllRhrC5KTadrY8XPuOc4+pvGbtoSvA
	 qv5kVkJObOFow==
From: Alessio Ferri <alessio.ferri@mythread.it>
Subject: [PATCH v4 0/7] b43: complete N-PHY rev 8 + radio 2057 rev 8
 support
Date: Thu, 28 May 2026 19:31:34 +0200
Message-Id: <20260528-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v4-0-464566194d47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/52OQQ6DIBREr2JYlwa+Qk1XvUdjCIWvkqgQsKbGe
 PdS016gyzfJzJuNJIwOE7kWG4m4uOT8lKE6FcT0euqQOpuZAAPJBHD6qEpl/BgGnFFNKvSryj1
 Vq6it8wqYuHyD9AzBx5nqkoNomUTgSPJuiNi61+G8N5l7l2Yf1+PCwj/pz1b9YVs4ZdRYbcHUA
 qSRt27UbjjnFdLs+/4G3ebSIPIAAAA=
X-Change-ID: 20260521-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-a3125f06e21e
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alessio Ferri <alessio.ferri@mythread.it>
X-Mailer: b4 0.14.3
X-CMAE-Envelope: MS4xfOUW+OMsbislXLVfjghoLiIMSllfjXG3jKhyT1qtr1TPotfGmGoeb8vIdxFRzON3ha+X1I01ALnINSxjunIRNJpkd+hb2Tso3vfQ6c4Al8AAeBDPURzQ
 29rmtnLnULRa/0VO3EcRCGmWXrooQhLCSqu40xytABMkKlcKB3hRVoC95GKPgsnpJAd3K9lN6GO5nNKsx17R2Mutn7NSdr9S/uiqb1CtsCb/hg8E+yllqt/u
 ISNj8R6MRy9W4IQM8xcXYODVPcwBRGWI658r2/xDq9z4g/xbS34L7GLyOev25WmdqYS+z22dTV35Abi8K3uXSBOpyhKw+cyRTuLnPPUyqtk=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37074-lists,linux-wireless=lfdr.de];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:email,mythread.it:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+]
X-Rspamd-Queue-Id: 3B0E95F5D7D
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
bcma id table, firmware name, and the corerev 22 / radio 2057 combination
needs the 24-bit indirect radio access path that brcmsmac uses for
the same silicon generation (see brcmsmac/phy/phy_cmn.c
read_radio_reg() / write_radio_reg()).

The series:

  1/7  b43: add firmware and initvals names for rev22
  2/7  b43: add d11 core revision 0x16 to id table
  3/7  b43: route d11 corerev 22 to 24-bit indirect radio access
  4/7  b43: support radio 2057 rev 8
  5/7  b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
  6/7  b43: add channel info table for N-PHY r8 + radio 2057 r8
  7/7  b43: add RF power offset for N-PHY r8 + radio 2057 r8

Patches almost reveal the bringup, the first two are swapped, as
applying 2/7 without 1/7 generate an immediate kernel panic caused
by a null deref.
From the third, each one fixes the next visible failure
in bring-up: 3/7 lets phy versioning read coherent radio identifiers,
4/7 unblocks the boot-time radio calibration that otherwise stalls,
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
v4: reword patch 1/7 commit
v3: no changes, fighting with b4
v2:
  - Recovered the first patch of the series, so numbering is now /7
  - Added Assisted-By header
v1: https://lore.kernel.org/linux-wireless/8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it/

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
---
Alessio Ferri (7):
      b43: add firmware mappings for rev22
      b43: add d11 core revision 0x16 to id table
      b43: route d11 corerev 22 to 24-bit indirect radio access
      b43: support radio 2057 rev 8
      b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
      b43: add channel info table for N-PHY r8 + radio 2057 r8
      b43: add RF power offset for N-PHY r8 + radio 2057 r8

 drivers/net/wireless/broadcom/b43/main.c        |  22 ++-
 drivers/net/wireless/broadcom/b43/radio_2057.c  | 230 ++++++++++++++++++++++--
 drivers/net/wireless/broadcom/b43/tables_nphy.c |  58 ++++++
 3 files changed, 290 insertions(+), 20 deletions(-)
---
base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
change-id: 20260521-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-a3125f06e21e

Best regards,
-- 
Alessio Ferri <alessio.ferri.3012@gmail.com>


