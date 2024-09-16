Return-Path: <linux-wireless+bounces-12897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C808297A917
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 00:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4727EB23222
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 22:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5A1145B0B;
	Mon, 16 Sep 2024 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aEiIIJp8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066D0F9DA
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726524813; cv=none; b=JI6T0VY8hlrEAyKDHJytGd25cii15js6PFFgUjTy3Gq3UeOb8brQu3YHZOl1ryjFL9M8zZgMuBWsqbFrDkGSfTsffIaT8d4aq9Jd53rg+66R/IXC8z0jv23hbpbTZpEsKAxCHGOtVqAfe9RjZMRozbZN6yn9duOobIg2qaaVURo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726524813; c=relaxed/simple;
	bh=Bh6Cm1Z3rhYBjqzFPBKjHxiLnT/azI21r6rQYNIhvHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aFjK6JfFQ6XJbI1qaXhImceXES/PPSJoLr313tOS0iw162zP2WEAurdoqzmEPBd5jef2APfnXAwObpvnezc/sbPgaSdS9XVzpybJYpyMMcgRtuuUdehga/lqX+cdEG4K/6qY47GXbp7mryOJJRVbNIY7UM0x15fSLxhQY3ssouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aEiIIJp8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCb4It023049;
	Mon, 16 Sep 2024 22:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4dYVWhqWiG/i+tE3q0W5k7H0CKTLSs3e0gSYnWXTt7c=; b=aEiIIJp8aaJbUEYL
	vWtotknKGNJbdtRuZKX8OPTksPy7knWHztKJTpsa2NflxTiFuVR+574U8A08pRWb
	/mDUaUuxcNEnyUMoz7rsPBLTgf4jFcSRmfil3nL8zfkvBqHKbL1c4jfZi+g/oc3M
	og7dgkfkY+KCXtU1mxXXqq3GW2wvWDqBGYEbFf0j8U9fp3bavwS2AiPqF8co+yf2
	8SZuxPXF3wUkNZuQFspTnUYSaiy5SXSkeRGBYoA2OP5bsR2iJhX2h+MdiOwCuK81
	jKp8Iruli4rqDzib8fESVbArYO9wHgSZI2450cS0sCAC/qNpw47TOu+HlFtb4f/s
	dDgvsg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jdnbfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 22:13:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48GMDS1A019823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 22:13:28 GMT
Received: from [10.111.182.118] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Sep
 2024 15:13:27 -0700
Message-ID: <a2f03c0e-6527-42ce-9321-4e8891fc37bf@quicinc.com>
Date: Mon, 16 Sep 2024 15:13:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: ath12k: Support Self-Generated Transmit stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240913082949.573482-1-quic_rdevanat@quicinc.com>
 <20240913082949.573482-2-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240913082949.573482-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8TR7heaDNEK1O7duTlwFBYu5_2CE39YN
X-Proofpoint-GUID: 8TR7heaDNEK1O7duTlwFBYu5_2CE39YN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160151

On 9/13/2024 1:29 AM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request transmit selfgen stats from firmware through HTT stats
> type 12. These stats give information about single user NDP packets, multi-
> user MIMO NDP packets, OFDMA triggers, etc.
> 
> Sample output:
> -------------
> echo 12 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_TX_SELFGEN_CMN_STATS_TLV:
> mac_id = 0
> su_bar = 0
> rts = 0
> .....
> 
> HTT_TX_SELFGEN_AC_STATS_TLV:
> ac_su_ndpa_tried = 0
> ac_su_ndp_tried = 0
> ac_mu_mimo_ndpa_tried = 0
> .....
> 
> HTT_TX_SELFGEN_AX_STATS_TLV:
> ax_su_ndpa_tried = 0
> ax_su_ndp_tried = 0
> ax_mu_mimo_ndpa_tried = 0
> .....
> 
> HTT_TX_SELFGEN_BE_STATS_TLV:
> be_su_ndpa_queued = 0
> be_su_ndpa_tried = 0
> be_su_ndp_queued = 0
> .....
> 
> HTT_TX_SELFGEN_AC_ERR_STATS_TLV:
> ac_su_ndp_err = 0
> ac_su_ndpa_err = 0
> ac_mu_mimo_ndpa_err = 0
> .....
> 
> HTT_TX_SELFGEN_AX_ERR_STATS_TLV:
> ax_su_ndp_err = 0
> ax_su_ndpa_err = 0
> ax_mu_mimo_ndpa_err = 0
> .....
> 
> HTT_TX_SELFGEN_BE_ERR_STATS_TLV:
> be_su_ndp_err = 0
> be_su_ndp_flushed = 0
> be_su_ndpa_err = 0
> .....
> 
> HTT_TX_SELFGEN_AC_SCHED_STATUS_STATS_TLV:
> ac_su_ndpa_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
> ac_su_ndp_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
> ac_mu_mimo_ndpa_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
> .....
> 
> HTT_TX_SELFGEN_AX_SCHED_STATUS_STATS_TLV:
> ax_su_ndpa_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
> ax_su_ndp_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
> ax_mu_mimo_ndpa_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
> .....
> 
> HTT_TX_SELFGEN_BE_SCHED_STATUS_STATS_TLV:
> be_su_ndpa_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
> be_su_ndp_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
> be_mu_mimo_ndpa_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


