Return-Path: <linux-wireless+bounces-30249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E384CEC9ED
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 23:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4518300FE05
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 22:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682C921ABC1;
	Wed, 31 Dec 2025 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efkNvawn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326B4D8CE
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767218626; cv=none; b=QxnSlEYNjfxMACObpr8BHW/LiW6/RgTegKFbWBfa44VvhaXXfo7W0VILO/2weqTm3yzROpSRBN6JWfgttg9830Z9hep5jtc1PRJet6vRBhw8UC08TrU1PaBBJWCRbfb3fZIYWguGngoF1mmBwJMmTTdGwUMuPmpbKR3dvbJsGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767218626; c=relaxed/simple;
	bh=0lsq6d/gQPYj9SLz0dIsrDfSjoJsKz4tuuXS1LTbTBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZqxJCOlbv97FAQLlvUxqITgJk5aX+Msr5CKOKbmNJWf2hqK0swz5TOuyQ6JswS4sXa5PMp6i05HrcDm5leUopcZyxX+fiTuit8SRqDcYJxIgyF1c8YwadVwJEo3B+sgnbM319M6GUstE/agrLUqFqBF/YK7H+EVshYeCDEort0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efkNvawn; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5957c929a5eso15898384e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 14:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767218622; x=1767823422; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cjfn9DqBsPvK0Mj5U5qRNWPlKde8DxcL2uQXb+ouwsc=;
        b=efkNvawnkyFSiXypNaNEHnAbKZ6MDR6P1nwdjEY5h+ldEL4bGykSfKTAxUcKhfSKcA
         LHtuupySMvYVTk2qe/+TvhVAUhUrfKGh6qbAVTc5ATSEKY2FBxC5i4dEmSnlQ+Oyd+e2
         Ss3Aw4IJXRqNye/YTqc0rn2L6jRPnSBWko25NXDOYVUO08oZVSv7a+Y0XzqDBZkex8bn
         lq0nR9sSkGCl1gEI5zSAg1gnrigBpU00mOnU5puyPH8X1pk1C/ZZd++3eww2unYtCajj
         jzQdKdTf1P+3B2d0oQuc3iuXRDe7zI6FYI+9BzoWhj1It4u4zd4z3uBUjifJXizGZJFi
         aMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767218622; x=1767823422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cjfn9DqBsPvK0Mj5U5qRNWPlKde8DxcL2uQXb+ouwsc=;
        b=ueBKM4JUrPDEnlTDaMfixfEZoQz9Ae0+MJTl+Q2SLjErM5TiX+GImS3xsGPueskrg2
         SFoVi3BbjPD5rmjHaVB1E3zzY7rm453w4NkMEQ9lYlA0FFzN2k/NZPYd2WLJGtR2CeXo
         7QFOw/EJHPN7XGzEqsoKYxmAyIvCnky3E7HqZVVTnmWjAuplHHak6D7BevgmLQHpk4eg
         0IhiGLLkZ3yzCp8mtbh5773mpS02SZ9EoBWoekq0S8ZH3/UrWdrW2w2NAOUx7qO4ZSLL
         xOMBaTXhjakRYuZSVPwrwagXrbhuX+H/4OEzM0gdZPy9qBWPxCJr+LAvrIqucvUJNWuI
         TKeg==
X-Forwarded-Encrypted: i=1; AJvYcCUm9sE7oKibYohO8Roa8q+zeHRtstZ5zfL+hpDe3Q66+5D9XknDGQCz7HRQ11d7AswvSu/qf6ujUkK+Yvm88A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6z28htEj0kdcfRGC7PT3DPFE/QazNvOmQniSWD4EnjW+IjDAk
	eeNh1xo7aDm4ieCE9xWo/8h/Wj0tp0Blv9CiGmJm9EFZx9LWccNaLM2zOJOYdAuO
X-Gm-Gg: AY/fxX6dlt8Ufyd5zDQ3s6AUJd1CPj65BY6/ZFu0QD6thmTJdZMloqKBGDLPCjomj1Z
	j9GcGUsj5e+CZSKKMtBNO8kaHr7g3j9cHOqWnYtG/72LeWY/OEEP8O2bNZe3U9r7IGUuDnew6kf
	nN5vS/BA4Do6Z5IT8t7VcsWI/tmAUcXSID7lZVb6460I5BROnj9YLq3bIvKpcp114Fn4H/Ko2No
	BMD42c61F1I1ShtMI6BePKurmH5FUCJomehoDTCssoKB/0+JqaL9h5rvarOLf3ENiEZQs7cFUs7
	qlWZ2zq2mSF9ERuXmR3skd6yyPmY4pfaqvmHLyWW19JKHNE6BCQ16FmTFbT66NigI/mJZNpLivX
	aZ+nSRBmffcRLEXTPqhXuhkO6AZ1SjFLllox5Rt1ZzNlDY4gg+q6dh0K8k8pfJMS+N2QxA96T/I
	/nr1mXaGYGwCqZdRH12AO2ffMkRXYB8be9UhPvHdWqN7iK
X-Google-Smtp-Source: AGHT+IHid0Vwou13jAYw+90m8rZaMWJ/iPwOUATtSlFQor2Cm5pCVyRHF9dvuerOeRa+ds+XbflU8Q==
X-Received: by 2002:a05:6000:40dc:b0:432:8667:51c7 with SMTP id ffacd0b85a97d-43286675205mr19637524f8f.44.1767212040335;
        Wed, 31 Dec 2025 12:14:00 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm75936755f8f.7.2025.12.31.12.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 12:13:59 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 8B3B7BE2DE0; Wed, 31 Dec 2025 21:13:58 +0100 (CET)
Date: Wed, 31 Dec 2025 21:13:58 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: "Dylan E." <dylan.eskew@candelatech.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, gregkh@linuxfoundation.org,
	sashal@kernel.org, jjohnson@kernel.org
Subject: Re: [BUG 6.18.2] Null Pointer Exception in Fair Scheduler
Message-ID: <aVWEBthpdfNX_Mst@eldamar.lan>
References: <38b9cad8-1c17-4d89-9f17-44f89fb66ab8@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38b9cad8-1c17-4d89-9f17-44f89fb66ab8@candelatech.com>

Hi Dylan,

On Wed, Dec 31, 2025 at 12:00:07PM -0800, Dylan E. wrote:
> Hello,
> 
> When booting into the v6.18.2 tagged kernel from linux-stable, I get the
> following
> stack trace while booting into the system every 1 in 5 boots or so, usually
> during
> fsck or early systemd service initialization:
> 
> ---
> BUG: kernel NULL pointer dereference, address: 0000000000000051
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP
> CPU: 0 UID: 0 PID: 15 Comm: rcu_preempt Not tainted 6.18.2 #2 PREEMPT(full)
> Hardware name:  /SKYBAY, BIOS 5.12 06/27/2017
> RIP: 0010:pick_task_fair+0x57/0x160
> Code: 66 90 66 90 48 8b 5d 50 48 85 db 74 10 48 8b 73 70 48 89 ef e8 3a 74
> ff ff 85 c0 75 71 be 01 00 00 00 48 89 ef e8 29 a5 ff ff <80> 78 51 00 48 89
> c3 0f 85 80 00 00 00 48 85 c0 0f 84 87 00 00 00
> RSP: 0000:ffffc900000d3cf8 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000800
> RDX: fffffc02295d3c00 RSI: 0000000000000800 RDI: 0000000002edc4f2
> RBP: ffff888108f13000 R08: 0000000000000400 R09: 0000000000000002
> R10: 0000000000000260 R11: ffff888108b74200 R12: ffff888265c2cd00
> R13: 0000000000000000 R14: ffff888265c2cd80 R15: ffffffff827c6fa0
> FS:  0000000000000000(0000) GS:ffff8882e2724000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000051 CR3: 00000001110a5003 CR4: 00000000003706f0
> Call Trace:
>  <TASK>
>  pick_next_task_fair+0x1d/0x3d0
>  __schedule+0x1ee/0x10c0
>  ? lock_timer_base+0x6d/0x90
>  ? rcu_gp_cleanup+0x560/0x560
>  schedule+0x23/0xc0
>  schedule_timeout+0x6e/0xe0
>  ? hrtimers_cpu_dying+0x1b0/0x1b0
>  rcu_gp_fqs_loop+0xfb/0x510
>  rcu_gp_kthread+0xcd/0x160
>  kthread+0xf5/0x1e0
>  ? kthreads_online_cpu+0x100/0x100
>  ? kthreads_online_cpu+0x100/0x100
>  ret_from_fork+0x114/0x140
>  ? kthreads_online_cpu+0x100/0x100
>  ret_from_fork_asm+0x11/0x20
>  </TASK>
> Modules linked in: i915 drm_buddy intel_gtt drm_client_lib
> drm_display_helper drm_kms_helper igb cec dca rc_core i2c_algo_bit ttm
> agpgart e1000e serio_raw hwmon drm mei_wdt i2c_core intel_oc_wdt video wmi
> CR2: 0000000000000051
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:pick_task_fair+0x57/0x160
> Code: 66 90 66 90 48 8b 5d 50 48 85 db 74 10 48 8b 73 70 48 89 ef e8 3a 74
> ff ff 85 c0 75 71 be 01 00 00 00 48 89 ef e8 29 a5 ff ff <80> 78 51 00 48 89
> c3 0f 85 80 00 00 00 48 85 c0 0f 84 87 00 00 00
> RSP: 0000:ffffc900000d3cf8 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000800
> RDX: fffffc02295d3c00 RSI: 0000000000000800 RDI: 0000000002edc4f2
> RBP: ffff888108f13000 R08: 0000000000000400 R09: 0000000000000002
> R10: 0000000000000260 R11: ffff888108b74200 R12: ffff888265c2cd00
> R13: 0000000000000000 R14: ffff888265c2cd80 R15: ffffffff827c6fa0
> FS:  0000000000000000(0000) GS:ffff8882e2724000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000051 CR3: 00000001110a5003 CR4: 00000000003706f0
> Kernel panic - not syncing: Fatal exception
> Shutting down cpus with NMI
> Kernel Offset: disabled
> Rebooting in 30 seconds..
> ---
> 
> I can't seem to reproduce this issue with the v6.18.1 tagged linux-stable
> build, and
> after bisecting between v6.18.1 and v6.18.2, I land on this commit (which is
> clearly
> not the problem):
> 
> d911fa97dab3ba026a8b96bb7f833d007b7fc4e1 | wifi: ath12k: fix VHT MCS
> assignment
> 
> I don't have any ath12k radios in my system, but I do have 1 ath9k and 2
> ath10k
> radios. A little up the tree I see this patch which *could* be related, but
> I lack
> the knowledge to know:
> 
> b1497ea246396962156b63d5c568a16d6e32de0b | wifi: ath10k: move recovery check
> logic into a new work
> 
> Let me know if there's any more info that's needed or additional steps I can
> take to
> further diagnose the bug.

This should be the same issue as reported in
https://lore.kernel.org/oe-lkp/202510211205.1e0f5223-lkp@intel.com/
and then fixed in mainline with 127b90315ca0 ("sched/proxy: Yield the
donor task") .

Can you confirm picking this commit fixes the issue?

Regards,
Salvatore

