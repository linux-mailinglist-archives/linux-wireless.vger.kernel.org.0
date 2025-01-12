Return-Path: <linux-wireless+bounces-17379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08309A0A7A2
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 09:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F7A1887B29
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 08:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D688016EBE8;
	Sun, 12 Jan 2025 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NQbz+CBA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1979E1
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669430; cv=none; b=XI0rA2ai5HdKLHKZo88EVeAkPKPcCUqacmqyWulDwPu+sSlj7HHd70lFTC9p9xv1urZ4ZMflxF38OFRiB8Knv6oOqu3Ppv16CVJC809kz6ZWL527SkQ/y6qwVUQHM3kdSI9xtGOnIb7XF5mGkSYF2rB6100WUupnwWh6Ge5x2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669430; c=relaxed/simple;
	bh=Syy6W0ndoDPxs2+FZ+T16Mk4+Rz1HfM+/3Ct2dllYwY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=k1n067siik7Kr9GZBbpJq2co/vT0+AFPDI8axFRCHUdGn1Hs2HiEqq24Rjg9vLrJW0GpRM8J2a/NH5G5bz9nt9o4pbHA3klQWEa0I727z9N/9LiMd4obiQYWaxz9fLr7n9utUXIRWCuLE4Xazsl2Yoe77htK0fDaMOBhCuMHx6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NQbz+CBA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C5mtn3014906;
	Sun, 12 Jan 2025 08:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eR2CcfwKjGqCBuOA/4djstG5tfAz18dpULywknSPuk8=; b=NQbz+CBAFOOLRWKV
	4GybfjhZ5MBl6iURKF5PCFbHbsc90DUXH3UnRD2q3aYjh2ZSo2qyF5iG6APRdWuK
	C6m2V+DewXPwQYW+fOhFeAqYLIbPiFTYQKKhnFjX5QFNHlZRcHqiXbTBx5DsjWKj
	dm+3Fi16Ic+CBkJpsXGNO86cmNXcxW67r6b0J5vPKjxqoIoCJuATnaMIgQjVbFsr
	08gqtY5ywppncyc6ggX6a++e3g0iXODH5o/Z25PmCsxlm4MmFTEKZBNyWAQ9/wy5
	rWZZFJAnl3IsWNbGy+SqOr/5cYQEEDgUrvuvMp3LCDzOhtXkmzxc0+wDY1KUYT/0
	sr0dnQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hhq9rj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 08:10:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C8AMjm026019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 08:10:22 GMT
Received: from [10.50.34.183] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 12 Jan
 2025 00:10:20 -0800
Message-ID: <452ed804-bb69-4b75-b571-0ee00ac7dd30@quicinc.com>
Date: Sun, 12 Jan 2025 13:40:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sarika Sharma <quic_sarishar@quicinc.com>
Subject: Re: [PATCH RFC 3/7] wifi: cfg80211: extend statistics for link level
 in sinfo
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
 <20250110042449.1158789-4-quic_sarishar@quicinc.com>
 <ac4560bbaa2d90f0c931bff6074642ea0df1cd71.camel@sipsolutions.net>
Content-Language: en-US
In-Reply-To: <ac4560bbaa2d90f0c931bff6074642ea0df1cd71.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wi5QrBosRC_oBrs0svI8XYIU-dHDcF3j
X-Proofpoint-ORIG-GUID: Wi5QrBosRC_oBrs0svI8XYIU-dHDcF3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=524 clxscore=1015 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501120070

On 1/10/2025 2:50 PM, Johannes Berg wrote:
> On Fri, 2025-01-10 at 09:54 +0530, Sarika Sharma wrote:
>>
>> -int ieee80211_ave_rssi(struct ieee80211_vif *vif);
>> +int ieee80211_ave_rssi(struct ieee80211_vif *vif, int link_id);
>>
> 
> You really should get these kinds of things out of the way before the
> real patches.

Sure, will add these type of changes as a separate patch at the starting 
of this series.

> 
> johannes


