Return-Path: <linux-wireless+bounces-2424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D86C839E8D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 03:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D711B283EB7
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 02:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3E715D2;
	Wed, 24 Jan 2024 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f81mOIFD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BA17CD
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062169; cv=none; b=SsO8jHHQUD1DaktqWm2iZt5GWXYG3wT5Eilzjl6r4gzNyNaE/p0DI6a7wBrhjxJW/JBIfA9p5bDxWeCEmDZL08SRMVs2+V66kMEQptE8nQm6uBe4hgYWUrGTJUT9dFMqaSCw4kdIMe/ewPHce32miqgAD3dFAZIoHHHWwx4t2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062169; c=relaxed/simple;
	bh=WlaLhL1L3zsCh/k94MIFABeH8HP27Vst4jTMxQ6g5H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=riovwwb8uMCWX9CPMeP3/DmjBuBomKYCtLn1NzGi3uzN5FyQ0DiE1VlSD5Vz1TGm6gROpL2WMvKbpToMQDMKUrMcRjv6tGf7wUaLadRc17F47c9FdQElvke4lev/pu+0oCfkQsGXZ9xnIVdEI11ooYDpEfhpyY1s+xbSHl1YlnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f81mOIFD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O0jjFT005562;
	Wed, 24 Jan 2024 02:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=69hanRqci+Q8/5MZ/MBa58r1Geu9XBuEAXnhSXH+tpY=; b=f8
	1mOIFDJx1jk+J1kxOfqbM5haR3n/rbZSnqItpuNKcukLdmiA6/o04atpDLzoEJKL
	5qgGlYP+cIOkMnbMaubMlDG96xJ3iYiSQiq8+AkUKCK65MOkDJEhbEActAOFlYNq
	6wxIGYzN3b0O5tbmOjlFPZOt9rUVJsiEzWumsWzQUNWI739NKYV5IxdGYplbUtG5
	y240inbod2i+x0/+k84ohwjuqXcMHtjJsG8tmtHgSHs5CqsaXlRJhNNvCAjzxgi1
	vN7EEVuCbRr8r4ipKPnpkMuEkwAJovCHKjNdVDU8eYWo6S08/bUSxlkWO+/NervP
	YqhgO6YSOhGVbOmr1BSA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmhn8hsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:09:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O29EpD025110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:09:14 GMT
Received: from [10.110.18.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 18:09:14 -0800
Message-ID: <2a6677b6-f18c-41ff-8582-d14af8b4d845@quicinc.com>
Date: Tue, 23 Jan 2024 18:09:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] wifi: ath11k: avoid forward declaration of
 ath11k_mac_start_vdev_delay()
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240123025700.2929-1-quic_bqiang@quicinc.com>
 <20240123025700.2929-4-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240123025700.2929-4-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8AMzCeKnMCSe4vkJKf-RrNIWM2bW6c8B
X-Proofpoint-ORIG-GUID: 8AMzCeKnMCSe4vkJKf-RrNIWM2bW6c8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 malwarescore=0 mlxlogscore=399 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240014

On 1/22/2024 6:56 PM, Baochen Qiang wrote:
> Currently ath11k_mac_start_vdev_delay() needs a forward declaration because
> it is defined after where it is called. Avoid this by re-arranging
> ath11k_mac_station_add() and ath11k_mac_op_sta_state().
> 
> No functional changes. Compile tested only.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


