Return-Path: <linux-wireless+bounces-31628-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJNjCvJGhmkhLgQAu9opvQ
	(envelope-from <linux-wireless+bounces-31628-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 20:54:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEFC102EB7
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 20:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B610F300A637
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 19:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C4A32B9BC;
	Fri,  6 Feb 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="BBWTQ8Ek";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="RLlJy1Hn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617326ED59;
	Fri,  6 Feb 2026 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407660; cv=none; b=DKd4VtgPVwTGoPKDPZtbDMQgsfDuFCmOztsQcZApXrLZURkrultQ5CCDK+5So0ZJuecj8+suZwNFdp2ZdgVhGYB/CaO7nx6Z80bBOtkoBf7MXVH8g5CaCSB0TDSQgBg4DsHmQ/z1mXy52KZkM2yExk3MEdTq3on77Q3qEWHhYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407660; c=relaxed/simple;
	bh=PRr7Hpe7c4EDtdbIbjvob9tWf81iUT4gU6SBmjVnN80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktxonJ9nZF/KMwujlFweXcSDrB4iPCfNq5v9xOjPMMvYwiSuifX4QjXY7ZXXROZf41p5ywzNfK7T+t5KsMyfOVIBAjPCLeBE4MtwI8Rkm7h0sHTR1xuyd/VHxjdy2WIeEHJUqpSY1HiRzwJh2YMekkW5om6QlprCytHUuw9LRHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=BBWTQ8Ek; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=RLlJy1Hn; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770407636; bh=R2zmt2rU1GHwt3meo6uTtvY
	arMax11ycYnpUX5GS8VU=; b=BBWTQ8EkYClsNFkzh2z4h1Mj4HhZWxUEXtkpoLH/qdlcF+/ND5
	id3ZFTNRsmAP1w+Pt0QLDuJaF6t5b8F96457EnB8IJtIF5n3PfZ6us1xg/x0LFMhzKEDWfEdJgE
	fsjwqolZjZyFElJNK8G/FPxhuxPrWwdnICdXife4odg3F4AZTENZ1d9ElJMZ+30e1Cs55u1s4cH
	KXOmk8du9tLLBc2O9G6sQ/Kbp98mUSu/CsNs890/1gJftSoHnpRO+5QExn3anMtEX+UP4gkNA+B
	d70aOS8KQC36HcCDYOYQ9WtWY4QYjaQsbNkLc8/arDUDq1yDP8+ZPe7rwJXez4gM5fw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770407636; bh=R2zmt2rU1GHwt3meo6uTtvY
	arMax11ycYnpUX5GS8VU=; b=RLlJy1HnmnEXN63jU5pwEaKa6xUHEW33O/i4yACgDuiAtrzY5e
	9KDq8Sc0JZqy4NpgJFrlUriCGXFpv0PuOCDg==;
From: Daniel Hodges <git@danielhodges.dev>
To: linux-wireless@vger.kernel.org
Cc: libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Daniel Drake <dsd@laptop.org>,
	Dan Williams <dcbw@redhat.com>,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH] wifi: libertas: fix use-after-free in lbs_free_adapter()
Date: Fri,  6 Feb 2026 14:53:56 -0500
Message-ID: <20260206195356.15647-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[danielhodges.dev,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31628-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@danielhodges.dev,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,danielhodges.dev:email,danielhodges.dev:dkim,danielhodges.dev:mid]
X-Rspamd-Queue-Id: 7BEFC102EB7
X-Rspamd-Action: no action

The lbs_free_adapter() function uses timer_delete() (non-synchronous)
for both command_timer and tx_lockup_timer before the structure is
freed. This is incorrect because timer_delete() does not wait for
any running timer callback to complete.

If a timer callback is executing when lbs_free_adapter() is called,
the callback will access freed memory since lbs_cfg_free() frees the
containing structure immediately after lbs_free_adapter() returns.

Both timer callbacks (lbs_cmd_timeout_handler and lbs_tx_lockup_handler)
access priv->driver_lock, priv->cur_cmd, priv->dev, and other fields,
which would all be use-after-free violations.

Use timer_delete_sync() instead to ensure any running timer callback
has completed before returning.

This bug was introduced in commit 8f641d93c38a ("libertas: detect TX
lockups and reset hardware") where del_timer() was used instead of
del_timer_sync() in the cleanup path. The command_timer has had the
same issue since the driver was first written.

Fixes: 8f641d93c38a ("libertas: detect TX lockups and reset hardware")
Fixes: 954ee164f4f4 ("[PATCH] libertas: reorganize and simplify init sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 drivers/net/wireless/marvell/libertas/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/main.c b/drivers/net/wireless/marvell/libertas/main.c
index d44e02c6fe38..dd97f1b61f4d 100644
--- a/drivers/net/wireless/marvell/libertas/main.c
+++ b/drivers/net/wireless/marvell/libertas/main.c
@@ -799,8 +799,8 @@ static void lbs_free_adapter(struct lbs_private *priv)
 {
 	lbs_free_cmd_buffer(priv);
 	kfifo_free(&priv->event_fifo);
-	timer_delete(&priv->command_timer);
-	timer_delete(&priv->tx_lockup_timer);
+	timer_delete_sync(&priv->command_timer);
+	timer_delete_sync(&priv->tx_lockup_timer);
 }
 
 static const struct net_device_ops lbs_netdev_ops = {
-- 
2.52.0


