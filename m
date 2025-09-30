Return-Path: <linux-wireless+bounces-27729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE17BBABA8E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 08:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDC01C6F22
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 06:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ABC2581;
	Tue, 30 Sep 2025 06:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZS44hf+h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1827B339
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213509; cv=none; b=kdLQ52C9mur2wZuXejKkxyX87rmWdaHBRJnEjVxqyqoAeCPSOpkcEWEd78ZHmblkCwwHEqrOnIVtuxokFmYmezHHBxtPQUvfaNYwQtesrS8Cc5qbDYM8LBybnn4JjJHCYfAqrCkkXsWNf6Fb+2GywZtNH2Prf+MOUKVECwHbGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213509; c=relaxed/simple;
	bh=16Lc+wM3WkMBVsu91oIa15x3brJ28HoCPaDDL30QKNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mvUJWMzxHYt7UFjdceT+oT4Eg7Vn9Ph1kxOyYn6ae5JKskW45T2jY2JxVBLMrdDwFp176VhgjNNU755YT+UzGf4upsU9u822tudjU1zfdM3R3lgaHxAfSslNw+qR3coi7ET9dUFZ7B3CmJpJJQUwV2ndGgScdB6dC4ajlaPg4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZS44hf+h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HvD2011778;
	Tue, 30 Sep 2025 06:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nn+qAJIlHrfAtc6icVKaRA7vk1pOD9ZpryOheEuTofU=; b=ZS44hf+h5PALUdZk
	j1pyKQ78Smon12XGl8zNxwUwSWT74lxhHuiCH4hSpKZc1ghQATOYPx/pXfXkOCXN
	9dDmNhSXuO9Lo2dSlz78GkxzDlfPOqKjuzRC7Or1+poDvc6D2Aj6xmnIVcVUGtxc
	kH1i57qlyVuSBhLhQLRlmucI/EBPsGlu0pcbS5/OQfUH+BNUOHTqEtYImeDa32xk
	zkUdi7FFF17Z6oOz/dI8fGikMDNgZAdwwM5m1DO7lglz3RpMqxzLuyWQtlXdZmyQ
	ghbHU9hwGS9hZRAWf5N3ZnPb/UfwoW0q7bT4sAQzKWURhy0jtyZV1Ezl9wVoenN+
	TEDnGg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e5mcr5cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 06:24:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58U6OvHn001812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 06:24:57 GMT
Received: from [10.79.196.122] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Mon, 29 Sep
 2025 23:24:56 -0700
Message-ID: <495834e0-aa0c-4ea5-9e54-17ed0bcadf73@quicinc.com>
Date: Tue, 30 Sep 2025 11:54:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 0/3] wifi: cfg80211/mac80211: add support
 to handle incumbent signal detected event
To: Benjamin Berg <benjamin@sipsolutions.net>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
 <fc58639b6e910e93b103cb8abcf2a5edefa70913.camel@sipsolutions.net>
Content-Language: en-US
From: Amith A <quic_amitajit@quicinc.com>
In-Reply-To: <fc58639b6e910e93b103cb8abcf2a5edefa70913.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=68db77ba cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=SOZjVK6XgupnwtrLmuEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: t9fCrmI6jtu1PFBvlLivVNvdrv7MMZ-3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwNCBTYWx0ZWRfXw8eZwMCprZrK
 NbFTNtl7Z7gmihzxIyd5l3qowhN80zPN3iwFwQ6pD51NvJeSflwJnFBG1N8m5ZMLPh6hLS2UTpG
 gSR06k+55i6AdZ+ajDVLmHBUJnNNtfvJbqPcku1erM/KVndEokWx7n6DXyZxm4k6Sw/htfqSTNq
 5kQfXFs1//51cFEzlpuIBRxtF/nIMRFY8KyOEOUMfbpZZjugx1mUvEMdHY5TV8tEflQQuzAKTNo
 obQef2ltqllvHZjm1FleMjvr+PMh1VCGzOd8sYdaQVUKorRGB7MswD0RIfk3nrEAWmXprrZ9bb9
 w8ASuXy9LfPxqsGutldZcm6WrQqJm6c83uMjr843fGUI3T9brMlhVP0WLXK21vofIlNhJ9AU3NG
 sjGDm7HJMJjbCgN8VotRgA2kczE0Jg==
X-Proofpoint-GUID: t9fCrmI6jtu1PFBvlLivVNvdrv7MMZ-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270004



On 9/23/2025 2:30 PM, Benjamin Berg wrote:
> Hi,
>
> On Tue, 2025-09-23 at 13:05 +0530, Amith A wrote:
>> This patch series adds support to handle incumbent signal interference
>> detected event in 6 GHz band. When an incumbent signal is detected by an
>> AP/mesh interface operating in 6 GHz band, the AP/mesh is expected to
>> vacate the channels affected by it.
>>
>> Driver is expected to call the newly introduced API with required
>> information to notify the interference detection. This information will be
>> ultimately sent to user space via NL802111 command. User space is expected
>> to process it and take further action - vacate the channel, or reduce the
>> bandwidth.
> I am wondering a bit whether cfg80211 should enforce some AP behaviour
> here. Like marking the channels as incumbent internally and stopping
> the interface if userspace does not vacate them within a certain period
> of time.
>
> As-is, userspace seems to be able to simply ignore the event or
> misbehave in other ways and cause an incumbent channel to be used even
> though it is prohibited by regulatory rules.
This infrastructure was designed to closely resemble DFS radar detection
and handling, where cfg80211/mac80211 acts as a pass-through layer and
userspace is responsible for taking action. If you suggest adopting AP
behavior in cfg80211 where the interface is stopped if userspace fails to
vacate the affected channels within a certain timeout, that’s certainly
doable.

Based on my understanding, regulatory requirements prohibit transmission
on a channel while interference is present and allow resumption only once
the interference ceases. However, I am not aware of any specific time
constraints defined for vacating the channel.
> Another question may be whether cfg80211 needs to verify that the
> driver/hardware is doing incumbent signal detection before it uses
> channels that may be affected.
Apologies, I didn’t fully grasp your question. Are you suggesting that
we advertise a capability flag if the driver/hardware supports
incumbent signal detection?
>
> Benjamin
>
>> Aditya Kumar Singh (1):
>>    wifi: mac80211_hwsim: add incumbent signal interference detection
>>      support
>>
>> Hari Chandrakanthan (2):
>>    wifi: cfg80211: add support to handle incumbent signal detected event
>>      from mac80211/driver
>>    wifi: mac80211: add support to handle incumbent signal detected event
>>      from driver
>> ---
>> Changes in v3:
>>   - Removed the workqueue mechanism in ieee80211_incumbent_signal_detected(),
>>     exported the cfg80211_ function that sends the NL80211 command and called
>>     it from ieee80211_incumbent_signal_detected() directly.
>>   - Renamed nl80211_incumbent_signal_notify() to
>>     cfg80211_incumbent_signal_notify() and removed the gfp argument from it.
>>
>> Changes in v2:
>>   - Updated the kernel doc of NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP
>>     to include details of how it interacts with puncturing.
>>   - Rebased on ToT
>> ---
>>   drivers/net/wireless/virtual/mac80211_hwsim.c | 33 ++++++++++++++++
>>   drivers/net/wireless/virtual/mac80211_hwsim.h |  4 ++
>>   include/net/cfg80211.h                        | 17 ++++++++
>>   include/net/mac80211.h                        | 18 +++++++++
>>   include/uapi/linux/nl80211.h                  | 19 +++++++++
>>   net/mac80211/ieee80211_i.h                    |  5 +++
>>   net/mac80211/main.c                           |  3 ++
>>   net/mac80211/trace.h                          | 26 +++++++++++++
>>   net/mac80211/util.c                           | 39 +++++++++++++++++++
>>   net/wireless/mlme.c                           | 12 ++++++
>>   net/wireless/nl80211.c                        | 35 +++++++++++++++++
>>   net/wireless/nl80211.h                        |  4 ++
>>   12 files changed, 215 insertions(+)
>>
>>
>> base-commit: e3ac93e9d916ebae0711a42f524429dad89c4887


