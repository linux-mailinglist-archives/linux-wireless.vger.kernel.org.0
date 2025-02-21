Return-Path: <linux-wireless+bounces-19299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD151A3FEF6
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 19:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19DE188F8A8
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 18:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC881F7561;
	Fri, 21 Feb 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UwaObQTt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B05A1F755B
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740163261; cv=none; b=Nu7YoM6H+JgW1uYCi/lXJezxs7y/ay6F0e9P0cbAg/SDVcfk8gI1c/5OrqSuTktN4ozsDTVhouIlPbVQGY48u6yEVH81tGly2MI9WQnUdD/DaEzCvZ9EPwiN02UpuEXF/hQR0+3AszMVigZCJZYZmdKF0Rz8t5r4xm5n9PNOR9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740163261; c=relaxed/simple;
	bh=H2zhK8zZ9asWfz3zUhXjZoqJeGM8OMCxl69KstTzyu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeJYKzxzJFJbNHo9cx+EZHVN2ufoD85/WvjrEAZVGBl1tmL3EimKc5oKiY/2/yjFZJ0nnO20nMywdBDfK5MOE5QNHzN4EFkuBf/AWYYHRg8ejPl/AlpYWvtjQtp+uUcSgSC9Fr4G6aLM1R4NkkwrzwAwj/fB8Wz4GPlQAvSX8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UwaObQTt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LDhOup018511
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 18:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wMYP6hIrffnWUkIHtues6VuRiWcXuQIYdaUazXfUFUo=; b=UwaObQTt/PJjYe+k
	YBofITckKrC0F3eM/uxfwWsaMLW6LZRi2Q5mf+ayo/gAtR3jFQ4VqCipfq3EFAMK
	BdrH2dr8CO+5Dik+3xf55iz+nOhrkuTfpTK21x+9t0MIf/R5Bs0Y7dAycxFMhhAz
	LeLBrfWAlYNtEfH4MTvlo0GJSRVxGzi4ESzBP3Sn7RwpE9r1GYDENkDImKC9skoG
	RBugCZv1Ne+/0zJy1E/TgZaXHQVkX4BPAswRYCY72Pzgf0RS0GS2+iUE76wSQtIA
	IxxMFjzM3sc04QOW5BjeJG6LLgjPzda7Fnhq1pqz0+3swP6DdmuUQVKfb4gu5nPl
	uLZ+SQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44xm3rj7rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 18:40:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220f0382404so46679455ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 10:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740163257; x=1740768057;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMYP6hIrffnWUkIHtues6VuRiWcXuQIYdaUazXfUFUo=;
        b=g+bnX4CErtzPZJQihrqEQhi8PPf5f5bH7xoUy8XdhNiAqhVmzk7Vodk6ei7v+6A0g8
         rTjbvmnkWi3mwZzSGNi6xGYGZoa5E9eayijOZnk51mUNiOjdYoAGf9cXODVPz07wzBNU
         FPAYliHB0tX0X38gUJFox5J7lwHKyM/XeSVvSQpmn01xNqb45Mddr+dXeprkTZ4uTyQZ
         vNlEdLtulfxhBj2Cbu/EPZdOvTxxyTf5tD0w5YDmDVFF4+5dXl3dRq4fZP9lM6ANVoUS
         3382BN2dZv4CD3mWeljEgaf9KvIcbEmU/1oxBLYzK+OMKyOPjlv4W89NDDnAjd8BXYJ3
         iz9w==
X-Forwarded-Encrypted: i=1; AJvYcCU7d9AlJl0hrp4vFRq44qlpxQfc/D4xZuqgzOxYx3JqbIYBgduRDxUuLmk9Gx1sGvdMqOvhYQT0BCF2nZhEwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNeZhjgaxaS8IuGGVmqb23HfR7GepazSv2b5mKRsz9C2yD9g5
	khqsJIzsgQT512b+2HFCK2er50Gy1GK3jT6GN2066n6URTzpQWLExpkOjrwde7rPjmgnr0bdtJv
	Bl7e4qOQ2HS1JAz97nDDUwyv1v9EU2MhQvnW/xhDvDts+QkS+mEEyKNeFoQgGJXXtMQy9EsFpPw
	==
X-Gm-Gg: ASbGnctWSGbXblJhy5DeNOcSpP5dISt8wOax49XjAQivOYWQwvOe3lG4zFuKxzqAQNA
	VB+Lhw/IHgvHVZqOwdAzLkse/YoHGow5Y0Eta/ScYUi79yG3ryhTqDnV3bOVRtl3tvEwDlZ6Wmo
	86JY6fbRa3QsT5b9FWduahJX4hDZ5ODV17NB6AFAPyPSd2PDAjlC+u1aNrVrkpb2mS5SnJ/ZgAt
	PSc2ixqVIJkKJdCnEg880tFqogRjQ1Bbr5raHCBeo4GcaSZ5iZUANKl8+Iu51sMNkxDjhr8fISo
	3oIY6SNySsPEdFRijuH3Ghm3+6EHbleZIu0rC5hW2h9Ok2voM1ld2tmw0RtN+C4nmBOk44TouTx
	YNmyPacQV
X-Received: by 2002:a05:6a21:62c1:b0:1ee:d664:17b2 with SMTP id adf61e73a8af0-1eef3d87899mr8951878637.30.1740163256689;
        Fri, 21 Feb 2025 10:40:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKH11POX2hcjDdmkIoR7gpNQHjH2N0ihQ45xic8nCrVScNUqFWhQF/1zMPciFRm+iSwzgCAA==
X-Received: by 2002:a05:6a21:62c1:b0:1ee:d664:17b2 with SMTP id adf61e73a8af0-1eef3d87899mr8951839637.30.1740163256263;
        Fri, 21 Feb 2025 10:40:56 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb58618479sm12525512a12.33.2025.02.21.10.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 10:40:55 -0800 (PST)
Message-ID: <c5e627da-5822-4fc0-8575-431435add7f3@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 10:40:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: nl80211: report real HE length
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>,
        linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
References: <20250220074657.120288-1-janusz.dziedzic@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250220074657.120288-1-janusz.dziedzic@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tLJl4IiNKfs60LBknkTq1AHPBSIivkwR
X-Proofpoint-GUID: tLJl4IiNKfs60LBknkTq1AHPBSIivkwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210129

On 2/19/2025 11:46 PM, Janusz Dziedzic wrote:
> Report real length for:
>  - supported HE-MCS and NSS set
>  - PPE Thresholds

Are there observable issues with the current code? If so, perhaps describe
them so that anybody with similar issues will be able to find this patch via a
search engine?

Is a Fixes: tag warranted?

> 
> Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>

Actual code LGTM,
Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

> ---
>  net/wireless/nl80211.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 8bd09110d393..c0772e24cc2e 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -1873,6 +1873,12 @@ nl80211_send_iftype_data(struct sk_buff *msg,
>  		return -ENOBUFS;
>  
>  	if (he_cap->has_he) {
> +		u8 mcs_nss_size, ppe_thresh_size;
> +
> +		mcs_nss_size = ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem);
> +		ppe_thresh_size = ieee80211_he_ppe_size(he_cap->ppe_thres[0],
> +					he_cap->he_cap_elem.phy_cap_info);
> +
>  		if (nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC,
>  			    sizeof(he_cap->he_cap_elem.mac_cap_info),
>  			    he_cap->he_cap_elem.mac_cap_info) ||
> @@ -1880,10 +1886,9 @@ nl80211_send_iftype_data(struct sk_buff *msg,
>  			    sizeof(he_cap->he_cap_elem.phy_cap_info),
>  			    he_cap->he_cap_elem.phy_cap_info) ||
>  		    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET,
> -			    sizeof(he_cap->he_mcs_nss_supp),
> -			    &he_cap->he_mcs_nss_supp) ||
> +			    mcs_nss_size, &he_cap->he_mcs_nss_supp) ||
>  		    nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE,
> -			    sizeof(he_cap->ppe_thres), he_cap->ppe_thres))
> +			    ppe_thresh_size, he_cap->ppe_thres))
>  			return -ENOBUFS;
>  	}
>  


