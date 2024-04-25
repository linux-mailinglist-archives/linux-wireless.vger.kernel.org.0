Return-Path: <linux-wireless+bounces-6874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDD98B29AC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 22:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BDC1F23065
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 20:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61B415381A;
	Thu, 25 Apr 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tryy5F4x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7AD153811
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076649; cv=none; b=Ckdnj93AqAs8tRrI4aF7iDritpt5/agLAD0rRioo94MZCaT3FYvVXacvg1d5JRJbwiQsPDnQVRf44ZtYTNaTsLLJOP3awlGjOROGOeh4+qGES7yuWSqlapV2JyctCAuyTEpd3JCz9/Bq4y74kwvSs0AKAFB5m5vYo2+3O+EtF5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076649; c=relaxed/simple;
	bh=/caJpYu0k8/MvQ4Wl1KXIgn/d3x54rflSSCblDJwlAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S8QsESfzPjaKeaoEco+X8QvhHGRsLX1inf1K9uvZTKcM/qINWxC9JmHEygjGd6wRHAkf4RVLtSDRbNzXVrhnZ4ow051pmvIqESFX9sS7uVv9cc2tp/beA3750VLN3KVW3zJ4k7wA2AULAmOssaoRKDOjxaYrqlYSIsRJ1X5y3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tryy5F4x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9xulA002621;
	Thu, 25 Apr 2024 20:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FSXqZkBG0aQd1sAXt8lAk18tEzsXZx0nYrSAK5+olRo=; b=Tr
	yy5F4xtRpiEWriHCFwwq4g/qu5S6Sc/qoDoGCgZBj2fps6afO68oj+G5dVXJ98oy
	5wktx6ztza80HwCTobIWRVWGx6acqbZyQpaM9WENSghjTQjRvVuxiGCGsTNEIycF
	oYzvHL81Z92GLI2F1uR/QO1IeCYZoFad031e/2z6ENY/l9RBc52G2hMyu917doDc
	yPFqZiyDpOnqY98SorLGTYPJHmzRYw99oAgUbe7tNGd7wfplan49RKhrbLiV4flq
	Jx0kEKWbEKYY+x9c2kvFshVY5Qlx2VHx5ykd+j1RjgFWlXy5CAL8YVMJZLWSeCiP
	kEIDSLA0k1quHg0HiGyg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqn0whrrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 20:06:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PK6f19017358
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 20:06:41 GMT
Received: from [10.227.91.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 13:06:41 -0700
Message-ID: <a81aea48-740e-416e-b29f-e94d7fca371b@quicinc.com>
Date: Thu, 25 Apr 2024 13:06:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/6] bug fixes and enhancements to 6 GHz band support
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
 <6eda8fe4-bd89-425c-8717-65ab42e073ba@quicinc.com>
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <6eda8fe4-bd89-425c-8717-65ab42e073ba@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zy0Rh6m6HJezPdG8itOrI1MXRZiW48-l
X-Proofpoint-GUID: Zy0Rh6m6HJezPdG8itOrI1MXRZiW48-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_20,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250145



On 4/25/2024 10:45 AM, Jeff Johnson wrote:
> On 4/24/2024 12:11 PM, Pradeep Kumar Chitrapu wrote:
>> In 6 GHz band, add support for
>> 1. channel 2.
>> 2. Fix packet drop issues.
>> 3. AMPDU aggregation
>> 4. SMPS configuration
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> changes in v3:
>>   - address review comments for fixing ath12k-check issues.
> 
> this should be more specific. at a minimum it should indicate which patches in
> the series have been modified
> 
Thanks Jeff, I will add acked-by and also address te other comments in 
this series
in next revision.

