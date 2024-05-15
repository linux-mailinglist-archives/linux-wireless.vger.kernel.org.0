Return-Path: <linux-wireless+bounces-7720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3058F8C6EBC
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 00:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55BA1F21728
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 22:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3523D551;
	Wed, 15 May 2024 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gcf9673q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C639FEC;
	Wed, 15 May 2024 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715813032; cv=none; b=i1DODQy3x3oCZDZdQJW8NbVBgRH4ymx6wva5HVxbPwme4qGjMpDzhR1fWAazYKwMHzF8r+6ZlxiubjsTHd9Fd6I/2R/423A9ZZOVcF+/UZqBhPGe45CHFzpMdQZqb5ZUm+U6Tdrvs7YvUHiQ/k9+1a0zbPIeLmzKHVaQtiuR64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715813032; c=relaxed/simple;
	bh=oKchVcPehzuYki4OTeXXqHW9MQl47AW4/PLCYjSexzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gp0hrCwkBBeInCVEmH6DaEQebwkpTx4SHC19SCK1qWXInhbuPhUcxUi24Q/qLzSLwytsUXKlgBgIaPqd2iEngGdKyV0n59VarCqIKaZRd0x90IT9ufO7LTrQ4ZO6FPnXKotIRvJMdTwJ/fK0RbhWzfKLo9iXolw4/XK7cRbDuvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gcf9673q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FL9ex3023672;
	Wed, 15 May 2024 22:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wBLXCgEnr6gzv+kDg5m82yPO1uvCwTswI6/CjKGoDxg=; b=Gc
	f9673qHVZAMwaG8XwJQsRpMRb+0t9Zcvchzsu8jKCo2qpxYindfiXvCP6rLuEcWR
	h2RElb7iQZVm4KJedsYnL+TfYGkyBP6aiNgGIGzB06c2RLoxFjQp6ZgccUiySKZN
	EU6X4C0U/YYrdmtuLjqUFnK5/h0A7tZPn5tm6FPxYbP40msI6Of5WWHf0hhUCoZe
	6hxHRm/4Wwg9GR6tGDalFsqnYfGif8tIwdiPrhk0Mwb12xcu/bEzSs/Ib4AHvBy4
	tSK1y+lBGXVCfMJu3T3Cr05U4H/YL1c8Q73A7o9+layupBnujMz6d1t93IA/iJCT
	/PcFXbSaBKbj05er4ufg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y49gdupb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 22:43:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44FMhiZT031868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 22:43:44 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 May
 2024 15:43:43 -0700
Message-ID: <01c8dc05-76d1-478e-a4e4-3eab8d6aeaf9@quicinc.com>
Date: Wed, 15 May 2024 15:43:42 -0700
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
 <e5edd92e-ab47-4a55-9276-5a7d160fd399@quicinc.com>
 <CAK7LNAQ11Pt85_T9kvYYbqfnjMSH_Yjwvz52E+Tcmw8jS-wvDw@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAK7LNAQ11Pt85_T9kvYYbqfnjMSH_Yjwvz52E+Tcmw8jS-wvDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rrHJ38Yb-Gpp-m0ozMswyzE1KhhcJIWA
X-Proofpoint-ORIG-GUID: rrHJ38Yb-Gpp-m0ozMswyzE1KhhcJIWA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_14,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=836
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150161

On 5/14/2024 9:10 PM, Masahiro Yamada wrote:
> On Wed, May 15, 2024 at 3:14 AM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>
>> On 5/14/2024 10:45 AM, Masahiro Yamada wrote:
>>> On Tue, May 14, 2024 at 11:43 PM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>>>
>>>> On 5/11/2024 3:49 AM, Dmitry Baryshkov wrote:
>>>>> If ath10k_snoc is built-in, while Qualcomm remoteprocs are built as
>>>>> modules, compilation fails with:
>>>>>
>>>>> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_init':
>>>>> drivers/net/wireless/ath/ath10k/snoc.c:1534: undefined reference to `qcom_register_ssr_notifier'
>>>>> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_deinit':
>>>>> drivers/net/wireless/ath/ath10k/snoc.c:1551: undefined reference to `qcom_unregister_ssr_notifier'
>>>>>
>>>>> Add corresponding dependency to ATH10K_SNOC Kconfig entry so that it's
>>>>> built as module if QCOM_RPROC_COMMON is built as module too.
>>>>>
>>>>> Fixes: 747ff7d3d742 ("ath10k: Don't always treat modem stop events as crashes")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> ---
>>>>>  drivers/net/wireless/ath/ath10k/Kconfig | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
>>>>> index e6ea884cafc1..4f385f4a8cef 100644
>>>>> --- a/drivers/net/wireless/ath/ath10k/Kconfig
>>>>> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
>>>>> @@ -45,6 +45,7 @@ config ATH10K_SNOC
>>>>>       depends on ATH10K
>>>>>       depends on ARCH_QCOM || COMPILE_TEST
>>>>>       depends on QCOM_SMEM
>>>>> +     depends on QCOM_RPROC_COMMON || QCOM_RPROC_COMMON=n
>>>>>       select QCOM_SCM
>>>>>       select QCOM_QMI_HELPERS
>>>>>       help
>>>>>
>>>>> ---
>>>>> base-commit: 75fa778d74b786a1608d55d655d42b480a6fa8bd
>>>>> change-id: 20240511-ath10k-snoc-dep-862a9da2e6bb
>>>>
>>>> I see how this fixes the problem, but this doesn't seem like an ideal
>>>> solution. The fact that the *_ssr_notifier() functions are correctly protected
>>>> by conditional compilation ideally should mean that clients don't need to call
>>>> call out this as a dependency. Otherwise, it would mean we'd need to do this
>>>> for all feature flags.
>>>
>>>
>>> It depends on if qcom_common.c is optional for ath10k_snoc.
>>>
>>> If it is optional, this patch is correct.
>>
>> At least from a build perspective it is optional
> 
> 
> 
> You need to make a decision from a run-time perspective
> (that is, whether you are fine with having
> ar_snoc->notifier == NULL)
> 
> 
> If you are able to build the kernel successfully
> but you get a run-time error (e.g. NULL pointer dereference),
> it is even worse because run-time debugging is generally more
> difficult than compile-time debugging.

The current patch maintains the existing logic, so that is my preference.


