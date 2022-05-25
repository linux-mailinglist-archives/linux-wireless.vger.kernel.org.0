Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48AE5346EA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 01:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbiEYXKT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 May 2022 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiEYXKR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 May 2022 19:10:17 -0400
X-Greylist: delayed 530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 16:10:14 PDT
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C9166ADA
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 16:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1653519681; bh=evRB2StPeYm41jBlxWTteitvVZnEIQjHDz4gUNTMwwg=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=pSbepI2l+eVdnosS+39mEt0SfZvy3NcaXzXh3oIJYTc3SJN9tJ0ohprFgKAKsg5Vd
         mON61vjujVSSsm1chF8SMfGnyxCvTCbTPwsnj0kCYCo+gRfq8iWHzqqVJSYQK4UU3D
         Q/b2bEZBh/AUlCxcB+Dw6tcysEpwoexEL6QuVNJM=
Date:   Thu, 26 May 2022 01:01:21 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     tony0620emma@gmail.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, phhuang@realtek.com
Subject: Re: [PATCH 3/6] rtw88: Add update beacon flow for AP mode
Message-ID: <20220525230121.zk6xdjycxdhe62nw@core>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20220407095858.46807-1-pkshih@realtek.com>
 <20220407095858.46807-4-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407095858.46807-4-pkshih@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ping-Ke,

please see bugreport below:

On Thu, Apr 07, 2022 at 05:58:55PM +0800, Ping-Ke Shih wrote:
> From: Po-Hao Huang <phhuang@realtek.com>
> 
> To support stations in power saving mode, AP should notify stations
> that there are frames buffered at the AP via TIM during beacons.
> Driver used to transmit identical beacons that were downloaded to
> hardware during the initiation phase. This beacon will become
> obsolete over time.
> 
> If the beacon does not contain sufficient information, station would
> not be able to percept that there is data to receive. Hence it won't
> wake up and start the PS-poll procedure, this could lead to timeout
> and/or lost data segments. In order to resolve this issue, driver will
> now download beacon to hardware whenever the content is updated.
> 
> Enable hardware to update dtim_count for more efficiency, this reduces
> the overhead of downloading beacon at every beacon interval since most
> of the time only the dtim_count needs to be updated.
> 
> Change queue mapping for broadcast/multicast frames to high queue, so
> these frames can be prioritized and sent when dtim_count is zero.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> 
> [...]
>
> diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
> index c9341af493645..1ee41dfda5e1b 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac80211.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
> @@ -402,8 +402,10 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
>  			coex_stat->wl_beacon_interval = conf->beacon_int;
>  	}
>  
> -	if (changed & BSS_CHANGED_BEACON)
> +	if (changed & BSS_CHANGED_BEACON) {
> +		rtw_set_dtim_period(rtwdev, conf->dtim_period);
>  		rtw_fw_download_rsvd_page(rtwdev);
> +	}
>  
>  	if (changed & BSS_CHANGED_BEACON_ENABLED) {
>  		if (conf->enable_beacon)
> @@ -474,6 +476,18 @@ static int rtw_ops_sta_remove(struct ieee80211_hw *hw,
>  	return 0;
>  }
>  
> +static int rtw_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
> +			   bool set)
> +{
> +	struct rtw_dev *rtwdev = hw->priv;
> +
> +	mutex_lock(&rtwdev->mutex);
> +	rtw_fw_download_rsvd_page(rtwdev);
> +	mutex_unlock(&rtwdev->mutex);

set_tim is supposed to be atomic. See: https://elixir.bootlin.com/linux/latest/source/include/net/mac80211.h#L3500

This is causing some scheduling in atomic warnings in my kernel:

BUG: scheduling while atomic: swapper/1/0/0x00000700
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.18.0-rc7-00703-g33b5ee09a0c1 #4
Hardware name: Pine64 RK3566 Quartz64-A Board (DT)
Call trace:
 dump_backtrace.part.0+0xc4/0xd0
 show_stack+0x14/0x60
 dump_stack_lvl+0x60/0x78
 dump_stack+0x14/0x2c
 __schedule_bug+0x5c/0x70
 __schedule+0x5c4/0x630
 schedule+0x44/0xb0
 schedule_preempt_disabled+0xc/0x14
 __mutex_lock.constprop.0+0x538/0x56c
 __mutex_lock_slowpath+0x10/0x20
 mutex_lock+0x54/0x60
 rtw_ops_set_tim+0x20/0x40
 __sta_info_recalc_tim+0x150/0x250
 sta_info_recalc_tim+0x10/0x20
 invoke_tx_handlers_early+0x4e4/0x5c0
 ieee80211_tx+0x78/0x110
 ieee80211_xmit+0x94/0xc0
 __ieee80211_subif_start_xmit+0x818/0xd20
 ieee80211_subif_start_xmit+0x44/0x2d0
 dev_hard_start_xmit+0xd0/0x150
 __dev_queue_xmit+0x250/0xb30
 dev_queue_xmit+0x10/0x20
 br_dev_queue_push_xmit+0x94/0x174
 br_forward_finish+0x90/0xa0
 __br_forward+0xc0/0x13c
 br_forward+0x108/0x134
 br_dev_xmit+0x1cc/0x3a4
 dev_hard_start_xmit+0xd0/0x150
 __dev_queue_xmit+0x250/0xb30
 dev_queue_xmit+0x10/0x20
 arp_xmit+0x6c/0x7c
 arp_send_dst+0x8c/0xc0
 arp_solicit+0xd4/0x1e0
 neigh_probe+0x58/0xa0
 neigh_timer_handler+0x27c/0x380
 call_timer_fn.constprop.0+0x20/0x80
 __run_timers.part.0+0x230/0x280
 run_timer_softirq+0x38/0x70
 _stext+0x104/0x278
 __irq_exit_rcu+0xa4/0xdc
 irq_exit_rcu+0xc/0x14
 el1_interrupt+0x34/0x50
 el1h_64_irq_handler+0x14/0x20
 el1h_64_irq+0x64/0x68
 arch_cpu_idle+0x14/0x20
 do_idle+0x208/0x290
 cpu_startup_entry+0x20/0x30
 secondary_start_kernel+0x130/0x144
 __secondary_switched+0x54/0x58

kind regards,
	o.

> +	return 0;
> +}
> +
>  static int rtw_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>  			   struct ieee80211_vif *vif, struct ieee80211_sta *sta,
>  			   struct ieee80211_key_conf *key)
> @@ -875,6 +889,7 @@ const struct ieee80211_ops rtw_ops = {
>  	.conf_tx		= rtw_ops_conf_tx,
>  	.sta_add		= rtw_ops_sta_add,
>  	.sta_remove		= rtw_ops_sta_remove,
> +	.set_tim		= rtw_ops_set_tim,
>  	.set_key		= rtw_ops_set_key,
>  	.ampdu_action		= rtw_ops_ampdu_action,
>  	.can_aggregate_in_amsdu	= rtw_ops_can_aggregate_in_amsdu,
