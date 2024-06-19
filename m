Return-Path: <linux-wireless+bounces-9232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E2D90E2C7
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 07:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5D40B2219A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 05:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A60558BB;
	Wed, 19 Jun 2024 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXwZQEU7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E949FC1F;
	Wed, 19 Jun 2024 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775832; cv=none; b=LLonIjg9C4fn8tTCYqnBLdKEFyL3WGCOtmUkf6rRWWvfYpc4+ssZdOWi2sEdFFu5QPLrjeJRUgDZ7RHuhYduyWLdkdsOnZsfu3rOvkqS+VLm45oLX9+CW/NvZQqbYa4WJNi8iL261B0JiDusHq+oHaYxZBXAP3K3aZ3mrt8shrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775832; c=relaxed/simple;
	bh=1MWDSgrROFhu76DSyxYy7yjYvYvBvDjlXn+sMPQhZZw=;
	h=From:To:Subject:Date:CC:Message-ID:MIME-Version:Content-Type; b=Evnw5XHOZoma2hrw5O1IDaSecuHobR6zmJ3sHe9IyF1uGgB/NrmOhpFJ+DtdXqWH7mpLX+NO2VHswakbgzs5zdepycncrHaqNwdL8FHqAtyAEnfYy86fYduCGm/ZeS9caNCHgopZ70FVTQ/v2LRlidTE+sUebuZNCtlJFDBEhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXwZQEU7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f64ecb1766so44747175ad.1;
        Tue, 18 Jun 2024 22:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718775830; x=1719380630; darn=vger.kernel.org;
        h=mime-version:message-id:cc:date:subject:to:from:user-agent:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1MWDSgrROFhu76DSyxYy7yjYvYvBvDjlXn+sMPQhZZw=;
        b=LXwZQEU7SCYtcv2Dv+2yCz21W/i1lOlr4jmI0JqSSdSLZrcv6l7c+dABXHlMxRuZ2Y
         hD1eRaLzVKsG/g8KO1Sj7pbmuHPv2gkzc52ntgNXYDK9LqHzMJmepGndpP0hutovCeI0
         oHu6Zz96HHOrVtm5yHVnUl7AA8ikPu3XjEoY5UUZZHTnNGZsook2G7IYXenWShoWN/mv
         tx/ZOtNKOdu2oUqkWfLAUtwQfQc4+BklJBKamqqflJ8QWsxdw5wfB7yrZqnUJofgVJ6f
         1QQ39EIbEZ03o2wEqqnQo0yB8ZVFuM1Jz6yhHhrkid9Lkv2ruytwm1O6jCSlHh8OLO8v
         XnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718775830; x=1719380630;
        h=mime-version:message-id:cc:date:subject:to:from:user-agent
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MWDSgrROFhu76DSyxYy7yjYvYvBvDjlXn+sMPQhZZw=;
        b=qFD6be3VC6FzkfXBYoPzaPsSGVwoMc4ex+CnGes8u5ThaNDq7oV/T+xFaxgqsXnDDG
         Ka6V+Xn9HGCuEMYoSkA/kv91Vmt4nHYCL/a1xoifYI9XSrhXoysN8ZP4ugcFXb1X5akn
         debpw5W/wIVreINdVLNM4ouNMOhRkQz4KyY7DWNeo80VAWzaCuQL19xlyduFLRotPRlb
         ZwcdzCoe5FmPSRgeoG8ZrJxtCX1O+Rc8nvjlMHufVZAdsROBmk51n2m9Zc87mIdwAnRq
         WntNahJz/Tk2e9XlDUseDflh+i5G8v8Ng/n/x9dvOXEF5dkt6vXV8G5nR2950HEWutL9
         /fUw==
X-Gm-Message-State: AOJu0YxGGqyVUQ3epsjdCvZM89Tcfz0eYNK4BQJpYqfOiHD4JqwKSRI8
	TjX+M8ppbxxB8dmO9Op0G+Yo5NwdXZ754O0GPTGBciBH1sC2RNtw
X-Google-Smtp-Source: AGHT+IG4cfqY0r085GVp78gHD0WvEwQnaNKB8ctJdXB3EzIEPfgwgJ/alDtu38pkvaE8lUWvr11uPA==
X-Received: by 2002:a17:903:40c7:b0:1f7:1cbc:184b with SMTP id d9443c01a7336-1f9aa3c362cmr17571975ad.20.1718775829404;
        Tue, 18 Jun 2024 22:43:49 -0700 (PDT)
Received: from terra ([122.171.16.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e704desm107512475ad.75.2024.06.18.22.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:43:48 -0700 (PDT)
User-agent: Mozilla/5.0 (Windows NT 6.1; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0 Lightning/4.0.2
From: Forty Five <mathewegeorge@gmail.com>
To: linux-wireless@vger.kernel.org
Subject: [REGRESSION] Freeze on resume from S3 (bisected)
Date: Wed, 19 Jun 2024 10:09:03 +0530
CC: linux-pm@vger.kernel.org,phhuang@realtek.com,pkshih@realtek.com,kvalo@kernel.org,regressions@lists.linux.dev
Message-ID: <87tthpwkqf.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


I've been experiencing system freezes that require a hard reset with the
power button, starting from v6.8-rc1. The warnings produced suggest a
wireless-related issue, and the bisection seems to confirm this.

The freezes usually occur right after resuming from S3 (suspend). To
reproduce the issue, I just suspend (`sudo systemctl suspend`) and
resume (press any key on keyboard) a few times until the freeze happens.
It takes 4-5 cycles of this most of the time, though it varies a lot.

The upshot of all of this is that S3 (and S4 as well, see below) are
pretty much unusable for me, due to the risk of losing work due to a
freeze.

Since a hard reset causes the systemd journal to be dropped, I set up
[kdumpst](https://gitlab.freedesktop.org/gpiccoli/kdumpst) so that I
could record dmesg output at the time of the freeze. I've linked to the
crash logs produced by that tool for every bad commit in the bisection
(except in cases where I couldn't get the kdump to happen - see the
comments in the bisection log below), as well as a crash log triggered
by SysRq (Alt+SysRq+c) on a good commit for comparison.

I've already submitted this as an Arch Linux bug report:
https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/61

The freezes have also occurred (seemingly) at random times, although
this is quite rare. They do seem to be more likely to occur after the
system has been hibernated, although I don't really have any way to
confirm this.


Git bisect log:

git bisect start
# status: waiting for both good and bad commits
# bad: [83a7eefedc9b56fe7bfeff13b6c7356688ffa670] Linux 6.10-rc3
git bisect bad 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
# good: [e8f897f4afef0031fe618a8e94127a0934896aba] Linux 6.8
git bisect good e8f897f4afef0031fe618a8e94127a0934896aba
# bad: [445e60303883950161f67e18b9f048b18d7fb706] Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
git bisect bad 445e60303883950161f67e18b9f048b18d7fb706
# bad: [e5e038b7ae9da96b93974bf072ca1876899a01a3] Merge tag 'fs_for_v6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
# this one froze on the first suspend/resume
git bisect bad e5e038b7ae9da96b93974bf072ca1876899a01a3
# good: [1f440397665f4241346e4cc6d93f8b73880815d1] Merge tag 'docs-6.9' of git://git.lwn.net/linux
git bisect good 1f440397665f4241346e4cc6d93f8b73880815d1
# bad: [a2f24c8a955c8f941d6ac08dd7f401f54eef4627] Merge branch 'mptcp-some-clean-up-patches'
git bisect bad a2f24c8a955c8f941d6ac08dd7f401f54eef4627
# bad: [26f4dac11775a1ca24e2605cb30e828d4dbdea93] netfilter: x_tables: Use unsafe_memcpy() for 0-sized destination
# This one was very hard to reproduce - it must have taken 25-30 cycles total, and I hibernated the system twice
git bisect bad 26f4dac11775a1ca24e2605cb30e828d4dbdea93
# good: [4f5e5092fdbf5cec6bedc19fbe69cce4f5f08372] Merge tag 'net-6.8-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good 4f5e5092fdbf5cec6bedc19fbe69cce4f5f08372
# good: [b4e8ae5c8c41355791a99fdf2fcac16deace1e79] net: add napi_busy_loop_rcu()
git bisect good b4e8ae5c8c41355791a99fdf2fcac16deace1e79
# bad: [20ea9327c2fd545d6b96e998727bcd724290694d] net: dccp: Simplify the allocation of slab caches in dccp_ackvec_init
git bisect bad 20ea9327c2fd545d6b96e998727bcd724290694d
# bad: [92046e83c07b064ca65ac4ae7660a540016bdfc1] Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
git bisect bad 92046e83c07b064ca65ac4ae7660a540016bdfc1
# bad: [b54846da45942bbe4e5ebc59d497e4a48525ba5a] Merge tag 'wireless-next-2024-01-25' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
git bisect bad b54846da45942bbe4e5ebc59d497e4a48525ba5a
# good: [3832a9c40b356500c5b85a6fdf9577c590fcd637] wifi: rtw89: fw: extend JOIN H2C command to support WiFi 7 chips
git bisect good 3832a9c40b356500c5b85a6fdf9577c590fcd637
# bad: [5ba45ba77616637e554d66a57ef0334e5cc2efe4] wifi: rtw89: fix disabling concurrent mode TX hang issue
# I see the same kernel warnings here as with the other bad commits.
# However, there is no crash after a few suspend/resume cycles - instead
# the system simply restarts when I trigger the nth suspend. I'm not
# able to trigger a crash with SysRq either (Alt+SysRq+c) - again, the
# system restarts. This is the case with all bad commits after this.
git bisect bad 5ba45ba77616637e554d66a57ef0334e5cc2efe4
# good: [85da8f71aaa7b83ea7ef0e89182e0cd47e16d465] wifi: brcmfmac: Demote vendor-specific attach/detach messages to info
git bisect good 85da8f71aaa7b83ea7ef0e89182e0cd47e16d465
# good: [295304040d9f6f350b68652acd99650c7e16d0a8] wifi: rtw89: 8922a: add TX power related ops
git bisect good 295304040d9f6f350b68652acd99650c7e16d0a8
# good: [7cf6b6764b2f665d317ba0f91c247437019a2f4c] wifi: rtw89: Set default CQM config if not present
git bisect good 7cf6b6764b2f665d317ba0f91c247437019a2f4c
# good: [7e11a2966f51695c0af0b1f976a32d64dee243b2] wifi: rtw89: fix null pointer access when abort scan
git bisect good 7e11a2966f51695c0af0b1f976a32d64dee243b2
# bad: [f59a98c82534e986b06615ba94e060aa3129b08b] wifi: rtw89: fix HW scan timeout due to TSF sync issue
git bisect bad f59a98c82534e986b06615ba94e060aa3129b08b
# bad: [bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23] wifi: rtw89: add wait/completion for abort scan
git bisect bad bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23
# first bad commit: [bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23] wifi: rtw89: add wait/completion for abort scan


#regzbot introduced: bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23


Logs produced by kdumpst:

[kdumpst-e5e038b7ae9da96b93974bf072ca1876899a01a3.zip](https://gitlab.archlinux.org/archlinux/packaging/packages/linux/uploads/b925cb5e9c6cfb6b224993c017ba61f5/kdumpst-e5e038b7ae9da96b93974bf072ca1876899a01a3.zip)

[kdumpst-b54846da45942bbe4e5ebc59d497e4a48525ba5a.zip](https://gitlab.archlinux.org/archlinux/packaging/packages/linux/uploads/e1610c3ae26971a890121d3a5eb8fa9e/kdumpst-b54846da45942bbe4e5ebc59d497e4a48525ba5a.zip)

[kdumpst-a2f24c8a955c8f941d6ac08dd7f401f54eef4627.zip](https://gitlab.archlinux.org/archlinux/packaging/packages/linux/uploads/34171a87da304987cc8ce5066fc35dd5/kdumpst-a2f24c8a955c8f941d6ac08dd7f401f54eef4627.zip)

[kdumpst-92046e83c07b064ca65ac4ae7660a540016bdfc1.zip](https://gitlab.archlinux.org/archlinux/packaging/packages/linux/uploads/67d756f963ffafd0b332c88701286a30/kdumpst-92046e83c07b064ca65ac4ae7660a540016bdfc1.zip)

[kdumpst-445e60303883950161f67e18b9f048b18d7fb706.zip](https://gitlab.archlinux.org/archlinux/packaging/packages/linux/uploads/f75f91d127050a327114bf904f335087/kdumpst-445e60303883950161f67e18b9f048b18d7fb706.zip)

[kdumpst-26f4dac11775a1ca24e2605cb30e828d4dbdea93.zip](https://gitlab.archlinux.org/archlinux/packaging/packages/linux/uploads/f3d26fc4187c8b8854386fed6f15c972/kdumpst-26f4dac11775a1ca24e2605cb30e828d4dbdea93.zip)

[kdumpst-20ea9327c2fd545d6b96e998727bcd724290694d.zip](https://gitlab.archlinux.org/archlinux/packaging/packages/linux/uploads/8618207aff0eb92413ce0c2994c7888f/kdumpst-20ea9327c2fd545d6b96e998727bcd724290694d.zip)

Good commit: [kdumpst-e8f897f4afef0031fe618a8e94127a0934896aba.zip](https://gitlab.archlinux.org/archlinux/packaging/packages/linux/uploads/b13b3914e50fc85548c77a4163dec383/kdumpst-e8f897f4afef0031fe618a8e94127a0934896aba.zip)
--

