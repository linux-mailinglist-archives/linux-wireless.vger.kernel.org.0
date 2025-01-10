Return-Path: <linux-wireless+bounces-17335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A144BA09823
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B752C3A990B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6A2207E0C;
	Fri, 10 Jan 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Nuv7gaIU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1845028C
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529001; cv=none; b=XrAilzLJqWdtZJ78pzSOGDQcxK2hBE57u2+UmEXK1Lp37+oHGzPOVlmyr2YI9ewFUeCsbh2lNH8Qy1HxnfEA3aMEF2+oBdDO4a5GDZUtuXOrPTzj9gm4d4KIeFVWBNNFIvXNm/UIFCV3ZwN6+JF7AwSMmZciUl5/KUR2psSQnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529001; c=relaxed/simple;
	bh=h9LB9aPOSp8XVQ5IiipScD94NkhV4LUKnFHeWXA9u7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwYTNGSjQCCONuwS65gPsQ6669/OMPfbEVVBP+iIJ8hOOco7IdZ7INjclZZHvZlQUJHF1IxzIdCrhhxhraNCwd46HD1RI+SdU+ZJFkJ7pLvvwjutjlUePlTAW5HnOz+n2hqwED1/+k3vcqQM4M3XdfqIY8PTBu44fgcLdk4sw9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Nuv7gaIU; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B5BE72A99B5
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:54:04 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 91CF8B80076;
	Fri, 10 Jan 2025 16:53:56 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E2DD913C2B0;
	Fri, 10 Jan 2025 08:53:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E2DD913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1736528036;
	bh=h9LB9aPOSp8XVQ5IiipScD94NkhV4LUKnFHeWXA9u7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nuv7gaIU6knPKzdNFqtDJ5h+20FePz7UrdSdFMH7NTl8/QhniJD0z73c3ohWREr1S
	 +ZUpBkQBh+L+ivcWuVDfR6OFnzGywoAHXfMAZ4P7os2JOScGDMhQGoW9AeRBYV2vR/
	 ImedoItWjMKPwRyEDgpw+3qQZF9NHWxLZfADUvnI=
Message-ID: <38a7b894-9528-123a-28b8-fd9613fe4a13@candelatech.com>
Date: Fri, 10 Jan 2025 08:53:55 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 0/7] wifi: cfg80211/mac80211: add support to handle
 per link statistics of multi-link station
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1736528037-Ph6YRlwZxNM4
X-MDID-O:
 us5;ut7;1736528037;Ph6YRlwZxNM4;<greearb@candelatech.com>;535bfda298b524f45ffb92fb019ae3e8
X-PPE-TRUSTED: V=1;DIR=OUT;

On 1/9/25 20:24, Sarika Sharma wrote:
> Current implementation of NL80211_CMD_GET_STATION does not work
> for multi-link operation(MLO) since in case of MLO only deflink
> (or one of the links) is considered and not all links.
> 
> Hence, add the link_sinfo structure to provide infrastructure
> for link-level station statistics for multi-link operation(MLO).
> 
> Additionally, accumulated stats for MLO are included in a concise
> manner to provide a comprehensive overview of the ML stations.
> 
> NOTE:
>     1. Current code changes are done to get an early feedback on design.
>     2. Once RFC patches are approved will add the required driver changes.
>     3. Ath12k changes are included in this series for reference to other
>        driver changes.

> Alternate approach:
>     - Keep sinfo structure as it is and use this for non-ML or
>       accumulated statistics for ML station.
>     - Add link sinfo for links with only certain link specific statistics.
>     - Keep mac_op_sta_statistics at MLD level and let driver fill the
>       MLO and link level data, if driver not filling let mac80211 fill
>       the data.
>     - Corresponding changes done to embed statistics into the NL message
>       based on the sinfo/link_sinfo.

My suggestions for general approach to this:

1)  current sinfo stats should report totals for all links,
but it should not sum them up at query time because links come
and go.  So driver/firmware/mac80211 or whatever is keeping count
of the stats needs to count the total tx/rx/ packets/bytes/whatever
as it happens.

2)  Per-link stats can be over duration of the link object.

3)  For sinfo logic that currently reports tx/rx mcs rate and such that cannot
be summed, use 'best' link's for those values.  Effectively, this probably means highest
frequency is 'best' link.

4) Add per-link stats data that looks very much like 'sinfo' data struct and user-space
that can support that could then get detailed per-link stats at same time it is getting
per netdev 'sinfo' stats.

5) Assuming there will never be more than 3 links for any radios supported by Linux in the near future,
embed the 3 link's 'sinfo-like' stats data structure in the per-netdev sinfo stats struct
so that we can get all 3 link's data at same time that we are getting the other stats.
That should save calls into the driver and ensure that per-links stats can be gathered
at exactly the same time.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



