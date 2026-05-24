Return-Path: <linux-wireless+bounces-36839-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNEFDYZvE2oCBAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36839-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:37:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD065C4648
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 23:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E3CE30094C3
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2026 21:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AF73382E8;
	Sun, 24 May 2026 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="i9dh2itE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5FB3090C6
	for <linux-wireless@vger.kernel.org>; Sun, 24 May 2026 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779658626; cv=none; b=qJCQxGdSKhNhmX2dgzbRzZ8nsEejztjFGK7xC3CnbPtwuEf2pAuGX4XpIiIm7YK7jMUmsVXaN2DKdV0nVcT8GNQgl+aWFNjOPOr5DJaAIOEqn/enas0KgYD2QJfbzaJWR0dU75dt//70p5oj9iiI3Z5VjU3ZFHdClk60jXYfDps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779658626; c=relaxed/simple;
	bh=nGiMuq5oQsggp47VgQXRPVHvJULhPZFlt9aAJxCDgMM=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H51L8jeK0RfVe/Q7T9YjlfSEGE+cC+hvspXzlDdtbH48ML5vRmd5cR2pr3TKozxIrD1cSJyy230zoa1J3TImStqiGtPWRumopUN/snOpohM5S6ulonSjrZX8VTXoHzjLU3wV+e4VhTBTw0bpqknTMVNaO6AhFe19VlUYBOYCJno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=i9dh2itE; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from fedora ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id RGSLws9kZwf0DRGSLwF9e0; Sun, 24 May 2026 23:33:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779658438; bh=nGiMuq5oQsggp47VgQXRPVHvJULhPZFlt9aAJxCDgMM=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=i9dh2itEY0km5/SEoJ5DOUUqITm91LgJTJZ47GTOTNh137Xg3L4bhON81D9E2dcs6
	 JCgw+Kkd+Q2a9PYdKsNZOqYdOY0aqmADb4WSewbJVinE8VmrFtYPlwOiqTqju2Hc+h
	 rSZu8gulBm2Z+d+0uPuq+pdi356ML+wF7LEWCLVqagQesnhlD6Kws9o6e7q5yvx/MB
	 kVyvBn3mCEviQc6fegrWfZPspWXBUOhPImkvCw/kMwFO8dUBXeO7IejmSTuyBPHkpX
	 y/WKQIA0YnAPXPVpPoromW50rDSXZmhVfzVUdsfceyMrdeBI7qw4fIdgsRNL+/Xiig
	 LjwCLaeeTpzng==
Date: Sun, 24 May 2026 23:33:57 +0200
From: Alessio Ferri <alessio.ferri@mythread.it>
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] b43: complete N-PHY rev 8 + radio 2057 rev 8
Message-ID: <20260524233357.0c66e4bb@fedora>
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
X-CMAE-Envelope: MS4xfJTdJJSA0gvcntBIWyRIkKxZg/g8VWhWAAviSQBQU7kFW2tz5wbjroSqE135QI6LbtqQbkZfNDsT1YSkXFvrgZP1NLjyFZ37s5YEnNUnlwYEWmuH9vty
 ThF8/vO08VstbamSs9Bs0A9genukAgbTcD+CJNJQeeMBk57OmMdC0dLngzw+LQAftI542m1ooI8mTqKlKZJu2pqZLK7e2Fx8gHAGNSLkPZIftwOHhj5Bjze7
 AQNPrvmjLvLSGTMHEDaF6RXip4dQqhJz43GsL90Vo5E=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	TAGGED_FROM(0.00)[bounces-36839-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:email,mythread.it:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9AD065C4648
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Add d11 core revision 0x16 (= 22) to the b43 bcma device id table.

The b43 bcma id table covers d11 revisions 0x11, 0x15, 0x17, 0x18,
0x1C, 0x1D, 0x1E, 0x28 and 0x2A. Revision 0x16 belongs to the same
N-PHY family as revisions 0x17 and 0x18 (radio 2057) and needs no
new PHY or radio code beyond the radio_rev 8 dispatcher entries
added later in this series - only the device id entry is missing.
Without it bcma scan enumerates the 802.11 core but no driver binds.

The revision is used by the Broadcom BCM6362 single-die integrated
2.4 GHz wireless block found in xDSL SoCs.

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/net/wireless/broadcom/b43/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/b43/main.c
b/drivers/net/wireless/broadcom/b43/main.c index 37c5d9928..85ea8fdd9
100644 --- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -117,6 +117,7 @@ MODULE_PARM_DESC(allhwsupport, "Enable support for
all hardware (even it if over static const struct bcma_device_id
b43_bcma_tbl[] = { BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x11,
BCMA_ANY_CLASS), BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x15,
BCMA_ANY_CLASS),
+	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x16,
BCMA_ANY_CLASS), BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x17,
BCMA_ANY_CLASS), BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x18,
BCMA_ANY_CLASS), BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x1C,
BCMA_ANY_CLASS),

-- 
2.54.0

