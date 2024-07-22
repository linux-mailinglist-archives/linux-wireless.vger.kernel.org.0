Return-Path: <linux-wireless+bounces-10424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F04E93897D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 09:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B59280A8E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 07:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649A08F58;
	Mon, 22 Jul 2024 07:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XTLfJGoy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877C22F41;
	Mon, 22 Jul 2024 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631777; cv=none; b=WTdBveu2uIyd9IkOIVs4TKNEiR13W0ZzLhVz19DJwkVQdjQ4sG7o+JwvRSRmjmuc6HCyaEf6hPSBprdBDZuuyiG6kKrNhetHdtX3My3dvy5oqzAlCwhcfvUBXRvGkZs5ILn1+bUlSoQ6+SWkoOIYtmeAdH8/NM64zNE4B637edI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631777; c=relaxed/simple;
	bh=V0t82O2bFJK4j+T544j2QCYifm9/JDBY8tz4aRK63TI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=rfXGZU3rxGkA7U+CxvoGe80D2lFzOV1s2//c1B/EKnYV6miS29J2A1r8hTjZCleXMT1iSlAYgId3b5/BDiyUb9VzFmxDz+Wbb/3loFZXPX1xiDQS+6McilCBNvoU5ty2QPZuSInirWJrWaaKdtuGBoWba0KlSr4MvIuT8/xL2KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XTLfJGoy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46LLxcLk022838;
	Mon, 22 Jul 2024 07:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BW3f9GIsvtIUK90wLhUHer5+7DZ0w/N1HRpFgXktSg0=; b=XTLfJGoyuNFixsnZ
	JywC9fgz1ImImhVBf3QF607eBe/CuJFwzRDuUOMe7qlUjDOIvTP9K4GTr9KSGyZu
	JYLO2SOfCGPCUu3c4RfmHRC0OBSQSTYuk5fT1ByYhp7dK2tkufeAfEozZ/2IXdjy
	LYvnZZjtqtaJEGzwpU56RdoQvzYbyO2RSeso8tbby9P1qbzjtJ9+HxZQb00+csPB
	7z9+ig/8MB7TiyePa5M9/5WYwtR32kGjT1kyXtJpWcbd5Ql5tELtS1ScvGgyeltL
	gr/786w7WIrghrNgkobSVzueoefjvNUqR0MG2zP4nXGHRRRzoWGlJCgGdktMRmxn
	sQDaGg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g2kmu2fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 07:02:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46M72n0Z013861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 07:02:49 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Jul
 2024 00:02:46 -0700
Message-ID: <1aad7e68-c2d4-4b77-b526-5580860d7e3e@quicinc.com>
Date: Mon, 22 Jul 2024 15:02:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: use 128 bytes aligned iova in transmit path
 for WCN7850
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <kernel@quicinc.com>,
        <netdev@vger.kernel.org>
References: <20240715023814.20242-1-quic_bqiang@quicinc.com>
 <c26af1cb-747a-462d-8e13-af948bbb8171@quicinc.com>
 <df00b06a-d33b-4df8-8f44-2b7f659cb2f9@quicinc.com>
Content-Language: en-US
In-Reply-To: <df00b06a-d33b-4df8-8f44-2b7f659cb2f9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fKrrrrMkKq6NicoQgubtJ-RkyOPgY0ow
X-Proofpoint-GUID: fKrrrrMkKq6NicoQgubtJ-RkyOPgY0ow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_03,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220054



On 7/22/2024 2:54 PM, Baochen Qiang wrote:
> 
> 
> On 7/19/2024 10:10 PM, Jeff Johnson wrote:
>> On 7/14/2024 7:38 PM, Baochen Qiang wrote:
>>> In transmit path, it is likely that the iova is not aligned to PCIe TLP
>>> max payload size, which is 128 for WCN7850. Normally in such cases hardware
>>> is expected to split the packet into several parts in a manner such that
>>> they, other than the first one, have aligned iova. However due to hardware
>>> limitations, WCN7850 does not behave like that properly with some specific
>>> unaligned iova in transmit path. This easily results in target hang in a
>>> KPI transmit test: packet send/receive failure, WMI command send timeout
>>> etc. Also fatal error seen in PCIe level:
>>>
>>> 	...
>>> 	Capabilities: ...
>>> 		...
>>> 		DevSta: ... FatalErr+ ...
>>> 		...
>>> 	...
>>>
>>> Work around this by manually moving/reallocating payload buffer such that
>>> we can map it to a 128 bytes aligned iova. The moving requires sufficient
>>> head room or tail room in skb: for the former we can do ourselves a favor
>>> by asking some extra bytes when registering with mac80211, while for the
>>> latter we can do nothing.
>>>
>>> Moving/reallocating buffer consumes additional CPU cycles, but the good news
>>> is that an aligned iova increases PCIe efficiency. In my tests on some X86
>>> platforms the KPI results are almost consistent.
>>>
>>> Since this is seen only with WCN7850, add a new hardware parameter to
>>> differentiate from others.
>>
>> I asked for expert opinion on this patch and received the following response.
>> Baochen, can you take a look at this suggestion?
>>
>>> Aligning headers is sometimes done, but it appears the driver
>>> doesn't support scatter gather? I think the author may want to advertise
> right, ath12k does not support SG currently.
> 
>>> scatter and linearize manually in the driver, to a correct offset.
> is there an existing skb API or API combinations which can do that for me? I checked __skb_linearize() and it does not take an 'offset' argument.
or do I need to implement it myself from a very low level basis? like (if required) allocating skb structure, allocating/aligning payload buffer, copying/freeing paged frag/frag list, etc..

> 
>>> Because now core is linearizing the skb in validate_xmit_skb()
>>> and then the driver moves it a second time..
>>
>>
> 

