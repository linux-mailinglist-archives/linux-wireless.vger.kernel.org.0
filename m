Return-Path: <linux-wireless+bounces-10266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D94493298F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 16:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8106B1C20B41
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDCC1A0AED;
	Tue, 16 Jul 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kTllUNj9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214F19B3D6;
	Tue, 16 Jul 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140876; cv=none; b=NRpYYWjfWd9aLDvgExSijffbGgqi8AhHJrGx77TxUMjB0xypv+5oobL6IJXDKDnA2mDSDdeVN7W+TXq4pxsOH91NvFCcD+gWjdM9xmQnEUtb5QegezyJKDJLqAnG92shcVM8icBseUks6UmCLo9kRMxsYgkBWz+nFSxCa0YOk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140876; c=relaxed/simple;
	bh=anaUBK+dep9/rBEfBe2oKEYQuVt/IGTEAa2GVzdz6HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oqagY7jcEs9ahnB20tOLXKZSUbCMg8NtZACvmZd3EvBnkfRvvvlelV6GL6xUreTZDwDoOHO5grCehp5QIG7bh5kpIPUZ/Khc8/iRmv/wrHVsvxE4j+oKmYJbDwZlokmVi2X1gJ5CBrTlaVFnmWyZe6HkpTWIH4159OmqGRPEfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kTllUNj9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GDR4Y7021550;
	Tue, 16 Jul 2024 14:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z+ZiobYmNSqYGyNF4Jfh80LXbvHZvZQKCWqa2am9DI4=; b=kTllUNj93P/HRCOx
	ipWFjO0DpNseMuVr2nWXZKDi/YlDssq6DYIvHGmWJkL21HzAV451yi8rSz2mJ1eF
	XNRXpTIDBtBAkY7b693TK0n4XIp2e1xZZ594Djbgkrab/XF6WOeKeN/pW/we98vz
	a+hj5DlNBmNrmNDUcmC1CZje5R9IAe8s7b4eY1QJamDDHsrBTdsoXJ7IA9mjmWiz
	o+qNbKxymhoNLIhB1LiBUvq53w2D0J7Vzk5llJUPZf7+M6lnvYPmr2XdjY/yWAVc
	FlsiuNvz+1hoUMI+QgyC9InoAsyHs1vlxeGKfhJO1R50cQLLgjCqI6RIHYIM2A88
	jeeo/w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bgk6qbvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 14:41:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46GEex7E011074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 14:40:59 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Jul
 2024 07:40:57 -0700
Message-ID: <69825f6e-c981-4f02-b10f-27e0799804e1@quicinc.com>
Date: Tue, 16 Jul 2024 07:40:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] wifi: ath12k: fix build vs old compiler
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        "Baochen Qiang" <quic_bqiang@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
References: <3175f87d7227e395b330fd88fb840c1645084ea7.1721127979.git.pabeni@redhat.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <3175f87d7227e395b330fd88fb840c1645084ea7.1721127979.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D0U0g0cqZEMhSIbmynx_k5R8aMzOjk27
X-Proofpoint-ORIG-GUID: D0U0g0cqZEMhSIbmynx_k5R8aMzOjk27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=752 suspectscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160109

On 7/16/2024 4:06 AM, Paolo Abeni wrote:
> gcc 11.4.1-3 warns about memcpy() with overlapping pointers:
> 
> drivers/net/wireless/ath/ath12k/wow.c: In function ‘ath12k_wow_convert_8023_to_80211.constprop’:
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551611 or more bytes at offsets 0 and 0 overlaps 9223372036854775799 bytes at offset -9223372036854775804 [-Werror=restrict]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
>   637 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> ./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/wow.c:190:25: note: in expansion of macro ‘memcpy’
>   190 |                         memcpy(pat, eth_pat, eth_pat_len);
>       |                         ^~~~~~
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551605 or more bytes at offsets 0 and 0 overlaps 9223372036854775787 bytes at offset -9223372036854775798 [-Werror=restrict]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
>   637 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> ./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/wow.c:232:25: note: in expansion of macro ‘memcpy’
>   232 |                         memcpy(pat, eth_pat, eth_pat_len);
>       |                         ^~~~~~
> 
> The sum of size_t operands can overflow SIZE_MAX, triggering the
> warning.
> Address the issue using the suitable helper.
> 
> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Only built tested. Sending directly to net to reduce the RTT, but no
> objections to go through the WiFi tree first

Since Kalle is on holiday please go ahead and take this via net.
This looks nicer than Kalle's version :)

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>




