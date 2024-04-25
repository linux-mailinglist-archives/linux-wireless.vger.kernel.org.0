Return-Path: <linux-wireless+bounces-6864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFAF8B27D2
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 20:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE559B2457C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 18:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2810814EC53;
	Thu, 25 Apr 2024 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fRVxcZEP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5914F9E7
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068137; cv=none; b=pHjmcwp4TKqJv0doxu5ny9/t6dkhHV4Te4OMbIPamsUIA8yLL0mMtquF1y+ycubjjIrEzgTFjL+U7SDy1T9XOeAe5hxpiFN4YA7j3lgBpuf9DvSF9doO3JUbO5XJ4wpnq2rnqT2GxetKsfvpir/jjUD2ZLeE7PFBK6q/kTT95So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068137; c=relaxed/simple;
	bh=IA99BHuqLrsELFSR0psGIutYgpnPcIAscHrogo2x7kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h5tL63n99SpG7F2RapZTJCtGBjfZyPWNg7m3t4dWw5vOhjKHAYmMuPoB3DMyk5bHykNXKPi1uRvabJVL4O0wru/4JngR5WV+cQYrlBPBBL26XytrQxlyvWu9ToRcYfh6i1hW0SUwV4RDCmI5U9tFeOYD5pWFc+jw/pj2mER9NFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fRVxcZEP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9wccu030769;
	Thu, 25 Apr 2024 18:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=85pKbVDjhJPOQX2m4EyatzAdR3L6uwClLPrOHfj/1QM=; b=fR
	VxcZEP6LOiFVGMVVMBQnMLDgADBF5MjHF8iLjag7FZ1Mh42r6+ac5SH4PuvS5vFu
	k1qZ44XCZcOihKcqemH9g7N0CxlEOg24F/WM5ajkrr/5QRMy+C6V3q46AFBganud
	mk1lpefKQ4aV6A+WGXCwvXUBcbyi1WgFEU40pYxxrQj63Rjxa/vToWmGCCLrYqqR
	8DeXwlpFQD7ioj7wpu6d7IFHGAOBOc/PKTLCcyoFTGvDKl+CZt8Y1qTcRhePt4O/
	R49DORl06blX6rnSKbMI9KHr0PxYtDjde3JiEgM7S4bpgb+VI3paFSkRatyoPBsY
	1iGMSlx1/dDfzRDAwAbg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqn0whg4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 18:02:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PI2CfW031380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 18:02:12 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 11:02:12 -0700
Message-ID: <abefe407-4b06-4ee3-8394-417598f69f07@quicinc.com>
Date: Thu, 25 Apr 2024 11:02:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 6/6] wifi: ath12k: support SMPS configuration for 6 GHz
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
 <20240424191141.32549-7-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240424191141.32549-7-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b0S97NYwPWE3jU26F6HG_dQt9ST6B9S-
X-Proofpoint-GUID: b0S97NYwPWE3jU26F6HG_dQt9ST6B9S-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250130

On 4/24/2024 12:11 PM, Pradeep Kumar Chitrapu wrote:
> Parse SMPS configuration from IEs and configure. Without this,
> SMPS is not enabled for 6 GHz band.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 29 ++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 65688e55c285..44e853893ec5 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -2086,13 +2086,18 @@ static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
>  				     ampdu_factor)) - 1;
>  }
>  
> -static inline int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,
> -					    int *smps)

the inline removal should be fixed in 5/6 since that is where it was added

> +static int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,
> +				     const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
> +				     int *smps)

rest of the patch LGTM

