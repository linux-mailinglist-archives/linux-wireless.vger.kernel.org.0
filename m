Return-Path: <linux-wireless+bounces-16000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296159E892F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 03:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2901882CB4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536C317741;
	Mon,  9 Dec 2024 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aLoI5MLL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969D9474;
	Mon,  9 Dec 2024 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733711359; cv=none; b=pPZR0LVNdN24yWRyID4K62lD0/Qxq2e1NUQPg3yQxhGz5Pp057Ajfsh6bn4ZFF0VU8om3J5BsLIXONqS6rnMHb0VgZfTcySCXHUgeVdexQeX45myh7sPXBgEIFfzAvtrf5757qtgdh9zY4B+hj1dno3VKrr8kQAk0UZli/QRgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733711359; c=relaxed/simple;
	bh=vAeVK8k9eLgDWD7NrbBu2SEg2upIUWl8Mn5mO8s5hoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pUSMtqwuuCzjsosAf9vFy2o7Zd2/Un7e/7EsFPce5YGqL9SQN5LZXhXcdN/7WhZ+Y3oJ24r/nr14L/OmZCa2x5vkkAkdWIMxksbWnGwJHWLYZXlrKjrUxboBdtZvmztaITA5BmnQkyxzY9PWhufZtmVx+59dh6+96yqkSH4PElo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aLoI5MLL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8NOr9P022763;
	Mon, 9 Dec 2024 02:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hkDMC4n+nmNheTZrmeWXtlAoFZY5epZRSAMxvpIPWdU=; b=aLoI5MLLrcCarm1h
	xPOX0f64GN6qIBUxn/Jx2XBZBQFtzgmjHGzFLnEyQa/+OoxkRyelJWDvf1wMUlGy
	L/T2F0jv3ehEyURgQmj6Bwdw2rKFaqni9z9ZEOtT/esIXIbr3kw48hMTi6MdCYRy
	QRp92pRnbEWVnn/rsIW+FFaqKpRS0VwaucMPUC10BfeeXrYV5sQri7QnGbx53jRo
	lqwRwI9/9UCwUySjEFpLTusSC+TT/4sCUEaD1H7eUS7kkyTTOCRuvUR3QmyvqrrL
	B+CH/gEtK5s1vOAkz8eWJ7g20OTfNvT5hQAWeU/K+QskydwD9DcGD7HhX1VNRE9n
	jvRVHQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cer6k2cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 02:29:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B92T8dq032403
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 02:29:08 GMT
Received: from [10.231.194.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 18:29:06 -0800
Message-ID: <1123551c-1a6d-4d0d-b3c7-f65c15509280@quicinc.com>
Date: Mon, 9 Dec 2024 10:29:03 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <quic_cjhuang@quicinc.com>, <vbenes@redhat.com>
References: <0f24e115-e76d-4c8a-8a1b-591a157ee78e@quicinc.com>
 <20241208121321.9760-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20241208121321.9760-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hAWil-3zcNZNZj6diss3URCGw0hEV4V1
X-Proofpoint-ORIG-GUID: hAWil-3zcNZNZj6diss3URCGw0hEV4V1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=565 clxscore=1011 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090019



On 12/8/2024 8:13 PM, Jose Ignacio Tornos Martinez wrote:
>> My point is that you can try setup with ap type interface,
> This is what I am doing!
So you can't up with ap type or can't up with managed interface?
>> now combination limits not allow up 3 inferfaces with managed interface.
> Why? The limits were bigger previously.
> Why cannot allow the old configuration (previous to the commit f019f4dff2e4
> ("wifi: ath11k: support 2 station interfaces"a))?
> In another way, your proposed configuration is limited for me.
> 
> Thanks
> 
> Best regards
> Jose Ignacio
> 


