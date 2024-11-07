Return-Path: <linux-wireless+bounces-15019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBD99BFA95
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 01:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B5DB20A8E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 00:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ADC366;
	Thu,  7 Nov 2024 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bc7TuT9A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80A621
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938450; cv=none; b=fDdHmk4OtduGxMFSRgRL1jUKHbhCkHKoEcgGlKAJb+bOvMjP4QYtfh0MsCItwkxIc86CH3uVw0Ta7UQJFXIg6lnLfHU1HmgmhJZ647xzhj8OHxZYmXEZG67JKWY2h2wV6/jQ8fmllEsQT9a0+SeYZTMztJ1pwTYPqVzDRlE0yRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938450; c=relaxed/simple;
	bh=7Kr+xBS8nCfcu7u1riulC21jmhfB5ehrhYD/Tyg6X+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nje37FTY41XXN1m7JCTT8oRZart6f5sSgUXRTKQVg2HS5NeKTffgxsK623ZXVI8GPRuzje1mEW6QXFTK63L8z0rKQbLj4K+6O1I333A4HThBjKJShf7Hek4fafghVZ5OWEVkZPtzmuGNFKwe+iIZBcwS7JgJnR8MP12ZS/A2z5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bc7TuT9A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6HkgpE028840;
	Thu, 7 Nov 2024 00:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4o4oDhBwaou2FC37R3e+JEtwsqqNeCqd2aFyl1njSVA=; b=bc7TuT9AQh3FIE70
	MTAV1u9kb8wzjjJHMqCj6/iRbIadaIbk0L/FQY6bFp/eL+X/H8QEIvf3j6Xg3TBt
	UKoVXiC8w3X9Vr2z0qVkityAcG9iOgcY8nGatmo2E4ANKhLozA2sMb481sqz2rci
	PsAELodo5KM6aIHgZoP06w6QlKKCQx06GVg0Eziox01kOxJx8eKPb7fbTJ1V5SIA
	hV4M9ape3QI+GWk2UbGm8OTzONtUdvZuOh3ZxvVsFsPNPQADFyENfwoJhm5eSamU
	JH47KhjyGTmYET/mqNMK8CjlZgDjd0ZX/vo74oVQECciFD8QQhYm71kbCanbRDwN
	V8i0iQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd28ctu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 00:14:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A70E3Wn026781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 00:14:03 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 16:14:03 -0800
Message-ID: <32b84dff-b547-4154-8959-8386815f0ab7@quicinc.com>
Date: Wed, 6 Nov 2024 16:14:02 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] wifi: ath12k: Support Transmit PER Rate Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
 <20241106044548.3530128-5-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241106044548.3530128-5-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t5Ni30mFdffCyJ5gfFLxaM5GTiWjpo8q
X-Proofpoint-GUID: t5Ni30mFdffCyJ5gfFLxaM5GTiWjpo8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=877
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070000

On 11/5/2024 8:45 PM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request per rate stats through HTT stats type
> 40. These stats give information about rates of PPDUs and
> MPDUs for single user and for OFDMA and MUMIMO technologies
> corresponding to multiple users.
> 
> Sample output:
> -------------
> echo 40 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_TX_PER_STATS:
> 
> PER_STATS_SU:
> 
> PER per BW:
> ppdus_tried_su =  0:0  1:0  2:0  3:0  4:0
> ppdus_ack_failed_su =  0:0  1:0  2:0  3:0  4:0
> mpdus_tried_su =  0:0  1:0  2:0  3:0  4:0
> mpdus_failed_su =  0:0 1:0 2:0 3:0 4:0
> 
> PER per NSS:
> ppdus_tried_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0
> ppdus_ack_failed_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0
> mpdus_tried_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0
> mpdus_failed_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0
> 
> PER per MCS:
> ppdus_tried_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0  8:0  9:0  10:0  11:0  12:0  13:0
> ppdus_ack_failed_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0  8:0  9:0  10:0  11:0  12:0  13:0
> mpdus_tried_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0  8:0  9:0  10:0  11:0  12:0  13:0
> mpdus_failed_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0  8:0  9:0  10:0  11:0  12:0  13:0
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


