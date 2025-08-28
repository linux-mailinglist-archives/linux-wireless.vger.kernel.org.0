Return-Path: <linux-wireless+bounces-26727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C168B39639
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF78462228
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6144F283C90;
	Thu, 28 Aug 2025 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RstMqYs3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E52D7801;
	Thu, 28 Aug 2025 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368478; cv=none; b=bIU5r9GH65s7IX8F5janyEKv7LFDpvy4F66iLMXYZtZ+al6dd7Cxe8y3XpH8vYhQ3bRlsWquobhD7uLSAWyht/S9GpWcxlZrLo43HPPbMi4unX2u+DdvTID1YRPcxfkqyUeuEXsa+Fl2J4yXbmZdozYKEEIp2I6ZWbz/LDRLTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368478; c=relaxed/simple;
	bh=dSgFH52W1Wp5go3fx/XlIZBS2GEY67YrkqYA70jmFqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IItbI07L10hRREiELfjukfCEiDHO7P2R5SfYOEpRSBg3HN+/zpn//uNaxtGb4huiWhG5UARQh9bP45/qA17l12KEa3hwFaLOOKDHRtmLkdmJ+XVXgmOMuGfJ2zvbF6EWqIGyOYzrIF4/2L73U7raFnPlweCUzq1LOLcsxsxSGZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RstMqYs3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57S87UNj81334954, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756368451; bh=xLPnaPnz+J9oPl4NL8YGGtvhgUSFRZNSIyOOEWj5DJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RstMqYs3yQX9i+4EcIhp77xFqIOlaVSVG0rgqhzEv8aeo6JQC9jBhxVVVY2FZ6LEK
	 JT8Inr8qdnD9uPHDGu08cicjJG6JN1VVlFPKysQnxg5NyiWyA9Ei90CUhAisOp56pm
	 ihzO3wlFLGmgpXI2K4foHaxeFcIh5p/v/+SnEa/cBHUao6vBVcONdbhZ3W598mHL/X
	 W43x0JFbztJO+xMocXWFPYLsT/8UBEdB4etxAjG7Ka329KRS+9h6cng+IOkE8Ec4Dt
	 avZYh2ls582F2Qo7tRHB9tYc9+gd3nFtL8qBO5amnhZIFFy8sdy3XX3auO8LJo33hp
	 0loCg66FWDOvQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57S87UNj81334954
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 16:07:31 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 28 Aug 2025 16:07:29 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 28 Aug 2025 16:07:28 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d]) by
 RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d%2]) with mapi id
 15.01.2507.035; Thu, 28 Aug 2025 16:07:28 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: "pchelkin@ispras.ru" <pchelkin@ispras.ru>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Zong-Zhe Yang <kevin_yang@realtek.com>
CC: Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rtw v2 1/4] wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
Thread-Topic: [PATCH rtw v2 1/4] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()
Thread-Index: AQHcF8icTIlJtwQk2kOn9fej8NWkdbR3L+cQ
Date: Thu, 28 Aug 2025 08:07:28 +0000
Message-ID: <87693651fe394065b421d8d8fe171f89@realtek.com>
References: <20250827120603.723548-2-pchelkin@ispras.ru>
In-Reply-To: <20250827120603.723548-2-pchelkin@ispras.ru>
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
> It is a consequence of a race between the waiting and the signaling side =
of the completion:
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
> The completing side might proceed and free the underlying skb even before=
 the waiting side
> is fully awoken and run to execution.  Actually the race happens regardle=
ss of
> wait_for_completion_timeout() exit status, e.g.
> the waiting side may hit a timeout and the concurrent completing side is =
still able to free the
> skb.
>=20
> Skbs which are sent by rtw89_core_tx_kick_off_and_wait() are owned by the=
 driver.  They
> don't come from core ieee80211 stack so no need to pass them to ieee80211=
_tx_status_ni()
> on completing side.
>=20
> Introduce a work function which will act as a garbage collector for rtw89=
_tx_wait_info objects
> and the associated skbs.  Thus no potentially heavy locks are required on=
 the completing
> side.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Fixes: 1ae5ca615285 ("wifi: rtw89: add function to wait for completion of=
 TX skbs")
> Cc: stable@vger.kernel.org
> Suggested-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>=20
> v2: use a work function to manage release of tx_waits and associated skbs=
 (Zong-Zhe)
>=20
> The interesting part is how rtw89_tx_wait_work() should wait for completi=
on - based on
> timeout or without it, or just check status with a call to completion_don=
e().
>=20

I like "wait for timeout" as what you have done, but maybe using a smaller =
timeout.
Completing side might not be in order, so don't take too much time on uncom=
pleted
ones when going through list.

> Simply waiting with wait_for_completion() may become a bottleneck if for =
any reason the
> completion is delayed significantly, and we are holding a wiphy lock here=
.  I _suspect_
> rtw89_pci_tx_status() should be called either by napi polling handler or =
in other cases e.g. by
> rtw89_hci_reset() but it's hard to deduce for any possible scenario that =
it will be called in
> some time.
>=20

When rtw89_hci_reset() is called, all pending skb should be released.
(it means completing side will be done)
So, we can call a func (directly) as rtw89_tx_wait_work() does there.

> Anyway, the current and the next patch try to make sure that when
> rtw89_core_tx_wait_complete() is called, skbdata->wait is properly initia=
lized so that there
> should be no buggy situations when tx_wait skb is not recognized and inva=
lidly passed to
> ieee80211 stack, also without signaling a completion.
>=20
> If rtw89_core_tx_wait_complete() is not called at all, this should indica=
te a bug elsewhere.
>=20
>  drivers/net/wireless/realtek/rtw89/core.c | 42 +++++++++++++++++++----
> drivers/net/wireless/realtek/rtw89/core.h | 22 +++++++-----
> drivers/net/wireless/realtek/rtw89/pci.c  |  9 ++---
>  3 files changed, 54 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c
> b/drivers/net/wireless/realtek/rtw89/core.c
> index 57590f5577a3..48aa02d6abd4 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1073,6 +1073,26 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *r=
twdev,
>  	}
>  }
>=20
> +static void rtw89_tx_wait_work(struct wiphy *wiphy, struct wiphy_work
> +*work) {
> +	struct rtw89_dev *rtwdev =3D container_of(work, struct rtw89_dev,
> +						tx_wait_work);
> +	struct rtw89_tx_wait_info *wait, *tmp;
> +
> +	lockdep_assert_wiphy(wiphy);
> +
> +	list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) {
> +		if (!wait->finished) {
> +			unsigned long tmo =3D msecs_to_jiffies(wait->timeout);
> +			if (!wait_for_completion_timeout(&wait->completion, tmo))
> +				continue;
> +		}
> +		list_del(&wait->list);
> +		dev_kfree_skb_any(wait->skb);
> +		kfree(wait);
> +	}
> +}
> +

A func (not work_fn look) for rtw89_hci_reset to call directly.
And consider to use a smaller timeout.

>  void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)  {
>  	u8 ch_dma;
> @@ -1090,6 +1110,8 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_de=
v *rtwdev,
> struct sk_buff *sk
>  	unsigned long time_left;
>  	int ret =3D 0;
>=20
> +	lockdep_assert_wiphy(rtwdev->hw->wiphy);
> +
>  	wait =3D kzalloc(sizeof(*wait), GFP_KERNEL);
>  	if (!wait) {
>  		rtw89_core_tx_kick_off(rtwdev, qsel); @@ -1097,18 +1119,23 @@ int
> rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff =
*sk
>  	}
>=20
>  	init_completion(&wait->completion);
> -	rcu_assign_pointer(skb_data->wait, wait);
> +	skb_data->wait =3D wait;

(completing/waiting side are lockfree in different context, and can be diff=
erent CPU)
So, please keep RCU access to avoid potential problems.
And, keep using kfree_rcu(wait) to ensure freeing time is suitable.

>=20
>  	rtw89_core_tx_kick_off(rtwdev, qsel);
>  	time_left =3D wait_for_completion_timeout(&wait->completion,
>  						msecs_to_jiffies(timeout));
> -	if (time_left =3D=3D 0)
> +	if (time_left =3D=3D 0) {
>  		ret =3D -ETIMEDOUT;
> -	else if (!wait->tx_done)
> -		ret =3D -EAGAIN;
> +	} else {
> +		wait->finished =3D true;
> +		if (!wait->tx_done)
> +			ret =3D -EAGAIN;
> +	}
>=20
> -	rcu_assign_pointer(skb_data->wait, NULL);
> -	kfree_rcu(wait, rcu_head);
> +	wait->skb =3D skb;
> +	wait->timeout =3D timeout;
> +	list_add_tail(&wait->list, &rtwdev->tx_waits);
> +	wiphy_work_queue(rtwdev->hw->wiphy, &rtwdev->tx_wait_work);
>=20

If completed (i.e. time_left !=3D 0), free them directly without queuing wo=
rk.
Reduce the chance to do list/work things.

>  	return ret;
>  }
> @@ -4972,6 +4999,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
>  	clear_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
>=20
>  	wiphy_work_cancel(wiphy, &rtwdev->c2h_work);
> +	wiphy_work_cancel(wiphy, &rtwdev->tx_wait_work);
>  	wiphy_work_cancel(wiphy, &rtwdev->cancel_6ghz_probe_work);
>  	wiphy_work_cancel(wiphy, &btc->eapol_notify_work);
>  	wiphy_work_cancel(wiphy, &btc->arp_notify_work); @@ -5203,6 +5231,7 @@ =
int
> rtw89_core_init(struct rtw89_dev *rtwdev)
>  		INIT_LIST_HEAD(&rtwdev->scan_info.pkt_list[band]);
>  	}
>  	INIT_LIST_HEAD(&rtwdev->scan_info.chan_list);
> +	INIT_LIST_HEAD(&rtwdev->tx_waits);
>  	INIT_WORK(&rtwdev->ba_work, rtw89_core_ba_work);
>  	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
>  	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_w=
ork);
> @@ -5233,6 +5262,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
>  	wiphy_work_init(&rtwdev->c2h_work, rtw89_fw_c2h_work);
>  	wiphy_work_init(&rtwdev->ips_work, rtw89_ips_work);
>  	wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6ghz_prob=
e_work);
> +	wiphy_work_init(&rtwdev->tx_wait_work, rtw89_tx_wait_work);
>  	INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
>=20
>  	skb_queue_head_init(&rtwdev->c2h_queue);
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h
> b/drivers/net/wireless/realtek/rtw89/core.h
> index 43e10278e14d..06f7d82a8d18 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -3508,12 +3508,16 @@ struct rtw89_phy_rate_pattern {
>=20
>  struct rtw89_tx_wait_info {
>  	struct rcu_head rcu_head;
> +	struct list_head list;
>  	struct completion completion;
> +	struct sk_buff *skb;
> +	unsigned int timeout;
>  	bool tx_done;
> +	bool finished;
>  };
>=20
>  struct rtw89_tx_skb_data {
> -	struct rtw89_tx_wait_info __rcu *wait;
> +	struct rtw89_tx_wait_info *wait;
>  	u8 hci_priv[];
>  };

As mentioned above, I would like to keep rcu.

>=20
> @@ -5925,6 +5929,9 @@ struct rtw89_dev {
>  	/* used to protect rpwm */
>  	spinlock_t rpwm_lock;
>=20
> +	struct list_head tx_waits;
> +	struct wiphy_work tx_wait_work;
> +
>  	struct rtw89_cam_info cam_info;
>=20
>  	struct sk_buff_head c2h_queue;
> @@ -7258,23 +7265,20 @@ static inline struct sk_buff *rtw89_alloc_skb_for=
_rx(struct
> rtw89_dev *rtwdev,
>  	return dev_alloc_skb(length);
>  }
>=20
> -static inline void rtw89_core_tx_wait_complete(struct rtw89_dev *rtwdev,
> +static inline bool rtw89_core_tx_wait_complete(struct rtw89_dev
> +*rtwdev,
>  					       struct rtw89_tx_skb_data *skb_data,
>  					       bool tx_done)
>  {
>  	struct rtw89_tx_wait_info *wait;
>=20
> -	rcu_read_lock();
> -
> -	wait =3D rcu_dereference(skb_data->wait);
> +	wait =3D skb_data->wait;
>  	if (!wait)
> -		goto out;
> +		return false;
>=20
>  	wait->tx_done =3D tx_done;
> -	complete(&wait->completion);
> +	complete_all(&wait->completion);
>=20
> -out:
> -	rcu_read_unlock();
> +	return true;
>  }
>=20
>  static inline bool rtw89_is_mlo_1_1(struct rtw89_dev *rtwdev) diff --git
> a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek=
/rtw89/pci.c
> index a669f2f843aa..6356c2c224c5 100644
> --- a/drivers/net/wireless/realtek/rtw89/pci.c
> +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> @@ -464,10 +464,7 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rt=
wdev,
>  	struct rtw89_tx_skb_data *skb_data =3D RTW89_TX_SKB_CB(skb);
>  	struct ieee80211_tx_info *info;
>=20
> -	rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status =3D=3D RTW89_TX=
_DONE);
> -
>  	info =3D IEEE80211_SKB_CB(skb);
> -	ieee80211_tx_info_clear_status(info);
>=20
>  	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
>  		info->flags |=3D IEEE80211_TX_STAT_NOACK_TRANSMITTED;
> @@ -494,6 +491,10 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rt=
wdev,
>  		}
>  	}
>=20
> +	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status =3D=3D RTW8=
9_TX_DONE))
> +		return;
> +
> +	ieee80211_tx_info_clear_status(info);

Don't change order of these calls.
(it's wrong for normal pkt because their tx_info are cleared after filled)

>  	ieee80211_tx_status_ni(rtwdev->hw, skb);  }
>=20
> @@ -1387,7 +1388,7 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *=
rtwdev,
>  	}
>=20
>  	tx_data->dma =3D dma;
> -	rcu_assign_pointer(skb_data->wait, NULL);
> +	skb_data->wait =3D NULL;
>=20
>  	txwp_len =3D sizeof(*txwp_info);
>  	txwd_len =3D chip->txwd_body_size;
> --
> 2.50.1

