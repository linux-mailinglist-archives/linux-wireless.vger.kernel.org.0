Return-Path: <linux-wireless+bounces-1947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6124682E32D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 00:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387DCB21F8C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 23:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60D21B5BA;
	Mon, 15 Jan 2024 23:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="CFcr2Yc5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A831AADB
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6AD5228007A;
	Mon, 15 Jan 2024 23:15:02 +0000 (UTC)
Received: from [192.168.22.29] (unknown [50.225.254.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 5272613C2B0;
	Mon, 15 Jan 2024 15:15:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5272613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1705360500;
	bh=/tF+9lOWwxU9IAyf2N2jg73nzuINHo5WUqQTl7sVBEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CFcr2Yc5GfovH0JCP+q3L06mCvjCCKfnvJt3YQnEoeLCPKgyyr2WHoIxAEG3XZDUn
	 KF6W/woHs0JGtH0t1zHlt/9tMfzWdqR4teOEBC8scssIoRRZP1pnHh0nhIRpSAp40B
	 98gS27bWRYWU9PZA2jrjoDgPLaZVFQtWVmag6Yws=
Message-ID: <e87848a8-da4e-571b-2e07-7b7aa1bc8bed@candelatech.com>
Date: Mon, 15 Jan 2024 15:14:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5/8] wifi: mac80211: disallow drivers with HT wider than
 HE
Content-Language: en-MW
To: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
 Gregory Greenman <gregory.greenman@intel.com>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
 <20240111181514.da15fe3214d2.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
 <87wmsehf3d.fsf@kernel.org>
 <aae05a63171cf0f3c81dedc24d3b0a558ce530f5.camel@sipsolutions.net>
 <b1046a3b-8c29-aa64-2954-adec6c5d9bc9@candelatech.com>
 <88ad7e8849f7b29826ddf922734997d73539b21d.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <88ad7e8849f7b29826ddf922734997d73539b21d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1705360503-6Un1MdyEga-o
X-MDID-O:
 us5;ut7;1705360503;6Un1MdyEga-o;<greearb@candelatech.com>;6ed5a8f8c51578afd12669094ba34ba9

On 1/15/24 14:00, Johannes Berg wrote:
> On Fri, 2024-01-12 at 11:58 -0800, Ben Greear wrote:
>>
>> I tried backporting this patch into my 6.7 tree.  An mtk7915 radio system blows up badly
>> in this case.  Likely this is mt76 bug, but also...it used to work and the crash doesn't
>> make it very obvious that the above code is to blame.
> 
> Yeah, hence my comment about kernel developers hopefully being able to
> figure it out :-)
> 
>> mt7915e 0000:06:00.0: mt7915_register_device failed, ret: -22
>> mt7915e 0000:06:00.0: mt7915_pci_probe had error on try 3/3, ret: -22
> 
> Felix says this kind of retry logic doesn't exist upstream, maybe you
> have some delta in your tree that's making it crash?
> 
> Also, from what he says and looking at the code, it should register with
> HE 40 MHz capability set whenever has_he==true, so also here, do you
> have any non-upstream changes that could affect it?

Yes, I do.  Don't think I have anything that adjusts the 40Mhz, but possible.

Anyway, I know how to fix/work around it now, so if it works for Felix
then fine with me.

I still think you should have a pr_err or warn_on_once though, since if that clause
hits, at best case the radio suddenly became un-available.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

