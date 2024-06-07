Return-Path: <linux-wireless+bounces-8654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D848FFA13
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 04:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1BE2837B8
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C48DDD9;
	Fri,  7 Jun 2024 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fqXuJUwA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD862F26
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717728934; cv=none; b=DznBIFEhGDQBpBQZlsW4j597T/QI1oKBApJ0qZXN/BB3czohxWZXWC2DGTfZYG18oc+J1DXItHH7PV1JMjpgHx3PHrzTwdusNn4qTYr0hG3lbtEahTY+ahSumc/IDPyCs0q3n3jZPFKBRHuzr+X5T8B6zFn9Xn6kSD+ptWa5kpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717728934; c=relaxed/simple;
	bh=7b+tXuK0YVjSLbKsEAPPZeltSUucMgIXjHZlb6UkUaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XKipCaj0gshcgLoTXSrIvcNLO0bB8kyy88Fi7pGM7K9Gz6A1pa4KlHCQ7dyq64Xcl1Co/ehF75HVwmKxAvQZKC98cFcv+ul8ECJlcm51iKRoJJx3K6pxkJIuGyA3MIp07RnRFl+6KKwl6ghlBOX782QBmKB0lx6jpXgbQ2KSm2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fqXuJUwA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4571VH7N031711;
	Fri, 7 Jun 2024 02:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4tTbXsCHuGQtIxn9Aj09SJmqa8/QdCyX6mvTd1JlVbc=; b=fqXuJUwAvuvPEbWz
	96EqdBe8B//KCOXa6hIb7EpyMHDbB2LxYmiorcpn5E6hKL210kzrb4fFpMCOUiPS
	s4AUBYDvUAQZyY/sKzosswuoHOpL2PeBbgQCRziZYJhlolNj4FGIr1N6Pb0ELsSA
	Azs1fGsu5aYoapAU6mXjlY9Pnf3/ND45025U/tP92N3zoWFNVAr3ZDMrcOQqcsDe
	o6vAstVrOtEO5WhvyS7V+pWiV8ByAAnq0PK/uEtvZfHRob4az3dID8zXPlE3GYvQ
	KP5EZXzeM63aXjMWv3GMXTMW9MK30zcWc4f+8wAvrNEqe1ae8i3t9mGsgheZpdA0
	Fu3FCw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjk89d74h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 02:55:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4572t6tO005785
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 02:55:06 GMT
Received: from [10.216.24.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 19:55:04 -0700
Message-ID: <b57a06e3-6dcf-4205-83e8-14857c4b7258@quicinc.com>
Date: Fri, 7 Jun 2024 08:25:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] wifi: ath12k: Add support to parse requested
 stats_type
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240603044214.960261-1-quic_rgnanase@quicinc.com>
 <20240603044214.960261-5-quic_rgnanase@quicinc.com>
 <7c7ea029-6ef9-4e7b-ac45-bdf341a8256a@quicinc.com>
Content-Language: en-US
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
In-Reply-To: <7c7ea029-6ef9-4e7b-ac45-bdf341a8256a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lfoncVws7FW8dubi5Eukyq6tOyCNZpHO
X-Proofpoint-ORIG-GUID: lfoncVws7FW8dubi5Eukyq6tOyCNZpHO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406070021


On 6/6/2024 10:12 PM, Jeff Johnson wrote:
> On 6/2/2024 9:42 PM, Ramya Gnanasekar wrote:
>> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>>
>> Add extended htt stats parser and print the corresponding TLVs associated
>> with the requested htt_stats_type.
>> Add support for TX PDEV related htt stats.
>>
> 
> while reviewing some other patches in the internal pipeline I discovered I had
> overlooked some things in this series, so pointing them out now...
> 
>> ---
>>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 315 ++++++++++++++++++
>>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 211 ++++++++++++
>>  drivers/net/wireless/ath/ath12k/dp_rx.c       |  10 +-
>>  drivers/net/wireless/ath/ath12k/dp_rx.h       |   4 +
>>  4 files changed, 536 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
>> index d98b971cde7d..e0a0acd5eec8 100644
>> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
>> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
>> @@ -9,6 +9,321 @@
>>  #include "debug.h"
>>  #include "debugfs_htt_stats.h"
>>  #include "dp_tx.h"
>> +#include "dp_rx.h"
>> +
>> +static u32
>> +print_array_to_buf(u8 *buf, u32 offset, const char *header,
>> +		   const __le32 *array, u32 array_len)
>> +{
>> +	int index = 0;
>> +	u8 i;
>> +
>> +	if (header) {
>> +		index += scnprintf(buf + offset,
>> +				   ATH12K_HTT_STATS_BUF_SIZE - offset,
>> +				   "%s = ", header);
>> +	}
>> +	for (i = 0; i < array_len; i++) {
>> +		index += scnprintf(buf + offset + index,
>> +				   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
>> +				   " %u:%u,", i, le32_to_cpu(array[i]));
>> +	}
> 
> note that this will end up with a trailing comma, so suggest you add:
> 
> 	/* have the next print overwrite the last trailing comma */
> 	index--;

Thanks. Will address the same.
> 
>> +	index += scnprintf(buf + offset + index,
>> +			   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
>> +			   "\n\n");
>> +	return index;
>> +}
>> +
>> +static void
>> +htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
>> +				struct debug_htt_stats_req *stats_req)
>> +{
>> +	const struct ath12k_htt_tx_pdev_stats_cmn_tlv *htt_stats_buf = tag_buf;
>> +	u8 *buf = stats_req->buf;
>> +	u32 len = stats_req->buf_len;
>> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
>> +	u32 mac_id_word = le32_to_cpu(htt_stats_buf->mac_id__word);
> 
> this dereference has to occur after the length check, otherwise you may have a
> buffer overread
> 
>> +
>> +	if (tag_len < sizeof(struct ath12k_htt_tx_pdev_stats_cmn_tlv))
> 
> sizeof(*htt_stats_buf) is preferred
> 
>> +		return;
>> +
> 
> that concludes my new comments
> 

Thanks Jeff. I will address the same.

