Return-Path: <linux-wireless+bounces-30613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE0D0C97E
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 00:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A70DE3026BE9
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5E33396F7;
	Fri,  9 Jan 2026 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="hbXNx1dp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF330DEAD;
	Fri,  9 Jan 2026 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768003106; cv=none; b=koHcxZobxUd3FDG2dHy7PWdwXlZpsXkTsI7cdDAaZnFC3Rr2QFBnh26MRmb5CGX8U0MrPULUFdQkqbYTQ1tRrr7Mh0YbjIB5RBO2L3oadc0cFXdtXTvBRBCEcerOPuLcRgCJWinv6A42aMdHTV6TJo3zNFSkY38e1uH65cmgyrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768003106; c=relaxed/simple;
	bh=qhH99tXGViJsXtnjgqGko5PECpUJrIUS2vFygTi7ucU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ontD6aNh9joCwHVwZtGBhrQ2V2dFHVEzaYmn6AASw8TEy+CCJoUaLhlPO7Mch6inzlGuhxlmADuHhcZE+wn85JRdp8DrfiZk9vUY2lXrONakA8rDxx5o0KtjoW6Br3PItXZvK7E/YRKKR9R6xQrwyL6B+fJCuxNR9NFceL8ES1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=hbXNx1dp; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 596CE10D511;
	Sat, 10 Jan 2026 00:58:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768003101; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=npFTekgQMtFTQzfDNZyH73VMWtv9loyh6/Rcmwz3rWE=;
	b=hbXNx1dpozaEe3RIUOaTK6VHBGU4+7jq6dNIVtcggp7DXvCommE4vNIs06zAi4mX3l8jbt
	j9SPsYNO33iG/aukl+z6HCui0xawEODgj+fU5aDgZjDhYLfahzYndAxbl82+p3iDKnXg9h
	0eFXS8MYGmJOWMjKxPLMe0aKw/TOkd7iRYKjb23FPgkwtdS4nASHpie/s2Fy3i3vHlnCu4
	nQZW9lqZf69F1I2DJcyRLI9SsrYT1pCt0WCUO+WjE928NfQMopBEHs+e0RYMpodVsklKFB
	Lv5zU9OzsGxOPB8Z+17d2/V5qAOHc9Eup7AmA4jEJuaOTgRjNvjwyLXQsRkGsg==
From: Marek Vasut <marex@nabladev.com>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Radenovic Goran <gradenovic@ultratronik.de>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rsi: Fix memory corruption due to not set vif driver data size
Date: Sat, 10 Jan 2026 00:56:29 +0100
Message-ID: <20260109235817.150330-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The struct ieee80211_vif contains trailing space for vif driver data,
when struct ieee80211_vif is allocated, the total memory size that is
allocated is sizeof(struct ieee80211_vif) + size of vif driver data.
The size of vif driver data is set by each WiFi driver as needed.

The RSI911x driver does not set vif driver data size, no trailing space
for vif driver data is therefore allocated past struct ieee80211_vif .
The RSI911x driver does however use the vif driver data to store its
vif driver data structure "struct vif_priv". An access to vif->drv_priv
leads to access out of struct ieee80211_vif bounds and corruption of
some memory.

In case of the failure observed locally, rsi_mac80211_add_interface()
would write struct vif_priv *vif_info = (struct vif_priv *)vif->drv_priv;
vif_info->vap_id = vap_idx. This write corrupts struct fq_tin member
struct list_head new_flows . The flow = list_first_entry(head, struct
fq_flow, flowchain); in fq_tin_reset() then reports non-NULL bogus
address, which when accessed causes a crash.

The trigger is very simple, boot the machine with init=/bin/sh , mount
devtmpfs, sysfs, procfs, and then do "ip link set wlan0 up", "sleep 1",
"ip link set wlan0 down" and the crash occurs.

Fix this by setting the correct size of vif driver data, which is the
size of "struct vif_priv", so that memory is allocated and the driver
can store its driver data in it, instead of corrupting memory around
it.

Cc: stable@vger.kernel.org
Fixes: dad0d04fa7ba ("rsi: Add RS9113 wireless driver")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Marek Vasut <marex@nabladev.com>
Cc: Radenovic Goran <gradenovic@ultratronik.de>
Cc: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
---
Splat reported by UT https://lkml.org/lkml/2025/10/22/1167
Splat as seen on DH STM32MP15xx DHCOR DRC Compact with current 6.18.y LTS:
8<--- cut here ---
Unable to handle kernel paging request at virtual address fffffffc when read
[fffffffc] *pgd=dbfde861, *pte=00000000, *ppte=00000000
Internal error: Oops: 37 [#1] SMP ARM
Modules linked in:
CPU: 0 UID: 0 PID: 106 Comm: ifconfig Tainted: G        W           6.18.4-00006-gbeb1780fe470-dirty #67
 PREEMPT
Tainted: [W]=WARN
Hardware name: Generic DT based system
PC is at fq_flow_reset.constprop.0+0x84/0x22c
LR is at fq_flow_reset.constprop.0+0x84/0x22c
pc : [<c0110934>]    lr : [<c0110934>]    psr: 600a0013
sp : e0c45ca0  ip : 00000000  fp : c2c11600
r10: 00000624  r9 : 00000000  r8 : e0c45cf4
r7 : 00000000  r6 : c197e668  r5 : c197e5c0  r4 : fffffffc
r3 : c4281b00  r2 : 00000000  r1 : 00000000  r0 : 00000012
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: c429c06a  DAC: 00000051
Register r0 information: non-paged memory
Register r1 information: NULL pointer
Register r2 information: NULL pointer
Register r3 information: slab task_struct start c4281b00 pointer offset 0 size 2304
Register r4 information: non-paged memory
Register r5 information: slab kmalloc-8k start c197e000 pointer offset 1472 size 8192
Register r6 information: slab kmalloc-8k start c197e000 pointer offset 1640 size 8192
Register r7 information: NULL pointer
Register r8 information: 2-page vmalloc region starting at 0xe0c44000 allocated at kernel_clone+0xb4/0x288
Register r9 information: NULL pointer
Register r10 information: non-paged memory
Register r11 information: slab kmalloc-8k start c2c10000 pointer offset 5632 size 8192
Register r12 information: NULL pointer
Process ifconfig (pid: 106, stack limit = 0x3fd08b1b)
Stack: (0xe0c45ca0 to 0xe0c46000)
5ca0: c197e668 fffffffc 00000000 c2c11890 c197e5c0 00000000 00000000 c0110d18
5cc0: c2c10600 c197e5c0 e0c45cf4 00000000 e0c45cf4 c0b65f68 00008914 c0183e44
5ce0: 00000001 00000000 600a0013 c0187684 00000010 e0c45cf4 e0c45cf4 00000000
5d00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5d20: 00000000 115bbe91 c4281b00 c2c10600 c197e240 c0db94cc 00001003 00000001
5d40: c2d68a0c e0c45e50 00008914 c0b66338 c197e240 115bbe91 00000000 c2c10000
5d60: e0c45d94 c0db94cc 00001003 c0953c00 e0c45d94 e0c45d94 c2c10000 00001002
5d80: e0c45d94 c095830c ffffffff c2d03ed8 c2205660 c2c10104 c2c10104 115bbe91
5da0: c2c10000 c2c10000 00000000 00001003 c2c10130 c0958404 c2c10000 00001002
5dc0: c2c10000 00001002 00000000 c2d68a00 00000000 c095b72c 00000000 e0c45e40
5de0: c2c10000 c0a07254 c3212a48 00000000 00000020 00000014 e0c45e60 c4281b00
5e00: e0c45e40 00001002 0044032c 0043fe6c 0042a1f0 115bbe91 00000000 00008914
5e20: beb49abc c13f6e40 c42ac000 e0c45e60 c4281b00 c29e1e40 00000004 c0a09b94
5e40: 6e616c77 00000030 00000000 00000000 00001002 0044032c 0043fe6c 0042a1f0
5e60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5e80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5ea0: 00000000 00000000 00000000 00000000 00000000 115bbe91 00000000 c2511200
5ec0: 00008914 beb49abc c13f6e40 c0da8868 c4281b00 c092f358 e0c45ee7 c2b9d490
5ee0: c2204f68 00339798 00000000 00000000 00000000 00000000 00000000 00000000
5f00: 00000000 00000000 00000000 115bbe91 beb49b44 c29e1e40 beb49abc 00008914
5f20: c2511280 c02de8b4 fffffffe ffffff9c e0c45f74 c01002c4 0042bb7c 00000000
5f40: 00000000 c02da9e8 00000000 0042bb7c 00000001 004406c8 00000001 c4281b00
5f60: 00000004 c02c6f84 00000000 ffffff9c c29e1e40 00000000 00000000 115bbe91
5f80: 00000004 beb49b44 beb49abc 00000004 00000036 c01002c4 c4281b00 00000036
5fa0: beb49f86 c0100060 beb49b44 beb49abc 00000004 00008914 beb49abc beb49aa8
5fc0: beb49b44 beb49abc 00000004 00000036 00440000 0042a350 00000000 beb49f86
5fe0: 00000036 beb49a90 b6ea1891 b6e0f736 800a0030 00000004 00000000 00000000
Call trace:
 fq_flow_reset.constprop.0 from ieee80211_txq_purge+0xd8/0x1fc
 ieee80211_txq_purge from ieee80211_do_stop+0x52c/0x848
 ieee80211_do_stop from ieee80211_stop+0xb4/0x138
 ieee80211_stop from __dev_close_many+0xc8/0xe8
 __dev_close_many from __dev_change_flags+0xe0/0x1b8
 __dev_change_flags from netif_change_flags+0x20/0x5c
 netif_change_flags from dev_change_flags+0x2c/0x40
 dev_change_flags from devinet_ioctl+0x304/0x59c
 devinet_ioctl from inet_ioctl+0x204/0x228
 inet_ioctl from sock_ioctl+0x160/0x410
 sock_ioctl from sys_ioctl+0x65c/0x8b8
 sys_ioctl from ret_fast_syscall+0x0/0x54
Exception stack(0xe0c45fa8 to 0xe0c45ff0)
5fa0:                   beb49b44 beb49abc 00000004 00008914 beb49abc beb49aa8
5fc0: beb49b44 beb49abc 00000004 00000036 00440000 0042a350 00000000 beb49f86
5fe0: 00000036 beb49a90 b6ea1891 b6e0f736
Code: e59f1194 e59f018c e300213d ebffc819 (e5943000)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Fatal exception in interrupt
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index f3a853edfc11d..8c8e074a3a705 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -2035,6 +2035,7 @@ int rsi_mac80211_attach(struct rsi_common *common)
 
 	hw->queues = MAX_HW_QUEUES;
 	hw->extra_tx_headroom = RSI_NEEDED_HEADROOM;
+	hw->vif_data_size = sizeof(struct vif_priv);
 
 	hw->max_rates = 1;
 	hw->max_rate_tries = MAX_RETRIES;
-- 
2.51.0


