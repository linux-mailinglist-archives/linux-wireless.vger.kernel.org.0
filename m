Return-Path: <linux-wireless+bounces-4634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E008879D20
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 21:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA44A1F21994
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 20:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCE37E10A;
	Tue, 12 Mar 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LaEc8IqK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884BA382
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277168; cv=none; b=JNSNnUrw97h+isbDM3po/1FgNGxNMB+vxP4heHhLGNAuiybqi0GLy43ObYrsltcX8UiAY5SiEeE+EHXJgQKMQQLO6lA17slTPQSIiVcrOJmJRrQwcMFMYm6fZo1S1/SuPs/atViokhzgY+Qk+MVT/YUEJgkaPBvsZZGoMOoYZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277168; c=relaxed/simple;
	bh=tidWqtdJkl/V0+5ccbSw7NWlc22HgAjNHlM0zo6JsMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HZrKP5dZ1b6LXltwa7QkK5XbkySyX75yuqMXUm2kO/aYZe95LC3rdon3pImoZx4CfHTm5Iy3pn7XBhMv7PLbX1uZUpRTdpLNNWQkoTuRsCj14mY0KR3W/7GQsWNKRO01qhYSw2dC+L7mqBfFVEVlEciKTY1dVHFe/AAGm75XEnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LaEc8IqK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CKeQel016219;
	Tue, 12 Mar 2024 20:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4uw/qFoW9jGPAe7Ib9fIAeYoIcFG35WvSTxMS1sNb2c=; b=La
	Ec8IqKu7sLMRmnyRYqADi0gvnzbs3Z9h/k96YPl02+rvOOrdaAwqQ8niU4q6DGOq
	lbw3DX4RTcL1eKL63Ci9mlp62+f9tezvE4rpCBsfxOQuxixaRZlPQno1GS07Ngk7
	Ik+h1Xp2BtJtsFIWOVwz+DylbwnrYF5NG17etdLWKbV7tErQ6XckFsqSMMFm/Ktt
	nnYt5T74+vzRaTRScVb1l0bNuK/qcouKQlhS0CKQMWgkK1MBAjOKyhHuWCCpr9Oh
	gP9poQmGoMwoM04s9Nmed4F5aKpr74eNppVDUnXqX2l2WJTRyAVkNUhbwm8cg6AF
	xW5AFeoVWMjy6szJBbcA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtfwn253d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 20:59:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CKxDQi003045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 20:59:13 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 13:59:12 -0700
Message-ID: <e717c1c4-25d9-48bd-9a46-815e777f6526@quicinc.com>
Date: Tue, 12 Mar 2024 13:59:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] wifi: ath12k: Add single wiphy support
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240312135557.1778379-1-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NPrYYZUeE3xUdn1M3LJ6fQPUJYIbZvu7
X-Proofpoint-GUID: NPrYYZUeE3xUdn1M3LJ6fQPUJYIbZvu7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_13,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403120160

On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> With the introduction of Multi Link Operation (MLO) support in
> IEEE802.11be, each EHT AP/non AP interface is capable of
> operating with multiple radio links.
> 
> cfg80211/mac80211 expects drivers to abstract the communication
> between such Multi Link HW and mac80211/cfg80211 since it depends
> on different driver/HW implementation. Hence the single wiphy
> abstraction with changes in datastructures were introduced in
> "wifi: ath12k: Introduce hw abstraction"
> 
> This patchset extends the implementation to allow combination
> of multiple underlying radios into a single composite hw/wiphy
> for registration. Since now multiple radios are represented by
> a single wiphy, changes are required in various mac ops that the
> driver supports since the driver now needs to learn on how to tunnel
> various mac ops properly to a specific radio.
> 
> This patchset covers the basic mac80211 ops for an interface bring up
> and operation.
> 
> Note:
> Monitor and hw reconfig support for Single Wiphy will be done in future
> patchsets.
> 
> ---
>  v4:
>  - Updated missing Signed-off details for patches.
> 
>  v3:
>   - Rebased on ToT (added additional ar check in PATCH 08/12 for p2p)
>   - Introduced iterator to loop through ars in an ah(for_each_ar())
>   - Addressed comments on reverse xmas tree declaration style.
> 
>  v2:
>   - Rebased on ToT and dependent patchset
> 
> 
> Karthikeyan Periyasamy (1):
>   wifi: ath12k: add multiple radio support in a single MAC HW
>     un/register
> 
> Sriram R (11):
>   wifi: ath12k: Modify add and remove chanctx ops for single wiphy
>     support
>   wifi: ath12k: modify ath12k mac start/stop ops for single wiphy
>   wifi: ath12k: vdev statemachine changes for single wiphy
>   wifi: ath12k: scan statemachine changes for single wiphy
>   wifi: ath12k: fetch correct radio based on vdev status
>   wifi: ath12k: Cache vdev configs before vdev create
>   wifi: ath12k: Add additional checks for vif and sta iterators
>   wifi: ath12k: modify regulatory support for single wiphy architecture
>   wifi: ath12k: Modify set and get antenna mac ops for single wiphy
>   wifi: ath12k: Modify rts threshold mac op for single wiphy
>   wifi: ath12k: support get_survey mac op for single wiphy
> 
>  drivers/net/wireless/ath/ath12k/core.h |  38 +-
>  drivers/net/wireless/ath/ath12k/hw.h   |   1 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 911 +++++++++++++++++++------
>  drivers/net/wireless/ath/ath12k/p2p.c  |   3 +-
>  drivers/net/wireless/ath/ath12k/p2p.h  |   1 +
>  drivers/net/wireless/ath/ath12k/reg.c  |  55 +-
>  6 files changed, 785 insertions(+), 224 deletions(-)
> 

ath12k-check reports the following issues when run against the series:
drivers/net/wireless/ath/ath12k/core.h:994: Macro argument reuse 'index' - possible side-effects?
drivers/net/wireless/ath/ath12k/core.h:994: Macro argument reuse 'ah' - possible side-effects?
drivers/net/wireless/ath/ath12k/mac.c:3635: Please don't use multiple blank lines
drivers/net/wireless/ath/ath12k/mac.c:6230: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath12k/mac.c:8429: Missing a blank line after declarations


