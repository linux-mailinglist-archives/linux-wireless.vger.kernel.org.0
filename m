Return-Path: <linux-wireless+bounces-5268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1709088BA11
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 06:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC921F3B715
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 05:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E82D12AAE1;
	Tue, 26 Mar 2024 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b3CCjwnq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF512AACA
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432653; cv=none; b=IOD72EmKMmxxNvu7mluuU54jCtAd+Zp3sn0NsSVQPGA6utcKZGuR6yLAptJY8pTy+PdtjI8xyJ/c9I+XxsUuxWdXB4nkQ1SlkP1T2ab0jCFRjiDtGa42X+j0SKxGx+D8qj0xWH9XYCWGMAhjOf8gWU/NZEJ7XcDGEXYrGm511/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432653; c=relaxed/simple;
	bh=c6W0IRBBefYYfAAgYv7znP/COx4nHoernumAtC0Pz5o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=e1srgpmFvphAyanh06mr9CwNyK8gJvqW6dPMIJP2g/Y+QrcLSFD2qFS8JlLVLKpnitsRnAvDEP6Z4i6MK91/VcdV27JqYUvBW2Q6YwlGXOFRJkW6b6FZZMnMvyC1Mjq1vts0h7Rr+NKo466BUryHBAulFTVW1wHz+aq93ecZ8ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b3CCjwnq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q5o2gF028482;
	Tue, 26 Mar 2024 05:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1uH8yNwQMtsDvtG2o4kpREeJyV6I+yIigZwEysXzY4E=; b=b3
	CCjwnqKZSomR1HWY9RISCTCQj/88w0+G0VR/DWV6B6gtl7rt1ajqcCSBcjeKFcV1
	5h29ZkZefNHdvPDvfBGZWY9ubvvvLO1eKgDWUYtuYqMw8OPKa2ddNEayKHWZwduL
	DnGftCSQye1wZcwVSIgnqmKap3mSQwZlXY6aydbdj0Zn3rweuIOD/SSEOhSwe/ZE
	ASDCZT2hyfMnB1UGZFYn9bNbXy2PSbmxIjhoAKOTMFYKnGEj7qEhpLxs6oCNyRN+
	2ILXyW9cxaYKeCBWd8yi5wMlxyf43Az1Dt9hEEXiTAxQqqMG7ChOD2WonDY68xU2
	Lry2YKSjNyRwjJHFdIwA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3rj2r0s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 05:57:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42Q5vPBX030689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 05:57:25 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 22:57:24 -0700
Message-ID: <cd8f0071-1033-46b8-b7d7-3140079e8a5a@quicinc.com>
Date: Tue, 26 Mar 2024 11:27:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: validate link status before deciding on
 off channel Tx
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312154620.242773-1-quic_adisi@quicinc.com>
 <2c8338a29d3c42ebbf1fd5efd348c14471fa5004.camel@sipsolutions.net>
 <bc2422eb-efae-423e-b60a-2aa0a3ea94fb@quicinc.com>
In-Reply-To: <bc2422eb-efae-423e-b60a-2aa0a3ea94fb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: huw2Txk9LDBOXTbQzYkF9yMZT3WdwKki
X-Proofpoint-ORIG-GUID: huw2Txk9LDBOXTbQzYkF9yMZT3WdwKki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_02,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 phishscore=0 mlxlogscore=694 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403260037

On 3/26/24 09:58, Aditya Kumar Singh wrote:
>> Can you fix
>> that too? And if you fix that ... yeah we probably still should have
>> this patch but ... _without_ this:
>>
> 
> Sure let me try to fix that as well. So here's what Im planning -
> 1. Separate the ether_addr changes into a separate independent patch.
> 2. Patch series to fix the active flag handling at link level.

Upon checking further, I see -

If we fix the setting of the flag only when first link comes up and 
reset it only when last link is removed, then probably there is no need 
to add separate handler - ieee80211_is_link_bss_active() to check if 
any one link is active or not.

FWIW, the purpose of the new function introduced is to check if at least 
one of the link is active. And now if the flag is set, this ultimately 
means that one link is at least active. So we do not need to go and 
check in each link again right?

