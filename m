Return-Path: <linux-wireless+bounces-7284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EC48BE0DB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 13:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202C81F24DD5
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA51522E;
	Tue,  7 May 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j7jGJq7q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB9152170
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080844; cv=none; b=VmpBQbUtO+icM83nNkXcB7v7A5dOLmQfzZKn8/bZ76373ZlyB5oIrYKXOYndlr3V16FOub9pKcZ5pGqR5482FsmicrIO/dsHJ34odgMTL9Jw4s8ouZzrtA7wi1tSifYcPGWZ6Zl8hxfIKe3o3+M0ktopF/8C5gNbtZ8GBiBIPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080844; c=relaxed/simple;
	bh=8O5DK7lqHd5v2k1czkNSES4P9wu933bk8ufARyH5dzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MbeLXfzascKxiqv4WHUy0mbLt6G3MPItePrWwf21/vQQgDeePBToMkFlr5jbzM7vQveI3iXrLJj3giLO143YFwU7tDuIHuNJ73aykN+3GJn8FItsYZNK2brzROQqjqIQOmThHLFWdV2zMeqmaTJswT1xZCRo0EmTvJkgwPzPw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j7jGJq7q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447AuYAR022792;
	Tue, 7 May 2024 11:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=StWBNV/pEUVac1VskfbognEZZQrm/yz5f41jUW5WZJM=; b=j7
	jGJq7qPC0HEppxXKzl9zrL7dL1lfBtV0koXgqD8MYun3x7oWb9IFtOsEbTbiNA1/
	wZoLnha1JYtNJQNHvBCEv7EZwwKc2JIkE98hWlqCc/moxJJXL6nHEWF00zAVSuCb
	WoZGv+MaVMsQYTZGku/86TPFPm/WfgU0aTjmVcNzN6PPq+K3oas8bcoD6+pE+ARs
	UVeQcje+Fbsw19JAudd0MVoN6h+9Qb+M10sKZM480RYH5xkoArBVzZQ+pkjVgjWz
	p+gwllYGYtZ14hZ0xTYu3m5VM1veiF3Ksp9OxVx6EL0PvUigVYp3Je6zSu5nls5q
	c+GzltgRObRCfBJbB3Rw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xyj5h85bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 11:20:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447BKWhE010498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 11:20:32 GMT
Received: from [10.253.76.74] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 04:20:31 -0700
Message-ID: <430d0e14-bc60-4872-ace7-2328532bcfc0@quicinc.com>
Date: Tue, 7 May 2024 19:20:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] wifi: ath12k: remove redundant peer delete
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240429081525.983-5-quic_kangyang@quicinc.com>
 <171507720282.3827098.15356808712274335251.kvalo@kernel.org>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <171507720282.3827098.15356808712274335251.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UDh7yU130P7CtqozbWGj4OOp-NGvpfFf
X-Proofpoint-GUID: UDh7yU130P7CtqozbWGj4OOp-NGvpfFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_05,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=909 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405070078



On 5/7/2024 6:20 PM, Kalle Valo wrote:
> kangyang <quic_kangyang@quicinc.com> wrote:
> 
>> Firmware will create internal peer for monitor mode. For host no need to
>> do peer create and peer delete.
>>
>> So remove related code.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> What about QCN9274? The commit message doesn't mention that at all. Is it safe
> to assume that QCN9274 firmware acts the same?
> 


The first judgement 'ab->hw_params->vdev_start_delay' only works for 
WCN7850. It won't affect QCN9274.

Sorry, i should mention.


