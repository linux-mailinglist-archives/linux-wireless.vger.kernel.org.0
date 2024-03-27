Return-Path: <linux-wireless+bounces-5395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E56888EE9E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 19:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E64D9B2274D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 18:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E2E152172;
	Wed, 27 Mar 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Tf0ipOtp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E41514D7
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565620; cv=none; b=jpP0jOoQ5WUIFJIg2LS/DSRt4nueou6t5QcCF+PBoZHBIhmhewPyKLYaWgP68612b7Fz/4RV1+3EJufnfXZPdUIxicOWy/i1M43FV/UEUm80BV+PoTzM2NO9MFVuHFIofLAK90vifCx0ed9hCmgrC3es/Y8O9/5nptrLy08883Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565620; c=relaxed/simple;
	bh=DRriF96XBdtDbA0stDmuq0Ozvtm/4dViy+piu1EqTFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyb76jVpjTyIV+YCkaP1MHMI8DjfR3/9PigchRmYhm/OE5wqMPTejy3jpJryEZcZXCd1MtCYfOXnKb5IaR00l5AvTN/ODfPfJMIcSTLFH9Pj3tECqc79IY+I+zl+TWLRLs6kjn43ghHoHaKHxfnoFimQXzzEc/31gL56rtX7U6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Tf0ipOtp; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id pWKlrZ4dtPM1hpYP4rw2li; Wed, 27 Mar 2024 18:53:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pYP3rUA1BYakKpYP3rcktZ; Wed, 27 Mar 2024 18:53:37 +0000
X-Authority-Analysis: v=2.4 cv=a4T79lSF c=1 sm=1 tr=0 ts=66046b31
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=0yL73Cyy68KADmUz8mEA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gdIFR+CqW2Hj2dXzDKpIE02t+3L7EdU4qxKK93B9/Fo=; b=Tf0ipOtpi0jeAMo4neqo5oMZiS
	ATSJyTc5sBz7hKoQdpI8on6+u7RfGRaI8vKMNAKx9ceiayArBeevctN7FVjjs6ls5K4ktPWNGCMjm
	Fq6Nd8R63PrT6CZC9bzR4cVyUs1qe14QkX8fsg9/4RND+GG/1vGWHLB/17yFZXcTlV4D8Jme1UssB
	J3z/Ukd0wr3JkRgkDf9yzX0CXWofYVCqWPwLXIZpWXat3J/pPrTY4ZJKLGlfo1Pcuw26KaX6H1ykU
	zaRsPG6fURPbfDEcePieD07SDhCFdVdImb6qph1AamMkZwYh0GLtMuote+aUg4pgrkdQG0onCuoKn
	Ne4umHSQ==;
Received: from [201.172.173.147] (port=36948 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpYP2-003XoZ-2f;
	Wed, 27 Mar 2024 13:53:36 -0500
Message-ID: <d34e1ab7-bed6-4721-98fc-0288eb314de6@embeddedor.com>
Date: Wed, 27 Mar 2024 12:53:35 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: wil6210: Annotate a couple of structs with
 __counted_by()
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgRayuCJ0gQinMvr@neat>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZgRayuCJ0gQinMvr@neat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpYP2-003XoZ-2f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:36948
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI/o79qvKcGFmvpNZpVW2mkWRpDPJIaGQuEYgsyPiuAmQHCNPHewQa5MyAhI8UYdnqscwRXgKNPae23JD/g5VTxUNpLbNRv1ISZKVkSNAPNRz4sghV8y
 Fxh0UHct4P5mX3OtiGk8kKY0CfEcRQ9k9qmolIGSjxgjFL5hFFJsQqJrG3emyRB6RKN14/CI8rwyZ3kLlBFpmMsA8QkexgzLX9XMy3nzjMgUe8cKg7iAQkh9

Hi all,

Please, drop this.

The following patches replaces it:

https://lore.kernel.org/linux-hardening/ZgRqjGShTl3y5FFB@neat/

Thanks
--
Gustavo

On 3/27/24 11:43, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>   - Annotate one more struct.
>   - Update Subject line.
> 
> v1:
>   - Link: https://lore.kernel.org/linux-hardening/ZgODZOB4fOBvKl7R@neat/
> 
>   drivers/net/wireless/ath/wil6210/wmi.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
> index 71bf2ae27a98..38f64524019e 100644
> --- a/drivers/net/wireless/ath/wil6210/wmi.h
> +++ b/drivers/net/wireless/ath/wil6210/wmi.h
> @@ -474,7 +474,7 @@ struct wmi_start_scan_cmd {
>   	struct {
>   		u8 channel;
>   		u8 reserved;
> -	} channel_list[];
> +	} channel_list[] __counted_by(num_channels);
>   } __packed;
>   
>   #define WMI_MAX_PNO_SSID_NUM	(16)
> @@ -3320,7 +3320,7 @@ struct wmi_set_link_monitor_cmd {
>   	u8 rssi_hyst;
>   	u8 reserved[12];
>   	u8 rssi_thresholds_list_size;
> -	s8 rssi_thresholds_list[];
> +	s8 rssi_thresholds_list[] __counted_by(rssi_thresholds_list_size);
>   } __packed;
>   
>   /* wmi_link_monitor_event_type */

