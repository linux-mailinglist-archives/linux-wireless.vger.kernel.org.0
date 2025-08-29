Return-Path: <linux-wireless+bounces-26860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA33BB3B48D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 09:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51ED1628BE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 07:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3F27A919;
	Fri, 29 Aug 2025 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kafFjXWO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809F2512FF;
	Fri, 29 Aug 2025 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453377; cv=none; b=AH2QgxvLW0/G7/3xglI1iyqhK2pnir7FkTnGvvu8c98yQ840/YDnCX7WIyoaoEZ1rqbj415LWuZhZ1T/YohnQ6NKqUtUGcuhNcZpE6r2cPv5l3A6SVDDAzUowWuPeH2DCHARn0kJZCYqMj3BbnqxuodVBGJ9TJvlBASTlMUb6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453377; c=relaxed/simple;
	bh=omYshunl/47Gmx45LOuWHou/w14wi6yGwePU8pTUXXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hQmWWY/D2jmSdQ5JqggRAGMb+U7e8Pni61fO1Yux9j8o2Yd/WaB3Ef0njbg0o8ny1ximV4L0xDctiDoZw/0pXQQoIoL025dMdAO/xlNZ9fvGKBnLZzjKwfB9AyKTDjBJXGiLtbQuw5BwMcej8Xyqa5c6LL+H1Vek/KBI/fO/+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kafFjXWO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57T7gUqfD3210887, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756453350; bh=lEo2hn+/tSFkkavImGYN8OD5Nrb32sJmXvWcsjUEj4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kafFjXWO8R2c9qAnf3ZxDBDHoUipYnsvSpleM7TvI4RW84JFnz7/s5agbJrKi6JJ3
	 3R3XH1oa4guKV5if+qn+6X5vMTSyCiAv+1xVrTNLT5mq2vIqYBg5uSW7OWRvFdiXPI
	 L1tfAGAU6E/rB511slSO8T79U0Jyq7PL7UEBC+Vjxgn9hged40feE0Fc96qQVhVWeZ
	 NoXYOfo6eE0eluk1f4yWxPP/pYs/oD/X0D/+TpWPSldBMloaD/9gb5thoMegw4CL6G
	 R9yaaORzUoaOcYAgRMUfgcDNyXVmBoDtn9CsoXAvdvHCe2abbN8b3sdmouOmffJXuP
	 UTaCt7Z8z9Blg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57T7gUqfD3210887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 15:42:30 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 15:42:30 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 15:42:30 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d]) by
 RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d%2]) with mapi id
 15.01.2507.035; Fri, 29 Aug 2025 15:42:30 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: "pchelkin@ispras.ru" <pchelkin@ispras.ru>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC: Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rtw v3 1/5] wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
Thread-Topic: [PATCH rtw v3 1/5] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()
Thread-Index: AQHcGJfyqL1ue2mRp02bzGzCJpb+JrR4uaTA
Date: Fri, 29 Aug 2025 07:42:29 +0000
Message-ID: <7725eefdd48e4ebba4711d369feaa14c@realtek.com>
References: <20250828211245.178843-2-pchelkin@ispras.ru>
In-Reply-To: <20250828211245.178843-2-pchelkin@ispras.ru>
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
> v3: - decrease waiting timeout in rtw89_tx_wait_work() (Zong-Zhe)
>     - clear tx_waits list from rtw89_hci_reset(), too (Zong-Zhe)
>     - keep RCU updating for skb_data->wait (Zong-Zhe)
>     - keep the old order of calls in rtw89_pci_tx_status() (Zong-Zhe)
>     - drop wait->finished as complete_all() would make the completion be
>       done permanently (me)
>=20
> v2: - use a work function to manage release of tx_waits and associated sk=
bs (Zong-Zhe)
>=20
>=20
> FWIW, I think RCU locking becomes unnecessary after the next patch [PATCH=
 rtw v3 2/5] wifi:
> rtw89: fix tx_wait initialization race but let's keep it if you feel that=
's more safe.
>=20

Thanks. My thoughts are simple.
1. If it doesn't lead to bugs (i.e. not really necessary changes), keep it.
2. Keeping RCU gives us some room, if someday somehow we need to extend flo=
w.
    Otherwise, we need to add it back again at that time.
3. Keep free side safe (kfree_rcu(@wait)) and doesn't depend on how complet=
e() or
    wait_for_completion*() are implemented. (where completion is in @wait)

(If I change my mind after reading [PATCH v3 2/5], I will send my new comme=
nts.)

>=20
>  drivers/net/wireless/realtek/rtw89/core.c | 28 ++++++++++++++---
> drivers/net/wireless/realtek/rtw89/core.h | 38 +++++++++++++++++++++--
> drivers/net/wireless/realtek/rtw89/pci.c  |  3 +-  drivers/net/wireless/r=
ealtek/rtw89/ser.c
> |  2 ++
>  4 files changed, 63 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c
> b/drivers/net/wireless/realtek/rtw89/core.c
> index 57590f5577a3..5c964283cd67 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1073,6 +1073,14 @@ rtw89_core_tx_update_desc_info(struct rtw89_dev *r=
twdev,
>  	}
>  }
>=20
> +static void rtw89_tx_wait_work(struct wiphy *wiphy, struct wiphy_work
> +*work) {
> +	struct rtw89_dev *rtwdev =3D container_of(work, struct rtw89_dev,
> +						tx_wait_work);
> +
> +	rtw89_tx_wait_list_clear(rtwdev);
> +}
> +
>  void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel)  {
>  	u8 ch_dma;
> @@ -1090,6 +1098,8 @@ int rtw89_core_tx_kick_off_and_wait(struct rtw89_de=
v *rtwdev,
> struct sk_buff *sk
>  	unsigned long time_left;
>  	int ret =3D 0;
>=20
> +	lockdep_assert_wiphy(rtwdev->hw->wiphy);
> +
>  	wait =3D kzalloc(sizeof(*wait), GFP_KERNEL);
>  	if (!wait) {
>  		rtw89_core_tx_kick_off(rtwdev, qsel); @@ -1098,17 +1108,22 @@ int
> rtw89_core_tx_kick_off_and_wait(struct rtw89_dev *rtwdev, struct sk_buff =
*sk
>=20
>  	init_completion(&wait->completion);
>  	rcu_assign_pointer(skb_data->wait, wait);
> +	wait->skb =3D skb;
>=20

Generally, fill wait's fields before publishing it.
(i.e. before rcu_assign_pointer(...))

>  	rtw89_core_tx_kick_off(rtwdev, qsel);
>  	time_left =3D wait_for_completion_timeout(&wait->completion,
>  						msecs_to_jiffies(timeout));
> -	if (time_left =3D=3D 0)
> +
> +	if (time_left =3D=3D 0) {
>  		ret =3D -ETIMEDOUT;
> -	else if (!wait->tx_done)
> -		ret =3D -EAGAIN;
> +		list_add_tail(&wait->list, &rtwdev->tx_waits);
> +		wiphy_work_queue(rtwdev->hw->wiphy, &rtwdev->tx_wait_work);
>=20
> -	rcu_assign_pointer(skb_data->wait, NULL);
> -	kfree_rcu(wait, rcu_head);
> +	} else {
> +		if (!wait->tx_done)
> +			ret =3D -EAGAIN;
> +		rtw89_tx_wait_release(&wait->rcu_head);
> +	}
>=20
>  	return ret;
>  }
> @@ -4972,6 +4987,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
>  	clear_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
>=20
>  	wiphy_work_cancel(wiphy, &rtwdev->c2h_work);
> +	wiphy_work_cancel(wiphy, &rtwdev->tx_wait_work);
>  	wiphy_work_cancel(wiphy, &rtwdev->cancel_6ghz_probe_work);
>  	wiphy_work_cancel(wiphy, &btc->eapol_notify_work);
>  	wiphy_work_cancel(wiphy, &btc->arp_notify_work); @@ -5203,6 +5219,7 @@ =
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
> @@ -5233,6 +5250,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
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
> index 43e10278e14d..9b22bb116af9 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -3506,9 +3506,12 @@ struct rtw89_phy_rate_pattern {
>  	bool enable;
>  };
>=20
> +#define RTW89_TX_WAIT_DEFAULT_TIMEOUT 10
>  struct rtw89_tx_wait_info {
>  	struct rcu_head rcu_head;
> +	struct list_head list;
>  	struct completion completion;
> +	struct sk_buff *skb;
>  	bool tx_done;
>  };
>=20
> @@ -5925,6 +5928,9 @@ struct rtw89_dev {
>  	/* used to protect rpwm */
>  	spinlock_t rpwm_lock;
>=20
> +	struct list_head tx_waits;
> +	struct wiphy_work tx_wait_work;
> +
>  	struct rtw89_cam_info cam_info;
>=20
>  	struct sk_buff_head c2h_queue;
> @@ -6181,6 +6187,30 @@ rtw89_assoc_link_rcu_dereference(struct rtw89_dev =
*rtwdev, u8
> macid)
>  	list_first_entry_or_null(&p->dlink_pool, typeof(*p->links_inst), dlink_=
schd); \
>  })
>=20
> +static inline void rtw89_tx_wait_release(struct rcu_head *rcu_head) {
> +	struct rtw89_tx_wait_info *wait =3D
> +		container_of(rcu_head, struct rtw89_tx_wait_info, rcu_head);
> +
> +	dev_kfree_skb_any(wait->skb);
> +	kfree(wait);
> +}
> +
> +static inline void rtw89_tx_wait_list_clear(struct rtw89_dev *rtwdev) {
> +	struct rtw89_tx_wait_info *wait, *tmp;
> +
> +	lockdep_assert_wiphy(rtwdev->hw->wiphy);
> +
> +	list_for_each_entry_safe(wait, tmp, &rtwdev->tx_waits, list) {
> +		if (!wait_for_completion_timeout(&wait->completion,
> +						 RTW89_TX_WAIT_DEFAULT_TIMEOUT))
> +			continue;
> +		list_del(&wait->list);
> +		call_rcu(&wait->rcu_head, rtw89_tx_wait_release);
> +	}
> +}
> +

I feel dev_kfree_skb_any + kfree_rcu is fine at least for now.

For call_rcu, there is one problem to me.
Can rtw89_tx_wait_release be invoked after rmmod ?
e.g. one tx is never completed yet unfortunately -> user rmmod driver
    -> release pending skb -> rtw89_tx_wait_list_clear -> ...

So, how about the follow-up ?

    rtw89_tx_wait_release(struct rtw89_tx_wait_info *wait):
        dev_kfree_skb_any(wait->skb)
        kfree_rcu(wait)

    rtw89_tx_wait_list_clear(...):
        ...
        for each wait in list:
            ...
            list_del
            rtw89_tx_wait_release(wait)

>  static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,
>  				     struct rtw89_core_tx_request *tx_req)  { @@ -6190,6 +6220,7
> @@ static inline int rtw89_hci_tx_write(struct rtw89_dev *rtwdev,  static=
 inline void
> rtw89_hci_reset(struct rtw89_dev *rtwdev)  {
>  	rtwdev->hci.ops->reset(rtwdev);
> +	rtw89_tx_wait_list_clear(rtwdev);
>  }
>=20
>  static inline int rtw89_hci_start(struct rtw89_dev *rtwdev) @@ -7258,11 =
+7289,12 @@
> static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rt=
wdev,
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
> +	bool ret =3D false;
>=20
>  	rcu_read_lock();
>=20
> @@ -7270,11 +7302,13 @@ static inline void rtw89_core_tx_wait_complete(st=
ruct
> rtw89_dev *rtwdev,
>  	if (!wait)
>  		goto out;
>=20
> +	ret =3D true;
>  	wait->tx_done =3D tx_done;
> -	complete(&wait->completion);
> +	complete_all(&wait->completion);
>=20

Maybe add a comment to hint.
For example, /* Don't access skb anymore after completing */

>  out:
>  	rcu_read_unlock();
> +	return ret;
>  }
>=20
>  static inline bool rtw89_is_mlo_1_1(struct rtw89_dev *rtwdev) diff --git
> a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek=
/rtw89/pci.c
> index a669f2f843aa..4e3034b44f56 100644
> --- a/drivers/net/wireless/realtek/rtw89/pci.c
> +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> @@ -464,7 +464,8 @@ static void rtw89_pci_tx_status(struct rtw89_dev *rtw=
dev,
>  	struct rtw89_tx_skb_data *skb_data =3D RTW89_TX_SKB_CB(skb);
>  	struct ieee80211_tx_info *info;
>=20
> -	rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status =3D=3D RTW89_TX=
_DONE);
> +	if (rtw89_core_tx_wait_complete(rtwdev, skb_data, tx_status =3D=3D RTW8=
9_TX_DONE))
> +		return;
>=20
>  	info =3D IEEE80211_SKB_CB(skb);
>  	ieee80211_tx_info_clear_status(info);
> diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wirel=
ess/realtek/rtw89/ser.c
> index bb39fdbcba0d..fe7beff8c424 100644
> --- a/drivers/net/wireless/realtek/rtw89/ser.c
> +++ b/drivers/net/wireless/realtek/rtw89/ser.c
> @@ -502,7 +502,9 @@ static void ser_reset_trx_st_hdl(struct rtw89_ser *se=
r, u8 evt)
>  		}
>=20
>  		drv_stop_rx(ser);
> +		wiphy_lock(wiphy);
>  		drv_trx_reset(ser);
> +		wiphy_unlock(wiphy);
>=20
>  		/* wait m3 */
>  		hal_send_m2_event(ser);
> --
> 2.51.0


