Return-Path: <linux-wireless+bounces-37675-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cv1GIS3SKmohxgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37675-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 17:20:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B267303F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 17:20:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=c4DBG+YC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37675-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37675-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D25030A29FE
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398583E7164;
	Thu, 11 Jun 2026 15:19:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m2441.xmail.ntesmail.com (mail-m2441.xmail.ntesmail.com [45.195.24.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A43FCB1F;
	Thu, 11 Jun 2026 15:19:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191149; cv=none; b=QD4hHq84yMRF193JUOaZNt23W66DRapQomrA8snXN/Y+BL20nYwZOpGH61PzERwPlVhToCoCCBbjUhXMFeMPBiEmaBoVzC/zC3s4nEfAZPVjCcwIbd1Mw3vmTilrTkm5QstwyrE705wVjZNqefpaxE5NrvLXrdrp6jxMaDQqljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191149; c=relaxed/simple;
	bh=b5Yaa5D9Q9tacvKyv70XltCPg/lllDC98RpZ+toEmtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kVBFqsY9E6icAR4RL4eonbdLyHuZdb1xcQWRbnonfKQ3Dl22EbFsCCSOI/qnKyq0BR1WP4NW6pr9FP02+15Qv1LJONqlOI0RjPeIippk0aB0ZuaCIDqw8pPYd3BTYcfUp6ZoKf618iPdIjk+RQYXuEXEPca7UIQ14MtnxCAwBdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=c4DBG+YC; arc=none smtp.client-ip=45.195.24.41
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42068ba35;
	Thu, 11 Jun 2026 23:18:57 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: linux-wireless@vger.kernel.org
Cc: libertas-dev@lists.infradead.org,
	linville@tuxdriver.com,
	luisca@cozybit.com,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] wifi: libertas_tf: kill shared URB before resubmitting it
Date: Thu, 11 Jun 2026 23:18:48 +0800
Message-Id: <20260611151848.2573316-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb743d90803a1kunm78d9ab71169c51
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHh8eVkgaSU8aQ0NCShodTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=c4DBG+YC26VyKqRdOEIWQXAFyicGtWJ2umJ2JVbcdIGrwLf+rqi65w8HFgHKRNKX7ihqPj7SVB6UZY5vWmwKbqTlmS9cgClFzMD/WHHAan58Gyddawo+HweDuzPC8NjF2GDNuMtdzzv2j17vNZ/DzQ8WOZnmuNsUEsstKdOnd+I=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=rpUA/+FiAP1Fr1OdfUX65iVV1Nwx0bLdkSoyPLe/t0Y=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37675-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:libertas-dev@lists.infradead.org,m:linville@tuxdriver.com,m:luisca@cozybit.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B56B267303F

libertas_tf's usb_tx_block() reuses a shared send URB and immediately
does usb_fill_bulk_urb() plus usb_submit_urb() on it. Depending on the
caller, that shared carrier is either cardp->tx_urb or cardp->cmd_urb.
There is no patch-local usb_kill_urb() before reuse, and the file-local
completion path provides no busy flag, completion, or other ownership
handoff that would make active reuse safe.

A running system can reach this through if_usb_host_to_card() for normal
data or command traffic, if_usb_issue_boot_command() for firmware boot
commands, and if_usb_send_fw_pkt() for firmware download packets. Those
paths all feed back into the same helper, so a second submission can
refill and resubmit an URB while the previous transfer is still active.

The issue was found by our static analysis tool and manually audited on
Linux v6.18.21. It was further validated with a focused QEMU no-device KCSAN
harness, which reproduced active reuse of both shared carriers:
cardp->tx_urb through if_usb_host_to_card(), and cardp->cmd_urb through
if_usb_issue_boot_command() and if_usb_send_fw_pkt().

Call usb_kill_urb(urb) after selecting the shared target URB and before
refilling it, so both tx_urb and cmd_urb are quiesced before reuse.

Fixes: c305a19a0d0a ("libertas_tf: usb specific functions")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/wireless/marvell/libertas_tf/if_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas_tf/if_usb.c b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
index 5662a244f82a..7542956d3c47 100644
--- a/drivers/net/wireless/marvell/libertas_tf/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
@@ -387,6 +387,8 @@ static int usb_tx_block(struct if_usb_card *cardp, uint8_t *payload,
 	else
 		urb = cardp->cmd_urb;
 
+	usb_kill_urb(urb);
+
 	usb_fill_bulk_urb(urb, cardp->udev,
 			  usb_sndbulkpipe(cardp->udev,
 					  cardp->ep_out),
-- 
2.34.1

