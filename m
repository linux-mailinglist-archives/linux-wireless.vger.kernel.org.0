Return-Path: <linux-wireless+bounces-26488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906EFB2EC87
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 06:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B3A7BF023
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 04:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0382469D;
	Thu, 21 Aug 2025 04:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PMi0jtq1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137C2111A8;
	Thu, 21 Aug 2025 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748911; cv=none; b=rVHFhhQkuyqSMmd3ZSNx2KH8eJMb1Nc+lR/BAGIrYTmHNFsqJAoxE8awR6oRjtlkVMZf+1nIDOV7hFR+3VfKouzVRjeQs1FtTkf7G7VvwL0GxlFD1ZtBGM+dz1/jZy+KMKt0QekNbafaR4rpN//aNT0AiFm4CVuNidaed6C7SHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748911; c=relaxed/simple;
	bh=hq6BmYJKUGrsbZPK4lPRsFbIo7hndZQGkUXL3NsnNTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DYzrhvBF7Zbz/vYUAFYY5kR4Vua/ycCY6uXj00obzwO8tvtiKv1hBFhepEEuaK04TLuyjmlBEIGpFq/Bdt1D4dUPVZB4fJZKmvqnSBpQi81WI/EZwTFCrHWT38uNJ/+Ok7dVj1frSPqERUiO1iLKvw/rD0ylhOIZkBxAT+zACYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PMi0jtq1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57L41LpQ41400304, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755748881; bh=uR/6QHusaHtBAfpIVj55/WMIiB+GPeYFJmtAnm//QFo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PMi0jtq1KlrqxxiXPTBRYsbe07EV96KjwoJY6BsYQU4vmkt0F/dCEMIp+KVKCcFir
	 tZbaNKRTSwwtFKeBYDVSAQn0bAB1smK02r9uUKp4D+v/InVbnijeu3BKBSukT8C1OH
	 +bjd7ZBW7Vx0LXb+Z5T4/TC8mmbVCLrBL4n+PL2fc75nxPo75NEX8oUyrVyYCOVVlm
	 L5ps27tSMDqFrBSAL2H0YvRAVctM0qNFdLAfjRdMt0222sABduwsSxW5RP9t1jnqIP
	 lEYpF2bGFa8uM2sjW44Rt0sV9VcN72Z5ftZE7JJfXxw+X+h9B/HCxpjvbh1ltqaV9N
	 BTaUit6jVrnvA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57L41LpQ41400304
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 12:01:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 21 Aug 2025 12:01:21 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 21 Aug 2025 12:01:21 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d]) by
 RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d%2]) with mapi id
 15.01.2507.035; Thu, 21 Aug 2025 12:01:21 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Ping-Ke Shih <pkshih@realtek.com>
CC: Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/2] wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
Thread-Topic: [PATCH rtw-next 1/2] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()
Thread-Index: AQHcEd2TXgTNv1RIp0yyOkAvjkku2rRsb/bQ
Date: Thu, 21 Aug 2025 04:01:21 +0000
Message-ID: <b4ec58864e544b0295ddb02ed408199b@realtek.com>
References: <20250820141441.106156-1-pchelkin@ispras.ru>
 <20250820141441.106156-2-pchelkin@ispras.ru>
In-Reply-To: <20250820141441.106156-2-pchelkin@ispras.ru>
Accept-Language: zh-TW, en-US
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
>=20
> There is a bug observed when rtw89_core_tx_kick_off_and_wait() tries to a=
ccess already
> freed skb_data:
>=20
>  BUG: KFENCE: use-after-free write in rtw89_core_tx_kick_off_and_wait
> drivers/net/wireless/realtek/rtw89/core.c:1110
>=20
>  CPU: 6 UID: 0 PID: 41377 Comm: kworker/u64:24 Not tainted  6.17.0-rc1+ #=
1 PREEMPT(lazy)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS edk2-20250523=
-14.fc42
> 05/23/2025
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
>  process_one_work kernel/workqueue.c:3241  worker_thread kernel/workqueue=
.c:3400
> kthread kernel/kthread.c:463  ret_from_fork arch/x86/kernel/process.c:154
> ret_from_fork_asm arch/x86/entry/entry_64.S:258
>=20
>  kfence-#251: 0x0000000056e2393d-0x000000009943cb62, size=3D232,
> cache=3Dskbuff_head_cache
>=20
>  allocated by task 41377 on cpu 6 at 77869.159548s (0.009551s ago):
>  __alloc_skb net/core/skbuff.c:659
>  __netdev_alloc_skb net/core/skbuff.c:734  ieee80211_nullfunc_get
> net/mac80211/tx.c:5844  rtw89_core_send_nullfunc
> drivers/net/wireless/realtek/rtw89/core.c:3431
>  rtw89_core_scan_complete drivers/net/wireless/realtek/rtw89/core.c:5338
>  rtw89_hw_scan_complete_cb drivers/net/wireless/realtek/rtw89/fw.c:7979
>  rtw89_chanctx_proceed_cb drivers/net/wireless/realtek/rtw89/chan.c:3165
>  rtw89_chanctx_proceed drivers/net/wireless/realtek/rtw89/chan.c:3194
>  rtw89_hw_scan_complete drivers/net/wireless/realtek/rtw89/fw.c:8012
>  rtw89_mac_c2h_scanofld_rsp drivers/net/wireless/realtek/rtw89/mac.c:5059
>  rtw89_fw_c2h_work drivers/net/wireless/realtek/rtw89/fw.c:6758
>  process_one_work kernel/workqueue.c:3241  worker_thread kernel/workqueue=
.c:3400
> kthread kernel/kthread.c:463  ret_from_fork arch/x86/kernel/process.c:154
> ret_from_fork_asm arch/x86/entry/entry_64.S:258
>=20
>  freed by task 1045 on cpu 9 at 77869.168393s (0.001557s ago):
>  ieee80211_tx_status_skb net/mac80211/status.c:1117  rtw89_pci_release_tx=
wd_skb
> drivers/net/wireless/realtek/rtw89/pci.c:564
>  rtw89_pci_release_tx_skbs.isra.0 drivers/net/wireless/realtek/rtw89/pci.=
c:651
>  rtw89_pci_release_tx drivers/net/wireless/realtek/rtw89/pci.c:676
>  rtw89_pci_napi_poll drivers/net/wireless/realtek/rtw89/pci.c:4238
>  __napi_poll net/core/dev.c:7495
>  net_rx_action net/core/dev.c:7557 net/core/dev.c:7684  handle_softirqs
> kernel/softirq.c:580
>  do_softirq.part.0 kernel/softirq.c:480
>  __local_bh_enable_ip kernel/softirq.c:407  rtw89_pci_interrupt_threadfn
> drivers/net/wireless/realtek/rtw89/pci.c:927
>  irq_thread_fn kernel/irq/manage.c:1133
>  irq_thread kernel/irq/manage.c:1257
>  kthread kernel/kthread.c:463
>  ret_from_fork arch/x86/kernel/process.c:154  ret_from_fork_asm
> arch/x86/entry/entry_64.S:258
>=20
> It is a consequence of a race between the waiting and the signalling side=
 of the completion:
>=20
>             Thread 1                                    Thread 2
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
>=20
> complete(&wait->completion)
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
> The signalling side might proceed and free the underlying skb even before=
 the waiting side is
> fully awoken and run to execution.
>=20
> RCU synchronization here would work well if the signalling side didn't go=
 on and release skb
> on its own.  Thus the waiting side should be told somehow about what is h=
appening on the
> completion side.

I reread the flow and am thinking about it a bit.
Actually, only when signaling side doesn't run on time, waiting side should=
 update skb_data->wait.
(see code comments below)

>=20
> It seems the only correct way is to use standard locking primitives with =
owner tracking, like
> was originally published in one [1] of the versions of the patch mentione=
d in Fixes.
>=20
> [1]: https://lore.kernel.org/linux-wireless/20230404025259.15503-3-pkshih=
@realtek.com/
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Fixes: 1ae5ca615285 ("wifi: rtw89: add function to wait for completion of=
 TX skbs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>=20
> The bug is tricky because the waiter-completer interaction isn't simple h=
ere.  I've tried to
> come up with something that wouldn't require taking additional locks at
> rtw89_core_tx_wait_complete() but these ideas don't eliminate the possibl=
e race entirely, to
> my mind.

Thank you for finding the potential race condition.

>=20
> Though one solution that _works_ currently is to get rid of 'struct rtw89=
_tx_wait_info' and
> replace it with the only field it is used for - 'bool tx_done'.  Then it =
can be stored at 'struct
> ieee80211_tx_info::status::status_driver_data' directly without the need =
for allocating an
> extra dynamic object and tracking its lifecycle.
> I didn't post this since then the structure won't be expandable for new f=
ields and that's
> probably the reason for why it wasn't done in this manner initially.

With a busy waiting on tx waiting side ?
If so, it would be unacceptable.

>=20
>  drivers/net/wireless/realtek/rtw89/core.c | 15 ++++++++---
> drivers/net/wireless/realtek/rtw89/core.h | 32 ++++++++++++++---------
> drivers/net/wireless/realtek/rtw89/pci.c  |  6 +++--
>  3 files changed, 36 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c
> b/drivers/net/wireless/realtek/rtw89/core.c
> index 57590f5577a3..826540319027 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1088,6 +1088,7 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_de=
v *rtwdev,
> struct sk_buff *sk
>         struct rtw89_tx_skb_data *skb_data =3D RTW89_TX_SKB_CB(skb);
>         struct rtw89_tx_wait_info *wait;
>         unsigned long time_left;
> +       bool free_wait =3D true;
>         int ret =3D 0;
>=20
>         wait =3D kzalloc(sizeof(*wait), GFP_KERNEL); @@ -1097,7 +1098,8 @=
@ int
> rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff =
*sk
>         }
>=20
>         init_completion(&wait->completion);
> -       rcu_assign_pointer(skb_data->wait, wait);
> +       spin_lock_init(&wait->owner_lock);
> +       skb_data->wait =3D wait;
>=20
>         rtw89_core_tx_kick_off(rtwdev, qsel);
>         time_left =3D wait_for_completion_timeout(&wait->completion,
> @@ -1107,8 +1109,15 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_d=
ev *rtwdev,
> struct sk_buff *sk
>         else if (!wait->tx_done)
>                 ret =3D -EAGAIN;
>=20
> -       rcu_assign_pointer(skb_data->wait, NULL);
> -       kfree_rcu(wait, rcu_head);

Please consider the following.
(moving "rcu_assign_pointer(skb_data->wait, NULL)" to be under "if (time_le=
ft =3D=3D 0)")

    if (time_left =3D=3D 0) {
        rcu_assign_pointer(skb_data->wait, NULL);
        ret =3D -ETIMEDOUT;
    } else if (!wait->tx_done) {
        ret =3D -EAGAIN;
    }

    kfree_rcu(wait, rcu_head);

If completing side does run as expected (potential racing mentioned in this=
 patch),
there is no real need to assign NULL back.

