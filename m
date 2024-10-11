Return-Path: <linux-wireless+bounces-13896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B8099A926
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 18:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2FF1C20908
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9AA198A30;
	Fri, 11 Oct 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TNVFIjKf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6400618027;
	Fri, 11 Oct 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665520; cv=none; b=K9Bt+pEpJ1IVddejmu9JwhVSlcKXbhrZc5gaYRoBMq0HNT6/D0MMdqR3mCNvZOK7L0QiX7U2xGdr8k/owAz4vamtp6Q/Sv0TApK4heiKxP8KuslAocRW+bIENy31kteVqfY8g64Gb75UsE1E6v9qBDrvBvTH2QWvJHLIcodTPyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665520; c=relaxed/simple;
	bh=A+TJf2abRaHp9Asv8iqVXTw2ovZI1EKG8uVgldMLXdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cuaf9oCVw189njG9AbC+nh20QRN/R7W0DYlh6T5GbfwerrdW21NfO6uCW1S8/+ejPlkWm6ZBsc93f2rLPNPtBOlzBOdThhOlJwSHYsgI1GRn0JOOjg1hv+xEg0rhQ+DpBfDUTzJw7Tfc8/5Mmlhb8/AhG89nraj0jUmwVo3zfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TNVFIjKf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B9rmUB020040;
	Fri, 11 Oct 2024 16:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	njZ484qpDsi6Z2x/1aupfhS9YOld/F1zjzQoZ1yH3Ro=; b=TNVFIjKf0an3j4fg
	07Wl25Ax+yyaz+vdrjtWAKSQo4S6/mQPUzoTf0bQ2B4UDoMWHrDljs/+PwqX86V5
	h4SkgYXqsi0CmeZByvmzvrqt7YQUv3vDGtLbLfKCASt1GcXcv4RIhYz/WcyKOU8n
	Va4bgJXgy0LKA+P4hQK6mZyRP0mFTvp0jrCIuZAWAq3btJX5bMSQdmVJ6tG5HLMf
	1vPvgEBO6rcN8/agT7zabF5J1vNoPBPzxvBJgB4R0FMy+w6R5PrZID59VHzpqUeo
	9aEHv7QGzsgrCpLWmjTtttImpdVbkOV2uHP8eJmDyrikTj+fSpMmvFlaCKyhEfPP
	W6tiIw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426db7mf9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 16:51:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49BGpov3028837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 16:51:51 GMT
Received: from [10.48.240.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Oct
 2024 09:51:50 -0700
Message-ID: <b58b5b2e-bf9f-480c-810b-2cef29aab82c@quicinc.com>
Date: Fri, 11 Oct 2024 09:51:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath10k: add channel 177 for 5 GHz band
To: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20240801202359.794035-1-frut3k7@gmail.com>
 <20241009065051.51143-1-frut3k7@gmail.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20241009065051.51143-1-frut3k7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9sSnCPrP0KTQXd4Lw_uXlg2Dv2mGvdBW
X-Proofpoint-GUID: 9sSnCPrP0KTQXd4Lw_uXlg2Dv2mGvdBW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1011 spamscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410110117

On 10/8/2024 11:49 PM, Paweł Owoc wrote:> Add support for channel 177 (5885
MHz ) for the 5 GHz band.
> 
> Tested-on: qca988x hw2.0 firmware ver 10.2.4-1.0-00047

Can you elaborate on what was tested in your commit text? And more
importantly, what is the impact on existing devices, especially given that
existing devices would not have calibration data for this channel in the board
files? Does the QCA988x board file even have calibration data for this channel?

> 
> Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
> ---

what is the diff from v1?
for future reference when you submit a new version of a patch you should
include a patch changelog after the ---, see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

>  drivers/net/wireless/ath/ath10k/core.h | 4 ++--
>  drivers/net/wireless/ath/ath10k/mac.c  | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
> index 446dca74f06a..3dff8c028526 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -39,8 +39,8 @@
>  #define WMI_READY_TIMEOUT (5 * HZ)
>  #define ATH10K_FLUSH_TIMEOUT_HZ (5 * HZ)
>  #define ATH10K_CONNECTION_LOSS_HZ (3 * HZ)
> -#define ATH10K_NUM_CHANS 41
> -#define ATH10K_MAX_5G_CHAN 173
> +#define ATH10K_NUM_CHANS 42
> +#define ATH10K_MAX_5G_CHAN 177
>  
>  /* Antenna noise floor */
>  #define ATH10K_DEFAULT_NOISE_FLOOR -95
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 646e1737d4c4..cee6a4d287b5 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -9543,6 +9543,7 @@ static const struct ieee80211_channel ath10k_5ghz_channels[] = {
>  	CHAN5G(165, 5825, 0),
>  	CHAN5G(169, 5845, 0),
>  	CHAN5G(173, 5865, 0),
> +	CHAN5G(177, 5885, 0),
>  	/* If you add more, you may need to change ATH10K_MAX_5G_CHAN */
>  	/* And you will definitely need to change ATH10K_NUM_CHANS in core.h */
>  };


