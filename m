Return-Path: <linux-wireless+bounces-16400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC4D9F265F
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2024 22:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11346163951
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2024 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77921B87F5;
	Sun, 15 Dec 2024 21:56:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from torres.zugschlus.de (torres.zugschlus.de [81.169.166.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E7A47;
	Sun, 15 Dec 2024 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.169.166.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734299781; cv=none; b=cbg8gtsoH9qqubyoFbyrwkjYK6jAMFroWvoFPevtbCLsDIlVv9wTyDB9++q3xCS0U8CzXfU9LpbP9ACQvHCNBsD6ZSdLFcT/maJOPUZwdQeXKSlvSVTpinymfmAGaeC8okKricLFeQs5Y4mqxM7YBs9/Yh+ip/TEpBYBZZrMTVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734299781; c=relaxed/simple;
	bh=JTD6V+x3SZ85xNTMHpCfoFDzY9mj5HkgrDqBg2/D7U8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dzr/T8Cy3XGBBg5+nkcQPi4jzY77XBhw8U0U0X5Puyxbukk4qTyIQ434A7B4gjl55NViQ9FQCbhNvJ6jgMIQMOh1UPq+uD/pyD0ty0Wxl7j9Ex8kI1eWrVWC3jNAmmGRGgG8WlHDYnSMnBIklt3nA6QbCmIOdQZXl6ekMFmCwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de; spf=pass smtp.mailfrom=zugschlus.de; arc=none smtp.client-ip=81.169.166.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
	(envelope-from <mh+linux-kernel@zugschlus.de>)
	id 1tMvxP-001vBG-0q;
	Sun, 15 Dec 2024 22:15:19 +0100
Date: Sun, 15 Dec 2024 22:15:19 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Intel Comet Lake Wifi (8086:02f0) only working after cold start,
 failed with error -110
Message-ID: <Z19G5zFhmWOfINvt@torres.zugschlus.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,

I recently bought a used ThinkPad X13 1st Generation. That one is
equipped with an:
00:14.3 Network controller [0280]: Intel Corporation Comet Lake PCH-LP CNVi WiFi[8086:02f0]

(lspci output avaible online as https://www.zugschlus.de/stuff/lspci-v
and https://www.zugschlus.de/stuff/lspci-nn)

I can reproduce the following behavior with all Linux kernels beginning
with the one that is in Debian Stable (didn't try anything older than
that), Debian unstable, current Linux Mint, Fedora Workstation 41, up to
a self-compiled Linux 6.12.5).

While there was a Windows installed on the box when I got it, I do not
intend to dual boot the machine, and Windows has been erased by
installing the first Linux over it. Hence, I dont consider the hints
found on the Internet regarding Windows fast startup applicable in my
case. In any case, I disabled Windows fast startup before overwriting
Windows.

When the notebook is freshly cold booted (machine OFF, no led blinking,
pulsing or anything, power supply disconnected), Wifi works. When I just
reboot the machine without turning it actually off, or turn it off while
leaving the power supply connected, Wifi does not work. The Wifi chip
still shows up in lspci but not in ip addr / ip link. dmesg looks like
it does not even try uploading firmware.

In the non-working case, I see a bunch of lines like
[    3.998476] iwlwifi 0000:00:14.3: CSR_RESET = 0x10
[    3.998494] iwlwifi 0000:00:14.3: Host monitor block 0x0 vector 0x0
[    3.998524] iwlwifi 0000:00:14.3:     value [iter 0]: 0x00000000
[    3.998545] iwlwifi 0000:00:14.3:     value [iter 1]: 0x00000000
[    3.998566] iwlwifi 0000:00:14.3:     value [iter 2]: 0x00000000
[    3.998587] iwlwifi 0000:00:14.3:     value [iter 3]: 0x00000000
[    3.998608] iwlwifi 0000:00:14.3:     value [iter 4]: 0x00000000
ending with
[    4.007732] iwlwifi 0000:00:14.3: probe with driver iwlwifi failed with error -110

(full output on https://www.zugschlus.de/stuff/dmesg-notwork)

For reference, see dmesg output for a working case on
https://www.zugschlus.de/stuff/dmesg-work.

As per the instructions given on
https://wireless.docs.kernel.org/en/latest/en/users/drivers/iwlwifi/debugging.html,
I have not yet upped the debug level. I am prepared to try with a kernel
that has CONFIG_IWLWIFI_DEVICE_TRACING and/or CONFIG_IWLWIFI_DEBUG set.
If you ask me to do this, please give me instructions about how to
enable the desired debugging if module parameters, kernel command line
parameters etc are necessary.

I would apprecaite any help. I can keep the machine in the current state
for a few days, I only need it after chrismas.

Please keep me on Cc, I am not subscribed to the mailing lists.

Greetings
Marc


-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421

