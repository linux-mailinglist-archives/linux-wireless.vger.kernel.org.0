Return-Path: <linux-wireless+bounces-5620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F415892367
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 19:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DB61F23106
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09837290E;
	Fri, 29 Mar 2024 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VD8Srjjb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08F2DF7D
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737280; cv=none; b=K7KVvmL2QcGnohAmLEP25c8TKjH7a4Hqagv3wMwdARh20rI3c5AKt3i/qzTQ+lICeHR8JXkRX9c/CQ7lcImxd1pZnjVJFX6W6BAEq/JIK+d8Xu7HmddQDYZAA5YZXWAys4sO5iExl+UisA3eoksMDpn1q/0/EyVt/tH3qjhZYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737280; c=relaxed/simple;
	bh=XowHppYX0hmNQoC8G3Dxu2CGrAOICY3XaiXrT4Po04w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mAS9o+EUCT0aiJyabo5MtMalWFk0yqCiVHf5xCgr9I0+lqDHP4g6+gl4Mg9JjpmiUahjrOrfb8bRa/APJdvkfMaZD5ssIaQEIqqNGe8w2Yi1w8NjnDIZ7dBzXNBrbHchhACQ4ZW5npQ7n0onGW6SMAfJGU2aBVpUTwXWNJAjdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VD8Srjjb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THfIpL011115;
	Fri, 29 Mar 2024 18:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FaVReTnlcxohtbMgcWaNCsncdtZON36tWnhAcerdk4Q=; b=VD
	8Srjjb0/hNVUtPiHFGfhyNIlka0NUHVOfI/YaXL/vqqpO6V7xPwdekcWUjJE0TEr
	P4iAcHL6OLU/wft+z8YjGvSUnnfS8pUe8dFlWaJLPVoSdjMkqDCEBaaXa9aGWSwR
	QV5Os3wWGmVSjaMHWbsa8mn56MEaA8XNKvbDr4Y6UeJWcXn9RImx+0U17UdMcFj/
	i83PvSTU/dctyv7m/UWUTxiT37cM7Qv69Dageea7tKBzooYnoXBEK885oJOVYy3U
	ujm41DbhXinUZJf4/eCJX4cYC0fRSqYLQxGwCpYBScl0NqkzdtjoiWdoxXMeoMOe
	Atc+WmWtdDRIWLhpeR5A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5sm6hh7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:34:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TIYYSL020272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:34:34 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 11:34:34 -0700
Message-ID: <b39413ca-ea59-4733-9a68-f26039d3a94b@quicinc.com>
Date: Fri, 29 Mar 2024 11:34:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] wifi: cfg80211/mac80211: Introduce nl80211 commands to
 support MLD link removal offload
Content-Language: en-US
To: Manish Dharanenthiran <quic_mdharane@quicinc.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
References: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
 <20240328055235.3034174-2-quic_mdharane@quicinc.com>
 <ab738886-f7e3-43ab-8615-2164e8414786@quicinc.com>
 <1ff49b19-e2e3-4415-b9e1-f9c1f793f89c@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <1ff49b19-e2e3-4415-b9e1-f9c1f793f89c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CGOQSDX2cwQ9reIiTdgYoa6flgiu72SY
X-Proofpoint-GUID: CGOQSDX2cwQ9reIiTdgYoa6flgiu72SY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=955 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290164

On 3/29/2024 10:16 AM, Manish Dharanenthiran wrote:
> On 3/29/2024 2:32 AM, Jeff Johnson wrote:
>> kernel-doc warns:
>>
>> include/net/cfg80211.h:9573: warning: Function parameter or struct member 'action' not described in 'cfg80211_update_link_reconfig_remove_status'
>> include/net/cfg80211.h:9573: warning: Excess function parameter 'status' description in 'cfg80211_update_link_reconfig_remove_status'
[...]
> Is there any way to run this locally similar to checkpatch? so that we 
> will make sure check this as well before sending to community in 
> upcoming patches.

I use:
files=$(git diff --name-only $base HEAD)
scripts/kernel-doc -Wall -Werror -none $files


