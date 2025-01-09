Return-Path: <linux-wireless+bounces-17237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25338A075FF
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 13:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D713A64B6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B7E217642;
	Thu,  9 Jan 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IJD33f5r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756C802
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426771; cv=none; b=DtTviBReMSM7k6zsqvAucmm92/TSaqj4HeXpYVTLXHq1m7kML4rhJEIUG6jcy6r3iFLpRkxAU+6cpRdeHaUa5+Hqtj5cl97E5ZcJ47xhAcEB5vKxt9Mk/c4KkZdIKF+i0kW3dtmz5yrqzSe4DFRUo0nUb8DBRxV+vj9LxW+9yew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426771; c=relaxed/simple;
	bh=1/1JHKC05Ec4ZjV26je2x+xozsVPMac9X4UrQuwIlss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a87u/UTNnOko4xy6Z2U/95rELXsHHzr88DWsinDcb75V9h6PEJ2uBtRgOixx3IIhi4XrZpEYHcgiE/mFAhwzUCK6/R83JnOgVKTjrIXXC4171yb5bFEswID1VzjSlQWwZPI21XBI4xsfTNd34kGZd11cL0/77IECa0NR6ekGnis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IJD33f5r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509B3bnv024406;
	Thu, 9 Jan 2025 12:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9DHD6/tYHN4tKdVA0UATA5TPjVjyIjuosBtS+ep/QFU=; b=IJD33f5r6TpfTVcK
	Jqz/Sr2PXXAo6R2kqjA6EOELF4HVZ0MkMakmJJ6wIT7XA8CXMEM9W4oWquQCxFlV
	bT0b3m5DiIgZM/kW3rk+JmKXEuMqptg6hgjT/L1zzAMDu2S70RmJFRGzwQ8bK59p
	VFSE0KWuMFQqDF6JX+6X/R1sID27TgMa2/uf2h7iL/4v/Pg181ee4CpvoI+kzvst
	gDBCOM5shx+m3E4Y9JMM9tzPTLlL+OkI2czNqDspVHG7hRo6E/JZsX5b1XxicFfI
	L7Xikl+67lWAMsMyK4KgIcCK6I/8b771lYZclo+UQJ5WsENU9SVKeIq3dc1msPO2
	chieTA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442d8hg7ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 12:46:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 509Ck1Xi009061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 12:46:01 GMT
Received: from [10.50.34.168] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 Jan 2025
 04:45:59 -0800
Message-ID: <4d9ddf3b-19f2-42b9-958b-62a1f0f7991d@quicinc.com>
Date: Thu, 9 Jan 2025 18:15:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: mac80211: update ML STA with EML capabilities
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Ramasamy Kaliappan
	<quic_rkaliapp@quicinc.com>
References: <20250107174802.1793252-1-quic_ramess@quicinc.com>
 <20250107174802.1793252-3-quic_ramess@quicinc.com>
 <6f61f6eaf03eec99f0f30d01501bc60f8ead1270.camel@sipsolutions.net>
Content-Language: en-US
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <6f61f6eaf03eec99f0f30d01501bc60f8ead1270.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x6tRKUgfMFXBEkk570UcimKkiJhI9Bqj
X-Proofpoint-ORIG-GUID: x6tRKUgfMFXBEkk570UcimKkiJhI9Bqj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=806
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090101




On 1/8/2025 2:04 PM, Johannes Berg wrote:
> On Tue, 2025-01-07 at 23:18 +0530, Rameshkumar Sundaram wrote:
>> +	if (params->eml_cap)
>> +		sta->sta.eml_cap = params->eml_cap;
>>
> It would seem to me that 0 is a valid value, so you may need a separate
> "was the attribute included and we're changing the value" flag?
Yes you're right, shall i add a new entry in 
station_parameters_apply_mask {} and use it for this ?

