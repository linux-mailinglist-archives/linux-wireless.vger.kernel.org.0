Return-Path: <linux-wireless+bounces-15589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D69D58D3
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 05:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A0C28323B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 04:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA534376F1;
	Fri, 22 Nov 2024 04:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FjagU9mZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB9230987
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 04:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732249641; cv=none; b=vCgfwUNDzRBxhugevfYPqujdLGJ5J+7MqoRv0qDtQ13qNkWMY0hiY09/9KTuGFFO1DeMTTrcAhJdbjN8t1PLMpIUYX9XRn8GXIt+uQ3zzsdRK5A3eAAI21zbYuyL296XFPnJqhr8msOz0kF6XzV60cRfrnbCTXoW9Pvx607QjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732249641; c=relaxed/simple;
	bh=dYYE1WgoV5bgZRssMhoRh+gladGHZ0UptcobPi/IyRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k9j9SvngUx7Zm4oe80J0mIVfF67+vghUJjjnLX3xs1+l+fmC7RaIYMpHK31//L2iUvqVSIkPiPpzJpO6h5slkIzzo2VBmo6UO1AK5zhSfr+F6/+1zfjOMpBKInomPdsJKsyuDrwG0Mk9YbLGIW8uO2uxv65u+fYNFyDnacnk2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FjagU9mZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALGVpq1015515;
	Fri, 22 Nov 2024 04:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qTu7iMQVugNg11tdHGirIxpPG43YD77DQ00zRSFoUxk=; b=FjagU9mZjJOHSvtk
	Vei21CENcogPcvixgJV0kgHmzQKRzaD+IioMnkk+Mu6Wb4rSPx7E9MIxwuF99Znh
	Rxv3piBDc7dQDKR8dHJH2gXGUqvTs20GOUek/o9Oid4Ybyf7QFxzXXaSE8gQirYU
	1kqz/DPS7doTtQRo1ETvA436Zm9zhZwiRBhFnjOvfndUJG+iqPnrUmCIH/N0vTjG
	IYm/ERR7K19xyO9kOlk3cK/enWXFS1A2F4DV6AR+lGND5SRLOiN49r6i68jSagzb
	pfL21k6meGhAUB713miN5sens2Vu+oVqFWc6cdnYS+EE3ag2jwS/nWFucJqdwWB9
	ts0IGw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4320y9jy9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 04:27:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AM4RDc3026958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 04:27:13 GMT
Received: from [10.111.176.168] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 20:27:12 -0800
Message-ID: <4c8570c2-bafd-4072-81f2-b1d87c1f2b93@quicinc.com>
Date: Thu, 21 Nov 2024 20:27:11 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: mac80211: use wiphy guard
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
References: <20241121231136.4fede74dcb60.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>
 <20241121231136.9e02d2b88f8e.I5b06810b7a71860fe3c2efa92ac09f2a13e30d7b@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241121231136.9e02d2b88f8e.I5b06810b7a71860fe3c2efa92ac09f2a13e30d7b@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GCxxsA9xm_ZYLVQw5E0wdXoapB2PlTrQ
X-Proofpoint-ORIG-GUID: GCxxsA9xm_ZYLVQw5E0wdXoapB2PlTrQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=669 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220035

On 11/21/2024 2:11 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The wiphy guard simplifies some code here, so use it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>


Now we just need guard(rtnl) :)


