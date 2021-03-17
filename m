Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8DC33FB84
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Mar 2021 23:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCQWwb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Mar 2021 18:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhCQWwT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Mar 2021 18:52:19 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC95CC06174A
        for <linux-wireless@vger.kernel.org>; Wed, 17 Mar 2021 15:52:18 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id v17so287608iot.6
        for <linux-wireless@vger.kernel.org>; Wed, 17 Mar 2021 15:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WXYhupZX2ErX4pBb43XWlz6FEpr8DfumfrBgRMgf4oc=;
        b=P3V2kK+7GdN+ByajsL4nuy6OImCiG0lgUrScudL77h2Rq4Bb0bFNIz82GTqqZFzYwm
         G6gIcFPY61Wm56biJKPNJFepLRo/5BwfRL1gLiaO0TNVVNhJFWFs7Oyd/LUGQNld58t/
         ccOKHcEklI0qD3MEDjeaSbJTJ/BMxeYFXX403QI3QNCXn6uuYIDyVsoykheWYN2DSeZp
         r4iLCko0sZOXWxeAms8d209h6ZOx/cP3k9qm5O7kfJAeaObNm6Qd2GaMF5rgqG11o/A5
         4CNCBlODRs1VEzrGogoVlS/dcSV96bPaWBONZC96BDmsk2vLwvHvRx/SQ9aXwIPwjzFa
         hrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WXYhupZX2ErX4pBb43XWlz6FEpr8DfumfrBgRMgf4oc=;
        b=EWBSUiz3a6tFhX9RebhiD7O3qv43xFVl14JogIUo+urF9v5i52/lZgmjU200+LrWpy
         nOhdJmJ1L+FaN0b+CC6xlCbvOHPsNu/cCeo+kGbaqasHSBRUCqN6xQt08DlsQf/4qowk
         +A1nHdR8SYMvXLBbZixDPaLD4VDVAVEupTl8ZRf0B8nV9PDEptNmu+zoLQZJKoZxY9hD
         2Usp6aO+Od7/5U8Kpx2cCqHP/C2HXY5BCVce7NZ1PTtmnDKS3NzdD/MaoOxJ8xoTc4lQ
         MrS/R5icrgLrHSa/tFaDJ3QZA61+TwskcBCP+umiWIh620N3G5uzPWYrkmLN0LryLqp8
         j3AA==
X-Gm-Message-State: AOAM530M8ctJLLEKAfY61F37BhMfPWOOT3XgLhcYYec87WOs0m+gmcze
        VKMU7ApT5EIals8sdgI3DAx1mWWBl4Q+H0VpxJHqn+9oMUes6g==
X-Google-Smtp-Source: ABdhPJyfEF3n1rSUW9jL3T4A4f6g1HbLD3uM8AGIwhynHyzThu57D4ItfKvR8sXBMezKb292Wdy4CS7YhRLo6Sjhsqc=
X-Received: by 2002:a5d:9285:: with SMTP id s5mr8392522iom.139.1616021538161;
 Wed, 17 Mar 2021 15:52:18 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 17 Mar 2021 15:52:07 -0700
Message-ID: <CAMn1gO7evHe+pvcFwv1XE+y090CSWwXL=pRKjZwmnrZa3j4gtg@mail.gmail.com>
Subject: Re: [PATCH v2] cfg80211: avoid holding the RTNL when calling the driver
To:     johannes.berg@intel.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

I'm seeing warnings like this on 5.12.0-rc2 which I think were caused
by your patch.

[    4.898946][  T455] ------------[ cut here ]------------
[    4.899434][  T455] RTNL: assertion failed at net/core/dev.c (10988)
[    4.900191][  T455] WARNING: CPU: 1 PID: 455 at
net/core/dev.c:10988 dev_change_net_namespace+0x680/0x730
[    4.901042][  T455] Modules linked in: zram zsmalloc
vmw_vsock_virtio_transport virtio_pmem virtio_pci
virtio_pci_modern_dev virtio_net virtio_mmio virtio_input
virtio_console virtio_blk virtio_rng virtio_gpu virtio_dma_buf
vexpress_sysreg system_heap snd_hda_intel snd_intel_dspcfg
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec snd_hda_core
rtc_test psmouse net_failover nd_virtio md_mod mac80211_hwsim
ledtrig_audio hci_vhci goldfish_sync(O) goldfish_pipe(O)
goldfish_battery(O) goldfish_address_space(O) failover dummy_hcd
dummy_cpufreq clk_vexpress_osc vexpress_config armmmci ambakmi
[    4.906291][  T455] CPU: 1 PID: 455 Comm: iw Tainted: G           O
     5.12.0-rc2-mainline-08319-g19e2e1d25c10 #1
[    4.907475][  T455] Hardware name: linux,ranchu (DT)
[    4.907988][  T455] pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[    4.908627][  T455] pc : dev_change_net_namespace+0x680/0x730
[    4.909168][  T455] lr : dev_change_net_namespace+0x680/0x730
[    4.909725][  T455] sp : ffffffc012df3830
[    4.910118][  T455] x29: ffffffc012df3870 x28: ffffff800dd8b240
[    4.910693][  T455] x27: ffffff801ca76000 x26: 0000000000000008
[    4.911212][  T455] x25: ffffff801cac3210 x24: ffffffc011b5ac40
[    4.911848][  T455] x23: ffffff801ca768e0 x22: ffffffc011798506
[    4.912382][  T455] x21: ffffffc011b5ac40 x20: ffffff800db0b240
[    4.912793][  T455] x19: ffffff801cb00000 x18: ffffffc012549080
[    4.913200][  T455] x17: 0000000000000006 x16: 000000000000b70d
[    4.913612][  T455] x15: 0000000000000019 x14: 02a5000000000000
[    4.914135][  T455] x13: 0000000000000000 x12: 000000005c961000
[    4.914752][  T455] x11: ffffffc0119d6070 x10: 0000000000000000
[    4.915238][  T455] x9 : a0858573fdaceb00 x8 : a0858573fdaceb00
[    4.915836][  T455] x7 : ffffffc011715fa9 x6 : 0000000000000003
[    4.916352][  T455] x5 : 0000000000000001 x4 : 0000000000000001
[    4.916909][  T455] x3 : ffffff800dd8b240 x2 : ffffff807fbb5988
[    4.917411][  T455] x1 : 0000000000000000 x0 : 0000000000000030
[    4.918034][  T455] Call trace:
[    4.918327][  T455]  dev_change_net_namespace+0x680/0x730
[    4.918827][  T455]  cfg80211_switch_netns+0x90/0x1b8
[    4.919305][  T455]  nl80211_wiphy_netns+0x6c/0xf0
[    4.919772][  T455]  genl_rcv_msg+0x3c0/0x3ec
[    4.920163][  T455]  netlink_rcv_skb+0x108/0x124
[    4.920650][  T455]  genl_rcv+0x38/0x54
[    4.920955][  T455]  netlink_unicast_kernel+0xa0/0x140
[    4.921484][  T455]  netlink_unicast+0xfc/0x1a4
[    4.921918][  T455]  netlink_sendmsg+0x28c/0x320
[    4.922363][  T455]  ____sys_sendmsg+0x17c/0x234
[    4.922786][  T455]  __sys_sendmsg+0x190/0x1e8
[    4.923183][  T455]  __arm64_sys_sendmsg+0x28/0x38
[    4.923557][  T455]  el0_svc_common+0x94/0x118
[    4.923921][  T455]  do_el0_svc+0x28/0x88
[    4.924223][  T455]  el0_svc+0x2c/0x90
[    4.924582][  T455]  el0_sync_handler+0x88/0xec
[    4.925113][  T455]  el0_sync+0x194/0x1c0
[    4.925572][  T455] ---[ end trace 8f99239e8a4e6dad ]---
[    4.926322][  T455] ------------[ cut here ]------------

Peter
