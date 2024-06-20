Return-Path: <linux-wireless+bounces-9315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9175910DCA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA721F21D25
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5F61B011C;
	Thu, 20 Jun 2024 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YOj4viEa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E31AF6B5
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902665; cv=none; b=MElWxm/x1dFYM4UzTyT8Fre63IgQ6t6Jz6FNHsVYrurX8gzqS8YFeOHBFVGAnIyYKpZ6sFvuH2rO9+uZwXE0auuO9mb8Dj0Un5xxw/+oWvNxC0tIbu0awJ7j3VfCf8hqrnBA7/kM/HS7SADwLc/cXsNHBtG1QKbeZ89mLvB+gg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902665; c=relaxed/simple;
	bh=EMkN0KZm2AT1CMh88MFwtPtniI6rOk+/UWavPCBJFHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MZW9jHRBO0HCDzQnJGlVvlevUh3D+vXanVWumf+AQneUZWBNZz9bwMC74dfoJkVmqrUQNmgm+oKW7g+lHqUUxgBAZJFIQdHg32JgHPWSrHqULtAXQdH1dE35W9WPiWROebu6isYAlsc+zgD3E3JIGCnud6A4rcmdWKc0vQVEVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YOj4viEa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KDlwOG024058;
	Thu, 20 Jun 2024 16:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jOnIOyMbv9+Xav1Yh+aebdf37DE/bK2YV1q6ZQixIMA=; b=YOj4viEaqvDDqd1M
	SuP46QGYiKEl2Mx5nc1xlJBLM1rXGYr0tanuQSzbkm6YEzr+032QNhJDfhM6jbQh
	zcrJXlALNfC/ixz39fUCdmodXKe30VnT/jFoT5JEBZzlZ67DxSRgVTZouTK0gq83
	ufBMh2n6CQJQx/3/0343C6D+vOzEw5jB3GpK1rUQ4XrrPP+l9FHWFX2vc6S+IdPU
	l/IJ3ubfk1VgQmWIkP6tZMJpZH/dOhNqOwDJHnJQScLkk7MsTswRtypw79/QpwFN
	diDnJx4IkpCHPOowBMt5crn4Pa8O0/OcwNAuLn8AHDn+hAshS7XlEviNt5uIYO0a
	/ANfgA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvnmh8fws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:57:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KGveAV011891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:57:40 GMT
Received: from [10.216.57.43] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 09:57:38 -0700
Message-ID: <d3cbc5b0-5003-49a9-817a-e5a37c274fcb@quicinc.com>
Date: Thu, 20 Jun 2024 22:27:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] wifi: ath12k: prepare sta data structure for MLO
 handling
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20240617131650.3288118-1-quic_ramess@quicinc.com>
 <20240617131650.3288118-4-quic_ramess@quicinc.com>
 <29fcda42-8d83-40e4-856a-d98e56981091@quicinc.com>
Content-Language: en-US
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <29fcda42-8d83-40e4-856a-d98e56981091@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dxJbAhmYgrl_Br0p0AcrL7Y7CTvSJ8FS
X-Proofpoint-GUID: dxJbAhmYgrl_Br0p0AcrL7Y7CTvSJ8FS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxlogscore=832
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200122



On 6/18/2024 3:49 PM, Baochen Qiang wrote:
> 
> 
> On 6/17/2024 9:16 PM, Rameshkumar Sundaram wrote:
>> +static inline struct ieee80211_sta *ath12k_sta_to_sta(struct ath12k_sta *ahsta)
>> +{
>> +	return container_of((void *)ahsta, struct ieee80211_sta, drv_priv);
>> +}
>> +
> better naming as ath12k_ahsta_to_sta()?

Sure, will change as suggested.

