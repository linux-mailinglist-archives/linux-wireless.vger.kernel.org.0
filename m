Return-Path: <linux-wireless+bounces-23018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3957AAB8CAC
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 18:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F2417B0A0
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692541C07C3;
	Thu, 15 May 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HDTHwVW2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F551A23A0
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327261; cv=none; b=KTA6i0KCurG2HZlpNqf9xHnILlBZeocLHN3K9iKuO4XO8pbTaAyby9GEuP/DJ7p0E6pIq0aAazhSvMolnEhWeg/QvfeeWw1eI41lg7sTo7BfVJnguJU/uGhLUWD/9KicFScZSEb2gorcSMicw2pEDZgSLmBxLrexd2sQzSzoT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327261; c=relaxed/simple;
	bh=zqYQbucbeNICrjzDWnd0YaXbnLv6h8fWvXEoaXOlmaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bwEzLNXGKZ5R22IfkRAjtnFe16A2S4gug88fCMsPBo3I1e+rtKyO+qz2c0T8t8SVO5ejbDlxlxhE8JBxQMXucPzLEBv6KzGabESheG8cJI7nh68rGohaBrXsGsZ//feA4JV+oD26gJF8u3jhLNxs2rfFQu7LTGzXMbSL2fylJ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HDTHwVW2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFEOi001818;
	Thu, 15 May 2025 16:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gjEL3nvy6/whuuMM6xD2E15K2R5pph6vVQm+V1ncReA=; b=HDTHwVW20w4bVJ+Y
	A1BAhX8bsR6k6flvLFwvA4cljWOOq5MEOvsHxP9UWNiHhjhijZa6GH+Vs5WiQm1r
	qmKf7XOYB8g7TwhlEBSB20PYhE8T+FRZ6/ABj4Z3ufrkO77oMkREWL547cAoxk4U
	eccXLh9kNIbVJf1CrdubuE/5pchTSoYa0rtuXxIBWmaiTfFRtkSqtGIsaiURUze5
	WOD8l0clVayHo2BL44jds4/02QSLlMp/7xnBSHJOhnBOnCwWPjfvXhcX6VRQIlsZ
	mlu20W7EtEzNKEWRtIpnjuZxOV6dHvtPPdQbyLwYYZFnbMvU6v1IavScvF7Oi+uq
	g/4AoQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcreteh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:40:55 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FGetJj026389
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:40:55 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 09:40:53 -0700
Message-ID: <be47b961-9ee9-42f1-819b-e94e6e7c4695@quicinc.com>
Date: Thu, 15 May 2025 22:10:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 02/10] wifi: cfg80211: add
 link_station_info structure to support MLO statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-3-quic_sarishar@quicinc.com>
 <1683e3d5cd40dcc65ed7022083eefd6acf9764ac.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <1683e3d5cd40dcc65ed7022083eefd6acf9764ac.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ltM_8BKKwokG2objs_iKiE4dCFehxMaY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NSBTYWx0ZWRfX3Ws4pvcSjlOP
 UKwJa2GHlYyMcmgq/wWgQc0r6ujPO90thP4tj4DShhPf/aef1Er396KBDV2Z2/jDVCZ34jld7U6
 5RLi0dyyHeYB9R+/4sPle506FWInis5GARvZ9e6XxTScm/bnfFxY04O6a7KveGus/WOKeTgeVS9
 JToU0nN/Y7JbiHDg5hiTkKE2RyA9JGYFK6iic87ltC97qGqGSt/sdORnheBh/P746JX1poaDrB6
 r6KVopOajAoukL8J+zz13NDnwqOsGFUUfXozccmZ263QQyRA53IgmPHdkjH5EQ4TVhtT+Yudmgn
 yHga4IY8ott3d2Ejp2YdvjikDJef1p08DYrZ7zscEc6foEIiw4QgqicuERequNsLUFnUC7ZNjbQ
 NM2Lqr+mWTrNT5odlqaO6AOUqVLw+MIXDiaQmANWjBSw+q5vBzxQZSgu+tFbtCcCU4kompNH
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=68261918 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=X03CQ67M6BpLr6dRp2sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ltM_8BKKwokG2objs_iKiE4dCFehxMaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=861 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150165

On 5/15/2025 4:51 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>>
>> + * @addr: For MLO STA connection, filled with address of the link of station.
>> + **/
>> +
>> +struct link_station_info {
> 
> nit: neither ** nor the blank line should be there
> 

Sure, I see you already corrected it.
Thanks!

> johannes


