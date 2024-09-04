Return-Path: <linux-wireless+bounces-12484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC2D96C057
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 16:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E171F26532
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A488441D;
	Wed,  4 Sep 2024 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="muX0YKAQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCB1DB55D
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459874; cv=none; b=aHOl8pN/FiaN1tsbPv2qB7Fti9DuST6zUxpe94YYRWhLsiMTgjFNf8P2dKhln4cYVhI7KoFoB75s4Y1AYJaOslWa8yU+pOFzLvga8vLKRuQl/wjOtGo14uZoHXa2pbKSWEOTHnufDlXCVD45SRT+/wo+GENnLM8US4wucO4Zo8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459874; c=relaxed/simple;
	bh=447LwyUT5oXZu520/DwPs55bbrosa07mWoL8Yq3vNHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LrFXMn6cnZBi72oMOqwRRT04Bu5YOYpZKmSB7VIWwxRqo3GK3/QvBHu8f6ZYvR/btw9nPO55xNlVG+yp3dJp2juT09oEY6jikEFEVq1n/S6dVb03bikZd/aHofUQB/1/+PuzQELnI0dxdcP1JfN8gjt3tKLkcPwDOeFig1doyNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=muX0YKAQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4844Xmpq010421;
	Wed, 4 Sep 2024 14:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	447LwyUT5oXZu520/DwPs55bbrosa07mWoL8Yq3vNHY=; b=muX0YKAQxl15fjNl
	yHQxVh14lzPNjf1x6YU/4we2XWQDPqhcmu0dgX8IE6Pi7qmpNCoNQ0xkMVZTcGxT
	y7pcqfEPtMCJ0elz9Klc2AFFCRnTR0HM8Ayhx2SSGZ1GIwDN3IRz8rTpKoY4Jn9h
	9P9bZJ2Atklz0L4UtySAMUGhqXOssnXDNz0hv1GoiVNorkmwNOazekUH5/M6DZmp
	r1WYkkcd/TX5d+39SCe6Kj8OQ/qmfAqv1uVVmZimNoFs474mg6cpxOHB6V7Bz9g4
	Lyob1LGFwubIpO6D4UX5JoLkeTKImxLrzLKF0hUBfO9lmloMRHhhgFgchezBRivu
	Klnp1g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41egmrhexn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 14:24:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484EORal027007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 14:24:27 GMT
Received: from [10.206.102.252] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 07:24:26 -0700
Message-ID: <d9e887af-3bd6-a3b2-d9b2-f329fc972877@quicinc.com>
Date: Wed, 4 Sep 2024 19:54:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: cfg80211: Avoid RCU debug splat in
 __cfg80211_bss_update error paths
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240904015520.3571295-1-quic_vjakkam@quicinc.com>
 <037a8342a820c9be41ba367280df4f448e741c05.camel@sipsolutions.net>
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <037a8342a820c9be41ba367280df4f448e741c05.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t8i12dhzMXHeloOn7TREXSrPaNsf0P6m
X-Proofpoint-ORIG-GUID: t8i12dhzMXHeloOn7TREXSrPaNsf0P6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_11,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=479 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040108


On 9/4/2024 1:10 PM, Johannes Berg wrote:
>
> I don't think that's right. Every other path here just uses
> rcu_access_pointer(), and we own the 'tmp' at this point, so that seems
> correct.
>
> johannes


Thanks, sent v2 with the suggested changes.

- veeru


