Return-Path: <linux-wireless+bounces-17333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D666A096DF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 17:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA46188E76B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6DE211285;
	Fri, 10 Jan 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="do5YoJG0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E02212B3F
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525570; cv=none; b=pW/dM4iZaMCfbZdhHhzB8mQ/C7CImiiPlRbrvji6Cbe8cwTclUGbEGvBt/fY5vHHbpWc0j/Pj/SzEVEwVfmNlJdC9w+RR/h8/kPImQCD1a5x+Pvkn/7mnf9N/yOvS4YQ/Jb4NsG+qimB9zlsProUCS1SUdTvORlrPUYsPXz+kCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525570; c=relaxed/simple;
	bh=1loWZ9bOXRZXLVQGK84Z2KM8wFElH6WRvEwiWBzFyXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I57jvleXlvUEWS5RjLc9FSTiB40tV9oiYZTotD4KjDJlPQNd+GujNGXy1l+Zu8ne/z/OvAemrWI2RNhI/SkQnppBSqVoMZ9W8NNpjnf/aSgKJ/Y6FOHiVCM7NAwlg+yJu0ppBbKGUmdlJqivdAo/oY9Sk0YZdUzaB6OcMNNwaS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=do5YoJG0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ACLdLL004169
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+iYWaWujGsKCPY8a2vLX77zbn5xn/LLvdTqPJX4SkPo=; b=do5YoJG0ClrGAI9L
	AvS7yxyPzZV7Uv3tYPPsU1iJqTcOFrHKglqmxFyRtiTK1Z4LlCwAhO5O1Ql+GQXL
	CvP1/aeFw/EN78mIrsUiUM5OY+rSH3GeanMAghK4XtdTaj9FoMHsLzFbH82ewYkq
	++Di64P0qQAmYiZzFYYX4B9khgINDEDFngRfUjtQ/NT4O73xXwpn04oCwT1vGS0M
	mR2X7wehZvlq8VsvtbE49tWRFAQTf3koK/fSN9TE24K5Yn1pc03MTZmwS4U0CPEJ
	7b2cLZmMjvBZyB/1UetvLvZdz8crb1CdwWrLj0tJQ/k3p4CdQ3TUpvKFOI5PCtr+
	Ix2Org==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4433g0rn55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 16:12:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216728b170cso43827725ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 08:12:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525567; x=1737130367;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+iYWaWujGsKCPY8a2vLX77zbn5xn/LLvdTqPJX4SkPo=;
        b=n/VL/oTtumZ08vWVUKxq4CuePpEL5x/d1CVPx0Qr4jpzmPqfuHc2gD3R4lmVaTVOsC
         Lic8kFo9NB/UaLHM2mssacV+qTTl5k2Z7hM23jvV+ob5LJPAlV89IDkLDGPuZ1frKbp2
         nYtPq3u29CRvF7QJcKGoznwt37ntrZSOwTTJOqwAyX6xmkrF9LgftgBXiErXWbTFHCRW
         yTCxf+kL7nNf3sJRnHDOaxEijhKVlc1ZqgKJZc2CBynDd40RrhD52YOIvhKWRU3tS7Pn
         kXlAT77BtI2GwGxTcQLoZQ843ckM2ReHP5uZmJkEirIosFzbLUC9ZUeUUptjjw0xrk9/
         6v3g==
X-Gm-Message-State: AOJu0Yz/IwCVwmsl+2QQ5EfygKHtaw8OkNpGBZ7cEO0pmXS4LnOS3gH5
	D4f164DZwUyUlKtEbp17i3yXXJZkY7c01QNPfbrxlk+4tRprwlEF2gATmCIzLL9yqjTWuDKKGyf
	yjMvAblG/GA7pzn9d0cGTrMC0hKXs9lyEzojNcB+QOHolj8C8+pxCvBE0YqbEQ77g0A==
X-Gm-Gg: ASbGncug3Q2kEbjyPE+qgikbb00+wKcyBylnHMabfD2tqEhsP1X+W4RggB7n3NRfW/h
	L0CulQ5100H3rY2IZR9vZ+el/hIiN1bRKFlaStjV+9wCqtwDba8NLS45uZzJjyxv16S4bY4jNoE
	n6vvH67UzH2EDtU61HW7s5Xewedcnqi4aXmiGb7eQLNeS2u0YzRH8dpzPdPf2IVSEzGKFBi+/MB
	PYqjK84grsWBAGK0iR0cqhL6htQFU9w4Hc/bhvNGqc36McuyKwDRzCBKsCm+KDHxBu43v4xjZ6H
	Sv0SLJ9FXdXmSuWUOMrqAjBtMKNNw0/8zul6U3tOaHMuRDPMKw==
X-Received: by 2002:a05:6a20:7fa5:b0:1e1:b014:aec9 with SMTP id adf61e73a8af0-1e88d2d4fe3mr18405310637.29.1736525566892;
        Fri, 10 Jan 2025 08:12:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSrjtUpxaxRefWDDN05bK5NgjTJ0bWRhlmpfeMG3efgDXx7X4xzN+YPAEVZbPmNF8ssj+i3A==
X-Received: by 2002:a05:6a20:7fa5:b0:1e1:b014:aec9 with SMTP id adf61e73a8af0-1e88d2d4fe3mr18405277637.29.1736525566460;
        Fri, 10 Jan 2025 08:12:46 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31de807786sm3034286a12.76.2025.01.10.08.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 08:12:46 -0800 (PST)
Message-ID: <8c756343-af71-4e8e-ae9f-6681159e90e9@oss.qualcomm.com>
Date: Fri, 10 Jan 2025 08:12:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] wifi: ath12k: Refactor ath12k_get_num_hw() helper
 function argument
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20241217035920.2683568-1-quic_periyasa@quicinc.com>
 <20241217035920.2683568-4-quic_periyasa@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241217035920.2683568-4-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AnRxDwIMKulr8Aw_kiGIxOTnoxGyBBoy
X-Proofpoint-ORIG-GUID: AnRxDwIMKulr8Aw_kiGIxOTnoxGyBBoy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501100127

On 12/16/2024 7:59 PM, Karthikeyan Periyasamy wrote:
> Currently, the ath12k_get_num_hw() helper function takes the device handle
> as an argument. Here, the number of hardware is retrieved from the group
> handle. Demanding the device handle from the caller is unnecessary since
> in some cases the group handle is already available. Therefore, change this
> helper function argument from the device handle to the group handle. This
> also fixes the below Smatch static checker warning.
> 
> Smatch warning:
> ath12k_mac_destroy() error: we previously assumed 'ab' could be null
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/ath12k/3e705de0-67d1-4437-97ff-4828d83ae2af@stanley.mountain/
> Closes: https://scan7.scan.coverity.com/#/project-view/52682/11354?selectedIssue=1602340
> Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---

...

> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 6b31e053d6da..f37a50f3eabb 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -1209,9 +1209,9 @@ static inline void ath12k_ag_set_ah(struct ath12k_hw_group *ag, int idx,
>  	ag->ah[idx] = ah;
>  }
>  
> -static inline int ath12k_get_num_hw(struct ath12k_base *ab)
> +static inline int ath12k_get_num_hw(struct ath12k_hw_group *ag)
>  {
> -	return ab->ag->num_hw;
> +	return ag->num_hw;

since there is no longer multiple indirection perhaps we should just get rid
of this and directly use ag->num_hw at all call sites, especially given that
there are already places that do this:

drivers/net/wireless/ath/ath12k/core.c: for (i = 0; i < ag->num_hw; i++) {
drivers/net/wireless/ath/ath12k/mac.c:  for (i = 0; i < ag->num_hw; i++) {
drivers/net/wireless/ath/ath12k/mac.c:  for (i = 0; i < ag->num_hw; i++) {

/jeff

