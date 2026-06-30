Return-Path: <linux-wireless+bounces-38355-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id syvcAgqlQ2rGeAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38355-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:14:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F2E6E36F0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:14:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DgtHvom+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38355-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38355-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CFAC3046CF5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022F7411661;
	Tue, 30 Jun 2026 10:59:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A740E8D8;
	Tue, 30 Jun 2026 10:59:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817184; cv=none; b=AU1KAMmvT3G+7gETYpxp3MFE+kYIZa7gh0tJh61+oX4IEhWTk/aCQUJG0UBZOI5wv+s5SrNw9qPXA0utu3WQaKbz/0NQ2j2SGd5/vSaAe7vg/HSWJWAJzNLGgCFlXlOMHR1/AaKV4vYatYDVnen+JwmOKwyJWTg91nuNjHRBrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817184; c=relaxed/simple;
	bh=AyB/L2uCs+AZEaaOd3L9Nr1/Nuxd6Za0GDoPK4n0OO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFEjamgK5GCfOUFaENBCA9RSCFuoEVzSWMY51wh2+YOHoClj3x05mvCgEYMbyv8hDIQEiBJ4pfCUE0JU0y9hsNhqzH74beNJ4UqwZD9y0eZ2oiO3p7o9WcsZBQXuPu5CX8rB4a0p5/GAWA3zhl/O3UdsgyC/bbtXetjnZzVCjQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgtHvom+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483751F000E9;
	Tue, 30 Jun 2026 10:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817182;
	bh=Iyk9farFukAIvKGcWCVjubpPNe4OtJIT0B3fPfHAcek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DgtHvom+XpxZXXgnBz9yJtGhfbx53DMTm3ffkikikYQtwt3tKs2l3gb0W9BGYsxFr
	 HBMmkEkqHjLTrCQSdfgOPCoqG8pLs59vVpY0RhShTSDjPiccqeO5eLAh2KzloZldjB
	 9aQB/cqqC5E01rOsg5+4e1GjyJr/Mqxg3CsHsbce9L7s1baDkgwVpzWQjdt8McI+gi
	 tIoYZb5Gxfgsm1yHnCPN1NEXfJ+zehRfkmNSrkeBDoxPX/B2fvjXhFo93wYmNxhjYM
	 HB5IPDc4Vq1cQdfMn2rOXAQ8BWdAmEUSqtfEwRWxSf5CT9AAGH1bqQISufWjD7MsMw
	 Z5dTleKHYc+8A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 13:59:22 +0300
Subject: [PATCH net-next 3/8] ice: use kzalloc() to allocate staging buffer
 for reading from GNSS
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-b4-drivers-net-v1-3-672162a91f37@kernel.org>
References: <20260630-b4-drivers-net-v1-0-672162a91f37@kernel.org>
In-Reply-To: <20260630-b4-drivers-net-v1-0-672162a91f37@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Brian Norris <briannorris@chromium.org>, 
 Edward Cree <ecree.xilinx@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Manish Chopra <manishc@marvell.com>, Mike Rapoport <rppt@kernel.org>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Sudarsana Kalluru <skalluru@marvell.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, b43-dev@lists.infradead.org, 
 intel-wired-lan@lists.osuosl.org, libertas-dev@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-net-drivers@amd.com, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38355-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:briannorris@chromium.org,m:ecree.xilinx@gmail.com,m:francesco@dolcini.it,m:manishc@marvell.com,m:rppt@kernel.org,m:przemyslaw.kitszel@intel.com,m:skalluru@marvell.com,m:anthony.l.nguyen@intel.com,m:b43-dev@lists.infradead.org,m:intel-wired-lan@lists.osuosl.org,m:libertas-dev@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-net-drivers@amd.com,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[rppt@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,dolcini.it,marvell.com,kernel.org,intel.com,lists.infradead.org,lists.osuosl.org,vger.kernel.org,kvack.org,amd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81F2E6E36F0

ice_gnss_read() uses get_zeroed_page() to  allocate a staging buffer for
reading GNSS module data via I2C bus.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 8fd954f1ebd6..7d21c3417b0b 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2021-2022, Intel Corporation. */
 
 #include "ice.h"
+#include <linux/slab.h>
 #include "ice_lib.h"
 
 /**
@@ -124,7 +125,7 @@ static void ice_gnss_read(struct kthread_work *work)
 
 	data_len = min_t(typeof(data_len), data_len, PAGE_SIZE);
 
-	buf = (char *)get_zeroed_page(GFP_KERNEL);
+	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf) {
 		err = -ENOMEM;
 		goto requeue;
@@ -151,7 +152,7 @@ static void ice_gnss_read(struct kthread_work *work)
 			 count, i);
 	delay = ICE_GNSS_TIMER_DELAY_TIME;
 free_buf:
-	free_page((unsigned long)buf);
+	kfree(buf);
 requeue:
 	kthread_queue_delayed_work(gnss->kworker, &gnss->read_work, delay);
 	if (err)

-- 
2.53.0


