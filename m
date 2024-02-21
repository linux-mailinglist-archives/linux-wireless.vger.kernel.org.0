Return-Path: <linux-wireless+bounces-3875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE0A85E5E6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 19:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AB71F28BAF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7ED1272AD;
	Wed, 21 Feb 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S2531RbL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8262C126F2A;
	Wed, 21 Feb 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539893; cv=none; b=DtcUxbx6AAaBtfPsFZ0TUnCrbHziy8Eze7GXp3fhjouUTfJcVEz733RY8j3epyP7w++WZ27x7lyR90KM8ucJpmVuv6bWHdeZfTQrihg6EMRLMIrEdgy3WYFcmPN43lRleS6M6CvOeDa4q31nUSa2ZDrWJ3xUvSNUq6EpYJJI4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539893; c=relaxed/simple;
	bh=BxwxxO/7eTRN7pZB+YquD6YwDZUgoTBroSaWeFnl7Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OC/gyU5tiCTI7slzgLIAMqdQQnIz1q6ZasKWzt76fGC9VCwez53vomPVIpM1wWGHgs6dQGYAIrO47AcVtGFLx3XhaFsgBL+U9llexaTZVMI10hwL1UEXjG3W1uPSAWYhEsjBwbpQgbSrh3qzDHUB2WU1vO5CUOxNhluOpUE0FoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S2531RbL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LEnWaD021912;
	Wed, 21 Feb 2024 18:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kLiKQmvF1Vw+hboepdQr7A7saE0S87PT9STsSbbPacA=; b=S2
	531RbLY20iAJRVjrNxallRvqsFIR5N5LAeCsCSjoCxL9b40Mw/tohB+SNGGpFXnA
	6+ZQjNc8DyNDbBocGMpCDkN1nD0kSAVr+ZObTKysK/ZxMTMHitZY5TnGS4wJ8WWG
	ZNv0vWFwv72ZX0vDRxE4JJjl6JYbxlhCcilQ6c9PqzBkZvk5jxbpHUuLGgHClTpq
	OtuPAaH51wha2N1CtaB6LJSBoDTTsBBVhdfBruiNyeay9Aoj1npVJe1yBh1jlD7m
	DQYRNbXNQFNpPayFR20Fon1jm3cY3lHXlQsgp+kcavQ8dnOP1xBh9wZ7IndyhzhB
	m1BBfaPeYLS0ErYDCQ0g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdfm794cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 18:24:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LIOj5q030870
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 18:24:45 GMT
Received: from [10.110.34.22] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 10:24:44 -0800
Message-ID: <dc54be43-e27f-4b5b-9b84-cf0856370abf@quicinc.com>
Date: Wed, 21 Feb 2024 10:24:44 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: qrtr: support suspend/hibernation
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>,
        <mhi@lists.linux.dev>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240221030026.10553-1-quic_bqiang@quicinc.com>
 <20240221030026.10553-3-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240221030026.10553-3-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OYoakFoWCnbxQ2Fcz-wSJuMQ-RLpZMsT
X-Proofpoint-ORIG-GUID: OYoakFoWCnbxQ2Fcz-wSJuMQ-RLpZMsT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_05,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210143

On 2/20/2024 7:00 PM, Baochen Qiang wrote:
> MHI devices may not be destroyed during suspend/hibernation, so need
> to unprepare/prepare MHI channels throughout the transition.
> 
> The RFC version adds new API to MHI stack with which an MHI controller
> driver can do unprepare/prepare directly by itself, see
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20231127162022.518834-3-kvalo@kernel.org/
> 
> Although it works well Mani pointed out that the design is not good
> because MHI channels are managed by MHI client driver thus should not
> be touched by others. See the discussion
> 
> https://lore.kernel.org/mhi/20231127162022.518834-1-kvalo@kernel.org/
> 
> This version changes to add suspend/resume callbacks to achieve the
> same purpose. The suspend callback is called in the late suspend stage,
> this means MHI channels are still alive at suspend stage, and that makes
> it possible for an MHI controller driver to communicate with others over
> those channels at suspend stage. While the resume callback is called in
> the early resume stage, for a similar reason.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>  net/qrtr/mhi.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
> index 9ced13c0627a..b54a6c2113e9 100644
> --- a/net/qrtr/mhi.c
> +++ b/net/qrtr/mhi.c
> @@ -118,6 +118,32 @@ static const struct mhi_device_id qcom_mhi_qrtr_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(mhi, qcom_mhi_qrtr_id_table);
>  
> +static int qcom_mhi_qrtr_pm_suspend_late(struct device *dev)

Don't your new functions also need to be annotated as __maybe_unused?

> +{
> +	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
> +
> +	mhi_unprepare_from_transfer(mhi_dev);
> +
> +	return 0;
> +}
> +
> +static int qcom_mhi_qrtr_pm_resume_early(struct device *dev)
> +{
> +	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
> +	int rc;
> +
> +	rc = mhi_prepare_for_transfer_autoqueue(mhi_dev);
> +	if (rc)
> +		dev_err(dev, "failed to prepare for autoqueue transfer %d\n", rc);
> +
> +	return rc;
> +}
> +
> +static const struct dev_pm_ops __maybe_unused qcom_mhi_qrtr_pm_ops = {

this does not need to be __maybe_unused, see below

> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(qcom_mhi_qrtr_pm_suspend_late,
> +				     qcom_mhi_qrtr_pm_resume_early)
> +};
> +
>  static struct mhi_driver qcom_mhi_qrtr_driver = {
>  	.probe = qcom_mhi_qrtr_probe,
>  	.remove = qcom_mhi_qrtr_remove,
> @@ -126,6 +152,9 @@ static struct mhi_driver qcom_mhi_qrtr_driver = {
>  	.id_table = qcom_mhi_qrtr_id_table,
>  	.driver = {
>  		.name = "qcom_mhi_qrtr",
> +#ifdef CONFIG_PM

conditional compilation isn't necessary here since the 'pm' member is
always present

> +		.pm = &qcom_mhi_qrtr_pm_ops,
> +#endif
>  	},
>  };
>  


