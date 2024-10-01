Return-Path: <linux-wireless+bounces-13356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6798B565
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 09:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C362328126C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC131BD512;
	Tue,  1 Oct 2024 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n7TJznjG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A06E1BD4EB
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767249; cv=none; b=izSxytlynm3/QTu3GWtAvEKtEXuBTlp1h4KhUXN0ffigEBRHSgCr3AS1le04iwSwQEFfngvX7met5ueoJconl+9URYBwVPRm/gGjTEKf5vklRWaM9n8uv8qtFG9E8Gd8VBYdxoTfkygApzVxJWeH1Frc45CBjewDlAZWscCgL3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767249; c=relaxed/simple;
	bh=gNRPDATDLAYZSP41QJUsRMue5gE2mwV5I/h5tH9K2uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VO7W0ya2eO5W8XBZtMppDf0O4d8FdiigkKAWLeYJFWoapdKAmvPd8wB+OZYDeMHlM4WzLH7ZtJLoNxabunQMG4b8ORvfrW3C8ZGdk4fI6EVTWPzhYgMUqGaFdTQBf/JW2Xke4QqsJEp8K4025VknsRwozcWDpeHn2KP9M71EfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n7TJznjG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UMKbV8032662;
	Tue, 1 Oct 2024 07:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a+FiTzvYg/TRqYbWIoQ6cFsUX+Om6brwEohQgKsokvo=; b=n7TJznjGE3AD/cCb
	xz3RK1lZNEMl8RL6qTQEyLVNZ1maSF54JoCS55DQ9VxL2sKJkOeuRbDtuHAMtl6/
	XKmFLEI7QT+S341y1Ynyt4JlwXu7FdpUCiM8qcG/wj//1qLMcba+FyaHQkHn7FrJ
	tUBqU3AVg6sl+mHVHBbjMa+dQxSTWZMZSQqPkzz2AsEprOM+3yu45+sqsrWdhtsN
	5wyvnj78GA5Jn6Cj6qhO7d3TyW44/LA931WKFDcE5lMk545v5pGjEstPQ2oEC6Sx
	tTEMYUZhEgo+9FUZcW/u9wWfHZSCvlX25LaYV/nso+g8Xo5TC+aYl1jErOgabFx3
	JWScKg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xaymf9xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 07:20:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4917Kf3R007555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 07:20:41 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Oct 2024
 00:20:39 -0700
Message-ID: <5baec254-9fe9-4923-ba38-c43bb9300508@quicinc.com>
Date: Tue, 1 Oct 2024 12:50:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: fix assigning channel in activate links
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20241001041518.2236297-1-quic_adisi@quicinc.com>
 <06708838017266efd2351f0bda1bf01b0ee2bef9.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <06708838017266efd2351f0bda1bf01b0ee2bef9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FZQPy0IjqeBHkBPXuqylvPXDAEDfSNum
X-Proofpoint-GUID: FZQPy0IjqeBHkBPXuqylvPXDAEDfSNum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxlogscore=800
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010049

On 10/1/24 12:02, Johannes Berg wrote:
> On Tue, 2024-10-01 at 09:45 +0530, Aditya Kumar Singh wrote:
>> The current flow in _ieee80211_set_active_links() does not align with the
>> operational requirements of drivers that groups multiple hardware
>> under a single wiphy.
> 
> Btw, given that, I'd argue it's not really "fix ..." right now, since
> there's no such driver and no real bug? Dunno. But "fix" makes it sound
> like there's a bugfix, and it isn't now, it's just preparing for future
> ath12k compatibility.
> 

I see your point. Sure will rephrase the message and will not use 'fix' 
word in next version.

-- 
Aditya


