Return-Path: <linux-wireless+bounces-18880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45D0A3351E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 03:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851157A312D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 02:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD8A145348;
	Thu, 13 Feb 2025 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R+uVJyUf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D5143C5D
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412307; cv=none; b=LFPVCFeKlad7DTZ39fNSq/U0Qmoe6Vv48Y/HNJyPu/V1LFwebiwTRO1o11rpzR+h2iDaYUnUATBfJQied62HKwkWjQT4chQsX8iauO3dAVHlqmQDdbeFdW7UelNYIK8hDAup2Hls9Lzit9KZCQaW9VUzqD6HX5/eTigg9zX15kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412307; c=relaxed/simple;
	bh=qDiV3iB8BbclBWN2cb7brTK+3b8CnyiePVaRncsTfmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n99xFWzoL1ZSzzWIaSeimLq5O0TKz2qdEec4+DsT3F0y0JZH8u68VtQu1OsF7j6zF5rJXqUi0BPc6a4NpQNqO0XP2FWzfIcn11zjgmUJHmugblJvNuKDakOQgIKRlzDJ1RMsqa6RVNzNgvdGcEdJTed7AVMhLsszztQMawlzB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R+uVJyUf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D1rSrG010369;
	Thu, 13 Feb 2025 02:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ju1CUxdi9qHgTtG7ye6LU9jXq3SmZNCoz31/czRX4eQ=; b=R+uVJyUflZcqLA52
	Zt7zkyA3t74I+5yiM2saixu/f6rU6Vj7A5155NHGyDB/t+AVqjHWMCJw2kBH47zt
	QAPdFd6/773fJc3jDZFHGejZOuXIg/7V3BxRpC9KUtVc2kw7tEO79LznhWkzepLw
	p77BsGwEQT2maSDOWeT2nUUIkHv3zfMRnRdz8a2eUl1RxAOdN6PGrYXlrd96+OIk
	0F7csGP4DwrXSkvQibAk6QyOWwfeO/rikIu33xX9gUZd8wkJg3YdKubl4RE4lOnN
	rNA5rQ/HnDZgEX6M+8uMDG6RR5lS/eu4lQlCA9iyJAJFd7tDTduXqZTfvdZxyXvB
	0Z7djA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qcs5hn9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 02:05:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51D250SU003474
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 02:05:01 GMT
Received: from [10.110.103.217] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Feb
 2025 18:05:00 -0800
Message-ID: <62873a7f-d62a-4594-a7f8-c29e1df0aa30@quicinc.com>
Date: Wed, 12 Feb 2025 18:05:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/6] wifi: ath12k: add 6 GHz params in peer assoc
 command
To: <mbizon@freebox.fr>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Avula Sri Charan
	<quic_asrichar@quicinc.com>
References: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
 <20240508173655.22191-5-quic_pradeepc@quicinc.com>
 <600e45a74fc3ca1bedc12c273a84966fdfa3d908.camel@freebox.fr>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <600e45a74fc3ca1bedc12c273a84966fdfa3d908.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mFZklj5tV6q3-N_CiL_zCxA0-wQcfs7X
X-Proofpoint-GUID: mFZklj5tV6q3-N_CiL_zCxA0-wQcfs7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130014



On 1/23/2025 3:35 AM, Maxime Bizon wrote:
> 
> On Wed, 2024-05-08 at 10:36 -0700, Pradeep Kumar Chitrapu wrote:
> 
> Hello,
> 
> This patch has been merged, but there may be a bug here:
> 
>> +       if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
>> +               arg->bw_40 = true;
>> +
>> +       if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
>> +               arg->bw_80 = true;
>> +
>> +       if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
>> +               arg->bw_160 = true;
>> +
>> +       if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_320)
>> +               arg->bw_320 = true;
>> +
> 
> 
> Downstream driver does this instead:
> 
> if (sta->deflink.bandwidth >= IEEE80211_STA_RX_BW_40)
> 	arg->bw_40  = true
> [...]
> 
> 
> So for a 320Mhz STA, bw_40/80/160/320 are set, resulting in multiple
> bits WMI_PEER_xxxMHZ set the associated WMI command.
> 
> Which one is correct ?
> 
> (This is for EHT, but the same applies for VHT/HE code)
> 
Hi Maxime,

I noticed that currently only one of the bandwidth flags is set in the 
driver. I am inquiring with the firmware team to determine if we need to 
set multiple flags from the driver. I will update you soon and, if 
required, will post the next revision.

Thanks
Pradeep

