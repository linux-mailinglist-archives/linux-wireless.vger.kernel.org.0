Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3959301887
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 22:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbhAWV3q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 16:29:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbhAWV3p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 16:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611437297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RR+slcZJIQfXXKpkeDmqoU9L0QjyogxRcflNfjMUohg=;
        b=IUR9TEs8bjd7XGKiGAkLTn/VQool6NIc2qjr9fvz+lKbgU4RJvAWoDDPIC4DJfGQPCTiIg
        9sFW5nuFWjJcExZCA7cSPe8XVSf7+Ss9HmSj+DswBng+4dWrS4c2SaK8i7dO+dRCKcofr4
        +1ekKqpuxt/+R9hw0f2dr81z0TaLel0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-GrtWXSzuMY2A1QAMneWIqg-1; Sat, 23 Jan 2021 16:28:15 -0500
X-MC-Unique: GrtWXSzuMY2A1QAMneWIqg-1
Received: by mail-ed1-f71.google.com with SMTP id j12so4994568edq.10
        for <linux-wireless@vger.kernel.org>; Sat, 23 Jan 2021 13:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RR+slcZJIQfXXKpkeDmqoU9L0QjyogxRcflNfjMUohg=;
        b=GcL8DQBezqJQBN0rc7n/T4ukBts1VDHVtmnc5v9ScY4Zjo6aclnu/8Z8xeuuN49nJg
         WZ7OjnC4WzExDktTlK9qV0GdsViWMIh77jg064AxoFfnuyP2vmVJRH1EGf0uZ/7U9Gix
         gXLiKH2zgemjRZ7yr5b0nSdz+29XjuDJlPJLEPyhvuNrm+sO1h4XIqJXibKXTKjZO/l+
         WnBSk+t5oewwrQEi9OoyBuUt25AEG2X1+yq5wzqc1MJ65GtXxG2H/pu3fA7kNA31dA9U
         T/nHDzIGxLQE4whJhQcvnciLGsaGZXGG2ukCNl6GZLYFEwPKu8snup2b6Kyi4KazkQZy
         p05w==
X-Gm-Message-State: AOAM533wIrTVhdgiZM8DFi6c+tsW616uehUdXZUOd2mLWizA2cDP45+H
        b404mIS3RpZOkAY1TzLpbw+5Dzft5stTJnTRrlfodUPDpuRulgPIopjDSBUYZFUkHOS087WvoWD
        i3WYfXi4xaKvJ2MaFyVKw/aFKV/N6Eqc9fUMdlUp0Am11GLsg3j2BPXJp0qiT4WNFOUqOgnH1ov
        g+1T0=
X-Received: by 2002:aa7:cb42:: with SMTP id w2mr2507495edt.21.1611437293184;
        Sat, 23 Jan 2021 13:28:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwYEly+R5w8HgUxryf0HJBiKAvzJuY0EjMiEUvCCS7+nyqgsZB4APh8K8E9WFsuAXiKBAdVw==
X-Received: by 2002:aa7:cb42:: with SMTP id w2mr2507482edt.21.1611437292965;
        Sat, 23 Jan 2021 13:28:12 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id r10sm7781677edw.24.2021.01.23.13.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 13:28:11 -0800 (PST)
Subject: Re: [PATCH] cfg80211: Save the regulatory domain with a lock
To:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net,
        "Peer, Ilan" <ilan.peer@intel.com>
Cc:     linux-wireless@vger.kernel.org
References: <iwlwifi.20210105165657.613e9a876829.Ia38d27dbebea28bf9c56d70691d243186ede70e7@changeid>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d839ab62-e4bc-56f0-d861-f172bf19c4b3@redhat.com>
Date:   Sat, 23 Jan 2021 22:28:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <iwlwifi.20210105165657.613e9a876829.Ia38d27dbebea28bf9c56d70691d243186ede70e7@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 1/5/21 3:56 PM, Luca Coelho wrote:
> From: Ilan Peer <ilan.peer@intel.com>
> 
> Saving the regulatory domain while setting custom regulatory domain
> was done while accessing a RCU protected pointer but without any
> protection.
> 
> Fix this by using RTNL while accessing the pointer.
> 
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Reported-by: syzbot+27771d4abcd9b7a1f5d3@syzkaller.appspotmail.com
> Reported-by: syzbot+db4035751c56c0079282@syzkaller.appspotmail.com
> Reported-by: Hans de Goede <hdegoede@redhat.com>

So I'm afraid that I have some bad news about this patch, it fixes
the RCU warning which I reported:

https://lore.kernel.org/linux-wireless/20210104170713.66956-1-hdegoede@redhat.com/

But it introduces a deadlock. I hit this while testing 5.11-rc4 + this patch
on top on a device with a RTL8723BS wifi chip. Granted the driver for that
chipset comes from staging. But I seriously wonder if that is the only driver to
hit this deadlock:

[   63.231667] rtl8723bs: acquire FW from file:rtlwifi/rtl8723bs_nic.bin

[   65.206585] ============================================
[   65.206602] WARNING: possible recursive locking detected
[   65.206620] 5.11.0-rc4+ #210 Tainted: G         C  E    
[   65.206638] --------------------------------------------
[   65.206651] NetworkManager/988 is trying to acquire lock:
[   65.206668] ffffffff8dbc3188 (rtnl_mutex){+.+.}-{3:3}, at: wiphy_apply_custom_regulatory+0x9d/0x2b0 [cfg80211]
[   65.206867] 
               but task is already holding lock:
[   65.206880] ffffffff8dbc3188 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x142/0x480
[   65.206945] 
               other info that might help us debug this:
[   65.206960]  Possible unsafe locking scenario:

[   65.206974]        CPU0
[   65.206986]        ----
[   65.206997]   lock(rtnl_mutex);
[   65.207021]   lock(rtnl_mutex);
[   65.207044] 
                *** DEADLOCK ***

[   65.207055]  May be due to missing lock nesting notation

[   65.207067] 2 locks held by NetworkManager/988:
[   65.207085]  #0: ffffffff8dbc3188 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x142/0x480
[   65.207130]  #1: ffff8c27825161f0 (&pdvobj->hw_init_mutex){+.+.}-{3:3}, at: netdev_open+0x39/0x70 [r8723bs]
[   65.207230] 
               stack backtrace:
[   65.207237] CPU: 3 PID: 988 Comm: NetworkManager Tainted: G         C  E     5.11.0-rc4+ #210
[   65.207247] Hardware name: Jumper EZpad/EZpad, BIOS Jumper12x.WJ2012.bsBKRCP05 04/28/2018
[   65.207254] Call Trace:
[   65.207271]  dump_stack+0x8b/0xb0
[   65.207287]  __lock_acquire.cold+0x159/0x2ab
[   65.207303]  ? __lock_acquire+0x382/0x1e10
[   65.207319]  lock_acquire+0x116/0x370
[   65.207337]  ? wiphy_apply_custom_regulatory+0x9d/0x2b0 [cfg80211]
[   65.207409]  __mutex_lock+0x7e/0x7a0
[   65.207425]  ? wiphy_apply_custom_regulatory+0x9d/0x2b0 [cfg80211]
[   65.207489]  ? wiphy_apply_custom_regulatory+0x9d/0x2b0 [cfg80211]
[   65.207556]  ? rcu_read_lock_sched_held+0x3f/0x80
[   65.207571]  ? __kmalloc+0x2de/0x310
[   65.207592]  wiphy_apply_custom_regulatory+0x9d/0x2b0 [cfg80211]
[   65.207664]  rtw_regd_init+0x32/0x40 [r8723bs]
[   65.207755]  rtw_cfg80211_init_wiphy+0x79/0xb0 [r8723bs]
[   65.207848]  _netdev_open+0x8b/0x1b0 [r8723bs]
[   65.207939]  netdev_open+0x45/0x70 [r8723bs]
[   65.208030]  __dev_open+0xd4/0x1a0
[   65.208047]  __dev_change_flags+0x1cb/0x240
[   65.208066]  dev_change_flags+0x21/0x60
[   65.208081]  do_setlink+0x251/0x10b0
[   65.208096]  ? __snmp6_fill_stats64.constprop.0+0x53/0xe0
[   65.208113]  ? __lock_acquire+0x382/0x1e10
[   65.208126]  ? __nla_validate_parse+0x4f/0xb20
[   65.208150]  __rtnl_newlink+0x60c/0x980
[   65.208201]  ? lock_acquire+0x116/0x370
[   65.208226]  ? sock_def_readable+0x5/0x2a0
[   65.208256]  ? find_held_lock+0x2b/0x80
[   65.208283]  ? sock_def_readable+0xb0/0x2a0
[   65.208315]  ? netlink_unicast+0x1f7/0x230
[   65.208348]  ? trace_event_raw_event_lock_acquire+0x100/0x100
[   65.208371]  ? __bfs+0xe0/0x210
[   65.208445]  ? rcu_read_lock_sched_held+0x3f/0x80
[   65.208457]  ? kmem_cache_alloc_trace+0x292/0x2c0
[   65.208473]  rtnl_newlink+0x44/0x70
[   65.208488]  rtnetlink_rcv_msg+0x16e/0x480
[   65.208502]  ? netlink_deliver_tap+0x95/0x3e0
[   65.208519]  ? rtnetlink_put_metrics+0x1c0/0x1c0
[   65.208533]  netlink_rcv_skb+0x50/0xf0
[   65.208553]  netlink_unicast+0x16d/0x230
[   65.208569]  netlink_sendmsg+0x23f/0x460
[   65.208589]  sock_sendmsg+0x5e/0x60
[   65.208605]  ____sys_sendmsg+0x231/0x270
[   65.208620]  ? import_iovec+0x17/0x20
[   65.208633]  ? sendmsg_copy_msghdr+0x5c/0x80
[   65.208649]  ___sys_sendmsg+0x75/0xb0
[   65.208670]  ? find_held_lock+0x2b/0x80
[   65.208683]  ? __fget_files+0xd0/0x1a0
[   65.208700]  ? __fget_files+0xef/0x1a0
[   65.208715]  __sys_sendmsg+0x49/0x80
[   65.208744]  ? syscall_enter_from_user_mode+0x27/0x80
[   65.208776]  do_syscall_64+0x33/0x40
[   65.208808]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   65.208836] RIP: 0033:0x7f846e33b80d
[   65.208865] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 ea ec ff ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2f 44 89 c7 48 89 44 24 08 e8 1e ed ff ff 48
[   65.208890] RSP: 002b:00007ffd17e602d0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
[   65.208920] RAX: ffffffffffffffda RBX: 000055fa8da219c0 RCX: 00007f846e33b80d
[   65.208939] RDX: 0000000000000000 RSI: 00007ffd17e60320 RDI: 000000000000000d
[   65.208957] RBP: 00007ffd17e60320 R08: 0000000000000000 R09: 0000000000000000
[   65.208974] R10: 0000000000000000 R11: 0000000000000293 R12: 000055fa8da219c0
[   65.208992] R13: 00007ffd17e604d8 R14: 00007ffd17e604cc R15: 0000000000000000

Upon a quick check I could not figure out the exact cause of this so
I'm going to drop the "cfg80211: Save the regulatory domain with a lock"
patch from my local kernels for now.

Note we really should fix this new deadlock before 5.11 is released. This is
worse then the RCU warning which this patch fixes.

Regards,

Hans





> Fixes: beee24695157 ("cfg80211: Save the regulatory domain when setting custom regulatory")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  net/wireless/reg.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
> index bb72447ad960..8114bba8556c 100644
> --- a/net/wireless/reg.c
> +++ b/net/wireless/reg.c
> @@ -5,7 +5,7 @@
>   * Copyright 2008-2011	Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
>   * Copyright 2013-2014  Intel Mobile Communications GmbH
>   * Copyright      2017  Intel Deutschland GmbH
> - * Copyright (C) 2018 - 2019 Intel Corporation
> + * Copyright (C) 2018 - 2021 Intel Corporation
>   *
>   * Permission to use, copy, modify, and/or distribute this software for any
>   * purpose with or without fee is hereby granted, provided that the above
> @@ -139,6 +139,11 @@ static const struct ieee80211_regdomain *get_cfg80211_regdom(void)
>  	return rcu_dereference_rtnl(cfg80211_regdomain);
>  }
>  
> +/*
> + * Returns the regulatory domain associated with the wiphy.
> + *
> + * Requires either RTNL or RCU protection
> + */
>  const struct ieee80211_regdomain *get_wiphy_regdom(struct wiphy *wiphy)
>  {
>  	return rcu_dereference_rtnl(wiphy->regd);
> @@ -2571,9 +2576,13 @@ void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
>  	if (IS_ERR(new_regd))
>  		return;
>  
> +	rtnl_lock();
> +
>  	tmp = get_wiphy_regdom(wiphy);
>  	rcu_assign_pointer(wiphy->regd, new_regd);
>  	rcu_free_regdom(tmp);
> +
> +	rtnl_unlock();
>  }
>  EXPORT_SYMBOL(wiphy_apply_custom_regulatory);
>  
> 

