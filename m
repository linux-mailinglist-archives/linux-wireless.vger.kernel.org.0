Return-Path: <linux-wireless+bounces-18798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86F2A31B3A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 02:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BFE16664E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 01:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF22868B;
	Wed, 12 Feb 2025 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="qsK5EnCV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1318651
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324138; cv=none; b=l/UjCmRd42WRr+t30+3YtL0BOcf4huVfOdIn7U9ZukwNvOc2g6hjSL1Vho7zwm+yHmP+0Aqduq67cqVRVY0SIIhKY28naCJqoJUC/EqYYqp6spS7nOjPYStm1PltE1SmKmhTslbPrgYD4Ghc5niFbFcY0nCHwE2Hxav3aQ1/+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324138; c=relaxed/simple;
	bh=FW4xoGh7dgzIgE2sDIXowMTt0y1zsuzbj7v0S1PNA7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNfP6QIiHKX1A+gXzIVT8jjA+no4tV9UXNEmYUP1STTeZCv4hprOx2SQlWGFwrqJdyWc9UPgxWUX87/3Hlifm2kxmh5TIQAYrnNIYpmG13tOwrDOttc6/MmGoDwwBFtyFjs5evcQ7OkUoLBpQ5pTmr55JiXIk0hM55tlB4yVh/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=qsK5EnCV; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8A9C42C329A
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 01:27:04 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 79DBCC0065;
	Wed, 12 Feb 2025 01:26:56 +0000 (UTC)
Received: from [10.20.39.22] (hirgnt03.hicv.net [173.197.107.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 4A8EA13C2B0;
	Tue, 11 Feb 2025 17:26:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4A8EA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1739323615;
	bh=FW4xoGh7dgzIgE2sDIXowMTt0y1zsuzbj7v0S1PNA7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qsK5EnCVpoOjiVPHXoeaanWN2NhxJslk3xcUJttMF9VpmZ921uGORkVdImEpAkyWC
	 6OL25r8xYvzs6K+b3UxnFeU4NzTG2iy9Ihk/Kgrmmh2Z1r64jKriJFEvMq20M+2wXc
	 nv0/kgCW63muHRlQFhNGYvNC4aK/sDf8upffjHeI=
Message-ID: <87535bc3-16f5-4780-900f-8aa0ec6cfd64@candelatech.com>
Date: Tue, 11 Feb 2025 17:26:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] wifi: intel: incorrect RSSI values on beacons from APs
 using legacy rates
To: Hamdi Issam <ih@simonwunderlich.de>, lkp@intel.com,
 johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc: sw@simonwunderlich.de
References: <20241125164034.2712936-1-ih@simonwunderlich.de>
 <93cb3283-3fb3-47be-841b-1f8586c06216@simonwunderlich.de>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <93cb3283-3fb3-47be-841b-1f8586c06216@simonwunderlich.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1739323617-vzxvuQdt6XVB
X-MDID-O:
 us5;ut7;1739323617;vzxvuQdt6XVB;<greearb@candelatech.com>;2d65718dd4530f116754a4cdb26278af
X-PPE-TRUSTED: V=1;DIR=OUT;

On 2/11/25 8:58 AM, Hamdi Issam wrote:
> Hello,
> 
> I have opened a ticket (https://community.intel.com/t5/Wireless/wifi-intel-incorrect-RSSI-values-on-beacons-from-APs-using/m-p/1647584#M57080) on the intel 
> support community about this issue, but the Linux OS is unsupported by them.
> 
> Does anyone have any ideas on how to further debug this issue or what might be causing it?

I'm not sure about this specific issue, but if you feel like using out-of-tree patches
that are never likely to make it upstream, you can find patches in our tree that disables
the Intel firmware's beacon filtering (and beacon RSSI reporting)
and then does the RSSI calculation in the driver.  It is not a small change and might
have some weird dependencies on other stuff in our tree.

That fixed some inaccuracies that we found, but it may have draw-backs that I'm
not aware of.

https://github.com/greearb/linux-ct-6.13

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

