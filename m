Return-Path: <linux-wireless+bounces-36559-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ9yDjFOCmqQzQQAu9opvQ
	(envelope-from <linux-wireless+bounces-36559-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 01:24:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D03E15645A3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 01:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBFE23000B00
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 23:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD79329C7C;
	Sun, 17 May 2026 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojn3YdDd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423162F290E
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779060271; cv=pass; b=Q3bZ2oKjvUxglN+fNnydnCzEu+phrTAV7NEUKIBt3cPLBOMe2Wh3oksSkdDAQ8eEvsTRjwr4Fvd46lJzIZNDBuaEoMXclvM9V2zW5X8EmsrqG9y2M8JX9H4yZnW24ZEpHkIaXkfxrGtMzWyLcJPVd78YeYVlnjGfcPHbbzdF9Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779060271; c=relaxed/simple;
	bh=MRbXxiNY/Z0MY4d+RR6IuuKFnuyGzMRPd/Ot65mgDjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mA775ODVi4XHlgwOX+C31aWyW4dIRmiRHPDIP4+eVT0F6QtewKRrB5KVBJawyhG8g6Sp9dg0ambmomK0kVCwswCiWaR2XqNU7x1Li4lUy2ULe+14vetFAY2KGDELN11IhF5mckQVRKvdbjGy9u/YiogawsuOGu9ToLfMLhAgjKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojn3YdDd; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bce57c132b2so562385266b.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 16:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779060267; cv=none;
        d=google.com; s=arc-20240605;
        b=SH8+2vzRCcyFbp5vUsK6QFM9HXWnUcoXfbnJMxTBvqx2Fuv2qWEb9nHeL76al8I0A/
         NorhdwreCgesMJqwLSaUJvPpLoIR/+jI3+i86DJhf8S5loxKeL+1dshNUvO2qh2VDJ+w
         JEXC32sYVGLsA9dt41mEgLAyUdyuZLFkfWAAdDkna9lVfn2vM1WDu4Sa3cdgC3JlqKab
         TuLGEibDGxlDgZkXf930qj4xt7RfX5jO92gXNmCOu+zb5aKrw0frsGdmRYxQg8Xa2eQ0
         qV8XjBLIu0g8GnfRGZFBuy5fBztGMLxm1AmOiSUM7nagEItm1U9lMckGti3SGYI26Iji
         MMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RJ2XY4w2SFXccVnKG9oVkhWxDffVwijZSyk8r8hCJvc=;
        fh=C8tep4+BrysoOMFVckULblQwtTxc3tLjhF7D9wfOd5c=;
        b=UZobO4drbRPzpIapl4z2Ocet+PQ8r+vjBJMpc8sCEWSXHKi3U2qQ5+tZNMXIK/RVv3
         5uZoMQ0TDhqU1ykLUTsLacy66WQcpTSso2sTtxpG+3IzzGYC1u/97JP4CWAhL1V/LrFA
         C6RA17NYhd1//RsG+O/9CKuhccQrkOGj8qzEhWGeM+JHuyANZZJMPoomuFjXq9k/c8fE
         NNat1/AwZan2SIBO+WjjzjWJDTOPaK3d5Wbax+ZV+xggz4JZ7kTjhPK2wNsxXAOKcQlJ
         JU8F91UEjWjNzcWf2uqiE3sOjwC5+qnIi9nYd4cl0twp5KtkEqDAB/LnEhwpECO0rCEn
         p1ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779060267; x=1779665067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ2XY4w2SFXccVnKG9oVkhWxDffVwijZSyk8r8hCJvc=;
        b=Ojn3YdDd7XG5DpqjvRa8QU5vJoY9BuPw1ICwr1SAvVrYzbLdlGJp3WEfX1IZ0A5zrH
         nLkz5+ctSZRGnDODgjUuIAktzMkXxk3LxuVN47HIUXWHr+PqazbdkUNG7uEOpDjgv+qw
         +iiFN7zm51QFnQDzAop7mGfXV2tXICJmOu/9J2sysnkq3cAOvqrxsRi2cO8VlFq61pNH
         R5njVzvx68k43RhULtOkkRa++XlQjXtImpzSCwjRr04di/8Y46w5PFwN0vGn5463p6tb
         hk+vbCm5O6Ef4yUNJJx2F8BdZfVfb/oDA1BIgD5QwB/wRGHUfkx1IJBaeOuJtdEsJ1Xt
         cxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779060267; x=1779665067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJ2XY4w2SFXccVnKG9oVkhWxDffVwijZSyk8r8hCJvc=;
        b=j4deStoYkBQ+ujr4lWAEOXCJz1/gmsXZnNsIS5OA1brnM36WiWeqdpsITOOhhYKKJN
         rh8OyfH3uthuD423lGCPAHVDNexUgp6NWESUGO6bUESbsL60TmQ7XkNverT/z+sK5vfm
         oAQH/7KOFwuryHcWFtOR8liMSFIsxZ1+x2bAeWwnMcx8Qk0X5ICmwXA+YPHBCo+MVy8i
         E1/feeDBAVEIS7dy5SqM+cQyJSWkSbOJcZAvrOKkEQwWtTbjHzc9i/USH6RDSjXhe/Am
         giwJKZZ2Ws6bSmZWDwUroeyxMAPE/IxWRhEaa71G4iRd4xINhxE6RRX1YZHrbveXYpX5
         SBkw==
X-Gm-Message-State: AOJu0YyJca94Ru4lNMDwGTmouTDqTwbCZUCaGvu53BiQne2j9VMLzos2
	XZ/KGexVc2X6CIL3BlHuCz3EELcp6uSleIr84pThHIF/d7s8oTHqkiTN8guzlVR4Fx23sE0Gbaf
	BmKEXVoJNMIWd0tGnLa82ruFCKPksfsGi8A==
X-Gm-Gg: Acq92OHjUWm6uAmv+PUJfAeSHsXhG4iLEUVOiFC625h4GDg6mt2CdZXaLkQxYGD9fnZ
	S8WhWLRvf1U7WwOKjH8QpOKk75PalplmBZ0991b/lxDkT/bWcGOefukW6wPKUH/X+0CGsTRftWI
	eLyDdDpEUF1OV8PqC5jmZrwycz3WdAze2ng4Jb09imi9lSDhRpZTn7KvDtBxCFi1XtUTEa7+uw1
	rxvmCqcbUMGboVHqHyn62qS4msBK4PZxxkZ5gmP3Lq5YWZWiTHYWILcBWk/rh9sZKV+FZ1DAqXf
	7O25gkvvKmAAQLyeBSm951Dx9eunC50fosAjlUrxaoWk4QTtS8kkUHGrGQSYmv1eb7e31MtjuMH
	hTsc7XjDEx8FWYOzYWm4LeE1EfKBMAl/3NonORvHG4/xecSmhWn/tRm53SA==
X-Received: by 2002:a17:907:d0b:b0:bd1:77c4:acc0 with SMTP id
 a640c23a62f3a-bd51550075amr612633666b.19.1779060267117; Sun, 17 May 2026
 16:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517231759.56638-1-rosenp@gmail.com>
In-Reply-To: <20260517231759.56638-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 17 May 2026 16:24:16 -0700
X-Gm-Features: AVHnY4LnnDekBASEVqED0hpnZ8_YrpB8Dmtp3z_UDAr11DQjxn6LIqcT1OaSYRE
Message-ID: <CAKxU2N_z1XkK738rk7-KZVaQcsWpqb70qfnE3CrnaqPX6WQc-Q@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: rt2x00: Allocate LED names dynamically
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D03E15645A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36559-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 4:18=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> The rt2x00 LED registration path builds LED class names from the
> driver and wiphy names. A fixed stack buffer can truncate those names
> before they are passed to the LED core.
>
> Allocate each LED name with kasprintf(), check allocation failures, and
> release the stored name when the LED is unregistered.
>
> Assisted-by: Codex:GPT-5.5
I got a crash from this driver:

[11292.387895] ieee80211 phy2: rt2x00_set_rt: Info - RT chipset 3070,
rev 0201 detected
[11293.065970] ieee80211 phy2: rt2x00_set_rf: Info - RF chipset 0005 detect=
ed
[11293.072037] ieee80211 phy2: Selected rate control algorithm 'minstrel_ht=
'
[11293.105170] ieee80211 phy2: rt2x00lib_request_firmware: Info -
Loading firmware file 'rt2870.bin'
[11293.105237] ieee80211 phy2: rt2x00lib_request_firmware: Info -
Firmware detected - version: 0.36
[11296.194097] usb 1-11: USB disconnect, device number 6
[11296.196552] ieee80211 phy2: rt2x00usb_vendor_request: Error -
Vendor Request 0x06 failed for offset 0x101c with error -19
[11301.161824] BUG: unable to handle page fault for address: ffffffffffffff=
08
[11301.161830] #PF: supervisor read access in kernel mode
[11301.161833] #PF: error_code(0x0000) - not-present page
[11301.161835] PGD ea3a27067 P4D ea3a27067 PUD ea3a29067 PMD 0
[11301.161842] Oops: Oops: 0000 [#1] SMP NOPTI
[11301.161847] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
7.0.8-arch1-1 #1 PREEMPT(full)
c2ec282795e9f47cb8bc86f69b5629c84ae881f4
[11301.161851] Hardware name: To Be Filled By O.E.M. X370 Professional
Gaming/X370 Professional Gaming, BIOS P7.30 10/27/2022
[11301.161854] RIP: 0010:led_blink_set_nosleep+0x1a/0xa0
[11301.161860] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb 48 83 ec 10 48 89 74 24 08 48
89 14 24 <48> 83 7f 38 00 74 07 48 83 7f 28 00 75 35 48 8d bb 88 00 00
00 e8
[11301.161863] RSP: 0018:ffffc9fc80003d88 EFLAGS: 00010286
[11301.161867] RAX: 0000000000000000 RBX: fffffffffffffed0 RCX: ffffffffc23=
2c4f8
[11301.161869] RDX: 0000000000000000 RSI: 0000000000000001 RDI: fffffffffff=
ffed0
[11301.161871] RBP: ffff89714752de40 R08: ffff8975fef1f2c0 R09: 0000000100a=
7df80
[11301.161873] R10: 0000000000000201 R11: 0000000000000000 R12: 00000000000=
00001
[11301.161875] R13: 0000000000000000 R14: ffffc9fc80003e10 R15: ffff8975fef=
1f2c0
[11301.161877] FS:  0000000000000000(0000) GS:ffff897645967000(0000)
knlGS:0000000000000000
[11301.161880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11301.161882] CR2: ffffffffffffff08 CR3: 00000001191d1000 CR4: 0000000000f=
50ef0
[11301.161884] PKRU: 55555554
[11301.161887] Call Trace:
[11301.161889]  <IRQ>
[11301.161893]  led_trigger_blink+0x55/0x90
[11301.161898]  ? __pfx_tpt_trig_timer+0x10/0x10 [mac80211
43d2d2695e6be7042340c3321c2c597aa1cd7f70]
[11301.161944]  ? __pfx_tpt_trig_timer+0x10/0x10 [mac80211
43d2d2695e6be7042340c3321c2c597aa1cd7f70]
[11301.161980]  call_timer_fn+0x2a/0x140
[11301.161986]  __run_timers+0x269/0x330
[11301.161993]  timer_expire_remote+0x47/0x60
[11301.161997]  tmigr_handle_remote+0x498/0x570
[11301.162005]  handle_softirqs+0xe8/0x2c0
[11301.162011]  __irq_exit_rcu+0xc9/0xf0
[11301.162015]  sysvec_apic_timer_interrupt+0x71/0x90
[11301.162020]  </IRQ>
[11301.162022]  <TASK>
[11301.162024]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[11301.162028] RIP: 0010:cpuidle_enter_state+0xbb/0x440
[11301.162032] Code: 00 00 e8 c8 ec ec fe e8 93 ee ff ff 48 89 c5 0f
1f 44 00 00 31 ff e8 04 41 eb fe 45 84 ff 0f 85 74 01 00 00 fb 0f 1f
44 00 00 <45> 85 f6 0f 88 cb 01 00 00 44 89 f1 48 2b 2c 24 48 6b d1 68
48 89
[11301.162034] RSP: 0018:ffffffffb8403e10 EFLAGS: 00000246
[11301.162037] RAX: ffff897645967000 RBX: 0000000000000002 RCX: 00000000000=
00000
[11301.162039] RDX: 00000a4741bc4107 RSI: fffffffb5c704741 RDI: 00000000000=
00000
[11301.162041] RBP: 00000a4741bc4107 R08: ffff897645967000 R09: ffffffffb86=
19920
[11301.162043] R10: ffff8975fea217c0 R11: 0000000000000001 R12: ffff8967025=
08800
[11301.162045] R13: ffffffffb8619920 R14: 0000000000000002 R15: 00000000000=
00000
[11301.162052]  cpuidle_enter+0x31/0x50
[11301.162057]  do_idle+0x14b/0x2a0
[11301.162063]  cpu_startup_entry+0x29/0x30
[11301.162067]  rest_init+0xcc/0xd0
[11301.162071]  start_kernel+0xa5b/0xa70
[11301.162077]  x86_64_start_reservations+0x24/0x30
[11301.162082]  x86_64_start_kernel+0xda/0xe0
[11301.162086]  common_startup_64+0x13e/0x141
[11301.162094]  </TASK>
[11301.162096] Modules linked in: rt2800usb rt2x00usb rt2800lib
rt2x00lib rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device ccm
algif_aead des3_ede_x86_64 des_generic libdes cmac algif_skcipher md4
bnep algif_hash af_alg vfat fat amd_atl intel_rapl_msr
intel_rapl_common snd_hda_codec_alc882 snd_hda_codec_realtek_lib
snd_hda_codec_generic snd_hda_codec_atihdmi snd_hda_codec_hdmi
snd_hda_intel uvcvideo iwlmvm videobuf2_vmalloc kvm_amd snd_hda_codec
uvc snd_hda_core videobuf2_memops snd_intel_dspcfg videobuf2_v4l2
mac80211 btusb kvm snd_intel_sdw_acpi videobuf2_common btmtk snd_hwdep
btrtl videodev ee1004 libarc4 snd_pcm btbcm irqbypass igb atlantic
btintel snd_timer sp5100_tco mc mousedev iwlwifi wmi_bmof rapl macsec
dca snd mxm_wmi i2c_piix4 ptp pcspkr bluetooth soundcore k10temp
pps_core i2c_smbus gpio_amdpt gpio_generic mac_hid cfg80211 rfkill
crypto_user uinput pkcs8_key_parser i2c_dev ntsync nfnetlink zram
842_decompress 842_compress lz4hc_compress lz4_compress dm_crypt
encrypted_keys trusted asn1_encoder tee
[11301.162195]  dm_mod hid_logitech_hidpp amdgpu amdxcp i2c_algo_bit
drm_ttm_helper ttm drm_exec drm_panel_backlight_quirks gpu_sched
drm_suballoc_helper video drm_buddy sr_mod nvme drm_display_helper
hid_logitech_dj cdrom nvme_core ghash_clmulni_intel cec aesni_intel
nvme_keyring ccp nvme_auth hkdf wmi thunderbolt
[11301.162227] CR2: ffffffffffffff08
[11301.162230] ---[ end trace 0000000000000000 ]---
[11301.162232] RIP: 0010:led_blink_set_nosleep+0x1a/0xa0
[11301.162236] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb 48 83 ec 10 48 89 74 24 08 48
89 14 24 <48> 83 7f 38 00 74 07 48 83 7f 28 00 75 35 48 8d bb 88 00 00
00 e8
[11301.162238] RSP: 0018:ffffc9fc80003d88 EFLAGS: 00010286
[11301.162241] RAX: 0000000000000000 RBX: fffffffffffffed0 RCX: ffffffffc23=
2c4f8
[11301.162243] RDX: 0000000000000000 RSI: 0000000000000001 RDI: fffffffffff=
ffed0
[11301.162245] RBP: ffff89714752de40 R08: ffff8975fef1f2c0 R09: 0000000100a=
7df80
[11301.162247] R10: 0000000000000201 R11: 0000000000000000 R12: 00000000000=
00001
[11301.162249] R13: 0000000000000000 R14: ffffc9fc80003e10 R15: ffff8975fef=
1f2c0
[11301.162251] FS:  0000000000000000(0000) GS:ffff897645967000(0000)
knlGS:0000000000000000
[11301.162253] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11301.162255] CR2: ffffffffffffff08 CR3: 00000001191d1000 CR4: 0000000000f=
50ef0
[11301.162258] PKRU: 55555554
[11301.162260] Kernel panic - not syncing: Fatal exception in interrupt
[11301.162414] Kernel Offset: 0x34c00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

This AI kept trying to patch net/mac80211/led.c . I really don't think
the problem is there. It found this one in the driver itself. Although
it's probably not it either.


> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../net/wireless/ralink/rt2x00/rt2x00leds.c   | 30 ++++++++++++++-----
>  1 file changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00leds.c b/drivers/ne=
t/wireless/ralink/rt2x00/rt2x00leds.c
> index f5361d582d4e..8818e0b2447b 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00leds.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00leds.c
> @@ -100,6 +100,8 @@ static int rt2x00leds_register_led(struct rt2x00_dev =
*rt2x00dev,
>
>         retval =3D led_classdev_register(device, &led->led_dev);
>         if (retval) {
> +               kfree(name);
> +               led->led_dev.name =3D NULL;
>                 rt2x00_err(rt2x00dev, "Failed to register led handler\n")=
;
>                 return retval;
>         }
> @@ -111,15 +113,19 @@ static int rt2x00leds_register_led(struct rt2x00_de=
v *rt2x00dev,
>
>  void rt2x00leds_register(struct rt2x00_dev *rt2x00dev)
>  {
> -       char name[36];
> +       char *name;
>         int retval;
>         unsigned long on_period;
>         unsigned long off_period;
>         const char *phy_name =3D wiphy_name(rt2x00dev->hw->wiphy);
>
>         if (rt2x00dev->led_radio.flags & LED_INITIALIZED) {
> -               snprintf(name, sizeof(name), "%s-%s::radio",
> -                        rt2x00dev->ops->name, phy_name);
> +               name =3D kasprintf(GFP_KERNEL, "%s-%s::radio",
> +                                rt2x00dev->ops->name, phy_name);
> +               if (!name) {
> +                       retval =3D -ENOMEM;
> +                       goto exit_fail;
> +               }
>
>                 retval =3D rt2x00leds_register_led(rt2x00dev,
>                                                  &rt2x00dev->led_radio,
> @@ -129,8 +135,12 @@ void rt2x00leds_register(struct rt2x00_dev *rt2x00de=
v)
>         }
>
>         if (rt2x00dev->led_assoc.flags & LED_INITIALIZED) {
> -               snprintf(name, sizeof(name), "%s-%s::assoc",
> -                        rt2x00dev->ops->name, phy_name);
> +               name =3D kasprintf(GFP_KERNEL, "%s-%s::assoc",
> +                                rt2x00dev->ops->name, phy_name);
> +               if (!name) {
> +                       retval =3D -ENOMEM;
> +                       goto exit_fail;
> +               }
>
>                 retval =3D rt2x00leds_register_led(rt2x00dev,
>                                                  &rt2x00dev->led_assoc,
> @@ -140,8 +150,12 @@ void rt2x00leds_register(struct rt2x00_dev *rt2x00de=
v)
>         }
>
>         if (rt2x00dev->led_qual.flags & LED_INITIALIZED) {
> -               snprintf(name, sizeof(name), "%s-%s::quality",
> -                        rt2x00dev->ops->name, phy_name);
> +               name =3D kasprintf(GFP_KERNEL, "%s-%s::quality",
> +                                rt2x00dev->ops->name, phy_name);
> +               if (!name) {
> +                       retval =3D -ENOMEM;
> +                       goto exit_fail;
> +               }
>
>                 retval =3D rt2x00leds_register_led(rt2x00dev,
>                                                  &rt2x00dev->led_qual,
> @@ -182,6 +196,8 @@ static void rt2x00leds_unregister_led(struct rt2x00_l=
ed *led)
>                 led->led_dev.brightness_set(&led->led_dev, LED_OFF);
>
>         led->flags &=3D ~LED_REGISTERED;
> +       kfree(led->led_dev.name);
> +       led->led_dev.name =3D NULL;
>  }
>
>  void rt2x00leds_unregister(struct rt2x00_dev *rt2x00dev)
> --
> 2.54.0
>

