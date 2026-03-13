Return-Path: <linux-wireless+bounces-33224-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBxPNc2BtGlTpAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33224-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 22:29:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A828A25E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 22:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B939330BF28F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5713845BC;
	Fri, 13 Mar 2026 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kS1vKUBO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB691383C6F;
	Fri, 13 Mar 2026 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773437317; cv=none; b=ou4RCSPQrQbadoG87+UrrDEPWXoeDI0+8WLNf31aRNpM7jPbZGSaxIr5QmJXHy1cAmLOWmBsakcUx0cC+iHHagUihGfTIgU3bxWs+AKlmJoZ2PbeG52QTm0khh/6e97RVCjSuOGD3ev8Wb9F4wDF9fMIHWnx6RH1IyzRblNhdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773437317; c=relaxed/simple;
	bh=zExRomcPKnjAtinRkt6KMsB26g2jkpv2YzaeFON3qEM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HxbMgrFyqx8XzdAxmFe96a3dKb5QritjS/lTsG7vWiASVXxdWn1IHLp/iW2Is1Dvod2viEOxRccvH9YqQDjOgTJVZ50FNoau1AGiYnwAhdRigrgk8xWrhoyHzYsIpz7k+XzCxvkoTSDUdX5sS5vAju+aDryxsYbDAknk2hbOIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kS1vKUBO; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+nNz6YA7+pDqY0dz/bzIhLRvah3GG0oYcR+y3o/Wm/Q=; b=kS1vKUBO9z0Jq2qdYjMxnnl/38
	FgSS8BhjceQaZmgT9f/8W5K6kYJPmYqdpA8M8xUKOjNyoZF2aVMlqz0DS5Az9NhObGrOPJNWr/DWs
	1JL5TZyWODmG98QMUPkclBzqLPSOX/1hAdsMtwbyRgy2mU5lzEW/P6gwGQaou41RS6VBFY+ISSX7B
	w7BqqTXMUaDF6iYUAsaireL7N90Bb9wyLhTiJ9oNPdkRNLqjKWyTFj5Rm2Qr4Z96hZjYT3PV6cDKS
	JFWCesWBzJtcQ7VhVZydnSX9bA+DFpQdQUoAjKVFT5L147Z7vR58OU/t/VJBVEQ5xePkt5+m+513z
	FgIk4MHA==;
Received: from 189-14-81-93.vmaxnet.com.br ([189.14.81.93] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w1A3b-00FRhq-HN; Fri, 13 Mar 2026 22:28:31 +0100
From: Heitor Alves de Siqueira <halves@igalia.com>
Subject: [PATCH 0/2] wifi: libertas: add USB anchors for TX/RX paths
Date: Fri, 13 Mar 2026 18:27:56 -0300
Message-Id: <20260313-libertas-usb-anchors-v1-0-915afbe988d7@igalia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAxA0atI1hOwtajMVWQW1UQNSB0SFUG8u
 8XlW/x/gbEKG3yLC5QPMVlThvsUMMwxTYxC2eBLX5eVq3CRnnWLhrv1GNMwr2rYOKI2BE8UPOT
 0rzzK+W67330/nn3tM2YAAAA=
X-Change-ID: 20260313-libertas-usb-anchors-71dd8442dd42
To: Johannes Berg <johannes.berg@intel.com>, 
 Szymon Wilczek <swilczek.lx@gmail.com>
Cc: linux-wireless@vger.kernel.org, libertas-dev@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 syzbot+74afbb6355826ffc2239@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33224-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.641];
	FROM_NEQ_ENVFROM(0.00)[halves@igalia.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,74afbb6355826ffc2239];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email,igalia.com:mid]
X-Rspamd-Queue-Id: 847A828A25E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes a sleep-in-interrupt-context bug reported by Syzbot in
the Marvell libertas driver. Previous in-flight URBs were killed with
usb_kill_urb(), which shouldn't be called from interrupt context as it
might sleep.

The first patch adds USB anchors for the TX and RX paths, so we have a
way to track any in-flight URBs. Existing functions now use the anchors
instead of handling URBs directly.

The second patch fixes the reported bug by checking the TX anchor for
any in-flight URBs before sending out new ones. We now return -EBUSY
instead of killing the pending URB.

Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
Heitor Alves de Siqueira (2):
      wifi: libertas: use USB anchors for tracking in-flight URBs
      wifi: libertas: don't kill URBs in interrupt context

 drivers/net/wireless/marvell/libertas/if_usb.c | 32 ++++++++++++++++++--------
 drivers/net/wireless/marvell/libertas/if_usb.h |  3 +++
 2 files changed, 25 insertions(+), 10 deletions(-)
---
base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
change-id: 20260313-libertas-usb-anchors-71dd8442dd42

Best regards,
-- 
Heitor Alves de Siqueira <halves@igalia.com>


