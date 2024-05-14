Return-Path: <linux-wireless+bounces-7657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452518C5ADE
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 20:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1910281F0D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF11802D1;
	Tue, 14 May 2024 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QPvSZ4AJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2901802CC;
	Tue, 14 May 2024 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710501; cv=none; b=giYWWA9aKml1X3JT3NKdtMfirrjZlf46pFbWOzZCKJ1xYda8wPg/jjnxyhRJSiWR4YsYz/I4tNqglGtuHJfUxXx8CyuC7sTLpzcfzILzjR6viuJWC7N7TtaIytjSFi+AdTIdz+4pATX4H825ry6jBNVPvYaHBWbXnHV+g2GlXys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710501; c=relaxed/simple;
	bh=0YTUEiFdqVgsyhGRrtIwAVlKX3/OZiI22fa1dGr7wYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NJtFopbBC4sxYnOQNY1KA/ENJt4qmgZBpQj1So7ZS2A7HcOUYl6jmJBpziemDdc4SZrnUrlcjk3H8f0D4sFR3X3XqPwfbdfhYFaUj0eTSp+oQlBkeabFH26vgohnPIgF5/m3kBG2bXHyBPxs0p4DmJ5OvTQi99RLKz1H0UZ/zj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QPvSZ4AJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44EE9pdQ004151;
	Tue, 14 May 2024 18:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OAc04QDaaFxlVX9U1jLw7CfZQzypcX2egL9NvmQNVpk=; b=QP
	vSZ4AJMV8M4ptCZa+BS/ZXi9PvMnFW4c4X3hRQkkxCL9GIzDowL0wS0M0NqZzKee
	nBuOcX7hx51gzefJY3PLX4MzVzu2tzTHzDN5rdGi4MuqcLGwRoP/cjXIedX4OJV8
	R6AtF0t1FE2h5JW5SSjpmmN4pabBycXZKtAo4bInN1aa8HTTABV+iuWP1GN2DuIy
	FuYvebpdLnsMEd6iCqIQMRZCZ/YJbMAKl0sH3GS/OmffnFcvKwsIYMvhcQ7K2vnl
	C0N47VhxsnxKbXHBFQ3nxOnE4Qd/9KDuSQu0ysvmx3SdbzCwCtbzs/psxlkKI02O
	otlykDsrq0Iazhiq1YxA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y49ft0me7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 18:14:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44EIEpb8011974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 18:14:51 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 May
 2024 11:14:50 -0700
Message-ID: <e5edd92e-ab47-4a55-9276-5a7d160fd399@quicinc.com>
Date: Tue, 14 May 2024 11:14:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: fix QCOM_RPROC_COMMON dependency
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalle Valo
	<kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Stephen Boyd
	<swboyd@chromium.org>,
        Rakesh Pillai <quic_pillair@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <linux-kbuild@vger.kernel.org>
References: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
 <12a208d7-f36b-4953-abff-323a15452b3c@quicinc.com>
 <CAK7LNASyBNbxm-e+iZ=7pOJg-a-Zm84O6RNcqiUjZQH7f9r3Lw@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAK7LNASyBNbxm-e+iZ=7pOJg-a-Zm84O6RNcqiUjZQH7f9r3Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9VgrQtpqhVheQyH8pRyT6lhcDDHS8BpV
X-Proofpoint-GUID: 9VgrQtpqhVheQyH8pRyT6lhcDDHS8BpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_10,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=994 mlxscore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405140129

On 5/14/2024 10:45 AM, Masahiro Yamada wrote:
> On Tue, May 14, 2024 at 11:43 PM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>
>> On 5/11/2024 3:49 AM, Dmitry Baryshkov wrote:
>>> If ath10k_snoc is built-in, while Qualcomm remoteprocs are built as
>>> modules, compilation fails with:
>>>
>>> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_init':
>>> drivers/net/wireless/ath/ath10k/snoc.c:1534: undefined reference to `qcom_register_ssr_notifier'
>>> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_deinit':
>>> drivers/net/wireless/ath/ath10k/snoc.c:1551: undefined reference to `qcom_unregister_ssr_notifier'
>>>
>>> Add corresponding dependency to ATH10K_SNOC Kconfig entry so that it's
>>> built as module if QCOM_RPROC_COMMON is built as module too.
>>>
>>> Fixes: 747ff7d3d742 ("ath10k: Don't always treat modem stop events as crashes")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>  drivers/net/wireless/ath/ath10k/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
>>> index e6ea884cafc1..4f385f4a8cef 100644
>>> --- a/drivers/net/wireless/ath/ath10k/Kconfig
>>> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
>>> @@ -45,6 +45,7 @@ config ATH10K_SNOC
>>>       depends on ATH10K
>>>       depends on ARCH_QCOM || COMPILE_TEST
>>>       depends on QCOM_SMEM
>>> +     depends on QCOM_RPROC_COMMON || QCOM_RPROC_COMMON=n
>>>       select QCOM_SCM
>>>       select QCOM_QMI_HELPERS
>>>       help
>>>
>>> ---
>>> base-commit: 75fa778d74b786a1608d55d655d42b480a6fa8bd
>>> change-id: 20240511-ath10k-snoc-dep-862a9da2e6bb
>>
>> I see how this fixes the problem, but this doesn't seem like an ideal
>> solution. The fact that the *_ssr_notifier() functions are correctly protected
>> by conditional compilation ideally should mean that clients don't need to call
>> call out this as a dependency. Otherwise, it would mean we'd need to do this
>> for all feature flags.
> 
> 
> It depends on if qcom_common.c is optional for ath10k_snoc.
> 
> If it is optional, this patch is correct.

At least from a build perspective it is optional

> 
> 
> If it is mandatory
> depends on QCOM_RPROC_COMMON
> 
> 
>>
>> +linux-kbuild just to make sure there isn't a better approach.
> 
> 
> Commit 28d49e171676afb7df7f47798391364af9abed7f suggested
> 
>   depends on BAR || !BAR
> 
> but
> 
>   depends on BAR || BAR=n
> 
> works equivalently.

Thanks for the information.

I'll let Kalle decide if he wants to change this in 'pending' to:
	depends on QCOM_RPROC_COMMON || !QCOM_RPROC_COMMON

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


