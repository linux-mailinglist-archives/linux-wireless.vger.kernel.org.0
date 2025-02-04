Return-Path: <linux-wireless+bounces-18425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF4A276F6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3E818858F0
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC77214A60;
	Tue,  4 Feb 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hRliQO/B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384363232;
	Tue,  4 Feb 2025 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738685803; cv=none; b=ZTmA1qvnwSeHMX/K5lojQ+gKPbDxbxjnrvrmRp8OSk8QLs+J/EOzoK6hd93lBMs7COVZDPU3lyvNdc4EeJoAtJZhBCOz3F5cLBYKTbygb6ODBFJlzRZSQGS9GwucNb/f34HhDwGPkjM507rYs+3BdkIynRfsr7c4znWuKIYeadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738685803; c=relaxed/simple;
	bh=Wm9ixR6QtXFALjs+x9GdQG7OdHTWuWrT49ASoIfXQ8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pW1I22727ti6OTRXR2kmhjo7ALrPLFhQNEhVzw6xSzSzLDcvbTk7Lem3vDzqUqLj1GCkUGIQWRmoD39uGYMBlDA+J2E1XmWeXDjNKrPyAnmnueULm4yqt44dfe7CZzhU1xFfwWnCC5ITqgCdA5cOnCQrPOgvcllx8R+V7jidDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hRliQO/B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514EWWI4016940;
	Tue, 4 Feb 2025 16:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Prt8xOPE4tzYuuC2GdD2b9BREl1EzNERXgEX3LdMYw=; b=hRliQO/BB8VXK+iU
	03snTgLVxtZUR3NwJVBTM0RlC5+q2FVKqLn5yX0Ggr70MgbMF65hkuTesT2b4UC4
	G+W6aBhrfK1axekqYqx2C1sanmhbvr23clTYStKlUQWAsjEfZ8cLGL37PT+JM2aF
	HV50cvQb1p11okbqvrrcjZEM4bP5h8IjPI9T4m3yT+UmJKBX/xXUrg9M4guxQfZ6
	vGRWutGyo/8mdu4rN960a8gRd3lHMnlKyHuRPEqiOBPxBKtDwcUdEo6lvv676zS5
	TGIUwAF+hs81dJh0S1xoGLAcmDvbaa6+7tCeMDAIJzts6p+nksD3T+WR8rpI9Rra
	IfbNDQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kmre08kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 16:16:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 514GGaWq007150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 16:16:36 GMT
Received: from [10.216.42.141] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Feb 2025
 08:16:32 -0800
Message-ID: <e05719c5-15b8-4ee7-85a3-5dd9d00f5b0e@quicinc.com>
Date: Tue, 4 Feb 2025 21:46:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/13] wifi: ath12k: Power up root PD
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Sowmiya Sree
 Elavalagan" <quic_ssreeela@quicinc.com>
References: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
 <20250130043508.1885026-10-quic_rajkbhag@quicinc.com>
 <02d3f555-c2e9-40ed-8695-8ae7f260e259@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <02d3f555-c2e9-40ed-8695-8ae7f260e259@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8WNBpYl_UMi4pz-k9IFQYjBjVXRBXcG1
X-Proofpoint-GUID: 8WNBpYl_UMi4pz-k9IFQYjBjVXRBXcG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=874 bulkscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040125

On 1/30/2025 1:28 PM, Krzysztof Kozlowski wrote:
> On 30/01/2025 05:35, Raj Kumar Bhagat wrote:
>> +
>> +static void ath12k_ahb_unregister_rproc_notifier(struct ath12k_base *ab)
>> +{
>> +	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
>> +
>> +	if (!ab_ahb->root_pd_notifier) {
>> +		ath12k_err(ab, "Rproc notifier not registered\n");
>> +		return;
>> +	}
>> +
>> +	qcom_unregister_ssr_notifier(ab_ahb->root_pd_notifier,
>> +				     &ab_ahb->root_pd_nb);
>> +	ab_ahb->root_pd_notifier = NULL;
>> +}
>> +
>> +static int ath12k_ahb_get_rproc(struct ath12k_base *ab)
>> +{
>> +	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
>> +	struct device *dev = ab->dev;
>> +	struct device_node *np;
>> +	struct rproc *prproc;
>> +
>> +	np = of_parse_phandle(dev->of_node, "qcom,rproc", 0);
>> +	if (!np) {
>> +		ath12k_err(ab, "failed to get q6_rproc handle\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	prproc = rproc_get_by_phandle(np->phandle);
>> +	if (!prproc)
> 
> Nothing improved here - you still leak the reference.
> 

Thanks, will take care of np refcount leak in next version.

>> +		return dev_err_probe(&ab->pdev->dev, -EPROBE_DEFER,
>> +				     "failed to get rproc\n");
>> +
>> +	ab_ahb->tgt_rproc = prproc;
> 
> And here.
> 

Thanks, will handle rproc refcount leak.

