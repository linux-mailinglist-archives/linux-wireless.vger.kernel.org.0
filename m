Return-Path: <linux-wireless+bounces-4127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18C86A653
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 03:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC6F1C23B3F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 02:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567664A1A;
	Wed, 28 Feb 2024 02:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j7uV7rUw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C43217;
	Wed, 28 Feb 2024 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086140; cv=none; b=VnXPJG1LwYL2DVHFAb3mJ2k7TrXBr8VrKCmjpWXH9/dnFOPzVNdvnReRPEke80SdQWgstW28bTYc+roncLSRiy9taDYhab0guzJJqbtXyoctTyAC8I3C1tyytS0xaLPNok6jze2irRxNvQn/8xvqfqqgVbbvw69wvJjw7u1d4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086140; c=relaxed/simple;
	bh=L57cOBXopWwIX9zuQIZBcvW1Q+tlXF76gCxChCMWHHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EGcww8YsDdhsJTERH2zoRSY7lpvlEh2XzLxCSnWOmva7LhBZusMMXObNaQ0Q6x/8tqvo3CrAmUhAilap3DNsqHa+Mlb2s6xqAQUnoMpibkKyIBLfeID35aejf1QQ21Q47MV1mU4F7ECy8xJE5GGuYQk1twspL00pIDggyPqHxnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j7uV7rUw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RLv3D8025039;
	Wed, 28 Feb 2024 02:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pZYGHFKUM9rzaHQ4aXknAtv1pfMLnYJeIrsE7pM77xI=; b=j7
	uV7rUw5c2Z1tW72+RelEjaVFRSXID7T7ZRKzfApE4GrSoyPbk1bNZCkcifiroQSY
	Fy6FatFqqrTkAmxlZs0V7IsCEkydOQsCS33/Dm+ABhDWcqemlyUpkd0gZfT2P+J/
	Cb+NovUKsM/ZLtc/ckG+LYDK35TLRCJJ3wBbSnoFm/QlR/aOnYqZ3JtsTLMVinN8
	el1vk8/FvFnlPlEAbyMp6s5m1PDLerhaxqSi1PM90aHHjOAjxhMMVPKeFAtfqd1j
	pA0oUXDY/ga1yAr4/Aa/HKjfjrSono8x8k7/cnRKE1T6lk19VFf0StEvlSc6vfs5
	kxdiUN+Y78SIhM83OE+g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whccwa8cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 02:08:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S28nAu031123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 02:08:49 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 18:08:48 -0800
Message-ID: <17b2041d-7c9b-4cb4-bf39-7d0f5d60c04b@quicinc.com>
Date: Wed, 28 Feb 2024 10:08:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] net: qrtr: support suspend/hibernation
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>
References: <20240227104427.7505-1-quic_bqiang@quicinc.com>
 <20240227104427.7505-3-quic_bqiang@quicinc.com>
 <20240227121602.GM2587@thinkpad>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240227121602.GM2587@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Mucq4qeKIj9MChr9ozOcHndDP28ykHAR
X-Proofpoint-ORIG-GUID: Mucq4qeKIj9MChr9ozOcHndDP28ykHAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxlogscore=881 mlxscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280015



On 2/27/2024 8:16 PM, Manivannan Sadhasivam wrote:
> On Tue, Feb 27, 2024 at 06:44:26PM +0800, Baochen Qiang wrote:
>> MHI devices may not be destroyed during suspend/hibernation, so need
>> to unprepare/prepare MHI channels throughout the transition, this is
>> done by adding suspend/resume callbacks.
>>
>> The suspend callback is called in the late suspend stage, this means
>> MHI channels are still alive at suspend stage, and that makes it
>> possible for an MHI controller driver to communicate with others over
>> those channels at suspend stage. While the resume callback is called
>> in the early resume stage, for a similar reason.
>>
>> Also note that we won't do unprepare/prepare when MHI device is in
>> suspend state because it's pointless if MHI is only meant to go through
>> a suspend/resume transition, instead of a complete power cycle.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> Btw, you forgot to CC netdev folks. Here is the list that get_maintainer.pl
> returns:
> 
> "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
> Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
> Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
> Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
> netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
> 
Sure Mani, will send a v4 with above folks CC'ed.

> - Mani
> 
>> ---
>>   net/qrtr/mhi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
>> index 9ced13c0627a..69f53625a049 100644
>> --- a/net/qrtr/mhi.c
>> +++ b/net/qrtr/mhi.c
>> @@ -118,6 +118,51 @@ static const struct mhi_device_id qcom_mhi_qrtr_id_table[] = {
>>   };
>>   MODULE_DEVICE_TABLE(mhi, qcom_mhi_qrtr_id_table);
>>   
>> +static int __maybe_unused qcom_mhi_qrtr_pm_suspend_late(struct device *dev)
>> +{
>> +	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
>> +	enum mhi_state state;
>> +
>> +	state = mhi_get_mhi_state(mhi_dev->mhi_cntrl);
>> +	/*
>> +	 * If the device is in suspend state, then no need for the
>> +	 * client driver to unprepare the channels.
>> +	 */
>> +	if (state == MHI_STATE_M3)
>> +		return 0;
>> +
>> +	mhi_unprepare_from_transfer(mhi_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused qcom_mhi_qrtr_pm_resume_early(struct device *dev)
>> +{
>> +	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
>> +	enum mhi_state state;
>> +	int rc;
>> +
>> +	state = mhi_get_mhi_state(mhi_dev->mhi_cntrl);
>> +	/*
>> +	 * If the device is in suspend state, we won't unprepare channels
>> +	 * in suspend callback, therefore no need to prepare channels when
>> +	 * resume.
>> +	 */
>> +	if (state == MHI_STATE_M3)
>> +		return 0;
>> +
>> +	rc = mhi_prepare_for_transfer_autoqueue(mhi_dev);
>> +	if (rc)
>> +		dev_err(dev, "failed to prepare for autoqueue transfer %d\n", rc);
>> +
>> +	return rc;
>> +}
>> +
>> +static const struct dev_pm_ops qcom_mhi_qrtr_pm_ops = {
>> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(qcom_mhi_qrtr_pm_suspend_late,
>> +				     qcom_mhi_qrtr_pm_resume_early)
>> +};
>> +
>>   static struct mhi_driver qcom_mhi_qrtr_driver = {
>>   	.probe = qcom_mhi_qrtr_probe,
>>   	.remove = qcom_mhi_qrtr_remove,
>> @@ -126,6 +171,7 @@ static struct mhi_driver qcom_mhi_qrtr_driver = {
>>   	.id_table = qcom_mhi_qrtr_id_table,
>>   	.driver = {
>>   		.name = "qcom_mhi_qrtr",
>> +		.pm = &qcom_mhi_qrtr_pm_ops,
>>   	},
>>   };
>>   
>> -- 
>> 2.25.1
>>
> 

