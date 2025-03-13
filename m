Return-Path: <linux-wireless+bounces-20359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94044A6064C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 01:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B62519C431E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 00:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703D41F9423;
	Fri, 14 Mar 2025 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R0Gn5KLt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5EB1F9A89
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910408; cv=none; b=e8a25D2/eiBKEoBZwwRLumS86VGp2Yq1Mpq3CGSfkR6WefnevIcUusOleG0MgkkER1ibzHS9TPsDrxM9XGoma2BxBKQxlnMJ0B0PYhAXcHU4vPF+2w4H57FNQyFKJOn9lDsGLVMKmp2PHcTlMHkPB8ipbhuoWv4EeFemLDcicu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910408; c=relaxed/simple;
	bh=I/5te5WVcFa1ErJWMjq03k1PPU/dZQOfYg/5hMm0IFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCi9KepLZN3N4QxDrk8ItOfF48tAmAK4uoFzHFQOFVkw0WnIwQqE2V80ix9Sz7bIXC39NWKw/yVWlDKc97PVKRAK+1hXjw4TNL/oc2b6OIb4hlYhjDKYmffcjfcJjNuS25Q9KpUPIDGQXwcVwJJQD77dT+Zlccg29RwDn9gJUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R0Gn5KLt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DMYbsO008921
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 00:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3rxV0cUwI7tUT4iN/+BoAqbkfW6S2hEbm1jFGV0H1G8=; b=R0Gn5KLtOFZtRQO6
	JN84i2Y7t3UR4y76BU3GoEt4IDZ2yYdPUc2xoWpiIo4iODDDf+9Cb9FCgFgrpm0v
	g6nUErt3WXiNh2TtEQW4UsLSCzP0ie66e03i9l3X2MN9mDpB35f8ccMr3c8g4jMa
	Su4t/VltrvQ2xSgrTAEn/XAXUNs+APnUCt7H6T8wORErUFVhn8oAKrvXlKgQz1aI
	gBItk1ZjRWkOsgKCPMfspwioheLm03n/XrJxVrOIg9VM39w+bsHn0l6Czl4So6vD
	EsvXR9Pg4iHHg3TrFcVagQ7F5FMkObU/3hKcX9pUJatXyFuZ/XrF8Vhs8Lqu9dnz
	HUT8Sg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2rffwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 00:00:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2233b764fc8so26686765ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 17:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741910399; x=1742515199;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rxV0cUwI7tUT4iN/+BoAqbkfW6S2hEbm1jFGV0H1G8=;
        b=jZuvmVlxkiS6mhq2R8SWvdOO96yxsAGAA6wIvAP/ejvdoSqn9r9Crv4CAeJ+RzP6ky
         5BS/ebQjyLmLaP+WBfMDYOFsscl0tYc8U3jxqfuoCIonRlygSa6+MOSysh3SHSBT753t
         vUNUwNRpYw3FDi/hdwfquDmYrKzVF+MpY6jY8u9ihfqAwFEKeJWoB//5lHKfOD4Ssct9
         xOQSQBrHdK0FzHrbda6NaOsmBxeYZmr73WxJsPSObQq/aO0o7y09d7TrXlbr6OIDNn89
         jzr5qrp3OrtEBo88KwR+ExAqXhKbJKbd9NhIqNkXQtzDMiBHu4jlUCTMBwJmFdWhzlT8
         NLHw==
X-Forwarded-Encrypted: i=1; AJvYcCVOtDrf3p03rlv6WpTB4DYaZ4KnbJiyugmmhb1kjiFToAHBOzztE0xZzKXt4Jr1Y3lWvt0raTAjH1RD2o02Iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfuU9grWbQw4ywCLorJk1FtujJzNNdqQhfnoLVncyncWzHO7ug
	6UsJFN3uDewo9uR/TUnWo/HHlXdMtRzI8KH0qN2aI1QymfvQJRKwwPjm/FIoeB7+8GsnEy6r+Hz
	etAbqNDrpGaT5xoBiH706FwiM8nRvQsyHrf/xCFLcLYtNI+teLvO9a6RZ0+HmJ6TZVw==
X-Gm-Gg: ASbGncskGQWWnnWZwcdcvARnDHFJ6ZPj5/gpNmgunPztQDJ67gGTvVjBNPr6VcGaAts
	lgT7xu7rBkVIW3O8N2zIS6zahxUr8H/FGSo32RG1DQNv8y/G+oSzjaL9irhPt06fLtmdHzoHVMX
	rIWjrCzQLteyS6vtoFWBAflRM7gPqdbiuep/F3x+M75LZR49nwj1RRfOk6594GdaZMb9uuyiqgJ
	82XBx1f5rP+nwK9sNtYq1+Wxl3ulF5gMR7lLQ1Y41qHbj9IKLe0HFeFRH1Mrx3OFJM5U+suqmue
	wsAxzXbLeDh5LFPBAiCLpPkZfwxJ+WhU4eLfRpZxB1BCGCSzcPg91vPWjLOh6yPXn0rmOuafqBy
	6r1EDDqRt
X-Received: by 2002:a17:902:c949:b0:223:5945:ffd5 with SMTP id d9443c01a7336-225e0af042bmr5385765ad.32.1741910399418;
        Thu, 13 Mar 2025 16:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd5eusBp3XBT8vjASGqycG29XNPxwKAB6RDbi/shunpuWjDgRorClqQWRNNcSZI3+K1imp2g==
X-Received: by 2002:a17:902:c949:b0:223:5945:ffd5 with SMTP id d9443c01a7336-225e0af042bmr5385505ad.32.1741910398936;
        Thu, 13 Mar 2025 16:59:58 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4219sm19483005ad.57.2025.03.13.16.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 16:59:58 -0700 (PDT)
Message-ID: <17e98c93-77a4-4caa-9378-bfa22b077f3a@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 16:59:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v9 13/13] wifi: ath12k: enable ath12k AHB support
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20250305185501.2400888-1-quic_rajkbhag@quicinc.com>
 <20250305185501.2400888-14-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250305185501.2400888-14-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D6NHKuRj c=1 sm=1 tr=0 ts=67d37180 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EFA6Gn_6DS6O034KAtkA:9 a=QEXdDO2ut3YA:10
 a=McEyGMjRs-CLr1QD_1hQ:22 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: hONxfRUqtk4af48ougmrlu2YYZabJIto
X-Proofpoint-ORIG-GUID: hONxfRUqtk4af48ougmrlu2YYZabJIto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_10,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130182

On 3/5/2025 10:55 AM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Currently only PCI devices are supported in Ath12k driver. Refactor
> Ath12k module_init and module_exit to include Ath12k AHB support.
> 
> Add Ath12k AHB support in Kconfig with dependency on Remoteproc
> driver. Ath12k AHB support relies on remoteproc driver for firmware
> download, power up/down etc.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/Kconfig  |  6 ++++
>  drivers/net/wireless/ath/ath12k/Makefile |  1 +
>  drivers/net/wireless/ath/ath12k/ahb.h    | 11 ++++++++
>  drivers/net/wireless/ath/ath12k/core.c   | 35 ++++++++++++++++++++++--
>  drivers/net/wireless/ath/ath12k/pci.c    | 10 ++-----
>  drivers/net/wireless/ath/ath12k/pci.h    |  4 ++-
>  6 files changed, 55 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
> index 52a1bb19e3da..b2bfcaca00b3 100644
> --- a/drivers/net/wireless/ath/ath12k/Kconfig
> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
> @@ -15,6 +15,12 @@ config ATH12K
>  
>  	  If you choose to build a module, it'll be called ath12k.
>  
> +config ATH12K_AHB
> +	bool "QTI ath12k AHB support"
> +	depends on ATH12K && REMOTEPROC && QCOM_Q6V5_WCSS_SEC

Just to state publicly what I said to you privately, I cannot accept this
series since I cannot enable the feature, even to do a sanity build, since the
patchset that introduces QCOM_Q6V5_WCSS_SEC is not yet accepted.

So moving this to deferred in patchwork. Let me know when QCOM_Q6V5_WCSS_SEC
is accepted.

/jeff

