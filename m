Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA512140F9A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2020 18:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgAQRDx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jan 2020 12:03:53 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:41131 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgAQRDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jan 2020 12:03:53 -0500
Received: by mail-il1-f169.google.com with SMTP id f10so21813166ils.8;
        Fri, 17 Jan 2020 09:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9rXKRnJJ1nTCqM8mpLYzm67vNkb+m9EUg6D73cXEmU=;
        b=tA4axjUgnsgsmjCKcVZVbiOt09ABpav8Mjt5KcCQ94jjqhs/XJW4xzAKPcg/B7x0e9
         AvNaNOVtQMfN1fyczIKQ3eqCOhRdvNweaFlENmQS6uTYPC+BWXHUknAUgABxWiw9LYMg
         okwTwOYd4rcxhnVoJ3OeDvkYfYjCL3D5mLB9zHxS6cP2O/5dd6RhXEW6PgxlcenZDq8V
         +laOIrpnSnRUFY0dqIKVkIrtznKVCM8Dhd1Wl3OwFBm8nZfEKdpvo3G/mYzYBscu2AMq
         pnMLBxwtKMoCpYnsFEJDJmP5xv6PL14NMMUOPq5D9qnq7LYNAKrRL3PBQr4ZQp9WYo5d
         T6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9rXKRnJJ1nTCqM8mpLYzm67vNkb+m9EUg6D73cXEmU=;
        b=K9Le3FHmQ1GLt3xgL5YIuGUE8tTyuTTdlpXdMw8tOYSAw1anC6Omv41Jvvz8XbCUyx
         iBlY4E8JiVT3GQD5sswtMyUetpVjFSqk7OfPng9ZHIW+OAg8BC02bvMcgnIYTvTFCDFV
         7XicgAu6mGaqkoPPwwwiUGw7ZKrFHd0i77Ej/XzlgtFZ1LgEMBXJvw3BqtDNlRdb7NHA
         d0W6kKZi/IqjAXPkdiJFc0FUD+xebetfxtcdkrcxnqK46jOHPTTMNAk1Bh7Fz7ac/ZZf
         6NwgbJ8fkJ7g1o/pKUcSc+bpMZk3hNrAtwxl4HYwgCVULK1uj9CoDB8xkrDGV9jjn67k
         HJUQ==
X-Gm-Message-State: APjAAAW072/+9ZPdtJDKq3BoR4tH3mwdEx9kicZAt8FJ/1/gQHkw0NNQ
        e2GSkQIJ3MN96ZjKoxrF6sRhWpbvdmii59F7ecw=
X-Google-Smtp-Source: APXvYqwQV7hNXZywjk4J+YZdw3tMMi4shv6RUZ4/q/kCiudIp3pK9F3OHyKe7jjqSR8Q7nSgLn0yU/6CIizPJh5Ehjg=
X-Received: by 2002:a92:cc42:: with SMTP id t2mr3769738ilq.111.1579280631342;
 Fri, 17 Jan 2020 09:03:51 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNu+nih5nZkuavoYot0eo5pF7quD4JviN+vWctPdmbu=A@mail.gmail.com>
 <fe3cd3c3d4364ef4bfb14b5ac3fcee1d@realtek.com>
In-Reply-To: <fe3cd3c3d4364ef4bfb14b5ac3fcee1d@realtek.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 17 Jan 2020 22:03:40 +0500
Message-ID: <CABXGCsO6ODRapJgZG-Ot2oHDDyFVHPQAL_r7DESQe6yHSaXgQg@mail.gmail.com>
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
> It seems like the firmware is not responsive, and is not reporting TX
> status or consuming H2C commands.
> The first trace dump "purge skb(s) not reported by firmware" will be
> printed when driver timed-out for TX status report. It could happen
> sometimes when driver turns power off too quickly after de-auth sent.
> Or firmware just missed it. Originally I was thinking that the TX status
> missing means that the firmware is not working, but seems it's not
> true. So I think I might lower the print level (WARN() -> rtw_warn()).
>
> But from your kernel log I can see that the h2c commands failed to
> be sent to firmware, which means there's another things that cause
> firmware to stall. It will be better if you can turn the debug masks on,
> and reproduce it, to help me so see what happened.
> To turn the debug masks on:
> $ echo 0xffffffff > /sys/module/rtw88/parameters/debug_mask

Yet another catch.
And it looks like it happened when I switched on/off WiFi in Network
manager because the network not worked.

https://pastebin.com/pYyswtwT

[64440.892201] rtw_pci 0000:05:00.0: wrong bfee role
[64440.892280] wlp5s0: associated
[66459.825899] rtw_pci 0000:05:00.0: failed to send h2c command
[68226.924564] rtw_pci 0000:05:00.0: firmware failed to restore hardware setting
[69219.317785] rtw_pci 0000:05:00.0: firmware failed to restore hardware setting
[69219.822479] ------------[ cut here ]------------
[69219.822595] purge skb(s) not reported by firmware
[69219.822642] WARNING: CPU: 9 PID: 0 at
drivers/net/wireless/realtek/rtw88/tx.c:155
rtw_tx_report_purge_timer+0x20/0x50 [rtw88]
[69219.822648] Modules linked in: ccm uinput rfcomm xt_CHECKSUM
xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp
tun bridge stp llc nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nf_tables_set nft_chain_nat nf_tables ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw ip6table_security
iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_mangle iptable_raw iptable_security ip_set nfnetlink
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter cmac
bnep sunrpc vfat fat edac_mce_amd snd_hda_codec_realtek kvm_amd
snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio kvm
snd_hda_intel rtwpci snd_intel_dspcfg irqbypass rtw88 snd_hda_codec
mac80211 btusb snd_hda_core btrtl btbcm crct10dif_pclmul snd_hwdep
btintel crc32_pclmul snd_seq snd_seq_device eeepc_wmi bluetooth
cfg80211 snd_pcm ghash_clmulni_intel joydev
[69219.822689]  asus_wmi sparse_keymap snd_timer video wmi_bmof
ecdh_generic snd sp5100_tco ecc k10temp pcspkr rfkill soundcore ccp
i2c_piix4 libarc4 gpio_amdpt gpio_generic acpi_cpufreq binfmt_misc
ip_tables xfs libcrc32c amdgpu amd_iommu_v2 gpu_sched ttm
drm_kms_helper drm igb crc32c_intel dca i2c_algo_bit nvme nvme_core
wmi pinctrl_amd fuse
[69219.822716] CPU: 9 PID: 0 Comm: swapper/9 Not tainted
5.5.0-0.rc6.git2.2.fc32.x86_64 #1
[69219.822719] Hardware name: System manufacturer System Product
Name/ROG STRIX X470-I GAMING, BIOS 3004 12/16/2019
[69219.822727] RIP: 0010:rtw_tx_report_purge_timer+0x20/0x50 [rtw88]
[69219.822731] Code: 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 8b
47 a8 85 c0 75 01 c3 41 54 55 53 48 89 fb 48 c7 c7 20 6b 40 c1 e8 c0
18 d5 e8 <0f> 0b 4c 8d a3 50 ff ff ff 4c 89 e7 e8 5f 25 7e e9 48 8d 7b
98 48
[69219.822735] RSP: 0018:ffffa5b1c03ace48 EFLAGS: 00010286
[69219.822738] RAX: 0000000000000000 RBX: ffff8e3b92c57810 RCX: 0000000000000000
[69219.822741] RDX: ffff8e3bbb5eaf40 RSI: ffff8e3bbb5dc5b8 RDI: 0000000000000300
[69219.822744] RBP: 0000000000000101 R08: 00003ef47eeff977 R09: 0000000000000000
[69219.822748] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa5b1c03aced8
[69219.822751] R13: ffffffffc139a3c0 R14: 00000001041c3868 R15: ffffffffc139a3c0
[69219.822754] FS:  0000000000000000(0000) GS:ffff8e3bbb400000(0000)
knlGS:0000000000000000
[69219.822757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[69219.822760] CR2: 00000d87813a8160 CR3: 0000000661156000 CR4: 00000000003406e0
[69219.822763] Call Trace:
[69219.822767]  <IRQ>
[69219.822776]  call_timer_fn+0xaf/0x2c0
[69219.822788]  run_timer_softirq+0x1bf/0x5e0
[69219.822794]  ? sched_clock_cpu+0xc/0xc0
[69219.822806]  __do_softirq+0xe1/0x45d
[69219.822815]  irq_exit+0xf7/0x100
[69219.822820]  smp_apic_timer_interrupt+0xa4/0x230
[69219.822825]  apic_timer_interrupt+0xf/0x20
[69219.822828]  </IRQ>
[69219.822834] RIP: 0010:cpuidle_enter_state+0xce/0x400
[69219.822838] Code: 80 7c 24 0f 00 74 17 9c 58 0f 1f 44 00 00 f6 c4
02 0f 85 0b 03 00 00 31 ff e8 3e 31 8a ff e8 19 c7 91 ff fb 66 0f 1f
44 00 00 <45> 85 ed 0f 88 5c 02 00 00 49 63 d5 4c 2b 64 24 10 48 8d 04
52 48
[69219.822843] RSP: 0018:ffffa5b1c0167e68 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[69219.822847] RAX: ffff8e3bb6503380 RBX: ffff8e3baad93000 RCX: 0000000000000000
[69219.822850] RDX: ffff8e3bb6503380 RSI: 0000000000000006 RDI: ffff8e3bb6503380
[69219.822853] RBP: ffffffffab814d60 R08: 00003ef47eed9fb1 R09: 0000000000000000
[69219.822855] R10: 0000000000000000 R11: 0000000000000000 R12: 00003ef47eed9fb1
[69219.822858] R13: 0000000000000002 R14: 0000000000000002 R15: ffff8e3bb6503380
[69219.822871]  ? cpuidle_enter_state+0xc7/0x400
[69219.822879]  cpuidle_enter+0x29/0x40
[69219.822884]  do_idle+0x1e9/0x290
[69219.822892]  cpu_startup_entry+0x19/0x20
[69219.822896]  start_secondary+0x16e/0x1c0
[69219.822902]  secondary_startup_64+0xb6/0xc0
[69219.822915] irq event stamp: 534378571
[69219.822919] hardirqs last  enabled at (534378570):
[<ffffffffaa00396b>] trace_hardirqs_on_thunk+0x1a/0x1c
[69219.822926] hardirqs last disabled at (534378571):
[<ffffffffaa003987>] trace_hardirqs_off_thunk+0x1a/0x1c
[69219.822929] softirqs last  enabled at (534378546):
[<ffffffffaa0f4138>] irq_enter+0x68/0x70
[69219.822933] softirqs last disabled at (534378547):
[<ffffffffaa0f4237>] irq_exit+0xf7/0x100
[69219.822936] ---[ end trace dc2e3f2642bd6283 ]---
[69220.006376] rtw_pci 0000:05:00.0: timed out to flush queue 2
[69220.006634] rtw_pci 0000:05:00.0: sta 50:ff:20:04:c8:dc with macid 0 left
[69222.707299] rtw_pci 0000:05:00.0: stop vif 80:c5:f2:74:cd:51 on port 0
[69226.866078] rtw_pci 0000:05:00.0: start vif 7e:f2:b4:c5:77:d2 on port 0
[69229.508705] rtw_pci 0000:05:00.0: stop vif 7e:f2:b4:c5:77:d2 on port 0
[69229.965361] rtw_pci 0000:05:00.0: start vif 80:c5:f2:74:cd:51 on port 0
[69232.596582] wlp5s0: authenticate with 50:ff:20:04:c8:dc
[69232.596610] wlp5s0: capabilities/regulatory prevented using AP
HT/VHT configuration, downgraded
[69233.038518] wlp5s0: send auth to 50:ff:20:04:c8:dc (try 1/3)
[69233.103760] wlp5s0: authenticate with 50:ff:20:04:c8:dc
[69233.103810] wlp5s0: send auth to 50:ff:20:04:c8:dc (try 1/3)


--
Best Regards,
Mike Gavrilov.
