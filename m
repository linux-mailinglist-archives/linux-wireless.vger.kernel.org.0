Return-Path: <linux-wireless+bounces-26166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E21AB1C149
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 09:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA0418A8205
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 07:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2530521A94F;
	Wed,  6 Aug 2025 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cdb9xuXb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E62219311;
	Wed,  6 Aug 2025 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754465148; cv=none; b=qg/a8WsguTBXuHWNNTsQSibpXFK1cRc0wq8s2c9XIB7iNX09HuM3xnhrZdgcFH6UgDmOXfc89aH3kzXNk1bhs+t4JbgJhAi+Bb/hGMjdvAb5X/lXcb7yvKw5R+ll6yoAw08752eftbiXbthpHaw/fxHi1WCFU0eurV0cBwOaO1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754465148; c=relaxed/simple;
	bh=3q3CjfbHSWlzB+JVF2qlhl+e9zHvaojcn0S6SvoA5Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gL3BuLaVqgCNZXDfr6gDekX76U/2YRAMPBemIdAUGJSC0DxipfeK2Rpxmzi+4UoDkLSWxl9MRiRGvBZG00RyOGVVI08+jdgfOklZpCRD/+LHhKq4T3112nzPlXyV9HohG07OUBEs09vwz3SlnZDi/cFEB1Ra4c3ii92nmKSMzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cdb9xuXb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766PgmD022277;
	Wed, 6 Aug 2025 07:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2nqQ0K0cV3yjbvs90QWBSQ0QBNQ/gxQbHXc2pXA4sAo=; b=Cdb9xuXbEqfoUEj2
	tdCBIe/nh8BUqzavgGsUib2caarmcLxi7GPshpciioGfvUiWvYSlr9rQitTH72j8
	6i4f7C/az29HPUJt6toCTrmeL3vNthFwaB6XwKdjMceg1RXfKGAQTPtzoNusyeEf
	nv5B8F+6hqJzRPjePal2EIWruYXVlwcYtC6hXreLLjOdaxZ5L3scloXZbf074oKx
	9HEk0skE/q8uYFEYgwTaw1055r/X4Y9tC7G8GyAcqL8S3ptP1LPJKd483u72qvrq
	13n1MhRfo34Xtw+/xwv7sTFIlS1G0nEYa16F0lpxTIKe2ejXmqilCLs5roe+O9cu
	7Tk8RA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy89q7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 07:25:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5767PaYX002896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 07:25:36 GMT
Received: from [10.50.25.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 6 Aug
 2025 00:25:31 -0700
Message-ID: <ac14b632-91ec-58a7-26cc-23d0056222b9@quicinc.com>
Date: Wed, 6 Aug 2025 12:55:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] soc: qcom: mdt_loader: Remove pas id parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Vikash
 Garodia" <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@oss.qualcomm.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-remoteproc@vger.kernel.org>,
        "Bjorn
 Andersson" <bjorn.andersson@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
 <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
Content-Language: en-US
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KOi4YqLNCKZAqLXV9R7gOyrdCUchfY9H
X-Proofpoint-ORIG-GUID: KOi4YqLNCKZAqLXV9R7gOyrdCUchfY9H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX0TQ9K+31ta3c
 t63cut98vJ4sgHPI43G//saEJRq/ZyO5GPLiLgBOwUW09EuKlJTiihKQW+cUcPbDRLCpia7+f5K
 kJDAcAv3J9UapI+be22L40HnaJQl3OzsoKb0LrgPCJADMXOQl4GnSKR4CmEdPtfldS8E85t03uS
 OOL2Y+bS0GyPYpHivZnkCDFgs6po2qzp8vL5TAYtG00plNETpXrehVi8cPOth+U7YC1oE4NLVU6
 ucUP/75CScU0FnOdDlrEdZ2GFa+w1GcuOCVQ6RecHh2nXDk7LOIk4CJxRKo7Pj1cPEVtEM03vRs
 UKHU5NbWCV64q1KXjbklPJ/4kYX0kFQ3smV2F2xWzM9BC5PHZXsApD3oQz+WcYP478vXczV3sS6
 6WgiEJTJ
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=68930371 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=iBbKO0qNdUk1ZPghfYAA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009



On 8/4/2025 6:11 PM, Mukesh Ojha wrote:
> pas id is not used in qcom_mdt_load_no_init() and it should not
> be used as it is non-PAS specific function and has no relation
> to PAS specific mechanism.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/venus/firmware.c |  4 ++--
>  drivers/net/wireless/ath/ath12k/ahb.c        |  2 +-
>  drivers/remoteproc/qcom_q6v5_adsp.c          |  2 +-
>  drivers/remoteproc/qcom_q6v5_pas.c           |  7 +++----
>  drivers/remoteproc/qcom_q6v5_wcss.c          |  2 +-
>  drivers/soc/qcom/mdt_loader.c                | 14 ++++++--------
>  include/linux/soc/qcom/mdt_loader.h          |  7 +++----
>  7 files changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 66a18830e66d..862d0718f694 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -136,8 +136,8 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  		ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
>  				    mem_va, *mem_phys, *mem_size, NULL);
>  	else
> -		ret = qcom_mdt_load_no_init(dev, mdt, fwname, VENUS_PAS_ID,
> -					    mem_va, *mem_phys, *mem_size, NULL);
> +		ret = qcom_mdt_load_no_init(dev, mdt, fwname, mem_va,
> +					    *mem_phys, *mem_size, NULL);
>  
>  	memunmap(mem_va);
>  err_release_fw:

Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

Thanks,
Dikshita

