Return-Path: <linux-wireless+bounces-6260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151B38A3183
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 16:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3822B1C2197E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0A214533D;
	Fri, 12 Apr 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqJ+eIBr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E861420BC
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933405; cv=none; b=nG4EaW7g7BT1jOyaVRjPoPBeLuZk1ntm4kwOYiAKNa8S2XOFGx82OI2k8xy5QGz5HLnxJmpug8auYnJCjB09utvsrlG5y9BeZLlGV9IIWkmoJil/RKr3hYhnTdDa0I1lzLth6uehxOJJBBWZvrf4qhcn9lGz7f6TkVhol7X3uBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933405; c=relaxed/simple;
	bh=vnADFdz2mR7nUYdiU1XNFGdfX1kJY1Q0L7LwX6756Z4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ebfDiyul1/ULEh0h9ykZtdrdRhNDPz8bpMVwdsrghqKY5Nli7+fVJNjLqORjW64NnAW+HeZ/pCeDuK3Gx1Z2A0LpLJuwcaeB/xLPn+0z7MsVXEAg6XsFV9YdTYgVEs1q9+EE1gm4fgkLub6APCZkMTH04hgeUNjHCFWmjCFgX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqJ+eIBr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34388753650so445584f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712933402; x=1713538202; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=srLEC2dE9vyZoKIORjfFHXAEBSsiIKv7ujXCrfpzv+I=;
        b=IqJ+eIBrgOz6PMC3rGfGt+MUB9o/wheVmE4rGCHS3FyTL2zLYxH8SzzA1VhEfayObK
         TcM4Ci/BmfEWJPdJ7qptzaGi87I+WLhYLBfec1qD9YrAVgPuiDaOP0bFKH3PF0Hq8fl6
         1pIJ014GRjybcjXH3SUQ8EjwNmYgcnBxYN5LOt8sP02Ps3Voxu3mJF0NzHoYBJc7cFXN
         o/k7Dhd2bz5nTkY+nTYyjv1wOHaoBsE2lSZ7gSzquidiSPsd2KFFCAjUstOPZ3vQOMy0
         Kg+UmLpVTWGihsIYR5m2AF6L22wCeVsk8owftLA4rDeJ/Jo3su6DwES8tH2iJngeoO/l
         On1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712933402; x=1713538202;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=srLEC2dE9vyZoKIORjfFHXAEBSsiIKv7ujXCrfpzv+I=;
        b=uZOa1bxBFZ+iLhXD1e0+m64eB+qMjfd5UpG0ZA08MBif3buqW4KjJPd4zp4mbk2dgv
         VFJ3gNcwqQFU+u48oo8duMna1Cv9Hp/YRhk0VMN2j3/rodresyv3JDDKDEoGU1e5cm1E
         6aTQyt8AINjXHioJVD7UokIWiHLiqfUu39scpBn2QAULxwkCfUUMO0gyeTR4H34B14Nd
         0lIHtkbU20YZ4TJ+uoNwrcdVtccMDTcwfs/o/44r9lxmB1HQmFMjKshN/W40MdvOsY51
         evmifJc/QSfWX0vMpfEpUwe8MB6yYzAhVos4PdbCB8Jb+Ndkmzbhij1rzQ0R3NiOffja
         G4pg==
X-Gm-Message-State: AOJu0Yz452wIHvHPwt2AYT+2uH8kmsQKjkpA94tWlsU7SvPYsUDBxEhB
	ToLLihisk/xguqGbUwNsjaxCexzt0cl3TQcStu1U5vhNN10M2jAZu8cSGintrJXjvMoy5iGPNbC
	7jFO32q8Ug1B5JlAkgTRJ9Lh3QJCoDcYq
X-Google-Smtp-Source: AGHT+IFpzx1xZUAWzkCLs6h5ze6rYlLptlIudN2HtCQ61m0XT6dVGxhl7QJuKfwhKI1jEwlIypArIkx+ndwQMbXzgLY=
X-Received: by 2002:a5d:6d84:0:b0:347:1cb4:f94 with SMTP id
 l4-20020a5d6d84000000b003471cb40f94mr1336935wrs.4.1712933401675; Fri, 12 Apr
 2024 07:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gabriel Tisan <gabriel.tisan@gmail.com>
Date: Fri, 12 Apr 2024 16:49:50 +0200
Message-ID: <CAD9ZU8Coc0r3AiWz+rA4eoXuDQBBCAMY0J4w5x-Pa1JEpbmdWA@mail.gmail.com>
Subject: rtw88: rtw8822cu (LM842) on Raspi4 -> driver get stucked while
 sending data
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi !

I want to use LM842 USB stick on a Raspberry Pi 4 using Raspberry Pi OS
(64-bit Debian Bookworm with kernel 6.6.20), but the driver get stucked.

The LM842 on Raspi is used as AP. Here I show how I created the AP:
sudo nmcli con add type wifi ifname wlan1 mode ap con-name TEST-AP
ssid TEST autoconnect false
sudo nmcli con modify TEST-AP 802-11-wireless.band bg
sudo nmcli con modify TEST-AP 802-11-wireless.channel 6
sudo nmcli con modify TEST-AP 802-11-wireless.cloned-mac-address
00:12:34:56:78:9a
sudo nmcli con modify TEST-AP ipv4.method shared ipv4.address 192.168.244.1/24
sudo nmcli con modify TEST-AP ipv6.method disabled
sudo nmcli con modify TEST-AP wifi-sec.key-mgmt wpa-psk
sudo nmcli con modify TEST-AP wifi-sec.psk "mypassword"
sudo nmcli con up TEST-AP

Here is the kernel log with 2 kernel traces:
============plug-in LM842 USB stick ===========
Apr 12 14:36:33 lite-61 kernel: usb 1-1.3: new high-speed USB device
number 3 using xhci_hcd
Apr 12 14:36:33 lite-61 kernel: usb 1-1.3: New USB device found,
idVendor=0bda, idProduct=c82c, bcdDevice= 0.00
Apr 12 14:36:33 lite-61 kernel: usb 1-1.3: New USB device strings:
Mfr=1, Product=2, SerialNumber=3
Apr 12 14:36:33 lite-61 kernel: usb 1-1.3: Product: 802.11ac NIC
Apr 12 14:36:33 lite-61 kernel: usb 1-1.3: Manufacturer: Realtek
Apr 12 14:36:33 lite-61 kernel: usb 1-1.3: SerialNumber: 123456
Apr 12 14:36:33 lite-61 kernel: usbcore: registered new interface driver btusb
Apr 12 14:36:33 lite-61 kernel: Bluetooth: hci1: RTL: examining
hci_ver=0a hci_rev=000c lmp_ver=0a lmp_subver=8822
Apr 12 14:36:33 lite-61 kernel: Bluetooth: hci1: RTL: rom_version
status=0 version=3
Apr 12 14:36:33 lite-61 kernel: Bluetooth: hci1: RTL: loading
rtl_bt/rtl8822cu_fw.bin
Apr 12 14:36:33 lite-61 kernel: Bluetooth: hci1: RTL: loading
rtl_bt/rtl8822cu_config.bin
Apr 12 14:36:33 lite-61 kernel: Bluetooth: hci1: RTL: cfg_sz 6, total sz 35990
Apr 12 14:36:33 lite-61 kernel: rtw_8822cu 1-1.3:1.2: WOW Firmware
version 9.9.4, H2C version 15
Apr 12 14:36:33 lite-61 kernel: rtw_8822cu 1-1.3:1.2: Firmware version
9.9.15, H2C version 15
Apr 12 14:36:34 lite-61 kernel: Bluetooth: hci1: RTL: fw version 0x0cc6d2e3
Apr 12 14:36:34 lite-61 kernel: Bluetooth: MGMT ver 1.22
Apr 12 14:36:34 lite-61 kernel: usbcore: registered new interface
driver rtw_8822cu
===========AP is started, client connect to
AP===============================================================
===========send some test data with iperf3 30-45 min (UDP/TCP test
data)=====================================
===========iperf3 -c 192.168.244.1 -u -i 1 -t 600 -O 5  || iperf3 -c
192.168.244.1 -i 1 -t 600 -O 5==========
Apr 12 14:41:01 lite-61 kernel: rtw_8822cu 1-1.3:1.2: timed out to flush queue 3
Apr 12 14:41:01 lite-61 kernel: rtw_8822cu 1-1.3:1.2: timed out to flush queue 3

Apr 12 14:57:04 lite-61 kernel: rtw_8822cu 1-1.3:1.2: timed out to flush queue 3
Apr 12 14:57:04 lite-61 kernel: rtw_8822cu 1-1.3:1.2: timed out to flush queue 3
Apr 12 14:57:15 lite-61 kernel: rtw_8822cu 1-1.3:1.2: timed out to flush queue 3
Apr 12 15:07:15 lite-61 kernel: rtw_8822cu 1-1.3:1.2: timed out to flush queue 3
=========here it get stalled : the connection is broken=========
=========AP is not anymore visible==============================
Apr 12 15:17:19 lite-61 kernel: rtw_8822cu 1-1.3:1.2: timed out to flush queue 3
Apr 12 15:17:19 lite-61 kernel: rtw_8822cu 1-1.3:1.2: timed out to flush queue 3
Apr 12 15:17:21 lite-61 kernel: rtw_8822cu 1-1.3:1.2: timed out to flush queue 3
Apr 12 15:17:24 lite-61 kernel: rtw_8822cu 1-1.3:1.2: error beacon valid
Apr 12 15:17:24 lite-61 kernel: rtw_8822cu 1-1.3:1.2: failed to
download drv rsvd page
=============shut down AP in Raspi(sudo nmcli con down TEST-AP)===========
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: timed out to flush queue 3
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: timed out to flush queue 3
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: timed out to flush queue 3
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: error beacon valid
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: failed to
download rsvd page
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: failed to
download firmware
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: leave idle state failed
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: failed to send h2c command
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: failed to send h2c command
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: failed to send h2c command
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: failed to leave ips state
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: failed to leave idle state
Apr 12 15:23:47 lite-61 kernel: ------------[ cut here ]------------
Apr 12 15:23:47 lite-61 kernel: WARNING: CPU: 0 PID: 513 at
net/wireless/core.c:1518 cfg80211_netdev_notifier_call+0x3a4/0x558
[cfg80211]
Apr 12 15:23:47 lite-61 kernel: Modules linked in: ctr ccm
nft_reject_ipv4 nf_reject_ipv4 nft_reject nft_ct nft_masq
nft_chain_nat nf_tables nfnetlink nf_nat_h323 nf_conntrack_h323
nf_nat_pptp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip
nf_conntrack_sip nf_nat_irc nf_conntrack_irc nf_nat_ftp
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
rtw88_8822cu rtw88_8822c rtw88_usb rtw88_core mac80211 btusb btrtl
btintel libarc4 cmac algif_hash aes_arm64 aes_generic algif_skcipher
af_alg bnep brcmfmac_wcc brcmfmac brcmutil cfg80211 hci_uart btbcm
bluetooth vc4 v3d gpu_sched drm_shmem_helper snd_soc_hdmi_codec
raspberrypi_hwmon drm_display_helper ecdh_generic cec ecc
drm_dma_helper rpivid_hevc(C) bcm2835_v4l2(C) bcm2835_codec(C)
bcm2835_isp(C) binfmt_misc drm_kms_helper rfkill bcm2835_mmal_vchiq(C)
v4l2_mem2mem snd_soc_core videobuf2_vmalloc libaes
videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 snd_compress
videodev snd_pcm_dmaengine snd_bcm2835(C) snd_pcm videobuf2_common
vc_sm_cma(C) mc raspberrypi_gpiomem
Apr 12 15:23:47 lite-61 kernel:  snd_timer snd nvmem_rmem
uio_pdrv_genirq uio drm fuse dm_mod drm_panel_orientation_quirks
backlight ip_tables x_tables ipv6 i2c_brcmstb
Apr 12 15:23:47 lite-61 kernel: CPU: 0 PID: 513 Comm: NetworkManager
Tainted: G         C         6.6.20+rpt-rpi-v8 #1  Debian
1:6.6.20-1+rpt1
Apr 12 15:23:47 lite-61 kernel: Hardware name: Raspberry Pi 4 Model B
Rev 1.5 (DT)
Apr 12 15:23:47 lite-61 kernel: pstate: 60000005 (nZCv daif -PAN -UAO
-TCO -DIT -SSBS BTYPE=--)
Apr 12 15:23:47 lite-61 kernel: pc :
cfg80211_netdev_notifier_call+0x3a4/0x558 [cfg80211]
Apr 12 15:23:47 lite-61 kernel: lr :
cfg80211_netdev_notifier_call+0x230/0x558 [cfg80211]
Apr 12 15:23:47 lite-61 kernel: sp : ffffffc080ba32e0
Apr 12 15:23:47 lite-61 kernel: x29: ffffffc080ba32e0 x28:
ffffffec109ec868 x27: ffffffec10974300
Apr 12 15:23:47 lite-61 kernel: x26: ffffffec8b22d850 x25:
ffffffec8ae94008 x24: ffffffc080ba35c0
Apr 12 15:23:47 lite-61 kernel: x23: 0000000000000002 x22:
ffffff8036be0000 x21: ffffff8036be03c0
Apr 12 15:23:47 lite-61 kernel: x20: ffffff8034ca8000 x19:
ffffff8034ca8950 x18: 0000000000000000
Apr 12 15:23:47 lite-61 kernel: x17: ffffff93b02ba000 x16:
ffffffec8a8fd448 x15: 0000000000070014
Apr 12 15:23:47 lite-61 kernel: x14: ffffffec8b54ef60 x13:
0000000000000010 x12: 0000001000001780
Apr 12 15:23:47 lite-61 kernel: x11: 0000000000000000 x10:
0000000000000000 x9 : ffffffec10974530
Apr 12 15:23:47 lite-61 kernel: x8 : ffffffc080ba32c8 x7 :
ffffff80051d0000 x6 : 0000000000000000
Apr 12 15:23:47 lite-61 kernel: x5 : 0000000000000080 x4 :
0000000000000000 x3 : 0000000000000000
Apr 12 15:23:47 lite-61 kernel: x2 : ffffff8004049ec0 x1 :
ffffff8034ca8950 x0 : 0000000000000000
Apr 12 15:23:47 lite-61 kernel: Call trace:
Apr 12 15:23:47 lite-61 kernel:
cfg80211_netdev_notifier_call+0x3a4/0x558 [cfg80211]
Apr 12 15:23:47 lite-61 kernel:  notifier_call_chain+0x78/0x148
Apr 12 15:23:47 lite-61 kernel:  raw_notifier_call_chain+0x20/0x38
Apr 12 15:23:47 lite-61 kernel:  call_netdevice_notifiers_info+0x60/0xb8
Apr 12 15:23:47 lite-61 kernel:  __dev_notify_flags+0xbc/0xf0
Apr 12 15:23:47 lite-61 kernel:  dev_change_flags+0x5c/0x80
Apr 12 15:23:47 lite-61 kernel:  do_setlink+0x28c/0xef8
Apr 12 15:23:47 lite-61 kernel:  __rtnl_newlink+0x520/0x898
Apr 12 15:23:47 lite-61 kernel:  rtnl_newlink+0x58/0x90
Apr 12 15:23:47 lite-61 kernel:  rtnetlink_rcv_msg+0x134/0x390
Apr 12 15:23:47 lite-61 kernel:  netlink_rcv_skb+0x64/0x138
Apr 12 15:23:47 lite-61 kernel:  rtnetlink_rcv+0x20/0x38
Apr 12 15:23:47 lite-61 kernel:  netlink_unicast+0x2fc/0x370
Apr 12 15:23:47 lite-61 kernel:  netlink_sendmsg+0x1c4/0x448
Apr 12 15:23:47 lite-61 kernel:  __sock_sendmsg+0x64/0xc0
Apr 12 15:23:47 lite-61 kernel:  ____sys_sendmsg+0x260/0x298
Apr 12 15:23:47 lite-61 kernel:  ___sys_sendmsg+0xb4/0x110
Apr 12 15:23:47 lite-61 kernel:  __sys_sendmsg+0x8c/0xf0
Apr 12 15:23:47 lite-61 kernel:  __arm64_sys_sendmsg+0x2c/0x40
Apr 12 15:23:47 lite-61 kernel:  invoke_syscall+0x50/0x128
Apr 12 15:23:47 lite-61 kernel:  el0_svc_common.constprop.0+0x48/0xf0
Apr 12 15:23:47 lite-61 kernel:  do_el0_svc+0x24/0x38
Apr 12 15:23:47 lite-61 kernel:  el0_svc+0x40/0xe8
Apr 12 15:23:47 lite-61 kernel:  el0t_64_sync_handler+0x100/0x130
Apr 12 15:23:47 lite-61 kernel:  el0t_64_sync+0x190/0x198
Apr 12 15:23:47 lite-61 kernel: ---[ end trace 0000000000000000 ]---
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: error beacon valid
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: failed to
download rsvd page
Apr 12 15:23:47 lite-61 kernel: rtw_8822cu 1-1.3:1.2: failed to
download firmware
Apr 12 15:23:48 lite-61 kernel: warning: `iwconfig' uses wireless
extensions which will stop working for Wi-Fi 7 hardware; use nl80211
=============plug-out LM842 USB stick ===========
Apr 12 15:25:09 lite-61 kernel: usb 1-1.3: USB disconnect, device number 3
Apr 12 15:25:09 lite-61 kernel: ------------[ cut here ]------------
Apr 12 15:25:09 lite-61 kernel: Have pending ack frames!
Apr 12 15:25:09 lite-61 kernel: WARNING: CPU: 0 PID: 3332 at
net/mac80211/main.c:1510 ieee80211_free_ack_frame+0x5c/0x88 [mac80211]
Apr 12 15:25:09 lite-61 kernel: Modules linked in: ctr ccm
nft_reject_ipv4 nf_reject_ipv4 nft_reject nft_ct nft_masq
nft_chain_nat nf_tables nfnetlink nf_nat_h323 nf_conntrack_h323
nf_nat_pptp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip
nf_conntrack_sip nf_nat_irc nf_conntrack_irc nf_nat_ftp
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
rtw88_8822cu rtw88_8822c rtw88_usb rtw88_core mac80211 btusb btrtl
btintel libarc4 cmac algif_hash aes_arm64 aes_generic algif_skcipher
af_alg bnep brcmfmac_wcc brcmfmac brcmutil cfg80211 hci_uart btbcm
bluetooth vc4 v3d gpu_sched drm_shmem_helper snd_soc_hdmi_codec
raspberrypi_hwmon drm_display_helper ecdh_generic cec ecc
drm_dma_helper rpivid_hevc(C) bcm2835_v4l2(C) bcm2835_codec(C)
bcm2835_isp(C) binfmt_misc drm_kms_helper rfkill bcm2835_mmal_vchiq(C)
v4l2_mem2mem snd_soc_core videobuf2_vmalloc libaes
videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 snd_compress
videodev snd_pcm_dmaengine snd_bcm2835(C) snd_pcm videobuf2_common
vc_sm_cma(C) mc raspberrypi_gpiomem
Apr 12 15:25:09 lite-61 kernel:  snd_timer snd nvmem_rmem
uio_pdrv_genirq uio drm fuse dm_mod drm_panel_orientation_quirks
backlight ip_tables x_tables ipv6 i2c_brcmstb
Apr 12 15:25:09 lite-61 kernel: CPU: 0 PID: 3332 Comm: kworker/0:1
Tainted: G        WC         6.6.20+rpt-rpi-v8 #1  Debian
1:6.6.20-1+rpt1
Apr 12 15:25:09 lite-61 kernel: Hardware name: Raspberry Pi 4 Model B
Rev 1.5 (DT)
Apr 12 15:25:09 lite-61 kernel: Workqueue: usb_hub_wq hub_event
Apr 12 15:25:09 lite-61 kernel: pstate: 60000005 (nZCv daif -PAN -UAO
-TCO -DIT -SSBS BTYPE=--)
Apr 12 15:25:09 lite-61 kernel: pc :
ieee80211_free_ack_frame+0x5c/0x88 [mac80211]
Apr 12 15:25:09 lite-61 kernel: lr :
ieee80211_free_ack_frame+0x5c/0x88 [mac80211]
Apr 12 15:25:09 lite-61 kernel: sp : ffffffc0872bb910
Apr 12 15:25:09 lite-61 kernel: x29: ffffffc0872bb910 x28:
0000000000000002 x27: ffffff80027fe000
Apr 12 15:25:09 lite-61 kernel: x26: ffffff800315f000 x25:
ffffff800315f0a8 x24: ffffff8036be1fa0
Apr 12 15:25:09 lite-61 kernel: x23: 0000000000000000 x22:
000000007fffffff x21: ffffffec10b2e480
Apr 12 15:25:09 lite-61 kernel: x20: 0000000000000000 x19:
ffffff80047d5f00 x18: ffffffc080d2bc78
Apr 12 15:25:09 lite-61 kernel: x17: ffffffec8b382740 x16:
ffffffec89c8efa0 x15: 0000000000000040
Apr 12 15:25:09 lite-61 kernel: x14: ffffff8036be1fa0 x13:
2173656d61726620 x12: 6b636120676e6964
Apr 12 15:25:09 lite-61 kernel: x11: fffffffffffe0000 x10:
ffffffec8b2a3708 x9 : ffffffec89d0946c
Apr 12 15:25:09 lite-61 kernel: x8 : 00000000ffffefff x7 :
ffffffec8b2a3708 x6 : 80000000fffff000
Apr 12 15:25:09 lite-61 kernel: x5 : ffffff803b150d48 x4 :
0000000000000000 x3 : 0000000000000027
Apr 12 15:25:09 lite-61 kernel: x2 : 0000000000000000 x1 :
0000000000000000 x0 : ffffff8002f8dc40
Apr 12 15:25:09 lite-61 kernel: Call trace:
Apr 12 15:25:09 lite-61 kernel:  ieee80211_free_ack_frame+0x5c/0x88 [mac80211]
Apr 12 15:25:09 lite-61 kernel:  idr_for_each+0x6c/0xf0
Apr 12 15:25:09 lite-61 kernel:  ieee80211_free_hw+0x48/0xc0 [mac80211]
Apr 12 15:25:09 lite-61 kernel:  rtw_usb_disconnect+0xc4/0x108 [rtw88_usb]
Apr 12 15:25:09 lite-61 kernel:  usb_unbind_interface+0x80/0x278
Apr 12 15:25:09 lite-61 kernel:  device_remove+0x78/0x90
Apr 12 15:25:09 lite-61 kernel:  device_release_driver_internal+0x1dc/0x238
Apr 12 15:25:09 lite-61 kernel:  device_release_driver+0x20/0x38
Apr 12 15:25:09 lite-61 kernel:  bus_remove_device+0xd4/0x120
Apr 12 15:25:09 lite-61 kernel:  device_del+0x164/0x430
Apr 12 15:25:09 lite-61 kernel:  usb_disable_device+0xdc/0x1c0
Apr 12 15:25:09 lite-61 kernel:  usb_disconnect+0xe0/0x2b8
Apr 12 15:25:09 lite-61 kernel:  hub_event+0x970/0x1540
Apr 12 15:25:09 lite-61 kernel:  process_one_work+0x148/0x3b8
Apr 12 15:25:09 lite-61 kernel:  worker_thread+0x32c/0x450
Apr 12 15:25:09 lite-61 kernel:  kthread+0x11c/0x128
Apr 12 15:25:09 lite-61 kernel:  ret_from_fork+0x10/0x20
Apr 12 15:25:09 lite-61 kernel: ---[ end trace 0000000000000000 ]---

The last kernel trace happens even if I don't send any data.
Only plug-in the stick , connect to AP, wait some minutes,
disconnect from AP and plug-out LM842.

Any ideas what might be the cause of this ?

Regards,
Gabriel

