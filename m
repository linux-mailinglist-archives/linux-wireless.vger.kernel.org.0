Return-Path: <linux-wireless+bounces-9220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BDF90E205
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 05:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9391C22417
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 03:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D998558BA;
	Wed, 19 Jun 2024 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WjzSoMpz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FAC55892
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768449; cv=none; b=QaarIE83MImBGWLt0fWx5HTwQDoDAsI8wj8FVXBpnyEyKkUw+jl09IurQa4YejFHwymRUZeVIrramQWMymPXRifk3rovF/l7/ocs1CCZO0q58IHhA5IGNPC7nJexvaj0afO0ULPh2nXiEZlrnzaSAAODUcuae0mTICfJAO73Rf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768449; c=relaxed/simple;
	bh=ml3R2p9ME+ij7LQntIJZxEHC41SKD9E4173GlnzLyYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UeLr1GQWbq9w2e93V08pEOiBjpVKge44EmR05ZP3/vJHvUqdsBa3e6NAtVcGvg2Ia1RCGfCCHfpygpJWu66Mx9WqY5wWbTocj3ie19NnDwL68kcd9e98rF0ZavqtHLvvK8ya4nvkultvkzRSZfxURfv5Uir24PA1dUvDqIwtHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WjzSoMpz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILb03A027906;
	Wed, 19 Jun 2024 03:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UXVAOMw1KpkcPBNALFhvUh1q5B92hsJFwdBP9PO5TGI=; b=WjzSoMpz4YF6mk77
	SDPi0bDMdBwiBDiDl3OA6fradLbQys8KlPk6++3Mj7Z/y2NQSsYXIDIsEtAsRJ0B
	w1JcmTQAnvuSXi6CpFnqqnufEENHtk8tBa/3NP8Mjg6jFjn+StHxarHxmzmBTOwA
	6aZ2gFRsRB9JLlMsxk+pEw4iBJWLNqL9yb1OWw7KMfhXmdVKrKAdC82ynSJq3o9d
	mdQVqrhXoCBOvca/ANfK9ia+4PAxEt7vAgW7K/4vq/mxKFZOfWYrFEKzsRMctggr
	yGSEJhR70QC2DxAiCIxp/Vupu3w0iNtTRgq4Z+F6aol6Kywh+h/tqNVX3Yk+CISe
	2eCYKA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9yrj9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 03:40:34 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J3eXg0021163
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 03:40:33 GMT
Received: from [10.152.193.243] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 20:40:32 -0700
Message-ID: <507c6ea1-388b-45b4-97e4-67f5a55e0bd5@quicinc.com>
Date: Wed, 19 Jun 2024 09:10:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] wifi: ath: create common testmode_i.h file for ath
 drivers
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240617052903.2720292-1-quic_aarasahu@quicinc.com>
 <20240617052903.2720292-2-quic_aarasahu@quicinc.com>
 <255df1aa-8d06-4d6e-82f0-577aff3ebe5f@quicinc.com>
Content-Language: en-US
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
In-Reply-To: <255df1aa-8d06-4d6e-82f0-577aff3ebe5f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4IgGmr07CzLRYuvj0d5CH7yKK25Uo2tB
X-Proofpoint-GUID: 4IgGmr07CzLRYuvj0d5CH7yKK25Uo2tB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=644 spamscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190026



On 6/18/2024 3:09 AM, Jeff Johnson wrote:
> On 6/16/2024 10:29 PM, Aaradhana Sahu wrote:
>> User space application requires that the testmode interface
>> is exactly same between ath drivers. Move testmode_i.h file
>> in ath directory to ensure that all ath driver uses same testmode
>> interface instead of duplicating testmode_i.h for each ath drivers.
>>
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/testmode.c    | 78 +++++++++----------
>>  .../wireless/ath/{ath11k => }/testmode_i.h    | 54 ++++++-------
>>  2 files changed, 66 insertions(+), 66 deletions(-)
>>  rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
>>
> ...
>> diff --git a/drivers/net/wireless/ath/ath11k/testmode_i.h b/drivers/net/wireless/ath/testmode_i.h
>> similarity index 50%
>> rename from drivers/net/wireless/ath/ath11k/testmode_i.h
>> rename to drivers/net/wireless/ath/testmode_i.h
>> index 91b83873d660..ac852642bde1 100644
>> --- a/drivers/net/wireless/ath/ath11k/testmode_i.h
>> +++ b/drivers/net/wireless/ath/testmode_i.h
>> @@ -1,59 +1,59 @@
>>  /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>>  /*
>>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> 
> this should be
>  * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> 
>>   */
> 

Sure, will update in the next version.

