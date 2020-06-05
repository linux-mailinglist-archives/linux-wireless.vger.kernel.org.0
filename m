Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516171F02F5
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2020 00:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgFEWls (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jun 2020 18:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgFEWls (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jun 2020 18:41:48 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20FCC08C5C3
        for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2020 15:41:47 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z9so13604905ljh.13
        for <linux-wireless@vger.kernel.org>; Fri, 05 Jun 2020 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Mae4jOlihjfAZDZDhTPFsGOTgOiZjtEf9k7k3F8fM7I=;
        b=E3W1dtzmFKFhCyu+O5OE4z2hPwO2tZ6sGQvElxznmj+8Ev3u49IP1hB5edjQq4eSlq
         lsrphGci2bIunBYoxyg0OKawiQn91gGQ7TW12/BDWz/AmP8hoALE+iWwiR0RcmGkQNsd
         vEDNqnVCDEBUdyc94cJ4cwBO4+YZDASsvOkzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Mae4jOlihjfAZDZDhTPFsGOTgOiZjtEf9k7k3F8fM7I=;
        b=nXjYW/2/NKH3NzgZr53PKJs8+GcZRLcywb57iEgwRUGFUa3aQ0aPmu1OVl8TKaPrEF
         gKvMyZjIV6QokAzd4Mg/auXafCYvWKJyNwlrXWYVz9CNLiqhNoKyNVLUEYSgSdXKGj4a
         YvxASYwnXxrEzhfSRlItkydSzmgjxZtqQfRZWal6RJLvxTc9Qv1l9iSEhbt6/iv9ec1E
         dN9o89lRY0Mv7Nr+hfbuphi6HdhvXjJl9J+kVdwstaG3aWTNJ8u8t+4b/0YTVCVTKC3a
         5yB19UfUFDUZOVJY32VrpxFcJ0geGAWqF2BQC2QQneQR9Uh/R2y5iS3r3ypVSeaU2vw+
         IeTQ==
X-Gm-Message-State: AOAM5328ze0noh1RsjfrSZG/gNUnszzjmu5zCvDG0rdfs3j18zLzJhmC
        rcMTfKjie95Z6zWShX+KlKAXNEInAFc=
X-Google-Smtp-Source: ABdhPJxLXmssMJ7hvmUX7loZFsB0Kw9s93QtpPVshx0/t5av1QlA6WFVviqoY/iDdAd7TkRhjJKi1w==
X-Received: by 2002:a2e:a211:: with SMTP id h17mr5682147ljm.289.1591396905461;
        Fri, 05 Jun 2020 15:41:45 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id i4sm1514173ljd.18.2020.06.05.15.41.44
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 15:41:44 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a25so13647245ljp.3
        for <linux-wireless@vger.kernel.org>; Fri, 05 Jun 2020 15:41:44 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr6109684ljn.285.1591396903743;
 Fri, 05 Jun 2020 15:41:43 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jun 2020 15:41:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0QUaYcLHKG=_fw65NqhGbqvnU958SkHak9mg9qNwR+A@mail.gmail.com>
Message-ID: <CAHk-=wj0QUaYcLHKG=_fw65NqhGbqvnU958SkHak9mg9qNwR+A@mail.gmail.com>
Subject: Hang on wireless removal..
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

So I think there's something wrong with wireless networking, and
(likely) in particular turning off wireless. And I think the problem
came in this merge window, because now my machine hangs on shutdown.

My new desktop is otherwise working fine, but it has some unnecessary
wireless capability on the motherboard, in the form of a Intel Wi-Fi 6
AX200 module that I don't use (since I end up using wired gig ethernet
instead).

And while debugging the shutdown hang (symptom: systemd waits forever
for NetworkManager and WPA supplicant), I turned off the WiFi.

And what do you know, things went all sideways.

They went sideways because everything that wants the rtnl lock seems
to just hang.

Example:

  kworker/57:2    D    0  1592      2 0x80004080
  Workqueue: events_power_efficient reg_check_chans_work [cfg80211]
  Call Trace:
   __schedule+0x30b/0x4b0
   ? schedule+0x77/0xa0
   ? schedule_preempt_disabled+0xa/0x10
   ? __mutex_lock+0x264/0x410
   ? psi_group_change+0x44/0x260
   ? reg_check_chans_work+0x1d/0x300 [cfg80211]
   ? __switch_to_asm+0x42/0x70
   ? process_one_work+0x1fa/0x3f0
   ? worker_thread+0x25d/0x480
   ? kthread+0x121/0x130
   ? process_one_work+0x3f0/0x3f0
   ? kthread_blkcg+0x30/0x30
   ? ret_from_fork+0x22/0x30
  kworker/60:2    D    0  1926      2 0x80004000
  Workqueue: ipv6_addrconf addrconf_verify_work
  Call Trace:
   __schedule+0x30b/0x4b0
   ? schedule+0x77/0xa0
   ? schedule_preempt_disabled+0xa/0x10
   ? __mutex_lock+0x264/0x410
   ? addrconf_verify_work+0xa/0x20
   ? process_one_work+0x1fa/0x3f0
   ? worker_thread+0x25d/0x480
   ? kthread+0x121/0x130
   ? process_one_work+0x3f0/0x3f0
   ? kthread_blkcg+0x30/0x30
   ? ret_from_fork+0x22/0x30
  NetworkManager  D    0  4329      1 0x00004000
  Call Trace:
   __schedule+0x30b/0x4b0
   ? schedule+0x77/0xa0
   ? schedule_preempt_disabled+0xa/0x10
   ? __mutex_lock+0x264/0x410
   ? __netlink_dump_start+0xa7/0x300
   ? rtnl_dellink+0x3c0/0x3c0
   ? rtnetlink_rcv_msg+0x375/0x3d0
   ? poll_freewait+0x35/0xa0
   ? do_sys_poll+0x58f/0x5f0
   ? rtnl_dellink+0x3c0/0x3c0
   ? __ia32_compat_sys_ppoll_time64+0x120/0x120
   ? ip_output+0x6a/0xd0
   ? ip_mc_finish_output+0x120/0x120
   ? avc_has_perm+0x34/0xa0
   ? rtnetlink_bind+0x30/0x30
   ? netlink_rcv_skb+0xfb/0x130
   ? netlink_unicast+0x1bf/0x2e0
   ? netlink_sendmsg+0x385/0x410
   ? __sys_sendto+0x21f/0x230
   ? move_addr_to_user+0x97/0xc0
   ? alloc_file_pseudo+0x9b/0xd0
   ? sock_alloc_file+0xc4/0x100
   ? __x64_sys_sendto+0x22/0x30
   ? do_syscall_64+0x5e/0xd0
   ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

and perhaps most interestingly, wpa_supplicant is waiting for some of
those workqueues that are waiting for the lock:

  wpa_supplicant  D    0  2162      1 0x00004000
  Call Trace:
   __schedule+0x30b/0x4b0
   ? schedule+0x77/0xa0
   ? schedule_timeout+0x22/0x150
   ? ttwu_queue+0xf4/0x120
   ? wait_for_common+0xac/0x110
   ? __flush_work+0x200/0x230
   ? put_pwq+0x70/0x70
   ? __cfg80211_unregister_wdev+0x95/0x130 [cfg80211]
   ? ieee80211_if_remove+0xa3/0xe0 [mac80211]
   ? ieee80211_del_iface+0xe/0x20 [mac80211]
   ? rdev_del_virtual_intf+0x2b/0xc0 [cfg80211]
   ? genl_rcv_msg+0x451/0x570
   ? genl_unbind+0xb0/0xb0
   ? netlink_rcv_skb+0xfb/0x130
   ? genl_rcv+0x24/0x40
   ? netlink_unicast+0x1bf/0x2e0
   ? netlink_sendmsg+0x385/0x410
   ? ____sys_sendmsg+0x26b/0x290
   ? __sys_sendmsg+0x128/0x180
   ? selinux_socket_setsockopt+0xc3/0xd0
   ? __cgroup_bpf_run_filter_setsockopt+0x99/0x290
   ? netlink_setsockopt+0x38/0x4d0
   ? __sys_setsockopt+0x11b/0x1b0
   ? do_syscall_64+0x5e/0xd0
   ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

which explains why systemd waits for that one too.

So something seems to have never released the rtnl lock.

In fact, I suspect it's exactly that wpa_supplicant itself that
deadlocks on it and holds the rntl lock while it does that
"flush_work()". Which in turn waits for things to go away, but they'll
never go away because they need the rtnl lock. That wpa_supplicant is
holding.

If I were a betting man, I'd suspect it's due to commit 6cd536fe62ef
("cfg80211: change internal management frame registration API"), which
seems to move that

        flush_work(&wdev->mgmt_registrations_update_wk);

into __cfg80211_unregister_wdev(). But honestly, that's just a guess.

I'd bisect this and verify things, but I'm really hoping I don't have to.

I still have a number of pull requests for the merge window, so
instead I'm sending this email out with my current guesses, and I hope
someody will say "Yeah, you're right, the fix is already pending", or
"No Linus, you're barking up completely the wrong tree, but I think I
know what the problem is".

Btw, I'm not a networking person, but I have to say, I've seen rtnl
lock problems enough over time even as an outsider to have grown to
really hate that thing. Am I wrong? It really seems to get involved
much too much, and held in really awkward places.

Am I wrong?

             Linus
