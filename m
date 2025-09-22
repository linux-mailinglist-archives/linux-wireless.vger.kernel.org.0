Return-Path: <linux-wireless+bounces-27550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F051B8EA9E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 03:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45C2189A54C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 01:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B9148830;
	Mon, 22 Sep 2025 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Eufm3Y2x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A7481DD;
	Mon, 22 Sep 2025 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503948; cv=none; b=gc24yRsbkR7ePCxsKZ38MpuaF6wg5UjPuaSDdhmHDtjbWrtw8Nv7W+L0g1oLAycp42VMJTjrASnKCcHN/KpVUur4z0j2YL7xg6zfDQ0KoTzXqYtPYNH0MOf27/9W3fsfSqbVMhA4a88MMRqpdR8joRfk5lUjYGf5kFMGbnwMITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503948; c=relaxed/simple;
	bh=wPn9cvRHGOjpYsmWC0ojlvksHsDIjUJHt/jZvBQB3Zk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UQH3Ay6/2xmcaoKBCm7IVdttbadyK2VWXRb/BeaAJc0ujheImj2VpcO7af8EsTHxMzvMF/qSerS6wfxbp8gBiaFGqzKwSGMB85vr0rkVUnlgzjGAeYlf7+k4dFeduYyxaHud7fNW8ogHONnB0sjze6Oom9L5HB+pBXiQrz2OIzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Eufm3Y2x; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58M1IeUsA3495560, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758503920; bh=p7LZFSgA0/HcOqDv17nbjQEtOaBU2w78E1Qh3nWgL6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Eufm3Y2xbtC/NBXJsW6p2bNTOFLEuaTSyB4kGWNaximkrSuZdmU2uVuwuvXDoIY5Q
	 lClschGMNFuBgouBMdvCQafGQGs/8p6OpPv4yYAezBqvysUl+8viyFRYR9GQCtuj4D
	 K3Y0xr0qxp1yM9dVQUDALBO63R0Eps09KpF7FJO/3qKy1ybBjw2ckmK0pCXkgz87W7
	 zptl7vBCP0ElmUWEbHKjYUYKkpNvD0dQKsh2+HfVMahfjhYX/R9yeRU+Vic83ikPd2
	 fJfRDgjQMOeF+GoCV7s8nGCRxbKOufSz2kKeX7GmGDKm6L/edroMJVdUtz3z4B3roE
	 pvkwOulCV+rFA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58M1IeUsA3495560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 09:18:40 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 22 Sep 2025 09:18:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Sep 2025 09:18:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Mon, 22 Sep 2025 09:18:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next v5 1/4] wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
Thread-Topic: [PATCH rtw-next v5 1/4] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()
Thread-Index: AQHcKanJdlLBn5PAWkut4UDGgRk+3LSeajjw
Date: Mon, 22 Sep 2025 01:18:38 +0000
Message-ID: <eaf2925504f14e9db946978a366fcbdf@realtek.com>
References: <20250919210852.823912-1-pchelkin@ispras.ru>
 <20250919210852.823912-2-pchelkin@ispras.ru>
In-Reply-To: <20250919210852.823912-2-pchelkin@ispras.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> There is a bug observed when rtw89_core_tx_kick_off_and_wait() tries to
> access already freed skb_data:
>=20
>  BUG: KFENCE: use-after-free write in rtw89_core_tx_kick_off_and_wait
> drivers/net/wireless/realtek/rtw89/core.c:1110
>=20
>  CPU: 6 UID: 0 PID: 41377 Comm: kworker/u64:24 Not tainted  6.17.0-rc1+ #=
1 PREEMPT(lazy)
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS edk2-2025052=
3-14.fc42 05/23/2025
>  Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
>=20
>  Use-after-free write at 0x0000000020309d9d (in kfence-#251):
>  rtw89_core_tx_kick_off_and_wait drivers/net/wireless/realtek/rtw89/core.=
c:1110
>  rtw89_core_scan_complete drivers/net/wireless/realtek/rtw89/core.c:5338
>  rtw89_hw_scan_complete_cb drivers/net/wireless/realtek/rtw89/fw.c:7979
>  rtw89_chanctx_proceed_cb drivers/net/wireless/realtek/rtw89/chan.c:3165
>  rtw89_chanctx_proceed drivers/net/wireless/realtek/rtw89/chan.h:141
>  rtw89_hw_scan_complete drivers/net/wireless/realtek/rtw89/fw.c:8012
>  rtw89_mac_c2h_scanofld_rsp drivers/net/wireless/realtek/rtw89/mac.c:5059
>  rtw89_fw_c2h_work drivers/net/wireless/realtek/rtw89/fw.c:6758
>  process_one_work kernel/workqueue.c:3241
>  worker_thread kernel/workqueue.c:3400
>  kthread kernel/kthread.c:463
>  ret_from_fork arch/x86/kernel/process.c:154
>  ret_from_fork_asm arch/x86/entry/entry_64.S:258
>=20
>  kfence-#251: 0x0000000056e2393d-0x000000009943cb62, size=3D232, cache=3D=
skbuff_head_cache
>=20
>  allocated by task 41377 on cpu 6 at 77869.159548s (0.009551s ago):
>  __alloc_skb net/core/skbuff.c:659
>  __netdev_alloc_skb net/core/skbuff.c:734
>  ieee80211_nullfunc_get net/mac80211/tx.c:5844
>  rtw89_core_send_nullfunc drivers/net/wireless/realtek/rtw89/core.c:3431
>  rtw89_core_scan_complete drivers/net/wireless/realtek/rtw89/core.c:5338
>  rtw89_hw_scan_complete_cb drivers/net/wireless/realtek/rtw89/fw.c:7979
>  rtw89_chanctx_proceed_cb drivers/net/wireless/realtek/rtw89/chan.c:3165
>  rtw89_chanctx_proceed drivers/net/wireless/realtek/rtw89/chan.c:3194
>  rtw89_hw_scan_complete drivers/net/wireless/realtek/rtw89/fw.c:8012
>  rtw89_mac_c2h_scanofld_rsp drivers/net/wireless/realtek/rtw89/mac.c:5059
>  rtw89_fw_c2h_work drivers/net/wireless/realtek/rtw89/fw.c:6758
>  process_one_work kernel/workqueue.c:3241
>  worker_thread kernel/workqueue.c:3400
>  kthread kernel/kthread.c:463
>  ret_from_fork arch/x86/kernel/process.c:154
>  ret_from_fork_asm arch/x86/entry/entry_64.S:258
>=20
>  freed by task 1045 on cpu 9 at 77869.168393s (0.001557s ago):
>  ieee80211_tx_status_skb net/mac80211/status.c:1117
>  rtw89_pci_release_txwd_skb drivers/net/wireless/realtek/rtw89/pci.c:564
>  rtw89_pci_release_tx_skbs.isra.0 drivers/net/wireless/realtek/rtw89/pci.=
c:651
>  rtw89_pci_release_tx drivers/net/wireless/realtek/rtw89/pci.c:676
>  rtw89_pci_napi_poll drivers/net/wireless/realtek/rtw89/pci.c:4238
>  __napi_poll net/core/dev.c:7495
>  net_rx_action net/core/dev.c:7557 net/core/dev.c:7684
>  handle_softirqs kernel/softirq.c:580
>  do_softirq.part.0 kernel/softirq.c:480
>  __local_bh_enable_ip kernel/softirq.c:407
>  rtw89_pci_interrupt_threadfn drivers/net/wireless/realtek/rtw89/pci.c:92=
7
>  irq_thread_fn kernel/irq/manage.c:1133
>  irq_thread kernel/irq/manage.c:1257
>  kthread kernel/kthread.c:463
>  ret_from_fork arch/x86/kernel/process.c:154
>  ret_from_fork_asm arch/x86/entry/entry_64.S:258
>=20
> It is a consequence of a race between the waiting and the signaling side
> of the completion:
>=20
>             Waiting thread                            Completing thread
>=20
> rtw89_core_tx_kick_off_and_wait()
>   rcu_assign_pointer(skb_data->wait, wait)
>   /* start waiting */
>   wait_for_completion_timeout()
>                                                 rtw89_pci_tx_status()
>                                                   rtw89_core_tx_wait_comp=
lete()
>                                                     rcu_read_lock()
>                                                     /* signals completion=
 and
>                                                      * proceeds further
>                                                      */
>                                                     complete(&wait->compl=
etion)
>                                                     rcu_read_unlock()
>                                                   ...
>                                                   /* frees skb_data */
>                                                   ieee80211_tx_status_ni(=
)
>   /* returns (exit status doesn't matter) */
>   wait_for_completion_timeout()
>   ...
>   /* accesses the already freed skb_data */
>   rcu_assign_pointer(skb_data->wait, NULL)
>=20
> The completing side might proceed and free the underlying skb even before
> the waiting side is fully awoken and run to execution.  Actually the race
> happens regardless of wait_for_completion_timeout() exit status, e.g.
> the waiting side may hit a timeout and the concurrent completing side is
> still able to free the skb.
>=20
> Skbs which are sent by rtw89_core_tx_kick_off_and_wait() are owned by the
> driver.  They don't come from core ieee80211 stack so no need to pass the=
m
> to ieee80211_tx_status_ni() on completing side.
>=20
> Introduce a work function which will act as a garbage collector for
> rtw89_tx_wait_info objects and the associated skbs.  Thus no potentially
> heavy locks are required on the completing side.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Fixes: 1ae5ca615285 ("wifi: rtw89: add function to wait for completion of=
 TX skbs")
> Cc: stable@vger.kernel.org
> Suggested-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



