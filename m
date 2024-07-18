Return-Path: <linux-wireless+bounces-10362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CCC935219
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 21:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458CD1C21A60
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 19:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6C144D3B;
	Thu, 18 Jul 2024 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="FCzYwxUe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9713A257
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721330463; cv=none; b=SuC/BE7lJPLBHb67imNQBfHCaDBEl+qgWR3SWDTOB+ZMbRVR8haOMOhAK02pk+N8tvX2CNpToeU+I6xq8GN4p18GnEE1SX8dBiuTiGGGMruIZtsDtaOfYZ/L/3sOZDU++VVPyR3fFk/79XjVbfghu1AvSi/gv7A67WnTMl1zGcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721330463; c=relaxed/simple;
	bh=aeM+On/YtbFK9tVyic+dFsk3HaI60N9cG5Gvt6fimUM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ptoqNIDgiLOIDUzOLlo64Me4qZu8A1kJBXa/ggkiZtT52H3bunquF2mWFH8ajD7/R9wn7jVA78KJZiwLgOAY8tNvJWG8G/i8CceIiO+/pOaZ3dqK+mSM3YT82cQMGr8Q6IzDNXVso8CMefSvSGTfmXyVrp5QxFmgiaB7HRj89VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=FCzYwxUe; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 71611300077;
	Thu, 18 Jul 2024 19:20:52 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id C007213C2B0;
	Thu, 18 Jul 2024 12:20:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C007213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1721330451;
	bh=aeM+On/YtbFK9tVyic+dFsk3HaI60N9cG5Gvt6fimUM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=FCzYwxUef0Uf/MkYXbyUs9Smlort5dVvMiYPQFdmFMIxoNdo5tb/bpQyLT3Uk4Mzt
	 vZ4phxffYycyQm6yH5McWm4FXryz46BGvcVDRl65e9qFDC77RfU0g+luu0IFn6rFWD
	 2Zv4NUFX/04LBMYNR4Cu9L8t3yvwQc4tRucMi87E=
Message-ID: <3379abec-9251-ac6b-3760-4f1838f31445@candelatech.com>
Date: Thu, 18 Jul 2024 12:20:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 06/18] wifi: iwlwifi: keep the TSO and workaround pages
 mapped
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
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
Organization: Candela Technologies
In-Reply-To: <4abe931d-f6ec-adb6-9b78-23d4c0c4b1a2@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1721330453-KOd6nLzqOQ8B
X-MDID-O:
 us5;at1;1721330453;KOd6nLzqOQ8B;<greearb@candelatech.com>;50171c4d2da3acbebc7f7131b075104c

On 7/11/24 09:09, Ben Greear wrote:
> On 7/10/24 23:15, Berg, Benjamin wrote:
>> Hi Ben,
>>
>> yes, you need to apply:
>>
>> commit 003eae5a28c6c9d50290a4ac9b955be912f24c9f
>> Author: Benjamin Berg <benjamin.berg@intel.com>
>> Date:   Tue Jul 9 14:31:49 2024 +0200
>>
>>      wifi: iwlwifi: correctly reference TSO page information
>>
>>
>> I had not fully tested the last revision and the error slipped
>> unfortunately.
> 
> Hello Benjamin,
> 
> Sorry I did not notice that patch on the mailing list on my own.  I re-applied
> the 6/18 and 7/18 patches, and the fix you mention above, and system appears stable.

Hello,

We found another regression in our patched 6.10-ish kernel.  Before I apply these 3
patches:

wifi: iwlwifi: keep the TSO and workaround pages mapped
wifi: iwlwifi: use already mapped data when TXing an AMSDU
wifi: iwlwifi: correctly reference TSO page information

Then I see around 4Gbps TCP upload on my test rig.  After this, it runs very poorly,
perhaps bouncing up to high speed for a second or two, but mostly averaging 80Mbps
or so after it runs for a bit.

What are these patches trying to solve, and are you able to see good TCP upload performance
with these patches applied?

Thanks,
Ben


