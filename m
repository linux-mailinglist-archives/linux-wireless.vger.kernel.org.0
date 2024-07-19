Return-Path: <linux-wireless+bounces-10389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E209377C2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 14:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7092813C2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 12:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0FF84A50;
	Fri, 19 Jul 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="aNtfOCu2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C6823B8
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721392252; cv=none; b=ZfOsV4CqTU48BMzyzXYXHNQvq2BROF5itMkae1BEtINhPw+EixADqP345cW4PIiE9wgZI3HTwVU9I+qgBV3kMKTWlrAk8GPfHP9ZMVK8lrcebNkE2xdxMR6SrYxj+LgIokhsDMonlxpLya+1S0cw6zSjDj0N40ulNmvXMFW/qY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721392252; c=relaxed/simple;
	bh=nu/RE8fnpGyxBBU7FeJ27Nn6eoQVDJlaj1fu/dARe+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqd1eiiqBYPKHzgwLw2fUp0pk1Lmrxx0skgm3VWaUe4LiyJTvt4DFjkL3kKpVmQKKEzNmksUbeUbc5bH5DlLWa9TQ0jMwpqZHWC39wRS+wU4V0VFR22eVWGPT/2fOUR1lX6jeFxhIfxORMHLhxpK8cIB5xwRxNLYhAbSXdm6Hjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=aNtfOCu2; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7326B9C0087;
	Fri, 19 Jul 2024 12:30:40 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.37.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 1389D13C2B0;
	Fri, 19 Jul 2024 05:30:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1389D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1721392237;
	bh=nu/RE8fnpGyxBBU7FeJ27Nn6eoQVDJlaj1fu/dARe+I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aNtfOCu2vZaG1HPvdqJl9uTvf2R5nnGf5g2v+N1+PnJkDIIqZIfbR4B1XdJql1azg
	 CoT8q0Bzi+/mlDz2Rt94KdtofkhGNGX8wOlO38kHT6ByCFwDAfDq4He7qXl9AXQZ0q
	 lYa9uZksdzHiRNs1x47EmPoBYmg+bXeXoftS2/bQ=
Message-ID: <c0ca8993-ee46-4b5e-b500-7eeec0752e3e@candelatech.com>
Date: Fri, 19 Jul 2024 05:30:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] wifi: iwlwifi: keep the TSO and workaround pages
 mapped
To: "Berg, Benjamin" <benjamin.berg@intel.com>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Berg, Johannes" <johannes.berg@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
 <20240703125541.7ced468fe431.Ibb109867dc680c37fe8d891e9ab9ef64ed5c5d2d@changeid>
 <a0a7dbf2-b4c5-ddf8-59e9-7e8a067e2f11@candelatech.com>
 <64fefdf4c689a4fe039917f69b9f6d61aca0db92.camel@intel.com>
 <4abe931d-f6ec-adb6-9b78-23d4c0c4b1a2@candelatech.com>
 <3379abec-9251-ac6b-3760-4f1838f31445@candelatech.com>
 <141e44a9ddb6e5a1a9981c4eacad8c3a5e8f5b52.camel@intel.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <141e44a9ddb6e5a1a9981c4eacad8c3a5e8f5b52.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1721392241-CrhRWHPuoOBe
X-MDID-O:
 us5;at1;1721392241;CrhRWHPuoOBe;<greearb@candelatech.com>;50171c4d2da3acbebc7f7131b075104c

On 7/19/24 00:22, Berg, Benjamin wrote:
> Hi,
> 
> have you applied all patches? It'll be slightly slower until you apply
> the last patch in the series (and break completely unless you have the
> bugfix obviously).

I applied those three in my email below, on top of everything else that seemed
pertintent to iwlwifi/mac80211, but always possible I mis-applied something
or missed another patch.

I think I'll just leave those out and test again when i rebase on 6.11.
If you do start getting other reports of slowdowns, however...I think these
will be the suspect patches.

Thanks,
Ben

> 
> A slowdown to 80MBit/s seems a bit like we are getting packet loss and
> the AMSDU is simply not send out. I suppose, that could happen if some
> of the DMA mapping is failing, but I really do not have a good idea
> right now.
> 
> I do think that these patches have gone through quite some verification
> and were working well for us.
> 
> 
> As for the value of the patchset, the thing to keep in mind is that we
> send out large SKBs that are spanning multiple pages. Before the patch,
> we would do mapping as below, where h1, … and m1, … are each mappings
> that only span a small part of a page (h_n is the header for the nth
> packet while m_n is the corresponding message data):
> 
> TSO page: |- h1 -|- h2 -|- h3 -|- h4 -| …
> SKB page 1: |- m1     -|- m2      -|
> SKB page 2: |- m2 -|-  m3  -|- m4 -|
> SKB page 3: |- m4 -|- …
> 
> With the patches applied, each of the pages will be mapped in a single
> chunk. This brings down the number of DMA mappings and also avoids
> partial mappings which can very be particularly expensive depending on
> the IOMMU configuration.
> 
> Only the last patch in the series removes the old mappings (obviously
> you also need the later bugfix commit). So you might see a slight
> slowdown if the patch "wifi: iwlwifi: use already mapped data when
> TXing an AMSDU" is not applied.
> 
> But not a slowdown to 80MBit/s …
> 
> Benjamin
> 
> On Thu, 2024-07-18 at 12:20 -0700, Ben Greear wrote:
>> On 7/11/24 09:09, Ben Greear wrote:
>>> On 7/10/24 23:15, Berg, Benjamin wrote:
>>>> Hi Ben,
>>>>
>>>> yes, you need to apply:
>>>>
>>>> commit 003eae5a28c6c9d50290a4ac9b955be912f24c9f
>>>> Author: Benjamin Berg <benjamin.berg@intel.com>
>>>> Date:   Tue Jul 9 14:31:49 2024 +0200
>>>>
>>>>       wifi: iwlwifi: correctly reference TSO page information
>>>>
>>>>
>>>> I had not fully tested the last revision and the error slipped
>>>> unfortunately.
>>>
>>> Hello Benjamin,
>>>
>>> Sorry I did not notice that patch on the mailing list on my own.  I
>>> re-applied
>>> the 6/18 and 7/18 patches, and the fix you mention above, and
>>> system appears stable.
>>
>> Hello,
>>
>> We found another regression in our patched 6.10-ish kernel.  Before I
>> apply these 3
>> patches:
>>
>> wifi: iwlwifi: keep the TSO and workaround pages mapped
>> wifi: iwlwifi: use already mapped data when TXing an AMSDU
>> wifi: iwlwifi: correctly reference TSO page information
>>
>> Then I see around 4Gbps TCP upload on my test rig.  After this, it
>> runs very poorly,
>> perhaps bouncing up to high speed for a second or two, but mostly
>> averaging 80Mbps
>> or so after it runs for a bit.
>>
>> What are these patches trying to solve, and are you able to see good
>> TCP upload performance
>> with these patches applied?
>>
>> Thanks,
>> Ben
>>
> 
> Intel Deutschland GmbH
> Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
> Tel: +49 89 99 8853-0, www.intel.de
> Managing Directors: Sean Fennelly, Jeffrey Schneiderman, Tiffany Doon Silva
> Chairperson of the Supervisory Board: Nicole Lau
> Registered Office: Munich
> Commercial Register: Amtsgericht Muenchen HRB 186928

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


