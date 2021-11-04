Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED49C4459B4
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Nov 2021 19:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhKDS33 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Nov 2021 14:29:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46835 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232231AbhKDS33 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Nov 2021 14:29:29 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A7DB45C00C9;
        Thu,  4 Nov 2021 14:26:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 04 Nov 2021 14:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
         h=to:from:subject:cc:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=/PUPvRlaa4VO1v/wmWpphO9Zqw
        6tA3sbSyzVvv/H1Wg=; b=V83FRyEtea+x38EaUeNoxCpa1WXnVBk49uA/sGnfxo
        0HtKUCcFiWrdArH7OJ9iMFkRsF/kLpKatQOmaTrpk+dDBO4L53NRmZHgT8IV4v8g
        OkG+kHFxieeMqx9lgqSoG3KRa0cfGZgaA7ZSpEDVNx10w3mKxJw1zo2wTjy2xBtF
        nbo+RNA76hxz4LBvCLimclV1p54DQsNk8YZYXkKT2y43TTgV9gwUzQfnh/uU0ti0
        Q9SgWnh4wc4xspYjuVS+THkfxn1UVhAmHkUs5Ys8HRpZxZ9rUK9KVTosKa832WrP
        cRi4wA/04zaM2/u+ejayJFck/exb32xCYeRFwNr1tHEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/PUPvR
        laa4VO1v/wmWpphO9Zqw6tA3sbSyzVvv/H1Wg=; b=bGYUCoKX1K+6gFsgOycxlY
        R/OZaORCEgn654V+FY3zk3eivc/WlnLzImfPy/AOYRx2DLwgL/GaMQ6t12aTT+p4
        7/CZZ92sHifMzLjPG94iK4z22XmVV3OXKnDvj7tRnTlQj9/V9DpzpIcDgbQJxrT8
        m5KzpEpuHjynaB/6zX2MtfByrPUn39IJLzL7h9BLhigVt/wuEmVHG0KUgmTuU9Gm
        pM1yfRKXnCjsuA0a7RjSswiDyiVtutN2APxBh0I003ZVLTsJZF1tBPDM27KPPmWh
        6GZ9U1qfjFavrPCEqLuMj5wBDhGFe95vrj5bsctfzmdQHx2Bg1D+MpY3Va8BEIrQ
        ==
X-ME-Sender: <xms:6iWEYSHCKX9am5Mwoc6BlT0Z7fXMMOLs_XTd3dXrxrznvanEsCTvwQ>
    <xme:6iWEYTVqk4XRl5VA3G_b1Eyr2tEnpgupo1-qyZkO6EHl7qGagUJyNUlHbQmH0Ebk5
    7AQhqpgKR7iQ7rPmtE>
X-ME-Received: <xmr:6iWEYcIubCfQkbd3NPfUuCDbLlLyXZgthbuTzJZnQpgBB3KFuDGFaDDaIo1xGa8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtjeertd
    dtfeejnecuhfhrohhmpeffuhhsthihucforggsvgcuoeguuhhsthihseguuhhsthihmhgr
    sggvrdgtohhmqeenucggtffrrghtthgvrhhnpeehgfelgfeiffehvefhgedtudelfedtud
    euueehudffjeeigfejueejffegtdfgfeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpeguuhhsthihseguuhhsthihmhgrsggvrdgtohhm
X-ME-Proxy: <xmx:6iWEYcGgzZbp3Ve8nz-GHezUSSZ7rOdIxKjL6bTqNtnTJONJZ_QC9w>
    <xmx:6iWEYYWcKsCdX6S6Xz68SN0F3x03NxOCZ0jfNS2t_jIaXDrdR3Qr0A>
    <xmx:6iWEYfO-Rjz9m7nip4oaYjALIykHHK4kyaaHeP605oycC6pfphvqoQ>
    <xmx:6iWEYReiU67Mp965_6Ze-cra2fFnPWnlCXHdes_t2WklfWYWgMC1fg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Nov 2021 14:26:50 -0400 (EDT)
To:     linux-wireless@vger.kernel.org
From:   Dusty Mabe <dusty@dustymabe.com>
Subject: iwlwifi: null pointer dereference RIP:
 0010:iwl_mvm_get_tx_rate+0xd3/0x100 [iwlmvm]
Cc:     jforbes@fedoraproject.org
Message-ID: <685581b8-3a0e-d794-ec57-5cfdee7a9e71@dustymabe.com>
Date:   Thu, 4 Nov 2021 14:26:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm trying to track down a bug happening on my Intel NUC with a Fedora `5.14.13`
kernel.

The trace looks something like:

```
[345514.404223] BUG: kernel NULL pointer dereference, address: 000000000000016c
[345514.409853] #PF: supervisor read access in kernel mode
[345514.415323] #PF: error_code(0x0000) - not-present page
[345514.420718] PGD 0 P4D 0
[345514.425995] Oops: 0000 [#1] SMP NOPTI
[345514.431240] CPU: 2 PID: 774 Comm: irq/48-iwlwifi Kdump: loaded Tainted: G        W         5.14.13-300.fc35.x86_64 #1
[345514.436529] Hardware name:  /NUC5i3RYB, BIOS RYBDWi35.86A.0350.2015.0812.1722 08/12/2015
[345514.441734] RIP: 0010:iwl_mvm_get_tx_rate+0xd3/0x100 [iwlmvm]
[345514.446884] Code: 08 74 09 80 3d db 25 05 00 00 74 19 0f be 5d 08 83 fb 0b 0f 87 5e ff ff ff 0f b6 45 04 eb a2 0f 0b 31 db eb f4 44 0f be 4d 08 <45> 8b 85 6c 01 00 00 0f b7 f2 0f b7 c9 48 c7 c7 38 a0 e2 c0 c6 05
[345514.452177] RSP: 0018:ffffbe7fc0128cb8 EFLAGS: 00010246
[345514.457251] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000050
[345514.462313] RDX: 000000000000049b RSI: ffffbe7fc0128d88 RDI: ffff9e2c91a4a008
[345514.467293] RBP: ffffbe7fc0128d88 R08: 0000000000000050 R09: 00000000ffffffed
[345514.472227] R10: 0000000000000000 R11: 0000000000000050 R12: ffff9e2c91a4a008
[345514.477112] R13: 0000000000000000 R14: ffffbe7fc0128d88 R15: ffff9e2ca78aa484
[345514.481906] FS:  0000000000000000(0000) GS:ffff9e33b6d00000(0000) knlGS:0000000000000000
[345514.486673] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[345514.491327] CR2: 000000000000016c CR3: 00000001cde10005 CR4: 00000000003706e0
[345514.495957] Call Trace:
[345514.500447]  <IRQ>
[345514.504856]  iwl_mvm_set_tx_cmd_rate+0x66/0x140 [iwlmvm]
[345514.509279]  iwl_mvm_set_tx_params+0x1a5/0x580 [iwlmvm]
[345514.513627]  iwl_mvm_tx_skb_non_sta+0x16a/0x350 [iwlmvm]
[345514.517898]  iwl_mvm_tx_skb+0x23/0x40 [iwlmvm]
[345514.522081]  ieee80211_tx_frags+0x15c/0x220 [mac80211]
[345514.526254]  __ieee80211_tx+0x76/0x140 [mac80211]
[345514.530342]  ieee80211_tx+0xc7/0x110 [mac80211]
[345514.534361]  ieee80211_tx_pending+0x9c/0x270 [mac80211]
[345514.538316]  ? net_rx_action+0x223/0x2e0
[345514.542147]  tasklet_action_common.constprop.0+0xbc/0x120
[345514.545940]  __do_softirq+0xcd/0x282
[345514.549643]  do_softirq+0x76/0x90
[345514.553270]  </IRQ>
[345514.556800]  __local_bh_enable_ip+0x4b/0x50
[345514.560301]  iwl_pcie_irq_handler+0x493/0xad0 [iwlwifi]
[345514.563751]  ? irq_thread_dtor+0xb0/0xb0
[345514.567101]  irq_thread_fn+0x1d/0x60
[345514.570380]  irq_thread+0xb9/0x150
[345514.573574]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[345514.576732]  ? irq_thread_check_affinity+0xc0/0xc0
[345514.579822]  kthread+0x124/0x150
[345514.582821]  ? set_kthread_struct+0x40/0x40
[345514.585764]  ret_from_fork+0x1f/0x30
[345514.588623] Modules linked in: tun overlay bridge stp llc intel_rapl_msr snd_hda_codec_hdmi intel_rapl_common iwlmvm x86_pkg_temp_thermal intel_powerclamp mac80211 i915 coretemp snd_usb_audio snd_hda_codec_realtek kvm_intel snd_hda_codec_generic libarc4 ledtrig_audio snd_hda_intel kvm snd_usbmidi_lib snd_intel_dspcfg snd_intel_sdw_acpi iwlwifi btusb snd_hda_codec snd_rawmidi mei_hdcp at24 btrtl iTCO_wdt intel_pmc_bxt btbcm iTCO_vendor_support btintel snd_seq_device snd_hda_core irqbypass mc bluetooth rapl intel_cstate snd_hwdep snd_pcm cfg80211 intel_uncore i2c_algo_bit ttm i2c_i801 mei_me snd_timer i2c_smbus lpc_ich drm_kms_helper ecdh_generic mei joydev rfkill snd ir_rc6_decoder cec soundcore rc_rc6_mce nuvoton_cir acpi_pad drm zram ip_tables xfs dm_multipath crct10dif_pclmul crc32_pclmul crc32c_intel e1000e ghash_clmulni_intel hid_microsoft ff_memless video fuse
[345514.601061] CR2: 000000000000016c
```

I set up kdump and got a vmcore in /var/crash so we might be able to analyze that to find more
information. I'm available on IRC (dustymabe on libera.chat) if anyone would like to dig in
to the crashdump for more information.

Thanks!
Dusty Mabe
