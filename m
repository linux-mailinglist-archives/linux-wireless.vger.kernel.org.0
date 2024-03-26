Return-Path: <linux-wireless+bounces-5302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D8888CE37
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 21:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869D9B24D3C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7618013D50C;
	Tue, 26 Mar 2024 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iLcGReCm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F0813D266;
	Tue, 26 Mar 2024 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484500; cv=none; b=T8tm+YXcJVaRjAo2d+AaX1MVIS/0ZzmEQbp0mxrmapAF59uNHzryXrJkrmf0Xn4wgytQ8584QKOyvKKAp8U2Np3wChyZ3XSfjKyR2JBigFWzw3xi0TyGoVGpIJrS+PXyRwByFxlb5fZrPoVrlKZ78X810gGLrtQSk+h4u8zxh54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484500; c=relaxed/simple;
	bh=Zj9xZxiRH621POyDDPfyvBW+CAKirKQUnKHj+jJbDqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jtN+NywRAtPuCv0a/O7S0/o6G51AXKBWHOUzb0w3UNj7yXkHTr4psryhj+XyflKiM0Bb/Rl/XarKCvObP8WTZMrBJErhCL0+bueR2oKvlMZzSsZRUIxg5VnvhMFxL5hKO2OWSxDLADduTUk22iD09tP9SSF1dxsVmVej4Dtsm9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iLcGReCm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QJk031030462;
	Tue, 26 Mar 2024 20:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=arEoGTCZUWCWxutFceAE4m0rRT/rHcBdAsYFinq5huc=; b=iL
	cGReCm1lly3g04MpHOt5KRGF4FYqket/bQKauEHCn38nZGrmbHRmsfffw+xzsq//
	IdwmrUQopEO8WUKYE6bAviAuQwLlSLi5U4qKnMTwFjLGfqXvHxZ7KUwopEWWH2oa
	TLJ4sic+WGlf5GrVzyJIdhLqCyM29x+NmBGyjIdi6jE1/YwUla3KBdgHzKYibmFD
	mt7zbY7xUBs0bQMnVqOmlVTNK1ySGb8Lh0M53iSlBikOg+7r4i1aUGF+ke6636p6
	ZPZflfkOY1dZWNYTMdsd8YfyYfLBbcIeFD/4DlHHm3LLDC2SVP2OB3Zw6y1kbG0J
	J+dHcZ6hiEsqHB02OWcQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3q0n2ngn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 20:21:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QKLMrt011298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 20:21:22 GMT
Received: from [10.110.28.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 13:21:21 -0700
Message-ID: <4b7bf7cc-ede6-4c2a-983c-da4c8c09c5d1@quicinc.com>
Date: Tue, 26 Mar 2024 13:21:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marc Gonzalez
	<mgonzalez@freebox.fr>
CC: Kalle Valo <kvalo@kernel.org>, ath10k <ath10k@lists.infradead.org>,
        wireless <linux-wireless@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Arnaud Vrac <avrac@freebox.fr>,
        Jami Kettunen <jamipkettunen@gmail.com>,
        Jeffrey Hugo
	<quic_jhugo@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr> <87cyse8j9m.fsf@kernel.org>
 <6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr> <87plw87nsc.fsf@kernel.org>
 <0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr> <87h6hk7aee.fsf@kernel.org>
 <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr>
 <243a97b7-c298-4307-9f06-8b3a7c3e24fd@freebox.fr>
 <9293793d-00e8-42ce-87b2-05abc3b49387@freebox.fr>
 <CAA8EJppn6M9dpzyu9d283AUtaeN-i-L=-aM5P9BEELXPLFS8YQ@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAA8EJppn6M9dpzyu9d283AUtaeN-i-L=-aM5P9BEELXPLFS8YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _qISA-bD4TD7kdEs3Ay_IX7kYusR7aIm
X-Proofpoint-ORIG-GUID: _qISA-bD4TD7kdEs3Ay_IX7kYusR7aIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403260146

On 3/26/2024 10:51 AM, Dmitry Baryshkov wrote:
> On Tue, 26 Mar 2024 at 19:45, Marc Gonzalez <mgonzalez@freebox.fr> wrote:
>>
>> [ It has been pointed out to me that the previous message was unclear. ]
>> [ Below is my 2nd attempt at a clearer message. ]
>>
>> Problem: firmware-5.bin has not been parsed yet when we have to handle
>> the ATH10K_QMI_EVENT_SERVER_ARRIVE case, so we can't rely on feature bits
>> to work around the lack of MSA_READY indicator.
> 
> Then, I'd say, we have to resort to the DT property, unless Kalle or
> Jeff have other proposals.

Another option is to follow the downstream driver model and only expect this
based upon static configuration within the driver.

Downstream driver has:
	if (priv->device_id == ADRASTEA_DEVICE_ID) {
		ret = wlfw_msa_mem_info_send_sync_msg(priv);
		ret = wlfw_msa_ready_send_sync_msg(priv);
	}

https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/platform/-/blob/wlan-platform.lnx.1.0.r4-rel/icnss2/main.c?ref_type=heads#L968

The downstream MSA logic (including some other code that populates MSA-related
fields in the QMI messages) is only invoked for ADRASTEA_DEVICE_ID.

We could introduce a new hw_params parameter to have the same semantics.

But I'm OK with the DT option as well.

Kalle?

/jeff

