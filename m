Return-Path: <linux-wireless+bounces-18070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C08A20C50
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 15:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0518F3A6937
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C06A1C878E;
	Tue, 28 Jan 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RQ8yi2Zt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8A41B0413
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738075806; cv=none; b=RCjBDIIW0gQWpMHgQNLaZFI22gPLnUZLLUE6ZYYV7Dqttw+7E27bSmwZaGKWTn9REjv993/dTA+5mj0AVqHsYsClYb41z88WvvoYEBlbMdQ070qEDYDfdkSEgqFWvsf9M6TGxIAihxPfRKfOxm6lNi1vy1Zd3yALj7VO9s9nE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738075806; c=relaxed/simple;
	bh=yN/7tYntALaDnr/PrrVqyeb/xsCgQS8+qjejjh7wO0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OvpL/94U0aJpcyc7pQeyEb3yUq01QYJIaAtuTYQQxUlcLQ0X0Viw6wdCXoMlcKk/d2szdsPKaZV5doTOZma6ZT9iS/7YNVFkrWmgpqao1dAm6MiDJUalEp7XpV1ZSyNKgFZKyjsL6xSs4kR8foXcouFHwD1cM0JZc3b/QVYu0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RQ8yi2Zt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S9lpho019133
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 14:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kg7KgCeFkHFpNSsYE8u5hk8iLj7p7GoJw/mPLS3+mtw=; b=RQ8yi2ZtF+mIzT3p
	lzZB+egjQsUII91eV7gnTX58yJZt45Vnje9DK8cVEZsUyTu1zShS1q23a8vRifPH
	98Bcmy0qn8rIa6Yv3zw1jWrewM0Yep8v6rq6geLOHcxYvY2RsAKQ/6WMQp83VXWG
	yhYMF0++ubId0P1NiFfR9Ze9JeiiVng9Z86FPr/pd/8mes6YkeZ+yGPd8XojT25Y
	vP/Riu0dLkDE0Y24sugRZEBKOIl350F/KI1oa3aJdqbPPpXZlcU3UBsGIFKvZJy4
	5BtuzXjaUzUm9t2sA7tBhDgF1llyg1rpYR7KvmKAO4f5fDgsIXf5+vXb0iL2Jqqc
	HA4koA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44evwugpmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 14:50:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2163c2f32fdso178516195ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 06:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738075803; x=1738680603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg7KgCeFkHFpNSsYE8u5hk8iLj7p7GoJw/mPLS3+mtw=;
        b=toiojlC6XLsSV68Bv9ZAkv5TUi9+f5HscAoSFVGXOYuCkN5jA+vYDmTDM/XFcfsyth
         je+kpYB041fEif0LUpe2QccvCxN+RYTbs3gCf9kntU7ejFJcTwTLgqUVhq/fHFUEuCSo
         dE8xr7FpwNNU/xlOLViOxHOkVs23KZekB4qbCyYHkrzlc4/vvyMNsIqpYlwnOcU2Kh5h
         KxOU9BQSirPGKizpokc0/YomRKm0joBzklVB1WbKNCDVvnUjl1FdSf+6nZF3kIfl7WdM
         3dUsqVJ+zEBcayO0PfZ658A75nzhQT4dh3g7INPBz2S5MRqReGF+AcKYzq+IHTte3gLL
         c+HA==
X-Gm-Message-State: AOJu0YxA8Hh0/ic9TBrCLGErQN6yCsCDGpRpW9rZ9qCqsH9tHg+mERJ2
	5rFXPIZsyAQ20z09hV7eKh2ysaGtaVoVSkmq16+ELnTKVc1l0P/5B3wE2XLVNS+TgOUJ/B/sOR2
	Cosc/KAjKdyoBm5Jrn7+BnepPKX3KdnFrnfHJWUL0/0HVfbLfzDrjlgqLg97DB1iNOA==
X-Gm-Gg: ASbGncumyKA0hiIMHzsykktnzezgMRVpNCesNUIA5u1V1LeQYAZyD3aXmKUQ3WCT7+b
	KjPeVFigMCKR3jZxqJ9y2R9pU0UKEyOOdi12Ud2pL765kWviR/owzShFAVatfLbTeDmoaOESVv9
	GHExRg42F9VcOJbbWU27cD9RuNe9JgEArqeFbyIBcolmn7CC6clPP9+VTwPcYlrU5wg6lHI9a5s
	a99b5iIEZxUKODwRUE3HkN0Ml5QkNKYM8hVgOHdDxAQuGsxvXR9ivSPnMubT//M8Ric8ePWqJzd
	CuPd5k1rXV6soYbk+IWuzHQciSqSPPWpstsaH9ULMQ==
X-Received: by 2002:a17:902:c94d:b0:216:3e87:c9fc with SMTP id d9443c01a7336-21c353ef5damr753457165ad.5.1738075803138;
        Tue, 28 Jan 2025 06:50:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8jXYTfjcUCXFjJG6lpWbPt8PeB6TXSFVj8bhXCi5auL8mxkEEOnalCqSS8TNNFiC16do/Lg==
X-Received: by 2002:a17:902:c94d:b0:216:3e87:c9fc with SMTP id d9443c01a7336-21c353ef5damr753456905ad.5.1738075802786;
        Tue, 28 Jan 2025 06:50:02 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e30dsm82406075ad.199.2025.01.28.06.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 06:50:02 -0800 (PST)
Message-ID: <1fc5e70e-12a7-4a4e-9d0b-3fc25f5151cd@oss.qualcomm.com>
Date: Tue, 28 Jan 2025 20:19:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] wifi: ath12k: Add Support to Parse TPC Event from
 Firmware
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
References: <20250128111059.1690113-1-quic_rdevanat@quicinc.com>
 <20250128111059.1690113-2-quic_rdevanat@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250128111059.1690113-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aDgPRhG59O3qw_lt-eUODKFQ0HlhD771
X-Proofpoint-ORIG-GUID: aDgPRhG59O3qw_lt-eUODKFQ0HlhD771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280110

On 1/28/25 16:40, Roopni Devanathan wrote:
> From: Sowmiya Sree Elavalagan<quic_ssreeela@quicinc.com>
> 
> Host receives four Transmit Power Control(TPC) events from firmware on
> sending TPC request. Fixed param TLV is present as part of all event to
> indicate the event count and end of event. TPC config parameters along
> with regulatory power array comes as first event. Rates array comes as
> second and third event as it cannot be packed in single event.
> Conformance Test Limit (CTL) power array comes as the fourth event.
> Firmware packs different sets of array params which includes array
> length and type inside master TLV as different subtlvs. And the actual
> content of array is packed one after the other inside a separate TLV as
> single buffer.
> 
> Parse various events and save it in local structures. Create tpc_stats
> file using debugfs to store these local structures. Create function to
> handle TPC stats read to relay the information to the user.
> 
> Command usage:
> cat > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/tpc_stats
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan<quic_ssreeela@quicinc.com>
> Co-developed-by: Ramya Gnanasekar<quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar<quic_rgnanase@quicinc.com>
> Co-developed-by: Roopni Devanathan<quic_rdevanat@quicinc.com>
> Signed-off-by: Roopni Devanathan<quic_rdevanat@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

-- 
Aditya

