Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3884453028D
	for <lists+linux-wireless@lfdr.de>; Sun, 22 May 2022 13:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244719AbiEVLHa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 May 2022 07:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiEVLH3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 May 2022 07:07:29 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262AA3BBE8
        for <linux-wireless@vger.kernel.org>; Sun, 22 May 2022 04:07:25 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ff39b44b06so122563857b3.13
        for <linux-wireless@vger.kernel.org>; Sun, 22 May 2022 04:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=1RqWQUDdAXqtIhUjsxYu40IGVme2To9vWJye1o8DdfQ=;
        b=J8bUjxxJUlQvh6ecjbxj2mXhmxcJgeit4zM5pCKBzaThwGw4G9AufUfu3ELWLW12Eh
         fEgxqFlypjl4jM8JDDWWvSLLSq32kw6YEkNG5OhgLNj5DmrR5PYczLQurXPMRdzZeP2w
         /S53q9TQJYgTR0hqSZXlJMPm9Sa/YlXlG23e32ThMjW++GBkWMC+VBBVKHLLASsyFMIy
         K4qppM+0lfnRHIHdQVco060qocejcYMWAulKUeTC+qM4qI4+EuGjeOfbQ0QeWoEQFh/k
         iSaQhkH3MHMUtNQeoZ4QwOYd3pLcUxqlH+P8S2gcTUixKdedlBK4IgQG0y1MvEnSbmqI
         +SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1RqWQUDdAXqtIhUjsxYu40IGVme2To9vWJye1o8DdfQ=;
        b=R6CSxcEwijtWLGs30JiVST0/Pwgg5hzAKxYRjVlqIoYGUlMrVcIN41OQszQdjKQB7o
         m3xkF96C4zGSwhqg8zMJxig7gIoQmGgat+GWzrDelKBvk8smR8SC4fmv3kY3tUG8hUw6
         CjKIM/F1QlBO+XO9swbJZ1/sajOavUHhgwAfpygAMBLvqwV+74HBaup9q/yEgBz15P4D
         roptj8IweNAtHOhZzGE1BRbYK58SVxlhzDJKRbHMfOGu8ga69Qey2et1FzJlUWAJ4P9v
         lqZ4pNea77rJh6P49tsNGRBscdJp5JeYBAj8AM7Oswt+UN643mOaghbYDwNkufP4bWta
         ZKoQ==
X-Gm-Message-State: AOAM530EwA5hcw4h6jNhRc/3Kwm2NvdsxYq+bSXB7tKQQSfctipi5LA2
        AS3x1Y2jRa9znRWA2QR7l/2+wx+XxnzYa02JDdKQpXBhHzU=
X-Google-Smtp-Source: ABdhPJy7e1hhobCRj+WnTW2DNADKOEwkef/g5KmqGuX1CPvwcvgh/1CKJh+m052KGG7KtEzT9vsNoh0vrSvLUShgSl0=
X-Received: by 2002:a81:1583:0:b0:2ff:306c:16fc with SMTP id
 125-20020a811583000000b002ff306c16fcmr18091667ywv.213.1653217644129; Sun, 22
 May 2022 04:07:24 -0700 (PDT)
MIME-Version: 1.0
From:   koos vriezen <koos.vriezen@gmail.com>
Date:   Sun, 22 May 2022 13:07:12 +0200
Message-ID: <CAGCbPWQXxGQqxnR1U6oExYU=Y7cww4F1gG2VbKvRRs=iXe8BGA@mail.gmail.com>
Subject: Crash ath10 after resume from suspend to ram, linux-5.17.7
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

Hi,

On my dell xps 9380 debian I got this crash. Only saw it once so far and I
do quite often a suspend/resume

02:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless
Network Adapter (rev 32)
ii  firmware-atheros                              20210818-1
all          Binary firmware for Qualcomm Atheros wireless cards

May 21 08:23:26 airbus wpa_supplicant[731]: wlp2s0:
CTRL-EVENT-REGDOM-CHANGE init=COUNTRY_IE type=COUNTRY alpha2=DE
May 21 08:23:26 airbus kernel: ------------[ cut here ]------------
May 21 08:23:26 airbus kernel: WARNING: CPU: 0 PID: 0 at
drivers/net/wireless/ath/ath10k/htt_rx.c:35
ath10k_htt_rx_pop_paddr+0xac/
0xc0 [ath10k_core]
May 21 08:23:26 airbus kernel: Modules linked in: snd_seq_dummy(E)
snd_hrtimer(E) snd_seq(E) snd_seq_device(E) ctr(E) ccm(E) btusb
(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) snd_hda_codec_hdmi(E)
jitterentropy_rng(E) sha512_ssse3(E) sha512_generic(E) uvcvide
o(E) videobuf2_vmalloc(E) videobuf2_memops(E) drbg(E)
videobuf2_v4l2(E) videobuf2_common(E) ansi_cprng(E) videodev(E)
ecdh_generic
(E) ecc(E) mc(E) cpufreq_powersave(E) cpufreq_conservative(E)
cpufreq_userspace(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) intel_
tcc_cooling(E) snd_ctl_led(E) x86_pkg_temp_thermal(E)
snd_hda_codec_realtek(E) intel_powerclamp(E) snd_hda_codec_generic(E)
corete
mp(E) kvm_intel(E) ath10k_pci(E) dell_laptop(E) kvm(E) dell_wmi(E)
ath10k_core(E) ledtrig_audio(E) irqbypass(E) crct10dif_pclmul(E
) ath(E) intel_rapl_msr(E) dell_smbios(E) crc32_pclmul(E) mac80211(E)
dcdbas(E) dell_wmi_descriptor(E) wmi_bmof(E) ghash_clmulni_i
ntel(E) dell_smm_hwmon(E) joydev(E) snd_soc_skl(E) snd_soc_hdac_hda(E)
snd_hda_ext_core(E)
May 21 08:23:26 airbus kernel:  snd_soc_acpi_intel_match(E)
snd_soc_acpi(E) snd_soc_sst_ipc(E) snd_soc_sst_dsp(E) snd_soc_core(E)
aesni_intel(E) crypto_simd(E) snd_hda_intel(E) cryptd(E)
snd_intel_dspcfg(E) rapl(E) snd_hda_codec(E) intel_cstate(E)
snd_hwdep(E) processor_thermal_device_pci_legacy(E) snd_pcsp(E)
snd_hda_core(E) processor_thermal_device(E) intel_uncore(E)
cfg80211(E) processor_thermal_rfim(E) evdev(E) snd_pcm(E) snd_timer(E)
processor_thermal_mbox(E) snd(E) processor_thermal_rapl(E)
serio_raw(E) efi_pstore(E) soundcore(E) hid_multitouch(E) rfkill(E)
libarc4(E) i915(E) intel_rapl_common(E) intel_soc_dts_iosf(E)
ucsi_acpi(E) ttm(E) typec_ucsi(E) intel_pch_thermal(E) roles(E)
typec(E) tpm_crb(E) tiny_power_button(E) wmi(E) battery(E) button(E)
video(E) int3403_thermal(E) tpm_tis(E) int340x_thermal_zone(E)
tpm_tis_core(E) tpm(E) rng_core(E) intel_hid(E) sparse_keymap(E)
acpi_pad(E) int3400_thermal(E) acpi_thermal_rel(E) ac(E) fuse(E)
configfs(E) efivarfs(E) ip_tables(E) x_tables(E) autofs4(E)
May 21 08:23:26 airbus kernel:  ext4(E) crc32c_generic(E) crc16(E)
mbcache(E) jbd2(E) hid_generic(E) rtsx_pci_sdmmc(E) mmc_core(E)
crc32c_intel(E) i2c_i801(E) i2c_smbus(E) xhci_pci(E) xhci_hcd(E)
intel_lpss_pci(E) rtsx_pci(E) intel_lpss(E) usbcore(E) idma64(E)
usb_common(E) thermal(E) i2c_hid_acpi(E) i2c_hid(E) hid(E)
May 21 08:23:26 airbus kernel: CPU: 0 PID: 0 Comm: swapper/0 Tainted:
G     U      E     5.17.7 #4
May 21 08:23:26 airbus kernel: Hardware name: Dell Inc. XPS 13
9380/0KTW76, BIOS 1.13.1 03/25/2021
May 21 08:23:26 airbus kernel: RIP:
0010:ath10k_htt_rx_pop_paddr+0xac/0xc0 [ath10k_core]
May 21 08:23:26 airbus kernel: Code: 0c 03 90 94 00 00 00 2b 90 90 00
00 00 48 8b b9 b8 03 00 00 45 31 c0 b9 02 00 00 00 48 8b 30 e8 ea 4d
9c ec 4c 89 e0 41 5c c3 <0f> 0b 45 31 e4 4c 89 e0 41 5c c3 66 0f 1f 84
00 00 00 00 00 41 57
May 21 08:23:26 airbus kernel: RSP: 0018:ffffa9fe40003da0 EFLAGS: 00010246
May 21 08:23:26 airbus kernel: RAX: 0000000000000000 RBX:
ffffa9fe40003e60 RCX: ffff93d885b420a0
May 21 08:23:26 airbus kernel: RDX: 0000000000000000 RSI:
000000002e0c2000 RDI: ffff93d885b42d18
May 21 08:23:26 airbus kernel: RBP: ffffa9fe40003ed0 R08:
0000000000000206 R09: 0000000000000000
May 21 08:23:26 airbus kernel: R10: 0000000000000000 R11:
ffffffffaeb75c40 R12: ffff93d91f4676c8
May 21 08:23:26 airbus kernel: R13: ffff93d885b420a0 R14:
ffff93d885b420a0 R15: ffff93d91f4676d0
May 21 08:23:26 airbus kernel: FS:  0000000000000000(0000)
GS:ffff93dc1e600000(0000) knlGS:0000000000000000
May 21 08:23:26 airbus kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
May 21 08:23:26 airbus kernel: CR2: 00007fe0077a9548 CR3:
000000014e5a6004 CR4: 00000000003706f0
May 21 08:23:26 airbus kernel: Call Trace:
May 21 08:23:26 airbus kernel:  <IRQ>
May 21 08:23:26 airbus kernel:
ath10k_htt_txrx_compl_task+0x66e/0x12d0 [ath10k_core]
May 21 08:23:26 airbus kernel:  ? ath10k_pci_rx_post_pipe+0x2c0/0x2c0
[ath10k_pci]
May 21 08:23:26 airbus kernel:  ? ath10k_bss_info_changed+0xb0/0x1050
[ath10k_core]
May 21 08:23:26 airbus kernel:  ?
ath10k_ce_per_engine_service+0x53/0x80 [ath10k_core]
May 21 08:23:26 airbus kernel:  ? ath10k_pci_napi_poll+0x4c/0x120 [ath10k_pci]
May 21 08:23:26 airbus kernel:  ath10k_pci_napi_poll+0x4c/0x120 [ath10k_pci]
May 21 08:23:26 airbus kernel:  __napi_poll+0x22/0x110
May 21 08:23:26 airbus kernel:  net_rx_action+0x206/0x260
May 21 08:23:26 airbus kernel:  __do_softirq+0xb2/0x1d7
May 21 08:23:26 airbus kernel:  irq_exit_rcu+0x7a/0xa0
May 21 08:23:26 airbus kernel:  common_interrupt+0x80/0xa0
May 21 08:23:26 airbus kernel:  </IRQ>
May 21 08:23:26 airbus kernel:  <TASK>
May 21 08:23:26 airbus kernel:  asm_common_interrupt+0x1e/0x40
May 21 08:23:26 airbus kernel: RIP: 0010:cpuidle_enter_state+0xb8/0x270
May 21 08:23:26 airbus kernel: Code: e8 8d cb b4 ff 31 ff 49 89 c6 e8
a3 d4 b4 ff 45 84 ff 74 12 9c 58 f6 c4 02 0f 85 a5 01 00 00 31 ff e8
4c d4 b9 ff fb 45 85 ed <0f> 88 ad 00 00 00 49 63 cd 4c 2b 34 24 48 89
c8 48 6b d1 68 48 c1
May 21 08:23:26 airbus kernel: RSP: 0018:ffffffffae603e60 EFLAGS: 00000202
May 21 08:23:26 airbus kernel: RAX: ffff93dc1e622440 RBX:
0000000000000001 RCX: 000000000000001f
May 21 08:23:26 airbus kernel: RDX: 0000000000000000 RSI:
000000004041c640 RDI: 0000000000000000
May 21 08:23:26 airbus kernel: RBP: ffff93dc1e62b300 R08:
00005d36cb6fb0dc R09: 0000000000000001
May 21 08:23:26 airbus kernel: R10: 0000000000000012 R11:
0000000000000009 R12: ffffffffae6c8780
May 21 08:23:26 airbus kernel: R13: 0000000000000001 R14:
00005d36cb6fb0dc R15: 0000000000000000
May 21 08:23:26 airbus kernel:  cpuidle_enter+0x24/0x40
May 21 08:23:26 airbus kernel:  do_idle+0x1a2/0x220
May 21 08:23:26 airbus kernel:  cpu_startup_entry+0x14/0x20
May 21 08:23:26 airbus kernel:  start_kernel+0x880/0x892
May 21 08:23:26 airbus kernel:  ? load_ucode_intel_bsp+0xc/0x28
May 21 08:23:26 airbus kernel:  secondary_startup_64_no_verify+0xc3/0xcb
May 21 08:23:26 airbus kernel:  </TASK>
May 21 08:23:26 airbus kernel: ---[ end trace 0000000000000000 ]---
May 21 08:23:26 airbus kernel: ath10k_pci 0000:02:00.0: failed to pop
paddr list: -2

Reloading the wireless related kernel modules didn't make this device work,
had to reboot.

Found one similar report here
https://bbs.archlinux.org/viewtopic.php?id=276259


Regards,
Koos Vriezen
