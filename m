Return-Path: <linux-wireless+bounces-4135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0414F86A8D0
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B397828558A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 07:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9432D2420C;
	Wed, 28 Feb 2024 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FuVLhX/D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A44241E6
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104901; cv=none; b=PguGna4CQKLsRqD4mIyweZcJT+6aNxdLACR2Sc6Tv8f0cMKpjyDDu8NRneqpTn0nOxXx5qoTGY0//8yEiQ9gQcXeN6YMoJJpevde+dBJbFQe9eJOod8IG7M8L3bfRtCAIsbwK5/PAhqLkW3lcRK5LiawwxGvwtxEzeu22tkkRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104901; c=relaxed/simple;
	bh=vd8YmsDAdWgpS8ypb9hJT155MHFhbEHyuX1Xxg1Qx/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TIDBL8f9k9gQ358KKqSSOCmD6tdosEMS6Yq+JogR0MlMdg4BNtpTIHARQgSagrwPVIf07NR/DOhiVWa4nhrwSSrPSU1+X2dsXWF8i808ouvJ2HnEFVotiK6AfVsACyYvfAP6IZXWESOQ8R1qMiessuwVrXD0n5HVcq9jOnqWeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FuVLhX/D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S7I4rD005134;
	Wed, 28 Feb 2024 07:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=clkTeZGnR4RlnTd2HgHjAA6UMsC005qBUXmZpM5hoL4=; b=Fu
	VLhX/DTXOZRipPc4EJ0qtxIqYMeSV2kjQblWoDeBU46nSvmUkaokqOfqCFZ14uP/
	JxOk95zyAppkdok+mZREuWuune6kZTRO64AFShOpyFHVkHoun92vBW1a9Gx9/vRo
	VdyIDqVmdHiXZyuQGE+s1GH1rw8X2IknqQKE/7rlbebb8DcjE+JFLMTqkaCfhoTK
	NmV8EKB/q1/ZtfbbKlK+QoUe3mNQWneYf2m8+XHIQBRXARIFGMiGWf6xCfwKkmLd
	bjV1QkosoTaxX8In6e5J4uGYNr3KA/b3mC/yaEvmSo4LreHgIjq/ak7XDjmdFOxQ
	9sDEwI496Y180U2kqVrw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whkd5hksh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 07:21:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S7LYee030313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 07:21:34 GMT
Received: from [10.110.92.246] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 23:21:32 -0800
Message-ID: <4e67118d-80e4-422e-aa39-73b891ee6042@quicinc.com>
Date: Wed, 28 Feb 2024 15:21:30 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath12k: report tx bitrate for iw dev xxx station
 dump
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240219095802.1147-1-quic_lingbok@quicinc.com>
 <87y1b7jkxu.fsf@kernel.org>
 <6f39eb1c-97f7-4029-a5f2-5ab36ff0f0a6@quicinc.com>
 <877ciq9h3e.fsf@kernel.org>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <877ciq9h3e.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LWkZl3sgax-aQ1fwxgi8_yGn2_hKHX_q
X-Proofpoint-ORIG-GUID: LWkZl3sgax-aQ1fwxgi8_yGn2_hKHX_q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=769 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280056



On 2024/2/27 21:23, Kalle Valo wrote:
> Lingbo Kong <quic_lingbok@quicinc.com> writes:
> 
>> On 2024/2/26 23:37, Kalle Valo wrote:
>>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>>>
>>>> The tx bitrate of "iw dev xxx station dump" always show an invalid value
>>>> "tx bitrate: 6.0MBit/s".
>>>>
>>>> To address this issue, parse the tx complete report from firmware and
>>>> indicate the tx rate to mac80211.
>>>>
>>>> After that, "iw dev xxx station dump" show the correct tx bitrate such as:
>>>> tx bitrate: 104.0 MBit/s MCS 13
>>>> tx bitrate: 144.4 MBit/s MCS 15 short GI
>>>> tx bitrate: 626.9 MBit/s 80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
>>>> tx bitrate: 1921.5 MBit/s 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0
>>>>
>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>> Tested-on: QCN9274 hw2.0 PCI QCN9274 hw2.0 PCI
>>>> WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>>> Please use full englist words like transmit instead of tx. Also the
>>> title could be simplified to:
>>> wifi: ath12k: report station mode transmit rate to user space
>>> Here I assumed this only works in station mode. Or does this also
>>> support AP and P2P mode? The commit message should explain that.
>>>
>>
>> Ok, i will apply it in next version. Thanks for pointing out.
> 
> After rereading my comments maybe keep the title simple like:
> 
>    wifi: ath12k: report station mode transmit rate
> 
> But it would be good to clarify in the commit message what modes this is
> supported. And what hardware families support this.

Hi kalle, Could you please offer your opinion on this commit message?

wifi: ath12k: report station mode transmit rate

Currently, the transmit rate of "iw dev xxx station dump" command always 
show an invalid value.

To address this issue, ath12k parse the info of transmit complete report 
from firmware and indicate the transmit rate to mac80211.

This patch only applies to the WCN7850's station mode.

After that, "iw dev xxx station dump" show the correct transmit rate.
Such as:
tx bitrate: 104.0 MBit/s MCS 13
tx bitrate: 144.4 MBit/s MCS 15 short GI tx bitrate: 626.9 MBit/s
80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0 tx bitrate: 1921.5 MBit/s 
160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0


