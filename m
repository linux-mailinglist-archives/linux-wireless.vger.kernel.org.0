Return-Path: <linux-wireless+bounces-4445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5802C8740D9
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 20:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136CE287187
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 19:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3E614038F;
	Wed,  6 Mar 2024 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SF933Idc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8213E7E9;
	Wed,  6 Mar 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754748; cv=none; b=KmsVi5PfsU2/leFJbxCp5ZV4BAfHcUBAhdub/gh7tYlwCPaO4UdaHxdpciE/wtM9jFpnwXpIKUi6+9dRzVX677K5LVcVPW5gaSF5zmvIaCMJkd0T2ZQlLvmE29zZopJLt3a+/qCGEPrfrF9yiwYyDTVuxZGsePgcyKTJ+yau1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754748; c=relaxed/simple;
	bh=Pm9iytJeHmNpW5R3KERp+8ohecuf8RUsfMoFsLAuIlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YddPhhQW0Q/ZePS1niamKZOE1Pq3Gt1Zwh1BWh+joG9krSn70xG2gVfZjcfHBu4xOFbe+rPezCLFC9Ee1uaB3S5uYM1y6sfhhAdzxCCBk42RV8rEGNXIy4prae/bY6slplQHDnBezoIPg9Lt/1BePJI5zXhfZqA1A11OTGUAsHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SF933Idc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426HNm7t001155;
	Wed, 6 Mar 2024 19:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yJINZYBZZmc1ycj8lkeDH7Y38CEh8BjsOQ03wwRU7QA=; b=SF
	933IdcK+XE4HHZXciZplKx6et8rarVSInfGXQLR8x0CaTGIF+ML7FanvnhMS95uU
	m1owAWaYhIcPmnz4L0NQzbyUp/ROfr+430mRE5+SSYH+LfiJc3yD2jRsL/xSCJ40
	al9gq4vJbNvYmAsK9JdHY28dX0+nvmgHY2tjF/Szge2cwNYKCkXq8PCgB9lV2tvj
	2bngtDxS8d/iMnLvfaOxjc2HtjpVUZncCYvrvyDrac+RtZDX/baJ7jFH0qUdQMAq
	2gAEYjiGlDe9Ud/BGykpExrBtAZec/R652K99dMxoA/uLdFi1XS7l9kwNvEcFqqJ
	rSLBjQrYtE+5/kWyinZQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpgwmt022-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 19:52:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426Jpn1u022260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 19:51:49 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 11:51:48 -0800
Message-ID: <1701a746-7607-4890-9a59-9b6fc9817ec9@quicinc.com>
Date: Wed, 6 Mar 2024 11:51:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] net: rfkill: gpio: Convert to platform remove
 callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Johannes Berg <johannes@sipsolutions.net>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <kernel@pengutronix.de>
References: <20240306183538.88777-2-u.kleine-koenig@pengutronix.de>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240306183538.88777-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z5d2RXAcawdt5Qf4aLW4Da-glALtowcJ
X-Proofpoint-ORIG-GUID: z5d2RXAcawdt5Qf4aLW4Da-glALtowcJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060161

On 3/6/2024 10:35 AM, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>


