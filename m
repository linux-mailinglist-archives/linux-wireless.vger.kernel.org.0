Return-Path: <linux-wireless+bounces-17531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D90A118ED
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 06:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21C13A7ECF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 05:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F422F825;
	Wed, 15 Jan 2025 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yya/FK80"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66C22F3B1
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736918797; cv=none; b=abolnmuQwLH+dYB+SmEF1zG3nJewNVyWojH+26rCvrcARfav4fELaSM7/DP7y/lhyCbHFUbLkXuJkr/QRucLsEKa4MnLEgnx8YBvwU2bxUGQDOMbZOM3S2rRgyR/67qW+QMx1ckAHfv9w4xCc4OCr+ffIAAfskjfPd0p+zpVsnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736918797; c=relaxed/simple;
	bh=LQjFMoTkiq4In4bbBe/niZvS2YRgxvj9zVBVwMi+4lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=thaR9J37QHIzItoxVt5nPUofh8CcQu+Kv7P5zdqjjlTFyS+ZMeSUm1cWMNAA2Juzun+62SQYaKP9dtB9lUsAVp4UVbXiSyZc0Y5yqE/115Vp/QNp6KRTJvCgtsR5430L/1MZvOX84uurMhrqJOaC1kvyJ0cVxZjQfvdpdtPoUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yya/FK80; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F0aim7001344;
	Wed, 15 Jan 2025 05:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gYzg4gZ95K4UdPOeti/o1jGOxz8MHNFZitraDieLTNQ=; b=Yya/FK80JeTm8Xvd
	WA/KZdt2iJ00145Dy46AUnMWbiR9dOOasFL7t3HsRg0TSNyZOJerGGp6plD5Oi7u
	64eFrn7c/iyoT2fEgG5eti+jF0jffAd52XfBLWc+QuFu+iRqsuidRiCWiTgX+6Rh
	zI1x22wOpUpHxXX2ydOFBbr6l9IhZnuvT4gRDEHXN5W/5h9ULoFs1mZoi0Ns5N9s
	5lSIRTdNdF6p/avmuLcMelHyg+UStV0aPY3A0aHDnnTxdGE9zIZOLOlaPPj2JJRG
	7smGcV257paUW0gGsdI+wEcoz2i+9wYVCyAfLgIi7GAMfkCHQh/2Afsz8nXniQPK
	ccf+bw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4462mkgj45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 05:26:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F5QVHC013238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 05:26:31 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 Jan
 2025 21:26:29 -0800
Message-ID: <d2b317e0-dccc-4683-8964-3878ef61d4fb@quicinc.com>
Date: Wed, 15 Jan 2025 10:56:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] wifi: ath12k: Fill pdev id for fw test cmd
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>
References: <20250115042532.1509956-1-quic_aarasahu@quicinc.com>
 <20250115042532.1509956-5-quic_aarasahu@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250115042532.1509956-5-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5WFkbIMyYhgkosu7Nv3PbCZMgPVfGoV7
X-Proofpoint-GUID: 5WFkbIMyYhgkosu7Nv3PbCZMgPVfGoV7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_01,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=891 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150037

On 1/15/25 09:55, Aaradhana Sahu wrote:
> Currently pdev id is not set properly. That can cause a crash
> if pdev id is not equal to the pdev id when firmware test
> command is run during AP bring up or ping.
> 
> Set pdev id in function ath12k_tm_cmd_wmi to resolve this
> issue.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Rajat Soni <quic_rajson@quicinc.com>
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/testmode.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 

Previous patch "[PATCH v9 3/5] wifi: ath12k: add factory test mode 
support" only added testmode.c file isn't it? So can't we squash this 
patch in that?

Let's not introduce a bug in patch X and then in same series fix it at 
patch Y.

-- 
Aditya

