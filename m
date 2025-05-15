Return-Path: <linux-wireless+bounces-23031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B75AB8E15
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 19:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B7D1BC583D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166AF8F6E;
	Thu, 15 May 2025 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bT6bG8Q9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE11361
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331280; cv=none; b=jopuSONENAE4TTgyppGqP15LCQc3rLfDge548C7T74tAmNheTtCgdd0gPUkioMd4Kv5j3aVJ4LFfca8FfDeQ/5ZaoykMRxiaAMkG0EL9+oYsyUrXEL4tYoEm8QCXs9utf28n3B7BtpjN74kevFXd1rBoP/fzVz2Xf/JqGbRJRcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331280; c=relaxed/simple;
	bh=cXjPcZwV121S5o6u9NZDSKVzRc1aGiPoAyS5f5j4ojQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q3qoZR3CiSsSodl6AA3va1CafarXt0X3RWNl8Okdb+HsHJs0DrVNrtsEYe8R7dpD/ToKSoHwuVXZiAymzS4Evc2RdHhY78GzPljgQ1KT8SlCRNupeHI7FZu4ijCCFCivJeDqaOB2inXXhi6wAosRmAYa1Hz+XarZzcrQ/UxJSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bT6bG8Q9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFCx4026140;
	Thu, 15 May 2025 17:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nBlkn25NX2626G9KjiNZ3arTXWtTINesJ6phcfXkemQ=; b=bT6bG8Q9pWCskNGK
	b9VwzUKKQTCVrBFw8KlaRMp0uqMSzqaxuAS9+MjOP1JqeJ5hxAZLYc6c4MOhlk0H
	O36A97ePbhMVg5pvHH2rtHcNUOn4Cw5m7OCh4dRtAUC6ypD7ACZ51zQUYo/vy11r
	lX5jkYF9vVuf/9ZSXT+D6yckaInhXUkmwHNQseLwOI/QBmmFSTHCDjx7QXTURVUW
	hjRiyjzH9vfpfRyNhhAOlmRKpJNKFAdn1vM1YA9IHHO3PV/+CQ+g/YoKEBqlNwzq
	g9wpFaF4DucHoiUqzwjRilvgwXPk2QCmpzp7pgvzOb99/yYclZQyr96MoAyzPyz/
	aFLPIQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcyq9tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:47:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FHlrpN028709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:47:53 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 10:47:52 -0700
Message-ID: <6aca52d3-b8d1-4e71-a51c-1fb6250859c3@quicinc.com>
Date: Thu, 15 May 2025 23:17:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
 <7930179174c97d598a40b789abc43cb36c947dde.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <7930179174c97d598a40b789abc43cb36c947dde.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D-wNi4PAZOZQm4CVNjo7LD_SNdzfkY4e
X-Proofpoint-ORIG-GUID: D-wNi4PAZOZQm4CVNjo7LD_SNdzfkY4e
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=682628c9 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=q6SCKEJee5I3l0FuCyEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3NiBTYWx0ZWRfX9NKszc3L/oGS
 FgXtd+ymTX0VUAgGkKrjPtIjj3Tfo+PoL/s6DDySFqe+g3cCzhmnmKRU3rP6WqCLu6uzbc28TJ0
 K79JzxBN/u/U/YFo9rRLBW1Cb2cvCLTUdIKDFF2ISELJeBrgcpEBAEiaM17quTGwcSG00IJQX9W
 mlzynHfwQC3G90cfNXw75qvyhX8VsaHqZcmfD62EZ9dMsrIbZHN8uhSpx1+7yXZ/8+9uj17pwvd
 Bl2lMROE5ceY4J8JhAUHkxQi/i1+Mbclofe58iZYbXvXwajAeqhZSxtyI+GGTBUmZ3dfXsH2a4q
 XoPyEO1VK3nFivJYMe+rXJCD5x5YYZYxZbCmIURtEx6jCrFpBzL/YD42guNgk5eX/K8wLgJNQNe
 BHJOq5VYHHNb7B0tm4Mhiers/ZW/A49bhv83IJ05S2khH3vfbzu3IF3c3AYjW6d6J/flbfry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=726 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505150176

On 5/15/2025 5:11 PM, Johannes Berg wrote:
> Also,
> 
> On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>>
>> +static void sta_accumulate_removed_link_stats(struct sta_info *sta, int link_id)
>> +{
>> +	struct link_sta_info *link_sta = wiphy_dereference(sta->local->hw.wiphy,
>> +							   sta->link[link_id]);
>> +	int ac;
>> +
>> +	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
>> +		sta->rem_link_stats.tx_packets +=
>> +			link_sta->tx_stats.packets[ac];
>> +		sta->rem_link_stats.tx_bytes += link_sta->tx_stats.bytes[ac];
> 
> It seems odd to take per-AC values and flatten them in this case? How do
> they even get reported, as overall values only? Then you get the same
> inconsistency again on per-AC values since those are (or at least
> could/should be) summed up over all links, but aren't kept post removal?

Looks like we can flatten them. In existing code as well we have 
flattened and use, during sta_set_sinfo()

         "if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_PACKETS))) {
                 sinfo->tx_packets = 0;
                 for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
                         sinfo->tx_packets += 
sta->deflink.tx_stats.packets[ac];
                 sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
         } "

> 
> johannes


