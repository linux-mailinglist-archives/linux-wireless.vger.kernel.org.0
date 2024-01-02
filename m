Return-Path: <linux-wireless+bounces-1411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C437E82232A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 22:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27201C22B77
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 21:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3B4168A6;
	Tue,  2 Jan 2024 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KhnMaI3K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3A168AD
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 402L9G7T013086;
	Tue, 2 Jan 2024 21:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2kjy99lXyYb3N9XUoPDcTni4rxj8Z/7A2/qWI8FZ1/A=; b=Kh
	nMaI3KrbycfcKnMTI8r1qbV/jvhyDN8KgLf+f1xCcSkoLMBmAyFergX0F9H5dgEU
	S9lJpkcHVdYaXXcfjvEolu+hzIIkL+T9kN6Utg+dRm5YB38ejWvDvtSJK2K4Ya0g
	qBjSxaHtuS2esXzTobDUEs8ZIQN5L27y8mk2T0guOulriMh9PuVhx0QKaAlficIs
	gv6izjHy9EYnEG+BYIGq9gKWqjhakPFw47mnRudnyarvUaH73q+WNDV+qMFdml9S
	rMn3hw0pgZnt1Ws3qRebxYhw7Rb1TO5u34qy+HR92v5sfH0agIymbjjg3nma51Yu
	3gGdCtvWCKUopUvA4j2w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vc9nn1vtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 21:13:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 402LDOtp006249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jan 2024 21:13:24 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Jan
 2024 13:13:24 -0800
Message-ID: <3a4ab7b8-4af0-447e-b189-be1e3e7cfe9e@quicinc.com>
Date: Tue, 2 Jan 2024 13:13:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] wifi: cfg80211: handle UHB AP and STA power type
Content-Language: en-US
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        "Sisodiya, Mukesh"
	<mukesh.sisodiya@intel.com>,
        "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>,
        Kalle Valo <kvalo@kernel.org>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman,
 Gregory" <gregory.greenman@intel.com>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
 <20231220133549.cbfbef9170a9.I432f78438de18aa9f5c9006be12e41dc34cc47c5@changeid>
 <87jzp61ox0.fsf@kernel.org>
 <MW5PR11MB581024768AEC355DEE8F15D5A39BA@MW5PR11MB5810.namprd11.prod.outlook.com>
 <SN6PR11MB3421B9AC91E1FBDAD531C662FF9DA@SN6PR11MB3421.namprd11.prod.outlook.com>
 <5b18c070-71ce-44a5-a7ae-0303e23b6aac@broadcom.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <5b18c070-71ce-44a5-a7ae-0303e23b6aac@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OvzHAxn7nJPdy4fTCv_l6nOCL5f31Chu
X-Proofpoint-ORIG-GUID: OvzHAxn7nJPdy4fTCv_l6nOCL5f31Chu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=451 phishscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401020157

On 1/1/2024 4:15 PM, Arend van Spriel wrote:
> On 12/29/2023 2:51 PM, Sisodiya, Mukesh wrote:
>> Hi Miri/ Kalle,
>> Yes,  it is Ultra High band(6Ghz) AP.
>> Regards,
>> Mukesh Sisodiya
>> -----Original Message-----
>> From: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
>> Sent: Sunday, December 24, 2023 1:23 AM
>> To: Kalle Valo <kvalo@kernel.org>
>> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org; Sisodiya, Mukesh <mukesh.sisodiya@intel.com>; Greenman, Gregory <gregory.greenman@intel.com>
>> Subject: RE: [PATCH v2 05/13] wifi: cfg80211: handle UHB AP and STA power type
>>
>>> -----Original Message-----
>>> From: Kalle Valo <kvalo@kernel.org>
>>> Sent: Friday, December 22, 2023 13:02
>>> To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
>>> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org;
>>> Sisodiya, Mukesh <mukesh.sisodiya@intel.com>; Greenman, Gregory
>>> <gregory.greenman@intel.com>
>>> Subject: Re: [PATCH v2 05/13] wifi: cfg80211: handle UHB AP and STA
>>> power type
>>>
>>> Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:
>>>
>>>> From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
>>>>
>>>> UHB AP send supported power type(LPI, SP, VLP) in beacon and probe
>>>> response IE and STA should connect to these AP only if their
>>>> regulatory support the AP power type.
>>>>
>>>> Beacon/Probe response are reported to userspace with reason "STA
>>>> regulatory not supporting to connect to AP based on transmitted
>>>> power type" and it should not connect to AP.
>>>>
>>>> Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
>>>> Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
>>>> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>>>
>>> What's an UHB AP? Never heard of that before.
>>
>> Ultra High Band (6 GHz) Aps
> 
> Not sure where the term is coming from. It is not in the 802.11 
> standards nor WFA specifications afaict.

I have the same concern. We should not introduce "marketing"
terminology; please stick to terminology used in the specifications.



