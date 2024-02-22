Return-Path: <linux-wireless+bounces-3901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA9285F221
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 08:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423E8283B09
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 07:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAA317998;
	Thu, 22 Feb 2024 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bIkAmb3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E2311CBC;
	Thu, 22 Feb 2024 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588133; cv=none; b=R0GrY/qO2tRyjcfTBf+5oQqbGh3BbexG0O0vjmtC829w9CpfUEwGliF1SXf4ej7R5Y95hG2jnhDoBLwJc32m+DUgNriaW4RXuUfmNunWuyQNmUetOL3VBcGX6Wr0LprPXKVt7c9Vjy8Hk1EF1wNuC3XjwO6j0FC4tIOrz04ptgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588133; c=relaxed/simple;
	bh=8KSbFOTKvnmtiBvPf5gWoGvyX7fsCaZvv7zdHfKgQOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NRW2o5vcHbh4qStXKdFytWU4bqMM43IZJ98F2YzugHx9xZBYwS0pmO9sD7i7nYN/OhHOj4T1RqIRqw/2Ahn9b5ZIwpMUPLY+y5hYFCOVDiNWUCxwpxmtcSy/4uprpgWxCYuOVpRuNgU8rOU8fqc1EysQwcSX6nByTEiaJ2872zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bIkAmb3D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M3kI7X011318;
	Thu, 22 Feb 2024 07:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=psqBUKQGbSXbbAVz6siNfbT5CXvozy5U7okkg1Pdo+U=; b=bI
	kAmb3DoGAkSsJ/hHT6Udv8/yp0Ek0VtrvE99Jya7DTOIY4kv35ENxk+HZcAjTXlH
	dkiV92pNGvT3yGsxXKNEeRDOIqs8Hc61ovtCQcsS6SSWvdsjzb4jrYwIUL8q6nQu
	1WTpmRz2oQPh+paNQbuYVMwcjU50MexPsBF9NnV4AXNZMhI3wslfIKAywW1VFQ1s
	moH8lN5c/CpipQ4LzCILjEGutnj+5wG2AtXPG8RHHwRhp4FVVmLQOpwJHWPFI2T1
	jB8d5AaLRl28/69/ks3zppSRN0fAsiCrcNODH/H0gF3t1EJYiWlbRsQ08AYWdSXU
	ugC2N4ALn/PyiSBAI5BA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdckvb1jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 07:48:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M7mlWk029379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 07:48:47 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 23:48:46 -0800
Message-ID: <77f6bbf6-add1-4f3b-9c10-5292e032c758@quicinc.com>
Date: Thu, 22 Feb 2024 15:48:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: qrtr: support suspend/hibernation
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <mhi@lists.linux.dev>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240221030026.10553-1-quic_bqiang@quicinc.com>
 <20240221030026.10553-3-quic_bqiang@quicinc.com>
 <dc54be43-e27f-4b5b-9b84-cf0856370abf@quicinc.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <dc54be43-e27f-4b5b-9b84-cf0856370abf@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: khza-GBEbGNQoETOuHopejsYeNiKfW8u
X-Proofpoint-ORIG-GUID: khza-GBEbGNQoETOuHopejsYeNiKfW8u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_05,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220061



On 2/22/2024 2:24 AM, Jeff Johnson wrote:
> On 2/20/2024 7:00 PM, Baochen Qiang wrote:
>> MHI devices may not be destroyed during suspend/hibernation, so need
>> to unprepare/prepare MHI channels throughout the transition.
>>
>> The RFC version adds new API to MHI stack with which an MHI controller
>> driver can do unprepare/prepare directly by itself, see
>>
>> https://patchwork.kernel.org/project/linux-wireless/patch/20231127162022.518834-3-kvalo@kernel.org/
>>
>> Although it works well Mani pointed out that the design is not good
>> because MHI channels are managed by MHI client driver thus should not
>> be touched by others. See the discussion
>>
>> https://lore.kernel.org/mhi/20231127162022.518834-1-kvalo@kernel.org/
>>
>> This version changes to add suspend/resume callbacks to achieve the
>> same purpose. The suspend callback is called in the late suspend stage,
>> this means MHI channels are still alive at suspend stage, and that makes
>> it possible for an MHI controller driver to communicate with others over
>> those channels at suspend stage. While the resume callback is called in
>> the early resume stage, for a similar reason.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>>   net/qrtr/mhi.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
>> index 9ced13c0627a..b54a6c2113e9 100644
>> --- a/net/qrtr/mhi.c
>> +++ b/net/qrtr/mhi.c
>> @@ -118,6 +118,32 @@ static const struct mhi_device_id qcom_mhi_qrtr_id_table[] = {
>>   };
>>   MODULE_DEVICE_TABLE(mhi, qcom_mhi_qrtr_id_table);
>>   
>> +static int qcom_mhi_qrtr_pm_suspend_late(struct device *dev)
> 
> Don't your new functions also need to be annotated as __maybe_unused?
OK, will add __maybe_unused in next version.

> 
>> +{
>> +	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
>> +
>> +	mhi_unprepare_from_transfer(mhi_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_mhi_qrtr_pm_resume_early(struct device *dev)
>> +{
>> +	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
>> +	int rc;
>> +
>> +	rc = mhi_prepare_for_transfer_autoqueue(mhi_dev);
>> +	if (rc)
>> +		dev_err(dev, "failed to prepare for autoqueue transfer %d\n", rc);
>> +
>> +	return rc;
>> +}
>> +
>> +static const struct dev_pm_ops __maybe_unused qcom_mhi_qrtr_pm_ops = {
> 
> this does not need to be __maybe_unused, see below
> 
>> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(qcom_mhi_qrtr_pm_suspend_late,
>> +				     qcom_mhi_qrtr_pm_resume_early)
>> +};
>> +
>>   static struct mhi_driver qcom_mhi_qrtr_driver = {
>>   	.probe = qcom_mhi_qrtr_probe,
>>   	.remove = qcom_mhi_qrtr_remove,
>> @@ -126,6 +152,9 @@ static struct mhi_driver qcom_mhi_qrtr_driver = {
>>   	.id_table = qcom_mhi_qrtr_id_table,
>>   	.driver = {
>>   		.name = "qcom_mhi_qrtr",
>> +#ifdef CONFIG_PM
> 
> conditional compilation isn't necessary here since the 'pm' member is
> always present
Sure, will remove that in next version.

> 
>> +		.pm = &qcom_mhi_qrtr_pm_ops,
>> +#endif
>>   	},
>>   };
>>   
> 

