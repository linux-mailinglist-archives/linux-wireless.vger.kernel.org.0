Return-Path: <linux-wireless+bounces-8265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6059C8D3984
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 16:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182F4287BDE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B504F15920F;
	Wed, 29 May 2024 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BuqJzlBx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F5158201
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993678; cv=none; b=V2KLNNTYFRBEvWBFf9QFYLj5pBVBmHA0elSt3kdI7aFUwLEtTdtbcyPe0A9gs2P8imkYwt7wJnfc1OJTZAGz7hYgzP5OySaQ/sZmpQdAwLNM58uHJ0vwCu3+X6hxnvp8BPggizc+QeHt8UlUd4AFgI+wAvbPtXnGgLvNVgOfoDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993678; c=relaxed/simple;
	bh=guo8qQGcvK6lUK1IJVdV1wUl8KN4Hs/TlPyxZV9oaaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ajsoq0sKvJnbLSORpkILOzOABMl02ZT26PxT7x+DH7b2tHR/OORIJoD29rLJdIUuTVHBnyaAuz9wfxHh8UvWWW6BpHaYGZB0GNkjVgI3dTF5u7+kZ9ZImV2Y9ZOYZ/ssE9SrHTTnbfZ2QTwS/KRjLZOMp9p5e08euZj6GGPka0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BuqJzlBx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TB49Qc005808;
	Wed, 29 May 2024 14:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kJ5qKcintWpRbRz347ijnBiMJCZIvMoK3IueNeRB/7k=; b=BuqJzlBxzLSRy6nb
	wcexmv6jXj5EBLnCs9D7P3PRF4dKph1LJ0J0li2FVb8SRN/36qyVtSCPnGrRu0Sl
	H34dsQjcuAmKIBBKZ+2MCFi/y95yNjKR82ghAiAkhaLzuKt1vjpJS9r0lwHKwns+
	2t7WrBOxQqKJ9xTJWvWmKwGMNJAtbkB3vZbfRlDM45fKA74H07zzKX9378XT5x58
	Q3/sllv1F2BlCFUf12Ct6nM+tfiOT1B85LOn8Tf185DZpvVlfBMR/outwkgncwxd
	pTAZbQFMsWsRlAmEfWV4gfzlnoMEt/kRPawSjtwTjmtUVp45svYwbauPNZ2c6wVv
	rNRAUw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0ps3u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 14:41:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TEf2ug028634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 14:41:02 GMT
Received: from [10.110.122.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 07:41:01 -0700
Message-ID: <0f49d156-2359-4286-b2ba-b6fb4345af82@quicinc.com>
Date: Wed, 29 May 2024 07:41:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: modify remain on channel for single wiphy
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240528082739.1226758-1-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240528082739.1226758-1-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HEUKkfD941SlGmtPX5_QcCSiPXfhhXmx
X-Proofpoint-GUID: HEUKkfD941SlGmtPX5_QcCSiPXfhhXmx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_11,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=791 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290101

On 5/28/2024 1:27 AM, Rameshkumar Sundaram wrote:
> When multiple radios are advertised as a single wiphy which
> supports various bands, vdev creation for the vif is deferred
> until channel is assigned to it.
> If a remain on channel(RoC) request is received from mac80211,
> select the corresponding radio(ar) based on channel and create
> a vdev on that radio to initiate an RoC scan.
> 
> Note that on RoC completion this vdev is not deleted. If a new
> RoC/hw scan request is seen on that same vif for a different band the
> vdev will be deleted and created on the new radio supporting the
> request.
> 
> Also if the RoC scan is requested when the vdev is in started state,
> no switching to new radio is allowed and RoC request can be accepted
> only on channels within same radio.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


