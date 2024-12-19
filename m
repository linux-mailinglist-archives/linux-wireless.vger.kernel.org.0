Return-Path: <linux-wireless+bounces-16586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E77F9F79ED
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD08188E1D3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 10:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59B222D76;
	Thu, 19 Dec 2024 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XD10DkUw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF964221D8E
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734605849; cv=none; b=NUdB6WJH4ri3YqT+xb57krThvlqkdtGdOSqHU7DNShqAIvhTXxGKD/epZoI/O1EeJG5xresbU+1auyf1TQ/gljhN/rMhD+n8b5cmb47jE3Od3B0mxsdqos58leRCoyHMB0giEznKXnA+sHslzugE+4T/QELmzNVUhC007TCOp1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734605849; c=relaxed/simple;
	bh=gVONadR+k+21DXGI8wFk9dYAkhmoRQ32b5bIJ8QplGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LuxxnBiYlb3/0Q4EopQ6ac7PfSe4NlE5uSuz3VfSth78Ae2zoNx3Ud4OHIQVMPe7xcnaV5ms4FQWD4BtU7UyfoeDl/GONRkp127kqhGCDngI2u+Vh9i6R9a6ciucJXtWLoVZFDv0ptsZgtmjH55P43Kfa4RcSnz+YCQQ+cGF/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XD10DkUw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ8HaTt020684;
	Thu, 19 Dec 2024 10:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	firzsUJ/USBwbtp5BfOMl9GNuLneYUakt2qJ9xwKqyE=; b=XD10DkUwJzr+ZO1o
	rh0nScicaLHSiMi7mBHHbAS3nDkAfTi4J8etQ9QmvlzRIy6LaOD8JtPbgJ8CzZP7
	5fPze9ZwnBCmRIme9vmgnDkSYHVuWaTELNJm+ubp014+MQCEWWmFs+rUMP0QSszF
	/8xfZEeszxMl2nkT2nupljnd2tPJNZqo8UeZyIUH7JqwFa4DLUdlx7XD2qgJS6nv
	gCj0ZCtfY7mc6EtK1vX/sBpuJ+y+9MC3jR3aVhCP79Qef0Ll2xKoYO9jJjxFINzr
	/w+YRdWsYrvpAz5JwF/TKboDUmxgcwKsr9vP20c7ao8ZY+kRc87F1uouQ4dtK0zs
	JhhWLw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mfup8d0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 10:57:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJAvKFv020570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 10:57:20 GMT
Received: from [10.206.111.90] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Dec
 2024 02:57:18 -0800
Message-ID: <bfe298e3-c096-4426-a948-c4a67a5b8db0@quicinc.com>
Date: Thu, 19 Dec 2024 16:27:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: cfg80211: skip regulatory checks when the
 channel is punctured
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_mpaluri@quicinc.com>
References: <20241125051624.29085-1-quic_kkavita@quicinc.com>
 <cc95ac5eb124ff46484a44beb0e2ec300d1d6392.camel@sipsolutions.net>
 <b4c7a1b1-86cf-4c06-b7ee-21f2f6333dec@quicinc.com>
 <81f864e1fcc1c226763273dec915e43f1fe14f5f.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <quic_kkavita@quicinc.com>
In-Reply-To: <81f864e1fcc1c226763273dec915e43f1fe14f5f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jUQO5L1ijOZ0xUCurokF6M-Jc03lD69X
X-Proofpoint-ORIG-GUID: jUQO5L1ijOZ0xUCurokF6M-Jc03lD69X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=845 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190089



On 12/19/2024 2:31 PM, Johannes Berg wrote:
> On Thu, 2024-12-19 at 11:35 +0530, Kavita Kavita wrote:
>>
>> The for_each_subchan() macro will not work for this. When sub channel is
>> null, it will terminate the loop, but in this case, we should continue
>> checking other sub channels.
> 
> Wait, I'm confused by what you're saying here. The for_each_subchan()
> macro should iterate over all enabled (not punctured) subchannels, so
> why would it not be applicable here?
> 

So, In the following regulatory checks: cfg80211_get_chans_dfs_required, 
cfg80211_get_chans_dfs_usable, cfg80211_get_chans_dfs_available, and so on.

When iterating over primary or secondary bandwidth, if we encounter any 
null subchannel, the loop will terminate, and we will not check the 
remaining subchannels. I handled this null subchannel case within the 
macro itself, so when this situation occurs, the loop terminates and 
does not check further subchannels.

However, for cfg80211_set_chans_dfs_state, we should iterate over all 
channels, even if any subchannel is null.

The for_each_subchan() macro is designed to iterate over all enabled 
(not punctured) subchannels.

However, I implemented this macro specifically for the above regulatory 
checks.

I will fix this in the updated patch to make it applicable for all.

Thanks

> johannes



