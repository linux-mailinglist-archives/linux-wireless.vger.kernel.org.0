Return-Path: <linux-wireless+bounces-12639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FA3970C70
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 05:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DE41C21B4C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 03:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE2318A6D0;
	Mon,  9 Sep 2024 03:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WsHefuyQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C1193;
	Mon,  9 Sep 2024 03:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725853701; cv=none; b=o8r2wyxIRi74pIgKN2xgk26LESfReZqaMnvbLDqxdirE5ONwZhH+qZlGwPK31zzSmeO2Y7D8FgESiOPTR7XH3Tvz17UwesXOH1YkYArZfWpzdN4HZKuX9o7SrInKpoTLzEyL47+l4RjD3FBFmNA6ilR0kxol+HXYXmgGsUxC2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725853701; c=relaxed/simple;
	bh=EBLlIJaE10+TLTTwu/j7Ny9Oq+hXo0DMutyWZZ5lytA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eMUkMcxK4qjDj94tM2JlIVPYHGZp2DK4JoatzmcaVfnZmgH6T14zBqJn5vqc8YsMG5iQB3oSStpoL+/ngNxG24bh0EqpsoJVaG1WgtZ68QjKw1AafttqkIiRl21XGJNHwPIVSVbm27Jpg+7vnx/+aOZxKuFXb+wcxVF7z6om9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WsHefuyQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 488NhjLc013350;
	Mon, 9 Sep 2024 03:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WzHz7THkziQEgqXPCjnx7uCmkZMMyuMMpkTozuIadsw=; b=WsHefuyQynjnRl7p
	Kn7S8F6bRyA5O+mVylAeQPnamc3iMoz/lwsA/YLk/UKwy2n5/JKHBH45ulo0y7aX
	e6WR19ZrlRiLFIIQXjrVyG5ojqSh5z+Ut2lwM/FKx6Qv8dVa3ZiqGHJN6dlwORGN
	OxPX1iWiM7yexX1v4/PyVlnKo61foaa4q3BG4ETJnnERZdVB8tTNa8jYe3WSoL5x
	O8d/7LRboCrWiPp+aNH+YC6niqXIYOC27u7Q9sJFUjoL4kT/pVvhFmmqY74FyQHc
	XhbaHhoBX5dCaoNAi+2xh0LvvMLmZLIcXqa+NDeRiOPTFcw2/axC/kVGJla8ptiA
	Aq0Qig==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy59sm1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 03:48:13 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4893mCvw003283
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 03:48:13 GMT
Received: from [10.151.41.25] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Sep 2024
 20:48:10 -0700
Message-ID: <44a7d182-154e-49b2-afb6-c1289d472513@quicinc.com>
Date: Mon, 9 Sep 2024 09:18:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath11k: allow missing memory-regions
To: Caleb Connolly <caleb.connolly@linaro.org>,
        Jeff Johnson
	<jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240904095815.1572186-2-caleb.connolly@linaro.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <20240904095815.1572186-2-caleb.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zuhaROB0NlZvzXhCjy-nVXHPpVfdopI-
X-Proofpoint-ORIG-GUID: zuhaROB0NlZvzXhCjy-nVXHPpVfdopI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=793 phishscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090029

On 9/4/2024 3:27 PM, Caleb Connolly wrote:
> On SC7280 platforms which are running with TrustZone, it is not
> necessary to manually map the memory regions used by the wifi hardware.
> However, ath11k will currently fail to load unless both memory regions
> are specified.
> 
> This breaks wifi on the rb3gen2 which only specifies the firmware memory
> region and does not use the CE region.
> 
> Adjust the order of operations in ath11k_ahb_fw_resources_init() to
> check for the wifi-firmware subnode before attempting to parse the
> memory regions.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

