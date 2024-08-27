Return-Path: <linux-wireless+bounces-12073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA6B9613CC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BA61F24230
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CA21CEAA2;
	Tue, 27 Aug 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="cYAHB8dz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46DB1C9EC9
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775305; cv=none; b=B+DGS9WNPqMG+a8YjZ5ebvQfdIEynhH4+LTXnLM92xNDFuGhS8bv4+EgnIWEj4dTb3RL9F2jlmSv4h4towBCMdB4v5a9I3SBwPw93vulfolqe1cxJEQrmEYi5OjFxQ1CeMPH4daF7OZyvU9UUtvW55+ILs54fI9D2doxYXM3epo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775305; c=relaxed/simple;
	bh=5ChHNN2aXvfqIEa+Oaq8zCXjcAGlJrVG5hgaFDfGXxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p4P8R+Vo/ZuPFvW3Cla76GAqDnZenFfrTRT1m5ifE3RLiSu1ARTkTDfMpkbNNL2YrloL5ntjDhDp4AviX4PDw1YtqxNl3tH2KXtXNpEBvv7mXs3fjoP9PDIrwcyviPn5e0sUpxh3a/Nc6tLLjYGdZH+yDfJXUKRfUsdw6LvqDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=cYAHB8dz; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6A3606C005D;
	Tue, 27 Aug 2024 16:14:56 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E56B713C2B0;
	Tue, 27 Aug 2024 09:14:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E56B713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1724775296;
	bh=5ChHNN2aXvfqIEa+Oaq8zCXjcAGlJrVG5hgaFDfGXxI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cYAHB8dzaKFOBS/3J4fyHKeb8VmpJzN+FeW6KVJ2OJonis2Kp2TCg6Elfr2Yjnft1
	 xwekVfCm1BCMO0busew6u2yZBSV7hANvwj1ZZ1Bbwvdmc1kwQur+S63/pe2zH9xuDw
	 PB1O+iyrEAsuYlToIh3+QqRdhWDQfhllENlDBY/c=
Message-ID: <5a23917b-eb43-1046-654c-0d5dea016726@candelatech.com>
Date: Tue, 27 Aug 2024 09:14:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: HACK/RFC: Fix link_sta->rx_nss == 0 in iwlwifi upon eMLSR link
 change.
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <d42ef01b-996b-a645-d59e-f3dec5a974a9@candelatech.com>
 <4c6891c3bf91876a6ad64849b5bb7624ed5a0305.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <4c6891c3bf91876a6ad64849b5bb7624ed5a0305.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1724775297-KfLAzz7JdRcy
X-MDID-O:
 us5;at1;1724775297;KfLAzz7JdRcy;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 8/27/24 08:51, Johannes Berg wrote:
> On Tue, 2024-07-16 at 16:25 -0700, Ben Greear wrote:
>> While poking around at some instability and poor performance seen in download
>> direction, I noticed that the rate-ctrl was probably set incorrectly in
>> the iwlwifi driver due to link_sta->rx_nss being zero when changing active link
>> to the secondary link (the one we didn't originally associate with).
>>
>> After debugging, I found that the hack below will make this problem
>> go away.  I sincerely doubt this is the correct approach, but I'm not
>> sure how it is all supposed to work in the first place.
> 
> Andrei came up with this, which does seem better, but probably wouldn't
> address the AP side:
> 
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index d624c51d0bd1..8d32adf7502d 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -5744,6 +5744,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
>   		}
>   
>   		if (link_id != assoc_data->assoc_link_id) {
> +			ieee80211_sta_init_nss(link_sta);
>   			err = ieee80211_sta_activate_link(sta, link_id);
>   			if (err)
>   				goto out_err;
> 
> Care to test it?
> 
> In general I think we should probably remove the call to
> ieee80211_sta_init_nss() from rate_control_rate_init() and call it
> explicitly wherever needed, since with MLO we require offloaded rate
> control and rate_control_rate_init() doesn't really do anything (except
> this for the deflink, which is then questionable)

Yes, we can test this.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



