Return-Path: <linux-wireless+bounces-8281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804F28D3E97
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 20:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309701F24BC0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 18:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B038E1C230A;
	Wed, 29 May 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IJMGQJCT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683815B552
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008870; cv=none; b=mivPbBWm8LziHJesBwq7pLeB0D83GC5j9+l1/BSaBiN+SfF9WNUFYk/qunJH5V8eWAa3C2lGflbR4n0vk6uiKcUluz2OYym7T5tLk3nTc/DL8KCE25taGYQFxhuDkRvw796hsqG2pFz/1G7ctVIKjZf321sUvpRABKV7bM6NCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008870; c=relaxed/simple;
	bh=PX3Ha9GDLydMyiIXcYq/VVNxXxDqCadTUN7Nld6JlRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jlsAXL14cC9fBcc6cQ3AE8YHAHTVuC7aqHSIfDoRbcqjGz5bBOO+fluDCHzYdAHl4ddu5PrQqwXKeIhwIO1i0WarvRssqcTXqvmtgrpTMN1kuZHITEh6LRS2pgZ+5NbEau7DfMN7L+RzC+PCAkXiHYB6Bgcrs8BgozZ85G2PVKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IJMGQJCT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44THtGYA006833;
	Wed, 29 May 2024 18:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K3h5LPMKxKKDm4hq2pOHbFuVeCR93OWHOIZHAEeXxzg=; b=IJMGQJCTlWc3n1tN
	kqqG59dAmEj6jeycC8+ergRvgsHnB3HZfT++0Xc8uOmdSa2qypxeLllj6wClpDWi
	UhmetA62yfT/bJsgVh0IipxRzRJtnnow3fHvu6bf6nOKQfwmkIvKDgg8Ip4w15hd
	4KYe6nkche3KIf60v7DEn2OaSol07xVXCRkhCStKL30q1Hq/zT8zIQBdif27mJbw
	RFuA1yUog0eNussdXUk8ZpAdJxpLABMYE/BB0GtbeNPjOvE0AlodgTB1N5I+QvF3
	K6V5AqaCTES6uW1SMztYDSmY+ztNimcLv5Ya3FKq6jSNkeW+Ktfd2+u3OPIkT/KD
	0/EGnw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ye96bga4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 18:54:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TIsOEe001990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 18:54:24 GMT
Received: from [10.110.109.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 11:54:24 -0700
Message-ID: <f62188cf-215d-4a4a-b9fd-c8cf9f87d6b5@quicinc.com>
Date: Wed, 29 May 2024 11:54:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath12k: handle symlink cleanup for per pdev
 debugfs dentry
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240529043043.2488031-1-quic_adisi@quicinc.com>
 <20240529043043.2488031-4-quic_adisi@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240529043043.2488031-4-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pMezlylBW8ras7kBrY_6c6HjVU1-nV6z
X-Proofpoint-ORIG-GUID: pMezlylBW8ras7kBrY_6c6HjVU1-nV6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_15,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=742 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290130

On 5/28/2024 9:30 PM, Aditya Kumar Singh wrote:
> Whenever per pdev debugfs directory is created, a symlink to it is also
> placed in ieee80211/phy* directory. During clean up of per pdev debugfs,
> this symlink also needs to be cleaned up.
> 
> Add changes to clean up the symlink whenever the per pdev debugfs is
> removed.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


