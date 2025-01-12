Return-Path: <linux-wireless+bounces-17377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3157CA0A7A0
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 09:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C55F1886854
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAE379E1;
	Sun, 12 Jan 2025 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BkPBxYpn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08C1714A1
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669321; cv=none; b=tpYPRY6J5nsnaxWob0zzyrCp+aoCZn75UVCLeSZItjLEsj6eooIiALJd2rFJIGtOs3ERfO1DztAmnIGJrom9IwQx4P4wKvVqlV0l9t1qzq3FYwwKHRwb9k6Nu5HABYPbCi/w4WETBVT7zan60pOCW26vdTDb9oBKvcb27uo89K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669321; c=relaxed/simple;
	bh=xIFrezFNdM7PTr4eCUlK/Le0tIrkxBjW5sAbyn1oAzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CB6+nxQX4XS159jLINOL/TUnIF1h49wQxdc5+aSfy02gqRGleixM71Ofa24CQa0CDm+yM3zvvL0M/qWGvgWJpQftIPMaUTyalqvCdZ2KpBU9PZmZg1AKgEOXggq1LBNCOw2JiXESrQHgw8u/90OOxd7Vh1DbjF3gCPs6bnXZMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BkPBxYpn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C7Y2Oe019408;
	Sun, 12 Jan 2025 08:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hnizD9CiDnoQ0Q9WEjug54Qprg7eSadCINnCuMg+RKg=; b=BkPBxYpnXfb3+NxP
	i5bvn5E+aDScb3AJlhyHHubJB/BVXHcyNOs2smCqpj+s3XQUKfNpkTrDg8uezCp6
	6NKFqIk9wmUIpyWrYp+a2nWwqpW/d+5ifssL0OVWcj8Bao26O7JraWdRYPtPv+1w
	tEhF9OZeZxOtTSd6i2X0FymWCZKxdZgxRneNpA+hs4uk6t/cdl+Qh75lwBFI4Ea7
	k1PLFIXK54G4SqJjQF7u5Em5YRbAAT+3SSvBPg9tZM9gymseS32Ux6VFJGoWeSeW
	1P6S+4wNrcvC5GAb+7FyNPN1MUIOb+nCuKi+MwVNbfj69oRJ9o+J5Jw0UVLhKyUL
	fdwnKA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hm21rq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 08:08:29 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C88SnW023801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 08:08:28 GMT
Received: from [10.50.34.183] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 12 Jan
 2025 00:08:26 -0800
Message-ID: <214e0005-2045-4d2b-9071-54cd40ddd049@quicinc.com>
Date: Sun, 12 Jan 2025 13:38:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/7] wifi: cfg80211: reorg sinfo structure elements
 for mesh
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
 <20250110042449.1158789-2-quic_sarishar@quicinc.com>
 <5e7eb3236768d8e3fe4eee984fc799070aabd30a.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <5e7eb3236768d8e3fe4eee984fc799070aabd30a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vec88g0sWe6VYBqHU620ugeU6Oms06h_
X-Proofpoint-ORIG-GUID: vec88g0sWe6VYBqHU620ugeU6Oms06h_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=629 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501120070

On 1/10/2025 2:45 PM, Johannes Berg wrote:
> 
>>   include/net/cfg80211.h  | 43 ++++++++++++++-------------
>>   net/mac80211/sta_info.c | 64 ++++++++++++++++++++++-------------------
>>   net/wireless/nl80211.c  | 11 +++----
> 
> That should be two or three patches, I suppose.
> 
> johannes

Sure, will split it.

