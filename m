Return-Path: <linux-wireless+bounces-4264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E99D986D39E
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 20:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF6EB2552E
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76461428FD;
	Thu, 29 Feb 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H9Yc8el0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C871428EF;
	Thu, 29 Feb 2024 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235990; cv=none; b=GAlizf0hN1G0dS2UDJh4A2H1hEWTVcsRLem4TZiAUHTB3hPC4yjjdmTciBOz0r2uyL8QkZ1W/zWYCeLFtSDpl+RNRUkxxCFDc7nCvKEfm+SvYmlQHsPaO7EnwKk2mM/IsLa67d4BUpqhqnCNfPwZsQsPf32xRQmFFSZQnEdaLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235990; c=relaxed/simple;
	bh=N60hj8bK/MPHewnHLJwKqCbGV5X7NGgQaRg8sEUD/Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XwjjG9TJrd9wcWA/Tgeqd42KIE31TT0/hh3luC9CyOtIJJJUT0pwknzPxxLLswV9fr5/bx5SYoeWSGdzDSRaiDdtmCBThfj53FnTOGMA/C7zkohrrdlSfAA95FLKcclR5fA3Zlo3UpbpfC5liqRVeWRVIMZzRneuRXJbq4rPQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H9Yc8el0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TIdBlV005591;
	Thu, 29 Feb 2024 19:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+KelDty0wxWhCzXHAyYD6vlvmk+OW6Qo5uQybSHnaZM=; b=H9
	Yc8el075J3+8d4GD+nXf4h14nKsA1sR2Ht+4v97h1Y9nh2MZQP7f8uDDYY+SwYgd
	FYBiZiggDpApdRzW3WS94fUn/USZruUOzS/JDb12jnU2G5cfsexhpGvA9B+sXS1c
	nmywECm/q2iiNv2PdVhZVpLuNZzLCEk8P+Z0b07SO2ZFEES9UDkla5ZX0bLHgQKs
	hU2uSQld01PLQT6dNV70RbUcg+yTln/N+IT8Y7MK6c+oGo3tXsfSo4VHUqiv8NUX
	O80TzPNEnU69LMGaGr1lZkzjjpvLn6wGY0N3Ge/iZX4R17DdVIEdcvZ9Q9sWt4u8
	drifnT32MVK1g/gcfLiw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjkkqabgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 19:46:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41TJkIqn018607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 19:46:18 GMT
Received: from [10.110.42.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 11:46:17 -0800
Message-ID: <c48ead11-0e2a-4066-b324-84f802215c9a@quicinc.com>
Date: Thu, 29 Feb 2024 11:46:16 -0800
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
To: Conor Dooley <conor@kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: Marc Gonzalez <mgonzalez@freebox.fr>, ath10k <ath10k@lists.infradead.org>,
        wireless <linux-wireless@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Jami Kettunen
	<jamipkettunen@gmail.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <20240229-ageless-primal-7a0544420949@spud>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240229-ageless-primal-7a0544420949@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ra0XPkIMN5IYWwSyBqp93GD6FLSAijgU
X-Proofpoint-GUID: Ra0XPkIMN5IYWwSyBqp93GD6FLSAijgU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_05,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=709
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290153

On 2/29/2024 10:40 AM, Conor Dooley wrote:
> On Wed, Feb 28, 2024 at 06:37:08PM +0200, Kalle Valo wrote:
>> Marc Gonzalez <mgonzalez@freebox.fr> writes:
> 
>>> As mentioned in my other reply, there are several msm8998-based
>>> devices affected by this issue. Is it not appropriate to consider
>>> a kernel-based work-around?
>>
>> Sorry, not following you here. But I'll try to answer anyway:
>>
>> I have understood that Device Tree is supposed to describe hardware, not
>> software. This is why having this property in DT does not look right
>> place for this. For example, if the ath10k firmware is fixed then DT
>> would have to be changed even though nothing changed in hardware. But of
>> course DT maintainers have the final say.
> 
> I dunno, if the firmware affects the functionality of the hardware in a
> way that cannot be detected from the operating system at runtime how
> else is it supposed to deal with that?
> The devicetree is supposed to describe hardware, yes, but at a certain
> point the line between firmware and hardware is invisible :)
> Not describing software is mostly about not using it to determine
> software policy in the operating system.

FWIW I've compared ath10k to the out-of-tree Android driver and there
are discrepancies in this area. I've asked the development team that
supports ath10k to provide a recommendation.

/jeff

