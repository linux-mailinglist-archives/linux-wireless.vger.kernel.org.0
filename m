Return-Path: <linux-wireless+bounces-24613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8FCAEB48E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 12:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446221882EC5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 10:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3773A29617D;
	Fri, 27 Jun 2025 10:25:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D87C29E115
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019900; cv=none; b=GOiEEy+B9jmJuDkE78L2ZS7sdr+Kn9X6tsPCPhKx2XfHx7dfI9o9qW8LkTfCKizhYqd7ezhU82xWaN4KWCCdln4qyqHifx4LnVrFYEDHNLxc1CO1BMd136+2CqwjJzvoeoZ6p0kLLjQAe82PkxsR668RioYbaAkswLfsRQpZgAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019900; c=relaxed/simple;
	bh=bQSa1k2KObGYTsvnGVKo0UkNQZjhV4fuHVuqN5pq/KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pm55IPubdkuPDwUCC9fQuDZA4Zl/ta1CthzNFmRzKYsd4AwYQ1/UGu5oFE/MP1e8e+q7spWttw/AK1Ptpe3J/rPuVUZF0iQXdPuRGnq42YaZ4SFZe/7VhHJUbBPz0clDF9pSpZzxB/4ipHmPi/2DyGbDCCYS3Psb+wT2MeH9KDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 452A31A00;
	Fri, 27 Jun 2025 03:24:40 -0700 (PDT)
Received: from [10.57.30.59] (unknown [10.57.30.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A88C33F58B;
	Fri, 27 Jun 2025 03:24:55 -0700 (PDT)
Message-ID: <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
Date: Fri, 27 Jun 2025 11:24:53 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Matt Mower <mowerm@gmail.com>, Jeff Johnson <jjohnson@kernel.org>,
 will@kernel.org, joro@8bytes.org, Hegde Vasant <Vasant.Hegde@amd.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 1107521@bugs.debian.org, iommu@lists.linux.dev
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+Vasant

On 2025-06-27 6:39 am, Baochen Qiang wrote:
> [+ IOMMU list]
> 
> On 6/27/2025 12:21 AM, Matt Mower wrote:
>> Dear maintainer,
>>
>> I have been experiencing lost network connection with the ath12k_pci driver
>> in the linux-6.12.y kernel branch. Often, when the issue occurs, the
>> network does not recover until I reboot the computer. A full report of the
>> errors I encounter, the symptoms that arise, and several dmesg attachments
>> are in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1107521 . I have
>> attached a dmesg from 6.12.34 for convenience. The short summary is:
>>
>> 1. I started noticing log lines like the following soon after boot when I
>> updated from 6.12.22 to 6.12.27. After these events occur, the network goes
>> down and often does not come back up.
>>     ath12k_pci 0000:c2:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0010 address=0xfea00000 flags=0x0020]
>> 2. I was able to reproduce this issue very rarely in 6.12.12 and 6.12.22.
>> The issue always occurs soon after boot in 6.12.27, 6.12.30, 6.12.33, and
>> 6.12.34.
>> 3. I have not reproduced the issue in 6.15.2 or 6.15.3.
>> 4. In some cases, when shutting down the computer, a kernel bug caused my
>> computer to hang. I haven't determined whether this is related to the issue
>> above or an independent issue. Search the bug report
>> for PXL_20250611_140820085.jpg to see a picture of the kernel bug on my
>> laptop screen.
>> 5. I have tested two firmware versions:
>>     a. fw_version 0x1108811c fw_build_timestamp 2025-05-17 00:21 fw_build_id
>> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>     b. fw_version 0x100301e1 fw_build_timestamp 2023-12-06 04:05 fw_build_id
>> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Thanks,
>> Matt
>>
> 
> I had a quick test with 6.12.27 kernel on both my Intel desktop and AMD RD but didn't hit
> the issue. And I am using WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3.
> 
> As mentioned in the Debian bug report, since reverting ath12k patches does not fix this
> issue, maybe it comes from the IOMMU subsystem?

Faults are usually still indicative of the client driver/subsystem doing 
something not quite right - racily performing dma_unmap before the 
device has actually finished making accesses; mapping the wrong size 
such that the device accesses off the end of the mapping (this can often 
run into another valid mapping so not necessarily fault); mapping the 
wrong DMA direction such that the device then tries to write to a 
read-only page. However I suppose it's not impossible that some fix to 
amd-iommu in that period might have changed its behaviour in a way that 
exacerbates things - Vasant, does this strike a chord with anything 
you're aware of?

A couple more things I'd try on the ath12k side: firstly, boot with 
"iommu.strict=1" and see if that makes the faults any more 
frequent/reproducible; if a fault is fairly easily reproducible, then 
use the DMA API and/or IOMMU API tracepoints to compare the fault 
address to prior DMA mapping activity - that can usually reveal the 
nature of the bug enough to then know what to go looking for.

I wouldn't put much significance in whatever happens *after* the fault - 
presumably the driver is assuming the blocked DMA write has completed, 
so then goes on to read some incomplete descriptor as if it were valid, 
and thus may fall over in all manner of entertaining ways on bogus data.

Thanks,
Robin.


