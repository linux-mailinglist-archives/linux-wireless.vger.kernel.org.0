Return-Path: <linux-wireless+bounces-14431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E19E9AD342
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 19:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D08F1C21F3B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A727E1BD038;
	Wed, 23 Oct 2024 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WpqrTccq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E061BCA07
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705723; cv=none; b=izsEAswMwAIcnfNZW/P7nRVHH3AJK6lTt6cEKIAcijgmoclkf/9DseJMjTBOUQx96ErfD2O6Ga05BME6ahBeZYwe1HrfZV67tCCxvU/cSA55HakXloLzweStJNlodO52q2jnIZse833HubPEpJVCBDQqRYxaC9o0Zkc496Wz6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705723; c=relaxed/simple;
	bh=z1lCqSRabXZJC9slyr78KY5ibyBJxp+xlUN3QK3cNY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J276pwCmvPiH7D5pg/eMx2e0CvEcYd/sXwvGIXN59HZe9qqDUK0Ccb7PtFYIp4XQZ//wwY8MQwseM4HYpSlbpGMb0skm7PA1ijeIPoyIZXB22DxNnDYOGl60PmZ7GWX/fLpx9CU0AJWXEYSg3N2/HrSZfa8V9dfKaCF8q+rFxoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WpqrTccq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9SnZA025432;
	Wed, 23 Oct 2024 17:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a5pk3Gb9ZZ+iJpGPYIKUJqzg7WHsdPaCPYzNB59ezTU=; b=WpqrTccqTH4zQllH
	e8dRxoxsYs2raYE+prPJbwuiy23D5OQkS/iEb1Y4BW1dJyKeNlFbFi/3i1YEJ5Qp
	l2ukApiLwL1wu3skAn7023dcZMoA5YIMnVz+erTRogTkpaWapjl0blblwIUgdBhl
	vZKdJpgobsdLjJPQQryFwrdXMep19hyBudKY1JV6OZykkkBv41z4z4/tKzsqlAhU
	tmK68ziErffX0NH1eMnMjgJwmmVlh4s6XzvJJtODsekdLzsQcb7RSs6zr5a3uS3v
	XAptje1Sq1hr5Qls21XG+mTx80PFvK+oEMQKN2liYKKrlJmOTOMOKVKhsyIATFPS
	0iKisQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em41u2dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:48:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NHmarG006296
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 17:48:36 GMT
Received: from [10.48.242.6] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 10:48:36 -0700
Message-ID: <78aff701-7670-46c2-a947-ff39f5cba23d@quicinc.com>
Date: Wed, 23 Oct 2024 10:48:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] wifi: ath12k: Add new features to ACPI
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241023024551.18966-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241023024551.18966-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: spkpqbtQsmee3giDA8q7gTN2pWbfWXsV
X-Proofpoint-ORIG-GUID: spkpqbtQsmee3giDA8q7gTN2pWbfWXsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230113

On 10/22/2024 7:45 PM, Lingbo Kong wrote:
> By reading ACPI tables, implement a method to obtain the ACPI functions
> Bitmap, enable or disable specific features based on ACPI Bitflags and
> download board data files based on ACPI board data filename extensions.
> 
> v3:
> 1.change some function name.
> 
> v2:
> 1.support functions for cases where CONFIG_ACPI is disabled
> 
> Lingbo Kong (4):
>   wifi: ath12k: Add support for obtaining the buffer type ACPI function
>     bitmap
>   wifi: ath12k: Add Support for enabling or disabling specific features
>     based on ACPI bitflag
>   wifi: ath12k: Adjust the timing to access ACPI table
>   wifi: ath12k: Add support for reading variant from ACPI to download
>     board data file
> 
>  drivers/net/wireless/ath/ath12k/acpi.c | 200 +++++++++++++++++++------
>  drivers/net/wireless/ath/ath12k/acpi.h |  38 +++++
>  drivers/net/wireless/ath/ath12k/core.c |   8 +-
>  drivers/net/wireless/ath/ath12k/core.h |   7 +
>  drivers/net/wireless/ath/ath12k/mac.c  |   3 +-
>  drivers/net/wireless/ath/ath12k/qmi.c  |   9 ++
>  6 files changed, 217 insertions(+), 48 deletions(-)
> 
> 
> base-commit: cd8aa3af7491a1f7a5b81e53dbe62a38433c2d4b

FYI this series does not apply cleanly on top of the MLO branch and hence it
will be deferred until the MLO branch has merged.

/jeff

