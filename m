Return-Path: <linux-wireless+bounces-5227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D368B88AE26
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 19:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013E3B2D9F5
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FA5130ACA;
	Mon, 25 Mar 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="NRPP7vwg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34EC12C811
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388411; cv=none; b=SwPMxO0lyQzuOLzATINgAEZVynWTNsasTsTGJKsGMUSPHuvIyNRFgZ3gsB427FNl40dB+XVfLd0+kaP8U97QtNswOQgMm6QocXzbiINU5M/4jFysNVtFSb+9yzg4iBxHltjkLzJyn92ED1w4WkVFWptk6Unkw+cA8GV9sQ2U1ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388411; c=relaxed/simple;
	bh=+nXTJMxD8K1FReEQVLa/pkIMgtakPsSluwyhSZTuMtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IxaZvbfGc3vGBUDfq0CtbsLNA2AMaM0Vl1TVSbNtYUhEAOiOi8fPIlwaWk2T0RwL8J9lqoOYHoOHsPhx31G75HOwl20mrLTF/6aRY3uSU2VUfXGhW4p6WajWsxHfU4HJNq0zu64KwB+73s/Bzhodw1Gypmdy3UGvW4OoM8fO0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=NRPP7vwg; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A5E0B6C0085;
	Mon, 25 Mar 2024 17:40:07 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 24E5513C2B0;
	Mon, 25 Mar 2024 10:40:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 24E5513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1711388406;
	bh=+nXTJMxD8K1FReEQVLa/pkIMgtakPsSluwyhSZTuMtM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=NRPP7vwgQnvmC4winYl0MHP4Ct4wsJez8r61k2ExCIilhJcJ6V0RBKXLmvqLMB5EG
	 0tylsm/cfAgkiYzMCVYyKuMnL7+oxozt9IpPzZk7wm2V+lVJ1Qy/2QU82UNjYh+NaX
	 yJegTM5CR3j4JXOzZEy7C9+CdIw4Mge22fxAaeQQ=
Message-ID: <6bed94b3-4674-7fe9-ee82-bac7f9c7ffd6@candelatech.com>
Date: Mon, 25 Mar 2024 10:40:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: mac80211: Ensure links are cleaned up when driver
 fails.
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <20231111001023.1335122-1-greearb@candelatech.com>
 <5fe480c4-fa39-1d29-a5e9-ba2447b08dd2@candelatech.com>
 <449f6afbc20c57f704dbeabc3a8eac8fec676405.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <449f6afbc20c57f704dbeabc3a8eac8fec676405.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1711388408-ssyKkbunqDOM
X-MDID-O:
 us5;at1;1711388408;ssyKkbunqDOM;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 3/25/24 10:30, Johannes Berg wrote:
> On Mon, 2024-03-25 at 09:10 -0700, Ben Greear wrote:
>> On 11/10/23 16:10, greearb@candelatech.com wrote:
>>> From: Ben Greear <greearb@candelatech.com>
>>>
>>> On cleanup paths, links need to be deleted even if the driver fails
>>> to do so.  Add a flag to cause driver errors to be ignored in
>>> appropriate cases.
>>>
>>> This appears to fix some kernel warnings and crashes.
>>
>> Hello Johannes,
>>
>> Any interest in this patch?
> 
> Well, you threw a bunch of unrelated stuff into it, and didn't even
> really explain why it's needed ... so not really?

It is needed because if FW crashes while you are trying to remove links, then link
removal would fail, which causes mac80211 to not clean up its links.  In case where you
are trying to delete the station, this causes un-cleaned links which caused crashes
back when I was creating this patch.  My patch allows always cleaning up the links
regardless of driver errors in the teardown paths.

Always possible some intervening changes made this less of a problem, especially since
MLO is disabled for be200 in upstream code anyway now.

I can remove the extra logging if you are otherwise OK with the approach
but don't want the logs.

Thanks,
Ben

> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



