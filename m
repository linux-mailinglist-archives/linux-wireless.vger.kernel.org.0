Return-Path: <linux-wireless+bounces-29266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FACAC7E722
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Nov 2025 21:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B9EE341B7B
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Nov 2025 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12975199931;
	Sun, 23 Nov 2025 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk6xjoBP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE04126BF1
	for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763929783; cv=none; b=dMcnWGwopl3xK96GQOh5JJz91mBXJ66p4Hpkh2b8h3IfHYhvBs0M5QX3AhRIObvzCyk9pb44mR58AwaMyqpeCcqWR7oZTcoUkieE0LP8kT5WPHomlrhvdXWytgGOBJFY+2pFJ+mrqxcRL4ISNyfLKtzUeZ7u8PqmCbKOkp6XMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763929783; c=relaxed/simple;
	bh=hV7ZxGT29nv/d6d3I1fvOKp/7Ygz/U08zPiusCslOSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kg9i0J7eI7YUnjI2WUa9v9M+VqBm5buVNHx2P1+MwVbBlb3FFW/9wYhPGjJdiOXoZnmo+6eArreFGjuCtXja5FndyKBjJFg/Y8roj8iplkvU85XSLmHCeL5m3Cdn2TW3jM6EEBLC7QBqZALP+sw4/Kp5+XA/VNjwXbr5pRddFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk6xjoBP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso16802465e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 12:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763929778; x=1764534578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PEvTGSSKI1QnKV7zawY6m4RLLmEAVZqsAG60EOMw5Xc=;
        b=Gk6xjoBPB+aWRrTFw/ng8Mu5h+QNh6WhNBnEtHdDFieryHO5HzrjXLfKn0kHW0mMUu
         jn/RaLBUshGxKT5ZHPn5HIRYmfvKd2vv6BJk/UPIm2xibdWypazWsWX1gRRJQDd8t0cJ
         ZKRJBz0nhHcQUnelLy8dMasoBW7zuDDemo/7TSw7O1n1X4i9aCcV4l3QiBzQ/bYHPdUf
         crXl5LxM7THx+ULekA6iufxbbQzLuBjmM3ifGkWJxe4kVOkn6wYKmS81RIQ3ui8lEQ90
         yjFE0+q+Qs/TNU0INeo27VusX8oDBHmtS+Rv2/3IikQHznZU+YRYZ4k83PydrYRwfbyC
         Abzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763929778; x=1764534578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEvTGSSKI1QnKV7zawY6m4RLLmEAVZqsAG60EOMw5Xc=;
        b=r/oGryubkqa3lpVaWH4iLgIwjIyEWbllsh1MHBTPbqQJEO3HOItIi/MSde8WLaSxph
         MU1lfklZ8vtGHqM5QJc9SCs8OACkTfxdT3/kHOzcPd+k/40ZsdsSup7u0qmiBJGumK2g
         8drw06MsctU9n7Wf1BVZp/OhZ6g2xaPF7l7OBAzJLszaHnDYYgP4Hw3tb0rpv5JMzEMj
         9A13x5ZVUcjIPV1m814NK9b05T/QoEq777lj8MMOIGpUb/Tq3KXia23FJR6/5G+0Pucr
         4hh6pTAru3ZkRkQnb37TLnGHuHalt/xgS1qoy+3OyGoTfn+Amhvn9k8zelCpTpkqni8Y
         7JJg==
X-Forwarded-Encrypted: i=1; AJvYcCVwEBgN2uweHoCp3DSVJbsJasTOXMxoMurqUbpB+KSxRaGre6CySzN1qLE5F2myvg9rFIg0EYnS2RwvxJJt7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZmp+HYMFjxtd3SD790Jb2MlAYi8K51DIV0bomDFg5TVi60z71
	9C84rnSZ8+4qvj27hFqR6CoB1mcosB76Ww3uuR2Z0wrPW5idWIJC82lf
X-Gm-Gg: ASbGncv2m85HIOVET2ap+FDLuzazzi+RsMmUixCp5nbDN4pvesh9EqDR0G9d6aUMlJD
	1b4vFAAHIhnyJseK/sTcoQ1ru14J0T5Ka8//ma5VEtqCyvEuA3fZgxGzpJM8iXbLAprk02M7X44
	sJARn743LHsPedrr3i2xl9/81PrNIYYC1tv4kHwyROiikABh5PuGrAMoOfmwkeX0DsjU9/jMV6Y
	6viWScFZn7kJksjVzaj+lJ/pPJde3QEckYQ4AFKf2vZifRBb8jY8FtKgTsTi2tQJ3ba99Av6jt4
	GlVvfOS7nQ4OxiqkaobpRLCZcnR0DwYnhfZG6qGTsZEYFu3BbepqSAYFiu9jljRySLko1IiNDQo
	IXo2SLDFxFxE/Gb7X+dV2flT2ZVg3BJVV8/vyxHCGqG192soPT8IwAgsVvWlidOBg490tbQwacF
	KnZBq1YlZljGBCKY0Aris=
X-Google-Smtp-Source: AGHT+IE+UOP5s5wUeDkfGE05WueRL80lE8JRU7aM27z/DletiIzu2v9U5zUm4O32XFtq53Iuw2gQ3A==
X-Received: by 2002:a5d:5d12:0:b0:42b:2e39:6d45 with SMTP id ffacd0b85a97d-42cc1cbd047mr9288093f8f.15.1763929777755;
        Sun, 23 Nov 2025 12:29:37 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e5b6sm24043170f8f.1.2025.11.23.12.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 12:29:37 -0800 (PST)
Message-ID: <475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
Date: Sun, 23 Nov 2025 22:29:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
To: Zenm Chen <zenmchen@gmail.com>, gustavo@embeddedor.com
Cc: Jes.Sorensen@gmail.com, gustavoars@kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, pkshih@realtek.com
References: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
 <20251121111132.4435-1-zenmchen@gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20251121111132.4435-1-zenmchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21/11/2025 13:11, Zenm Chen wrote:
> Gustavo A. R. Silva <gustavo@embeddedor.com> =E6=96=BC 2025=E5=B9=B411=E6=
=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:20=E5=AF=AB=E9=81=
=93=EF=BC=9A
>>
>> Hi,
>>
>> On 11/21/25 19:06, Zenm Chen wrote:
>>> Dear maintainers,
>>>
>>> With this patch applied, my system always freezes right after the rtl=
8xxxu
>>> driver is loaded. is it normal?
>>
>> I don't think so... It probably means that struct urb urb; cannot real=
ly be
>> moved to the end of struct rtl8xxxu_rx_urb or struct rtl8xxxu_tx_urb?
>>
>> It'd be great if you could share a log.
>>
>=20
> Hi,
>=20
> Nothing helpful found from the kernel log. Maybe Realtek drivers mainta=
iner
> Ping-Ke could take a look what is wrong next Monday.
>=20
[...]

I got something. In my case everything seemed fine until I unplugged the
wifi adapter. And then the system still worked for a few minutes before
it froze.

Nov 23 14:32:55 ideapad2 kernel: Linux version 6.17.5-arch1-1 (linux@arch=
linux) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU Binutils) 2.45.0) #1 SMP P=
REEMPT_DYNAMIC Thu, 23 Oct 2025 18:49:03 +0000
Nov 23 14:32:55 ideapad2 kernel: Command line: initrd=3D\initramfs-linux.=
img root=3DUUID=3Db5112f42-9fd6-4fd2-b9de-c8b5c1bfe3d7 resume=3DUUID=3Db4=
662085-9bec-4783-b2e4-716e1dc53476 rootfstype=3Dext4 rw add_efi_memmap us=
b_storage.quirks=3D0bda:1a2b:i mitigations=3Doff log_buf_len=3D16M

Nov 23 21:55:51 ideapad2 wpa_supplicant[1392]: wlp3s0f3u2: CTRL-EVENT-SIG=
NAL-CHANGE above=3D0 signal=3D-96 noise=3D9999 txrate=3D300000
Nov 23 21:55:56 ideapad2 wpa_supplicant[1392]: wlp3s0f3u2: CTRL-EVENT-SIG=
NAL-CHANGE above=3D1 signal=3D-92 noise=3D9999 txrate=3D300000
Nov 23 21:55:57 ideapad2 wpa_supplicant[1392]: wlp3s0f3u2: CTRL-EVENT-BEA=
CON-LOSS
Nov 23 21:56:34 ideapad2 kernel: usb 1-2: USB disconnect, device number 6=


Nov 23 21:56:34 ideapad2 kernel: wlp3s0f3u2: deauthenticating from ... by=
 local choice (Reason: 3=3DDEAUTH_LEAVING)

Nov 23 21:56:34 ideapad2 kernel: usb 1-2: disconnecting

Nov 23 21:56:34 ideapad2 kernel: usercopy: Kernel memory overwrite attemp=
t detected to SLUB object 'kmalloc-256' (offset 30, size 250)!
Nov 23 21:56:34 ideapad2 kernel: ------------[ cut here ]------------
Nov 23 21:56:34 ideapad2 kernel: kernel BUG at mm/usercopy.c:102!

Nov 23 21:56:34 ideapad2 kernel: Oops: invalid opcode: 0000 [#1] SMP NOPT=
I
Nov 23 21:56:34 ideapad2 NetworkManager[467]: <info>  [1763927794.3185] r=
adio killswitch /sys/devices/pci0000:00/0000:00:08.1/0000:03:00.3/usb1/1-=
2/1-2:1.0/ieee80211/phy2/rfkill5 disappeared
Nov 23 21:56:34 ideapad2 kernel: CPU: 3 UID: 1000 PID: 950 Comm: pipewire=
-pulse Tainted: G           OE       6.17.5-arch1-1 #1 PREEMPT(full)  01c=
39fc421df2af799dd5e9180b572af860b40c1
Nov 23 21:56:34 ideapad2 kernel: Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNE=
D_MODULE
Nov 23 21:56:34 ideapad2 kernel: Hardware name: LENOVO 82KR/LNVNB161216, =
BIOS HBCN18WW 08/27/2021
Nov 23 21:56:34 ideapad2 kernel: RIP: 0010:usercopy_abort+0x7a/0x7c
Nov 23 21:56:34 ideapad2 kernel: Code: 48 c7 c6 fc fb aa a4 eb 0e 48 c7 c=
7 78 7f ad a4 48 c7 c6 db 32 aa a4 52 48 89 fa 48 c7 c7 80 4b 9f a4 50 41=
 52 e8 66 dc fe ff <0f> 0b 48 89 d9 49 89 e8 48 2b 0a 31 f6 44 89 f2 48 c=
7 c7 3f cf aa
Nov 23 21:56:34 ideapad2 kernel: RSP: 0018:ffffceeac9c57b88 EFLAGS: 00010=
246
Nov 23 21:56:34 ideapad2 kernel: RAX: 0000000000000066 RBX: ffff8d9eeb002=
01e RCX: 0000000000000000
Nov 23 21:56:34 ideapad2 kernel: RDX: 0000000000000000 RSI: 0000000000000=
001 RDI: ffff8da08ed9cfc0
Nov 23 21:56:34 ideapad2 kernel: RBP: 00000000000000fa R08: 0000000000000=
000 R09: 00000000fff7ffff
Nov 23 21:56:34 ideapad2 kernel: R10: ffffffffa619d880 R11: ffffceeac9c57=
a28 R12: ffff8d9eeb002118
Nov 23 21:56:34 ideapad2 kernel: R13: 000000000000013f R14: 0000000000000=
000 R15: 0000000000000000
Nov 23 21:56:34 ideapad2 kernel: FS:  00007f494e17a740(0000) GS:ffff8da0e=
8c86000(0000) knlGS:0000000000000000
Nov 23 21:56:34 ideapad2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Nov 23 21:56:34 ideapad2 kernel: CR2: 00007f4947f70040 CR3: 000000014ccc0=
000 CR4: 00000000003506f0
Nov 23 21:56:34 ideapad2 kernel: Call Trace:
Nov 23 21:56:34 ideapad2 kernel:  <TASK>
Nov 23 21:56:34 ideapad2 kernel:  __check_heap_object+0xea/0x120
Nov 23 21:56:34 ideapad2 kernel:  ? __do_sys_memfd_create+0x91/0x2e0
Nov 23 21:56:34 ideapad2 kernel:  __check_object_size+0x1d2/0x1f0
Nov 23 21:56:34 ideapad2 kernel:  strncpy_from_user+0x30/0x110
Nov 23 21:56:34 ideapad2 kernel:  __do_sys_memfd_create+0xc0/0x2e0
Nov 23 21:56:34 ideapad2 kernel:  do_syscall_64+0x81/0x970
Nov 23 21:56:34 ideapad2 kernel:  ? put_timespec64+0x3a/0x70
Nov 23 21:56:34 ideapad2 kernel:  ? __x64_sys_clock_gettime+0x96/0xd0
Nov 23 21:56:34 ideapad2 kernel:  ? do_syscall_64+0x81/0x970
Nov 23 21:56:34 ideapad2 kernel:  ? do_fault+0x34c/0x5a0
Nov 23 21:56:34 ideapad2 kernel:  ? __handle_mm_fault+0x8d1/0xf10
Nov 23 21:56:34 ideapad2 kernel:  ? do_syscall_64+0x81/0x970
Nov 23 21:56:34 ideapad2 kernel:  ? count_memcg_events+0xc2/0x190
Nov 23 21:56:34 ideapad2 kernel:  ? handle_mm_fault+0x1d7/0x2d0
Nov 23 21:56:34 ideapad2 kernel:  ? do_user_addr_fault+0x21a/0x690
Nov 23 21:56:34 ideapad2 kernel:  ? exc_page_fault+0x7e/0x1a0
Nov 23 21:56:34 ideapad2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Nov 23 21:56:34 ideapad2 kernel: RIP: 0033:0x7f494df1bd6b
Nov 23 21:56:34 ideapad2 kernel: Code: 73 01 c3 48 8b 0d a5 cf 0e 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8=
 3f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 cf 0e 00 f7 d=
8 64 89 01 48
Nov 23 21:56:34 ideapad2 kernel: RSP: 002b:00007ffd9fcf9028 EFLAGS: 00000=
246 ORIG_RAX: 000000000000013f
Nov 23 21:56:34 ideapad2 kernel: RAX: ffffffffffffffda RBX: 000055fc2b84c=
860 RCX: 00007f494df1bd6b
Nov 23 21:56:34 ideapad2 kernel: RDX: 0000000000000000 RSI: 0000000000000=
00b RDI: 00007ffd9fcf9080
Nov 23 21:56:34 ideapad2 kernel: RBP: 00007ffd9fcf9140 R08: 0000000000000=
000 R09: 0000000000000000
Nov 23 21:56:34 ideapad2 kernel: R10: 0000000000000001 R11: 0000000000000=
246 R12: 000000000000000f
Nov 23 21:56:34 ideapad2 kernel: R13: 0000000000000908 R14: 0000000000000=
002 R15: 000055fc2c191790
Nov 23 21:56:34 ideapad2 kernel:  </TASK>
Nov 23 21:56:34 ideapad2 kernel: Modules linked in: rtl8xxxu(OE) uinput c=
cm rtw89_8922au(OE) rtw89_8852cu(OE) rtw89_8852bu(OE) rtw89_8852au(OE) rt=
w89_8851be(OE) rtw89_8851bu(OE) rtw89_8922a(OE) rtw89_8852c(OE) rtw89_885=
2b(OE) rtw89_8852a(OE) rtw89_8851b(OE) rtw89_8852b_common(OE) rtw89_pci(O=
E) rtw89_usb(OE) rtw89_core(OE) mac80211 libarc4 cfg80211 snd_seq_dummy s=
nd_hrtimer rfcomm snd_seq snd_seq_device cmac algif_hash algif_skcipher a=
f_alg snd_sof_amd_acp70 bnep snd_sof_amd_acp63 snd_sof_amd_vangogh snd_so=
f_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_sof_xt=
ensa_dsp snd_sof snd_sof_utils snd_pci_ps snd_soc_acpi_amd_match joydev s=
nd_amd_sdw_acpi intel_rapl_msr soundwire_amd mousedev soundwire_generic_a=
llocation snd_ctl_led soundwire_bus snd_hda_codec_alc269 snd_soc_sdca ee1=
004 snd_hda_scodec_component uvcvideo snd_hda_codec_realtek_lib videobuf2=
_vmalloc snd_soc_core snd_hda_codec_generic snd_hda_codec_atihdmi uvc vid=
eobuf2_memops snd_compress snd_hda_codec_hdmi videobuf2_v4l2 ac97_bus vid=
eobuf2_common amd_atl
Nov 23 21:56:34 ideapad2 kernel:  hid_multitouch videodev snd_pcm_dmaengi=
ne intel_rapl_common snd_hda_intel btusb snd_hda_codec snd_rpl_pci_acp6x =
mc btrtl snd_acp_pci btintel btbcm snd_amd_acpi_mach snd_hda_core btmtk k=
vm_amd snd_acp_legacy_common snd_intel_dspcfg bluetooth snd_intel_sdw_acp=
i polyval_clmulni snd_pci_acp6x snd_hwdep ghash_clmulni_intel snd_pcm snd=
_pci_acp5x aesni_intel sp5100_tco snd_rn_pci_acp3x rapl snd_timer snd ide=
apad_laptop snd_acp_config lenovo_wmi_hotkey_utilities platform_profile w=
mi_bmof vfat snd_soc_acpi i2c_piix4 fat sparse_keymap acpi_cpufreq k10tem=
p i2c_smbus snd_pci_acp3x rfkill soundcore ccp i2c_hid_acpi i2c_hid mac_h=
id vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) kvm irqbypass i2c_dev crypto=
_user ntsync loop dm_mod nfnetlink ip_tables x_tables amdgpu amdxcp i2c_a=
lgo_bit drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper drm_pan=
el_backlight_quirks video drm_buddy serio_raw nvme drm_display_helper sdh=
ci_acpi cec nvme_core sdhci wmi nvme_keyring mmc_core nvme_auth
Nov 23 21:56:34 ideapad2 kernel: Unloaded tainted modules: rtl8xxxu(OE):1=
 [last unloaded: rtl8xxxu(OE)]
Nov 23 21:56:34 ideapad2 kernel: ---[ end trace 0000000000000000 ]---
Nov 23 21:56:34 ideapad2 kernel: RIP: 0010:usercopy_abort+0x7a/0x7c
Nov 23 21:56:34 ideapad2 kernel: Code: 48 c7 c6 fc fb aa a4 eb 0e 48 c7 c=
7 78 7f ad a4 48 c7 c6 db 32 aa a4 52 48 89 fa 48 c7 c7 80 4b 9f a4 50 41=
 52 e8 66 dc fe ff <0f> 0b 48 89 d9 49 89 e8 48 2b 0a 31 f6 44 89 f2 48 c=
7 c7 3f cf aa
Nov 23 21:56:34 ideapad2 kernel: RSP: 0018:ffffceeac9c57b88 EFLAGS: 00010=
246
Nov 23 21:56:34 ideapad2 kernel: RAX: 0000000000000066 RBX: ffff8d9eeb002=
01e RCX: 0000000000000000
Nov 23 21:56:34 ideapad2 kernel: RDX: 0000000000000000 RSI: 0000000000000=
001 RDI: ffff8da08ed9cfc0
Nov 23 21:56:34 ideapad2 kernel: RBP: 00000000000000fa R08: 0000000000000=
000 R09: 00000000fff7ffff
Nov 23 21:56:34 ideapad2 kernel: R10: ffffffffa619d880 R11: ffffceeac9c57=
a28 R12: ffff8d9eeb002118
Nov 23 21:56:34 ideapad2 kernel: R13: 000000000000013f R14: 0000000000000=
000 R15: 0000000000000000
Nov 23 21:56:34 ideapad2 kernel: FS:  00007f494e17a740(0000) GS:ffff8da0e=
8c86000(0000) knlGS:0000000000000000
Nov 23 21:56:34 ideapad2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Nov 23 21:56:34 ideapad2 kernel: CR2: 00007f4947f70040 CR3: 000000014ccc0=
000 CR4: 00000000003506f0
Nov 23 21:56:35 ideapad2 kernel: usercopy: Kernel memory overwrite attemp=
t detected to SLUB object 'kmalloc-256' (offset 30, size 250)!
Nov 23 21:56:35 ideapad2 kernel: ------------[ cut here ]------------
Nov 23 21:56:35 ideapad2 kernel: kernel BUG at mm/usercopy.c:102!
Nov 23 21:56:35 ideapad2 kernel: Oops: invalid opcode: 0000 [#2] SMP NOPT=
I
Nov 23 21:56:35 ideapad2 kernel: CPU: 3 UID: 1000 PID: 16545 Comm: thunde=
rbird Tainted: G      D    OE       6.17.5-arch1-1 #1 PREEMPT(full)  01c3=
9fc421df2af799dd5e9180b572af860b40c1
Nov 23 21:56:35 ideapad2 kernel: Tainted: [D]=3DDIE, [O]=3DOOT_MODULE, [E=
]=3DUNSIGNED_MODULE
Nov 23 21:56:35 ideapad2 kernel: Hardware name: LENOVO 82KR/LNVNB161216, =
BIOS HBCN18WW 08/27/2021
Nov 23 21:56:35 ideapad2 kernel: RIP: 0010:usercopy_abort+0x7a/0x7c
Nov 23 21:56:35 ideapad2 kernel: Code: 48 c7 c6 fc fb aa a4 eb 0e 48 c7 c=
7 78 7f ad a4 48 c7 c6 db 32 aa a4 52 48 89 fa 48 c7 c7 80 4b 9f a4 50 41=
 52 e8 66 dc fe ff <0f> 0b 48 89 d9 49 89 e8 48 2b 0a 31 f6 44 89 f2 48 c=
7 c7 3f cf aa
Nov 23 21:56:35 ideapad2 kernel: RSP: 0018:ffffceeac0f73d68 EFLAGS: 00010=
246
Nov 23 21:56:35 ideapad2 kernel: RAX: 0000000000000066 RBX: ffff8d9eeb002=
f1e RCX: 0000000000000000
Nov 23 21:56:35 ideapad2 kernel: RDX: 0000000000000000 RSI: 0000000000000=
001 RDI: ffff8da08ed9cfc0
Nov 23 21:56:35 ideapad2 kernel: RBP: 00000000000000fa R08: 0000000000000=
000 R09: 00000000fff7ffff
Nov 23 21:56:35 ideapad2 kernel: R10: ffffffffa619d880 R11: ffffceeac0f73=
c08 R12: ffff8d9eeb003018
Nov 23 21:56:35 ideapad2 kernel: R13: 000000000000013f R14: 0000000000000=
000 R15: 0000000000000000
Nov 23 21:56:35 ideapad2 kernel: FS:  00007f7b885127c0(0000) GS:ffff8da0e=
8c86000(0000) knlGS:00007f7600000000
Nov 23 21:56:35 ideapad2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Nov 23 21:56:35 ideapad2 kernel: CR2: 00007f7b454f4000 CR3: 0000000186d0f=
000 CR4: 00000000003506f0
Nov 23 21:56:35 ideapad2 kernel: Call Trace:
Nov 23 21:56:35 ideapad2 kernel:  <TASK>
Nov 23 21:56:35 ideapad2 kernel:  __check_heap_object+0xea/0x120
Nov 23 21:56:35 ideapad2 kernel:  ? __do_sys_memfd_create+0x91/0x2e0
Nov 23 21:56:35 ideapad2 kernel:  __check_object_size+0x1d2/0x1f0
Nov 23 21:56:35 ideapad2 kernel:  strncpy_from_user+0x30/0x110
Nov 23 21:56:35 ideapad2 kernel:  __do_sys_memfd_create+0xc0/0x2e0
Nov 23 21:56:35 ideapad2 kernel:  ? do_syscall_64+0x81/0x970
Nov 23 21:56:35 ideapad2 kernel:  do_syscall_64+0x81/0x970
Nov 23 21:56:35 ideapad2 kernel:  ? tick_nohz_handler+0xb1/0x140
Nov 23 21:56:35 ideapad2 kernel:  ? timerqueue_add+0xae/0xd0
Nov 23 21:56:35 ideapad2 kernel:  ? __hrtimer_run_queues+0x164/0x2a0
Nov 23 21:56:35 ideapad2 kernel:  ? rcu_accelerate_cbs+0x27/0x90
Nov 23 21:56:35 ideapad2 kernel:  ? rcu_core+0x199/0x380
Nov 23 21:56:35 ideapad2 kernel:  ? handle_softirqs+0x192/0x2a0
Nov 23 21:56:35 ideapad2 kernel:  ? __irq_exit_rcu+0x4c/0xf0
Nov 23 21:56:35 ideapad2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Nov 23 21:56:35 ideapad2 kernel: RIP: 0033:0x7f7b87f1bd6b
Nov 23 21:56:35 ideapad2 kernel: Code: 73 01 c3 48 8b 0d a5 cf 0e 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8=
 3f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 cf 0e 00 f7 d=
8 64 89 01 48
Nov 23 21:56:35 ideapad2 kernel: RSP: 002b:00007ffe45e67df8 EFLAGS: 00000=
206 ORIG_RAX: 000000000000013f
Nov 23 21:56:35 ideapad2 kernel: RAX: ffffffffffffffda RBX: 0000000000001=
000 RCX: 00007f7b87f1bd6b
Nov 23 21:56:35 ideapad2 kernel: RDX: 0000000000000000 RSI: 0000000100000=
00b RDI: 00007f7b790982d8
Nov 23 21:56:35 ideapad2 kernel: RBP: 0000000000000000 R08: 0000000000000=
001 R09: 00007ffe45e67f24
Nov 23 21:56:35 ideapad2 kernel: R10: a317c9d9e8f775f4 R11: 0000000000000=
206 R12: 00007f7b424a6928
Nov 23 21:56:35 ideapad2 kernel: R13: 00007ffe45e67ea0 R14: 00007ffe45e67=
ef0 R15: 0000000000001000
Nov 23 21:56:35 ideapad2 kernel:  </TASK>
Nov 23 21:56:35 ideapad2 kernel: Modules linked in: rtl8xxxu(OE) uinput c=
cm rtw89_8922au(OE) rtw89_8852cu(OE) rtw89_8852bu(OE) rtw89_8852au(OE) rt=
w89_8851be(OE) rtw89_8851bu(OE) rtw89_8922a(OE) rtw89_8852c(OE) rtw89_885=
2b(OE) rtw89_8852a(OE) rtw89_8851b(OE) rtw89_8852b_common(OE) rtw89_pci(O=
E) rtw89_usb(OE) rtw89_core(OE) mac80211 libarc4 cfg80211 snd_seq_dummy s=
nd_hrtimer rfcomm snd_seq snd_seq_device cmac algif_hash algif_skcipher a=
f_alg snd_sof_amd_acp70 bnep snd_sof_amd_acp63 snd_sof_amd_vangogh snd_so=
f_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_sof_xt=
ensa_dsp snd_sof snd_sof_utils snd_pci_ps snd_soc_acpi_amd_match joydev s=
nd_amd_sdw_acpi intel_rapl_msr soundwire_amd mousedev soundwire_generic_a=
llocation snd_ctl_led soundwire_bus snd_hda_codec_alc269 snd_soc_sdca ee1=
004 snd_hda_scodec_component uvcvideo snd_hda_codec_realtek_lib videobuf2=
_vmalloc snd_soc_core snd_hda_codec_generic snd_hda_codec_atihdmi uvc vid=
eobuf2_memops snd_compress snd_hda_codec_hdmi videobuf2_v4l2 ac97_bus vid=
eobuf2_common amd_atl
Nov 23 21:56:35 ideapad2 kernel:  hid_multitouch videodev snd_pcm_dmaengi=
ne intel_rapl_common snd_hda_intel btusb snd_hda_codec snd_rpl_pci_acp6x =
mc btrtl snd_acp_pci btintel btbcm snd_amd_acpi_mach snd_hda_core btmtk k=
vm_amd snd_acp_legacy_common snd_intel_dspcfg bluetooth snd_intel_sdw_acp=
i polyval_clmulni snd_pci_acp6x snd_hwdep ghash_clmulni_intel snd_pcm snd=
_pci_acp5x aesni_intel sp5100_tco snd_rn_pci_acp3x rapl snd_timer snd ide=
apad_laptop snd_acp_config lenovo_wmi_hotkey_utilities platform_profile w=
mi_bmof vfat snd_soc_acpi i2c_piix4 fat sparse_keymap acpi_cpufreq k10tem=
p i2c_smbus snd_pci_acp3x rfkill soundcore ccp i2c_hid_acpi i2c_hid mac_h=
id vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) kvm irqbypass i2c_dev crypto=
_user ntsync loop dm_mod nfnetlink ip_tables x_tables amdgpu amdxcp i2c_a=
lgo_bit drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper drm_pan=
el_backlight_quirks video drm_buddy serio_raw nvme drm_display_helper sdh=
ci_acpi cec nvme_core sdhci wmi nvme_keyring mmc_core nvme_auth
Nov 23 21:56:35 ideapad2 kernel: Unloaded tainted modules: rtl8xxxu(OE):1=
 [last unloaded: rtl8xxxu(OE)]
Nov 23 21:56:35 ideapad2 kernel: ---[ end trace 0000000000000000 ]---
Nov 23 21:56:35 ideapad2 kernel: RIP: 0010:usercopy_abort+0x7a/0x7c
Nov 23 21:56:35 ideapad2 kernel: Code: 48 c7 c6 fc fb aa a4 eb 0e 48 c7 c=
7 78 7f ad a4 48 c7 c6 db 32 aa a4 52 48 89 fa 48 c7 c7 80 4b 9f a4 50 41=
 52 e8 66 dc fe ff <0f> 0b 48 89 d9 49 89 e8 48 2b 0a 31 f6 44 89 f2 48 c=
7 c7 3f cf aa
Nov 23 21:56:35 ideapad2 kernel: RSP: 0018:ffffceeac9c57b88 EFLAGS: 00010=
246
Nov 23 21:56:35 ideapad2 kernel: RAX: 0000000000000066 RBX: ffff8d9eeb002=
01e RCX: 0000000000000000
Nov 23 21:56:35 ideapad2 kernel: RDX: 0000000000000000 RSI: 0000000000000=
001 RDI: ffff8da08ed9cfc0
Nov 23 21:56:35 ideapad2 kernel: RBP: 00000000000000fa R08: 0000000000000=
000 R09: 00000000fff7ffff
Nov 23 21:56:35 ideapad2 kernel: R10: ffffffffa619d880 R11: ffffceeac9c57=
a28 R12: ffff8d9eeb002118
Nov 23 21:56:35 ideapad2 kernel: R13: 000000000000013f R14: 0000000000000=
000 R15: 0000000000000000
Nov 23 21:56:35 ideapad2 kernel: FS:  00007f7b885127c0(0000) GS:ffff8da0e=
8c86000(0000) knlGS:00007f7600000000
Nov 23 21:56:35 ideapad2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Nov 23 21:56:35 ideapad2 kernel: CR2: 00007f7b454f4000 CR3: 0000000186d0f=
000 CR4: 00000000003506f0

Nov 23 21:57:04 ideapad2 kded6[801]: ALSA lib pcm_dmix.c:1000:(snd_pcm_dm=
ix_open) unable to open slave
Nov 23 21:57:04 ideapad2 kded6[801]: Failed to play sound with canberra: =
IO error
Nov 23 22:00:23 ideapad2 systemd[605]: tmux-spawn-4357e0b9-3ff9-4bed-b43f=
-44b5af7e6726.scope: Consumed 2min 4.555s CPU time, 4.5G memory peak.
Nov 23 22:00:28 ideapad2 systemd[605]: tmux-spawn-5190b6e1-506e-4427-a912=
-986c0b18a4f1.scope: Consumed 17.101s CPU time, 46.7M memory peak.
Nov 23 22:00:31 ideapad2 su[1321]: pam_unix(su:session): session closed f=
or user root
Nov 23 22:00:31 ideapad2 systemd[605]: tmux-spawn-f0d674d1-8dd9-46d4-9cbd=
-e6287a41dd03.scope: Consumed 1.427s CPU time, 69M memory peak.
Nov 23 22:00:33 ideapad2 systemd[605]: app-org.kde.konsole@061205b39e534f=
a7bbae71a4d17052ed.service: Consumed 3.282s CPU time, 50.5M memory peak.
Nov 23 22:00:33 ideapad2 systemd[605]: app-org.kde.konsole-1245.scope: Co=
nsumed 12.682s CPU time, 35M memory peak.
Nov 23 22:00:42 ideapad2 kernel: ------------[ cut here ]------------
Nov 23 22:00:42 ideapad2 kernel: refcount_t: saturated; leaking memory.
Nov 23 22:00:42 ideapad2 kernel: WARNING: CPU: 2 PID: 715 at lib/refcount=
=2Ec:22 refcount_warn_saturate+0x55/0x110
Nov 23 22:00:42 ideapad2 kernel: Modules linked in: rtl8xxxu(OE) uinput c=
cm rtw89_8922au(OE) rtw89_8852cu(OE) rtw89_8852bu(OE) rtw89_8852au(OE) rt=
w89_8851be(OE) rtw89_8851bu(OE) rtw89_8922a(OE) rtw89_8852c(OE) rtw89_885=
2b(OE) rtw89_8852a(OE) rtw89_8851b(OE) rtw89_8852b_common(OE) rtw89_pci(O=
E) rtw89_usb(OE) rtw89_core(OE) mac80211 libarc4 cfg80211 snd_seq_dummy s=
nd_hrtimer rfcomm snd_seq snd_seq_device cmac algif_hash algif_skcipher a=
f_alg snd_sof_amd_acp70 bnep snd_sof_amd_acp63 snd_sof_amd_vangogh snd_so=
f_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_sof_xt=
ensa_dsp snd_sof snd_sof_utils snd_pci_ps snd_soc_acpi_amd_match joydev s=
nd_amd_sdw_acpi intel_rapl_msr soundwire_amd mousedev soundwire_generic_a=
llocation snd_ctl_led soundwire_bus snd_hda_codec_alc269 snd_soc_sdca ee1=
004 snd_hda_scodec_component uvcvideo snd_hda_codec_realtek_lib videobuf2=
_vmalloc snd_soc_core snd_hda_codec_generic snd_hda_codec_atihdmi uvc vid=
eobuf2_memops snd_compress snd_hda_codec_hdmi videobuf2_v4l2 ac97_bus vid=
eobuf2_common amd_atl
Nov 23 22:00:42 ideapad2 kernel:  hid_multitouch videodev snd_pcm_dmaengi=
ne intel_rapl_common snd_hda_intel btusb snd_hda_codec snd_rpl_pci_acp6x =
mc btrtl snd_acp_pci btintel btbcm snd_amd_acpi_mach snd_hda_core btmtk k=
vm_amd snd_acp_legacy_common snd_intel_dspcfg bluetooth snd_intel_sdw_acp=
i polyval_clmulni snd_pci_acp6x snd_hwdep ghash_clmulni_intel snd_pcm snd=
_pci_acp5x aesni_intel sp5100_tco snd_rn_pci_acp3x rapl snd_timer snd ide=
apad_laptop snd_acp_config lenovo_wmi_hotkey_utilities platform_profile w=
mi_bmof vfat snd_soc_acpi i2c_piix4 fat sparse_keymap acpi_cpufreq k10tem=
p i2c_smbus snd_pci_acp3x rfkill soundcore ccp i2c_hid_acpi i2c_hid mac_h=
id vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) kvm irqbypass i2c_dev crypto=
_user ntsync loop dm_mod nfnetlink ip_tables x_tables amdgpu amdxcp i2c_a=
lgo_bit drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper drm_pan=
el_backlight_quirks video drm_buddy serio_raw nvme drm_display_helper sdh=
ci_acpi cec nvme_core sdhci wmi nvme_keyring mmc_core nvme_auth
Nov 23 22:00:42 ideapad2 kernel: Unloaded tainted modules: rtl8xxxu(OE):1=
 [last unloaded: rtl8xxxu(OE)]
Nov 23 22:00:42 ideapad2 kernel: CPU: 2 UID: 1000 PID: 715 Comm: eDP-1 Ta=
inted: G      D    OE       6.17.5-arch1-1 #1 PREEMPT(full)  01c39fc421df=
2af799dd5e9180b572af860b40c1
Nov 23 22:00:42 ideapad2 kernel: Tainted: [D]=3DDIE, [O]=3DOOT_MODULE, [E=
]=3DUNSIGNED_MODULE
Nov 23 22:00:42 ideapad2 kernel: Hardware name: LENOVO 82KR/LNVNB161216, =
BIOS HBCN18WW 08/27/2021
Nov 23 22:00:42 ideapad2 kernel: RIP: 0010:refcount_warn_saturate+0x55/0x=
110
Nov 23 22:00:42 ideapad2 kernel: Code: 84 bc 00 00 00 c3 cc cc cc cc 85 f=
6 74 46 80 3d 6a d9 d0 01 00 75 ee 48 c7 c7 18 d3 a1 a4 c6 05 5a d9 d0 01=
 01 e8 9b 0b 7d ff <0f> 0b c3 cc cc cc cc 80 3d 43 d9 d0 01 00 75 cb 48 c=
7 c7 c8 d3 a1
Nov 23 22:00:42 ideapad2 kernel: RSP: 0018:ffffceeaca82f7d8 EFLAGS: 00010=
246
Nov 23 22:00:42 ideapad2 kernel: RAX: 0000000000000000 RBX: ffff8d9e86a69=
800 RCX: 0000000000000027
Nov 23 22:00:42 ideapad2 kernel: RDX: ffff8da08ed1cfc8 RSI: 0000000000000=
001 RDI: ffff8da08ed1cfc0
Nov 23 22:00:42 ideapad2 kernel: RBP: ffff8d9e007e6318 R08: 0000000000000=
000 R09: 00000000fff7ffff
Nov 23 22:00:42 ideapad2 kernel: R10: ffffffffa619d880 R11: ffffceeaca82f=
670 R12: ffff8d9e86a69800
Nov 23 22:00:42 ideapad2 kernel: R13: ffff8d9e007e6400 R14: ffff8d9e86a69=
858 R15: 0000000000000001
Nov 23 22:00:42 ideapad2 kernel: FS:  00007f59e78816c0(0000) GS:ffff8da0e=
8c06000(0000) knlGS:0000000000000000
Nov 23 22:00:42 ideapad2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Nov 23 22:00:42 ideapad2 kernel: CR2: 00007fe1c8273000 CR3: 000000010a3e6=
000 CR4: 00000000003506f0
Nov 23 22:00:42 ideapad2 kernel: Call Trace:
Nov 23 22:00:42 ideapad2 kernel:  <TASK>
Nov 23 22:00:42 ideapad2 kernel:  drm_property_blob_get+0x12/0x20
Nov 23 22:00:42 ideapad2 kernel:  amdgpu_dm_plane_drm_plane_duplicate_sta=
te+0xba/0x120 [amdgpu 02022ce4aee5e37157721ed7588d157409a3623e]
Nov 23 22:00:42 ideapad2 kernel:  drm_atomic_get_plane_state+0xa4/0x1a0
Nov 23 22:00:42 ideapad2 kernel:  drm_atomic_set_property+0x2bd/0xd60
Nov 23 22:00:42 ideapad2 kernel:  drm_mode_atomic_ioctl+0x235/0xcf0
Nov 23 22:00:42 ideapad2 kernel:  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10=

Nov 23 22:00:42 ideapad2 kernel:  drm_ioctl_kernel+0xab/0x100
Nov 23 22:00:42 ideapad2 kernel:  drm_ioctl+0x29b/0x550
Nov 23 22:00:42 ideapad2 kernel:  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10=

Nov 23 22:00:42 ideapad2 kernel:  amdgpu_drm_ioctl+0x4a/0x90 [amdgpu 0202=
2ce4aee5e37157721ed7588d157409a3623e]
Nov 23 22:00:42 ideapad2 kernel:  __x64_sys_ioctl+0x94/0xe0
Nov 23 22:00:42 ideapad2 kernel:  do_syscall_64+0x81/0x970
Nov 23 22:00:42 ideapad2 kernel:  ? schedule+0x27/0xd0
Nov 23 22:00:42 ideapad2 kernel:  ? do_nanosleep+0x66/0x170
Nov 23 22:00:42 ideapad2 kernel:  ? __rseq_handle_notify_resume+0xa6/0x49=
0
Nov 23 22:00:42 ideapad2 kernel:  ? switch_fpu_return+0x4e/0xd0
Nov 23 22:00:42 ideapad2 kernel:  ? do_syscall_64+0x229/0x970
Nov 23 22:00:42 ideapad2 kernel:  ? do_futex+0x11f/0x190
Nov 23 22:00:42 ideapad2 kernel:  ? __x64_sys_futex+0x12d/0x210
Nov 23 22:00:42 ideapad2 kernel:  ? do_futex+0xc5/0x190
Nov 23 22:00:42 ideapad2 kernel:  ? do_syscall_64+0x81/0x970
Nov 23 22:00:42 ideapad2 kernel:  ? switch_fpu_return+0x4e/0xd0
Nov 23 22:00:42 ideapad2 kernel:  ? do_syscall_64+0x229/0x970
Nov 23 22:00:42 ideapad2 kernel:  ? put_timespec64+0x3a/0x70
Nov 23 22:00:42 ideapad2 kernel:  ? ksys_write+0xcd/0xf0
Nov 23 22:00:42 ideapad2 kernel:  ? do_syscall_64+0x81/0x970
Nov 23 22:00:42 ideapad2 kernel:  ? do_syscall_64+0x229/0x970
Nov 23 22:00:42 ideapad2 kernel:  ? exit_to_user_mode_loop+0xcf/0x150
Nov 23 22:00:42 ideapad2 kernel:  ? do_syscall_64+0x229/0x970
Nov 23 22:00:42 ideapad2 kernel:  ? exit_to_user_mode_loop+0xcf/0x150
Nov 23 22:00:42 ideapad2 kernel:  ? do_syscall_64+0x229/0x970
Nov 23 22:00:42 ideapad2 kernel:  ? __irq_exit_rcu+0x4c/0xf0
Nov 23 22:00:42 ideapad2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Nov 23 22:00:42 ideapad2 kernel: RIP: 0033:0x7f5a03b1674d
Nov 23 22:00:42 ideapad2 kernel: Code: 04 25 28 00 00 00 48 89 45 c8 31 c=
0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8=
 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 2=
5 28 00 00 00
Nov 23 22:00:42 ideapad2 kernel: RSP: 002b:00007f59e7880500 EFLAGS: 00000=
246 ORIG_RAX: 0000000000000010
Nov 23 22:00:42 ideapad2 kernel: RAX: ffffffffffffffda RBX: 00007f59e0006=
6b0 RCX: 00007f5a03b1674d
Nov 23 22:00:42 ideapad2 kernel: RDX: 00007f59e78805f0 RSI: 00000000c0386=
4bc RDI: 0000000000000013
Nov 23 22:00:42 ideapad2 kernel: RBP: 00007f59e7880550 R08: 00007f59e0007=
d24 R09: 00007f59e0006358
Nov 23 22:00:42 ideapad2 kernel: R10: 0000000000000005 R11: 0000000000000=
246 R12: 00007f59e78805f0
Nov 23 22:00:42 ideapad2 kernel: R13: 00000000c03864bc R14: 0000000000000=
013 R15: 00007f59e0007ce0
Nov 23 22:00:42 ideapad2 kernel:  </TASK>
Nov 23 22:00:42 ideapad2 kernel: ---[ end trace 0000000000000000 ]---
Nov 23 22:00:42 ideapad2 kernel: ------------[ cut here ]------------
Nov 23 22:00:42 ideapad2 kernel: refcount_t: underflow; use-after-free.
Nov 23 22:00:42 ideapad2 kernel: WARNING: CPU: 0 PID: 13624 at lib/refcou=
nt.c:28 refcount_warn_saturate+0xbe/0x110
Nov 23 22:00:42 ideapad2 kernel: Modules linked in: rtl8xxxu(OE) uinput c=
cm rtw89_8922au(OE) rtw89_8852cu(OE) rtw89_8852bu(OE) rtw89_8852au(OE) rt=
w89_8851be(OE) rtw89_8851bu(OE) rtw89_8922a(OE) rtw89_8852c(OE) rtw89_885=
2b(OE) rtw89_8852a(OE) rtw89_8851b(OE) rtw89_8852b_common(OE) rtw89_pci(O=
E) rtw89_usb(OE) rtw89_core(OE) mac80211 libarc4 cfg80211 snd_seq_dummy s=
nd_hrtimer rfcomm snd_seq snd_seq_device cmac algif_hash algif_skcipher a=
f_alg snd_sof_amd_acp70 bnep snd_sof_amd_acp63 snd_sof_amd_vangogh snd_so=
f_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_sof_xt=
ensa_dsp snd_sof snd_sof_utils snd_pci_ps snd_soc_acpi_amd_match joydev s=
nd_amd_sdw_acpi intel_rapl_msr soundwire_amd mousedev soundwire_generic_a=
llocation snd_ctl_led soundwire_bus snd_hda_codec_alc269 snd_soc_sdca ee1=
004 snd_hda_scodec_component uvcvideo snd_hda_codec_realtek_lib videobuf2=
_vmalloc snd_soc_core snd_hda_codec_generic snd_hda_codec_atihdmi uvc vid=
eobuf2_memops snd_compress snd_hda_codec_hdmi videobuf2_v4l2 ac97_bus vid=
eobuf2_common amd_atl
Nov 23 22:00:42 ideapad2 kernel:  hid_multitouch videodev snd_pcm_dmaengi=
ne intel_rapl_common snd_hda_intel btusb snd_hda_codec snd_rpl_pci_acp6x =
mc btrtl snd_acp_pci btintel btbcm snd_amd_acpi_mach snd_hda_core btmtk k=
vm_amd snd_acp_legacy_common snd_intel_dspcfg bluetooth snd_intel_sdw_acp=
i polyval_clmulni snd_pci_acp6x snd_hwdep ghash_clmulni_intel snd_pcm snd=
_pci_acp5x aesni_intel sp5100_tco snd_rn_pci_acp3x rapl snd_timer snd ide=
apad_laptop snd_acp_config lenovo_wmi_hotkey_utilities platform_profile w=
mi_bmof vfat snd_soc_acpi i2c_piix4 fat sparse_keymap acpi_cpufreq k10tem=
p i2c_smbus snd_pci_acp3x rfkill soundcore ccp i2c_hid_acpi i2c_hid mac_h=
id vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) kvm irqbypass i2c_dev crypto=
_user ntsync loop dm_mod nfnetlink ip_tables x_tables amdgpu amdxcp i2c_a=
lgo_bit drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper drm_pan=
el_backlight_quirks video drm_buddy serio_raw nvme drm_display_helper sdh=
ci_acpi cec nvme_core sdhci wmi nvme_keyring mmc_core nvme_auth
Nov 23 22:00:42 ideapad2 kernel: Unloaded tainted modules: rtl8xxxu(OE):1=
 [last unloaded: rtl8xxxu(OE)]
Nov 23 22:00:42 ideapad2 kernel: CPU: 0 UID: 0 PID: 13624 Comm: kworker/u=
16:3 Tainted: G      D W  OE       6.17.5-arch1-1 #1 PREEMPT(full)  01c39=
fc421df2af799dd5e9180b572af860b40c1
Nov 23 22:00:42 ideapad2 kernel: Tainted: [D]=3DDIE, [W]=3DWARN, [O]=3DOO=
T_MODULE, [E]=3DUNSIGNED_MODULE
Nov 23 22:00:42 ideapad2 kernel: Hardware name: LENOVO 82KR/LNVNB161216, =
BIOS HBCN18WW 08/27/2021
Nov 23 22:00:42 ideapad2 kernel: Workqueue: events_unbound commit_work
Nov 23 22:00:42 ideapad2 kernel: RIP: 0010:refcount_warn_saturate+0xbe/0x=
110
Nov 23 22:00:42 ideapad2 kernel: Code: 01 01 e8 55 0b 7d ff 0f 0b c3 cc c=
c cc cc 80 3d ff d8 d0 01 00 75 85 48 c7 c7 70 d3 a1 a4 c6 05 ef d8 d0 01=
 01 e8 32 0b 7d ff <0f> 0b c3 cc cc cc cc 80 3d dd d8 d0 01 00 0f 85 5e f=
f ff ff 48 c7
Nov 23 22:00:42 ideapad2 kernel: RSP: 0018:ffffceead3787de8 EFLAGS: 00010=
246
Nov 23 22:00:42 ideapad2 kernel: RAX: 0000000000000000 RBX: ffff8d9e007e6=
318 RCX: 0000000000000027
Nov 23 22:00:42 ideapad2 kernel: RDX: ffff8da08ec1cfc8 RSI: 0000000000000=
001 RDI: ffff8da08ec1cfc0
Nov 23 22:00:42 ideapad2 kernel: RBP: ffff8d9e86a69800 R08: 0000000000000=
000 R09: 00000000fff7ffff
Nov 23 22:00:42 ideapad2 kernel: R10: ffffffffa619d880 R11: ffffceead3787=
c80 R12: ffff8d9e8ac80010
Nov 23 22:00:42 ideapad2 kernel: R13: 0000000000000003 R14: 0000000000000=
003 R15: ffff8d9f15d6b4d8
Nov 23 22:00:42 ideapad2 kernel: FS:  0000000000000000(0000) GS:ffff8da0e=
8b06000(0000) knlGS:0000000000000000
Nov 23 22:00:42 ideapad2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Nov 23 22:00:42 ideapad2 kernel: CR2: 00007fe1c8164000 CR3: 0000000143546=
000 CR4: 00000000003506f0
Nov 23 22:00:42 ideapad2 kernel: Call Trace:
Nov 23 22:00:42 ideapad2 kernel:  <TASK>
Nov 23 22:00:42 ideapad2 kernel:  amdgpu_dm_plane_drm_plane_destroy_state=
+0x44/0x90 [amdgpu 02022ce4aee5e37157721ed7588d157409a3623e]
Nov 23 22:00:42 ideapad2 kernel:  drm_atomic_state_default_clear+0x1b7/0x=
2d0
Nov 23 22:00:42 ideapad2 kernel:  __drm_atomic_state_free+0x71/0xb0
Nov 23 22:00:42 ideapad2 kernel:  process_one_work+0x190/0x350
Nov 23 22:00:42 ideapad2 kernel:  worker_thread+0x2d7/0x410
Nov 23 22:00:42 ideapad2 kernel:  ? __pfx_worker_thread+0x10/0x10
Nov 23 22:00:42 ideapad2 kernel:  kthread+0xf9/0x240
Nov 23 22:00:42 ideapad2 kernel:  ? __pfx_kthread+0x10/0x10
Nov 23 22:00:42 ideapad2 kernel:  ? __pfx_kthread+0x10/0x10
Nov 23 22:00:42 ideapad2 kernel:  ret_from_fork+0x1c1/0x1f0
Nov 23 22:00:42 ideapad2 kernel:  ? __pfx_kthread+0x10/0x10
Nov 23 22:00:42 ideapad2 kernel:  ret_from_fork_asm+0x1a/0x30
Nov 23 22:00:42 ideapad2 kernel:  </TASK>
Nov 23 22:00:42 ideapad2 kernel: ---[ end trace 0000000000000000 ]---
Nov 23 22:00:42 ideapad2 kernel: BUG: kernel NULL pointer dereference, ad=
dress: 00000000000000b0
Nov 23 22:00:42 ideapad2 kernel: #PF: supervisor write access in kernel m=
ode
Nov 23 22:00:43 ideapad2 kernel: #PF: error_code(0x0002) - not-present pa=
ge
Nov 23 22:00:43 ideapad2 kernel: PGD 0 P4D 0=20
Nov 23 22:00:43 ideapad2 kernel: Oops: Oops: 0002 [#3] SMP NOPTI
Nov 23 22:00:43 ideapad2 kernel: CPU: 1 UID: 1000 PID: 668 Comm: kwin_way=
land Tainted: G      D W  OE       6.17.5-arch1-1 #1 PREEMPT(full)  01c39=
fc421df2af799dd5e9180b572af860b40c1
Nov 23 22:00:43 ideapad2 kernel: Tainted: [D]=3DDIE, [W]=3DWARN, [O]=3DOO=
T_MODULE, [E]=3DUNSIGNED_MODULE
Nov 23 22:00:43 ideapad2 kernel: Hardware name: LENOVO 82KR/LNVNB161216, =
BIOS HBCN18WW 08/27/2021
Nov 23 22:00:43 ideapad2 kernel: RIP: 0010:dma_buf_poll+0x125/0x300
Nov 23 22:00:43 ideapad2 kernel: Code: 0e 4c 89 e7 41 83 e5 fe e8 78 bf 4=
8 00 eb 80 c7 83 b8 00 00 00 01 00 00 00 4c 89 e7 e8 64 bf 48 00 48 8b 53=
 08 b8 01 00 00 00 <f0> 48 0f c1 82 b0 00 00 00 48 85 c0 0f 88 4e 01 00 0=
0 31 f6 48 8d
Nov 23 22:00:43 ideapad2 kernel: RSP: 0018:ffffceeaca6f7968 EFLAGS: 00010=
286
Nov 23 22:00:43 ideapad2 kernel: RAX: 0000000000000001 RBX: ffff8d9e007e6=
c00 RCX: 0000000000000000
Nov 23 22:00:43 ideapad2 kernel: RDX: 0000000000000000 RSI: 0000000000000=
000 RDI: ffff8d9e007e6c80
Nov 23 22:00:43 ideapad2 kernel: RBP: ffff8d9de8840548 R08: ffff8d9ff2703=
6e8 R09: 0000000000000000
Nov 23 22:00:43 ideapad2 kernel: R10: 0000000000000000 R11: 0000000000000=
000 R12: ffff8d9e007e6c80
Nov 23 22:00:43 ideapad2 kernel: R13: 0000000000000001 R14: 0000000000000=
000 R15: ffff8d9fbe021d80
Nov 23 22:00:43 ideapad2 kernel: FS:  00007f59fd4d3400(0000) GS:ffff8da0e=
8b86000(0000) knlGS:0000000000000000
Nov 23 22:00:43 ideapad2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Nov 23 22:00:43 ideapad2 kernel: CR2: 00000000000000b0 CR3: 000000010a3e6=
000 CR4: 00000000003506f0
Nov 23 22:00:43 ideapad2 kernel: Call Trace:
Nov 23 22:00:43 ideapad2 kernel:  <TASK>
Nov 23 22:00:43 ideapad2 kernel:  do_sys_poll+0x2cb/0x590
Nov 23 22:00:43 ideapad2 kernel:  __x64_sys_poll+0xc4/0x190
Nov 23 22:00:43 ideapad2 kernel:  ? do_syscall_64+0x81/0x970
Nov 23 22:00:43 ideapad2 kernel:  do_syscall_64+0x81/0x970
Nov 23 22:00:43 ideapad2 kernel:  ? __x64_sys_epoll_wait+0x70/0x120
Nov 23 22:00:43 ideapad2 kernel:  ? ktime_get_ts64+0x42/0x120
Nov 23 22:00:43 ideapad2 kernel:  ? do_syscall_64+0x81/0x970
Nov 23 22:00:43 ideapad2 kernel:  ? __x64_sys_clock_gettime+0x96/0xd0
Nov 23 22:00:43 ideapad2 kernel:  ? do_syscall_64+0x81/0x970
Nov 23 22:00:43 ideapad2 kernel:  ? do_syscall_64+0x81/0x970
Nov 23 22:00:43 ideapad2 kernel:  ? do_syscall_64+0x81/0x970
Nov 23 22:00:43 ideapad2 kernel:  ? do_syscall_64+0x81/0x970
Nov 23 22:00:43 ideapad2 kernel:  ? __sysvec_apic_timer_interrupt+0x55/0x=
100
Nov 23 22:00:43 ideapad2 kernel:  ? __irq_exit_rcu+0x4c/0xf0
Nov 23 22:00:43 ideapad2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Nov 23 22:00:43 ideapad2 kernel: RIP: 0033:0x7f5a03a9f042
Nov 23 22:00:43 ideapad2 kernel: Code: 08 0f 85 d1 40 ff ff 49 89 fb 48 8=
9 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c=
 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 0=
0 00 00 00 66
Nov 23 22:00:43 ideapad2 kernel: RSP: 002b:00007ffe99230d48 EFLAGS: 00000=
246 ORIG_RAX: 0000000000000007
Nov 23 22:00:43 ideapad2 kernel: RAX: ffffffffffffffda RBX: 0000000000000=
000 RCX: 00007f5a03a9f042
Nov 23 22:00:43 ideapad2 kernel: RDX: 0000000000000000 RSI: 0000000000000=
001 RDI: 00007ffe99230dc0
Nov 23 22:00:43 ideapad2 kernel: RBP: 00007ffe99230d70 R08: 0000000000000=
000 R09: 0000000000000000
Nov 23 22:00:43 ideapad2 kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 00007f59e00030e0
Nov 23 22:00:43 ideapad2 kernel: R13: 0000563c822ebb60 R14: 0000563c823d6=
868 R15: 0000563c823d6880
Nov 23 22:00:43 ideapad2 kernel:  </TASK>
Nov 23 22:00:43 ideapad2 kernel: Modules linked in: rtl8xxxu(OE) uinput c=
cm rtw89_8922au(OE) rtw89_8852cu(OE) rtw89_8852bu(OE) rtw89_8852au(OE) rt=
w89_8851be(OE) rtw89_8851bu(OE) rtw89_8922a(OE) rtw89_8852c(OE) rtw89_885=
2b(OE) rtw89_8852a(OE) rtw89_8851b(OE) rtw89_8852b_common(OE) rtw89_pci(O=
E) rtw89_usb(OE) rtw89_core(OE) mac80211 libarc4 cfg80211 snd_seq_dummy s=
nd_hrtimer rfcomm snd_seq snd_seq_device cmac algif_hash algif_skcipher a=
f_alg snd_sof_amd_acp70 bnep snd_sof_amd_acp63 snd_sof_amd_vangogh snd_so=
f_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_sof_xt=
ensa_dsp snd_sof snd_sof_utils snd_pci_ps snd_soc_acpi_amd_match joydev s=
nd_amd_sdw_acpi intel_rapl_msr soundwire_amd mousedev soundwire_generic_a=
llocation snd_ctl_led soundwire_bus snd_hda_codec_alc269 snd_soc_sdca ee1=
004 snd_hda_scodec_component uvcvideo snd_hda_codec_realtek_lib videobuf2=
_vmalloc snd_soc_core snd_hda_codec_generic snd_hda_codec_atihdmi uvc vid=
eobuf2_memops snd_compress snd_hda_codec_hdmi videobuf2_v4l2 ac97_bus vid=
eobuf2_common amd_atl
Nov 23 22:00:43 ideapad2 kernel:  hid_multitouch videodev snd_pcm_dmaengi=
ne intel_rapl_common snd_hda_intel btusb snd_hda_codec snd_rpl_pci_acp6x =
mc btrtl snd_acp_pci btintel btbcm snd_amd_acpi_mach snd_hda_core btmtk k=
vm_amd snd_acp_legacy_common snd_intel_dspcfg bluetooth snd_intel_sdw_acp=
i polyval_clmulni snd_pci_acp6x snd_hwdep ghash_clmulni_intel snd_pcm snd=
_pci_acp5x aesni_intel sp5100_tco snd_rn_pci_acp3x rapl snd_timer snd ide=
apad_laptop snd_acp_config lenovo_wmi_hotkey_utilities platform_profile w=
mi_bmof vfat snd_soc_acpi i2c_piix4 fat sparse_keymap acpi_cpufreq k10tem=
p i2c_smbus snd_pci_acp3x rfkill soundcore ccp i2c_hid_acpi i2c_hid mac_h=
id vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) kvm irqbypass i2c_dev crypto=
_user ntsync loop dm_mod nfnetlink ip_tables x_tables amdgpu amdxcp i2c_a=
lgo_bit drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper drm_pan=
el_backlight_quirks video drm_buddy serio_raw nvme drm_display_helper sdh=
ci_acpi cec nvme_core sdhci wmi nvme_keyring mmc_core nvme_auth
Nov 23 22:00:43 ideapad2 kernel: Unloaded tainted modules: rtl8xxxu(OE):1=
 [last unloaded: rtl8xxxu(OE)]
Nov 23 22:00:43 ideapad2 kernel: CR2: 00000000000000b0
Nov 23 22:00:43 ideapad2 kernel: ---[ end trace 0000000000000000 ]---
Nov 23 22:00:43 ideapad2 kernel: RIP: 0010:usercopy_abort+0x7a/0x7c
Nov 23 22:00:43 ideapad2 kernel: Code: 48 c7 c6 fc fb aa a4 eb 0e 48 c7 c=
7 78 7f ad a4 48 c7 c6 db 32 aa a4 52 48 89 fa 48 c7 c7 80 4b 9f a4 50 41=
 52 e8 66 dc fe ff <0f> 0b 48 89 d9 49 89 e8 48 2b 0a 31 f6 44 89 f2 48 c=
7 c7 3f cf aa
Nov 23 22:00:43 ideapad2 kernel: RSP: 0018:ffffceeac9c57b88 EFLAGS: 00010=
246
Nov 23 22:00:43 ideapad2 kernel: RAX: 0000000000000066 RBX: ffff8d9eeb002=
01e RCX: 0000000000000000
Nov 23 22:00:43 ideapad2 kernel: RDX: 0000000000000000 RSI: 0000000000000=
001 RDI: ffff8da08ed9cfc0
Nov 23 22:00:43 ideapad2 kernel: RBP: 00000000000000fa R08: 0000000000000=
000 R09: 00000000fff7ffff
Nov 23 22:00:43 ideapad2 kernel: R10: ffffffffa619d880 R11: ffffceeac9c57=
a28 R12: ffff8d9eeb002118
Nov 23 22:00:43 ideapad2 kernel: R13: 000000000000013f R14: 0000000000000=
000 R15: 0000000000000000
Nov 23 22:00:43 ideapad2 kernel: FS:  00007f59fd4d3400(0000) GS:ffff8da0e=
8b86000(0000) knlGS:0000000000000000
Nov 23 22:00:43 ideapad2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Nov 23 22:00:43 ideapad2 kernel: CR2: 00000000000000b0 CR3: 000000010a3e6=
000 CR4: 00000000003506f0
Nov 23 22:00:43 ideapad2 kernel: note: kwin_wayland[668] exited with irqs=
 disabled
Nov 23 22:00:50 ideapad2 kwin_wayland_wrapper[16761]: ALSA lib pcm_dmix.c=
:1000:(snd_pcm_dmix_open) unable to open slave
Nov 23 22:00:50 ideapad2 kwin_killer_helper[16761]: Failed to play sound =
with canberra: File or data not found


