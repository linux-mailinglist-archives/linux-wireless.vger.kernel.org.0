Return-Path: <linux-wireless+bounces-16618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3FB9F7DB0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 16:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC31896052
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 15:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94528225797;
	Thu, 19 Dec 2024 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen-moser.de header.i=@steffen-moser.de header.b="Yi+UETw0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dd54106.kasserver.com (dd54106.kasserver.com [85.13.166.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EAE225788
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.166.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620913; cv=none; b=PUtCV9K3Q18wybo8aFE81dMiTWE1T6/KfffOe8qUlF2L/tLMr4EwZifsaGBjxMNO9o7o0MfN42RBcXn+m95Ltuyd9eK2AOV66PAN8md4Zq4h0xmSV1MuWVG4EP37RPO+f/o7ZcXP0Osw47jteISizFykKqckn+khEtQFPZgBGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620913; c=relaxed/simple;
	bh=IQTCWRza9lC/pLLTaBSx2I7HwHGI1hJfrUDk22jrHzc=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=GsWMkSkwQVa0ZTm8F2iaqv4wABH/nSN/2DFnuOW61jVH7ffFHNRgg49A5u9jWnwGZESQQF/K+E60FdSaA3Za6mE7e6jsUNeD0yGtZkLZdOUMD277MvZQEw3D1DoB8ZZdw03PGyltN6O9MoOARExDC8fjwvqajRD6p71IVTO2HhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=steffen-moser.de; spf=pass smtp.mailfrom=steffen-moser.de; dkim=pass (2048-bit key) header.d=steffen-moser.de header.i=@steffen-moser.de header.b=Yi+UETw0; arc=none smtp.client-ip=85.13.166.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=steffen-moser.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen-moser.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen-moser.de;
	s=kas202408292216; t=1734620550;
	bh=tl9/TSE13SGHHsDVBAMGCjzUpLNejfjWBwGw2380tcE=;
	h=Date:From:To:Subject:From;
	b=Yi+UETw0xf4VuPScGggy6iZuY+dBwCAC3fQbHUNUgmZjX4ZW1534irLfSzQUS1O1E
	 0y1rsBp7/2o/dv6vUJbdsQhJ7XikPBmPJfEkAoHbZwT/YfEvV5V+821g99vWfBHiTF
	 W7AoWofIgkki9JPLh+7S69ZD12Y7YJoGrc+BzaznMCMca8UzcnxE2XZxtCZ/8c1lkj
	 EjbrrRGPi8r15SUWqQE7hQsWQEo7Mu7XDo6LKYeR62RRv0qxIpAJllFc5RgsqrlE8E
	 w3F7J12agcWSUC9Ih2yIMkRat/aKa+AoCo7zCC2Yl+lsBPCU5d9xPI1fU3pfRV3Ez6
	 Sy6bKOCl7WWMA==
Received: from [134.60.53.199] (53-199.saps.uni-ulm.de [134.60.53.199])
	by dd54106.kasserver.com (Postfix) with ESMTPSA id DC091E4A6AB4
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 16:02:30 +0100 (CET)
Message-ID: <c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de>
Date: Thu, 19 Dec 2024 16:02:30 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE, en-US
From: Steffen Moser <lists@steffen-moser.de>
To: linux-wireless@vger.kernel.org
Subject: Potential Broadcast Issues After GTK Key Exchange on ath11k with
 IPQ8072A (QCN5024/QCN5054)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

Hello everyone,

I've encountered a possible issue in a DD-WRT [1] setup where broadcast 
packets stop being delivered after a GTK (Group Temporal Key) exchange. 
This issue occurs on a system with the following hardware:

     Access Point Hardware: DynaLink DL-WRX36
     Router Software: DD-WRT v3.0-r58819 std (12/13/24)
     CPU: Qualcomm IPQ8072A
     WiFi Chips: Qualcomm QCN5024 and Qualcomm QCN5054
     WiFi Driver: ath11k
     Firmware: WLAN.HK.2.12-01460-QCAHKSWPL_SILICONZ-1
     NSS FW version: NSS.FW.12.5-210-HK.R
     Kernel: Linux WL-AP-EG 6.6.64-rt29 #1791 SMP Thu Dec 12 16:41:51 
+07 2024 aarch64 DD-WRT

The behavior is such that after a GTK exchange, the AP can get into a 
"weird state". When being there, broadcast frames like ARP or mDNS are 
no longer reliably delivered to connected clients while unicasts come 
still through. In this "weird state", the channel quality (active time 
vs. busy time) goes down and latencies to the still reachable WIFI 
clients rise.

I've come across a related bug report on GitHub that describes a similar 
issue: 
https://github.com/openwrt/openwrt/issues/9555#issuecomment-2433857175

Unfortunately, the GitHub discussion drifted towards various other 
possible bugs.

In the meantime, I have a done a lot of additional debugging, but I am 
coming to a dead end due to limited knowledge of the ath11k driver and 
firmware internals. Interestingly, the AP can get back from "weird 
state" to "normal state" after another GTK rekey event. I've seen this 
behavior only in the 5 GHz band, yet (using non-DFS-channels).

My questions to the Linux wireless experts and developers in this community:

  · Is such a behavior known with ath11k on IPQ8072A or on the mentioned 
WiFi chips (QCN5024/QCN5054)?

  · Could this be a driver or firmware issue that specifically arises 
after a GTK or even GMK exchange?

  · What can I do to debug it further? I've switched on debugging in 
"hostapd" in order to see the keying events. Are there more lower-level 
logs I can get from the WiFi chip and match to the latency and key 
exchange observations?

  · Are there any additional information I can/should deliver to give 
the devs more insight about this issue?

When exchanging the DynaLink DL-WRX36 AP by a Netgear R7800 AP (CPU: QCA 
IPQ8065), its predecessor, the problem is gone without touching any of 
the clients.

Thank you in advance for any insights or experiences regarding this issue.

Best regards,
Steffen

[1] https://dd-wrt.com/


-- 
✂-----------------------------------------------------------------------
Dipl.-Inf. Steffen Moser                  Tel (Office): +49.731.50.32407
School of Advanced Professional Studies       Ulm University, Room: 1013
https://wissenschaftliche-weiterbildung.org/    Oberberghof 7, 89081 Ulm
https://saps.uni-ulm.de/                                         Germany


