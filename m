Return-Path: <linux-wireless+bounces-13087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6823C97EF64
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 18:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DD91C2142F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 16:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F2219EEB7;
	Mon, 23 Sep 2024 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ousdaPam"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C98719E96E;
	Mon, 23 Sep 2024 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109732; cv=none; b=KYlx4q75UpOdMMMu9/rcJI2cSLCtNGHz7Oa7UDKmpCCBeUtQXqn6c+ahADE3zcf5u+tTBWIG8+uoaKyrRxytNDLOZi3OScpbaQrgEnrXNGimjtiEIKy/EC5cdxflf2wcg0CNsDEpoxiALHN30d4J/mJcut/Qb2+siGPJCWjo2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109732; c=relaxed/simple;
	bh=2M5J+TbVZFk4TiTrNW3LHK0inn5MLmRnFEcbUeUZrPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z4DLHhnyxiXyf5Q3Jhix+oBD+ZokPfoWzHkVaZCHByKjtvHeHyw11e34C0S/gmM56cvXiA1mhiTqmllvTobYl5cbR3bJXC2WKqiZfDtTxkfIE1qNcWcjfN2+GFiaShxofODK3LbLwxplbc6/5HnT11btAzvfFrX6B9iJZO+2cxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ousdaPam; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NBaSfi002210;
	Mon, 23 Sep 2024 16:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rrauDeWc9p7iK81JL4w61/Po1J4RqQlMEpxtgv9Ofjo=; b=ousdaPammY40oyo9
	nqc5SiLNSRhPKXzQctWofmKqbF8y4PjgUcZGktEnRdXpZvp4kXvjH5Zp8qIbK4d5
	r2TvHa8aPL7iTm86CqeZF2t2JFrvNni0JuOvdjvVEeM1cmYPgYxu1pmrZvXdKAUe
	Ld4HB107h3KPdIhtt8otyO460SZ+gpl/nW+EN1GWYczuSRCfPE9l8SC/nujZ0Kfo
	o9LpvOS6RZOkbkSw99BwePYMQgW3B/kFLVi5Ljqa5kHNxOfhLj+BqzM/YitxY1Sy
	Ae3oVPlbUpUWTpwkf7Zrqe7SeWkVpYseymfhpMfn4AOXGasQE0wfXWCZQNwusGG2
	Dtc3QA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn5bnnyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 16:41:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48NGfWTU003416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 16:41:32 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Sep
 2024 09:41:31 -0700
Message-ID: <80b820cd-9255-473e-8e4a-3e7d8612d876@quicinc.com>
Date: Mon, 23 Sep 2024 09:41:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ath6kl: Reduce scopes for two variables in
 ath6kl_sdio_power_on()
To: Markus Elfring <Markus.Elfring@web.de>, <linux-wireless@vger.kernel.org>,
        James Minor <james.minor@ni.com>, Kalle Valo <kvalo@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
CC: LKML <linux-kernel@vger.kernel.org>,
        Steve deRosier
	<steve.derosier@lairdtech.com>,
        Julia Lawall <julia.lawall@inria.fr>
References: <d5a19bb5-f940-4f07-9f98-c670d96cc839@web.de>
 <33b08664-fa25-4cef-86b2-49f65b4369c9@web.de>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <33b08664-fa25-4cef-86b2-49f65b4369c9@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z5WtGCqt0ue2DvVakkqBrKw_nWAmZSS2
X-Proofpoint-GUID: Z5WtGCqt0ue2DvVakkqBrKw_nWAmZSS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 mlxlogscore=873
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230124

On 9/21/2024 5:06 AM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Sep 2024 13:30:48 +0200
> 
> Adjust the definitions for the local variables "func" and "ret"
> so that the corresponding setting will be performed a bit later.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/net/wireless/ath/ath6kl/sdio.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/sdio.c b/drivers/net/wireless/ath/ath6kl/sdio.c
> index e4d15cc9b36c..689f83f6bce5 100644
> --- a/drivers/net/wireless/ath/ath6kl/sdio.c
> +++ b/drivers/net/wireless/ath/ath6kl/sdio.c
> @@ -503,17 +503,15 @@ static void ath6kl_sdio_irq_handler(struct sdio_func *func)
>  static int ath6kl_sdio_power_on(struct ath6kl *ar)
>  {
>  	struct ath6kl_sdio *ar_sdio = ath6kl_sdio_priv(ar);
> -	struct sdio_func *func = ar_sdio->func;
> -	int ret = 0;
> 
>  	if (!ar_sdio->is_disabled)
>  		return 0;
> 
>  	ath6kl_dbg(ATH6KL_DBG_BOOT, "sdio power on\n");
> -
> +	struct sdio_func *func = ar_sdio->func;
>  	sdio_claim_host(func);
> 
> -	ret = sdio_enable_func(func);
> +	int ret = sdio_enable_func(func);
>  	sdio_release_host(func);
>  	if (ret) {
>  		ath6kl_err("Unable to enable sdio func: %d)\n", ret);
> --
> 2.46.0

NAK

no maintainer wants to spend time on patches like this which bring no real
value to code that is not actively being maintained, and which violates the
established understanding that, except under certain recently established
criteria, declarations and code should not be interleaved.

please avoid sending any patches to ath* drivers that do not fix bugs.

/jeff


