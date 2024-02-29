Return-Path: <linux-wireless+bounces-4221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6AB86BEEE
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 03:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA97B24369
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE608846D;
	Thu, 29 Feb 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iQfdAyOZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148BA5F;
	Thu, 29 Feb 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709173829; cv=none; b=UHl8VbE25BEZTEfL+9wldeEArPbrIQxxLMKuocKGdmknSHSISF7q+6yka8ZDvB6qFExDgOZqNsDm512aFR1kn+p2PA987teEpOwpVioj27myCmJNHQWGNPu1AB2S9mL5podYMpB+ZvGef/BBqMPn9ODI+9GajE+7+xqSSSvMow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709173829; c=relaxed/simple;
	bh=KhLL1Qqe/ranCX4jPUDTrZJCslOyFCtVGuTGjX2JrsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sLjnLJW9V1UUoQx3WqCovi0CEgwqHVeep/BPqpvhg2Padq/ntQrG7YTIlviMR5sYtg38qPGi2e2ou5pdayN7cupYJCMbQux/0uISsjemAhiXa1Wsfr/SS7cIzm8Dm+Bl6U+XMiuLLUGclbmXx+m9/f3jBTbNnCco5x7mLe8NCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iQfdAyOZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T1mfQd007940;
	Thu, 29 Feb 2024 02:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0/+C9tGIWpwPDFX0nUJBfhs5juresADDoCaZ7B+HQJM=; b=iQ
	fdAyOZy4J3CmN9WqWJmFLtxKex91dvUNix40Bu5eWdto7YFP6Rvdr80VMX/uQxqQ
	VQ6ZO05jwWZMsmX2BkOgW9D7d/BDSP8Yl+tLyy3k7ejQEZqVjq/eSvLQN7MEmQvq
	8cXfy6gfz6k5/xtT1JS92Fs2HTi3WIOTM+MIoSZ/odeyHetsvLgw14kZRn7vr+6K
	NR3dNfOSSJjrutEdoBj1qY5CBgY6O+cnHqm9vUselJhvGAkhhLInx3DvRsgp32Th
	ShNja+SZzuEcfTe5Hfs7okzEBYyi30PbaRYStGYfdMqdhFh4UdZ+FkyaSdTiBJ/z
	zzmas5Ib3xfymCkdMhUA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj6en9mf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 02:30:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41T2U9gv007702
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 02:30:09 GMT
Received: from [10.253.39.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 18:30:06 -0800
Message-ID: <60d9970b-b397-4c3d-b3cb-9d90866acebf@quicinc.com>
Date: Thu, 29 Feb 2024 10:30:04 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] wifi: ath11k: support hibernation
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <manivannan.sadhasivam@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20240228022243.17762-1-quic_bqiang@quicinc.com>
 <20240228022243.17762-4-quic_bqiang@quicinc.com>
 <ae3ec744-2157-4a8c-aa1b-38a22dc18042@quicinc.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <ae3ec744-2157-4a8c-aa1b-38a22dc18042@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B3EbC9YNp5quH_dD_zn2pm_Byq4raZCR
X-Proofpoint-ORIG-GUID: B3EbC9YNp5quH_dD_zn2pm_Byq4raZCR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290018



On 2/28/2024 11:31 PM, Jeff Johnson wrote:
> On 2/27/2024 6:22 PM, Baochen Qiang wrote:
>> Now that all infrastructure is in place and ath11k is fixed to handle all the
>> corner cases, power down the ath11k firmware during suspend and power it back
>> up during resume. This fixes the problem when using hibernation with ath11k PCI
>> devices.
>>
>> For suspend, two conditions needs to be satisfied:
>>          1. since MHI channel unprepare would be done in late suspend stage,
>>             ath11k needs to get all QMI-dependent things done before that stage.
>>          2. and because unprepare MHI channels requires a working MHI stack,
>>             ath11k is not allowed to call mhi_power_down() until that finishes.
>> So the original suspend callback is separated into two parts: the first part
>> handles all QMI-dependent things in suspend callback; while the second part
>> powers down MHI in suspend_late callback. This is valid because kernel calls
>> ath11k's suspend callback before all suspend_late callbacks, making the first
>> condition happy. And because MHI devices are children of ath11k device
>> (ab->dev), kernel guarantees that ath11k's suspend_late callback is called
>> after QRTR's suspend_late callback, this satisfies the second condition.
>>
>> Above analysis also applies to resume process. so the original resume
>> callback is separated into two parts: the first part powers up MHI stack
>> in resume_early callback, this guarantees MHI stack is working when
>> QRTR tries to prepare MHI channels (kernel calls QRTR's resume_early callback
>> after ath11k's resume_early callback, due to the child-father relationship);
>> the second part waits for the completion of restart, which won't fail now
>> since MHI channels are ready for use by QMI.
>>
>> Another notable change is in power down path, we tell mhi_power_down() to not
>> to destroy MHI devices, making it possible for QRTR to help unprepare/prepare
>> MHI channels, and finally get us rid of the probe-defer issue when resume.
>>
>> Also change related code due to interface changes.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>
>> Tested-by: Takashi Iwai <tiwai@suse.de>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/ahb.c  |   6 +-
>>   drivers/net/wireless/ath/ath11k/core.c | 105 +++++++++++++++++--------
>>   drivers/net/wireless/ath/ath11k/core.h |   6 +-
>>   drivers/net/wireless/ath/ath11k/hif.h  |  14 +++-
>>   drivers/net/wireless/ath/ath11k/mhi.c  |  12 ++-
>>   drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
>>   drivers/net/wireless/ath/ath11k/pci.c  |  44 +++++++++--
>>   drivers/net/wireless/ath/ath11k/qmi.c  |   2 +-
>>   8 files changed, 142 insertions(+), 52 deletions(-)
> ...snip...
>> +int ath11k_core_resume_early(struct ath11k_base *ab)
>> +{
>> +	int ret;
>> +	struct ath11k_pdev *pdev;
>> +	struct ath11k *ar;
>> +
>> +	if (!ab->hw_params.supports_suspend)
>> +		return -EOPNOTSUPP;
>> +
>> +	/* so far signle_pdev_only chips have supports_suspend as true
> 
> nit: s/signle/single/
> 
>> +	 * and only the first pdev is valid.
>> +	 */
>> +	pdev = ath11k_core_get_single_pdev(ab);
>> +	ar = pdev->ar;
>> +	if (!ar || ar->state != ATH11K_STATE_OFF)
>> +		return 0;
>> +
>> +	reinit_completion(&ab->restart_completed);
>> +	ret = ath11k_hif_power_up(ab);
>> +	if (ret)
>> +		ath11k_warn(ab, "failed to power up hif during resume: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(ath11k_core_resume_early);
>>   
>>   int ath11k_core_resume(struct ath11k_base *ab)
>>   {
>>   	int ret;
>>   	struct ath11k_pdev *pdev;
>>   	struct ath11k *ar;
>> +	long time_left;
>>   
>>   	if (!ab->hw_params.supports_suspend)
>>   		return -EOPNOTSUPP;
>> @@ -940,29 +990,19 @@ int ath11k_core_resume(struct ath11k_base *ab)
>>   	if (!ar || ar->state != ATH11K_STATE_OFF)
>>   		return 0;
>>   
>> -	ret = ath11k_hif_resume(ab);
>> -	if (ret) {
>> -		ath11k_warn(ab, "failed to resume hif during resume: %d\n", ret);
>> -		return ret;
>> +	time_left = wait_for_completion_timeout(&ab->restart_completed,
>> +						ATH11K_RESET_TIMEOUT_HZ);
>> +	if (time_left == 0) {
>> +		ath11k_warn(ab, "timeout while waiting for restart complete");
>> +		return -ETIMEDOUT;
>>   	}
>>   
>> -	ath11k_hif_ce_irq_enable(ab);
>> -	ath11k_hif_irq_enable(ab);
> 
> these are disabled in suspend_late()
> do you need to enable in resume_early()?
> or are they expected to be enabled via ath11k_wow_op_resume()?
> 
> and if that is the case, why isn't the disable in
> ath11k_wow_op_suspend() sufficient? can the disables in suspend_late()
> be removed?
There are two user cases here:
1. if WoWLAN is enabled, IRQ enable/disable only happens in 
ath11k_wow_op_suspend()/resume(), ath11k_core_suspend()/late_suspend() 
and ath11k_core_resume()/early_resume() do nothing but return directly 
due to below check:
		if (!ar || ar->state != ATH11K_STATE_OFF)
			return 0;
so this is symmetric and no issues here.

2. if WoWLAN is disabled, ath11k_wow_op_suspend()/resume() won't get 
called, see the check on 'local->wowlan' in __ieee80211_suspend(). Then 
IRQ is disabled in ath11k_core_suspend_late(). The reason why IRQ is not 
enabled in ath11k_core_resume()/early_resume() is because in this case 
we power down/up firmware, and during power up we go the reset path 
where IRQ would be enabled back in below calls:
	CE irqs: ath11k_core_qmi_firmware_ready() -> ath11k_core_start() -> 
ath11k_hif_start() -> ath11k_pci_start() -> ath11k_pcic_start() -> 
ath11k_pcic_ce_irqs_enable()
	DP irqs: ath11k_core_qmi_firmware_ready() -> ath11k_hif_irq_enable()
> 
> just concerned about the lack of symmetry here
Yes, also noticed it but didn't figure out a better way.

> 
> /jeff

