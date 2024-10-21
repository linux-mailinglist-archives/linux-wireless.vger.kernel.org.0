Return-Path: <linux-wireless+bounces-14254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A44A29A5FDA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 11:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FB71C21403
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8A71E2824;
	Mon, 21 Oct 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZAk9A6QD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B7F1E25FE
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502452; cv=none; b=b7RUOs9gDffS0CJZBpYQ8s6nNYonSPFm+HmsMWqXC8ERCpXapyQNjD8gnE8lG5SwWZWlSwyGCsei6xNOQBrfVe7jejlDBBG1dnsNRmfOCJcPwqVdP6+ssclS22DdMMrLdsdQmkvgti7lCR68JdpghEptdmPWV6HIznPfBxJM5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502452; c=relaxed/simple;
	bh=h2uOu/k1ANMKB9uYGHgae7H9L1FOcm5wfYcmSy8sBls=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q+dDk1VRtVyKjZQOISCVD7nFZtckVHFVQRN903j5JU/vX95xzgd6ZhC8kx23dWQJsMXOf3z5kib8f5YH+8UOPs7bDdNSOxo7RFwKnRZAcdEzNvRp8r1S95CVoQP2V0sEdAP7giQHvuDR9g4TBH+3icJmM2ue0c0Ji9MaLG4yp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZAk9A6QD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L8Vr3t014410;
	Mon, 21 Oct 2024 09:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mk+SxayGyeYDS5Wl2XojgirHH/IjbtuVxMSJDdqxZiU=; b=ZAk9A6QDM7hAFiyI
	QqfKpsWpA4uOCKVakDlKpiwGU/oV2aDyLt7vnkj+9/wZj4fiipITDE8rUOxafo2V
	YQAoSZ4n2gHn9OLElg9A0NJsTu5Q+xSuEeUcTVll+HO2TNKY7DNmwwI1b9bjIR0f
	EKinCH1lPSkhYA9kCLYUstXXFBm7d9h4RfytzWlPBhErDRSyonB6TLR/wF0NX44f
	nooa++m6LFR5Ywlt0VkQIfV6Nz1h06alV1olseoA7psZjz4Fmuz1h6Ao4XCqZzRV
	yRA4IT6h5okF8OuaqjOxX6qheJ6MKSNkgsNjdeGD3EGcptHjnMXAzj6K3TFEDozd
	Y0UrGg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkhd078f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 09:20:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49L9Kgx8009094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 09:20:42 GMT
Received: from [10.253.15.238] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 02:20:40 -0700
Message-ID: <6838befe-4305-47f7-a4f3-0f34864f0031@quicinc.com>
Date: Mon, 21 Oct 2024 17:20:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] wifi: ath12k: delete mon reap timer
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
 <20241016065700.1090-12-quic_kangyang@quicinc.com>
 <87wmi1q1tv.fsf@kernel.org>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <87wmi1q1tv.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jzD7HXGyCenab1DB0Qa0rIBBWcejrbml
X-Proofpoint-GUID: jzD7HXGyCenab1DB0Qa0rIBBWcejrbml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=788
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410210067



On 10/21/2024 4:47 PM, Kalle Valo wrote:
> Kang Yang <quic_kangyang@quicinc.com> writes:
> 
>> Currently mon reap timer is not used, and it is not needed anymore.
>>
>> So remove related code.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> 
> Same question, does it fix a known issue or is just cleanup? Always
> answer to the question 'why?'.

It is a clean up. Ath11k uses mon reap timer to implement rx pktlog. But 
ath12k doesn't support it yet. If we want to support, reuse the 
interrupt of monitor status ring is better. Because:
1. monitor mode also need the configuration of monitor status ring.
2. the rx pktlog is highly dependent on the implementation of monitor mode.

> 


