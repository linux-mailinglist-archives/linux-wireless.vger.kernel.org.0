Return-Path: <linux-wireless+bounces-5373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 325DC88EB6A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 17:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA991C21EB0
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90264131BBB;
	Wed, 27 Mar 2024 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YEFIF9rs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6DB131BCA
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557417; cv=none; b=ZQA6qiUng7YNW75Yhb45zpCfBD1E8R5C3ioVoAxM3ZAvHIc1j+TprtMKDoqwtSFl14hFXBLwPFI2GzFakoZa1rsHonuuT7ANxn3sTwem75URnbsrY5Eq3tsdNs4bINIWj+jwbqKws2mJTbWmVfOXnOIxyGP234kQVh82OszZBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557417; c=relaxed/simple;
	bh=lzYy8Kji+MK52RfD99/YmEqnoRSMUk9wNGQoVEHsg08=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rb3Fld5c6RuN9y7TJbPhRJNRlEiuWC/jfGwHduzsbCRtBie3rTLQSXSbC7ZaxZHQYL7cDkhdUhN9R5f2+Zv+xXRh51fJvxtqgUetnaH2qiO4tfDipMr4JAH0hknR3VeFGn5ScdGClWhOCQ5LHZ7x2rfRyB0I2R1tUzkmtjphVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YEFIF9rs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42REWK9n012346;
	Wed, 27 Mar 2024 16:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xgtWmVEsDFLcu1A8EvEyTLzh6xkczJ80UK97IYO3b44=; b=YE
	FIF9rs2kJbgWr5BufWJQJqHp+FA7easj3orBx/bfMVM0ByazNKBvmufOINhTlNDd
	Bn5tLRyPfSO9MDhFWL9F7HnmOEynRmn84vX7cFS2FdKD6iWBbtnEitQNSHBFOBHe
	CEIYm09NgJAHZdwvyLPHhD4hUe/nlkXJoLG/QLh/zibEYOQST7thq2DUqZKihKqk
	KjvglRCT5qtSiZF4FFzaMQGeO/3BQJvl+C7c5G5Qy38ncIfO+/0/y2dGMufS0Uub
	OM/q9qGfbFx12gul6GLVnJFB7yc337/NAXSZKO0xEQMsm+gDa6QRdgyOfxSGKXFW
	uXltokcV5n09rbi55NOg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x477yteds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 16:34:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RGYaRk009216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 16:34:36 GMT
Received: from [10.110.28.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 09:34:35 -0700
Message-ID: <d0cfe92b-c696-4a60-9eaf-f81f6ee5e75f@quicinc.com>
Date: Wed, 27 Mar 2024 09:34:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] wifi: rtlwifi: Add rtl8192du/table.{c,h}
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>, "kvalo@kernel.org" <kvalo@kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <ed50254c-889e-4dcd-93db-f63b776e3503@gmail.com>
 <5170c29a7b565fdec2e004f9391d325328ef5a72.camel@realtek.com>
 <8a90f3cb-7218-4f23-8aa7-fcc68e2f4a93@gmail.com> <87y1a4yqvh.fsf@kernel.org>
 <5d117cf09134b034e704b8a1b5167235963a9c88.camel@realtek.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <5d117cf09134b034e704b8a1b5167235963a9c88.camel@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g_GTkgKKqoMRmI0Bnie5l2JJdgqq-i_j
X-Proofpoint-ORIG-GUID: g_GTkgKKqoMRmI0Bnie5l2JJdgqq-i_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_12,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 mlxlogscore=687 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403270114

On 3/27/2024 2:30 AM, Ping-Ke Shih wrote:
> On Wed, 2024-03-27 at 11:18 +0200, Kalle Valo wrote:
>>
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>>
>>>>> --- /dev/null
>>>>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
>>>>> @@ -0,0 +1,1675 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/* Copyright(c) 2009-2012  Realtek Corporation.*/
>>>>> +
>>>>> +#include <linux/types.h>
>>>>> +
>>>>> +#include "table.h"
>>>>> +
>>>>> +u32 rtl8192du_phy_reg_2tarray[PHY_REG_2T_ARRAYLENGTH] = {
>>>>
>>>> static const ?
>>>>
>>>>> +
>>>>> +u32 rtl8192du_phy_reg_array_pg[PHY_REG_ARRAY_PG_LENGTH] = {
>>>>
>>>> static const ?
>>>>
>>>
>>> I can make them static if I move them to table.h. Only phy.c
>>> includes this header, so that should be fine.
>>
>> Do note that .h files can't contain static variables, otherwise there
>> will be duplicate data.
>>
> 
> Indeed, so these cases should be 'const u32', no need 'static'. 
> 
> 
Or make them static and have accessor functions to return pointers to the tables

