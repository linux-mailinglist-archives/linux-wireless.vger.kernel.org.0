Return-Path: <linux-wireless+bounces-19695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E0FA4BBE2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 11:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382F23AB2E3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ECB1EE7DC;
	Mon,  3 Mar 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gn6mC+O6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EC1EDA04
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997134; cv=none; b=PFNFRb22CBYjuHLkxXsuPdWFBOun4m+eR5lW0k3fk9ev6TXID11INCw4kiSYQxjP7NTzDufGMfFk+OWT0Yjtjt3puQZBwPXZeXQhD9H5pR7AUnbGiBDPNSc7wDfirylhu90yLpV2ykLEoMyuXQij2YDaAjQf4w1OPHjdkFyqPzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997134; c=relaxed/simple;
	bh=k3Da29qawyQ+nxE5nExlQp4Ph5SgYNUmjhR2iR0tw6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dUcZNqjq+S2X/terSNp/Ir8lF0bbO+OBGQfQ2guUYuJYsNpoyRWWzZi1mrJLm1F4cZVfkZ0tVRtmpdBZxEyWwZe2abq3Hnutzu8C3G6PoklZXK9k47K0ISR4A1XN6cHutay7y4ck00yaWaesAyLpVesVkpiS7dKNAeeRyYanbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gn6mC+O6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522MmnIq005964;
	Mon, 3 Mar 2025 10:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rL7NF/Dj3Nd1cVs4jbz4bFdZ8/H8O7kdUnOpV2xmpf8=; b=Gn6mC+O6M14QLGZh
	eGasHgN2rT7MxXQVj0fClf8q6Uhmb9XV64QpLz0Fr3zzq9mYYMi+AIwKibMla8Xu
	SBnL9okJu3qnwLUiFqxoqMaNSWuGBDF+bcfU974uyJ6hk+4cXGh0pDX+T6CoVu/P
	amq66wfskSS7EFWhf+orlYauXJ60CIpk0sgomfXnYvpfB9K4dIDy6NqDZli2p09+
	vvZFbwbmCzo2wJIV8qeKkv8ZNl7OviB2B924d83TG7n8vpGEyx6n0cWcjFJz6FcP
	RzQkVpOQhrvQ+7fBJ1KaEWziGssdBoesThB//6Yr0immf+BmsILdJ9gOX/Wf9cav
	ow+pQw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t95vkfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 10:18:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523AIl34012425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 10:18:47 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 02:18:45 -0800
Message-ID: <28d36a7f-3408-4072-9857-8bd652260926@quicinc.com>
Date: Mon, 3 Mar 2025 15:48:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] wifi: cfg80211: Add Support to Set RTS Threshold
 for each Radio
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
 <20250129155246.155587-2-quic_rdevanat@quicinc.com>
 <a2bcb0b6507c843b13e0ef98d76727a76b53f129.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <a2bcb0b6507c843b13e0ef98d76727a76b53f129.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HwPjDC9rE1i1vcZZDlJjfsUJcaIUZUYx
X-Proofpoint-GUID: HwPjDC9rE1i1vcZZDlJjfsUJcaIUZUYx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=736 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030079



On 2/28/2025 6:32 PM, Johannes Berg wrote:
> On Wed, 2025-01-29 at 21:22 +0530, Roopni Devanathan wrote:
>>
>> +			result = rdev_set_wiphy_params(rdev, radio_id, changed);
>> +			if (result) {
>> +				rdev->wiphy.retry_short = old_retry_short;
>> +				rdev->wiphy.retry_long = old_retry_long;
>> +				rdev->wiphy.frag_threshold = old_frag_threshold;
>> +				rdev->wiphy.rts_threshold = old_rts_threshold;
>> +				rdev->wiphy.coverage_class = old_coverage_class;
>> +				rdev->wiphy.txq_limit = old_txq_limit;
>> +				rdev->wiphy.txq_memory_limit = old_txq_memory_limit;
>> +				rdev->wiphy.txq_quantum = old_txq_quantum;
>> +				return result;
>> +			}
>> +
>> +			for (i = 0 ; i < rdev->wiphy.n_radio; i++) {
>> +				rdev->wiphy.radio_cfg[i].rts_threshold =
>> +					rdev->wiphy.rts_threshold;
>> +			}
>>
> 
> The order here also seems really odd? That basically means the driver
> now needs to propagate it to all the radios, but you still have
> different per-radio values at that point, that seems bad. You also
> didn't even document any such assumptions.

The idea is to maintain different variables for global RTS threshold and
per-radio RTS threshold. Each time RTS threshold of a radio is getting
changed, we are trying to update the RTS threshold for that radio alone. If
global RTS threshold(rdev->wiphy.rts_threshold) is updated, we are trying to
change the RTS threshold of all radios. This is the reason we are assigning
same value - rts_threshold, to all radios.

I'll document this assumption to make it clear, thanks for pointing out.

> 
> johannes

