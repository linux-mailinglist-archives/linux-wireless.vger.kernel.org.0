Return-Path: <linux-wireless+bounces-21946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6B6A99F82
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 05:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2460A446469
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 03:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC5942A82;
	Thu, 24 Apr 2025 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ifHpDMo4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F099460
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745464997; cv=none; b=kO7hzl0qUojwZQVZ3O7SNhtk5hbMYQu9Xe1V1iAkSFygxzfPjzSCMGRZrmezVktBSq8YPLths5zRqL+slZm49v7zEMWJO5uEsO5OVk20X4W6YakNppzEDu/3sNqXh0reUbRWEebhz+wfmU0QkJHzpdKSjY5ZZ+k729t+7qH0SC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745464997; c=relaxed/simple;
	bh=THJ0quqjIe8vkIWqtlYez3WDfEgZhllRKx2xIaavTPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NStqDEv4l+4T5M2tcEoax703zdqEwiZf0PJpl1PLhQ0N/TKqS5HwFes0N6jQQjR5R40+gYt5eBu3Ukbsa3LySmp3gjhdqDFcLAafSJukeEuH0i+OueAtrOeDwAONsFFED0vWlXsd3vuKgOzP/QXqViL8BBG1tvYcLWm0RtdsH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ifHpDMo4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0F7J1003412;
	Thu, 24 Apr 2025 03:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VlW5JnVB4wM1atEUvMP3nNXsK7m7hYLZihhoVGrulvk=; b=ifHpDMo42nkSi/+d
	unWY0MwzJT8HbAEtXzYV0gqPM23/jzEbPDnzMVzanIJLPky1D0ovS1lR7mq24OMf
	5ID/BSr0YFkEzNy2NdO6M+M+1/rUJk0VkLvGdfwxGPWE98GjpeklqUQedCHVd1Jv
	zyjDRyZsdpGiXXHpwaUQFMYnkbN9zesqbF42q+cwcfXxtcoVefQEizF6ER6WJ1yy
	wzcv1IYX2C08qEdiwsd3VWsVhDYuryL/TKIS6BE3qBELbHAjyF5R1qRU37A0/Ey0
	GwYECh7Ef8RzZ7ZEKIKRFo97jBqkJjXTFknthSG8glAS2IXyD3XKMItB427G7PIF
	0L45Vw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0m1yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 03:23:10 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O3N9pl014717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 03:23:09 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Apr
 2025 20:23:08 -0700
Message-ID: <4f020a0d-a068-4aab-ab1c-2c9c045fda50@quicinc.com>
Date: Thu, 24 Apr 2025 08:53:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 03/11] wifi: cfg80211: refactoring
 nl80211_set_station() for link attributes towards MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <20250415042030.1246187-4-quic_sarishar@quicinc.com>
 <4e3289a9f15789c93e47ac469ccd910fe77765e4.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <4e3289a9f15789c93e47ac469ccd910fe77765e4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9xejmECxGU1IZtPbBnpRWFhTWI5pnREf
X-Authority-Analysis: v=2.4 cv=ftfcZE4f c=1 sm=1 tr=0 ts=6809ae9e cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=WgfDEpF-0SlxUTPTT0EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9xejmECxGU1IZtPbBnpRWFhTWI5pnREf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAxOCBTYWx0ZWRfX32Tk86zEpCCf 90uZxKft/Nk1Sw3eApq8H03zzEl8JdhY5kAfBlGjs2Ht76ElDpp2Q/oCxHfDvTWkj4gPSYAHlYb YoPrVWhmpiHvQ+silyOT/claf2+YJ0f8ejCzQCJYuakdtplxAzlBODPTxN35XkpL6Re5fP9Zfn2
 GsgFl0gl1dOMXnMTjIL/JpsGoNnOPktsuD3ebZx5kb5v3/MuMnwZM5Y6AG1tWqnxZxrhZoiN1GS 44yaIDql/2K8S7lOKRqDRAMn2FpDmZLHUHRyJ2Z7VUiRTYNdjhnaRkhGkqm4/QnTziA75Kr/DXO mtflCVn2lvcwyFnlIns6n+ncBTd2e6XK0kz9i9a1QWo30kKM+ibBpibL0RJgVGo9SBjY0dH9uK+
 XY4gt5/3+Uffdyzqfs4ok9hilWOUTesA4oGCeFumnI3EeGCxLtItLRwiEgmfYuRp37pcFXUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=664 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240018

On 4/23/2025 10:07 PM, Johannes Berg wrote:
> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>> Refactor nl80211_send_station() to fill link level NL attributes for
> 
> nit: subject should also say "refactor"
> 
> (also previous patch)
> 
> johannes

Sure, will use refactor in subject.

