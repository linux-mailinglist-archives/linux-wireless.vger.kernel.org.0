Return-Path: <linux-wireless+bounces-6267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B7B8A3520
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 19:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD3028855E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 17:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE0D14D29E;
	Fri, 12 Apr 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZwf0F/R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED014C596
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944125; cv=none; b=WYSW1Zl53d3B1aLOIgMJxWsRSsRyYt+mO4v3QzrbPOzZKV4AHlJmnNg2Q2lGJzGuZE5mtYph0qJU0IyPWF10zgpcTRxkO7H0xZAM+eKngSDDL2r/RtBXIqQzTGgOs3j6VXp7u8cqzpNKVmOT2RDW2ugIm/341zcbbx84bpVtOjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944125; c=relaxed/simple;
	bh=nlFw604Ueneanf/thBFAfMvl/lWtz6UzMNv1eWU+VLQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=m/SYEWHc68pyS6mwY6gER/1z36HZwttxlpL81YhmSZ09oqoPrQizCo78VStJFUEIlGAi5S3hzJFwKS0fvkBcNDYnesr0i13iWh4HyDL7KvqmzQvnkI4JtFTrA98u6k4UO4h8fbF/ZeWuZkJdQG6Kj9haDR+45NI5oYNNKHGy28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZwf0F/R; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41802e8db9aso4622465e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712944123; x=1713548923; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbxyWFuVR7bMyTYuI1ipdVC3HWbyIZTBTABu+RcjbLE=;
        b=OZwf0F/RYBEHaIzTc89I7U8USG3y43EZSwbDh4LkNhANZ3bodHTaKTRihCTJwUtOf1
         E+KqjktxGyRLnZgmnNRWqAlZJNdE1A/4nPym8Q/FqWBu/dXQ460Zor0mZJGHFbRVKPXS
         6mUeFXWnuU3K30QxOnDM5oEzKH1+D6lNoMeSgXoJGX2VJtHjUWk5qO25D5RG4eYDyH76
         yejnlpHyXCvQdFPHkde/QkiIxm6LEg1oKKuI6Zk9U6A+GdOESNHB9yPWBxB2lCryPfjf
         3CR+nymc3XNM0y74iLdl480ocNtNn/ceBObIDz0qjWqn2S4+R05lYCTrrcsQaHVzKFeR
         dGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712944123; x=1713548923;
        h=content-transfer-encoding:subject:from:to:content-language
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lbxyWFuVR7bMyTYuI1ipdVC3HWbyIZTBTABu+RcjbLE=;
        b=I8wfAcFoMF/HcDSJ/UfNMv4H/egEh250Cf48H4CDhlgNmRLlIrpND3UfB7/YlueKo6
         oP1+dBUB1RE3mMUpmytvzQOhJ5GMowtKvLOGhY7mkpbo9c1EhgL7tpfH1G7QWduimN/2
         qjmlIGfl86/fJhxH+juwVKduotWxHbHxo+66dMOQqKjXGZT5X71tte+4Wq4pq8PGggb4
         Wbtw1fDEpPlb6Ikc/eT/DfkaPU55AKbTqD2nehhfxCzzYIna7AGlj1iEOx3+xaR8kczI
         LT766K3aV7jIO2VjK7y5T2EhojBYyAYneqpMMsNy9Y1uwL8m/sYo2u4DMSayYshjEfr2
         p8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW2RqFbhJLPFm2nkDiRWRg7U6n3DPHn4a07g2jQY28SYTCV9ycyfo4Hs3adWmK7xnEVewaIDNMjajFFTmeNqOy6CLIsS9BWZilnxjuKVC8=
X-Gm-Message-State: AOJu0Yxginxj4dWB1x0U2Gjp0KODj2S1kf/JU5rN6Gtt/vHvoKP4hUU+
	H3FGTfk1YKqWOWb/WE9pPaCMyl1LJdX9yjEQjB5z7oRBgS+UzVg=
X-Google-Smtp-Source: AGHT+IFSAyaVbVzs6uo7GEs86H7RvwhBztoApLWnGPgjJyI5HwJArD4yVWU6GcR13WMzDvw8Qd+5EA==
X-Received: by 2002:a05:600c:3b1b:b0:417:d99f:1fef with SMTP id m27-20020a05600c3b1b00b00417d99f1fefmr4566463wms.3.1712944122432;
        Fri, 12 Apr 2024 10:48:42 -0700 (PDT)
Received: from localhost (47.red-95-127-89.dynamicip.rima-tde.net. [95.127.89.47])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041663450a4asm9451836wmn.45.2024.04.12.10.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 10:48:41 -0700 (PDT)
Message-ID: <2c534d01-449a-43f4-9216-eacdb3b35577@gmail.com>
Date: Fri, 12 Apr 2024 19:48:39 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Stanislaw Gruszka <stf_xl@wp.pl>, linux-wireless@vger.kernel.org
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
Subject: [WARNING] memcpy: detected field-spanning write (size 1005) of single
 field "&out_cmd->cmd.payload" at
 drivers/net/wireless/intel/iwlegacy/common.c:3173 (size 320)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In Fedora kernel 6.8.5-301.fc40.x86_64, dmesg shows:

[ device: 03:00.0 Network controller [0280]: Intel Corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection [8086:4230] (rev 61) ]

Thanks.

[   53.407607] ------------[ cut here ]------------
[   53.407622] memcpy: detected field-spanning write (size 1005) of single field "&out_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3173 (size 320)
[   53.407721] WARNING: CPU: 1 PID: 1632 at drivers/net/wireless/intel/iwlegacy/common.c:3173 il_enqueue_hcmd+0x477/0x560 [iwlegacy]
[   53.407804] Modules linked in: snd_hrtimer i915 snd_hda_codec_analog snd_hda_codec_generic iTCO_wdt intel_pmc_bxt iTCO_vendor_support iwl4965 btusb btrtl snd_hda_intel btintel snd_intel_dspcfg 
btbcm snd_intel_sdw_acpi btmtk iwlegacy bluetooth snd_hda_codec drm_buddy mac80211 i2c_algo_bit coretemp i2c_i801 wmi_bmof ttm acpi_cpufreq i2c_smbus r592 libarc4 thinkpad_acpi memstick cfg80211 
drm_display_helper snd_hda_core lpc_ich ses enclosure snd_seq_dummy snd_seq_oss scsi_transport_sas cec snd_seq_midi_event snd_pcm_oss snd_seq ledtrig_audio snd_hwdep snd_seq_device platform_profile 
rfkill snd_pcm snd_timer snd_mixer_oss snd soundcore pktcdvd binfmt_misc loop nfnetlink zram sdhci_pci firewire_ohci cqhci firewire_core sdhci ata_generic sha512_ssse3 mmc_core video sha256_ssse3 
e1000e sha1_ssse3 yenta_socket crc_itu_t wmi serio_raw pata_acpi uas usb_storage scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_tables ip_tables fuse i2c_dev
[   53.408052] CPU: 1 PID: 1632 Comm: wpa_supplicant Tainted: G     U             6.8.5-301.fc40.x86_64 #1
[   53.408063] Hardware name: LENOVO 7659AB7/7659AB7, BIOS 7LETC9WW (2.29 ) 03/18/2011
[   53.408069] RIP: 0010:il_enqueue_hcmd+0x477/0x560 [iwlegacy]
[   53.408132] Code: 01 00 00 4c 89 c6 48 c7 c2 78 58 ba c0 48 c7 c7 d0 58 ba c0 48 89 44 24 20 4c 89 44 24 18 c6 05 77 48 1f 00 01 e8 e9 8b 8c c7 <0f> 0b 48 8b 44 24 20 4c 8b 44 24 18 e9 f9 fc ff ff 
48 8b 85 90 3f
[   53.408140] RSP: 0018:ffffb4d841ddb668 EFLAGS: 00010082
[   53.408150] RAX: 0000000000000000 RBX: ffff958a1794d000 RCX: 0000000000000027
[   53.408157] RDX: ffff958b37d218c8 RSI: 0000000000000001 RDI: ffff958b37d218c0
[   53.408162] RBP: ffff958b18e11fc0 R08: 0000000000000000 R09: ffffb4d841ddb4d8
[   53.408168] R10: ffffffff8a516808 R11: 0000000000000003 R12: ffffb4d841ddb770
[   53.408173] R13: 00000000000003f1 R14: ffff958b2f6ae960 R15: ffff958b2c7d9d00
[   53.408179] FS:  00007ff1ddeec840(0000) GS:ffff958b37d00000(0000) knlGS:0000000000000000
[   53.408186] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.408193] CR2: 00007ff1de15f730 CR3: 0000000136860000 CR4: 00000000000006f0
[   53.408199] Call Trace:
[   53.408207]  <TASK>
[   53.408212]  ? il_enqueue_hcmd+0x477/0x560 [iwlegacy]
[   53.408274]  ? __warn+0x81/0x130
[   53.408293]  ? il_enqueue_hcmd+0x477/0x560 [iwlegacy]
[   53.408356]  ? report_bug+0x16f/0x1a0
[   53.408371]  ? handle_bug+0x3c/0x80
[   53.408379]  ? exc_invalid_op+0x17/0x70
[   53.408388]  ? asm_exc_invalid_op+0x1a/0x20
[   53.408405]  ? il_enqueue_hcmd+0x477/0x560 [iwlegacy]
[   53.408466]  ? il_enqueue_hcmd+0x477/0x560 [iwlegacy]
[   53.408496]  il_send_cmd_sync+0xf7/0x440 [iwlegacy]
[   53.408551]  ? il4965_request_scan+0x859/0xa00 [iwl4965]
[   53.408551]  il4965_request_scan+0x701/0xa00 [iwl4965]
[   53.408551]  il_mac_hw_scan+0x201/0x340 [iwlegacy]
[   53.408551]  drv_hw_scan+0x9f/0x150 [mac80211]
[   53.408551]  __ieee80211_start_scan+0x296/0x750 [mac80211]
[   53.408551]  rdev_scan+0x25/0xd0 [cfg80211]
[   53.408551]  nl80211_trigger_scan+0x3b4/0x7b0 [cfg80211]
[   53.408551]  genl_family_rcv_msg_doit+0xef/0x150
[   53.408551]  genl_rcv_msg+0x1b7/0x2c0
[   53.408551]  ? __pfx_nl80211_pre_doit+0x10/0x10 [cfg80211]
[   53.408551]  ? __pfx_nl80211_trigger_scan+0x10/0x10 [cfg80211]
[   53.408551]  ? __pfx_nl80211_post_doit+0x10/0x10 [cfg80211]
[   53.408551]  ? __pfx_genl_rcv_msg+0x10/0x10
[   53.408551]  netlink_rcv_skb+0x50/0x100
[   53.408551]  genl_rcv+0x28/0x40
[   53.408551]  netlink_unicast+0x249/0x370
[   53.408551]  netlink_sendmsg+0x21c/0x480
[   53.408551]  ____sys_sendmsg+0x39f/0x3d0
[   53.408551]  ___sys_sendmsg+0x9a/0xe0
[   53.408551]  __sys_sendmsg+0xcc/0x100
[   53.408551]  do_syscall_64+0x83/0x170
[   53.408551]  ? __sys_setsockopt+0xb2/0xe0
[   53.408551]  ? syscall_exit_to_user_mode+0x80/0x230
[   53.408551]  ? do_syscall_64+0x8f/0x170
[   53.408551]  ? do_user_addr_fault+0x304/0x670
[   53.408551]  ? exc_page_fault+0x7f/0x180
[   53.408551]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[   53.408551] RIP: 0033:0x7ff1dd92d6a4
[   53.408551] Code: 15 79 87 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00 f3 0f 1e fa 80 3d a5 09 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 
83 ec 20 89 55
[   53.408551] RSP: 002b:00007ffe8bf867e8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[   53.408551] RAX: ffffffffffffffda RBX: 0000555e2541efa0 RCX: 00007ff1dd92d6a4
[   53.408551] RDX: 0000000000000000 RSI: 00007ffe8bf86820 RDI: 0000000000000006
[   53.408551] RBP: 00007ffe8bf86810 R08: 0000000000000004 R09: 0000000000000001
[   53.408551] R10: 00007ffe8bf86920 R11: 0000000000000202 R12: 0000555e254910d0
[   53.408551] R13: 0000555e2541eeb0 R14: 00007ffe8bf86820 R15: 0000000000000000
[   53.408551]  </TASK>
[   53.408551] ---[ end trace 0000000000000000 ]---

