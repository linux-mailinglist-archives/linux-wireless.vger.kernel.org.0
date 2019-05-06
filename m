Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9314441
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 07:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfEFFWO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 01:22:14 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50004 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfEFFWO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 01:22:14 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x465M5xJ030057, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x465M5xJ030057
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 6 May 2019 13:22:06 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Mon, 6 May 2019
 13:22:04 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: avoid circular locking between local->iflist_mtx and rtwdev->mutex
Thread-Topic: [PATCH] rtw88: avoid circular locking between
 local->iflist_mtx and rtwdev->mutex
Thread-Index: AQHVAavSE33vtHf7Yk65ASXHYPVDmKZdk6RQ
Date:   Mon, 6 May 2019 05:22:03 +0000
Message-ID: <F7CD281DE3E379468C6D07993EA72F84D17EB119@RTITMBSVM04.realtek.com.tw>
References: <1556886547-23632-1-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1556886547-23632-1-git-send-email-sgruszka@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Subject: [PATCH] rtw88: avoid circular locking between local->iflist_mtx and
> rtwdev->mutex
> 
> Remove circular lock dependency by using atomic version of interfaces
> iterate in watch_dog_work(), hence avoid taking local->iflist_mtx
> (rtw_vif_watch_dog_iter() only update some data, it can be called from
> atomic context). Fixes below LOCKDEP warning:
> 
> [ 1157.219415]
> ======================================================
> [ 1157.225772] [ INFO: possible circular locking dependency detected ]
> [ 1157.232150] 3.10.0-1043.el7.sgruszka1.x86_64.debug #1 Not tainted
> [ 1157.238346] -------------------------------------------------------
> [ 1157.244635] kworker/u4:2/14490 is trying to acquire lock:
> [ 1157.250194]  (&rtwdev->mutex){+.+.+.}, at: [<ffffffffc098322b>]
> rtw_ops_config+0x2b/0x90 [rtw88]
> [ 1157.259151]
> but task is already holding lock:
> [ 1157.265085]  (&local->iflist_mtx){+.+...}, at: [<ffffffffc0b8ab7a>]
> ieee80211_mgd_probe_ap.part.28+0xca/0x160 [mac80211]
> [ 1157.276169]
> which lock already depends on the new lock.
> 
> [ 1157.284488]
> the existing dependency chain (in reverse order) is:
> [ 1157.292101]
> -> #2 (&local->iflist_mtx){+.+...}:
> [ 1157.296919]        [<ffffffffbc741a29>] lock_acquire+0x99/0x1e0
> [ 1157.302955]        [<ffffffffbce72793>] mutex_lock_nested+0x93/0x410
> [ 1157.309416]        [<ffffffffc0b6038f>]
> ieee80211_iterate_interfaces+0x2f/0x60 [mac80211]
> [ 1157.317730]        [<ffffffffc09811ab>]
> rtw_watch_dog_work+0xcb/0x130 [rtw88]
> [ 1157.325003]        [<ffffffffbc6d77bc>] process_one_work+0x22c/0x720
> [ 1157.331481]        [<ffffffffbc6d7dd6>] worker_thread+0x126/0x3b0
> [ 1157.337589]        [<ffffffffbc6e107f>] kthread+0xef/0x100
> [ 1157.343260]        [<ffffffffbce848b7>]
> ret_from_fork_nospec_end+0x0/0x39
> [ 1157.350091]
> -> #1 ((&(&rtwdev->watch_dog_work)->work)){+.+...}:
> [ 1157.356314]        [<ffffffffbc741a29>] lock_acquire+0x99/0x1e0
> [ 1157.362427]        [<ffffffffbc6d570b>] flush_work+0x5b/0x310
> [ 1157.368287]        [<ffffffffbc6d740e>]
> __cancel_work_timer+0xae/0x170
> [ 1157.374940]        [<ffffffffbc6d7583>]
> cancel_delayed_work_sync+0x13/0x20
> [ 1157.381930]        [<ffffffffc0982b49>] rtw_core_stop+0x29/0x50
> [rtw88]
> [ 1157.388679]        [<ffffffffc098bee6>] rtw_enter_ips+0x16/0x20
> [rtw88]
> [ 1157.395428]        [<ffffffffc0983242>] rtw_ops_config+0x42/0x90
> [rtw88]
> [ 1157.402173]        [<ffffffffc0b13343>]
> ieee80211_hw_config+0xc3/0x680 [mac80211]
> [ 1157.409854]        [<ffffffffc0b3925b>]
> ieee80211_do_open+0x69b/0x9c0 [mac80211]
> [ 1157.417418]        [<ffffffffc0b395e9>] ieee80211_open+0x69/0x70
> [mac80211]
> [ 1157.424496]        [<ffffffffbcd03442>] __dev_open+0xe2/0x160
> [ 1157.430356]        [<ffffffffbcd03773>]
> __dev_change_flags+0xa3/0x180
> [ 1157.436922]        [<ffffffffbcd03879>] dev_change_flags+0x29/0x60
> [ 1157.443224]        [<ffffffffbcda14c4>] devinet_ioctl+0x794/0x890
> [ 1157.449331]        [<ffffffffbcda27b5>] inet_ioctl+0x75/0xa0
> [ 1157.455087]        [<ffffffffbccd54eb>] sock_do_ioctl+0x2b/0x60
> [ 1157.461178]        [<ffffffffbccd5753>] sock_ioctl+0x233/0x310
> [ 1157.467109]        [<ffffffffbc8bd820>] do_vfs_ioctl+0x410/0x6c0
> [ 1157.473233]        [<ffffffffbc8bdb71>] SyS_ioctl+0xa1/0xc0
> [ 1157.478914]        [<ffffffffbce84a5e>] system_call_fastpath+0x25/0x2a
> [ 1157.485569]
> -> #0 (&rtwdev->mutex){+.+.+.}:
> [ 1157.490022]        [<ffffffffbc7409d1>] __lock_acquire+0xec1/0x1630
> [ 1157.496305]        [<ffffffffbc741a29>] lock_acquire+0x99/0x1e0
> [ 1157.502413]        [<ffffffffbce72793>] mutex_lock_nested+0x93/0x410
> [ 1157.508890]        [<ffffffffc098322b>] rtw_ops_config+0x2b/0x90
> [rtw88]
> [ 1157.515724]        [<ffffffffc0b13343>]
> ieee80211_hw_config+0xc3/0x680 [mac80211]
> [ 1157.523370]        [<ffffffffc0b8a4ca>]
> ieee80211_recalc_ps.part.27+0x9a/0x180 [mac80211]
> [ 1157.531685]        [<ffffffffc0b8abc5>]
> ieee80211_mgd_probe_ap.part.28+0x115/0x160 [mac80211]
> [ 1157.540353]        [<ffffffffc0b8b40d>]
> ieee80211_beacon_connection_loss_work+0x4d/0x80 [mac80211]
> [ 1157.549513]        [<ffffffffbc6d77bc>] process_one_work+0x22c/0x720
> [ 1157.555886]        [<ffffffffbc6d7dd6>] worker_thread+0x126/0x3b0
> [ 1157.562170]        [<ffffffffbc6e107f>] kthread+0xef/0x100
> [ 1157.567765]        [<ffffffffbce848b7>]
> ret_from_fork_nospec_end+0x0/0x39
> [ 1157.574579]
> other info that might help us debug this:
> 
> [ 1157.582788] Chain exists of:
>   &rtwdev->mutex --> (&(&rtwdev->watch_dog_work)->work) -->
> &local->iflist_mtx
> 
> [ 1157.593024]  Possible unsafe locking scenario:
> 
> [ 1157.599046]        CPU0                    CPU1
> [ 1157.603653]        ----                    ----
> [ 1157.608258]   lock(&local->iflist_mtx);
> [ 1157.612180]
> lock((&(&rtwdev->watch_dog_work)->work));
> [ 1157.620074]                                lock(&local->iflist_mtx);
> [ 1157.626555]   lock(&rtwdev->mutex);
> [ 1157.630124]
>  *** DEADLOCK ***
> 
> [ 1157.636148] 4 locks held by kworker/u4:2/14490:
> [ 1157.640755]  #0:  (%s#6){.+.+.+}, at: [<ffffffffbc6d774a>]
> process_one_work+0x1ba/0x720
> [ 1157.648965]  #1:  ((&ifmgd->beacon_connection_loss_work)){+.+.+.}, at:
> [<ffffffffbc6d774a>] process_one_work+0x1ba/0x720
> [ 1157.659950]  #2:  (&wdev->mtx){+.+.+.}, at: [<ffffffffc0b8aad5>]
> ieee80211_mgd_probe_ap.part.28+0x25/0x160 [mac80211]
> [ 1157.670901]  #3:  (&local->iflist_mtx){+.+...}, at: [<ffffffffc0b8ab7a>]
> ieee80211_mgd_probe_ap.part.28+0xca/0x160 [mac80211]
> [ 1157.682466]
> 
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> ---
>  drivers/net/wireless/realtek/rtw88/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c
> b/drivers/net/wireless/realtek/rtw88/main.c
> index 9893e5e297e3..f63c34a2e356 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -162,7 +162,8 @@ static void rtw_watch_dog_work(struct work_struct
> *work)
>  	rtwdev->stats.tx_cnt = 0;
>  	rtwdev->stats.rx_cnt = 0;
> 
> -	rtw_iterate_vifs(rtwdev, rtw_vif_watch_dog_iter, &data);
> +	/* use atomic version to avoid taking local->iflist_mtx mutex */
> +	rtw_iterate_vifs_atomic(rtwdev, rtw_vif_watch_dog_iter, &data);
> 
>  	/* fw supports only one station associated to enter lps, if there are
>  	 * more than two stations associated to the AP, then we can not enter
> --


Looks good to me.
Thanks.

Acked-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Yan-Hsuan
