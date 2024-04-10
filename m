Return-Path: <linux-wireless+bounces-6080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D07889EE2E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 11:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F1DDB23459
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 09:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA012154C15;
	Wed, 10 Apr 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pPF2s6il"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F0719BA6
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740120; cv=none; b=Zg0y8nSpFq/x2YuA7aW1uZBeCSXm9S2ujb0eOCNw73NRol1mhJoh5Ne3tRbWldVd1tiRM4Y6YTtXC0UO4+q/fvT1y0tDab1hxLek8tiOi0SgQT+2xhP2kYdrkAEegQXlbzUkKl8J0/qFaBjdP2Ke0VgZy/TKXPIlIVbWSW5H7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740120; c=relaxed/simple;
	bh=dSKpmpsQxG+C4iGS6EL6LwbhTLM4G21OLrV4F+2TGKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AaJdaLuDxlK96vCj+3iOznfFJgHEBdUcTOXmxKFcV+49KmFYCXgOJdnpjv6clfc0jNZ1+pw4s3jKHBRTgcK/AXQ32ywoettrC5mT9CdJDtiXZuCJP57YNfvxMQ5aRE+qJ2dE9C0rrI78mPkG5GyNaR3MKfv+7CwgHSmzeqYzCBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pPF2s6il; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A7bS6d005668;
	Wed, 10 Apr 2024 09:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=69XpRfCxp0+5Q/zhx5TDPs7ME9TL7fE+00ukrSeOfpg=; b=pP
	F2s6ilDMCs2gNvC8vcPVgd2p7qxrSJ5y1ukwK6OgZxWoslSFYEzRDsajhOz2Tw9z
	UkPWYPtUiRHWOnzmkGdCwPC1hS8o68e3KdZdkC3ECFLRmSZW9klsdFxq5V4/9IsL
	bdK8b6eeDtqz/w/MI8s3fLLAuxnlakG82q70RR5q0zMUGPZtab9mt+I6k5GRsljq
	u2Qb35wDZsRZWNnHOio/NJtav2qhMhDgb7i8xQppFro2UgMzxPZHoHHEp7ih7PeA
	F59yt29ddxDqw1I2hmaA0mR5AaretW8MAi4WlxGII/Etb7guAGcClieYe8oG8HHv
	7wUQtc63JqjLqhyXlwtg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdpharfya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 09:08:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43A98UCs005523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 09:08:30 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 02:08:27 -0700
Message-ID: <d2e6360b-1092-4e57-47e6-c5f336f32c92@quicinc.com>
Date: Wed, 10 Apr 2024 14:38:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: diEgu_66qCdiLZoIpjt4XWGbI8Qep39I
X-Proofpoint-ORIG-GUID: diEgu_66qCdiLZoIpjt4XWGbI8Qep39I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_03,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=579 mlxscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100065



On 3/28/2024 1:16 PM, Johannes Berg wrote:
> That's a big set, not sure I can review it all at once :)
> 

I plan to separate the code refactoring changes from this patchset. Do 
you have any concerns?

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

