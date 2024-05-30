Return-Path: <linux-wireless+bounces-8312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB28D8D4BA5
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 14:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F881C22E96
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 12:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABC818307E;
	Thu, 30 May 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CbEMDhZb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B29183074;
	Thu, 30 May 2024 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071978; cv=none; b=IyuHhgWtK9NSqfdhn6Zq4iUQIwXy8zBHf9wyNyuuVDywa72Wd4+5b4sJiX/SiWRZooQ3El2BoCTvDx3XspKdUFVaE2PV1sA3cu+w0S9wkjrKkoSxRYRjeuVpZPaZ1Sqv+CI2jpR9TJdz12PxzYFCyRON8jKsawtQDNajPx/pZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071978; c=relaxed/simple;
	bh=fbw5/ISy9x/5eLVR6YcFxlLwCyJIGhqNQiUbGdDLPHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EVh635cR4nsK28XiaGxYKxxsn5FYCXrqdel6CIfOuvGdd3O5YR+Qek5k6gLfZkUKoTZYz4XZFaO46KfZY2mYXz7cvw3oTLKldwZKeadSY5AtfQ/7grseo6E8a27xJtzY0cVQnCLw6AvxeCLusrrlVHgVkGT+i+ixvK3i7s7RQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CbEMDhZb; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44UCQ1cK098230;
	Thu, 30 May 2024 07:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717071961;
	bh=TLL4+PI9m+gKUlb5vXXkSEHtuOv17Z74UbZi/p+Au0E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CbEMDhZbvEjoxH/COAvDFETjhRqgBxyXzGQx1fUxXtIdOJcv1XNVpHveZ9YeLgCos
	 LfkSatkAoae34uziPJV+/mzsbliCLAxiU+kZRk/gorg+a8GpJI60NgQyBb0YRK8fB/
	 sbZcIqH0Lcw1uSn0szWSrvomqbUawXWKt5D4arbg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44UCQ1jZ032220
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 07:26:01 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 07:26:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 07:26:01 -0500
Received: from [137.167.6.219] (lt5cg1094w5k.dhcp.ti.com [137.167.6.219])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44UCPxAf072533;
	Thu, 30 May 2024 07:26:00 -0500
Message-ID: <ceba870f-34d3-4545-884e-f04f966646ab@ti.com>
Date: Thu, 30 May 2024 15:25:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 6/8] wifi: wlcore: add pn16 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
 <E1sBsy7-00E8vu-Nc@rmk-PC.armlinux.org.uk>
 <e6ae6dfa-6554-4e88-abb0-31dbbd8df03f@ti.com>
 <Zlg2zGb7s7zu6jb+@shell.armlinux.org.uk>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <Zlg2zGb7s7zu6jb+@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 5/30/2024 11:20 AM, Russell King (Oracle) wrote:
[...]
> > The original code was > tx_lnk_free_pkts = 
> status->counters.tx_lnk_free_pkts[i]; > diff = (tx_lnk_free_pkts - 
> lnk->prev_freed_pkts) & 0xff; > > if (diff == 0) > continue; > > I 
> wonder if comparing tx_lnk_free_pkts to 0 was added intentionally? 
> This is > monotonously incremented counter so 0 is not significant, 
> unlike the diff. > Have I missed something? You are... While you're 
> correct about the original code, your quote is somewhat incomplete. + 
> if ( (isSta == true) && (i == wlvifSta->sta.hlid) && 
> (test_bit(WLVIF_FLAG_STA_AUTHORIZED, &wlvifSta->flags)) && 
> (status->counters.tx_lnk_free_pkts[i] > 0) ) ... + } + if ( (isAp == 
> true) && (test_bit(i, &wlvifAp->ap.sta_hlid_map[0])) && 
> (test_bit(WLVIF_FLAG_AP_STARTED, &wlvifAp->flags)) && 
> (wlvifAp->inconn_count == 0) && (status->counters.tx_lnk_free_pkts[i] 
> > 0) ) ... + } }

Sorry, considered only the diff with base branch, not the original patch.

> Note that both of these if() conditions can only be executed if the 
> final condition in each is true. Both check for the same thing, which 
> is: status->counters.tx_lnk_free_pkts[i] > 0 In my patch, 
> tx_lnk_free_pkts is status->counters.tx_lnk_free_pkts. Therefore, 
> there is no point in evaluating either of these excessively long if() 
> conditions in the original code when tx_lnk_free_pkts is less than 
> zero or zero - and thus the logic between TI's original patch and my 
> change is preserved. Whether that condition in the original patch is 
> correct or not is the subject of that FIXME comment - I believe TI's 
> code is incorrect, since it is possible that tx_lnk_free_pkts, which 
> is a u8 that is incremented by the number of free packets, will hit 
> zero at some point just as a matter of one extra packet being freed 
> when the counter was 255. Moving it out of those two if() statements 
> makes the issue very obvious. It would be nice to get a view from TI 
> on whether the original patch is actually correct in this regard. I 
> believe TI's original patch is buggy.

After consulting with the author I do not believe it is buggy. It was 
the most painless way to prevent issues with the recovery flow.
Indeed there will be case where tx_lnk_free_pkts is 0 again in which 
case the internal counters will not be updated. This was considered OK 
as this is usually a transient state and the counter will advance 
eventually.
For the unlikely case where FW crashed just after update was skipped, 
well, there will be a small rollback in the PN after recovery which 
means a few frames will get lost. This as considered acceptable.

Michael.

