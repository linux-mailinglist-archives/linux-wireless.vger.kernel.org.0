Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3C12655DB
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 01:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgIJX5X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 19:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgIJX5R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 19:57:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53739C061573
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 16:57:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q4so810231pjh.5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 16:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KWVg2MCHn7g+sGvnF2RykV+WUczNo9MCGMpv05VM9A=;
        b=ospAo1KOdLOtQq/8sk4bedijZsp7XYo6OVg3foANKVAg6BFDOSYZ+mnMdpGdFBu6wN
         m29T75qiNJ4hnaAjMk268jvDw11LPUOZ5uD0dAmPFvzSNBifV5fUbYTynbiiC9apCmem
         iyqwp2kTfrn4De+UuYPva0ZixgODZfGJslScw87T6Y/KAh48PxtWH7XdsJGCkDGzgmb5
         6z8I17rUlDUwZCeWwjOnO7M0uo486Gq9+7EBtQz/Tn59NJZMzpLkUIXuXZwYh2VX/PiA
         /oqrtx6Bt04oJBjINATtYxF8K3TM+WZV/Tn/S2znp4wR6/dn9T84qUkTjCC9QA52FP9q
         RgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KWVg2MCHn7g+sGvnF2RykV+WUczNo9MCGMpv05VM9A=;
        b=c/hzqn0oM2QkucyuJmDjb5U2qT1V0VrcFbNRVVjLkJKB2boSdpIJ1VB+Kfves531Hp
         gJl56AXV8UHu8v6fDu9JPOTvS+n66R6kTnttFWKlxVkBLYb+S4gEFVuzwTCS21R9bZWV
         wJiMPVcdBAuZ53nNB/+dnVa7ygrNTFkBKWLTgUnU4zEJm3AVrCoL0PptdSDL99d/SJek
         Fdtxn7ksoyLoqDYFDeb5T0VdFJ17G2b18RwTAz5FCKK2BnSIwwYZtNoE46zUFWW3nah+
         iBSTqfAP25XFh35Y5RRoqwOLuGkI9mnMm0i8xhim6XZFAgT6Lg6+P/kZ7h/8LResyOw+
         UEIw==
X-Gm-Message-State: AOAM531LGQ+OhTUw8JnuwAVukIH27/379GGmmMOul6FTEsO336C3eleU
        WJFya6PFM+BnItEYjD7yWQAor09nG8s=
X-Google-Smtp-Source: ABdhPJyVxaK86IBT3uQO0P5WeyD/9ZDB+y1iX8LV9ztyIMTloCF0Q6ORLbVv4yYPYMbr3vUeERW0Bg==
X-Received: by 2002:a17:90a:6848:: with SMTP id e8mr2131948pjm.221.1599782234675;
        Thu, 10 Sep 2020 16:57:14 -0700 (PDT)
Received: from host-29.home (50-126-102-83.drr01.csby.or.frontiernet.net. [50.126.102.83])
        by smtp.gmail.com with ESMTPSA id m5sm149957pjn.19.2020.09.10.16.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:57:13 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/1] mac80211_hwsim: fix crash when receiving frame
Date:   Thu, 10 Sep 2020 16:57:07 -0700
Message-Id: <20200910235707.7732-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910235707.7732-1-prestwoj@gmail.com>
References: <20200910235707.7732-1-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This crash has rarely happened to me on bare metal, but when running
in a virtual environment it happens much more frequently. It would
appear that the mac80211_hwsim_data (data2) obtained from
get_hwsim_data_ref_from_addr() is not fully initialized. When the
crash happens the 'channel' member (ieee80211_channel*) is NULL. This
is not checked for and eventually dereferenced which causes the
segmentation fault.

The actual dereference happens around line 3536 (as of 5.8) in this
if statement for checking if the frame is offchannel:

if (rx_status.freq != data2->channel->center_freq &&
	(!data2->tmp_chan ||
	rx_status.freq != data2->tmp_chan->center_freq)) {
		mutex_unlock(&data2->mutex);
		goto out;
}

Below is the crash:

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
---
 drivers/net/wireless/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 1356e8cbe617..c6a5987e9933 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3506,7 +3506,7 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	skb_put_data(skb, frame_data, frame_data_len);
 
 	data2 = get_hwsim_data_ref_from_addr(dst);
-	if (!data2)
+	if (!data2 || !data2->channel)
 		goto out;
 
 	if (!hwsim_virtio_enabled) {
-- 
2.26.2

