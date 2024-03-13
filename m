Return-Path: <linux-wireless+bounces-4688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C140587AFE8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 19:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8CE1C25A2C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 18:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE5663117;
	Wed, 13 Mar 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UN92uJFX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750181AD1
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350738; cv=none; b=HoXl5xmJn1gepiIx3StUADlaY167BUTDYC+76lZsksEbYlA4mpbmzMnL66sXPX9UhaFy+Hs22rc6y6/5L/uxY7oZ65L0JOUvIxageRneP8OvzxqqFRIemfGBbb6ON6n8Oyb9Fq/3sxyT/osMsjQE2uc+usYMqpaKxjzE2vlRcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350738; c=relaxed/simple;
	bh=v1B/1fYnPkecf5RDD0WWCCJyu6CP2ppHDyTk+VNIg7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kH1X0VkIPbpev3QZ5vMHMsrgTeNPwZM8cBLEXjVHFiaJFyg2/DvNoVRRqpsWuHoWjhQikZnrBN385neFtrtids2YC2ub3Oji8++E38WIFmP1af+Fg/Y88kG3aFniEhKK30G/CjZI64/JZlRBZ8YoCseAIYiE5H7f1HOz47Njtko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UN92uJFX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DFCCGS003542;
	Wed, 13 Mar 2024 17:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EcwFO52/1CgSdPoWVw8hr6j4WBHecOlldApDkuWLDDo=; b=UN
	92uJFXGoxM6UsvPb7Jl1dcTKpSwLF4X5jdAm5ckeFCLSTd7uVWVOHaGa9NUgEzJy
	oMjoiW/tmkoUD4xb/K75gmoiSMOVPO2QaWHHd+s8xF6xmg4wrep79vny13ma7vf7
	tzT5g0YlRycBNaK79FT0Fqw5/Ao/VTWPovQceU9fpSXZf2ld92r9RJ+DKg97/cAl
	aJbTz9ZNxi+MhQEazzR+7aXEWAHXUS9X2ny7lAnxEd5wuScEEGl7iY5GI+KUGXU/
	ashfq00j2kXjPmwJ1DmBAFIJQwDPIhlP53sZdoRX+Mwn33RCHGa/W7dhlpbXIMmG
	DYArDQDhZjHItVclNtKQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuam5gvrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 17:25:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DHPVOE016039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 17:25:31 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 10:25:30 -0700
Message-ID: <9a8cebda-c627-4876-b5e7-9edbad72ab1a@quicinc.com>
Date: Wed, 13 Mar 2024 10:25:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211_hwsim: set link ID information during Rx
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240313145402.456514-1-quic_adisi@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240313145402.456514-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FWfrUHzcYkJIZOYQ0z0khNSgtHG6-Nl3
X-Proofpoint-ORIG-GUID: FWfrUHzcYkJIZOYQ0z0khNSgtHG6-Nl3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=946 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130132

On 3/13/2024 7:54 AM, Aditya Kumar Singh wrote:
> Currently link ID information is not passed to mac80211 via Rx status by
> mac80211_hwsim. This leads to packet getting dropped in function
> __ieee80211_rx_handle_packet since it expects the link ID if packet is
> intended for a MLO station and the station is not directly passed via
> pubsta function argument.
> 
> Add changes to pass the link ID information in Rx status.
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>  drivers/net/wireless/virtual/mac80211_hwsim.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
> index b55fe320633c..783114ccb5b8 100644
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -1721,6 +1721,9 @@ static void mac80211_hwsim_rx(struct mac80211_hwsim_data *data,
>  				sp->active_links_rx &= ~BIT(link_id);
>  			else
>  				sp->active_links_rx |= BIT(link_id);
> +
> +			rx_status->link_valid = true;
> +			rx_status->link_id = link_id;
>  		}
>  		rcu_read_unlock();
>  	}
> 
> base-commit: e27b02e23a701e5761f1d6028643e1203a1c56de


