Return-Path: <linux-wireless+bounces-17729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963A8A16603
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 05:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC50E169146
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 04:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2198013D297;
	Mon, 20 Jan 2025 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PjKO9JiD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5F33997
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 04:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737346129; cv=none; b=XfE+bUxxru+YJz6G/m++ANIzcQ154a9uiPUb8HBgxE9QBz4MxNw8U9RDyPBCWrA8oo5s1NH6TewYI7wuvPDKOWUSFcFvMAALbaCCvxD5uDB4FtgkbXyzu2MS7o8AE1AL5EFytoQLwKaQAVYMPpg/uPgccC63zaXcHyv+ZTVFnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737346129; c=relaxed/simple;
	bh=vVInHq2a8ndN6/ZV4eoqfLMYF4Csm9i5EktllZhqEwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BK/7SDu+vEokg2kQw9dhGzbIjOTPoxf6nJXqgqqgozaG18I7MCvNYASQCQykfHiOcUlL/26IlVRtQqimogjsosmPXg2bR4sDhRuGrCMGJNUqaSP/4HsqKIA6jnWf6qBcYeW+vIkYjnbRsG9mikTccx+5YICijxd7y9Gi+snUFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PjKO9JiD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K31Uox012005;
	Mon, 20 Jan 2025 04:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C0Z0vwF7s4QGUXyfNNExvhCXaAKwPJatJwNh2IqApWY=; b=PjKO9JiDspqnwMBf
	jIksYQ7kceBW5QF6xTzwu1UQVPxjnYusgqLKKQFzSUPI16YIani2YjTBGqi8pd3h
	O3dtdCGxSEmGgrNYRT6/ArpHeBlBuBdkRNQ+uoXI6dQd1B0/vF0HfX29xZRUJcGe
	GrRPCBkDrkd7xYIKYSdSqodFb74CxjiyiOeM6Y9mLFaV992UCv3tFJ6/P0fCsjJf
	1EdY8/21yTWCnhGs7SEZBdfPCm8sG4D8X4xLzdwslmaumFjuLg7gL3fQkUj+sa4m
	gHjKXE0No8+O0hvuBegwEcMm3ZyI34u1IlCZnSLtWOnnKOcncurXOk2pGaEUyDke
	kNVJCA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 449e7j03sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 04:08:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50K48gVH025653
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 04:08:42 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 19 Jan
 2025 20:08:41 -0800
Message-ID: <ca119799-f55a-49d1-a00e-bb86704f2f80@quicinc.com>
Date: Mon, 20 Jan 2025 09:38:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/4] wifi: ath: create common testmode_i.h file for
 ath drivers
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250119083657.1937557-1-quic_aarasahu@quicinc.com>
 <20250119083657.1937557-2-quic_aarasahu@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250119083657.1937557-2-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JpJCJakVpiy2X8OMv86Iak7gkCADMWwC
X-Proofpoint-GUID: JpJCJakVpiy2X8OMv86Iak7gkCADMWwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=396 mlxscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200030

On 1/19/25 14:06, Aaradhana Sahu wrote:
> User space application requires that the testmode interface
> is exactly same between ath drivers. Move testmode_i.h file
> in ath directory to ensure that all ath driver uses same testmode
> interface instead of duplicating testmode_i.h for each ath drivers.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu<quic_aarasahu@quicinc.com>
> ---

Reviewed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

-- 
Aditya

