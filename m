Return-Path: <linux-wireless+bounces-17338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E54EA09B95
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 20:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5B93A2922
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9B524B241;
	Fri, 10 Jan 2025 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eAhnUkxI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C87824B221
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536049; cv=none; b=Q/B5E9RPDPAordb13cWrDd/2EV+e6Bmc2MeChYkfwHRyuzYchk3N/yfXD6lLlEbFXjKQk4FH+uzE7Hgh2KzfFi4EcXdeyW5I/SBw3tfubzXSHErTvJ3fT+DvnAx33TR7s4EGaWa5Mh6DGSL/dHtdGeSEk//olvGbECbwWr7TF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536049; c=relaxed/simple;
	bh=s7NDNwsezKfqkwQg1AihcWFTonGutuHBbRZXHmRyYPQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=VAe+HMhNKd/OoPGLEuMU+opQQKeAnh/66xoyPXup1+Nfuc1fpZfjH/S1WzrehkcpFqgk909V2dyMeZwKP0U5bm4/T5ZNpw1iwbj4aKrMOkLXNsn2D2EhwLolrPI3X1fc44X0yU/4g/3T113T32Yu4i5YT6QWDYR7bE6dc9IMZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eAhnUkxI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9EgjE011861;
	Fri, 10 Jan 2025 19:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nlZjaxk75NtXy7s8W6UBpYftDT6gHb/O9rLqEymTZRU=; b=eAhnUkxIbDkzHaUq
	XSGIUsruHTLjsqFb1xVw+7xL5wh3FO6CMiOfM6lXIdoGY/Yi7B2sxkgsFB6CU0lq
	mY015d4QIvBdna0S2rrBYInqEvOe/4eJV8xyrUB5dleUPQ5P/Vr8oREaHON40K6G
	R3QtrB9no5W2R/gnqjmwpH3hs6YhEdUH8lRU6jV8l+nlZDHaTox6nkHdRRgpzxGY
	h1AmljM0NAsSVpUasB06hJGolDSPvKOeCwTlUAGh3xmeLO6aai0bW0B0cADWqBgt
	8b8cN8R5bT9PVa3TuontNhqO5Je220uYNF1fiyXW3erWReCFjIzoIurQOmjQm9E4
	HktJjw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4430rfhghe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 19:07:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50AJ7NgR023292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 19:07:23 GMT
Received: from [10.111.179.128] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 Jan
 2025 11:07:22 -0800
Message-ID: <8e60ea5c-6e7e-4fc7-bb4e-a973ce0c73e9@quicinc.com>
Date: Fri, 10 Jan 2025 11:07:22 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Support transmit hardware queue stats
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240724042809.3716580-1-quic_rgnanase@quicinc.com>
 <75b0db02-b0cd-4265-9c8e-306c2ba75d3b@quicinc.com>
Content-Language: en-US
In-Reply-To: <75b0db02-b0cd-4265-9c8e-306c2ba75d3b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QTR8Itz9gUD2_YVSTTENlMIbYNnvFe_y
X-Proofpoint-GUID: QTR8Itz9gUD2_YVSTTENlMIbYNnvFe_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100147

On 7/25/2024 8:45 AM, Jeff Johnson wrote:
> On 7/23/2024 9:28 PM, Ramya Gnanasekar wrote:
>> Add support to request firmware hardware stats through HTT
>> stats and display the stats information in debugfs.
>>
>> Sample Output:
>> -------------
>> echo 3 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_reset
>> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
>>
>> HTT_TX_HWQ_STATS_CMN_TLV:
>> mac_id = 0
>> hwq_id = 0
>> xretry = 0
>> underrun_cnt = 42
>> flush_cnt = 0
>> filt_cnt = 0
>> null_mpdu_bmap = 0
>> user_ack_failure = 42
>> ack_tlv_proc = 0
>> sched_id_proc = 0
>> null_mpdu_tx_count = 42
>> mpdu_bmap_not_recvd = 0
>> num_bar = 0
>> rts = 0
>> cts2self = 0
>> qos_null = 0
>> mpdu_tried_cnt = 0
>> mpdu_queued_cnt = 42
>> mpdu_ack_fail_cnt = 0
>> mpdu_filt_cnt = 0
>> false_mpdu_ack_count = 0
>> txq_timeout = 0
>>
>> HTT_TX_HWQ_CMD_RESULT_STATS_TLV:
>> cmd_result =  0:42, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0
>>
>> HTT_TX_HWQ_CMD_STALL_STATS_TLV:
>> cmd_stall_status =  0:0, 1:0, 2:0, 3:0, 4:0
>>
>> HTT_TX_HWQ_FES_RESULT_STATS_TLV:
>> fes_result =  0:42, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
>>
>> HTT_TX_HWQ_STATS_CMN_TLV:
>> mac_id = 0
>> hwq_id = 1
>> xretry = 0
>> underrun_cnt = 0
>> flush_cnt = 0
>> filt_cnt = 0
>> null_mpdu_bmap = 0
>> user_ack_failure = 0
>> ack_tlv_proc = 0
>> sched_id_proc = 0
>> null_mpdu_tx_count = 0
>> mpdu_bmap_not_recvd = 0
>> num_bar = 0
>> rts = 0
>> cts2self = 0
>> qos_null = 0
>> mpdu_tried_cnt = 0
>> mpdu_queued_cnt = 0
>> mpdu_ack_fail_cnt = 0
>> mpdu_filt_cnt = 0
>> false_mpdu_ack_count = 0
>> txq_timeout = 0
>>
>> .....
>> .....
>>
>> HTT_TX_HWQ_STATS_CMN_TLV:
>> mac_id = 0
>> hwq_id = 20
>> xretry = 0
>> underrun_cnt = 0
>> .....
>> .....
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Now NAK since this no longer applies.
Please rebase to current ath/main and make sure to add 2025 to QuIC copyrights


