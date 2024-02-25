Return-Path: <linux-wireless+bounces-3982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078B6862AD9
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Feb 2024 15:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930C81F212B1
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Feb 2024 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941CE12B87;
	Sun, 25 Feb 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cHKz66FI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD4748D
	for <linux-wireless@vger.kernel.org>; Sun, 25 Feb 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708872931; cv=none; b=dFCYIXqnaaoYLF+sDFeZVDjaHlm5FcdtzBaqmivws5Y5CY/wHe4LIGtJ3SfNKS6d9fyVNUoaV/0KKKINXtKf+7zu7JH7AmMCxoiIh12p2xZB0VrXgGWhvWPevlIUnXXdHpFT8uQg6oz2/unRzH5azJ5IXismeMXjCeon4OzvF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708872931; c=relaxed/simple;
	bh=tjP0ICjqR0BpQ4MRsnX5MSItzJMdzPy407ciHwk5D8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DQmMwlIQuQ+itGjoylSdor7H3/BPTlhfRT5DWJgoNZHDay2mlkzZOQQ6XYLI+iELYfA2s/YOFYjG/21fTHQVjcOGrlg196O5E38qDrXg+SXCiGOUKy9wR8V5e/2sse9KYtVpdBvYtY6wNwfig1fj96Ps6gAqtnHnYUejly6P9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cHKz66FI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41PEVbZ7029290;
	Sun, 25 Feb 2024 14:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Uc0wMqLN4cXLorwtjxl+1hxzQu0VmHmGBOY2K5ZtoN0=; b=cH
	Kz66FIp7BAgYNGp1w59++Gg0jxz1pf1jAh12UzYvC6Ta6i0uM5rR6d1ARVUDm3bl
	Kf16kbI8qp8FuS+Qv2Q7fbgR+LahezI4Dt+Lfd/AFn9oJpO2kyAizLUZfdndKAaM
	SEnSqibQj0072GM0xF9Sc4xlFmxSgPW/QjLJFbZKzJCuxgJFI890FPob5BUK3Xhn
	ppgPrbyDn2c12mc0Uk+gyuZ41pa89pB5Ui8ZHt/tolKR6Qq+YbOHnyhgw3/fXBtP
	ebrmPXYgrQX9RreSH56DeDsHagCFYLs7W2iNeff3RdjQZex6o/SMHHEeTi+BR537
	+P5I3kKIt3AAJODY+OYw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wf8p7j0bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 14:34:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41PEYSdT026435
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 14:34:28 GMT
Received: from [10.216.1.166] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 25 Feb
 2024 06:34:26 -0800
Message-ID: <38def880-b4f0-a4da-6189-b986d986e486@quicinc.com>
Date: Sun, 25 Feb 2024 20:04:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] wifi: cfg80211/ath12k: Add support to rx retry stats
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240212121616.3683197-1-quic_haric@quicinc.com>
 <c6192c28d7d30198b8b53f89a06c0c37d4ab9d0e.camel@sipsolutions.net>
From: Hari Chandrakanthan <quic_haric@quicinc.com>
In-Reply-To: <c6192c28d7d30198b8b53f89a06c0c37d4ab9d0e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 80I_RjxbUadBD1LIF_7f1vNrBZQ94xbr
X-Proofpoint-GUID: 80I_RjxbUadBD1LIF_7f1vNrBZQ94xbr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_16,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=737 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402250116


On 2/12/2024 6:25 PM, Johannes Berg wrote:
> On Mon, 2024-02-12 at 17:46 +0530, Hari Chandrakanthan wrote:
>> This patch series adds support to count station level rx retries.
>>
>> wifi: cfg80211: Add support to rx retry stats
>> wifi: ath12k: Add support to rx retry stats
>>
>> Tested-on: QCN9274 hw1.0 PCI WLAN.WBE.1.2.1-00148-QCAHKSWPL_SILICONZ-1
>>
>> Hari Chandrakanthan (2):
>>    wifi: cfg80211: Add support to rx retry stats
>>    wifi: ath12k: Add support to rx retry stats
> There's trivial work here to expose them from mac80211, so please do
> that. Also not entirely sure then why you need it in ath12k, but perhaps
> if it's already done header conversion?
>
> johannes

When RX_FLAG_8023 is set, the rx skb contains 802.3 header.
Also the flag member(u32) in struct ieee80211_rx_status is also completely
utilized. can we extend it to u64 and use a bit in the u64 to indicate 
that retry bit
is set in 802.11 header when rx decap is offloaded?


