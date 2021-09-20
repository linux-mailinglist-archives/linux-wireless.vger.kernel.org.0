Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4604117AC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 16:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbhITO5D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 10:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232984AbhITO5C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 10:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632149735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r39BSiVg8f6m8qAJTYAtCrwN+DnD+JvQIIqCFqAVzZk=;
        b=NYP84abTPfHAU3quoWs9+6FKdeFq1D4+/QHAknSj233KB/0tvmp9zDaMNIEIoqltyFy+7h
        st5GPLMcBdRaTOLp3SYlRRL7SesvXvtC7NUy8huZwYpXhb44JIp2clE35g1UF8aIFbQcCm
        XLR44wJmB/ipCyZ0CZ+H0H8cAUcNyrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-Wsh-6_vaNoO3HQCk4fWJ9Q-1; Mon, 20 Sep 2021 10:55:32 -0400
X-MC-Unique: Wsh-6_vaNoO3HQCk4fWJ9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B87D10151F8;
        Mon, 20 Sep 2021 14:55:31 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DA2F1F451;
        Mon, 20 Sep 2021 14:55:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 3/3] staging: rtl8723bs: remove a third possible deadlock
Date:   Mon, 20 Sep 2021 16:55:02 +0200
Message-Id: <20210920145502.155454-3-hdegoede@redhat.com>
In-Reply-To: <20210920145502.155454-1-hdegoede@redhat.com>
References: <20210920145502.155454-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The assoc_timer takes the pmlmepriv->lock and various functions which
take the pmlmepriv->scanned_queue.lock first take the pmlmepriv->lock,
this means that we cannot have code which waits for the timer
(timer_del_sync) while holding the pmlmepriv->scanned_queue.lock
to avoid a triangle deadlock:

[  363.139361] ======================================================
[  363.139377] WARNING: possible circular locking dependency detected
[  363.139396] 5.15.0-rc1+ #470 Tainted: G         C  E
[  363.139413] ------------------------------------------------------
[  363.139424] RTW_CMD_THREAD/2466 is trying to acquire lock:
[  363.139441] ffffbacd00699038 (&pmlmepriv->lock){+.-.}-{2:2}, at: _rtw_join_timeout_handler+0x3c/0x160 [r8723bs]
[  363.139598]
               but task is already holding lock:
[  363.139610] ffffbacd00128ea0 ((&pmlmepriv->assoc_timer)){+.-.}-{0:0}, at: call_timer_fn+0x5/0x260
[  363.139673]
               which lock already depends on the new lock.

[  363.139684]
               the existing dependency chain (in reverse order) is:
[  363.139696]
               -> #2 ((&pmlmepriv->assoc_timer)){+.-.}-{0:0}:
[  363.139734]        del_timer_sync+0x59/0x100
[  363.139762]        rtw_joinbss_event_prehandle+0x342/0x640 [r8723bs]
[  363.139870]        report_join_res+0xdf/0x110 [r8723bs]
[  363.139980]        OnAssocRsp+0x17a/0x200 [r8723bs]
[  363.140092]        rtw_recv_entry+0x190/0x1120 [r8723bs]
[  363.140209]        rtl8723b_process_phy_info+0x3f9/0x750 [r8723bs]
[  363.140318]        tasklet_action_common.constprop.0+0xe8/0x110
[  363.140345]        __do_softirq+0xde/0x485
[  363.140372]        __irq_exit_rcu+0xd0/0x100
[  363.140393]        irq_exit_rcu+0xa/0x20
[  363.140413]        common_interrupt+0x83/0xa0
[  363.140440]        asm_common_interrupt+0x1e/0x40
[  363.140463]        finish_task_switch.isra.0+0x157/0x3d0
[  363.140492]        __schedule+0x447/0x1880
[  363.140516]        schedule+0x59/0xc0
[  363.140537]        smpboot_thread_fn+0x161/0x1c0
[  363.140565]        kthread+0x143/0x160
[  363.140585]        ret_from_fork+0x22/0x30
[  363.140614]
               -> #1 (&pmlmepriv->scanned_queue.lock){+.-.}-{2:2}:
[  363.140653]        _raw_spin_lock_bh+0x34/0x40
[  363.140675]        rtw_free_network_queue+0x31/0x80 [r8723bs]
[  363.140776]        rtw_sitesurvey_cmd+0x79/0x1e0 [r8723bs]
[  363.140869]        rtw_cfg80211_surveydone_event_callback+0x3cf/0x470 [r8723bs]
[  363.140973]        rdev_scan+0x42/0x1a0 [cfg80211]
[  363.141307]        nl80211_trigger_scan+0x566/0x660 [cfg80211]
[  363.141635]        genl_family_rcv_msg_doit+0xcd/0x110
[  363.141661]        genl_rcv_msg+0xce/0x1c0
[  363.141680]        netlink_rcv_skb+0x50/0xf0
[  363.141699]        genl_rcv+0x24/0x40
[  363.141717]        netlink_unicast+0x16d/0x230
[  363.141736]        netlink_sendmsg+0x22b/0x450
[  363.141755]        sock_sendmsg+0x5e/0x60
[  363.141781]        ____sys_sendmsg+0x22f/0x270
[  363.141803]        ___sys_sendmsg+0x81/0xc0
[  363.141828]        __sys_sendmsg+0x49/0x80
[  363.141851]        do_syscall_64+0x3b/0x90
[  363.141873]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  363.141895]
               -> #0 (&pmlmepriv->lock){+.-.}-{2:2}:
[  363.141930]        __lock_acquire+0x1158/0x1de0
[  363.141954]        lock_acquire+0xb5/0x2b0
[  363.141974]        _raw_spin_lock_bh+0x34/0x40
[  363.141993]        _rtw_join_timeout_handler+0x3c/0x160 [r8723bs]
[  363.142097]        call_timer_fn+0x94/0x260
[  363.142122]        __run_timers.part.0+0x1bf/0x290
[  363.142147]        run_timer_softirq+0x26/0x50
[  363.142171]        __do_softirq+0xde/0x485
[  363.142193]        __irq_exit_rcu+0xd0/0x100
[  363.142215]        irq_exit_rcu+0xa/0x20
[  363.142235]        sysvec_apic_timer_interrupt+0x72/0x90
[  363.142260]        asm_sysvec_apic_timer_interrupt+0x12/0x20
[  363.142283]        __module_address.part.0+0x0/0xd0
[  363.142309]        is_module_address+0x25/0x40
[  363.142334]        static_obj+0x4f/0x60
[  363.142361]        lockdep_init_map_type+0x47/0x220
[  363.142382]        __init_swait_queue_head+0x45/0x60
[  363.142408]        mmc_wait_for_req+0x4a/0xc0 [mmc_core]
[  363.142504]        mmc_wait_for_cmd+0x55/0x70 [mmc_core]
[  363.142592]        mmc_io_rw_direct+0x75/0xe0 [mmc_core]
[  363.142691]        sdio_writeb+0x2e/0x50 [mmc_core]
[  363.142788]        _sd_cmd52_write+0x62/0x80 [r8723bs]
[  363.142885]        sd_cmd52_write+0x6c/0xb0 [r8723bs]
[  363.142981]        rtl8723bs_set_hal_ops+0x982/0x9b0 [r8723bs]
[  363.143089]        rtw_write16+0x1e/0x30 [r8723bs]
[  363.143184]        SetHwReg8723B+0xcc9/0xd30 [r8723bs]
[  363.143294]        mlmeext_joinbss_event_callback+0x17a/0x1a0 [r8723bs]
[  363.143405]        rtw_joinbss_event_callback+0x11/0x20 [r8723bs]
[  363.143507]        mlme_evt_hdl+0x4d/0x70 [r8723bs]
[  363.143620]        rtw_cmd_thread+0x168/0x3c0 [r8723bs]
[  363.143712]        kthread+0x143/0x160
[  363.143732]        ret_from_fork+0x22/0x30
[  363.143757]
               other info that might help us debug this:

[  363.143768] Chain exists of:
                 &pmlmepriv->lock --> &pmlmepriv->scanned_queue.lock --> (&pmlmepriv->assoc_timer)

[  363.143809]  Possible unsafe locking scenario:

[  363.143819]        CPU0                    CPU1
[  363.143831]        ----                    ----
[  363.143841]   lock((&pmlmepriv->assoc_timer));
[  363.143862]                                lock(&pmlmepriv->scanned_queue.lock);
[  363.143882]                                lock((&pmlmepriv->assoc_timer));
[  363.143902]   lock(&pmlmepriv->lock);
[  363.143921]
                *** DEADLOCK ***

Make rtw_joinbss_event_prehandle() release the scanned_queue.lock before
it deletes the timer to avoid this (it is still holding pmlmepriv->lock
protecting against racing the timer).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 59e0b5345078..53599d8a42d1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1236,16 +1236,13 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 				rtw_indicate_connect(adapter);
 			}
 
+			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
+
 			/* s5. Cancel assoc_timer */
 			del_timer_sync(&pmlmepriv->assoc_timer);
-
 		} else {
 			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
-			goto ignore_joinbss_callback;
 		}
-
-		spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
-
 	} else if (pnetwork->join_res == -4) {
 		rtw_reset_securitypriv(adapter);
 		_set_timer(&pmlmepriv->assoc_timer, 1);
-- 
2.31.1

