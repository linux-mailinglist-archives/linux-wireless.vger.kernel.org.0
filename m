Return-Path: <linux-wireless+bounces-12900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0715297A91A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 00:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45771F29200
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 22:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FD15AAC8;
	Mon, 16 Sep 2024 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZYT+YT6U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEBF9DA
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726524832; cv=none; b=ijcyfCqH8enZAkc/+rgP+2vZH6Hpizd0MgxBKXnIN7Eap1/kPw16iIgueYM7U1macqgkUAcpGetpsI3tWKA9uGlczdNSIGOsp/sSaIc5hEYuFyDAHHFRcav8eBQYvsjSIrpR/Dd8O3eSJkMo7pksXObeYz6AuJaQqTiShbcYfwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726524832; c=relaxed/simple;
	bh=KixywjsLaur2Z4+MytqkTgQzy2FAKGuWNx+RIskkVgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cY0iYkBuUMxJkj88Llf73WALOMvpp1SvWI831ZHpt8zENU5xQ2zgmRgMRl7+oL+VMYy0kB0+Xj6fBNw0Z0G8MW6MmDyye+K/mGGSIV85Q29NFz0z0/RtHFPyrF+4FXkP+xWSmS9SA+iyS0PnR+hqJmmyBxFWeJJMAQEPSqNqG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZYT+YT6U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCcjXH014288;
	Mon, 16 Sep 2024 22:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UsPE/Td9F5KYxBf+8SfUI5CxgVUKhzcjvMbJjZONz8U=; b=ZYT+YT6U1UVJVFty
	aCOuqAGKgfNws2NVbAcVs/4UGeqUDRpVHnDtjAxusDbnY7K9XMz6nPlbibgacTzQ
	FQKc1inyWn0cZTKM5Fs5ykMWJN/dino15LSW8XVPAkqpcPkueCp5IEY3qWSI/S64
	zhj2vwfy4KW3XPa+8SpzNJVyKbo/ZpKFnqX8RJ5/uADUgxgt03R4Bf+hA6lOxZp3
	rSfInhmSyQ4HCMISskUUmS95RAn7z9zKtK2GxYKRdyADNStVrKgtcEu6EuMRUkHr
	aoJ2hJxoMFWr5cCYVPjzM0orgulqF2Gc7f0NKr8vY1FXhI8LjwJOc5T2PH1WqtB4
	rP88ng==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4j6nc2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 22:13:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48GMDkau004817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 22:13:46 GMT
Received: from [10.111.182.118] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Sep
 2024 15:13:45 -0700
Message-ID: <2eff7510-3f48-4564-8bd7-9a48b248a3fa@quicinc.com>
Date: Mon, 16 Sep 2024 15:13:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: ath12k: Support pdev CCA Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240913082949.573482-1-quic_rdevanat@quicinc.com>
 <20240913082949.573482-5-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240913082949.573482-5-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i08cZcacA9YMS1TJ39GCCk75pC-F-kKg
X-Proofpoint-GUID: i08cZcacA9YMS1TJ39GCCk75pC-F-kKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=801
 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409160151

On 9/13/2024 1:29 AM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request CCA stats for physical devices from firmware
> through HTT stats type 19. These stats give information about
> channel number, number of records, counters' bitmap, collection
> interval and different CCA counters.
> 
> Sample output:
> -------------
> echo 19 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_PDEV_CCA_STATS_HIST_TLV (1s):
> chan_num = 5955
> num_records = 10
> valid_cca_counters_bitmap = 0xff
> collection_interval = 1000
> 
> HTT_PDEV_STATS_CCA_COUNTERS_TLV:(in usec)
> tx_frame_usec = 0
> rx_frame_usec = 0
> rx_clear_usec = 999955
> my_rx_frame_usec = 0
> usec_cnt = 999955
> med_rx_idle_usec = 0
> med_tx_idle_global_usec = 0
> cca_obss_usec = 999955
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


