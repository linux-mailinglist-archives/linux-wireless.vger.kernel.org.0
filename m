Return-Path: <linux-wireless+bounces-5476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D870F8904DE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E56B2524D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C657E787;
	Thu, 28 Mar 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IgmHZ63v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472EE8004E
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642781; cv=none; b=Dn6ROUS1QAlqKGK7gjmMPQvK5NEV1F73xo0P5kLV4ZF1nvjdJ7VJDY+6zinJwZPVRajsncP6cEr0zUMuZ173wiwRqbDDGwlZZEVSLKaHpUdhMqmF7vDRyBq00Rk1E6t3hYq3vzgGyXMHAq+wobThWj8MITihKfHhZNxvrWhnN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642781; c=relaxed/simple;
	bh=/wAqZIkYxMgaBGJ4jlSsC5OM8vUy9SihNqGIje/w6NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Iuoh1fng1yQiegL2OZLrQUEO8iP4/A6MUE+HtTcrgl2iwS0HYwgOr7f7y7uA/AyAQ3YVcNRCtLvRQ/S9ClSaVsa2OF9cYdYNXycrODHgXxqjC46hSiI5GArMDd4kDCSdvPzU+ooJnl8PZ/YqxCss7zAPPqxdv2KZveDOwp66UYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IgmHZ63v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SAVSoi024185;
	Thu, 28 Mar 2024 16:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qqNaIn1vdQNG08WNesydJO7U23oVtC4uv9qaa9pLUmM=; b=Ig
	mHZ63v3Ti230P5scwaVODmoACh7NQU7gAY3yuyZmGiLY8yGmdFA4gCU2dPhekFl1
	4BHiypY1vVm7bTgYzEQi0NKmOJmENwmMlkK/li/iDQ+A1mx1d7pb7m1cQkrBiZqc
	wUKdv50X12BKbY6nlQPAmxQn2OMmnKiJSr2j1yu7/8nQwlWdWk5Lqy4Bh9jZ+3vZ
	qkGkFjrVbTNYU8CVjMFvlEJc13VvQOis1qfmTyg+5G5Cd/80cBtObnEPAVNQCiGf
	tYHG9TfkH0ZjwThlPTxV2y8aJXjMpq2h94OK0jSnwF81GMYSiqSfU0wsdhNC19hJ
	mw5YlVUltSzc+jnbp40g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x54r61h07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 16:19:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SGJWXU010035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 16:19:32 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 09:19:32 -0700
Message-ID: <7c7fa31b-fe2e-4281-8d4c-e62c39cd1b9a@quicinc.com>
Date: Thu, 28 Mar 2024 09:19:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] wifi: nl80211: send iface combination to user space
 in multi-hardware wiphy
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-7-quic_periyasa@quicinc.com>
 <29fc2719d6814a8e84f5db9ad81c76116a52828b.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <29fc2719d6814a8e84f5db9ad81c76116a52828b.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QPY9pI_EXv5in7LVaudwa_xU0QFpehrl
X-Proofpoint-ORIG-GUID: QPY9pI_EXv5in7LVaudwa_xU0QFpehrl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_15,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=991
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280111

On 3/28/2024 6:33 AM, Johannes Berg wrote:
> On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
[...]
>> +	hw_combis = nla_nest_start(msg, NL80211_IFACE_COMB_PER_HW_COMB);
>> +	if (!hw_combis)
>> +		return -ENOBUFS;
>> +
>> +	for (i = 0; i < c->n_hw_list; i++) {
>> +		struct nlattr *hw_combi, *limits;
>> +
>> +		hw_combi = nla_nest_start(msg, i + 1);
> 
> And of course the array and splitting discussions apply here too.

This is where I meant to say that I believe we are trying to reuse the same
structure and code as the wiphy-global combinations


