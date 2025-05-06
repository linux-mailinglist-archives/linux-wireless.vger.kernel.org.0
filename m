Return-Path: <linux-wireless+bounces-22658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B37AABF17
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 11:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6679716306F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9621B9F4;
	Tue,  6 May 2025 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sc0l0/ZL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500E22DA04
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523197; cv=none; b=XueKX/mtjAKCSHtukbEIoLTj+zh1ZFHzCwWfIP4EcMbx76Yolg9ekkjxpp26t37xbprW1YM/4MWZvrJGBwvTKfy5ryx2DgOyLzJTrOayUNBW8GGV5nq4CTiWqEyYqhua5Vkn405SKxoNWPuKBQXNaA91/IGcBjLqpVKnkTR6YJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523197; c=relaxed/simple;
	bh=vsin+CoQ+vWqmZlTkAkCpKsSF6ZhhI/p7luj+oyKOAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eTa6iR9PluZnJ34bXBycRVc551L+0PbEw5FEZScQJzf7b9OwgoaL30RFQ9WzFhh3Slt9hRIrnNV7prt2ZPUGGJBtCf7AbCIAbmApFy4qvXLu2G4Yx0kHlKShtTrZEbI+cCwl0s6NEsCyQ/A4a5dTThelpY9uT8wLWZUbgglfx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sc0l0/ZL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5467ItQt016934;
	Tue, 6 May 2025 09:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hmQ5itCDXl4b8OO8xUVwuQa9wDyhI4g/YkbaLq6LtD8=; b=Sc0l0/ZLxr+jZ+Qd
	loM+f4gDxyHgIedhv/DAA04ZnMUkJkTAUOhuoxEzXF9ktpPK1yH8R/2mr7HeKEVO
	x6mcCIm7fhSksSKNHt+tcyvaDmBXZ+eesPcHTrQKtERUUy73l+fjjxDJc3NewI6v
	v6S8WfvJuxeO3Ee68IbOwUwLxVEjHZEeMzzmcYoT7qxlWSp6qMtX8oa3ldXSXP1V
	Zjpbrsx0gpkakp0ItDRzoDMQu6uvqeT/pIebhTsSBjw8TI1h+2Yf12jJGBow3Ib2
	EfRqH9w3lI391jJT+D+LBnrdnYQ4/UQ+SZtPL0MbZf67hrDBgRjBLHODwEb7RZjB
	ab43Pg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46fdwtrc3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 09:19:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5469JiY2018297
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 May 2025 09:19:44 GMT
Received: from [10.216.28.46] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 6 May 2025
 02:19:42 -0700
Message-ID: <0c166b5b-f358-1f39-4569-a1ac388033df@quicinc.com>
Date: Tue, 6 May 2025 14:49:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Revert "ath11k: clear the keys properly via DISABLE_KEY"
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath11k@lists.infradead.org>,
        Sven Eckelmann <se@simonwunderlich.de>
CC: <linux-wireless@vger.kernel.org>, Steffen Moser <lists@steffen-moser.de>
References: <20250117191455.3395145-1-nico.escande@gmail.com>
 <20e0a239-3d23-473b-5bc8-41bc25a64088@quicinc.com>
 <D9NDQJB4VMWA.V4IPOZOIR46W@gmail.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <D9NDQJB4VMWA.V4IPOZOIR46W@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=VPPdn8PX c=1 sm=1 tr=0 ts=6819d431 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=OLL_FvSJAAAA:8
 a=IbVDsZSo2lVlMIwTQQ8A:9 a=QEXdDO2ut3YA:10 a=cq9DwLQcLZUA:10
 a=Iy0t56g-M2wA:10 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-GUID: 0qxcDUgYLaC0xEml_eltkdevkWe14pI5
X-Proofpoint-ORIG-GUID: 0qxcDUgYLaC0xEml_eltkdevkWe14pI5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4OCBTYWx0ZWRfX7tjRIBDXYq7W
 ++bypCaRnEAyJ5pbjhWAQr+yk2D1EEtxbkfkQmLNU+IA0Mk/reucNPdplpaB52LtKECpFUQlXlT
 ZdpekatG2xaD0LST0Ab4B0duTHNSixxnXZRn9++TYD8lgheiZaP9DuAerCV9of2pX6+Zqgww9fg
 ljrNAq8HU3PU4RsbALWJVmPIiOMcJXp8pwcTqEfdKv0jOXBDlVnFDmzRSokz7ox//O+WZlH2lUg
 Clr/sA8/XU8fbM1nHWJiy8sLyRBfjOp5/U7K2pXyvtkMygk6zcqqq5Use05bmAMb0GwTX1Dcqg8
 dVJ30+GRqM1dyC5o4mbjH0c7MQ/0EBj2f6RrDdFPyM8dNtviG7jW5LPC/xnexOnIGMhBo1qgWi3
 ginN5r9d89utY73qexG8Yz1SdJ7o7RuOBHkYPizBUzg+maHrvGU+9uX04gUqsJk5LjGyAX07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=577 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060088

Hi Nicolas

On 5/4/2025 6:06 PM, Nicolas Escande wrote:
> On Sat Jan 18, 2025 at 11:29 AM CET, Vasanthakumar Thiagarajan wrote:
>> Hi Nicolas,
>>
>> On 1/18/2025 12:44 AM, Nicolas Escande wrote:
>>> This reverts commit 436a4e88659842a7cf634d7cc088c8f2cc94ebf5.
>>>
>>> This as been reported by multiple people [0] that with this commit,
>>> broadcast packets were not being delivered after GTK exchange.
>>> Qualcomm seems to have a similar patch [1] confirming the issue.
>>>
>>
>> This will re-open https://www.spinics.net/lists/hostap/msg08921.html
>> reported by Sven. The recommended ath firmware ABI during GTK re-keying
>> is SET_KEY instead of current DEL_KEY followed by SET_KEY. We are looking
>> at other options like some marking by mac80211 for the driver to be able
>> to identify if the received DEL_KEY is for re-keying. Also I'm curious
>> if roaming between secure and non-secure mode is a critical use case.
>> If not, we can probably go ahead with this revert as temporary WAR,
>> @Sven?
>>
>> Vasanth
> 
> Hello,
> 
> Any news on this ?
> I would hate for this to sink into oblivion once again given how hard this
> affects end users when it does hit.

We are working on a driver change w/o reverting the commit, we'll share
the patch once complete.

Vasanth

