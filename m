Return-Path: <linux-wireless+bounces-14114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537219A18E3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 04:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98B5B257E3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 02:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4B257333;
	Thu, 17 Oct 2024 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cUf+g8/M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387224D9FB
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133776; cv=none; b=jU2ZNKG+m2JnToedJs2zeOUM+krxUdIBpWb8LW7+f8UWdYJg4ykMWSW/sLTWXPBGS8ug5riXFy8ewyAACp5Z1M/b6wnbV6Xb+q2YJq8sklKPfX268VQjdGbXX/hJD12wUBFCTykKhXkfqg7shWe5u67UeNwO8OAtLTawSRnXkAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133776; c=relaxed/simple;
	bh=LITkRrYs7O8ghmQYp7bWD/78zlgl6Fa21AsE8eee/DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CK1nuXwWHspqEWJJzmn4QnQMrJ8rSgGWQtHuqEXoLnsRL5VMkgQVRHzPm8TSsuao7XiAKu3m98cTL1o6kGu9p8CIF9Q4/6lCRsUscPBm4zC1ygOk2RGB7aQ8B1j8Dava9ge2K7jfWZoHwHfB60/h3Ruk9XMwQdDAnEZMv3Vp2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cUf+g8/M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GF462Y031206;
	Thu, 17 Oct 2024 02:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BRkTC/BajiIEZ93+ZobX6Y7gXi9VmeUy82YGR1xdh3E=; b=cUf+g8/MysIr8BLR
	bGzOvrQmG+l9oQ/RAm07td+AF4hnfbKPeY3pIj0PvyezsaFay/9qPptyH7DgOPfm
	SyveLcv5yEfRA0ziifXulUlsLZQpty4DAAy8dQg0IRRxVYmUvtypHymI+S+O7Avi
	WQS5pqkQHCxy8NtgD+xIGKc3Ni42oU0XvYm0R3MMilkf+xt8h7bwmwuu1VtU4S+e
	aXqJUvfmshmEukhZElJD1y1etkj3YhrKuLiO4d52xxP80X5X0bqQmB9UR+F8X82l
	CXud7PP10tbjA2juhy1wV7vcbvyKYNxEUUKtaD3N5dCrSVAky6UQKcZ9Oe9llsN0
	iaNF+Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a8nq352e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 02:56:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49H2u3sw008956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 02:56:03 GMT
Received: from [10.253.11.179] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 19:56:02 -0700
Message-ID: <566978ea-3542-4306-a71a-ea4051937163@quicinc.com>
Date: Thu, 17 Oct 2024 10:55:59 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] wifi: ath12k: MLO support part 1
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
        Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241015171416.518022-1-kvalo@kernel.org>
 <172909314915.475660.17863446001052139312.b4-ty@quicinc.com>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <172909314915.475660.17863446001052139312.b4-ty@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WeLGLsaj3gg-ayCq4U3WXOtMXvgZPqS_
X-Proofpoint-GUID: WeLGLsaj3gg-ayCq4U3WXOtMXvgZPqS_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=698 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170020



On 10/16/2024 11:39 PM, Jeff Johnson wrote:
> 
> On Tue, 15 Oct 2024 20:14:05 +0300, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> I'll start submitting patches for adding MLO support to ath12k. There will be
>> several patchsets and this is the first one (of many).
>>
>> In this patchset we start refactoring code in mac.c to support multiple links.
>>
>> [...]
> 
> Applied, thanks!
> 
> [01/11] wifi: ath12k: prepare vif data structure for MLO handling
>          commit: 3dd2c68f206ef7020d12b9f85cbfe05ca8662cf4
> [02/11] wifi: ath12k: pass ath12k_link_vif instead of vif/ahvif
>          commit: 005fe43b93dedb621a0827408051f3a51d7a0769
> [03/11] wifi: ath12k: prepare sta data structure for MLO handling
>          commit: b89b5dbea65294e660f26e90d51ec786a7fdccb9
> [04/11] wifi: ath12k: prepare vif config caching for MLO
>          commit: 84c59710829411d4ad344cc6cd8a0fb2d9faa104
> [05/11] wifi: ath12k: modify ath12k_mac_vif_chan() for MLO
>          commit: abaadb934b30ec86065e9c8a23843d7bb8be0064
> [06/11] wifi: ath12k: modify ath12k_get_arvif_iter() for MLO
>          commit: 94a2712f0b152739d1f506977fc38be0da37610f
> [07/11] wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO
>          commit: afbab6e4e88da68cca94cabfc1604d71db161d42
> [08/11] wifi: ath12k: modify ath12k_mac_op_set_key() for MLO
>          commit: 25e18b9d6b4bfd9cb3dd32e7b081eef306cd2517
> [09/11] wifi: ath12k: update ath12k_mac_op_conf_tx() for MLO
>          commit: af41f908c9e4d3358b5753648e669114d9109004
> [10/11] wifi: ath12k: update ath12k_mac_op_update_vif_offload() for MLO
>          commit: f4adb07e0a524a35b34397ad08d0199cfe2c450f
> [11/11] wifi: ath12k: modify link arvif creation and removal for MLO
>          commit: 477cabfdb776b571fab425813c074f30c02a5cf6

Hey, i will do rebase for 11d scan and monitor patch set.
Has a lot of conflicts with MLO work...

> 
> Best regards,


