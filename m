Return-Path: <linux-wireless+bounces-10764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FEF943533
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 19:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D971F23402
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2DC381A4;
	Wed, 31 Jul 2024 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W1S0iIlT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4BB1799F
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722448578; cv=none; b=TnPEDav9WhJW1e2sfhkSAuBhUWO8S1qMhySQfD8/fqNigyCvcj8kVkf+QOIsM1uSqlebtU54pqdty/8ly9Tc/+0aTer5sazlinVVckpPw4uN7OCmjHOlQY1fzMeKqc7rpPTcxAv0UDPfh7c0LJ4dgGhdv8VhHCFx4oFLfLe1Y18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722448578; c=relaxed/simple;
	bh=GKNdWU8kDKKCtkK3dL12ezTyL5kn46tTE4VRmWYI1j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LOLlnyZg2EMX2x0fZhs2+OTDtlGNyY670WqL6F51352rgie6Pjf4Q0PBRuA0YRfaaiuN8nNX7ymE/YqvtOoWtKOKofZN7salKPl4kKz6uEMwlUcd19oYnQfj1b1qCZgtqSNMTP2vKKxz6smVGI+Ea+tylIWDP6smVs67sLvqr9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W1S0iIlT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VCXt6n031641;
	Wed, 31 Jul 2024 17:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mioISJehhtWtXAXFLAz+BflYe85ptWXAnSZ9obXoXn4=; b=W1S0iIlTAhMnlADq
	aRMQo4dvXcNILBSy6s8JsqI6/KRfD9NqG6wcLkdDuab0cCGcVBampQmPGvR4KT46
	fKq2h8pBob6BuJc+jqCiXL2pLrwm+rSyxTbB5lz7I9b0y/aCtV3QLGwpih1TnEXQ
	e/6yZWqRH8V6r7ENVwd9Rr5rswT0xzv5wzeD+TZ/0V1Er+dxQtpnp0d0paP+0sJE
	gJ4gJ0rGZNwulDvgtZ08l8+CD96oRUdas0ASVFBAx4+71DMhJek4j7kntUPugQTD
	kkTxiJbPKnv/XuaZc9YzDED53eKnVf7hw+sGkei14WEoyuVty+uX1IBa3mFgNNZa
	X9oZeg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mp8n4jgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 17:56:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46VHu5mD030673
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 17:56:05 GMT
Received: from [10.111.177.34] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 10:56:05 -0700
Message-ID: <6f47df34-3ae3-4619-b52a-1140f9a6e384@quicinc.com>
Date: Wed, 31 Jul 2024 10:56:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] wifi: ath12k: report station mode transmit rate
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240731113645.54738-1-quic_lingbok@quicinc.com>
 <20240731113645.54738-2-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240731113645.54738-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PREX3MicXtPtQPiMD0BP-4TItqYldgir
X-Proofpoint-ORIG-GUID: PREX3MicXtPtQPiMD0BP-4TItqYldgir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=852
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310125

On 7/31/2024 4:36 AM, Lingbo Kong wrote:
...
>  drivers/net/wireless/ath/ath12k/core.h    |   2 +
>  drivers/net/wireless/ath/ath12k/dp_rx.h   |   3 +
>  drivers/net/wireless/ath/ath12k/dp_tx.c   | 134 +++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/hal_rx.h  |   3 +

My Qualcomm Innovation Center copyright checker reports:
drivers/net/wireless/ath/ath12k/hal_rx.h copyright missing 2024


>  drivers/net/wireless/ath/ath12k/hal_tx.h  |   7 +-
>  drivers/net/wireless/ath/ath12k/mac.c     |  79 +++++++++++++
>  drivers/net/wireless/ath/ath12k/mac.h     |   4 +-
>  drivers/net/wireless/ath/ath12k/rx_desc.h |   1 +
>  8 files changed, 227 insertions(+), 6 deletions(-)


