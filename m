Return-Path: <linux-wireless+bounces-19789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60298A4F34A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 02:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189E67A25A9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F47136988;
	Wed,  5 Mar 2025 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d5Ua+zCb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224EF513
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137095; cv=none; b=uXkMQ5wfXRSHT6yPaR8ERLmNVNelOGcM93OgcO35k50MT9Gqq27m57579q6Jtxexz8ljfrNML+BjxrBENOBdV3N5Vn3CKtCT/F+wFIW0cWjKIC2e3Tt2hs5cbogbFUrsV8DprkoL28SHSDj5vPJQEsdXswaOUxtZ0hsFFlG5aBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137095; c=relaxed/simple;
	bh=CtUQxbfalC6D+BKZF+LsVxHgqmn75Y4BdEjp5PM88fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A5pDE0K+IiPwJpGdBsWw1YyEUsKvS789VtKzM05VzXLzWzPo5ld8QpbY7l09zg5f1EvpNlYR/H6i7gTxP+QUyPH6xNRmWDnVI8myUOGQah6Q0HR7j1pET815NoriCnpkBEqNBQdq8Cr+8kw/6st0WEh3qypj8AsNnrkmXSH1M3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d5Ua+zCb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524NAQLm014538;
	Wed, 5 Mar 2025 01:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vWIsGuTLIh3N0YMwR9Z7DAC3ZaFXnY+Ypv6rDdVhb8A=; b=d5Ua+zCblNoc/VZW
	InL+BJJGfI5hSxCnwcdgQYR6cde6e/0eHtjujvFJ38QZSgMD0OpMfb+qraOXZRSD
	IAgqhscM33Oy8/1FNhPdrfuqLj02fM34OZLFor8dQnL2kTLUUjlhi070KODSB+tJ
	yj9DaSlUzEVFT9UBl+ImexNY8HYtRxyZcFejO4zb7lNxK6rkrUwSuiDh5bohtQmW
	ElaYY3VvL4JXjPb/SsPdbw4fJdyg8LOXBZLhAMxoMwVdYsCnFHM1eelvb3WFEptt
	CfK8moG2Fe7jCFdS0OZSNhtFhwFBDNTbXJbgHJ6sZ+jaxEVYbGn7p03cF6KIlwks
	UVZE/g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6vkqt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 01:11:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5251BNgC020312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 01:11:23 GMT
Received: from [10.216.53.74] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Mar 2025
 17:11:21 -0800
Message-ID: <a71f6f08-d123-d172-1b99-edf4c63ce642@quicinc.com>
Date: Wed, 5 Mar 2025 06:41:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v8 7/9] wifi: ath12k: fix NULL access in assign channel
 context handler
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250222151926.379652-1-quic_periyasa@quicinc.com>
 <20250222151926.379652-8-quic_periyasa@quicinc.com>
 <6eed9dae-7f4d-4757-9d49-b21aff8e802d@oss.qualcomm.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <6eed9dae-7f4d-4757-9d49-b21aff8e802d@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M9N6Y_-i1BV_IkniuYbLgjdnI7oVQrtZ
X-Authority-Analysis: v=2.4 cv=LYfG6ifi c=1 sm=1 tr=0 ts=67c7a4bc cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=3-wCbd5yTIyj0ScaWrAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: M9N6Y_-i1BV_IkniuYbLgjdnI7oVQrtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_01,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=869 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050007



On 3/4/2025 11:06 PM, Jeff Johnson wrote:
> On 2/22/2025 7:19 AM, Karthikeyan Periyasamy wrote:
>> Currently, when ath12k_mac_assign_vif_to_vdev() fails, the radio handle
>> (ar) gets accessed fom the link VIF handle (arvif) for debug logging, This
> 
> WARNING:TYPO_SPELLING: 'fom' may be misspelled - perhaps 'from'?
> 

Yes, my bad. Correct word is 'from'.

>> is incorrect. In the fail scenario, radio handle is NULL. Fix the NULL
>> access, avoid radio handle access by moving to the hardware debug logging
>> helper function (ath12k_hw_warn).

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

