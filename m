Return-Path: <linux-wireless+bounces-2591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA3183EB02
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 05:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDC11F243DD
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 04:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AFA3D6C;
	Sat, 27 Jan 2024 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PQgj2EF0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B617FD
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 04:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706329934; cv=none; b=F95j+Bywg92tT2Em2sVRlyqANn23agCNkgYq07jRFw9RxxJhxAFbsGhR2/zvl8LHXUAZYx88RPvo/4JruYMbzhYG4jYLWPd8B21A2/YAFcO5Q3eKfKRzzx8j1BkThkvd+aN/1qXOp4Fw2oMEm3moF5H/rFTI9roBTuk1x5JVkM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706329934; c=relaxed/simple;
	bh=5aX+TnzkTZOyBOQgaT9VCG7IpEWAouSUfbIPtbOB3lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZnkpKPRJM2JxypSTqsv7ZO3GY/ZgWpncRZDOyK4r5P8aorCLbBggzmqUX6CHB2ICJPXbgvl5DbMTvqWfIy1buSz8yH/ax+Ur1SOxMK47GjzO4Utd2cc+8U8nOQfedT1I8ldYUxj7/9zv40tBHSNOPU4GF7kZYA3cVv1ltn3jeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PQgj2EF0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40R4VlQx021059;
	Sat, 27 Jan 2024 04:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6utVVzv24TMuHaOi9DUlqOdQ2/Jgg9eUs8xBXPgvhmY=; b=PQ
	gj2EF0qLiD64H9OZrxKwr91K/tHoN5Jt2AIXMUN/OJMKbacIPKMrXgwnXjeIR0mk
	H2hURs/7LDInCnLBZb6bhDK8H6mFySN94fpA79GKueQ7/4+yjS7db/9SP/Osb1op
	QrrTajve997WY2pzIIS1oSJgg7iOuu/SpJ1UkdMH05JNe2pzbo+pcgxzPDdS3int
	AwFR2PEIZ/hBv9U1sZZfh7XTIq26Ba6jd6jNzDStiVXkQWttEgJifjAQGjLZGijP
	G0ljcvQPYVf+A5siujg+BzKns0gXSydRskIDEmWxXqIQGH8pLcgHlZ/qQ79DtFA/
	KpWIgD8yi9vH0ZnZeKHQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvqhmr7ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 04:31:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R4Vjls016414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 04:31:45 GMT
Received: from [10.253.76.87] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 20:31:44 -0800
Message-ID: <fc6bd06f-d52b-4dee-ab1b-4bb845cc0b95@quicinc.com>
Date: Sat, 27 Jan 2024 12:31:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k and vfio-pci support
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <8734v5zhol.fsf@kernel.org> <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
 <87r0ipcn7j.fsf@kernel.org> <356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
 <26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
 <87mstccmk6.fsf@kernel.org> <df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
 <8734v4auc4.fsf@kernel.org> <e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
 <285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
 <4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
 <3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
 <ee0280fd-032c-4f45-a3f9-50d96d8bed6d@gmail.com>
 <16cfd010-b62d-4385-92d1-002820a8db38@quicinc.com>
 <cdec259a-b779-4856-8585-f285179e3671@gmail.com>
 <21e925bc-ee3e-4421-949b-b3839d2abdef@quicinc.com>
 <08457e37-49f4-4c51-998b-e577731c8022@gmail.com> <87o7dh2oky.fsf@kernel.org>
 <8b938c5f-a8c1-4fc5-aaf5-501f097a1db0@gmail.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <8b938c5f-a8c1-4fc5-aaf5-501f097a1db0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ebk55hykM7StFfMozH85KxV78O9czg1o
X-Proofpoint-ORIG-GUID: Ebk55hykM7StFfMozH85KxV78O9czg1o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=630
 spamscore=0 impostorscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270031



On 1/27/2024 2:20 AM, James Prestwood wrote:
> Hi Kalle/Baochen,
> 
> On 1/19/24 9:57 AM, Kalle Valo wrote:
>> James Prestwood <prestwoj@gmail.com> writes:
>>
>>>> Sorry I should have made it clear:
>>>> step1: start qemu and load ath11k without changing anything, then
>>>> you get those errors;
>>>> step2: keep qemu running and ath11k there, don't unload it. Then
>>>> check lspci output in host to get the MSI vector.
>>>> step3: Back in qemu, hard code MSI vector to the one you get in
>>>> step2, then rebuild and reload ath11k.
>>> Thank you for the clarification, this worked like a charm!
>> Very nice, huge thanks to Baochen for finding the workaround! James, let
>> us know how it works for you in the long run. This would definitely help
>> automating ath11k testing so I'm very interested about this.
> 
> It appears this hack isn't a reliable solution long term. It did survive 
> several reboots but then I was back to the same behavior. Looked at the 
> MSI vector and it had changed:
> 
> It went from fee00558 to feee00538
> 
Yes, the MSI vector allocation is up to the kernel, and several factors 
are considered when doing this. Among them, the most important are the 
IRQ load balance and available vectors on a specific CPU. As a result, 
the vector changes, not only when you request it (as you already see), 
but also in run time.

> But at least I can just modify this and get it working again.
> 
> Thanks,
> 
> James
> 
>>

