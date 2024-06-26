Return-Path: <linux-wireless+bounces-9618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08450918DBB
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 20:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5BE1C215F7
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63932190461;
	Wed, 26 Jun 2024 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QCk4SIw1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C99190074;
	Wed, 26 Jun 2024 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424854; cv=none; b=ErCoxs8Fych7TPb9SxvwEegPkcvgoDBwEyylocbuWW0I9FJgD0ijnIin5yh53JnM98WVnCCkGZ82KDLAUj1OoTWHoyuSzEDawrMdZQrP0Of7uhx/eKikkLfJ+q92Mx2FKhAK666ut2+ekAoWS5FDUyrYs6AmVUJyti0DpRCUxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424854; c=relaxed/simple;
	bh=dEKOHRnvgr2bPEaSKQ7QryLyhhLHJuqrfCUUP4PkpWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VPbv9wDdyW3duifyIoJSDG7PwSHEpMdA0kQGyLV0DTbAuz8Ik3m7Q95RsNdIFXQbb/hpiZYSReY6X26fM6pERVotenxopqNxE3rbUxLaj06RjUI8fvFkFVh69CSKlG0VdhQhuTxLkb4dhG8uFEDk+NZ7vxQakVWqFfQ5tn1LCYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QCk4SIw1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfTYD018092;
	Wed, 26 Jun 2024 18:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lDsWwsdaTUBDqF+6nbEyjVJX2L01zIeks05Bc1Lx3Eo=; b=QCk4SIw1Mo9r/1p+
	nM+0ToMLAoEp3nxPdPFDL0KBA5mfI4OXIuhcFEgvK+8WBzriMhoZ+kVpvlri6MvP
	DyyqazaaMrANC7Vsawr4UfX5ejK35Cy2lrNiPbTRo+RnX+9TYLWzKILvyoPztH/U
	DDFlRcB7eNdFACSWkVTNIhjf8TROyWDSdJQeJ7TdkBNUMqR4FfQZDYat9euhWMOx
	gdUsFOpSfxkgyYkjDVgRZF0vvFMAPDWFddRkh8G9eho/nho5P3Z2f2wgITeJC5/i
	VRa/tepI83h8KhngWNUmqDfyBRevtDxj2feN1PG8EddIfuOVt0X9vdAPdYIMwR+m
	t/h9Vw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywppva1f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 18:00:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QI0lFS028466
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 18:00:47 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 11:00:46 -0700
Message-ID: <65eb0a5e-05cd-4fe4-96e2-1c3b2229ae39@quicinc.com>
Date: Wed, 26 Jun 2024 11:00:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Allow driver initialization for WoW
 unsupported devices
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240626024257.709460-1-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240626024257.709460-1-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G_uCpsUHPniOW0tcWLS3o-IcYPyYIyPs
X-Proofpoint-ORIG-GUID: G_uCpsUHPniOW0tcWLS3o-IcYPyYIyPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_10,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=968 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260132

On 6/25/2024 7:42 PM, Rameshkumar Sundaram wrote:
> Currently during driver initialization, mac registration is allowed
> only for devices that advertise WMI_TLV_SERVICE_WOW, but QCN9274
> doesn't support WoW and hence mac registration is aborted and driver
> is de-initialized.
> 
> Allow mac registration to proceed without WoW Support for devices
> that don't advertise WMI_TLV_SERVICE_WOW.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Cc: stable@vger.kernel.org
> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/wow.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
> index 685e8e98d845..c5cba825a84a 100644
> --- a/drivers/net/wireless/ath/ath12k/wow.c
> +++ b/drivers/net/wireless/ath/ath12k/wow.c
> @@ -1001,8 +1001,8 @@ int ath12k_wow_op_resume(struct ieee80211_hw *hw)
>  
>  int ath12k_wow_init(struct ath12k *ar)
>  {
> -	if (WARN_ON(!test_bit(WMI_TLV_SERVICE_WOW, ar->wmi->wmi_ab->svc_map)))
> -		return -EINVAL;
> +	if (!test_bit(WMI_TLV_SERVICE_WOW, ar->wmi->wmi_ab->svc_map))
> +		return 0;
>  
>  	ar->wow.wowlan_support = ath12k_wowlan_support;
>  
> 
> base-commit: dadc1101eabb54ace51aa6fc58c902bf43ac0ed7
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


