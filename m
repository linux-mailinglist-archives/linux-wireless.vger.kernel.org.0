Return-Path: <linux-wireless+bounces-24641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBE6AED335
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 06:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E0616B507
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 04:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE87C13E41A;
	Mon, 30 Jun 2025 04:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IgDy3U4X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2104C6C
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 04:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256745; cv=none; b=YsWWjAXyBtwLuTaZFwsjZTKq1IcBfMczF28JF4XuVQ249wR9UWJ5wm/nAuGFhtqkRPBe6fVOWykbl6kKZ7KRBi3/0CIecNhspqfwkgFmniixZtyy9J3PIy654cW6+/q6AOI/iO2oeHKlyqa+vnzSNonTEcPDdmCx+ZQ4jYMh9AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256745; c=relaxed/simple;
	bh=+7NZsdc+AsH7c+zCzfyIHcXpLAxxb/WwAgnTp7XJMa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NDzqKGbgFGX6vhztaVcNvvpHiKWm0A1GH5zbddJwzFd/KPYt0vxj1kdRXLhmKcW7BjEJ9ORWrf3mEl//WN/9LW7GAgB3FvPQu0+gItbfqcVCNk33n2dor/+t92H1ZqSEBIy+vlKX4RNLiktT+79Cz5DI9Kt223/RHohA/RoZKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IgDy3U4X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TNrija007588;
	Mon, 30 Jun 2025 04:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QemUHvmYnZbBhKWqdiLnQENNxT6zPm/OvCUZPEIWRTE=; b=IgDy3U4Xqd1gPMN/
	bSAQNemsQlBXNgNIGWs6Alak+/WimCkjf06rjrZB5Mc9E2jTJwgz7Gh4cSbzobPO
	V71B9p+g3qzLG4cSaRZD5K7HmRMQ3cVkM77rKqi97FFu9XZk+9zuJn3xCeVMBJfg
	CnGzlHEB6gxkE3A+UqX7UQS4p/qBNOrWTRTVOqPdrFhmmn8eoJQ/jiyYhzUpO97g
	yFR2mVNtj2AS2KWQi/A7QISezcqGK1bKPQniC/LY8rriEUWz1+fm2cSN0132vQb0
	ystnI4pOMcxf+Jz9cAh0dA5lxO9PaWkSHJ77rjTD6tIFr+w9i0/SQM7Bf6D0A7Vj
	LzzlSA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fxbap5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 04:12:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55U4CBuZ004223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 04:12:11 GMT
Received: from [10.152.204.0] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 29 Jun
 2025 21:12:09 -0700
Message-ID: <246a762f-8348-9e61-114c-bdedf63b2e60@quicinc.com>
Date: Mon, 30 Jun 2025 09:42:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Revert "ath11k: clear the keys properly via DISABLE_KEY"
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath11k@lists.infradead.org>,
        Sven Eckelmann <se@simonwunderlich.de>
CC: <linux-wireless@vger.kernel.org>, Steffen Moser <lists@steffen-moser.de>
References: <20250117191455.3395145-1-nico.escande@gmail.com>
 <20e0a239-3d23-473b-5bc8-41bc25a64088@quicinc.com>
 <D9NDQJB4VMWA.V4IPOZOIR46W@gmail.com>
 <0c166b5b-f358-1f39-4569-a1ac388033df@quicinc.com>
 <DAX52ECUSPW5.1P50QHZ8X2QFX@gmail.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <DAX52ECUSPW5.1P50QHZ8X2QFX@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDAzMiBTYWx0ZWRfXysuZxCL/5C9I
 SqHbdakDy5TngH/EdEBnGnmm7IngUl3XHm54IKEEcTBjVc4g5Tn/0SVZDfPp/S3AEdDV31eRa1C
 jVU1MTy9uQHKXw44kdFXSIKKQdftpRQTYCjyT5nTofBqzylK+pe3bRFpOzjSbFwQN3iIalRFCt9
 WR+6soU9/E2ivUu3NDSsyt3qckO8icP14OcCDWp84/0r57j3zV23J/WGsCnjHK+X5EY6qGUZ1iV
 ZmXCy0mNWLvCsBj7NHNn+Ko1TxrjhjuAQZpbXaE/8tOUcpZ3TIhd4Eo5lWg1gGWvMMLtXnIRHkQ
 ldsI2mUJfNs2OTyeBtpfVCnlUOL/o7BQq+qZU4Zziv+FGsgOjriA0iFFEQ0JNXMcBLFJK6ZeFpo
 MBZr4LyVyeaKAY0eiJqXWlsQIjlmJ0MHy5xT4zgFytPf3stLfVKCjPWmCfuLA0sWrIoIxdj6
X-Proofpoint-GUID: 5qT1_rULxBA394zJKvEaY1F3P_fQpujI
X-Proofpoint-ORIG-GUID: 5qT1_rULxBA394zJKvEaY1F3P_fQpujI
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=68620e9c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=OLL_FvSJAAAA:8
 a=4XwAeAJPTqeN_iEf8BgA:9 a=QEXdDO2ut3YA:10 a=cq9DwLQcLZUA:10
 a=Iy0t56g-M2wA:10 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=671 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300032



On 6/27/2025 1:01 PM, Nicolas Escande wrote:
> On Tue May 6, 2025 at 11:19 AM CEST, Vasanthakumar Thiagarajan wrote:
>> Hi Nicolas
>>
>> On 5/4/2025 6:06 PM, Nicolas Escande wrote:
>>> On Sat Jan 18, 2025 at 11:29 AM CET, Vasanthakumar Thiagarajan wrote:
>>>> Hi Nicolas,
>>>>
>>>> On 1/18/2025 12:44 AM, Nicolas Escande wrote:
>>>>> This reverts commit 436a4e88659842a7cf634d7cc088c8f2cc94ebf5.
>>>>>
>>>>> This as been reported by multiple people [0] that with this commit,
>>>>> broadcast packets were not being delivered after GTK exchange.
>>>>> Qualcomm seems to have a similar patch [1] confirming the issue.
>>>>>
>>>>
>>>> This will re-open https://www.spinics.net/lists/hostap/msg08921.html
>>>> reported by Sven. The recommended ath firmware ABI during GTK re-keying
>>>> is SET_KEY instead of current DEL_KEY followed by SET_KEY. We are looking
>>>> at other options like some marking by mac80211 for the driver to be able
>>>> to identify if the received DEL_KEY is for re-keying. Also I'm curious
>>>> if roaming between secure and non-secure mode is a critical use case.
>>>> If not, we can probably go ahead with this revert as temporary WAR,
>>>> @Sven?
>>>>
>>>> Vasanth
>>>
>>> Hello,
>>>
>>> Any news on this ?
>>> I would hate for this to sink into oblivion once again given how hard this
>>> affects end users when it does hit.
>>
>> We are working on a driver change w/o reverting the commit, we'll share
>> the patch once complete.
>>
>> Vasanth
> 
> Hello,
> 
> I might be mistaken but I did not see anything posted for that yet, right ?

Patch has not been posted yet. Since the code change does not
look straight forward and the issue is security related it takes
time. This issue is being actively looked into.

Vasanth

