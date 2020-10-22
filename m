Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D49296489
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Oct 2020 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902422AbgJVST0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Oct 2020 14:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902393AbgJVST0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Oct 2020 14:19:26 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92695C0613CE
        for <linux-wireless@vger.kernel.org>; Thu, 22 Oct 2020 11:19:26 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id h10so2738813oie.5
        for <linux-wireless@vger.kernel.org>; Thu, 22 Oct 2020 11:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Iul3HKf6GvF8Napjkc1eLX9WQ6qH5CDvr2prxmBwu6c=;
        b=mcJm9EtL82LNR92TatSfHUdO+2JiVUmlMCfD1Qe+7X6DBAT2sfesZ6SpxQ3HLCQmVO
         8osAdHOxrn61f0yItjG/zPWR7rsKmoxIATQMSiFwV2QZOi1IwP1XqThkIUqj+OanhCEZ
         kD3+PO28chjYgjpckSFLIDbLB2PfIWwfOchtLUHtLWbPiHOr6Yg7adGyzQoNjUcolpmW
         ACWpMWl1MVo+5wEnsYAPBOabj/YC/0F3ypEVza4aogm3Hj5VKxRXmz54JGlVc+Nv+z6e
         +7Rqq3Vc1jzm5qN7X7rEGAIpTdzM5dV4N0K5T36fmVBEqyHx/jsdjLXsmxXaeZX8QrB/
         Z+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Iul3HKf6GvF8Napjkc1eLX9WQ6qH5CDvr2prxmBwu6c=;
        b=iiKOFLrto1saiMu9KwWhYSUlILGOT1Zl5CYAvAEfVUx5KeCUosZT2nI7fUHLDYFSek
         5QcPLPGz0GiqXT1IVtBLhr/sY0QvTRpfYZSvYrbAE9JYYw9YrXSCUqbA/CPBjXWcwXZ7
         VVTYf4FFaVa/b4+mIC1pfDaxmAuBUNz7phjqdCE4VcmZC7EiUTwuv9oOxRrQLehNjgcZ
         s8340aTt8XOVfEd4WJJoZCeSMM7pn8/1x0TSSCDCoIcvNkDqDTdgC+wyZQ830ok4DnzA
         7CE8b+nIO1uwKhJTdodudePxYzpMZZ6ZuDOfSgbUYxQ0MlnFg4x3Dhp1kcyR0dJtO94v
         oRQQ==
X-Gm-Message-State: AOAM532lcfUQILsw5kc+V2+jmAmBKkoMQiaFnsgE9W7PTq1ZXA5EfkcC
        qOT4AQI9EwI2pG+NtEkaugo7eXwIoTce8aEqnwafLNn5eztNDw==
X-Google-Smtp-Source: ABdhPJzMOJ1elYAxWuE4dw0wvSvNa8gYtKv7mu0wGH1W4YtoQB9595soXQa1rjUqh2z+bSnE85OHDqro1AU71bPL+Nc=
X-Received: by 2002:aca:918:: with SMTP id 24mr2490154oij.179.1603390765516;
 Thu, 22 Oct 2020 11:19:25 -0700 (PDT)
MIME-Version: 1.0
From:   Uri Okrent <uokrent@gmail.com>
Date:   Thu, 22 Oct 2020 14:18:49 -0400
Message-ID: <CALPkawa4PG_y+mAwQwnZjWKyu+_k18P_WTHvst6+3+Ej7pMbGg@mail.gmail.com>
Subject: help debugging ath10k latency issue
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello all, I've got a ath10k QCA6174 wireless device on my laptop
which generally runs well, but after a few days of uptime with
"normal" latency. I suddenly experience very high latency. I am
measuring latency by pinging my access point. After a reboot it looks
something like this:

[1603195511.647411] 64 bytes from 192.168.0.185: icmp_seq=1 ttl=64 time=5.97 ms
[1603195512.644271] 64 bytes from 192.168.0.185: icmp_seq=2 ttl=64 time=1.77 ms
[1603195513.647936] 64 bytes from 192.168.0.185: icmp_seq=3 ttl=64 time=3.29 ms
[1603195514.648112] 64 bytes from 192.168.0.185: icmp_seq=4 ttl=64 time=1.93 ms
[1603195515.649151] 64 bytes from 192.168.0.185: icmp_seq=5 ttl=64 time=1.76 ms
[1603195516.651775] 64 bytes from 192.168.0.185: icmp_seq=6 ttl=64 time=2.85 ms
[1603195517.651775] 64 bytes from 192.168.0.185: icmp_seq=7 ttl=64 time=1.83 ms
[1603195518.653779] 64 bytes from 192.168.0.185: icmp_seq=8 ttl=64 time=1.79 ms
[1603195519.673433] 64 bytes from 192.168.0.185: icmp_seq=9 ttl=64 time=19.4 ms
[1603195520.657162] 64 bytes from 192.168.0.185: icmp_seq=10 ttl=64 time=1.90 ms
[1603195521.669162] 64 bytes from 192.168.0.185: icmp_seq=11 ttl=64 time=12.7 ms
[1603195522.660162] 64 bytes from 192.168.0.185: icmp_seq=12 ttl=64 time=1.81 ms
[1603195523.662202] 64 bytes from 192.168.0.185: icmp_seq=13 ttl=64 time=1.88 ms
[1603195524.662584] 64 bytes from 192.168.0.185: icmp_seq=14 ttl=64 time=1.88 ms
[1603195525.664175] 64 bytes from 192.168.0.185: icmp_seq=15 ttl=64 time=2.39 ms
[1603195526.666592] 64 bytes from 192.168.0.185: icmp_seq=16 ttl=64 time=3.19 ms

after a few days it will suddenly look like this:
[1603387794.470254] 64 bytes from 192.168.0.185: icmp_seq=60939 ttl=64
time=4.33 ms
[1603387795.487899] 64 bytes from 192.168.0.185: icmp_seq=60940 ttl=64
time=20.4 ms
[1603387796.515681] 64 bytes from 192.168.0.185: icmp_seq=60941 ttl=64
time=46.8 ms
[1603387797.542636] 64 bytes from 192.168.0.185: icmp_seq=60942 ttl=64
time=72.6 ms
[1603387798.563217] 64 bytes from 192.168.0.185: icmp_seq=60943 ttl=64
time=91.3 ms
[1603387799.474965] 64 bytes from 192.168.0.185: icmp_seq=60944 ttl=64
time=2.21 ms
[1603387800.476286] 64 bytes from 192.168.0.185: icmp_seq=60945 ttl=64
time=2.08 ms
[1603387801.613268] 64 bytes from 192.168.0.185: icmp_seq=60946 ttl=64
time=138 ms
[1603387802.479966] 64 bytes from 192.168.0.185: icmp_seq=60947 ttl=64
time=3.19 ms
[1603387803.479461] 64 bytes from 192.168.0.185: icmp_seq=60948 ttl=64
time=1.80 ms
[1603387804.501875] 64 bytes from 192.168.0.185: icmp_seq=60949 ttl=64
time=22.1 ms
[1603387805.528428] 64 bytes from 192.168.0.185: icmp_seq=60950 ttl=64
time=47.3 ms
[1603387806.550368] 64 bytes from 192.168.0.185: icmp_seq=60951 ttl=64
time=67.7 ms
[1603387807.496661] 64 bytes from 192.168.0.185: icmp_seq=60952 ttl=64
time=12.1 ms
[1603387808.574657] 64 bytes from 192.168.0.185: icmp_seq=60953 ttl=64
time=88.7 ms
[1603387809.616396] 64 bytes from 192.168.0.185: icmp_seq=60954 ttl=64
time=128 ms
[1603387810.642946] 64 bytes from 192.168.0.185: icmp_seq=60955 ttl=64
time=153 ms
[1603387811.493232] 64 bytes from 192.168.0.185: icmp_seq=60956 ttl=64
time=2.11 ms
[1603387812.494298] 64 bytes from 192.168.0.185: icmp_seq=60957 ttl=64
time=1.84 ms
[1603387813.512747] 64 bytes from 192.168.0.185: icmp_seq=60958 ttl=64
time=18.2 ms
[1603387814.550750] 64 bytes from 192.168.0.185: icmp_seq=60959 ttl=64
time=54.8 ms
[1603387815.640003] 64 bytes from 192.168.0.185: icmp_seq=60960 ttl=64
time=142 ms

It will stay like that until I reboot at which point it will run
normally again for a few days. I've tried installing various
firmwares, and disabling power management, but that has not changed
anything.  I ran ping for a few days to pin point the exact time
things go crazy and while i found a general timestamp, within a few
seconds, there doesn't appear to be anything in syslog or kernel
messages that would explain the abrupt change in behavior.

I'm on kernel 5.4.0-52-generic (ubuntu 20.04.1). Some info about my
hardware from the kernel:
[Tue Oct 20 07:54:27 2020] ath10k_pci 0000:02:00.0: qca6174 hw3.2
target 0x05030000 chip_id 0x00340aff sub 1a56:143a
[Tue Oct 20 07:54:27 2020] ath10k_pci 0000:02:00.0: kconfig debug 0
debugfs 1 tracing 1 dfs 0 testmode 0
[Tue Oct 20 07:54:27 2020] ath10k_pci 0000:02:00.0: firmware ver
WLAN.RM.4.4.1-00157-QCARMSWPZ-1 api 6 features wowlan,ignore-otp,mfp
crc32 90eebefb
[Tue Oct 20 07:54:27 2020] ath10k_pci 0000:02:00.0: board_file api 2
bmi_id N/A crc32 fe1026b8
[Tue Oct 20 07:54:27 2020] ath10k_pci 0000:02:00.0: unsupported HTC
service id: 1536
[Tue Oct 20 07:54:27 2020] ath10k_pci 0000:02:00.0: htt-ver 3.60
wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
[Tue Oct 20 07:54:27 2020] ath10k_pci 0000:02:00.0 wlp2s0: renamed from wlan0

At this point I'm stumped. Does anyone have any pointers of where I
might start looking (log files, debugging to enable, etc) in order to
get to the bottom of this? I should also note that this system was
previously running ubuntu 18.04 with kernel 5.3 and had no such
issues.

Thanks

-- 
   Uri
