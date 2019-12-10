Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10E041185C2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 12:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfLJLDa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 06:03:30 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:53727 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfLJLD3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 06:03:29 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 06:03:28 EST
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 157beb9a
        for <linux-wireless@vger.kernel.org>;
        Tue, 10 Dec 2019 10:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:content-type; s=mail; bh=LjXP+V
        FAks+60VK0j8KqKd76dcg=; b=1Fz0wJ2MHF7TpLdLBmwDYwpYxsx7p+gXXvHQJN
        TIRb8OtRlSyo6x4Cfssf+XZdX7JuwCUEhEaWL74gBvzRfyEhXfMrI91qPhYLQLQO
        zCfYYnuJtPMPlxSUw4JNaxUDdWLbKQTZ1JdaiqDsO9ieg5WDLf4snrtg6ugeVpEd
        hOXmiKUjDRu8369814WwfGIdGqJKttQtB/ZH0ejSBGDS7YvTHjoClmTxje2t1Bdl
        gXL8OyVlKWknnuf2McrBHq9wRbuOg2Fjjytmsf3XVXXf+ubtMzJEPYBt9I4T14OQ
        d1wFWOI+bBXoVQlLsHwsX+XAVOMEpgPKr+FZuSdSKMdAPLzg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fc9e8ef8 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-wireless@vger.kernel.org>;
        Tue, 10 Dec 2019 10:01:17 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id b8so9383112oiy.5
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2019 02:56:48 -0800 (PST)
X-Gm-Message-State: APjAAAVEOHP5aZKihOU50JQP51X6HaTtr76IqxsPHJqKMvmKoor7CsaV
        Pl8tzJKAjuSM4fQkqYbxmNlAZ+9MBYBUPrOiOqM=
X-Google-Smtp-Source: APXvYqyq3SAk4BoIXK7WGpQxq7xCebyjFD6RyPhV4rYO5nrrt2GuvN6jylOKUSJTPFTBJJ90b/ZK8xdTglOhM5CY8Vg=
X-Received: by 2002:aca:5143:: with SMTP id f64mr3309047oib.66.1575975407363;
 Tue, 10 Dec 2019 02:56:47 -0800 (PST)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 10 Dec 2019 11:56:36 +0100
X-Gmail-Original-Message-ID: <CAHmME9o2Peyim_B8qhdGjdvrWz=rSXJV-ZnqMtKRs3j5LwuN6A@mail.gmail.com>
Message-ID: <CAHmME9o2Peyim_B8qhdGjdvrWz=rSXJV-ZnqMtKRs3j5LwuN6A@mail.gmail.com>
Subject: WARN_ON in ieee80211_sta_update_pending_airtime triggered in 5.5-rc1
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The below is caused by this card:

zx2c4@thinkpad ~ $ lspci | tail -n 2 | head -n 1
52:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
zx2c4@thinkpad ~ $ lspci -n | tail -n 2 | head -n 1
52:00.0 0280: 8086:2723 (rev 1a)

[   22.547494] ------------[ cut here ]------------
[   22.547496] STA f2:9f:c2:67:25:0e AC 2 txq pending airtime
underflow: 4294967236, 104
[   22.547522] WARNING: CPU: 10 PID: 669 at
net/mac80211/sta_info.c:1931
ieee80211_sta_update_pending_airtime+0x110/
0x120 [mac80211]
[   22.547522] Modules linked in: nvidia_drm(PO) nvidia_modeset(PO)
uvcvideo videobuf2_vmalloc videobuf2_memops vide
obuf2_v4l2 videodev videobuf2_common usbhid joydev mousedev af_packet
8021q iptable_filter bpfilter xt_hl xt_multipo
rt xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
ip6table_filter ip6_tables mei_hdcp intel_rapl_msr wmi_bm
of x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel iwlmvm kvm
mac80211 libarc4 snd_hda_codec_conexant snd_h
da_codec_generic irqbypass iwlwifi crc32_pclmul nvidia(PO)
crc32c_intel snd_hda_intel cfg80211 psmouse snd_intel_dsp
cfg input_leds sdhci_pci snd_hda_codec cqhci snd_hwdep sdhci
snd_hda_core thunderbolt snd_pcm mmc_core xhci_pci snd_
timer xhci_hcd mei_me processor_thermal_device usbcore
intel_rapl_common mei usb_common intel_soc_dts_iosf intel_pch
_thermal wmi thinkpad_acpi ledtrig_audio snd soundcore led_class
rfkill int3403_thermal int340x_thermal_zone pinctrl
_cannonlake pinctrl_intel int3400_thermal evdev acpi_thermal_rel sch_fq_codel
[   22.547540] CPU: 10 PID: 669 Comm: irq/187-iwlwifi Tainted: P     U
    O      5.5.0-rc1+ #2
[   22.547540] Hardware name: LENOVO 20QTCTO1WW/20QTCTO1WW, BIOS
N2OET40W (1.27 ) 10/17/2019
[   22.547547] RIP:
0010:ieee80211_sta_update_pending_airtime+0x110/0x120 [mac80211]
[   22.547548] Code: 8b 44 24 04 eb a0 44 0f b7 c1 48 83 c6 40 89 c1
0f b6 d2 48 c7 c7 80 8b a6 a1 89 44 24 04 c6 05
16 1e 0b 00 01 e8 dd 2f 6c df <0f> 0b 8b 44 24 04 eb 89 0f 1f 84 00 00
00 00 00 55 89 f5 53 48 89
[   22.547549] RSP: 0000:ffff888ff2dcfbd8 EFLAGS: 00010296
[   22.547549] RAX: 0000000000000049 RBX: 00000000ffffff98 RCX: 0000000000000000
[   22.547550] RDX: 0000000000000049 RSI: ffffffff82e643a9 RDI: ffffffff82e647a9
[   22.547550] RBP: ffff888fbcce87c0 R08: 000000053fef7e95 R09: 0000000000000049
[   22.547550] R10: 0000000000000000 R11: ffffffff82e643a9 R12: 0000000000000068
[   22.547551] R13: 0000000000000002 R14: ffff888fb67f45c8 R15: ffff888ff2dcfc88
[   22.547551] FS:  0000000000000000(0000) GS:ffff888ffc480000(0000)
knlGS:0000000000000000
[   22.547552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.547552] CR2: 00005591ac7b47c0 CR3: 0000000fd2eed006 CR4: 00000000003606e0
[   22.547553] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   22.547553] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   22.547553] Call Trace:
[   22.547562]  __ieee80211_tx_status+0x717/0x900 [mac80211]
[   22.547569]  ieee80211_tx_status+0x55/0x60 [mac80211]
[   22.547575]  iwl_mvm_tx_reclaim+0x276/0x3a0 [iwlmvm]
[   22.547580]  iwl_mvm_rx_ba_notif+0x25e/0x2d0 [iwlmvm]
[   22.547585]  iwl_mvm_rx_common+0xc3/0x260 [iwlmvm]
[   22.547591]  iwl_pcie_rx_handle+0x3b3/0xa20 [iwlwifi]
[   22.547593]  ? irq_forced_thread_fn+0x70/0x70
[   22.547597]  iwl_pcie_irq_rx_msix_handler+0x4f/0x100 [iwlwifi]
[   22.547598]  irq_thread_fn+0x17/0x60
[   22.547600]  ? schedule+0x45/0xb0
[   22.547600]  irq_thread+0xc1/0x130
[   22.547601]  ? wake_threads_waitq+0x30/0x30
[   22.547602]  kthread+0xf3/0x130
[   22.547604]  ? irq_thread_dtor+0x80/0x80
[   22.547604]  ? kthread_park+0x80/0x80
[   22.547605]  ret_from_fork+0x1f/0x30
[   22.547606] ---[ end trace a3d28d2de23c3176 ]---
[   22.547607] ------------[ cut here ]------------
[   22.547607] Device phy0 AC 2 pending airtime underflow: 4294967236, 104
[   22.547622] WARNING: CPU: 10 PID: 669 at
net/mac80211/sta_info.c:1940
ieee80211_sta_update_pending_airtime+0xe4/0
x120 [mac80211]
[   22.547622] Modules linked in: nvidia_drm(PO) nvidia_modeset(PO)
uvcvideo videobuf2_vmalloc videobuf2_memops vide
obuf2_v4l2 videodev videobuf2_common usbhid joydev mousedev af_packet
8021q iptable_filter bpfilter xt_hl xt_multipo
rt xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
ip6table_filter ip6_tables mei_hdcp intel_rapl_msr wmi_bm
of x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel iwlmvm kvm
mac80211 libarc4 snd_hda_codec_conexant snd_h
da_codec_generic irqbypass iwlwifi crc32_pclmul nvidia(PO)
crc32c_intel snd_hda_intel cfg80211 psmouse snd_intel_dsp
cfg input_leds sdhci_pci snd_hda_codec cqhci snd_hwdep sdhci
snd_hda_core thunderbolt snd_pcm mmc_core xhci_pci snd_
timer xhci_hcd mei_me processor_thermal_device usbcore
intel_rapl_common mei usb_common intel_soc_dts_iosf intel_pch
_thermal wmi thinkpad_acpi ledtrig_audio snd soundcore led_class
rfkill int3403_thermal int340x_thermal_zone pinctrl
_cannonlake pinctrl_intel int3400_thermal evdev acpi_thermal_rel sch_fq_codel
[   22.547631] CPU: 10 PID: 669 Comm: irq/187-iwlwifi Tainted: P     U
 W  O      5.5.0-rc1+ #2
[   22.547631] Hardware name: LENOVO 20QTCTO1WW/20QTCTO1WW, BIOS
N2OET40W (1.27 ) 10/17/2019
[   22.547638] RIP:
0010:ieee80211_sta_update_pending_airtime+0xe4/0x120 [mac80211]
[   22.547638] Code: 00 00 45 0f b6 ed 48 85 f6 75 07 48 8b b2 40 01
00 00 45 89 e0 89 c1 44 89 ea 48 c7 c7 b8 8b a6
a1 89 44 24 04 e8 09 30 6c df <0f> 0b 8b 44 24 04 eb a0 44 0f b7 c1 48
83 c6 40 89 c1 0f b6 d2 48
[   22.547639] RSP: 0000:ffff888ff2dcfbd8 EFLAGS: 00010296
[   22.547639] RAX: 000000000000003b RBX: 00000000ffffff98 RCX: 0000000000000000
[   22.547640] RDX: 000000000000003b RSI: ffffffff82e6439b RDI: ffffffff82e6479b
[   22.547640] RBP: ffff888fbcce87c0 R08: 000000053ff1312e R09: 000000000000003b
[   22.547640] R10: 0000000000000000 R11: ffffffff82e6439b R12: 0000000000000068
[   22.547641] R13: 0000000000000002 R14: ffff888fb67f45c8 R15: ffff888ff2dcfc88
[   22.547641] FS:  0000000000000000(0000) GS:ffff888ffc480000(0000)
knlGS:0000000000000000
[   22.547642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.547642] CR2: 00005591ac7b47c0 CR3: 0000000fd2eed006 CR4: 00000000003606e0
[   22.547642] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   22.547643] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   22.547643] Call Trace:
[   22.547650]  __ieee80211_tx_status+0x717/0x900 [mac80211]
[   22.547656]  ieee80211_tx_status+0x55/0x60 [mac80211]
[   22.547660]  iwl_mvm_tx_reclaim+0x276/0x3a0 [iwlmvm]
[   22.547664]  iwl_mvm_rx_ba_notif+0x25e/0x2d0 [iwlmvm]
[   22.547668]  iwl_mvm_rx_common+0xc3/0x260 [iwlmvm]
[   22.547671]  iwl_pcie_rx_handle+0x3b3/0xa20 [iwlwifi]
[   22.547673]  ? irq_forced_thread_fn+0x70/0x70
[   22.547676]  iwl_pcie_irq_rx_msix_handler+0x4f/0x100 [iwlwifi]
[   22.547677]  irq_thread_fn+0x17/0x60
[   22.547678]  ? schedule+0x45/0xb0
[   22.547679]  irq_thread+0xc1/0x130
[   22.547679]  ? wake_threads_waitq+0x30/0x30
[   22.547680]  kthread+0xf3/0x130
[   22.547681]  ? irq_thread_dtor+0x80/0x80
[   22.547682]  ? kthread_park+0x80/0x80
[   22.547683]  ret_from_fork+0x1f/0x30
[   22.547683] ---[ end trace a3d28d2de23c3177 ]---
