Return-Path: <linux-wireless+bounces-9021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B1D909A44
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2024 00:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCD31F21B80
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2024 22:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB4761FD1;
	Sat, 15 Jun 2024 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iR21zgFO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82158825;
	Sat, 15 Jun 2024 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718491309; cv=none; b=S8YSd2jJhK9ajV0zpm7OyYX+PmrKSAY1fvIuKo1l4qmlhenzNK5qvSLbHCCmkOUX6y8rzdFyjTe4ecsCfz1X90R0LuRkqBsHIFKrSsIlI+iPNROXdP2rjujszSlndYv+rLQjHaoPqpg3HM3/wF1Wzc7E/UMO+lzqbfQHvo1NP70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718491309; c=relaxed/simple;
	bh=zTomvuEXwFeQv6R1wyXc3ygD/xU6T8enKPDdKqX/JOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CXGCFE76db4Hp9N8NvEhO9fyWTBma2nbNCvWtZQ0QoX9AEPhLPwxfmopPBWlj5wpGTtRATe4oquCMCzXcT0l6757hsh/8Gsh6Ro82NdZ9JSlFPjO1mS+wPamKbzCWW4sxXaH7IhnT0NdBuy+dyzF23axrN/JBX3eV8amrm4lOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iR21zgFO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45FMZqK2010384;
	Sat, 15 Jun 2024 22:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4AtUIj6+jb5pJN+Yhpmk82WIhOJoGk8n1f7dla6Xlm0=; b=iR21zgFOVht0G1Ui
	XjJS54b5VR0MYNZs30FiK4NRDdgMwxvqkAd9LJtztyJRyuD/0dGEiHN7z4bTtyLM
	Y0YRf9IuFGfzd6RiPosAdTaleqeXTXoIL9zhy9Tga7Gdl2U7MaELRh+79E51f8AN
	cBbumSku2iAJWaCOfSIkn+MGpe5F6GUU73xffHwxE7OJd1O63akblDz8KRmQ9SYJ
	n1dbe+Lx8MSzcIYQQFFcezmOXKGu+DK48so4afTR8r8o80BHqr7R4XER5A535slH
	jKhlz79puLB7UQH3d3TzDH6YC0hdE5Z8UJFJv82063Ney1ph4EXqAKrRmFUKl6GS
	u4geGg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys0an1bm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 22:41:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45FMfc4W017091
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 22:41:38 GMT
Received: from [10.48.243.167] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 15:41:37 -0700
Message-ID: <b26cbfac-b9cd-4682-86a4-4686c3ec15bb@quicinc.com>
Date: Sat, 15 Jun 2024 15:41:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix potential NULL dereference
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <4428a7ab-eb67-4f0e-992f-35577ea2b564@moroto.mountain>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <4428a7ab-eb67-4f0e-992f-35577ea2b564@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aC2NQg2k6GFhXZI6RfdtvCdTC5lHxb_t
X-Proofpoint-ORIG-GUID: aC2NQg2k6GFhXZI6RfdtvCdTC5lHxb_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_16,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=735
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406150173

On 6/14/2024 10:32 AM, Dan Carpenter wrote:
> In this condition if "sband" is NULL then it leads to a NULL dereference
> on the next line when it does "idx -= sband->n_channels;".
> 
> The condition can just be deleted, because if "sband" is NULL or the
> "idx" is out of bounds, then the correct thing is to at this point is to
> return -ENOENT.  There are no additional sbands available to try.
> 
> Fixes: 70e3be54bbdd ("wifi: ath12k: fix survey dump collection in 6 GHz")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 509c02bffdae..e5456383dabd 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -8314,11 +8314,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  
>  	if (!sband)
>  		sband = hw->wiphy->bands[NL80211_BAND_6GHZ];
> -	if (!sband || idx >= sband->n_channels) {
> -		idx -= sband->n_channels;
> -		sband = NULL;
> -	}
> -
>  	if (!sband || idx >= sband->n_channels)
>  		return -ENOENT;
>  
This duplicates
https://lore.kernel.org/all/20240611031017.297927-2-quic_aarasahu@quicinc.com/

