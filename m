Return-Path: <linux-wireless+bounces-22154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB665A9F715
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 19:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476B83ADFFE
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 17:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028FE25CC7C;
	Mon, 28 Apr 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OLRj/8Bd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F75813CA97
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860466; cv=none; b=KP7Ornb44CCQs+Y5pJM0NSM9ZOmlBY+YbTslczH147n1v8/7UpPE1GwuKEDNhJWW0Aet/3E1TvUWgX2LntElqissX1ax8P0FcSPGAS/JDhAvFBOqVWuJ2jUt8bFqkFr+5dBSRCLevdkzXMY5nFjrMg2yNazR5L25jRifQOpLmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860466; c=relaxed/simple;
	bh=cGs3Jb2nQ37NF/7beZapPr3FUIwv16Sm07Ifr1nLpUE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=LJEaneyL+I918HmEmqo3Uvee7/SkOuodhT4g7k9qvh0en7SQdJa+oKfHS6k28mQlc3R77wlIzk4VBOFngRtuAOtSXHo2C6a7oYntRHwhVdWFukVGCSebaPzGoiY1wWM3xasQCWBN5cNaDZSb7XehWjeJ+pdS+XZWmZO3thJFsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OLRj/8Bd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SAA2tD015854;
	Mon, 28 Apr 2025 17:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wh8AXznfAaDShm6du/256XBfIvd+khiuSNyA5+h88Po=; b=OLRj/8BdhLGYKa01
	N0OAc5eaCWBrqqYfwyTuc/nOFykjF457qW2hFXiZTb3HIpPUMpBZLKe+4Exy34W/
	qhC41ysP3V5eUN0Xp3YvKhQUYs6ZKzH48MY2RSsK/iZzYByj+vpOgKNxRg2Q+WWx
	Xm23xNTOmNRiNslxXOb83rRH+8Z1BjDBKe6CXM/R99ejX4tpP7M0+V40KeM1pj0y
	2fvFFedrEbE8K+sTrn/aKIRaUMK4/I+Se9MPFeU2NXXi8PmY4YkGzN9CG5XoKqvx
	vSVdfUvYeIkQJvpZNcAWCw6p+MF174uDNLpCpEYzPPl9nXQO9g/XURC46NJhsMkp
	w7H1wg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468pg99wt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 17:14:12 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53SHEBUc002911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 17:14:11 GMT
Received: from [10.50.3.121] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 10:14:09 -0700
Message-ID: <0772aa2e-d4df-4647-88d3-06c3726b0680@quicinc.com>
Date: Mon, 28 Apr 2025 22:44:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 00/11] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <07c00e98-5280-4563-854f-5c7a457578d0@oss.qualcomm.com>
 <07f6395a-8bc1-491d-a90b-3fc50b8478c7@quicinc.com>
Content-Language: en-US
In-Reply-To: <07f6395a-8bc1-491d-a90b-3fc50b8478c7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ZpvtK87G c=1 sm=1 tr=0 ts=680fb764 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=eIXec_biSmsyT1gLdVUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tqPef9PWqMlhRJOpKWDd6qlYSsyy0iDO
X-Proofpoint-GUID: tqPef9PWqMlhRJOpKWDd6qlYSsyy0iDO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzOSBTYWx0ZWRfXy4r6xWi3D3T+ krFrOP1uvUpxW28AZFOu5xDeRRL9D4EcdsjC2bmHQCQGAznvkbUNqE0ZG94Zph0jNGS7cKUF8nX pBlCiU/kctZcrZ7URHvIdkNsxH/mhRnOoJuXW8O/RoqDR2VUOaeO0/SsptZnA8VxNnLvew/68VD
 mUq6p3Yqnee6CAFZMFkyRoE3BTQMYkVUwD6kTUe1gaw1m49WLOBhQ9pxacmV4MZ8rr5Dchtw2DD DeWMpdnBC8E9niwZJH4i9A5mAsukNjSIgl4EqMcRjMWJID4klhvtAOiPfTDC4ufTVTwgBoKXdG5 KF6s3EXLPNUUB2eHgrkXT9Y5iBlsWj/LBr2syqt6KcygoZ5XJFJYSHYXGGZBaqfr2vEjwXnh5XG
 loKIDKEbidsXblky4zh69aSgqQC1A4tD9Y+sPpgUSNHI0MzKR+u0aOenkpdmyyLFtYunHkoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=616 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280139

On 4/28/2025 10:52 AM, Sarika Sharma wrote:
> On 4/25/2025 9:16 PM, Jeff Johnson wrote:
>> Just a couple of generic points:
>>
>> The last ath/ath-next pull request was processed. You need to rebase 
>> since
>> this series no longer applies cleanly to wireless-next/main.
>>
>> When you post v7, please include all parties affected by this series, 
>> either
>> by using scripts/get_maintainer.pl or by using b4. There are a 
>> multitude of
>> driver-specific lists and maintainers have not been directly notified 
>> of this
>> series.
>>
>> Since ath/ath-next matches wireless-next/main, and since this series has
>> co-dependent changes, I am freezing ath/ath-next. I'll continue to 
>> accumulate
>> patches in ath/pending.
>>
>> My hope is that all of the issues in this series can be resolved, and 
>> that
>> Johannes will be able to apply the entire series to wireless-next/ 
>> main. After
>> that, I'll fast-forward ath/ath-next to pick up the changes, and then 
>> I'll
>> start applying the accumulated ath/pending patches.
>>
>> But I'll only hold off for a couple of weeks since I want to issue 
>> another
>> pull request in time for the v6.16 merge window.
>>
>> /jeff
> 
> Sure Jeff, let me sent new version with rebase and include all parties 
> affected by this series.
> 

I am waiting for a clarification on one query from Johannes
on V6 on
"[wireless-next,v6,04/11] wifi: cfg80211: reorg sinfo structure elements
for MLO".
will share the V7 with rebase, once I get clarification.

