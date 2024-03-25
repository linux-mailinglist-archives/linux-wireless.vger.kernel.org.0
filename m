Return-Path: <linux-wireless+bounces-5200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2DA88A953
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CECA1C64139
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65AE1EA95;
	Mon, 25 Mar 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="e6BjfZaa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9D127B68
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377169; cv=none; b=mtePaHKNcYwCGRzZkWzBOo+XOderqmR8RCU9bl4Zl1DhGkEXrhWGb9XTnI+Zhg82tSrGYnvPB2ChdbiCQlZy810QsITrnr0qXkkLdZV2U0iuuj6l6fCnp4mFTxdKI4QZ/fqZ+xp3BuBokZhQaXAKTVjy+lXy5KVEmSeTUjqb0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377169; c=relaxed/simple;
	bh=bxDcRtA9L3sGOJixz82ChQDNvwqAybE1NBdivpzEPFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AHAQ/KiKKZ9kLFzLyp0h3V4xti5jqjmFw7anSb1tYITrKYfw/vKSOKzvZIjahJqkIchmdDrSBALzeWEAUsZxR3ZKwsHyMgGm4ElSxSKjIsXWdF0mK8z6zFeB55mdahJtNBc2b/BZuoAhr/LHbsQc/UpDqWoVg94+FVPnLlDRQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=e6BjfZaa; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0B51E3C0078;
	Mon, 25 Mar 2024 14:32:39 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 750A513C2B0;
	Mon, 25 Mar 2024 07:32:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 750A513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1711377156;
	bh=bxDcRtA9L3sGOJixz82ChQDNvwqAybE1NBdivpzEPFE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=e6BjfZaaWhmKbwmlzy9rs4oS5+t5cG1yU6PHdLvPJJ4M9nOe6bkeNfFGoTSQwrXcb
	 LmxGmlK6dv8zuIr7ZrfnHcoFI/+kNEcMc9okKCUGQ5LXoa6VljDfv83hKF/xLGe5Zq
	 K6ED+1GV2meBvKdazVn2BoTipV4AahNogGT1iWg0=
Message-ID: <748f4086-41a1-4c23-9c99-82b555950b00@candelatech.com>
Date: Mon, 25 Mar 2024 07:32:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Access to ieee80211_conn_settings in the driver?
Content-Language: en-MW
To: Johannes Berg <johannes@sipsolutions.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <1df701f9-3f27-4887-a9ed-60cf2f12beb4@candelatech.com>
 <661c532c30e9fa218cf0b3d30da0bb65aafc4e8c.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <661c532c30e9fa218cf0b3d30da0bb65aafc4e8c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1711377160-Rw2SWYk_8uXp
X-MDID-O:
 us5;at1;1711377160;Rw2SWYk_8uXp;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 3/25/24 02:47, Johannes Berg wrote:
> Hi Ben
> 
>> I'm interested in getting access to ieee80211_conn_settings
>> struct in drivers.
> 
> My first instinct here is to say no. This thing was only introduced
> recently, and it was ... difficult ... to do. I don't even want to
> imagine I'd have had to worry about a whole bunch of drivers using it
> for random purposes as well.
> 
>> Specifically, so I can deal with disabling
>> 160Mhz in mt76 even if peer is 160Mhz for instance, on a per-station vdev basis.
> 
> Not sure how that even makes sense? You have the min_def in the chandef
> though, so you could do some bandwidth tricks there for AP side?
> 
>> Actually, 160Mhz is bad example, but in case I want to pass other
>> association config info into the driver, like disabling as much of
>> OFDMA or MU-MIMO as possible.
> 
> No idea what that means ... I mean I guess we could add somewhere
> (bss_conf?) a flag indicating "things" are needed, e.g. if you're
> connecting 160 MHz is it VHT or HE or EHT, to set things accordingly?

 From what I can tell, mt76 figures out to disable ofdma or similar
by looking at beacon IEs.  That is painful, but I guess it works.
But I want similar ability to tweak STA side connections without
resorting to debugfs or module param hacks.

> 
> 
>> Is this of general interest, and if so, any suggestions for you
>> you'd like to see it implemented?
> 
> I'd like to _not_ see it implemented :)

Ok, I'll keep it my private hacks.  I at least got it to compile copying
the conn_settings.  I'll get everything rebased and make sure it works.
To actually make it all work one needs to add a way to
send new flags down through netlink...I figure that part would face resistance
as well...

Thanks,
Ben

> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


