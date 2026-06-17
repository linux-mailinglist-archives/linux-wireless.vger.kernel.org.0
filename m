Return-Path: <linux-wireless+bounces-37871-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hNbIL54VM2of9QUAu9opvQ
	(envelope-from <linux-wireless+bounces-37871-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 23:46:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DBD69C8F7
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 23:46:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mythread.it header.s=a1 header.b=D6kXGsZl;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37871-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37871-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=mythread.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA776302A541
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8422E3AD510;
	Wed, 17 Jun 2026 21:46:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd14162.aruba.it (smtpcmd14162.aruba.it [62.149.156.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB139DBC0
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 21:46:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781732764; cv=none; b=lHVx0kK0ZZUnN6yvoiweSdG+uDBFLTuHc29yH0WFsrBxJF4gqV60u60VNTBoNrYVy920uUHrFJG4WL1h4vqXd6TEVg6WYYM6IqcedM/dzdF2nlrdqsAeOTrjljDt0UfyPS8ibjODPX+RHRc0iZ65+JQff+ceyt21IxCRmUtCWc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781732764; c=relaxed/simple;
	bh=wbPr2nXaCc8pvhEHTa71CECEb28g9TLw8qb1ftmdqDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTeCL97sPfRK5voOIqkm1LVzRIsmIu02CJ7QJa6PAj+ftgzx/skrV3r4iH0OzPcWbY9QzI++XlQsnOlqxlcqid+npFdS46KYFqff+MlV74PaJ7hYgraEbgh1qCAEIZXvFnqoupRDaH+VG4fXAhocWjOBZj6V2DQYnDSvHWEq4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=D6kXGsZl; arc=none smtp.client-ip=62.149.156.162
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Zy28wJnjp4OeoZy28w4699; Wed, 17 Jun 2026 23:42:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1781732572; bh=wbPr2nXaCc8pvhEHTa71CECEb28g9TLw8qb1ftmdqDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:To;
	b=D6kXGsZlSYC05UaNjXwV8d23mIMMuKslM7yA0k0Hh7OaIosmov8nkaKBexdSqGi0P
	 yVJO0T4y9FEvwwupSe+hcgcdIGXhkYqouW7YhmaRR2Vmm8Tpb37drPzebVx8EYLY3N
	 Eb/3CteJubEYdgGMZLpq+84Kjkgv+ghTExkV4d6f8kZYkX8vXbKtuUHMsYHyNm8x2O
	 0mVPuftiPMqAIVMS+BNilZU1z56AP9QV4nGMyDp0eP7j5X0DMgqQAUxhH3KezK6qEN
	 hNoEoMpS0deGyrciE4vhJHU4BddCH6tobZaB5+1lik1SWpKgWjNmtb2XzDKAJDanrF
	 ygaA6rd62VzDA==
From: Alessio Ferri <alessio.ferri@mythread.it>
Date: Wed, 17 Jun 2026 23:42:08 +0200
Subject: [PATCH 1/4] bcma: host_pci: add BCM4352 device ID 0x43b3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-b43-add-4352-wip-v1-1-c81323496720@gmail.com>
References: <20260617-b43-add-4352-wip-v1-0-c81323496720@gmail.com>
In-Reply-To: <20260617-b43-add-4352-wip-v1-0-c81323496720@gmail.com>
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Michael Buesch <m@bues.ch>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 b43-dev@lists.infradead.org, Alessio Ferri <alessio.ferri@mythread.it>, 
 Alessio Ferri <alessio.ferri.3012@gmail.com>
X-Mailer: b4 0.14.3
X-CMAE-Envelope: MS4xfLXwwPZf+zvRvaxi04KLBEA+7NwsGZPt9cEHom9ia9PgTlNGuLphhMD0DYzzhzekT46IGqoJ5Ci+Kv0ZjxbyfCH3JefsPZwnhqNHbOgW39uO49hQBP5p
 Splrew9fv0Oh69c1jydST3GMK31ZUjC2UNWnoBedbHQHGbshruON6Pz7A298As4uFC4oG9gmHfKSkUFr2W+nN1X4HXptdwrPjekUYgEDcY6s8vUJt6eqj0Fv
 NkbAHhct2USse8BkK/cgGQoJ+B8SKA7b8l4bZrIvCqox+9UWYLSs2vcQlRgCxJ6rHt3v1JXYEPfKlyHmPkRDv/93Wu1CrnlNm0XJ5MFzVYv2fi8zEwrBkUPR
 w39iFSpaFaIwlk86rmDfMUFWpRSJQHuJ7f6yX/k1jmw6tW/Ke63EXNVeykJ/I3AUlt4Rk1n3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37871-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,bues.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zajec5@gmail.com,m:m@bues.ch,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:b43-dev@lists.infradead.org,m:alessio.ferri@mythread.it,m:alessio.ferri.3012@gmail.com,m:alessioferri3012@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,mythread.it,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46DBD69C8F7

From: Alessio Ferri <alessio.ferri.3012@gmail.com>

The BCM4352 is an AC PHY. It is missing from bcma_pci_bridge_tbl[],
so bcma-pci-bridge does not bind. Add the ID.

The chip identifies as BCM4352 (chip rev 3, PHY type AC); b43 with AC-PHY
support handles it once bcma reaches the D11 core.

Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/bcma/host_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bcma/host_pci.c b/drivers/bcma/host_pci.c
index 3dc2985063f1..f6cf722a3798 100644
--- a/drivers/bcma/host_pci.c
+++ b/drivers/bcma/host_pci.c
@@ -298,6 +298,7 @@ static const struct pci_device_id bcma_pci_bridge_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x43a9) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x43aa) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x43b1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x43b3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x4727) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 43227) },	/* 0xa8db, BCM43217 (sic!) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 43228) },	/* 0xa8dc */

-- 
2.54.0


