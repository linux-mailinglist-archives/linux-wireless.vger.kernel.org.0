Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 693E6134058
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 12:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAHLXf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jan 2020 06:23:35 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:50139 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgAHLXf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jan 2020 06:23:35 -0500
Received: from [192.168.2.97] (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 3F47F58006C
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2020 12:23:30 +0100 (CET)
To:     linux-wireless@vger.kernel.org
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Subject: Possible deadlock in cfg80211
Autocrypt: addr=markus.theil@tu-ilmenau.de; keydata=
 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
 sGZPq8zmOtvOyZtafA==
Message-ID: <64dc212d-fde7-ab84-369c-c7cb5bf579d7@tu-ilmenau.de>
Date:   Wed, 8 Jan 2020 12:23:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

while testing hostapd with hwsim, the following deadlock was reported:

[  500.865102] ============================================
[  500.865106] WARNING: possible recursive locking detected
[  500.865112] 5.4.8-arch1-1 #1 Not tainted
[  500.865117] --------------------------------------------
[  500.865122] kworker/3:0/36 is trying to acquire lock:
[  500.865127] ffff8881acdf0d08 (&wdev->mtx){+.+.}, at:
cfg80211_stop_ap+0x37/0x60 [cfg80211]
[  500.865249]
               but task is already holding lock:
[  500.865253] ffff8881acdf0d08 (&wdev->mtx){+.+.}, at:
cfg80211_autodisconnect_wk+0x3d/0x190 [cfg80211]
[  500.865354]
               other info that might help us debug this:
[  500.865358]  Possible unsafe locking scenario:

[  500.865363]        CPU0
[  500.865366]        ----
[  500.865369]   lock(&wdev->mtx);
[  500.865373]   lock(&wdev->mtx);
[  500.865378]
                *** DEADLOCK ***

[  500.865382]  May be due to missing lock nesting notation

[  500.865388] 3 locks held by kworker/3:0/36:
[  500.865391]  #0: ffff8881d4c22148 ((wq_completion)events){+.+.}, at:
process_one_work+0x4ee/0xac0
[  500.865407]  #1: ffff8881d4327dc8
((work_completion)(&wdev->disconnect_wk)){+.+.}, at:
process_one_work+0x4ee/0xac0
[  500.865418]  #2: ffff8881acdf0d08 (&wdev->mtx){+.+.}, at:
cfg80211_autodisconnect_wk+0x3d/0x190 [cfg80211]
[  500.865517]
               stack backtrace:
[  500.865524] CPU: 3 PID: 36 Comm: kworker/3:0 Not tainted 5.4.8-arch1-1 #1
[  500.865530] Hardware name: LENOVO 2349QM6/2349QM6, BIOS G1ETC2WW
(2.82 ) 08/07/2019
[  500.865628] Workqueue: events cfg80211_autodisconnect_wk [cfg80211]
[  500.865634] Call Trace:
[  500.865645]  dump_stack+0xb8/0x110
[  500.865654]  __lock_acquire.cold+0xe2/0x212
[  500.865672]  ? lockdep_hardirqs_on+0x260/0x260
[  500.865681]  ? find_held_lock+0x8c/0xa0
[  500.865693]  lock_acquire+0xe5/0x220
[  500.865772]  ? cfg80211_stop_ap+0x37/0x60 [cfg80211]
[  500.865783]  __mutex_lock+0x137/0xd00
[  500.865864]  ? cfg80211_stop_ap+0x37/0x60 [cfg80211]
[  500.865873]  ? preempt_count_sub+0x14/0xc0
[  500.865880]  ? __mutex_lock+0x71f/0xd00
[  500.865888]  ? find_first_zero_bit+0x28/0x50
[  500.865977]  ? cfg80211_stop_ap+0x37/0x60 [cfg80211]
[  500.865986]  ? mutex_lock_io_nested+0xc20/0xc20
[  500.866090]  ? cfg80211_autodisconnect_wk+0x3d/0x190 [cfg80211]
[  500.866098]  ? mutex_lock_io_nested+0xc20/0xc20
[  500.866109]  ? lockdep_hardirqs_on+0x260/0x260
[  500.866116]  ? match_held_lock+0x2e/0x240
[  500.866127]  ? preempt_count_sub+0x14/0xc0
[  500.866224]  ? cfg80211_stop_ap+0x37/0x60 [cfg80211]
[  500.866322]  cfg80211_stop_ap+0x37/0x60 [cfg80211]
[  500.866433]  cfg80211_autodisconnect_wk+0xd5/0x190 [cfg80211]
[  500.866445]  process_one_work+0x5c0/0xac0
[  500.866460]  ? pwq_dec_nr_in_flight+0x110/0x110
[  500.866480]  worker_thread+0x7a/0x690
[  500.866497]  kthread+0x1ab/0x200
[  500.866505]  ? process_one_work+0xac0/0xac0
[  500.866511]  ? kthread_create_on_node+0xd0/0xd0
[  500.866521]  ret_from_fork+0x3a/0x50

Markus

