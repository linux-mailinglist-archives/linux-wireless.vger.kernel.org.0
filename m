Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3545133EEB
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 11:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgAHKJA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jan 2020 05:09:00 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45069 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAHKJA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jan 2020 05:09:00 -0500
Received: by mail-il1-f196.google.com with SMTP id p8so2151601iln.12;
        Wed, 08 Jan 2020 02:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rwZwmnt2UnOUu3Zp4GzpWfKBgqtgvpBiXHh9MTpc/Ko=;
        b=csq7vNU92EUloQMY87mKOFEcnGkzWwWIkpD+9HhvMicHW4y30a90NNaBKe66GZ5wiX
         JykB4KAL7PZk/0pZh+cwzYPqKb6Rlh/ZArVmt0n8WFX7HUAdaj0qzcoNh0n32q1/lwcG
         TQLsWh8IQuZ0Z1yJy5onX6CiB8GwsE0Vjx6OwYLt2mc5guSO6DL9qTbzHCSoVtVLMFmr
         NGFZ8pMXwx/Ii8cwSFh9338Iy5kS3iIVLiJNgxjlzw4tRY24xwmvZ9NX38DeEsTqH87P
         Y6lAihPuhaQtSJNhLu59teIxDlBofKzIsA7QxJrsdTlChzwleJazsN+TY67VIQaWt0BB
         gYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rwZwmnt2UnOUu3Zp4GzpWfKBgqtgvpBiXHh9MTpc/Ko=;
        b=m+qQtYCCjiAgbQxlYrmWGGTQlEEKL6xvwDiBcuwQVmqsKXfd0XcNVzSrFOEs0wQNro
         BeGbL8ujp5TmxpnqGHNArHzl82fm0M6hDfXLCC2Rd2yf8OtwB98swbPFJUysp/7WTsYA
         jlkypUaDqJI1uwiRAD0fa6lCF/Y7t+kYIXNbXpU1YO+ybrkqE/FmXmQtkUNc5V7qQ+xQ
         wKxAMquEd5fo8vWo/HuKG0tiLlIRIBvSEE2VwSOlK8VOEiGsoaPZfw2pRA97vbEDeGqg
         z02vYFYGPLjasz2wE+HFX/n3KL6jmIXxXslrPYNkwBJGNX0UiOvlo40+nU9ErrtIkCX5
         yhoA==
X-Gm-Message-State: APjAAAW3+c/I0WxfSi89CPH8mC0Iwg3RH64TBw5/nA8e/GzxfBk73+B7
        fh1Him0zYyhR+5pWZ/8lWUjgDDwT4NdSsE5mKh+xa7VuiSi5Tg==
X-Google-Smtp-Source: APXvYqy4pcdY9LHO5DPZwzg4N4jxl2Y1E9DW547SqUjcsOvtecHqTLirlxVHPiyERPPjc3X6KFx6xRk0FQkoYxj1W7w=
X-Received: by 2002:a92:b6d1:: with SMTP id m78mr3028711ill.245.1578478138417;
 Wed, 08 Jan 2020 02:08:58 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 8 Jan 2020 15:08:47 +0500
Message-ID: <CABXGCsNu+nih5nZkuavoYot0eo5pF7quD4JviN+vWctPdmbu=A@mail.gmail.com>
Subject: [rtw88] purge skb(s) not reported by firmware
To:     Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        yhchuang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi folks.
I recently joined testing the rtw88 driver.
In just a few days, I already catches such WARNING twice times:


[ 4899.601656] rtw_pci 0000:05:00.0: failed to send h2c command
[ 9084.661382] rtw_pci 0000:05:00.0: firmware failed to restore hardware setting
[ 9085.167364] ------------[ cut here ]------------
[ 9085.167370] purge skb(s) not reported by firmware
[ 9085.167417] WARNING: CPU: 9 PID: 0 at
drivers/net/wireless/realtek/rtw88/tx.c:155
rtw_tx_report_purge_timer+0x20/0x50 [rtw88]
[ 9085.167419] Modules linked in: uinput rfcomm xt_CHECKSUM
xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp
tun bridge stp llc ccm nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nf_tables_set nft_chain_nat nf_tables ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw ip6table_security
iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_mangle iptable_raw iptable_security ip_set nfnetlink
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter cmac
bnep sunrpc vfat fat snd_hda_codec_realtek rtwpci
snd_hda_codec_generic rtw88 ledtrig_audio snd_hda_codec_hdmi
edac_mce_amd snd_hda_intel kvm_amd snd_intel_dspcfg snd_hda_codec
btusb mac80211 kvm snd_hda_core btrtl btbcm snd_hwdep btintel snd_seq
bluetooth eeepc_wmi snd_seq_device irqbypass snd_pcm asus_wmi
snd_timer crct10dif_pclmul sp5100_tco cfg80211
[ 9085.167456]  sparse_keymap ecdh_generic crc32_pclmul joydev video
pcspkr snd i2c_piix4 wmi_bmof ghash_clmulni_intel k10temp rfkill ccp
ecc libarc4 soundcore gpio_amdpt gpio_generic acpi_cpufreq binfmt_misc
ip_tables xfs libcrc32c amdgpu amd_iommu_v2 gpu_sched ttm
drm_kms_helper drm igb crc32c_intel dca nvme i2c_algo_bit nvme_core
wmi pinctrl_amd fuse
[ 9085.167480] CPU: 9 PID: 0 Comm: swapper/9 Not tainted
5.5.0-0.rc5.git0.2.fc32.x86_64 #1
[ 9085.167482] Hardware name: System manufacturer System Product
Name/ROG STRIX X470-I GAMING, BIOS 2901 10/16/2019
[ 9085.167492] RIP: 0010:rtw_tx_report_purge_timer+0x20/0x50 [rtw88]
[ 9085.167496] Code: 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 8b
47 f0 85 c0 75 01 c3 41 54 55 53 48 89 fb 48 c7 c7 58 18 30 c1 e8 92
c8 e4 e2 <0f> 0b 4c 8d 63 d8 4c 89 e7 e8 12 31 7a e3 48 8d 7b e0 48 89
c5 e8
[ 9085.167498] RSP: 0018:ffffab39c03ace78 EFLAGS: 00010286
[ 9085.167501] RAX: 0000000000000000 RBX: ffff9ee2d73d5cf0 RCX: 0000000000000007
[ 9085.167503] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff9ee2fdc59cc0
[ 9085.167505] RBP: ffff9ee2fdc5be80 R08: 00000000000005bf R09: 0000000000000034
[ 9085.167506] R10: ffffab39c03acd20 R11: 0000000000000000 R12: ffff9ee2d73d5cf0
[ 9085.167508] R13: ffffffffc1295180 R14: 0000000000000001 R15: ffff9ee2d73d5cf0
[ 9085.167511] FS:  0000000000000000(0000) GS:ffff9ee2fdc40000(0000)
knlGS:0000000000000000
[ 9085.167513] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9085.167515] CR2: 0000201f0874d000 CR3: 00000007dddec000 CR4: 00000000003406e0
[ 9085.167517] Call Trace:
[ 9085.167520]  <IRQ>
[ 9085.167527]  call_timer_fn+0x2d/0x130
[ 9085.167532]  __run_timers.part.0+0x16f/0x260
[ 9085.167537]  ? timerqueue_add+0x96/0xb0
[ 9085.167540]  ? enqueue_hrtimer+0x36/0x90
[ 9085.167544]  run_timer_softirq+0x26/0x50
[ 9085.167548]  __do_softirq+0xee/0x2ff
[ 9085.167554]  irq_exit+0xe9/0xf0
[ 9085.167557]  smp_apic_timer_interrupt+0x76/0x130
[ 9085.167561]  apic_timer_interrupt+0xf/0x20
[ 9085.167563]  </IRQ>
[ 9085.167567] RIP: 0010:cpuidle_enter_state+0xc9/0x3e0
[ 9085.167570] Code: e8 cc 04 8f ff 80 7c 24 0f 00 74 17 9c 58 0f 1f
44 00 00 f6 c4 02 0f 85 ea 02 00 00 31 ff e8 9e 54 95 ff fb 66 0f 1f
44 00 00 <45> 85 ed 0f 88 40 02 00 00 49 63 d5 4c 2b 64 24 10 48 8d 04
52 48
[ 9085.167572] RSP: 0018:ffffab39c0167e68 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[ 9085.167575] RAX: ffff9ee2fdc6ad80 RBX: ffff9ee2f0d44800 RCX: 000000000000001f
[ 9085.167577] RDX: 0000000000000000 RSI: 0000000022a8dc79 RDI: 0000000000000000
[ 9085.167578] RBP: ffffffffa575a2c0 R08: 000008434e2c4d11 R09: 0000000000001d85
[ 9085.167580] R10: 0000000000000018 R11: ffff9ee2fdc69b64 R12: 000008434e2c4d11
[ 9085.167581] R13: 0000000000000001 R14: 0000000000000001 R15: ffff9ee2f9cc2680
[ 9085.167588]  ? cpuidle_enter_state+0xa4/0x3e0
[ 9085.167591]  cpuidle_enter+0x29/0x40
[ 9085.167596]  do_idle+0x1e4/0x280
[ 9085.167599]  cpu_startup_entry+0x19/0x20
[ 9085.167603]  start_secondary+0x162/0x1b0
[ 9085.167606]  secondary_startup_64+0xb6/0xc0
[ 9085.167610] ---[ end trace f734f2b1bc40ebdb ]---
[12111.505901] rtw_pci 0000:05:00.0: failed to send h2c command
[12111.505956] rtw_pci 0000:05:00.0: failed to send h2c command


Yes, it seems like nothing bad happened, except frequent network disconnect.
Unfortunately I don't know how exactly reproduce it.
But I think if someone propose patch and this WARNING after applying
didn't appears againn at least a week then we can assume that the
problem is fixed.

--
Best Regards,
Mike Gavrilov.
