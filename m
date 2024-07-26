Return-Path: <linux-wireless+bounces-10550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E027B93DAD6
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 00:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70EA1B22971
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 22:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D28E14AD19;
	Fri, 26 Jul 2024 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kT2U3pyF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE38812;
	Fri, 26 Jul 2024 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034310; cv=none; b=RhgkD+CpWhZj9XBvSnt71E7tujX925kYpRyhKWtORvdxg12O0GgbzfPK+oojpSXg7Z/dvDR6Eqqo2F19MlTzYX0i/+luNAlQ7LYTEEgVO4HdpvDRRaOzmmDJt29uZI0pH6IxAdckz5QIEHk3kSuNXV0wNNNKme0CO4oItEdRcPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034310; c=relaxed/simple;
	bh=JZFUiU+gRw5qCLmml+ZjbyuQp6PDRWONZ7fu5hDlrcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=INkF4g1QS7po2TPeX0WVtBXAjXgo7RWST8ch7g7WeREIEgmTmkwwoIQIOTmKA6HzlClFh5/tDTWdO6duKzRuo5XdxY7B4YL36pzGJ9Q3izVj3Yel9IOrbWJTmjXG8nW7KWv5An9RowNpjHPFIjwFdJ4wjy/zzuDmXHmZ2Z0kKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kT2U3pyF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QBUVkP027304;
	Fri, 26 Jul 2024 22:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tCX5pgNwvuFzxoqpyP7lwKLP1X7u8Hwdp/+BGUb+Nb0=; b=kT2U3pyFWlo1S1DY
	IN3mmImRJ3x+fLs3DWOzw6McK9EG8BskyWCmu42smmZsG485CV4BEl1SL5Au11ME
	oWISlzUOvuX8DVKiEazjWib4nS3DkEJ17+cb6cL7TL8MjoTSi5zBKGtJyMImHNc9
	xEUesvpIg0oCZcVZItIhM/2R0MGqcWpJCSs6Y8WvYBJZ2HNSQZvaY5oCCtjKCPIf
	plBNODAMYNqtzafCX+SbV1PUhwQ1UrkzHirfgsetR45Kzj7n/o7NYMTmXJyEKI2T
	WtC3yFXxuygJS8oOTGC3pPSWpu7xRN+/wWCvUJJ+aJ3uwY2yJw99OLojOMGKSP1g
	dWhjcw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40m1ttjk4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 22:51:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46QMpRhp031577
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 22:51:27 GMT
Received: from [10.111.176.158] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Jul
 2024 15:51:27 -0700
Message-ID: <dcd0d83a-af37-4ef5-8351-a435ab115ed0@quicinc.com>
Date: Fri, 26 Jul 2024 15:51:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rfkill: Correct parameter type for
 rfkill_set_hw_state_reason()
Content-Language: en-US
To: Zijun Hu <zijun_hu@icloud.com>, Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240715-rfkill_fix-v1-1-a9f2d56b4716@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240715-rfkill_fix-v1-1-a9f2d56b4716@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3N0DMc6iqsE3OVPl27DdsWrnjDWsd_jI
X-Proofpoint-ORIG-GUID: 3N0DMc6iqsE3OVPl27DdsWrnjDWsd_jI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_13,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=981 clxscore=1015 bulkscore=0
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260154

On 7/15/2024 6:39 AM, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Change type of parameter @reason to enum rfkill_hard_block_reasons for
> API rfkill_set_hw_state_reason() according to its comments.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  include/linux/rfkill.h | 5 ++---
>  net/rfkill/core.c      | 7 +------
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/rfkill.h b/include/linux/rfkill.h
> index 373003ace639..4f7558267541 100644
> --- a/include/linux/rfkill.h
> +++ b/include/linux/rfkill.h
> @@ -147,7 +147,7 @@ void rfkill_destroy(struct rfkill *rfkill);
>   * Prefer to use rfkill_set_hw_state if you don't need any special reason.
>   */
>  bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
> -				bool blocked, unsigned long reason);
> +		bool blocked, enum rfkill_hard_block_reasons reason);

function parameters should align on (

>  /**
>   * rfkill_set_hw_state - Set the internal rfkill hardware block state
>   * @rfkill: pointer to the rfkill class to modify.
> @@ -279,8 +279,7 @@ static inline void rfkill_destroy(struct rfkill *rfkill)
>  }
>  
>  static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
> -					      bool blocked,
> -					      unsigned long reason)
> +		bool blocked, enum rfkill_hard_block_reasons reason)

function parameters should align on (

>  {
>  	return blocked;
>  }
> diff --git a/net/rfkill/core.c b/net/rfkill/core.c
> index 7a5367628c05..f8ed6431b2f5 100644
> --- a/net/rfkill/core.c
> +++ b/net/rfkill/core.c
> @@ -539,18 +539,13 @@ bool rfkill_get_global_sw_state(const enum rfkill_type type)
>  #endif
>  
>  bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
> -				bool blocked, unsigned long reason)
> +		bool blocked, enum rfkill_hard_block_reasons reason)

function parameters should align on (

>  {
>  	unsigned long flags;
>  	bool ret, prev;
>  
>  	BUG_ON(!rfkill);
>  
> -	if (WARN(reason & ~(RFKILL_HARD_BLOCK_SIGNAL |
> -			    RFKILL_HARD_BLOCK_NOT_OWNER),
> -		 "hw_state reason not supported: 0x%lx", reason))
> -		return rfkill_blocked(rfkill);
> -

did you validate that all callers are actually passing a valid enum?
that is something you should describe in your commit since this is a change
beyond just changing the prototype

>  	spin_lock_irqsave(&rfkill->lock, flags);
>  	prev = !!(rfkill->hard_block_reasons & reason);
>  	if (blocked) {
> 
> ---
> base-commit: 338a93cf4a18c2036b567e9f613367f7a52f2511
> change-id: 20240715-rfkill_fix-335afa2e88ca
> 
> Best regards,


