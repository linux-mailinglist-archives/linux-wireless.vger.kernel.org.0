Return-Path: <linux-wireless+bounces-4760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A9C87C172
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 17:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357481C2158D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 16:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B973526;
	Thu, 14 Mar 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S3WqRZ0/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2C1E480
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434570; cv=none; b=nFHB4rC15NS5UPIUv2lvAdwpFxiLMgZJyiouShkjePb15GeKatnOqkSgXgHVjROkHiXTgZFwDXvXr4cSB+PHE7BovNdAPHuWPN9AwMJpmiZYYwMRyXB2bp/CnY8ld3U9Cpi/D0Nrt6VpPETNJS6Mm9vLn7jx4mVuv/0H5SdpcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434570; c=relaxed/simple;
	bh=Pu4XgZvXCLpyruGEB9barxynZlnKd2aziYl38H8bj6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mJDVkj2CX1GbxvMWImQHIasriXP1oP3KgOkb2WN3yjGd4aW11q/JqukLRJXOhBeqUpgnei7nnxlkdCBdww5AxgQiFx4UdC0lctyWxHTT77MGvKw8KdV13Y8oMjuUcYH/PF0gXPm5v9UTHb9GyynZ34uJ7a7HWYbILh/tDMp9JgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S3WqRZ0/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E7K1W4026029;
	Thu, 14 Mar 2024 16:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XNPHlBdYkUZSf1G1/L2zsqXGaiSzXuU1Y8qLYhyS7n4=; b=S3
	WqRZ0/A20poPzbK8ckE0we12pcGvjOAclaohWAMmHshCeaLBDCPzpYkBfLFf6LtA
	2soAtE9aSprHEhS5JtzeTb8guCq+cOXKgEq9GsxRQZ+t4ZnG/97DT6aJKvAv21H4
	UHURdywCKiJsbdNaFFwsV3rdHq7PUFAABhzyp2SSSsz/gRetJZAq+Cb3cL1K7k8D
	WXtaZGO+Yz64LRqe6OfC2StTWViv5yYwha1j8031PySwLpoupq4Z8EWf3vw1GhGG
	3y/y76V7wjxVEXRUHe3qHqj9PszQzQ6Hlbjh0gIalNadBsUqzYdmXIAyAUjLuBJ0
	2IohEjSLSu+e6ESFbyFA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wusxghjv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 16:42:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EGg9WK003821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 16:42:09 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 09:42:08 -0700
Message-ID: <50b2d162-00a1-4001-894b-d5560c4226b2@quicinc.com>
Date: Thu, 14 Mar 2024 09:42:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: iwlwifi: mvm: disable MLO for the time being
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Miri Korenblit
	<miriam.rachel.korenblit@intel.com>,
        <ath12k@lists.infradead.org>
References: <20240314110951.b50f1dc4ec21.I656ddd8178eedb49dc5c6c0e70f8ce5807afb54f@changeid>
 <20240314110951.d6ad146df98d.I47127e4fdbdef89e4ccf7483641570ee7871d4e6@changeid>
 <87bk7g4x08.fsf@kernel.org>
 <09ca997159333980a168051a2a49c675a8ad5eeb.camel@sipsolutions.net>
 <87plvwepjq.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87plvwepjq.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6jbGhKt9NOXLPI7f8T7XdVSOqNIWxqhl
X-Proofpoint-GUID: 6jbGhKt9NOXLPI7f8T7XdVSOqNIWxqhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=377 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140126

On 3/14/2024 9:39 AM, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
>> On Thu, 2024-03-14 at 18:08 +0200, Kalle Valo wrote:
>>>
>>>> -		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
>>>> +		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
>>>
>>> I think we should add the same for ath12k, right?
>>>
>>
>> It's really up to you, I think. I'm hoping to even get this into stable,
>> FWIW.
> 
> ath12k doesn't support MLO yet but I feel that disabling wext already
> now would be consistent from user's point of view.

Now that I understand what this is doing I completely agree. We should prevent
the use of wext with ath12k.

/jeff


