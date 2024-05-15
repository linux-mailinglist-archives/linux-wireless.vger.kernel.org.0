Return-Path: <linux-wireless+bounces-7715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537218C6C02
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0CA285100
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0107159594;
	Wed, 15 May 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oLwtA4OJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489C159565
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796837; cv=none; b=gDZToZjwUOEHsV3tdx3+1DMZyeIFpRTKbFNHIDeDUAAq4pF4m2cSI0IIXEhTS2Weak7G6Y3j4xVcxi+Kjyy5YAT5YiofFK4/OvFfa15D3a4KnBF3aPG8qHzq+PFroB7lsPt2iyz5SONKN76uEUB16m4gsbZAIFhv/NGetbg68hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796837; c=relaxed/simple;
	bh=yjC+I5kYoObtD+aw7nT7HRR6/6tCO4ab9HirZRXaPso=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TXkMkQAAndmfO9rO4+WE4JegGrIAmUlxG3Td8cEx6mzx3ISpoWR3QJEDKPcAH+8EjBNIGdshcx6Ll1f2WpcAjtnOdHKMhnvjPXWY0KJgFkRrDskECRYVt1lu2uXNXzPcoqLu3RBd3/7nzg6s5y2n5REswNuRf+hgw+ILy9EVNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oLwtA4OJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44F90aag021385;
	Wed, 15 May 2024 18:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=33/366XHZMVVhIE508DvavCS7eBCyvvNtVp1d49Apvs=; b=oL
	wtA4OJBXqLmsLt0SpeLkdIu5G34Qq+8sU7N1gvC0BJ48Gy6K+HyPQQapDu+HrzCq
	26cCgzbAA7BTmh+9t6kGHf/G1kkTIFywFZtFXxsynH5jS0eQx4512TClM0/8dTi+
	z8WFmGKaps39bHPXQ0NpGz5a9IPRE6WiGdlKo8Q+bPYKzRYqUKDEwB7BkBBJenZj
	4By4eUQ0rOfjIr1pde3Mhv1Runz/99ZSgMyTygfYCkifMCir7EbmjdIZwjMMFDII
	qx8nGFvp7y3Djy2IpL3oNZfQlceWRRBlbEAlSeUC5by1alcj8cmqEZ4d4z8Z5Rp8
	R5Jwi0EyIfQ17zIRi6Eg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y45vbbuv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 18:13:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44FIDf8m019066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 18:13:41 GMT
Received: from [10.227.108.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 May
 2024 11:13:40 -0700
Message-ID: <a304cc50-4160-4660-950c-18ed1fe15159@quicinc.com>
Date: Wed, 15 May 2024 11:13:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in
 ieee80211_bss_conf
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240515165231.12114-1-quic_pradeepc@quicinc.com>
 <20240515165231.12114-2-quic_pradeepc@quicinc.com>
 <32e7237f6dcf98254c2468438665a1b9357d2dd9.camel@sipsolutions.net>
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <32e7237f6dcf98254c2468438665a1b9357d2dd9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OuJ0OkQAtz9Rt0Su270JtbL1L6F8M40F
X-Proofpoint-ORIG-GUID: OuJ0OkQAtz9Rt0Su270JtbL1L6F8M40F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_11,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxlogscore=918 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150129



On 5/15/2024 10:45 AM, Johannes Berg wrote:
> 
>> + * @eht_80mhz_full_bw_ul_mumimo: does this BSS support the reception (AP) or
>> + *	transmission (non-AP STA) of an EHT TB PPDU on an RU that spans the
>> + *	entire PPDU bandwidth
>>
> 
> I'm really not sure why you insist on neither fixing the documentation
> nor the implementation, but I'll say it again (just this once): they
> need to match!
> 
> johannes
Thanks Johannes for clarification..

Apologies for confusion, I was trying to remove 'AP mode' reference in 
commit description after your initial comment, so that it does not 
conflict with eht_80mhz_full_bw_ul_mumimo's description in code. Also 
was trying to replicate "he_full_ul_mumimo"'s comment in code.

Anyways I understood now (hopefully :)) now and fixed it in V6.
Please let me know if you have any other comments.

Thanks
pradeep

