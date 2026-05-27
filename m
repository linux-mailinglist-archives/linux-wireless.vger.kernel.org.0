Return-Path: <linux-wireless+bounces-37004-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APjaNgraFmpVtgcAu9opvQ
	(envelope-from <linux-wireless+bounces-37004-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 13:48:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5673B5E39E2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 13:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1E793021D24
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 11:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A25139B4B9;
	Wed, 27 May 2026 11:44:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E085391E7F;
	Wed, 27 May 2026 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882283; cv=none; b=PhIHnephlC+UavZ2WUvjy/48w9W8dnHbU+rJqcU2YVmPlJChuhIBKgmS18q4DUW63rx6RIKfSL/1s7EduHmuMLhI15GyOm3cTfQhuV1eZkqLCf+TZftUJRDMKG3qbTBWy38jeB4W/eNXiRLxWD38diJJhlOcz32F5AUIFlDwfXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882283; c=relaxed/simple;
	bh=De3gMUrcaiy7YuEmHqPOMMl+cLgPJPASHy/CpGHuxSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kzRbZ7lbdwgVcVb6pQY/c/PANTbO/LQ8ewaGduZW58qemDKyKaw6aKs0uJ3iIy1qvS+ZrK4YieK+kDtsvUaHT1EutXnJXJijml0ocSmkvqUghuUyyUTRLje/cP0RuIsB/O7KiqheIL/vv02LS8lIZzUQPqW7rPFdl3qGb1Nj8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.3])
	by APP-03 (Coremail) with SMTP id rQCowACXe+If2RZqs9eNEg--.14634S2;
	Wed, 27 May 2026 19:44:31 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Mathias Kretschmer <mathias.kretschmer@fokus.fraunhofer.de>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH] mac80211: suppress false WARNING when rate_mask is empty in __rate_control_send_low
Date: Wed, 27 May 2026 11:44:30 +0000
Message-Id: <20260527114430.3682878-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXe+If2RZqs9eNEg--.14634S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar43XF43Kr17ZFyUAr4rAFb_yoW3ur17pr
	y0grnrCF48Xan8AFW8Jw18JrW3XF47A3W3J397JryfJa43Cr1DXrnrKry8tr4UtrW7AF4x
	KF1qywsYyr9FyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjQeoUUUUUU==
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xujiakai24@mails.ucas.ac.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ucas.ac.cn];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37004-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 5673B5E39E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the beacon generation path calls __rate_control_send_low() with a
zero rate_mask (rc_rateidx_mask[band] == 0), the loop skips all rates
and triggers a WARN_ONCE even though there is no actual problem: the
rate index defaults to 0, and the caller (rate_control_send_low)
subsequently corrects it via rc_send_low_basicrate() using
basic_rates. This scenario occurs when a user sets a per-band bitrate
mask via NL80211_CMD_SET_TX_BITRATE_MASK on a band different from
the one where a beacon is later sent (e.g., after CSA).

Fix by wrapping the WARN_ONCE in a check for rate_mask != 0. When
rate_mask is 0, no rates were filtered out — just the max rate index
was reached because no specific mask was applied — so the warning is
a false positive.

Fixes: 2103dec14792 ("mac80211: select and adjust bitrates according to channel mode")
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
 net/mac80211/rate.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index ba1a3aa3f5d4..5cafc5043f19 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -396,12 +396,13 @@ static void __rate_control_send_low(struct ieee80211_hw *hw,
 		info->control.rates[0].idx = i;
 		break;
 	}
-	WARN_ONCE(i == sband->n_bitrates,
-		  "no supported rates for sta %pM (0x%x, band %d) in rate_mask 0x%x with flags 0x%x\n",
-		  sta ? sta->addr : NULL,
-		  sta ? sta->deflink.supp_rates[sband->band] : -1,
-		  sband->band,
-		  rate_mask, rate_flags);
+	if (rate_mask)
+		WARN_ONCE(i == sband->n_bitrates,
+			  "no supported rates for sta %pM (0x%x, band %d) in rate_mask 0x%x with flags 0x%x\n",
+			  sta ? sta->addr : NULL,
+			  sta ? sta->deflink.supp_rates[sband->band] : -1,
+			  sband->band,
+			  rate_mask, rate_flags);
 
 	info->control.rates[0].count =
 		(info->flags & IEEE80211_TX_CTL_NO_ACK) ?
-- 
2.34.1

Found by fuzzing. Here is the report:
------------[ cut here ]------------
no supported rates for sta (null) (0xffffffff, band 0) in rate_mask 0x0 with flags 0x0
WARNING: net/mac80211/rate.c:406 at __rate_control_send_low+0x20f/0x260 home/zzzrrll/tmp/linux-7.0.10/net/mac80211/rate.c:401, CPU#0: swapper/0/0
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G             L      7.0.10 #2 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__rate_control_send_low+0x249/0x260 home/zzzrrll/tmp/linux-7.0.10/net/mac80211/rate.c:401
Code: 10 41 8b 94 85 d4 00 00 00 eb 0e e8 e1 18 14 fc ba ff ff ff ff 48 8b 0c 24 8b 49 10 4c 89 f7 4c 89 ee 44 8b 44 24 0c 41 89 e9 <67> 48 0f b9 3a e9 40 ff ff ff 66 66 66 66 2e 0f 1f 84 00 00 00 00
RSP: 0018:ffa0000000003a78 EFLAGS: 00010246
RAX: ffffffff855306ef RBX: 000000000000000c RCX: 0000000000000000
RDX: 00000000ffffffff RSI: 0000000000000000 RDI: ffffffff877d9fa0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: ffffffff8702d780 R12: 0000000000000800
R13: 0000000000000000 R14: ffffffff877d9fa0 R15: ff11000018fba128
FS:  0000000000000000(0000) GS:ff110000f40c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32f23ffc CR3: 0000000023fe1000 CR4: 0000000000751ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 rate_control_send_low+0xae/0x240 home/zzzrrll/tmp/linux-7.0.10/net/mac80211/rate.c:429
 rate_control_get_rate+0x6f/0x1c0 home/zzzrrll/tmp/linux-7.0.10/net/mac80211/rate.c:943
 ieee80211_beacon_get_finish+0x1f2/0x230 home/zzzrrll/tmp/linux-7.0.10/net/mac80211/tx.c:5367
 __ieee80211_beacon_get_ap home/zzzrrll/tmp/linux-7.0.10/net/mac80211/tx.c:5470 [inline]
 ieee80211_beacon_get_ap+0xb94/0xc40 home/zzzrrll/tmp/linux-7.0.10/net/mac80211/tx.c:5532
 __ieee80211_beacon_get+0x938/0xa80 home/zzzrrll/tmp/linux-7.0.10/net/mac80211/tx.c:5638
 ieee80211_beacon_get_tim+0x60/0x150 home/zzzrrll/tmp/linux-7.0.10/net/mac80211/tx.c:5780
 ieee80211_beacon_get home/zzzrrll/tmp/linux-7.0.10/include/net/mac80211.h:5720 [inline]
 mac80211_hwsim_beacon_tx+0x1bc/0x350 home/zzzrrll/tmp/linux-7.0.10/drivers/net/wireless/virtual/mac80211_hwsim.c:2361
 __iterate_interfaces+0x1af/0x290 home/zzzrrll/tmp/linux-7.0.10/net/mac80211/util.c:760
 ieee80211_iterate_active_interfaces_atomic+0x32/0x40 home/zzzrrll/tmp/linux-7.0.10/net/mac80211/util.c:796
 mac80211_hwsim_beacon+0x63/0xd0 home/zzzrrll/tmp/linux-7.0.10/drivers/net/wireless/virtual/mac80211_hwsim.c:2395
 __run_hrtimer home/zzzrrll/tmp/linux-7.0.10/kernel/time/hrtimer.c:1790 [inline]
 __hrtimer_run_queues+0x168/0x3b0 home/zzzrrll/tmp/linux-7.0.10/kernel/time/hrtimer.c:1854
 hrtimer_run_softirq+0xa3/0x1f0 home/zzzrrll/tmp/linux-7.0.10/kernel/time/hrtimer.c:1871
 handle_softirqs+0xdc/0x2d0 home/zzzrrll/tmp/linux-7.0.10/kernel/softirq.c:622
 __do_softirq home/zzzrrll/tmp/linux-7.0.10/kernel/softirq.c:656 [inline]
 invoke_softirq home/zzzrrll/tmp/linux-7.0.10/kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x44/0xd0 home/zzzrrll/tmp/linux-7.0.10/kernel/softirq.c:723
 instr_sysvec_apic_timer_interrupt home/zzzrrll/tmp/linux-7.0.10/arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0x76/0x90 home/zzzrrll/tmp/linux-7.0.10/arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 home/zzzrrll/tmp/linux-7.0.10/arch/x86/include/asm/idtentry.h:697
RIP: 0010:pv_native_safe_halt+0x13/0x20 home/zzzrrll/tmp/linux-7.0.10/arch/x86/kernel/paravirt.c:63
Code: ee 27 83 fb cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d a3 1c 15 00 f3 0f 1e fa fb f4 <e9> c3 27 83 fb cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff87003e88 EFLAGS: 00000212
RAX: ff110000f40c5000 RBX: 0000000000000000 RCX: 4000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000002d5c79c
RBP: 0000000000000000 R08: ffffffff81606126 R09: 0000000000000012
R10: 000001f47d45d440 R11: ffffffff813a87f0 R12: 0000000000000000
R13: ffffffff8994f020 R14: ffffffff8702d780 R15: 0000000000000000
 arch_safe_halt home/zzzrrll/tmp/linux-7.0.10/arch/x86/kernel/process.c:766 [inline]
 default_idle+0x9/0x10 home/zzzrrll/tmp/linux-7.0.10/arch/x86/kernel/process.c:767
 default_idle_call+0x3c/0x60 home/zzzrrll/tmp/linux-7.0.10/kernel/sched/idle.c:122
 cpuidle_idle_call home/zzzrrll/tmp/linux-7.0.10/kernel/sched/idle.c:199 [inline]
 do_idle+0x18f/0x2c0 home/zzzrrll/tmp/linux-7.0.10/kernel/sched/idle.c:352
 cpu_startup_entry+0x25/0x30 home/zzzrrll/tmp/linux-7.0.10/kernel/sched/idle.c:451
 rest_init+0xc0/0xc0 home/zzzrrll/tmp/linux-7.0.10/init/main.c:760
 start_kernel+0x34f/0x380 home/zzzrrll/tmp/linux-7.0.10/init/main.c:1209
 x86_64_start_reservations+0x24/0x30 home/zzzrrll/tmp/linux-7.0.10/arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x109/0x110 home/zzzrrll/tmp/linux-7.0.10/arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x147
 </TASK>
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	41 8b 94 85 d4 00 00 	mov    0xd4(%r13,%rax,4),%edx
   7:	00
   8:	eb 0e                	jmp    0x18
   a:	e8 e1 18 14 fc       	call   0xfc1418f0
   f:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  14:	48 8b 0c 24          	mov    (%rsp),%rcx
  18:	8b 49 10             	mov    0x10(%rcx),%ecx
  1b:	4c 89 f7             	mov    %r14,%rdi
  1e:	4c 89 ee             	mov    %r13,%rsi
  21:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
  26:	41 89 e9             	mov    %ebp,%r9d
* 29:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2e:	e9 40 ff ff ff       	jmp    0xffffff73
  33:	66                   	data16
  34:	66                   	data16
  35:	66                   	data16
  36:	66                   	data16
  37:	2e                   	cs
  38:	0f                   	.byte 0xf
  39:	1f                   	(bad)
  3a:	84 00                	test   %al,(%rax)
  3c:	00 00                	add    %al,(%rax)


