Return-Path: <linux-wireless+bounces-9971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C28B8926DF2
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 05:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7DA1F22F18
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 03:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B251C68E;
	Thu,  4 Jul 2024 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gzc/q9RC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3031B7F7
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062776; cv=none; b=tMEBu6BPD3MIneZEjrjoageP+/EsF88He5wcQGJbqnIwSD/Q6jNSEjvqCRlaLB/dOdXtVrpufL66Jmi+Phi9vhUwmJcV6P3ovrOByQ5ZMNk6Il4wGQ9MeUY2XJ64hEmYE1BHzdRUj612ZXFAAwima+e6RahrtFZEAv/czwT8JbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062776; c=relaxed/simple;
	bh=N3jvDr3JfXpSH80XKHxOYUSM+5NMqWRrjE1KfKN8c/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edIoS82XGEbgiSwE9b+a3HggmCtjtKFGb3e4r8VQb0gwctJcb9jOe8sZeHoAopxHWjGWPdJaR2Vq5zr5Axwlx/vo+a0lXxcZIglowQX/vXjlBkt6gvP2ZECM3nSu1do4cJI5/nGm/o3x2fWFa6tnyxS22CCsgmNJsPsQ34PmTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=gzc/q9RC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CB0833F0D2
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 03:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720062766;
	bh=9CRBUg6uYodxq5mWT1CMKFQBlvPAVSqkA4Ock1rCT/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=gzc/q9RCZswEDzbkpoUWvbM2bagqCASDBXx7sMkEsV66rFJDX1j3/X1MknIzxtBLU
	 MTb5jgCFsScz1n2dx2/xJK5VJKDchbUAFPcSjvI25JDexWPj516Mv56D76fGmYrjjA
	 u4J5F2bVNYG+4VYgphLyLch3wiWPQaAL0oDgsV2bdRJDAPKlJtF9isVLvLaiGSqs1o
	 +XFaihPCs+asdFuwIMCXhFs+WsILfMnZ8kDqWFV7SgXHwl/iy0u36LOOIWl2OQWZ+N
	 fxU9+yfmeya+4X/SD6Q34zHCnYH2rMzkeg9xdV8RsBF2wcEK6iNKqw7ZfFE6L509zm
	 2I0XRTZzSYR9A==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367a058fa21so2104f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 20:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720062766; x=1720667566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CRBUg6uYodxq5mWT1CMKFQBlvPAVSqkA4Ock1rCT/I=;
        b=JdpiX4HkqHfszAgqzj6XARg+14Pgbr8q8IU8t5LQ0z33nb2ZUIEazIv2yZYNTxdPKS
         sbK+w4dWLYBLph5MsV4usJLBRD9F2E9OeZt9u4MVZQeHjTK+rPkQ8OBJfZ1nqYP17Gyb
         j/Yd+v/VADmevs3YxOmIbEeOrxipigBeFKstw9FTwakhgJVr9lqwdlkCGUzTCo9jK8TZ
         tXMo5HJ5EaQEl74GzlnGuivnsSHlMlvOlNuAPHOuQhHbSh9sVXJzp0Us9VOFv0vtjWi3
         X19i1ZOT3TJ4QyY0Ef/4LwduJOBX2v6xW9BYoQmaMAhuTzCx/Z7Xpc9Hcj83Mwl0sKUX
         xmNw==
X-Forwarded-Encrypted: i=1; AJvYcCVU/GfpVVk30Eq7Yx5/YmV3Biu+IjGBcYwVlDpNh+bFnd3nNolbheUqCVfp7QywXVN/Aw1VzAw57O+4P0NJXM8LmAxz0p1wGeatoZN+Cjg=
X-Gm-Message-State: AOJu0YzSrDfdX8tqXdEp4Wzrvscwzctc9+RhUZ+ZuKwObzpmsoLoC1nC
	zt4cKR6Vgi8M8cLs6ZXDVkvnjzME0m2zLYbW9EmrErB5+d2RUhmzHlcEysShaGpoUS4FvnPMYdE
	XOSFZDy6ifapWGNE6Cv6GOFlXRv0mWYb+y7Tr8DUzFWLAe4STgBK0xN+YM4kgCm65LiMkWvd6gD
	JFAcIFod+du4ZnGZToYtDK7dae4tEutnVq8cFQnZj8dXOuuFIprUzWE+8=
X-Received: by 2002:adf:ab08:0:b0:363:1c9d:d853 with SMTP id ffacd0b85a97d-3679f76ff77mr101465f8f.32.1720062766195;
        Wed, 03 Jul 2024 20:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn6MiLj8RUEc8lEGjRSroyBGNAuvBKodyxkFScqCVq3jn3pc7i39ziH4b/m9XkweOdBJGRi8WttaTMVbS+zA0=
X-Received: by 2002:adf:ab08:0:b0:363:1c9d:d853 with SMTP id
 ffacd0b85a97d-3679f76ff77mr101460f8f.32.1720062765721; Wed, 03 Jul 2024
 20:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704030304.16213-1-en-wei.wu@canonical.com>
In-Reply-To: <20240704030304.16213-1-en-wei.wu@canonical.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Thu, 4 Jul 2024 11:12:34 +0800
Message-ID: <CAMqyJG1=uCoYzy12ONEoxh3Oc_VSLVJGqzwwxfj2JqL8LPneEg@mail.gmail.com>
Subject: Re: [PATCH] wifi: virt_wifi: avoid reporting connection success with
 wrong SSID
To: kvalo@kernel.org, edumazet@google.com, davem@davemloft.net, 
	en-wei.wu@canonical.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: rickywu0421@gmail.com, 
	syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

After applying this patch and testing on the machines of syzbot, the
original warning is gone. However, syzbot reported that there is
another warning generated:

     create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
     unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
     ksys_unshare+0x619/0xc10 kernel/fork.c:3323
     __do_sys_unshare kernel/fork.c:3394 [inline]
     __se_sys_unshare kernel/fork.c:3392 [inline]
     __x64_sys_unshare+0x38/0x40 kernel/fork.c:3392
     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
     do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
WARNING: CPU: 1 PID: 11 at lib/ref_tracker.c:179
ref_tracker_dir_exit+0x411/0x550 lib/ref_tracker.c:179
Modules linked in:
CPU: 1 PID: 11 Comm: kworker/u8:0 Not tainted
6.10.0-rc5-syzkaller-01200-gcda91d5b911a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 06/07/2024
Workqueue: netns cleanup_net
RIP: 0010:ref_tracker_dir_exit+0x411/0x550 lib/ref_tracker.c:179
Code: 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 88 f2 ab 06 eb 1a e8 f1
b7 ad fc 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 70 f2 ab 06 90 <0f> 0b
90 48 83 c3 44 48 89 df be 04 00 00 00 e8 5b 7f 13 fd 48 89
RSP: 0018:ffffc900001079e0 EFLAGS: 00010246
RAX: 2ba763440467a200 RBX: ffff8880296b9ed8 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcabb40 RDI: 0000000000000001
RBP: ffffc90000107ab0 R08: ffffffff92fbc66f R09: 1ffffffff25f78cd
R10: dffffc0000000000 R11: fffffbfff25f78ce R12: 1ffff1100da640d8
R13: dead000000000100 R14: ffff8880296b9f28 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b2700a0950 CR3: 000000002c8b0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 net_free net/core/net_namespace.c:465 [inline]
 cleanup_net+0xbf3/0xcc0 net/core/net_namespace.c:661
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

It looks like it's not related to the changes I have made, since the
new warning is probably describing a leak when doing net_free. I will
look at the new warning soon, and maybe we can just focus on the
original warning now.

En-Wei.


On Thu, 4 Jul 2024 at 11:03, En-Wei Wu <en-wei.wu@canonical.com> wrote:
>
> When user issues a connection with a different SSID than the one
> virt_wifi has advertised, the __cfg80211_connect_result() will
> trigger the warning: WARN_ON(bss_not_found).
>
> The issue is because the connection code in virt_wifi does not
> check the SSID from user space (it only checks the BSSID), and
> virt_wifi will call cfg80211_connect_result() with WLAN_STATUS_SUCCESS
> even if the SSID is different from the one virt_wifi has advertised.
> Eventually cfg80211 won't be able to find the cfg80211_bss and generate
> the warning.
>
> Fixed it by checking the SSID (from user space) in the connection code.
>
> Fixes: c7cdba31ed8b ("mac80211-next: rtnetlink wifi simulation device")
> Reported-by: syzbot+d6eb9cee2885ec06f5e3@syzkaller.appspotmail.com
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> ---
>  drivers/net/wireless/virtual/virt_wifi.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
> index 6a84ec58d618..86a8f74be654 100644
> --- a/drivers/net/wireless/virtual/virt_wifi.c
> +++ b/drivers/net/wireless/virtual/virt_wifi.c
> @@ -136,6 +136,9 @@ static struct ieee80211_supported_band band_5ghz = {
>  /* Assigned at module init. Guaranteed locally-administered and unicast. */
>  static u8 fake_router_bssid[ETH_ALEN] __ro_after_init = {};
>
> +#define VIRT_WIFI_SSID_LEN 8
> +#define VIRT_WIFI_SSID "VirtWifi"
> +
>  static void virt_wifi_inform_bss(struct wiphy *wiphy)
>  {
>         u64 tsf = div_u64(ktime_get_boottime_ns(), 1000);
> @@ -146,8 +149,8 @@ static void virt_wifi_inform_bss(struct wiphy *wiphy)
>                 u8 ssid[8];
>         } __packed ssid = {
>                 .tag = WLAN_EID_SSID,
> -               .len = 8,
> -               .ssid = "VirtWifi",
> +               .len = VIRT_WIFI_SSID_LEN,
> +               .ssid = VIRT_WIFI_SSID,
>         };
>
>         informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
> @@ -213,6 +216,8 @@ struct virt_wifi_netdev_priv {
>         struct net_device *upperdev;
>         u32 tx_packets;
>         u32 tx_failed;
> +       u32 connect_requested_ssid_len;
> +       u8 connect_requested_ssid[IEEE80211_MAX_SSID_LEN];
>         u8 connect_requested_bss[ETH_ALEN];
>         bool is_up;
>         bool is_connected;
> @@ -224,11 +229,21 @@ static int virt_wifi_connect(struct wiphy *wiphy, struct net_device *netdev,
>                              struct cfg80211_connect_params *sme)
>  {
>         struct virt_wifi_netdev_priv *priv = netdev_priv(netdev);
> +       u32 ssid_len;
>         bool could_schedule;
>
>         if (priv->being_deleted || !priv->is_up)
>                 return -EBUSY;
>
> +       if (!sme->ssid) {
> +               wiphy_err(wiphy, "invalid SSID\n");
> +               return -EINVAL;
> +       }
> +
> +       ssid_len = min_t(u32, sme->ssid_len, IEEE80211_MAX_SSID_LEN);
> +       priv->connect_requested_ssid_len = ssid_len;
> +       memcpy(priv->connect_requested_ssid, sme->ssid, ssid_len);
> +
>         could_schedule = schedule_delayed_work(&priv->connect, HZ * 2);
>         if (!could_schedule)
>                 return -EBUSY;
> @@ -252,12 +267,15 @@ static void virt_wifi_connect_complete(struct work_struct *work)
>                 container_of(work, struct virt_wifi_netdev_priv, connect.work);
>         u8 *requested_bss = priv->connect_requested_bss;
>         bool right_addr = ether_addr_equal(requested_bss, fake_router_bssid);
> +       bool right_ssid = (priv->connect_requested_ssid_len == VIRT_WIFI_SSID_LEN ?
> +                         !memcmp(priv->connect_requested_ssid, VIRT_WIFI_SSID,
> +                                 priv->connect_requested_ssid_len) : false);
>         u16 status = WLAN_STATUS_SUCCESS;
>
>         if (is_zero_ether_addr(requested_bss))
>                 requested_bss = NULL;
>
> -       if (!priv->is_up || (requested_bss && !right_addr))
> +       if (!priv->is_up || (requested_bss && !right_addr) || !right_ssid)
>                 status = WLAN_STATUS_UNSPECIFIED_FAILURE;
>         else
>                 priv->is_connected = true;
> --
> 2.43.0
>

