Return-Path: <linux-wireless+bounces-7020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1860A8B67EE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 04:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCD628144A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 02:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C022205E3C;
	Tue, 30 Apr 2024 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UY0OaTdm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCF8F6D;
	Tue, 30 Apr 2024 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443786; cv=none; b=JVrvKJrOSfggO1ZNH1ZRXrVii5frC7e3dpTGJ7djNpGgZZmS9bvzfVH9QbK3I8B2WxQfQuZb4g6ZwaH7jtAqpUaQVFocroUzXjq+fe2/Su85q5jRed0/n+1fiAH8lIxtnnmKj8/2LTDdZ8oSt3p3sludmt+nNX8IRrB45VB1zBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443786; c=relaxed/simple;
	bh=Ud+LkQAh0rs5TSGiP8CU4UDW0ISa6e6QMI/5JKf7Src=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZulxAXnq+mOXX/Q0RmjBfTd9z33g+3wSez0r0pDRcE2w9N6ipHSR3nxKFt0BgeCpJxi33CveB6MQJV6fxEhywn6BIw0iqPZYgXUV1ZPtNm/VZG7i93ghonNRT52r+fT1Bbx+JgLpLcmBwR2dckbuOaiQWfjErk5hig9flT7uZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UY0OaTdm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U1dhvl006017;
	Tue, 30 Apr 2024 02:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=/JrSxKRikx/ULsd2Vwsog
	sEYAHRF6BlHCT0fKeJM9bs=; b=UY0OaTdmqwei13HTBSTyzdwP1UyTec71uVyRJ
	BJV+KUsp2Su5z9WasHtej4rHA9D8yGrUvWnRBWB544MsELuAXE54Y9url1n6SlcS
	lw3vHmXFX82qP/vrC4b9/UnUHxIUvATGNrWpCPe/B3jv8ov7A4JBNKO5kYqlsBTL
	mcc1HK2mUkPG9fDdHce1cxwIJEKR4bkLePcSK9wFW1wbrJ9YBnyF3TYgoVno40PU
	xX60BhU0yZ+EoyVlx064EEpGD5sXZ/50UTNpiISvoJQ/ag7QcD6Si28f/6yOO3kJ
	e6txVr9R6MxvU+yZMFwCcwhO/c/Mgunu5DoDcSr/TS6vWcMdA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtaf3c4gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 02:22:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U2MpAm006636
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 02:22:51 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 19:22:51 -0700
Date: Mon, 29 Apr 2024 19:22:50 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Marc Gonzalez <mgonzalez@freebox.fr>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k <ath10k@lists.infradead.org>,
        wireless
	<linux-wireless@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>, MSM
	<linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        "Arnaud
 Vrac" <avrac@freebox.fr>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Jami Kettunen <jamipkettunen@gmail.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Alexey Minnekhanov
	<alexeymin@postmarketos.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Message-ID: <ZjBV+th9DmnNLhnN@hu-bjorande-lv.qualcomm.com>
References: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
 <54ac2295-36b4-49fc-9583-a10db8d9d5d6@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54ac2295-36b4-49fc-9583-a10db8d9d5d6@freebox.fr>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1oB5qNag3a0wxUSUDP-oPFDthv-01A9U
X-Proofpoint-ORIG-GUID: 1oB5qNag3a0wxUSUDP-oPFDthv-01A9U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_22,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300016

On Mon, Apr 29, 2024 at 04:04:51PM +0200, Marc Gonzalez wrote:
> The ath10k driver waits for an "MSA_READY" indicator
> to complete initialization. If the indicator is not
> received, then the device remains unusable.
> 
> cf. ath10k_qmi_driver_event_work()
> 
> Several msm8998-based devices are affected by this issue.
> Oddly, it seems safe to NOT wait for the indicator, and
> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
> 
> Jeff Johnson wrote:
> 
>   The feedback I received was "it might be ok to change all ath10k qmi
>   to skip waiting for msa_ready", and it was pointed out that ath11k
>   (and ath12k) do not wait for it.
> 
>   However with so many deployed devices, "might be ok" isn't a strong
>   argument for changing the default behavior.
> 
> Kalle Valo first suggested setting a bit in firmware-5.bin to trigger
> work-around in the driver. However, firmware-5.bin is parsed too late.
> So we are stuck with a DT property.
> 
> Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>

This says "Pierre-Hugues certifies the origin of the patch" then "Marc
certifies the origin of the patch". This would have to imply that
Pierre-Hugues authored the patch, but you're listed as the author...

Perhaps a suitable answer to this question would be to add
"Co-developed-by: Pierre-Hugues ..." above his s-o-b, which implies that
the two of you jointly came up with this and both certify the origin.


Other than that, I think this looks good, so please upon addressing this
problem feel free to add my:

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> index 9b3ef4bc37325..9070a41f7fc07 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> @@ -122,6 +122,11 @@ properties:
>        Whether to skip executing an SCM call that reassigns the memory
>        region ownership.
>  
> +  qcom,no-msa-ready-indicator:
> +    type: boolean
> +    description:
> +      Don't wait for MSA_READY indicator to complete init.
> +
>    qcom,smem-states:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: State bits used by the AP to signal the WLAN Q6.
> -- 
> 2.34.1
> 

