Return-Path: <linux-wireless+bounces-10259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1022A9327F2
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 16:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C451F23D28
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 14:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BD2198E98;
	Tue, 16 Jul 2024 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WlCbj9X/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3C152E02;
	Tue, 16 Jul 2024 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138466; cv=none; b=auAosYTF9C0MwXV4hBXLr0tH3osahZNGzS348YGbfWgKSlNViBUshZutJ3Nug2497iki3Pj8kGhp7oAGY7QuMlgcwIeGBWBAxUYgitAfi752ZPVHwG1v3D/Hj8El3ahfaFSA9CtQMDx9aPBpNTvLzjwGXsn3n7zwCgUpRSeDKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138466; c=relaxed/simple;
	bh=VQwTSIUDAGEJADPLLK8V5LN5pXkh+arA0z+AJ5zqXR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eYW+lnu75uZjF3SGqhM4kunNjL++8P8UBgB18wMlhhdYlmC5ryipONu4lNsGx5H0OX6xHbPDSiZx3IYztwtGub0ubs1GBypM/XyF1D2LYf0QAqGDdzTR0ZXM+mji82LOYFB3trYCCYB6JKp7vkBIds80yJvGmQU/8NV6CdAVryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WlCbj9X/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GDgMpH006921;
	Tue, 16 Jul 2024 14:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OUcto7EFJnJbd3Vlf+1/ygQaFeJzw/melNmMoRsS8P0=; b=WlCbj9X/fv89LO7N
	P0+XgyFv4seKkTIEjaLTCbzDu5kib++lgknhV8YABhe29yyGN2DnCgeYb6Y0o/5t
	tCVm4S3tRnTjmvHhHVDP9XgwE8ZXiSeQjsqkNjHx+sCjxr4wy5iqSi61R9QVROBE
	0I8aAOhGYNS3aZn+QUfKiN1WuBfrBsdLLYEI41aQgTqeTpF1gcDB2kVaPBX6EW3V
	fVkwB73VQbMbTijZ3sBozhMhKCCJYB98cLLN5tsRci5NIjV5XWAFxCm3xCyGo3lb
	lcJ63kcCD1YUguiC5LZazM4sX8WJAAedenoJcs5ZSQf4aIqFRTwlwsmLmH+/QbKt
	EhDHoQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bjv8q55t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 14:00:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46GE0kg5015060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 14:00:46 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Jul
 2024 07:00:45 -0700
Message-ID: <a7950e7b-2275-4b6d-b8e1-4f50d0bc28e6@quicinc.com>
Date: Tue, 16 Jul 2024 07:00:44 -0700
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6Q3KmPlUQYOvDOqg88Z0B9mftQCV-To6
X-Proofpoint-GUID: 6Q3KmPlUQYOvDOqg88Z0B9mftQCV-To6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=896 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160104

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
> ---
>  drivers/net/wireless/ath/ath12k/wow.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
> index c5cba825a84a..bead19db2c9a 100644
> --- a/drivers/net/wireless/ath/ath12k/wow.c
> +++ b/drivers/net/wireless/ath/ath12k/wow.c
> @@ -186,7 +186,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
>  	if (eth_pkt_ofs < ETH_ALEN) {
>  		pkt_ofs = eth_pkt_ofs + a1_ofs;
>  
> -		if (eth_pkt_ofs + eth_pat_len < ETH_ALEN) {
> +		if (size_add(eth_pkt_ofs, eth_pat_len) < ETH_ALEN) {
>  			memcpy(pat, eth_pat, eth_pat_len);
>  			memcpy(bytemask, eth_bytemask, eth_pat_len);
>  
> @@ -228,7 +228,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
>  	} else if (eth_pkt_ofs < prot_ofs) {
>  		pkt_ofs = eth_pkt_ofs - ETH_ALEN + a3_ofs;
>  
> -		if (eth_pkt_ofs + eth_pat_len < prot_ofs) {
> +		if (size_add(eth_pkt_ofs, eth_pat_len) < prot_ofs) {
>  			memcpy(pat, eth_pat, eth_pat_len);
>  			memcpy(bytemask, eth_bytemask, eth_pat_len);
>  

Duplicate of https://msgid.link/20240704144341.207317-1-kvalo@kernel.org ??


