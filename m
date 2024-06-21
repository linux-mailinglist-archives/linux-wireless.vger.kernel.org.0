Return-Path: <linux-wireless+bounces-9412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 432B9911E37
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED827282469
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A0216D4D4;
	Fri, 21 Jun 2024 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b="JEnWuwl8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B22A16D4D0
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957094; cv=none; b=eiUST1FMFW62GhXgEzl/CnPQEFUlj52i2RNjmvkKdsoCg7B5I2233MfT+SeZA2Py2FMHbRwGERqbLXyJLz0/LW0mYuj0GZp/FjC1vDxSnxpSKP4VdqOq5FC591VAqORTa+4H8EIEMWdIMcG5dsOX44nxT8hrJbvUhBS6Pf9UZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957094; c=relaxed/simple;
	bh=ZaK+rt9B1kMkxrWYuXAyl7LZVGtC9k3XZeU3cQjVxnU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EfG6VcEMR2F/Uow8l9ricpALaISO8woA0CGwap07OxFfHHfafPNr6MMQuJOj5ou/D7rQQPRH5H0NebN6vJFZnXnnHu/ZdYUSqgxkS4vX5RkYssgTMAgb6Lo980MnY3hX95bsd5mk0OHLvgwHc72K3U5wIJ9F97NEplDbshmcNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com; spf=pass smtp.mailfrom=citymesh.com; dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b=JEnWuwl8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citymesh.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso1940822a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 01:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1718957091; x=1719561891; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VSI2yyzGMEOl1jMHYavqX3CDfQJ/NSUivwxmCx+KJx8=;
        b=JEnWuwl8awTYQyYszzhVA8f/N3ad6/kRb10WxUYayY5IQOLp3j9hN/9rfr/YJqCMFc
         TmZ+YDKjtvczQgX/mBOWS+cPGY2FwNhmEEsEv+C6lGT9uIlkQwwTm6JSOTbLQxqZKv0E
         4aywV1o/yokcTB+r3H1UG7mdpkAd7773xHF+0ruCA4Z51sPeb7Ynp7EBzUE0A5Nz9bHI
         9mkY4eMfqVsWqOaDVXlpsvlFD5yCSFVeFV4r+EMpLCGHV5HJUx3C4txooKYXsQH5X7RS
         EgHvfU084ydUCA5HIRtkzt1FCEfXhwNIuDgnPUOBgIhMn8LeIo9Rcha+vRfgtjgD+5HD
         TsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718957091; x=1719561891;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSI2yyzGMEOl1jMHYavqX3CDfQJ/NSUivwxmCx+KJx8=;
        b=qNvvSsD1/g6oOxNm3LPX6a1Yxyk+CV4EPEfS+20iY98wYAoPYqw/nxebU0qpBLDt3M
         bw5tSN8LuJ26vniWa9q8wTnGvTZkBmjV5rPntI4M6x6iHvYW+jgYrwEtiT9eVqYfuWNz
         Zw0bvfoYprbC0GRpEG2mKvIDtqZfTMsYy0a23BhO9IdPIWAnOA1vsXYN2rZwR2SvcQPa
         mw+tXxOpdwI8roQwW/mUiwQAvn9PwNK+jfZZzIaQxJwad2/kmExdUyMYXZXtJ21tBtxr
         UN0NBjz8ge6sWQ7JdtoO2TWXalMwN+TEpaRnI/JiOorrPXfQHE89t9viGiV15/HcBFk/
         ev/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhoUziDMhYB76rBIQfLXjFGBoP4G7qDpNbUZETl5JyAbJsBlDqp8/vMmC+JWjnqJ3su3lDB1GTVwHLA3U9V42X+0oDxuTsqvBsbDi3GQs=
X-Gm-Message-State: AOJu0YyjhAlg50KaFy5OoRLPV+52aTRyervQm8c83WUANP9aRx5AWpi9
	jttiv+s0EG2YsGTi3joJR5qkt3lncUesorNdmsOLVjzP0xCm2p0OQS8iYU2woFCCMbrqbX7xKUF
	kNuRgk/uXW2ouQJ2s/wwkXypUiOUZOLsw6NlizA==
X-Google-Smtp-Source: AGHT+IGshKwjY9oBCtZcrPdff4kHU6jfIiZLHyEkWf6cdQquSNCDmq3QVIi/T+ktjNL9qTv6o80T1ekMKXRWV/F1Sco=
X-Received: by 2002:a05:6402:1289:b0:57d:10db:488e with SMTP id
 4fb4d7f45d1cf-57d10db4895mr4240104a12.30.1718957090675; Fri, 21 Jun 2024
 01:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Koen Vandeputte <koen.vandeputte@citymesh.com>
Date: Fri, 21 Jun 2024 10:04:39 +0200
Message-ID: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
Subject: ieee80211.h virtual_map splat
To: ath10k@lists.infradead.org, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

Within OpenWRT, we switched to kernel 6.6 some time ago.

During testing on a WiFi WDS setup (ath10k), I noticed an old standing
bug which now prints a lot more data due to the kernel upgrade:

- All WDS stations are connected
- The splat occurs
- All WDS station seem to go in timeout and disconnect
- The behavior is fixed after a reboot

Yes, we use ath10k-ct over here, but this part of the code is
identical to upstream ath10k.

The main issue:

memcpy: detected field-spanning write (size 64) of single field
"tim->virtual_map" at
../ath10k-ct-smallbuffers/ath10k-ct-2024.03.02~eb3f488a/ath10k-6.7/wmi.c:4043
(size 1)


looks like virtual_map is defined as  "u8 virtual_map[1]", triggering
that error within "include/linux/ieee80211.h"

/**
 * struct ieee80211_tim_ie - Traffic Indication Map information element
 * @dtim_count: DTIM Count
 * @dtim_period: DTIM Period
 * @bitmap_ctrl: Bitmap Control
 * @virtual_map: Partial Virtual Bitmap
 *
 * This structure represents the payload of the "TIM element" as
 * described in IEEE Std 802.11-2020 section 9.4.2.5.
 */
struct ieee80211_tim_ie {
        u8 dtim_count;
        u8 dtim_period;
        u8 bitmap_ctrl;
        /* variable size: 1 - 251 bytes */
        u8 virtual_map[1];
} __packed;


According to this page, defining it this way is actually deprecated:
https://www.kernel.org/doc/html/latest/process/deprecated.html

What is the correct way to fix this?
Converting it to "u8 virtual_map[];"  ?


Thanks!



full splat log:

[   37.027955] br-wan: port 11(wlan1.sta10) entered disabled state
[   37.032802] ath10k_ahb a800000.wifi wlan1.sta10: entered allmulticast mode
[   37.038987] ath10k_ahb a800000.wifi wlan1.sta10: entered promiscuous mode
[   37.046430] br-wan: port 11(wlan1.sta10) entered blocking state
[   37.052492] br-wan: port 11(wlan1.sta10) entered forwarding state
[   37.218833] br-wan: port 12(wlan1.sta11) entered blocking state
[   37.218965] br-wan: port 12(wlan1.sta11) entered disabled state
[   37.223718] ath10k_ahb a800000.wifi wlan1.sta11: entered allmulticast mode
[   37.230047] ath10k_ahb a800000.wifi wlan1.sta11: entered promiscuous mode
[   37.237405] br-wan: port 12(wlan1.sta11) entered blocking state
[   37.243485] br-wan: port 12(wlan1.sta11) entered forwarding state
[   39.966722] br-wan: port 13(wlan1.sta7) entered blocking state
[   39.966835] br-wan: port 13(wlan1.sta7) entered disabled state
[   39.971752] ath10k_ahb a800000.wifi wlan1.sta7: entered allmulticast mode
[   39.977727] ath10k_ahb a800000.wifi wlan1.sta7: entered promiscuous mode
[   39.985296] br-wan: port 13(wlan1.sta7) entered blocking state
[   39.991074] br-wan: port 13(wlan1.sta7) entered forwarding state
[   40.578110] ath10k_ahb a800000.wifi: mac flush vdev 0 drop 0 queues
0x1 ar->paused: 0x0  arvif->paused: 0x0
[   43.478613] br-wan: port 14(wlan1.sta12) entered blocking state
[   43.478746] br-wan: port 14(wlan1.sta12) entered disabled state
[   43.483502] ath10k_ahb a800000.wifi wlan1.sta12: entered allmulticast mode
[   43.489811] ath10k_ahb a800000.wifi wlan1.sta12: entered promiscuous mode
[   43.497315] br-wan: port 14(wlan1.sta12) entered blocking state
[   43.503246] br-wan: port 14(wlan1.sta12) entered forwarding state
[   51.425993] br-wan: port 15(wlan1.sta13) entered blocking state
[   51.426108] br-wan: port 15(wlan1.sta13) entered disabled state
[   51.430959] ath10k_ahb a800000.wifi wlan1.sta13: entered allmulticast mode
[   51.437137] ath10k_ahb a800000.wifi wlan1.sta13: entered promiscuous mode
[   51.444841] br-wan: port 15(wlan1.sta13) entered blocking state
[   51.450608] br-wan: port 15(wlan1.sta13) entered forwarding state
[  378.987163] ath10k_ahb a800000.wifi: wmi: fixing invalid VHT TX
rate code 0xff
[ 2799.429749] ath10k_ahb a800000.wifi: Invalid VHT mcs 15 peer stats
[29009.581820] ------------[ cut here ]------------
[29009.581898] WARNING: CPU: 0 PID: 0 at
../ath10k-ct-smallbuffers/ath10k-ct-2024.03.02~eb3f488a/ath10k-6.7/wmi.c:4043
ath10k_wmi_event_host_swba+0x7c4/0x824 [ath10k_core]
[29009.585574] memcpy: detected field-spanning write (size 64) of
single field "tim->virtual_map" at
../ath10k-ct-smallbuffers/ath10k-ct-2024.03.02~eb3f488a/ath10k-6.7/wmi.c:4043
(size 1)
[29009.600608] Modules linked in: nft_fib_inet nf_flow_table_inet
iptable_nat ath10k_pci(O) ath10k_core(O) ath(O) xt_state xt_nat
xt_conntrack xt_REDIRECT xt_MASQUERADE xt_FLOWOFFLOAD wireguard
nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir
nft_quota nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash
nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_compat
nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack mac80211(O)
libchacha20poly1305 iptable_mangle iptable_filter ipt_REJECT ip_tables
curve25519_neon cfg80211(O) xt_time xt_tcpudp xt_multiport xt_mark
xt_mac xt_limit xt_comment xt_TCPMSS xt_LOG x_tables poly1305_arm
nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6
nf_defrag_ipv4 mbt(O) libcurve25519_generic libcrc32c hwmon compat(O)
chacha_neon ip_gre gre dummy ip6_udp_tunnel udp_tunnel ip_tunnel tun
dns_resolver sha512_arm ghash_arm_ce cmac leds_gpio xhci_plat_hcd
xhci_pci xhci_hcd dwc3 dwc3_qcom gpio_button_hotplug(O) crc32c_generic
[29009.683039] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O
   6.6.32 #0
[29009.705243] Hardware name: Generic DT based system
[29009.712626]  unwind_backtrace from show_stack+0x10/0x14
[29009.717217]  show_stack from dump_stack_lvl+0x40/0x4c
[29009.722337]  dump_stack_lvl from __warn+0x94/0xbc
[29009.727546]  __warn from warn_slowpath_fmt+0xf8/0x15c
[29009.732233]  warn_slowpath_fmt from
ath10k_wmi_event_host_swba+0x7c4/0x824 [ath10k_core]
[29009.737309]  ath10k_wmi_event_host_swba [ath10k_core] from
ath10k_wmi_10_4_op_rx+0x444/0x6a4 [ath10k_core]
[29009.745437]  ath10k_wmi_10_4_op_rx [ath10k_core] from
ath10k_htc_rx_completion_handler+0xa8/0x210 [ath10k_core]
[29009.754899]  ath10k_htc_rx_completion_handler [ath10k_core] from
ath10k_pci_fw_dump_work+0xf28/0xf94 [ath10k_pci]
[29009.764894]  ath10k_pci_fw_dump_work [ath10k_pci] from
ath10k_ce_per_engine_service+0x64/0x84 [ath10k_core]
[29009.775299]  ath10k_ce_per_engine_service [ath10k_core] from
ath10k_ce_per_engine_service_any+0x74/0x194 [ath10k_core]
[29009.784848]  ath10k_ce_per_engine_service_any [ath10k_core] from
ath10k_pci_napi_poll+0x44/0x138 [ath10k_pci]
[29009.795611]  ath10k_pci_napi_poll [ath10k_pci] from
__napi_poll.constprop.0+0x2c/0x180
[29009.805589]  __napi_poll.constprop.0 from net_rx_action+0x140/0x2e8
[29009.813400]  net_rx_action from __do_softirq+0x100/0x270
[29009.819561]  __do_softirq from irq_exit+0x88/0xb4
[29009.825117]  irq_exit from call_with_stack+0x18/0x20
[29009.829715]  call_with_stack from __irq_svc+0x80/0x98
[29009.834751] Exception stack(0xc0d01f28 to 0xc0d01f70)
[29009.839706] 1f20:                   00000003 00000001 1d2e2e44
40000000 00000000 c0d04f68
[29009.844745] 1f40: c0d084c0 c0d04fa0 00000000 00000000 c0d04f08
00000000 0000001f c0d01f78
[29009.852898] 1f60: c09deaf8 c09df260 60000013 ffffffff
[29009.861055]  __irq_svc from default_idle_call+0x2c/0x30
[29009.866089]  default_idle_call from do_idle+0x1d8/0x228
[29009.871124]  do_idle from cpu_startup_entry+0x28/0x2c
[29009.876328]  cpu_startup_entry from kernel_init+0x0/0x12c
[29009.881537]  kernel_init from arch_post_acpi_subsys_init+0x0/0x8
[29009.886973] ---[ end trace 0000000000000000 ]---
[29083.868479] ath10k_ahb a800000.wifi: mac flush vdev 0 drop 0 queues
0x1 ar->paused: 0x0  arvif->paused: 0x0
[29084.022948] ath10k_ahb a800000.wifi: htt tx: fixing invalid VHT TX
rate code 0xff
[29140.323342] ath10k_ahb a800000.wifi wlan1.sta13: left allmulticast mode
[29140.323438] ath10k_ahb a800000.wifi wlan1.sta13: left promiscuous mode
[29140.329056] br-wan: port 15(wlan1.sta13) entered disabled state
[29140.578367] ath10k_ahb a800000.wifi: mac flush vdev 0 drop 0 queues
0x1 ar->paused: 0x0  arvif->paused: 0x0
[29391.197449] ath10k_ahb a800000.wifi wlan1.sta5: left allmulticast mode
[29391.197545] ath10k_ahb a800000.wifi wlan1.sta5: left promiscuous mode
[29391.203174] br-wan: port 7(wlan1.sta5) entered disabled state
[29391.458355] ath10k_ahb a800000.wifi: mac flush vdev 0 drop 0 queues
0x1 ar->paused: 0x0  arvif->paused: 0x0
[29393.265876] ath10k_ahb a800000.wifi wlan1.sta1: left allmulticast mode
[29393.265971] ath10k_ahb a800000.wifi wlan1.sta1: left promiscuous mode
[29393.271627] br-wan: port 3(wlan1.sta1) entered disabled state
[29393.498365] ath10k_ahb a800000.wifi: mac flush vdev 0 drop 0 queues
0x1 ar->paused: 0x0  arvif->paused: 0x0
[29398.364359] ath10k_ahb a800000.wifi wlan1.sta6: left allmulticast mode
[29398.364453] ath10k_ahb a800000.wifi wlan1.sta6: left promiscuous mode
[29398.370110] br-wan: port 8(wlan1.sta6) entered disabled state
[29398.608363] ath10k_ahb a800000.wifi: mac flush vdev 0 drop 0 queues
0x1 ar->paused: 0x0  arvif->paused: 0x0
[29398.623885] ath10k_ahb a800000.wifi wlan1.sta12: left allmulticast mode
[29398.623983] ath10k_ahb a800000.wifi wlan1.sta12: left promiscuous mode
[29398.629566] br-wan: port 14(wlan1.sta12) entered disabled state
[29398.858363] ath10k_ahb a800000.wifi: mac flush vdev 0 drop 0 queues
0x1 ar->paused: 0x0  arvif->paused: 0x0
[29398.872599] ath10k_ahb a800000.wifi wlan1.sta11: left allmulticast mode
[29398.872693] ath10k_ahb a800000.wifi wlan1.sta11: left promiscuous mode
[29398.878220] br-wan: port 12(wlan1.sta11) entered disabled state
[29399.138369] ath10k_ahb a800000.wifi: mac flush vdev 0 drop 0 queues
0x1 ar->paused: 0x0  arvif->paused: 0x0
[29399.151185] ath10k_ahb a800000.wifi wlan1.sta9: left allmulticast mode

