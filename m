Return-Path: <linux-wireless+bounces-13682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 692E8993E3D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 07:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82072860E3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 05:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C6F13A878;
	Tue,  8 Oct 2024 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KHWGd3SL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3B7DA87
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 05:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364481; cv=none; b=Cp35F3VcYsElcl0nGy5VaRxJzMHD6E0biDLREhlr0s3sKDzbQHWcuWZqlvtdgxoMwFw7wIJMSCO3Q0hM7z7s5+NTrV+yxKCPXh+pLT+M8vdLJEBEgsoVMqiZyPFHTT3eaOLqF0Q2Ojf/KXMRn3KfWgAXBYv3criVGTWAckb+lGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364481; c=relaxed/simple;
	bh=aZWT/kSqmJ0QkjU/ZC4697RNpMjQJPRiRqJUxHHpP/4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=He9X/boY6+NBoFBxrQDs1zESQ/b3bqobMYTc3FG8hCkigTMy9dMLKuMNdZJihB8dFCs/MIpoUMmtNfuuaPhWMD3VS7JxaWHjYuiJqCuvImjWnEP3ePM/baU+9UK2XpZOKbuat58G6ypFEDQ4U2Koo8VHwoXnT/v5KjHIlnsbQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KHWGd3SL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4984SZBA008688;
	Tue, 8 Oct 2024 05:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wD7zD8w10mP+ohQu4eNgrzKSlFKA0Lx5UXkzDpOElak=; b=KHWGd3SLQvR6WrDe
	UCXCExlvmmO+FvAOerj2VJ4YeG4Zstl00Wjkgv3crOlvyeGx/cU+5aQGE+VdvYlq
	vXGjj07rc2XBr/meDAFP1e/lVUBRzsT24fmJMaqGcABmksAl5GCDqkz5ioukXwMR
	adbZFA8j1jKiful7+HjicACUPOmuB1PtaGTbqS4G+98dI56AY2ViOPnjXn03lQKN
	s+pVU5mi+sWGezLjkLCkMFCNjfOIQIFl/Br9mKjHilq9VIXCbungMlyDptbFNBis
	UrWJq5I4HsHN/qfRggSKEvkjgKwje7P/ztq3EgRdOMav09171FKstgwBHym+j0kE
	mLhmzw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424wrc02pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 05:13:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4985DwhX026392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 05:13:58 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 22:13:56 -0700
Message-ID: <97054998-0793-4c71-a202-dd5167fcc24d@quicinc.com>
Date: Tue, 8 Oct 2024 10:43:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mac80211: re-order assigning channel in activate
 links
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20241001085034.2745669-1-quic_adisi@quicinc.com>
 <93df47a867ee1f8d84cabdbc953707eab2ea3704.camel@sipsolutions.net>
 <6504caf7-e9d5-49ff-983e-73335f8ee3a1@quicinc.com>
Content-Language: en-US
In-Reply-To: <6504caf7-e9d5-49ff-983e-73335f8ee3a1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DvIQ7wmkr1Xeun-pdkoLMdcUppB3sF4o
X-Proofpoint-ORIG-GUID: DvIQ7wmkr1Xeun-pdkoLMdcUppB3sF4o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080032

On 10/1/24 15:49, Aditya Kumar Singh wrote:
> On 10/1/24 15:29, Johannes Berg wrote:
>> On Tue, 2024-10-01 at 14:20 +0530, Aditya Kumar Singh wrote:
...
>>
>> which sort of indicates that we're working around it, but it also
>> correctly says that we cannot activate a link before we have the (link)
>> station.
>>
>> In the flow as you changed it we'd activate the link in firmware before
>> the stations are added, but that isn't allowed. There's not really a
> 
> Is this a generic expectation? And that too only for ML STA? Since at 
> least for ML AP, we could have links in firmware active and later when 
> station connects, we create link stations.
> 
>> good place to hook into after the station is added, unless we somehow
>> want to activate the link from the station change, but that seems ...
>> odd to say the least? Though I guess it's already somewhat odd to init
>> rate control here as written now...
>>
>> Maybe we can hook into the later link info change. This seems to
>> initially work, but still doing more tests:
>>
> 
> sure, hoping that it passes all ;)
> 

Hi Johannes,

Is your testing complete? Do you see any issues with this change?

-- 
Aditya


