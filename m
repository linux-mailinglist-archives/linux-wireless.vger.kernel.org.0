Return-Path: <linux-wireless+bounces-27563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD21CB8F2CA
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 08:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685093A2AC1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6993274FDF;
	Mon, 22 Sep 2025 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O6ijBDj0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2176C2517B9
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523063; cv=none; b=dSPoApdqVzAw2LHaxKWpDD+6Tpp3JYnd5uSfbcn+zc76SVLoj/gEBsmss9YwVzM/udJwb7weTlNUqsYRJyq+ZB5g+DITw1pVkWih6jKpVzbrbRclUOh4iY1loQt9y7INg3MD7os8iAvKIAA2qCEgQzhijWzPk/TWB1VE6a+ViUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523063; c=relaxed/simple;
	bh=gl4ssw5XLsmDVO5icWmy5wiQjWYJbwAiPPkpCQ9XESw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vlw9iz310tA6j4HCtE/6IQ4EJTz93Bo4o1PapOOgVI7jdAX9BOT+JqW71JRZ2a4DvkakeUl7q6l+xzj3S2eN9f/BNxgB9fS0VNaSWTHW+D/EPfHBN9iWzo/0qW8a2gGDY6tULrqyXF063vkXasGZ3OV5wRBDmFNwBvn7z6abEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O6ijBDj0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M0PG4q002099;
	Mon, 22 Sep 2025 06:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gl4ssw5XLsmDVO5icWmy5wiQjWYJbwAiPPkpCQ9XESw=; b=O6ijBDj0fbUoc+XO
	wMc+UmEA0/6SSXStJm5X9XWIx9E5meDVMwV9Al8Y4R0S//BqlSd5jsOoOWbzSFxq
	frXm1rrYmIzAAsWMbMyCIxMDGRVesgK3IC1chS1SUMBxDXYf+yrF7qgo7lQ4ekVd
	dermzTPJ4BU9UKfTwE9F5uoNulQpW0izPSZrk1zi9tPnTJpHlO+txopZZZHi9y89
	iOYF4CMTB3P3/UB2oYqEbHNPjA549WIKSehzrzHj/u0v8ldtYZb/CXK/D/jPGPVb
	X5otZyalYwWnyDUOD7lcDOSvw527EwsCqP47aNQBNEru8MNgvDFcwvW03BjnWb8a
	jCP+sw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499nj8ugrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 06:37:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58M6bbRt017302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 06:37:37 GMT
Received: from [10.50.2.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Sun, 21 Sep
 2025 23:37:36 -0700
Message-ID: <e2647512-82cd-44b1-9d1c-941e4df11bd4@quicinc.com>
Date: Mon, 22 Sep 2025 12:07:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 2/3] wifi: mac80211: add support to
 handle incumbent signal detected event from driver
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan
	<quic_haric@quicinc.com>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
References: <20250912032105.714949-1-quic_amitajit@quicinc.com>
 <20250912032105.714949-3-quic_amitajit@quicinc.com>
 <42b9db0313d7b5448ca6103099b17e63c01300d3.camel@sipsolutions.net>
 <5115aba0-6a43-4122-a8ca-6fd993f21177@quicinc.com>
 <6f1f2a41ff0af4c6bff8199250397fd93ae983f2.camel@sipsolutions.net>
Content-Language: en-US
From: Amith A <quic_amitajit@quicinc.com>
In-Reply-To: <6f1f2a41ff0af4c6bff8199250397fd93ae983f2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=dZ6A3WXe c=1 sm=1 tr=0 ts=68d0eeb2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=vQ2ucV2iIQzhKsCFl50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CTJty47SfHx_3AXRG8SYu7ZxkscdFQ-5
X-Proofpoint-GUID: CTJty47SfHx_3AXRG8SYu7ZxkscdFQ-5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MyBTYWx0ZWRfXxBDPbDGznjuh
 nvt/szgQcP8Rfrakb1trRdaAPH0PSp1VIoEyIG+smYTz2Kl3kBdiY2rI/PD8dnopycF1O6PHOnx
 B6VlWtAsDhFtK5Rvzt9aLvtdx0IKKXJV7TjSvdepAumjJ+58TPvFdywOAi5WE5LxNbip9jFhVwo
 ycj2Zg4T6wU673tEQf2XsVRQdnDFwZGn1BeWzn+ExqlJwPbmZKhpJjd8nYdp4Fapme2Re43K8nR
 bADsmOTzh6OUWYWpZhYJr00rAGNdghhuocY6GlHLMNeiken2fExyAWqL5cl/yjT1Slztrfb09G8
 d0NHFRxsruhz5D62CozIwzLQlKn/lC6abdYp6VFNXiblo7rWrLyPIwMjYXAir6LRi9C9yB9FGxB
 FjmSq3bX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200043



On 9/22/2025 11:47 AM, Johannes Berg wrote:
> On Mon, 2025-09-22 at 11:10 +0530, Amith A wrote:
>> The workqueue mechanism here can be removed as
>> ieee80211_incumbent_signal_detected() will be called from process context.
> That's fair, but somewhat besides the point - it should be OK to call
> the cfg80211 function from pretty much any context, so even if this
> weren't the case for your particular driver, there'd be no need?
>
> johannes
You are right. Ideally the cfg80211 API should be safe to call from any
context. However, in its current implementation, it uses nlmsg_new() and
genlmsg_multicast_netns() with GFP_KERNEL, which assumes process context
for memory allocation. That’s why I initially used a workqueue to
guarantee process context.

