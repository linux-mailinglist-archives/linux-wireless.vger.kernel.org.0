Return-Path: <linux-wireless+bounces-21849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDD1A9733D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 19:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4327AB64E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6C29616D;
	Tue, 22 Apr 2025 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5quNiPT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BF72900AC;
	Tue, 22 Apr 2025 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341324; cv=none; b=XvjP1HsKvo7/O70BT+cgoPFYS/eBy4xMBMYEZYTirzOmKuuvRQLqzxLVOqLWv9S2vOLOj0z9s/hL8DQBm6NRBrKKGs3wQVU/nfqe7S3SM8pWB6aE3zrjBxieROVYxAdY4OxaDMjZCFuHpuyloeoF6s5N/XWpC42jG3bVWdACnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341324; c=relaxed/simple;
	bh=tz697PeimqwwKDXfJs0BPD/016iKLpVR0s6NEmZvSyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pLjoQEF7DH1F//noj5R9TtOCvLiS52aj67S9cY6tWLbToP8VtJZ7jwvTANCaeZbH4f+DqNrvKuM3c5BcqPOkV5oWd0vrx/2XobKWrVYQOttwE+Q1TwnTvgbv6RkzLGhygblrs6HfxoZyBBnO0nntVdfmnT822aPoLboLPM1Ruvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5quNiPT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so8347499a12.3;
        Tue, 22 Apr 2025 10:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745341321; x=1745946121; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmsdnMqf5xlO7k6+QnwIpLTJU73C+ck4BW6kSugTHUQ=;
        b=A5quNiPTKKdWl9uN7QRJrJaNsvP7SpGsTVc3ei/Wk+bYUIE4awrtfnD1sD/dANn7Sh
         EjxVmxKO7IGWtKDepICkzchIcU9utQqZHOk/+SPBc311gUUozjL1XBxrP4qWOPjiaZE6
         6RhRsLWjCVg9QlhPP3VRRZ+yOlzBkcM2OTcelJVOJ0jDlrNYEPbEeGWkkQi3zJaTPVsI
         7d5Re7ypbzQCTx7WRiZrtSWNsddcv1T55fpwz0KAeMriWTAvAAzDRdq+vzo4U6SnjZIk
         g+cGujD1E/Smpc4dvDt58OjfCbUGe4E0Lo0n7SlYfzkqdQGcGFqNrKxtnmA9xobJJXBG
         LJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745341321; x=1745946121;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmsdnMqf5xlO7k6+QnwIpLTJU73C+ck4BW6kSugTHUQ=;
        b=GWzo6rZ/eCfjimaVKHEFdcBoOaexVZWoZn9SxYhBU6xElDYtugwXCW8fD2a9m8q0cG
         eSh5nieZ5L3YgZznfY+yTo6TJjVV7LJDOIIw01k+H3Y0NEuOdcKsD/nKkV2RQhimO7S+
         bVTwdB7b+hApB7tGAq36yeDVG0mkB5TCJUkpUKbug+ig0EtPXodzpfqlQgPTP4XSP77Y
         KupxSBRz5gajDFFq64KRm2wMFDdSa5etRG0oWQageeABZWaBXKeQHHuWYVwvIUyREFBx
         yaJQyvCI//lPtEmuw5k7cRyKemC2Ie2g92uArOPNWDOu4YpjJvOO70/kwZENUXllJvp/
         MBdA==
X-Forwarded-Encrypted: i=1; AJvYcCUN6W91RyiSNns4MrpxkghO4QDFCC3bJUHn0htn7kjVcaiZOL/6qAKlG/PbNRoFumoNbzH4YOxyb26Av5DXUMY=@vger.kernel.org, AJvYcCW82dRb2KzuNsl+1cmLJBR5QFMfLcTB62PnOCVFCM7ejloapt+giSaahalzT2Osq+V5bpgGovo42k0gb1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlgQVGNeJugSc1cvSU1lUAHIqpQAkoE05ld32rmwfm51JUWRi
	+htnrAWyDhWb4WaupdVnoIlVb8AiLag03OboXiVZWICoxVmHh26wa/X1CbMQlQMOpmeK9LZ7l+s
	kF7ORbfihpwM6TlpwVNDJNddecJQ=
X-Gm-Gg: ASbGncum623PhtD+0pvTwRqJD20YeNacFKJ+n+CekJDeOQYgxQ+fAL5G6cjUwfy0JUo
	007wOzUd12HjEezDrkV7+wdpW146rl8EENgf9UoBUfcRDXoZdKNhifUGxX4stsGmHPdBvdgLW1s
	fxPAKgxaqITqQ6dlNwaQv9bzW2tZt6TdmRGbuT
X-Google-Smtp-Source: AGHT+IHd2N9D1ZrJXInnFHsaJpiRrGdvZOEoz2WndD7gmxPUbmQCpZ/3gUmK1m/ge8Qp9ZnPcHOvzzMo3WOgXfkexnE=
X-Received: by 2002:a17:906:dc90:b0:ac6:e33e:9ef8 with SMTP id
 a640c23a62f3a-acb74ad97bamr1143411466b.2.1745341320895; Tue, 22 Apr 2025
 10:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABTDG886JyTFu0dUWgZAT89Dmxjm78VNk0TXcgf=1yABBRN5XQ@mail.gmail.com>
In-Reply-To: <CABTDG886JyTFu0dUWgZAT89Dmxjm78VNk0TXcgf=1yABBRN5XQ@mail.gmail.com>
From: Hank Barta <hbarta@gmail.com>
Date: Tue, 22 Apr 2025 12:01:49 -0500
X-Gm-Features: ATxdqUHnhdxkjiue3m4U7BvSmKftALxNk06SRc-rmx9Be7QM4KMDNVlJDk1pDLs
Message-ID: <CABTDG8-A7A7WJUSHio85vVPCKM02nuwcYPhbYju6bQacbteQUg@mail.gmail.com>
Subject: Re: Stack dump, Pi 4B, Debian Bookworm (not RpiOS)
To: arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I should have mentioned that I'm also running Tailscale and Docker on
this host so there's a lot of "networking" going on. Following a
reboot, I see what I think is the same stack dump. In addition there
are a lot of messages on the console like

[  242.666852] ieee80211 phy0: brcmf_p2p_send_action_frame: Unknown
Frame: category 0x5, action 0x1
[  251.665022] ieee80211 phy0: brcmf_p2p_send_action_frame: Unknown
Frame: category 0x5, action 0x1
[  260.716149] ieee80211 phy0: brcmf_p2p_send_action_frame: Unknown
Frame: category 0x5, action 0x1
[  269.670253] ieee80211 phy0: brcmf_p2p_send_action_frame: Unknown
Frame: category 0x5, action 0x1
[  278.673598] ieee80211 phy0: brcmf_p2p_send_action_frame: Unknown
Frame: category 0x5, action 0x1

In spite of that, WiFi and Ethernet seem to be working.

best,

On Tue, Apr 22, 2025 at 11:52=E2=80=AFAM Hank Barta <hbarta@gmail.com> wrot=
e:
>
> Good morning, I encountered the following while attempting to connect
> to a WiFi AP using iwd. Another user on the Raspberry Pi IRC
> (ukleinek) suggested I forward that to this group.
>
> hbarta@olive:~/MkDocs/my-notes/docs/hosts/Raspberry-Pi/4/allegan$ cat
> iwd.crash.txt
> [565142.844103] NET: Registered PF_ALG protocol family
> [565142.895121] alg: No test for hmac(md4) (hmac(md4-generic))
> [565255.271588] ------------[ cut here ]------------
> [565255.278557] memcpy: detected field-spanning write (size 72) of
> single field "&mgmt_frame->u" at
> drivers/net/wireless/broadcom/brcm80211/brcmfm
> ac/p2p.c:1469 (size 26)
> [565255.295948] WARNING: CPU: 1 PID: 1135280 at
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1469
> brcmf_p2p_notify_action_frame_rx+0x30c
> /0x440 [brcmfmac]
> [565255.312770] Modules linked in: ghash_generic ghash_ce gf128mul gcm
> ccm algif_aead des_generic libdes ecb algif_skcipher md4 algif_hash
> af_alg
> nf_conntrack_netlink xt_nat veth xt_conntrack bridge stp llc xt_set
> ip_set xt_addrtype xfrm_user xfrm_algo overlay xt_MASQUERADE xt_tcpudp
> xt_mark
> nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 tun qrtr binfmt_misc hid_logitech_hidpp joydev hci_uart
> btqca btrtl bt
> bcm btintel btsdio bluetooth jitterentropy_rng sha512_generic evdev
> bcm2835_v4l2(C) hid_logitech_dj sha512_arm64 bcm2835_mmal_vchiq(C)
> videobuf2_v
> malloc videobuf2_memops videobuf2_v4l2 cpufreq_dt videobuf2_common
> videodev aes_neon_bs snd_bcm2835(C) mc aes_neon_blk vc4 zfs(POE)
> snd_soc_hdmi_c
> odec snd_soc_core raspberrypi_cpufreq drbg snd_pcm_dmaengine
> ansi_cprng snd_pcm brcmfmac snd_timer zunicode(POE) brcmutil
> ecdh_generic pwm_bcm2835
> snd zzstd(OE) ecc nls_ascii zlua(OE) iproc_rng200 soundcore nls_cp437
> cec bcm2835_wdt vfat fat rc_core bcm2711_thermal vchiq(C)
> [565255.313189]  drm_display_helper v3d zcommon(POE) znvpair(POE)
> hid_generic gpu_sched drm_dma_helper zavl(POE) drm_shmem_helper
> drm_kms_helper i
> cp(POE) leds_gpio spl(OE) sg cfg80211 rfkill nf_tables libcrc32c
> nfnetlink loop fuse drm efi_pstore dm_mod dax configfs ip_tables
> x_tables autofs4
> usbhid hid ext4 crc16 mbcache jbd2 crc32c_generic sd_mod t10_pi
> crc64_rocksoft crc64 crc_t10dif crct10dif_generic uas usb_storage
> scsi_mod scsi_c
> ommon xhci_pci dwc2 xhci_hcd broadcom udc_core bcm_phy_ptp bcm_phy_lib
> reset_raspberrypi roles i2c_bcm2835 usbcore genet sdhci_iproc
> mdio_bcm_unim
> ac of_mdio usb_common fixed_phy fwnode_mdio crct10dif_ce
> crct10dif_common sdhci_pltfm libphy fixed sdhci gpio_regulator
> phy_generic
> [565255.489912] CPU: 1 PID: 1135280 Comm: kworker/1:3 Tainted: P
>   C OE      6.1.0-33-arm64 #1  Debian 6.1.133-1
> [565255.489934] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
> [565255.489941] Workqueue: events brcmf_fweh_event_worker [brcmfmac]
> [565255.490001] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTY=
PE=3D--)
> [565255.490013] pc : brcmf_p2p_notify_action_frame_rx+0x30c/0x440 [brcmfm=
ac]
> [565255.490058] lr : brcmf_p2p_notify_action_frame_rx+0x30c/0x440 [brcmfm=
ac]
> [565255.490100] sp : ffff80000c8d3c20
> [565255.490105] x29: ffff80000c8d3c20 x28: ffff145a4bc40810 x27:
> 0000000000000048
> [565255.490123] x26: ffff145a7c9ed560 x25: 0000000000000048 x24:
> ffff145a49cd8900
> [565255.490139] x23: ffff145a07b6aa98 x22: 0000000000000058 x21:
> ffff145a07b6aa80
> [565255.490154] x20: ffff80000c8d3d78 x19: ffff145a48e139c0 x18:
> 0000000000000006
> [565255.490169] x17: 010300080103060e x16: 0000000000000010 x15:
> 0000000000000001
> [565255.490184] x14: 0000000020000000 x13: 0000000000000002 x12:
> 0000000000000000
> [565255.490199] x11: 00000000ffffefff x10: ffffd291cf1109c8 x9 :
> ffffd291cd61d33c
> [565255.490214] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 :
> 0000000000000001
> [565255.490229] x5 : ffff145a7fb74ad0 x4 : ffff145a7fb74ad0 x3 :
> ffff145a7fb80c70
> [565255.490243] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> ffff145a46768000
> [565255.490258] Call trace:
> [565255.490264]  brcmf_p2p_notify_action_frame_rx+0x30c/0x440 [brcmfmac]
> [565255.490309]  brcmf_fweh_call_event_handler+0x44/0xc0 [brcmfmac]
> [565255.490352]  brcmf_fweh_event_worker+0x190/0x490 [brcmfmac]
> [565255.490395]  process_one_work+0x1f4/0x460
> [565255.490416]  worker_thread+0x188/0x4e0
> [565255.490429]  kthread+0xe0/0xe4
> [565255.490441]  ret_from_fork+0x10/0x20
> [565255.490455] ---[ end trace 0000000000000000 ]---
> [565658.710117] ieee80211 phy0: brcmf_p2p_send_action_frame: Unknown
> Frame: category 0x5, action 0x4
> [565658.721227] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [565704.491659] ieee80211 phy0: brcmf_p2p_send_action_frame: Unknown
> Frame: category 0x5, action 0x1
> root@cheshire:/home/hbarta#
>
> This was captured from dmesg output after I connected an Ethernet
> cable because I experienced it while using the console.
>
> I was running iwctl interactively and had entered (to the best of my
> recollection) commands to scan (nothing reported) and list (reported
> list of visible APs which seemed incomplete) and connect [AP Name].
> The last command prompted for the pass phrasxe and when I entered it
> and hit return, the stack dump appeared.
>
> (Stack dumpo also at https://pastebin.com/CtEMNFxf for 6 months.)
>
> The back story on this is that NetworkManager + wpa_supplicant is not
> reliably maintaining a consistent connection so I am exploring other
> configurations hoping to improve that.
>
> best
>
> Edit: I just enabled iwd (systemctl start iwd) and got another stack
> dump on the console. I've added it to the pastebin.
>
> --
> Beautiful Sunny Winfield



--=20
Beautiful Sunny Winfield

