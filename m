Return-Path: <linux-wireless+bounces-24052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7FCAD6ED6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7BB189F1E3
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB438205AA3;
	Thu, 12 Jun 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PGv+2B6f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02807EC2
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727195; cv=none; b=TcpT/7DxVnFU0qOKTPaRLNWMcIQdx5voa21B381xxyZJDO2JsT2op4ksTGZc7sQAIhlR4j8N82TjBYB6xKleeL4NFVdc12pvW/8lWfW6m61vkCRp212bm/bT0t6Tq/625JMYpUid5W1XH5uQFBYGXR0EIDjvy0Tp/wogcbClTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727195; c=relaxed/simple;
	bh=JAdtqs3zGWrmUQ/02QPjTpOUVJpDF9rKNNKxrvc/EwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8tiCU9nlYlTxpL6dho4B7lndooA4u1OqH77529o7IhJvXL87iChdC66Ix7+RvK1RnOOlSKiEVSDiWUZBhVpfvP8z4wiqRddMEsptXzX6bWRlgHd4tQew1cYQ4F9+f3SIf84g9ip3iWK5MqiezmAod30z4trW3L97R5CtuusX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PGv+2B6f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C996ME031607
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7QIskp7CeaFU7u4UNInC1v8TRYXWF8xfW2XMu+8r6y8=; b=PGv+2B6filVfzlnw
	qFQC+g29GIxUfp6kN3eTp6J5fHn7JpE2t9AQOpqzwhmTe4fxaw5XQmtP0neba6Y0
	CQ9ZYkfEjH9uv/hc9IsWVgVAjCWCcfoyS3QrF3V4jCxYJDCI9TrTCfUpS0PXKh+f
	wRLLgBxL6kTUum7niuaBsRmFG3sJJk/Wv5VFZOpyhIo9evTAMXoPs0o0/QFF2rW6
	osOusL0EVJ/xfpFvFwUuE2SJSRcRXgEQ8dOl/RfLYka11gvudS5mP3a6si+HbDAE
	JwWQBNI2kzMFi/1mwakoYz3QB4iI+A6sDSfCwR1zQep/g/3deOSxL0EdVx1jAAAq
	rDUBWQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 477jdwstge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:19:52 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-747adea6ddbso825189b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 04:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749727191; x=1750331991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QIskp7CeaFU7u4UNInC1v8TRYXWF8xfW2XMu+8r6y8=;
        b=ncQx+IUrFF8LaNPKJFXbMGf+o6LhxQxsNWK6sh4maa4+bw49fJolwY6uZ0RnBY5ZRk
         5sKeyMAHe7PeTdg22ybu5+fY1epV3WOqKhx+2VlJ/ur501tuALKLukQOq8jaslTEEXnu
         wfRfEORPG/zYg9pHbEPJ/xQ3bunFDpqWWlx089reIO1NShbmZSlS90uwZRVQIeDiKAPv
         o8AfUWH9GdIW2KcXnifujNZdAnb3Xk60HE2ojVmH08ih6EG+uLAnPao8cCfxDD9I6Ihz
         Vis3XsCoNc2tI0r+9V2NotSeLnUPJnE6wzvFMW9ru+TSCPVRSdNTnNPd2oLyaYqdodQJ
         wfBg==
X-Forwarded-Encrypted: i=1; AJvYcCX4KNZT0dy8t2AGW81S+wNPfDqjk5CLbKcFT9nPbAYDyRVd7e4kn54S2iF2t23xtBd/y0Vnpx+jmrAYUpDMfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNcK5jfXR8cQTAElraPGFjGnn72x3nMkt59pKvgPAEw2HSHA2A
	vnFT48tXVUwBJi1i8jskmrgiu7PPz4xuk7WWXUohllOAsYhh9J4iVBmmcXJwtDTRTEAGviNMmYu
	U34nr/MSHnNRxYl4D029tHnstHUFw3XJWfVcFrGO4AzewfLzj7MY9ulmez6TdlNxhK1U6IA==
X-Gm-Gg: ASbGncshaxVhkypF5i+yNEiONJHD1EYB4EVdImkiXzga4AsnlztNlBJhWcY7B6gHec0
	CMNT0zc1YODIovn3ee+IBYkZcR2Acr4ghDroC2JhO9NEtTx+GKjfXXn79s5gDepAtIigB4/kThU
	P5tlkChLNuD39Z7W7Cft6PUUsg5mowkjjEYtGXLclUp5jjFBmDbnfy8YxLZp7YXODrTv9e2PzG+
	bpQS5ctYd66AWuEH6qSScDolCvsvVAFeMJlXaBacmnR3K+pG8ZzqajeL3VVguiX5fiavZVt71T/
	3/SLosPY7dJCrCuAz49a25D3V7sRdmLOz+FZ/IJ+oK/ugMjNMnVZT5PyEXe6ZfDu
X-Received: by 2002:a05:6a21:1519:b0:216:1fc7:5d51 with SMTP id adf61e73a8af0-21f86747eecmr11545649637.37.1749727191392;
        Thu, 12 Jun 2025 04:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEymZNRL34fw7cMWDROMev8RqOV8BO00M024ki/BJ4JwmO6XOC+uwIudz/uK7cTSGz1z7G5uw==
X-Received: by 2002:a05:6a21:1519:b0:216:1fc7:5d51 with SMTP id adf61e73a8af0-21f86747eecmr11545609637.37.1749727190903;
        Thu, 12 Jun 2025 04:19:50 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488087aa4csm1198848b3a.8.2025.06.12.04.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 04:19:50 -0700 (PDT)
Message-ID: <ec974dc0-962b-f611-7bbb-c07a3872f70f@oss.qualcomm.com>
Date: Thu, 12 Jun 2025 16:49:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath11k: support fetching mac address from nvmem
Content-Language: en-US
To: george.moussalem@outlook.com, Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250324-ath11k-nvmem-v1-1-d82bdf72820e@outlook.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250324-ath11k-nvmem-v1-1-d82bdf72820e@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA4NyBTYWx0ZWRfX90xwbpgjKpRq
 XqLk29X+XF62u/kNpUxLsiLiIcKaQujRonXLLmnDIodUTGCvUZ7jz0DlU4ShgMLI3oHCmjAghtv
 Ci05bNSJaCrarQh+N11pnezRCp1zj+Z9pwYc4OWYk2EXzBShZ7aNqNsCzCWQuyetxFDybY7nzCb
 RW9GUtDJcEZaFUqwy9VW+NW8uLiZu8eKmoSlzmY/I7+xyh4/HjVoCY3B0ABCMmjgdYZUR5dCPMX
 6CLd70Tzov+jLRDd/7CIh3I52UBaNRe7LjdzV7zfsu1fJGCTh68KRD7iEEMFcaYfO+93pKNsEsK
 497oQLYooc1X/4iG/GCpdtsN9pfpKMBtBis2RbhbgW9l0l04LgecFSHeF15b+BLYau2R5XOtSX9
 PJFb4jE5kAbZSstoPLB76RPYRvxl8kipJvhjuJuKYaH129OHLCNkObzgbk3jDGv6SHYw0MZ8
X-Proofpoint-ORIG-GUID: S55TRbaYiZIIZ69hhG-GYdMiqDHNfPvf
X-Proofpoint-GUID: S55TRbaYiZIIZ69hhG-GYdMiqDHNfPvf
X-Authority-Analysis: v=2.4 cv=Jce8rVKV c=1 sm=1 tr=0 ts=684ab7d8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=UqCG9HQmAAAA:8 a=wwL4Hbxs1AlHKMMt3U0A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 mlxlogscore=916 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120087



On 3/24/2025 11:54 AM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Many embedded devices with ath11k wifi chips store their mac address in
> nvmem partitions. Currently, the ath11k driver supports getting the
> mac address from the 'mac-address', 'local-mac-address', and 'address'
> device tree properties only. As such, add support for obtaining the mac
> address from nvmem if defined in a 'mac-address' cell by replacing the
> call to device_get_mac_address by of_get_mac_address which does exactly
> the same as the former but tries to get it from nvmem if it is not set
> by above mentioned DT properties,

May be not exactly, this also moves from a generic API to DT specific API that
might impact systems which dont have device tree (x86)?

> 
> Tested-on: IPQ5018, QCN6122, and QCN9074

You may want to follow the existing Tested-on style.

> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 97816916abac..49af6b9fc867 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -9,6 +9,7 @@
>   #include <linux/etherdevice.h>
>   #include <linux/bitfield.h>
>   #include <linux/inetdevice.h>
> +#include <linux/of_net.h>
>   #include <net/if_inet6.h>
>   #include <net/ipv6.h>
>   
> @@ -10379,7 +10380,7 @@ int ath11k_mac_register(struct ath11k_base *ab)
>   	if (ret)
>   		return ret;
>   
> -	device_get_mac_address(ab->dev, mac_addr);
> +	of_get_mac_address(ab->dev->of_node, mac_addr);

May be call of_get_mac_address_nvmem() when device_get_mac_address() fails?

Vasanth

