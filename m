Return-Path: <linux-wireless+bounces-19028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA550A37A33
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 04:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9793AE90B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 03:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7773A5C603;
	Mon, 17 Feb 2025 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WYTyPHX9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C986C2C9
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739764372; cv=none; b=bUs3NWoCJpU3le+eD84l0XqhL7ZCaTk8pNLjRI+9yCAlzQffRZGjCvZuDH9v0ugdsuSaCBLO4TEAcoh/iyea8ByRkyOXdhFukT9CqejOlWlQf8S1mNnOod5zV5yqesXFh/CrsC+XtJdhwQ79hEAlf3wfgmjqsvU8g9QLOXIVY3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739764372; c=relaxed/simple;
	bh=kdeDHW6f3Rv2ZPpMl74QOG8+Co49wn4fJjLGe3cscVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K4t7VK/3CxbxugscAcTf/HF/BP1mcL7aCQop3s+/h14HAa5Flzf0z/yq3Gl0/8glZvpBGiP9o00XVMJUW0QWOzfkX7FJwndZgWHKk7yZqDp35e0/iNNGtHM6OzMDsR9tInAM0bEoE04sPvr9WB/bEGcVCAqyZ+rdiJIKdOQgtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WYTyPHX9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H03DDM022862;
	Mon, 17 Feb 2025 03:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MHOT/tIVc3KEdfX3aJDRjS0QlWTWE2GxKNZqfA9jy5A=; b=WYTyPHX9MjqytOsU
	MsoaVjMep6iAB/V58YMz8wBFadN9S/7Q1LWS5MiTSkKVNa0C2sOQKog2Z16oVXYJ
	g4yxbCD9cfgho8TB7RIPOAH/cLKScqz5lPvQ7n8g4oAjKCyiPn39HqX6JdZSZAl4
	Lw7Anv5BpaBaaaKvkt1IsyG36J5at84HEo6RSPYPzxoOCuWrRk3FIMtOxURQHEz/
	nKzfgBXaaMocyLQG7hhzYBLf5DPUPdLaAffNq24sv1ByEsJzAmY16ullo1I+WFTX
	FSWAKtwTzn/hTNgqK1M3OlR3SoSlJdOcCiwjxnMj76FUdnsr5DhfIoKfYoKLm6ic
	VP6jyw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7vgcmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 03:52:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51H3qa5d024687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 03:52:36 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 16 Feb
 2025 19:52:34 -0800
Message-ID: <32bf3919-8347-497c-a534-0d61a935eb47@quicinc.com>
Date: Mon, 17 Feb 2025 09:22:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] wifi: mac80211: correct RX stats packet increment
 for multi-link
To: Ben Greear <greearb@candelatech.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>
References: <20250213173206.1665731-1-quic_sarishar@quicinc.com>
 <20250213173206.1665731-2-quic_sarishar@quicinc.com>
 <26f57f33-459d-4563-b0a5-2c5c287e1d55@candelatech.com>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <26f57f33-459d-4563-b0a5-2c5c287e1d55@candelatech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jW5_WEWVChAx_f5neXrc1EA2FvVcamD-
X-Proofpoint-ORIG-GUID: jW5_WEWVChAx_f5neXrc1EA2FvVcamD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_02,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170030

On 2/14/2025 1:47 AM, Ben Greear wrote:
> On 2/13/25 9:32 AM, Sarika Sharma wrote:
>> Currently, RX stats packets are incremented for deflink member for
>> non-ML and multi-link(ML) station case. However, for ML station,
>> packets should be incremented based on the specific link.
>>
>> Therefore, if a valid link_id is present, fetch the corresponding
>> link station information and increment the RX packets for that link.
>> For non-MLO stations, the deflink will still be used.
>>
>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
>> ---
>>   net/mac80211/rx.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
>> index 1e28efe4203c..eb3e2d550c8f 100644
>> --- a/net/mac80211/rx.c
>> +++ b/net/mac80211/rx.c
>> @@ -231,8 +231,19 @@ static void __ieee80211_queue_skb_to_iface(struct 
>> ieee80211_sub_if_data *sdata,
>>       skb_queue_tail(&sdata->skb_queue, skb);
>>       wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
>> -    if (sta)
>> -        sta->deflink.rx_stats.packets++;
>> +    if (sta) {
>> +        struct link_sta_info *link_sta_info;
>> +
>> +        if (link_id >= 0) {
>> +            link_sta_info = rcu_dereference(sta->link[link_id]);
>> +            if (!link_sta_info)
>> +                return;
> 
> I think if you cannot find the link_sta_info here, you should just use 
> deflink
> so the packet is still counted?
> 
> Thanks,
> Ben

Currently, we are consistently searching for link_sta, and if link_sta 
is not found, we return. We are not utilizing deflink when the link of 
link_sta is NULL. Additionally, while populating stats in station_info 
structure, we are checking sta_link for link stats instead of deflink.

I believe that filling the stats in deflink is not beneficial for MLO 
link-level stats.

May be Johannes can comment on this, if still required I believe this 
could be taken as separate changes.


