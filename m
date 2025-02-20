Return-Path: <linux-wireless+bounces-19156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6CCA3CFDC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 04:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66CB3BB18B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 03:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA101DDC3E;
	Thu, 20 Feb 2025 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BCc7CL5R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3375E1D6DC4
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020973; cv=none; b=CgGbjPaHs5jNZNsD9XbvipL1WYfe0K91SRa0wNzSNw9u1X/6Uu28SRe70NgsTwV/pSIiCUePMkybXtvRUyhIOVXcNjPJssbfBJzs0Xqt+A/upW4uPCl5b+Q8fZBR2qo/bxYwYLpRu8IE/KuOMHxRvMkH+hyyD+fTH2kMAmlbKm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020973; c=relaxed/simple;
	bh=fSFkICmJ6NbKnWIC4TwRecAqhx0jN9W8LnVXz9pDJ3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WOLRsrfRu46r//m/EFRXI+m7dM1Qtm8PQDEw8ioYyRYKCS1ho9eKGk0m4k2z4cenbJcOKn5iMyFHpGFamCVjOO+PvAwnd9CfH5htWeZ7jRksNs2HasrWzvbYOal43T+QM2afQUPx4uf6mIs7wiBB3i23uD6A109YJL9oDpSSnW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BCc7CL5R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JG6nCF026862;
	Thu, 20 Feb 2025 03:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MOXDuzaczed56I7RRNdp8299W+cYa4s2dYdnyMysfdw=; b=BCc7CL5RlZt98FsA
	0EXLcWJkcU4o4QA+PokwwnFltGZT0zsJ/BZOLBL7buVU2pEcywyrmCbQmqReBT3v
	0D4TzpDGYd15fWslcrw2MJD+SSmv8Fjeg/raP8isUWjRVq1GfMulXmmZtWDM5uBW
	lLIycxsJrZXt2Nj/oH2FLcGQBdIiRu0tciwv22Ji6AHW8Zpm5BSnOTKRFhz3+K9p
	41ma4mSTG/iOxCQK7Elel65EZXdaveqWRBlN3eLn2JTagHpSsWdFGJ1ZWzfd4YGM
	ArCMaFJJqKGE3EPOH3Gl1Ny5Pu6G1mVM8kyhRPu6k4kyHIJ7h0LEq51bKha9uklH
	pbltgg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy0mpep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 03:09:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K39QZV006485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 03:09:26 GMT
Received: from [10.133.33.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Feb
 2025 19:09:25 -0800
Message-ID: <70c3d63c-df03-4956-961e-c7a654568b0b@quicinc.com>
Date: Thu, 20 Feb 2025 11:09:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/4] wifi: ath12k: use correct WMI command to set
 country code for WCN7850
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250212063200.1631-1-quic_kangyang@quicinc.com>
 <20250212063200.1631-4-quic_kangyang@quicinc.com>
 <c7a422b9-55b9-3f03-a89b-6b5e82d8e3c5@quicinc.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <c7a422b9-55b9-3f03-a89b-6b5e82d8e3c5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g-Nx4B6uiK7IZLPhlihzZ6ZbTc51ZHCB
X-Proofpoint-ORIG-GUID: g-Nx4B6uiK7IZLPhlihzZ6ZbTc51ZHCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_11,2025-02-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=820 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200020



On 2/19/2025 12:35 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 2/12/2025 12:01 PM, Kang Yang wrote:
>> From: Wen Gong <quic_wgong@quicinc.com>
>>
>> When userspace try to set country code by NL80211_REGDOM_SET_BY_USER
>> hint(like iw reg set XX), it will pass new country code to ath12k.
>> Then ath12k will set this new country code to firmware by
>> WMI_SET_INIT_COUNTRY_CMDID. But for WCN7850, this WMI command won't
>> take effect.
>>
>> For AP based chips(QCN92xx), WMI_SET_INIT_COUNTRY_CMDID is the correct
>> command. However, for STATION based chips(WCN7850), it need to use
>> WMI_SET_CURRENT_COUNTRY_CMDID.
>>
>> Add flag current_cc_support in hardware parameters. It is used to
>> distinguish AP/STA platform. After that, the firmware will work
>> normal and the regulatory feature works well for WCN7850.
>>
> 
> Should this patch be the next in the series right after the patch
> (patch 1/4) that adds WMI command implementation for
> WMI_SET_CURRENT_COUNTRY_CMDID?

Indeed, will change it.

> 
> Vasanth


