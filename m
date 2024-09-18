Return-Path: <linux-wireless+bounces-12930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E397B6C8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 04:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9292816F6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 02:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500E527442;
	Wed, 18 Sep 2024 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KI1Oi7Eg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B479C8
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 02:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726626072; cv=none; b=ilhcCSlafuudEK5vaYsxraMs+bWpW2BhDABiuzAzvpqMFlvlR88pxxiiix24t/GwXMsz3Mll+i5v/Sfqz1dpMVtnSOazXdQUtoVJf/+REAeQgkgqJR5uHAznLzgzIhPDAZxGNYNfl1R+LfeYjjE5aSEnRG9vS6c3LxFkkHQIq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726626072; c=relaxed/simple;
	bh=SGff6+WUQiT0mkRZV+tvMULznkQqgx2LkZLrEJ8HX0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MfmA/crx3vr1FTt95LUP97ujpOFt+ORT+LdiIrjASeCB02cbCCrni7Di4EAGfUVPMrJqFijrOdtplmylLbKNSejV+wE6b2uJDI7rLvVy+peRjplIDi/BujaPYdOzQ69OfZIMgE205R1slpME0C5kDD1GHeewUPyAQezLV825iuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KI1Oi7Eg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HHv6Lr022162;
	Wed, 18 Sep 2024 02:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Um7r5rj3kk8EY6ZPn8L7JsB5/s4PfF3T5yMHduM0z4=; b=KI1Oi7Eg77c2hbEi
	tps3CqMOvv2fPj4FaDkkIKcP9WZufkeoSoqJdhJ8jT3AL/zLnScrqGNxSuWaTc4U
	mHp3OcBH0ddaODwVAu8BL1UcFQ/sHtui5mQya2BivtjbSmsu7jF2y3Ueo5vRyA2o
	c9Y4Ly40b4Z/vslMVLufYqVJco/gkveDDxImDY4bxsSKMCeUIz8L31Ahz20JetvT
	avZVR0QSqNilY1pUbEGlVKFV1jHTJ6ocKazAZq3IBBc2Y/eOdVWHgl2ghlA3w1aY
	TIXiPxVegfAyEheNnBWw1ELCLRSYTqRmRnFpSuiKrZLATx832Z6eelUN5apiYYZu
	0dbrtg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4hfggqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 02:21:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48I2L4IF005530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 02:21:04 GMT
Received: from [10.253.39.169] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 17 Sep
 2024 19:21:03 -0700
Message-ID: <33a441f4-c2ef-44f2-a67a-4633733c871a@quicinc.com>
Date: Wed, 18 Sep 2024 10:21:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: ath11k: fix full monitor mode
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240913100708.756-1-quic_kangyang@quicinc.com>
 <87ed5kaxxp.fsf@kernel.org>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <87ed5kaxxp.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sC6O1iRV6hlH90_0nmiFq4nnQtuzuS5T
X-Proofpoint-ORIG-GUID: sC6O1iRV6hlH90_0nmiFq4nnQtuzuS5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=711 mlxscore=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409180012



On 9/16/2024 2:56 PM, Kalle Valo wrote:
> Kang Yang <quic_kangyang@quicinc.com> writes:
> 
>> Fix a warning and a bug for full monitor mode. With these two fixes,
>> full monitor mode can work properly to capture packets.
> 
> On what hardware versions?

Only for QCN9074. WCN6855/QCA6390 don't support the full monitor mode.

> 


