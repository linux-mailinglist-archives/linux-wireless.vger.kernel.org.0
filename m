Return-Path: <linux-wireless+bounces-28454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7C1C2808C
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 15:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB881A22EB1
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F58B2882AA;
	Sat,  1 Nov 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyDBaAJL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C8189B84
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762006166; cv=none; b=annKY0fRppK0IhH7vvNpRPnr90KqK8tcWClnY/3PUjfUEkHQcMDiDYpaZEGw4QxYP9OuRauNWS0qq007Vi6sWcQ2Gaosg8PjrlWuTRfUOKHM2b2T/BFmowPngjjUM+r9AxSt3odZmHh3Tb7motWmiIBwyE+zFCb7vR0SqHE2j7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762006166; c=relaxed/simple;
	bh=bY9A7f5T0avlV6x9P7sAniPcVef5NAIJ1un1OSez7LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aJXrLTfqymcjrZXx3aCj5rUa9EEbSG4SK95rdqQ8RWHYziSOnXl0b3lwevNxUniDQjTMhA00T9fouopL+fIXugRJZHlsuInNK1M4sZPgepkoCJELuXZ2zZ2yHfpO//bNQUM5zCOZDGopm8Wa6P51WiueErANzlMdz69wLBvMTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyDBaAJL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4771b03267bso21033275e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762006163; x=1762610963; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Ujb8Z63OBL3/S9qdmCFHVoYEyV/TIBIToVJZuS5+7tQ=;
        b=GyDBaAJLBxmjKWvrQi8a0+WdY5ueDwhXP/VxQIBttqnW95vw2BT0tO6UNdNN70l4r7
         hbkGXMT4NtI6Uz7sxZi32HbbctsgrdLpv3aTPqxghats4qCGWKGmPnlL5n9geKy6+/NS
         VIevcXCTv5aWJ/UO+6Pp1khYvclkEKay1XX0q8P0ICtm+mxGGPVXOHfNnooXBgJGLKBi
         ywN4dvzkEitg8EiexAwvs/NsDADz6m5kwzgIYGBg+a7x5fOM2sJyBAIWWPANWRrV+Pa5
         nJgXwPgYDe+Q41BT0gfdGiYj6mwmRKyd4ssMvfMHIqMHCfRAfwkBEdRlD8CbJhVNyEp0
         NBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762006163; x=1762610963;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ujb8Z63OBL3/S9qdmCFHVoYEyV/TIBIToVJZuS5+7tQ=;
        b=eLbwWBg7bUyx2mb1EaCdMwpWcpNYZvsKsBl6iIkGbrf7+WSVp+BZeonB28jCo54kyb
         9KlgeN/F8KQG8kLw7nXovC0vT5cjEO3B+Z1neJ9s8gCI0zcAPSqnjSvFrx5PiFQBeIeG
         GjjFeW3aH3u5eZOYxFWQ2Obln13bQIEv81AvnyVnQ030a42kIrRddZlYflmo4iAMrnND
         xaGHVR3ILe0DesJxfTmZcse7HTfXmjnZ6TCyXcmWi8OiFYx9n0j5UWYIMUU0pkr2RJ8x
         V7J4T9U5YmtPM60VmBPEWOgcEMD5GNJMQ8IgPzM68+6wwmt44rbI70p3KyJFaXjHDPN7
         rhAg==
X-Gm-Message-State: AOJu0YzjIumL1hOgKHeopYOnlQUPt8WGpJ34M6zMvL04pWoTMtv+hqh0
	AHOaNsacn7WIQinC6fcZzkTvYvNgkDfp+qapEZNL3w95CiPG9hmBj9Hf
X-Gm-Gg: ASbGncuH7WB6oCuSvLf1d1ft+GphVHt9UZ0dkQrxfkAzrHZuQYxAbijbRfZ6tCmeqBc
	Itygw0ZLJKESSwiDuR3Ov+b2g5MJmrlkqgOCP0SXMhtATeKwHiokQXR149yLQMav2/8mDnb6Umq
	xLrcM3KOQtW8Xc0Ff7cuccrBYR8CDtOS3LirbgrRZ9eZyUV4OGdzSEczejdKEmusSg9lXmta5X7
	ls0Ucpk6DRv6JZznUwVaesnzHSAbCnEndewTZmwvhZa/VkWZAISwt5bmv27HPIGTdmUI69cE394
	73pU6/NZ2K6KtzNstR/pEoHp/Gxti5S3HBXhQoDuhmOpPLc67523W/nM+bG6IE/KEtCQtez/NQm
	p8HDXnA82O7LQMvcCSFO9WyzAUUFnTiSPN++DjS0z87PYb3yk6NCUqiydgL1qxC6f4HS75NfTqG
	BJeFFt0Blg252abY4doCIW8nDls7JrW13UEppiSbKREqNf
X-Google-Smtp-Source: AGHT+IFskyqA/JihqRH0qYQj327yRRIPGRIxKarRuLsTMEIc/CthCSy1c5cMTqDg14hazFeNlgL2nw==
X-Received: by 2002:a05:600c:b85:b0:46e:4a30:2b0f with SMTP id 5b1f17b1804b1-477308908c6mr63633035e9.29.1762006162214;
        Sat, 01 Nov 2025 07:09:22 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4af7c7sm51176185e9.7.2025.11.01.07.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:09:21 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 1F065BE2EE7; Sat, 01 Nov 2025 15:09:20 +0100 (CET)
Date: Sat, 1 Nov 2025 15:09:20 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jiri Slaby <jirislaby@kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vincent Danjean <vdanjean@debian.org>, 1119093@bugs.debian.org
Subject: UBSAN array-index-out-of-bounds in ath5k driver
Message-ID: <aQYUkIaT87ccDCin@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

In Debian, https://bugs.debian.org/1119093, Vincent Danjean reported
the following:

>   Hi,
> 
>   The ath5k driver seems to do an array-index-out-of-bounds access
> as shown by the UBSAN kernel message.
> [   17.954484] ------------[ cut here ]------------
> [   17.954487] UBSAN: array-index-out-of-bounds in /build/reproducible-path/linux-6.16.3/drivers/net/wireless/ath/ath5k/base.c:1741:20
> [   17.955289] index 4 is out of range for type 'ieee80211_tx_rate [4]'
> [   17.956134] CPU: 1 UID: 0 PID: 1745 Comm: 16 Not tainted 6.16.3+deb13-amd64 #1 PREEMPT(lazy)  Debian 6.16.3-1~bpo13+1 
> [   17.956137] Hardware name: Gigabyte Technology Co., Ltd. H67A-UD3H-B3/H67A-UD3H-B3, BIOS F8 03/27/2012
> [   17.956139] Call Trace:
> [   17.956142]  <TASK>
> [   17.956145]  dump_stack_lvl+0x5d/0x80
> [   17.956154]  ubsan_epilogue+0x5/0x2b
> [   17.956158]  __ubsan_handle_out_of_bounds.cold+0x46/0x4b
> [   17.956162]  ath5k_tasklet_tx+0x4e0/0x560 [ath5k]
> [   17.956173]  tasklet_action_common+0xb5/0x1c0
> [   17.956178]  handle_softirqs+0xdf/0x320
> [   17.956181]  __irq_exit_rcu+0xbc/0xe0
> [   17.956184]  common_interrupt+0x47/0xa0
> [   17.956188]  asm_common_interrupt+0x26/0x40
> [   17.956191] RIP: 0033:0x7f4fa439067d
> [   17.956204] Code: 0f b6 14 16 45 85 c0 74 01 92 29 d0 c3 48 8d 3c 07 48 8d 34 0e 45 85 c0 74 03 48 87 f7 48 0f bc d2 49 29 d3 76 0b 0f b6 0c 16 <0f> b6 04 17 29 c8 c3 31 c0 c3 66 0f 1f 84 00 00 00 00 00 0f b6 0e
> [   17.956206] RSP: 002b:00007ffd8cc32f08 EFLAGS: 00000212
> [   17.956209] RAX: 0000000000000020 RBX: 0000556dfab414a0 RCX: 0000000000000070
> [   17.956210] RDX: 000000000000000d RSI: 00007f4fa4b7a05f RDI: 0000556dfab414a0
> [   17.956211] RBP: 00007f4fa4b7a05f R08: 0000000000000400 R09: 0000000000000008
> [   17.956213] R10: fffffffffffff4b8 R11: 000000000000000e R12: 000000000000001b
> [   17.956214] R13: 0000556dfab412c0 R14: 00007ffd8cc32f80 R15: 00007f4fa4b79eaf
> [   17.956217]  </TASK>
> [   17.956217] ---[ end trace ]---
> 
> It occurs once at each boot.
> According to
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable/+blame/master/drivers/net/wireless/ath/ath5k/base.c
> the line of code has not changed for about 15 years.
> And I'm using this driver for more than 10 years.
> So, the array-index-out-of-bounds does not seem to
> have hard consequences for now (by luck?)
> 
>   Regards,
>     Vincent

Does that ring any bell?

Regards,
Salvatore

