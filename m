Return-Path: <linux-wireless+bounces-18002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E19A1D1F3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 09:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5962E165E13
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F47D156C72;
	Mon, 27 Jan 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dzB9wmew"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF4DF71
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737965726; cv=none; b=c/Bkc8afGCzsLzBW87brxfRLJUwQzg8JIHhwJthB237lV8TXSGs/MP8YsuAY6Rin6NU1xFKTzBzFFT7+JWSjeJfhqAqUbYY1kIjx6/SN7kkKRJe3wj3RNmBS6EeyoUCEqhNjFE18hQ6Bz8mP2711wxwJRwCWTqEmyz254x5VwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737965726; c=relaxed/simple;
	bh=Jyopvxgw/9VSzs3QAgHpDq/mQ7siNK6b/ygtzLKe8E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KVQ87caKbsVDAq9jG6NDGq+6ge1wLdExTUfZPBXiCWf+thJYDtQ2QhROgc5v088yc1BHqnbRtJoTVKoDbkBJyNB/exkPdRQY1m+nKdmstfPWVGY9rgAD76DDPcmqTWJBU2XffzPsPuYaEBxf2A12lLH3rjWW4BJMi3d+S678Rsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dzB9wmew; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R4kdgr018672;
	Mon, 27 Jan 2025 08:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N9K+oGbmnKAX6d05tXBvf4pq0h7uvZP9S2XaWVJotMU=; b=dzB9wmewz3sLsw1n
	VQLTTkbATKG3R2ZO8t7vA2IOKXKPZRhi3rFEGYaB9pbA+m4KDtJNmWcB1pu/QDw1
	qUKCghsOSx+mYgnuO1cHjcvi7FhGma8CScCDJo05RaswcxDPmrZXe201YqW41fgC
	WkISM1b6EkMUmI5fTI9Xin5GJyYtVRC5koynDuMapSohX9R2FyFlVq0WSu0mIutn
	DfxmMlxWnoNGd79GvT9adrY9wqyo9I+zIAn4+ZZwOIMw1UHu9VPYLff8+jMh1MCM
	jA3X1kawdJaIe9Yl5+MQSDifg4Rt0q2jXCIpB9gjPp/xWuOeq0bOYF7bDD7b7Lea
	MsqNrg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44e3dr0d5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 08:15:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50R8FJaR028555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 08:15:20 GMT
Received: from [10.253.73.203] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 Jan
 2025 00:15:18 -0800
Message-ID: <bd1544e9-0947-424e-9cb0-f50c41e0be41@quicinc.com>
Date: Mon, 27 Jan 2025 16:15:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] wifi: ath12k: Support dump PDEV transmit and
 receive rate HTT stats
To: <ath12k@lists.infradead.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250113071758.19589-1-quic_lingbok@quicinc.com>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <20250113071758.19589-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Jxvz3kY3eup3J9_N7BSCWi88N2PemVKa
X-Proofpoint-GUID: Jxvz3kY3eup3J9_N7BSCWi88N2PemVKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=742 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501270065



On 2025/1/13 15:17, Lingbo Kong wrote:
> Support to dump PDEV transmit rate stats through HTT debugfs stats type 9.
> Support to dump PDEV receive rate stats through HTT debugfs stats type 10.
> Support to dump additional PDEV receive rate stats through HTT debugfs stats type 30.
> 
> v4:
> 1.used tab(s) to align the = to match the existing code
> 
> v3:
> 1.Rebase again to 48322e474f04
> 
> v2:
> 1.use TAB to be consistent with existing code
> 
> Lingbo Kong (3):
>    wifi: ath12k: Dump PDEV transmit rate HTT stats
>    wifi: ath12k: Dump PDEV receive rate HTT stats
>    wifi: ath12k: Dump additional PDEV receive rate HTT stats
> 
>   .../wireless/ath/ath12k/debugfs_htt_stats.c   | 500 ++++++++++++++++++
>   .../wireless/ath/ath12k/debugfs_htt_stats.h   | 182 +++++++
>   2 files changed, 682 insertions(+)
> 
> 
> base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256

hi jeff,
do you have any updates on this patchset?🙂

/lingbo

