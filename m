Return-Path: <linux-wireless+bounces-38655-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bmv9J0FoS2qWQwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38655-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 10:33:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F1C70E224
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 10:33:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38655-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38655-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 569FC31A49FA
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D98392824;
	Mon,  6 Jul 2026 07:58:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692FE3AE6F4;
	Mon,  6 Jul 2026 07:58:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324694; cv=none; b=f+DNSUiOErkkloFjv8j4mYxn+z1wwjq57fAOL8d3h6GbzN81yh4+svX01Uf/Lthy4m5HlUa0sGUYy/WcOLBDXsl4XRgnQMNtQY3IunoVGM8lsWsl/QDYlEKM5XydBzOVGE8dblthq5SRA0WWvaWwJ61dF8KpZSTbbkqTOWKHWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324694; c=relaxed/simple;
	bh=n9dzOAGP4Bv6PvLUN6wPfgxiBIA9gxN9UGXPhoMd4ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B5NWS6y1twIBMuEmbYO0ND4/B+6gJxB5KXgV14zKAgWJNOvx0bl+MAjlgF7KX7dcCdTQlacTLEhEmgPSja4FudThAXQ81kg2OWJkS+cFJWD/ITmI5MQ+JH60b3NitzcZRGPmT5askTP4Wkd4uFqz5WH3ET/PeP6XCvsxPCpxzDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 61967750791011f1aa26b74ffac11d73-20260706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b30a95a6-5605-4de1-94f4-5eaa454a3205,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:3a95e9b818a18410cf3d7f02c8553566,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 61967750791011f1aa26b74ffac11d73-20260706
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1945132417; Mon, 06 Jul 2026 15:57:48 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Mark Greer <mgreer@animalcreek.com>,
	David Heidelberg <david@ixit.cz>
Cc: Linmao Li <lilinmao@kylinos.cn>,
	linux-wireless@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: trf7970a: Use NULL when no response is expected
Date: Mon,  6 Jul 2026 15:57:42 +0800
Message-Id: <20260706075743.564658-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS(0.00)[m:mgreer@animalcreek.com,m:david@ixit.cz,m:lilinmao@kylinos.cn,m:linux-wireless@vger.kernel.org,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38655-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lilinmao@kylinos.cn,linux-wireless@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lilinmao@kylinos.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:from_mime,kylinos.cn:email,kylinos.cn:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9F1C70E224

When a command's timeout is zero, no response is expected, and the TX
interrupt handler completes the command by passing ERR_PTR(0) to the
digital callback.

ERR_PTR(0) evaluates to NULL, so no errno is encoded here.  Use NULL
directly to avoid suggesting that this is an error-pointer path.

Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/nfc/trf7970a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 08c27bb438b5..7addf243c6f1 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -938,7 +938,7 @@ static irqreturn_t trf7970a_irq(int irq, void *dev_id)
 			if (!trf->timeout) {
 				trf->ignore_timeout =
 				    !cancel_delayed_work(&trf->timeout_work);
-				trf->rx_skb = ERR_PTR(0);
+				trf->rx_skb = NULL;
 				trf7970a_send_upstream(trf);
 				break;
 			}
-- 
2.25.1


