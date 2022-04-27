Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54AF512494
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 23:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbiD0Vfx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 17:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiD0Vff (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 17:35:35 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C03C2716C
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 14:32:23 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.132])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D38B72007E
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 21:32:21 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A93E4500097
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 21:32:21 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.39.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0401513C2B0
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 14:32:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0401513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1651095141;
        bh=lOCDQY0Jj6sUeg7ze95plIYAIIP1e2ekJ0eJqJkCrsQ=;
        h=To:From:Subject:Date:From;
        b=SdvLPhDCazlOV61RBqDNqJJOY8chsYarr6rr3TM3xJbSVngqb7QO52WeR8Owrq3Na
         7RJjaCsVo5wiCt8mCFDWBYTLt6oD+hzTkj6KC7Zq29ftmE4co16LWpNEvSwaLQO4OT
         Hjk1aI7YF8g4wjew/BneSz2L7cEgDEkFCP8du8Gs=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: AP + STA on DFS channel breaks DFS detection.
Organization: Candela Technologies
Message-ID: <c937f0dc-5be7-8986-01a5-152c6b20e868@candelatech.com>
Date:   Wed, 27 Apr 2022 14:32:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1651095142-bWnhqlJ5sCIt
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I am using 5.17.4+ kernel, MT7915 radios.  One radio (wiphy0) is acting as AP on
channel 132.  It starts, does CAC and starts working fine.

Then, I bring up a station on wiphy1 (on same machine).  The STA connects to the AP
on wiphy0 and starts running traffic for a short time (usually < 1 minute).  And then
the AP gets stopped.  I don't think this is specific to connecting AP to STA on same machine,
probably if STA connected to another AP on channel 132 it would have same issue.

I think I have tracked this down by adding prints and WARN_ON to find
the interesting state changes.  It looks like when the STA changes its
regdom (probably because it is admin-up and/or associated to the AP), then the state of the
channel's dfs_state is reset.  Channel objects are per band, not per wiphy.

And then a bit later, a timer kicks off and decides that CAC has not completed
(because it already completed earlier on the AP, but chan->dfs_state was lost,
and STA will not do CAC anyway.)

So, question is, how in the world to fix this properly!

2818 Apr 27 14:20:42 lf0350-9634 kernel: cfg80211: handle-single-rule: wiphy0 chan: 00000000d9f5550d  old_state: 2  new: DFS_USABLE
2819 Apr 27 14:20:42 lf0350-9634 kernel: ------------[ cut here ]------------
2820 Apr 27 14:20:42 lf0350-9634 kernel: WARNING: CPU: 1 PID: 75 at net/wireless/reg.c:1830 wiphy_update_regulatory.cold.32+0x3ba/0x796 [cfg80211]
2821 Apr 27 14:20:42 lf0350-9634 kernel: Modules linked in: nf_conntrack_netlink nfnetlink iptable_raw xt_CT nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
libcrc32c          bpfilter vrf 8021q garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core pcengines_apuv2 gpio_keys_polled leds_gpio 
gpio_amd_fch amd64_edac             edac_mce_amd kvm_amd mt7915e kvm irqbypass bfq mt76_connac_lib mt76 mac80211 fam15h_power k10temp i2c_piix4 cfg80211 
acpi_cpufreq nfsd auth_rpcgss nfs_acl            sch_fq_codel lockd grace drm fuse agpgart sunrpc zram sdhci_pci cqhci sdhci igb hwmon i2c_algo_bit mmc_core 
sp5100_tco dca xhci_pci xhci_pci_renesas ccp              i2c_core [last unloaded: nfnetlink]
2822 Apr 27 14:20:42 lf0350-9634 kernel: CPU: 1 PID: 75 Comm: kworker/1:1 Tainted: G        W         5.17.4+ #14
2823 Apr 27 14:20:42 lf0350-9634 kernel: Hardware name: PC Engines APU2/APU2, BIOS 4.0.7 02/28/2017
2824 Apr 27 14:20:42 lf0350-9634 kernel: Workqueue: events reg_regdb_apply [cfg80211]
2825 Apr 27 14:20:42 lf0350-9634 kernel: RIP: 0010:wiphy_update_regulatory.cold.32+0x3ba/0x796 [cfg80211]
2826 Apr 27 14:20:42 lf0350-9634 kernel: sta03000: Limiting TX power to 20 (23 - 3) dBm as advertised by 00:0a:52:06:9f:10
2827 Apr 27 14:20:42 lf0350-9634 kernel: Code: 48 8b b3 c8 01 00 00 48 85 f6 0f 84 a8 00 00 00 41 8b 4e 2c 4c 89 f2 48 c7 c7 20 10 51 a0 e8 7e 70 6d e1 41 83 7e 
2c        02 75 02 <0f> 0b 48 8b 05 b8 25 30 e2 8b 4c 24 24 41 c7 46 2c 00 00 00 00 41
2828 Apr 27 14:20:42 lf0350-9634 kernel: RSP: 0018:ffffc90000297dc0 EFLAGS: 00010246
2829 Apr 27 14:20:42 lf0350-9634 kernel: RAX: 000000000000005a RBX: ffff88810bca03a0 RCX: 0000000000000027
2830 Apr 27 14:20:42 lf0350-9634 kernel: RDX: 0000000000000000 RSI: ffff88811ac9c440 RDI: ffff88811ac9c448
2831 Apr 27 14:20:42 lf0350-9634 kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: c0000000ffffdfff
2832 Apr 27 14:20:42 lf0350-9634 kernel: R10: 0000000000000001 R11: ffffc90000297bf0 R12: ffff8880141a399c
2833 Apr 27 14:20:42 lf0350-9634 kernel: R13: ffff88810c3803a0 R14: ffff88810ac00c28 R15: 0000000000565d60
2834 Apr 27 14:20:42 lf0350-9634 kernel: FS:  0000000000000000(0000) GS:ffff88811ac80000(0000) knlGS:0000000000000000
2835 Apr 27 14:20:42 lf0350-9634 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2836 Apr 27 14:20:42 lf0350-9634 kernel: CR2: 00005601e502dba0 CR3: 000000000bf36000 CR4: 00000000000406e0
2837 Apr 27 14:20:42 lf0350-9634 kernel: Call Trace:
2838 Apr 27 14:20:42 lf0350-9634 kernel:  <TASK>
2839 Apr 27 14:20:42 lf0350-9634 kernel:  update_all_wiphy_regulatory+0x2e/0x90 [cfg80211]
2840 Apr 27 14:20:42 lf0350-9634 kernel:  set_regdom+0x101/0x420 [cfg80211]
2841 Apr 27 14:20:42 lf0350-9634 kernel:  reg_regdb_apply+0x65/0x90 [cfg80211]
2842 Apr 27 14:20:42 lf0350-9634 kernel:  process_one_work+0x21a/0x3f0
2843 Apr 27 14:20:42 lf0350-9634 kernel:  ? process_one_work+0x3f0/0x3f0
2844 Apr 27 14:20:42 lf0350-9634 kernel:  worker_thread+0x28/0x3a0
2845 Apr 27 14:20:42 lf0350-9634 kernel:  ? process_one_work+0x3f0/0x3f0
2846 Apr 27 14:20:42 lf0350-9634 kernel:  kthread+0xd2/0x100
2847 Apr 27 14:20:42 lf0350-9634 kernel:  ? kthread_complete_and_exit+0x20/0x20
2848 Apr 27 14:20:42 lf0350-9634 kernel:  ret_from_fork+0x1f/0x30
2849 Apr 27 14:20:42 lf0350-9634 kernel:  </TASK>
2850 Apr 27 14:20:42 lf0350-9634 kernel: ---[ end trace 0000000000000000 ]---

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
