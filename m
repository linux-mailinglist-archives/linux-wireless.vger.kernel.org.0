Return-Path: <linux-wireless+bounces-24726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFCFAEF621
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 13:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857DB3A69ED
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 11:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C15527057D;
	Tue,  1 Jul 2025 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S42xIoYN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B631D221281
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368137; cv=none; b=F/1T9iCYa8JCmwfiotoH+Gg9JSJSzswJnC28Z66uNLYo1xn1JIParwcp0EV4Y1/OEckodxjIOavORFcCXC4OTiaHUkOquYXFtT9st3PH1ZYxjwaTcImrt9smOeGy+n3EmxMLnh/zWQSNGdimWMTZbw7y1Jqk1B+9oz5jQTec47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368137; c=relaxed/simple;
	bh=wTZUi4vju100Tja8ABb3JcBpG3pYHG0mJ4B6j6MtUD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WbfozW8YvjP138DWyjxeXld7r4/7HQD/mua1rI16IY8cNDHI8G/fplVc0BtB5zTf53wiM0wMloSC8QA6MhKvWuOCkoTZRWPs7yDf7Cihqwk2i4WpPtpOw4iD2xFPrm4r01b1JhnV+SsXtN71BYwCqYYDGuyfkhxicsm4nTRPk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S42xIoYN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561ANP1m025098;
	Tue, 1 Jul 2025 11:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EXz229/r6m6HxzE2YbFgwqw70Gw4tlfeL+W5f6ZoJu8=; b=S42xIoYNc6qDylgN
	a9VksuEQnqkyq3v6RBbNcJaqQ63Ww5a8ME0FzO2SQTYofo9IYdvT4isKKAsCJMLL
	joqXyHMWsFVcAljrwySZGP4vDcG+1JSIkr+IleF18Zjv7TV1IUJSkZ6DJ/yUUxBS
	QnuaMhrE24r/DksuJLoB2/Ajb2/v6jJfTkqLdV73hFAVZRq6KVYwY0Pxai8/Tza1
	np3bP+QRivWsxKB3hshHLTaaZmrFjMlpLxGCeMwc1X/mJ22YtfLGv/nzqSu/1ikL
	Y7nGBGrqAMzbQwdvjHWYeKiBMhpnoi0ckj83Lp5W5vgAWFyQOUsjtOgh+4aWXOhQ
	LUliBA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8020gtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 11:08:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 561B8nQs027798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 11:08:49 GMT
Received: from [10.152.204.0] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 1 Jul
 2025 04:08:48 -0700
Message-ID: <976b8fd6-c7a8-0372-c24d-3423eefb8309@quicinc.com>
Date: Tue, 1 Jul 2025 16:38:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v8 0/5] wifi: ath12k: add support to fill link
 statistics of multi-link station
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250701105927.803342-1-quic_sarishar@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250701105927.803342-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x2nAJ9aTWOCS7BEHQxGMX8uxEQ9hiFjJ
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=6863c1c2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8
 a=PR1o3sFXcxSDq6vng0cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: x2nAJ9aTWOCS7BEHQxGMX8uxEQ9hiFjJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2OCBTYWx0ZWRfX3KQYNmKq09bU
 SlDhhSza+NQJae2ASrf5168cFNI8rrxWLxDE9RnMfKpRAxlwnUWFOL+/SIUcw2VMFa0/1MAlb/H
 CufNrzZ1gukEIGaCwqBTupgjTHWDZyjgLpKMflH7P84hMFi6AixKLF7Ih/rXsegXxBXBpOISLBb
 gCEnNFysYiz0Ab3z1smsLIibNEnmWYp2JOyW0nbwlDSazGYztm9vM2UrTXg0BdNffXwGfAKTkF2
 kwpCuvyIarCVY7AiNywD/U1iIrUA66tL1iz5iby/Mq+0oVkKCH0X0JxYgevAwQMuvElp7eNO/mp
 4zZHoUs0weP9drvIDXPryYNUlGsKNmzRSzN0B+Nshv5Ja5qhLHBBm3ULX/IYQQxz2ayKXkOBrQY
 xNBsuVUw19HMZZ9f/1tsiZeB03RE6FzyT5IUpUs33piAOyrWPjCDxIfZ5OrPauFo2+hm54it
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=795 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010068



On 7/1/2025 4:29 PM, Sarika Sharma wrote:
> Currently, station statistics are filled at deflink for both non-ML and
> multi-link(ML) station.
> 
> Hence, add support to fill station statistics for the corresponding
> link of station.
> 
> V8:
>   - Remove unnecessary initialization of bool is_ofdma.
> 
> V7:
>   - Rebased to latest.
> 
> V6:
>   - Remove dependent cfg80211 patch- as merged.
>   - Change the code according to  design change of cfg80211 patch series.
> 
> V5:
>   - Removed mac80211 patch from this series and included in dependent series.
> 
> V4:
>   - Removed driver patches.
>   - Added branch tree tag.
>   
> V3:
>   - Fix kernel test robot build error
> 
> v2:
>   - Convert RFC patch to actual PATCH with each patch bisectable.
>   - Add new patch to update bw for ofdma packets.
>   - Add new patch to fetch tx_retry and tx_failed packets.
> 
> Sarika Sharma (5):
>    wifi: ath12k: fill link station statistics for MLO
>    wifi: ath12k: add link support for multi-link in arsta
>    wifi: ath12k: add EHT support for TX rate
>    wifi: ath12k: correctly update bw for ofdma packets
>    wifi: ath12k: fetch tx_retry and tx_failed from
>      htt_ppdu_stats_user_cmpltn_common_tlv
> 
>   drivers/net/wireless/ath/ath12k/core.h   |  2 +
>   drivers/net/wireless/ath/ath12k/dp.h     |  2 +
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 22 ++++--
>   drivers/net/wireless/ath/ath12k/dp_rx.c  | 48 ++++++++++---
>   drivers/net/wireless/ath/ath12k/mac.c    | 88 ++++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/peer.h   | 26 +++++++
>   6 files changed, 173 insertions(+), 15 deletions(-)
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

