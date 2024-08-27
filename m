Return-Path: <linux-wireless+bounces-12099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF95961927
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 23:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DDB285036
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 21:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5965215539A;
	Tue, 27 Aug 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="osrUYKuF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF31F943
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793833; cv=none; b=BkWYkMRVxDX+npbwPNdFn4LoxsngxNJyiywuZUJXlqbji4h5yNhXvXNTKRkTfY2Szi/mYseIjCLjbKDgvjnj4YEcV38IfBo6Ex9PXLfNG6FPlPTs8/XW77T56EFfVQKqqjhnfHJLAwVwExa1l6uQdyx9we4kmyTsZCcWbh9TThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793833; c=relaxed/simple;
	bh=wlrTFw0eF1H4fd6gxEABWpxDbKMOFJ2/Eqcu2NrOXrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bM59Cb0bZ2ld6dipWP5LLkrvPf23LXtCsuqpjU6XoJEGrWGT+hbRoFFhFE+nKC8VQhl5uOV3s7SAuO32td/rvOVTYgooIZkZnfXtyqy13tFbwypwfLAl7Q/P61DUl1uiN31bba7V+mLVA28v2N/zYJUc9kXUieuZCz2+tiw30lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=osrUYKuF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RJkwOw018168;
	Tue, 27 Aug 2024 21:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w+fxUiHiHPueOzRgw5JBaotNGvvazHhs8zICGYxeKnA=; b=osrUYKuF0xVPEDeh
	PEXP9tFA7bJZEL1vxwvQpnMfSR48oG/bMtg82kT5ITwpFm4eUezXRet6yOoxWA17
	Xzh0YsYCFQWhbTjtZww73htmU54ARLeAFeagxHriVdk3+niklDKfLsJ2TH3iu7oS
	kqWdUGvEM6G7R7xgYrziSFHQAB9ade4MMGmBYyZ6/DeWgtJAh1TXuspkKDoz0fXf
	AWhT3tk5SLxuYJfVzJylaYpgcnqaQJtLSzCng74CexRCw2//XcGm7j2KLN1AVJcW
	HFH1e1hYWsWS9idr9henyLmQob9ctFfVLFEBTV946GhkHjj9MyJslDYdjqOEQKjV
	vmlShA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4179810akm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 21:23:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47RLNlIb020617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 21:23:47 GMT
Received: from [10.111.180.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 27 Aug
 2024 14:23:47 -0700
Message-ID: <24340105-999a-4210-a74b-1cdc67de3678@quicinc.com>
Date: Tue, 27 Aug 2024 14:23:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: refactor ath11k_dp_peer_cleanup()
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240826014942.87783-1-quic_bqiang@quicinc.com>
 <20240826014942.87783-2-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240826014942.87783-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8yqUwEqCrtvi3ODOzcuOtSasqga3zJvh
X-Proofpoint-ORIG-GUID: 8yqUwEqCrtvi3ODOzcuOtSasqga3zJvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=906 spamscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270157

On 8/25/2024 6:49 PM, Baochen Qiang wrote:
> Currently ath11k_dp_peer_cleanup() acquires ab->base_lock inside itself. This is
> working because it is only called in below context where that lock is not held:
> 
> 	ath11k_mac_op_sta_state() --> ath11k_mac_station_remove()
> 
> In a upcoming patch that fixes memory leak in reset scenario, we need to do the
> same job as ath11k_dp_peer_cleanup(). However ab->base_lock is already held there
> so we can not directly call it.
> 
> So the decision is to move lock/unlock outside of ath11k_dp_peer_cleanup() such
> that we won't get deadlock in a context where the lock is already held. In order
> to make sure it is called with lock held, add LOCKDEP assertion there.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


