Return-Path: <linux-wireless+bounces-18950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADDCA35210
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 00:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D1116A57D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 23:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9444E212B3B;
	Thu, 13 Feb 2025 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HeqQg5O9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1482753F5
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739488669; cv=none; b=FAXlFcj7IYAB8rKi3wX6wNWBw+kYou0q45Qik5Z1hGR9CYUyK53MIXB0TxRtgTVo/CBwcTO8NBYH+jHs9s2s7qD9meu5oNpt9Uw/D9MhMBtz9cNuIJavu9smLiW4XcSgAfKw2KoFye5dxC+tvX7m/nYU8aWrmXe+4unPtth8wkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739488669; c=relaxed/simple;
	bh=h2iPlkPXpJOSydcIUW8hf9gV7XycBheX/Su2h8taiwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idveoChrcuJGxOBBna0IQywCJuIZsq3ztc1qCfji+Iu96O9u2UgmH3fmhHphw1rWu3YLkIYBpNnaH85+rCWqzHJoSkkO+HreJbLJXQ9uopo3kIr+ElC5Q+HkVX5yR7lXsHyKt9KUaJJmXZYXegpoyF3egqWb/VzcwbnLML+vu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HeqQg5O9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DKVerY027469
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 23:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qrKqwAz8/y/nYtbJvGFXtPOikpfxCNae5javLo1xFL0=; b=HeqQg5O9K0Y7E2at
	X8d5r24mh7rsqGWqMCZMr1fXcvANuTXs2srUlJhxiIa5iLLIVekqoq1bbfxDKYU9
	ZAhwDVHLixMxBn0IWqsKlQHBRXi3Fq4OkfoHqCYgK21bApxWVaUkeU2DL59D33uE
	LfOTLd2i+VECGZQfTO6pYsk418w3Ou4SDvov2ox++ZCWiVWJdYFipasC+0RKrbc/
	kx6bLQ6hXQHLfqU52KRBX1JhV1agA6+PFsbL4UZTRMUJVPOEcwoC7bC6B8nt+Gof
	ALy2Uv91KbqmafKYcQf0df9IT09xidVIpa2n+wEtgjwoWLRDCfhLNwbeCVj3HFPR
	1xQQOw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44sebn9ye9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 23:17:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e43050c8d0so36033696d6.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 15:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739488665; x=1740093465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrKqwAz8/y/nYtbJvGFXtPOikpfxCNae5javLo1xFL0=;
        b=gnuRgA8YtbohgHktw3YN8uRIp8BCHGd8U7fQs2/rNksyIDHrH9cCyUsd8ZGtQPMKBa
         b6fa5b647LT35mhVYM4Lybl7d8S79U0DPmnbSxgp+NNakGNuXTIZLUNgQy4Ry738773r
         fxW+vaY1uMRJ3ZoXCaWOvCSe0AYRN6578o+PvxitzhcX9LGpMnEXqELrtq+iv+ZkdPAb
         oJfWkAAsxDRwYli1NRQVjk8ZOAV59Cjfvkrp2sPKSsZgQrAGy5JceGlpa52vLKrZoUGb
         6wgCaIz5bn73bpHWnzzjt9q0KiR0d+rd087p8H9psLau6yz3pxKGuidpDsRWHxsVt7Za
         Sj5g==
X-Forwarded-Encrypted: i=1; AJvYcCWpgyGxLhTVskpoVedrV39Iyh7cHZ0ZsCEhrKrhyvcAzUh5xE1Jg64SvuYp3sEX5YzeppKB/vX3UZCzapkORQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDLoLJR9xYWflOsFY/9dKS8ktLe7xdahoUqBSWC4gRIWueMYqM
	0OHNkPIobL0cqy+cPgrbf5A29Qts3aqKALcCb+NhQCTgzac/k74zQeBOs5F2k90FoOhD7oINF3I
	JputPOm9IkbPlz9lutt3P9G01BdrpiAKLtaze2kiN/AgrE+YFHWQS369kf2maT+DoQu0sNx0nig
	==
X-Gm-Gg: ASbGncuAHfZIkw/65BdG1ztTStpRMHwC2Ax1My0XbonowVPAuQzDL2/Iei5IuJfR9Y/
	II9aI45egudZa1tkeylItoXIYyu+ArAGNnHza59i27u3/bO9IlzUKhs6qMegMBSbjsszxbmUncf
	9+X554Yfw6Fp6Y0c3VSEC7Uz/6/Fg0J69nmEBtBwq2iRMi6gFV156PcB/7XFF1+JjqFOInbiIbY
	ebGTrTOwXFf8bk5QQpkAfEcVCbYt38X1vuQ8ryHufEspD2CaRgoDPiuyPZYx+k4KRdH9YLvKPlW
	tu6z/DAjXH42t300tQBxBovCaTaNWcxpKPaUXD3gZO511lUKOAICQ5nXY3E6TAXcFYXQQw==
X-Received: by 2002:a05:6214:2028:b0:6e6:5e66:770f with SMTP id 6a1803df08f44-6e65e66780fmr67123176d6.16.1739488665656;
        Thu, 13 Feb 2025 15:17:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3IyNLcVOqUOu1ZVdzkIWViilmcFh2U7s8tXWp9vxKaW2ksV73AkING7XUGsAp9dIz/TYnvw==
X-Received: by 2002:a05:6214:2028:b0:6e6:5e66:770f with SMTP id 6a1803df08f44-6e65e66780fmr67123006d6.16.1739488665371;
        Thu, 13 Feb 2025 15:17:45 -0800 (PST)
Received: from [192.168.69.139] (c-98-35-147-9.hsd1.ca.comcast.net. [98.35.147.9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a4379sm14800796d6.64.2025.02.13.15.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 15:17:45 -0800 (PST)
Message-ID: <14da00e1-f1df-4269-ad9f-4f9be02ea552@oss.qualcomm.com>
Date: Thu, 13 Feb 2025 15:17:43 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] wifi: ath12k: use link ID for CSA finish
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
References: <20250213225036.3118133-1-aloka.dixit@oss.qualcomm.com>
 <20250213225036.3118133-4-aloka.dixit@oss.qualcomm.com>
Content-Language: en-US
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
In-Reply-To: <20250213225036.3118133-4-aloka.dixit@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jWH83LW4DG1VXmOGp6LdiePT2bYs8EA9
X-Proofpoint-ORIG-GUID: jWH83LW4DG1VXmOGp6LdiePT2bYs8EA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_09,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130164

On 2/13/2025 2:50 PM, Aloka Dixit wrote:
> From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
> 
> Send link ID instead of default 0 to finish channel switch operation.
> 
> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>>
> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 4dd6cdf84571..198e22ec6735 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -6894,7 +6894,7 @@ ath12k_wmi_process_csa_switch_count_event(struct ath12k_base *ab,
>   		}
>   
>   		if (arvif->is_up && conf->csa_active)
> -			ieee80211_csa_finish(ahvif->vif, 0);
> +			ieee80211_csa_finish(ahvif->vif, arvif->link_id);
>   	}
>   	rcu_read_unlock();
>   }

This is merged now as part of another patch so can be ignored.

