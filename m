Return-Path: <linux-wireless+bounces-15288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97139C82E8
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 07:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D772284CDD
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C964813635B;
	Thu, 14 Nov 2024 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="otkxhRVc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E21E4B0
	for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731564341; cv=none; b=oIWRni6EXjyyMtBDcLAqkzB4Q6OivmdifeiieNWBB48UJg3pIGaSVw1HDomTbTS0NNFeZ1iClw/zkjPUsWTTh0OMcxpeB3u6B32pGXOfDD8geKNML5MV5eHNkud9SuVYboFhJ0A76il6fMStMw6NoPHNkNXv+Eo3886n44gACnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731564341; c=relaxed/simple;
	bh=Jw2ehHh4wEbx8h9VLScUEcBS0DwZNteYYfZLhbCaxZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mtRlm4DkywpIPQIgIs1g0AtRTC002RHtN+IpK9kMJoz1B1WSMiWK4dYRPkoRadZXadZtrOO4QeEGe8KeU1sTVMLe7KcVCRZdJCeUJrBMu3vKDWaU2B/h2Zh2NKYwqHwrDfWJjgxCJ7LiN+jNIY2L58d/9VaZocJJ8skzSOTisI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=otkxhRVc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADHxnkg027160;
	Thu, 14 Nov 2024 06:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lYN2T2uiL1rSa76+CT+P8a51e6Ph4ss/DFfXvR6dSUM=; b=otkxhRVcqenYQ3lD
	6z3R+7bMMowhRvX53Em+fgW2MrLbixV3V9GCs+u3myAdxI+IM8/Fs0FCYVU4dHaU
	XWfv6DGrr+EoYsqvz0+C1cBnr8BclEf3S82nvPjQWVWA1OoNAEPpqVNIGv+D6fJj
	dCqbe2CwUQWwrfijvrWiGkT+BH2EUbgEG4E2cimOjPWd7J3GcdW4gD05RM3p27i/
	83+2KtT/SHKT34A3ZeWTAiAfufAKD++WCn+1BxUOH3wkvJ42mZUq3tNPYhFc2Doj
	/TGFWyQ3CY0K0eqmGH/f2YWa60MGfG4aVgWSv1Mvh9fNmqDIydi/nXJ/zG2Oj3fU
	oDG61Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w10jshth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 06:05:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AE65VC3027388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 06:05:31 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 22:05:30 -0800
Message-ID: <7917a344-82aa-4ef8-9558-554743c5dd15@quicinc.com>
Date: Thu, 14 Nov 2024 14:05:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] wifi: ath11k: move some firmware stats related
 functions outside of debugfs
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241113015631.3105-1-quic_bqiang@quicinc.com>
 <20241113015631.3105-4-quic_bqiang@quicinc.com> <8734jv2xnd.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <8734jv2xnd.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mECpuCujJ7lJmX2aoXkyFcvtoo3GOKQZ
X-Proofpoint-GUID: mECpuCujJ7lJmX2aoXkyFcvtoo3GOKQZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=752
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140044



On 11/13/2024 7:14 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> Commit b488c766442f ("ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855")
>> and commit c3b39553fc77 ("ath11k: add signal report to mac80211 for QCA6390 and WCN6855")
>> call debugfs functions in mac ops. Those functions are no-ops if CONFIG_ATH11K_DEBUGFS is
>> not enabled, thus cause wrong status reported.
> 
> What do you mean exactly with wrong status reported?
ah, thanks for pointing that. actually no wrong values reported, since we are not even reporting anything in that case. will be accurate.

> 
> mac.c is quite large already, making it even bigger is something I would
> like to avoid.
then can you suggest any other place?

> 


