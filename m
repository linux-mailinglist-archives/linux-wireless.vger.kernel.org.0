Return-Path: <linux-wireless+bounces-10482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECAF93B117
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 14:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50751F24980
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 12:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE44D158A15;
	Wed, 24 Jul 2024 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hWr/NvM0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46105158A19
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825718; cv=none; b=lg3idJ95ON/JsDOZdJq2sKvZVPUCmZZyMzORr2PFTrurE2aJtAbkgohB5MJHL8hhKej+S5/gqvbKl4RpZDHo8MSQReHIC+6EnQaX41PoUXdH9hFQiGrZOUHyrtiCn3+EAAJQAthIE7tSKLXv3VIGaxRg/0jJ7R4CV/FB5B8LCtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825718; c=relaxed/simple;
	bh=6ugcYOFC9pU8TiHTJ8FuG+7NDCqY9yj+Pg+Bmau4OCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yzxdeb+8K1gNfnsPud9iRTF87acVOJZP/07ixmUkoSgFt6R6qEDyAAHBlCr5gHPiI1TBcjmZ941c8K3afQFG6eVyY+CYN+FcbPnKceFmpB9ECTHPSEVmHDlO6pOx/qobmwi4plrg/pbvkuYuHCXtvd5sfAD/wodJ2V37JWszBwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hWr/NvM0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O9N930015095;
	Wed, 24 Jul 2024 12:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6ugcYOFC9pU8TiHTJ8FuG+7NDCqY9yj+Pg+Bmau4OCE=; b=hWr/NvM0NziJawWQ
	XcFjKCgIdlo/gx2pPVTELUxkPLHpvAvHAn/Fx5diohx1f9eAldHxpRqJRol4atTF
	iZIGsOvOU44Aiq1Uf2aTZh5v95qCzHLP+Aw34YKnaIawP0PXQvErXN6xVbb4yq7j
	QDE3tS5w1ZoPLcwySKosAcWRT20FeBX3OgXgXxOWJCuqMYOmRKlsgEv8gX3dt9w0
	tssk6Kt9kdzK3Hc7QTtL45JcnJmHGBz9DhK9mQfttRmJ1JLQLNMBfRWCTWeRfn30
	pki6xFNaTXZHF+eYtK9OYP5W4SRdZalISnz8nHcotRSxZ+gx/j5jQL7bOCyEy0vs
	CfTPjg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40jxxbgg70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 12:55:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46OCtBh4003015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 12:55:11 GMT
Received: from [10.216.12.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Jul
 2024 05:55:09 -0700
Message-ID: <77483c94-5661-7c76-66d6-6800a18b8c32@quicinc.com>
Date: Wed, 24 Jul 2024 18:25:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: cfg80211: fix reporting failed MLO links status
 with cfg80211_connect_done
Content-Language: en-US
To: Carlos Llamas <cmllamas@google.com>
CC: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
References: <20240722194146.1736608-1-quic_vjakkam@quicinc.com>
 <Zp_TLK2-C4LYC-yl@google.com>
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <Zp_TLK2-C4LYC-yl@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: paM1MAFoCxbq5tUVvYFLAl525S0BLPuH
X-Proofpoint-GUID: paM1MAFoCxbq5tUVvYFLAl525S0BLPuH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_10,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=833 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240095


On 7/23/2024 9:28 PM, Carlos Llamas wrote:
> On Tue, Jul 23, 2024 at 01:11:46AM +0530, Veerendranath Jakkam wrote:
>> Individual MLO links connection status not copied to
>> EVENT_CONNECT_RESULT data while processing the connect response
>> information in cfg80211_connect_done(). Due to this failed links also
>> indicated with success status in EVENT_CONNECT_RESULT.
>>
>> To fix this, copy the individual MLO links status to
>> EVENT_CONNECT_RESULT data.
> Does this need a Fixes: tag then?


Sent v2 patch with "Fixes:" tag.

Thanks,

Veeru



