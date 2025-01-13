Return-Path: <linux-wireless+bounces-17408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EB6A0B258
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 10:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D7A167363
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957EE231A46;
	Mon, 13 Jan 2025 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W3eG+CxI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C546B5
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759190; cv=none; b=jkjUZPfbMQveNp7LV5827QaToEeqzZy8HynuYsU36U81jaxY7QcXQLjmGV/tBk4kJMbKYgcjoWkOiEv1NMbOoE0VGJmNAlzZ0O1nIKsRdhrzBeG1c6aDBaAXmKdwt+o/FQenllt0ouoRJgm6AmqfCGcNaBX2uWEEgcY5Kiew+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759190; c=relaxed/simple;
	bh=AbE3lEing9yLAYha9GAB2HZw+DijmsbxzI5xYVkKO64=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pln1pdlcR3u7mnP3ByWKtUYDrfZszWOOGapMeVqvpsMWmYIHk1U539y6e4cEc5Q5UJJWQQecruvFPmrQCPtacAwLn/JbrULNP+2li/gcrxlyPpaYklMgxiDW41d37Kxp8n7votrJ7rlr8qVl/CdmeD7YDAYlSAVf7toq2Wj/mCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W3eG+CxI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D5U1eB011889;
	Mon, 13 Jan 2025 09:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oP/6jxT+j3pmnNWgCpjYqwaAtqP2fxE+DnE3V/pCOi8=; b=W3eG+CxIHDoufzeU
	n06nc87aC7O4PBfUrvqiu4oC9RQLddX5Lp8SrmTQJwy5BKC1rahGG/y3JSDyEHgS
	x14Lmb5kIGrC5FhJRGePRetf5ztJrBNRA6h6/ruN2BpYgAWiCkcGJmlTqD/uw6pH
	jv8wfIUXsl98FYcaSF6fqf/rMEBflJ+UNG0DSZ3Eh+PDJyq6VuazdPbWbDWQ4DHv
	2FgVM+/Q0WG6qhtK1ylNwHLwDR69PSv+SidVHK46gf2oFz+qOXLWifrLsf6VRoLj
	fBuc7qDdBXCOLWfOzXYNh1Z4psP5xLJ8bD744ig6GkGOYlVtbLY3MsWDT68i92dC
	y5qPng==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444vqygg0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 09:06:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D96C6E024813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 09:06:12 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 Jan
 2025 01:06:10 -0800
Message-ID: <4dadf825-0b9b-4109-a8a4-9eecc9f1dd5c@quicinc.com>
Date: Mon, 13 Jan 2025 14:36:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] wifi: ath12k: Add new features to ACPI
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250113074810.29729-1-quic_lingbok@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250113074810.29729-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zB1717-E7_2uNFgCCVACuMIGPuACXRYt
X-Proofpoint-GUID: zB1717-E7_2uNFgCCVACuMIGPuACXRYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=890
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130077

On 1/13/25 13:18, Lingbo Kong wrote:
> By reading ACPI tables, implement a method to obtain the ACPI functions
> Bitmap, enable or disable specific features based on ACPI Bitflags and
> download board data files based on ACPI board data filename extensions.
> 
> v4:
> 1.rebase to 0c5fcd9069dd
> 
> v3:
> 1.change some function name.
> 
> v2:
> 1.support functions for cases where CONFIG_ACPI is disabled
> 
> Lingbo Kong (4):
>    wifi: ath12k: Add support for obtaining the buffer type ACPI function
>      bitmap
>    wifi: ath12k: Add Support for enabling or disabling specific features
>      based on ACPI bitflag
>    wifi: ath12k: Adjust the timing to access ACPI table
>    wifi: ath12k: Add support for reading variant from ACPI to download
>      board data file
> 
>   drivers/net/wireless/ath/ath12k/acpi.c | 200 +++++++++++++++++++------
>   drivers/net/wireless/ath/ath12k/acpi.h |  38 +++++
>   drivers/net/wireless/ath/ath12k/core.c |   8 +-
>   drivers/net/wireless/ath/ath12k/core.h |   7 +
>   drivers/net/wireless/ath/ath12k/mac.c  |   3 +-
>   drivers/net/wireless/ath/ath12k/qmi.c  |   9 ++
>   6 files changed, 217 insertions(+), 48 deletions(-)
> 

* drivers/net/wireless/ath/ath12k/acpi.c: 2025 copyright missing
* drivers/net/wireless/ath/ath12k/acpi.h: 2025 copyright missing
* drivers/net/wireless/ath/ath12k/core.c: 2025 copyright missing
* drivers/net/wireless/ath/ath12k/core.h: 2025 copyright missing
* drivers/net/wireless/ath/ath12k/mac.c: 2025 copyright missing
* drivers/net/wireless/ath/ath12k/qmi.c: 2025 copyright missing

No need to respin just because of this.

> 
> base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256


-- 
Aditya

