Return-Path: <linux-wireless+bounces-17774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F006DA179CF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 10:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050D47A4359
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F411B3925;
	Tue, 21 Jan 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FHR251L/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCB1B6CF3
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737450211; cv=none; b=ObhsT+GYZxTkmK9/Se/kjFeKbmo1isvHOn2hJwIsECjH4cA5+x70jyNXv2SLq/13GKgNg+2nC2jKrsQK5WOswxnUQFX2GFvuvUmDA43U96lfdQMMLWqBtBhp3c7UHKp7LukBsJLUm1pI4w8Lliu7rmT0eAMSvLPa2Jg/EVPKBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737450211; c=relaxed/simple;
	bh=JzbR8z9qVm+mvLOHqlLSsRO087BFzj7q/bbHoO/Y4wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h6OshTDOZD1ixq5+i6kWLC6sn9NeI+vvG+d/lDfa7nxtLOzlvHjiCg5UqI7CF0REXCxG1kt0Pj4m8RLLdUaWXLNWMBUQccRA8czCLAbbvsuK8Cz1qRss3e/uOQ2SFgNqFh4YFUmJoLNxN8NxpQCpnxVHQvVrfqy+RudaWh5iHIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FHR251L/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L8Ykj7009150;
	Tue, 21 Jan 2025 09:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nOmxGULGuRWlpFQmMFFTRM2ETutV+o82//ne1gQwiBg=; b=FHR251L/liWUe4Lj
	99ZdP4ZHzgatiPsRFZRT008Mh1TY19CZ0+8rJGR4AQw6gEZoghfqKMhvZbRX9fQj
	uzfDckt+JKkJZZZZlWGSlNmz3LjEdj2tBJsqIGo6Sf4K++8uA6TQkYAh8tWE56tF
	m0HUyEsu17SIhriEZJwpBGv6AgzAr+1MvZPGYx8OlCmQ7w+U7ylbI4fCJzR9ONOZ
	gIqZiu+ZSzEQNTTdTJKjUujc4eKIF7Sr3PR1bhfSPNzAdbvsuaTEYYq3dDvJ0sOr
	o3qCYgCKIysyuYn6SaixAXD8JN3zkCc7Z2ZizR+1hh+P7HTm8b2LzlPeAT170r1n
	m9th2g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a85sr2hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:03:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50L93QfU027784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:03:26 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 Jan
 2025 01:03:24 -0800
Message-ID: <97ae78d5-7d87-41a2-a50f-72cf40c9ed56@quicinc.com>
Date: Tue, 21 Jan 2025 14:33:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] wifi: ath11k: update channel list in reg notifier
 instead reg worker
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250117061737.1921-1-quic_kangyang@quicinc.com>
 <20250117061737.1921-2-quic_kangyang@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250117061737.1921-2-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LnKqIVJqCVnKT1oC1j4AdaesZWdDljvl
X-Proofpoint-ORIG-GUID: LnKqIVJqCVnKT1oC1j4AdaesZWdDljvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_04,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 clxscore=1011 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501210074

On 1/17/25 11:47, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Currently when ath11k gets a new channel list, it will be processed
> according to the following steps:
> 1. update new channel list to cfg80211 and queue reg_work.
> 2. cfg80211 handles new channel list during reg_work.
> 3. update cfg80211's handled channel list to firmware by
> ath11k_reg_update_chan_list().
> 
> But ath11k will immediately execute step 3 after reg_work is just
> queued. Since step 2 is asynchronous, cfg80211 may not have completed
> handling the new channel list, which may leading to an out-of-bounds
> write error:
> BUG: KASAN: slab-out-of-bounds in ath11k_reg_update_chan_list
> Call Trace:
>      ath11k_reg_update_chan_list+0xbfe/0xfe0 [ath11k]
>      kfree+0x109/0x3a0
>      ath11k_regd_update+0x1cf/0x350 [ath11k]
>      ath11k_regd_update_work+0x14/0x20 [ath11k]
>      process_one_work+0xe35/0x14c0
> 
> Should ensure step 2 is completely done before executing step 3. Thus
> Wen raised patch[1]. When flag NL80211_REGDOM_SET_BY_DRIVER is set,
> cfg80211 will notify ath11k after step 2 is done.
> 
> So enable the flag NL80211_REGDOM_SET_BY_DRIVER then cfg80211 will
> notify ath11k after step 2 is done. At this time, there will be no
> KASAN bug during the execution of the step 3.
> 
> [1] https://patchwork.kernel.org/project/linux-wireless/patch/20230201065313.27203-1-quic_wgong@quicinc.com/
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>


-- 
Aditya

