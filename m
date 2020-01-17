Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E644E1402B1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2020 05:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgAQEAV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jan 2020 23:00:21 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:40097 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgAQEAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jan 2020 23:00:18 -0500
Received: by mail-io1-f42.google.com with SMTP id x1so24469613iop.7;
        Thu, 16 Jan 2020 20:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWWfJaURmsOQ3gW/I5cX63NQOzc27+1p7Rp9O4pX5yo=;
        b=RsKQHLuc6uNM3k6juQztjjat/V3GWbnLqFJSu/HfXVn2wSGEEcwdQHNe/TdUPRKyL4
         iEx5Ml60uCGFoFKNt/4WdXmsMeqcQW5yfBKJ8KodB9nbHeHaoZbGf72vnsEV9aDp87nK
         eeGQhZg8ffauTETAWipn6SeEiMJ4rcb/QMZu0BlHe0WAIEB9c3XS71mOyQMDJ0Zwf82/
         PKZG5Ev0YGYb1rSrG1L16Cxg7NuA8ZTA60QWhK38NkScdb2l6d9VrdisYF91GidZPl40
         LYE8hm7Fjlcxe85KxFtpvL9YKFomj9nv/WLQK2s77Bba2RdR/4imq2CbCD/gu+eYJm4R
         U+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWWfJaURmsOQ3gW/I5cX63NQOzc27+1p7Rp9O4pX5yo=;
        b=MX276bAsQdUndKD5C22o4qCrF8nUTWNLFgsx+awIDXlWRv6dA9Yi3nBJCpKGSThobs
         dwFMASDbSJeQL2aVj7AaJ+ogv7CxIzbEMEVH9FKAYoduoZpngupgRirT+gJH5V7S7fXC
         HxCvIGtbDd0Q2CwCKNXeLPXWCsYEJL6l5z41HgdUkhg2/WyMKvP19jU7gS++90Sj8D02
         Joz1EAA9OUip26Y5VThqKZsLjZhaugRpeNcbRhp94AeYLZvz/2SblXupONk6c14s+vzt
         3ru+foM16l1qOM6p1nYEeoa8UgOT8sfl+hw21yrXkFmDw3jiXxZmCVQSd3nJnGmwE0Lg
         +5LA==
X-Gm-Message-State: APjAAAVDnM5XR6dEKHDff4GtE2+biHOTw1rPgXKBticRZAw/O7x4QU6M
        KzAFsUcqOIVYdzwF9pX/js+lRB9GDUZYjOKeLa4=
X-Google-Smtp-Source: APXvYqwibINkfFs9b53KPq3W0e3f9E1ZwCkRXy1fkMNxHTHKGjNeRHl5Nh+PtLpPL1i1LpQ+FTDXwcZcQ373qW2lf8E=
X-Received: by 2002:a02:b385:: with SMTP id p5mr31237614jan.43.1579233617266;
 Thu, 16 Jan 2020 20:00:17 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNu+nih5nZkuavoYot0eo5pF7quD4JviN+vWctPdmbu=A@mail.gmail.com>
 <fe3cd3c3d4364ef4bfb14b5ac3fcee1d@realtek.com>
In-Reply-To: <fe3cd3c3d4364ef4bfb14b5ac3fcee1d@realtek.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 17 Jan 2020 09:00:06 +0500
Message-ID: <CABXGCsMUwgUNFiYDLqDPWaUw3zu0oJWUY-gFktJwpqc4JxHFSA@mail.gmail.com>
Subject: Re: [rtw88] purge skb(s) not reported by firmware
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 13 Jan 2020 at 12:49, Tony Chuang <yhchuang@realtek.com> wrote:
>
> But from your kernel log I can see that the h2c commands failed to
> be sent to firmware, which means there's another things that cause
> firmware to stall. It will be better if you can turn the debug masks on,
> and reproduce it, to help me so see what happened.
> To turn the debug masks on:
> $ echo 0xffffffff > /sys/module/rtw88/parameters/debug_mask
>

wlp5s0: RX AssocResp from 50:ff:20:04:c8:dc (capab=0x1811 status=0 aid=1)
rtw_pci 0000:05:00.0: sta 50:ff:20:04:c8:dc joined with macid 0
rtw_pci 0000:05:00.0: wrong bfee role
wlp5s0: associated
rtw_pci 0000:05:00.0: failed to send h2c command
rtw_pci 0000:05:00.0: failed to send h2c command
------------[ cut here ]------------
purge skb(s) not reported by firmware
WARNING: CPU: 7 PID: 0 at drivers/net/wireless/realtek/rtw88/tx.c:155
rtw_tx_report_purge_timer+0x20/0x50 [rtw88]
Modules linked in: uinput rfcomm xt_CHECKSUM xt_MASQUERADE
xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp tun bridge stp
llc ccm nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_tables_set
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ip_set nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter cmac bnep sunrpc vfat fat
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
snd_hda_codec_hdmi edac_mce_amd kvm_amd snd_hda_intel snd_intel_dspcfg
kvm irqbypass snd_hda_codec btusb rtwpci btrtl rtw88 snd_hda_core
btbcm crct10dif_pclmul snd_hwdep btintel crc32_pclmul mac80211 snd_seq
snd_seq_device bluetooth eeepc_wmi snd_pcm ghash_clmulni_intel
asus_wmi joydev
 sparse_keymap snd_timer ecdh_generic cfg80211 video wmi_bmof ecc snd
pcspkr sp5100_tco ccp k10temp soundcore i2c_piix4 rfkill libarc4
gpio_amdpt gpio_generic acpi_cpufreq binfmt_misc ip_tables xfs
libcrc32c amdgpu amd_iommu_v2 gpu_sched ttm drm_kms_helper drm igb
crc32c_intel nvme dca i2c_algo_bit nvme_core wmi pinctrl_amd fuse
CPU: 7 PID: 0 Comm: swapper/7 Not tainted 5.5.0-0.rc6.git2.2.fc32.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X470-I GAMING, BIOS 3004 12/16/2019
RIP: 0010:rtw_tx_report_purge_timer+0x20/0x50 [rtw88]
Code: 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 8b 47 a8 85 c0 75
01 c3 41 54 55 53 48 89 fb 48 c7 c7 20 bb 10 c1 e8 c0 c8 04 d4 <0f> 0b
4c 8d a3 50 ff ff ff 4c 89 e7 e8 5f d5 ad d4 48 8d 7b 98 48
RSP: 0018:ffffbb9dc0354e48 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff920758997810 RCX: 0000000000000000
RDX: ffff92077afeaf40 RSI: ffff92077afdc5b8 RDI: 0000000000000300
RBP: 0000000000000101 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffbb9dc0354ed8
R13: ffffffffc109f3c0 R14: 00000001009d4a78 R15: ffffffffc109f3c0
FS:  0000000000000000(0000) GS:ffff92077ae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562f61eee7e0 CR3: 00000006d7082000 CR4: 00000000003406e0
Call Trace:
 <IRQ>
 call_timer_fn+0xaf/0x2c0
 run_timer_softirq+0x1bf/0x5e0
 ? clockevents_program_event+0x50/0xf0
 __do_softirq+0xe1/0x45d
 irq_exit+0xf7/0x100
 smp_apic_timer_interrupt+0xa4/0x230
 apic_timer_interrupt+0xf/0x20
 </IRQ>
RIP: 0010:cpuidle_enter_state+0xce/0x400
Code: 80 7c 24 0f 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 0b 03
00 00 31 ff e8 3e 31 8a ff e8 19 c7 91 ff fb 66 0f 1f 44 00 00 <45> 85
ed 0f 88 5c 02 00 00 49 63 d5 4c 2b 64 24 10 48 8d 04 52 48
RSP: 0018:ffffbb9dc0157e68 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: ffff92076ac8d400 RCX: 000000000000001f
RDX: 0000000000000000 RSI: 0000000022a8dc79 RDI: ffffffff9590fd27
RBP: ffffffff96814d60 R08: 000009a60caadd47 R09: 000000000000aeef
R10: 00000000000026d2 R11: ffff92077afed824 R12: 000009a60caadd47
R13: 0000000000000002 R14: 0000000000000002 R15: ffff9207764b8000
 ? cpuidle_enter_state+0xc7/0x400
 ? cpuidle_enter_state+0xc7/0x400
 cpuidle_enter+0x29/0x40
 do_idle+0x1e9/0x290
 cpu_startup_entry+0x19/0x20
 start_secondary+0x16e/0x1c0
 secondary_startup_64+0xb6/0xc0
irq event stamp: 15178100
hardirqs last  enabled at (15178099): [<ffffffff951b61ff>]
tick_nohz_idle_exit+0x5f/0xc0
hardirqs last disabled at (15178100): [<ffffffff95b7422e>] __schedule+0xde/0x9c0
softirqs last  enabled at (15178094): [<ffffffff950f4138>] irq_enter+0x68/0x70
softirqs last disabled at (15178093): [<ffffffff950f411d>] irq_enter+0x4d/0x70
---[ end trace 48f8cd6a9096abc3 ]---
rtw_pci 0000:05:00.0: sta 50:ff:20:04:c8:dc with macid 0 left
wlp5s0: authenticate with 50:ff:20:04:c8:dc
wlp5s0: capabilities/regulatory prevented using AP HT/VHT
configuration, downgraded
wlp5s0: send auth to 50:ff:20:04:c8:dc (try 1/3)
wlp5s0: send auth to 50:ff:20:04:c8:dc (try 2/3)
wlp5s0: send auth to 50:ff:20:04:c8:dc (try 3/3)
wlp5s0: authentication with 50:ff:20:04:c8:dc timed out
wlp5s0: authenticate with 50:ff:20:04:c8:dc
wlp5s0: capabilities/regulatory prevented using AP HT/VHT
configuration, downgraded
wlp5s0: send auth to 50:ff:20:04:c8:dc (try 1/3)
wlp5s0: authenticated


Here is full version: https://pastebin.com/neBaLf4A


--
Best Regards,
Mike Gavrilov.
