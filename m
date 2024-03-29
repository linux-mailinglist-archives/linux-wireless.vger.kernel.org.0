Return-Path: <linux-wireless+bounces-5614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083E3892307
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD2F1C211A8
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCA552F79;
	Fri, 29 Mar 2024 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZpSxBFdp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253351C0DC2
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734875; cv=none; b=XkVYGVYdbN1/R4VjpUpzxGZgPeVz5rIgVHONd+PE5w361uKpK4YuoObspOWwa3170tGJL5GaSCazUAzo4rixHktCWAJF8T4wwsiQVUBG5p4C69clScSjxCYzgEkHw/WFn75CoKwnXGooS2rCNlPcfjstVOp4X6W9+jC4qmtqsBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734875; c=relaxed/simple;
	bh=u3LxzrV8DPTn4WdL2ENwSLHPojMnrc75n93daqGbCh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ux3eLrR3EovnW6WY+4BP3N4pak50+AAf6aw+6RJDVdTBfgfMcfFWo02/OxXfTzQJXUNyz9I0RF1zEIwxRG+r9plK/5+22pOEv8bQ39f2O1w4EPRVVEqXMeK+spMQzXRWko8Sce7xd7A0fWe6GWWP9XL7+xGcXzELGTU2bqImnZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZpSxBFdp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THgVtV001041;
	Fri, 29 Mar 2024 17:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lPwAdeRwnp+jmLqXPDhPkR2HEa9R0lZiweO/MiFU1n4=; b=Zp
	SxBFdpaX2bT/880VOw/yF4hnNe1UAGYtcTafeah3xZPsXiNTSzbS+4Y0/W5LiBur
	bWcGA2shN8SwA78XppTCfxSpvLc5P40TwMoiIE+Hot1JY7SJ3ltpsFUlPz1H8PW0
	UQMrexqkItbbIyM0VDSRQBSw71JD0+EsAfknatKXFdK2fPHe2T5KJrqP42eGH9lX
	e5dAvbAbl5brZ7A/utU2poSrpkoJ7UR7gmzhLcxUNwJp/MXvhz/H7u9f88ECBCuk
	cZyvy05hGHGvHFFps45URZ89qCGXSZTx4LdqoaHWlCdF35rY2K+Pfd9YNntNuqVP
	Zrigprtr94UTjwnZxcTQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5ybmrdbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:54:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42THsS7c031350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:54:28 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 10:54:27 -0700
Message-ID: <6ead299e-003b-4db5-adc7-e009c0d3ddb1@quicinc.com>
Date: Fri, 29 Mar 2024 10:54:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] wifi: ath12k: support SMPS configuration for 6 GHz
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240325212304.28241-1-quic_pradeepc@quicinc.com>
 <20240325212304.28241-7-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240325212304.28241-7-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V5qJ_w140Zg-ltTtqKU4Qf4F1QajWGE5
X-Proofpoint-GUID: V5qJ_w140Zg-ltTtqKU4Qf4F1QajWGE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290158

On 3/25/2024 2:23 PM, Pradeep Kumar Chitrapu wrote:
> Parse SMPS configuration from IEs and configure. Without this,
> SMPS is not enabled for 6 GHz band.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index b4114dd22bf0..433b8be74997 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -1964,12 +1964,17 @@ static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
>  }
>  
>  static inline int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,
> +					    const struct ieee80211_he_6ghz_capa *he_6ghz_capa,

ath12k-check complains:
drivers/net/wireless/ath/ath12k/mac.c:1967: line length of 94 exceeds 90 columns

git blame indicates:
bf5622d2fd27a (Pradeep Kumar Chitrapu 2024-03-25 14:23:04 -0700 1967)              const struct ieee80211_he_6ghz_capa *he_6ghz_capa,

Suggest removing 'inline' to align with:
https://www.kernel.org/doc/html/latest/process/coding-style.html#the-inline-disease


