Return-Path: <linux-wireless+bounces-771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36EB811FD9
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 21:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F51C20EF7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 20:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6A97E540;
	Wed, 13 Dec 2023 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="x52FsXjf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA2FDB
	for <linux-wireless@vger.kernel.org>; Wed, 13 Dec 2023 12:21:02 -0800 (PST)
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id D5TWrbbdGWcCIDVj4rvllN; Wed, 13 Dec 2023 20:21:02 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id DVj3rhQtd0xkrDVj3rcmiN; Wed, 13 Dec 2023 20:21:01 +0000
X-Authority-Analysis: v=2.4 cv=N7U6qkxB c=1 sm=1 tr=0 ts=657a122d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NTzXNMFqqmFafkXJ348A:9 a=QEXdDO2ut3YA:10 a=phs4urI-Bf8A:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7UAQwQ7IEtUhKOpC9ppXTt8xH6jO7zZPX28hM2QTFvA=; b=x52FsXjfxbUcEeG9/WkQOhe+2y
	jct1laMvmnHlYE2wFSApdVD2VqsiYlBPyH4EAm7tA04/0pPCbZm23IaZNzHzcrc+FYSeE8vTmVUMp
	ZMsdVq2OrSPvRy6BH0pkMg9xHXfjopFoNawyVLlK7t/mocBLeTjdtQxUwpuG9GO/3mXLDjkNH7zLd
	OAfhFOX/l/leXxYamAy3tZB8V1NEm/lLeLEdaWF9owd5voG9iTx5y2We1sj4x1HNHRVfRg+iKmbYV
	ieuNz1ubExRMreRfX2hvnEJlvlVYXnUcwcRa725grxbpmxo2bm0JoJPodPIwwz0sB91REK3xvl+3/
	zNfHEv5w==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:36860 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rDVj2-003Rqk-2d;
	Wed, 13 Dec 2023 14:21:00 -0600
Message-ID: <6f95ea62-ff20-4aea-817f-6c5f84ab5a97@embeddedor.com>
Date: Wed, 13 Dec 2023 14:21:00 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] wifi: ath10k: use flexible arrays
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
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
X-Exim-ID: 1rDVj2-003Rqk-2d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:36860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 38
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKCsDuGZAbxmmow0Tg+5QLG2tUVhzAGM4jRQKox816HGPMQ7ZlXTF1xTRLnEbYm0lfjDba2GDLRmHIXxRTaTP/9TM3jdtjNMYEKASpI7p9qADpL7zYug
 GzHXcjrOq1RP2A5Un7iO10rkXUfPu/fEVDFUFaQsiwSXkEEU6VKuyMRhsO3dWiKJHs4HJfYnd001B542ymB7L+fvdkWOL/LCJQqxBbELAorPkZXaRc8ABvk4



On 12/13/23 11:06, Jeff Johnson wrote:
> Clean up the last remaining zero-length and one-element arrays in
> ath10k to comply with:
> https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> 
> With these cleanups done the ath10k-check script no longer reports any
> issues.

This is really great!

Thank you for taking care of this. :)
--
Gustavo

> 
> ---
> Jeff Johnson (6):
>        wifi: ath10k: use flexible array in struct wmi_host_mem_chunks
>        wifi: ath10k: use flexible arrays for WMI start scan TLVs
>        wifi: ath10k: remove struct wmi_pdev_chanlist_update_event
>        wifi: ath10k: remove unused template structs
>        wifi: ath10k: use flexible array in struct wmi_tdls_peer_capabilities
>        wifi: ath10k: remove duplicate memset() in 10.4 TDLS peer update
> 
>   drivers/net/wireless/ath/ath10k/wmi.c | 10 +++----
>   drivers/net/wireless/ath/ath10k/wmi.h | 55 +++++++++--------------------------
>   2 files changed, 17 insertions(+), 48 deletions(-)
> ---
> base-commit: 7133b072dfbfac8763ffb017642c9c894894c50d
> change-id: 20231212-wmi_host_mem_chunks_flexarray-78264e146731
> 

