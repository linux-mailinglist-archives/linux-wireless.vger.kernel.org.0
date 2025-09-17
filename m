Return-Path: <linux-wireless+bounces-27446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D50B81C38
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 22:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4D117AA2A
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 20:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC962C21F5;
	Wed, 17 Sep 2025 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O32RE3ri"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5452C0263
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140994; cv=none; b=Nc7s3I/EgT9ArOKITvGnZA622Rszfm64GO+dH8lZ+MjCoOCeYpblpRwJgoJIA1A4V6JqTyucNh545gVzR1JN35Jxdg9N6h06H0MqKJfIpnr2XK76RBBhA0URg6LvQncrz/niTFihzyvzdG6QLBODyzQcgty9ctGbVaixeaeaxlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140994; c=relaxed/simple;
	bh=rxAati95/xUI61030WJWld7Jg5f/fH5oCtuvlnPZI1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZEW+EFr6PTFql/LsOIGe7mmD/GbjmA8rvkMrm4K4O4IsFwJzroLTDX24yBL/TgyAMwpafulrMat2JuDoozlGkej59ibmkCpYET3SoHE9nqZsEoLRM/UNY2MrLiriU0fQTtVOkxj6s3FofePD4+ZZULA3AOg817nwzWCTEnKS4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O32RE3ri; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HG4YAt021478
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 20:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HEM1lJMKa2QVcYthJ1BIIXMBnRFN8LfFqYTZtb21724=; b=O32RE3riyGSoQUA3
	q1AU52H69/hFWKxCdkNT2rE9A5iLo9O2DE2gH3UigCTJWh/IhPNYpdk/6/T7rPV/
	dRxVGsbUMtE+V4iN+zYI6w40/OKEW1d6Sbztnqhi9ZNpWabFlEDTj7FqKdBhknfP
	PtoAXuOEl+TX8ni9ogB9Hs8kqbNtxtAO2cnLFJjpoMcDVeg1zv262qAaiQI6wOLu
	frgsJ9YRwVZKFw0wCWi8Vw5UHqile123TQ4Jwp+QDXrOF57S6gra+EInum6rW7gx
	pnR9gxL7Tn3l54eh6bm3o4MRRVn3DO11RHmYj9HTZ+7iTlLFsBrDTGrUISaF3Ydz
	lgPv3A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy5brc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 20:29:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-267fa90a2fbso14814175ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 13:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140989; x=1758745789;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEM1lJMKa2QVcYthJ1BIIXMBnRFN8LfFqYTZtb21724=;
        b=vmI+AjOPWkNQvleWJRH6j5s3Ep8pBsgZ/+QQyPhccgGp6jtNzwCZrY+MZEn1teAPla
         egECK5QXjrw+PK7o8Vt1wvnDS3YdWl5veb32HUDqaj6EIyd7lWUE92cCx+7Rs/uD7vcK
         CpfipTNd4bcbqXyS232V4neQUXkMcfFOLsbI8M7yEGIEK/N/l379XKWVDifX3aa4QDm3
         Zy7vioMQl+6TTQa+66uGlIM9Z7H4fLs07f5yRn/02vcRgEQXuJ2RFG3upoDcHckqL7ly
         JhL/nM1BS9bPE/dF4a/yFKCySKDU91dLYoWVh7fjSh44kIOrkfyCqxe7RmhXp4+TqcFt
         u+zw==
X-Forwarded-Encrypted: i=1; AJvYcCU013KOspCTbG/deYyQgMsbGshxzMRxV/cPfyY5y4r/OpzBNz+excoXN2AqjKOuBP+HtQU2bNj8w65H1OVASw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGx7VUEjM4d5RQIkItKsWDSWFbVOwfzo24tvgopp6bTZSo7CfR
	mwBtTfIbTH2dnj1VZv6BM2wINyPN/cBeaSivTHqVt76Iv6/vshFU61RkgvipwgzE/ospUMNN1jB
	nQ4vJWjl0Xu9EzaAyIMXnRk46PI14Z2ifJ11HthCN++iCbZWGP0LxWU3imsxMC2jESj+jXQ==
X-Gm-Gg: ASbGncshzvbB8VbNPYpct7Tgho5XZ/GXbI7b5IUUuRsiDX9zNS8gu13smft7ZVh6NgT
	bwWxpIdnfQUQj1Ah6Xb0q8WbCjMBgeSkAoN+LN1ZeRdzdeaMxGRzQ+/B80+60rY8YVWAOdJ5Xfi
	99bnC+mGeDADcl3IoJhsbK6J7ty/qeu/d4A0jvw1Eda0tSBA4csqHrZQAAcfNQrV0qfJk6s0K77
	zr3GJMsZ4+1z4vXlvDPwQk/1q/e7qJkJJfWVWKa3CVcTUj+pVgavwDTmpO6HbEQd98jYhEDaxnf
	LveXkd+1Ri1EfUOt4M3sVudcpF+bJlZLxFy+6UlejQtxvYSVqqU1knNZo4fwMr4+Za3xUzRLESE
	eRGjc9mc/4FHBHzrQwj7fQkH9GdKRgarZmHwy
X-Received: by 2002:a17:903:11d1:b0:266:3f63:3500 with SMTP id d9443c01a7336-2697c829fd7mr9913405ad.12.1758140989446;
        Wed, 17 Sep 2025 13:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoM/05y1CwkSSQcd6Pm0FZF2zcDhD38jOzV9/eRqaD0ZUm8ijYqgE/YnLUSCVJPnWy0wFC1w==
X-Received: by 2002:a17:903:11d1:b0:266:3f63:3500 with SMTP id d9443c01a7336-2697c829fd7mr9913175ad.12.1758140988955;
        Wed, 17 Sep 2025 13:29:48 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802fe08bsm4163555ad.103.2025.09.17.13.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 13:29:48 -0700 (PDT)
Message-ID: <b2efb1f2-df89-4c88-8f97-e164e89c7532@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 13:29:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Remove redundant semicolons
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jeff Johnson
 <jjohnson@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <linux-wireless@vger.kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250812075259.6921-1-liaoyuanhong@vivo.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250812075259.6921-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cEew1Re-QI06H9crttKfNeJhbvd9BeiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5dgpQCgEMy6x
 GYEY4OXxXPP4s21IUsYSZQtdZ73SnL9Wj0lnpFeaGomdkpLKSh/byFguq3lXtwK2zbU3Ip7MW//
 lcLEfpC67mx6Vp3Zl2spUld+kohOalJZUsIkvv5WqULru8UW1PAgZwIbkH7p4i1hYEZBZbKhwTA
 S89evt7RuxU/jybZldhD3mTRHbeil+yA9kSR7V3CeRToRArpUHD4fIB52DOkqU+GacXIPM+1Awp
 U/mVAihwCeo1Y57RsF/m1OfHQhOi7Iie33mVLl5SImi4O5lxojJed1yxTo3ThjM7UUchdtYQHv5
 MARs9yZEkNGwC7FkoVru1I7CrrnqjOCzIvG2x+M44AL/lec5EyXLrUtwMQQj7kT2SwpyJd+GHdp
 KaaljFBK
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=68cb1a3e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=1WtWmnkvAAAA:8 a=mgvM1FoPK4XduYGJcSIA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: cEew1Re-QI06H9crttKfNeJhbvd9BeiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 8/12/2025 12:52 AM, Liao Yuanhong wrote:
> Remove unnecessary semicolons.

There is only one so s/semicolons/semicolon/ here and in subject

> 
> Fixes: d5c65159f2895 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")

Drop this since this isn't a bug fix that needs to be backported

> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index ffc7482c77b6..b9e976ddcbbf 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -4615,7 +4615,6 @@ static void ath11k_hal_rx_msdu_list_get(struct ath11k *ar,
>  			      msdu_details[i].buf_addr_info.info0) == 0) {
>  			msdu_desc_info = &msdu_details[i - 1].rx_msdu_info;
>  			msdu_desc_info->info0 |= last;
> -			;
>  			break;
>  		}
>  		msdu_desc_info = &msdu_details[i].rx_msdu_info;
No need to repost -- I'll incorporate these changes when I process the patch.

/jeff

