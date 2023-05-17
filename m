Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C036706319
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 10:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjEQIkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 04:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjEQIjs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 04:39:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5190A76AF
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 01:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4914643C6
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 08:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61680C433D2;
        Wed, 17 May 2023 08:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684312768;
        bh=pt8bo7TRf1e6H02nUDmSUDgbdnCDqWzIG5YjU9i1oso=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eDBwCMH/vVcOleF6wZqtkZG7EgumG8b2pT23Ru1XYstHS4cmZEHhc0xVBylt7ZFTI
         utSZ5wJMr84lFm5ROgfcDOHGCRyT+0hgOp3M4uoJs4aKyeFTaEw8tfoJ9skE4Jzltg
         zVRvH0qsng6yHdoKXqd25TkyAiE6IV+rJQju/TZySz0q1/yjCwhMDgZRFFIONw0TSf
         KEtPxCxZXM/CDNuHD1jEcurU4yX43zlKpyIwkyAz+Lf2muoZ5uzXIcSdWJXZzw3Zmi
         41CSWk2tlStTMlVmfbmoP8qLx+16+Q+dGBNiZMtDrUR7tMmbpNXm6teHMuqqLTQ4IH
         87DCdB7Clcu1g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Pkshih <pkshih@realtek.com>
Subject: Re: Bug in commit b2cbac9b9b28
References: <cdd2ebad-cae6-70e2-87a6-84f75f227150@lwfinger.net>
Date:   Wed, 17 May 2023 11:39:24 +0300
In-Reply-To: <cdd2ebad-cae6-70e2-87a6-84f75f227150@lwfinger.net> (Larry
        Finger's message of "Tue, 16 May 2023 22:07:05 -0500")
Message-ID: <87a5y3mjwj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> Kalle,
>
> Commit b2cbac9b9b28 ("net: Remove low_thresh in ip defrag") results in
> warnings like the following:
>
> [11278.308851] ------------[ cut here ]------------
> [11278.308854] sysctl net/ipv4/ipfrag_low_thresh: data points to
> kernel global data: ipfrag_low_thresh_unused
> [11278.308896] WARNING: CPU: 2 PID: 2603 at net/sysctl_net.c:155
> register_net_sysctl+0xab/0x150
> [11278.308902] Modules linked in: vboxnetadp(OE) vboxnetflt(OE)
> vboxdrv(OE) rfcomm(E) ccm(E) rpcsec_gss_krb5(E) auth_rpcgss(E)
> nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E) sunrpc(E) fscache(E)
> netfs(E) af_packet(E) cmac(E) algif_hash(E) algif_skcipher(E)
> af_alg(E) qrtr(E) bnep(E) btusb(E) btrtl(E) btbcm(E) btintel(E)
> btmtk(E) bluetooth(E) ecdh_generic(E) binfmt_misc(E) nls_iso8859_1(E)
> nls_cp437(E) vfat(E) iwlmvm(E) rtw89_8851be(E) fat(E) rtw89_8851b(E)
> rtw89_pci(E) intel_rapl_msr(E) rtw89_core(E) intel_rapl_common(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E)
> snd_hda_codec_realtek(E) snd_hda_codec_generic(E) mac80211(E)
> ledtrig_audio(E) kvm_intel(E) iTCO_wdt(E) spi_intel_platform(E)
> intel_pmc_bxt(E) spi_intel(E) iTCO_vendor_support(E)
> snd_hda_codec_hdmi(E) iwlwifi(E) mei_pxp(E) mei_hdcp(E)
> snd_hda_intel(E) kvm(E) snd_intel_dspcfg(E) libarc4(E)
> snd_hda_codec(E) irqbypass(E) snd_hwdep(E) pcspkr(E) snd_hda_core(E)
> cfg80211(E) wmi_bmof(E) snd_pcm(E) lpc_ich(E) mei_me(E) snd_timer(E)
> snd(E) toshiba_acpi(E)
> [11278.308958]  thermal(E) mei(E) e1000e(E) tiny_power_button(E)
> soundcore(E) sparse_keymap(E) toshiba_bluetooth(E) industrialio(E)
> battery(E) tpm_infineon(E) ac(E) button(E) joydev(E) fuse(E)
> configfs(E) dmi_sysfs(E) ext4(E) mbcache(E) jbd2(E)
> crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) polyval_clmulni(E)
> polyval_generic(E) ghash_clmulni_intel(E) sha512_ssse3(E) i915(E)
> i2c_algo_bit(E) drm_buddy(E) rtsx_pci_sdmmc(E) mmc_core(E)
> drm_display_helper(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E)
> sysimgblt(E) aesni_intel(E) crypto_simd(E) ehci_pci(E) sr_mod(E)
> cec(E) xhci_pci(E) xhci_pci_renesas(E) ttm(E) cryptd(E) xhci_hcd(E)
> cdrom(E) ehci_hcd(E) rtsx_pci(E) drm(E) usbcore(E) video(E) wmi(E)
> serio_raw(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E)
> scsi_dh_emc(E) scsi_dh_alua(E) msr(E)
> [11278.309005] Unloaded tainted modules: acpi_cpufreq(E):1 ie31200_edac(E):1
> [11278.309009] CPU: 2 PID: 2603 Comm: chrome Tainted: G        W  OE
> 6.4.0-rc1-wireless_next-g082489a6b7fd #12
> 5a2b2d499aad74f4cae3c5aa9f2f676e9892c87c
> [11278.309013] Hardware name: TOSHIBA TECRA A50-A/TECRA A50-A, BIOS
> Version 4.50 09/29/2014
> [11278.309014] RIP: 0010:register_net_sysctl+0xab/0x150
> [11278.309018] Code: c0 b1 72 b9 48 81 fd 00 00 00 b3 73 b0 48 c7 c1
> 5a 40 ea b0 48 8b 13 4c 8b 43 08 4c 89 ee 48 c7 c7 08 ba fa b0 e8 a5
> 5f 62 ff <0f> 0b 66 81 63 14 6d ff 48 8b 53 40 48 83 c3 40 48 85 d2 75
> 8b 5b
> [11278.309019] RSP: 0018:ffffb93ac8937c30 EFLAGS: 00010282
> [11278.309022] RAX: 0000000000000000 RBX: ffff9953b8ee7e40 RCX: 0000000000000027
> [11278.309024] RDX: ffff9953e32a24c8 RSI: 0000000000000001 RDI: ffff9953e32a24c0
> [11278.309025] RBP: ffffffffb2d0f2e8 R08: 0000000000000000 R09: ffffb93ac8937ad8
> [11278.309026] R10: 0000000000000003 R11: ffff9953ef546fa8 R12: ffff9951fe649400
> [11278.309028] R13: ffffffffb0fa0c46 R14: ffff9953b8ee7e00 R15: 0000000070000000
> [11278.309029] FS:  00007fe6c4030040(0000) GS:ffff9953e3280000(0000)
> knlGS:0000000000000000
> [11278.309031] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [11278.309032] CR2: 00007fff7a7b0000 CR3: 00000002c4acc001 CR4: 00000000001706e0
> [11278.309034] Call Trace:
> [11278.309036]  <TASK>
> [11278.309038]  ipv4_frags_init_net+0xdd/0x170
> [11278.309041]  ops_init+0x37/0x120
> [11278.309045]  setup_net+0x12a/0x290
> [11278.309047]  copy_net_ns+0x106/0x260
> [11278.309050]  create_new_namespaces+0x113/0x2e0
> [11278.309053]  copy_namespaces+0x8d/0x100
> [11278.309056]  copy_process+0xee5/0x1c20
> [11278.309060]  kernel_clone+0x98/0x3a0
> [11278.309063]  __do_sys_clone+0x66/0x90
> [11278.309066]  do_syscall_64+0x56/0x80
> [11278.309069]  ? exc_page_fault+0x6d/0x150
> [11278.309073]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [11278.309078] RIP: 0033:0x7fe6c5272a66
> [11278.309080] Code: 85 ff 74 3e 48 83 e6 f0 74 38 48 89 4e f8 48 83
> ee 10 48 89 3e 48 89 d7 4c 89 c2 4d 89 c8 4c 8b 54 24 08 b8 38 00 00
> 00 0f 05 <48> 85 c0 7c 13 74 01 c3 31 ed 58 5f ff d0 48 89 c7 b8 3c 00
> 00 00
> [11278.309082] RSP: 002b:00007fff7a7af158 EFLAGS: 00000206 ORIG_RAX:
> 0000000000000038
> [11278.309085] RAX: ffffffffffffffda RBX: 00007fff7a7b31b0 RCX: 00007fe6c5272a66
> [11278.309086] RDX: 0000000000000000 RSI: 00007fff7a7b3160 RDI: 0000000070000011
> [11278.309088] RBP: 00007fff7a7b31a0 R08: 0000000000000000 R09: 0000000000000000
> [11278.309089] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000070000011
> [11278.309091] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [11278.309093]  </TASK>
> [11278.309094] ---[ end trace 0000000000000000 ]---
>
> I ran across this because I needed to run the most recent copy of
> wireless-next to test a new driver in the rtw89 family. After a scare
> about the new driver causing this problem, I tested wireless-next tip
> and found this problem on a machine with no wifi. I bisected the
> problem and found the bad commit.
>
> This problem has been reported [1] to the author of the bad commit. I
> think the bad patch should be reverted; however, my main reason for
> this report is to alert other users of wireless-next to the problem.

Thanks Larry, this was really helpful. I also see this now on my test
boxes but didn't have to waste any time debugging thanks to you :)

I also see that the broken commit is now reverted in net-next:

https://git.kernel.org/netdev/net-next/c/e7480a44d7c4

Unfortunately it will trickle down to wireless-next after the next
wireless-next pull request, which will take something like 2-3 weeks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
