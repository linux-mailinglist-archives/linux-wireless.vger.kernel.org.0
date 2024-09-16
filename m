Return-Path: <linux-wireless+bounces-12898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77A097A918
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 00:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B146283BF8
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 22:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12687145B0B;
	Mon, 16 Sep 2024 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JX9Pe1oi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B43F9DA
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726524822; cv=none; b=Jx0RdBlniH8S9a0bWUj5hwpBN6Tec5Gab29xQgUG4y79AR+39f78kHQZn6mDIDARsAVq4zqNTmzizA+8v+1ceF08MBFHmZrFYC5y/+c4PDOdR0sBTgcfLwHouz76WhB7f0QLKSg/eRV4tChFl+Ylnz+ZeKYKRK0TE3I1n1DpWfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726524822; c=relaxed/simple;
	bh=fs+L9FPwuYVpo8J65YvVYega5oj0D+j2255HwnRYi0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D2LUoClwSC1+KEL3DIAEiTNsLV98ILo2z4aWZ6DPTbfxltLSOllZvkMwh6/ftYfPNfN75aIrA9VvpD6c+ynDZIy3juuTWvCH6II0xlHA4W3uabexhsuvmnVKwXzvuZw8inNGLa7UGeveWh9FqAHtcCfBMH6CT7mpvDMq26Q7Zjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JX9Pe1oi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCrotx017095;
	Mon, 16 Sep 2024 22:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7rqLTiSZyYwJxwpcN4mZlhCYGVDyK4f/k5/fkCJ9pgQ=; b=JX9Pe1oiShurRFpx
	FU4CbSz8i7l2Tp1LWzAVcdEFkJG6WPkcM8a0eSOuHFMvDNog99cLrZgcX2xICeOh
	JphXSpHMv3YL7N1767M2Jgx6RU9se2p/7d+e6vcuAw8LSP43VpbhAkMpAFe4yoFd
	OmOuGtEqIL7rYsCKcmiTJuuLtKGuaIr+MuT0TbyDkUbZL2RzlwRUouMPtn3a/jPk
	atWyfyvvBlBCF0T1/HPCyzgwogYD95vFX9S7CX3E0O5QllQJk3sUIljcX1HNW0dH
	m/RRRrCI3mOk8x6tMXVkdH7GIihljLvBzQ6jKpLjJXj/EnKzZXsSD71p5x31VEBK
	8tHUMA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4hh59vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 22:13:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48GMDYk2010723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 22:13:34 GMT
Received: from [10.111.182.118] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Sep
 2024 15:13:34 -0700
Message-ID: <a718b706-8d00-4717-843d-8c964c22d6f2@quicinc.com>
Date: Mon, 16 Sep 2024 15:13:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] wifi: ath12k: Support Ring and SFM stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240913082949.573482-1-quic_rdevanat@quicinc.com>
 <20240913082949.573482-3-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240913082949.573482-3-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kls8MJSsCzyzXBVOVOpAW9WpsUkmcpFv
X-Proofpoint-ORIG-GUID: kls8MJSsCzyzXBVOVOpAW9WpsUkmcpFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=977 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409160150

On 9/13/2024 1:29 AM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request ring and SFM stats from firmware through HTT stats
> type 15 and 16 respectively. These stats give information such as ring
> size, ring address, valid number of words in ring, etc., for stats type 15
> and SFM buffer information, number of users, words used by users, etc.,
> for stat type 16.
> 
> Sample output:
> -------------
> echo 15 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_STATS_STRING_TLV:
> data = TCL_GSE_CMD_RING
> 
> HTT_SRING_STATS_TLV:
> mac_id = 0
> ring_id = 0
> arena = 8
> .....
> 
> echo 16 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_SFM_CMN_TLV:
> mac_id = 0
> buf_total = 1760
> mem_empty = 32895
> .....
> 
> HTT_STATS_STRING_TLV:
> data = PMAC_SFM_CLIENT0_RXPCU0
> 
> HTT_SFM_CLIENT_TLV:
> client_id = 0
> buf_min = 148
> buf_max = 445
> .....
> 
> HTT_SFM_CLIENT_USER_TLV:
> dwords_used_by_user_n =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0,
> 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0,
> 34:0, 35:0, 36:0, 37:0, 38:0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


