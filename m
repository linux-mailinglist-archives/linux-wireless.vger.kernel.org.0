Return-Path: <linux-wireless+bounces-30234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEF3CEBEEC
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 13:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B384B30080CA
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 12:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6392FD66D;
	Wed, 31 Dec 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cfge0or+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MUVcpUsd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506462DCF69
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183504; cv=none; b=Hug/8kUkqh/6k63OfS2tG/XOlRuVSXZOe/DfR2ce2z1TY++O1Fhsfn2u7FFGyon9b1iGIrGtjSaylgkQCpbwvh4vHfxKBfB4l/ddPyewyuA6dKsC+QxGEPZ1fbXkD1yb9X/JnR45zEDxBPH3pis2KSsPr9KjfZocTlumiRp4x9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183504; c=relaxed/simple;
	bh=vR25SYRzjiDlqhb74zWnpwbujse6EwlvQv4/tQfE+48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqkpZUFTKv3Q2mnSALFg+pq2SH1O6rOafYB1RBJ9r7F9CW4uCKOKblGcoI4+q99/MCSS0vA3UOga3UQB3k+qa2IuRd87NsdctkHYLkLULBxBZCL2DE6qxziH4vFd2IHGmfbMW9XRD42m7T7GmUlWv5xF7xaiqSbhjYVCYQ5sgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cfge0or+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MUVcpUsd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV78ZFp2733397
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IWPcobs6vfaZsrdB9wU8wUq6VCm4lbG0X06J5zTpzNA=; b=Cfge0or+FimIZ4ft
	ZoIjV+UUEVPWXYDwflBGfqx/ADLwjuqjmy/4pUXz3Z6OOVLH5Y1ruf1ePI+7x4iG
	pRctGSEw7CBbNBYDNtq6+6h57SIP7R3UWtOWY70q777FurXmKvMw4+Jrhf7pY1Pe
	WfKawEip+biCJpKDBF9/Lid9N8Lkp30j0fvUT/lJGTybiEyeHctmwrRryWyzAgg6
	O/Qr7FlRPitFUhNA9nyEzJ2FBAm0z/m0LUKHemdl6BEcyrpHgyLnF/jlfMkuC8D6
	C42F9WMkEVa9NqyScVZT7GLpeZFfpjkcVIyo0S56cECuPdPpYmtVReoLpDIU+Dht
	Ka8jBw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcy6aggjg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 12:18:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-890072346c2so16635216d6.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 04:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183502; x=1767788302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWPcobs6vfaZsrdB9wU8wUq6VCm4lbG0X06J5zTpzNA=;
        b=MUVcpUsdJAXVOQYX2HPwIvc3fP1shH3V1eQo2zmQWR8bACzyDYd+NJhHNXZG5cKatU
         L3+PHnTcr0pax6KcMnXDwymw/Pq0kMTYkfMSZaBoRO7g4ZsDHR8BUsZyNzUbBCbPeW29
         ab2Q6HWrugt5juBCgpVCYlk0NZkCER45vxl+IMzPOgp4WqwCGPTCxmDq+5SWhIEfVgY0
         Pa26NS9LRRYjWCkrpLF3OnWbL4pXRNHlhta3hRs+rwGNx+WPyDiiE6Mw4yAwpJmPRto+
         24GiGj3JFWx9jfnoTOeOjfTp34TVxomOjYUCG48eklHxAoOXU8Af1TxpcHkDfxgwO0L6
         /Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183502; x=1767788302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWPcobs6vfaZsrdB9wU8wUq6VCm4lbG0X06J5zTpzNA=;
        b=fqpukAM1Z0IDxDE6ljYqcflEsDa2u/+r8a2W7g/tkcfoNzNpkQH2vqgouXZ3YxzmJH
         k3nfsNQOveEp8gggJjeIkp0RV08u1HV4TfLJslZAVta5xC7jjo2M2cYwSK8iLvcs9cX+
         HxGHIn0E6Qzd7M82yMQ/hbNtHjcHR9sieNIXtjIi907AXd2vqR/72AQo0xWLpJjtAe3k
         SyeQ603NZ6zseeWSphG7Ifak808THWPqZsbjhvwAjc33p2fQZL9aSTSRwH/W5ug4SEgD
         28u5859d6HNPgkGM4Cc2fTjAdroJDcxcj8ILTFCBzoNBS6NPUrnHVzHrnRp2zJz1tMdl
         5uqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKGh7KhKCUkCGEz73iynxjCDSHBqW/C0NSObwgkWzPoJjrR6xxsevIGfZshD5afIsu2qw4RNgJRlscvC3krg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbtQPunsJ5oiK1fqOhbWm/uYQGiKELj3h1nqRxWCEUUiRIw8Wc
	B47l/HFYEWAyqRZzRdzM36jQKuCjPRf5aIXW248VMt1vy6ufBqHY44YR9qhW4h8dw9zm9hfkqkV
	0WDF4O5ZV8lGczdgwM9H20iBCrgHGm754F4Cc3rBou4BIupJNwqakRhANTKow84u11xtECg==
X-Gm-Gg: AY/fxX78YoNFffiYmwwpW7b0q9/xjCOpJ6Q8s2Gy9fQzOxS3miosD5r0mDFizIx1elH
	C4q/xOAITjO6LDIJGUGD30GtdavN7SgF2ogIR7YptHkeE6WqFQeef3GZlUtwt5awxMuKIIgvVAG
	onvxUicWOcgEM+wBt5OuvJqV+8BFDcwmX/UtMYHCO6SJj5mrjfKF3YJix9Zesfg1G2AUgpTpngY
	9uG6N6CREjABHBDrAMC5OuSXYXfVlwktSZmhrkWUgAGZ0dL4BUOZO5kQ4LRCyfcFO74w6AIHeUB
	0/FET64SO6hGU2zKlC0hB733MrG7FCSgMWBAJQDHhiv/pn8ZbcHIXMBUcG605o7qmWBa7maXBVE
	kGV6mJ88byNG8iWVLwh2ve7fHIlS6cNbwpzhqE45VLOZnVC1osXTyMkrhlQr05vFifQ==
X-Received: by 2002:a05:622a:cc:b0:4ee:1db1:a61d with SMTP id d75a77b69052e-4f4abcf3ba4mr419688741cf.3.1767183501899;
        Wed, 31 Dec 2025 04:18:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4xZ0NZV6OIB9S/tTaZX8Jwqb+5SJHZnAnR3CZjAFhy6aj42iDY49quAMU/SvRZ9mwZtROpg==
X-Received: by 2002:a05:622a:cc:b0:4ee:1db1:a61d with SMTP id d75a77b69052e-4f4abcf3ba4mr419688441cf.3.1767183501315;
        Wed, 31 Dec 2025 04:18:21 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494ce2sm37741474a12.17.2025.12.31.04.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:18:20 -0800 (PST)
Message-ID: <9c3cfc5b-a036-4f40-9121-5e00893f4301@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:18:16 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-11-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-11-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZOt7c7r5dmxN_VbfdyUeJ55FQZHOr5K1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwOCBTYWx0ZWRfX+BoY6l/7VHmB
 ORWIiyH/KZK+68P6k6fEBp7lz8Gr9Ty06i4TAhdLm7pkCFTL8Ka5UIshpIcbDEb2uBmQwjD2/zN
 SPVtoQRpMqsycJEXVd5kDOf6SiA1bLHOmZThS+MdFUujKOXWmUzqBAP6TvwaLO98jsek+YdPd1J
 pOd2RhLesfZiBYFJsjsbaqsN8vJqjT+gjc08MoE425SkVJ7nvctZAE8inS+QYnMVBm4L8QF9y0U
 8EX6586bN3K90TsKbbJXmx9h3JaZ38WYhpn7JfjR3x73OldWoKZy6VqieHLkmDpdR6kCXTbOwt4
 7KuHtunXJZ3d1upqQCkmUO5jWp+1EB2jIaL0iQmZmD2W+ljJl2hh9Xt+wdTK838fu+bMVtlEq6c
 kcp5lyiBnfeK+xky/A9k9tWeEpwMI8DrD1RS+oTC26NtJ9mWg+aQvEq7eJ37lNc1KDyot8HL7HL
 gOEA0SOicSeBcAM25wg==
X-Proofpoint-GUID: ZOt7c7r5dmxN_VbfdyUeJ55FQZHOr5K1
X-Authority-Analysis: v=2.4 cv=J9GnLQnS c=1 sm=1 tr=0 ts=6955148e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YN4nVyxdPvXl5XCbABQA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310108

On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> The onboard WiFi / BT device, WCN3988, has a simple on-chip PMU, which
> further spreads generated voltage. Describe the PMU in the device tree.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

