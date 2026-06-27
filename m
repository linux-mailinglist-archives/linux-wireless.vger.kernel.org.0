Return-Path: <linux-wireless+bounces-38206-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QF8cAvAgQGpgcAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38206-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 21:13:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 638226D2877
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 21:13:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=justthetip.ca header.s=key1 header.b=BNS2THqI;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38206-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38206-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=justthetip.ca;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3236300F9EE
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 19:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E833B6C4;
	Sat, 27 Jun 2026 19:13:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14130C618
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 19:13:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782587627; cv=none; b=HU8b2czjMBSWDn4roAVeSoxnfTEKtQcYrxiGbxKYKoh2dscl8YYIW5EjQ0PgGBWEMSZDlA5AtaqM4NuDnJACLJF0LOs4ylcplyDjFHbkvmiDNwZtkSsYbelf/JFvD8KEIp8XXywAvA/S19BwD1dd2853+RGbiOlp6yVCcdM8Lf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782587627; c=relaxed/simple;
	bh=g/b49vB9WnlFn6jVYcE+oDOg8tL8u591dk+98+nm4/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mR/LjCdUWCH/EltaAfmTpNm4GAv19qKTkZo/psEMNVJy7CiS0ld33hsKSS7owQN/NDxDWL6mXOxVxB3hdzsnQEHWQAcLqluMbmgCS2n002SPcCIygphktYSkwfPUEfaXZQEfDfhNBLW4rklqVrb6/yG9ztfdJ3jjVwtIjrdAUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=BNS2THqI; arc=none smtp.client-ip=91.218.175.177
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1782587621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=avS2FSFhlwL5nb1Fc8PZ/lOaiZOoEiMWRiRXPXE6xd8=;
	b=BNS2THqIlaWX8Ag84rLq5W/z/58VetbZw7t8lIDRv4289eoczRr6JOizxsN86FAVmGKEGv
	DuXeSJ2JzXADgLS2GKjE5dcb5gCP36tmnYoD/DcN1h1vfEKolzrrqJ+Nota89nb8zMEcuM
	MghzfhlxxGHQEWksqclQNGX8GN7H4ASRLXCZXpKLIFgUout7W0M4vc49Bp0sd1icdoA3y0
	LaOSDOBLbYXXZ7vwtPiW3nprK+eLDv3eA04VMUQfgKHcz3PXmBsmn3XfmAPC1ptMpI5XuQ
	nA8c7J4bU9WYdD1Nvr+1WbxWWBqYwauTObQrhag4IzuiZrVysGYA0R/qwVHBKA==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	linux-wireless@vger.kernel.org
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] wifi: mt76: drop TXRX_NOTIFY on non-mmio buses
Date: Sat, 27 Jun 2026 12:13:33 -0700
Message-ID: <20260627191336.20223-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38206-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:linux-wireless@vger.kernel.org,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:mingyen.hsieh@mediatek.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 638226D2877

PKT_TYPE_TXRX_NOTIFY is an mmio-only event, but the mt7921, mt7925 and
mt7615 RX classifiers dispatch it to *_mac_tx_free() on every bus. That
cleans the DMA tx queues via queue_ops->tx_cleanup(), a callback only
the mmio queue ops implement, so on USB or SDIO the event calls a NULL
pointer in the RX worker.

Reproduced on mt7921u (Alfa AWUS036AXML) and mt7925u (NETGEAR A9000):
the unpatched driver oopses, the patched driver drops the event. mt7615
is the same dispatch, fixed by inspection.

Each patch guards the path with mt76_is_mmio(), as in
commit 5683e1488aa9 ("wifi: mt76: connac: do not check WED status for
non-mmio devices").

Devin Wittmayer (3):
  wifi: mt76: mt7921: drop TXRX_NOTIFY on non-mmio buses
  wifi: mt76: mt7925: drop TXRX_NOTIFY on non-mmio buses
  wifi: mt76: mt7615: drop TXRX_NOTIFY on non-mmio buses

 drivers/net/wireless/mediatek/mt76/mt7615/mac.c |  6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 10 +++++++---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 10 +++++++---
 3 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.54.0


