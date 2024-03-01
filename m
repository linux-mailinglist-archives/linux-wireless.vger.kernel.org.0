Return-Path: <linux-wireless+bounces-4283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844FB86D95A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 03:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A221C229F1
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 02:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA42639847;
	Fri,  1 Mar 2024 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pKzjQ+u7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E238FBC;
	Fri,  1 Mar 2024 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258667; cv=none; b=pfPx7dR5E9CkZibBae3SmhcdRfDdCBsAky92knXylzNMBocRdD0iYEcYsyF39LPiEraBzIQvb6qRNI8hFDB0uOvS1iLnL9zDfvunm1EpqGhVc1lkJh8ecWwjDa6CgKkiXeLFj5133ho8MDynASfBexJhUtQzpoDfF5A1x6z+SZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258667; c=relaxed/simple;
	bh=EUE081BGTpKI2jPBm9l1DAZfBilSuxIrE7H7+2z6rZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qNhBQ1zyUBQ36RQH1hHAqteKvzc8AE2r5D5C4OPrMl3cmkG1OC4ndnTY+FKEI1Fj6/S18gSMWZ+KACi8z3j/j6m6VRJhBv1QFnFjONglkaT3Alf/7Lj0qS9v24IHMnddW1VwPh9ibPnjByc6usc19lKlT+upSstvL1q0MxhfJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pKzjQ+u7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4210oB4O002798;
	Fri, 1 Mar 2024 02:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qCn2CH+WxcE0RRkPCW/gs9CnYBAjab4ADjZKcKMLPuk=; b=pK
	zjQ+u7uSv+S+UixgecppGb/dBVrX0b/LUyXbXp0MAe6DfjOKWq3bSBczwTX78cNJ
	E127Ey6x6a0Cz+tJzGikZayFGo+qN3zOrt+eWIE7rOc/G0WP+oU/zcwAzoFlZTN9
	3JL44MBn92GUxkEurqGE+PFO+UAuG00AxOEv1v6d8tO9OwWvsAr5OVbISmbVIHlD
	oq+WCRt9KpVDWpVZLPx1rFgZ2xON6NyyPcg76RSsSDfH+y5R1ObEuT0Bpx0qnIQZ
	W6XRMCRBqjHOiGdzkEoCGWdjpc9tWB7icPEBD79tvz4x+Zs0F8C3MVbidunNkuDa
	Qn/QoCv/ODx9/18ul+pw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjx9y1970-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 02:04:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42124CIq002965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 02:04:12 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 18:04:09 -0800
Message-ID: <b5b3f46d-ad98-44e5-84e0-7b00fe29ec5a@quicinc.com>
Date: Fri, 1 Mar 2024 10:04:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] bus: mhi: host: add mhi_power_down_keep_dev()
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Kalle Valo
 (QUIC)" <quic_kvalo@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20240228022243.17762-1-quic_bqiang@quicinc.com>
 <20240228022243.17762-2-quic_bqiang@quicinc.com>
 <20240229101202.GB2999@thinkpad>
 <531daaa9-cf14-4812-8908-c617bd25bc08@quicinc.com>
 <87le7383nd.fsf@kernel.org>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87le7383nd.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mO0jaRZNk5ofn2jUbE7-xk37L4P-YGcS
X-Proofpoint-ORIG-GUID: mO0jaRZNk5ofn2jUbE7-xk37L4P-YGcS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010016



On 3/1/2024 3:35 AM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> On 2/29/2024 6:12 PM, Manivannan Sadhasivam wrote:
>>> On Wed, Feb 28, 2024 at 10:22:41AM +0800, Baochen Qiang wrote:
>>>> ath11k fails to resume:
>>>>
>>>> ath11k_pci 0000:06:00.0: timeout while waiting for restart complete
>>>>
>>>> This happens because when calling mhi_sync_power_up() the MHI subsystem
>>>> eventually calls device_add() from mhi_create_devices() but the device
>>>> creation is deferred:
>>>>
>>>> mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral
>>>>
>>>> The reason for deferring device creation is explained in dpm_prepare():
>>>>
>>>>           /*
>>>>            * It is unsafe if probing of devices will happen during suspend or
>>>>            * hibernation and system behavior will be unpredictable in this case.
>>>>            * So, let's prohibit device's probing here and defer their probes
>>>>            * instead. The normal behavior will be restored in dpm_complete().
>>>>            */
>>>>
>>>> Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not
>>>> called and thus MHI channels are not prepared:
>>>>
>>>> So what this means that QRTR is not delivering messages and the QMI connection
>>>> is not working between ath11k and the firmware, resulting a failure in firmware
>>>> initialization.
>>>>
>>>> To fix this add new function mhi_power_down_keep_dev() which doesn't destroy
>>>> the devices for channels during power down. This way we avoid probe defer issue
>>>> and finally can get ath11k hibernation working with the following patches.
>>>>
>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>>
>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>>
>>> Did Kalle co-author this patch? If so, his Co-developed-by tag should
>>> be added.
>>
>> Hmm, I'm not sure...  I would like Kalle's thoughts on this.
> 
> IIRC I did only some simple cleanup before submitting the patch so I
> don't think Co-developed-by is justified. I'm also fine with removing my
> Signed-off-by.
Thanks Kalle.

Hi Mani, so according to Kalle's comments, I'd like to keep the patch as is.

> 

