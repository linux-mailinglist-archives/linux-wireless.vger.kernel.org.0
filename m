Return-Path: <linux-wireless+bounces-11010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E541948EB4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 14:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6541F26BD4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D083C1C3F02;
	Tue,  6 Aug 2024 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je58oyYR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF21BF323
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946183; cv=none; b=NprQjiJHpKlUx3KBmLZrZtB35hsYpwkzsGRsEIXvQmSEUGfKkcEuPcvWe/8GA2PcPXX0k/nc3qexuBEGQ92qr2/+GzDwZjg+C/jOVRQFe6g5cHQQ+yrd73bZeL0dQ1yIfZIy2S6dCYbOafYXspzmsrkVsYWaaY6xYdoPBzK7oJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946183; c=relaxed/simple;
	bh=4vKfB1DXxrqFECpahejxD10IZ28VnGz82cH1yCwJ6IM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MCW2FzCDOKuuJ2CD42lsYj/jVeokKNjrYExWbiBAahCpGcEU+/+cqorQgz/9hLJOWCM+i2VcaKebI0ifaAcDmdMUaN+8ijeFUjngZmHKJRZE6nGkz8Z4yu+lYQPo3qqlXwM9YNDsNZJuKywmEo5vR/8v+I9TAWj/7FKiDPgiBEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je58oyYR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso720755a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2024 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722946180; x=1723550980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o/Lmv+RV8CDcIK7rCeJaWUhFFon1DLkxKcJeaXf7nTg=;
        b=je58oyYRQWQvPIx11cZ41lzn8BegLS3iTTTRQgqlWrzqixhqLc85if3NTOhUkGGqcM
         1do4IeWH3gsEeUmJYH3E8hcNPTCWkUOSEJxu0NmoLwjZi91MbfuQLGSVBFqoEm65hOkm
         Q7fdTipFC1LyEpKv1DwCFqfRvC7U5tP8qKuPsT2JAowp5JwGzmABEwCxVrHyxKvV4Ea9
         jkJrMlFs82E1oeaVDccdZ3hBPvZv4XdYGRSyjvHi5y4o/lb3ZjH9hgFM41c/pTXYsHmA
         nXjQvC9Qyie7Wr+CM+MhUtL7ZqjBIhcaa8m4m1qSYJC3d4Tr9+vX/KV9lvQb662hQQJH
         Rj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722946180; x=1723550980;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/Lmv+RV8CDcIK7rCeJaWUhFFon1DLkxKcJeaXf7nTg=;
        b=rzvJc9zEegVAWOEndc4hlrhu6lfjwi5iFM3TR9WvBV8dVbnVeAEWKVJsgUi6ETEcUS
         gy8wv/JOy1QgVhoj8KCOqdNgAPdBM7qz0gV1yma9N3nxAq5xru4qpwXuQVqt4kH6eqwS
         snSXCkdmZswGftg9n0RGILrMP2mWx3R+cRaXB4u3wZ17+imyNUk9uMP3Nmbfy+tgan+5
         XEOZJhLypl13jYMtQDDFNiLiDhWku3FLDNLvkNwkOjBik9XD3Dde5Up7oqAzMNfCpAcQ
         K0o8pZUuaGBTpnbseWM+mJZik0NC6OQUDjZAM/ZqbBspsTed81DR4NU2I1rY8pTTD0a9
         BRnQ==
X-Gm-Message-State: AOJu0Ywj63n95NKHuYJlHgIBPSgDyqnvI+Ea7o7alMaMWv7pWS22p2Q9
	tN2YheKy5nFPcZFVU9jbXhpAdmb1SBWk1sxCnrJR2OQEOuLERMUzYTrMEWnaZCziHWvUKn8tXxe
	uNCkXRs8H4y/NRn2mS+n79SlCWOo=
X-Google-Smtp-Source: AGHT+IEtkL52G/E4IeqPgyTleDjIUk6aBfAIa3wIP4V7Q6E6ly0ZRrI/AwnKTl3pZ+7Z4KAcJCUW5ySFdoPrDA2CU64=
X-Received: by 2002:a50:fe99:0:b0:5a2:abcb:c4cf with SMTP id
 4fb4d7f45d1cf-5b7f4294f19mr10945124a12.22.1722946180108; Tue, 06 Aug 2024
 05:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 6 Aug 2024 13:09:28 +0100
Message-ID: <CALeDE9OAa56KMzgknaCD3quOgYuEHFx9_hcT=OFgmMAb+8MPyA@mail.gmail.com>
Subject: Crash when rmmod the rtw88_8723cs driver
To: Ping-Ke Shih <pkshih@realtek.com>, Fiona Klute <fiona.klute@gmx.de>, 
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Folks,

When playing around with the original Pinephone and the new support
for the rtl8723cs (thanks Fiona!) I had to rmmod the driver to test
suspend (side note there's issues with the driver here) I got the
crash below in the 6.10.x kernel.

Happy to test any patches.

Regards,
Peter

# rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core
[ 3698.067354] wlan0: deauthenticating from aa:f5:fd:60:4c:a8 by local
choice (Reason: 3=DEAUTH_LEAVING)
[ 3698.300937] ------------[ cut here ]------------
[ 3698.305987] Have pending ack frames!
[ 3698.310853] WARNING: CPU: 3 PID: 9232 at net/mac80211/main.c:1691
ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
[ 3698.324249] Modules linked in: rfcomm snd_seq_dummy snd_hrtimer
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables bnep
joydev panel_sitronix_st7703 rtw88_8723cs(-) hci_uart rtw88_8703b
rtw88_8723x btqca rtw88_sdio btrtl rtw88_core btintel mac80211 btbcm
st_magn_spi axp20x_adc st_sensors_spi libarc4 axp20x_pek bluetooth
regmap_spi snd_soc_simple_card gpio_vibra sun50i_codec_analog
snd_soc_simple_card_utils ff_memless sun8i_adda_pr_regmap cfg80211
inv_mpu6050_i2c inv_mpu6050 sun8i_di st_magn_i2c inv_sensors_timestamp
st_magn i2c_mux st_sensors_i2c st_sensors
industrialio_triggered_buffer sun6i_mipi_dsi stk3310 sunxi_cedrus(C)
kfifo_buf goodix_ts snd_soc_simple_amplifier sun8i_rotate
sun8i_thermal sun4i_i2s sun8i_codec v4l2_mem2mem snd_soc_bt_sco
videobuf2_dma_contig videobuf2_memops rfkill videobuf2_v4l2
snd_soc_core videodev snd_compress ac97_bus snd_pcm_dmaengine snd_seq
[ 3698.325088]  videobuf2_common snd_seq_device snd_pcm sun8i_mixer mc
snd_timer snd leds_sgm3140 leds_gpio led_class_flash soundcore vfat
fat pkcs8_key_parser fuse loop nfnetlink zram mmc_block
axp20x_usb_power axp20x_battery pinctrl_axp209 industrialio
axp20x_regulator axp20x_rsb crct10dif_ce polyval_ce polyval_generic
ghash_ce lima governor_simpleondemand sunxi sunxi_rsb pwm_sun4i
sun8i_a33_mbus gpu_sched musb_hdrc phy_sun6i_mipi_dphy i2c_mv64xxx
sunxi_wdt ohci_platform ehci_platform des_generic ohci_hcd libdes
phy_generic udc_core sun4i_drm sun8i_ce nvmem_sunxi_sid sunxi_mmc
phy_sun4i_usb sun6i_dma sun4i_tcon sun8i_tcon_top drm_dma_helper
pwm_bl cpufreq_dt dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua
[ 3698.477870] CPU: 3 PID: 9232 Comm: rmmod Tainted: G         C
  6.10.1-200.fc40.aarch64 #1
[ 3698.486780] Hardware name: pine64 Pine64 PinePhone Braveheart
(1.1)/Pine64 PinePhone Braveheart (1.1), BIOS 2024.01 01/01/2024
[ 3698.498252] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 3698.505306] pc : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
[ 3698.514865] lr : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
[ 3698.524187] sp : ffff80008c1b37b0
[ 3698.527577] x29: ffff80008c1b37b0 x28: ffff000003be8000 x27: 0000000000000000
[ 3698.534830] x26: 0000000000000000 x25: ffff000003dc14b8 x24: ffff80008c1b37d0
[ 3698.542093] x23: ffff000000ff9f80 x22: 0000000000000000 x21: 000000007fffffff
[ 3698.549342] x20: ffff80007c7e93d8 x19: ffff00006e66f400 x18: 0000000000000000
[ 3698.556597] x17: ffff7ffffd2b3000 x16: ffff800083fc0000 x15: 0000000000000000
[ 3698.563861] x14: 0000000000000000 x13: 2173656d61726620 x12: 6b636120676e6964
[ 3698.571081] x11: 0000000000000000 x10: 000000000000005d x9 : ffff8000802af2b0
[ 3698.578301] x8 : ffff80008c1b3430 x7 : 0000000000000001 x6 : 0000000000000001
[ 3698.585555] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[ 3698.592942] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000003be8000
[ 3698.600234] Call trace:
[ 3698.602774]  ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
[ 3698.611524]  idr_for_each+0x74/0x110
[ 3698.615226]  ieee80211_free_hw+0x44/0xe8 [mac80211]
[ 3698.623476]  rtw_sdio_remove+0x9c/0xc0 [rtw88_sdio]
[ 3698.628563]  sdio_bus_remove+0x44/0x180
[ 3698.632624]  device_remove+0x54/0x90
[ 3698.636324]  device_release_driver_internal+0x1d4/0x238
[ 3698.641628]  driver_detach+0x54/0xc0
[ 3698.645270]  bus_remove_driver+0x78/0x108
[ 3698.649355]  driver_unregister+0x38/0x78
[ 3698.653374]  sdio_unregister_driver+0x2c/0x40
[ 3698.657808]  rtw_8723cs_driver_exit+0x18/0x1000 [rtw88_8723cs]
[ 3698.663747]  __do_sys_delete_module.isra.0+0x190/0x338
[ 3698.669042]  __arm64_sys_delete_module+0x1c/0x30
[ 3698.673869]  invoke_syscall+0x74/0x100
[ 3698.673924]  el0_svc_common.constprop.0+0x48/0xf0
[ 3698.673935]  do_el0_svc+0x24/0x38
[ 3698.673945]  el0_svc+0x3c/0x158
[ 3698.673971]  el0t_64_sync_handler+0x120/0x138
[ 3698.673994]  el0t_64_sync+0x194/0x198
[ 3698.674027] ---[ end trace 0000000000000000 ]---

