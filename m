Return-Path: <linux-wireless+bounces-19696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E36A4BBE4
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 11:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F22E16E4B5
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 10:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175621EE7DC;
	Mon,  3 Mar 2025 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mCSsTR48"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995091EDA04
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997184; cv=none; b=QdmA0rXOr0j/7oNV1SNMF0S1BSTN+6mE9AGDFClwdN/Juyx4CZwUyudfoE1ytBE4drK/YsC0tOMBZdmvT8PuIBrFneTtLPDMvmyb5hk5++It4FUU9JcyMNnZH2lPfSzw9Vb87FWbAPf9W8oK18C9GviNt0KUFGRwk5VXAMOVAVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997184; c=relaxed/simple;
	bh=uRADvBsyODQqdhrDtGP0SBQu60ng1+/sJaPm2F2Zjwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DlRb40CapQjztSlhQVqXYAeLW4PifWMEfiHZAroDWVp0Gs7sagUPZz6OIgdqa1gCeLGH7nKocCjz07J3uIPveApyZR/Cv9tAre35iZY7Uf9KWwleu2aLj0jW6/3g/j6+/LKZZradz8pQOUb18gFcKwxN8hF4vb85V1B9UegSA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mCSsTR48; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522Nb1aU021907;
	Mon, 3 Mar 2025 10:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ymjyMYU8K4jEiwpdWi54nBIgeBtbpvHZJbMO26RaR54=; b=mCSsTR48eSxlE+dY
	sEOVzb3Q5hiCb1I+z8AyacEH+mfQ3aluJwihbzSB9cLYTMSHhBdOC3CdCSV11jPB
	8Gb/t4TRiQqbyvzrbmkST92EAPkTC9PBzgNbu2EaXoO+PIjOQI0bsBBbIast73ro
	OjKn4WK1hUI2OSXK0vNDngmw4V/aW2fxrYlGfd3Xf4gLRnZg7k/GjjyXoKVqLrte
	1VodSmQLwVzHwqhez0q5piWWXzhwHFbcAFoEuE871e54PnBTytEzQwGEDI++Jt8B
	cEtEufbFw5JnSFrhdJo8F6VZWvwTCchKLI67NIRyhtk6rAHKFOuTdBeHdvKRcJKW
	14+cwg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453uh748yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 10:19:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523AJbZg026879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 10:19:37 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 02:19:36 -0800
Message-ID: <c207680b-0461-46d5-894e-45b6d627ee93@quicinc.com>
Date: Mon, 3 Mar 2025 15:49:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] wifi: cfg80211: Report per-radio RTS threshold to
 userspace
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
 <20250129155246.155587-3-quic_rdevanat@quicinc.com>
 <7ff2d1dd2a83d9047c128035296db1651bcb6b91.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <7ff2d1dd2a83d9047c128035296db1651bcb6b91.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tR48CK6-l8J9Mgzv831hFGMtKDMZpF7i
X-Proofpoint-ORIG-GUID: tR48CK6-l8J9Mgzv831hFGMtKDMZpF7i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030079



On 2/28/2025 6:33 PM, Johannes Berg wrote:
> 
>> @@ -2449,6 +2450,9 @@ static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
>>  	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_INDEX, idx))
>>  		goto nla_put_failure;
>>  
>> +	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD, rcfg->rts_threshold))
>> +		goto nla_put_failure;
>>
> 
> There is, fwiw, still a preference for shorter lines.
> 
Sure, I'll change this appropriately, thanks.

> johannes

