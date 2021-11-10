Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D779644BADD
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 05:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhKJEkn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Nov 2021 23:40:43 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:36989 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230357AbhKJEkn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Nov 2021 23:40:43 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9BEB43201CD3;
        Tue,  9 Nov 2021 23:37:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 Nov 2021 23:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
         h=subject:from:to:cc:references:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=V
        9932IHxqtF/1rRETEfVm9lzYHpbYdWta4Sshdl+xb4=; b=uRXVwfLp1pDxv95h8
        tOcJ3yevN6Xiy2flZ68nFguKXZt845c7cwshJ2PvgIlF8dkI12UFzZjL9A5MY/0k
        4QZTWL+GZL5bngVoXKNGTODfOcvrjqhsfLgtbEcPdIOJO6wcSvyEUBfbjEo4y2cR
        ytQ899KzsBxVoE7PAzQ5aoD7PzTNdIPpZ2sciBpKwaxMCyuwI3A95oGRujgsMdr6
        X0bDjB97tpEJ1pZ28zX3lQ4nRmVTzIaWlzpEfjSRPtwBt7WU14IpyJshFDAb+Wjs
        SMlnMkDXDwQCPva6q6JauYWtxymOZg0ZApfbirSCjy2s1ViCoZFctC+it9vhmWd2
        fanag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=V9932IHxqtF/1rRETEfVm9lzYHpbYdWta4Sshdl+x
        b4=; b=SYxB+1fTaOmZMCabdgZ5PL0LHytDhuDGNS8v2SNbXcOWq9cvz6M3K5fW/
        CkEWYFFIdi6mJheByzU2VwNtTwNczeFAwrJri3+0KjPUx+sJRp8a0lXspXR2dox9
        nJHgrbq7Ww+nzqMYYDG5/TzFLf0lDflyV3HOyJGddSRxcksfAGnKakG3bkANjZjl
        QGGQxX8KYlj3IPfSXIwsjwekCwVNOe2Yan3/cvK47n7SzJCx4vWptd846B7DNcMf
        Xkvkdjmy5ncNgYB4cZNolkhBrmhIlmptgonZVwO9anKrg5v3DDRi3e1SPaaJWBSh
        ftZ08NqJqGDt77recq34i8R9BOwMQ==
X-ME-Sender: <xms:okyLYbllZicE8i65JaDVco0UchLMn1MBmA6JVrEqKsNzy9E8dq7SCw>
    <xme:okyLYe2hf0JpxM-gZybBoC5QzE6nuvtq6FqCr58coPhC_ourqE8SpGHzQ3eStPZEL
    rBXre7kkp5kxeflbFY>
X-ME-Received: <xmr:okyLYRo4r78qxt11Uk_cEPs8uDok-ygkyHIJKiXGl7M120Ih_8rfgdHBSIfEFQU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffhvfhfkffffgggjggtgfesthejre
    dttdefjeenucfhrhhomhepffhushhthicuofgrsggvuceoughushhthiesughushhthihm
    rggsvgdrtghomheqnecuggftrfgrthhtvghrnhephffgtdehhfekfefgudelvdevgefhgf
    ffveegjefggeeludeuleefgedvleduheegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepughushhthiesughushhthihmrggsvgdrtghomh
X-ME-Proxy: <xmx:okyLYTmr3ZKQq5bImh9xyg59DifpDhFkllXDSHF2z_8_lXqYvZXFow>
    <xmx:okyLYZ3hBjPNR1uDrQTxoGTtpB67Qi8CfcUApVPax6d1QXN_L1v_5A>
    <xmx:okyLYSu6Q4y75_kp2bkhaFyNyRiEusr5vO7mEw58sq2deDj8jo9lGw>
    <xmx:okyLYW9-ffN4pd8S_zRoZFgWF2W8rB_1ec9Pe5HIvOgbLQrKV5PWoQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Nov 2021 23:37:54 -0500 (EST)
Subject: Re: iwlwifi: null pointer dereference RIP:
 0010:iwl_mvm_get_tx_rate+0xd3/0x100 [iwlmvm]
From:   Dusty Mabe <dusty@dustymabe.com>
To:     linux-wireless@vger.kernel.org
Cc:     jforbes@fedoraproject.org
References: <685581b8-3a0e-d794-ec57-5cfdee7a9e71@dustymabe.com>
Message-ID: <2badde47-3a74-48a1-a1e7-bd7a77f78223@dustymabe.com>
Date:   Tue, 9 Nov 2021 23:37:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <685581b8-3a0e-d794-ec57-5cfdee7a9e71@dustymabe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/4/21 2:26 PM, Dusty Mabe wrote:
> Hi,
> 
> I'm trying to track down a bug happening on my Intel NUC with a Fedora `5.14.13`
> kernel.
> 
> The trace looks something like:
> 
> ```
> [345514.404223] BUG: kernel NULL pointer dereference, address: 000000000000016c
> [345514.409853] #PF: supervisor read access in kernel mode
> [345514.415323] #PF: error_code(0x0000) - not-present page
> [345514.420718] PGD 0 P4D 0
> [345514.425995] Oops: 0000 [#1] SMP NOPTI
> [345514.431240] CPU: 2 PID: 774 Comm: irq/48-iwlwifi Kdump: loaded Tainted: G        W         5.14.13-300.fc35.x86_64 #1
> [345514.436529] Hardware name:  /NUC5i3RYB, BIOS RYBDWi35.86A.0350.2015.0812.1722 08/12/2015
> [345514.441734] RIP: 0010:iwl_mvm_get_tx_rate+0xd3/0x100 [iwlmvm]
> [345514.446884] Code: 08 74 09 80 3d db 25 05 00 00 74 19 0f be 5d 08 83 fb 0b 0f 87 5e ff ff ff 0f b6 45 04 eb a2 0f 0b 31 db eb f4 44 0f be 4d 08 <45> 8b 85 6c 01 00 00 0f b7 f2 0f b7 c9 48 c7 c7 38 a0 e2 c0 c6 05
> [345514.452177] RSP: 0018:ffffbe7fc0128cb8 EFLAGS: 00010246
> [345514.457251] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000050
> [345514.462313] RDX: 000000000000049b RSI: ffffbe7fc0128d88 RDI: ffff9e2c91a4a008
> [345514.467293] RBP: ffffbe7fc0128d88 R08: 0000000000000050 R09: 00000000ffffffed
> [345514.472227] R10: 0000000000000000 R11: 0000000000000050 R12: ffff9e2c91a4a008
> [345514.477112] R13: 0000000000000000 R14: ffffbe7fc0128d88 R15: ffff9e2ca78aa484
> [345514.481906] FS:  0000000000000000(0000) GS:ffff9e33b6d00000(0000) knlGS:0000000000000000
> [345514.486673] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [345514.491327] CR2: 000000000000016c CR3: 00000001cde10005 CR4: 00000000003706e0
> [345514.495957] Call Trace:
> [345514.500447]  <IRQ>
> [345514.504856]  iwl_mvm_set_tx_cmd_rate+0x66/0x140 [iwlmvm]
> [345514.509279]  iwl_mvm_set_tx_params+0x1a5/0x580 [iwlmvm]
> [345514.513627]  iwl_mvm_tx_skb_non_sta+0x16a/0x350 [iwlmvm]
> [345514.517898]  iwl_mvm_tx_skb+0x23/0x40 [iwlmvm]
> [345514.522081]  ieee80211_tx_frags+0x15c/0x220 [mac80211]
> [345514.526254]  __ieee80211_tx+0x76/0x140 [mac80211]
> [345514.530342]  ieee80211_tx+0xc7/0x110 [mac80211]
> [345514.534361]  ieee80211_tx_pending+0x9c/0x270 [mac80211]
> [345514.538316]  ? net_rx_action+0x223/0x2e0
> [345514.542147]  tasklet_action_common.constprop.0+0xbc/0x120
> [345514.545940]  __do_softirq+0xcd/0x282
> [345514.549643]  do_softirq+0x76/0x90
> [345514.553270]  </IRQ>
> [345514.556800]  __local_bh_enable_ip+0x4b/0x50
> [345514.560301]  iwl_pcie_irq_handler+0x493/0xad0 [iwlwifi]
> [345514.563751]  ? irq_thread_dtor+0xb0/0xb0
> [345514.567101]  irq_thread_fn+0x1d/0x60
> [345514.570380]  irq_thread+0xb9/0x150
> [345514.573574]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
> [345514.576732]  ? irq_thread_check_affinity+0xc0/0xc0
> [345514.579822]  kthread+0x124/0x150
> [345514.582821]  ? set_kthread_struct+0x40/0x40
> [345514.585764]  ret_from_fork+0x1f/0x30
> [345514.588623] Modules linked in: tun overlay bridge stp llc intel_rapl_msr snd_hda_codec_hdmi intel_rapl_common iwlmvm x86_pkg_temp_thermal intel_powerclamp mac80211 i915 coretemp snd_usb_audio snd_hda_codec_realtek kvm_intel snd_hda_codec_generic libarc4 ledtrig_audio snd_hda_intel kvm snd_usbmidi_lib snd_intel_dspcfg snd_intel_sdw_acpi iwlwifi btusb snd_hda_codec snd_rawmidi mei_hdcp at24 btrtl iTCO_wdt intel_pmc_bxt btbcm iTCO_vendor_support btintel snd_seq_device snd_hda_core irqbypass mc bluetooth rapl intel_cstate snd_hwdep snd_pcm cfg80211 intel_uncore i2c_algo_bit ttm i2c_i801 mei_me snd_timer i2c_smbus lpc_ich drm_kms_helper ecdh_generic mei joydev rfkill snd ir_rc6_decoder cec soundcore rc_rc6_mce nuvoton_cir acpi_pad drm zram ip_tables xfs dm_multipath crct10dif_pclmul crc32_pclmul crc32c_intel e1000e ghash_clmulni_intel hid_microsoft ff_memless video fuse
> [345514.601061] CR2: 000000000000016c
> ```
> 
> I set up kdump and got a vmcore in /var/crash so we might be able to analyze that to find more
> information. I'm available on IRC (dustymabe on libera.chat) if anyone would like to dig in
> to the crashdump for more information.


Bump - anybody interested in more information to see if we can track this one down.

Since I have a vmcore from a kdump it might be a little easier to diagnose things.

Dusty
