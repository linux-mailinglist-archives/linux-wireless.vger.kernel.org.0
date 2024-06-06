Return-Path: <linux-wireless+bounces-8604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9A98FE3FA
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 12:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F6B3B26D40
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E4185091;
	Thu,  6 Jun 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yz7rh6KT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD3183A82
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668021; cv=none; b=V7veG3ZCjz4LHLtWxEmq0xV24EbYQGfbAXiplQUQkSYOHBJxKidvMhwS5e1kipb47H4Y1r63ZpsW5/VgxruFpsv+DfI2q/8245Ud5IWNnVWVtVcIcLQuLgWNex/vDLcvUZg/+yrH04QENYq3qNJB+Se4rKRzgYiEhgavYYwLgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668021; c=relaxed/simple;
	bh=pq8O0QJ5L8S9Spi6hn1eAgcImw1756KjkepqYaCcqq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hWQZmZcVP4XbfQepPuKzvhsjxSa2dMlPkaGmKFvWyjTIfo3aC/6TYrlQiL+FHr1UOaYsMAPStBE+cLZVd9Xg2t6ih3LADcDNO0sABsIBTyqNwdKM/ETbkuySrQk2jI9tZd3sVpv/X9GVo6HeIZi9zys5qipXHkEK+tv/bGH0hbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yz7rh6KT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4569niVf007052;
	Thu, 6 Jun 2024 10:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QhZ1b1O39oD34yksHyaU4sQjHdDBGycMhRm7Rczsnxk=; b=Yz7rh6KT76ANWPpx
	z92vHR/PcD/bJWEWvXA5ZO28JXqToImt1Pwf72UZq2mAPCAKR/pHzZFKsJ3jNfeJ
	HOGjxLqPToFdy1jAc3asKUz0Aow8Twar9+9dOoW2UE1Ceq9Q92g3jJz49xRX8gNn
	kkWBdFAhY4Lf9pH35Q/JRn0BHwlntlsmC6a449Fhkl9YFb8BuRx7mpfYfecdyotG
	2bGsAG47KmHbAqGbTyU6oFOHyz2jaTY74V7J6W+0aco3L5iFeuLIE4i2sMpJ21zu
	aFxbKZoOq7Rf39Kbrt33HpmPIrr4p2yC4KRNl0kkmAXbc5YJ4ZyyVfo3J0lopOWK
	NSjiIg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj7urcn54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 10:00:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 456A09I3014072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 10:00:09 GMT
Received: from [10.216.0.40] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 03:00:07 -0700
Message-ID: <f751d310-4cbb-4562-947b-a0a76edb6b40@quicinc.com>
Date: Thu, 6 Jun 2024 15:30:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/7] cfg80211/mac80211: support defining multiple radios
 per wiphy
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC: <johannes@sipsolutions.net>, <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
References: <cover.c104c0bb3a14f4ac26aee71f4979846f6ad87742.1717611760.git-series.nbd@nbd.name>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <cover.c104c0bb3a14f4ac26aee71f4979846f6ad87742.1717611760.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2G8BjylzToG8y2fxyyO1N61N1o5phNUM
X-Proofpoint-GUID: 2G8BjylzToG8y2fxyyO1N61N1o5phNUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=731
 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406060073

On 6/6/24 00:01, Felix Fietkau wrote:
> The prerequisite for MLO support in cfg80211/mac80211 is that all the links
> participating in MLO must be from the same wiphy/ieee80211_hw. To meet this
> expectation, some drivers may need to group multiple discrete hardware each
> acting as a link in MLO under single wiphy.
> 
> With this series, the bands and supported frequencies of each individual
> radio are reported to user space. This allows user space to figure out the
> limitations of what combination of channels can be used concurrently.
> 
> Each mac80211 channel context is assigned to a radio based on radio specific
> frequency ranges and interface combinations.
> 
> This is loosely based on Karthikeyan Periyasamy's series
> "[PATCH 00/13] wifi: Add multi physical hardware iface combination support"
> with some differences:
> 
>   - a struct wiphy_radio is defined, which holds the frequency ranges and
>     a full struct ieee80211_iface_combination array
>   - a channel context is explicitly assigned to a radio when created
>   - both global and per-radio interface combination limits are checked
>     and enforced on channel context assignment
> 
> Changes since RFC:
>   - replace static per-radio number of channels limit with full ifcomb
>     checks
>   - remove band bitmask in favor of only using freq ranges

What about handling 2 GHz + 5 GHz issue we discussed in v1 related to 
radar detection width and num chan ctx? Is that taken care?

