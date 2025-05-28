Return-Path: <linux-wireless+bounces-23479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3786AC70CA
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 20:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BF74E59C3
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 18:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3691ADC69;
	Wed, 28 May 2025 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A2kUjX2Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E327450
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456210; cv=none; b=nKjRY9u36r3oQuaVIOIEudzSqU5IOhVoCRwnVoBMPvHj5Q3UX3rqBlI3fEy0TuZs5wBHtQMVI2xUUo+JBrriKreMO6Q1fZiNyiVaMDvl84/sogssO9LimvJk7wCJLOrt3fJuyhfNiTXx6SgCdjSEe45dxd/XRg8aBCh/MSVcjYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456210; c=relaxed/simple;
	bh=E6OP3po2q9Nd3C654fc9dkk6QHXiSrqcM86mJf3WnEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=odvULPSTqcYzvDFTmwX6IUgyxtGv1+XmWWqQmkEWFAAx3cDCGaAGr1g4wbXq6bpmoo5xSYgPahadZtg4H/WM2+m3SF/uYojW6pMCuaKhVFUHm2W8oSFI8glJMWOnHj1vtJNEPFbwtwG8PKdcUDw/edZQUNHQ0qFY+w41nlnTvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A2kUjX2Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SH5iit003397;
	Wed, 28 May 2025 18:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+zixsDt6O/lSXZW+FRvUWVqt5pnoQYYegJZqcTFH/aM=; b=A2kUjX2Q/zd2cBjT
	LNsu9TKX1fR/gbb00FetqpmMGSvUF02XIo9QKTS/Na7y6M39A3k64aiMzpcdgnsW
	T1UUhvWLM/gjaqTvgluDOEIl3o1GUJnwuqNGM+NzgOBXccTrPRl1+tE6lvFlwyVC
	8yyRFI7H3Ssh+bHS4szazQO2F13EgTcBHFkIN3e3G7MOSWzec9KVsAJg9HsiS+T7
	Zm66Z7dFRgZL3X+6v0ioFXv2mStvjGz5dce2FbSCliayEhk0p70r4v8K8ih2affx
	3ep7Yx7FQ/TuPswmkUOFpyFXm9lxyH4EUJbWLlMnOGjOYASkJAwwjAbLPTEpG04s
	r3FaEA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46wavkvyqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 18:16:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54SIGhw8006627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 18:16:43 GMT
Received: from [10.110.49.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 28 May
 2025 11:16:42 -0700
Message-ID: <b7d500e3-445e-455d-a74f-4ec3c7f3fde3@quicinc.com>
Date: Wed, 28 May 2025 11:16:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 8/9] wifi: ath12k: add support for 160 MHz bandwidth
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
 <20250418174818.3336510-9-quic_pradeepc@quicinc.com>
 <DA08F3TG062A.151WKWWF5OPL0@gmail.com>
 <c21146ef-3cf6-4d8e-a32d-8479e4d96f3b@quicinc.com>
 <DA2JV34RZGAQ.24P9Y3C865UHN@gmail.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <DA2JV34RZGAQ.24P9Y3C865UHN@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nnLJJxhHB57sASbP49M5K_MuHFcH8aws
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE1OSBTYWx0ZWRfX4TD2Gdj22lWA
 ETCyaKKdyRfhIjBJ8pXkF4LdCN+36csXM9GbnQ1bGQdGG9Bv+s3RVWNXiP5LNWY74teCa6ewpnn
 8b2USxRJZ4EHm+ljTVHyrMH2oPZUXq6zw+E6SALpNjID0np/b0SYu9N4KZlsl8S/sDJxqtHffys
 yuZMvNkqBU53/qQZ/5rNpRJQ+VcXa1I2inhp/PIlkjKYv/yFnJqnxp/RPfRzlh3YbVT1EK9JqwG
 oFiUInDe6an5eg87sL8OsfH/wN2rSvIhQzvBemLcekQ70z93ka56Vq9g1LkHr3hG2f/f4RliICZ
 QeekQsQ6x9+GwccE87LLc8GPS79nZGJ06W3wjav/zmcHxmhWoeDVzKBqQEUc8zT80C0hVHlcnPc
 oU2HSqyaQdZsxvWZkrfXPHO83otd1z3EQ8hwYkJx8Z99zongW3imD6sJwDumU6066+G+IMNr
X-Authority-Analysis: v=2.4 cv=fMk53Yae c=1 sm=1 tr=0 ts=6837530b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=SvoT8jjy0BNg_UzYINgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nnLJJxhHB57sASbP49M5K_MuHFcH8aws
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_09,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280159



On 5/22/2025 1:34 AM, Nicolas Escande wrote:
> On Wed May 21, 2025 at 11:38 PM CEST, Pradeep Kumar Chitrapu wrote:
> [...]
>> Thanks Nicolas,
>>
>> I believe IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ mean only
>> 80PLUS80 not both 160 and 80PLUS80 and STA must set
>> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ flags for indicating 160 MHz
>> support. Please correct me if my understanding is correct. However I
>> agree that we must allow STA to connect irrespective of which flag STA
>> sets as long as bandwidth is 160MHz. I see ath10k and ath11k also allows
>> this by setting default phymode of MODE_11AC_VHT160 for BW
>> ==IEEE80211_STA_RX_BW_160 case.
>> I will make this change in next revision.
>> Thanks
>> Pradeep
> 
> Hello Pradeep,
> 
> Well this is quite unclear for me maybe Johannes or someone more aware of the
> evolutions of the standard could shime in.
> 
>  From what I've gathered:
>    - the naming IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ implies both
>      which points it was the case when added
>    - and the original 802.11ac-2013 Table 8-183v states:
> 	Set to 0 if the STA does not support either 160 or 80+80 MHz.
> 	Set to 1 if the STA supports 160 MHz.
> 	Set to 2 if the STA supports 160 MHz and 80+80 MHz.
> 	The value 3 is reserved.
> 
> Things get complicated after:
>   - later versions like 802.11-2020 have deprecated value 2 in favor of the new
>     Extendeed NSS BW feature
>   - Table 9-272 still implies both 160 & 80+80
>   - Table 11-23 & Table 11-24 implies only 80+80 but both talk about the
>     'VHT Operation' Channel Width field and not the 'VHT Capabilities' Supported
>     Channel Width. And thoses had different values even in the first AC amendment
> 
> So it feels like when no Extended NSS BW Support is used (first gen AC devices),
> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ really means both 160 & 80+80
Thanks Nicolas for detailed response.
Request you to kindly review V14 series and let me know if it works?

Thanks
Pradeep

