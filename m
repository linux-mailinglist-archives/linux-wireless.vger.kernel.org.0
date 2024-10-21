Return-Path: <linux-wireless+bounces-14276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3669A6F78
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 18:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01A0283E60
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 16:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392001CBEB6;
	Mon, 21 Oct 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="orfvX9tR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA02F4A;
	Mon, 21 Oct 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528241; cv=none; b=pZwDEjlSuXF6j5ICf8MnEUcEOE4m4U4VeuI52D+fwKk6NB3oPr1Ba8qGyZC3Y7hniotmFVb092vu7Qq5siyqZFyARA7VsvrZ1cF8bT4sywclBaztEznCHQW32dlH7/OeMstiKV5MOrKTfOwMZY3c1faSAZVEMP7lyVYFMyQhWxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528241; c=relaxed/simple;
	bh=wVHygHLX0rRBWh+MRDKlvnD+h8J3+q7ltadnmhMxdMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VgX2ib16HGIbjxWqSe0tVPaLevOeZeqXhmx1HjMunf/osq/kOS0zvUM1c+BOhHaLRjRmJ0nrM3Lp2CPCqKcWnIe2Lz081KNNDpgaEGtRYXpHC0oRgyyeH9RuYSxJieLI3FPgmjPELN5GYFwa6xdoyWohCSpiVimKiI4105IllaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=orfvX9tR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LGLcu4014411;
	Mon, 21 Oct 2024 16:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B7SbI7GfHWJG7zU0LfJLxgCILdUeybLhY9e6jy8p+wA=; b=orfvX9tReUZru0J/
	X1GUjG45arnJtIoT/my1XoX/QkKRHR+DBibJCDwXeXPy/e0J/L9153JDdxBPLoVZ
	nvCGUgopV2pklzo/ZGXZ2O9o2iWjyeRUC6oJim3NnYnvWcrkQrfPJMpS6QGWUNQI
	p6WnptJjVdV+ay5XzLRevYZPw9iqm19h74Hwuzv0euBBaAPguYy4Hvsxs0Bwvuga
	xNnMjttX7ft76paqz4ihYCyHKeWugZjXt0OYk4TCTUFeSONn2P/W1HGXSBT+IQ5O
	G0W6TpgXDmYW5tHavBiqItM48HyKL6r1I7hHojDqjv/oahsnhd3It92JmdYHrDnj
	o9nvww==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkhd1jru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 16:30:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LGUVMQ011808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 16:30:31 GMT
Received: from [10.48.241.209] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 09:30:30 -0700
Message-ID: <be969496-0c74-400c-b856-9524746a5ee2@quicinc.com>
Date: Mon, 21 Oct 2024 09:30:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath11k: annotate skb of struct ath11k_ce_ring
 with __counted_by
To: Dmitry Antipov <dmantipov@yandex.ru>, Jeff Johnson <jjohnson@kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
References: <20241021142745.585308-1-dmantipov@yandex.ru>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241021142745.585308-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IRUHp4G_0wrYzE8DG4NQKUMqn40kwm2_
X-Proofpoint-GUID: IRUHp4G_0wrYzE8DG4NQKUMqn40kwm2_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410210118

On 10/21/2024 7:27 AM, Dmitry Antipov wrote:
> According to 'ath11k_ce_alloc_ring()', annotate flexible array
> member 'skb' of 'struct ath11k_ce_ring' with '__counted_by()'
> to improve runtime bounds checking when CONFIG_UBSAN_BOUNDS is
> enabled. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/ath/ath11k/ce.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
> index bcde2fcf02cf..9c54244970ce 100644
> --- a/drivers/net/wireless/ath/ath11k/ce.h
> +++ b/drivers/net/wireless/ath/ath11k/ce.h
> @@ -162,7 +162,7 @@ struct ath11k_ce_ring {
>  	u32 hal_ring_id;
>  
>  	/* keep last */
> -	struct sk_buff *skb[];
> +	struct sk_buff *skb[] __counted_by(nentries);
>  };
>  
>  struct ath11k_ce_pipe {

I won't be taking any of these without testing. I don't want to introduce
warnings due to the array being populated before setting the counter.

At a minimum you need to document where the counter is being set and verify
that is always done before accessing the flexible array.

(If it isn't broken, don't fix it)

/jeff

