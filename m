Return-Path: <linux-wireless+bounces-12573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A0096E78D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 04:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10DD1C22EBE
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 02:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3603F335BA;
	Fri,  6 Sep 2024 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aSYVqzDB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991732C8E
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725588535; cv=none; b=Bb1L5ASkv+BhyKxX+rji+o5k6uKlVEU/LObAcXgo6GFax7o+I2De22pWdOwgmnWN04wA+rt3WzOVuHYfiX+x+f6tjJENbSAOy5ZbDb0aCljTgHIZnwHX6hFjZO/TmfaO5yVqP2RbK+ZO8//ibsUPZhZxz1uazSJHosCSddMDVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725588535; c=relaxed/simple;
	bh=iDukbhPkxZgAmYVUUywr9pVGGkRRMmsk3q4c4qB6ZDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GmoYAMawTqmVlcfeFiM3SqEjHuaL4TlsoiMdPipKwDGMA7KsDqwsSuGjia9Sl8hvZh4xlB6vs5xQZwZNvFesBYya4RTIl+DLhV+U/JuWmx2bQx+zPsOYZ1qkNhvt9yuiXmi/O8lGyLZ94jcN5xOt55woLY/GXl0n58SS5yzaW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aSYVqzDB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQlpB008896;
	Fri, 6 Sep 2024 02:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9ByX8dWgLyyDLB0irOMULjt7eqTDhlWWdMhSFOnG2Ms=; b=aSYVqzDB8Cb+DTsb
	aTkHiJvIow4jlYJJOJHV6579P5LIeH40dMyC0AQQE4BdujEaeYTmk/Nbrle/qzAr
	d4fEg6RjcmDO2rtUmXDSgItkgWt3r47qr4uyAm7ldA2d9BFJv8OmseRMUW79+qsw
	JnqPo2mv/k1IUcNi3MrPKSRt6Klq769Cd/kqHXOe5xpsIO2WAtHkxtbyLRoFivre
	GI+osPGtSyA7v7NvUP5cbEu0lhmSuouCzQwjzNd1GgQc6TJMgdx8UsZFWQX1hUxJ
	rl8btsG5qczecTH55bcGxPecgzJsnJtb2ClbRqchcU4WLICP5tyYKQfbrHv0Syjy
	77hBoQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhx20sm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 02:08:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48628i7I016868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 02:08:44 GMT
Received: from [10.231.194.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 19:08:42 -0700
Message-ID: <0daaf053-0b27-43ab-bd3b-634b25b40f25@quicinc.com>
Date: Fri, 6 Sep 2024 10:08:37 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: support DBS and DFS compatibility
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240829064420.3074140-1-quic_yuzha@quicinc.com>
 <1e53e441-7539-4db3-89f2-3563667e2cff@quicinc.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <1e53e441-7539-4db3-89f2-3563667e2cff@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Q7JkPU3aBGJjUFeVOqku8OJ5mkz3Wd1k
X-Proofpoint-GUID: Q7JkPU3aBGJjUFeVOqku8OJ5mkz3Wd1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=554 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060015



On 9/6/2024 2:59 AM, Jeff Johnson wrote:
> On 8/28/2024 11:44 PM, Yu Zhang(Yuriy) wrote:
>> Now some chips which support 'support_dual_stations' will enable DBS,
>> but will disable DFS. Restructure the ath11k_mac_setup_iface_combinations
>> function to support DBS and DFS compatibility.
>>
>> About 'support_dual_station' feature can refer:
>> https://msgid.link/20230714023801.2621802-2-quic_cjhuang@quicinc.com
>>
>> Add a ieee80211_iface_combination to support DBS and DFS compatibility,
>> one combination can support DFS(same with non dual sta), another
>> combination can support DBS. When running different scenarios that will
>> use different ieee80211_iface_combination due to mac80211 will go through
>> all of possible interface combinations.
>>
>> In addition, maximum number of interfaces of these types should be total
>> allowed in this group.
>>
>> The chips affected are:
>>
>>   QCA6390 hw2.0
>>   WCN6855 hw2.0
>>   WCN6855 hw2.1
>>
>> Other chips are not affected.
>>
>> Tested-on: WCN6855 WLAN.HSP.1.1-04402-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1.
> 
> nit: should include the hw type tested on, see:
> <https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches#tested-on_tag>
> 
> if you can reply with that, Kalle can update the patch in the pending branch
> 

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-00410-QCAHKSWPL_SILICONZ-2
Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.1.0.1-01161-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 WLAN.HSP.1.1-04402-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1


