Return-Path: <linux-wireless+bounces-18095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0222BA21426
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 23:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2516B18857A7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BF519C566;
	Tue, 28 Jan 2025 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULjrVbkP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF88F166F1A
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738103369; cv=none; b=nZ6Cbm1U4XwDJ9s89HkoIbdvRDHS0HPS6PJEr42lgmpwcujrDx0t5eFAVzxTQ9sHpiiH2XW4DKObXZWahMZcbA2hpjdCH7Im90u1zVWbTiA/ajjPeGYR8dpNoSB0B+jYuYnbDDds0QU6683e/+tH18JS8f9VedQCdf1KV7BU3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738103369; c=relaxed/simple;
	bh=yRvNMH/SQo7R7vERdi4+tmm3hvVciotx74fK4D5Pg48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtCDNh5vwPX1zS+7qpxIvIcf9oXGLDoAKiIfj0TMYOr8BiZHulvD/hsALI5LkDMz7c8cC8xfHZo9EN3olrt5MZTj5cSrWuUo3pMBtizruwD496FLofpM7gxAOQjtFTpo+dpxYErnQq048VRig2KRseBfoho2KbPi/IM8SgaVnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULjrVbkP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SGHZdV022169
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 22:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KUBj3z+QlIiU8/W3AdzN3Qhed9pVzFFAvcMrnqtnFIw=; b=ULjrVbkPn/mQX0XK
	qtnVr600FdWQSeq2L6ruLDG95VHOz+KvkUfFWXOgh7PcktHeJ+yRuPJ0LRLgoOqH
	hu3Z6A39sP9qnQUM0dGzfdSXR8xhUcA+ScMKVArgxXj0SmwLc+khHPj086D/vni8
	qfhRzFg8E/PF2CdqWkvZ/tY8yNYbCsygafLIT2uQTRLBv4MMXmX5jnpNbHuNeDMX
	qr9MsY3L6tWh3SgD3f05DTOFEUM5Rk19AC1rLQzK43MTwrIvY4rLgSFjQMrYEHB0
	u7aU0wOQkmxaLpHXUBSo0kwREOdsoGDLnP4xUeiTLyhPw3qTmmnTEZVDpD4UiWKM
	dHGPiQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44f2mprs1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 22:29:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166464e236so181965705ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 14:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738103366; x=1738708166;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUBj3z+QlIiU8/W3AdzN3Qhed9pVzFFAvcMrnqtnFIw=;
        b=VYIUO0WSEYXi1lqbMkii9FGm1p/ybfDGJu9zVsQb6Oya5jk6hZd9+FuMjKJzwPRt/l
         xzCrU0xhGZBZ6J9kUJ8mBfRB4R9N2fiYOefF8wFBKnPIAVHYGR30ofTtKhifHPgPnivL
         Jd4Oc0E89ATbM1GIb6/XByqY51P4PZbkVU7rGphRE3QHR5HJEAEe/1p9hU0doxv/F1PT
         T1NfShT8RLjprurOGVIJwW9LL+ElTbAJn9dCbkecG7BYe4R3rbPLBTeqBrb5WQANhsEf
         wlTWOt7ONq4FhoUH3XlqKliVo+gqOB6GN29KlwlrRcGSE2bgegdNBP9+kp+9YWcgaXyf
         zqCg==
X-Gm-Message-State: AOJu0YypPUM2fVfE0Vk0hqNqXL+PP1g8wejM2mlfi2JXTM3rkxXb/DWC
	a99mx/XULlxEgbB+cr+hm8Nx1IEi/eTej5/YgGo1hhIK2H5Uu0cmbhaUF+YMjqechVEP7A2fNTe
	aS/pYHmV5X8FLKl9Mlbf4yU/zB5Z3KHxn4Ky0sXZeDW9btmpwl4ratuy7m/HFHwEN5g==
X-Gm-Gg: ASbGncvGWKElpz29RyV4oOGlekpYiKMqmeKyNMYqGksfUcKPUaHvVTkkDlWj1CkGbju
	Js/8TLfGDfNbuQGDJWz2SthyQUlID+17b3J4D9sZLYQ3dd+Zx9GFcs+PNb141z9+5bLc5mVggiN
	sBURafz4b15aF266D0N6BMaSs0aVzdpfsXoV84LS9Hzlkm9m+tTYwLQlmYNPEyJog2lH2GI2UrE
	DZLOkfKOfwNyJT+yz8/NMy1D56DtE25D538xxzr/id622eywu/Ku9+UwJQpdqO0eFotIG+YYkAi
	GtrHLv9ED00NB1Udo+nRHxLhEJVwf8ahxqYtss/YNFntOK0up9tjcRsdRVKAzs5/0s+btZ47cA=
	=
X-Received: by 2002:a05:6a20:842a:b0:1e1:c0d7:7502 with SMTP id adf61e73a8af0-1ed7a6233edmr1485565637.37.1738103366082;
        Tue, 28 Jan 2025 14:29:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhrrizMPrBdFMbKkt6Ls1uVXYfHcnVaDhIk4IsNSg1AmR8KiJrd3m0UAVfDOH8MjaNTmF0Jw==
X-Received: by 2002:a05:6a20:842a:b0:1e1:c0d7:7502 with SMTP id adf61e73a8af0-1ed7a6233edmr1485539637.37.1738103365665;
        Tue, 28 Jan 2025 14:29:25 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b2ed8sm9732665b3a.41.2025.01.28.14.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 14:29:25 -0800 (PST)
Message-ID: <d5eda793-c7e9-453f-9dbc-07e5df73c47d@oss.qualcomm.com>
Date: Tue, 28 Jan 2025 14:29:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: remove peer extra rssi update
To: Nicolas Escande <nico.escande@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250117181953.3375273-1-nico.escande@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250117181953.3375273-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bDM1pVnP6qizV6D_cRncFAX-hkD_zYGK
X-Proofpoint-ORIG-GUID: bDM1pVnP6qizV6D_cRncFAX-hkD_zYGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280164

On 1/17/2025 10:19 AM, Nicolas Escande wrote:
> Commit b205ce4c266c (ath11k: support avg signal in station dump) added an

I'll fixup this reference to address the checkpatch error:
ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'Commit b205ce4c266c ("ath11k: support avg signal in station dump")'
total: 1 errors, 0 warnings, 0 checks, 8 lines checked

> extra assignment of arsta->rssi_comb in ath11k_dp_rx_update_peer_stats
> when it added the average rssi support. So lets keeps only one by removing
> the legacy assignment so the two statements about rssi stay next to each
> other. Compile tested only.
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 029ecf51c9efd..24774cba9823b 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2831,8 +2831,6 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
>  	rx_stats->dcm_count += ppdu_info->dcm;
>  	rx_stats->ru_alloc_cnt[ppdu_info->ru_alloc] += num_msdu;
>  
> -	arsta->rssi_comb = ppdu_info->rssi_comb;
> -
>  	BUILD_BUG_ON(ARRAY_SIZE(arsta->chain_signal) >
>  			     ARRAY_SIZE(ppdu_info->rssi_chain_pri20));
>  


