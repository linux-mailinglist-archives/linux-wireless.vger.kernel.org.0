Return-Path: <linux-wireless+bounces-7964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427188CC6D0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 21:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA65282071
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9A3145B35;
	Wed, 22 May 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GvZ1JmSf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA04D51E;
	Wed, 22 May 2024 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716405738; cv=none; b=UC2EoYqIh8pLw/ourwgQgXLxVn1l/n0xbYwz0f4N+QJpk+alJOuBOH4lNpIE6v8aDJxw+ok2lnhC1lpdhEKXShYWPS5W1OWpFfMRyeJhsHAEKggB3+NEkpsXMkK64RnB/VgHdkOq09/VBAUHhOhI/SNbYlfQH/Jp3g7lTN/tX5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716405738; c=relaxed/simple;
	bh=0+7xrxHcIqXbOHoXrH88X8Y9k/W+g9wVdubBgA6njtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=anp9vaEcf6CkQ6UF7QVpO2Jq8gg1q10m7y0aTw8hlzvKCSiNfLk2nqyDSsjZE1sClkhnOXJc22zAnIF2Ia2qBOmbgkcHc51YLfy1/RdHdGOAZhjj+uu0lqR287BDY+6SZBmLRPkTjyyQO6GOldX6BerMHgLcu9z6TIHlTtE0tU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GvZ1JmSf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MAGZHn010057;
	Wed, 22 May 2024 19:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7Y/RN1PFOa+6BTPyCnx/ocDE9nnxvEeXbmZ9MEkrzO4=; b=Gv
	Z1JmSfS1vvNVPQTnLGqdl+x9gxWcNFS4ntVe5Eq94REbmTW454DnozK9aOC3zrgC
	88C413A/v/akbbc2Wo9pS+4jteqrVNTEfZbtmOMRLty7NPxRMI2K0M2yYrbYLRGE
	qobUyNBFTHj+I9b+S/LrkWX9vxZX+H91rsJrB3/DjkANzM9iqgJeAD/cvtndKmU2
	9DLHOlmOz7OPuzgzM0dfRv7wTiO/EmaI3865ZeOwliasLDLmzqg/j9bWe9MfmYua
	2+HU8WMIhgKXBuGqmxn1rDhyYVSj5JvWbEM6X/zBOqYkVv41s+jmp3MbVmecBi8E
	s49B9m5b37OUOxrWufzg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4ghuht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 19:22:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44MJLx7C018637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 19:21:59 GMT
Received: from [10.110.17.44] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 22 May
 2024 12:21:58 -0700
Message-ID: <a553622c-7576-4662-abac-68abe7ea7918@quicinc.com>
Date: Wed, 22 May 2024 12:21:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] remoteproc: qcom_wcnss: make use of QCOM_FW_HELPER
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic
 Poulain <loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <wcn36xx@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Arnd
 Bergmann <arnd@arndb.de>
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
 <20240521-qcom-firmware-name-v1-9-99a6d32b1e5e@linaro.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240521-qcom-firmware-name-v1-9-99a6d32b1e5e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6Cd_Uw9DlpwQ2Q_X57Sv7uAZhpOsr7NT
X-Proofpoint-ORIG-GUID: 6Cd_Uw9DlpwQ2Q_X57Sv7uAZhpOsr7NT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_10,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220134

On 5/21/2024 2:45 AM, Dmitry Baryshkov wrote:
> Make the driver use qcom_fw_helper to autodetect the path to the
> calibration data file.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/remoteproc/qcom_wcnss.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
> index 421a3943a90d..45fc578ae30b 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -23,6 +23,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/remoteproc.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> +#include <linux/soc/qcom/fw_helper.h>
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/smem_state.h>
>  
> @@ -555,8 +556,13 @@ static int wcnss_probe(struct platform_device *pdev)
>  	if (ret < 0 && ret != -EINVAL)
>  		return ret;
>  
> +	fw_name = qcom_get_board_fw(fw_name);
> +	if (!fw_name)
> +		return -ENOMEM;
> +
>  	rproc = devm_rproc_alloc(&pdev->dev, pdev->name, &wcnss_ops,
>  				 fw_name, sizeof(*wcnss));
> +	kfree(fw_name);
>  	if (!rproc) {
>  		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
>  		return -ENOMEM;
> 

can you cleanly bisect to this patch? seems it depends upon patch 10.
should 09 & 10 be swapped, or perhaps squashed?

