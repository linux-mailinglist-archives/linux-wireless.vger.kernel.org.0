Return-Path: <linux-wireless+bounces-6746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA79D8AF8A5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 22:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E3628450B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 20:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36942433A0;
	Tue, 23 Apr 2024 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JNFLwfvG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5596142E7C
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905737; cv=none; b=M/z5XlGED8Fn69N1YivK1VSvD8XdtHKvx3D7y+xvfjgMFbXffifkG2T0bptOkZVl+X5fo+/rVLj5wh1w/Jy+ZCnZjxbiDbZCX5bfDCnBB577wLPq65I49EeFS76m6x/xGCbjA3EPa+Haz3t/04SLCxxJ+U0o3EJX8xqkosV5t3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905737; c=relaxed/simple;
	bh=/ZzjAYpnPutlHP7mqSqo8GfWpF7p1pz1qivjLE+AETw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HmjGvQpl0hIYs6TWFqGxel4DGZHf0Z5/+VbEE5vFhrhA1PzP2mayHQSBSfd82avcKqD//9X2DbytCRgDnyOwBPKA9VdWmnjX5ekuY632WO1/QnyqvbmExLiPIGqOMyUF/lAPWt19Db/g1oV4NoprZH0hpJq3ZKy4ZkGeglR67mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JNFLwfvG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NKktpl021004;
	Tue, 23 Apr 2024 20:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=n98UzclOnnbRmGtd1Rcy9MSJPXR337fO+GZ+bzQ5tZ0=; b=JN
	FLwfvGfDIU8RtBDeez4FGBOFVKmt8E+NeuGrdyCpoPB0QX6nzudpnAxOzbUD0ouh
	kNAbHxc/CBtOF6YL7qE7rKNWJlSG5pyyfmXquRqDLVkm9Ma+hr0C7alGhp77tod8
	OFR2i6hW3tSVgbsrSpCcyfAvGvdUwdhizmRc38J01xo9y6OO4xChGW9uJ/FQhKfO
	5dDpOI5K/B3nG8POFJJ9s95C8dTvu0jgDFqpIkR8/JoXNWq9KDkJ6NCspK2GZJpr
	VyXuezeqVeI6OP/8+Z66nbWOH8iMBlzf71l1FQ3ZNvwCg26sCvbq/u+CQnVTvpDv
	SgF4enWtUgnm8892CAhw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp978t9m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 20:55:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NKtUZb002721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 20:55:30 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 13:55:29 -0700
Message-ID: <3a38abeb-6c00-434b-9704-8bf955c3b38a@quicinc.com>
Date: Tue, 23 Apr 2024 13:55:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] wifi: ath12k: Refactor the hardware recovery
 procedures
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240130060838.3895599-1-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130060838.3895599-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oIKHspSSERh_RcRDX_H3Y8qPOaCLjPM1
X-Proofpoint-GUID: oIKHspSSERh_RcRDX_H3Y8qPOaCLjPM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=594 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230052

On 1/29/2024 10:08 PM, Karthikeyan Periyasamy wrote:
> Currently, hardware recovery procedure supports multi wiphy model. However,
> to support single wiphy model, we need to refactor the hardware recovery
> procedure. This patchset allows the logic to work both multi wiphy models
> and future single wiphy models.
> 
> Karthikeyan Periyasamy (3):
>   wifi: ath12k: Refactor the hardware recovery procedure
>   wifi: ath12k: Refactor hardware recovery synchronous
>   wifi: ath12k: Refactor the hardware state
> 
>  drivers/net/wireless/ath/ath12k/core.c | 97 ++++++++++++++------------
>  drivers/net/wireless/ath/ath12k/core.h | 25 +++++--
>  drivers/net/wireless/ath/ath12k/mac.c  | 95 +++++++++++++++++--------
>  drivers/net/wireless/ath/ath12k/reg.c  |  5 +-
>  4 files changed, 137 insertions(+), 85 deletions(-)
> 
> 
> base-commit: 17f4b952f067b1f87d14e6df4c8c216fe7a245d1

since the "[PATCH 0/8] wifi: ath12k: Introduce device group abstraction"
series depends upon this series, is there a plan to re-spin a new version that
addresses Kalle's concerns?


