Return-Path: <linux-wireless+bounces-12798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26328975AC8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 21:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D60EB22FE3
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9461AD9CF;
	Wed, 11 Sep 2024 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BryHhaZT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02121885A8
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726082340; cv=none; b=aNa8143oq0K/46qaez4STtaKv7NqAc/H+6ZvsSh2Qkz5Oa86M6dXo5AFtJFDQ4TnKO7XrR9w9+9W0um/V7W/PSFMSorqHGX0c0XZXJz1aTD/lVh+RmMthhFEsAhYDRj4yXxWNhdJOoFxNCDsZ51pxWTSdYyRtH3WN6PUCZ3DQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726082340; c=relaxed/simple;
	bh=sDGHHQvc1w/U7n43eqLr9VMOozQdegjAqtxdGjCgsZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PSYX+knN73Z7oGVU0xqAAWgZertwY+JiAS1GUfLwTviRGm/wcw9dYfH7tWXROgHXaY4TAdVZqphkS7P0GJ6FEuO5Tf6/hdhlg1UN340dGzyW+2emP52sPA+/hGpmUWfq6gPyaXEa+xW+ESjvYRGOnKfQoX1PeTEqV1woiTeRMHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BryHhaZT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BEltaX008643;
	Wed, 11 Sep 2024 19:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0fFCbqLviOcKIuRISyLtYIUYll/QaQPmbfvi4zhJKU=; b=BryHhaZToImmG/gb
	HJAm5FnFef0ukKuxnvi3WUKJTTpK/sJeYtBLEt4fe/XhsWvVE+tEEshor2nBn4uC
	9xMChjZgywR+lCyYvS3RH4j00w+u35cJjWc0wdpoYsoYl73Hm2ynGzHJ07MN7B1v
	9IIBwTH7pCbNfTfgsz07OSn0Gb+60UBVhuyevFFILOdEkns8f47mpOQNGaf30Cer
	3jZzlPnmSfda9bKqiQCzdDlbo1xs8Hv3skuhaK4u8YtvfnZko1XnCVQPtvA8x7WG
	vvCnG8GfPxQX+VJ7WGDqmM+OluFoVsINl+vPVAlK3xdOzCjtlRFU6ejM5Uh98+m9
	p2ZpWw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41he5e20x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 19:18:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48BJIgKj005145
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 19:18:42 GMT
Received: from [10.111.181.177] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Sep
 2024 12:18:41 -0700
Message-ID: <4dd46a07-4896-433f-8e03-2cea28c255c2@quicinc.com>
Date: Wed, 11 Sep 2024 12:18:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New staging repos for ath1*k firmware
To: Sven Eckelmann <sven@narfation.org>, <ath11k@lists.infradead.org>
CC: ath10k <ath10k@lists.infradead.org>, ath12k <ath12k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Robert Marko
	<robert.marko@sartura.hr>, Kalle Valo <kvalo@kernel.org>
References: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
 <3772134.MHq7AAxBmi@ripper> <87h6ang8v3.fsf@kernel.org>
 <2248097.72vocr9iq0@ripper>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <2248097.72vocr9iq0@ripper>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wf7W8AIzynEdZL5L1inQIZoIK3ucZgp6
X-Proofpoint-GUID: wf7W8AIzynEdZL5L1inQIZoIK3ucZgp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=885 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110148

On 9/10/2024 4:39 AM, Sven Eckelmann wrote:
...
> For the completely missing ones, I've submitted following list to QCA:
> 
> * ath11k/IPQ5018_QCN6122 (that might be rather complicated due to the way how 
>   QCA designed this)
> * ath11k/IPQ5018_QCN6122_QCN6122 (that might be rather complicated due to the 
>   way how QCA designed this)
> * ath11k/IPQ9574
> * ath12k/IPQ5322
> * ath12k/IPQ5322_QCN6432_QCN6432 (sounds a little bit like the QCN6122 
>   situation)

I'm looking into the above. For the ath12k ones I suspect we are actually
waiting for the platform support to land in the upstream kernel, which has
some dependencies. See the current IPQ5322 RFC:

https://lore.kernel.org/all/20240814094323.3927603-1-quic_rajkbhag@quicinc.com/

> * ath12k/QCN9274

Does this help:
https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/commit/5d154d1a7f1059bf96b1127573e5b87f68538df8

/jeff

