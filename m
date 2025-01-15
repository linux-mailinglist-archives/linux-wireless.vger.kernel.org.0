Return-Path: <linux-wireless+bounces-17529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 781B8A1189A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 05:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA67167A35
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 04:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CFB22E401;
	Wed, 15 Jan 2025 04:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qm3Y1KqP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FD322D4FE;
	Wed, 15 Jan 2025 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736916772; cv=none; b=j1eM8t5E2jck4vylAdUhxId97mkyXYxpIeYjHlkrwTacOYXuaFO3Eh6M8b5ledHWvH7/Lf1O953my7YaXbx5R4SorIFhbbl1sSuZ3XF77ONxIA3m+n37u7S0nAF4o3R2NTxNvrRdV9BINajAp3X4DK4Yn2AiBzGwxDZamvwAqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736916772; c=relaxed/simple;
	bh=2zSMIc7SsmFSFASpJNoDw9TNsAkxJQB6XXrq6RkoZpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ItFpwBnaIG2eAd/telFXNnL8X5NFPlwGiZxH/sjEng9KJtTjzwcYNZGwXxAUXRWHaoNOsqIJYrGaWShYQSRt3nDkSlWQRLLh6sefRoyc9CWCo0G73htRmS5cL6B9cX49poPitRIySi+pJptSxOwHOSnqxpTYjkQGEYuJOv/I3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qm3Y1KqP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ELMjF7004053;
	Wed, 15 Jan 2025 04:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8qYUPlkg1yhMFgrFw+6gYp94n/I7Glr5J2ikRbSFZDk=; b=Qm3Y1KqPQ+x28Sp7
	8S5H8+lPkb8fCnTkIPjZrE2XOcx0pYFUs7PXVWSa3qRxvjrRkqq61pw0JvvynOxf
	MFLHo2ZLoWeWBzZ6te5zHCD+mq+cNpXwydYiIcC+aiMSLuzK9BcLck5L0jAiB992
	MjDoq2rjYb94pwlTg5K5cdpfqvJeE4/aCfSE5968N2iLkTs2NhVnt27cjL4A512I
	AoejD0oXMkchOth0oNq3H/XdE6RqLLorWNIiM3m+FbBCQCU2usOZrrVJ0lWVRmY9
	sFCwtRDMcV8lSDTrGYg4TeuuK81jqXeO96WHvB8XPg5zSDy3Y4BwMM98slBdce9B
	/DsMbw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445ysr8tj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 04:52:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F4qgj7005181
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 04:52:42 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 Jan
 2025 20:52:40 -0800
Message-ID: <bf3b176e-b09e-43c8-8404-4f4477dd4370@quicinc.com>
Date: Wed, 15 Jan 2025 10:22:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: handle
 ath12k_mac_ieee80211_sta_bw_to_wmi() for link sta
To: Kalle Valo <kvalo@kernel.org>
CC: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250110-fix_link_sta_bandwidth_update-v1-0-61b6f3ef2ea3@quicinc.com>
 <20250110-fix_link_sta_bandwidth_update-v1-2-61b6f3ef2ea3@quicinc.com>
 <87v7uhnst7.fsf@kernel.org>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <87v7uhnst7.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SfeW9J_l-0Ogh57AyjQYis5WWEWrUHIT
X-Proofpoint-ORIG-GUID: SfeW9J_l-0Ogh57AyjQYis5WWEWrUHIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_01,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150032

On 1/15/25 00:09, Kalle Valo wrote:
> Aditya Kumar Singh <quic_adisi@quicinc.com> writes:
> 
>> Currently ath12k_mac_ieee80211_sta_bw_to_wmi() handles the bandwidth from
>> sta's deflink member. This works only for non-ML station. Now that MLO
>> support is there, extend this function to use link sta instead of deflink.
>>
>> Additionally, in ath12k_mac_handle_link_sta_state(), the link sta structure
>> is not accessible, making it difficult to fetch the bandwidth there.
>> However, ath12k_mac_station_assoc() does reference the link sta structure.
>> Therefore, move the initial assignment of the arsta bandwidth member to
>> ath12k_mac_station_assoc().
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> 
> So how does this help in practice? Ie. what are the user visible
> symptoms this patch is fixing?
> 

For MLO station, any bandwidth change post initial association, the data 
will not go in the latest bandwidth of that link. Since to firmware, 
only deflink's bandwidth will always be configured.

For non-ML stations, no affect.

-- 
Aditya

