Return-Path: <linux-wireless+bounces-9638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BDE919DF5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 05:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA681F22700
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 03:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC8617C6A;
	Thu, 27 Jun 2024 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J3/zNBjv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FEE17C68
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 03:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719460070; cv=none; b=HNQjWNFixY4Yv4YwSsmRfGhMgMsqODlGzj/fXdtkSgh/UVyiEzp4NODlO70GbctrwAgndTAtSfytChoeMz0G4xa9n/Ci/PIa7b9HBS9vdNDcdhyggG5f8DJwuDfTjk9UL3N4Lhj+mpF789kAIS8g5CR2jkgNxNP9aaAHVBQgY2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719460070; c=relaxed/simple;
	bh=vwU8Tfgaxm/Ykt4p5EPM3Z/pjK9hmC1AArhentmw5NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lSuUNUvPug1EPRP+uteZENPUyfM27kjWQRAPBRfgo8ftH9iKF9/vxcE/YX3G3ULPFp5kAX/DGcaFuZhvP44GK/6sk770K7Q16weJwUBjzNjQ7HWwBlFmfpRNY1nr8GpiTU1AVMpsb/zrv1PqRPGl4NDMsyaI2U62KB/zZ2CewHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J3/zNBjv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R1gdG1029227;
	Thu, 27 Jun 2024 03:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3K75DiTcEzFH5h2DdMLg0zwganAgpWxdXjfAS99ED2A=; b=J3/zNBjvQT7DQiAA
	6wwLoy/56nceDBQ74zE2HenCwiGfsnsn2jDXxDLfsn4T6n8xetoxyVLdwibsKydq
	5w5cysr/h9l49Xazuu2/sL15Y5f11tecgqCRq3k8M47cSblUBpR44i9p6jKwspst
	jRSfzdFQgW2IkI7X+F+LJPgoD5q3hjqIwrRqgYoGzsquvI5RZSs1kZv1HN42kOTm
	HP+VLQfsF6Q7bW35Fd3a7Cv6FQ4KOhWSdySsKnZF+VU0d33MwOKus1Hjc1zGu4KA
	nqPIM8IxTHzAF8igzBoDu9sO9l7RNQnB5uS6LML98uiruBJZtv8ybFABDlnuJOA7
	MobkJw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6tu6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 03:47:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45R3liRH020478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 03:47:44 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 20:47:43 -0700
Message-ID: <9f77b235-6815-439e-b3f5-12fe6c6b61f1@quicinc.com>
Date: Thu, 27 Jun 2024 09:17:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] wifi: nl80211: allow CAC while other links are
 beaconing during MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
 <20240626045216.3754013-4-quic_adisi@quicinc.com>
 <65e48b46d81268ae8ccab7f21bb293320440ec40.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <65e48b46d81268ae8ccab7f21bb293320440ec40.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: usbgO7fytcR3ccwD3tKnNxYmapg3OaCL
X-Proofpoint-ORIG-GUID: usbgO7fytcR3ccwD3tKnNxYmapg3OaCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=452 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406270027

On 6/26/24 17:55, Johannes Berg wrote:
> On Wed, 2024-06-26 at 10:22 +0530, Aditya Kumar Singh wrote:
>> Currently if any of the link is beaconing, CAC can not be started.
>>
>> However, with MLO, it is possible that interface is beaconing already on a
>> link that did not require CAC, but now another link is being started that
>> does require CAC. Hence, same check does not apply to MLO.
>>
>> Add changes to check the link under consideration is beaconing or not in
>> case of MLO.
> 
> Also this really doesn't even do what it says, since it just checks link
> 0 ... I think some reordering here would be better.
> 
> I'm also not sure it all needs to be in this many patches? Might be
> easier to have fewer, and put e.g. patch 6 first since it's just trivial
> prep.
> 

Sure will do.


