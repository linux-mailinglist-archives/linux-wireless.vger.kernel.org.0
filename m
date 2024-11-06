Return-Path: <linux-wireless+bounces-15015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE789BF675
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 20:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7222D1F23396
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 19:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F7209691;
	Wed,  6 Nov 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QzGAa+uz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98201209F38;
	Wed,  6 Nov 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921356; cv=none; b=CRkD1UD1ssQzOt6kKE7Q6nahRBr41Z0vn9l20Slp6oILslIcJIt3P8e4DuiSJqSbK5EkhcTjvIjCDQTuh3n02COWTNLRGDm5jMaWF1xAjvGAKLO5708ltpGtyezEDSrxTnbzwyyZy39IInYauIlHexpmyWHMcoj/GRJc5tgBtgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921356; c=relaxed/simple;
	bh=wRXdvUkid6+WJT7OHlkdaJG33tESqCLQbCEaOYmhIeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KRiIJ5lhcMnocFHIGJw5B3sw/NZymzgoYVWui2oi0Us9rNlwg8bfAPVGpxpS2mYD7LFrf/AtpoqaNDncHjzVJGDjAo98GR3H9MelW+nJ2mIxoBum6v5LMDqC74oUPjwE+z6X0YWZ73JNxGhFCK0yTXluZkhHBPd/7MvEmXdGYUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QzGAa+uz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A69LUOt003865;
	Wed, 6 Nov 2024 19:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OQCQQkC9LSn1cPdQAofsX2DCjllx1SA7Oub3ZxyLGn8=; b=QzGAa+uzBDgUn4qY
	orflcgR3tR5btQxEY+xvMh8MCSZUTU2l9w/IKBmTdx9HX7DnrVl8pZspg7TfnoK3
	QAKKsH+vulmcgTFVHLYR88LgBw+z3iX2U9vRHLc8kFJmWapiZv3nqNYDvRaOglxo
	RmUQ3PNGKuNvEPjYpk9iP2he94ECHAgGjA0HYawDvgcTqLxNVQ/uOQfCULX7oR+M
	A4SGx3FNRYjbchMv7I+AWMnOdS2TpNHBLdf0+rSHbqiwn1Kh0x6OEbnMz4VbNUSu
	0WJCH0fRrQuoaawbE3eBoxKX1OANZGkY7WYceGWIwbiGCWDr891yIdF0rpd6aKq8
	JkTa9A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qhbucy3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 19:29:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6JT70B027884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 19:29:07 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 11:29:07 -0800
Message-ID: <1c248298-da83-42a5-8c96-c3db7f64b39a@quicinc.com>
Date: Wed, 6 Nov 2024 11:29:06 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] wifi: ath11k: miscellaneous spelling fixes
To: Dmitry Antipov <dmantipov@yandex.ru>, Jeff Johnson <jjohnson@kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A . R
 . Silva" <gustavoars@kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
References: <20241024111921.93105-1-dmantipov@yandex.ru>
 <20241024111921.93105-3-dmantipov@yandex.ru>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241024111921.93105-3-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mDdyY346GDDxxcX2r4rLH61Dhzk1JUDx
X-Proofpoint-GUID: mDdyY346GDDxxcX2r4rLH61Dhzk1JUDx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=624 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060148

On 10/24/2024 4:19 AM, Dmitry Antipov wrote:
> Correct spelling here and there as suggested by codespell.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: join the series
> ---
>  drivers/net/wireless/ath/ath11k/hal.h | 6 +++---
>  drivers/net/wireless/ath/ath11k/mac.c | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

feel free to submit this separately

ath.git is not taking any of your __counted_by() changes that aren't tested on
actual hardware



