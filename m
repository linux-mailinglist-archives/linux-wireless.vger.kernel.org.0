Return-Path: <linux-wireless+bounces-17652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1B9A1535D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 17:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEAB18825CD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1266A19C552;
	Fri, 17 Jan 2025 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="e75DFbym"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D919ADA4
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129603; cv=none; b=FjFF/jHxMsqwjixaAI2RxyZba5UNIFfRBcjnfh9CNqno09brmjJQy1D8bwLKs/Yn2d5uGbw0GpS+NuQbAdyL0WhDqF98cGGtG5KC12ME6Zd8IXXAjUYZgpgSnSuF9ss75gOemZAiOxY9uQx5J2U7txErePH4WHLImPlBDkROo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129603; c=relaxed/simple;
	bh=n54bq5Fm8IxV07/L9aKJuhsaDQsGRhzAwPELINTii9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXy1fgllQMx9zFbelbyUtR0be+uLU4olrhD5Z3c0Imexz7K2VD4LgFpjdh4u3lL2SlA0vAHgGuylIZuwj3/LO2MmnRmQ9m6cDG1K5LYYcXoE6WIrfTERwmw7okQg08nW3iK8gotUQWe4pGRqKIgz5sWTMon/Xs6nuNrKx1BZhyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=e75DFbym; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 51D5970007F;
	Fri, 17 Jan 2025 15:59:53 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 724F713C2B0;
	Fri, 17 Jan 2025 07:59:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 724F713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1737129592;
	bh=n54bq5Fm8IxV07/L9aKJuhsaDQsGRhzAwPELINTii9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e75DFbym6/7Z1zkCEC4v5yWmcmSzAzKqK01LMWg0FAWajXlMXugxKpwziSbD+e+S3
	 cdKkBf7z1LYsflGI6l79wX5cKv+kOVdhEgM5I6v4mZttZBGTmuPPGyGDdS9s80Y/UB
	 KlTPcSp4PTJn0mzCh2wLF+y9DJsfysI49+1HV1+I=
Message-ID: <e484a38c-90ad-4ff4-8b86-2b714dabb6d8@candelatech.com>
Date: Fri, 17 Jan 2025 07:59:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 09/12] wifi: cfg80211: add accumulated statistics
 for MLO links
To: Sarika Sharma <quic_sarishar@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
 <20250117124554.3719808-10-quic_sarishar@quicinc.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20250117124554.3719808-10-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1737129594-UY34dFoG6yzu
X-MDID-O:
 us5;ut7;1737129594;UY34dFoG6yzu;<greearb@candelatech.com>;535bfda298b524f45ffb92fb019ae3e8
X-PPE-TRUSTED: V=1;DIR=OUT;

On 1/17/25 04:45, Sarika Sharma wrote:
> Currently statistics are handled at link level for multi-link
> operation(MLO). There is no provision to check accumulated statistics
> for a multi-link(ML) station. Accumulated statistics are useful to
> provide comprehensive overview for the ML stations.
> 
> Statistics such as packets and bytes are useful for observing the
> total packets sent and received at the station level. However,
> MLO statistics for rates and signal can not be accumulated since it
> won't make much sense. Hence, a subsequent change will handle signal
> and rates bit differently at MLO level.
> 
> Hence, add accumulated statistics for MLO station. Also, for non-ML
> station accumulated statistics make no sense.

> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -2174,6 +2174,12 @@ struct link_station_info {
>    *	dump_station() callbacks. User space needs this information to determine
>    *	the accepted and rejected affiliated links of the connected station.
>    * @assoc_resp_ies_len: Length of @assoc_resp_ies buffer in octets.
> + * @rx_packets: total packets (MSDUs & MMPDUs) received from this station
> + * @tx_packets: total packets (MSDUs & MMPDUs) transmitted to this station
> + * @rx_bytes: total bytes (size of MPDUs) received from this station
> + * @tx_bytes: total bytes (size of MPDUs) transmitted to this station
> + * @tx_retries: cumulative retry counts (MPDUs)

While at it, can we define these a bit better?

For instance, if one frame is sent from mac80211 to the driver,
and the driver fails first transmit attempt, drops encoding rate,
and second transmit succeeds, is this correct?

tx_packets += 1;
tx_retries += 1;

If frame is is retried all 15 times and fails to be successfully transmitted, would
it be this?

tx_packets += 1;
tx_retries += 15
tx_failed += 1;

> + * @tx_failed: number of failed transmissions (MPDUs) (retries exceeded, no ACK)
>    * @valid_links: bitmap of valid links, or 0 for non-MLO. Drivers fill this
>    *	information in cfg80211_new_sta(), cfg80211_del_sta_sinfo(),
>    *	get_station() and dump_station() callbacks.
> @@ -2210,6 +2216,13 @@ struct station_info {
>   	const u8 *assoc_resp_ies;
>   	size_t assoc_resp_ies_len;
>   
> +	u32 rx_packets;
> +	u32 tx_packets;

At 10g rates, this will wrap fairly quickly, can we make these u64?

> +	u64 rx_bytes;
> +	u64 tx_bytes;
> +	u32 tx_retries;
> +	u32 tx_failed;
> +

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


