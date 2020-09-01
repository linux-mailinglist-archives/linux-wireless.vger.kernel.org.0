Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3457225A11F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 00:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgIAWDW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 18:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgIAWDU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 18:03:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E511C061244
        for <linux-wireless@vger.kernel.org>; Tue,  1 Sep 2020 15:03:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id np15so1206253pjb.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Sep 2020 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=xf29w5ZRorDR80v6k3JL+r7JFaXlM3o04vM6D/u2oBY=;
        b=qHCfLTZGsmqd9JA97WtLIiyeYMiC1EdroS90GVK17Hz6xphOV47N5NpCVCmRIAbavU
         +RS76rVYYFO6sR2yy0iEeiOwxmLe+tYqrZ+0rmawajbhTd6K+lcb9G+MYYcVdLYq9+Ew
         OeGhvdE1xCtqqfAqb3ho4oE2Qd1QCbiQ8qlFbetROb0a/Db6NlCnBtAHJOYeiyYVbXSk
         LZz9ggVvXWLkligd2JpWhsVlAy+Q9JPufPlMQuzOgkVz/tzj4jTjK/wk9hgQ+Y5qFsDc
         vg12bXyvcF2AxNif3D1ekc2PEDMCPVEyd4w3XsI7BqTF4UGI8scjSobKlmM9l9bSEvZR
         2A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=xf29w5ZRorDR80v6k3JL+r7JFaXlM3o04vM6D/u2oBY=;
        b=YVIjeJwLV50gr4uRVq+pir4W1F1SUFopBl//IRMozi0j6Jl5qTZRfIAiTJ7Xp+kh64
         LvTWv2kQkV3usv7NSQNvjg/NcL2oK0yWDN7kgvxorE3TMC9dFgrriS1SKvDe5NdWrBv1
         PW7icdZMxmWTBS4xONMWOO/jYvkxwlEH2N+rDABmHW8sH+BmowiNFnvf2ISpoNdNmCif
         J1+3CoDG0J+cNGZ2gnF8D9GT+dTOMucXmAW4rz3pE++5epHEuhmgNsh5M8fvr9Fix6bP
         ODkEi3mxKUW8Yt8mR3LHm5kwUOxtyx8QA2rYu98ZwWDOhBpH/NJS0QryUjKCfhxvTXs7
         ti6A==
X-Gm-Message-State: AOAM533d+VTfMcIPaLiL2S9lMPVYV9DKQv075iT79CJwLftaGPJiJK58
        Pn+1AIDYv6wRteVLiO34aBs8t/U4Xp8=
X-Google-Smtp-Source: ABdhPJzN3QE0cKACwKJ3HwNh1xHOYH6VXRvtywfZuKr3/X4DasZik/XI3SJso4qYVcx7Sd+ZRM/wdw==
X-Received: by 2002:a17:902:8347:: with SMTP id z7mr3199723pln.20.1598997799061;
        Tue, 01 Sep 2020 15:03:19 -0700 (PDT)
Received: from localhost.localdomain (h208-100-161-218.bendor.broadband.dynamic.tds.net. [208.100.161.218])
        by smtp.gmail.com with ESMTPSA id t12sm2386483pjv.55.2020.09.01.15.03.18
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 15:03:18 -0700 (PDT)
Message-ID: <5252d41eae98ad26b0be91ec602da969ab8e7c8e.camel@gmail.com>
Subject: mac80211_hwsim crash
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 01 Sep 2020 15:03:17 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

In the past I had very rarely seen this crash but recently I've been
testing on a very slow system, and it now happens quite frequently.
Inside hwsim_cloned_frame_received_nl data2->channel is dereferenced,
and in some cases channel is NULL. Looks like channel doesnt get set
during radio creation, but in mac80211_hwsim_config which I presume is
called after radio creation. It would appear to be some kind of race
between creating/configuring the radio and beginning to send frames,
but I'm not entirely sure.

I am creating radios with HWSIM_CMD_NEW_RADIO and waiting until that
completes before doing anything with the radio.

I've tested on 5.6/5.8 with the same results.

[ 1335.541174] CPU: 0 PID: 982 Comm: hwsim Not tainted 5.8.0 #1
[ 1335.553946] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-2.fc32 04/01/2014
[ 1335.588370] RIP: 0010:hwsim_cloned_frame_received_nl+0x141/0x2c0
[ 1335.633025] Code: 00 00 00 8b 50 04 0f b7 44 24 1c 89 d1 66 25 00 e0
81 e2 ff 1f 00 00 66 81 e1 ff 1f 09 c8 66 89 44 24 1c 48 8b 83 18 18 00
00 <39> 50 04 74 19 48 8b 83 18 10 00 00 48 85 c0 0f 84 4f 01 00 00 39
[ 1335.681665] RSP: 0018:ffffa178405cbbe0 EFLAGS: 00010206
[ 1335.703231] RAX: 0000000000000000 RBX: ffff9a2eca6dde60 RCX:
000000000000096c
[ 1335.712436] RDX: 000000000000096c RSI: 0000000000000006 RDI:
ffff9a2eca6df690
[ 1335.745603] RBP: ffff9a2eca68b800 R08: ffff9a2eca709c18 R09:
00000000000000c0
[ 1335.776576] R10: ffff9a2eca64e400 R11: ffffffff846dacb0 R12:
ffffa178405cbc50
[ 1335.812124] R13: ffff9a2eca6df690 R14: ffff9a2eca709c24 R15:
ffffffff84b10b40
[ 1335.820314] FS:  00007f6317b0d640(0000) GS:ffff9a2ecb800000(0000)
knlGS:0000000000000000
[ 1335.856293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1335.868371] CR2: 0000000000000004 CR3: 000000000b5fa001 CR4:
0000000000060ef0
[ 1335.906576] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 1335.921470] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 1335.952264] Call Trace:
[ 1335.957465]  genl_rcv_msg+0x19b/0x2f0
[ 1335.963895]  ? genl_family_rcv_msg_attrs_parse.isra.0+0xd0/0xd0
[ 1335.976278]  netlink_rcv_skb+0x42/0x100
[ 1335.991219]  genl_rcv+0x1f/0x30
[ 1336.002191]  netlink_unicast+0x1f4/0x2c0
[ 1336.036764]  netlink_sendmsg+0x220/0x450
[ 1336.041537]  sock_sendmsg+0x59/0x60
[ 1336.049155]  __sys_sendto+0xe9/0x150
[ 1336.060180]  ? do_epoll_wait+0x220/0x580
[ 1336.068490]  __x64_sys_sendto+0x20/0x30
[ 1336.077108]  do_syscall_64+0x3e/0x70
[ 1336.089408]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1336.106558] RIP: 0033:0x7f6317a44de0
[ 1336.127514] Code: c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca
64 8b 04 25 18 00 00 00 85 c0 75 1d 45 31 c9 45 31 c0 b8 2c 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 68 c3 0f 1f 80 00 00 00 00 55 48 83 ec 20 48
[ 1336.196097] RSP: 002b:00007ffe55b8bb88 EFLAGS: 00000246 ORIG_RAX:
000000000000002c
[ 1336.221389] RAX: ffffffffffffffda RBX: 0000000001f8e740 RCX:
00007f6317a44de0
[ 1336.238485] RDX: 00000000000000d0 RSI: 0000000001f9fc00 RDI:
0000000000000004
[ 1336.273075] RBP: 0000000001f8eb80 R08: 0000000000000000 R09:
0000000000000000
[ 1336.291910] R10: 0000000000000000 R11: 0000000000000246 R12:
00007ffe55b8bbe0
[ 1336.323480] R13: 00007ffe55b8bbdc R14: 0000000001f8ec00 R15:
0000000000000000
[ 1336.340154] Modules linked in:
[ 1336.363292] CR2: 0000000000000004
[ 1336.388283] ---[ end trace 9fe6dbc18b5d98f1 ]---
[ 1336.393855] RIP: 0010:hwsim_cloned_frame_received_nl+0x141/0x2c0
[ 1336.401009] Code: 00 00 00 8b 50 04 0f b7 44 24 1c 89 d1 66 25 00 e0
81 e2 ff 1f 00 00 66 81 e1 ff 1f 09 c8 66 89 44 24 1c 48 8b 83 18 18 00
00 <39> 50 04 74 19 48 8b 83 18 10 00 00 48 85 c0 0f 84 4f 01 00 00 39
[ 1336.466208] RSP: 0018:ffffa178405cbbe0 EFLAGS: 00010206
[ 1336.486609] RAX: 0000000000000000 RBX: ffff9a2eca6dde60 RCX:
000000000000096c
[ 1336.498722] RDX: 000000000000096c RSI: 0000000000000006 RDI:
ffff9a2eca6df690
[ 1336.540164] RBP: ffff9a2eca68b800 R08: ffff9a2eca709c18 R09:
00000000000000c0
[ 1336.554221] R10: ffff9a2eca64e400 R11: ffffffff846dacb0 R12:
ffffa178405cbc50
[ 1336.572482] R13: ffff9a2eca6df690 R14: ffff9a2eca709c24 R15:
ffffffff84b10b40
[ 1336.589609] FS:  00007f6317b0d640(0000) GS:ffff9a2ecb800000(0000)
knlGS:0000000000000000
[ 1336.628275] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1336.648020] CR2: 0000000000000004 CR3: 000000000b5fa001 CR4:
0000000000060ef0
[ 1336.657632] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 1336.694036] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 1336.851713] mac80211_hwsim: wmediumd released netlink socket,
switching to perfect channel medium

