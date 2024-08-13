Return-Path: <linux-wireless+bounces-11330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFFB94FCF6
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 06:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4958282A89
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 04:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015A12032D;
	Tue, 13 Aug 2024 04:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FVOGCpRH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5ED368
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 04:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723524596; cv=none; b=GGsLe0awzHzvWqCYy0lJwQ1oBApui9NwgkBLbokJ/DtKHswWp+TiqVKGtjxFxrAAZssshXuXpttr8lu4ncaTMn5ZBcbo3XoZ6HcIcuPMAGKFPzzgj0g6+W64W8JOZmhBbt6UMraWs8OUUcCu4T/Sd7CPtbwzH3brlD2DXctjLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723524596; c=relaxed/simple;
	bh=XWaKTxJdHzFNJlcMYe/72YVWakoYSHPCPi20XomwP50=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K9+WhzB5t2/fKxblPxFKt6eUVP0R9VNtH0Ekgy2+9yUEA4yo7Q4blNUY9TH8uiWwF8MX9up/WTUas37RnLsXWIIrvy46UxjejyTIcJybEHwanZgnrWyZVytA03rLNjWah/HpmDbXBGrTJOeJ9ZFPIX0KeUO03+dD9l0xcI9BDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FVOGCpRH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D4VDgk022253;
	Tue, 13 Aug 2024 04:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Di3PR0P88z1kjkWvSa9GWG4+VyTE1YAeE4ElA5Dwzsc=; b=FVOGCpRHnbLS869h
	vQjBUorvdMDlmKK3+Gp79MoPVpGKPKzgKHNKiQQra4X5P/ydPXrqpO30Yyh0d1Vo
	k4ELPvB5bm/3aYmKYuqraJhQLjgdFR6Kbg5PFvjG4klPKvV6AY/hlMbgycevT0Tz
	Z7osgzl/Fsq2mu9ULlmdCr10DuKl5uXSut+zJkHJtVC53NdzVay6o3XtSvLfifS6
	SN7kxH+fdn5fysh0dNlVRQ+WCaR/3DfVNb0Klux1uXQucFpZNFUtm9g7pni045Dk
	ymuOv5sI9fj8m3hJS7MzP+ps+/4rVG/MghofvHYNuricc8LM3XNwSDQuJUcH2g5V
	cm1MrA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1g7xaf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 04:49:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47D4noIM020511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 04:49:50 GMT
Received: from [10.216.0.53] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 12 Aug
 2024 21:49:49 -0700
Message-ID: <a0a6cfbf-4538-1be0-80a2-4aea8a656555@quicinc.com>
Date: Tue, 13 Aug 2024 10:19:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] wifi: cfg80211: fix per-STA profile BSS entry issues
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
 <ef80a0b77fcab051e256deb310c725d4d8884fbd.camel@sipsolutions.net>
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <ef80a0b77fcab051e256deb310c725d4d8884fbd.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w7IZ29i9CDYE15fjJVI7jwFOaiV371Qu
X-Proofpoint-ORIG-GUID: w7IZ29i9CDYE15fjJVI7jwFOaiV371Qu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=948 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130032


On 6/12/2024 4:36 PM, Johannes Berg wrote:
> On Mon, 2024-06-10 at 14:22 +0530, Veerendranath Jakkam wrote:
>> This patch set contains bugfixes and cleanups related to per-STA
>> profile BSS entries.
>>
> It also has RCU bugs (per warnings in the hwsim tests).
>
> johannes


Thanks for reviewing the patches.

I was able to run most of the hwsim tests except few tests (around 20) 
which are failing due to other reasons which are not relevant to the 
changes I submitted.

But I didn't observe any RCU warnings in my hwsim setup. Not sure if it 
is due to difference in kernel .config between our setups.

I enabled below kernel config additionally to find out RCU warnings but 
with no luck. It would be very help for me if you can share kernel 
".config" from your hwsim setup.

CONFIG_RCU_TRACE=y


- veeru


