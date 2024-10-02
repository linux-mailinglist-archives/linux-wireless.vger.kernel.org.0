Return-Path: <linux-wireless+bounces-13429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 792A198DE5E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 17:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC911F27EE2
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CE51CEEAF;
	Wed,  2 Oct 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bh+y+RBf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA21CFEA3
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881611; cv=none; b=scxdVRYN2NqxbVwlbo0gjh0fiE2TJuZMnIfyT6n/m5ohvY+KiODwXU0vbs1XTHN9qcHlbOerzhPFqGnCnQXCrnMwOxIsl9K7On9CYqRpTvn2BJmmtknfN03EHs2re2OKXDwpXCjwKmAH62mbbN75lACbnWV7/IhVBK0jHoMU1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881611; c=relaxed/simple;
	bh=GRtq0vtYtScp8RtYYiQK2vB0YAHbFpqOEJ3ok7YLdE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sYtZbiB7L8O6Xwd7Uh19uOzONLnX1qVvFoD3RiP4l+ZKkQ1vF1S/2WenZVlWyUz5+7I/Gp4TT2GxZR6VadTtSNwEqlNrBiYKWURUhOsL/vCm7k9aZQphTBjhZrtc6Xu4RsRzO3u8FgXnUpY6BrRG6+K/burJw/Q7E4Z1oRlXfRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bh+y+RBf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4920CZYY021799;
	Wed, 2 Oct 2024 15:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nPgCu8v210xFT7kLpqRfkX8maWXFX0X8vvHgjderZGQ=; b=Bh+y+RBf7Ed4nujD
	0ADyKQ2bz2tL+lPWexG/G4bMtNfFgznnbatjbSyO4IXS8N8Aesv0JI8BcyZtWNan
	ttO5fQJQ0xPNdMj60WpgZIy4nMIZDicT7JNUIz2GTx5pYMK4IGvgHcabasPtfvny
	bwi4942/UonwA4A5Nh3I6kx1UBIfEU45GH9DgdIurRbhnufA5Il5xE7KgZj694sO
	nixTKEdmx7eFVhOo6mG6XeivlADKoJmQBcFnQ4n+o/XhO6ezZ9NpJc5Ip1UCYuxw
	3yBbPpXq3sgps1OWXTdyLzgV+QH2LFVjYyLHWXc7vBpOgt+1TeXF0uDgfJMTEv7q
	HmHG+Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa12uuwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 15:06:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 492F6iZR020413
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Oct 2024 15:06:44 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 2 Oct 2024
 08:06:43 -0700
Message-ID: <2a680301-9304-4283-9917-d5345f8680c3@quicinc.com>
Date: Wed, 2 Oct 2024 08:06:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Support pdev Puncture Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>
References: <20240930174010.617123-1-quic_rdevanat@quicinc.com>
 <20240930174010.617123-3-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240930174010.617123-3-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Yh99-f9sHlhzdjahO5cAr9X72D69Dvu0
X-Proofpoint-GUID: Yh99-f9sHlhzdjahO5cAr9X72D69Dvu0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=883
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020109

On 9/30/2024 10:40 AM, Roopni Devanathan wrote:
> From: Rajat Soni <quic_rajson@quicinc.com>
> 
> Add support to request pdev puncture stats from firmware through
> HTT stats type 46. These stats give the count of number of
> subbands used in different wifi standards.
> 
> Sample output:
> -------------
> echo 46 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_PDEV_PUNCTURE_STATS_TLV:
> mac_id = 0
> tx_ofdm_su_last_used_pattern_mask = 0x00000001
> tx_ofdm_su_num_subbands_used_cnt_01 = 217
> tx_ofdm_su_num_subbands_used_cnt_02 = 0
> tx_ofdm_su_num_subbands_used_cnt_03 = 0
> .....
> 
> HTT_PDEV_PUNCTURE_STATS_TLV:
> mac_id = 0
> tx_ax_dl_mu_ofdma_last_used_pattern_mask = 0x00000000
> tx_ax_dl_mu_ofdma_num_subbands_used_cnt_01 = 0
> tx_ax_dl_mu_ofdma_num_subbands_used_cnt_02 = 0
> tx_ax_dl_mu_ofdma_num_subbands_used_cnt_03 = 0
> .....
> 
> HTT_PDEV_PUNCTURE_STATS_TLV:
> mac_id = 0
> tx_be_dl_mu_ofdma_last_used_pattern_mask = 0x00000000
> tx_be_dl_mu_ofdma_num_subbands_used_cnt_01 = 0
> tx_be_dl_mu_ofdma_num_subbands_used_cnt_02 = 0
> tx_be_dl_mu_ofdma_num_subbands_used_cnt_03 = 0
> .....
> 
> HTT_PDEV_PUNCTURE_STATS_TLV:
> mac_id = 0
> rx_ax_ul_mu_ofdma_last_used_pattern_mask = 0x00000000
> rx_ax_ul_mu_ofdma_num_subbands_used_cnt_01 = 0
> rx_ax_ul_mu_ofdma_num_subbands_used_cnt_02 = 0
> rx_ax_ul_mu_ofdma_num_subbands_used_cnt_03 = 0
> .....
> 
> HTT_PDEV_PUNCTURE_STATS_TLV:
> mac_id = 0
> rx_be_ul_mu_ofdma_last_used_pattern_mask = 0x00000000
> rx_be_ul_mu_ofdma_num_subbands_used_cnt_01 = 0
> rx_be_ul_mu_ofdma_num_subbands_used_cnt_02 = 0
> rx_be_ul_mu_ofdma_num_subbands_used_cnt_03 = 0
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


