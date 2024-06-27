Return-Path: <linux-wireless+bounces-9635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A89D919DD8
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 05:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2811F22767
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 03:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C0012E71;
	Thu, 27 Jun 2024 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Br2KSja0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C1291E
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719459087; cv=none; b=C2daW1G0pBEH1cJyalBDm1KjtuERKflhixqEIVQeJJRQvMxR3WucklU6NPW8d3bIxEkTtaf1c16VpKfZqvFMV3nN/GhlDdDYzfj/FMYI6f7r40XNjp2gKWnOOIBj5R0BQDZ4AXfBwawVenbWanRbN7LBXNca77JwtbKvCebRKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719459087; c=relaxed/simple;
	bh=9yu/XquQdBW9AIONE/WrsUjyZICkXbAa080Scqmszmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BsjIk8ENiysVwpdPaDToIIcyiAasGlajU5aUH09pDHwme6cXBcemx/sxd0LzefCJsLuj6RcmEgChhkpdowbsy7ZWc6ACPAe3GRb9Jek9WUxxPsA3enVxJCTCWbrD4Et5WkZ8dTbOVE2zx1FkKKcDXQ32NxTaWe1QCfvF0r+eCrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Br2KSja0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QM3UUZ003769;
	Thu, 27 Jun 2024 03:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	95cfiXka2X0N1nNQgsCOmwJyr15SxQeuo8qD1A+9W40=; b=Br2KSja0u6r392Bl
	O3KgJCJkkK64wYc+swsQ+K6xp+Ic31/fj2jKdKjJ0LHRCB5niZIJ/0hRZjk9WWTd
	aX3PhtDDLPaSYwu7vR0MRYvL73GxLbV42onyciP+tK9mFR9/9U2jF8sml1Em8cx3
	4YTxt2Qstt8583+0kURGbriV566BpG2Jj2sgXaLp2hak4cqsE7dos5QhKmiKztyq
	Ox//uce1HvhigbjJQYX5w2K9kaybA7OR2W0iSxEEDYNsU2+ZeuJQmWnJmpi3bsx2
	/DTnGrxNgFqGqzpCOoQbEdnte3KQdC8L08GyHjy04UFLmO42jjBTvFR4g3ql0rX2
	nNRaGA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywmaf3pe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 03:31:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45R3V7vp022395
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 03:31:07 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 20:31:06 -0700
Message-ID: <d5ac3c9c-b2cc-4558-87c9-0df986ebef65@quicinc.com>
Date: Thu, 27 Jun 2024 09:01:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] Revert "wifi: mac80211: move radar detect work to
 sdata"
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
 <20240626045216.3754013-2-quic_adisi@quicinc.com>
 <6b70365be2858b557340d3799fd7965f66bae2ba.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <6b70365be2858b557340d3799fd7965f66bae2ba.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W8AMJLQ0VoeQXOoOFZfAMJkGeUzIjQgf
X-Proofpoint-GUID: W8AMJLQ0VoeQXOoOFZfAMJkGeUzIjQgf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=710 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406270025

On 6/26/24 17:46, Johannes Berg wrote:
> On Wed, 2024-06-26 at 10:22 +0530, Aditya Kumar Singh wrote:
>> This reverts commit ce9e660ef32e87441bf59b04f67a24113e82546a.
> 
> Should have 12-digit sha1 and title like in a Fixes tag.
> 

Oh okay sure. This was generated by git itself. Will add properly in 
next version.



