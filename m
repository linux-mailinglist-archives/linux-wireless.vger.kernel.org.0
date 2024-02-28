Return-Path: <linux-wireless+bounces-4204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D432B86B328
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 16:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B49C1F24A29
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 15:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0719315B99B;
	Wed, 28 Feb 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WqlwM7FB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A74C65;
	Wed, 28 Feb 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134299; cv=none; b=pjcwD/I9o4S2cxcVghCW/hql9d2sGZIUE5IIa8zQivpFqf1F8qkvWP9+1Bhh8gANi7kdEJcEWclOQKSffM4MhIzNJ3+tlGSiL2hfhktPaRvP8ItXcT5r9Sjhb+D1MMeJEmpczbultg2Ssrg7M3NAEjYAnevsYSAVWfCzqshMsHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134299; c=relaxed/simple;
	bh=QMimz9gLzaGvecyK308RM7xhA4pWKTf2vO3HZ8IeD84=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j5jKuD10McgIJhnIJaSYCupYPgg9B2MkdVBgPU6jrSTiQgHgt4ifVkVOxhUCjfDbXltMlEmNnlB/lskdS6lQuonLP7qUsrABaRPX2Cr8txs+QYERyooaDXqDoW6ENeop9KnDb84rnvVlan4yyXNhA28O1yJcfqDONLntGSmh8rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WqlwM7FB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S8L3pR022917;
	Wed, 28 Feb 2024 15:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0tNc5re6i+mwAZj+uiyiJIhCAnBHBGUPnGZN4DVUiy0=; b=Wq
	lwM7FBpz0QNY1uh3oR6Bwb47Wq//aPhVRzNfYANoVw6heHHVOXSO949UiEIQeSgY
	Lh3g4SR7FyMEsAjYEd/N78NzrVqGTzAbINS7RL8FtU4ZIO1OgbRKoZeu/tqiU253
	S6HHVPMEnXGTn8eC0WnkWi+8LcpiHCF7jZXOpDchmubaohjdKrJPnaZm7s25NiAP
	8VfvF1gXaZ6iHZJul4Ahe49C8TKpcEQ03eU0/Q9p0RgI3Y4WD3ZAlV17Aqn1BBmX
	UmkQyOJvWwHdk9wMeutUIE1mZSgj0Jo2WZZ5o6KByKbL5LThxkQXExEQuOQFM/2e
	I4m9LCy0ZyS//ubkdPOw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whuksspqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:31:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SFVLQF032473
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:31:21 GMT
Received: from [10.110.113.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 07:31:20 -0800
Message-ID: <ae3ec744-2157-4a8c-aa1b-38a22dc18042@quicinc.com>
Date: Wed, 28 Feb 2024 07:31:20 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] wifi: ath11k: support hibernation
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>,
        <manivannan.sadhasivam@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20240228022243.17762-1-quic_bqiang@quicinc.com>
 <20240228022243.17762-4-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240228022243.17762-4-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F_vfeW3gW3zYQ68-plABaUfhw9KneFcE
X-Proofpoint-ORIG-GUID: F_vfeW3gW3zYQ68-plABaUfhw9KneFcE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280121

On 2/27/2024 6:22 PM, Baochen Qiang wrote:
> Now that all infrastructure is in place and ath11k is fixed to handle all the
> corner cases, power down the ath11k firmware during suspend and power it back
> up during resume. This fixes the problem when using hibernation with ath11k PCI
> devices.
> 
> For suspend, two conditions needs to be satisfied:
>         1. since MHI channel unprepare would be done in late suspend stage,
>            ath11k needs to get all QMI-dependent things done before that stage.
>         2. and because unprepare MHI channels requires a working MHI stack,
>            ath11k is not allowed to call mhi_power_down() until that finishes.
> So the original suspend callback is separated into two parts: the first part
> handles all QMI-dependent things in suspend callback; while the second part
> powers down MHI in suspend_late callback. This is valid because kernel calls
> ath11k's suspend callback before all suspend_late callbacks, making the first
> condition happy. And because MHI devices are children of ath11k device
> (ab->dev), kernel guarantees that ath11k's suspend_late callback is called
> after QRTR's suspend_late callback, this satisfies the second condition.
> 
> Above analysis also applies to resume process. so the original resume
> callback is separated into two parts: the first part powers up MHI stack
> in resume_early callback, this guarantees MHI stack is working when
> QRTR tries to prepare MHI channels (kernel calls QRTR's resume_early callback
> after ath11k's resume_early callback, due to the child-father relationship);
> the second part waits for the completion of restart, which won't fail now
> since MHI channels are ready for use by QMI.
> 
> Another notable change is in power down path, we tell mhi_power_down() to not
> to destroy MHI devices, making it possible for QRTR to help unprepare/prepare
> MHI channels, and finally get us rid of the probe-defer issue when resume.
> 
> Also change related code due to interface changes.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Tested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c  |   6 +-
>  drivers/net/wireless/ath/ath11k/core.c | 105 +++++++++++++++++--------
>  drivers/net/wireless/ath/ath11k/core.h |   6 +-
>  drivers/net/wireless/ath/ath11k/hif.h  |  14 +++-
>  drivers/net/wireless/ath/ath11k/mhi.c  |  12 ++-
>  drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
>  drivers/net/wireless/ath/ath11k/pci.c  |  44 +++++++++--
>  drivers/net/wireless/ath/ath11k/qmi.c  |   2 +-
>  8 files changed, 142 insertions(+), 52 deletions(-)
...snip...
> +int ath11k_core_resume_early(struct ath11k_base *ab)
> +{
> +	int ret;
> +	struct ath11k_pdev *pdev;
> +	struct ath11k *ar;
> +
> +	if (!ab->hw_params.supports_suspend)
> +		return -EOPNOTSUPP;
> +
> +	/* so far signle_pdev_only chips have supports_suspend as true

nit: s/signle/single/

> +	 * and only the first pdev is valid.
> +	 */
> +	pdev = ath11k_core_get_single_pdev(ab);
> +	ar = pdev->ar;
> +	if (!ar || ar->state != ATH11K_STATE_OFF)
> +		return 0;
> +
> +	reinit_completion(&ab->restart_completed);
> +	ret = ath11k_hif_power_up(ab);
> +	if (ret)
> +		ath11k_warn(ab, "failed to power up hif during resume: %d\n", ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(ath11k_core_resume_early);
>  
>  int ath11k_core_resume(struct ath11k_base *ab)
>  {
>  	int ret;
>  	struct ath11k_pdev *pdev;
>  	struct ath11k *ar;
> +	long time_left;
>  
>  	if (!ab->hw_params.supports_suspend)
>  		return -EOPNOTSUPP;
> @@ -940,29 +990,19 @@ int ath11k_core_resume(struct ath11k_base *ab)
>  	if (!ar || ar->state != ATH11K_STATE_OFF)
>  		return 0;
>  
> -	ret = ath11k_hif_resume(ab);
> -	if (ret) {
> -		ath11k_warn(ab, "failed to resume hif during resume: %d\n", ret);
> -		return ret;
> +	time_left = wait_for_completion_timeout(&ab->restart_completed,
> +						ATH11K_RESET_TIMEOUT_HZ);
> +	if (time_left == 0) {
> +		ath11k_warn(ab, "timeout while waiting for restart complete");
> +		return -ETIMEDOUT;
>  	}
>  
> -	ath11k_hif_ce_irq_enable(ab);
> -	ath11k_hif_irq_enable(ab);

these are disabled in suspend_late()
do you need to enable in resume_early()?
or are they expected to be enabled via ath11k_wow_op_resume()?

and if that is the case, why isn't the disable in
ath11k_wow_op_suspend() sufficient? can the disables in suspend_late()
be removed?

just concerned about the lack of symmetry here

/jeff

