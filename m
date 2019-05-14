Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9421B1CF73
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 20:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfENSym (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 14:54:42 -0400
Received: from [208.74.158.174] ([208.74.158.174]:56862 "EHLO
        mail3.candelatech.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfENSym (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 14:54:42 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 69A4313755C;
        Tue, 14 May 2019 11:54:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 69A4313755C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1557860080;
        bh=0RtU1LDJJk+MluKQvsl0drdP4LbJYsD3Uupu6kZCoC4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I98xYCbXtBQwXvs3EWFnGuo0HvTDBmZ3WbZQRCOkZd/31rmv/4/SrZrHl/1U8G3Hr
         6WQYcdlIoHPRYFPEivJtOycJYD78ML9h0xO0IHtrUeUC/yGRNdGJAh9VpBWSEtdDC4
         ze8KZQ1hEKL0cKLBkyO969HZaZq1JBl9/uvFi/go=
Subject: Re: [PATCH v2] mac80211: remove warning message
To:     Johannes Berg <johannes@sipsolutions.net>,
        Yibo Zhao <yiboz@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Zhi Chen <zhichen@codeaurora.org>
References: <1557824507-17668-1-git-send-email-yiboz@codeaurora.org>
 <7c92f5cf51eaec1d5449698d90f5b6c5ca6c2bea.camel@sipsolutions.net>
 <ccb48284f0d96e72f4c041e12c943f0a@codeaurora.org>
 <e2a6596b99085541a5886c0d0d6393c849ac2d57.camel@sipsolutions.net>
 <34f72d5db336b9898618bf1c5c15ec41094d7d06.camel@perches.com>
 <4d013893-3302-14f0-c957-b3771f4b6b82@candelatech.com>
 <8eacb8e107c854b64a0c6116fca9731ddd99dcac.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <730d3664-488d-7d57-04d5-1a57e91fa070@candelatech.com>
Date:   Tue, 14 May 2019 11:54:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8eacb8e107c854b64a0c6116fca9731ddd99dcac.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/14/19 11:40 AM, Johannes Berg wrote:
> 
>> We know the WARN hits, we have the backtrace, and it is easy enough (in my setup
>> at least) to reproduce this.  So, the WARN logic has done its job.
>>
>> Having more of these spam the kernel doesn't add much benefit I think.
> 
> Well, this doesn't necessarily just catch a *single* issue, so it should
> remain for the future, I'd think.
> 
>> Anyone have any suggestions on how to fix the underlying issue?
> 
> I don't even have the backtrace and scenario that causes it.
> 
> johannes
> 

Here is the info I have in my commit that changed this to WARN_ON_ONCE.
I never posted it because I had to hack ath10k to get to this state, so maybe
this is not a valid case to debug.


Maybe Yibo Zhao has a better example.

     mac80211: don't spam kernel logs when chantx is null.

     I set up ath10k to be chandef based again in order to test
     WDS.  My WDS stations are not very functional yet, and
     when ethtool stats are queried, there is a WARN_ON splat
     generated.  Change this to WARN_ON_ONCE so that there is
     less kernel spam.

     [ 2401.445631] WARNING: CPU: 1 PID: 14070 at /home/greearb/git/linux-4.13.dev.y/net/mac80211/ieee80211_i.h:1452 sta_set_rate_info_tx+0x18c/0x1a0 [mac80211]
     [ 2401.445727] Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink wanlink(O) ath10k_pci ath10k_core mac80211_hwsim ath5k ath9k ath9k_common 
ath9k_hw ath mac80211 cfg80211 nf_defrag_ipv4 libcrc32c 8021q garp mrp stp llc fuse macvlan pktgen nfsv3 nfs fscache amd64_edac_mod edac_mce_amd kvm_amd kvm 
irqbypass sp5100_tco fam15h_power k10temp i2c_piix4 ccp shpchp acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd grace sch_fq_codel sunrpc sdhci_pci sdhci mmc_core 
igb hwmon ptp pps_core i2c_algo_bit i2c_core dca ipv6 crc_ccitt [last unloaded: nfnetlink]
     [ 2401.445911] CPU: 1 PID: 14070 Comm: btserver Tainted: G        W  O    4.13.11+ #18
     [ 2401.445914] Hardware name: PC Engines apu2/apu2, BIOS 88a4f96 03/07/2016
     [ 2401.445918] task: ffff880118c73b80 task.stack: ffffc90001400000
     [ 2401.445973] RIP: 0010:sta_set_rate_info_tx+0x18c/0x1a0 [mac80211]
     [ 2401.446003] RSP: 0018:ffffc90001403820 EFLAGS: 00010246
     [ 2401.446007] RAX: 0000000000000000 RBX: ffff8800ca38e4a0 RCX: 000000000000000c
     [ 2401.446010] RDX: 0000000000000000 RSI: ffff8800ca38e4a0 RDI: ffff8800ca38e000
     [ 2401.446013] RBP: ffffc90001403850 R08: ffffffffa04437a0 R09: 0000000000002000
     [ 2401.446016] R10: 000000001183be82 R11: 0000000000000000 R12: ffffc90001403970
     [ 2401.446018] R13: 0000000000000000 R14: ffff8800c01d8900 R15: ffff8800ca180780
     [ 2401.446023] FS:  00007f8123ed7740(0000) GS:ffff88011ec80000(0000) knlGS:0000000000000000
     [ 2401.446026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     [ 2401.446029] CR2: 00000000036e8018 CR3: 00000000c0b29000 CR4: 00000000000406e0
     [ 2401.446034] Call Trace:
     [ 2401.446140]  sta_set_sinfo+0x629/0x8b0 [mac80211]
     [ 2401.446192]  ieee80211_get_stats+0x3f2/0x8c0 [mac80211]
     [ 2401.446207]  ? __nla_put+0x20/0x30
     [ 2401.446221]  ? __kmalloc_reserve.isra.35+0x2c/0x80
     [ 2401.446229]  ? netlink_deliver_tap+0x2d/0x1e0
     [ 2401.446235]  ? sock_def_readable+0x6d/0x70
     [ 2401.446239]  ? __netlink_sendskb+0x36/0x40
     [ 2401.446245]  ? netlink_unicast+0x1b0/0x1f0
     [ 2401.446252]  ? rtnl_getlink+0x135/0x1c0
     [ 2401.446261]  ? get_page_from_freelist+0x913/0xac0
     [ 2401.446270]  ? vmap_page_range_noflush+0x27d/0x370
     [ 2401.446277]  ? map_vm_area+0x31/0x40
     [ 2401.446284]  ? __vmalloc_node_range+0x21f/0x270
     [ 2401.446319]  dev_ethtool+0x11d1/0x1ce0
     [ 2401.446325]  ? __rtnl_unlock+0x25/0x50
     [ 2401.446330]  ? netdev_run_todo+0x4d/0x2e0
     [ 2401.446338]  ? dev_get_by_name_rcu+0x6f/0xa0
     [ 2401.446344]  dev_ioctl+0x330/0x550
     [ 2401.446349]  ? reuse_swap_page+0x30/0x100
     [ 2401.446355]  sock_do_ioctl+0x3d/0x50
     [ 2401.446359]  ? sock_do_ioctl+0x3d/0x50
     [ 2401.446363]  sock_ioctl+0x1e5/0x2a0
     [ 2401.446370]  do_vfs_ioctl+0x8b/0x5b0
     [ 2401.446376]  ? getnstimeofday64+0x9/0x20
     [ 2401.446383]  ? __audit_syscall_entry+0xba/0x110
     [ 2401.446391]  ? syscall_trace_enter+0x1b0/0x2b0
     [ 2401.446395]  SyS_ioctl+0x74/0x80
     [ 2401.446400]  ? __audit_syscall_exit+0x215/0x2b0
     [ 2401.446405]  do_syscall_64+0x5c/0x190
     [ 2401.446412]  entry_SYSCALL64_slow_path+0x25/0x25


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

