Return-Path: <linux-wireless+bounces-9639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17E4919DF6
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 05:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07801C21329
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 03:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4F313AD8;
	Thu, 27 Jun 2024 03:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lWypC4kj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49DB6FC6
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719460181; cv=none; b=blRCVjhXSyVGnEXpDcf1IEDrcFzQwjrBePxfv6WuKpgCDxEVxh1k6VnNXY+4ltOU+3fDMdvdggqFLA+FEZ+xuJ4vaQOgRqXJz6E6ScODSEqgzIV1XSrq6CHPPmMJJJfuTNmfJRlxSr0upZqu/CoAXot30UaMBYpvAHwsX2i20Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719460181; c=relaxed/simple;
	bh=0J5L3TXjh79GNdPJZDZRBWX8evWXKr364ZDzazcXBMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p4g/xI66tGgK3xmA7fyyeB5B8JoTPoTNHt9OaMqWap8rtpCN9g7wY4eUQAhIQRkwDYwll7iUs47VdSBh7jIf2iN+BBntqSrHoM2Hi9goCE69Ur0Q5QpBlN18/V75GAeVY/Mef5d7JqYqheieeDtoe22jENWCG/+8el6ADNLV+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lWypC4kj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QLvl2u004644;
	Thu, 27 Jun 2024 03:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6l6qcrJG0ZzYkHaOTfEeSVvWp03vz8wMeWfJhVLUXlc=; b=lWypC4kjmFWSAkqM
	Ft4IE3qeliCd1Tt6lAFGE+APodUi0K5MkkGRDwdBCG4uyrvyIdjKRnWxl5rLVtPI
	Qv5Ur06Al/e2dFePIV8LM4FOf+KQ9CODZCd3j7Ri/kt+C5KxnxOfuUEy2lNT0iuJ
	vOBZvk95wawjJbj5K+NehPIB57VdUcyRE/nTtu4Vkv+EPcYBYVFJhNmVaB1mL3vL
	yKeJUpPDVY0eI354BvYRRE6jKC64t5Uueo7bSZxSwSYkTvZOachJuP6kqGQd2qlU
	Plcwin9SnjIDz2/DwTnO9TD1jimyk/BGwbixNmfMx2Fams4j1R0TXJtkBn+sNS5I
	S6lqag==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywmaf3qep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 03:49:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45R3nXmH013456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 03:49:33 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 20:49:32 -0700
Message-ID: <28345e8c-2a80-4862-a4dc-45ef3875fd4f@quicinc.com>
Date: Thu, 27 Jun 2024 09:19:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] wifi: cfg80211: handle DFS on per link
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
 <20240626045216.3754013-6-quic_adisi@quicinc.com>
 <2670401fe00f0da320c534a94eb4575b001b180a.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <2670401fe00f0da320c534a94eb4575b001b180a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a_Lw3DCkzUu8e1Gt1wzc8SXS2f7rKNzg
X-Proofpoint-GUID: a_Lw3DCkzUu8e1Gt1wzc8SXS2f7rKNzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=450 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406270027

On 6/26/24 17:57, Johannes Berg wrote:
> Here, and also in patch 7, "handle DFS on per link" seems incomplete?
> Remove "on "? Or "per-link basis", though I find that a bit stilted?
> 
Will remove "on".

