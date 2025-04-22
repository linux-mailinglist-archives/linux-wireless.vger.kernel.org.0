Return-Path: <linux-wireless+bounces-21847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A852A97319
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 18:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EEC44047B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C649C296140;
	Tue, 22 Apr 2025 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti8Ez0nu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED82900A6;
	Tue, 22 Apr 2025 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745340753; cv=none; b=gPTXU1/P+X29GTK+yTKcf+Nuz6wzo5q5ZjgdftFTpdQy6b2AIg0RM9kgqsWHXwH9mdlH1yd2R/d3slhHwd/GE3tpo3RzeVXLpDTUdO/H8wYL34QgRxl4NuAIATRYiH4sjYZXEzWfTcQHIluv1EIiyt4a8xsoxFQg0W6zlxbUzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745340753; c=relaxed/simple;
	bh=aqfuT4KhozvPqTeyoEUgXQSOVYReVqP3zZDAZuJdN+Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SRviz/grbkvESPU7RDevvmu2FXridX9P6tk6ts/HnDlREYaVYs5V5OsapOBUY+6fvKVlsb0lkq5leO0P1vFgeZjNCRwWaC8N4vRkS0OATqgBUdQoarWilNFSEyQSPkyvrdG2yiE+bZDk5XFwf22C27zaK+D9fxFJQFrLM5o7tGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti8Ez0nu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac34257295dso993286766b.2;
        Tue, 22 Apr 2025 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745340750; x=1745945550; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+oAuAoMz4sDO/AVlpJFxLDfgAHNfCGXQoimCA6wbDjw=;
        b=Ti8Ez0nuNjzivWYduqR6RPjwS9yWFF93Tu8KmJD8KHbb0sG3edFLLWAGfRTkcJoq1X
         MdJ/QssdIbVfsohj3aYu46kv0RMons/W8NFfv4pciwOkUjhKHVC4kmp6xVJaNx2T3fMa
         7V9kPmrxvNsPJiQIRSQbgNxV/NRPHmJjZQYNRSZpnJZ+T6R27RFBFAuu/qcD2gvLpwo1
         6jDWAhIJYGGm+Q3ehVAaoO/h5dAasTOAfNOMXyZ9JD2DDD7XfpiU9NT7IJnOY+7wxIbx
         3tAYKJWOyD05toSg3LKd+zvQ/EaM0wHTJgjLEIbDCpms9sfyN7i1V8vTDKRt2/Rgt6vX
         wupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745340750; x=1745945550;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+oAuAoMz4sDO/AVlpJFxLDfgAHNfCGXQoimCA6wbDjw=;
        b=aUyIyomqDy5GHyXlYPvBSaFM6uC7BFCaRqWejOsdM77yuVychwHUOlv7y+m2e8ZA1x
         /Zr5YSq6FvwyzRRhA3YaY1OTyQWUWnOiIoLGVuNz4Gus1fsynrONUp5NOvanrK5D05l3
         ykg2ZaIKGhMNFQu8bpDD3osMlEq4rLNppDDXQ7VcXr73EgmaEQQD4Dhl/BMCaJmjPEx3
         SpcFbccp/GxouxC8RBy3n/+Q/uNsuHnAXYwTbGr+BW25ooiBwmxN91lJ1GKn+QvqHZ32
         MtHCUA7lJBMjFl6aWC4dOfClolXNxl1pUKO0xy7A2VRbWGbbnPyQcODosu3eKDIYPZZ3
         8ZJw==
X-Forwarded-Encrypted: i=1; AJvYcCUsNeOoWMbsB8RVnTCSNY4U/6kA8f9YcUL2C5/QecgmZNKPP8+o2htM9v2MUaf5oMWFnO+nugRqqo0+Dyo=@vger.kernel.org, AJvYcCVGyzCU8fy4qNF9Ki6p8EPVi3mJiWMDmJnN8HfIVQ6/zUfDQOE0FHQDRJXzZVZYn3VdWGtlpESW+D/kFk+E/tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMBM2TMJO/cY9k6V61HHRo78TJso/sjleDVFG7CA78P1S9+MTa
	EexTVk8BrWM8B4LTlBdaE3oGWdHhzzjr9YCgMPf2j97M5tWEb+Cr/JGDBaGd9kqmiwhAI4XWyQf
	d7gyrSnyjkLKlKfV5ez4tTxx7rD5xcyhn
X-Gm-Gg: ASbGncs4VhI31jUOVADFoKP3AsqLyKXsUEEUxXw0e4+eUKyDBYnUqcxijb1+t2spOSh
	ZcYz7BWBXtqPH0CKtlFP4y+dI7zPO/var+wzz4U++KTclPjLG/kqorMSpw9yMiZCSviJJcKFUmn
	LgNz44R+uIfInuokZBvYvYYalIZLBYkxxCObj0
X-Google-Smtp-Source: AGHT+IGjK87FTeUvbxRDMJp3Phzmv+Ss5LEopx3yEtdaEfC6V7gvoX6F8QTxmfGb1oXdbUgI8ofjONrBu5KXE4pRWQs=
X-Received: by 2002:a17:907:1c07:b0:ac6:e20f:fa48 with SMTP id
 a640c23a62f3a-acb74bdcde0mr1397216866b.33.1745340750026; Tue, 22 Apr 2025
 09:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hank Barta <hbarta@gmail.com>
Date: Tue, 22 Apr 2025 11:52:17 -0500
X-Gm-Features: ATxdqUEbJ4WG8mLzFBhg00fim0dvh4GtG-PzrR4F4r3oVhZOFqzj7wc8YjZ8lRg
Message-ID: <CABTDG886JyTFu0dUWgZAT89Dmxjm78VNk0TXcgf=1yABBRN5XQ@mail.gmail.com>
Subject: Stack dump, Pi 4B, Debian Bookworm (not RpiOS)
To: arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Good morning, I encountered the following while attempting to connect
to a WiFi AP using iwd. Another user on the Raspberry Pi IRC
(ukleinek) suggested I forward that to this group.

hbarta@olive:~/MkDocs/my-notes/docs/hosts/Raspberry-Pi/4/allegan$ cat
iwd.crash.txt
[565142.844103] NET: Registered PF_ALG protocol family
[565142.895121] alg: No test for hmac(md4) (hmac(md4-generic))
[565255.271588] ------------[ cut here ]------------
[565255.278557] memcpy: detected field-spanning write (size 72) of
single field "&mgmt_frame->u" at
drivers/net/wireless/broadcom/brcm80211/brcmfm
ac/p2p.c:1469 (size 26)
[565255.295948] WARNING: CPU: 1 PID: 1135280 at
drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1469
brcmf_p2p_notify_action_frame_rx+0x30c
/0x440 [brcmfmac]
[565255.312770] Modules linked in: ghash_generic ghash_ce gf128mul gcm
ccm algif_aead des_generic libdes ecb algif_skcipher md4 algif_hash
af_alg
nf_conntrack_netlink xt_nat veth xt_conntrack bridge stp llc xt_set
ip_set xt_addrtype xfrm_user xfrm_algo overlay xt_MASQUERADE xt_tcpudp
xt_mark
nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 tun qrtr binfmt_misc hid_logitech_hidpp joydev hci_uart
btqca btrtl bt
bcm btintel btsdio bluetooth jitterentropy_rng sha512_generic evdev
bcm2835_v4l2(C) hid_logitech_dj sha512_arm64 bcm2835_mmal_vchiq(C)
videobuf2_v
malloc videobuf2_memops videobuf2_v4l2 cpufreq_dt videobuf2_common
videodev aes_neon_bs snd_bcm2835(C) mc aes_neon_blk vc4 zfs(POE)
snd_soc_hdmi_c
odec snd_soc_core raspberrypi_cpufreq drbg snd_pcm_dmaengine
ansi_cprng snd_pcm brcmfmac snd_timer zunicode(POE) brcmutil
ecdh_generic pwm_bcm2835
snd zzstd(OE) ecc nls_ascii zlua(OE) iproc_rng200 soundcore nls_cp437
cec bcm2835_wdt vfat fat rc_core bcm2711_thermal vchiq(C)
[565255.313189]  drm_display_helper v3d zcommon(POE) znvpair(POE)
hid_generic gpu_sched drm_dma_helper zavl(POE) drm_shmem_helper
drm_kms_helper i
cp(POE) leds_gpio spl(OE) sg cfg80211 rfkill nf_tables libcrc32c
nfnetlink loop fuse drm efi_pstore dm_mod dax configfs ip_tables
x_tables autofs4
usbhid hid ext4 crc16 mbcache jbd2 crc32c_generic sd_mod t10_pi
crc64_rocksoft crc64 crc_t10dif crct10dif_generic uas usb_storage
scsi_mod scsi_c
ommon xhci_pci dwc2 xhci_hcd broadcom udc_core bcm_phy_ptp bcm_phy_lib
reset_raspberrypi roles i2c_bcm2835 usbcore genet sdhci_iproc
mdio_bcm_unim
ac of_mdio usb_common fixed_phy fwnode_mdio crct10dif_ce
crct10dif_common sdhci_pltfm libphy fixed sdhci gpio_regulator
phy_generic
[565255.489912] CPU: 1 PID: 1135280 Comm: kworker/1:3 Tainted: P
  C OE      6.1.0-33-arm64 #1  Debian 6.1.133-1
[565255.489934] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
[565255.489941] Workqueue: events brcmf_fweh_event_worker [brcmfmac]
[565255.490001] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[565255.490013] pc : brcmf_p2p_notify_action_frame_rx+0x30c/0x440 [brcmfmac]
[565255.490058] lr : brcmf_p2p_notify_action_frame_rx+0x30c/0x440 [brcmfmac]
[565255.490100] sp : ffff80000c8d3c20
[565255.490105] x29: ffff80000c8d3c20 x28: ffff145a4bc40810 x27:
0000000000000048
[565255.490123] x26: ffff145a7c9ed560 x25: 0000000000000048 x24:
ffff145a49cd8900
[565255.490139] x23: ffff145a07b6aa98 x22: 0000000000000058 x21:
ffff145a07b6aa80
[565255.490154] x20: ffff80000c8d3d78 x19: ffff145a48e139c0 x18:
0000000000000006
[565255.490169] x17: 010300080103060e x16: 0000000000000010 x15:
0000000000000001
[565255.490184] x14: 0000000020000000 x13: 0000000000000002 x12:
0000000000000000
[565255.490199] x11: 00000000ffffefff x10: ffffd291cf1109c8 x9 :
ffffd291cd61d33c
[565255.490214] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 :
0000000000000001
[565255.490229] x5 : ffff145a7fb74ad0 x4 : ffff145a7fb74ad0 x3 :
ffff145a7fb80c70
[565255.490243] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
ffff145a46768000
[565255.490258] Call trace:
[565255.490264]  brcmf_p2p_notify_action_frame_rx+0x30c/0x440 [brcmfmac]
[565255.490309]  brcmf_fweh_call_event_handler+0x44/0xc0 [brcmfmac]
[565255.490352]  brcmf_fweh_event_worker+0x190/0x490 [brcmfmac]
[565255.490395]  process_one_work+0x1f4/0x460
[565255.490416]  worker_thread+0x188/0x4e0
[565255.490429]  kthread+0xe0/0xe4
[565255.490441]  ret_from_fork+0x10/0x20
[565255.490455] ---[ end trace 0000000000000000 ]---
[565658.710117] ieee80211 phy0: brcmf_p2p_send_action_frame: Unknown
Frame: category 0x5, action 0x4
[565658.721227] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[565704.491659] ieee80211 phy0: brcmf_p2p_send_action_frame: Unknown
Frame: category 0x5, action 0x1
root@cheshire:/home/hbarta#

This was captured from dmesg output after I connected an Ethernet
cable because I experienced it while using the console.

I was running iwctl interactively and had entered (to the best of my
recollection) commands to scan (nothing reported) and list (reported
list of visible APs which seemed incomplete) and connect [AP Name].
The last command prompted for the pass phrasxe and when I entered it
and hit return, the stack dump appeared.

(Stack dumpo also at https://pastebin.com/CtEMNFxf for 6 months.)

The back story on this is that NetworkManager + wpa_supplicant is not
reliably maintaining a consistent connection so I am exploring other
configurations hoping to improve that.

best

Edit: I just enabled iwd (systemctl start iwd) and got another stack
dump on the console. I've added it to the pastebin.

-- 
Beautiful Sunny Winfield

