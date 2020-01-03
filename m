Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB9D312FD72
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2020 21:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgACUOO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jan 2020 15:14:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43966 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgACUOO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jan 2020 15:14:14 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so40873429ioo.10;
        Fri, 03 Jan 2020 12:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rV3hLJ1PYGvGESjNlIumRkdp9DivEV3BkcOThoD4wIQ=;
        b=Rbjfqvhuozr4fZ8UvcV394OYIjbGu/5fWOFttaqTNj0GmxH8clPNH1uZPjRvpAdC9i
         7krA6DG0zKw+973kEo3YnUq1H4QL8h54DWADBFClz7mRCIfHgZhBNU9vZhhte0cdNeb1
         piA2Tzzz67Oi3eywLwTPCKoLvt/Rrj+GgrVCNm/YlBpNj3MlmxTwkBQQr/WUOY+OyTIq
         DmHR9HK8XKyKlleS/opO4qWdl+eiIbnNzRQUDdaEm44dQJWB7+cznpmPDlnE1lqsqnrA
         RzPRdRgF0Wdspz8/4XC23LKiS1e0er2qdcY4UxR2DDyENAB7Y8frj6W8e2Gq8LezCPdX
         rY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rV3hLJ1PYGvGESjNlIumRkdp9DivEV3BkcOThoD4wIQ=;
        b=jQjmM/+wEmpAAcyOmYk1sIkIIXHzQb9nQK0FsNcMaMMxZGvbwl8X52jsrfTqPid/3c
         h1LQkW9LnDqttjf+dVAO1IHguIoPGaFysUe7KJTV1utblCemDiQeXQkvkXYeu4f6pSDx
         er/eg6Xkv+qCFWrx8oIurXhKSZ7Ml/7VEzdQQphzafQR8NrKwXPb4GF96XLfy4UPyTwS
         NR1bo5UipZntYNIda9MhFNNpCxvrK+FPJn+IVepAuJl/IB9O+7tMQ7KliKujarLHpAnQ
         /U8iC2CAY8IC47PNEX5FYXJ8TP0i+HxHRT/1H4xSZz8HCeGogZzff1v329emBfei+LlC
         Ds4g==
X-Gm-Message-State: APjAAAXm4rXFbjZV54n+mk+eOwh8mqUC5S+q5xkv7P8mbQmr7XssUeOe
        2SdOTnnauekvz5AXhaGlxnJGzF7RExHpj8vENw5G2qMmXpF0tg==
X-Google-Smtp-Source: APXvYqxYD5xt5uosDGM15eDbeGo7npu7qR8B1fpV18MjDSjrXfQMiLdLWb7RNTH8xrK53/eu9JDIC0z4izMEmjojM8M=
X-Received: by 2002:a6b:8e51:: with SMTP id q78mr56753106iod.179.1578082452839;
 Fri, 03 Jan 2020 12:14:12 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 4 Jan 2020 01:14:02 +0500
Message-ID: <CABXGCsODygM_F4JCesQOH_i+QA9XLWXvcT2o_K=dW6R8ZeJ6rQ@mail.gmail.com>
Subject: BUG: kernel NULL pointer dereference, address: 0000000000000070
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>
Cc:     =?UTF-8?B?0KDQuNGI0LDRgiDQoNC40LzQvtCy0LjRhyDQotC10YDQtdCz0YPQu9C+0LI=?= 
        <rtereguloff@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi folks.
My friend today launched stress-ng multiple times and he could twice
time reproduce the odd bug, which looks like a bug in the wifi driver.

lspci detects this device as:
Network controller: Realtek Semiconductor Co., Ltd. RTL8822BE
802.11a/b/g/n/ac WiFi adapter

I decided to report here because every time after this bug happens the
system became fully unresponsive. Which is really very annoying.

stress-ng-iomix (147381): drop_caches: 3
stress-ng-iomix (147417): drop_caches: 3
stress-ng-iomix (147415): drop_caches: 3
rtw_pci 0000:04:00.0: stop vif ea:01:4e:ce:99:c5 on port 0
rtw_pci 0000:04:00.0: start vif 06:72:1e:97:fc:83 on port 0
BUG: kernel NULL pointer dereference, address: 0000000000000070
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 1 PID: 819 Comm: irq/76-rtwpci Not tainted
5.5.0-0.rc4.git0.1.fc32.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X470-I GAMING, BIOS 3004 12/16/2019
RIP: 0010:rtw_pci_tx_isr+0x96/0x230 [rtwpci]
Code: 0e 01 00 00 48 8b 44 24 08 44 0f b6 64 24 13 48 c1 e0 06 49 83
c4 01 48 89 04 24 49 c1 e4 06 49 01 dc 4c 89 e7 e8 8a d1 96 ce <8b> 50
70 48 8b 70 48 49 89 c6 48 8b 03 48 8d b8 b0 00 00 00 48 8b
RSP: 0018:ffffad9f00d6fe08 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff9b66766e5d68 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000086 RDI: 0000000000000086
RBP: 000000000000006a R08: 0000000000000000 R09: 0000000000000059
R10: 0000000000000000 R11: ffff9b667da6ae38 R12: ffff9b66766e5ee8
R13: ffff9b66766e1e80 R14: 0000000000000005 R15: ffff9b66766e07c0
FS:  0000000000000000(0000) GS:ffff9b667da40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000070 CR3: 0000000333690000 CR4: 00000000003406e0
Call Trace:
 rtw_pci_interrupt_threadfn+0x15b/0x210 [rtwpci]
 ? irq_finalize_oneshot.part.0+0xf0/0xf0
 irq_thread_fn+0x20/0x60
 irq_thread+0xdc/0x170
 ? irq_forced_thread_fn+0x80/0x80
 kthread+0xf9/0x130
 ? irq_thread_check_affinity+0xf0/0xf0
 ? kthread_park+0x90/0x90
 ret_from_fork+0x22/0x40
Modules linked in: salsa20_generic camellia_generic
camellia_aesni_avx2 camellia_aesni_avx_x86_64 camellia_x86_64
cast6_avx_x86_64 cast6_generic cast_common serpent_avx2
serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic twofish_generic
twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 twofish_common
ofb tgr192 wp512 rmd320 rmd256 rmd160 rmd128 md4 uinput rfcomm
xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp
nf_conntrack_tftp tun bridge stp llc nft_objref
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nf_tables_set nft_chain_nat nf_tables
ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw iptable_security
ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
iptable_filter cmac bnep sunrpc
 snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio rtwpci
snd_hda_codec_hdmi rtw88 snd_hda_intel snd_intel_dspcfg edac_mce_amd
snd_usb_audio uvcvideo videobuf2_vmalloc videobuf2_memops
snd_hda_codec snd_usbmidi_lib videobuf2_v4l2 snd_hda_core
videobuf2_common mac80211 btusb snd_rawmidi kvm snd_hwdep btrtl
videodev snd_seq btbcm btintel snd_seq_device irqbypass bluetooth
cfg80211 snd_pcm eeepc_wmi mc joydev crct10dif_pclmul snd_timer
crc32_pclmul asus_wmi ecdh_generic snd sparse_keymap rfkill sp5100_tco
ccp ecc video soundcore libarc4 wmi_bmof pcspkr i2c_piix4
ghash_clmulni_intel k10temp gpio_amdpt gpio_generic acpi_cpufreq
binfmt_misc ip_tables amdgpu amd_iommu_v2 gpu_sched ttm drm_kms_helper
drm igb crc32c_intel uas dca i2c_algo_bit usb_storage wmi pinctrl_amd
fuse
CR2: 0000000000000070
---[ end trace 5e058b15ff4e55d6 ]---


# /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname
-r`/kernel/drivers/net/wireless/realtek/rtw88/rtwpci.ko.debug
rtw_pci_tx_isr+0x96
rtw_pci_tx_isr+0x96/0x230:
rtw_pci_tx_isr at
/usr/src/debug/kernel-5.4.fc32/linux-5.5.0-0.rc4.git0.1.fc32.x86_64/drivers/net/wireless/realtek/rtw88/pci.c:836

# eu-addr2line -e /lib/debug/lib/modules/`uname
-r`/kernel/drivers/net/wireless/realtek/rtw88/rtwpci.ko.debug
rtw_pci_tx_isr+0x96
drivers/net/wireless/realtek/rtw88/pci.c:836:3

$ uname -r
5.5.0-0.rc4.git0.1.fc32.x86_64

--
Best Regards,
Mike Gavrilov.
