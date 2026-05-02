Return-Path: <linux-wireless+bounces-35767-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPKaHp/f9WljQAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35767-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 13:27:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EDA4B1C99
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 13:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFC333004212
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2026 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AF02ED16D;
	Sat,  2 May 2026 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=hlope.org.za header.i=@hlope.org.za header.b="e4QyXmWR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from spe3.ucebox.co.za (spe3.ucebox.co.za [197.242.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE420308F36
	for <linux-wireless@vger.kernel.org>; Sat,  2 May 2026 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=197.242.159.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777721241; cv=none; b=R/J/xpYk1f4iDL/dPFYZ57pmwd0OS9po4oGuHYZmCiTmLJoZ5m8/+nfVe//hpxoXmZRv6FnoRRv+m23qg1cIU2KX1nDU9Ssx21Snz30VqGvYtN2nX8PlNBYoCr/9gWqIn1S3FU82eVFIx5SYTUoydsMmfPnh6itQ2AVZ2vR1iC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777721241; c=relaxed/simple;
	bh=zX1/WQdYJz3pkK8x3Rapd7vh14K0O9xbqweHgtNq+fQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=bY002nit5ODjk2LzBK3NxXweFqfRf6NnXMV4cJfg4PVPIY/KRCidlfFaueJgiMoH52mLZjW02NQZgLmYa37ptivGfGOSRVLA/Tl9XqOpf2nNAc9DtlGzVTAHC+h6MiZtg2oBU94ybfdvOs2xMG7RGA5QUqNiUAGybDX4YXbLUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hlope.org.za; spf=pass smtp.mailfrom=hlope.org.za; dkim=fail (0-bit key) header.d=hlope.org.za header.i=@hlope.org.za header.b=e4QyXmWR reason="key not found in DNS"; arc=none smtp.client-ip=197.242.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hlope.org.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hlope.org.za
Received: from zulu.aserv.co.za ([154.0.174.187])
	by spe9.ucebox.co.za with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <developer@hlope.org.za>)
	id 1wJ8Dy-0028CO-IO
	for linux-wireless@vger.kernel.org; Sat, 02 May 2026 12:58:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=hlope.org.za; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TCAUaD0SEMgwXL0VQx8DrmtgBFiVdWlRzgjONGqFOCU=; b=e4QyXmWRhqiQdqkhMStJn/+LdS
	SQxtrPLXEfLzIRE6cqgsSKMsmnKHyFP+zQmH7z4Nl/PfmvSuitBAnrxQJikYkfsTlqE9MAG/tX3m6
	LFsoUog+jVcr2QZoMamiEz7tZ4JiAd/dMalZZuDCs/bZuOAUq/rwOtzlGUTWxxt8rZkOt9Q4gbgds
	m0vFrv/d7m0CJM9ZCGvcIRa3vYgkumapD0Hve6R1d+/7C1Osn3nTtjo8oDfvwFI8Toy46UdqOSJCO
	NuP+e+Q2yohRrfZRQTZvsOlY0/WTK1u7wQqVx/f1QxUk6omEHh8QKMYZ4I9HjUZGrviCz+w859E4W
	GXBPT9Og==;
Received: from vc-vb-41-1-137-10.umts.vodacom.co.za ([41.1.137.10]:35606 helo=bongani-mini.home.org.za)
	by zulu.aserv.co.za with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <developer@hlope.org.za>)
	id 1wJ83G-0000000FhEs-0wAs
	for linux-wireless@vger.kernel.org;
	Sat, 02 May 2026 12:58:25 +0200
Date: Sat, 2 May 2026 12:58:24 +0200
From: Bongani Hlope <developer@hlope.org.za>
To: linux-wireless@vger.kernel.org
Subject: [BUG] wifi:  mt7902: NULL pointer dereference
Message-ID: <20260502125824.425d7159@bongani-mini.home.org.za>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/kW6XZQ01VnjOl9wqSTwUY3="
X-Get-Message-Sender-Via: zulu.aserv.co.za: authenticated_id: developer@hlope.org.za
X-Authenticated-Sender: zulu.aserv.co.za: developer@hlope.org.za
X-Afrihost-Domain: zulu.aserv.co.za
X-Afrihost-Username: 154.0.174.187
Authentication-Results: ucebox.co.za; auth=pass smtp.auth=154.0.174.187@zulu.aserv.co.za
X-Afrihost-Outgoing-Class: ham
X-Afrihost-Outgoing-Evidence: SB/global_tokens (3.0686342356e-10)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuV/M80WQNiIDDXQTQquUw/LChjzQ3JIZVFF
 8HV60IETFiu2SmbhJN1U9FKs8X3+Nt1zK+WV213mG9v1wBG3CJSJghHNKUD0bxViKcuMBmKJGtCI
 EVI9LzXDA1Xh+DPG4pL6EavGfHjCvaollK4sshM+k31k9aIIh+zJRA1xOJoRUKPGxjczx15onleF
 Kw2Xyyt6ZP2tC/xa8XrsQTYQrzShD1u9kStEG9iVayg0+O5KG5yvQMuWkRBpkwdqZCCJb2JtsT/K
 rZZE9nYR6d54nf41nJrgScHt+gjdYMBYQipBHjaQjbZXf7r/xWkJ7iSXisGgI7ipNMWH5h8WGewk
 pb7hZAHYSttyJwNs842uSNa4g9gPs0tPdO8E0s9/X6zcRJ74YYipGOQzPaO+qVA5KAhtAfD+R2gc
 z+gFAo4d+8j0ZxarK9ZokdXLR0Ak+HVqA76gMuAbQVblRb2cB1eH+fHy/me88+EY3zUbPYov6J0a
 /7wqyT5p50x81ZKcmzCu2U05xtF3xe//t5hsgHhlJAQsOBtxa5jaUkvbrJx5g8XZpbpXMX44D2sc
 lZz9QH7f/hmsZUuvgdrOZrw79MAW965faIfVaCHpEB6cFH6WJxE4Zjm0E9Z0fWCaM2Zll1+MDSK2
 CKOH12PjOhpmGIIwS8o40vdkUJ0F5PJcAvj+lex7IvyCxX5I3yc8ksisDY95MqKrVUzjVy87LTew
 YzHgq3Cg6Ri7w/NknqZKk7JU7W4LEFKOP/hFMrSq0fTHfSNkbNdGMQEdYHc6Xwk/DFt/t+k7TIbE
 FZy/RIPkSxAl/xCd7lDTDbvWhRfgWTIJ596OcNZUoXAOl772tkAFRI6aswDW+FFIy10ToX1sAvTM
 RAFrKlPpGIWkuuUH72RAyL2kn1i9d6hWUqvBcfvaLZ9Gqo2vi5Ll4syUjR3L0oC9PAYiUJHbuv0d
 hTPOJMWERUrwtSAF8UKKv6n8XNgFSNimYRXi2vmOo5DrVc/i8uL114uEclQJKUaq+jJCStbNUKvS
 eJxJlSqCD2ZoLNyo/ei4CZXg
X-Report-Abuse-To: spam@spe1.ucebox.co.za
X-Complaints-To: abuse@spe1.ucebox.co.za
X-Rspamd-Queue-Id: 36EDA4B1C99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35767-lists,linux-wireless=lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_AS(0.00)[developer@hlope.org.za];
	RCPT_COUNT_ONE(0.00)[1];
	DMARC_NA(0.00)[hlope.org.za];
	R_DKIM_PERMFAIL(0.00)[hlope.org.za:s=default];
	HAS_X_GMSV(0.00)[developer@hlope.org.za];
	DKIM_TRACE(0.00)[hlope.org.za:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_SPAM(0.00)[0.943];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[developer@hlope.org.za,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

--MP_/kW6XZQ01VnjOl9wqSTwUY3=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello

I'm not sure if this has been reported yet, first ran into this on
linux-next and it is still present on linux 7.1.0-rc1+. I get the
following kernel Oops:

wpa_supplicant[918]: wlp3s0: CTRL-EVENT-STARTED-CHANNEL-SWITCH
freq=5240 ht_enabled=1 ch_offset=-1 ch_width=80 MHz cf1=5210 cf2=0
kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000
kernel: #PF: supervisor read access in kernel mode
kernel: #PF: error_code(0x0000) - not-present page
kernel: PGD 0 P4D 0 
kernel: Oops: Oops: 0000 [#1] SMP NOPTI
kernel: CPU: 7 UID: 0 PID: 6710 Comm: kworker/u64:1 Not tainted
7.1.0-rc1+ #4 PREEMPT(full) 
kernel: Hardware name: Micro Computer (HK) Tech Limited EliteMini
Series/F7BSI, BIOS 1.08 11/05/2024
kernel: Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
kernel: PGD 0 P4D 0 
kernel: Oops: Oops: 0000 [#1] SMP NOPTI
kernel: CPU: 7 UID: 0 PID: 6710 Comm: kworker/u64:1 Not tainted
7.1.0-rc1+ #4 PREEMPT(full) 
kernel: Hardware name: Micro Computer (HK) Tech Limited EliteMini
Series/F7BSI, BIOS 1.08 11/05/2024
kernel: Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
kernel: RIP: 0010:mt7921_channel_switch_rx_beacon+0x1f/0x100
[mt7921_common]
kernel: Code: 12 3d 00 eb 9a 66 0f 1f 44 00 00 f3 0f 1e fa 0f 1f 44 00
00 48 8b 47 58 48 ff 05 ec 15 3d 00 48 8b 40 08 48 8b 80 80 9c 00 00 <48> 8b 08 48 39 4a 10 74 0c 48 ff 05 81 02 3d 00 e9 f7 f4 74 ea 53
kernel: RSP: 0018:ffffb75fa1993af0 EFLAGS: 00010202
kernel: RAX: 0000000000000000 RBX: ffff91cae1eb09e0 RCX:
0000000000000000
kernel: RDX: ffffb75fa1993b20 RSI: ffff91ca84badfe8 RDI:
ffff91cae1eb09e0
kernel: RBP: ffff91ca84bacac0 R08: 0000000000000001 R09:
0000000000000001
kernel: R10: ffff91ca8ba56128 R11: ffff91cae1eb0518 R12:
0000000000000000
kernel: R13: 0000000000000000 R14: ffffb75fa1993b60 R15:
ffff91cae1eb09e0
kernel: FS:  0000000000000000(0000) GS:ffff91d18ebde000(0000)
knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000000000000000 CR3: 0000000562a38000 CR4:
0000000000f50ef0
kernel: PKRU: 55555554
kernel: Call Trace:
kernel:  <TASK>
kernel:  ieee80211_sta_process_chanswitch+0x67c/0xee0 [mac80211]
kernel:  ieee80211_rx_mgmt_beacon+0x842/0x22a0 [mac80211]
kernel:  ? __entry_text_end+0x1020b6/0x1020b9
kernel:  ? internal_add_timer+0x4d/0x80
kernel:  ? __mod_timer+0x25e/0x500
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ieee80211_sta_rx_queued_mgmt+0xa7/0xbb0 [mac80211]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? psi_task_switch+0x31e/0x410
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ieee80211_iface_work+0x62e/0x890 [mac80211]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __schedule+0x5c8/0x20d0
kernel:  cfg80211_wiphy_work+0x1ee/0x280 [cfg80211]
kernel:  process_scheduled_works+0x180/0x680
kernel:  ? rescuer_thread+0x7f0/0x7f0
kernel:  worker_thread+0x1aa/0x450
kernel:  ? rescuer_thread+0x7f0/0x7f0
kernel:  kthread+0x181/0x1e0
kernel:  ? kthread_affine_node+0x1e0/0x1e0
kernel:  ret_from_fork+0x405/0x600
kernel:  ? kthread_affine_node+0x1e0/0x1e0
kernel:  ret_from_fork_asm+0x11/0x20
kernel:  </TASK>
kernel: Modules linked in: joydev uinput mptcp_diag xsk_diag tcp_diag
udp_diag raw_diag inet_diag unix_diag af_packet_diag netlink_diag sd_mod scsi_mod scsi_common ccm snd_seq_dummy snd_hrtimer snd_seq snd_>
kernel:  snd snd_pci_acp5x snd_rn_pci_acp3x irqbypass aesni_intel
snd_acp_config gf128mul snd_soc_acpi rapl ecdh_generic pcspkr k10temp amd_pmc snd_pci_acp3x soundcore button evdev rfkill libarc4 aead msr e>
kernel: CR2: 0000000000000000
kernel: ---[ end trace 0000000000000000 ]---
kernel: RIP: 0010:mt7921_channel_switch_rx_beacon+0x1f/0x100
[mt7921_common]
kernel: Code: 12 3d 00 eb 9a 66 0f 1f 44 00 00 f3 0f 1e fa 0f 1f 44 00
00 48 8b 47 58 48 ff 05 ec 15 3d 00 48 8b 40 08 48 8b 80 80 9c 00 00 <48> 8b 08 48 39 4a 10 74 0c 48 ff 05 81 02 3d 00 e9 f7 f4 74 ea 53
kernel: RSP: 0018:ffffb75fa1993af0 EFLAGS: 00010202
kernel: RAX: 0000000000000000 RBX: ffff91cae1eb09e0 RCX:
0000000000000000
kernel: RDX: ffffb75fa1993b20 RSI: ffff91ca84badfe8 RDI:
ffff91cae1eb09e0
kernel: RBP: ffff91ca84bacac0 R08: 0000000000000001 R09:
0000000000000001
kernel: R10: ffff91ca8ba56128 R11: ffff91cae1eb0518 R12:
0000000000000000
kernel: R13: 0000000000000000 R14: ffffb75fa1993b60 R15:
ffff91cae1eb09e0
kernel: FS:  0000000000000000(0000) GS:ffff91d18ebde000(0000)
knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000000000000000 CR3: 0000000562a38000 CR4:
0000000000f50ef0
kernel: PKRU: 55555554
kernel: note: kworker/u64:1[6710] exited with irqs disabled

Regards,
Bongani Hlope



--MP_/kW6XZQ01VnjOl9wqSTwUY3=
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lspci.txt

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Phoenix IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host Bridge
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Phoenix GPP Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Phoenix GPP Bridge
00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Phoenix GPP Bridge
00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host Bridge
00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 19h USB4/Thunderbolt PCIe tunnel
00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host Bridge
00:04.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 19h USB4/Thunderbolt PCIe tunnel
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Internal GPP Bridge to Bus [C:A]
00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Internal GPP Bridge to Bus [C:A]
00:08.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Internal GPP Bridge to Bus [C:A]
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 71)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 7
01:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc. OM8TAP4 PCIe 4 NVMe SSD (QLC) (DRAM-less)
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
03:00.0 Network controller: MEDIATEK Corp. Device 7902
c4:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Phoenix3 (rev b3)
c4:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Radeon High Definition Audio Controller [Rembrandt/Strix]
c4:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Phoenix CCP/PSP 3.0 Device
c4:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Device 15b9
c4:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Device 15ba
c4:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] Audio Coprocessor (rev 63)
c4:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h/1ah HD Audio Controller
c5:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Function
c6:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Function
c6:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Device 15c0
c6:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Device 15c1
c6:00.5 USB controller: Advanced Micro Devices, Inc. [AMD] Pink Sardine USB4/Thunderbolt NHI controller #1
c6:00.6 USB controller: Advanced Micro Devices, Inc. [AMD] Pink Sardine USB4/Thunderbolt NHI controller #2

--MP_/kW6XZQ01VnjOl9wqSTwUY3=--

