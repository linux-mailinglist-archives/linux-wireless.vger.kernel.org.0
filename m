Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD896F9B28
	for <lists+linux-wireless@lfdr.de>; Sun,  7 May 2023 21:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEGTYQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 May 2023 15:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGTYO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 May 2023 15:24:14 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13469AD31
        for <linux-wireless@vger.kernel.org>; Sun,  7 May 2023 12:24:13 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-54a009bf95bso1012218eaf.3
        for <linux-wireless@vger.kernel.org>; Sun, 07 May 2023 12:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683487452; x=1686079452;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5UAwWgWK48tAVCeirUORZIPmeUp/ywEqIKrhOmFhqro=;
        b=SxdmTMx4jklRCMBQBnIbtSllhO6xpcnPNDE7Bj3nArlBgQvSMpQ881g/qCxfTNpdd7
         f74J/DD97fcHIxHR80kC5yPG/Y5mLijfdaRDnO5ld4RHGWaPNb3AmAQiNVljHUUuwpp4
         NvguR9Ael+0Z8WQ5dRcDgvsVede91Lvzug5E7T3EhEuXk4HCXArq/OiLVAZCrkehCuaH
         sqN+5eQaHOPlP8aJk/vE8XxKzbIG5rdjr70dxEBdCVWjjl1hCPZlmuPvGfGpJjsCbhgy
         pSThyxBYJqpqbQc1FhKXbBKeUsoSp/j2L03HoeM80WjjLHZag4WF9sNUPXOxfMfXOFJU
         cdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683487452; x=1686079452;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UAwWgWK48tAVCeirUORZIPmeUp/ywEqIKrhOmFhqro=;
        b=HVg59NtmDcR/5v+nAwx0+C+ti6ufS3jsFnlq7eNCUsL51u4nZQkoGBSpPRKgStNZgM
         z7L4ifKmeXIvoacNsOPbcF5hhLxIoZSw4UJCgHXq/mLeVizvuZYo2zTadmGnXHDhxi5R
         I5divjdXdSFeQlFKZzohNGbO79AaeNqTQg2C1hYDeQKHPhcjBSzixosmH5pvpmRoycUq
         D2d7+ufOX8koxPKYtoiu1/9TB9Ov4ft0zF/M8tKtLaPeiyMHsWOL6K3daCYczYHk+c3f
         08sRPqm8MT+sRJ9QioaK/gI3qB6QsLtRBRy2ydQA+giJE+mK6Sew0WHQLerVJ9IU55EJ
         QtSg==
X-Gm-Message-State: AC+VfDyzyuv4lhUZUdYVG0cYAd4NdhihZeIsju3k6aM72gtPx4fl5sEB
        Ru/wcM6rVqBW86p9TSb3zDNEIyjYtss=
X-Google-Smtp-Source: ACHHUZ4gkEWMObHzdVC9ZCEGbi4Tk5EQAZMsl4U+5WN+eiaIy1t6e/iQARkmahleU4SRSf7rKfx0bA==
X-Received: by 2002:a4a:6512:0:b0:54f:8511:b20 with SMTP id y18-20020a4a6512000000b0054f85110b20mr356333ooc.5.1683487451717;
        Sun, 07 May 2023 12:24:11 -0700 (PDT)
Received: from [192.168.0.117] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id p17-20020a4ae151000000b005462a25c4f9sm3359496oot.9.2023.05.07.12.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 12:24:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <d37638ad-27c8-e74e-ece1-c4de2eaccfa6@lwfinger.net>
Date:   Sun, 7 May 2023 14:24:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>, Pkshih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: RCU WARNING Splat from rtw8822bu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I got the following WARNING splat from rtw8822bu. Driver rtw89_8852be was 
loaded, but inactive. This is the only instance of this warning in my logs even 
though I have been testing this driver quite a lot.

[18177.576316] ------------[ cut here ]------------
[18177.576320] Voluntary context switch within RCU read-side critical section!
[18177.576323] WARNING: CPU: 0 PID: 4621 at kernel/rcu/tree_plugin.h:318 
rcu_note_context_switch+0x571/0x5d0
[18177.576330] Modules linked in: rtw89_8852be(E) rtw89_8852b(E) rtw89_pci(E) 
ccm(E) rfcomm(E) rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) 
nfs(E) lockd(E) grace(E) sunrpc(E) fscache(E) netfs(E) af_packet(E) cmac(E) 
algif_hash(E) algif_skcipher(E) af_alg(E) bnep(E) vboxnetadp(OE) vboxnetflt(OE) 
qrtr(E) btusb(E) btrtl(E) btbcm(E) vboxdrv(OE) btintel(E) btmtk(E) bluetooth(E) 
rtw88_8822bu(E) rtw_usb(OE) rtw_8822b(OE) rtw_core(OE) ecdh_generic(E) 
binfmt_misc(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) intel_rapl_msr(E) 
intel_rapl_common(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) 
kvm_intel(E) iTCO_wdt(E) iwlmvm(E) spi_intel_platform(E) intel_pmc_bxt(E) 
rtw89_core(E) snd_hda_codec_realtek(E) spi_intel(E) iTCO_vendor_support(E) 
mei_hdcp(E) mei_pxp(E) snd_hda_codec_generic(E) ledtrig_audio(E) kvm(E) 
snd_hda_codec_hdmi(E) irqbypass(E) mac80211(E) pcspkr(E) wmi_bmof(E) iwlwifi(E) 
snd_hda_intel(E) snd_intel_dspcfg(E) snd_hda_codec(E) libarc4(E) snd_hwdep(E) 
lpc_ich(E) snd_hda_core(E) cfg80211(E)
[18177.576372]  snd_pcm(E) toshiba_acpi(E) snd_timer(E) mei_me(E) snd(E) 
sparse_keymap(E) e1000e(E) tiny_power_button(E) soundcore(E) mei(E) thermal(E) 
industrialio(E) toshiba_bluetooth(E) tpm_infineon(E) battery(E) button(E) ac(E) 
joydev(E) fuse(E) configfs(E) dmi_sysfs(E) ext4(E) mbcache(E) jbd2(E) 
crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) polyval_clmulni(E) 
polyval_generic(E) ghash_clmulni_intel(E) sha512_ssse3(E) i915(E) 
i2c_algo_bit(E) drm_buddy(E) drm_display_helper(E) xhci_pci(E) rtsx_pci_sdmmc(E) 
xhci_pci_renesas(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) 
cec(E) aesni_intel(E) ttm(E) sr_mod(E) mmc_core(E) crypto_simd(E) ehci_pci(E) 
xhci_hcd(E) cryptd(E) ehci_hcd(E) cdrom(E) rtsx_pci(E) drm(E) usbcore(E) 
video(E) wmi(E) serio_raw(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) 
scsi_dh_emc(E) scsi_dh_alua(E) msr(E)
[18177.576406] Unloaded tainted modules: rtw89_8852b(E):1 rtw89_pci(E):1 
rtw89_8852be(E):1 rtw_8822bu(OE):1 acpi_cpufreq(E):1 ie31200_edac(E):1 [last 
unloaded: rtw89_8852b(E)]
[18177.576414] CPU: 0 PID: 4621 Comm: kworker/u16:2 Tainted: G        W  OE 
6.4.0-rc0-gddc703714c0b-dirty #60 b8779e6b3528dc339549b3de720a59d95f1c4cf5
[18177.576417] Hardware name: TOSHIBA TECRA A50-A/TECRA A50-A, BIOS Version 4.50 
   09/29/2014
[18177.576418] Workqueue: phy3 ieee80211_chswitch_work [mac80211]
[18177.576469] RIP: 0010:rcu_note_context_switch+0x571/0x5d0
[18177.576472] Code: 00 00 00 00 0f 85 65 fd ff ff 49 89 84 24 a0 00 00 00 e9 58 
fd ff ff 48 c7 c7 60 66 ec b0 c6 05 96 5f 76 01 01 e8 af 0d f6 ff <0f> 0b e9 de 
fa ff ff c6 43 11 00 48 8b 73 20 ba 01 00 00 00 48 8b
[18177.576473] RSP: 0018:ffffa937cb0afa50 EFLAGS: 00010086
[18177.576475] RAX: 0000000000000000 RBX: ffff8d5b23233e80 RCX: 0000000000000027
[18177.576476] RDX: ffff8d5b232224c8 RSI: 0000000000000001 RDI: ffff8d5b232224c0
[18177.576477] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa937cb0af8f8
[18177.576478] R10: 0000000000000003 R11: ffff8d5b2f546fa8 R12: ffff8d5b23233040
[18177.576479] R13: ffff8d59a3475100 R14: ffff8d59a3475100 R15: ffffa937cb0afc00
[18177.576480] FS:  0000000000000000(0000) GS:ffff8d5b23200000(0000) 
knlGS:0000000000000000
[18177.576481] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18177.576483] CR2: 00007f0b70230fc4 CR3: 000000010dc34004 CR4: 00000000001706f0
[18177.576484] Call Trace:
[18177.576485]  <TASK>
[18177.576486]  __schedule+0xb0/0x1460
[18177.576492]  ? __mod_timer+0x116/0x360
[18177.576495]  schedule+0x5a/0xc0
[18177.576497]  schedule_timeout+0x87/0x150
[18177.576500]  ? trace_raw_output_tick_stop+0x60/0x60
[18177.576502]  wait_for_completion_timeout+0x7b/0x140
[18177.576505]  usb_start_wait_urb+0x82/0x160 [usbcore 
3226d314cb1ead5093f872b7ec783a0667c9bdaa]
[18177.576529]  usb_control_msg+0xe3/0x140 [usbcore 
3226d314cb1ead5093f872b7ec783a0667c9bdaa]
[18177.576547]  rtw_usb_read+0x88/0xe0 [rtw_usb 
ea7c9ef4045ae47f255f6c8259d13b8259ad6fcd]
[18177.576552]  rtw_usb_read8+0xf/0x10 [rtw_usb 
ea7c9ef4045ae47f255f6c8259d13b8259ad6fcd]
[18177.576556]  rtw_fw_send_h2c_command+0xa0/0x170 [rtw_core 
d6ae475d8b91a371feee3d61c7b6a8180a974991]
[18177.576571]  rtw_fw_send_ra_info+0xc9/0xf0 [rtw_core 
d6ae475d8b91a371feee3d61c7b6a8180a974991]
[18177.576584]  drv_sta_rc_update+0x7c/0x160 [mac80211 
c276bd403dbb068b66ac9ffb0a8f27d6e63e5c7c]
[18177.576613]  ieee80211_chan_bw_change+0xfb/0x110 [mac80211 
c276bd403dbb068b66ac9ffb0a8f27d6e63e5c7c]
[18177.576651]  ieee80211_change_chanctx+0x38/0x130 [mac80211 
c276bd403dbb068b66ac9ffb0a8f27d6e63e5c7c]
[18177.576688]  ieee80211_vif_use_reserved_switch+0x34e/0x900 [mac80211 
c276bd403dbb068b66ac9ffb0a8f27d6e63e5c7c]
[18177.576724]  ieee80211_link_use_reserved_context+0x88/0xe0 [mac80211 
c276bd403dbb068b66ac9ffb0a8f27d6e63e5c7c]
[18177.576760]  ieee80211_chswitch_work+0x95/0x170 [mac80211 
c276bd403dbb068b66ac9ffb0a8f27d6e63e5c7c]
[18177.576798]  process_one_work+0x201/0x410
[18177.576800]  worker_thread+0x4a/0x3b0
[18177.576802]  ? process_one_work+0x410/0x410
[18177.576803]  kthread+0xe1/0x110
[18177.576805]  ? kthread_complete_and_exit+0x20/0x20
[18177.576807]  ret_from_fork+0x1f/0x30
[18177.576810]  </TASK>
[18177.576811] ---[ end trace 0000000000000000 ]---

Thanks,

Larry

