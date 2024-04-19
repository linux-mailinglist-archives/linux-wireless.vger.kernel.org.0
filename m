Return-Path: <linux-wireless+bounces-6564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D738AAB99
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 11:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BDA1C20F4F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF28A7BB1B;
	Fri, 19 Apr 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nLG/Mkbi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6B7C081
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519619; cv=none; b=HPjy8wMFCdKQH9lunEo+UPVU+YDmTskC1JfEGIFwfJlTka/51eMQyvSwmE6PISGeuo0Peo4frxh6mzuDuykWkX8SeKfjzh3KZvF4AAVQbiu+/Dl1jLAwRbn/JczMoQD8ajMknzy6llQpoFLbmJG8s9oxBMSFVWsfGyEF36qxCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519619; c=relaxed/simple;
	bh=hsAnVAm0tQHz3RHuf6hpGiQ9xHGePb+Q0VviHvuHLeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=rOcD1aRd+vG87DUG+YysP2aMJ1LQ81pqgdNgk5MDCayM0O61W9WIGY9wquEFCOAr2rp3GU1meBGAd/pChyT4O33aYah1Xj26qH0CiSCKvOyF27CyE5ie6BieH8sQH1eEB+h59LJPP8XR7UqhxXARkTsN4uN3S+xJtJDH8O504Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nLG/Mkbi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43J5e9ek026167;
	Fri, 19 Apr 2024 09:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from:cc
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fX2Zkoi/Q8jYaRe57Bx6SrWfONRDiLzDduR+kVRXZHY=; b=nL
	G/Mkbi2CKN9buLfQ0Ir9lzWoF8Litj+M7jCjuco7MouQ7sd42rqEKd3F3dfNioyB
	B1NMfedUrS1NyBR4bjhrIwQAWEQl72BOPy5wxVZ1JtIkWpzI/BfaB6fggdCEtY/c
	rjVCL9PEPu6bP11ZFN5o+P3FGjPbEmgqAYJcDsdVsZwsUHu/tVabF/H005NyQD3d
	Vkio7oL7wbVTrUKJ8GV8+w4qROda4QGwClDnxfmYzlmje2hjNi6LX+2q837sc2gl
	TaQFfr5zOSAK//ketKSZQ8hwJSt3bcFQ+715JUWaNfmUEjRH24hJuxhmG6ZuoT2y
	6jsEzn6KkyfDLCzVqJKA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk4vnt9r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 09:40:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43J9dZvK011434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 09:39:35 GMT
Received: from [10.110.91.89] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 02:39:34 -0700
Message-ID: <be016fbf-0198-4fe1-84f8-cfb0bf00dc4b@quicinc.com>
Date: Fri, 19 Apr 2024 17:39:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] wifi: ath12k: ACPI support
To: <ath12k@lists.infradead.org>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
References: <91cbda07-0b93-4e0b-adaa-cd9b078a91b8@quicinc.com>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <91cbda07-0b93-4e0b-adaa-cd9b078a91b8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VWvcZX25eGwhdAh1Rb4gG4HbwGeboxjb
X-Proofpoint-GUID: VWvcZX25eGwhdAh1Rb4gG4HbwGeboxjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_07,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=778
 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190072



On 2024/4/19 14:30, Lingbo Kong wrote:
>  > -------- Forwarded Message --------
>  > Subject: Re: [PATCH v8 0/4] wifi: ath12k: ACPI support
>  > Date: Fri, 19 Apr 2024 07:16:07 +0300
>  > From: Kalle Valo <kvalo@kernel.org>
>  > To: Jeff Johnson <quic_jjohnson@quicinc.com>
>  > CC: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
>  >
>  > Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>  >
>  > > On 4/18/2024 9:20 AM, Kalle Valo wrote:
>  > >
>  > >> From: Kalle Valo <quic_kvalo@quicinc.com>
>  > >>
>  > >> Through reading ACPI tables, implement Time-Average-SAR(TAS), BIOS
>  > >> SAR, configuration of CCA threshold and band edge channel power
>  > functionalities.
>  > >> This is enabled only on WCN7850.
>  > >>
>  > >> TODO:
>  > >>
>  > >> * test with ACPI support in hardware (I don't have such hardware),
>  > especially
>  > >>   suspend and hibernation
>  >
>  > [...]
>  >
>  > > I can verify this doesn't crash my system, but apparently my ACPI
>  > > doesn't have the underlying settings, so cannot verify actual
>  > > functionality
>  >
>  > Thanks for testing. I hope Lingbo has a device with proper ACPI 
> settings.
>  >
> 
> yes, I'll apply these patch then test it.
> 

Hi, kalle, i've applied this patchset, set ACPI correctly, then ACPI's 
functionality is right.

>  > > Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0:
>  > > acpi_evaluate_dsm() failed Apr 18 15:13:59 qca-HP-ZBook-14-G2 kernel:
>  > > ath12k_pci 0000:03:00.0: failed to get ACPI DSM data: -2 Apr 18
>  > > 15:13:59 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: acpi
>  > > failed: -2
>  >
>  > I just want to verify that these are debug messages, right? Normal users
>  > shouldn't see any ACPI errors if there are no ACPI settings in the 
> system.
>  >
> 
> Let me check it.
> 
> Best regards
> Lingbo Kong
> 

These messages belong to debug messages, normal users won't see any ACPI 
errors if there are no ACPI settings in the system.

>  > --
>  > https://patchwork.kernel.org/project/linux-wireless/list/
>  >
>  > 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpat
>  > ches
> 

