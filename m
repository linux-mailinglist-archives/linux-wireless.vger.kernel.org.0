Return-Path: <linux-wireless+bounces-4175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED5A86AC16
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 11:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BD51C21162
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 10:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66539537E6;
	Wed, 28 Feb 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="wZF0Vh6V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEE535C7
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115798; cv=none; b=LGzmjKimLONphcTkjdPl+Wi/48IpAjNcX46vQ3gD8+yJTjjoD1fM4WfD6AmDIvQzKD1FQMP6oPjtN0TYV3mBEGnU8jVFSkRJIINc9YMdkgfcBUwakngA00s313VQdVl5vd1LUFuKoivbrk/xz+XSQ20ZuUbKnKNiwXSFNYjgjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115798; c=relaxed/simple;
	bh=u1LonVzz1zSKseajYZ9I4o/KtoYygqOLOX/ZiV5/9CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KMDa6YbzukVW4KIFMhrBjK09D8UzlaxKI/6LHsy61OFufuBnOc+SgQaZJP02uZqevzYlGm9vL3pD0F1tZ1oUJHf3R6tp7AWoEb3yrXzwDcrq3+yW+qHeUS2b9Q5F0b+tj8CvCTu5w1eoCcC1LSRDtMwea39jFNvvjr4Xg/OIyI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=wZF0Vh6V; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=u1LonVzz1zSK
	seajYZ9I4o/KtoYygqOLOX/ZiV5/9CU=; h=in-reply-to:from:references:to:
	subject:date; d=aixigo.com; b=wZF0Vh6V/2dOTUVH0vs7J3uQd3nRjXDAxMBrRlvU
	koGcFF/7BaqCLS06gc3NLTePKm14IO4CPA1tqsDgqCCjwIWSVDVK2XIbtpU9voQFzjWx0D
	x0AVvfExWN2G70ZVtu55wUh8OTJ8KALKbdylQ9H89as5QhJ+zv4/3UBaXJ0yM=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id bca033ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Feb 2024 11:23:05 +0100 (CET)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 41SAN4HX2805277
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Wed, 28 Feb 2024 11:23:04 +0100
Message-ID: <b9b2224a-f021-483a-8606-6aed94c5f6f9@aixigo.com>
Date: Wed, 28 Feb 2024 11:23:04 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: "iwlwifi: probe of 0000:00:14.3 failed with error -22"
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <dd1e2440-bb05-48d7-9f68-29bae758110d@aixigo.com>
 <9edf7003715cfdda3c794f3adbaeac5f36ada8ee.camel@sipsolutions.net>
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
In-Reply-To: <9edf7003715cfdda3c794f3adbaeac5f36ada8ee.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

On 2024-02-27 10:21:13, Johannes Berg wrote:
> On Tue, 2024-02-27 at 09:12 +0100, Harald Dunkel wrote:
>> The Intel Wifi hardware of a colleague's Tuxedo laptop (running Debian 12,
>> kernel 6.1.76) isn't found at boot time anymore. It doesn't come back on a
>> reboot. The kernel log shows
>>
>> [Mon Feb 26 13:21:23 2024] Intel(R) Wireless WiFi driver for Linux
>> [Mon Feb 26 13:21:23 2024] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
>> [Mon Feb 26 13:21:23 2024] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
>> [Mon Feb 26 13:21:23 2024] iwlwifi 0000:00:14.3: Adding cdb to rf id
>> [Mon Feb 26 13:21:23 2024] iwlwifi 0000:00:14.3: Detected RF 0x1010c000 from crf id 0x504
>> [Mon Feb 26 13:21:23 2024] iwlwifi: No config found for PCI dev 51f1/0000, rev=0x370, rfid=0x1010c000
>> [Mon Feb 26 13:21:23 2024] iwlwifi: probe of 0000:00:14.3 failed with error -22
> 
> Are you saying that it used to work with that same kernel, or are you
> saying that it worked with an older kernel?
> 

It used to work with the same kernel. We had configured 5 identical laptops
in the office, including wifi. After some time this one laptop showed the
problem. AFAIU it crashed first, but I have no records about this.

My colleague turned off the laptop for a power off reset over night (if this
is possible for a laptop with a batter). Next morning Wifi was back. Seems
to be some reset issue.

> In either case, do you have a working log?
> 

This is what we get for the new (6.5.10, Debian backports) kernel now:

```
root@ppcl013:~# dmesg -T | egrep -i wifi\|00:14.3
[Tue Feb 27 09:43:54 2024] pci 0000:00:14.3: [8086:51f1] type 00 class 0x028000
[Tue Feb 27 09:43:54 2024] pci 0000:00:14.3: reg 0x10: [mem 0x601d174000-0x601d177fff 64bit]
[Tue Feb 27 09:43:54 2024] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[Tue Feb 27 09:43:54 2024] pci 0000:00:14.3: Adding to iommu group 8
[Tue Feb 27 09:44:51 2024] Intel(R) Wireless WiFi driver for Linux
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: Detected crf-id 0x1300504, cnv-id 0x80400 wfpm id 0x80000030
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: PCI dev 51f1/0074, rev=0x370, rfid=0x10a100
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: firmware: direct-loading firmware iwlwifi-so-a0-hr-b0-83.ucode
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: api flags index 2 larger than supported by driver
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.41
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: firmware: failed to load iwl-debug-yoyo.bin (-2)
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: firmware: failed to load iwl-debug-yoyo.bin (-2)
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: loaded firmware version 83.e8f84e98.0 so-a0-hr-b0-83.ucode op_mode iwlmvm
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz, REV=0x370
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x10
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
[Tue Feb 27 09:44:51 2024] iwlwifi 0000:00:14.3: base HW address: e4:0d:xx:xx:xx:xx
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x10
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 0
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x10
[Tue Feb 27 09:44:52 2024] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
[Tue Feb 27 09:47:12 2024] iwlwifi 0000:00:14.3: Unhandled alg: 0x703
[Tue Feb 27 09:47:12 2024] iwlwifi 0000:00:14.3: Unhandled alg: 0x703
[Tue Feb 27 09:47:12 2024] iwlwifi 0000:00:14.3: Unhandled alg: 0x703
[Wed Feb 28 09:47:03 2024] iwlwifi 0000:00:14.3: Unhandled alg: 0x703
[Wed Feb 28 09:47:03 2024] iwlwifi 0000:00:14.3: Unhandled alg: 0x703
[Wed Feb 28 09:47:03 2024] iwlwifi 0000:00:14.3: Unhandled alg: 0x703
[Wed Feb 28 09:47:03 2024] iwlwifi 0000:00:14.3: Unhandled alg: 0x703
```

Hope this helps.

> If you really have subdevice ID 0000 then something went wrong and you
> have a blank OTP (now), which seems very strange.
> 
> This is an integrated NIC where part of the NIC is integrated into the
> platform, and other parts are on the companion RF (CRF), so could also
> be that the CRF module isn't seated well any more in the slot and it
> just cannot access the data properly?
> 

You mean there could be a problem with the wifi card not being plugged in
properly? We will check when my colleague is in the office.


Regards
Harri

