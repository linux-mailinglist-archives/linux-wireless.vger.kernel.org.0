Return-Path: <linux-wireless+bounces-15979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9A09E72D5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 16:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73F016DEF9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7997920B213;
	Fri,  6 Dec 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="gGpkSVA2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6D207658
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497952; cv=none; b=nHoOeMmAu7FZMW50MXZo0xCAwzDyzQagqHN2mBw2R9zUsEIYFUawAMSexAv4y2yUJcO3jfTRHniiJL0rnINJFV9kbk/S/iVdyVyDhy8E0k11Xg4jWOgmhXH2bGvPLFPrZ4a4WV1+Rdl3K/VBLqceIgQPEkam0z/NLd5T+Z7Sxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497952; c=relaxed/simple;
	bh=9uKTWqnil5oe1e27X3SHy2PkmpX+vzBYYigxRKNIb2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRQk1rbvZeYfjvrU/K7a8wgOnKXNyyNXihuiCKCYRwIfJhm4NN0qvomczrRCSxJg5D4/Ois2Yh3Qp10u4OWz8pbeR/+p6jdgOb2mH5I8qka8o8oT5jEyaKMR6QXmQuVt8qfUqGaehcl+V8Uy8WlP08eoOQ9L0gSeO+iQmOGFuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=gGpkSVA2; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DD8E26C006F;
	Fri,  6 Dec 2024 15:12:21 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.36.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id D7CE313C2B0;
	Fri,  6 Dec 2024 07:12:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D7CE313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1733497941;
	bh=9uKTWqnil5oe1e27X3SHy2PkmpX+vzBYYigxRKNIb2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gGpkSVA2NfK9u8TVM2SYNOUdDQ0wHiTigAJ17O+7YV9eOS8ypn05Bvl9vb47Kr1Dd
	 2qe17rYoFypwDFrhPEFD+lmvxfVdb9VOMp9+sJuLPXfvXb5hF+9od4WuKG/3LDtXYu
	 jIwVOb1/nq5mZvPY0yuzVKmTZ5FFK7QAeshlUxJM=
Message-ID: <a830c9cf-9256-42b7-8a3b-582df8b3b8ef@candelatech.com>
Date: Fri, 6 Dec 2024 07:12:20 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wireless: Remove adhoc and beacon_int_min_gcd check.
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: nbd@nbd.name
References: <20241205225502.878928-1-greearb@candelatech.com>
 <4c127a8e7e03882c4b26e480350453ef5a59ff54.camel@sipsolutions.net>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <4c127a8e7e03882c4b26e480350453ef5a59ff54.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1733497942-3NhjEL4lwIlh
X-MDID-O:
 us5;at1;1733497942;3NhjEL4lwIlh;<greearb@candelatech.com>;20e01846ddffb15f370631a0b8aff2f7
X-PPE-TRUSTED: V=1;DIR=OUT;

On 12/6/24 01:43, Johannes Berg wrote:
> On Thu, 2024-12-05 at 14:55 -0800, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> This check keeps mtk7996 from loading.  If someone thinks
>> they can get ADHOC to work, let them try it.  If the
>> kernel really needs to restrict some combination, then
>> it should be done at time user attempts to actually
>> use that combination, not at driver load.
>>
> 
> I disagree, the driver shouldn't advertise non-sense interface
> combinations that cannot possibly work correctly.

 From the code comment, it looks like it might be possible to get into
a bad configuration if peer ADHOC uses a small beacon time, and if
that also messes up mtk7996 firmware somehow.  But also,
it could work just fine if they did not use a small beacon time,
or if firmware magically deals with this somehow with work-arounds
specific to ADHOC (and yet still want normal APs to use 100 or larger
for beacon timer).  So 'cannot possibly work correctly'
is a bit of overreach I think.

Hello Felix,

Any suggestions for how to fix this?  Disable ADHOC in 7996, or set the beacon_int_min_gcd
to zero to allow it to be any duration?

What is openwrt doing to allow mtk7996 to load?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


