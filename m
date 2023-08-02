Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC27D76D473
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 18:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjHBQ7S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 12:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjHBQ7Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 12:59:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3B81722
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 09:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8C9761709
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 16:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7A4C433C9;
        Wed,  2 Aug 2023 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690995554;
        bh=bwxSpeeEMolFbxmAQsWkKQir/DQbwYfnu+Z9oe97nTk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=U8S72TPIKRI2q6+beVHNHp2gU7HR1ZrDDerWpV+GL/82hm6dl7AHobhznBI6fg2eD
         I0VEX9bedF6Tz2hpeA5V2T/MWOD0EoY4scvMek+kOvBDHXoo3BhFow4huKOpa6Q/a7
         j3zOwdu+6g66jGj5w1iqx8tSPvM6MaQTzP+ULWD2rRSJO1B6AyST2ceIOOC4RLvqsa
         0Ou5q7mc1zk2+I6Z9X27z+mKZ/aILEWL5chJ4lCHEfacPG7x170KFFeK33+WI53qoe
         dBbURiC9B74HXh4V8rXARvm0n/+gsiE+uCTGWiecH307ef15a2jcIF31PF0P11oJwN
         EWbS3zVUhJl/Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Use pdev_id rather than mac_id to get pdev
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230714080658.3140-1-quic_bqiang@quicinc.com>
References: <20230714080658.3140-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169099555133.463701.2834391629436788090.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 16:59:13 +0000 (UTC)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> We are seeing kernel crash in below test scenario:
>  1. make DUT connect to an WPA3 encrypted 11ax AP in Ch44 HE80
>  2. use "wpa_cli -i <inf> disconnect" to disconnect
>  3. wait for DUT to automatically reconnect
> 
> Kernel crashes while waiting, below shows the crash stack:
> [  755.120868] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  755.120871] #PF: supervisor read access in kernel mode
> [  755.120872] #PF: error_code(0x0000) - not-present page
> [  755.120873] PGD 0 P4D 0
> [  755.120875] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  755.120876] CPU: 7 PID: 0 Comm: swapper/7 Kdump: loaded Not tainted 5.19.0-rc1+ #3
> [  755.120878] Hardware name: Intel(R) Client Systems NUC11PHi7/NUC11PHBi7, BIOS PHTGL579.0063.2021.0707.1057 07/07/2021
> [  755.120879] RIP: 0010:ath12k_dp_process_rx_err+0x2b6/0x14a0 [ath12k]
> [  755.120890] Code: 01 c0 48 c1 e0 05 48 8b 9c 07 b8 b2 00 00 48 c7 c0 61 ff 0e c1 48 85 db 53 48 0f 44 c6 48 c7 c6 80 9d 0f c1 50 e8 1a 25 00 00 <4c> 8b 3b 4d 8b 76 14 41 59 41 5a 41 8b 87 78 43 01 00 4d 85 f6 89
> [  755.120891] RSP: 0018:ffff9a93402c8d10 EFLAGS: 00010282
> [  755.120892] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000303
> [  755.120893] RDX: 0000000000000000 RSI: ffffffff93b7cbe9 RDI: 00000000ffffffff
> [  755.120894] RBP: ffff9a93402c8e50 R08: ffffffff93e65360 R09: ffffffff942e044d
> [  755.120894] R10: 0000000000000000 R11: 0000000000000063 R12: ffff8dbec5420000
> [  755.120895] R13: ffff8dbec5420000 R14: ffff8dbdefe9a0a0 R15: ffff8dbec5420000
> [  755.120896] FS:  0000000000000000(0000) GS:ffff8dc2705c0000(0000) knlGS:0000000000000000
> [  755.120897] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  755.120898] CR2: 0000000000000000 CR3: 0000000107be4005 CR4: 0000000000770ee0
> [  755.120898] PKRU: 55555554
> [  755.120899] Call Trace:
> [  755.120900]  <IRQ>
> [  755.120903]  ? ath12k_pci_write32+0x2e/0x80 [ath12k]
> [  755.120910]  ath12k_dp_service_srng+0x214/0x2e0 [ath12k]
> [  755.120917]  ath12k_pci_ext_grp_napi_poll+0x26/0x80 [ath12k]
> [  755.120923]  __napi_poll+0x2b/0x1c0
> [  755.120925]  net_rx_action+0x2a1/0x2f0
> [  755.120927]  __do_softirq+0xfa/0x2e9
> [  755.120929]  irq_exit_rcu+0xb9/0xd0
> [  755.120932]  common_interrupt+0xc1/0xe0
> [  755.120934]  </IRQ>
> [  755.120934]  <TASK>
> [  755.120935]  asm_common_interrupt+0x2c/0x40
> [  755.120936] RIP: 0010:cpuidle_enter_state+0xdd/0x3a0
> [  755.120938] Code: 00 31 ff e8 45 e2 74 ff 80 7d d7 00 74 16 9c 58 0f 1f 40 00 f6 c4 02 0f 85 a0 02 00 00 31 ff e8 69 79 7b ff fb 0f 1f 44 00 00 <45> 85 ff 0f 88 6d 01 00 00 49 63 d7 4c 2b 6d c8 48 8d 04 52 48 8d
> [  755.120939] RSP: 0018:ffff9a934018be50 EFLAGS: 00000246
> [  755.120940] RAX: ffff8dc2705c0000 RBX: 0000000000000002 RCX: 000000000000001f
> [  755.120941] RDX: 000000afd0b532d3 RSI: ffffffff93b7cbe9 RDI: ffffffff93b8b66e
> [  755.120942] RBP: ffff9a934018be88 R08: 0000000000000002 R09: 0000000000030500
> [  755.120942] R10: ffff9a934018be18 R11: 0000000000000741 R12: ffffba933fdc0600
> [  755.120943] R13: 000000afd0b532d3 R14: ffffffff93fcbc60 R15: 0000000000000002
> [  755.120945]  cpuidle_enter+0x2e/0x40
> [  755.120946]  call_cpuidle+0x23/0x40
> [  755.120948]  do_idle+0x1ff/0x260
> [  755.120950]  cpu_startup_entry+0x1d/0x20
> [  755.120951]  start_secondary+0x10d/0x130
> [  755.120953]  secondary_startup_64_no_verify+0xd3/0xdb
> [  755.120956]  </TASK>
> [  755.120956] Modules linked in: michael_mic rfcomm cmac algif_hash algif_skcipher af_alg bnep qrtr_mhi intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio kvm_intel qrtr snd_hda_codec_hdmi kvm irqbypass ath12k snd_hda_intel snd_seq_midi crct10dif_pclmul mhi ghash_clmulni_intel snd_intel_dspcfg snd_seq_midi_event aesni_intel qmi_helpers i915 snd_rawmidi crypto_simd snd_hda_codec cryptd cec intel_cstate snd_hda_core mac80211 rc_core nouveau snd_seq snd_hwdep btusb drm_buddy drm_ttm_helper nls_iso8859_1 snd_pcm ttm btrtl snd_seq_device wmi_bmof mxm_wmi input_leds cfg80211 joydev btbcm drm_display_helper snd_timer btintel mei_me libarc4 drm_kms_helper bluetooth i2c_algo_bit snd fb_sys_fops syscopyarea mei sysfillrect ecdh_generic soundcore sysimgblt ecc acpi_pad mac_hid sch_fq_codel ipmi_devintf ipmi_msghandler msr parport_pc ppdev lp ramoops parport reed_solomon drm efi_pstore ip_tables x_tables au
 tofs4
> [  755.120992]  hid_generic usbhid hid ax88179_178a usbnet mii nvme nvme_core rtsx_pci_sdmmc crc32_pclmul i2c_i801 intel_lpss_pci i2c_smbus intel_lpss rtsx_pci idma64 virt_dma vmd wmi video
> [  755.121002] CR2: 0000000000000000
> 
> The crash is because, for WCN7850, only ab->pdev[0] is initialized, while mac_id here is
> misused to retrieve pdev and it is not zero, leading to a NULL pointer access.
> 
> Fix this issue by getting pdev_id first and then use it to retrieve pdev.
> 
> Also fix some other code snippets which have the same issue.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

7ee027abd453 wifi: ath12k: Use pdev_id rather than mac_id to get pdev

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230714080658.3140-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

