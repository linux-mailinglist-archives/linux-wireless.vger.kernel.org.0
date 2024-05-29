Return-Path: <linux-wireless+bounces-8279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0025D8D3E95
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 20:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15DA2837DD
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 18:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894C15B552;
	Wed, 29 May 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XBksK+AC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48EA15B139
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008864; cv=none; b=PI385CRIuJK+DSQWQlmq8NeYVHGLbvoldoDsAlJ+OOv7cC2SIVcd3jNVy1scUOa1q4x3OP5m5DP99L4GlmdO3iVNOjStuBDF4rnYPajsrtCA6IuuXy4vkI2xPwTTavzkFvWnj+LbdhjNv6qI40hF4ujz0JgBpy6H8tOGRU8hdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008864; c=relaxed/simple;
	bh=Q47xzL6d98STkKYXzhjCt7YaJewBdmVWph94DSSlcAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aixwQsFLbSvCaSag23CczekRc2pLGJ6bZo5sxDDlga+zpzvnWnpOPnk02TQkQCJVUHNE4f6/mbEQhqBxgnsDKYygZ0kVI5Pr+nHbEGWCqyUX2O7qYsQiCsO00yKy08AkbUluOQebs68/NNBbwWDtZsRahMnI/0P8/poKW4DBXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XBksK+AC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TAWqrw027031;
	Wed, 29 May 2024 18:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LvE3R28QsUeJZMRGut3j6Rbqwa+5CyBjuIYBoUifLSo=; b=XBksK+ACs4RGE8qR
	dC9stUbcqtTG45hgxUCrh+vgDIGtBvS9aLa0kUSo19D1JeW1S3u50gCc7CH+dHMl
	XZ2FRCgIASuZTor9khxvggIfMMKOC59OMGII8ZOiSP+nvsHXwNp2ck7pkZa3DOkT
	U/HShDEIWInXzK6c4+pIIIYNwERbO5qsm2OLmIcC1ZFw9SDf5AepQkP5KmOxMh+8
	f4mIsQguU7kDJdcteD0tuV6XusyBBY1MTGt1sFpqyO52Khw72BfrL2G9Aw1XuCZ5
	gDcVuRScF5Qb5H5pI07bV9Ov4VMZwazvLXdlS6+q+fpJEGTPf33mdHz8OiF5xs04
	7eXSpw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h9yvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 18:54:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TIsIqd019529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 18:54:18 GMT
Received: from [10.110.109.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 11:54:18 -0700
Message-ID: <45ce0913-a355-404a-ac4f-1f98c2927ddc@quicinc.com>
Date: Wed, 29 May 2024 11:54:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath12k: fix per pdev debugfs registration
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240529043043.2488031-1-quic_adisi@quicinc.com>
 <20240529043043.2488031-2-quic_adisi@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240529043043.2488031-2-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XSvmvqJHetAyGBSyJ011FkVUMVKQJ8S-
X-Proofpoint-ORIG-GUID: XSvmvqJHetAyGBSyJ011FkVUMVKQJ8S-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_15,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290130

On 5/28/2024 9:30 PM, Aditya Kumar Singh wrote:
> Function ath12k_debugfs_register() is called once inside the function
> ath12k_mac_hw_register(). However, with single wiphy model, there could
> be multiple pdevs registered under single hardware. Hence, need to register
> debugfs for each one of them.
> 
> Move the caller inside the loop which iterates over all underlying pdevs.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: f8bde02a26b9 ("wifi: ath12k: initial debugfs support")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



