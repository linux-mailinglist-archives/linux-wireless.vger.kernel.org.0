Return-Path: <linux-wireless+bounces-32120-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFoqIoegnGnqJgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32120-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 19:46:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BF317BB93
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 19:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A69CB316D9AB
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 18:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEA9369203;
	Mon, 23 Feb 2026 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE1HY6K6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CC1366DCB
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872208; cv=none; b=Cpn2FceEdGWiwL6PYwJUaNtcZjpxdp/9bVfzyKfSwxM+i7rKkBhaY1o6irc6WEKC8jS77IiySokwuzGoBZT7YVX4Qh5wprKRwG/cGo2Ee881APyETd6QM4WG2Ay8SzJMtA61YuQ4dGRldWNsP7DokYFkUsxVASCRZdFlf8sFFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872208; c=relaxed/simple;
	bh=ppOz6wHIlMpcSqa7YYeyf3qOHWb47ieChjT/39LCTYk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jXmIDH3aSWc+mDusRZyB5frHp2oLAj3Pic26AS0pO0ToSuXRhqXWbtGz0ft3hE6zBVlnDv6wd1Ncq5eHE3uJ1VFLi+KHHVAi/kVbTtiyMSX2+XxxlaItFuAe2LtQW32O+7RWQKGXRE50siA81PFoWxCvz8eZfsiB9pzdP6d7sa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE1HY6K6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so51687305e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 10:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771872205; x=1772477005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYbE3OojPx7rOaSiXc/RiI4EhYqX7mSz3sybsx/VPHc=;
        b=HE1HY6K6tomZ+i8d1FVWDrUQa+K1KBD/ZjmACQFvjvIonwSJlpUwQfSb9DztUspQYw
         fIdCKk+22NpEZvUpzjsfNxa9x50QdtTJpt9Ae7krwaA1n6msnm2jNHmTCw1IU9nVIBw4
         exqoJIateWIvJrGnHkhV6bwYfAMhR0IRRLfe8r3dECPn6UrNNp2/U62Ilp/pbtEcYP8N
         98SOndkG93rD8lBDojQ5z9z2YBgDQh7ny4fb0FDJa8AeXwF9UpjQ5WjwH/pFEqLGACu8
         +3qKQk5gKP256IYLdT3/BXfb/NcZ+rcb6vSsSr8q2LNXOZmxr83EbDJktlpHURycrtvF
         tXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771872205; x=1772477005;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QYbE3OojPx7rOaSiXc/RiI4EhYqX7mSz3sybsx/VPHc=;
        b=MtWdC/88TRg+qGcI5R9UF75WbFCgR6OrAANf8mch7KPXne8UazFK50WJSVIqVHpvWT
         HyoRoCbH1bX//0NYfC65ZqNXb72UyN7w+3XjQGPCTZ75bM0yJ5qrbkXzk/gMysZOIYlQ
         Co0uSMO4gHaM6tt8WsNItacgQsAHlo+CSNVqZIWcpftaEi9WUV9LgHBDsrmXps/G4l1I
         3qDw7fgXsy9iLYhib1Ivq31rEFoh1pY4Fz48hS6cdY2QvBNFwCa5+RnhovkOZ7uQ0rbn
         B0K+iCw6tVG8nsJaECoNqVBfLHSiosVc38u5Q70AigX2KkRZf9EuhKnpOTPmaiWpiBBK
         yIzA==
X-Forwarded-Encrypted: i=1; AJvYcCWBUdAbRKSEG/Vcx3e3lbtXv2Iwx1sc/TmWzSOJ+5YX0ZUhloaKh8iKVeOWn0lPxddFkKTK/6GROiiDWOtHgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCTugNqlmLWBEY8+OTdpALP/e5nYE7V0LFpI8apftZHcXc4of
	V+Mz0a0dlakIBNmguWScVG+840o2C+KY6kROACiGu+jBHhco33gvMoMs
X-Gm-Gg: AZuq6aJOf5TwQV2TE2Bmha71+5ReuPDrpIQIKUOh2zDzrkHH/MkvreMKv0HdZ4twx6U
	JcnfJ6u09ip+bsBHG3IQs5fR3XG08pArR1dMBoqh9nGsy+sWa+Lree0CtuECU3UOqivgF1YEMmJ
	gwFLIbDhL1MFwYV6oJ0sGpjw5MenU8/8vOXzYC2dRHIAr3Z1Y13BopAttEvStKVnIGm+eEX7Ar4
	ZwFd+UtdIAfaVSNP1OR2LedLgXNi9XIJMks7bBl8BXZzd5buM0bJBMWVQ2hhHgE9oJ/2BLKjglU
	yBSk+/FJIbOzIKXAr7Gy3NDdMqCupuU8QgJN2MatikwQhmTv/ETDcxxaeChOSOv1bmnC7JS9ASA
	8eKLT6A1yD4AmE4oSGQCynn5nVH58ArZZKOvSuOfofUoCvFHXu/Kw+zPEe3BANmS7RojPayyOZO
	z5hMtfKNqLfQ96sOFSmhne+qgZX94qTg==
X-Received: by 2002:a05:600c:470f:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-483a95a852cmr170127735e9.4.1771872204949;
        Mon, 23 Feb 2026 10:43:24 -0800 (PST)
Received: from debian.local ([90.243.35.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9b668f3sm218225955e9.3.2026.02.23.10.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:43:24 -0800 (PST)
Date: Mon, 23 Feb 2026 18:43:23 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes.berg@intel.com, emmanuel.grumbach@intel.com,
	linux-intel-wifi@intel.com, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] iwlwifi oops in iwl_pcie_rx_handle on resume
Message-ID: <aZyfy6WiJFORlhf_@debian.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32120-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisbainbridge@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lkml.org:url,debian.local:mid]
X-Rspamd-Queue-Id: D1BF317BB93
X-Rspamd-Action: no action

Hi,

I just got an oops with v7.0-rc1 shortly after resume:

<6>[ 9761.194306] ACPI: EC: interrupt unblocked
<6>[ 9761.336806] amdgpu 0000:03:00.0: [drm] PCIE GART of 1024M enabled.
<6>[ 9761.336816] amdgpu 0000:03:00.0: [drm] PTB located at 0x000000F41FC00=
000
<6>[ 9761.337043] amdgpu 0000:03:00.0: SMU is resuming...
<6>[ 9761.338126] amdgpu 0000:03:00.0: dpm has been disabled
<6>[ 9761.338943] amdgpu 0000:03:00.0: SMU is resumed successfully!
<6>[ 9761.439301] [drm] DM_MST: Differing MST start on aconnector: 00000000=
1b6f89b3 [id: 116]
<6>[ 9761.441525] amdgpu 0000:03:00.0: ring gfx uses VM inv eng 0 on hub 0
<6>[ 9761.441530] amdgpu 0000:03:00.0: ring comp_1.0.0 uses VM inv eng 1 on=
 hub 0
<6>[ 9761.441532] amdgpu 0000:03:00.0: ring comp_1.1.0 uses VM inv eng 4 on=
 hub 0
<6>[ 9761.441534] amdgpu 0000:03:00.0: ring comp_1.2.0 uses VM inv eng 5 on=
 hub 0
<6>[ 9761.441536] amdgpu 0000:03:00.0: ring comp_1.3.0 uses VM inv eng 6 on=
 hub 0
Oops#1 Part6
<6>[ 9761.441538] amdgpu 0000:03:00.0: ring comp_1.0.1 uses VM inv eng 7 on=
 hub 0
<6>[ 9761.441540] amdgpu 0000:03:00.0: ring comp_1.1.1 uses VM inv eng 8 on=
 hub 0
<6>[ 9761.441542] amdgpu 0000:03:00.0: ring comp_1.2.1 uses VM inv eng 9 on=
 hub 0
<6>[ 9761.441544] amdgpu 0000:03:00.0: ring comp_1.3.1 uses VM inv eng 10 o=
n hub 0
<6>[ 9761.441546] amdgpu 0000:03:00.0: ring kiq_0.2.1.0 uses VM inv eng 11 =
on hub 0
<6>[ 9761.441548] amdgpu 0000:03:00.0: ring sdma0 uses VM inv eng 0 on hub 8
<6>[ 9761.441550] amdgpu 0000:03:00.0: ring vcn_dec uses VM inv eng 1 on hu=
b 8
<6>[ 9761.441552] amdgpu 0000:03:00.0: ring vcn_enc0 uses VM inv eng 4 on h=
ub 8
<6>[ 9761.441554] amdgpu 0000:03:00.0: ring vcn_enc1 uses VM inv eng 5 on h=
ub 8
<6>[ 9761.441556] amdgpu 0000:03:00.0: ring jpeg_dec uses VM inv eng 6 on h=
ub 8
<6>[ 9761.568907] usb 1-1.3.2.4: reset high-speed USB device number 12 usin=
g xhci_hcd
<6>[ 9761.767481] nvme nvme0: 8/0/0 default/read/poll queues
<6>[ 9761.922505] iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
<6>[ 9761.922592] iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
<6>[ 9761.922715] iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
<6>[ 9761.922787] iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
<6>[ 9762.052938] OOM killer enabled.
<6>[ 9762.052942] Restarting tasks: Starting
<6>[ 9762.054800] Restarting tasks: Done
<6>[ 9762.054976] efivarfs: resyncing variable state
<6>[ 9762.066314] efivarfs: finished resyncing variable state
<5>[ 9762.066477] random: crng reseeded on system resumption
<6>[ 9762.160714] PM: suspend exit
<6>[ 9762.739294] iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
Oops#1 Part5
<6>[ 9762.739367] iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
<6>[ 9762.739435] iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
<6>[ 9762.739451] iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
<6>[ 9766.455338] wlp1s0: authenticate with d6:92:5e:eb:ee:15 (local addres=
s=3Dc8:15:4e:63:1d:e8)
<6>[ 9766.456638] wlp1s0: send auth to d6:92:5e:eb:ee:15 (try 1/3)
<6>[ 9766.518885] wlp1s0: authenticate with d6:92:5e:eb:ee:15 (local addres=
s=3Dc8:15:4e:63:1d:e8)
<6>[ 9766.518900] wlp1s0: send auth to d6:92:5e:eb:ee:15 (try 1/3)
<6>[ 9766.522553] wlp1s0: authenticated
<6>[ 9766.524038] wlp1s0: associate with d6:92:5e:eb:ee:15 (try 1/3)
<6>[ 9766.532772] wlp1s0: RX AssocResp from d6:92:5e:eb:ee:15 (capab=3D0x10=
11 status=3D0 aid=3D21)
<6>[ 9766.549780] wlp1s0: associated
<7>[ 9766.618488] wlp1s0: Limiting TX power to 23 (23 - 0) dBm as advertise=
d by d6:92:5e:eb:ee:15
<4>[ 9809.544787] Oops: general protection fault, probably for non-canonica=
l address 0xe0000d1060000000: 0000 [#1] SMP KASAN
<1>[ 9809.544818] KASAN: maybe wild-memory-access in range [0x0000888300000=
000-0x0000888300000007]
<4>[ 9809.544825] CPU: 3 UID: 0 PID: 996 Comm: irq/75-iwlwifi: Not tainted =
7.0.0-rc1 #444 PREEMPT(lazy)
<4>[ 9809.544832] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916,=
 BIOS F.17 12/18/2024
<4>[ 9809.544835] RIP: 0010:detach_if_pending (./include/linux/list.h:992 (=
discriminator 2) kernel/time/timer.c:891 (discriminator 2) kernel/time/time=
r.c:910 (discriminator 2))
<4>[ 9809.544845] Code: df 4c 89 ea 48 8b 2b 48 c1 ea 03 80 3c 02 00 0f 85 =
40 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 6b 08 4c 89 ea 48 c1 ea 03 =
<80> 3c 02 00 0f 85 14 02 00 00 49 89 6d 00 48 85 ed 74 23 48 b8 00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	df 4c 89 ea          	fisttps -0x16(%rcx,%rcx,4)
   4:	48 8b 2b             	mov    (%rbx),%rbp
   7:	48 c1 ea 03          	shr    $0x3,%rdx
   b:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   f:	0f 85 40 02 00 00    	jne    0x255
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df=20
  1f:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
  23:	4c 89 ea             	mov    %r13,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instru=
ction
  2e:	0f 85 14 02 00 00    	jne    0x248
  34:	49 89 6d 00          	mov    %rbp,0x0(%r13)
  38:	48 85 ed             	test   %rbp,%rbp
  3b:	74 23                	je     0x60
  3d:	48                   	rex.W
  3e:	b8                   	.byte 0xb8
	...

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 14 02 00 00    	jne    0x21e
   a:	49 89 6d 00          	mov    %rbp,0x0(%r13)
   e:	48 85 ed             	test   %rbp,%rbp
  11:	74 23                	je     0x36
  13:	48                   	rex.W
  14:	b8                   	.byte 0xb8
	...
<4>[ 9809.544849] RSP: 0018:ffffc90000708850 EFLAGS: 00010016
Oops#1 Part4
<4>[ 9809.544855] RAX: dffffc0000000000 RBX: ffff888107e710e0 RCX: ffffffff=
86373dde
<4>[ 9809.544859] RDX: 0000111060000000 RSI: ffffffff888b8ec0 RDI: ffffffff=
88f25138
<4>[ 9809.544862] RBP: dead000000000122 R08: 0000000000000000 R09: fffffbff=
f139f90c
<4>[ 9809.544865] R10: ffffffff89cfc867 R11: 0000000000000001 R12: 00000000=
00000000
<4>[ 9809.544868] R13: 0000888300000000 R14: ffff888107e710e8 R15: ffff8883=
8d6af9c0
<4>[ 9809.544872] FS:  0000000000000000(0000) GS:ffff888403005000(0000) knl=
GS:0000000000000000
<4>[ 9809.544875] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 9809.544878] CR2: 00007fad9435741c CR3: 0000000076a91000 CR4: 00000000=
00750ef0
<4>[ 9809.544882] PKRU: 55555554
<4>[ 9809.544885] Call Trace:
<4>[ 9809.544888]  <IRQ>
<4>[ 9809.544893]  __mod_timer (kernel/time/timer.c:1097)
<4>[ 9809.544899]  ? __get_next_timer_interrupt (kernel/time/timer.c:1019)
<4>[ 9809.544904]  ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/pa=
ravirt.h:529 ./arch/x86/include/asm/irqflags.h:159 ./include/linux/spinlock=
_api_smp.h:178 kernel/locking/spinlock.c:194)
<4>[ 9809.544909]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4472 (di=
scriminator 4))
<4>[ 9809.544914]  ? iommu_dma_free_iova (drivers/iommu/dma-iommu.c:245 dri=
vers/iommu/dma-iommu.c:804)
<4>[ 9809.544921]  __iommu_dma_unmap (drivers/iommu/dma-iommu.c:814)
<4>[ 9809.544927]  ? iommu_get_msi_cookie (drivers/iommu/dma-iommu.c:814)
<4>[ 9809.544932]  ? __lock_acquire (kernel/locking/lockdep.c:4674 (discrim=
inator 1) kernel/locking/lockdep.c:5191 (discriminator 1))
<4>[ 9809.544941]  iommu_dma_unmap_phys (./include/linux/swiotlb.h:145 ./in=
clude/linux/swiotlb.h:252 drivers/iommu/dma-iommu.c:1250 drivers/iommu/dma-=
iommu.c:1231)
<4>[ 9809.544947]  ? do_raw_spin_lock (./arch/x86/include/asm/atomic.h:107 =
(discriminator 1) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discr=
iminator 1) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminato=
r 1) ./include/asm-generic/qspinlock.h:111 (discriminator 1) kernel/locking=
/spinlock_debug.c:116 (discriminator 1))
<4>[ 9809.544952]  dma_unmap_phys (kernel/dma/mapping.c:212)
<4>[ 9809.544960] iwl_pcie_rx_handle (drivers/net/wireless/intel/iwlwifi/pc=
ie/gen1_2/rx.c:1311 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c:156=
5) iwlwifi
<4>[ 9809.544980]  ? kasan_save_stack (mm/kasan/common.c:59)
<4>[ 9809.544985]  ? kasan_save_stack (mm/kasan/common.c:58)
<4>[ 9809.544990]  ? __kasan_slab_free (mm/kasan/common.c:287)
<4>[ 9809.544994]  ? kmem_cache_free (mm/slub.c:6124 (discriminator 3) mm/s=
lub.c:6254 (discriminator 3))
<4>[ 9809.544999]  ? handle_softirqs (./arch/x86/include/asm/jump_label.h:3=
7 ./include/trace/events/irq.h:142 kernel/softirq.c:623)
<4>[ 9809.545003]  ? __irq_exit_rcu (kernel/softirq.c:657 kernel/softirq.c:=
496 kernel/softirq.c:723)
Oops#1 Part3
<4>[ 9809.545007]  ? irq_exit_rcu (kernel/softirq.c:741)
<4>[ 9809.545012]  ? cpu_startup_entry (kernel/sched/idle.c:429)
<4>[ 9809.545017]  ? start_secondary (arch/x86/kernel/smpboot.c:200 (discri=
minator 10) arch/x86/kernel/smpboot.c:280 (discriminator 10))
<4>[ 9809.545025]  ? iwl_pcie_rxq_alloc_rbs (drivers/net/wireless/intel/iwl=
wifi/pcie/gen1_2/rx.c:1499) iwlwifi
<4>[ 9809.545043] iwl_pcie_napi_poll_msix (drivers/net/wireless/intel/iwlwi=
fi/pcie/gen1_2/rx.c:1042) iwlwifi
<4>[ 9809.545058]  __napi_poll.constprop.0 (net/core/dev.c:7684)
<4>[ 9809.545065]  net_rx_action (net/core/dev.c:7749 net/core/dev.c:7899)
<4>[ 9809.545072]  ? run_backlog_napi (net/core/dev.c:7861)
<4>[ 9809.545079]  ? rcu_momentary_eqs (kernel/rcu/tree.c:2541)
<4>[ 9809.545086]  ? mark_held_locks (kernel/locking/lockdep.c:4325 (discri=
minator 1))
<4>[ 9809.545091]  ? handle_softirqs (./arch/x86/include/asm/paravirt.h:529=
 kernel/softirq.c:606)
<4>[ 9809.545096]  handle_softirqs (./arch/x86/include/asm/jump_label.h:37 =
=2E/include/trace/events/irq.h:142 kernel/softirq.c:623)
<4>[ 9809.545103]  ? tasklet_unlock_wait (kernel/softirq.c:580)
<4>[ 9809.545108]  ? tasklet_unlock_wait (kernel/softirq.c:580)
<4>[ 9809.545112]  ? tick_nohz_stop_idle (./include/linux/seqlock.h:453 ./i=
nclude/linux/seqlock.h:525 kernel/time/tick-sched.c:771)
<4>[ 9809.545119]  ? iwl_pcie_irq_rx_msix_handler (./include/linux/bottom_h=
alf.h:33 (discriminator 1) drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/r=
x.c:1666 (discriminator 1)) iwlwifi
<4>[ 9809.545134]  ? iwl_pcie_irq_rx_msix_handler (drivers/net/wireless/int=
el/iwlwifi/pcie/gen1_2/rx.c:1660 (discriminator 1)) iwlwifi
<4>[ 9809.545148]  do_softirq.part.0 (kernel/softirq.c:523 (discriminator 2=
0))
<4>[ 9809.545153]  </IRQ>
<4>[ 9809.545156]  <TASK>
<4>[ 9809.545158]  __local_bh_enable_ip (kernel/softirq.c:515 (discriminato=
r 1) kernel/softirq.c:450 (discriminator 1))
<4>[ 9809.545163]  ? iwl_pcie_irq_rx_msix_handler (./include/linux/bottom_h=
alf.h:33 (discriminator 1) drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/r=
x.c:1666 (discriminator 1)) iwlwifi
<4>[ 9809.545177] iwl_pcie_irq_rx_msix_handler (drivers/net/wireless/intel/=
iwlwifi/pcie/gen1_2/rx.c:1668 (discriminator 1)) iwlwifi
<4>[ 9809.545192]  ? iwl_pcie_rx_free (drivers/net/wireless/intel/iwlwifi/p=
cie/gen1_2/rx.c:1640) iwlwifi
<4>[ 9809.545206]  ? irq_thread (kernel/irq/manage.c:1058 (discriminator 3)=
 kernel/irq/manage.c:1268 (discriminator 3))
<4>[ 9809.545211]  irq_thread_fn (kernel/irq/manage.c:1143)
<4>[ 9809.545216]  irq_thread (kernel/irq/manage.c:1272)
<4>[ 9809.545220]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discrim=
inator 1))
<4>[ 9809.545225]  ? __kthread_parkme (./include/linux/instrumented.h:82 ./=
include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/kthread.c:2=
90)
<4>[ 9809.545230]  ? irq_copy_pending.isra.0 (kernel/irq/manage.c:1142)
<4>[ 9809.545235]  ? irq_forced_thread_fn (kernel/irq/manage.c:1245)
<4>[ 9809.545239]  ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/pa=
ravirt.h:529 ./arch/x86/include/asm/irqflags.h:159 ./include/linux/spinlock=
_api_smp.h:178 kernel/locking/spinlock.c:194)
Oops#1 Part2
<4>[ 9809.545243]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4472 (di=
scriminator 4))
<4>[ 9809.545247]  ? irq_has_action (kernel/irq/manage.c:1179)
<4>[ 9809.545252]  ? __kthread_parkme (./arch/x86/include/asm/bitops.h:202 =
=2E/arch/x86/include/asm/bitops.h:232 ./include/asm-generic/bitops/instrume=
nted-non-atomic.h:142 kernel/kthread.c:290)
<4>[ 9809.545263]  ? irq_forced_thread_fn (kernel/irq/manage.c:1245)
<4>[ 9809.545270]  kthread (kernel/kthread.c:467)
<4>[ 9809.545277]  ? _raw_spin_unlock_irq (./arch/x86/include/asm/paravirt.=
h:529 ./include/linux/spinlock_api_smp.h:187 kernel/locking/spinlock.c:202)
<4>[ 9809.545284]  ? kthread_affine_node (kernel/kthread.c:412)
<4>[ 9809.545292]  ret_from_fork (arch/x86/kernel/process.c:164)
<4>[ 9809.545302]  ? exit_thread (arch/x86/kernel/process.c:153)
<4>[ 9809.545312]  ? __switch_to (./arch/x86/include/asm/cpufeature.h:101 a=
rch/x86/kernel/process_64.c:377 arch/x86/kernel/process_64.c:665)
<4>[ 9809.545320]  ? kthread_affine_node (kernel/kthread.c:412)
<4>[ 9809.545330]  ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
<4>[ 9809.545351]  </TASK>
<4>[ 9809.545357] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq xt_c=
onntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntra=
ck nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat=
 x_tables nf_tables br_netfilter bridge stp llc ccm overlay qrtr rfcomm cma=
c algif_hash algif_skcipher af_alg bnep binfmt_misc ext4 mbcache jbd2 nls_a=
scii nls_cp437 vfat fat snd_acp3x_rn snd_acp3x_pdm_dma snd_soc_dmic intel_r=
apl_msr snd_soc_core snd_compress snd_hda_codec_generic amd_atl intel_rapl_=
common iwlmvm uvcvideo videobuf2_vmalloc btusb mac80211 snd_usb_audio snd_h=
da_codec_hdmi videobuf2_memops kvm_amd libarc4 btrtl uvc snd_usbmidi_lib sn=
d_pci_acp6x btintel videobuf2_v4l2 snd_rawmidi btbcm videodev kvm snd_seq_d=
evice btmtk snd_hda_intel irqbypass snd_pci_acp5x videobuf2_common snd_hda_=
codec bluetooth snd_intel_dspcfg rapl mc snd_hwdep ecdh_generic ecc wmi_bmo=
f snd_hda_core snd_rn_pci_acp3x iwlwifi snd_pcm snd_acp_config pcspkr ee100=
4 k10temp snd_soc_acpi snd_timer ac cfg80211 battery snd
Oops#1 Part1
<4>[ 9809.545588]  snd_pci_acp3x rfkill soundcore ccp joydev button amd_pmc=
 sg acpi_tad evdev msr parport_pc ppdev lp parport efi_pstore nvme_fabrics =
fuse configfs nfnetlink efivarfs autofs4 btrfs xor libblake2b raid6_pq dm_c=
rypt dm_mod r8153_ecm cdc_ether usbnet sd_mod hid_microsoft ff_memless hid_=
cmedia uas r8152 usb_storage mii scsi_mod libphy mdio_bus usbhid scsi_commo=
n amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_exec drm_suball=
oc_helper drm_buddy drm_panel_backlight_quirks gpu_sched amdxcp hid_multito=
uch drm_display_helper sp5100_tco ucsi_acpi hid_generic drm_kms_helper xhci=
_pci watchdog video typec_ucsi cec i2c_hid_acpi roles i2c_piix4 xhci_hcd gh=
ash_clmulni_intel nvme rc_core serio_raw i2c_hid amd_sfh typec i2c_smbus us=
bcore crc16 nvme_core hid thunderbolt fan usb_common wmi drm aesni_intel
<4>[ 9809.545854] ---[ end trace 0000000000000000 ]---
<4>[ 9809.764012] RIP: 0010:detach_if_pending (./include/linux/list.h:992 (=
discriminator 2) kernel/time/timer.c:891 (discriminator 2) kernel/time/time=
r.c:910 (discriminator 2))
<4>[ 9809.764021] Code: df 4c 89 ea 48 8b 2b 48 c1 ea 03 80 3c 02 00 0f 85 =
40 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 6b 08 4c 89 ea 48 c1 ea 03 =
<80> 3c 02 00 0f 85 14 02 00 00 49 89 6d 00 48 85 ed 74 23 48 b8 00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	df 4c 89 ea          	fisttps -0x16(%rcx,%rcx,4)
   4:	48 8b 2b             	mov    (%rbx),%rbp
   7:	48 c1 ea 03          	shr    $0x3,%rdx
   b:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   f:	0f 85 40 02 00 00    	jne    0x255
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df=20
  1f:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
  23:	4c 89 ea             	mov    %r13,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instru=
ction
  2e:	0f 85 14 02 00 00    	jne    0x248
  34:	49 89 6d 00          	mov    %rbp,0x0(%r13)
  38:	48 85 ed             	test   %rbp,%rbp
  3b:	74 23                	je     0x60
  3d:	48                   	rex.W
  3e:	b8                   	.byte 0xb8
	...

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 14 02 00 00    	jne    0x21e
   a:	49 89 6d 00          	mov    %rbp,0x0(%r13)
   e:	48 85 ed             	test   %rbp,%rbp
  11:	74 23                	je     0x36
  13:	48                   	rex.W
  14:	b8                   	.byte 0xb8
	...
<4>[ 9809.764025] RSP: 0018:ffffc90000708850 EFLAGS: 00010016
<4>[ 9809.764031] RAX: dffffc0000000000 RBX: ffff888107e710e0 RCX: ffffffff=
86373dde
<4>[ 9809.764033] RDX: 0000111060000000 RSI: ffffffff888b8ec0 RDI: ffffffff=
88f25138
<4>[ 9809.764036] RBP: dead000000000122 R08: 0000000000000000 R09: fffffbff=
f139f90c
<4>[ 9809.764038] R10: ffffffff89cfc867 R11: 0000000000000001 R12: 00000000=
00000000
<4>[ 9809.764040] R13: 0000888300000000 R14: ffff888107e710e8 R15: ffff8883=
8d6af9c0
<4>[ 9809.764043] FS:  0000000000000000(0000) GS:ffff888403005000(0000) knl=
GS:0000000000000000
<4>[ 9809.764046] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[ 9809.764048] CR2: 00007fad9435741c CR3: 0000000076a91000 CR4: 00000000=
00750ef0
<4>[ 9809.764051] PKRU: 55555554
<0>[ 9809.764054] Kernel panic - not syncing: Fatal exception in interrupt
<0>[ 9811.126715] Shutting down cpus with NMI
<0>[ 9811.126752] Kernel Offset: 0x4c00000 from 0xffffffff81000000 (relocat=
ion range: 0xffffffff80000000-0xffffffffbfffffff)


This could possibly be related to a similar oops I saw last week, in
that case the stack trace didn't point to iwlwifi, but the oops appeared
to be the result of memory corruption:
https://lkml.org/lkml/2026/2/18/486

