Return-Path: <linux-wireless+bounces-36560-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 96JiJvRwCmqZ1QQAu9opvQ
	(envelope-from <linux-wireless+bounces-36560-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 03:52:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAC5564E12
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 03:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D5E93008E14
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 01:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DE01C860A;
	Mon, 18 May 2026 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="TSIaEwYV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh20-2.aruba.it (smtpdh20-2.aruba.it [62.149.155.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A78481DD
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779069167; cv=none; b=pJzGV+PSyMSndyNyFR9vaYUHKwrtKUjvRPWz9j/ftmF6aPUinBkiHHJ4Syl625Y9/B1rCzJ6gD1fEC54wAKCcvXSeUQ3hYO1dg9LIQtkMNchF2ppy0EOty1mbybBce9cM0zxy1YiU9iti0ZAAwuUYIdexAZqcnmLXSMAYWfEsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779069167; c=relaxed/simple;
	bh=SHO4+MK+hS8uojnJO+haPscX134HfONcXTn+yvuHD+w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=X4R6DFjbQu+cxjvYd3EHfzN+l0ZaMwa5m9iQWipJzyKWXe+GnCIBgHZM9cRl4HuUYP7U0p3wUx+EcIothsOjUToylGfOa0NieE4KYxgISABbw/900v0JM8WEVyEeochzUsBsOU2LWgRO6UgDpZqaAnZj3oTWBls6ZlB5Iv4QfIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=TSIaEwYV; arc=none smtp.client-ip=62.149.155.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.83] ([79.20.159.46])
	by Aruba SMTP with ESMTPSA
	id On6swqrhpEZ9tOn6swfqTW; Mon, 18 May 2026 03:49:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779068974; bh=SHO4+MK+hS8uojnJO+haPscX134HfONcXTn+yvuHD+w=;
	h=Date:MIME-Version:To:From:Subject:Content-Type;
	b=TSIaEwYV7o446kaC1GM5fiSEwRyYp9M5POAPatYaE+CGIWhtIcFejlpfTTuCwcFSN
	 8BpQ5OErtQXPUcwhPw5nTaE7duoFxP6bg3mtKe8CT0syJOFFUpK9cdHUytZGWI5bY0
	 01h9SaBeL2soafbQ1spopVRszRpLs/o99xzP2mV58cLZH3qBBj69E8dkg+qKdJsDw7
	 pVkRVEtdhe5TdzpnRHD25ZtNw50Ovz/N6ChCg1v53uyTyAUVvjfH7NrG22urk+q1X5
	 BAfbnGuBuxyIhtg/qt1F+MhuK4Em8/XdiTL8UEkByA9wKcANwFkAtZbLVGQDbehGT/
	 UuVfHTpHCPuDw==
Message-ID: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
Date: Mon, 18 May 2026 03:49:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: it
To: linux-wireless@vger.kernel.org
Cc: b43-dev@lists.infradead.org, kvalo@kernel.org,
 linux-kernel@vger.kernel.org
From: Alessio Ferri <alessio.ferri@mythread.it>
Subject: [PATCH 0/6] b43: complete N-PHY rev 8 + radio 2057 rev 8 support
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDqvqqxGvya9CMsdk3xvdzgpoz8C1zpFiotCxr9vpXzvhYs0wwH1k9beIjgICJpv5HYMu4k2oUsPH+7fieVYrHCzcTE53YYAcbaYVK3LQ7tjbIk1k2Kl
 WMEa0oInbzCpQb/SSNPqaYvPIcpui3hE5bU2woVNvmnswgY7VlhviJoEdEi88MKxxgI/S/L2IuRZKsv+jf2yei/WYXwzKXDzfqlB0fnjCJYB3bhl1H+NjrBB
 RClS8xfp0u3EKbLVkTinJaZzeBitoMgmx9AVHwmiNMAEUWobz2u6UG71QHC6yL4ZhIJLrf2+iTHmbSgTYtLNbQ==
X-Rspamd-Queue-Id: 0BAC5564E12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36560-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
bcma id table, and the corerev 22 / radio 2057 combination needs the
24-bit indirect radio access path that brcmsmac uses for the same
silicon generation (see brcmsmac/phy/phy_cmn.c read_radio_reg() /
write_radio_reg()).

The series:

  1/6  b43: add d11 core revision 0x16 to id table
  2/6  b43: route d11 corerev 22 to 24-bit indirect radio access
  3/6  b43: support radio 2057 rev 8
  4/6  b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
  5/6  b43: add channel info table for N-PHY r8 + radio 2057 r8
  6/6  b43: add RF power offset for N-PHY r8 + radio 2057 r8

Patches are ordered so that each one fixes the next visible failure
in bring-up: 1/6 makes b43 bind to the core, 2/6 lets phy versioning
read coherent radio identifiers, 3/6 unblocks the boot-time radio
calibration that otherwise stalls the PSM at microcode startup, and
4/6-6/6 fill the remaining 2.4 GHz dispatcher entries so
b43_nphy_set_channel completes to the default channel and core_init
proceeds past PHY init.

Tested on a D-Link DSL-3580L (Broadcom BCM6362 SoC, single-die 2.4 GHz
N-PHY rev 8 + radio 2057 rev 8 in 2.4 GHz IPA mode). The chip is in
service worldwide in xDSL CPE devices.

b43 is currently Orphan in MAINTAINERS. These patches do not add a
new chip family or PHY infrastructure; they fill four explicit
dispatcher gaps for a combination of an already-supported PHY and
an already-supported radio.

Alessio Ferri (6):
  b43: add d11 core revision 0x16 to id table
  b43: route d11 corerev 22 to 24-bit indirect radio access
  b43: support radio 2057 rev 8
  b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
  b43: add channel info table for N-PHY r8 + radio 2057 r8
  b43: add RF power offset for N-PHY r8 + radio 2057 r8

 drivers/net/wireless/broadcom/b43/main.c      |  10 +-
 .../net/wireless/broadcom/b43/radio_2057.c    | 230 ++++++++++++++++--
 .../net/wireless/broadcom/b43/tables_nphy.c   |  58 +++++
 3 files changed, 280 insertions(+), 18 deletions(-)

-- 
2.43.0


