Return-Path: <linux-wireless+bounces-18346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E348A26AD5
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B7E77A12A8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 03:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B3A41A8F;
	Tue,  4 Feb 2025 03:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="irpHrLOm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF743232
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641111; cv=none; b=l32j6X+3ktqtu24Pv6UVJJlFN2KN+Yzex8kjF0DWnxT80IVCHuOsMjvjcst2a9lRbz5YMDVT96XnqvpltDluQelHX3LxFVlnbb4qV/5p9OA/CYN7Gh9U8q50rU0FSuGBiMNq95VRkR/ldoI5svvijYdXprQ3rtFjdMBQyKmVIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641111; c=relaxed/simple;
	bh=tzBLclfntbFQJR8PgOKavncmBL8lZSI2hrNRsPNhbO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHPZltD5fP5W8n9f064NTjmb0PneMpHbtm/L/1gWakAOyO2eJm1HQbygtZSA3a3ooCfEp6uKCQnqqsL1gp04PGgwBZPbrsKTLxe1Ri0NtljGQhC15qV0PmT7uMN4iZxyicCJKRmyjOr9vjNT8GA3Qsr8qnn6qP1OjUFL8fH/n/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=irpHrLOm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQfJG026948
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 03:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xljIf5LIELKjNsgQouAtJzQ958nVy1Um3h1N0CSDuKI=; b=irpHrLOmcpx9YFiX
	PquvN/0mnU3BCpB11oc4Qv9UfNvOYAyNoaXDzJZJDALhDZXKoIa3sZ9FhuOZBuDG
	xkbr8jogPZU/KvbVJdnK5hOkQEVa2arpbjLJghDHxSYUUHuRIGdKJRsA6/VBB/5R
	45DBzFyTILyAiWf61J2zxesNKIS41d0NvzSXPr2+/LWpSqHVtx5QgEW85IWTCWYP
	bPDfiThDrsxTv0/JO3mCfBh/jXYbnIcvDWbekDlaFicUv6F4gUV6LumZSrt1sOVn
	0zM06S+OOsVefZ9W8AGMrHySXAe4JKrkXo59gSDT3Yl74bh81DlEmoA+Glcr09kT
	qqED4A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k4ufrrhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 03:51:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2162259a5dcso179546485ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 19:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738641108; x=1739245908;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xljIf5LIELKjNsgQouAtJzQ958nVy1Um3h1N0CSDuKI=;
        b=YDpNQ6L1L1LSk0QttCHMAEJteSDTs22AM2ipj7Za+4OeHsiMBrCw8/ifHd2+j3Uzhp
         UqQiAZjZZL6ZhZqHFM7LeKbCWy5Lmj5ypz0tcCat54pPEEN4G03xBA51b65JRaM0je4M
         lg0XTjobj5bOPVXqVzqRda+0VNzVQ7WF2RelN/uxIh2aKArzHymirzjknrR+izXezRSb
         SdT9prpxmecEtgHGZZs5TQZQSYn4+HiM5kbvrydKu7qm8839G4+VrNgOZIQQn1MiO6Fc
         lRKyyDf59PCKhhYkvjHiVm8f/ML4KHAUhcW/rrF2kLM6L3UkD2m/6zB67BChD3/+cze+
         +f4Q==
X-Gm-Message-State: AOJu0YyzCweCBupyIslkEZw1PzVx/JFvFfh0H8BlbbOO7wk3o7Z5PJtm
	ok4lX2+sA5C2qjwYvT9rhyms8qmob3h+fqbOHd+wEKDJowC3+4tt1sCWdh98y+HR3KNWrsZEqUH
	C1LAoow0Xn4MSa9yV3N2MBHKOfWExnS99H1dfLzMv9uEZ9ghi9CpAQ8MdI0pbz05jWg==
X-Gm-Gg: ASbGncvCdTsr0wQRM3jz8RxuCJl5viTDXJLE2L18Ce2PMkZ+HDdbACXB6/vTenuMPSI
	b9zbKpBAxIXEqavdlJntv86F9UTd+OMp9oNHt8svkC0EWtEt5XXGyNoTU/GIs5pJSPa2jlmcD0N
	+Rr3ph0+1gKae9kK4Lldf33dNzd8FPpVHF7yrHvEoF+2IHjmos5ZCIxTH1DEpydkLZ+8wuwg3Ji
	XffF5nIVVuul69/UAmPP8eWonJ16nm+bayYsv2siW7NBC+ULwdI9E/SqkF0JwFAynRzGDhRq3IA
	m1nWCK7AtnjvhQXQTtaLxMb4iYJPgR8VOM7aMVs=
X-Received: by 2002:a05:6a20:9f45:b0:1e0:c50c:9842 with SMTP id adf61e73a8af0-1ed7a5d5389mr43603946637.31.1738641107984;
        Mon, 03 Feb 2025 19:51:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmdUVc0Wi9jxdVfRoEIvYyBtsi3glQt2raK360OuJpu7LbCgU1t2XAzalkIAtO1g7U9xNGjg==
X-Received: by 2002:a05:6a20:9f45:b0:1e0:c50c:9842 with SMTP id adf61e73a8af0-1ed7a5d5389mr43603893637.31.1738641107331;
        Mon, 03 Feb 2025 19:51:47 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631bed4sm9658304b3a.10.2025.02.03.19.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 19:51:47 -0800 (PST)
Message-ID: <f38c5c60-0e00-4b2d-bb47-1a86297fceb5@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 09:21:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] wifi: ath12k: Update HTT_TCL_METADATA version and
 bit mask definitions
To: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250203212647.2694566-1-quic_bmahalin@quicinc.com>
 <20250203212647.2694566-2-quic_bmahalin@quicinc.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250203212647.2694566-2-quic_bmahalin@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: x_p6L_qLlZ2orzRQasrgtC2cr7fZgHfo
X-Proofpoint-ORIG-GUID: x_p6L_qLlZ2orzRQasrgtC2cr7fZgHfo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040027

On 2/4/25 02:56, Balamurugan Mahalingam wrote:
> Update the HTT_TCL_METADATA version to the latest version (2)
> as the bit definitions have changed a little to support more
> features. This new version allows the host to submit a packet with
> more information to the firmware. Firmware uses this additional
> information to do special processing for certain frames.
> 
> All the firmware binaries available in upstream/public are compatible with
> this HTT version update.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Balamurugan Mahalingam<quic_bmahalin@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>


-- 
Aditya

