Return-Path: <linux-wireless+bounces-15793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA79DBDD5
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 00:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7490B21190
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 23:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89CC1C07FC;
	Thu, 28 Nov 2024 23:02:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8D14D6ED;
	Thu, 28 Nov 2024 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732834958; cv=none; b=S9Wjd6dIEGvBqvzeM0fv1QQpMDI8EB4rvJ1dCM1+g714kV2ea9gGFG7qUZ8MKbreC++UoIMBvUmt5Ib+wsJJbUzQ1ipi7AAXxZiNNuG4JOiBD5icp1R8IcH3E9bKljH+KlJxN1oBV2C4OdR3C5051Xfv0C9Cg/bFJNiBweCEY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732834958; c=relaxed/simple;
	bh=uWjIpIEOgElQIMv1XFirw5baSTrsZqB12pjmk7cD6bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nxe+puo/QpOb4GbmQ1Oy5Yfg/qurl7sqgszz03juKfvRLxaZFTSRnAsPIPC4nJCDyVy9yV6wb4iFhifWoBzKv08i9Ab8UcDBaLTIO5wLfPhXhP3gECeC+2Qub5uHMG+We26L0LOSSxq7txfRWGI3G8yTFhPptbqYD1WzvZgdJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af40d.dynamic.kabel-deutschland.de [95.90.244.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 33CAF61E5FE05;
	Fri, 29 Nov 2024 00:01:56 +0100 (CET)
Message-ID: <5c9bf757-a035-499c-a1ef-ac33c1c6e75b@molgen.mpg.de>
Date: Fri, 29 Nov 2024 00:01:55 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING: drivers/net/wireless/ath/ath10k/mac.c:8750
 ath10k_mac_update_vif_chan+0x237/0x2e0 [ath10k_core]
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev
References: <637c5bb4-5278-44be-9ac3-9c0ef9297162@molgen.mpg.de>
 <8734jcx60e.fsf@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <8734jcx60e.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kalle,


Thank you for your reply.


Am 27.11.24 um 12:36 schrieb Kalle Valo:
> Paul Menzel writes:
> 
>> On the Dell XPS 13 9360 with Linux 6.12.0-08446-g228a1157fb9f, I
>> noticed the trace below:
> 
> For others, commit 228a1157fb9f is from current merge window so the
> first release will be in v6.13-rc1.
> 
>> [16805.002289] ------------[ cut here ]------------
>> [16805.002296] WARNING: CPU: 3 PID: 65835 at drivers/net/wireless/ath/ath10k/mac.c:8750 ath10k_mac_update_vif_chan+0x237/0x2e0 [ath10k_core]
> 
> [...]
> 
>> I do not see such a message in the logs since September 19th, so I
>> believe it’s a regression.
> 
> Have you seen it only this one time or multiple times?

I have seen it only this one time.

> What kernels have you been testing prior? I'm trying to pinpoint what
> versions kernel version work and what have this warning.
Before I ran 6.12.0-07749-g28eb75e178d3 without seeing this. As it only 
occurred once, that does not give any pointer though.


Kind regards,

Paul


PS:

$ last reboot
reboot   system boot  6.12.0-10296-gaa Thu Nov 28 22:42 - still running
reboot   system boot  6.12-rc6-amd64   Wed Nov 27 14:04 - 22:42 (1+08:37)
reboot   system boot  6.12.0-10296-gaa Wed Nov 27 13:21 - 14:02  (00:40)
reboot   system boot  6.12.0-09568-g2f Tue Nov 26 18:41 - crash
reboot   system boot  6.12.0-08446-g22 Sat Nov 23 12:27 - 18:40 (3+06:13)
reboot   system boot  6.12.0-07749-g28 Fri Nov 22 10:14 - 10:24 (1+00:09)
reboot   system boot  6.12.0           Wed Nov 20 09:24 - crash
reboot   system boot  6.12.0-rc7       Wed Nov 20 09:22 - 09:23  (00:01)
reboot   system boot  6.12.0-rc7       Tue Nov 12 08:19 - 23:27 (7+15:08)
reboot   system boot  6.12.0-rc7       Mon Nov 11 21:54 - 00:16  (02:21)
reboot   system boot  6.11-amd64       Mon Nov 11 21:52 - crash
reboot   system boot  6.12.0-rc7       Mon Nov 11 20:43 - 21:52  (01:08)
reboot   system boot  6.12.0-rc7       Mon Nov 11 17:51 - 17:52  (00:01)
reboot   system boot  6.12.0-rc6-00077 Fri Nov  8 08:39 - 17:50 (3+09:11)
reboot   system boot  6.12.0-rc6-00077 Thu Nov  7 07:26 - 23:24  (15:58)
reboot   system boot  6.12.0-rc5-00047 Mon Nov  4 08:26 - crash
reboot   system boot  6.12.0-rc5-00047 Mon Nov  4 05:42 - 05:43  (00:00)
reboot   system boot  6.12.0-rc5-00047 Sun Nov  3 06:54 - 22:10  (15:15)
reboot   system boot  6.12.0-rc5-00047 Sat Nov  2 07:34 - 22:05  (14:31)

