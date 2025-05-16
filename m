Return-Path: <linux-wireless+bounces-23088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6549CABA2AC
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 20:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D870B7A5B56
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 18:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ABD27C84B;
	Fri, 16 May 2025 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="rZnzGgS5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90126A0BE;
	Fri, 16 May 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419630; cv=none; b=f4OLnmSXjs5Ofn7QnRXLcmhx4yaU+erzx1Yg8P6nn4Q1HlCRpRfEEt5FfxO7YAw/AgKKOLzjgUUV35Pvx1bIL0tQXRQUhcQb/sumb8E/ZQPZ/ItaJb2Oj6+jah5qyXHnShuyT27RiTBgdv2tvrVIyXlg2EchuF/n+rXNWZYbIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419630; c=relaxed/simple;
	bh=i22A1w5AKhlN8jaaG9r62lrwQPlASEcY4n9aoE+UlEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a0ZFn8PVRlDP98vzzkVQPtCpfj6eSPEKV5a2PQTnSjOcEzm5YPiAe9Ucd6itHFNUKTWEaHuilZu6kdqrXORIG7X/9u0/JMapiyWWw9ESwVhyCSKGGxit+7a8YRFRuJcO9Edts4WiSR0Y/zgS9/nd1l0tqBfHEFRtphudWptKRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=rZnzGgS5; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747419600; x=1748024400; i=spasswolf@web.de;
	bh=DljaHIK2q81/b2zdkPMR/eG/mnEl+c+88QLWW5/55rA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rZnzGgS56uA/DN5zs9ZlzD5Wb6VNmG42X46iemZyLtsWUKfJ+IfVwtpvetZXDp3O
	 sSfB9vZr5Ou4asJZ8/NVleYC4nDtUQYGeSUu0Yxi3J2XOBulroPtYiKjSp/keXwem
	 h3XNWM9i415i+A9/pVJqGlhZ4TDMoku78Neo8eej6jJ1sMdGNbKOi9baZCUDVl1Ny
	 x9AuwTy5wGUtv99JBwj63UuBu13Rwa7LUckuc54c8/3sKbIw7s8R9letEJgHDGPgj
	 IXOgx9TVvMAkPMaUWsyiBsJ0Km7C9DeHyCoQdZyWSoC/6KHNE2okGYUucSWr803xw
	 lx4lbFxwqwqfaWODkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL4Y-1uAY9U2Vz2-00BTDU; Fri, 16
 May 2025 20:20:00 +0200
Message-ID: <63cc1dbf07bde2c9d14e1f86ce2c2ce26a2a9936.camel@web.de>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Bert Karwatzki <spasswolf@web.de>
To: Johannes Berg <johannes@sipsolutions.net>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, 
 "llvm@lists.linux.dev"
	 <llvm@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-wireless@vger.kernel.org, spasswolf@web.de
Date: Fri, 16 May 2025 20:19:59 +0200
In-Reply-To: <ba97a2559cda1b14e0c9754523ff1152bdad90ef.camel@web.de>
References: <20250513164807.51780-1-spasswolf@web.de> <87h61ojg3g.ffs@tglx>
										 <7471a185adcc34a79c2ab8ce1e87ab922ae2232b.camel@web.de>
									 <b644ff1714731cfb652d809d4864f0d178b24a97.camel@web.de>
								 <2d8c1929bf5ab5260dacf9aa390456b3b49ce465.camel@sipsolutions.net>
							 <2cad838b39f00d93319509d2a6a77a4c42c7fa92.camel@web.de>
						 <a12c82c394e9676e32ede6b8312f821a16fef94b.camel@sipsolutions.net>
			 <f8552d41fb7eae286803b78302390614179b33b0.camel@web.de>
		 <8684a2b4bf367e2e2a97e2b52356ffe5436a8270.camel@sipsolutions.net>
	 <ba97a2559cda1b14e0c9754523ff1152bdad90ef.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a/xw0bSc2Eo/mXot/Scjsv8aM99ZOruv4XCQwbG9/7ZBEBwiBvs
 rpIvr3f5FEYu7u74M0YQom2c5bfcYLeEbapkrS+zr0rhzan4dBKnzSP9FEUqtYK13n06GE6
 K/6Duod2/lRUCWrmQizipvtGQua/S9mAuyjjvQan7P21WocOcE4VqX9WHuLgY1c3Y4nYw71
 rQVYKfGGBigFNgSpXduRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zr+ApHmj1sg=;zAqcXrRKqIB/uGhdpofFIeMXn1G
 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


I've added a debugging statement:

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3bd5ee0995fe..853493eca4f5 100644
=2D-- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4586,7 +4586,11 @@ static noinline void ieee80211_8023_xmit_clang_debu=
g_helper(struct sk_buff *skb,
                                                            struct ieee802=
11_local *local,
                                                            struct ieee802=
11_tx_info *info)
 {
-       if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATUS))) {
+       if (unlikely(skb->sk && ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_S=
TATUS) ||
+                               sock_flag(skb->sk, SOCK_WIFI_STATUS)))) {
+               if ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ^ sock=
_flag(skb->sk, SOCK_WIFI_STATUS))
+                       printk(KERN_INFO "%s: skb_shinfo(skb)->tx_flags & =
SKBTX_WIFI_STATUS =3D %u sock_flag(skb->sk,
SOCK_WIFI_STATUS) =3D %u\n",
+                                       __func__, (skb_shinfo(skb)->tx_fla=
gs & SKBTX_WIFI_STATUS), sock_flag(skb->sk,
SOCK_WIFI_STATUS));
                info->status_data =3D ieee80211_store_ack_skb(local, skb,
                                                            &info->flags, =
NULL);
                if (info->status_data)

This gives the following logoutput (and a lockup), indicating that sock_fl=
ag(skb->sk, SOCK_WIFI_STATUS) and
(skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) are actually NOT equivalen=
t (when compiled with clang and
PREEMPT_RT=3Dy)

2025-05-16T20:09:58.818563+02:00 lisa kernel: [  T581] ieee80211_8023_xmit=
_clang_debug_helper: skb_shinfo(skb)->tx_flags
& SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_WIFI_STATUS) =3D 1
2025-05-16T20:10:19.829599+02:00 lisa kernel: [    C2] rcu: INFO: rcu_pree=
mpt detected stalls on CPUs/tasks:
2025-05-16T20:10:19.829607+02:00 lisa kernel: [    C2] rcu: 	4-...!: (1 GP=
s behind) idle=3D1ddc/1/0x4000000000000000
softirq=3D0/0 fqs=3D72 rcuc=3D21002 jiffies(starved)
2025-05-16T20:10:19.829609+02:00 lisa kernel: [    C2] rcu: 	14-...!: (1 G=
Ps behind) idle=3D4cbc/1/0x4000000000000000
softirq=3D0/0 fqs=3D72 rcuc=3D21013 jiffies(starved)
2025-05-16T20:10:19.829611+02:00 lisa kernel: [    C2] rcu: 	Tasks blocked=
 on level-0 rcu_node (CPUs 0-15): P581
2025-05-16T20:10:19.829613+02:00 lisa kernel: [    C2] rcu: 	(detected by =
2, t=3D21002 jiffies, g=3D7525, q=3D973
ncpus=3D16)
2025-05-16T20:10:19.829615+02:00 lisa kernel: [    C2] Sending NMI from CP=
U 2 to CPUs 4:
2025-05-16T20:10:19.829616+02:00 lisa kernel: [    C4] NMI backtrace for c=
pu 4
2025-05-16T20:10:19.829618+02:00 lisa kernel: [    C4] CPU: 4 UID: 0 PID: =
581 Comm: napi/phy0-0 Not tainted 6.15.0-rc6-
next-20250513-llvm-00011-gf9a7992d47e7 #978 PREEMPT_{RT,(full)}=20
2025-05-16T20:10:19.829620+02:00 lisa kernel: [    C4] Hardware name: Micr=
o-Star International Co., Ltd. Alpha 15
B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
2025-05-16T20:10:19.829622+02:00 lisa kernel: [    C4] RIP: 0010:rtlock_sl=
owlock_locked+0xaed/0xc70
2025-05-16T20:10:19.829623+02:00 lisa kernel: [    C4] Code: 59 61 6a ff 4=
9 c7 07 01 00 00 00 4d 89 7f 08 65 ff 0d b7 bd
c1 00 74 4f 4d 85 ed 0f 84 76 ff ff ff e8 77 28 71 ff 48 8b 43 18 <48> 83 =
e0 fe 49 39 c5 75 2a 41 83 7d 34 00 0f 84 54
ff ff ff 41 8b
2025-05-16T20:10:19.829625+02:00 lisa kernel: [    C4] RSP: 0018:ffffcc0dc=
1ef7b00 EFLAGS: 00000246

2025-05-16T20:10:19.829627+02:00 lisa kernel: [    C4] RAX: ffff89e9c52f80=
01 RBX: ffff89e9e17a2e10 RCX: ffff89e9c52f8001
2025-05-16T20:10:19.829629+02:00 lisa kernel: [    C4] RDX: ffffcc0dc1ef7b=
38 RSI: ffff89e9c52fd000 RDI: ffffcc0dc1ef7bf0
2025-05-16T20:10:19.829631+02:00 lisa kernel: [    C4] RBP: ffff89e9c52fd8=
20 R08: ffffffffffffeb42 R09: 0000000000000002
2025-05-16T20:10:19.829632+02:00 lisa kernel: [    C4] R10: 00000000000000=
e4 R11: 00000000000005fe R12: ffffcc0dc1ef7b38
2025-05-16T20:10:19.829634+02:00 lisa kernel: [    C4] R13: ffff89e9c52f80=
00 R14: ffff89e9c52fd000 R15: ffffcc0dc1ef7bf0
2025-05-16T20:10:19.829636+02:00 lisa kernel: [    C4] FS:  00000000000000=
00(0000) GS:ffff89f8986c1000(0000)
knlGS:0000000000000000
2025-05-16T20:10:19.829637+02:00 lisa kernel: [    C4] CS:  0010 DS: 0000 =
ES: 0000 CR0: 0000000080050033
2025-05-16T20:10:19.829638+02:00 lisa kernel: [    C4] CR2: 00007f9ea92e20=
00 CR3: 00000007e5a3a000 CR4: 0000000000750ef0
2025-05-16T20:10:19.829640+02:00 lisa kernel: [    C4] PKRU: 55555554
2025-05-16T20:10:19.829642+02:00 lisa kernel: [    C4] Call Trace:
2025-05-16T20:10:19.829643+02:00 lisa kernel: [    C4]  <TASK>
2025-05-16T20:10:19.829644+02:00 lisa kernel: [    C4]  ? rt_spin_unlock+0=
x12/0x40
2025-05-16T20:10:19.829646+02:00 lisa kernel: [    C4]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2025-05-16T20:10:19.829648+02:00 lisa kernel: [    C4]  rt_spin_lock+0x81/=
0xa0
2025-05-16T20:10:19.829649+02:00 lisa kernel: [    C4]  mt76_rx_complete+0=
x49/0x2e0 [mt76]
2025-05-16T20:10:19.829651+02:00 lisa kernel: [    C4]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2025-05-16T20:10:19.829653+02:00 lisa kernel: [    C4]  mt76_rx_poll_compl=
ete+0x4a4/0x4d0 [mt76]
2025-05-16T20:10:19.829654+02:00 lisa kernel: [    C4]  ? mt76_dma_rx_poll=
+0xf6/0x660 [mt76]
2025-05-16T20:10:19.829656+02:00 lisa kernel: [    C4]  mt76_dma_rx_poll+0=
x147/0x660 [mt76]
2025-05-16T20:10:19.829657+02:00 lisa kernel: [    C4]  ? mt792x_poll_rx+0=
x2a/0x120 [mt792x_lib]
2025-05-16T20:10:19.829658+02:00 lisa kernel: [    C4]  mt792x_poll_rx+0x7=
1/0x120 [mt792x_lib]
2025-05-16T20:10:19.829660+02:00 lisa kernel: [    C4]  __napi_poll+0x2a/0=
x170
2025-05-16T20:10:19.829662+02:00 lisa kernel: [    C4]  ? napi_threaded_po=
ll_loop+0x32/0x1b0
2025-05-16T20:10:19.829663+02:00 lisa kernel: [    C4]  napi_threaded_poll=
_loop+0xe4/0x1b0
2025-05-16T20:10:19.829678+02:00 lisa kernel: [    C4]  ? napi_threaded_po=
ll_loop+0x32/0x1b0
2025-05-16T20:10:19.829679+02:00 lisa kernel: [    C4]  ? asm_sysvec_apic_=
timer_interrupt+0x1a/0x20
2025-05-16T20:10:19.829680+02:00 lisa kernel: [    C4]  napi_threaded_poll=
+0x57/0x80
2025-05-16T20:10:19.829682+02:00 lisa kernel: [    C4]  ? __pfx_napi_threa=
ded_poll+0x10/0x10
2025-05-16T20:10:19.829683+02:00 lisa kernel: [    C4]  kthread+0x25c/0x28=
0
2025-05-16T20:10:19.829685+02:00 lisa kernel: [    C4]  ? __pfx_kthread+0x=
10/0x10
2025-05-16T20:10:19.829696+02:00 lisa kernel: [    C4]  ret_from_fork+0xc4=
/0x1b0
2025-05-16T20:10:19.829698+02:00 lisa kernel: [    C4]  ? __pfx_kthread+0x=
10/0x10
2025-05-16T20:10:19.829699+02:00 lisa kernel: [    C4]  ret_from_fork_asm+=
0x1a/0x30
2025-05-16T20:10:19.829701+02:00 lisa kernel: [    C4]  </TASK>
2025-05-16T20:10:19.829702+02:00 lisa kernel: [    C2] Sending NMI from CP=
U 2 to CPUs 14:
2025-05-16T20:10:19.829704+02:00 lisa kernel: [   C14] NMI backtrace for c=
pu 14
2025-05-16T20:10:19.829705+02:00 lisa kernel: [   C14] CPU: 14 UID: 0 PID:=
 585 Comm: napi/phy0-0 Not tainted 6.15.0-rc6-
next-20250513-llvm-00011-gf9a7992d47e7 #978 PREEMPT_{RT,(full)}=20
2025-05-16T20:10:19.829707+02:00 lisa kernel: [   C14] Hardware name: Micr=
o-Star International Co., Ltd. Alpha 15
B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
2025-05-16T20:10:19.829708+02:00 lisa kernel: [   C14] RIP: 0010:queued_sp=
in_lock_slowpath+0x134/0x1c0
2025-05-16T20:10:19.829710+02:00 lisa kernel: [   C14] Code: 03 c1 e6 04 8=
3 e0 fc 49 c7 c0 f8 ff ff ff 49 8b 84 40 a0 fa
98 95 48 89 94 06 c0 21 06 96 83 7a 08 00 75 08 f3 90 83 7a 08 00 <74> f8 =
48 8b 32 48 85 f6 74 09 0f 0d 0e eb 0a 31 f6
eb 06 31 f6 eb
2025-05-16T20:10:19.829714+02:00 lisa kernel: [   C14] RSP: 0018:ffffcc0dc=
201f998 EFLAGS: 00000046
2025-05-16T20:10:19.829715+02:00 lisa kernel: [   C14] RAX: 00000000000000=
00 RBX: 0000000000000286 RCX: 00000000003c0000
2025-05-16T20:10:19.829717+02:00 lisa kernel: [   C14] RDX: ffff89f82e9a31=
c0 RSI: 0000000000000010 RDI: ffff89ea89ad79a8
2025-05-16T20:10:19.829718+02:00 lisa kernel: [   C14] RBP: ffff89ea05e8e0=
00 R08: fffffffffffffff8 R09: 0000000000000001
2025-05-16T20:10:19.829720+02:00 lisa kernel: [   C14] R10: 00000000000000=
01 R11: ffffffff951f07f0 R12: ffff89ea89ad7990
2025-05-16T20:10:19.829722+02:00 lisa kernel: [   C14] R13: ffff89e9e17a24=
80 R14: ffff89ea89ad79a8 R15: ffff89ea89ad79a8
2025-05-16T20:10:19.829723+02:00 lisa kernel: [   C14] FS:  00000000000000=
00(0000) GS:ffff89f898941000(0000)
knlGS:0000000000000000
2025-05-16T20:10:19.829735+02:00 lisa kernel: [   C14] CS:  0010 DS: 0000 =
ES: 0000 CR0: 0000000080050033
2025-05-16T20:10:19.829737+02:00 lisa kernel: [   C14] CR2: 00007f522c1f70=
00 CR3: 00000007e5a3a000 CR4: 0000000000750ef0
2025-05-16T20:10:19.829738+02:00 lisa kernel: [   C14] PKRU: 55555554
2025-05-16T20:10:19.829740+02:00 lisa kernel: [   C14] Call Trace:
2025-05-16T20:10:19.829741+02:00 lisa kernel: [   C14]  <TASK>
2025-05-16T20:10:19.829743+02:00 lisa kernel: [   C14]  _raw_spin_lock_irq=
save+0x57/0x60
2025-05-16T20:10:19.829744+02:00 lisa kernel: [   C14]  rt_spin_lock+0x73/=
0xa0
2025-05-16T20:10:19.829745+02:00 lisa kernel: [   C14]  sock_queue_err_skb=
+0xdc/0x140
2025-05-16T20:10:19.829773+02:00 lisa kernel: [   C14]  skb_complete_wifi_=
ack+0xa9/0x120
2025-05-16T20:10:19.829775+02:00 lisa kernel: [   C14]  ieee80211_report_u=
sed_skb+0x541/0x6e0 [mac80211]
2025-05-16T20:10:19.829786+02:00 lisa kernel: [   C14]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2025-05-16T20:10:19.829816+02:00 lisa kernel: [   C14]  ? __schedule+0x506=
/0x1280
2025-05-16T20:10:19.829822+02:00 lisa kernel: [   C14]  ? preempt_schedule=
_irq+0x42/0x80
2025-05-16T20:10:19.829823+02:00 lisa kernel: [   C14]  ieee80211_tx_statu=
s_ext+0x3b3/0x870 [mac80211]
2025-05-16T20:10:19.829824+02:00 lisa kernel: [   C14]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2025-05-16T20:10:19.829826+02:00 lisa kernel: [   C14]  ? rt_spin_lock+0x3=
d/0xa0
2025-05-16T20:10:19.829828+02:00 lisa kernel: [   C14]  ? mt76_tx_status_u=
nlock+0x38/0x230 [mt76]
2025-05-16T20:10:19.829829+02:00 lisa kernel: [   C14]  mt76_tx_status_unl=
ock+0x1e0/0x230 [mt76]
2025-05-16T20:10:19.829830+02:00 lisa kernel: [   C14]  __mt76_tx_complete=
_skb+0x13b/0x2e0 [mt76]
2025-05-16T20:10:19.829832+02:00 lisa kernel: [   C14]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2025-05-16T20:10:19.829833+02:00 lisa kernel: [   C14]  ? rt_spin_unlock+0=
x12/0x40
2025-05-16T20:10:19.829834+02:00 lisa kernel: [   C14]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2025-05-16T20:10:19.829836+02:00 lisa kernel: [   C14]  mt76_connac2_txwi_=
free+0x127/0x150 [mt76_connac_lib]
2025-05-16T20:10:19.829838+02:00 lisa kernel: [   C14]  mt7921_mac_tx_free=
+0x112/0x260 [mt7921_common]
2025-05-16T20:10:19.829839+02:00 lisa kernel: [   C14]  mt7921_rx_check+0x=
33/0xe0 [mt7921_common]
2025-05-16T20:10:19.829841+02:00 lisa kernel: [   C14]  mt76_dma_rx_poll+0=
x322/0x660 [mt76]
2025-05-16T20:10:19.829842+02:00 lisa kernel: [   C14]  ? mt792x_poll_rx+0=
x2a/0x120 [mt792x_lib]
2025-05-16T20:10:19.829843+02:00 lisa kernel: [   C14]  mt792x_poll_rx+0x7=
1/0x120 [mt792x_lib]
2025-05-16T20:10:19.829845+02:00 lisa kernel: [   C14]  __napi_poll+0x2a/0=
x170
2025-05-16T20:10:19.829846+02:00 lisa kernel: [   C14]  ? napi_threaded_po=
ll_loop+0x32/0x1b0
2025-05-16T20:10:19.829848+02:00 lisa kernel: [   C14]  napi_threaded_poll=
_loop+0xe4/0x1b0
2025-05-16T20:10:19.829849+02:00 lisa kernel: [   C14]  ? napi_threaded_po=
ll_loop+0x32/0x1b0
2025-05-16T20:10:19.829851+02:00 lisa kernel: [   C14]  ? ttwu_do_activate=
+0xa9/0x1a0
2025-05-16T20:10:19.829863+02:00 lisa kernel: [   C14]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2025-05-16T20:10:19.829864+02:00 lisa kernel: [   C14]  napi_threaded_poll=
+0x57/0x80
2025-05-16T20:10:19.829866+02:00 lisa kernel: [   C14]  ? __pfx_napi_threa=
ded_poll+0x10/0x10
2025-05-16T20:10:19.829867+02:00 lisa kernel: [   C14]  kthread+0x25c/0x28=
0
2025-05-16T20:10:19.829868+02:00 lisa kernel: [   C14]  ? __pfx_kthread+0x=
10/0x10
2025-05-16T20:10:19.829871+02:00 lisa kernel: [   C14]  ret_from_fork+0xc4=
/0x1b0
2025-05-16T20:10:19.829873+02:00 lisa kernel: [   C14]  ? __pfx_kthread+0x=
10/0x10
2025-05-16T20:10:19.829874+02:00 lisa kernel: [   C14]  ret_from_fork_asm+=
0x1a/0x30
2025-05-16T20:10:19.829875+02:00 lisa kernel: [   C14]  </TASK>


Bert Karwatzki

