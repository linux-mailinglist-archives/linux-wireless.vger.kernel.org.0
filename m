Return-Path: <linux-wireless+bounces-5850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2827E897903
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 21:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96077B261A9
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E833154BE8;
	Wed,  3 Apr 2024 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gU7A918X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80181524DC
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172558; cv=none; b=Ej/gpQEroZxgWv5NtmEoGMnEJKlPu+x4H2CYu0QPtgJKnsoQJAQnPI8SnSZE5zHfU+PMsF3ac2xzmgyprGJvO2ra39QkMoeb5PSyXumo8//ofULKDFDg7tPbbLnosC/lpMmlD0ptvIydBhylvipzK6+FpiahkSgQIFHTmFfC/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172558; c=relaxed/simple;
	bh=3HQkgOBLxdRx08ikscHe3lzhx1MuW4vRauCIiyRicd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ns5uW6UChXnVyQeoordnc3MtstMxAUBkqLzy2UNgJ2wiPEVPLXKZnuWPkWUJS5QLb9hnUinI5EcjKf1BY5hIKpqf+2rknn6MyYCnKHMYy1xewowbgS4mcqU2Ob0kBvEyWZQU1u8KDUBce9SuhQDfKnrRm8olqsS2nPad5hvC26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gU7A918X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433JRUw7020510;
	Wed, 3 Apr 2024 19:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=k4vGYDISrYqzlDnedyCCvSufWJp9roVtvbuNg1HGabQ=; b=gU
	7A918XpBPm1RPUtAf2luHYVMNiySS7an/vMjZyToDL68Hb9TwJrMUneyPe5mgfUh
	BijGKDNPe9T5lOIf6gL2RsPAPLjw+AtCSTfMU2/A+Hki1F724b2bNA2ybCXcg9H8
	ZYwvl8oUj6OcglkUBeUlZvwEnTfqc8zY5Rizp2FNVjmeOK0f170jk/iDe3Gtmzrh
	zCppMSKAmw8Q6uBA8RtPnsPiQbS0YtAvgWmcOEitVtxvUqlkARidXhtCudaO2150
	ZeqBTbq7hCAs/jbWL+dnzvBxJimal526TzsJZPxghdNQYAbXfaeiQMH3PhoCwVNu
	x8zU1KV3p7Afj5eVjpJA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8xnxt7r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 19:29:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433JTAeI015729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 19:29:10 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 12:29:10 -0700
Message-ID: <259cb770-373c-4549-ab3c-45cfcb00caa6@quicinc.com>
Date: Wed, 3 Apr 2024 12:29:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] [RESEND] wifi: ath12k: fix link capable flags
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240403042056.1504209-1-quic_periyasa@quicinc.com>
 <20240403042056.1504209-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240403042056.1504209-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fHYm2f3U9dtxprnWZN9waJvSZ-ZlTXl4
X-Proofpoint-GUID: fHYm2f3U9dtxprnWZN9waJvSZ-ZlTXl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_20,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=994 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030131

On 4/2/2024 9:20 PM, Karthikeyan Periyasamy wrote:
> By default driver supports intra-device SLO/MLO, the link capability flags
> reflect this. When the QMI PHY capability learning fails driver not enable
> the MLO parameter in the host capability QMI request message. In this case,
> reset the device link capability flags to zero (SLO/MLO not support) to
> accurately represent the capabilities.
> 
> Found in code review.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



