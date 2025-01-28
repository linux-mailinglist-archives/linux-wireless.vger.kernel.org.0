Return-Path: <linux-wireless+bounces-18086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC82A211C2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C373A379D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0278ABE40;
	Tue, 28 Jan 2025 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bfZAiT7J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD61AAA10
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738089853; cv=none; b=BXruP2ztusnuSTSO4Ynvt8fr4dmYA+sgwmYqMx98hnlRmJfJOQZWNdU3Xp5hg038Bw58sFKTOh6cU3P+stc2B4yU2w/EOFKbHYmN4t2oSFoyph/cl0C3IdpcbCZwqi3j0LjK9BlPn3aaU70OpbkPa7VzHRhBqRNJDId7LCQIeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738089853; c=relaxed/simple;
	bh=0JXSI4weAGD6OAsJdwx8r0sZu0S5bVpqUmVXGXYmVr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LMALQR5pSamVT3VqeHdKx6WMmiisSYSc4lZMPhk8yVbI3/hN+iuXNFVEc/QyYsLhR8paVcgv1AFGjY/+1Ie9OE5m8jLbbIvRdh07DYPvtrCix/ijNgLHjCCm3vFGSyc8Lz2/8hxZONoumRJ7P9ipm2ttJ7++stVV0ulOYXfxdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bfZAiT7J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SH6ibc032661;
	Tue, 28 Jan 2025 18:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	waasbAwmzj7ujLbfya5oMoQ+CaPf2PErneHn+u2V5JY=; b=bfZAiT7JBGavVxpj
	oKDKC41aLm9hb9J6OKLKYDqBeRUH7tnqY32k8CzYDa0mmnY5AzzJ0dZHEXvUPiTB
	dYggMLn4dsf6O5ylSF17rkGMkYrGbtfZLYyIqpxBTyiBRhtJ/umwZvueliRVZC8L
	s4kLEF4BsVTGbckTtFNkIsXSn/c7pchqnS6VS10tTKTgo+Rs6vLom867OlPC6zKf
	7eci2fzzYct6A2Ti1zMwhnk9eRVSIJq886yJE16yUmHYNA8b0Q8AJnaw1lnJHyi3
	bxkrDmiHsCPmlKnScgsiec59MoOUJj6EuoSFPvbm6AQ4FWQaF/NAtGr/5NZKjoq9
	miKwDQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ernksvq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 18:44:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50SIi42c004156
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 18:44:04 GMT
Received: from [10.227.108.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 10:44:04 -0800
Message-ID: <961df6e7-0b5c-4972-9324-5c4d430cb172@quicinc.com>
Date: Tue, 28 Jan 2025 10:44:03 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: <mbizon@freebox.fr>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
 <20250114003813.2783550-7-quic_pradeepc@quicinc.com>
 <f5c6d874e9d7682d52c5ed107a0ede952b5cf53f.camel@freebox.fr>
 <5861c953-436e-4f36-ae8b-5ef52fceb3b6@quicinc.com>
 <2aba18dc3448b5a60a1a06b33fa591e562927693.camel@freebox.fr>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <2aba18dc3448b5a60a1a06b33fa591e562927693.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gx0bl6nD4nIs3Aftg7pdH47GTKODw8PO
X-Proofpoint-ORIG-GUID: gx0bl6nD4nIs3Aftg7pdH47GTKODw8PO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280136



On 1/24/2025 12:26 AM, Maxime Bizon wrote:
> 
> On Thu, 2025-01-23 at 17:09 -0800, Pradeep Kumar Chitrapu wrote:
> 
> Hello,
> 
>> I believe, this is default GI based on device capability of HE for
>> ath11k or EHT for ath12k.
> 
> Your patch alters the behaviour of this code in
> ath12k_peer_assoc_h_ht():
> 
>          /* As firmware handles these two flags (IEEE80211_HT_CAP_SGI_20
>           * and IEEE80211_HT_CAP_SGI_40) for enabling SGI, reset both
>           * flags if guard interval is Default GI
>           */
> 	if (arvif->bitrate_mask.control[band].gi == NL80211_TXRATE_DEFAULT_GI)
> 	        arg->peer_ht_caps &= ~(IEEE80211_HT_CAP_SGI_20 |
> 				IEEE80211_HT_CAP_SGI_40);
> 
> 	if (arvif->bitrate_mask.control[band].gi != NL80211_TXRATE_FORCE_LGI) {
> 		if (ht_cap->cap & (IEEE80211_HT_CAP_SGI_20 |
> 	            IEEE80211_HT_CAP_SGI_40))
>                          arg->peer_rate_caps |= WMI_HOST_RC_SGI_FLAG;
> 	}
> 
> 
> I don't understand why a patch adding a feature to force GI would alter
> the current behaviour without any actual forcing ?
> 
Hi Maxime,

Apologize for my earlier comment. Firmware relies on peer_rate_caps and 
bandwidth settings when configuring GI. Currently default is configured 
as FORCE_SGI. When there is fixed rate settings configured from user 
space to override defaults to replace SHORT GI with DEFAULT_GI, the code 
snippet you mentioned ensures honoring this by removing HT_CAP_SGI_20 
and HT_CAP_SGI_40. The behavior has been same for ath11k driver as well.

I will get back with more detailed information as soon as possible.

Thanks for understanding,

Best regards,
Pradeep

