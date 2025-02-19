Return-Path: <linux-wireless+bounces-19136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B216DA3C631
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 18:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3353B2DB4
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF0213E9E;
	Wed, 19 Feb 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CgZxCEa7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8A286284
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986031; cv=none; b=P9dvolCZpblPQubGNwl3yfhvDHIz9WuGGaceL+lQc2CyRbTvV+7i2h5ZaYYzR9pNXaHcd0snzXX2IHE7WKa1y9j+rorjQbePN6UIqFBd/UB9l+Tbnt4awg9GzaNzoOzg6EF0A4mjBlfFbw3HiKuSKCzq88y1v2tUvZFoKEv7LGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986031; c=relaxed/simple;
	bh=1gYEnJ9vO9t+TfHsveW+FEXXReg2KFASGbzlwKgEWw4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Rkz4ohCcQVQUTa253Pk7SAKDNPCuFSdvK2oyVY7Sk4h4n38mUF43aSMIEaoOwYrj4aEzix3HeDE9xkWiEV2Otsz8eLyjz7QI2kG9utBO/oJKaaDySDa4dSqumVIX3ZxDICkn+zgDXPh+iXLf8UDApAzNRMeDBzmhfz8kTgYZabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CgZxCEa7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JGjENa031904;
	Wed, 19 Feb 2025 17:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NicJPxFZVFMslzB4MjZKlpt7ZkRqlSicXMOAsPiZtrw=; b=CgZxCEa7e4Kf35G/
	PqBfVCvESSZuIyCcuoY+lwASTDH/eYpidalEXydaWCPSzDZzA55AgUQ9LJsH/MPn
	UFRCmT5daloHIc/yfsFvhBlx7slUgvuJK9xbK3gVCMuRSYBoaJm/x2YrnrUmGvRL
	Q5MaZVkIf8sMyIijTlY6ARiLBZNNvd2ce6+aBcvHhsPZjTI9psy8Ab2hskPEifUa
	4yC9Vv/zUB2UHU9e/Jr/OnGKwFWqiqJSsocVxnnojS8+/Cl1ePCvKINnUVRcE3Pl
	ZQU1neCZxSnE3gLQb/pUM5oOOEcXs7XahSCVRidPNGS4FdzWKgXaghE3VKGQu1xU
	zgOuIQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy5bec9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 17:27:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51JHR39H013534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 17:27:03 GMT
Received: from [10.227.108.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Feb
 2025 09:27:03 -0800
Message-ID: <5618e86b-88d7-48e7-aeb9-5c4feabf04a3@quicinc.com>
Date: Wed, 19 Feb 2025 09:27:02 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/6] wifi: ath12k: add 6 GHz params in peer assoc
 command
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <mbizon@freebox.fr>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Avula Sri Charan
	<quic_asrichar@quicinc.com>
References: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
 <20240508173655.22191-5-quic_pradeepc@quicinc.com>
 <600e45a74fc3ca1bedc12c273a84966fdfa3d908.camel@freebox.fr>
 <62873a7f-d62a-4594-a7f8-c29e1df0aa30@quicinc.com>
Content-Language: en-US
In-Reply-To: <62873a7f-d62a-4594-a7f8-c29e1df0aa30@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SuOucCGuPbmPkFkNXgoEO-3Pnu6JfTy2
X-Proofpoint-GUID: SuOucCGuPbmPkFkNXgoEO-3Pnu6JfTy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190135



On 2/12/2025 6:05 PM, Pradeep Kumar Chitrapu wrote:
> 
> 
> On 1/23/2025 3:35 AM, Maxime Bizon wrote:
>>
>> On Wed, 2024-05-08 at 10:36 -0700, Pradeep Kumar Chitrapu wrote:
>>
>> Hello,
>>
>> This patch has been merged, but there may be a bug here:
>>
>>> +       if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
>>> +               arg->bw_40 = true;
>>> +
>>> +       if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
>>> +               arg->bw_80 = true;
>>> +
>>> +       if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
>>> +               arg->bw_160 = true;
>>> +
>>> +       if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_320)
>>> +               arg->bw_320 = true;
>>> +
>>
>>
>> Downstream driver does this instead:
>>
>> if (sta->deflink.bandwidth >= IEEE80211_STA_RX_BW_40)
>>     arg->bw_40  = true
>> [...]
>>
>>
>> So for a 320Mhz STA, bw_40/80/160/320 are set, resulting in multiple
>> bits WMI_PEER_xxxMHZ set the associated WMI command.
>>
>> Which one is correct ?
>>
>> (This is for EHT, but the same applies for VHT/HE code)
>>
> Hi Maxime,
> 
> I noticed that currently only one of the bandwidth flags is set in the 
> driver. I am inquiring with the firmware team to determine if we need to 
> set multiple flags from the driver. I will update you soon and, if 
> required, will post the next revision.
> 
> Thanks
> Pradeep
> 
Hi Maxime,

Currently, the firmware sets all lower bandwidth flags based on the 
highest bandwidth set. While there is no harm in setting all bandwidth 
flags, this may not be mandatory. Please let me know your thoughts.

Thanks,
Pradeep

