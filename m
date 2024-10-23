Return-Path: <linux-wireless+bounces-14436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E688B9AD6D8
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 23:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82BE2B226D2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 21:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2881F5848;
	Wed, 23 Oct 2024 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DdC9hlmC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C36E56A
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719806; cv=none; b=AncZPdX4oHtoyS9lFRMC1ov7Tz91ilThzBGot8+/pmMd5XHOTYETycEzb92g+BbeSrXDPNj6xMFYPkas3L8QCU/RLCMwHK3InKRh0rHqmJuZxmWT0M+OyUHgSG1/NsMANcVR0YhcyRq+2lsOTLgXceyz5awCp1vRW0EiWCIjsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719806; c=relaxed/simple;
	bh=D0Tfqt5jcLVUkD6Q67v0hwF1VSxCNxhs/HDdCEwABZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=au0GWOWBs1FX21Gffu+0LOaY7D3WDZPJaplQMBhBEbSSgQIRr3PYOmwEcD7smfqwdGFnzB1SsEbaKRvf6Y3O3mq3g4sFYdmlNR7K/cxT/oK0u7O+d1mjai/cRDLZzm2e/CnP9alHrPP/Oz9A+JW8LnRy70dNmWdLL/ReqXUJy2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=DdC9hlmC; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id 3exdtq2HjiA193j8QtYfFU; Wed, 23 Oct 2024 21:43:18 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 3j8PttDAxCB7M3j8Ptjft3; Wed, 23 Oct 2024 21:43:18 +0000
X-Authority-Analysis: v=2.4 cv=Y97+sAeN c=1 sm=1 tr=0 ts=67196df6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=vaJtXVxTAAAA:8 a=iwwoO_9B2agcGiYlQ7MA:9 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=16Q14PDMblkrTX6HXayHmrPosS3yrk6wYHUNr9G8tFQ=; b=DdC9hlmCbxOMYomLHYhhthbaGx
	T/pCCUXSbFOZ+S9cD7IpJAaaZVuA5uuG8yVA6RZgKxw6F9bfXV39r2ppXBex5nBYqisTZrirkxEzH
	30y3DCx902J0B+ymLZHjJZU83Dx9M/ngd3OUXasP3t3NdWOvqTIDWZ2tC+pw53v8FISB57lisr8mM
	GnVsdbAs+g06Ef3NS4SbBOO2o9SA97NUXKo4oJZTi965iZZqH9nLER/aLBfhpdvx7AJb1xRfkTsb+
	4NYL2lvjX+hErHbrAY8ZzB0ruJJgd5g7Y9WazxlNYYbYtr/VagU4MUG86dCJO1ojRCJrvc1TqoDvW
	qID9nuJQ==;
Received: from [201.172.173.7] (port=55182 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t3j8P-000jzM-0A;
	Wed, 23 Oct 2024 16:43:17 -0500
Message-ID: <a51a9a11-02b4-4da5-a9cc-1317b6bc7526@embeddedor.com>
Date: Wed, 23 Oct 2024 15:43:15 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: annotate channel of struct
 ath12k_wmi_scan_chan_list_arg with __counted_by
To: Dmitry Antipov <dmantipov@yandex.ru>, Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20241021143419.587716-1-dmantipov@yandex.ru>
 <20241021143419.587716-2-dmantipov@yandex.ru>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241021143419.587716-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t3j8P-000jzM-0A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:55182
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKiJTb4Vb0KON/Bn363BXm73VnK1vqGDXx6NcRexZkyJnaA1vD3yh1s9c6Xql6qCHbjUhtyghZk20LZvOhteTF+AQw/mndBRWcyZf8DzgO52NRoks8f5
 6v6s+rCCZQ10sUWXZa4BpfyZRtKmFNtjnkcb08IqSeHPQU8guOE2sxyoJ4KWrCmRATj4wgVfNkhidPrWbc7cTxiu/H1+7F9RY5f8Sb6/1E8bOZNhraQ6iseH



On 21/10/24 08:34, Dmitry Antipov wrote:
> According to 'ath12k_reg_update_chan_list()', annotate flexible
> array member 'channel' of 'struct ath12k_wmi_scan_chan_list_arg'
> with '__counted_by()' attribute to improve runtime bounds checking
> when CONFIG_UBSAN_BOUNDS is enabled. Compile tested only.

It seems you didn't[1] actually build-test this changes. :/

-Gustavo

[1] https://lore.kernel.org/linux-hardening/202410231916.Wjn5HeB6-lkp@intel.com/

> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   drivers/net/wireless/ath/ath12k/wmi.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 6a913f9b8315..9a6e28142754 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -3746,7 +3746,7 @@ struct wmi_stop_scan_cmd {
>   struct ath12k_wmi_scan_chan_list_arg {
>   	u32 pdev_id;
>   	u16 nallchans;
> -	struct ath12k_wmi_channel_arg channel[];
> +	struct ath12k_wmi_channel_arg channel[] __counted_by(nallchains);
>   };
>   
>   struct wmi_scan_chan_list_cmd {

