Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3B6618D1
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jan 2023 20:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjAHTrh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 14:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjAHTrg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 14:47:36 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4F1DF24
        for <linux-wireless@vger.kernel.org>; Sun,  8 Jan 2023 11:47:34 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z11so9728943ede.1
        for <linux-wireless@vger.kernel.org>; Sun, 08 Jan 2023 11:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pFyEyiq7Sg0TbUTgQWi12VGaV+asaXrzQtTJMoRmFZ0=;
        b=YGLrEbmIOoNi3vnGu2CvRzDBBL4DTcLQf+dLv7uHOiuGLav1fKQ37GdKeZXY3YneRB
         UK3GGqyhEIMIaEht9/d7++BCRAJI2ScMSYvpm4py5tgA+Jo3FhaC2EvpnUpa6PcjckT9
         xI+nSWzvjUMsN4tMDoNpCqYj4z5VCy5YDqJIbT+90faWd6sH0rC5AmPqk+RSFZK/nMy+
         pAcetLj1Nec9GRM02HD0dOAzNlLVqNh1/oypDHgPctxQqOc0H+WAAL+DrQ0Df6zfH0uq
         xypCj5cG79RQEGc19GjO6+lD2sc0pJ1znLL6VtcExetxuQQXYF4tBO4LTYeIflLk5uS9
         0Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFyEyiq7Sg0TbUTgQWi12VGaV+asaXrzQtTJMoRmFZ0=;
        b=g46pIBZi+2tefN7mnTJUbi6f8R/yee/vN02VTettN1v1/QmZNJnM0NYPk1P9e6v2ci
         MIba9M8pP2LO9JcI+XdirSnPYV1NO16MiPPtGvJwW/KoNMQP/Q+lb9KU6FNT6rM7Z4lg
         WzDlx4+lxErtaWuj6Z1/3q6l4KfqLQWQzQPMj5RD3uMP5sUsXsEyTxMwrYW10TRITrbD
         gP7Q0HxO+HMFFkqPXRKFA7HMTqLX5ggneMWKPeghglMwwtTimlNg5yiivtqgxYUQW2mg
         1T4Yz+ldlfaTTgH6/xc6c7wwtQOqTaNep1hAleC1oJiI5nKYay6Hvrlx5dWL5HTNGY08
         Ep3Q==
X-Gm-Message-State: AFqh2kpp8jE101AovqKpmr4JvctyLaLelldquGE5GmvQwRxUjlY1PDn7
        cgUc2B/ChAiT16K2JZNAXAJVBqa4qVLs4yJwiZqepv8S6MGocA==
X-Google-Smtp-Source: AMrXdXshWwY/K7IEr2uuP4TUjGkniLw6ugagtUYZEz8Na3VxArKiqa9KiIAmd1DdkOv4c4UmaR+BVOmQM7bWWSpJpiA=
X-Received: by 2002:a05:6402:2052:b0:492:bf3d:1a18 with SMTP id
 bc18-20020a056402205200b00492bf3d1a18mr1569325edb.17.1673207253242; Sun, 08
 Jan 2023 11:47:33 -0800 (PST)
MIME-Version: 1.0
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Date:   Mon, 9 Jan 2023 03:46:56 +0800
Message-ID: <CAN_LGv2FLLKxsbruJ0u_Gh3+_nTGaVGd4154DXQ7Tz+BnFt3EQ@mail.gmail.com>
Subject: Commit b320d6c4 broke mt76
To:     Benjamin Berg <benjamin.berg@intel.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Benjamin,

I have this hardware, which is supported by the mt76x2e driver:

04:00.0 Network controller [0280]: MEDIATEK Corp. MT7612E 802.11acbgn
PCI Express Wireless Network Adapter [14c3:7612]

Since Linux 6.1, the mt76 driver panics the kernel due to null
dereference shortly after authenticating to the AP, as follows:

[   27.868370] BUG: kernel NULL pointer dereference, address: 00000000000000a8
[   27.868379] #PF: supervisor write access in kernel mode
[   27.868382] #PF: error_code(0x0002) - not-present page
[   27.868384] PGD 0 P4D 0
[   27.868387] Oops: 0002 [#1] PREEMPT SMP PTI
[   27.868400] CPU: 1 PID: 613 Comm: napi/phy0-323 Not tainted
6.1.3-zen1-1-zen #1 e84ae47f4a6d6b4d7d2701d8d72f471c5f76a3ff
[   27.868404] Hardware name: MSI MS-7851/Z87I (MS-7851), BIOS V1.9 05/15/2015
[   27.868406] RIP: 0010:ieee80211_deliver_skb+0x4c/0x1a0 [mac80211]
[   27.868465] Code: 00 00 8b 55 70 49 8b 85 50 05 00 00 65 48 03 05
0a 63 34 3e 48 01 50 08 48 ff 00 48 83 7b 28 00 74 11 48 8b 43 30 48
63 53 44 <48> 83 84 d0 a8 00 00 00 01 8b 87 e8 11 00 00 8d 50 fd 83 fa
01 0f
[   27.868468] RSP: 0018:ffffbbb3c0917ae8 EFLAGS: 00010286
[   27.868470] RAX: 0000000000000000 RBX: ffffbbb3c0917c90 RCX: 0000000000000008
[   27.868472] RDX: 0000000000000000 RSI: ffffa0eaaece064e RDI: ffffa0ea895109c0
[   27.868474] RBP: ffffa0eaabc4f000 R08: 000000000000003b R09: 0000000000000171
[   27.868476] R10: 0000000000000171 R11: 0000000000000000 R12: 0000000000004000
[   27.868488] R13: ffffa0ea89510000 R14: 0000000000004288 R15: ffffa0eaabc4f000
[   27.868490] FS:  0000000000000000(0000) GS:ffffa0ed4f640000(0000)
knlGS:0000000000000000
[   27.868493] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.868548] CR2: 00000000000000a8 CR3: 00000002bf210006 CR4: 00000000001706e0
[   27.868550] Call Trace:
[   27.868554]  <TASK>
[   27.868557]  __ieee80211_rx_h_amsdu+0x22f/0x5b0 [mac80211
5aa547b8289f4567c72ef207cdf47dd6bfda0f0f]
[   27.868621]  ? ieee80211_prepare_and_rx_handle+0x1384/0x1cb0
[mac80211 5aa547b8289f4567c72ef207cdf47dd6bfda0f0f]
[   27.868671]  ieee80211_prepare_and_rx_handle+0x1384/0x1cb0
[mac80211 5aa547b8289f4567c72ef207cdf47dd6bfda0f0f]
[   27.868721]  ieee80211_rx_list+0xa42/0xd70 [mac80211
5aa547b8289f4567c72ef207cdf47dd6bfda0f0f]
[   27.868763]  mt76_rx_complete+0x207/0x2e0 [mt76
778938866a7f3ea5ea095213dfa0e7b90189f510]
[   27.868773]  mt76_rx_poll_complete+0x356/0x580 [mt76
778938866a7f3ea5ea095213dfa0e7b90189f510]
[   27.868781]  ? mt76_dma_rx_fill.isra.0+0x1a0/0x220 [mt76
778938866a7f3ea5ea095213dfa0e7b90189f510]
[   27.868788]  mt76_dma_rx_poll+0x397/0x500 [mt76
778938866a7f3ea5ea095213dfa0e7b90189f510]
[   27.868797]  ? __napi_poll+0x190/0x190
[   27.868801]  __napi_poll+0x2b/0x190
[   27.868805]  napi_threaded_poll+0x157/0x170
[   27.868810]  kthread+0xde/0x110
[   27.868814]  ? kthread_complete_and_exit+0x20/0x20
[   27.868817]  ret_from_fork+0x22/0x30
[   27.868823]  </TASK>
[   27.868824] Modules linked in: xt_conntrack xt_MASQUERADE
nf_conntrack_netlink xt_addrtype iptable_filter br_netfilter cmac ccm
tun nft_reject_ipv4 nf_reject_ipv4 nft_reject nft_ct nft_masq
nft_chain_nat nf_tables nfnetlink nf_nat_h323 nf_conntrack_h323
nf_nat_pptp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip
nf_conntrack_sip nf_nat_irc nf_conntrack_irc nf_nat_ftp
nf_conntrack_ftp iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 netconsole bridge stp llc xt_TCPMSS xt_policy xt_tcpudp
iptable_mangle snd_hda_codec_realtek intel_rapl_msr
snd_hda_codec_generic ledtrig_audio intel_rapl_common
snd_hda_codec_hdmi x86_pkg_temp_thermal mt76x2e snd_hda_intel spi_nor
intel_powerclamp mt76x2_common uvcvideo snd_intel_dspcfg coretemp
mt76x02_lib snd_intel_sdw_acpi mtd videobuf2_vmalloc videobuf2_memops
mt76 kvm_intel iTCO_wdt videobuf2_v4l2 snd_hda_codec mac80211
videobuf2_common mei_pxp kvm mei_hdcp snd_hda_core intel_pmc_bxt
irqbypass snd_usb_audio snd_usbmidi_lib
[   27.868860]  snd_rawmidi spi_intel_platform libarc4 videodev
snd_hwdep spi_intel mei_me rapl at24 snd_seq_device r8169
iTCO_vendor_support cfg80211 i2c_i801 realtek intel_cstate snd_pcm
snd_timer mc i2c_smbus mdio_devres mei intel_uncore snd rfkill mxm_wmi
pcspkr soundcore libphy lpc_ich joydev mousedev mac_hid dm_multipath
sg crypto_user fuse bpf_preload ip_tables x_tables btrfs
blake2b_generic libcrc32c crc32c_generic xor raid6_pq usbhid dm_crypt
cbc encrypted_keys trusted asn1_encoder tee dm_mod crct10dif_pclmul
crc32_pclmul crc32c_intel polyval_clmulni polyval_generic gf128mul
ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd sr_mod cryptd
xhci_pci cdrom xhci_pci_renesas nls_iso8859_1 nls_utf8 vfat fat i915
drm_buddy intel_gtt video wmi drm_display_helper cec ttm
[   27.868903] CR2: 00000000000000a8
[   27.868905] ---[ end trace 0000000000000000 ]---
[   27.868907] RIP: 0010:ieee80211_deliver_skb+0x4c/0x1a0 [mac80211]
[   27.868936] Code: 00 00 8b 55 70 49 8b 85 50 05 00 00 65 48 03 05
0a 63 34 3e 48 01 50 08 48 ff 00 48 83 7b 28 00 74 11 48 8b 43 30 48
63 53 44 <48> 83 84 d0 a8 00 00 00 01 8b 87 e8 11 00 00 8d 50 fd 83 fa
01 0f
[   27.868938] RSP: 0018:ffffbbb3c0917ae8 EFLAGS: 00010286
[   27.868940] RAX: 0000000000000000 RBX: ffffbbb3c0917c90 RCX: 0000000000000008
[   27.868942] RDX: 0000000000000000 RSI: ffffa0eaaece064e RDI: ffffa0ea895109c0
[   27.868945] RBP: ffffa0eaabc4f000 R08: 000000000000003b R09: 0000000000000171
[   27.868948] R10: 0000000000000171 R11: 0000000000000000 R12: 0000000000004000
[   27.868950] R13: ffffa0ea89510000 R14: 0000000000004288 R15: ffffa0eaabc4f000
[   27.868952] FS:  0000000000000000(0000) GS:ffffa0ed4f640000(0000)
knlGS:0000000000000000
[   27.868954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.868956] CR2: 00000000000000a8 CR3: 00000002bf210006 CR4: 00000000001706e0
[   27.868958] Kernel panic - not syncing: Fatal exception in interrupt
[   27.869243] Kernel Offset: 0x32000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   27.869257] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

On Reddit, there is a similar thread with a USB adapter:
https://www.reddit.com/r/archlinux/comments/zufy3n/linuxzen_611zen11_crashes_while_trying_to_use_usb/

I have checked with the nearly latest git revisions of both the kernel
(9b43a525db125799df81e6fbef712a2ae50bfc5d) and the mt76 driver from
https://github.com/openwrt/mt76 (679254c). The issue still exists.

I have bisected this, and the first bad commit is yours:

b320d6c456ff2aa43491654407d448bcfa58ac9f is the first bad commit
commit b320d6c456ff2aa43491654407d448bcfa58ac9f
Author: Benjamin Berg <benjamin.berg@intel.com>
Date:   Fri Sep 2 16:12:40 2022 +0200

    wifi: mac80211: use correct rx link_sta instead of default

    Use rx->link_sta everywhere instead of accessing the default link.

    Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>

 net/mac80211/rx.c | 69 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

So, apparently, there is a code path in the mt76 driver where either
rx->link_sta or rx->link_sta->rx_stats is NULL. I haven't figured out
which is the case. Could you please look again at the driver?

-- 
Alexander E. Patrakov
