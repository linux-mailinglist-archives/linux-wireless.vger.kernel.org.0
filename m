Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E394B0E5D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 14:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbiBJN0E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 08:26:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbiBJN0D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 08:26:03 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B751BB
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 05:26:02 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id 103so2985232uag.4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 05:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=scwT8+/S3f5jtmyYj25PieiroqBU/G6qH66D/RpAS74=;
        b=fDYVi6gMho1GQ6zPon71ErEXmcgxZSiXZGtEewhmCbIf9LQvalK9kdsmaZhkb8YE6H
         GNDOMvv33+vPbRWdl5eBIpucixmVrGe8Y/I6q8WFkaWsQ+KqqGbYyoFWj4YJmspSpY7F
         /eDd+TAvwgm2ssXSkey/EzUkfliim6qq2jSpCCRzVlosOqmqlKtznDLga5GlcV9sksc9
         ZZ7iO5s3VbE3lolm874CZrmcTu090y4G9/78fGB8l3GicumMWQ1TJklfEvq3ofgmwH9M
         epY3gicQ8nXIzevF5Y3kqzdyc97YHwaIvDUGEHulcLo/X47ByzZMIE6zfQOUdQeTxAv1
         2LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=scwT8+/S3f5jtmyYj25PieiroqBU/G6qH66D/RpAS74=;
        b=H4duKzCH1Yy2BUdGrnJYda6VZnLlqdlWNZeNv/L0ctXVb27mEdSe4d06tnW72QxSYk
         zlHybCByvexcmfLWvUmpPOLnJc468PXKn5dcLlq8G4F/XASFGaN3MTYdLq2m77MHCpgi
         B6JlQqHYXMBlmORt+lO/c4h8ZHIBc4o1jFwrR67jiBaiHIUfbNWbscWILNJhjkFweV+e
         HRP5ESdB8QCD/b1XqbCI/InUyPqxSh48Hp38n7KCHx5qng4lINaMDJ8HynAo3HxJY0Rh
         9HS9nTZEb0+8zH+ZZUACGNgPpkmqVqQPUkWXQ5m5QwP2ccT8Ca5mmVrS97oU0+t9zvrF
         MpHg==
X-Gm-Message-State: AOAM532cWuD5YFR+wDhFmZKGvULHGXPYj+MBXYhLq21GdGJfKKBgJDre
        b1IPzLyIZL0yWqgbGjtvnCuakxr5bFa7Nu8v7xBsomIjD+oPRA==
X-Google-Smtp-Source: ABdhPJwTvvZlCZnrV3Ojt+QqjYQA1YJul5bQeVXvDX9SEVNwOtb3QFaUGD5rfiGvh4vf4U/PfYP2vqiRleGjjXZG5nI=
X-Received: by 2002:ab0:314c:: with SMTP id e12mr2434168uam.108.1644499558980;
 Thu, 10 Feb 2022 05:25:58 -0800 (PST)
MIME-Version: 1.0
From:   Maxim Klimenko Sergievich <klimenkomaximsergievich@gmail.com>
Date:   Thu, 10 Feb 2022 15:25:47 +0200
Message-ID: <CAEqd1ZZucLqJMEktzmnCKzwXXkswzqJNf_yr2HZV20LcWtiR6A@mail.gmail.com>
Subject: Possible bug in cfg80211
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Modules settings:
blacklist pcspkr
blacklist bluetooth
blacklist kvm
blacklist kvm_amd

# options amdgpu reset_method=5
options snd_hda_intel power_save=1
options rtw88_core support_bf=0
options cfg80211 cfg80211_disable_40mhz_24ghz=1 bss_entries_limit=1
options mac80211 minstrel_vht_only=1 ieee80211_default_rc_algo=minstrel_ht

Dmesg log:
[  312.758466] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  312.758468] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  312.758469] CR2: 0000313609cd2000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  312.758471] Call Trace:
[  312.758475]  <IRQ>
[  312.758479]  ? __kmalloc+0x18c/0x360
[  312.758488]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  312.758527]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  312.758592]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  312.758640]  ? enqueue_task_fair+0x8e/0x690
[  312.758649]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  312.758689]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  312.758733]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  312.758772]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  312.758780]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  312.758785]  __napi_poll+0x2a/0x170
[  312.758791]  net_rx_action+0x275/0x330
[  312.758795]  __do_softirq+0xd0/0x2ca
[  312.758800]  do_softirq+0xb8/0xe0
[  312.758805]  </IRQ>
[  312.758806]  <TASK>
[  312.758807]  __local_bh_enable_ip+0x5a/0x70
[  312.758809]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  312.758814]  ? disable_irq_nosync+0x10/0x10
[  312.758819]  irq_thread_fn+0x20/0x60
[  312.758822]  irq_thread+0xc8/0x190
[  312.758825]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  312.758828]  ? irq_thread_check_affinity+0xe0/0xe0
[  312.758831]  kthread+0x132/0x160
[  312.758834]  ? set_kthread_struct+0x50/0x50
[  312.758836]  ret_from_fork+0x22/0x30
[  312.758842]  </TASK>
[  312.758843] ---[ end trace 5699e65abef40d98 ]---
[  312.860567] ------------[ cut here ]------------
[  312.860573] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  312.860652] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  312.860736]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  312.860805] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  312.860811] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  312.860814] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  312.860875] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  312.860878] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  312.860882] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ed0bc29410
[  312.860885] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  312.860887] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  312.860889] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  312.860891] R13: ffffa0ed13e9b400 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  312.860894] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  312.860897] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  312.860900] CR2: 0000313609cd2000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  312.860903] Call Trace:
[  312.860908]  <IRQ>
[  312.860913]  ? __kmalloc+0x18c/0x360
[  312.860926]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  312.860991]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  312.861053]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  312.861134]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  312.861201]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  312.861276]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  312.861341]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  312.861354]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  312.861361]  __napi_poll+0x2a/0x170
[  312.861370]  net_rx_action+0x275/0x330
[  312.861376]  __do_softirq+0xd0/0x2ca
[  312.861385]  do_softirq+0xb8/0xe0
[  312.861392]  </IRQ>
[  312.861393]  <TASK>
[  312.861395]  __local_bh_enable_ip+0x5a/0x70
[  312.861398]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  312.861406]  ? disable_irq_nosync+0x10/0x10
[  312.861414]  irq_thread_fn+0x20/0x60
[  312.861419]  irq_thread+0xc8/0x190
[  312.861424]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  312.861429]  ? irq_thread_check_affinity+0xe0/0xe0
[  312.861434]  kthread+0x132/0x160
[  312.861439]  ? set_kthread_struct+0x50/0x50
[  312.861442]  ret_from_fork+0x22/0x30
[  312.861452]  </TASK>
[  312.861454] ---[ end trace 5699e65abef40d99 ]---
[  313.081658] ------------[ cut here ]------------
[  313.081663] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.081734] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  313.081852]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  313.081908] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  313.081913] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  313.081916] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.082011] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  313.082013] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  313.082016] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ed0bc29028
[  313.082017] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  313.082019] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  313.082020] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  313.082021] R13: ffffa0ed45073c00 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  313.082023] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  313.082024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  313.082041] CR2: 0000313609cd2000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  313.082043] Call Trace:
[  313.082046]  <IRQ>
[  313.082049]  ? __kmalloc+0x18c/0x360
[  313.082055]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.082093]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.082128]  ? free_debug_processing+0x1c5/0x240
[  313.082131]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.082181]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.082220]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.082263]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.082302]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.082309]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.082313]  __napi_poll+0x2a/0x170
[  313.082318]  net_rx_action+0x275/0x330
[  313.082321]  __do_softirq+0xd0/0x2ca
[  313.082325]  do_softirq+0xb8/0xe0
[  313.082329]  </IRQ>
[  313.082330]  <TASK>
[  313.082331]  __local_bh_enable_ip+0x5a/0x70
[  313.082333]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.082338]  ? disable_irq_nosync+0x10/0x10
[  313.082341]  irq_thread_fn+0x20/0x60
[  313.082344]  irq_thread+0xc8/0x190
[  313.082347]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  313.082350]  ? irq_thread_check_affinity+0xe0/0xe0
[  313.082353]  kthread+0x132/0x160
[  313.082355]  ? set_kthread_struct+0x50/0x50
[  313.082357]  ret_from_fork+0x22/0x30
[  313.082362]  </TASK>
[  313.082363] ---[ end trace 5699e65abef40d9a ]---
[  313.167561] ------------[ cut here ]------------
[  313.167569] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.167667] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  313.167753]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  313.167813] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  313.167820] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  313.167822] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.167885] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  313.167888] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  313.167892] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ecb8354ca8
[  313.167894] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  313.167897] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  313.167899] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  313.167901] R13: ffffa0ed13e98400 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  313.167904] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  313.167907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  313.167909] CR2: 00002e020122e000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  313.167913] Call Trace:
[  313.167917]  <IRQ>
[  313.167921]  ? __kmalloc+0x18c/0x360
[  313.167930]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.167997]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.168059]  ? free_debug_processing+0x1c5/0x240
[  313.168065]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.168136]  ? enqueue_task_fair+0x8e/0x690
[  313.168151]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.168194]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.168238]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.168276]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.168284]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.168288]  __napi_poll+0x2a/0x170
[  313.168292]  net_rx_action+0x275/0x330
[  313.168296]  __do_softirq+0xd0/0x2ca
[  313.168300]  do_softirq+0xb8/0xe0
[  313.168304]  </IRQ>
[  313.168304]  <TASK>
[  313.168305]  __local_bh_enable_ip+0x5a/0x70
[  313.168308]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.168312]  ? disable_irq_nosync+0x10/0x10
[  313.168315]  irq_thread_fn+0x20/0x60
[  313.168319]  irq_thread+0xc8/0x190
[  313.168321]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  313.168324]  ? irq_thread_check_affinity+0xe0/0xe0
[  313.168327]  kthread+0x132/0x160
[  313.168330]  ? set_kthread_struct+0x50/0x50
[  313.168332]  ret_from_fork+0x22/0x30
[  313.168337]  </TASK>
[  313.168338] ---[ end trace 5699e65abef40d9b ]---
[  313.372552] ------------[ cut here ]------------
[  313.372557] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.372627] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  313.372703]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  313.372763] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  313.372769] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  313.372772] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.372833] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  313.372836] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  313.372839] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ecb8354ca8
[  313.372842] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  313.372844] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  313.372846] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  313.372848] R13: ffffa0ec610d7000 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  313.372851] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  313.372854] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  313.372857] CR2: 00002e020122e000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  313.372860] Call Trace:
[  313.372864]  <IRQ>
[  313.372868]  ? __kmalloc+0x18c/0x360
[  313.372877]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.372941]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.373001]  ? free_debug_processing+0x1c5/0x240
[  313.373006]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.373076]  ? enqueue_task_fair+0x8e/0x690
[  313.373090]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.373156]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.373230]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.373295]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.373306]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.373313]  __napi_poll+0x2a/0x170
[  313.373320]  net_rx_action+0x275/0x330
[  313.373326]  __do_softirq+0xd0/0x2ca
[  313.373332]  do_softirq+0xb8/0xe0
[  313.373338]  </IRQ>
[  313.373339]  <TASK>
[  313.373341]  __local_bh_enable_ip+0x5a/0x70
[  313.373345]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.373352]  ? disable_irq_nosync+0x10/0x10
[  313.373358]  irq_thread_fn+0x20/0x60
[  313.373363]  irq_thread+0xc8/0x190
[  313.373367]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  313.373372]  ? irq_thread_check_affinity+0xe0/0xe0
[  313.373378]  kthread+0x132/0x160
[  313.373381]  ? set_kthread_struct+0x50/0x50
[  313.373385]  ret_from_fork+0x22/0x30
[  313.373393]  </TASK>
[  313.373394] ---[ end trace 5699e65abef40d9c ]---
[  313.474711] ------------[ cut here ]------------
[  313.474716] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.474787] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  313.474863]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  313.474923] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  313.474929] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  313.474932] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.474992] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  313.474996] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  313.474999] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ecb83e58c0
[  313.475002] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  313.475004] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  313.475006] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  313.475008] R13: ffffa0ecfcafc400 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  313.475011] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  313.475014] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  313.475017] CR2: 00002e020122e000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  313.475020] Call Trace:
[  313.475024]  <IRQ>
[  313.475028]  ? __kmalloc+0x18c/0x360
[  313.475037]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.475102]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.475161]  ? enqueue_task+0x51/0x190
[  313.475167]  ? default_send_IPI_single_phys+0x34/0x60
[  313.475175]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.475253]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.475318]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.475392]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.475458]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.475469]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.475476]  __napi_poll+0x2a/0x170
[  313.475483]  net_rx_action+0x275/0x330
[  313.475488]  __do_softirq+0xd0/0x2ca
[  313.475495]  do_softirq+0xb8/0xe0
[  313.475500]  </IRQ>
[  313.475501]  <TASK>
[  313.475503]  __local_bh_enable_ip+0x5a/0x70
[  313.475506]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.475514]  ? disable_irq_nosync+0x10/0x10
[  313.475519]  irq_thread_fn+0x20/0x60
[  313.475525]  irq_thread+0xc8/0x190
[  313.475530]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  313.475534]  ? irq_thread_check_affinity+0xe0/0xe0
[  313.475540]  kthread+0x132/0x160
[  313.475543]  ? set_kthread_struct+0x50/0x50
[  313.475547]  ret_from_fork+0x22/0x30
[  313.475579]  </TASK>
[  313.475581] ---[ end trace 5699e65abef40d9d ]---
[  313.679551] ------------[ cut here ]------------
[  313.679557] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.679632] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  313.679720]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  313.679782] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  313.679787] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  313.679791] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.679852] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  313.679855] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  313.679859] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ec9c10c1b8
[  313.679861] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  313.679863] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  313.679865] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  313.679867] R13: ffffa0ecf536cc00 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  313.679870] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  313.679873] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  313.679876] CR2: 00007f0181d3ead8 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  313.679879] Call Trace:
[  313.679883]  <IRQ>
[  313.679887]  ? __kmalloc+0x18c/0x360
[  313.679896]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.679960]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.680022]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.680092]  ? enqueue_task_fair+0x8e/0x690
[  313.680106]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.680173]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.680247]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.680313]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.680325]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.680332]  __napi_poll+0x2a/0x170
[  313.680339]  net_rx_action+0x275/0x330
[  313.680345]  __do_softirq+0xd0/0x2ca
[  313.680352]  do_softirq+0xb8/0xe0
[  313.680357]  </IRQ>
[  313.680359]  <TASK>
[  313.680360]  __local_bh_enable_ip+0x5a/0x70
[  313.680364]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.680371]  ? disable_irq_nosync+0x10/0x10
[  313.680377]  irq_thread_fn+0x20/0x60
[  313.680382]  irq_thread+0xc8/0x190
[  313.680387]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  313.680392]  ? irq_thread_check_affinity+0xe0/0xe0
[  313.680397]  kthread+0x132/0x160
[  313.680401]  ? set_kthread_struct+0x50/0x50
[  313.680405]  ret_from_fork+0x22/0x30
[  313.680413]  </TASK>
[  313.680414] ---[ end trace 5699e65abef40d9e ]---
[  313.781924] ------------[ cut here ]------------
[  313.781928] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.782000] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  313.782076]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  313.782134] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  313.782140] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  313.782143] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.782203] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  313.782207] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  313.782210] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ed13d787f8
[  313.782213] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  313.782215] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  313.782217] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  313.782219] R13: ffffa0ed00808400 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  313.782223] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  313.782226] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  313.782228] CR2: 0000160a03f43000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  313.782232] Call Trace:
[  313.782236]  <IRQ>
[  313.782240]  ? __kmalloc+0x18c/0x360
[  313.782249]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.782313]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.782352]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.782418]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.782458]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.782501]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.782540]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.782547]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.782551]  __napi_poll+0x2a/0x170
[  313.782556]  net_rx_action+0x275/0x330
[  313.782560]  __do_softirq+0xd0/0x2ca
[  313.782564]  do_softirq+0xb8/0xe0
[  313.782567]  </IRQ>
[  313.782568]  <TASK>
[  313.782569]  __local_bh_enable_ip+0x5a/0x70
[  313.782571]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.782576]  ? disable_irq_nosync+0x10/0x10
[  313.782579]  irq_thread_fn+0x20/0x60
[  313.782583]  irq_thread+0xc8/0x190
[  313.782585]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  313.782588]  ? irq_thread_check_affinity+0xe0/0xe0
[  313.782591]  kthread+0x132/0x160
[  313.782594]  ? set_kthread_struct+0x50/0x50
[  313.782596]  ret_from_fork+0x22/0x30
[  313.782602]  </TASK>
[  313.782603] ---[ end trace 5699e65abef40d9f ]---
[  313.884429] ------------[ cut here ]------------
[  313.884434] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.884505] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  313.884580]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  313.884641] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  313.884647] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  313.884649] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  313.884710] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  313.884713] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  313.884717] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ed3fe72ca8
[  313.884719] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  313.884722] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  313.884724] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  313.884726] R13: ffffa0ed4123e400 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  313.884728] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  313.884732] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  313.884734] CR2: 0000160a03f43000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  313.884737] Call Trace:
[  313.884741]  <IRQ>
[  313.884745]  ? __kmalloc+0x18c/0x360
[  313.884754]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.884819]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  313.884880]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.884959]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.885025]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.885098]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  313.885164]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.885175]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.885182]  __napi_poll+0x2a/0x170
[  313.885189]  net_rx_action+0x275/0x330
[  313.885194]  __do_softirq+0xd0/0x2ca
[  313.885201]  do_softirq+0xb8/0xe0
[  313.885206]  </IRQ>
[  313.885208]  <TASK>
[  313.885209]  __local_bh_enable_ip+0x5a/0x70
[  313.885213]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  313.885220]  ? disable_irq_nosync+0x10/0x10
[  313.885226]  irq_thread_fn+0x20/0x60
[  313.885231]  irq_thread+0xc8/0x190
[  313.885236]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  313.885241]  ? irq_thread_check_affinity+0xe0/0xe0
[  313.885246]  kthread+0x132/0x160
[  313.885250]  ? set_kthread_struct+0x50/0x50
[  313.885253]  ret_from_fork+0x22/0x30
[  313.885261]  </TASK>
[  313.885263] ---[ end trace 5699e65abef40da0 ]---
[  314.089745] ------------[ cut here ]------------
[  314.089755] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.089817] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  314.089872]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  314.089920] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  314.089925] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  314.089928] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.089965] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  314.089966] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  314.089969] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ed3fe72730
[  314.089970] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  314.089972] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  314.089973] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  314.089974] R13: ffffa0ed14b61000 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  314.089976] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  314.089978] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  314.089979] CR2: 00002e0201eae5e0 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  314.089982] Call Trace:
[  314.089985]  <IRQ>
[  314.089989]  ? __kmalloc+0x18c/0x360
[  314.089998]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.090038]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.090074]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.090121]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.090159]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.090203]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.090241]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.090248]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.090252]  __napi_poll+0x2a/0x170
[  314.090257]  net_rx_action+0x275/0x330
[  314.090260]  __do_softirq+0xd0/0x2ca
[  314.090264]  do_softirq+0xb8/0xe0
[  314.090268]  </IRQ>
[  314.090269]  <TASK>
[  314.090269]  __local_bh_enable_ip+0x5a/0x70
[  314.090272]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.090276]  ? disable_irq_nosync+0x10/0x10
[  314.090280]  irq_thread_fn+0x20/0x60
[  314.090283]  irq_thread+0xc8/0x190
[  314.090286]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  314.090289]  ? irq_thread_check_affinity+0xe0/0xe0
[  314.090292]  kthread+0x132/0x160
[  314.090294]  ? set_kthread_struct+0x50/0x50
[  314.090296]  ret_from_fork+0x22/0x30
[  314.090301]  </TASK>
[  314.090302] ---[ end trace 5699e65abef40da1 ]---
[  314.191700] ------------[ cut here ]------------
[  314.191705] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.191777] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  314.191853]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  314.191915] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  314.191920] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  314.191923] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.191984] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  314.191987] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  314.191991] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ecf860b668
[  314.191994] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  314.191996] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  314.191998] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  314.192000] R13: ffffa0ed13fc9800 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  314.192003] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  314.192006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  314.192009] CR2: 0000313608818000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  314.192012] Call Trace:
[  314.192016]  <IRQ>
[  314.192020]  ? __kmalloc+0x18c/0x360
[  314.192030]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.192095]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.192138]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.192193]  ? enqueue_task_fair+0x8e/0x690
[  314.192203]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.192242]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.192286]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.192343]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.192351]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.192355]  __napi_poll+0x2a/0x170
[  314.192360]  net_rx_action+0x275/0x330
[  314.192363]  __do_softirq+0xd0/0x2ca
[  314.192368]  do_softirq+0xb8/0xe0
[  314.192373]  </IRQ>
[  314.192374]  <TASK>
[  314.192375]  __local_bh_enable_ip+0x5a/0x70
[  314.192377]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.192381]  ? disable_irq_nosync+0x10/0x10
[  314.192385]  irq_thread_fn+0x20/0x60
[  314.192388]  irq_thread+0xc8/0x190
[  314.192391]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  314.192394]  ? irq_thread_check_affinity+0xe0/0xe0
[  314.192397]  kthread+0x132/0x160
[  314.192400]  ? set_kthread_struct+0x50/0x50
[  314.192402]  ret_from_fork+0x22/0x30
[  314.192408]  </TASK>
[  314.192409] ---[ end trace 5699e65abef40da2 ]---
[  314.396705] ------------[ cut here ]------------
[  314.396709] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.396781] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  314.396857]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  314.396918] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  314.396924] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  314.396927] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.396988] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  314.396991] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  314.396995] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ed3ffc71b8
[  314.396997] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  314.397000] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  314.397002] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  314.397004] R13: ffffa0ecc8adcc00 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  314.397007] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  314.397010] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  314.397012] CR2: 0000313608818000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  314.397022] Call Trace:
[  314.397027]  <IRQ>
[  314.397031]  ? __kmalloc+0x18c/0x360
[  314.397042]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.397107]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.397169]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.397248]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.397314]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.397388]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.397453]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.397465]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.397472]  __napi_poll+0x2a/0x170
[  314.397480]  net_rx_action+0x275/0x330
[  314.397486]  __do_softirq+0xd0/0x2ca
[  314.397494]  do_softirq+0xb8/0xe0
[  314.397501]  </IRQ>
[  314.397502]  <TASK>
[  314.397504]  __local_bh_enable_ip+0x5a/0x70
[  314.397508]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.397515]  ? disable_irq_nosync+0x10/0x10
[  314.397522]  irq_thread_fn+0x20/0x60
[  314.397528]  irq_thread+0xc8/0x190
[  314.397532]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  314.397537]  ? irq_thread_check_affinity+0xe0/0xe0
[  314.397543]  kthread+0x132/0x160
[  314.397547]  ? set_kthread_struct+0x50/0x50
[  314.397550]  ret_from_fork+0x22/0x30
[  314.397559]  </TASK>
[  314.397561] ---[ end trace 5699e65abef40da3 ]---
[  314.499209] ------------[ cut here ]------------
[  314.499216] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.499293] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  314.499378]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  314.499484] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  314.499493] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  314.499497] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.499564] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  314.499567] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  314.499571] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ecf860dca8
[  314.499574] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  314.499576] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  314.499578] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  314.499580] R13: ffffa0ed00989400 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  314.499583] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  314.499586] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  314.499589] CR2: 0000282203e16f00 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  314.499592] Call Trace:
[  314.499597]  <IRQ>
[  314.499603]  ? __kmalloc+0x18c/0x360
[  314.499616]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.499680]  ? kretprobe_trampoline+0x25/0x50
[  314.499688]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.499740]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.499792]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.499831]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.499879]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.499918]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.499925]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.499929]  __napi_poll+0x2a/0x170
[  314.499934]  net_rx_action+0x275/0x330
[  314.499938]  __do_softirq+0xd0/0x2ca
[  314.499943]  do_softirq+0xb8/0xe0
[  314.499946]  </IRQ>
[  314.499947]  <TASK>
[  314.499948]  __local_bh_enable_ip+0x5a/0x70
[  314.499950]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.499955]  ? disable_irq_nosync+0x10/0x10
[  314.499959]  irq_thread_fn+0x20/0x60
[  314.499962]  irq_thread+0xc8/0x190
[  314.499965]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  314.499968]  ? irq_thread_check_affinity+0xe0/0xe0
[  314.499971]  kthread+0x132/0x160
[  314.499974]  ? set_kthread_struct+0x50/0x50
[  314.499976]  ret_from_fork+0x22/0x30
[  314.499981]  </TASK>
[  314.499982] ---[ end trace 5699e65abef40da4 ]---
[  314.706452] ------------[ cut here ]------------
[  314.706457] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.706528] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  314.706604]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  314.706663] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  314.706669] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  314.706672] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.706733] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  314.706736] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  314.706740] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ed3ca4aca8
[  314.706742] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  314.706745] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  314.706747] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  314.706749] R13: ffffa0ecf536cc00 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  314.706752] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  314.706755] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  314.706758] CR2: 0000282209edde30 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  314.706761] Call Trace:
[  314.706767]  <IRQ>
[  314.706771]  ? __kmalloc+0x18c/0x360
[  314.706782]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.706846]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.706906]  ? skb_release_data+0x136/0x180
[  314.706915]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.706992]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.707055]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.707102]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.707140]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.707147]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.707151]  __napi_poll+0x2a/0x170
[  314.707155]  net_rx_action+0x275/0x330
[  314.707158]  __do_softirq+0xd0/0x2ca
[  314.707163]  do_softirq+0xb8/0xe0
[  314.707166]  </IRQ>
[  314.707167]  <TASK>
[  314.707168]  __local_bh_enable_ip+0x5a/0x70
[  314.707170]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.707175]  ? disable_irq_nosync+0x10/0x10
[  314.707179]  irq_thread_fn+0x20/0x60
[  314.707182]  irq_thread+0xc8/0x190
[  314.707185]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  314.707188]  ? irq_thread_check_affinity+0xe0/0xe0
[  314.707191]  kthread+0x132/0x160
[  314.707193]  ? set_kthread_struct+0x50/0x50
[  314.707195]  ret_from_fork+0x22/0x30
[  314.707200]  </TASK>
[  314.707201] ---[ end trace 5699e65abef40da5 ]---
[  314.805928] ------------[ cut here ]------------
[  314.805933] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.806004] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  314.806080]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  314.806139] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  314.806145] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  314.806148] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.806208] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  314.806212] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  314.806216] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ed3cac9028
[  314.806218] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  314.806246] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  314.806248] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  314.806251] R13: ffffa0ecc8add400 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  314.806254] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  314.806257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  314.806260] CR2: 0000313608083000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  314.806263] Call Trace:
[  314.806266]  <IRQ>
[  314.806270]  ? __kmalloc+0x18c/0x360
[  314.806280]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.806345]  ? tcp_ack+0x677/0x1460
[  314.806353]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.806414]  ? init_object+0x73/0x90
[  314.806420]  ? free_debug_processing+0x1c5/0x240
[  314.806425]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.806505]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.806573]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.806649]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.806716]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.806728]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.806735]  __napi_poll+0x2a/0x170
[  314.806741]  net_rx_action+0x275/0x330
[  314.806747]  __do_softirq+0xd0/0x2ca
[  314.806754]  do_softirq+0xb8/0xe0
[  314.806759]  </IRQ>
[  314.806760]  <TASK>
[  314.806762]  __local_bh_enable_ip+0x5a/0x70
[  314.806766]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.806773]  ? disable_irq_nosync+0x10/0x10
[  314.806779]  irq_thread_fn+0x20/0x60
[  314.806785]  irq_thread+0xc8/0x190
[  314.806790]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  314.806795]  ? irq_thread_check_affinity+0xe0/0xe0
[  314.806800]  kthread+0x132/0x160
[  314.806804]  ? set_kthread_struct+0x50/0x50
[  314.806808]  ret_from_fork+0x22/0x30
[  314.806816]  </TASK>
[  314.806817] ---[ end trace 5699e65abef40da6 ]---
[  314.908292] ------------[ cut here ]------------
[  314.908298] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.908370] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  314.908446]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  314.908506] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  314.908512] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  314.908514] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  314.908575] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  314.908578] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  314.908582] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ed43172ca8
[  314.908584] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  314.908586] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  314.908588] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  314.908590] R13: ffffa0ecf536e800 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  314.908593] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  314.908596] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  314.908599] CR2: 00003136080a5000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  314.908602] Call Trace:
[  314.908607]  <IRQ>
[  314.908611]  ? __kmalloc+0x18c/0x360
[  314.908621]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.908685]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  314.908747]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.908824]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.908890]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.908963]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  314.909028]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.909040]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.909047]  __napi_poll+0x2a/0x170
[  314.909054]  net_rx_action+0x275/0x330
[  314.909059]  __do_softirq+0xd0/0x2ca
[  314.909066]  do_softirq+0xb8/0xe0
[  314.909071]  </IRQ>
[  314.909072]  <TASK>
[  314.909074]  __local_bh_enable_ip+0x5a/0x70
[  314.909077]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  314.909085]  ? disable_irq_nosync+0x10/0x10
[  314.909091]  irq_thread_fn+0x20/0x60
[  314.909096]  irq_thread+0xc8/0x190
[  314.909101]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  314.909106]  ? irq_thread_check_affinity+0xe0/0xe0
[  314.909111]  kthread+0x132/0x160
[  314.909115]  ? set_kthread_struct+0x50/0x50
[  314.909119]  ret_from_fork+0x22/0x30
[  314.909127]  </TASK>
[  314.909128] ---[ end trace 5699e65abef40da7 ]---
[  315.113422] ------------[ cut here ]------------
[  315.113429] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  315.113506] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  315.113590]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  315.113659] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  315.113665] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  315.113668] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  315.113729] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  315.113732] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  315.113736] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ecc473fe38
[  315.113739] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  315.113741] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  315.113743] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  315.113745] R13: ffffa0ed188c2000 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  315.113748] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  315.113751] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  315.113754] CR2: 00003136080a5000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  315.113757] Call Trace:
[  315.113760]  <IRQ>
[  315.113764]  ? __kmalloc+0x18c/0x360
[  315.113776]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  315.113840]  ? tcp_ack+0x677/0x1460
[  315.113848]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  315.113886]  ? skb_release_data+0x136/0x180
[  315.113894]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.113968]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.114007]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.114052]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.114092]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.114101]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.114105]  __napi_poll+0x2a/0x170
[  315.114111]  net_rx_action+0x275/0x330
[  315.114114]  __do_softirq+0xd0/0x2ca
[  315.114120]  do_softirq+0xb8/0xe0
[  315.114125]  </IRQ>
[  315.114126]  <TASK>
[  315.114127]  __local_bh_enable_ip+0x5a/0x70
[  315.114129]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.114133]  ? disable_irq_nosync+0x10/0x10
[  315.114138]  irq_thread_fn+0x20/0x60
[  315.114141]  irq_thread+0xc8/0x190
[  315.114144]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  315.114147]  ? irq_thread_check_affinity+0xe0/0xe0
[  315.114150]  kthread+0x132/0x160
[  315.114154]  ? set_kthread_struct+0x50/0x50
[  315.114156]  ret_from_fork+0x22/0x30
[  315.114163]  </TASK>
[  315.114164] ---[ end trace 5699e65abef40da8 ]---
[  315.215815] ------------[ cut here ]------------
[  315.215822] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  315.215898] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  315.215982]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  315.216048] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  315.216053] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  315.216056] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  315.216093] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  315.216095] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  315.216097] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ecf49b94d8
[  315.216099] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  315.216100] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  315.216102] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  315.216103] R13: ffffa0ec610d5000 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  315.216105] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  315.216106] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  315.216108] CR2: 00003136080a6000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  315.216110] Call Trace:
[  315.216112]  <IRQ>
[  315.216115]  ? __kmalloc+0x18c/0x360
[  315.216124]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  315.216162]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  315.216200]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.216251]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.216289]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.216334]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.216373]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.216381]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.216385]  __napi_poll+0x2a/0x170
[  315.216391]  net_rx_action+0x275/0x330
[  315.216394]  __do_softirq+0xd0/0x2ca
[  315.216399]  do_softirq+0xb8/0xe0
[  315.216404]  </IRQ>
[  315.216404]  <TASK>
[  315.216405]  __local_bh_enable_ip+0x5a/0x70
[  315.216407]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.216412]  ? disable_irq_nosync+0x10/0x10
[  315.216417]  irq_thread_fn+0x20/0x60
[  315.216420]  irq_thread+0xc8/0x190
[  315.216423]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  315.216453]  ? irq_thread_check_affinity+0xe0/0xe0
[  315.216456]  kthread+0x132/0x160
[  315.216459]  ? set_kthread_struct+0x50/0x50
[  315.216461]  ret_from_fork+0x22/0x30
[  315.216467]  </TASK>
[  315.216469] ---[ end trace 5699e65abef40da9 ]---
[  315.420300] ------------[ cut here ]------------
[  315.420305] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  315.420377] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  315.420453]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  315.420514] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  315.420519] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  315.420522] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  315.420583] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  315.420586] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  315.420590] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ed412fb348
[  315.420593] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  315.420595] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  315.420597] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  315.420599] R13: ffffa0ed13c4f800 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  315.420608] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  315.420611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  315.420614] CR2: 0000282209c23890 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  315.420617] Call Trace:
[  315.420622]  <IRQ>
[  315.420626]  ? __kmalloc+0x18c/0x360
[  315.420637]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  315.420702]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  315.420764]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.420845]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.420911]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.420984]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.421050]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.421061]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.421069]  __napi_poll+0x2a/0x170
[  315.421077]  net_rx_action+0x275/0x330
[  315.421082]  __do_softirq+0xd0/0x2ca
[  315.421090]  do_softirq+0xb8/0xe0
[  315.421096]  </IRQ>
[  315.421098]  <TASK>
[  315.421099]  __local_bh_enable_ip+0x5a/0x70
[  315.421103]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.421110]  ? disable_irq_nosync+0x10/0x10
[  315.421117]  irq_thread_fn+0x20/0x60
[  315.421123]  irq_thread+0xc8/0x190
[  315.421127]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  315.421132]  ? irq_thread_check_affinity+0xe0/0xe0
[  315.421137]  kthread+0x132/0x160
[  315.421142]  ? set_kthread_struct+0x50/0x50
[  315.421145]  ret_from_fork+0x22/0x30
[  315.421154]  </TASK>
[  315.421155] ---[ end trace 5699e65abef40daa ]---
[  315.522743] ------------[ cut here ]------------
[  315.522748] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  315.522818] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  315.522893]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  315.522953] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  315.522959] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  315.522962] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  315.523022] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  315.523025] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  315.523029] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ecfc8765a0
[  315.523032] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  315.523034] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  315.523036] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  315.523038] R13: ffffa0ed13e99400 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  315.523041] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  315.523044] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  315.523047] CR2: 00000a0800619058 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  315.523050] Call Trace:
[  315.523053]  <IRQ>
[  315.523056]  ? __kmalloc+0x18c/0x360
[  315.523065]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  315.523129]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  315.523191]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.523292]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.523358]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.523431]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.523496]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.523507]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.523514]  __napi_poll+0x2a/0x170
[  315.523521]  net_rx_action+0x275/0x330
[  315.523527]  __do_softirq+0xd0/0x2ca
[  315.523533]  do_softirq+0xb8/0xe0
[  315.523537]  </IRQ>
[  315.523539]  <TASK>
[  315.523540]  __local_bh_enable_ip+0x5a/0x70
[  315.523544]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.523551]  ? disable_irq_nosync+0x10/0x10
[  315.523557]  irq_thread_fn+0x20/0x60
[  315.523563]  irq_thread+0xc8/0x190
[  315.523567]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  315.523572]  ? irq_thread_check_affinity+0xe0/0xe0
[  315.523577]  kthread+0x132/0x160
[  315.523581]  ? set_kthread_struct+0x50/0x50
[  315.523585]  ret_from_fork+0x22/0x30
[  315.523594]  </TASK>
[  315.523596] ---[ end trace 5699e65abef40dab ]---
[  315.829827] ------------[ cut here ]------------
[  315.829830] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  315.829874] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  315.829922]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  315.829960] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  315.829964] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  315.829965] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  315.830001] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  315.830003] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  315.830005] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ecfcabf028
[  315.830007] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  315.830008] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  315.830010] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  315.830011] R13: ffffa0ecf536e400 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  315.830012] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  315.830014] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  315.830016] CR2: 00007f0176d87978 CR3: 0000000184672000 CR4: 0000000000350ee0
[  315.830018] Call Trace:
[  315.830021]  <IRQ>
[  315.830023]  ? __kmalloc+0x18c/0x360
[  315.830030]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  315.830081]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  315.830118]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.830170]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.830210]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.830254]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.830293]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.830300]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.830305]  __napi_poll+0x2a/0x170
[  315.830310]  net_rx_action+0x275/0x330
[  315.830313]  __do_softirq+0xd0/0x2ca
[  315.830318]  do_softirq+0xb8/0xe0
[  315.830321]  </IRQ>
[  315.830322]  <TASK>
[  315.830323]  __local_bh_enable_ip+0x5a/0x70
[  315.830325]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.830330]  ? disable_irq_nosync+0x10/0x10
[  315.830333]  irq_thread_fn+0x20/0x60
[  315.830337]  irq_thread+0xc8/0x190
[  315.830340]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  315.830343]  ? irq_thread_check_affinity+0xe0/0xe0
[  315.830346]  kthread+0x132/0x160
[  315.830348]  ? set_kthread_struct+0x50/0x50
[  315.830350]  ret_from_fork+0x22/0x30
[  315.830355]  </TASK>
[  315.830356] ---[ end trace 5699e65abef40dac ]---
[  315.932283] ------------[ cut here ]------------
[  315.932288] WARNING: CPU: 1 PID: 458 at net/wireless/scan.c:479
cfg80211_bss_update+0x596/0x650 [cfg80211]
[  315.932358] Modules linked in: nfnetlink ccm snd_seq_dummy
snd_hrtimer snd_seq snd_seq_device ip6t_rpfilter ip6table_raw
ip6table_mangle ip6table_nat ip6t_REJECT nf_reject_ipv6
ip6t_ipv6header ip6table_filter ip6_tables ipt_rpfilter iptable_raw
iptable_mangle iptable_nat nf_nat ts_bm xt_state xt_length xt_LOG
nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_recent intel_rapl_msr
intel_rapl_common xt_limit xt_tcpudp edac_mce_amd snd_soc_dmic
xt_string snd_acp3x_rn snd_acp3x_pdm_dma xt_conntrack crct10dif_pclmul
snd_soc_core joydev crc32_pclmul nf_conntrack mousedev snd_compress
qrtr ghash_clmulni_intel nf_defrag_ipv6 ac97_bus ns bnep
nf_defrag_ipv4 aesni_intel snd_pcm_dmaengine hid_multitouch wmi_bmof
crypto_simd iptable_filter snd_hda_codec_realtek rtw88_8822ce cryptd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi rtw88_8822c
rapl snd_hda_intel rtw88_pci snd_intel_dspcfg snd_intel_sdw_acpi btusb
rtw88_core amdgpu snd_hda_codec btrtl snd_hda_core vfat btbcm
snd_pci_acp5x sp5100_tco
[  315.932434]  mac80211 k10temp snd_hwdep btintel fat i2c_piix4
snd_pcm libarc4 snd_rn_pci_acp3x bluetooth gpu_sched ucsi_acpi
snd_timer snd_pci_acp3x ecdh_generic cfg80211 drm_ttm_helper snd crc16
typec_ucsi ccp ttm soundcore rfkill typec roles tpm_crb tpm_tis
i2c_hid_acpi mac_hid tpm_tis_core video i2c_hid tpm wmi acpi_cpufreq
rng_core pinctrl_amd amd_pmc p_lkrg(OE) uinput crypto_user fuse
ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor
raid6_pq serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[  315.932495] CPU: 1 PID: 458 Comm: irq/69-rtw88_pc Tainted: G
W  OE     5.15.19-1-MANJARO #1
e351c542aaa5663a651c7c28a85bccc2b32cd80c
[  315.932500] Hardware name: TIMI RedmiBook 14 II/TM1951, BIOS
RMARN4B0P0909 08/19/2020
[  315.932503] RIP: 0010:cfg80211_bss_update+0x596/0x650 [cfg80211]
[  315.932564] Code: 18 48 8b 5c 24 10 8b b3 dc 00 00 00 44 39 de 0f
84 5a fc ff ff 80 3d 7d 26 0b 00 00 0f 84 95 00 00 00 41 89 f3 e9 45
fc ff ff <0f> 0b eb 82 0f 0b 49 8b 85 90 00 00 00 48 85 c0 75 80 49 8b
85 98
[  315.932567] RSP: 0018:ffffc3434024c7a8 EFLAGS: 00010246
[  315.932571] RAX: ffffa0ec573a00c0 RBX: ffffa0ec573a0000 RCX: ffffa0ed0bc29410
[  315.932573] RDX: 0000000000000001 RSI: 0000000000000009 RDI: 0000000000000000
[  315.932576] RBP: ffffc3434024c840 R08: 0000000000000000 R09: 0000000000000000
[  315.932578] R10: ffffa0ec573a00c0 R11: 0000000000000001 R12: 0000000000000000
[  315.932580] R13: ffffa0ed4123d400 R14: ffffa0ec573a00b8 R15: 0000000000000080
[  315.932583] FS:  0000000000000000(0000) GS:ffffa0ef3f640000(0000)
knlGS:0000000000000000
[  315.932586] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  315.932589] CR2: 00007ffb3e420000 CR3: 0000000173c10000 CR4: 0000000000350ee0
[  315.932592] Call Trace:
[  315.932596]  <IRQ>
[  315.932600]  ? __kmalloc+0x18c/0x360
[  315.932610]  cfg80211_inform_single_bss_frame_data+0x220/0x440
[cfg80211 6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  315.932674]  cfg80211_inform_bss_frame_data+0x4f/0x420 [cfg80211
6f82c66ebd28967754d00e468cd5747e23cb9bb2]
[  315.932735]  ieee80211_bss_info_update+0xe8/0x2e0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.932813]  ieee80211_scan_rx+0xe5/0x160 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.932878]  ieee80211_rx_list+0xa34/0xc20 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.932952]  ieee80211_rx_napi+0x51/0xf0 [mac80211
64ac96be3480b64fbe6abe663dd122872c9c6c05]
[  315.933017]  rtw_pci_rx_napi.constprop.0+0x299/0x340 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.933029]  rtw_pci_napi_poll+0x58/0x180 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.933036]  __napi_poll+0x2a/0x170
[  315.933042]  net_rx_action+0x275/0x330
[  315.933048]  __do_softirq+0xd0/0x2ca
[  315.933054]  do_softirq+0xb8/0xe0
[  315.933060]  </IRQ>
[  315.933061]  <TASK>
[  315.933063]  __local_bh_enable_ip+0x5a/0x70
[  315.933066]  rtw_pci_interrupt_threadfn+0x18e/0x2c0 [rtw88_pci
0baaa1325e60e6bd61afe16fc20480b6b1e9e3bb]
[  315.933074]  ? disable_irq_nosync+0x10/0x10
[  315.933080]  irq_thread_fn+0x20/0x60
[  315.933085]  irq_thread+0xc8/0x190
[  315.933090]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  315.933095]  ? irq_thread_check_affinity+0xe0/0xe0
[  315.933100]  kthread+0x132/0x160
[  315.933103]  ? set_kthread_struct+0x50/0x50
[  315.933107]  ret_from_fork+0x22/0x30
[  315.933115]  </TASK>
[  315.933117] ---[ end trace 5699e65abef40dad ]---
[  397.279716] audit: type=1100 audit(1644497708.031:191): pid=5768
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:authentication
grantors=pam_faillock,pam_permit,pam_faillock acct="max"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  397.279783] audit: type=1101 audit(1644497708.031:192): pid=5768
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/0 res=success'
[  397.281813] audit: type=1110 audit(1644497708.034:193): pid=5768
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  397.286794] audit: type=1105 audit(1644497708.037:194): pid=5768
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  397.474766] audit: type=1106 audit(1644497708.227:195): pid=5768
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  397.474956] audit: type=1104 audit(1644497708.227:196): pid=5768
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  467.495096] atkbd serio0: Unknown key pressed (translated set 2,
code 0xf6 on isa0060/serio0).
[  467.495102] atkbd serio0: Use 'setkeycodes e076 <keycode>' to make it known.
[  468.314809] atkbd serio0: Unknown key released (translated set 2,
code 0xf6 on isa0060/serio0).
[  468.314819] atkbd serio0: Use 'setkeycodes e076 <keycode>' to make it known.
[  507.344517] audit: type=1100 audit(1644497818.174:197): pid=5877
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:authentication
grantors=pam_faillock,pam_permit,pam_faillock acct="max"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  507.344847] audit: type=1101 audit(1644497818.174:198): pid=5877
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/0 res=success'
[  507.347270] audit: type=1110 audit(1644497818.174:199): pid=5877
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  507.352455] audit: type=1105 audit(1644497818.181:200): pid=5877
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  514.885205] audit: type=1106 audit(1644497825.711:201): pid=5877
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  514.885383] audit: type=1104 audit(1644497825.711:202): pid=5877
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  519.730112] ip6tables deny: IN= OUT=wlp1s0
SRC=fe80:0000:0000:0000:6ece:a411:211f:a1ee
DST=ff02:0000:0000:0000:0000:0000:0000:0002 LEN=48 TC=0 HOPLIMIT=255
FLOWLBL=97451 PROTO=ICMPv6 TYPE=133 CODE=0
[  529.050108] audit: type=1101 audit(1644497839.867:203): pid=5931
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/0 res=success'
[  529.051088] audit: type=1110 audit(1644497839.867:204): pid=5931
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  529.054041] audit: type=1105 audit(1644497839.870:205): pid=5931
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  649.134916] audit: type=1100 audit(1644497960.016:206): pid=6198
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:authentication
grantors=pam_faillock,pam_permit,pam_faillock acct="max"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  649.135109] audit: type=1101 audit(1644497960.016:207): pid=6198
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/4 res=success'
[  649.136379] audit: type=1110 audit(1644497960.019:208): pid=6198
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  649.139323] audit: type=1105 audit(1644497960.022:209): pid=6198
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  684.438726] audit: type=1106 audit(1644497995.334:210): pid=6198
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  684.438797] audit: type=1104 audit(1644497995.334:211): pid=6198
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  687.762336] audit: type=1101 audit(1644497998.658:212): pid=6248
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/4 res=success'
[  687.763942] audit: type=1110 audit(1644497998.662:213): pid=6248
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  687.766881] audit: type=1105 audit(1644497998.665:214): pid=6248
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  687.779649] audit: type=1100 audit(1644497998.675:215): pid=6249
uid=0 auid=1000 ses=2 subj==unconfined msg='op=PAM:authentication
grantors=pam_rootok acct="root" exe="/usr/bin/su" hostname=? addr=?
terminal=/dev/pts/4 res=success'
[  687.780207] audit: type=1101 audit(1644497998.675:216): pid=6249
uid=0 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=? addr=?
terminal=/dev/pts/4 res=success'
[  687.780665] audit: type=1103 audit(1644497998.678:217): pid=6249
uid=0 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_rootok acct="root" exe="/usr/bin/su" hostname=? addr=?
terminal=/dev/pts/4 res=success'
[  687.780945] audit: type=1105 audit(1644497998.678:218): pid=6249
uid=0 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=? addr=?
terminal=/dev/pts/4 res=success'
[  706.688409] audit: type=1106 audit(1644498017.591:219): pid=5931
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  706.688533] audit: type=1104 audit(1644498017.591:220): pid=5931
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  714.933136] ip6tables reject: IN=wlp1s0 OUT=
MAC=33:33:00:00:00:01:98:da:c4:bf:99:a5:86:dd
SRC=fe80:0000:0000:0000:9ada:c4ff:febf:99a5
DST=ff02:0000:0000:0000:0000:0000:0000:0001 LEN=104 TC=0 HOPLIMIT=255
FLOWLBL=365839 PROTO=ICMPv6 TYPE=134 CODE=0
[  809.853432] audit: type=1106 audit(1644498120.684:221): pid=6249
uid=0 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=? addr=?
terminal=/dev/pts/4 res=success'
[  809.853446] audit: type=1104 audit(1644498120.684:222): pid=6249
uid=0 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_rootok acct="root" exe="/usr/bin/su" hostname=? addr=?
terminal=/dev/pts/4 res=success'
[  809.855050] audit: type=1106 audit(1644498120.688:223): pid=6248
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  809.855147] audit: type=1104 audit(1644498120.688:224): pid=6248
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  811.422511] audit: type=1101 audit(1644498122.253:225): pid=6575
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/4 res=success'
[  811.423901] audit: type=1110 audit(1644498122.253:226): pid=6575
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  811.429062] audit: type=1105 audit(1644498122.260:227): pid=6575
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  820.015607] audit: type=1106 audit(1644498130.839:228): pid=6575
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  820.015618] audit: type=1104 audit(1644498130.839:229): pid=6575
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  827.209416] audit: type=1101 audit(1644498138.043:230): pid=6597
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/4 res=success'
[  827.210740] audit: type=1110 audit(1644498138.043:231): pid=6597
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  827.215823] audit: type=1105 audit(1644498138.050:232): pid=6597
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  838.564793] atkbd serio0: Unknown key pressed (translated set 2,
code 0xf6 on isa0060/serio0).
[  838.564808] atkbd serio0: Use 'setkeycodes e076 <keycode>' to make it known.
[  841.307154] atkbd serio0: Unknown key released (translated set 2,
code 0xf6 on isa0060/serio0).
[  841.307164] atkbd serio0: Use 'setkeycodes e076 <keycode>' to make it known.
[  849.759236] audit: type=1100 audit(1644498160.608:233): pid=6632
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:unix_chkpwd
acct="max" exe="/usr/bin/unix_chkpwd" hostname=? addr=? terminal=?
res=success'
[  859.955506] audit: type=1106 audit(1644498170.805:234): pid=1201
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/3 res=success'
[  859.955598] audit: type=1104 audit(1644498170.805:235): pid=1201
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/3 res=success'
[  862.479995] atkbd serio0: Unknown key pressed (translated set 2,
code 0xf6 on isa0060/serio0).
[  862.480006] atkbd serio0: Use 'setkeycodes e076 <keycode>' to make it known.
[  863.562629] atkbd serio0: Unknown key released (translated set 2,
code 0xf6 on isa0060/serio0).
[  863.562640] atkbd serio0: Use 'setkeycodes e076 <keycode>' to make it known.
[  868.019112] audit: type=1106 audit(1644498178.868:236): pid=6597
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  868.019194] audit: type=1104 audit(1644498178.868:237): pid=6597
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  910.132185] audit: type=1130 audit(1644498220.979:238): pid=1 uid=0
auid=4294967295 ses=4294967295 subj==unconfined
msg='unit=systemd-tmpfiles-clean comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[  910.132194] audit: type=1131 audit(1644498220.979:239): pid=1 uid=0
auid=4294967295 ses=4294967295 subj==unconfined
msg='unit=systemd-tmpfiles-clean comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[  910.144887] audit: type=1130 audit(1644498220.992:240): pid=1 uid=0
auid=4294967295 ses=4294967295 subj==unconfined msg='unit=udisks2
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[  910.394132] audit: type=1334 audit(1644498221.242:241): prog-id=30 op=LOAD
[  910.394452] audit: type=1334 audit(1644498221.242:242): prog-id=31 op=LOAD
[  910.394553] audit: type=1334 audit(1644498221.242:243): prog-id=32 op=LOAD
[  910.517216] audit: type=1130 audit(1644498221.366:244): pid=1 uid=0
auid=4294967295 ses=4294967295 subj==unconfined
msg='unit=systemd-hostnamed comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[  912.347654] ip6tables deny: IN= OUT=wlp1s0
SRC=fe80:0000:0000:0000:6ece:a411:211f:a1ee
DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=166 TC=0 HOPLIMIT=255
FLOWLBL=958166 PROTO=UDP SPT=5353 DPT=5353 LEN=126
[  913.348921] ip6tables deny: IN= OUT=wlp1s0
SRC=fe80:0000:0000:0000:6ece:a411:211f:a1ee
DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=166 TC=0 HOPLIMIT=255
FLOWLBL=958166 PROTO=UDP SPT=5353 DPT=5353 LEN=126
[  915.350764] ip6tables deny: IN= OUT=wlp1s0
SRC=fe80:0000:0000:0000:6ece:a411:211f:a1ee
DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=166 TC=0 HOPLIMIT=255
FLOWLBL=958166 PROTO=UDP SPT=5353 DPT=5353 LEN=126
[  919.351817] ip6tables deny: IN= OUT=wlp1s0
SRC=fe80:0000:0000:0000:6ece:a411:211f:a1ee
DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=166 TC=0 HOPLIMIT=255
FLOWLBL=958166 PROTO=UDP SPT=5353 DPT=5353 LEN=126
[  927.359564] ip6tables deny: IN= OUT=wlp1s0
SRC=fe80:0000:0000:0000:6ece:a411:211f:a1ee
DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=166 TC=0 HOPLIMIT=255
FLOWLBL=958166 PROTO=UDP SPT=5353 DPT=5353 LEN=126
[  940.598027] audit: type=1131 audit(1644498251.449:245): pid=1 uid=0
auid=4294967295 ses=4294967295 subj==unconfined
msg='unit=systemd-hostnamed comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[  940.693168] audit: type=1334 audit(1644498251.545:246): prog-id=0 op=UNLOAD
[  940.693178] audit: type=1334 audit(1644498251.545:247): prog-id=0 op=UNLOAD
[  940.693182] audit: type=1334 audit(1644498251.545:248): prog-id=0 op=UNLOAD
[  943.363763] ip6tables deny: IN= OUT=wlp1s0
SRC=fe80:0000:0000:0000:6ece:a411:211f:a1ee
DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=166 TC=0 HOPLIMIT=255
FLOWLBL=958166 PROTO=UDP SPT=5353 DPT=5353 LEN=126
[  955.803399] audit: type=1101 audit(1644498266.650:249): pid=7072
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/4 res=success'
[  955.804357] audit: type=1110 audit(1644498266.650:250): pid=7072
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  955.807862] audit: type=1105 audit(1644498266.657:251): pid=7072
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  963.541299] audit: type=1106 audit(1644498274.386:252): pid=7072
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  963.541312] audit: type=1104 audit(1644498274.386:253): pid=7072
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  975.380261] ip6tables deny: IN= OUT=wlp1s0
SRC=fe80:0000:0000:0000:6ece:a411:211f:a1ee
DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=166 TC=0 HOPLIMIT=255
FLOWLBL=958166 PROTO=UDP SPT=5353 DPT=5353 LEN=126
[  988.784780] audit: type=1101 audit(1644498299.626:254): pid=7120
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/4 res=success'
[  988.786089] audit: type=1110 audit(1644498299.629:255): pid=7120
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  988.789376] audit: type=1105 audit(1644498299.633:256): pid=7120
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  988.791857] audit: type=1101 audit(1644498299.633:257): pid=7121
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/4 res=success'
[  988.793393] audit: type=1110 audit(1644498299.636:258): pid=7121
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  988.796460] audit: type=1105 audit(1644498299.639:259): pid=7121
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  989.214486] audit: type=1106 audit(1644498300.056:260): pid=7120
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[  989.214560] audit: type=1104 audit(1644498300.056:261): pid=7120
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1010.891724] audit: type=1100 audit(1644498321.729:262): pid=8190
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:authentication
grantors=pam_faillock,pam_permit,pam_faillock acct="max"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 1010.892805] audit: type=1101 audit(1644498321.733:263): pid=8190
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 1010.894392] audit: type=1110 audit(1644498321.733:264): pid=8190
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 1010.897098] audit: type=1105 audit(1644498321.736:265): pid=8190
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 1033.325832] ip6tables deny: IN= OUT=wlp1s0
SRC=fe80:0000:0000:0000:6ece:a411:211f:a1ee
DST=ff02:0000:0000:0000:0000:0000:0000:0002 LEN=48 TC=0 HOPLIMIT=255
FLOWLBL=97451 PROTO=ICMPv6 TYPE=133 CODE=0
[ 1039.395319] ip6tables deny: IN= OUT=wlp1s0
SRC=fe80:0000:0000:0000:6ece:a411:211f:a1ee
DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=166 TC=0 HOPLIMIT=255
FLOWLBL=958166 PROTO=UDP SPT=5353 DPT=5353 LEN=126
[ 1096.504060] systemd[1]: systemd 250.3-2-manjaro running in system
mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT
+GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC
+KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE
+BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT
default-hierarchy=unified)
[ 1096.518636] systemd[1]: Detected architecture x86-64.
[ 1096.524633] audit: type=1334 audit(1644498407.370:266): prog-id=33 op=LOAD
[ 1096.524651] audit: type=1334 audit(1644498407.370:267): prog-id=0 op=UNLOAD
[ 1096.524724] audit: type=1334 audit(1644498407.370:268): prog-id=34 op=LOAD
[ 1096.524728] audit: type=1334 audit(1644498407.370:269): prog-id=0 op=UNLOAD
[ 1096.724602] audit: type=1334 audit(1644498407.570:270): prog-id=35 op=LOAD
[ 1096.724653] audit: type=1334 audit(1644498407.570:271): prog-id=0 op=UNLOAD
[ 1096.724757] audit: type=1334 audit(1644498407.570:272): prog-id=36 op=LOAD
[ 1096.724837] audit: type=1334 audit(1644498407.570:273): prog-id=37 op=LOAD
[ 1096.724871] audit: type=1334 audit(1644498407.570:274): prog-id=0 op=UNLOAD
[ 1096.724888] audit: type=1334 audit(1644498407.570:275): prog-id=0 op=UNLOAD
[ 1138.018140] device-mapper: uevent: version 1.0.3
[ 1138.018267] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22)
initialised: dm-devel@redhat.com
[ 1141.630234] SGI XFS with ACLs, security attributes, realtime,
scrub, repair, quota, no debug enabled
[ 1141.691050] JFS: nTxBlock = 8192, nTxLock = 65536
[ 1159.866927] kauditd_printk_skb: 40 callbacks suppressed
[ 1159.866933] audit: type=1334 audit(1644498470.710:316): prog-id=56 op=LOAD
[ 1159.866940] audit: type=1334 audit(1644498470.710:317): prog-id=0 op=UNLOAD
[ 1159.867136] audit: type=1334 audit(1644498470.710:318): prog-id=57 op=LOAD
[ 1159.867224] audit: type=1334 audit(1644498470.710:319): prog-id=58 op=LOAD
[ 1159.867257] audit: type=1334 audit(1644498470.710:320): prog-id=0 op=UNLOAD
[ 1159.867276] audit: type=1334 audit(1644498470.710:321): prog-id=0 op=UNLOAD
[ 1159.867807] audit: type=1334 audit(1644498470.710:322): prog-id=59 op=LOAD
[ 1159.867864] audit: type=1334 audit(1644498470.710:323): prog-id=60 op=LOAD
[ 1159.867899] audit: type=1334 audit(1644498470.710:324): prog-id=0 op=UNLOAD
[ 1159.867918] audit: type=1334 audit(1644498470.710:325): prog-id=0 op=UNLOAD
[ 1167.452860] ip6tables deny: IN= OUT=wlp1s0
SRC=fe80:0000:0000:0000:6ece:a411:211f:a1ee
DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=166 TC=0 HOPLIMIT=255
FLOWLBL=958166 PROTO=UDP SPT=5353 DPT=5353 LEN=126
[ 1214.245908] kauditd_printk_skb: 26 callbacks suppressed
[ 1214.245915] audit: type=1334 audit(1644498525.085:352): prog-id=74 op=LOAD
[ 1214.245926] audit: type=1334 audit(1644498525.085:353): prog-id=0 op=UNLOAD
[ 1214.246189] audit: type=1334 audit(1644498525.085:354): prog-id=75 op=LOAD
[ 1214.246209] audit: type=1334 audit(1644498525.085:355): prog-id=76 op=LOAD
[ 1214.246232] audit: type=1334 audit(1644498525.085:356): prog-id=0 op=UNLOAD
[ 1214.246246] audit: type=1334 audit(1644498525.085:357): prog-id=0 op=UNLOAD
[ 1214.246781] audit: type=1334 audit(1644498525.085:358): prog-id=77 op=LOAD
[ 1214.246866] audit: type=1334 audit(1644498525.088:359): prog-id=78 op=LOAD
[ 1214.246888] audit: type=1334 audit(1644498525.088:360): prog-id=0 op=UNLOAD
[ 1214.246904] audit: type=1334 audit(1644498525.088:361): prog-id=0 op=UNLOAD
[ 1260.339898] kauditd_printk_skb: 26 callbacks suppressed
[ 1260.339904] audit: type=1131 audit(1644498571.173:388): pid=1 uid=0
auid=4294967295 ses=4294967295 subj==unconfined msg='unit=cronie
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[ 1260.342254] audit: type=1130 audit(1644498571.176:389): pid=1 uid=0
auid=4294967295 ses=4294967295 subj==unconfined msg='unit=cronie
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[ 1301.289091] ip6tables reject: IN=wlp1s0 OUT=
MAC=33:33:00:00:00:01:98:da:c4:bf:99:a5:86:dd
SRC=fe80:0000:0000:0000:9ada:c4ff:febf:99a5
DST=ff02:0000:0000:0000:0000:0000:0000:0001 LEN=104 TC=0 HOPLIMIT=255
FLOWLBL=365839 PROTO=ICMPv6 TYPE=134 CODE=0
[ 1322.218378] audit: type=1106 audit(1644498633.043:390): pid=7121
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1322.218435] audit: type=1104 audit(1644498633.043:391): pid=7121
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1362.701964] audit: type=1100 audit(1644498673.525:392): pid=22535
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:authentication
grantors=pam_faillock,pam_permit,pam_faillock acct="max"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1362.702403] audit: type=1101 audit(1644498673.525:393): pid=22535
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1362.704524] audit: type=1110 audit(1644498673.528:394): pid=22535
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1362.709935] audit: type=1105 audit(1644498673.531:395): pid=22535
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1364.728630] audit: type=1106 audit(1644498675.551:396): pid=22535
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1364.728768] audit: type=1104 audit(1644498675.551:397): pid=22535
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1423.506860] ip6tables deny: IN= OUT=wlp1s0
SRC=fe80:0000:0000:0000:6ece:a411:211f:a1ee
DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=166 TC=0 HOPLIMIT=255
FLOWLBL=958166 PROTO=UDP SPT=5353 DPT=5353 LEN=126
[ 1433.801335] audit: type=1101 audit(1644498744.613:398): pid=22757
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1433.802951] audit: type=1110 audit(1644498744.616:399): pid=22757
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1433.808268] audit: type=1105 audit(1644498744.620:400): pid=22757
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1446.521780] audit: type=1106 audit(1644498757.335:401): pid=22757
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1446.521868] audit: type=1104 audit(1644498757.335:402): pid=22757
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1501.034344] audit: type=1100 audit(1644498811.842:403): pid=22912
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:authentication
grantors=pam_faillock,pam_permit,pam_faillock acct="max"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1501.034709] audit: type=1101 audit(1644498811.842:404): pid=22912
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1501.036668] audit: type=1110 audit(1644498811.845:405): pid=22912
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1501.041807] audit: type=1105 audit(1644498811.848:406): pid=22912
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1532.285539] ip6tables reject: IN=wlp1s0 OUT=
MAC=33:33:00:00:00:01:98:da:c4:bf:99:a5:86:dd
SRC=fe80:0000:0000:0000:9ada:c4ff:febf:99a5
DST=ff02:0000:0000:0000:0000:0000:0000:0001 LEN=104 TC=0 HOPLIMIT=255
FLOWLBL=365839 PROTO=ICMPv6 TYPE=134 CODE=0
[ 1547.641743] audit: type=1106 audit(1644498858.440:407): pid=22912
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_close
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1547.641943] audit: type=1104 audit(1644498858.443:408): pid=22912
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/4 res=success'
[ 1707.072858] atkbd serio0: Unknown key pressed (translated set 2,
code 0xf6 on isa0060/serio0).
[ 1707.072868] atkbd serio0: Use 'setkeycodes e076 <keycode>' to make it known.
[ 1707.982424] atkbd serio0: Unknown key released (translated set 2,
code 0xf6 on isa0060/serio0).
[ 1707.982437] atkbd serio0: Use 'setkeycodes e076 <keycode>' to make it known.
[ 1907.185749] audit: type=1100 audit(1644499217.944:409): pid=25200
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:authentication
grantors=pam_faillock,pam_permit,pam_faillock acct="max"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/5 res=success'
[ 1907.186107] audit: type=1101 audit(1644499217.944:410): pid=25200
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="max" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/5 res=success'
[ 1907.188003] audit: type=1110 audit(1644499217.947:411): pid=25200
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/5 res=success'
[ 1907.193445] audit: type=1105 audit(1644499217.950:412): pid=25200
uid=1000 auid=1000 ses=2 subj==unconfined msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/5 res=success'
