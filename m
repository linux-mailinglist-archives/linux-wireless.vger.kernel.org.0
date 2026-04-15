Return-Path: <linux-wireless+bounces-34813-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACDzI1XI32kmYwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34813-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 19:18:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F283D406B9D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 19:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64CDC301EC59
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8243E8C59;
	Wed, 15 Apr 2026 17:18:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from shell.v3.sk (mail.v3.sk [167.172.186.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324D373C04;
	Wed, 15 Apr 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.186.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273486; cv=none; b=a6wXYeLZyzTDs+5EMV46+zswdSjpiKSLrT6+AnOGRKJ+q46iBt+x9uW/lZUNOaCOxpr00PSvCZNRMzs2hJv9YQnjacWHoqB/ZQDmB6LPrGt8AcZT9wc2itN0VrytqCudYlEhBjtAV/iCx5D8h8YoVXRDQ7WPH08HNwK75JX58A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273486; c=relaxed/simple;
	bh=BXM+to8siLu81KiUOonJM1w02O5RIRoRGMXyVjaji/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBf9FjrusieI65aSr4lvhwZGIGA5DcvdOFjlPKfgit+UiwklWKSBzrp2iKuSDhzGHsirDgqtNqLTq6G2emKzgUYmuqLlMxg8b9bws3syiehuqk1JnnhJQOsBppkDkGgC2Uwl+GuE60Tx1qhhqIRkFy3s3Z4WX6dhO5nDCf3g3rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk; spf=pass smtp.mailfrom=v3.sk; arc=none smtp.client-ip=167.172.186.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v3.sk
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.v3.sk (Postfix) with ESMTP id DD4E1E2111;
	Wed, 15 Apr 2026 16:52:53 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
	by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id R4N2wv-dUtxI; Wed, 15 Apr 2026 16:52:53 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.v3.sk (Postfix) with ESMTP id 4E47AE210E;
	Wed, 15 Apr 2026 16:52:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
	by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MkbUL-gib38t; Wed, 15 Apr 2026 16:52:53 +0000 (UTC)
Received: from demiurge.local (unknown [109.183.109.54])
	by zimbra.v3.sk (Postfix) with ESMTPSA id 06174E210D;
	Wed, 15 Apr 2026 16:52:53 +0000 (UTC)
From: Lubomir Rintel <lkundrak@v3.sk>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] zd1211rw/mac: Fix out-of-bounds upon RX when unassociated
Date: Wed, 15 Apr 2026 19:08:10 +0200
Message-ID: <20260415170810.1809398-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34813-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[v3.sk];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkundrak@v3.sk,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F283D406B9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Upon plugging the adapter, UBSAN complains about an out of bounds read:

  zd1211rw 1-12:1.0: firmware version 4725
  zd1211rw 1-12:1.0: zd1211b chip 083a:4505 v4810 high 00-13-f7 AL2230_RF=
 pa0 g--NS
  ------------[ cut here ]------------
  UBSAN: array-index-out-of-bounds in drivers/net/wireless/zydas/zd1211rw=
/zd_mac.c:1059:26
  index -1 is out of range for type 'ieee80211_channel [14]'
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.12-300.fc43.x86_6=
4 #1 PREEMPT(lazy)
  Hardware name: MSI MS-7A68/B250 KRAIT GAMING (MS-7A68), BIOS H.00 12/15=
/2016
  Call Trace:
   <IRQ>
   dump_stack_lvl+0x5d/0x80
   ubsan_epilogue+0x5/0x2b
   __ubsan_handle_out_of_bounds.cold+0x54/0x59
   zd_mac_rx+0x453/0x470 [zd1211rw]
   ? raise_softirq_irqoff+0x9/0x30
   rx_urb_complete+0x178/0x260 [zd1211rw]
   ? queue_work_on+0x73/0x80
   ? led_trigger_blink_oneshot+0x78/0xa0
   __usb_hcd_giveback_urb+0x9d/0x120
   usb_giveback_urb_bh+0xb1/0x140
   process_one_work+0x18f/0x350
   bh_worker+0x1ac/0x210
   tasklet_action+0x10/0x30
   handle_softirqs+0xed/0x340
   __irq_exit_rcu+0xcb/0xf0
   common_interrupt+0x85/0xa0
   </IRQ>
   <TASK>
   asm_common_interrupt+0x26/0x40
  RIP: 0010:cpuidle_enter_state+0xcc/0x660

  Code: 00 00 e8 f7 36 ef fe e8 72 f0 ff ff 49 89 c4 0f
        1f 44 00 00 31 ff e8 23 55 ed fe 45 84 ff 0f 85
        02 02 00 00 fb 0f 1f 44 00 00 <85> ed 0f 88 d3 01
        00 00 4c 63 f5 49 83 fe 0a 0f 83 9f 04 00 00 49
  RSP: 0018:ffffffff9dc03df8 EFLAGS: 00000246
  RAX: ffff8a5440447000 RBX: ffff8a53df03ea40 RCX: 0000000000000000
  RDX: 001bd812ca957581 RSI: 00000000248799d1 RDI: 0000000000000000
  RBP: 0000000000000002 R08: fffffffc74360e92 R09: ffff8a53df02cbe0
  R10: 001bd81656731313 R11: 0000000000000000 R12: 001bd812ca957581
  R13: ffffffff9df0fa60 R14: 0000000000000002 R15: 0000000000000000
   ? cpuidle_enter_state+0xbd/0x660
   cpuidle_enter+0x31/0x50
   cpuidle_idle_call+0xf5/0x160
   ? ktime_get+0x3c/0xf0
   do_idle+0x78/0xd0
   cpu_startup_entry+0x29/0x30
   rest_init+0xe7/0xf0
   start_kernel+0x49d/0x4a0
   x86_64_start_reservations+0x24/0x30
   x86_64_start_kernel+0x126/0x130
   common_startup_64+0x13e/0x141
   </TASK>
  ---[ end trace ]---

It is correct: if zd_mac_rx() is called when unassociated, the channel
is 0, becomes -1 under assumption there's a proper channel number
starting from 1.

Add a missing bounds check.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c b/drivers/net/w=
ireless/zydas/zd1211rw/zd_mac.c
index 03948f0b4628..c59d1929a69c 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_mac.c
@@ -1022,6 +1022,7 @@ int zd_mac_rx(struct ieee80211_hw *hw, const u8 *bu=
ffer, unsigned int length)
 	const struct rx_status *status;
 	struct sk_buff *skb;
 	int bad_frame =3D 0;
+	u8 channel;
 	__le16 fc;
 	int need_padding;
 	int i;
@@ -1055,7 +1056,9 @@ int zd_mac_rx(struct ieee80211_hw *hw, const u8 *bu=
ffer, unsigned int length)
 		}
 	}
=20
-	stats.freq =3D zd_channels[_zd_chip_get_channel(&mac->chip) - 1].center=
_freq;
+	channel =3D _zd_chip_get_channel(&mac->chip);
+	if (channel > 0 && channel <=3D ARRAY_SIZE(zd_channels))
+		stats.freq =3D zd_channels[channel - 1].center_freq;
 	stats.band =3D NL80211_BAND_2GHZ;
 	stats.signal =3D zd_check_signal(hw, status->signal_strength);
=20
--=20
2.52.0


