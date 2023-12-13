Return-Path: <linux-wireless+bounces-765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D21B0811FC2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 21:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816471F213F0
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995717E553;
	Wed, 13 Dec 2023 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="F19Xfa/f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A717FDB
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 12:14:56 -0800 (PST)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id DUeirKZP58HteDVd9rdlYp; Wed, 13 Dec 2023 20:14:55 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id DVd8rQolqGKIcDVd9rHGVN; Wed, 13 Dec 2023 20:14:55 +0000
X-Authority-Analysis: v=2.4 cv=E+beGIRl c=1 sm=1 tr=0 ts=657a10bf
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=uucgfnjzxiVboiWmI4QA:9 a=QEXdDO2ut3YA:10 a=phs4urI-Bf8A:10
 a=AjGcO6oz07-iQ99wixmX:22 a=TjNXssC_j7lpFel5tvFf:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1HyjzJtPl2sUntsAoFxkWgAbY6M7c0HaPJqZRErlf6Y=; b=F19Xfa/fVsko11ZYAAp+fLLgQE
	JKYZf7l5jeio10XKdoJ92Ca6CIbpzzE303mOM8CFzMLyyaaYFNqZorcLQrm3F//jBfGRyM9q+hRw8
	85yPu0ZLN1Q0GNj5Wq4d5zJLjkRV/9hcqK5MaeeRLZ1al/HZ7LJ/EKWPIn7LYl+BqV+NUym24eO5o
	nG1bZsdkm7VNFItpWobUGQCFEJpHzpWyw/14YxHbbaqfGjOfTZoVSKAIdLW2q9Om9sjw86EwnDRoZ
	XfY6tdpgITObdjqjbmfxrL3jq8ChxnJTW2Y4CE8dLMginTZCjjVGXAe4B8FzflF5iQ6CzIkJnywY1
	lugecQPQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:60998 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rDVd8-003PFj-0p;
	Wed, 13 Dec 2023 14:14:54 -0600
Message-ID: <f5a23931-6c05-4eed-91a5-5b829ad3aa94@embeddedor.com>
Date: Wed, 13 Dec 2023 14:14:53 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] wifi: ath10k: use flexible array in struct
 wmi_host_mem_chunks
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rDVd8-003PFj-0p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:60998
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGo9bQFmk0BbUINlFDdu6Ia+vprTEJjBV0KU4cDd035Rev7hqawnFoaka/EEL4YxdvcgF251F025a3iGbmTvCqfoj3S7r5pT9lgCkRTIGtPN9Cghe5ix
 TYn2vpgrBkNjs2lKyf38pj9QKOqLFT4d+hd3TDjuVdoad4xUaaoOe70onH26vGN34RAsYaN8kZ3EHpyVaVWvsJcs7RhW2F7SqudlpdZZw6/ZMW2lbNwmimIn



On 12/13/23 11:06, Jeff Johnson wrote:
> Currently struct wmi_host_mem_chunks defines:
> 	struct host_memory_chunk items[1];
> 
> Per the guidance in [1] this should be a flexible array. However there
> is a documented requirement:
> 	some fw revisions require at least 1 chunk regardless of count
> 
> To satisfy this requirement, follow the guidance from [2] and wrap the
> array in a union which contains both the flexible array and a single
> instance of the underlying struct. Since the footprint of the struct
> is unchanged, no additional driver changes are required.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> [2] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   drivers/net/wireless/ath/ath10k/wmi.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
> index 9146df98fcee..833ce0251a2c 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.h
> +++ b/drivers/net/wireless/ath/ath10k/wmi.h
> @@ -3069,7 +3069,10 @@ struct host_memory_chunk {
>   struct wmi_host_mem_chunks {
>   	__le32 count;
>   	/* some fw revisions require at least 1 chunk regardless of count */
> -	struct host_memory_chunk items[1];
> +	union {
> +		struct host_memory_chunk item;
> +		DECLARE_FLEX_ARRAY(struct host_memory_chunk, items);
> +	};
>   } __packed;
>   
>   struct wmi_init_cmd {
> 

