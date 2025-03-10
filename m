Return-Path: <linux-wireless+bounces-20100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 853F5A58B3C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 05:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D90A188A4D3
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 04:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78371BBBFD;
	Mon, 10 Mar 2025 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ha1RRw0F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CFD18DB24
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 04:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741581664; cv=none; b=S9EHaz516nyZAZIZGcSvAD9mHD2Y5Tl2GtvYg/iPXDc9fLkGqkQ7gEkvrlifdbatq6E8uYS+Mixgl8SpFVU9NtPqYyPRNSab9+eiWjsdc6YwdO3SfTUnI7jZ8o7fUqGTQRz53vslW8F2933X1ShTD9BD8j/TwIK/N1NBzGZMU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741581664; c=relaxed/simple;
	bh=atSUECywcur9e/3ND0qEP5EUxpf5Iqx4e7C9vMKuyb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PANOkzxDclapT4PUGVPfwknZ5uImuyjcs6LFLITM6g9aHu7xVNKXAbivdgd1NKUVbwbyXbJ8+TvftdH0I6xPRBUmyJW3mFu1i1jeadX8WjPlft0H7S72k7FbKRO0FKLILcupcnptRN8+Bnb0GzYAaRf8nPszCrLbrZNhTmB0Sgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ha1RRw0F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A0O6Ks029833;
	Mon, 10 Mar 2025 04:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	68dM0U+BDXb86CYy890JbNHHO/fp0JE5XhZmrxvlrCo=; b=Ha1RRw0Fe8mZOs61
	4pvJEg7hsSwKqZZZw8pSGT4uOZV0jbOWYj8VexkdWFXSQINGiT/EVYq4U24qdjLa
	+4AA+SMKwEfyT1hetfhpxtzXy/XUyVKcsmqpR99rhk54nt9/eYsSuBgBKHIqUnZI
	wAPrtFqXgvFb7GLNQjmGWEpsjuFaLiZbAXkkDJr13JcsGrHAe/KpOV6e1TVO/TDZ
	WK8GS87v+6LQvbH8JnIeOUwpHiBoe0MedZcU+Aw+EIifrBuiQ2w3IXB1ZVxo0RBG
	jM7uF1l06PPy2NjI8aTA8fzcDOUfdJMHV3zLdUjjk21C1y/EPBJhmaEyUNAvPgzE
	KxiDaQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eypbf3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 04:40:52 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52A4eqF5010866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 04:40:52 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 9 Mar 2025
 21:40:51 -0700
Message-ID: <cd46e11b-be40-4e4e-841c-cfbbed7c3b95@quicinc.com>
Date: Mon, 10 Mar 2025 10:10:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] wifi: mac80211: add support towards MLO handling
 of station statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
 <20250213171632.1646538-4-quic_sarishar@quicinc.com>
 <38d1d5f8be439e8553cddd2df03bf3553bafb82f.camel@sipsolutions.net>
 <c3c5fc43-9140-4793-9e61-279b7176150d@quicinc.com>
 <5fc1136a-811c-4d1f-8d8c-8cc27b697c01@quicinc.com>
 <0e95c126b5f273ae437c218f825f7761a5edc395.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <0e95c126b5f273ae437c218f825f7761a5edc395.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=A9yWP7WG c=1 sm=1 tr=0 ts=67ce6d54 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=jbFLbsRNUd9gKL7XDsEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uy-n45HQCIIIdroBUT59eiJGvbILVykQ
X-Proofpoint-GUID: uy-n45HQCIIIdroBUT59eiJGvbILVykQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=720
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100034

On 3/6/2025 5:36 PM, Johannes Berg wrote:
> On Mon, 2025-03-03 at 21:38 +0530, Sarika Sharma wrote:
>>
>> I checked, looks like link_sta_dereference_protected() uses
>> ieee80211_sta structure and here sta_info structure is used.
> 
> Oh.
> 
>> Can we declare one more macro related to sta_info structure here or let
>> use rcu_dereference_protected() itself?
>>
> 
> Not sure it's worth adding one, but you can use e.g. sdata_derefrence()
> or something like that, so you don't need to spell out *everything*

Sure, let me check and add.


