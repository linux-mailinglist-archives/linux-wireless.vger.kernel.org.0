Return-Path: <linux-wireless+bounces-7717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD4D8C6CB7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 21:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B281F22259
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607E1598EC;
	Wed, 15 May 2024 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkOShpXv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB315ADA8
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800656; cv=none; b=cxKkgM0+Vp7HCsdQ9GDJh6gBOePgtsmOGF+2xqvc+FDLfQDMkVks5JnSOYQs+r3y7JTKyq/DkxLRbEQPT9UThmf4OwW9vCD558kvpKrX9Legt0y/zxU4Wd0U4hfGTEdyPAGscXSc5/6p9qeKZypAYyhp7zxA0SyJJDMsuasm/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800656; c=relaxed/simple;
	bh=Fc5Ue7D5Sg+CITCUZYLctnnrDeqDQ37u+NohOYhOyJY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=Edj+4XUbG3Innt9ICazgz6WGHwj8mwn2l2B9F/AKltltN3Gi8vsFgknMU8M7e2YvnejHkvX6Y00K037ga+bonODiy2hLT5u6dhoRyu/ibnvc1emLP5hjb0v4N5995DvYGkctmQmbkZGmepyyoFLO3hs9oKec1eoQhe7FqnOJfmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkOShpXv; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9abbb9efbso1279323b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715800653; x=1716405453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hMhZsH60/7gq6I2jknscfswd/xL3UxEm8ULxg8qq1XY=;
        b=YkOShpXvd81scS+FCXBgVmQRquUFbdL+tPEVSgJjbRcnseHekh1tg0SnPGd9/2grQp
         rNdt81eR0ZdPR7/g/QeQI83PUCfrZFNWI9rBc5mr7nlCKXKvpJJdbPgYRt0NnPOAodZH
         VEjDcEOs6TS1pg3rBs0m8uKnn9kFvvYCp5LrMiVaTNf9L9RjC1oEhwBeB9irq7bMCdoT
         odLFcLVvtcJbXfc9sA0J6hDtyx8wbpMb51rZuhEdB0/ItbkoM5UO9zV8dP8GCcJlEBJ6
         EEcq0KxbIDUJWJTXwJnx9o/pYhFNukdY8DV5H/ALFhc2jBn8GvoPFGhkrvoTwBjRWWeN
         zS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715800653; x=1716405453;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMhZsH60/7gq6I2jknscfswd/xL3UxEm8ULxg8qq1XY=;
        b=rs4ADxZNn9sqOpT6pWZBq03hj1FAbNfIsbZTBcQQFxcfxYjDM2gRr/2C8GfSKEW7Mv
         BVvkiitTb3aPMDLz5MGAo7TerQvHWkzbNp8lq/5dLnhx716qW6GlX5iciHwHSxCShFAw
         y/f7ssOiYz6mhtUpvCwwMs105hMEqcl8tx3/zpRFSwu2eBnMJvvhK0MF2jVHLs3uGJxW
         2f2W3KTi2ys2CG551l/pKlTLaDXFfocE57nE50KvORRaspL/TpYWnv1EYypzNPcWadaL
         zZWzuUEU4MSJLcVw30I9UDHvX5CLUVKtm5nsQzeu2y/J459Pq0YbghyIaFtoN6dyBoBY
         oPWg==
X-Gm-Message-State: AOJu0YyRoHXSjakvk6G6mlDNpqscGgyYYXosq5bdzs6iwmIa+dC9/fSQ
	gzSxNCeYKP+i198K0WlIMwIKJNpMciEo3k3RUJS6QvLBX4c5WbdMiwQ7iA==
X-Google-Smtp-Source: AGHT+IEjtTYWhUua2OZ+dwjRlxBeVIo6/oeOEPpXh95xKLcSj+PKpDQfbtsBrqvm5ZV85iYJsygRYQ==
X-Received: by 2002:aca:2812:0:b0:3c9:98b4:d1f6 with SMTP id 5614622812f47-3c998b4d27amr6387712b6e.7.1715800653599;
        Wed, 15 May 2024 12:17:33 -0700 (PDT)
Received: from [192.168.0.166] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c9940efedcsm2171245b6e.8.2024.05.15.12.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 12:17:33 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <898f027b-bf08-4f6b-b0c7-623ca5c5f23c@lwfinger.net>
Date: Wed, 15 May 2024 14:17:32 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Pkshih <pkshih@realtek.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Problem with 8922ae
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping-Ke,

I have been busy with the 8821au driver and had not done anything with the 
8922ae driver in the meantime. Now, I am getting some warhings in the logs:

[ 8783.319543] [  T839] rtw89_8922ae 0000:02:00.0: FW status = 0xb6001220
[ 8783.319552] [  T839] rtw89_8922ae 0000:02:00.0: FW BADADDR = 0x0
[ 8783.319557] [  T839] rtw89_8922ae 0000:02:00.0: FW EPC/RA = 0x20136928
[ 8783.319562] [  T839] rtw89_8922ae 0000:02:00.0: FW MISC = 0x0
[ 8783.319566] [  T839] rtw89_8922ae 0000:02:00.0: R_AX_HALT_C2H = 0x30000007
[ 8783.319571] [  T839] rtw89_8922ae 0000:02:00.0: R_AX_SER_DBG_INFO = 0x0
[ 8783.319575] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319597] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319612] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319627] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319641] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319656] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319671] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319686] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319700] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319715] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319730] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319745] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319759] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319774] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319789] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8783.319800] [  T839] rtw89_8922ae 0000:02:00.0: SER catches error: 0x4000
[ 8783.326029] [T23006] ieee80211 phy1: Hardware restart was requested
[ 8867.101365] [  T839] rtw89_8922ae 0000:02:00.0: FW status = 0xdd001220
[ 8867.101375] [  T839] rtw89_8922ae 0000:02:00.0: FW BADADDR = 0x0
[ 8867.101381] [  T839] rtw89_8922ae 0000:02:00.0: FW EPC/RA = 0x20136928
[ 8867.101386] [  T839] rtw89_8922ae 0000:02:00.0: FW MISC = 0x0
[ 8867.101391] [  T839] rtw89_8922ae 0000:02:00.0: R_AX_HALT_C2H = 0x30000007
[ 8867.101396] [  T839] rtw89_8922ae 0000:02:00.0: R_AX_SER_DBG_INFO = 0x0
[ 8867.101401] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101423] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101439] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101455] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101470] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101485] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101500] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101515] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101529] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101545] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101560] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101575] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101590] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101605] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101620] [  T839] rtw89_8922ae 0000:02:00.0: [ERR]fw PC = 0x2001b780
[ 8867.101632] [  T839] rtw89_8922ae 0000:02:00.0: SER catches error: 0x4000
[ 8867.108241] [T23006] ieee80211 phy1: Hardware restart was requested
[ 8867.108256] [T22691] ------------[ cut here ]------------
[ 8867.108257] [T22691] ieee80211_restart_work called with hardware scan in progress
[ 8867.108285] [T22691] WARNING: CPU: 1 PID: 22691 at net/mac80211/main.c:467 
ieee80211_restart_work+0x136/0x140 [mac80211]
[ 8867.108353] [T22691] Modules linked in: vboxnetadp(OE) vboxnetflt(OE) 
vboxdrv(OE) rfcomm(E) snd_seq_dummy(E) snd_hrtimer(E) snd_seq(E) 
snd_seq_device(E) ccm(E) rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) 
dns_resolver(E) nfs(E) lockd(E) grace(E) sunrpc(E) af_packet(E) cmac(E) 
algif_hash(E) algif_skcipher(E) af_alg(E) qrtr(E) bnep(E) btusb(E) btrtl(E) 
btintel(E) btbcm(E) btmtk(E) bluetooth(E) ecdh_generic(E) binfmt_misc(E) 
nls_iso8859_1(E) nls_cp437(E) rtw89_8922ae(E) vfat(E) rtw89_8922a(E) fat(E) 
rtw89_pci(E) snd_hda_codec_realtek(E) iwlmvm(E) snd_hda_codec_generic(E) 
rtw89_core(E) intel_rapl_msr(E) snd_hda_scodec_component(E) intel_rapl_common(E) 
x86_pkg_temp_thermal(E) iTCO_wdt(E) intel_powerclamp(E) spi_intel_platform(E) 
snd_hda_codec_hdmi(E) mac80211(E) mei_hdcp(E) spi_intel(E) mei_pxp(E) 
coretemp(E) intel_pmc_bxt(E) iTCO_vendor_support(E) snd_hda_intel(E) 
kvm_intel(E) snd_intel_dspcfg(E) iwlwifi(E) snd_hda_codec(E) snd_hwdep(E) 
snd_hda_core(E) libarc4(E) kvm(E) pcspkr(E) cfg80211(E) snd_pcm(E) wmi_bmof(E) 
toshiba_acpi(E)
[ 8867.108409] [T22691]  snd_timer(E) e1000e(E) lpc_ich(E) mei_me(E) 
sparse_keymap(E) snd(E) mei(E) soundcore(E) toshiba_bluetooth(E) industrialio(E) 
thermal(E) tiny_power_button(E) tpm_infineon(E) battery(E) button(E) ac(E) 
joydev(E) fuse(E) loop(E) efi_pstore(E) dm_mod(E) configfs(E) dmi_sysfs(E) 
ext4(E) mbcache(E) jbd2(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) 
polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha512_ssse3(E) 
sha256_ssse3(E) sha1_ssse3(E) i915(E) i2c_algo_bit(E) drm_buddy(E) 
drm_display_helper(E) drm_kms_helper(E) sr_mod(E) cec(E) xhci_pci(E) 
xhci_pci_renesas(E) aesni_intel(E) video(E) rtsx_pci_sdmmc(E) mmc_core(E) 
crypto_simd(E) cryptd(E) cdrom(E) ehci_pci(E) ehci_hcd(E) ttm(E) xhci_hcd(E) 
wmi(E) drm(E) rtsx_pci(E) usbcore(E) serio_raw(E) msr(E)
[ 8867.108461] [T22691] Unloaded tainted modules: acpi_cpufreq(E):1 
ie31200_edac(E):1
[ 8867.108466] [T22691] CPU: 1 PID: 22691 Comm: kworker/1:0 Tainted: G 
OE      6.9.0-rc6-rtw-gdfddbd1faef0 #2 22389bc84921f116568819a110243f5d34dca438
[ 8867.108470] [T22691] Hardware name: TOSHIBA TECRA A50-A/TECRA A50-A, BIOS 
Version 4.50   09/29/2014
[ 8867.108472] [T22691] Workqueue: events_freezable ieee80211_restart_work 
[mac80211]
[ 8867.108521] [T22691] RIP: 0010:ieee80211_restart_work+0x136/0x140 [mac80211]
[ 8867.108566] [T22691] Code: 48 8b bd b8 ea ff ff e8 18 33 c6 ff 5b 5d 41 5c 41 
5d e9 cd a4 37 d3 48 c7 c6 d0 5d 28 c1 48 c7 c7 30 e9 28 c1 e8 4a 16 b0 d2 <0f> 
0b e9 12 ff ff ff 0f 1f 00 0f 1f 44 00 00 53 48 89 fb 48 81 c7
[ 8867.108568] [T22691] RSP: 0018:ffffa68008177e58 EFLAGS: 00010282
[ 8867.108570] [T22691] RAX: 0000000000000000 RBX: ffff915aae0bf3c0 RCX: 
0000000000000027
[ 8867.108572] [T22691] RDX: ffff915b232a3808 RSI: 0000000000000001 RDI: 
ffff915b232a3800
[ 8867.108573] [T22691] RBP: ffff915907b01e88 R08: 0000000000000000 R09: 
ffffa68008177d08
[ 8867.108575] [T22691] R10: ffffa68008177d00 R11: 0000000000000003 R12: 
ffff915b232b5800
[ 8867.108576] [T22691] R13: ffff915907b00900 R14: ffff915907b01e88 R15: 
0000000000000000
[ 8867.108578] [T22691] FS:  0000000000000000(0000) GS:ffff915b23280000(0000) 
knlGS:0000000000000000
[ 8867.108580] [T22691] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8867.108582] [T22691] CR2: 00007f4f247054f8 CR3: 0000000066235006 CR4: 
00000000001706f0
[ 8867.108584] [T22691] Call Trace:
[ 8867.108586] [T22691]  <TASK>
[ 8867.108587] [T22691]  ? ieee80211_restart_work+0x136/0x140 [mac80211 
8391c747405e6378a75b7e6b3ede48d8663d2f79]
[ 8867.108629] [T22691]  ? __warn.cold+0xa8/0x102
[ 8867.108634] [T22691]  ? ieee80211_restart_work+0x136/0x140 [mac80211 
8391c747405e6378a75b7e6b3ede48d8663d2f79]
[ 8867.108675] [T22691]  ? report_bug+0xd0/0x140
[ 8867.108680] [T22691]  ? handle_bug+0x38/0x70
[ 8867.108684] [T22691]  ? exc_invalid_op+0x13/0x60
[ 8867.108687] [T22691]  ? asm_exc_invalid_op+0x16/0x20
[ 8867.108691] [T22691]  ? ieee80211_restart_work+0x136/0x140 [mac80211 
8391c747405e6378a75b7e6b3ede48d8663d2f79]
[ 8867.108734] [T22691]  ? ieee80211_restart_work+0x136/0x140 [mac80211 
8391c747405e6378a75b7e6b3ede48d8663d2f79]
[ 8867.108778] [T22691]  process_one_work+0x17a/0x330
[ 8867.108781] [T22691]  worker_thread+0x2e9/0x400
[ 8867.108784] [T22691]  ? rescuer_thread+0x3e0/0x3e0
[ 8867.108786] [T22691]  kthread+0xcb/0x100
[ 8867.108790] [T22691]  ? kthread_complete_and_exit+0x20/0x20
[ 8867.108793] [T22691]  ret_from_fork+0x2d/0x50
[ 8867.108796] [T22691]  ? kthread_complete_and_exit+0x20/0x20
[ 8867.108799] [T22691]  ret_from_fork_asm+0x11/0x20
[ 8867.108804] [T22691]  </TASK>
[ 8867.108805] [T22691] ---[ end trace 0000000000000000 ]---

This warning came while running a kernel generated from rtw-next with commit 
28818b4d871bc93.

Thanks,

Larry

