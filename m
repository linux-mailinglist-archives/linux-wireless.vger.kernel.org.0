Return-Path: <linux-wireless+bounces-15010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E372A9BF34E
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 17:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E4AB20DA3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B336204F96;
	Wed,  6 Nov 2024 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DVvPv8GQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2B81E9099
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910828; cv=none; b=SwNtCtUl5rpLincJmCG+twkq2E/P7zlN3sSd2Vp0AJBGrI7EZCfF1WQWb/byXqQPcz2HP2mI6APNkNoIVa7rMjJSHjDSeQV9OnuL7flUzsw55gnjc4FaYYww0XcD6fBCQGhpuCwu1gj3txxWjEZz3/bV2a0/nd7kxnzgdOwrd30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910828; c=relaxed/simple;
	bh=KtbOnQu96h7Bqpd0a9tJweDsl7db+b2vi9BkYbopxkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t/ziyyyWOe3q2NQjQaSUG53ZIpKjrKBLxFYdKWHDQcrFVjZK/fBHad9n8meES6opqv1k2PtWITKZML11PSyXjQv40hTiV+0BzAd9jHf8GGwADl9Uj0IvHuoqvu327d1JBos6IfDq+xdwa2o1Qd6Gn88NOB+KY6cm1LPvBVOc8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DVvPv8GQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6EEbsm002132;
	Wed, 6 Nov 2024 16:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZSDpocEV0yz3CEoMlXviiQK6lBU9fkj3mTfj16J0P+8=; b=DVvPv8GQsH2Rv9eg
	29VYjsd7OR6GNLQVibIbikfT5edKIcmOl5vGPVHzQvzMYXWKXWGyLQ9+iERs2mJw
	gdZ8PMRguNmxy/Cd+VADiVpBa7g7EOy+kPdp8LLteDY1qejN/c9OOa7WCj/i5ant
	tMEyDRzyu7LT6xFB9h4GofRCfMefFppIswYlOtUGm23t41i+8tgETwufcQMMbkzg
	u0JJ4PX8mseG5SzZFyNki2jkP5fjaer8H6mDS7Taylv76x+BiW9QicJp8l30rt9M
	t8bX63EkBzjBiJ7dW3JJeLRBKlHkpNJy22fNh/4ngdJPYdl2XD6q4hIjsx3/kGdj
	3F22PQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r072hycv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 16:33:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6GXgeO004804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 16:33:42 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 08:33:42 -0800
Message-ID: <bf2dc4c5-1735-4ead-815c-03d11d0cb6eb@quicinc.com>
Date: Wed, 6 Nov 2024 08:33:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] wifi: ath12k: Use mac80211 sta's link_sta instead of
 deflink
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241106142617.660901-1-kvalo@kernel.org>
 <20241106142617.660901-9-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241106142617.660901-9-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Lu1a-pZ-vVaRpaA0tavUOrQzkUoVVr8j
X-Proofpoint-GUID: Lu1a-pZ-vVaRpaA0tavUOrQzkUoVVr8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=544 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060128

On 11/6/2024 6:26 AM, Kalle Valo wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Currently mac80211's struct ieee80211_sta deflink is used to fetch any sta
> related configurations in driver. With MLO multiple link sta's (struct
> ieee80211_link_sta) are affiliated to an ML sta and corresponding link configs
> are present in sta->link[]. Fetch link sta of corresponding link from ML sta
> and use the same for configurations.
> 
> Add ath12k_get_link_sta() helper to fetch ieee80211_link_sta from arsta. But as
> ath12k_mac_op_sta_rc_update() is called in atomic context the helper cannot be
> used and instead rcu_dereference() has to be called directly.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


