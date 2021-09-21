Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950F24130A5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 11:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhIUJTS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 05:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhIUJTR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 05:19:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DCDC061574
        for <linux-wireless@vger.kernel.org>; Tue, 21 Sep 2021 02:17:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q11so37083481wrr.9
        for <linux-wireless@vger.kernel.org>; Tue, 21 Sep 2021 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PwyFtB0A3eU67JbRpfDSSIWYkhNJh0KSc6wyGsptWEg=;
        b=XYn6wePN4FkmiGTHeoZPUomEVVa0NLndMcIpJiqOQ349+6CHiz+INhxxHFXeV+3ZiR
         FqnMvOO8ezDoH9Eh9t/KDezI42nGDedhWmJReG5lxzke/uKyU9h+R4ygGIWwPL6R6Xck
         cPD5LyL6/F08kehEWFUEcUd+JsHVPb7t5lXXEZs8tQrqUQaImVMOs4HOFGUQYUee4yK6
         hNWb9x2PitvJ/UyW4DTtGEx0XSuHDjmC2kkojepprukO9yFP3YjbSkrmzXkd+lgNPl2N
         fuGmvXEWD4K4vxYiPsqUYnsoqwPyC81RRQpLSUpmzX7gAXhreZMPH2gL4vijJraZX82Y
         BEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PwyFtB0A3eU67JbRpfDSSIWYkhNJh0KSc6wyGsptWEg=;
        b=ZHhFC++kacup1R2gEB72s7lYC15JrpkYENdIKP5Vd3ovVA3yZXiwPFfRFzDYgLcfe5
         jeoKlDlhXIOpVZ/GQQ5J4tHa69pqW3pMFJhR4IzLHgs89F5iEcTHd23MtgwaS30fLRg8
         ZKUfNPMTdZ7aGMmcyN4qcWqn/c9bvPxNcZCwjbdU1qJNvfqoBfKjMMAWopBvT94NOSQb
         h30q5/wo4rwhkm8ldWP+F18k3PZMAJ0bGRhlZqiWHC0k47z9eNELEHbu3uIkio4sQor0
         S3/PK0CL4eQ8ZZb3tAQ7meCwaBB3lHrckTA4nCj0XlCWdmm+xhg1vHJUgdJ9wK+sajUh
         4k4A==
X-Gm-Message-State: AOAM532qVxJeDLa6ejTGdawP7Oa50/6Rk2Ie1/E8bi63+arbvTGh/5+Y
        2Hy/2k1BXtSrMuWMAsATT+ugSDANs3g=
X-Google-Smtp-Source: ABdhPJzgxg5R6KKwSjgOMmwB/eVqY+iEGve8bcjWXv6+MigJyL8LCELJoQdujRqES2+bboIKXAo08g==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr3463772wmi.131.1632215867749;
        Tue, 21 Sep 2021 02:17:47 -0700 (PDT)
Received: from agape.jhs ([5.171.80.11])
        by smtp.gmail.com with ESMTPSA id j7sm23111710wrr.27.2021.09.21.02.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 02:17:47 -0700 (PDT)
Date:   Tue, 21 Sep 2021 11:17:44 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/3] staging: rtl8723bs: remove possible deadlock when
 disconnect (v2)
Message-ID: <20210921091743.GA19934@agape.jhs>
References: <20210920145502.155454-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920145502.155454-1-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Sep 20, 2021 at 04:55:00PM +0200, Hans de Goede wrote:
> From: Fabio Aiuto <fabioaiuto83@gmail.com>
> 
> when turning off a connection, lockdep complains with the
> following warning (a modprobe has been done but the same
> happens with a disconnection from NetworkManager,
> it's enough to trigger a cfg80211_disconnect call):
> 
> [  682.855867] ======================================================
> [  682.855877] WARNING: possible circular locking dependency detected
> [  682.855887] 5.14.0-rc6+ #16 Tainted: G         C OE
> [  682.855898] ------------------------------------------------------
> [  682.855906] modprobe/1770 is trying to acquire lock:
> [  682.855916] ffffb6d000332b00 (&pxmitpriv->lock){+.-.}-{2:2},
> 		at: rtw_free_stainfo+0x52/0x4a0 [r8723bs]
> [  682.856073]
>                but task is already holding lock:
> [  682.856081] ffffb6d0003336a8 (&pstapriv->sta_hash_lock){+.-.}-{2:2},
> 		at: rtw_free_assoc_resources+0x48/0x110 [r8723bs]
> [  682.856207]
>                which lock already depends on the new lock.
> 
> [  682.856215]
>                the existing dependency chain (in reverse order) is:
> [  682.856223]
>                -> #1 (&pstapriv->sta_hash_lock){+.-.}-{2:2}:
> [  682.856247]        _raw_spin_lock_bh+0x34/0x40
> [  682.856265]        rtw_get_stainfo+0x9a/0x110 [r8723bs]
> [  682.856389]        rtw_xmit_classifier+0x27/0x130 [r8723bs]
> [  682.856515]        rtw_xmitframe_enqueue+0xa/0x20 [r8723bs]
> [  682.856642]        rtl8723bs_hal_xmit+0x3b/0xb0 [r8723bs]
> [  682.856752]        rtw_xmit+0x4ef/0x890 [r8723bs]
> [  682.856879]        _rtw_xmit_entry+0xba/0x350 [r8723bs]
> [  682.856981]        dev_hard_start_xmit+0xee/0x320
> [  682.856999]        sch_direct_xmit+0x8c/0x330
> [  682.857014]        __dev_queue_xmit+0xba5/0xf00
> [  682.857030]        packet_sendmsg+0x981/0x1b80
> [  682.857047]        sock_sendmsg+0x5b/0x60
> [  682.857060]        __sys_sendto+0xf1/0x160
> [  682.857073]        __x64_sys_sendto+0x24/0x30
> [  682.857087]        do_syscall_64+0x3a/0x80
> [  682.857102]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  682.857117]
>                -> #0 (&pxmitpriv->lock){+.-.}-{2:2}:
> [  682.857142]        __lock_acquire+0xfd9/0x1b50
> [  682.857158]        lock_acquire+0xb4/0x2c0
> [  682.857172]        _raw_spin_lock_bh+0x34/0x40
> [  682.857185]        rtw_free_stainfo+0x52/0x4a0 [r8723bs]
> [  682.857308]        rtw_free_assoc_resources+0x53/0x110 [r8723bs]
> [  682.857415]        cfg80211_rtw_disconnect+0x4b/0x70 [r8723bs]
> [  682.857522]        cfg80211_disconnect+0x12e/0x2f0 [cfg80211]
> [  682.857759]        cfg80211_leave+0x2b/0x40 [cfg80211]
> [  682.857961]        cfg80211_netdev_notifier_call+0xa9/0x560 [cfg80211]
> [  682.858163]        raw_notifier_call_chain+0x41/0x50
> [  682.858180]        __dev_close_many+0x62/0x100
> [  682.858195]        dev_close_many+0x7d/0x120
> [  682.858209]        unregister_netdevice_many+0x416/0x680
> [  682.858225]        unregister_netdevice_queue+0xab/0xf0
> [  682.858240]        unregister_netdev+0x18/0x20
> [  682.858255]        rtw_unregister_netdevs+0x28/0x40 [r8723bs]
> [  682.858360]        rtw_dev_remove+0x24/0xd0 [r8723bs]
> [  682.858463]        sdio_bus_remove+0x31/0xd0 [mmc_core]
> [  682.858532]        device_release_driver_internal+0xf7/0x1d0
> [  682.858550]        driver_detach+0x47/0x90
> [  682.858564]        bus_remove_driver+0x77/0xd0
> [  682.858579]        rtw_drv_halt+0xc/0x678 [r8723bs]
> [  682.858685]        __x64_sys_delete_module+0x13f/0x250
> [  682.858699]        do_syscall_64+0x3a/0x80
> [  682.858715]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  682.858729]
>                other info that might help us debug this:
> 
> [  682.858737]  Possible unsafe locking scenario:
> 
> [  682.858744]        CPU0                    CPU1
> [  682.858751]        ----                    ----
> [  682.858758]   lock(&pstapriv->sta_hash_lock);
> [  682.858772]                                lock(&pxmitpriv->lock);
> [  682.858786]                                lock(&pstapriv->sta_hash_lock);
> [  682.858799]   lock(&pxmitpriv->lock);
> [  682.858812]
>                 *** DEADLOCK ***
> 
> [  682.858820] 5 locks held by modprobe/1770:
> [  682.858831]  #0: ffff8d870697d980 (&dev->mutex){....}-{3:3},
> 		at: device_release_driver_internal+0x1a/0x1d0
> [  682.858869]  #1: ffffffffbdbbf1c8 (rtnl_mutex){+.+.}-{3:3},
> 		at: unregister_netdev+0xe/0x20
> [  682.858906]  #2: ffff8d87054ee5e8 (&rdev->wiphy.mtx){+.+.}-{3:3},
> 		at: cfg80211_netdev_notifier_call+0x9e/0x560 [cfg80211]
> [  682.859131]  #3: ffff8d870f2bc8f0 (&wdev->mtx){+.+.}-{3:3},
> 		at: cfg80211_leave+0x20/0x40 [cfg80211]
> [  682.859354]  #4: ffffb6d0003336a8 (&pstapriv->sta_hash_lock){+.-.}-{2:2},
> 		at: rtw_free_assoc_resources+0x48/0x110 [r8723bs]
> [  682.859482]
>                stack backtrace:
> [  682.859491] CPU: 1 PID: 1770 Comm: modprobe Tainted: G
> 		C OE     5.14.0-rc6+ #16
> [  682.859507] Hardware name: LENOVO 80NR/Madrid, BIOS DACN25WW 08/20/2015
> [  682.859517] Call Trace:
> [  682.859531]  dump_stack_lvl+0x56/0x6f
> [  682.859551]  check_noncircular+0xdb/0xf0
> [  682.859579]  __lock_acquire+0xfd9/0x1b50
> [  682.859606]  lock_acquire+0xb4/0x2c0
> [  682.859623]  ? rtw_free_stainfo+0x52/0x4a0 [r8723bs]
> [  682.859752]  ? mark_held_locks+0x48/0x70
> [  682.859769]  ? rtw_free_stainfo+0x4a/0x4a0 [r8723bs]
> [  682.859898]  _raw_spin_lock_bh+0x34/0x40
> [  682.859914]  ? rtw_free_stainfo+0x52/0x4a0 [r8723bs]
> [  682.860039]  rtw_free_stainfo+0x52/0x4a0 [r8723bs]
> [  682.860171]  rtw_free_assoc_resources+0x53/0x110 [r8723bs]
> [  682.860286]  cfg80211_rtw_disconnect+0x4b/0x70 [r8723bs]
> [  682.860397]  cfg80211_disconnect+0x12e/0x2f0 [cfg80211]
> [  682.860629]  cfg80211_leave+0x2b/0x40 [cfg80211]
> [  682.860836]  cfg80211_netdev_notifier_call+0xa9/0x560 [cfg80211]
> [  682.861048]  ? __lock_acquire+0x4dc/0x1b50
> [  682.861070]  ? lock_is_held_type+0xa8/0x110
> [  682.861089]  ? lock_is_held_type+0xa8/0x110
> [  682.861104]  ? find_held_lock+0x2d/0x90
> [  682.861120]  ? packet_notifier+0x173/0x300
> [  682.861141]  ? lock_release+0xb3/0x250
> [  682.861160]  ? packet_notifier+0x192/0x300
> [  682.861184]  raw_notifier_call_chain+0x41/0x50
> [  682.861205]  __dev_close_many+0x62/0x100
> [  682.861224]  dev_close_many+0x7d/0x120
> [  682.861245]  unregister_netdevice_many+0x416/0x680
> [  682.861264]  ? find_held_lock+0x2d/0x90
> [  682.861284]  unregister_netdevice_queue+0xab/0xf0
> [  682.861306]  unregister_netdev+0x18/0x20
> [  682.861325]  rtw_unregister_netdevs+0x28/0x40 [r8723bs]
> [  682.861434]  rtw_dev_remove+0x24/0xd0 [r8723bs]
> [  682.861542]  sdio_bus_remove+0x31/0xd0 [mmc_core]
> [  682.861615]  device_release_driver_internal+0xf7/0x1d0
> [  682.861637]  driver_detach+0x47/0x90
> [  682.861656]  bus_remove_driver+0x77/0xd0
> [  682.861674]  rtw_drv_halt+0xc/0x678 [r8723bs]
> [  682.861782]  __x64_sys_delete_module+0x13f/0x250
> [  682.861801]  ? lockdep_hardirqs_on_prepare+0xf3/0x170
> [  682.861817]  ? syscall_enter_from_user_mode+0x20/0x70
> [  682.861836]  do_syscall_64+0x3a/0x80
> [  682.861855]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  682.861873] RIP: 0033:0x7f6dbe85400b
> [  682.861890] Code: 73 01 c3 48 8b 0d 6d 1e 0c 00 f7 d8 64 89
> 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
> b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3d
> 1e 0c 00 f7 d8 64 89 01 48
> [  682.861906] RSP: 002b:00007ffe7a82f538 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [  682.861923] RAX: ffffffffffffffda RBX: 000055a64693bd20 RCX: 00007f6dbe85400b
> [  682.861935] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055a64693bd88
> [  682.861946] RBP: 000055a64693bd20 R08: 0000000000000000 R09: 0000000000000000
> [  682.861957] R10: 00007f6dbe8c7ac0 R11: 0000000000000206 R12: 000055a64693bd88
> [  682.861967] R13: 0000000000000000 R14: 000055a64693bd88 R15: 00007ffe7a831848
> 
> This happens because when we enqueue a frame for
> transmission we do it under xmit_priv lock, then calling
> rtw_get_stainfo (needed for enqueuing) takes sta_hash_lock
> and this leads to the following lock dependency:
> 
> xmit_priv->lock -> sta_hash_lock
> 
> Turning off a connection will bring to call
> rtw_free_assoc_resources which will set up
> the inverse dependency:
> 
> sta_hash_lock -> xmit_priv_lock
> 
> This could lead to a deadlock as lockdep complains.
> 
> Fix it by removing the xmit_priv->lock around
> rtw_xmitframe_enqueue call inside rtl8723bs_hal_xmit
> and put it in a smaller critical section inside
> rtw_xmit_classifier, the only place where
> xmit_priv data are actually accessed.
> 
> Replace spin_{lock,unlock}_bh(pxmitpriv->lock)
> in other tx paths leading to rtw_xmitframe_enqueue
> call with spin_{lock,unlock}_bh(psta->sleep_q.lock)
> - it's not clear why accessing a sleep_q was protected
> by a spinlock on xmitpriv->lock.
> 
> This way is avoided the same faulty lock nesting
> order.
> 
> Extra changes in v2 by Hans de Goede:
> -Lift the taking of the struct __queue.lock spinlock out of
>  rtw_free_xmitframe_queue() into the callers this allows also
>  protecting a bunch of related state in rtw_free_stainfo():
> -Protect psta->sleepq_len on rtw_free_xmitframe_queue(&psta->sleep_q);
> -Protect struct tx_servq.tx_pending and tx_servq.qcnt when
>  calling rtw_free_xmitframe_queue(&tx_servq.sta_pending)
> -This also allows moving the spin_lock_bh(&pxmitpriv->lock); to below
>  the sleep_q free-ing code, avoiding another ABBA locking issue
> 
> CC: Larry Finger <Larry.Finger@lwfinger.net>
> Tested-on: Lenovo Ideapad MiiX 300-10IBY
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> Co-developed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
<snip>

everything works good and smooth on Lenovo ideapad MiiX 300-10IBY

thank you,

fabio
