Return-Path: <linux-wireless+bounces-12489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C04096C14F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 16:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A2D1F21390
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51571CCEFC;
	Wed,  4 Sep 2024 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FJTFNQvm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38356D529
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461624; cv=none; b=YP5kUdQN4WVLdAkJWBrMhQmKX3Y8hyPCo5NcccAD9TscKIv2qRYuDZgfbzVVJxuy1zIxZmcOBWL5iPh2JDTdZ5dBm43IfvyTgwK6l/a0h6J769huqXL94pJfwyoH/TDeEwzpuSLHiWarFIkM1UUt1T2rq23Fm8K5Nkldqk+DWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461624; c=relaxed/simple;
	bh=bzXYJNDC2n/3v4vNHcy7pIUKvGJL+I2mj6HHW8J0UNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pv4GDhwBW0QuZxeaoSV4Tv4ihPYq4xlQWGeIH29L31scHcIKoUdh4FIMjVEcPGWB98aDb17TsfztbgOKtLVMycpQ38/2WZkDd/62P0YLaXXyjcfZATZAjn/JHm0CsM4oQPkzjEb/0k9PZobmnT5F5IpyJxD89S+/AS0fTZu9bIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FJTFNQvm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484AkdbX026179;
	Wed, 4 Sep 2024 14:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1bg5a57la6f9J9Gvu3mgYapUsthkNaC1YKvue2oEMhE=; b=FJTFNQvmIjrFIxyx
	qWAkJmqkCp7WU5KOtaPr32b1y6oj+RQPt1dZeFLRAlc0jaz3jxUg4Dk/mFkQ2cuJ
	ry3v+doWJmtWjNT8UuNc5ofAy8AXeHMjL/rk7u4IrVTEY6zthpl4IlmuQjo36FV2
	r3iFjygU+pqq7jJxG7mE14ea98H4vTWhwOpmlldyH2kt/ljQhfgOlermgnQCle8M
	zEY8QEC9Mhsm4k2IHHeQvMZiNKAnnshDpJbH7447PJQvhVO9aFfxSjpTOVVhp5rY
	f2mOIl3+1dH4G00VhF+c0BuX93R7c1573ZbskaY/QvIG6shqSG2ElfQjN3jF62vP
	glAniw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt6735rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 14:53:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484ErXZ1003565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 14:53:33 GMT
Received: from [10.111.180.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 07:53:33 -0700
Message-ID: <0bab22f0-e5a4-49ac-8265-910ae9380add@quicinc.com>
Date: Wed, 4 Sep 2024 07:53:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wireless: ath9k: eeprom: remove platform data
To: Kalle Valo <kvalo@kernel.org>, Rosen Penev <rosenp@gmail.com>
CC: <linux-wireless@vger.kernel.org>, <toke@toke.dk>, <nbd@nbd.name>
References: <20240903202713.471489-1-rosenp@gmail.com>
 <87jzfrkfn7.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <87jzfrkfn7.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8zafkXhIWlMIxwGSA3Ew5vZQEXQoKSj4
X-Proofpoint-GUID: 8zafkXhIWlMIxwGSA3Ew5vZQEXQoKSj4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_12,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=885 lowpriorityscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040112

On 9/4/2024 1:05 AM, Kalle Valo wrote:
> Rosen Penev <rosenp@gmail.com> writes:
> 
>> There are no more board files defining platform data for this driver and
>> eeprom support through NVMEM has already been implemented. No need to
>> keep this old functionality around.
>>
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>  As an aside, the last user of this functionality downstream in OpenWrt
>>  has been removed: https://github.com/openwrt/openwrt/commit/7ac8279bd
>>
>>  drivers/net/wireless/ath/ath9k/eeprom.c | 12 ------------
>>  1 file changed, 12 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/wireless/ath/ath9k/eeprom.c
>> index efb7889142d4..df58dc02e104 100644
>> --- a/drivers/net/wireless/ath/ath9k/eeprom.c
>> +++ b/drivers/net/wireless/ath/ath9k/eeprom.c
>> @@ -15,7 +15,6 @@
>>   */
>>  
>>  #include "hw.h"
>> -#include <linux/ath9k_platform.h>
> 
> What about the file include/linux/ath9k_platform.h? That should be also
> removed, right?

That file is still used by other functionality (see init.c, btcoex.c)
But seems that at a minimum unused eeprom-related stuff should be removed from
struct ath9k_platform_data.

Please review that all of the platform-related code in init.c is still needed,
especially code related to eeprom support.

/jeff


