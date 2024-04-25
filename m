Return-Path: <linux-wireless+bounces-6850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D321B8B25B1
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 17:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7388C1F21677
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2744A14A096;
	Thu, 25 Apr 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cpl17gQJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1314149E05;
	Thu, 25 Apr 2024 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060355; cv=none; b=PZQ+eS4LGn4Gb5b9nXgzx1qaEDt7GaM0bY2cZurD1rYdKEAEOgDYMJjA55QyQL6mkEEh+5KTayXHtGgx5lGIROd8R3sEs4xTBWEhfa5Q/9NtPjdBb/LjwH0xLAOaLu0hVQ7ODQIsW69iM5SXD2i9Sne/zfHLePmJPt4kWQenO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060355; c=relaxed/simple;
	bh=B7Wmbm/n62aWiRnQINEzBVkAKyQUnC6b/81Q7ziiERY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=aRd8BzGo2lT3xojBB7M5n7Fpq5q63jHrriqlCly+5PqCcuXCWnkEv3FnKPlT6YWsSixTAc6puEXiU7MN1uujaSSGDFJT/ZX9JfRwsKQTGpHxVFMvocfZmrDgR63n8NIBcyxWjHrB0zoFy4bQSiqhBtO2N8YkhuYkNLNfrl0meLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cpl17gQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0A0C113CC;
	Thu, 25 Apr 2024 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714060354;
	bh=B7Wmbm/n62aWiRnQINEzBVkAKyQUnC6b/81Q7ziiERY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Cpl17gQJo6f4S7YharycS9+9clLcvEGJCo+FiOgL/rhae/OTS7MktDX8WQIQIGqCN
	 8cfsMuvqx2rAc2a1lJdXw/7TJg9OCxIc4ytRRqd6TZ8y25XSeMEbPU0bbUCcIOpAsa
	 kXH2VCrv6fCSrMB6T5AAzrXxkgoRpNjveXo1gFuY2gOJXWAtrJWjCrwnVDZ9Wmo8AV
	 TOhdpKNVp7W2phgu5yAMqLeeHxktFBlma6kwbRvWkaN6tZA45jSumM/GLcHiZpBDi9
	 dp4DhGY5HgUFEZTJTBEvJFy/H6AdlIzxK3xH7eL/jctWgm7GcZQAcovaeeTgAirA33
	 kZq0Q+wqC2zOQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ar5523: enable proper endpoint verification
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240408121425.29392-1-n.zhandarovich@fintech.ru>
References: <20240408121425.29392-1-n.zhandarovich@fintech.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Wu Yunchuan
	<yunchuan@nfschina.com>, Johannes Berg <johannes.berg@intel.com>, "Breno
 Leitao" <leitao@debian.org>, <linux-wireless@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
 <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171406032921.2967849.6111681305541795423.kvalo@kernel.org>
Date: Thu, 25 Apr 2024 15:52:23 +0000 (UTC)

Nikita Zhandarovich <n.zhandarovich@fintech.ru> wrote:

> Syzkaller reports [1] hitting a warning about an endpoint in use
> not having an expected type to it.
> 
> Fix the issue by checking for the existence of all proper
> endpoints with their according types intact.
> 
> Sadly, this patch has not been tested on real hardware.
> 
> [1] Syzkaller report:
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> WARNING: CPU: 0 PID: 3643 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
> ...
> Call Trace:
>  <TASK>
>  ar5523_cmd+0x41b/0x780 drivers/net/wireless/ath/ar5523/ar5523.c:275
>  ar5523_cmd_read drivers/net/wireless/ath/ar5523/ar5523.c:302 [inline]
>  ar5523_host_available drivers/net/wireless/ath/ar5523/ar5523.c:1376 [inline]
>  ar5523_probe+0x14b0/0x1d10 drivers/net/wireless/ath/ar5523/ar5523.c:1655
>  usb_probe_interface+0x30f/0x7f0 drivers/usb/core/driver.c:396
>  call_driver_probe drivers/base/dd.c:560 [inline]
>  really_probe+0x249/0xb90 drivers/base/dd.c:639
>  __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
>  __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:936
>  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:427
>  __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
>  bus_probe_device+0x1e8/0x2a0 drivers/base/bus.c:487
>  device_add+0xbd9/0x1e90 drivers/base/core.c:3517
>  usb_set_configuration+0x101d/0x1900 drivers/usb/core/message.c:2170
>  usb_generic_driver_probe+0xbe/0x100 drivers/usb/core/generic.c:238
>  usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
>  call_driver_probe drivers/base/dd.c:560 [inline]
>  really_probe+0x249/0xb90 drivers/base/dd.c:639
>  __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
>  __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:936
>  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:427
>  __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
>  bus_probe_device+0x1e8/0x2a0 drivers/base/bus.c:487
>  device_add+0xbd9/0x1e90 drivers/base/core.c:3517
>  usb_new_device.cold+0x685/0x10ad drivers/usb/core/hub.c:2573
>  hub_port_connect drivers/usb/core/hub.c:5353 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
>  port_event drivers/usb/core/hub.c:5653 [inline]
>  hub_event+0x26cb/0x45d0 drivers/usb/core/hub.c:5735
>  process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
>  worker_thread+0x669/0x1090 kernel/workqueue.c:2436
>  kthread+0x2e8/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>  </TASK>
> 
> Reported-and-tested-by: syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com
> Fixes: b7d572e1871d ("ar5523: Add new driver")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Does anyone have a real device to test this? I have had so much problems with
syzbot fixes in the past that I'm hesitant to take such patches without
testing.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240408121425.29392-1-n.zhandarovich@fintech.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


