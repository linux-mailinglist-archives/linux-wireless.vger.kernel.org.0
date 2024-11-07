Return-Path: <linux-wireless+bounces-15108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B0F9C0D05
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 18:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D500285499
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9AE216DE8;
	Thu,  7 Nov 2024 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hn7N4yit"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD8E21620A;
	Thu,  7 Nov 2024 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001013; cv=none; b=h0rvCWq/S459xTJM95VfuouF23TyVxMGIVQZqJLAoR4a30VJFgULWtVVJ+oKRT0NZK1IT0z4rKUvi6bIns5siKsjLt2zgMrJqBNWHGYdY98Qey+AyPtsp4VAGro/lRu6kFe4ovXPqqQo7nweObRi7e+uC0xSHnAF7BEEprHeLzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001013; c=relaxed/simple;
	bh=Ni91XCvSWqgPC8yJ83O+0MgR6E7Tj+zdm+wyD2OMSEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f5qfcbwzpYISTKWCHv0Yv4LEyznr+NzuO2JNo3jTD8L+g2FqXfS36fT6DHqIpvmQKN3tBs1PpBAPki8MHJqjlhPA7coTmYJB0QhySQcUzJRUBqqCV2Lgoom8lvZ5KnMt7cYcufSlquao4J7S4GjWhfiaufSwl55BMh8P/o7a7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hn7N4yit; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HLZCj020647;
	Thu, 7 Nov 2024 17:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s0rdTfLxHXh4Azbw6tlMVAkBP0BJZluXJ5wiWe+4++Y=; b=hn7N4yitYZQ51PbR
	N0x+y+WALX/gKwJNKopGFc9IyrugOQQRj82//r3WfC1jk/GGo47Ui28vV7GvHgSz
	GwwmBsLqVP0tvLacXgxQFfFsz+sVDG89XOfL+a6HDHtKLPFGln/YVv1cURZgR56P
	GpHjiJ4O4o2lf5n/sO4cBxM8j5u36+JbzUQ96BW8fn0lLXyWiqOdtnwPRAA4m2vw
	GqDZSLKtM5ZsbfHAFcM3wMXMElTEPyF74jd2Zh/pKfYCGTl7Jtcw7/on7xqnW3FA
	Lf/fT3yFqvz459nBO+MTw+ecp4bFycGGr60zVRzKyFnmXUhd+wuUe16GbMFkXkiU
	p9eB1g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ry700mvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 17:36:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7HaWud008817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 17:36:32 GMT
Received: from [10.48.242.241] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 7 Nov 2024
 09:36:31 -0800
Message-ID: <fa1c6387-e6cf-4508-850b-fc5f8ef126ce@quicinc.com>
Date: Thu, 7 Nov 2024 09:36:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/5] dt-bindings: net: wireless: Describe ath12k
 PCI module with WSI
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
 <20241105180444.770951-2-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241105180444.770951-2-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C9Utvv_E6VIwf5hGWeuU7Q3HFnbfRwOb
X-Proofpoint-ORIG-GUID: C9Utvv_E6VIwf5hGWeuU7Q3HFnbfRwOb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=850
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070138

On 11/5/2024 10:04 AM, Raj Kumar Bhagat wrote:
...
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
> @@ -0,0 +1,205 @@
...
> +maintainers:
> +  - Jeff Johnson <quic_jjohnson@quicinc.com>

please replace with jjohnson@kernel.org when you post v4


