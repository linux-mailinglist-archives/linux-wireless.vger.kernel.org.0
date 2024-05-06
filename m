Return-Path: <linux-wireless+bounces-7219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F88BD38D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197EA28355F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 17:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDEB157462;
	Mon,  6 May 2024 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e9Im+YVv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E45156F38
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014902; cv=none; b=X0G20vBCQGzgk/M6TXKU1kJYSb+bVKbKcDWx2BQsq5ezhZdQo9mkq/hV1G6GXnjTJqzZslIaU4lIuJLxjKKdJa3q72cA7NpVpMOwaig+/GJqu9GmpDO+C5LrK2sES46pfj59aUu+q6/20n/vxkn0WhISoQjUPbnUDRjZzL9XBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014902; c=relaxed/simple;
	bh=G7b0cld3PAaGgsrWRTbS2qi1APtRv2ZiVjHPBABZmyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eioi7V03ALDYT9Ohy67dZ+jcqEjl1kIoTgFcgYjSR5LIhCga7bHpNTRb70VEJuWDh7DYbzZ8BoXKzCw4fnsppubpwxeQ12hOZD540sYR7mShEaLjvViKmhyKM1WT68RGE/FkbG44n37ltiQ9JYeKEspsRiBDg/g/MwsMHgoQXi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e9Im+YVv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446DTB1n019577;
	Mon, 6 May 2024 17:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XHaBGGpLA6E2k8kzy+ANwzlVGVBSy9fteawDOaOtIcQ=; b=e9
	Im+YVv+gcIiYGwEZ/qHEDfF5e28z0Q649Flnhx4bt7Nk0tGnYsEO4cO5UeAa4s2L
	UHNRAQjSO0eCt65tse1PgKeDT1e7tmyQ5CwfJN62pVcDqs+oiIGEDComrz/ZI5TZ
	K6lokPWOcD8C8b5gZmYPVKU9Yuz/CckCwwCA4cOwc8DQQGN1dxFab2bNlBhQ9uvH
	0y7nejOmNKQM+/xHs8ydmiS90QcjafZhgROjl/ShSaamyhafIpjcUxPQjKbRer1u
	U2jD8+j941dKMplZnJ3Ko6dbYW+cjB37kovzQ6y0UEib8VcHntKEC6lzTl5c0fHn
	gZeigZUYfJeDPkQ1jgKQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxxj1gp7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 17:01:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 446H1UBH022986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 17:01:30 GMT
Received: from [10.216.38.76] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 May 2024
 10:01:28 -0700
Message-ID: <01e690ab-6b41-f976-1e83-d3840ef5ff7c@quicinc.com>
Date: Mon, 6 May 2024 22:31:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] cfg80211: Allow pre-CAC for self-managed wiphy
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240429042723.2847389-1-quic_hprem@quicinc.com>
 <21cd883ea7d3a7735bbba2c85f5d9e5d5803b5d6.camel@sipsolutions.net>
From: Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <21cd883ea7d3a7735bbba2c85f5d9e5d5803b5d6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ItnLHKfqgTyTfDdl7QCj2gXH_MVBNtOk
X-Proofpoint-ORIG-GUID: ItnLHKfqgTyTfDdl7QCj2gXH_MVBNtOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_11,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=809
 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060120



On 5/3/2024 1:56 PM, Johannes Berg wrote:
> On Mon, 2024-04-29 at 09:57 +0530, Harshitha Prem wrote:
>> Currently, to allow pre-CAC it requires both driver's regulatory domain
>> in wiphy and cfg80211 local regulatory domain to be same, along with the
>> region to be in ETSI.
> 
> Any idea why that is?
> 
>> But, for self-managed driver, some countries have mismatch between these
>> two regulatory domains and it would not allow for a pre-CAC. For example,
>> in ath12k driver (self-managed), country Sri Lanka (LK) is classified as
>> FCC domain as per cfg80211 local regulatory database but as per ath12k
>> driver it falls under ETSI domain then because of this mismatch, the
>> driver might not be able to do a pre-CAC.
>>
>> Hence, add changes to allow pre-CAC based on wiphy's regulatory setting
>> if it is a self-managed wiphy.
> 
> I don't see how that's really all that much more helpful than simply
> removing the restriction? But then why is the restriction there?
> 
> johannes

Hi Johannes,

Seems like, there can be a possibility to have two wiphy devices with 
two different regulatory domains to be present on a single system and 
for cfg80211 to respect it. In this case, a core central regulatory 
domain will consist of the intersection between the two wiphy's 
regulatory domains. Because of this mostly, in case of DFS, in cfg80211 
apis like reg_get_dfs_region() , there is a check to ensure like if both 
the core central regulatory and device's regulatory are same.

Drivers which are not self managed can have this restriction, just to 
ensure to allow precac only if both matches or May be should we relax 
this restriction?  but I am quite not sure on the impact. Will try to 
analyze on this.

Thanks,
Harshitha.

