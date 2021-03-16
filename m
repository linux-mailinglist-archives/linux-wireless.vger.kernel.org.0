Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA3F33DDB5
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Mar 2021 20:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240503AbhCPTln (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Mar 2021 15:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhCPTlR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Mar 2021 15:41:17 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84CAC06174A
        for <linux-wireless@vger.kernel.org>; Tue, 16 Mar 2021 12:41:16 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id v123so18873591vsv.9
        for <linux-wireless@vger.kernel.org>; Tue, 16 Mar 2021 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zcv5khHyaz47hytmZLdha7wMh/6R2lIiB6Z7Z8e4kNM=;
        b=o3Q1Mpmu7xv205oFcUDfGuCfbgY7ziDm8THTyiMsXFURa/Mlhm7CGDCsMm5+nwBs60
         BFT+UtFH3Ew1hvwNpxlnKPjqdNeHP4EpJEqQFTqer4VmI7CzixI+AlU9Pz+b7tTabgWl
         6kqEAMc8NTPXdCCJ90KJyganvgEmAwrFJzV+zqgfq1mvS7By2DsrQrGgCpg3E2IHo/6K
         NS01rP9Z15uXEFb1KVcfFEcJRHXZsvKVKo2I1XHhqXFKHgnh8HxB8+kqjVTASiSN0Biq
         R33FibVVVawEW1FP4L0X08wB/yhoYoZX6IRuesszvOj+wEssTqKRzKbqvkuppQbL2+r6
         GSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zcv5khHyaz47hytmZLdha7wMh/6R2lIiB6Z7Z8e4kNM=;
        b=QjlaqhSAEHDEVpFh2Bk4QrYTVvcwT+tbO21E6rQDpBwV6zU6Rii+guMANihonfGuOh
         zPstAlNAS+o9h0Br8PIq2FaoiUPD3hODgubAxN4w3JfypxlW61Lh98v/39zxGHvytLME
         y2N0bEcsmJwGmCZ/dHGFyw4YbZb5t3hrcv23rh8b/LEZtkW76Cc7D/O6hPr8acVfye0v
         Tug7gRWL9VTy3WzpJwFZYofZ01dSUueGFU9eJumlzBEkafwbZ311RpOQvS9bMzckUmQ7
         fYsYCV9nXqZJxKgULmO1AWvByUkE64P8doxd5TPW1WRuL9Ou8wplXRF6QMk9eyFPyct6
         dUmg==
X-Gm-Message-State: AOAM531HcuIp9SIVnJvGXAUfeqqGhNNwpAgjJk7MXcYqbEFBWnwRVAmi
        2ROhbelscunXsm4PtkfeHyfjjL88+WU8UtRmh5Y=
X-Google-Smtp-Source: ABdhPJyOM2hxhmLzZmwqALzddGVVwgGn3iR6ZbC7L/NLFgyZmFCVXDTe7gkgFbfX+elzFqxxfpcQI37m1rzK6wey48M=
X-Received: by 2002:a67:27c7:: with SMTP id n190mr1283508vsn.4.1615923675862;
 Tue, 16 Mar 2021 12:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <28fee372-0dc6-6351-2b1d-c79e924952a5@secunet.com>
In-Reply-To: <28fee372-0dc6-6351-2b1d-c79e924952a5@secunet.com>
From:   Sid Hayn <sidhayn@gmail.com>
Date:   Tue, 16 Mar 2021 15:41:06 -0400
Message-ID: <CAM0KTbCBXr8Rie3F7htE9bwhtL5=8azD-b+MkU-ozUg9zV++zQ@mail.gmail.com>
Subject: Re: [iwlwifi] v5.12-rc1: Unable to move phy0 to other network namespace
To:     Torsten Hilbrich <torsten.hilbrich@secunet.com>
Cc:     luciano.coelho@intel.com,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The fix for this was submitted as [PATCH] nl80211: fix locking for
wireless device netns change

It looks like johill needs to accept his own change still:
https://patchwork.kernel.org/project/linux-wireless/patch/20210310215839.eadf7c43781b.I5fc6cf6676f800ab8008e03bbea9c3349b02d804@changeid/

Thanks,
Zero

On Tue, Mar 16, 2021 at 2:48 PM Torsten Hilbrich
<torsten.hilbrich@secunet.com> wrote:
>
> Hello,
>
> starting with kernel v5.12-rc1 (and still not working in v5.12-rc3) I'm no longer able to move a wlan interface into another namespace.
>
> I have created a new network namespace, like in the following example:
>
> # ip netns add black
>
> Then I move the phy0 interface to that network namespace. I then expect the wlan0 interface to be removed from the initial network namespace and then to appear in the new one.
>
> # iw phy phy0 set netns name black
>
> However, starting with v5.12-rc1 (last known to be working with v5.11) the command never finishes execution. Instead, I get a number of rntl warnings and a soft hangup.
>
> Kernel log is attached.
>
> Here some relevant excerpts:
>
> 2021-03-16 11:26:49.124 kernel: iwlwifi 0000:3a:00.0: Detected Intel(R) Dual Band Wireless AC 8265, REV=0x230
>
> 2021-03-16 11:27:14.269 kernel: WARNING: CPU: 0 PID: 467 at net/core/dev.c:10988 dev_change_net_namespace+0x44d/0x480
> 2021-03-16 11:27:14.269 kernel: WARNING: CPU: 0 PID: 467 at net/core/dev.c:381 unlist_netdevice+0xdb/0xf0
> 2021-03-16 11:27:14.275 kernel: WARNING: CPU: 0 PID: 467 at net/core/dev.c:2054 call_netdevice_notifiers_info+0x7c/0x80
> 2021-03-16 11:27:14.275 kernel: WARNING: CPU: 0 PID: 467 at net/core/fib_rules.c:1227 fib_rules_event+0x18f/0x1a0
> 2021-03-16 11:27:14.275 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/devinet.c:1526 inetdev_event+0x39f/0x5c0
> 2021-03-16 11:27:14.276 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/devinet.c:309 inetdev_event+0x4a9/0x5c0
> 2021-03-16 11:27:14.276 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/igmp.c:1793 ip_mc_destroy_dev+0x67/0x70
> 2021-03-16 11:27:14.277 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/igmp.c:1721 ip_mc_down+0x84/0x90
> 2021-03-16 11:27:14.277 kernel: WARNING: CPU: 0 PID: 467 at net/ipv4/igmp.c:1664 __ip_mc_dec_group+0x162/0x1a0
>
> 2021-03-16 11:27:14.278 kernel: ---[ end trace 6b632a15496dddfa ]---
> 2021-03-16 11:30:24.753 kernel: INFO: task iw:467 blocked for more than 122 seconds.
> 2021-03-16 11:30:24.753 kernel:       Tainted: P        W  O      5.12.0-devel+ #1
> 2021-03-16 11:30:24.753 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 2021-03-16 11:30:24.753 kernel: task:iw              state:D stack:12720 pid:  467 ppid:   457 flags:0x00004000
> 2021-03-16 11:30:24.753 kernel: Call Trace:
> 2021-03-16 11:30:24.753 kernel:  __schedule+0x275/0x660
> 2021-03-16 11:30:24.753 kernel:  schedule+0x3c/0xa0
> 2021-03-16 11:30:24.753 kernel:  schedule_preempt_disabled+0xa/0x10
> 2021-03-16 11:30:24.753 kernel:  __mutex_lock.isra.12+0x2c7/0x4c0
> 2021-03-16 11:30:24.753 kernel:  ? trace_hardirqs_on+0x2a/0xb0
> 2021-03-16 11:30:24.753 kernel:  ? skb_dequeue+0x57/0x70
> 2021-03-16 11:30:24.753 kernel:  cfg80211_netdev_notifier_call+0x23d/0x3e0
> 2021-03-16 11:30:24.753 kernel:  raw_notifier_call_chain+0x41/0x50
> 2021-03-16 11:30:24.753 kernel:  dev_change_net_namespace+0xe1/0x480
> 2021-03-16 11:30:24.753 kernel:  ? __rtnl_unlock+0x25/0x50
> 2021-03-16 11:30:24.753 kernel:  cfg80211_switch_netns+0x65/0x1c0
> 2021-03-16 11:30:24.753 kernel:  nl80211_wiphy_netns+0x4b/0xc0
> 2021-03-16 11:30:24.753 kernel:  genl_family_rcv_msg_doit.isra.17+0x10f/0x150
> 2021-03-16 11:30:24.753 kernel:  genl_rcv_msg+0xde/0x1e0
> 2021-03-16 11:30:24.753 kernel:  ? nl80211_authenticate+0x310/0x310
> 2021-03-16 11:30:24.753 kernel:  ? genl_family_rcv_msg_doit.isra.17+0x150/0x150
> 2021-03-16 11:30:24.753 kernel:  netlink_rcv_skb+0x50/0x100
> 2021-03-16 11:30:24.753 kernel:  genl_rcv+0x24/0x40
> 2021-03-16 11:30:24.754 kernel:  netlink_unicast+0x1a5/0x280
> 2021-03-16 11:30:24.754 kernel:  netlink_sendmsg+0x21b/0x450
> 2021-03-16 11:30:24.754 kernel:  sock_sendmsg+0x5b/0x60
> 2021-03-16 11:30:24.754 kernel:  ____sys_sendmsg+0x1ad/0x1e0
> 2021-03-16 11:30:24.754 kernel:  ? copy_msghdr_from_user+0x5c/0x90
> 2021-03-16 11:30:24.754 kernel:  ___sys_sendmsg+0x84/0xc0
> 2021-03-16 11:30:24.754 kernel:  ? do_filp_open+0xa7/0x100
> 2021-03-16 11:30:24.754 kernel:  __sys_sendmsg+0x51/0x90
> 2021-03-16 11:30:24.754 kernel:  do_syscall_64+0x33/0x40
> 2021-03-16 11:30:24.754 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
>
> With regards,
>
>         Torsten
>
