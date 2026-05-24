Return-Path: <linux-wireless+bounces-36840-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFU0NDtwE2oCBAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36840-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:40:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFE55C46A3
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9C8230238EA
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 21:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFD733B97D;
	Sun, 24 May 2026 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="TIXm0K6+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8A31F9A7
	for <linux-wireless@vger.kernel.org>; Sun, 24 May 2026 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779658643; cv=none; b=sqK3Xxxm9dWE+ATmWzRY/2+3eZOC9uAIKWAAXoed70bFuzkg7PYHbk0/98j/rZI4WxgG4CCTQiWrYQuCcDtirjeVfA8hyRdabhd7CZSXby8+YNXebd1ueZXk61tRoGAQmU9ofOSFnLX2DJXTlauPB6lIgza2hUUoTd079iTD3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779658643; c=relaxed/simple;
	bh=RG0KZyQtlU1j74lUouM9Mvo7qOrsOrUFD/m4zDgFqlo=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awIOf8kk9l62okjeK5oMCsrnYIw5H5q6j1VALrgUmblDjbhGeFVxzCoYdyE6HKGBnkDe/RrKIqLGQz4vgsiqtlwgBp5SJBEJXwmBAD+Izs0+dhnGUKgBKo1LnocZVV79MptKhExRUIW8Qp7TXv8q05XYIUluwkiyev/98rnGee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=TIXm0K6+; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from fedora ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id RGSjwsAAMwf0DRGSjwF9mP; Sun, 24 May 2026 23:34:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779658461; bh=RG0KZyQtlU1j74lUouM9Mvo7qOrsOrUFD/m4zDgFqlo=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=TIXm0K6+Ud7Otyd9JGISay2DBVJgm6ley7d4uhYVzCpCytA3L46Jej0geZrCk+/lp
	 rBDSZhjSri8v0AASNCBm36YLaB6EpvjoDaxpL7P6/3nH4lA67a4UgGIhBzyJNBKL78
	 Qg+4ysAFSMH/EOVC9rGcGGeulQ0sj7xsyxHUoy1T8n2xWqwN5QDK/n9FfafimHCFwh
	 zToqCzT6YrAW+wiTxl5vjLGFbFjkH502SqLzQqofp9LrMXnHjXKpGGKZQsDrp0C3dy
	 gXVZo8IakMfHY/7zmorTwhMdd/gu+EGI8zy7pEa+tU53tFOGUiOevTgQcZFnIN1EGf
	 bPYSqmqVBhLQg==
Date: Sun, 24 May 2026 23:34:21 +0200
From: Alessio Ferri <alessio.ferri@mythread.it>
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] b43: complete N-PHY rev 8 + radio 2057 rev 8
Message-ID: <20260524233421.3586440f@fedora>
In-Reply-To: <20260524233228.06b38dba@fedora>
References: <20260524233228.06b38dba@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAjxe4MLZWq4FGrKWsG+dGrIeOwazvdChQn9UJRf7ZGS4bgHXonLXNFPaNn6bgLxjJ9Z24GTtcGakcSxL8puiaJipt3bU9HD5HpEN480QcTmN83t357/
 D7u560BfcSDpAkYrZRTXtvZp/LO791ZO8IxdwwO6mthh83pMToPOdMbWH/HrtyIxIqc2ze9ty94NFKebR5QxveIGfsR2DSx12351lH3OTo/u755B0yGrowGQ
 x/ocO8df1icjVYkCrgjsYxlgHrfCNDL5DYW0D9b1nWE=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	TAGGED_FROM(0.00)[bounces-36840-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:email,mythread.it:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2CFE55C46A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Rev 22 backports the older 802.11 core but pairs it with a radio
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

b43 does not support SSN/SSLPN PHYs - they are rejected earlier in
b43_phy_versioning() at the "unsupported PHY type" switch - so just
adding the check corerev == 22 will do.

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/net/wireless/broadcom/b43/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c
b/drivers/net/wireless/broadcom/b43/main.c index 85ea8fdd9..783af26cb
100644 --- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -4563,7 +4563,11 @@ static int b43_phy_versioning(struct b43_wldev
*dev) radio_id = b43_read16(dev, B43_MMIO_RADIO24_DATA);
 
 		radio_ver = 0; /* Is there version somewhere? */
-	} else if (core_rev >= 24) {
+	} else if (core_rev >= 24 || core_rev == 22) {
+		/*
+		 * D11 corerev 22 pairs an older 802.11 core with a
2057
+		 * radio that requires the 24-bit indirect access path.
+		 */
 		u16 radio24[3];
 
 		for (tmp = 0; tmp < 3; tmp++) {

-- 
2.54.0

