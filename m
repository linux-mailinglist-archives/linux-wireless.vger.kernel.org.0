Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419B41B31BF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 23:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgDUVP7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbgDUVP5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 17:15:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B6AC0610D5
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2020 14:15:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so5177840wmh.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2020 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=ZhDPma/iYmuGCtjFGt/fKICP58cUOPxePVJFhw6qpvs=;
        b=CQcDExfZuzMtCO2FjPlIdFC6JbRt6oOBaKbbsdbQyXbUTIzjiHph1wY9r8E66iJn+a
         5yJ0nhhN8mjtHZVLzgNERrtuFPbiyXyn9Psp9QE9CZeDwigFx4tR5UWx4mLO6ejoACUd
         L7ytfuTvqghIjCbeI61UdyCRwuVUeG53RJZx88oEW90lUWvsbdPdMAaxhQXNxqeKbXWk
         0XANQPGhVDVG5WW5AJ46N2UFJnT/sS+R+0EVZBqXcbLiZVcC8aVPxpA3CG/QAnEpWCdM
         LrxPCsj4AL3vEan2hq8lZ7HSLAr2Vd3FOttD4n42w5GVzHK+8xV/aLthPD7pNuFdtZym
         6GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=ZhDPma/iYmuGCtjFGt/fKICP58cUOPxePVJFhw6qpvs=;
        b=QgleUO2J12lOldcwcccYQH/3xcly5WEmWxijGCDN9HcTSbC/ySYGMWCg7oXgP/YgKC
         W4nEJUM+aHDMSZU5SkWJTpRUuuEYgv3dz0srEezCZeEI7RtJgXoH/E+YEiTqCGQWiXGe
         D3jpLMIUNcObIcnWaxh/hTeLqOLzQi7rzc5bxT9oEkZtiD1n2smQWqaf6E7/WXCkPJlt
         7280A5lq0KBdqgCeOTbc+yy4CyzzthquoO/zbZ8+UAZ+oh4ozymKZghjYZzRk6O2dzRT
         LBEnU2ZD7FCBFgsrjJqig6h0LsXJOeuC+S524ElLATPm3Q2mXDQarJY3769LFxpQT5Po
         +bfA==
X-Gm-Message-State: AGi0PuYx9uQk+lehLJpJV5wAdEYozi+5UUOlzGplBzXW4Fsad0MJOCWJ
        fxY/zhXYUogea1+dPNglvmKmLihJtkfeHg==
X-Google-Smtp-Source: APiQypK/HHJ+53VYSbhbD1Cy5RiLdfCxBQ1M2yWeksRLKo7+6e7/6/I7ZxAyLvY8mhYjW8KKuqdVVw==
X-Received: by 2002:a1c:80c3:: with SMTP id b186mr7414149wmd.117.1587503755790;
        Tue, 21 Apr 2020 14:15:55 -0700 (PDT)
Received: from t2b3 ([5.56.225.192])
        by smtp.gmail.com with ESMTPSA id s9sm5617341wrg.27.2020.04.21.14.15.54
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:15:55 -0700 (PDT)
Date:   Tue, 21 Apr 2020 23:15:52 +0200
From:   "Tobias S. Predel" <tobias.predel@gmail.com>
To:     linux-wireless@vger.kernel.org
Subject: rtw88: BUG: scheduling while atomic: kworker/u16:0/33416/0x00000002
Message-ID: <20200421211552.GA36171@t2b3>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm using linux-next 20200421 on Arch Linux=20
with rtw88 for=20

$ lspci -k

Subsystem: Hewlett-Packard Company Realtek RTL8822BE 802.11ac 2 =D7 2 Wi-Fi=
 + Bluetooth 4.2 Combo Adapter (MU-MIMO supported)
	Kernel driver in use: rtw_pci
	Kernel modules: rtwpci

and

$ ethtool -i wlp2s0

driver: rtw_pci
version: 5.7.0-rc2-next-20200421-1-next-
firmware-version: N/A
expansion-rom-version:
bus-info: 0000:02:00.0
supports-statistics: yes
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no

and I'm experiencing this

$ dmesg

[26628.497854] rtw_pci 0000:02:00.0: firmware failed to restore hardware se=
tting
[26663.488394] rtw_pci 0000:02:00.0: firmware failed to restore hardware se=
tting
[26973.646044] rtw_pci 0000:02:00.0: firmware failed to restore hardware se=
tting
[26981.542221] rtw_pci 0000:02:00.0: firmware failed to restore hardware se=
tting
[27047.668256] rtw_pci 0000:02:00.0: firmware failed to restore hardware se=
tting
[27095.665971] rtw_pci 0000:02:00.0: firmware failed to restore hardware se=
tting
[27131.504263] rtw_pci 0000:02:00.0: firmware failed to restore hardware se=
tting

[and a lot more of this messages]

and following non-fatal bug

[28125.482259] BUG: scheduling while atomic: kworker/u16:0/33416/0x00000002
[28125.482266] Modules linked in: nfnetlink xt_conntrack xt_tcpudp wireguar=
d curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64 libbl=
ake2s blake2s_x86_64 ip6_udp_tunnel udp_tunnel libcurve25519_generic libcha=
cha libblake2s_generic iptable_security iptable_raw iptable_mangle iptable_=
nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c dm_crypt dm=
_mod rfcomm fuse 8021q garp mrp stp llc ccm ebtable_filter ebtables ip6tabl=
e_filter ip6_tables iptable_filter cmac algif_hash algif_skcipher af_alg sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 bnep x86_pkg_temp_thermal btusb intel_powerclamp joydev btrtl btbcm btinte=
l coretemp mousedev kvm_intel bluetooth uas kvm hid_multitouch usb_storage =
ecdh_generic iTCO_wdt uvcvideo ecc mei_hdcp hid_generic iTCO_vendor_support=
 hp_wmi videobuf2_vmalloc irqbypass intel_rapl_msr usbhid sparse_keymap wmi=
_bmof snd_soc_skl videobuf2_memops videobuf2_v4l2 videobuf2_common crct10di=
f_pclmul videodev
[28125.482336]  snd_soc_sst_ipc crc32_pclmul snd_soc_sst_dsp ghash_clmulni_=
intel snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi mc aesni_intel=
 snd_soc_core crypto_simd snd_compress ac97_bus rtwpci cryptd snd_pcm_dmaen=
gine glue_helper nls_iso8859_1 rtw88 snd_hda_intel intel_cstate nls_cp437 s=
nd_intel_dspcfg intel_uncore vfat mac80211 fat i915 snd_hda_codec intel_rap=
l_perf snd_hda_core snd_hwdep snd_pcm snd_timer pcspkr psmouse snd input_le=
ds i2c_i801 cfg80211 soundcore r8169 realtek i2c_algo_bit rfkill libarc4 li=
bphy drm_kms_helper mei_me cec mei rc_core intel_lpss_pci intel_lpss intel_=
gtt idma64 syscopyarea sysfillrect processor_thermal_device intel_xhci_usb_=
role_switch intel_pch_thermal sysimgblt roles intel_rapl_common fb_sys_fops=
 intel_soc_dts_iosf i2c_hid tpm_crb wmi battery hid tpm_tis tpm_tis_core tp=
m int3400_thermal hp_accel int3403_thermal int340x_thermal_zone acpi_therma=
l_rel lis3lv02d hp_wireless evdev rng_core ac mac_hid drm crypto_user agpga=
rt ip_tables x_tables ext4
[28125.482418]  crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core s=
erio_raw atkbd libps2 xhci_pci crc32c_intel xhci_hcd rtsx_pci i8042 serio
[28125.482436] Preemption disabled at:
[28125.482443] [<0000000000000000>] 0x0
[28125.482452] CPU: 5 PID: 33416 Comm: kworker/u16:0 Tainted: G        W   =
      5.7.0-rc2-next-20200421-1-next-git #1
[28125.482456] Hardware name: HP HP ProBook 430 G5/8377, BIOS Q85 Ver. 01.0=
9.01 10/15/2019
[28125.482477] Workqueue: phy0 rtw_watch_dog_work [rtw88]
[28125.482481] Call Trace:
[28125.482495]  dump_stack+0x66/0x90
[28125.482505]  __schedule_bug.cold+0x8e/0x9b
[28125.482512]  __schedule+0x686/0x7b0
[28125.482520]  ? _raw_spin_unlock_irqrestore+0x20/0x40
[28125.482525]  schedule+0x46/0xf0
[28125.482531]  schedule_hrtimeout_range_clock+0xa5/0x120
[28125.482540]  ? hrtimer_init_sleeper+0xa0/0xa0
[28125.482546]  usleep_range+0x67/0x90
[28125.482568]  rtw_fw_send_h2c_command+0xe0/0x1a0 [rtw88]
[28125.482590]  rtw_fw_set_pwr_mode+0x95/0xb0 [rtw88]
[28125.482610]  rtw_enter_lps+0xa1/0x100 [rtw88]
[28125.482625]  rtw_watch_dog_work+0x21c/0x230 [rtw88]
[28125.482635]  process_one_work+0x1da/0x3d0
[28125.482643]  worker_thread+0x4a/0x3d0
[28125.482651]  kthread+0x122/0x160
[28125.482658]  ? process_one_work+0x3d0/0x3d0
[28125.482663]  ? kthread_park+0x90/0x90
[28125.482670]  ret_from_fork+0x1f/0x40
[28169.561821] rtw_pci 0000:02:00.0: firmware failed to restore hardware se=
tting
[28231.427898] rtw_pci 0000:02:00.0: firmware failed to restore hardware se=
tting
[28299.480530] rtw_pci 0000:02:00.0: firmware failed to restore hardware se=
tting

Maybe that's interesting for you.

Kind regards,
Tobias Predel
--=20
Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.
