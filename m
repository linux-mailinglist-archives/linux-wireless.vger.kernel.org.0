Return-Path: <linux-wireless+bounces-13426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB4D98DE52
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 17:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BC51C21582
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AF7567D;
	Wed,  2 Oct 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bDjRV9J6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A310E9
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881506; cv=none; b=fqBLrbV/JoBTUMPmhK5pbsWmL28nhTdAROPaMoo0qfobQC7yXlMGfU69X1ywPDsZ1j/24pMB4LDMSWKrjYLE56TYoOpswjEpAzaXQJyO4lmS+H5dygBGQWf8KtH+J828JxahtFesVQQRCY3QG9UW2KId10rGVugi3bR+IIzjpA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881506; c=relaxed/simple;
	bh=kXVVwM7H4EoaTsxWbZlN4OMuFonm6iOm3TT4RE/4F6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M4mQS7FBq+r9DUYy0l7v2H9E5zuzgCjlMda/mmvyk2U8XNR5J9Kt2pck9yyQrRx3D8GYfz10P4QxDgSRGRuawBAbQYJupbjRYWSO2zJ2NZGoFEuxvbmIpMnvVx0/3+BCUSrOoBfAgrfjVtCGBD7sFTwa743laT3gslYL+6yX7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bDjRV9J6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492E4hXX024421;
	Wed, 2 Oct 2024 15:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b796VRuUd0ikaRYqE2w6NKc6LfGxxVyDJMU8x28zz38=; b=bDjRV9J6PY9YP48+
	faDSHomLZQzSMVSNyCgSWFL22BQpIaIhN9kJhfjoSlQds+8WGFTkXQ1tIJsmNoc/
	cZe3ke5e373dECFzxbrLm3iLinP8523fUJ5WuhA0FDtQLMPpW2kYP9uVVJPjObyt
	8WwnMZPvw1OMAJ3icufu2j+ifXPTJtD0vI/JxsRAuKD66dUC3L988pSdAOOrbkLi
	/Gwp2szwov8tth8lYN1UZwVV/TNa3aNZYZYU79bGfCTem3Ql+KNaJKZ6dMjDdWC8
	wfLPxdBwleGMHARExk1hZ1L+CeMkioAoI/arBxS6hZW5N2AkjuUsLnSO+WRnYn7B
	biBsfw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x9cykvhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 15:04:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 492F4qcU012597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Oct 2024 15:04:52 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 2 Oct 2024
 08:04:52 -0700
Message-ID: <57a03cdf-462b-4fc6-ad4b-0863dab9a755@quicinc.com>
Date: Wed, 2 Oct 2024 08:04:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Support Pdev Scheduled Algorithm Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sidhanta Sahu
	<quic_sidhanta@quicinc.com>
References: <20240930171705.596703-1-quic_rdevanat@quicinc.com>
 <20240930171705.596703-2-quic_rdevanat@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240930171705.596703-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1NQwv6DYXy24TXJzOrOAHnejdapZ2Ocx
X-Proofpoint-ORIG-GUID: 1NQwv6DYXy24TXJzOrOAHnejdapZ2Ocx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=869 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410020110

On 9/30/2024 10:17 AM, Roopni Devanathan wrote:
> From: Sidhanta Sahu <quic_sidhanta@quicinc.com>
> 
> Add support to request scheduled algorithm stats from firmware
> through HTT stats type 49. These stats give information such
> as count of DLOFDMA enabled, disabled, probed and monitored
> based on rate and latency, consecutive number of MPDUs tried
> and succeeded, etc.
> 
> Note: WCN7850 firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> does not support HTT stats type 49.
> 
> Sample output:
> -------------
> echo 49 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_PDEV_SCHED_ALGO_TLV:
> mac_id = 0
> rate_based_dlofdma_enabled_count =  0:0, 1:0, 2:0, 3:0
> rate_based_dlofdma_disabled_count =  0:0, 1:0, 2:0, 3:0
> rate_based_dlofdma_probing_count =  0:0, 1:0, 2:0, 3:0
> rate_based_dlofdma_monitoring_count =  0:0, 1:0, 2:0, 3:0
> chan_acc_lat_based_dlofdma_enabled_count =  0:0, 1:0, 2:0, 3:0
> chan_acc_lat_based_dlofdma_disabled_count =  0:0, 1:0, 2:0, 3:0
> chan_acc_lat_based_dlofdma_monitoring_count =  0:0, 1:0, 2:0, 3:0
> downgrade_to_dl_su_ru_alloc_fail =  0:0, 1:0, 2:0, 3:0
> candidate_list_single_user_disable_ofdma =  0:0, 1:0, 2:0, 3:0
> dl_cand_list_dropped_high_ul_qos_weight =  0:0, 1:0, 2:0, 3:0
> ax_dlofdma_disabled_due_to_pipelining =  0:0, 1:0, 2:0, 3:0
> dlofdma_disabled_su_only_eligible =  0:0, 1:0, 2:0, 3:0
> dlofdma_disabled_consec_no_mpdus_tried =  0:0, 1:0, 2:0, 3:0
> dlofdma_disabled_consec_no_mpdus_success =  0:0, 1:0, 2:0, 3:0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sidhanta Sahu <quic_sidhanta@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


