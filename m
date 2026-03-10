Return-Path: <linux-wireless+bounces-32861-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODvaJWwMsGl4ewIAu9opvQ
	(envelope-from <linux-wireless+bounces-32861-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 13:19:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EFA24D3E3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 13:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6B4632E2672
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8784DBD97;
	Tue, 10 Mar 2026 11:56:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C1A421A10;
	Tue, 10 Mar 2026 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143748; cv=none; b=dEwLFqfFbbBX9dAwLCgrp7KsXdT4gwigdzJOm7fJSprvVJq6nUSh5WwDc7mtZqBKr1ILe/TyWq7g8TlJlaUiHhkF4LQGll8SKyeiwQgrCiXGygyG5jFWOHpBJiqwgR+Aqufd8MTmHiqqbisKSyVEoqKGmnQNltpHpMDrTbc0gLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143748; c=relaxed/simple;
	bh=iG/6Gbypjz2OmWQb0dXEIiFm2wHO3xZ/QJrRffJjoq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cmgf3xCjE9OQ9ysq1bE0CKZKwTugGis6AO0J25HvL1wxufWK3hWeiqL1V/MzS0DUG6G8VF48KkpaLZX4vaWKqrB0G19GDMwxk2eJ7/YfNo85ZtRQ3nti9fcFrTxLT/CkiRU8zkfCIngShGmYewTJwnCusowbr/9hgGEShpvZIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ad-e21d-7f0000032729-7f000001d9fc-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:25 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:25 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:53 +0100
Subject: [PATCH 27/61] net/netlink: Prefer IS_ERR_OR_NULL over manual NULL
 check
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-27-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=iG/6Gbypjz2OmWQb0dXEIiFm2wHO3xZ/QJrRffJjoq0=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYxKX27oPhhgjZ9L2aN+uf2Pkd/lJuV0FZGx
 7sT5NeXxfGJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGMQAKCRA0LQZT0ays
 2910CACA5AX3Aqq6mMRjUqWLJkwISGQ/SClIom7gyl5y4YdXmFh365btAW6CDMrujm4g2yYHKMn
 icMIaMalhr2gJPGai/SU/Cr5CZi3ZY+4gua5T+uq+HkP8vLsixdy6MzBKvC4YJ7SQ9u1y3suTJ2
 dXw3LfFbSDyXJK4eAmt3Q9xLN+IDoqMq7+VyONJtkwZmjMDy5iHAJpd4FamMBrqSwy4GaDMKKm7
 glgw85FRb142AMKifN1ghWcWZj4AIrKdQR8M3/bZ64Q5ElxSWaeaZ0coUuPBsdwn1welLaCtuOr
 MNnjMGoWnx945CHnVYBBpgGh+sR8NWsokX9o62B2ZLaEYpxG
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143725-9D646F2F-B8244D33/0/0
X-purgate-type: clean
X-purgate-size: 1047
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 36EFA24D3E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[avm.de : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32861-lists,linux-wireless=lfdr.de];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:mid,avm.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,davemloft.net:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4d609d5cf40653e04de60f2d28ee26b8bdcdc2ed..58707b9da84adf1002ab9eff9401fa2083374189 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2667,7 +2667,7 @@ static void *netlink_seq_start(struct seq_file *seq, loff_t *posp)
 
 	netlink_walk_start(iter);
 
-	for (pos = *posp; pos && obj && !IS_ERR(obj); pos--)
+	for (pos = *posp; pos && !IS_ERR_OR_NULL(obj); pos--)
 		obj = __netlink_seq_next(seq);
 
 	return obj;

-- 
2.43.0


