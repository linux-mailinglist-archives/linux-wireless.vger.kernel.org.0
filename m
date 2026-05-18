Return-Path: <linux-wireless+bounces-36563-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK49EVFxCmqZ1QQAu9opvQ
	(envelope-from <linux-wireless+bounces-36563-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 03:54:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6ED564E3F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 03:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 685C0300DE3B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 01:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741DB481DD;
	Mon, 18 May 2026 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="TcRybzlL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh20-1.aruba.it (smtpdh20-1.aruba.it [62.149.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E41FECBA
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779069261; cv=none; b=QhQYbQPNfagPFgvKb38Gb81ofNjVoHwIfvCpq9YD9Xg9jKRv9h1qGrsnnE0tnfAdjvw+sM92rw3soTOCSq36RPHB2YmTNkYZQcuodDOxHaiyfx5wkbk/q3F9d/8Tg5oLhpvuEzlnZfg7qi/h1c8WJrCeLFOplZ/T+ZX4p5AASRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779069261; c=relaxed/simple;
	bh=Mdt8NKJaOHbPoFDFNwE0LYxPnB/LN/w2c+7vx0TXwuU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JEg6k6t44D20BwKlLpa3fU5hcu/0bpOlX84G+Q8x1XvWNjRsSgHk+Ib7M9Q/jrIUuSCY3eCkdTaA7yY69X91KCt6VVbyHUpnZE6hZ+eCW/4tMr9xo9wkZDRj1Ve9dNne7jodrzWm6p+mlTuWsPj26lhtDPCg+oBX5F7iP39pDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=TcRybzlL; arc=none smtp.client-ip=62.149.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.83] ([79.20.159.46])
	by Aruba SMTP with ESMTPSA
	id On8ZwqsNYEZ9tOn8Zwfqmp; Mon, 18 May 2026 03:51:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779069079; bh=Mdt8NKJaOHbPoFDFNwE0LYxPnB/LN/w2c+7vx0TXwuU=;
	h=Date:MIME-Version:Subject:From:To:Content-Type;
	b=TcRybzlL4unEkmn3HQ+l0zrFsVip8JNk1J4o4XFq0reCuxQ/6WZQeGw41OQ2cO7Zu
	 h6BraMxsTB99XL0mN1nDVHEEJ+iJA4+WuLe/w/mm21IsEyw7/8VmBOWAvlSXF4UtGO
	 DO75X0xpPZ/KyNZIKOP9FjAyxfqSQE+nWi8evAhSCUyFyNT65poIcoTch9z77JC7Qu
	 ZVdYRhAsd/KW39yLFAVgHnXqQWdieJrtvNl0SWkze0pnPI+2a0aEmFk565iTRdYZJp
	 CmMXYZXzMNBbvoipX9ZD1SD03w3jtiQXDMSS4kP286ek7/KLf5pXlOBRa2gxfXNWEb
	 gy4MqV1OWbPBQ==
Message-ID: <3c2cba9c-8dc4-47a1-adb7-a7fd38d295e7@mythread.it>
Date: Mon, 18 May 2026 03:51:18 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/6] b43: route d11 corerev 22 to 24-bit indirect radio access
Content-Language: it
From: Alessio Ferri <alessio.ferri@mythread.it>
To: linux-wireless@vger.kernel.org
Cc: b43-dev@lists.infradead.org, kvalo@kernel.org,
 linux-kernel@vger.kernel.org
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
In-Reply-To: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfP+XANS/QP1ra5UIaxa6kPPRnUIq9DQSmK0PVDFsnIp8aJv/n3TC3QQFtM3ejpds/GSXSX6U1rbgd+lM8Q8bTEtOCsJjskiiDA1vBixmmTGOZLGvSOH3
 9FVFmJog/ceo8GT0NIHZgHSdrQYYfMuNc7SFHstO4GiZuG+jYdujdCwHixagKeQhkd98TwNyxNvBx719AnI6D5jYwd8DZrIcPpSIbRPMt3UMYHyUwz7mnJuS
 ESTWRod6bDGHKbZ6zl19IAT/I0cyMQaWSaAsEJM95tUa4U3KD/eJbjTXbxBRSR3q11cge/6iQsHUSERicnAO8w==
X-Rspamd-Queue-Id: 9A6ED564E3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36563-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:email,mythread.it:mid,mythread.it:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

D11 core revision 22 is an outlier in the corerev-to-radio-access
mapping. b43_phy_versioning() reads radio identifiers via two
different paths:

  - core_rev >= 24: 24-bit indirect access (B43_MMIO_RADIO24_CONTROL
    + B43_MMIO_RADIO24_DATA);
  - otherwise: legacy 4-wire access (B43_MMIO_RADIO_CONTROL +
    B43_MMIO_RADIO_DATA_LOW/HIGH).

Corerev 22 backports the older 802.11 core but pairs it with a radio
in the 2057 family, which requires the 24-bit indirect path. With
the current dispatch, corerev 22 falls into the legacy 4-wire branch,
reads garbage for radio_id, and bails out with -EOPNOTSUPP at the
"FOUND UNSUPPORTED RADIO" branch below.

brcmsmac handles the same silicon family with the equivalent
dispatch in drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/
phy_cmn.c read_radio_reg() and write_radio_reg():

    if ((D11REV_GE(pi->sh->corerev, 24)) ||
        (D11REV_IS(pi->sh->corerev, 22)
         && (pi->pubpi.phy_type != PHY_TYPE_SSN))) {
            /* radioregaddr / radioregdata (indirect) */
    } else {
            /* phy4waddr / phy4wdatalo (legacy)      */
    }

The "phy_type != PHY_TYPE_SSN" carve-out in brcmsmac is for the SSN
PHY variant of corerev 22, which uses the legacy path. b43 does not
support SSN/SSLPN PHYs - they are rejected earlier in
b43_phy_versioning() at the "unsupported PHY type" switch - so by
the time control reaches the radio versioning dispatch there is no
SSN device to mis-route. A positive (core_rev == 22) clause is
therefore sufficient and equivalent.

Encountered on the Broadcom BCM6362 single-die integrated 2.4 GHz
wireless block (radio 2057 rev 8, paired with d11 corerev 22 on
this silicon).

Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/net/wireless/broadcom/b43/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 673a56c30..7f96df5eb 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -4555,7 +4555,11 @@ static int b43_phy_versioning(struct b43_wldev *dev)
 		radio_id = b43_read16(dev, B43_MMIO_RADIO24_DATA);
 
 		radio_ver = 0; /* Is there version somewhere? */
-	} else if (core_rev >= 24) {
+	} else if (core_rev >= 24 || core_rev == 22) {
+		/*
+		 * D11 corerev 22 pairs an older 802.11 core with a 2057
+		 * radio that requires the 24-bit indirect access path.
+		 */
 		u16 radio24[3];
 
 		for (tmp = 0; tmp < 3; tmp++) {
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


