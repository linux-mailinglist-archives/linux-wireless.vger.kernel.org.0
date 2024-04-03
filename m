Return-Path: <linux-wireless+bounces-5835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6CF897343
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 17:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F30FBB23CC1
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0499149DE8;
	Wed,  3 Apr 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ibbj7TPV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45D59B67
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156421; cv=none; b=MGjw/Rah/VyWFKP+MPNbHwORx6nXsLZwqGzDx0J+YzNdptOKXVL3OSLtTmE3oroTjNcv4PslxwA/aMG9zONm6UZB/mOp2B7iyxYRMg7mO42snj1mHeLaWuT55T3f01kGM6Jq33xBiztJA+iPy1LLUabjy3XMM0ThalrPujumlzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156421; c=relaxed/simple;
	bh=NIn6Q80ppyEbg8lHi0cDMLyf3Sv2j86G+KkhmvLwLBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fz/fcJkAK56i57HBqAH6Ve+LIz0YWGycjjf1wzcUdoctagbU0GLavktm7m1Y0eHIqP2uMpQMpeKS7Dn8husXep3AofDfr1figr8lQ+X7QsGwAWJOGy+Z3eHROiRjargQe998maQVgUIkpA3M3u+iJ6Q5i/liu/6yzBCSi4rLloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ibbj7TPV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433DmO85014117;
	Wed, 3 Apr 2024 15:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=d5lIUhkPkZrQGh5RTSBkxbGqGWRelVvdvHuggsf0q30=; b=ib
	bj7TPV1gMexe2aBEYXtWBCqtuBRYk5mqBu0/ZdGA9ZO+SSyleGV7OCREx3wwzId2
	n2qjbjaaIYI7jYr0yqyZAoGQrh47oO8gfFREO/5t9cuefmCudxizol2NPudR/tpv
	TBrG+92q3OC8dkM1TGzQesulYnuU84vsL9Mo2CkQD3EAF59FmorgGozyqbm0eEFP
	0EPjRHNztXsk4EkuHgiIABXcfnkIJaB6eduC8lDuE96529FSkQw62fOpSGQl8XCU
	vo162rnnS93wmy9xWpWPvD0FCyPOyg4H/79Y1Gy7Sfphc3d3k5apj1DZeg/DkMDx
	LbdoM+MwmJ+cpTLajqOg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x944e0x8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 15:00:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433F0CZi019846
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 15:00:12 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 08:00:12 -0700
Message-ID: <9dc8f48b-bc94-47ab-a283-773e5623f7e5@quicinc.com>
Date: Wed, 3 Apr 2024 08:00:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] [RESEND] wifi: ath12k: refactor the link capable
 flag
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Kalle Valo
	<kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240403042056.1504209-1-quic_periyasa@quicinc.com>
 <87o7aq68a3.fsf@kernel.org>
 <9200cdc1-00ae-d3bb-1f3d-abb4ce993cf7@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <9200cdc1-00ae-d3bb-1f3d-abb4ce993cf7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P3_gPe0SFgQ6ny-Nkf_gdT1ThGx8DxaV
X-Proofpoint-GUID: P3_gPe0SFgQ6ny-Nkf_gdT1ThGx8DxaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_15,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=725 clxscore=1015 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404030102

On 4/3/2024 4:21 AM, Karthikeyan Periyasamy wrote:
> On 4/3/2024 4:08 PM, Kalle Valo wrote:
>> Why the resend? 
> 
> I missed the version log in the commit message.

In that case in the future, just reply to your cover letter and say you missed
including the versioning info, and put it in the reply.


