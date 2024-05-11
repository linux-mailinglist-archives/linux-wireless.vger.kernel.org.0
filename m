Return-Path: <linux-wireless+bounces-7498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0016D8C2F24
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 04:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E1A3B20FDA
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 02:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296621106;
	Sat, 11 May 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UyRprLxk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3991843;
	Sat, 11 May 2024 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715395860; cv=none; b=SuIxyncvQmBll/3tO507Gx9sqyVHepeUVhYjNnt3oMteTUGvdH3WYY1yRyJmdVAkn0DNRZTT7/c5jcLZlxIC9HjlhQyR+Ah3Q6KgHe6lec6Mi4qphe+Qf42vATm7L2dQUJgom5so/JuQ66MFt9gY3ovfMh6JiEzFdVW8gvFBHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715395860; c=relaxed/simple;
	bh=l7yFDr9qTYbTJV16yHhPyvkg1eaq22fWqFACR5S7RkU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CiNa+yxIv3CV6GGfAgj/6hlOIIQJ8h1WdS1gLZC9/Ov1KgyiVE8Q4Si82y6dV00I0G0FMygxCnMyO0OkO/AWP5nQzTNKCICUjSx+DUBpV8IEksvb0o5z1lsErgG3a3QF+HjCrJUV4oSwYRw7N7a0EctZZ/85VRMauJjCu+oB3vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UyRprLxk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44B1oCG8011434;
	Sat, 11 May 2024 02:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:cc:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nQKzXWC6ppx+6MllNXSbbJaAbYoPLAQn1w7SipaJxC0=; b=Uy
	RprLxk+udaFk16txGvMUlTsJJvmTQ+KJj0tJP30L/c6Xk2rUXIErLejfSKH3xMp5
	bHvBhMqPH80f3OR9ayadbqq0WiY7JufW/FFlNqP7horO+YWerpMGKYAsOfFT24dh
	rOFiAjc5umvo1oQaKf/n742QRzrHH5fxXM1dfjsqk9rK3bjEHqlSrtxW0shBTJ+4
	WkmMwPE0zaqY+Qw6muaRmp37Iek3SZjGtdIU7bBCuxPLYPTz0ip9p3FK0BGppRjP
	cZCBq8SncJOXLRx/89xbA8zjYRhTj2sdzSoLoV9sHVQMhSujwzoWxyTecbYT0kNj
	/qWWplLUjC42CDp79fZg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1ybx01yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 02:50:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44B2olNB004390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 02:50:47 GMT
Received: from [10.253.8.22] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 19:50:46 -0700
Message-ID: <88af0514-d618-4a47-94d4-163b0e58b9f2@quicinc.com>
Date: Sat, 11 May 2024 10:50:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <quic_cjhuang@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
To: Luca Weiss <luca.weiss@fairphone.com>, Kalle Valo <kvalo@kernel.org>
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
 <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
 <D15TIIDIIESY.D1EKKJLZINMA@fairphone.com> <87jzk2km0g.fsf@kernel.org>
 <93c15c59-f24c-4472-ae7e-969fd1e3bfec@quicinc.com>
 <4d60ccf3-455d-4189-9100-d35488b00236@quicinc.com>
 <D15ZZ5V3YU6Z.10FO9XK11WXFB@fairphone.com>
Content-Language: en-US
From: Carl Huang <quic_cjhuang@quicinc.com>
In-Reply-To: <D15ZZ5V3YU6Z.10FO9XK11WXFB@fairphone.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fQYglQo8Rf-s60w4UhR-OSnk24GZTlDt
X-Proofpoint-GUID: fQYglQo8Rf-s60w4UhR-OSnk24GZTlDt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_18,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1015
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405110020



On 2024/5/10 21:26, Luca Weiss wrote:
> On Fri May 10, 2024 at 3:04 PM CEST, Carl Huang wrote:
> 
> <snip>
> 
>>> Kalle, looks we're not able to fix it before Sunday as I don't have
>>> WCN6750 setup to verify the fix. The fix could be to define a dedicated
>>> function ath11k_init_wmi_config_wcn6750() for WCN6750. I'll send the
>>> patch out so others like Luca can have a try.
>>>
>> Sorry, I have problem to run "git send-email" as it prompts "5.7.60
>> SMTP; Client does not have permissions to send as this sender".
>>
>> The patch looks like:
>>
>>   From 19bb7f1377a5e3c5d42ab2bedbaf9e976c1068b4 Mon Sep 17 00:00:00 2001
>> From: Carl Huang <quic_cjhuang@quicinc.com>
>> Date: Fri, 10 May 2024 19:40:37 +0800
>> Subject: [PATCH] wifi:ath11k: fix WCN6750 firmware crash
>>
>> WCN6750 firmware crashed because of vdev_number changed to 3 from 4
>> in commit f019f4dff2e4("wifi: ath11k: support 2 station interfaces").
>>
>> Fix it by defining a separate function ath11k_init_wmi_config_wcn6750()
>> for WCN6750 to initialize its' specific parameters.
>>
>> Fixes: f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces")
>> Tested-on: WCN6855 hw2.0 PCI
>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>
>> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> 
> This seems to work fine also.
> 
Thank you Luca for the test.

