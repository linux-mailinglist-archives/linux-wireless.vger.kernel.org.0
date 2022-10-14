Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF405FF287
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 18:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJNQuB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 12:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJNQt7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 12:49:59 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13231B781
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 09:49:56 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w74so5677891oie.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CkZmaiNxL5uVyxvALeWUaDhF8HrDKA0hQpcwQtdzWCU=;
        b=psfcQthAt+F+B3ZGat3R0KBeAxQMBMTs29ojTX1UbsFvDaxHUXCKrpXs84XFu4Myil
         BJexXZOM2RWngWKit5ALuuLl6qDDBro7+2NnWxyBogGu0S0Cg/F/uFTz9+69aUdmX05h
         X/0uGkthWZAOhEuOjrhdUoMAfV14vVBrcV/yR6A6hLF8v8mFzAKgJ+659AY2k8hyb/vs
         eeIkDcP76wV47ZTpBWyLL6qSmKZqRNynuQY3NlVH9Lehp0WoDOMw43de7JAKLE54C2Hi
         zIQfT05kDtcjjR9lNtGe+X9M/4e98+CuagLhJMPeGJu82WcWXARYNKDgZkTIK05LS/vQ
         1ZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CkZmaiNxL5uVyxvALeWUaDhF8HrDKA0hQpcwQtdzWCU=;
        b=fISnPvCxAdDDa//+Y6tYQ1hdh66g9x2+Sv8ifarPiAp97eS5hhgIf6gINFvNSltN1c
         6VfnrNe/pyNVEXMx6FhDJIXc5KwAPh8KggyGxQsLKMj/TlTgmZMm3asUYnAY706LCyE8
         sQOUYDL/k0Y+t1fQE2cxagJJ+0dGZTquIb0p+CL9cVHDtIFCdCqVdn70OcTwRCFhowr3
         wPzZXoueTzvnedbwakLU4Nay6FJsAO2mIJIr1juSSBVYcDFbByYQdu8XFVqKct9TeLwX
         TOnyls7/toFOlIE58N80foee/dsnEDa6d7OlJZE+voWLpsa9DKiDXL7m6nHShNVczSVH
         mCBA==
X-Gm-Message-State: ACrzQf1jeU+PJ3S8ot3q3z0z8ZIVg+Shsuo1hfHy6HeygpQfjaTj1nBB
        jBvjGWOOIdJeHu6CwWyk9O0tXnjLHdg=
X-Google-Smtp-Source: AMsMyM5wk+NYW7xSaE1sZm2QJBxRI7aZimnoyFW1FDjJ4IMwNvuxh4pKOPLFDGrbWxbon6gRER5i1Q==
X-Received: by 2002:a05:6808:1691:b0:351:48da:62e0 with SMTP id bb17-20020a056808169100b0035148da62e0mr2974160oib.98.1665766195281;
        Fri, 14 Oct 2022 09:49:55 -0700 (PDT)
Received: from [192.168.0.158] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id bd18-20020a056808221200b00354e8bc0236sm1322798oib.34.2022.10.14.09.49.54
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 09:49:55 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <988d4c5c-a9a4-2f16-aa3c-e15778c04d46@lwfinger.net>
Date:   Fri, 14 Oct 2022 11:49:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Splat from net/wireless/wext-core.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

With a recent pull from kernel mainline, I am getting a log splat shown below:

[   29.369446] ------------[ cut here ]------------
[   29.369447] memcpy: detected field-spanning write (size 16) of single field 
"&compat_event->pointer" at net/wireless/wext-core.c:623 (size 4)
[   29.369465] WARNING: CPU: 0 PID: 38 at net/wireless/wext-core.c:623 
wireless_send_event+0x502/0x530
[   29.369472] Modules linked in: rfcomm(E) rpcsec_gss_krb5(E) auth_rpcgss(E) 
nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E) sunrpc(E) fscache(E) netfs(E) 
af_packet(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) vboxnetadp(OE) 
vboxnetflt(OE) bnep(E) btusb(E) btrtl(E) btbcm(E) btintel(E) btmtk(E) 
vboxdrv(OE) bluetooth(E) qrtr(E) ecdh_generic(E) dmi_sysfs(E) intel_rapl_msr(E) 
intel_rapl_common(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) 
rtw_8852be(OE) rtw_8852b(OE) rtw89pci(OE) iTCO_wdt(E) kvm_intel(E) 
snd_hda_codec_realtek(E) iwlmvm(E) nls_iso8859_1(E) snd_hda_codec_generic(E) 
intel_pmc_bxt(E) spi_intel_platform(E) rtw89core(OE) nls_cp437(E) 
iTCO_vendor_support(E) spi_intel(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) 
mei_pxp(E) mei_hdcp(E) vfat(E) kvm(E) snd_hda_intel(E) fat(E) irqbypass(E) 
snd_intel_dspcfg(E) mac80211(E) snd_hda_codec(E) pcspkr(E) joydev(E) wmi_bmof(E) 
iwlwifi(E) snd_hwdep(E) lpc_ich(E) snd_hda_core(E) libarc4(E) snd_pcm(E)
[   29.369535]  snd_timer(E) toshiba_acpi(E) cfg80211(E) mei_me(E) snd(E) 
sparse_keymap(E) e1000e(E) soundcore(E) mei(E) tiny_power_button(E) 
industrialio(E) toshiba_bluetooth(E) thermal(E) tpm_infineon(E) ac(E) battery(E) 
button(E) fuse(E) configfs(E) ext4(E) mbcache(E) jbd2(E) crct10dif_pclmul(E) 
crc32_pclmul(E) crc32c_intel(E) polyval_clmulni(E) polyval_generic(E) 
rtsx_pci_sdmmc(E) ghash_clmulni_intel(E) sha512_ssse3(E) mmc_core(E) i915(E) 
i2c_algo_bit(E) drm_buddy(E) drm_display_helper(E) drm_kms_helper(E) 
syscopyarea(E) sysfillrect(E) aesni_intel(E) sr_mod(E) sysimgblt(E) 
fb_sys_fops(E) crypto_simd(E) cec(E) xhci_pci(E) xhci_pci_renesas(E) cryptd(E) 
ehci_pci(E) xhci_hcd(E) ehci_hcd(E) ttm(E) serio_raw(E) cdrom(E) rtsx_pci(E) 
usbcore(E) drm(E) video(E) wmi(E) sg(E) dm_multipath(E) dm_mod(E) 
scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) msr(E)
[   29.369590] Unloaded tainted modules: ie31200_edac(E):1 pcc_cpufreq(E):8 
acpi_cpufreq(E):12
[   29.369596] CPU: 0 PID: 38 Comm: kworker/u16:1 Tainted: G           OE 
6.1.0-rc0-10164-g19f210eed144-dirty #4 a79f5d234c3d905ad563fd7aed3f9e7c19b19791
[   29.369600] Hardware name: TOSHIBA TECRA A50-A/TECRA A50-A, BIOS Version 4.50 
   09/29/2014
[   29.369602] Workqueue: phy0 ieee80211_iface_work [mac80211]
[   29.369658] RIP: 0010:wireless_send_event+0x502/0x530
[   29.369663] Code: 5f fd ff ff b9 04 00 00 00 48 89 ee 48 89 04 24 48 c7 c2 10 
ec f3 a4 48 c7 c7 c0 b1 e3 a4 c6 05 ed 3f 0e 01 01 e8 4c 8b 07 00 <0f> 0b 48 8b 
04 24 e9 2e fd ff ff e8 7e 3e 0d 00 e8 79 3e 0d 00 e8
[   29.369665] RSP: 0018:ffff9c11001b7790 EFLAGS: 00010286
[   29.369667] RAX: 0000000000000000 RBX: ffff8a70457a3d00 RCX: 0000000000000027
[   29.369669] RDX: ffff8a72632224c8 RSI: 0000000000000001 RDI: ffff8a72632224c0
[   29.369670] RBP: 0000000000000010 R08: 0000000000000000 R09: ffff9c11001b7638
[   29.369672] R10: 0000000000000003 R11: ffff8a726f546fa8 R12: ffffffffa4c45b3c
[   29.369673] R13: ffff8a70cb0fd000 R14: 0000000000000014 R15: ffff8a70457a3600
[   29.369675] FS:  0000000000000000(0000) GS:ffff8a7263200000(0000) 
knlGS:0000000000000000
[   29.369676] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.369678] CR2: 00007fb53d769000 CR3: 0000000163248002 CR4: 00000000001706f0
[   29.369679] Call Trace:
[   29.369681]  <TASK>
[   29.369683]  __cfg80211_connect_result+0x36f/0x650 [cfg80211 
ef292c04261807d50b3dee8f7093c79c21ebd85d]
[   29.369744]  ? cfg80211_rx_assoc_resp+0x1db/0x290 [cfg80211 
ef292c04261807d50b3dee8f7093c79c21ebd85d]
[   29.369787]  cfg80211_rx_assoc_resp+0x1db/0x290 [cfg80211 
ef292c04261807d50b3dee8f7093c79c21ebd85d]
[   29.369830]  ieee80211_rx_mgmt_assoc_resp.cold+0x268/0x191c [mac80211 
b16c34b0c18b27e169c0d6c5932cee86c8e5f900]
[   29.369889]  ieee80211_sta_rx_queued_mgmt+0x2d6/0x820 [mac80211 
b16c34b0c18b27e169c0d6c5932cee86c8e5f900]
[   29.369940]  ? __update_idle_core+0x68/0xc0
[   29.369944]  ? __switch_to_asm+0x3a/0x60
[   29.369948]  ? finish_task_switch.isra.0+0x90/0x2c0
[   29.369951]  ieee80211_iface_work+0x315/0x430 [mac80211 
b16c34b0c18b27e169c0d6c5932cee86c8e5f900]
[   29.369994]  process_one_work+0x202/0x3c0
[   29.369997]  worker_thread+0x4a/0x3b0
[   29.369999]  ? process_one_work+0x3c0/0x3c0
[   29.370000]  kthread+0xd7/0x100
[   29.370004]  ? kthread_complete_and_exit+0x20/0x20
[   29.370007]  ret_from_fork+0x1f/0x30
[   29.370010]  </TASK>
[   29.370011] ---[ end trace 0000000000000000 ]---

Thanks,

Larry
