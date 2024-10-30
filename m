Return-Path: <linux-wireless+bounces-14752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98299B6E12
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 21:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D85A2814F4
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 20:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED1E215010;
	Wed, 30 Oct 2024 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e2OzAGta"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1501EC016;
	Wed, 30 Oct 2024 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321323; cv=none; b=MPZu1YCWOdEaVOfkYDbfkiEC3KApyoSWMY+8au5aDgF1xYKCVdnJBWrIVshcfb0Psh/uDNPbR7JHdrUpYV/Xqa63nhboyCJL/G1BRSOQnB4/xunv8EO1JfJYInbhEYfTD+vb2rF1HmeLQ8ZWe3D21p9w7UZj6zMOagWW7t1Cb9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321323; c=relaxed/simple;
	bh=dQZjc7y8gqIlBQhCFx4XdLHsvRVBdaQFmbtnY4ikP9k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=eDrGb94qCGNfy7ZZ3aUvtZIvS6LtLAM11wFNsuMtSq0n6WcdmWIrApZvNXMHre0ycU7X0qRGfVLy/qc+yuyw2F7DOmONSwariwomH7rmFU5E/YiwEMYXCt+MZAmMaUzIw42QdVDb/XMcg/9fBS0zkJ4q8DUvhgh9kMh5mgNrCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e2OzAGta; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UJDuh5007329;
	Wed, 30 Oct 2024 20:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BdPiftZCGikrsqw0/qKY5H5erpVvYTx3MSTxwYAodRs=; b=e2OzAGtaMD9+PYr9
	9ze+VoTOIdq82fgm4ygcs0EMeiYxOUwH/qHfV3PP3moPM1xUUA/EoKlqg31zJbW/
	YR9goLkVeiqSwgHuCUjUNVZazM7qeISmc78ZAvLN+s7WMJEv/yRFA3/0WlO2xHYd
	IGjK0ArzV3H8FImmViyaTE5n1Cnjj5WLYVpbrLPCvnHfhzHzfOMaBcYRUYBpnxEY
	4v0UWHlg5E3GqiHolj2QLr3YP8HwSXV4bqmLVSQ+jvBPJssiLWQEhpEowHsHnogm
	YxcMOIYFxoY46v5Ob+2Qg7C62GfrAqcwaRVpFvjm31p1TsfceksOjSU5DkF32+Pd
	SqDg2Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42khqbsxb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 20:48:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UKmWEV032026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 20:48:32 GMT
Received: from [10.48.242.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 30 Oct
 2024 13:48:31 -0700
Message-ID: <d3f1b608-8549-4846-866e-81f785ee5a59@quicinc.com>
Date: Wed, 30 Oct 2024 13:48:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] dt-bindings: net: wireless: ath12k: describe
 WSI properties for QCN9274
From: Jeff Johnson <quic_jjohnson@quicinc.com>
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
References: <20241029173050.2188150-1-quic_rajkbhag@quicinc.com>
 <20241029173050.2188150-2-quic_rajkbhag@quicinc.com>
 <4d273cac-8955-4850-bd8a-0bad318c1e4f@quicinc.com>
Content-Language: en-US
In-Reply-To: <4d273cac-8955-4850-bd8a-0bad318c1e4f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mRYVMkxKpQp7PA2ctfUAP0fhLQ3TBN2d
X-Proofpoint-ORIG-GUID: mRYVMkxKpQp7PA2ctfUAP0fhLQ3TBN2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=848
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300163

On 10/30/2024 12:04 PM, Jeff Johnson wrote:
> in the description above you have two different diagrams:
> - one that shows 3 pcie* devices in a single group with apparently one port
> per device
> - one that shows 4 pcie* devices split into two groups of two, again with
> apparently one port per device
> 
> but in the representation that follows you describe three pcie* devices, each
> with two distinct ports, all 6 of which are part of group 0.
> 
> can we have diagrams that match the actual bindings. does the real product
> actually have 6 ports in one group?

After stepping away and then coming back and reading the dts change I now
understand that each device has two ports, a tx and an rx port.

/jeff

