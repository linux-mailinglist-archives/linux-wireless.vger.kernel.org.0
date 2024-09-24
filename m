Return-Path: <linux-wireless+bounces-13121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEF89849F6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 18:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC34C28277B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 16:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66451AB6E2;
	Tue, 24 Sep 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cYe7E0cH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486291DFFB;
	Tue, 24 Sep 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196427; cv=none; b=PI4UtCkhruF7ogIcnsvXCFk+rpCOWQogVVmJURoAu7cmUbv6GKrwBBCkZ89ojpKs18XGcQyXSYq27ZnIzK1u+i2UajTwK54mwOKGnyhEhJKeUqriCgv6/uRMtpjABq/4qGtNcRMBVL1EyYG7Lmmq6731//dA89vbf26yikLnCSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196427; c=relaxed/simple;
	bh=V5hP6EhqqL1VB4vgcnWs8ptf/NEEpkNyPz1lOH4OJ5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CzMud8TsgDCtMmu7dXD0GDEMn/41Y3GsjHYaRnxZBOHqLCVoXBPE4ZKMFnO/WI019d/9jDFgXpSV1zl0KwdD8cW1BbvCUhs9ikKOb5SCI0RNdeJE6Nv98eDYOCc77ls0ThjinkrWAJiJRJ4lU+1+x5s2cV7g9aEvx0gumF2A5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cYe7E0cH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O8tmP7001351;
	Tue, 24 Sep 2024 16:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RkdDY9gEmTPSGeBmDdPmUm8d9yq71EH6PpS8U/0msmg=; b=cYe7E0cHGJIJ3PAk
	JacpGeIk75pVzzEqUn4/zEoWRhVMyuVQPQTnXCw9txb65K2jAG5ONGm0xBfabDXB
	DGYnJZBU6p8hlO/I+8xfloMziAzR91gYDQaOtwvHSLO2+87WL5BXcyTA1cuT1Jlk
	cL3lZ20NgYlZP8Qui894Sswjcr4GO1eY2RZ0OM1TA85qyETL47vtahfXbzQOmTVK
	/CDsYrWFv2kwfSMhp64r7CzGd4fPSEFymwLq5U1+GlQPQ8b3aMcC6QXqRrsIB6Am
	LfMgdNmff8oBNO8cN7iwSIhQyA23ma9Bjub3LIhhaYn4fwtnQ/2p9qlLkTci5s5R
	YAU4Fg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqakgy4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 16:46:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48OGkTJO008531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 16:46:29 GMT
Received: from [10.111.183.86] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 09:46:27 -0700
Message-ID: <312fa408-d385-4b90-b8f4-729af4a3ce65@quicinc.com>
Date: Tue, 24 Sep 2024 09:46:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20240814082301.8091-1-brgl@bgdev.pl>
 <83c562e9-2add-4086-86e7-6e956d2ee70f@kernel.org> <87msk49j8m.fsf@kernel.org>
 <ed6aceb6-4954-43ad-b631-6c6fda209411@kernel.org> <87a5g2bz6j.fsf@kernel.org>
 <CAMRc=MeLick_+Czy5MhkX=SxVvR4WCmUZ8CQ5hQBVTe2fscCPg@mail.gmail.com>
 <b7fdafd6-5029-4b80-b264-11943740b354@quicinc.com>
 <1e79d94e-2f83-4762-b126-ed865142f1ed@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <1e79d94e-2f83-4762-b126-ed865142f1ed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BXe6QtAmQNmkBdVuW9HOlyqTvxLGKz_H
X-Proofpoint-GUID: BXe6QtAmQNmkBdVuW9HOlyqTvxLGKz_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240120

On 9/24/2024 1:06 AM, Krzysztof Kozlowski wrote:
> On 20/09/2024 23:02, Jeff Johnson wrote:
>> Again, since I'm a DT n00b:
>> Just to make sure I understand, you are saying that with this change any
>> existing .dts/.dtb files will still work with an updated driver, so the new
>> properties are not required to be populated on existing devices.
> 
> Did you folks rejected patches acked by DT maintainers on basis of not
> understanding DT at all?

I personally have not rejected any DT patches. Nor have I accepted any.
I'm deferring to Kalle.

>> However a new driver with support for these properties will utilize them when
>> they are present, and the current ath11k .dts files will need to be updated to
> 
> It is not related to drivers at all. Nothing in this thread is related
> to drivers.
> 
> Can we entirely drop the drivers from the discussion?

I brought up drivers since in the discussion there was concern that this DT
change would potentially break existing devices that have a DTS that defines
qcom,ath11k-calibration-variant, and I wanted clarification on that point.

/jeff

