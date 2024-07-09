Return-Path: <linux-wireless+bounces-10118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A7292B4F5
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 12:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAF71F216C7
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863013D89D;
	Tue,  9 Jul 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o0SZFiUe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE814F9E2
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520171; cv=none; b=ffySalDFi94OICmfldAGbAOxeYdwEyVu0139WAJ09SZX/cTcBCicKLOlNEXE1OuoOw0SIjpzsk9Zd4f3Ucm0ufETC6Uqi1VAWmDOF8uk2hswIQrKET8mS1iauoKJ7ZGnURIEnyZzuB300LtYhtJe4fsEeQXbdzUuj+IxvxSqle4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520171; c=relaxed/simple;
	bh=fqFQYaf6vIk50+G/ID/QIUD1s8y84zcrcawIrhUOedE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Px9P2jYgFg8KFkMqbj21CovUbJlhG9PGku/Lap/B58vlneBfFE5Snj5OioeAKo6bdK4CdwRDGlXpgF+OYf7Eb8hKa5yaelvu2uizuZznMyHrMFuzDBToi2lQwIWJ/a16L7oXO8diS5wyCtMwbPP4HhT24JlqBJ/Dn39OifS2TQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o0SZFiUe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46910wxb001714;
	Tue, 9 Jul 2024 10:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rPup1kK2+RcF+K0PkB3iX3bl7hY61xPiPlbCxOCCQ/4=; b=o0SZFiUe/woS6Aav
	97jWIcyNVhIk5jTqQehKS0hUIZxyw980v9WWng5KiYq++k0hiViv2cBdQzwFbORS
	eATMGuKevA4BR4hzOaEF49qynhSuobQ1P26yAcsPvRfumeowWncKWjHXj9NAxeHA
	I7rXgsm8ZB3sqgagrNoZjn8o7CgRc9JuAo2Iv2Gz2bnumrsRntL/FWRKgwq8yZgn
	uc36Cn0K5kI7Vo/3e48fN0sfj9LfCH/rKB2XIcqkw1m5vCOFQEcU+bPyN/HsJXXT
	OnSHx3U/TtZS4/fUWBPpIDAEvdFbUfVR7WroMkt/v7yDi0yIDjGuNoLl6nbjtiaP
	KOIiFw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa6614d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 10:15:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469AFwlk006165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 10:15:58 GMT
Received: from [10.152.206.169] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 03:15:56 -0700
Message-ID: <4f0963ff-a822-49b8-3d45-5d90e2c2d511@quicinc.com>
Date: Tue, 9 Jul 2024 15:44:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v8 7/8] wifi: ath12k: refactor core start based on
 hardware group
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
 <20240531180411.1149605-8-quic_hprem@quicinc.com> <87plsuql2y.fsf@kernel.org>
 <dd2488bb-43f9-d546-7617-2a54ca3d1a1d@quicinc.com>
 <87ed8ae8ye.fsf@kernel.org>
From: Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <87ed8ae8ye.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XyANtJGN_oqNyLr1i7nIBbA4qzsiBqa2
X-Proofpoint-ORIG-GUID: XyANtJGN_oqNyLr1i7nIBbA4qzsiBqa2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_01,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=951
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090070



On 7/3/2024 9:58 PM, Kalle Valo wrote:
> Harshitha Prem <quic_hprem@quicinc.com> writes:
> 
>>>>    +static void ath12k_core_device_cleanup(struct ath12k_base *ab)
>>>> +{
>>>> +	mutex_lock(&ab->core_lock);
>>>> +
>>>> +	if (test_and_clear_bit(ATH12K_FLAG_CORE_HIF_IRQ_ENABLED, &ab->dev_flags))
>>>> +		ath12k_hif_irq_disable(ab);
>>>> +
>>>> +	if (test_bit(ATH12K_FLAG_PDEV_CREATED, &ab->dev_flags))
>>>> +		ath12k_core_pdev_destroy(ab);
>>>> +
>>>> +	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)) {
>>>> +		ath12k_mac_unregister(ab);
>>>> +		ath12k_mac_destroy(ab);
>>>> +	}
>>>> +
>>>> +	mutex_unlock(&ab->core_lock);
>>>> +}
>>> This patch is just abusing flags and because of that we have
>>> spaghetti
>>> code. I have been disliking use of enum ath12k_dev_flags before but this
>>> is just looks too much. I am wondering do we need to cleanup the ath12k
>>> architecture first, reduce the usage of flags and then revisit this
>>> patchset?
>>>
>> yeah., more dev flags :( but flags were needed for the race conditions
>> when multiple devices where involved in a group, some devices would
>> have completed till pdev create some might not. Some crashes were seen
>> because hif_irq_disable was called for a device in a group but that
>> device was not even at the stage of core register. Will check the
>> possibility to  reduce the flag usage but it seemed necessary for
>> multiple device group clean up.
> 
> I think the core problem here is of mixing enum ath12k_hw_state and enum
> ath12k_dev_flags, it's just a mess even before this patchset. For
> example, these flags look like they should be part enum ath12k_hw_state
> instead:
> 
> 	ATH12K_FLAG_RECOVERY,
> 	ATH12K_FLAG_UNREGISTERING,
> 	ATH12K_FLAG_REGISTERED,
> 	ATH12K_FLAG_QMI_FAIL,
> 
> If we have an enum plus set of flags to handle the actual state then it
> will become difficult to manage it all. Instead we should just have the
> enum for tracking the state of the driver.
> 

ath12k_hw_state is the driver state representation which is used to 
indicate whether driver has started or in restarting from mac80211 
prespective where as ath12k_dev_flags closely related to devices and its 
q6 states.

So, ATH12K_FLAG_RECOVERY, ATH12K_FLAG_QMI_FAIL should be in 
ath12k_dev_flags because these are specific to Q6 crashes and failure. 
ATH12K_FLAG_UNREGISTERING is actually used to indicate pci_remove is 
initiated and we should not process any QMI events but may be naming is 
creating the confusion. ATH12K_FLAG_REGISTERED flag is used whether to 
recover or not with the information available in mac80211 to reconfig.

With hardware abstraction, it can be like 3 devices (ath12k_base) in one 
ath12k_hw and with ath12k_hw_states alone we might not be able to 
handle. Because, say device1 is in recovery, device2 is already till QMI 
firmware ready after device probing and these two devices are not 
registered to  mac80211 then we cannot set the ath12k_hw_state as ON/OFF 
or anything else.

Hence, we may require two distinct flags, where one holds the driver 
abstraction state and other is device states. With grouping complexity 
would increases as we have to sync between the devices and we require 
two flags. Please let me know your thoughts.


Thanks,
Harshitha

