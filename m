Return-Path: <linux-wireless+bounces-38796-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P2i4ON9mTmoNMAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38796-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 17:03:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC7C727BB8
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 17:03:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38796-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38796-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C03933100D42
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6344B3033DE;
	Wed,  8 Jul 2026 14:54:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965736A370
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 14:54:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522486; cv=none; b=XH67Bu6RKxQmGPgVGfgXjsSBZdopw5Dw8nmc5zHAngytDXslzPkSTJ7VANTTREo9XHdmyHOYNpEB6IMP+Bw40ZLS1jS/A1iEf+fg+C8NB1wEdUOZwSvhhQpqdG+J0IdosaBdoW54gepH1KSMHO9pyk/5izfKFUjvRD/T3zIRcCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522486; c=relaxed/simple;
	bh=n8a6IgAdvXQyqjnaQ9JkUOGf0ijz8TJilUs7FUksiM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxMu5v5Xh7ZgQIc1GOLYIsAO5TWE7SHuKxTYBzQSqpV02GUQSLb7rx3LxE4R3n3QcD1Mw7rUmIEA8lKBYBqqErEkrrUIsAbcLOLHtUd3ZyHZPKF3fqvv7zsgJFTnpwr4214kE6lzUzuHV2MUfAqpopQ5wziSgEpZCljgWdREIOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.24
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [212.227.17.181]) with ESMTPSA (Nemesis) id 1M9nAB-1wl4Tn0JeP-009EVu; Wed, 08
 Jul 2026 16:48:58 +0200
From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Ruslan Isaev <legale.legale@gmail.com>
Subject: [PATCH mt76] wifi: mt76: Disable napi when removing device
Date: Wed,  8 Jul 2026 16:43:47 +0200
Message-ID: <20260708144615.24092-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7MWKL+1X+JeZku4k0J1/JbP7QjnVsPblGgJo4RbwmlgsDYMwuqK
 ONNqt6qB+Im8MM+QAVw/eUjKMR/vDqygn2ZrYbtSpyPaOr/2JVbmfqazZprvIpNFsOFjhBg
 JMNGswyQTXI3AFqA6rgWiBqJXnovFAwvm4hXamx+87SQlcUswAbwdtgULrztYcLejyprDoS
 pPaZG3LJ6R8G6OkkqkmbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4by+nj9iuN8=;Wabs3Mp2/Sm6smjj0NIiBMqLXyK
 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
 =
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38796-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nicolas.cavallari@green-communications.fr,linux-wireless@vger.kernel.org];
	DMARC_NA(0.00)[green-communications.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:legale.legale@gmail.com,m:legalelegale@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.cavallari@green-communications.fr,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,green-communications.fr:from_mime,green-communications.fr:email,green-communications.fr:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BC7C727BB8

Unloading the mt7915e module with a MT7916 triggers multiples WARN in
__netif_napi_del_locked() and in page_pool_disable_direct_recycling()
because the driver does not disable the napi before destroying it.

This is troublesome since on MT7916 it is required to unload the module
and reinsert it with a different enable_6ghz parameter to change the
frequency.  The system generally becomes unstable after reinserting the
module.

Fix it by disabling napi before deleting it.  Also, do not delete napi
on WED queues since napi is neither used nor initialized on them.

Fixes: 17f1de56df05 ("mt76: add common code shared between multiple chipsets")
Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>

---
I'm aware of these previous attempts:
https://lore.kernel.org/linux-wireless/agEbiurBZzZv_Yt0@wico-dev.wnam.ru/T/#u
https://lore.kernel.org/linux-wireless/ahTdpNQp2va_xTVR@wico-dev.wnam.ru/T/#u

I can only test on a wed-less mt7916
---
 drivers/net/wireless/mediatek/mt76/dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f8c2fe5f2f58..322041859217 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -1189,7 +1189,10 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
 
-		netif_napi_del(&dev->napi[i]);
+		if (!mt76_queue_is_wed_rro(q)) {
+			napi_disable(&dev->napi[i]);
+			netif_napi_del(&dev->napi[i]);
+		}
 		mt76_dma_rx_cleanup(dev, q);
 
 		page_pool_destroy(q->page_pool);

base-commit: 50a7f9f9d48eb50c0e95bef53358acb5af5cb3c6
-- 
2.53.0


