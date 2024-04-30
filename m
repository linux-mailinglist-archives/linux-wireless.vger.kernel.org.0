Return-Path: <linux-wireless+bounces-7019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E338D8B67E7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 04:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F68E1C2237C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 02:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EC98C10;
	Tue, 30 Apr 2024 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iML3sVke"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514261C33;
	Tue, 30 Apr 2024 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443549; cv=none; b=UgXmLcD9QAvHXCZN16mBPeHIiPU/TliBdSvD9PxxEn/S0Pk+SGG+CqR9AwPbVBHbxA+mn2j7f0Z4GinHPdB32gEi4yPM//5wHmzBn5gcsdHk2Q6mhV9yuS9ZNV9J7gYlFLIXMK86G/mO54URY7XOiLS/g4It2QGAPAZ5U34Rg48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443549; c=relaxed/simple;
	bh=Z7K0gOXFRxt3LwB2Y7bmrDi+yGHhiUXJA33b4WlHP5I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5vdZp6zotXffXphBRmbizDnQa7gS8kAaW/Q6TYZFIfG+2JUvyLPTKuid43eGKPXeXYGy5Pku/sq1KpIyRUlD5SB68xvgP5WaFL1GFzU8dnaw63U9xebUHsFKUk/OUruAQ4n11fkcu/ojtJ1xInCgkwEHK9MD3lrPkY27U0ljwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iML3sVke; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U28gUO025662;
	Tue, 30 Apr 2024 02:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=4CllrCgnnFB2Wr4UN0fdY
	d/y9OMoKqDaEtt4RXkUtBY=; b=iML3sVkeDd+7ObHktgmy4sHyMiR/aPJyKaFES
	okXBz1bc8g/W7X45l1Pq34qXsGli/VlBVFfERsEg9YUWz0iKy36GE+Qs7gpevLTD
	WdePWsdwyEG6b24ECKUBSeakOxszRZHPJPaXhFwApYO3dVICfFbAFuO/eUH70ZLA
	1+g+HzDl3AvGb3qWs9zKBIoJ3iF/MxLuXAT4SGxHUjYJ/l2/d+tilge5Wq3nwk6c
	jAP3m9MndE7irpRo0JzdbftDIudlO85eXEAKxREA+YemLZVYk4/cpLUwebt3HsAn
	86d661YyGZ9sGmW2jcfr6vqa/zuaqBERWyQu2HGcSZ0ISq0TA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtqkr8102-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 02:18:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U2ItiO002112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 02:18:55 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 19:18:55 -0700
Date: Mon, 29 Apr 2024 19:18:54 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
CC: Marc Gonzalez <mgonzalez@freebox.fr>, Kalle Valo <kvalo@kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>,
        ath10k <ath10k@lists.infradead.org>,
        wireless <linux-wireless@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: Re: [PATCH v3 0/3] Work around missing MSA_READY indicator for
 msm8998 devices
Message-ID: <ZjBVDkc2KGIUxwbg@hu-bjorande-lv.qualcomm.com>
References: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
 <463bcd2f-c741-4120-b7ae-2bb55d5211e3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <463bcd2f-c741-4120-b7ae-2bb55d5211e3@linaro.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vNH_vqNqQ1j1KxSTV5KOc7DibHJOU5Ps
X-Proofpoint-ORIG-GUID: vNH_vqNqQ1j1KxSTV5KOc7DibHJOU5Ps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_22,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300016

On Tue, Apr 30, 2024 at 12:24:40AM +0100, Bryan O'Donoghue wrote:
> On 29/04/2024 15:01, Marc Gonzalez wrote:
> > Work around missing MSA_READY indicator in ath10k driver
> > (apply work-around for all msm8998 devices)
> > 
> > CHANGELOG v3
> > - Add a paragraph in binding commit to explain why we use
> >    a DT property instead of a firmware feature bit.
> > - Warn if the "no_msa_ready_indicator" property is true,
> >    but we actually receive the indicator.
> > 
> > Marc Gonzalez (3):
> >    dt-bindings: net: wireless: ath10k: add qcom,no-msa-ready-indicator prop
> >    wifi: ath10k: do not always wait for MSA_READY indicator
> >    arm64: dts: qcom: msm8998: set qcom,no-msa-ready-indicator for wifi
> > 
> >   Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml |  5 +++++
> >   arch/arm64/boot/dts/qcom/msm8998.dtsi                           |  1 +
> >   drivers/net/wireless/ath/ath10k/qmi.c                           | 11 +++++++++++
> >   drivers/net/wireless/ath/ath10k/qmi.h                           |  1 +
> >   4 files changed, 18 insertions(+)
> > 
> 
> I wonder if you could infer the workaround based on firmware version,
> instead of kernel passed flag ?
> 

It's been a while, but I attempted this for the similar workaround for
SDM845 RB3 et al. I vaguely remember concluding that the different
devices I worked on, had firmware from different branches without any
suitable version scheme to use for such comparison - which is why we
have "qcom,snoc-host-cap-8bit-quirk;" in those nodes (which apparently
is not documented in the yaml).

I'd also rather see us ask Marc spending time on some more fruitful
exercise...

Regards,
Bjorn

