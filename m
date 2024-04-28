Return-Path: <linux-wireless+bounces-6946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9E98B49A4
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Apr 2024 06:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77CE1C20AB6
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Apr 2024 04:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A832B23DE;
	Sun, 28 Apr 2024 04:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U6pymiwA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F971FA5
	for <linux-wireless@vger.kernel.org>; Sun, 28 Apr 2024 04:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714280318; cv=none; b=sqJH5uvX86ku/IZWcrFHB0vmsTr+3lFvpDU/dVlTC90Q3itrH+j1XTnAwCKHoDmbZeKiS3WaNiTK8elFTZ8jDBPLZDGtjuMeY/OBddPPUH1QC8rmqZoIyxD3rMIPnvLEddMc2y6FHZ4U9nhd9FR6NnEjtlzKgmtIqcYkqwAs9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714280318; c=relaxed/simple;
	bh=NaWgessqeEpNbfQ2dGGP9qTKEZWFTEBHOHt9Wq0JfiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gwy1x2c5qrGKgGjFRyO1sssvopX8lm2FxQ8+s7SMoPEphvDVx2m0K/AqAPJZcyXIQJw+t9JkY/dJbB3DEMsychXuY9tlVOfkVwuj8kSTmq9ah05CpSjehIu8r/NmYY1mGSVCAKrz0+UDYYmIXnJfIF7Z1Gs3cViND9zoEHMFfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U6pymiwA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43S4q3NM017905;
	Sun, 28 Apr 2024 04:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xt4Uf4oJwlm3QuqdX8dENJW4GO2h70oxRsJ5WWmJkaQ=; b=U6
	pymiwAx5znVSP0JaE1HzHzQux0rvVa4KoiYXMKcTwsxHQdVU3hq8Rm4qmjhNI20C
	NlZwbVTm0ur8aGFPl6i6jjMsvQxkeD6xhGN232CT11iqLjakOqOx01wP/bpGUn/T
	HZhmqIZ9Li/wcIQTgOXU3xR+jON7bHDriazZib5u60FIPONnqnxlyJ1ZxnbcbmOh
	UM3ijKZ5KfeHwsxTHM0TcG50auKWkNogTSwv6LDnP3dLHh/0d5EQIcX+YOJyWJtM
	JzteVBqNLssnXGHhv0rLfjwL4T0cLTyjm0PzCbj3u5rfrAlJx2r7mlROF8DkDNra
	GggwieqCzVpDqu/iLTog==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrsk798vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Apr 2024 04:58:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43S4wUZI024525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Apr 2024 04:58:30 GMT
Received: from [10.50.36.148] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 27 Apr
 2024 21:58:27 -0700
Message-ID: <973d4ffd-055c-190b-065a-5804cd059e03@quicinc.com>
Date: Sun, 28 Apr 2024 10:28:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv2 1/3] wifi: ath12k: fix calling correct function for rx
 monitor mode
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240427162644.2470886-1-quic_tamizhr@quicinc.com>
 <20240427162644.2470886-2-quic_tamizhr@quicinc.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20240427162644.2470886-2-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YdugQMLetX_4dgq2pFXz1NLPfKo__wWx
X-Proofpoint-ORIG-GUID: YdugQMLetX_4dgq2pFXz1NLPfKo__wWx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-28_02,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404280031



On 4/27/2024 9:56 PM, Tamizh Chelvam Raja wrote:
> Currently in ath12k_dp_tx_htt_monitor_mode_ring_config()
> ath12k_dp_tx_htt_tx_monitor_mode_ring_config() function wrongly called twice.
> Fix that by calling ath12k_dp_tx_htt_rx_monitor_mode_ring_config().
> 
> Currently monitor mode is disabled in driver so the change is compile
> tested and boot sequence verified.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp_tx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
> index 9b6d7d72f57c..2fb9fc42db11 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -1044,7 +1044,7 @@ int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset)
>   	struct ath12k_base *ab = ar->ab;
>   	int ret;
>   
> -	ret = ath12k_dp_tx_htt_tx_monitor_mode_ring_config(ar, reset);
> +	ret = ath12k_dp_tx_htt_rx_monitor_mode_ring_config(ar, reset);
>   	if (ret) {
>   		ath12k_err(ab, "failed to setup tx monitor filter %d\n", ret);
>   		return ret;


Looks like you modifying in wrong place because the debug log 
information is not matching the rx message. no ?

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

