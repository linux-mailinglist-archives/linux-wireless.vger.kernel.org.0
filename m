Return-Path: <linux-wireless+bounces-7485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE478C2969
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 19:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3F01C21BC6
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 17:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC3318654;
	Fri, 10 May 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ts5C3jAY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8E18637
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362789; cv=none; b=FNroVfTQr9p0xF3ovwtEZoKJu3kBj2o2Mq8kU7wraiHx11/MwBTqQM1dzaP5K7HvFTwPzgnhHixOkbaR2Jzq7JlEBgLJjMIfkjqxvhj/jsBDwKM7eKi2228vIG3GxSaaS0E4w3+K7ye5YXNavXO+cFTH8v5IUCXf5dWUaqsquX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362789; c=relaxed/simple;
	bh=PulP/0Dg7WtzdDuV7PmOpxg9JkERkLCuBVxFxCfdh+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=blrtcMZTYyFxFzTniAbqfzGYAqWB5t2qa91RlSfvaA2QwPJMUVAGzh6QXpllcThYn/WZryxzzqPEw2v3XG+O2DeLYpaDdztoeNhjMVnRDPrx/MKvbH5BDLMZcR17oQbTRJTlYMewmXqoBGe8ud/3kTU57mQc7xwMb4Idg2I9U+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ts5C3jAY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AE4ngv014161;
	Fri, 10 May 2024 17:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Z/2FNSJEDjSJpiIJJXuVWE9xSOlRJ4Xyd8X01guB3Eo=; b=Ts
	5C3jAY/XuZtwlqGnKoYMA+3eLzK4c8YHhxK6FxEq9rMgEpQWvjzdXooG1oJDJBZD
	FPYOaxOJNp9mTbT2mHa0zTl6VV2K+ywxSL0kaRchyV3kMUxpwj5OqKIwpm8WXh42
	FhAfls6bI1x5wLUmMsaq7acIRaxNpWSjfHTT4Es3ZDpRXxwpSkVs7qjdULJN0a1M
	J5D9ltgBEiEZ2cxgF3nkt9tWUqJFm5XrM+bV5AVowRh/LpDbauVXw1CNpzMnEneu
	jCwChv+SH4db4O3A7VACFfa/4EPqmvgE9LqlQNzK/R1hbQrVqbH4gIGCWMMb3oBJ
	XPDAtbH4H/soAbuSjODw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w2a4k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:39:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AHdjPe015769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:39:45 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 10:39:44 -0700
Message-ID: <55635ee8-1915-40ce-8c13-3337b9f40a21@quicinc.com>
Date: Fri, 10 May 2024 10:39:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] wifi: ath12k: add WoW net-detect functionality
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240510064748.369452-1-quic_bqiang@quicinc.com>
 <20240510064748.369452-4-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240510064748.369452-4-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NI7ZMKPQTWnjfTYs1dOzLl1oTyf4QeWZ
X-Proofpoint-ORIG-GUID: NI7ZMKPQTWnjfTYs1dOzLl1oTyf4QeWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100127

On 5/9/2024 11:47 PM, Baochen Qiang wrote:
> Implement net-detect feature by setting flag
> WIPHY_WOWLAN_NET_DETECT if firmware supports this
> feature. Driver sets the related PNO configuration
> to firmware before entering WoW and firmware then
> scans periodically and wakes up host if a specific
> SSID is found.
> 
> Note that firmware crashes if we enable it for both
> P2P vdev and station vdev simultaneously because
> firmware can only support one vdev at a time. Since
> there is rare scenario for a P2P vdev to do net-detect,
> skip it for P2P vdevs.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


