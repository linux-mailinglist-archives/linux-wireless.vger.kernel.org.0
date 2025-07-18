Return-Path: <linux-wireless+bounces-25668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73304B0A829
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 18:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27565A144A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2953F2E62AB;
	Fri, 18 Jul 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MMJk15T+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B992E611F
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855087; cv=none; b=FX1BvPRJi+Bcy+BEqkqpgB4zu6etfj0qsFJPiLXOF+3AIO+dG59ZM8FHKNLdXBGEaYrVwdZNqte+TdYrz1Ynq/dyxqtYLiCjxAsyfkbHBzXs9EDoJdeK/GU96sXm5jwrpb7GXDPqaTrLkRw15EM4JDi9ZRtZSuybpAGK5ns/6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855087; c=relaxed/simple;
	bh=siPkPZS1jwuV52DiOoGtoxvBbIthDBOqVSMRGYKeUjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3uZ9IHFBG++XvDewkh6ZKAswR8jEbU91vGA3ysfzni/ikeXRsQInBpRcBirqNH2I+fSn74gZu2C07IowzZzorI2ebUkjkkC5lTeWRzQQmyGXJ3YDxGxmX4i8qnmAobrUpUbU11rhyarfACRuqaJC/bJyQaEKo9ze/YtswjU8yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MMJk15T+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I82ghM028129
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 16:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/yh0gYO/fyXW+8lHXO7cK/ry70PjDM7Fy75uaOFuFZw=; b=MMJk15T+P+ORY+m4
	9gvnQxlPfKBWL/a7kicjMN8qRhaBDnlCUizNIAUrNT9vpfwkxj4bVBgvC//PLvIM
	iqhz4jlGGedRycuVI0bEdpXwI2tKs2ySPAZclKXoX7OgotuIuWzyV1Lm5PmVibti
	rh6SykQBBt1hND8TyOINvso9B8Li3oTR9OeXJP3FlGl5yf4K39jGxg9Zqu74g9La
	K2CrrwxtU8BVb55XdsY0zHjUTjCCwAEVU0eD5bc8YGFXpk1X71mUyTrHmPDnKo+d
	ZofL4j7AGOrkwdQn1WsJ0sV4focyOptL8yI/XvJoR5H6B2pZelt3dCP4kBGnrQCT
	49okSw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh64esr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 16:11:24 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74927be2ec0so2803695b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 09:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855083; x=1753459883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yh0gYO/fyXW+8lHXO7cK/ry70PjDM7Fy75uaOFuFZw=;
        b=FmZK8Q3ElB09omN/9yzcU+hniOeByaIeRC7rOJSgpTdGX1+NTZBcMkG+oumdqh/VXe
         9FC2mZTlnUzyxTvvdkDSh07nrRLN+pbqJRULwZUfQCNAcGxlVWyRWEiKupblHbSeq+QN
         zkB0u0kGYfKPGPsoBSmbN63LBcVuzMUsZkpEaWqixBSfx8IhH1diuxxwrFBf9iyhyNOm
         hNT9PONaMvFbjtE35pv3aKjRHbw/Qo4o7+yuPitJYUUs69t0NMUtz5uo07wco102p8MY
         YhIPBKzKu5o966Jgrd4pJ3aWhQ7iXWlmL/tKEma4qW1QNt3iPWnC+j82LTP3llRlhwgY
         tiOg==
X-Gm-Message-State: AOJu0YwHtKGkoEI4HAUFyKe7lLnGdjFAixieRmEtFBEW7Frlj46kVU5L
	8F43XPCYsWecyoacX/0AhQnsCarMZQ4mddoNNwOsKRbwCrSnBJF75glaG6tfITMOR7EKY9RubQA
	e38/z6zPn0UUXDzlrFMWei2aux8AoONPG7Gm98Qq1qbdcAZZV/FX2avLGOO+XjQzfHsNLzA==
X-Gm-Gg: ASbGncvlox6OMS9KsfMWSZ8v0dU3Y2A7zhtBrxQQLQVBY8gZEH60YTKkXMCYPmmkK2K
	hrXMBg/roDJwu3TLdwobr1jl0fue5Z50ZncQ8OBTIio0R/VWJue3hd5QRi+RvEFzxKyU6Y6UUB8
	IIVKUBF+RQ2VzXIsVu+V4QylCkgfs/woKcgubSBuAuHwSsMAaUEwMR2NBM7ZgbFwItwIqOWuj7p
	PDpJ1fNjOwk6eLcUllZdTXCm47y0UwUW3DzB35q0JIID728AB3DMiHkV4+FHKme3/ciZk2Rl0Q9
	JTdDbzTOJn5FnuFUwSEgIjGF7sCRuu5LhBBXRE5aneD1hRznu4qACnEEv7U1tlZdsN0Z7ZY1LDr
	eVOVFdfszlflJ
X-Received: by 2002:a05:6a21:33aa:b0:220:8ce7:d6b8 with SMTP id adf61e73a8af0-23813764a2fmr19137516637.37.1752855083515;
        Fri, 18 Jul 2025 09:11:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmXTvgcSZDj426oraVut1Ek6ZJdA4/CWhZ+n/mZw+J85k6n+n2IXVsGC/8zZ0DxyAVfSfg7w==
X-Received: by 2002:a05:6a21:33aa:b0:220:8ce7:d6b8 with SMTP id adf61e73a8af0-23813764a2fmr19137477637.37.1752855083130;
        Fri, 18 Jul 2025 09:11:23 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.211.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2444sm1503913b3a.25.2025.07.18.09.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:11:22 -0700 (PDT)
Message-ID: <62660c3c-30c9-8635-b5b8-3972b723610e@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 21:41:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2 0/3] wifi: ath12k: Add 802.11 encap/decap
 offload support
Content-Language: en-US
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=687a722c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=rmBo/+S5hedwIG+s4KM8eg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=hQefTeRL-RgvZKPZHv8A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: CA6sQrz0pskDWQ1uRAVod3EnhShRWE9h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyNiBTYWx0ZWRfX/DSFxPF2NyA3
 gePchGxsMRH1TuwzIaICj3IPlBIqtRd+LLeNy+c0QRtdm9SM93xLhvLpkitFUf8rbG27KWn1AB6
 HRgXGMaQXQXaZc1quZ8NC9q8oRSHBVJ+Lb0Lzok6VuvK9nQ9znan4d1Xw5wI4j98JxOzk6xm+kp
 48EzZ4RuSJxGDvSEwM7O+ABXkSMdFVcOfISsBvy4Z0GuEOCMutbhoET4T0nzkvIT+9oWTCKmGte
 3j8gwTay1Pi9BP39h2E6mhQebZ2O0fm+5JKblso2ofRyLjKvYkVIm7VrvU+bnJ/3Dp+m0wECEUr
 y05vUiAZ4u+ZCIVAz/0vMvI0R0qMcPMRNGOqbwhTRuDFjHBLlO46/oUIO+NlszAfwvMofp1OjSO
 QEf5oBbeimYXEWF4oILk96RR/sy8GCzrKGxCQpdu11o7WXZ4yMrWBsuSTyN4m1PktBF7QN1X
X-Proofpoint-ORIG-GUID: CA6sQrz0pskDWQ1uRAVod3EnhShRWE9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=932 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180126



On 7/18/2025 8:25 AM, Nithyanantham Paramasivam wrote:
> Currently, the mac80211 layer handles construction and parsing
> of 802.11 headers during packet transmission and reception.
> Offloading encapsulation and decapsulation to hardware can
> significantly enhance performance. This can be achieved by
> having the driver advertise hardware support to mac80211 to
> bypass 802.11 header processing
> 
> v1 -> v2:
> - Rebased on ToT
> - Firmware service bit check added for EAPOL ETH offload support
> - skb free handled in tx completion station negetive case
> 
> Nithyanantham Paramasivam (3):
>    wifi: ath12k: Fix the handling of TX packets in Ethernet mode
>    wifi: ath12k: Fix TX status reporting to mac80211 when offload is
>      enabled
>    wifi: ath12k: Advertise encapsulation/decapsulation offload support to
>      mac80211
> 
>   drivers/net/wireless/ath/ath12k/dp_tx.c | 102 +++++++++++++++++++++---
>   drivers/net/wireless/ath/ath12k/mac.c   |   6 ++
>   drivers/net/wireless/ath/ath12k/wmi.h   |   1 +
>   3 files changed, 98 insertions(+), 11 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

