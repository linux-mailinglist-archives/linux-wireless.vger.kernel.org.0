Return-Path: <linux-wireless+bounces-4323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4699E86F85E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 03:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98553B20D40
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 02:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1719B1362;
	Mon,  4 Mar 2024 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BQuFEABM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C615B7;
	Mon,  4 Mar 2024 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709517742; cv=none; b=XdVaR8Rsq7olm1e0PHkAUVEyFrLOLkOwbWkwUsir8AYgF8iYckCTOVUZOq+G/ItNUAV/q+Ri3lfbR16WVbMwtYUvXvwNeFPQ5VJgSAWO0FTBaQ76JJc3A+HChDgRUWYgkDv2erA2WFKv6d7wOjHnkG+N1W33PlJa2VW5UEgflfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709517742; c=relaxed/simple;
	bh=Ue33lGzqfo/jgNtFGbgWBqs1RMLXZ8/yeEEgr4eoBeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m8ioTi1N4WrMKiGJ3eWIWVif2/ORpJ0Oz9SopgXEFujD2n0AoUH475miNOUN24jdPz9h4fPwTGFmRjq3GQ81BIlIafcQTw8/kBmgJsPJEmkhP6x6g2nKrxcvwmovC5z9gvFzfAvphVFWCK0nYAftIXY4GCZK5+B2ZhntIB3ip0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BQuFEABM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4240ruIc001535;
	Mon, 4 Mar 2024 02:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dyx8i+1adfOwtwk/jtjUkWWhA/+3oNCwintV1yE78Qk=; b=BQ
	uFEABMcT6IYdLSiKSJGQrkmucM3SBJWSrSIx5RK5U0kSARNRWNXBaTCIY6p+a43/
	xebeTkNtCgfWo7So9fIGz4ZrpH1xbkkMbFCpvpHm4TKcQvy2u7ALTH+QO2gqnbUv
	Tu9HXT/LYSMOYc+hhOpwg+O5ieIRio7xqdBYYDE7hWTCuXKaRWWUc/r4bPTssnYG
	NSeunbmTrJMUBN3qtFy9axPZ7wtnHSi3fpK+wD7i92nDm/wcYecofycNPWaC5sN4
	qt6zLcfvzmWiK8okwhn+eWdmV1a4MSNHmZ4IkQsHoRVwpvrfQ3VTwKusUAykSRan
	O+AQRirZigkRWG+A9sEg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkwdhta39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 02:02:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424221Jp029057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 02:02:01 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 3 Mar
 2024 18:01:59 -0800
Message-ID: <ef427b87-1cf2-4ae2-8f14-2e2b34df3d84@quicinc.com>
Date: Mon, 4 Mar 2024 10:01:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] bus: mhi: host: add mhi_power_down_keep_dev()
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "Kalle Valo (QUIC)"
	<quic_kvalo@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20240228022243.17762-1-quic_bqiang@quicinc.com>
 <20240228022243.17762-2-quic_bqiang@quicinc.com>
 <20240229101202.GB2999@thinkpad>
 <531daaa9-cf14-4812-8908-c617bd25bc08@quicinc.com>
 <87le7383nd.fsf@kernel.org>
 <b5b3f46d-ad98-44e5-84e0-7b00fe29ec5a@quicinc.com>
 <20240301122559.GB2401@thinkpad>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240301122559.GB2401@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BF7jkQ2l8daP5i1xFiOnjYhtP4OXfjPH
X-Proofpoint-GUID: BF7jkQ2l8daP5i1xFiOnjYhtP4OXfjPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_01,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 mlxlogscore=951
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040014



On 3/1/2024 8:25 PM, Manivannan Sadhasivam wrote:
> On Fri, Mar 01, 2024 at 10:04:06AM +0800, Baochen Qiang wrote:
>>
>>
>> On 3/1/2024 3:35 AM, Kalle Valo wrote:
>>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>>
>>>> On 2/29/2024 6:12 PM, Manivannan Sadhasivam wrote:
>>>>> On Wed, Feb 28, 2024 at 10:22:41AM +0800, Baochen Qiang wrote:
>>>>>> ath11k fails to resume:
>>>>>>
>>>>>> ath11k_pci 0000:06:00.0: timeout while waiting for restart complete
>>>>>>
>>>>>> This happens because when calling mhi_sync_power_up() the MHI subsystem
>>>>>> eventually calls device_add() from mhi_create_devices() but the device
>>>>>> creation is deferred:
>>>>>>
>>>>>> mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral
>>>>>>
>>>>>> The reason for deferring device creation is explained in dpm_prepare():
>>>>>>
>>>>>>            /*
>>>>>>             * It is unsafe if probing of devices will happen during suspend or
>>>>>>             * hibernation and system behavior will be unpredictable in this case.
>>>>>>             * So, let's prohibit device's probing here and defer their probes
>>>>>>             * instead. The normal behavior will be restored in dpm_complete().
>>>>>>             */
>>>>>>
>>>>>> Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not
>>>>>> called and thus MHI channels are not prepared:
>>>>>>
>>>>>> So what this means that QRTR is not delivering messages and the QMI connection
>>>>>> is not working between ath11k and the firmware, resulting a failure in firmware
>>>>>> initialization.
>>>>>>
>>>>>> To fix this add new function mhi_power_down_keep_dev() which doesn't destroy
>>>>>> the devices for channels during power down. This way we avoid probe defer issue
>>>>>> and finally can get ath11k hibernation working with the following patches.
>>>>>>
>>>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>>>>
>>>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>>>>
>>>>> Did Kalle co-author this patch? If so, his Co-developed-by tag should
>>>>> be added.
>>>>
>>>> Hmm, I'm not sure...  I would like Kalle's thoughts on this.
>>>
>>> IIRC I did only some simple cleanup before submitting the patch so I
>>> don't think Co-developed-by is justified. I'm also fine with removing my
>>> Signed-off-by.
>> Thanks Kalle.
>>
>> Hi Mani, so according to Kalle's comments, I'd like to keep the patch as is.
>>
> 
> No. Either remove his signed off by (as indicated by Kalle) or add a
> co-developed-by tag. Keeping just a signed-off-by tag is wrong.
> 
OK, will send new version with Kalle's s-o-b tag removed.

> - Mani
> 

