Return-Path: <linux-wireless+bounces-36561-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPVPFidxCmqZ1QQAu9opvQ
	(envelope-from <linux-wireless+bounces-36561-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 03:53:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD53E564E28
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 03:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 479EA3012BDD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 01:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0282475CF;
	Mon, 18 May 2026 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="MA0Ex4KF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh20-1.aruba.it (smtpdh20-1.aruba.it [62.149.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4811C860A
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779069213; cv=none; b=IOifOFnpVUW2nez6RsAf2CqI6Wt7Gt2xG7ShE//7FhiJy1BwY8z6e+BQ0NQQnfkQxYQlDRs/Si6Jdrp1Pf2EbT46KXdTDXyUx4apXvvIAarGqFpgf+pvPWJrQkTqGTZDdLyiw4HkiwJ29j+Ffr1TdlcTcc1+fjIW/kwPkbkzIPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779069213; c=relaxed/simple;
	bh=j38EG0CrwL41nWBhkniE+1ThFORFCU/Ymo2Ve/yawT0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kJAwrO9JZkkLdKAzvjJpJA7fyKyQxCTZB1jTLXjekr91YrbQpm/sTJKlsuFrIYIy6+gjTm6RnXN4fUriQru4tDKb0D/HVQANLLUD9Zx9psP5ib1PNpWIC7dxINnmCJmSXdtrBbqqnEXMLAJ25w81pjIZjTZ8hUtWGbxXAnbnn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=MA0Ex4KF; arc=none smtp.client-ip=62.149.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.83] ([79.20.159.46])
	by Aruba SMTP with ESMTPSA
	id On7cwqryWEZ9tOn7dwfqb0; Mon, 18 May 2026 03:50:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779069021; bh=j38EG0CrwL41nWBhkniE+1ThFORFCU/Ymo2Ve/yawT0=;
	h=Date:MIME-Version:Subject:From:To:Content-Type;
	b=MA0Ex4KFfDN/pvSrxCO2fw01tRD1M4mx/DXyLu734hhKyXpLGT4k9Deark3VJD1at
	 HYfJ+msXqUk24lyZgXsJ+We+Du/W3PdvhcGroRxjoq004XaJd0CHLONKP0d6bWzjnw
	 /XONDxq07RsT8ey2I8mKZb+ggG+FRV/jb4/SQwDxFzNTLabFTwLXh/aLdZANe0ja+a
	 v8DPAXSqe7mhvnHVDFotCPKZ1BxKAboELtcmsSqOrk0ZvYTUhVfNQxJ3HPRsihfwLU
	 4uyt2/7CAreNv457K6DPk9OYCXc40cTR97ZC1QmfflVIW4L9n/ZE8wf0t9cU8TGCRK
	 1wbF0BOsQZgWw==
Message-ID: <ddf7b2a2-8e76-4708-a3ab-9a83db5d7d90@mythread.it>
Date: Mon, 18 May 2026 03:50:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/6] b43: add d11 core revision 0x16 to id table
Content-Language: it
From: Alessio Ferri <alessio.ferri@mythread.it>
To: linux-wireless@vger.kernel.org
Cc: b43-dev@lists.infradead.org, kvalo@kernel.org,
 linux-kernel@vger.kernel.org
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
In-Reply-To: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfC1B7BcOzHZVjxFuFA0JQKLWYMbgpio1SdFg83mQKWYll4H6ZbMyCZvh22i0NYJ9GOYwsrR7abA1p6uRlhFcEtethJLf2/Np/CCCtvo6MjUCIIxVL3nr
 aV7tpc5KaiaHd2/qyeWMaykcjH2m4AETpP9lMA3OsOCguAS9F1UNSNxSSeyJPiF87ZlWHxdhIhY8GPZHp6ypREPnRiexK3UXO0sRBpd6J8p0tMnT/ZR54cqs
 MDN1EFO9VhdbBvw6rvGxUzubjQKyqoHFj2d8u/XEgIS6YYXmG/lR138Ma7B5j2M+1o20bJvlLSjv/34q/QVwaw==
X-Rspamd-Queue-Id: CD53E564E28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36561-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add d11 core revision 0x16 (= 22) to the b43 bcma device id table.

The b43 bcma id table covers d11 revisions 0x11, 0x15, 0x17, 0x18,
0x1C, 0x1D, 0x1E, 0x28 and 0x2A. Revision 0x16 belongs to the same
N-PHY family as revisions 0x17 and 0x18 (radio 2057) and needs no
new PHY or radio code beyond the radio_rev 8 dispatcher entries
added later in this series - only the device id entry is missing.
Without it bcma scan enumerates the 802.11 core but no driver binds.

The revision is used by the Broadcom BCM6362 single-die integrated
2.4 GHz wireless block found in xDSL SoCs.

Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/net/wireless/broadcom/b43/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index b0e6aeb0b..673a56c30 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -117,6 +117,7 @@ MODULE_PARM_DESC(allhwsupport, "Enable support for all hardware (even it if over
 static const struct bcma_device_id b43_bcma_tbl[] = {
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x11, BCMA_ANY_CLASS),
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x15, BCMA_ANY_CLASS),
+	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x16, BCMA_ANY_CLASS),
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x17, BCMA_ANY_CLASS),
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x18, BCMA_ANY_CLASS),
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x1C, BCMA_ANY_CLASS),
-- 
2.43.0


Il 18/05/2026 03:49, Alessio Ferri ha scritto:
> This series completes b43 support for the Broadcom N-PHY revision 8
> paired with radio 2057 revision 8. b43 already supports the surrounding
> PHY family - N-PHY rev 8 with radio 2057 rev 5 and rev 7 are handled,
> and rev 16 with radio 2057 rev 9 is handled - but the rev 8 + rev 8
> combination falls through four dispatcher gaps:
> 
>   - radio_2057.c, r2057_upload_inittabs(), case 8 lists radio_rev 5
>     and 7 only;
>   - radio_2057.c, r2057_get_chantabent_rev7(), case 8 lists radio_rev
>     5 only;
>   - tables_nphy.c, b43_nphy_get_ipa_gain_table(), case 8 lists
>     radio_rev 5 only;
>   - radio_2057.c carries r2057_rev8_init[] as a 54-entry stub commented
>     out with "TODO: Which devices should use it?".
> 
> Two further pieces of plumbing are needed to reach those dispatchers
> in the first place: d11 core revision 0x16 is missing from the b43
> bcma id table, and the corerev 22 / radio 2057 combination needs the
> 24-bit indirect radio access path that brcmsmac uses for the same
> silicon generation (see brcmsmac/phy/phy_cmn.c read_radio_reg() /
> write_radio_reg()).
> 
> The series:
> 
>   1/6  b43: add d11 core revision 0x16 to id table
>   2/6  b43: route d11 corerev 22 to 24-bit indirect radio access
>   3/6  b43: support radio 2057 rev 8
>   4/6  b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
>   5/6  b43: add channel info table for N-PHY r8 + radio 2057 r8
>   6/6  b43: add RF power offset for N-PHY r8 + radio 2057 r8
> 
> Patches are ordered so that each one fixes the next visible failure
> in bring-up: 1/6 makes b43 bind to the core, 2/6 lets phy versioning
> read coherent radio identifiers, 3/6 unblocks the boot-time radio
> calibration that otherwise stalls the PSM at microcode startup, and
> 4/6-6/6 fill the remaining 2.4 GHz dispatcher entries so
> b43_nphy_set_channel completes to the default channel and core_init
> proceeds past PHY init.
> 
> Tested on a D-Link DSL-3580L (Broadcom BCM6362 SoC, single-die 2.4 GHz
> N-PHY rev 8 + radio 2057 rev 8 in 2.4 GHz IPA mode). The chip is in
> service worldwide in xDSL CPE devices.
> 
> b43 is currently Orphan in MAINTAINERS. These patches do not add a
> new chip family or PHY infrastructure; they fill four explicit
> dispatcher gaps for a combination of an already-supported PHY and
> an already-supported radio.
> 
> Alessio Ferri (6):
>   b43: add d11 core revision 0x16 to id table
>   b43: route d11 corerev 22 to 24-bit indirect radio access
>   b43: support radio 2057 rev 8
>   b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
>   b43: add channel info table for N-PHY r8 + radio 2057 r8
>   b43: add RF power offset for N-PHY r8 + radio 2057 r8
> 
>  drivers/net/wireless/broadcom/b43/main.c      |  10 +-
>  .../net/wireless/broadcom/b43/radio_2057.c    | 230 ++++++++++++++++--
>  .../net/wireless/broadcom/b43/tables_nphy.c   |  58 +++++
>  3 files changed, 280 insertions(+), 18 deletions(-)
> 


