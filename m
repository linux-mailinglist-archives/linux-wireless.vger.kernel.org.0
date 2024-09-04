Return-Path: <linux-wireless+bounces-12500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F5796C562
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 19:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC701C25185
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 17:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6CC4778C;
	Wed,  4 Sep 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kJ9wxUHY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAD10A12
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470726; cv=none; b=KbOOmHZU2Xy7PaEyT5hmU701k2kpKCwWX9CNHs8tCgby1EdMhG3/5TO/oVMaPegsjdXj+qnNmGUdrVjS2yZQuVShuoz5ek3AQesB/UcfQCo6uIfXFxAK8MsZEtrEK+y57+hw7o531QjXbIgWlWVOBCXg0+zVLL8hQ7dkR/Gb3ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470726; c=relaxed/simple;
	bh=jktc2OwO2NP1GVYlvR0L/ugFhh0hocAp9s45XS/xnF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tCVAOPhOfzSQFKavujg/VrhbidkluyNmWU/c0iWjXsBGaj0jkqDib3f7e+PLELL9MX1dVdMUJqyDBvlE4jJr/iUSf8S3H8CrXWBQKLgwYqjtVgtt+WIE6eF0RSaZV7O6bGe19vBUELnpYwV9tuwfURF14yIo7jz0kmPf7oAIxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kJ9wxUHY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484D8b68019870;
	Wed, 4 Sep 2024 17:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IlIDdBlBgXOQYRPGtE85G4T5HBRp3VWCBEmjWVE8JgU=; b=kJ9wxUHYr3iYUddA
	YVtAbdbDQiM4ganAHg1peoxWyQM4DUBlw1jVeuMNflbPFsoZzXfsy3TUPb75ILQs
	Sty5G8UyOrBh2NOZ9//h3g0UhooprHPh9+tz90S/tHsDNsVknK2LVlO0zqZHtzI0
	iXJ8xIp62no7YNuCDyDb6ELXf0+ABbaTYpZUoGF5B7cevAN6noMNYWfiofPaXPjB
	+iXjy+xU069YVnQTfcrAvuVSx+dO1fnp2ix6tz7HUrsJMWh7kdJgBpMy+2vO9h0w
	nQrsX+ByBfHUB+AEaHPTj4KeAc+Qxgv6LZB+8dpCayD8wjC8K13EXxz0jnD/PT4J
	UW2wpg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41egmrt1g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 17:25:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484HPJXv005296
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 17:25:19 GMT
Received: from [10.111.180.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 10:25:19 -0700
Message-ID: <d5394d40-6a5f-495b-81b5-d974ad0de0e6@quicinc.com>
Date: Wed, 4 Sep 2024 10:25:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: fix the stack frame size warning in
 ath10k_remain_on_channel
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, <kvalo@kernel.org>
CC: <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240830015349.1083226-1-quic_miaoqing@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240830015349.1083226-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wK_v_gdJJeL5154T4SzmqXAF--_0WtLJ
X-Proofpoint-GUID: wK_v_gdJJeL5154T4SzmqXAF--_0WtLJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=732 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040132

On 8/29/2024 6:53 PM, Miaoqing Pan wrote:
> Fix the following W=1 kernel build warning:
> 
> drivers/net/wireless/ath/ath10k/mac.c: In function ‘ath10k_remain_on_channel’:
> drivers/net/wireless/ath/ath10k/mac.c:7980:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Compile tested only.
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


