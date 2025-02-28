Return-Path: <linux-wireless+bounces-19597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD915A49E11
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 16:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391F13B1183
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 15:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A35271815;
	Fri, 28 Feb 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SI5dY1bU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EBF270EC6
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758135; cv=none; b=e+6SGtdA4jailhfiSMbz/fOn6wq9hAZXA6WJrZXDt/bWJVFVbQ1H0Ln0xwSHHspGTOGzs8/+mIoo264eVA9rZi1hwDSNDjwTY1QBak+6pFwwWlsZoGfdF2Sy8B5dJgN5EweJF+PmgsYsU6RqnYaQIHo5i9spMQt5Jm69UTOQgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758135; c=relaxed/simple;
	bh=FvrBaRMVUR4k3+YIebPyucGIJeEEZpSDsxkvZFFRM0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bSRzF8yOQGeh4zCr+OexgJzx/nKdYDqY9kqb02q/6dwSNjzvyWo/O7xT/TpaThqVpLtTcwHrUMjnXYQf8TCrf1OWx6G5LgUeA3/ZFiriwvBPMH6YNw8IjbFVdMJNQRiGxHiyraolTE190I+gO0AknCegH8bqwmel1XocIEDDeLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SI5dY1bU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXH1r018843;
	Fri, 28 Feb 2025 15:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HGMB4P60WQri5MzK5m2tsbr/OzGQADg7Vk48wr5t1+0=; b=SI5dY1bUCT5TfgBb
	UufL4B+UIGK3fMtY7aBVuUdKuccH8Usw9fw3iyaMAT/kXxn7cYo1zfd+UNjIDjeZ
	I8ZnhtiVts0fKIkl3bwldwdk6G2PwpkprNs5wi2zi1sDuFP5bAhRtNnj2dT8INx7
	3eIwANXq/QP5+ZnW3exFlSF55qDYbP3xxuJOqq45hGKTnDlcVL1EuUOC+HS6XEAg
	eek3TJ74QUfPIXjUr8+wec0VzTeibBEBdrHbVkXJQ0Wwr4cTpyS4Q24esHou+dh2
	NGm5qT3UrCQeke9HF+cc5ZGipsFVnE7tSjbD8qM/QOXR5IjVoNXGfviAfviZk36x
	HLUbcQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prn9txb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 15:55:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51SFtSbA028880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 15:55:28 GMT
Received: from [10.50.45.196] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Feb
 2025 07:55:27 -0800
Message-ID: <c5f975b9-0ac9-2659-1595-c35a7cedc8b7@quicinc.com>
Date: Fri, 28 Feb 2025 21:25:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] wifi: cfg80211: Allow monitor creation in
 NO_VIRTUAL_MONITOR mode with active AP
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250123010950.1958211-1-quic_nithp@quicinc.com>
 <20250123010950.1958211-2-quic_nithp@quicinc.com>
 <61c22a40a2b8bfe28175c2e7031b0a22fff2ca06.camel@sipsolutions.net>
 <ad67cbfc-e158-8fb2-c94f-e1e3b01a5c28@quicinc.com>
 <470352b7b5ead19e80be47f9b49d9285b870b65d.camel@sipsolutions.net>
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
In-Reply-To: <470352b7b5ead19e80be47f9b49d9285b870b65d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e_sK5aLjg-LW9e5e_d14vialkqtfNduf
X-Proofpoint-GUID: e_sK5aLjg-LW9e5e_d14vialkqtfNduf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=856
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280116

On 2/28/2025 8:17 PM, Johannes Berg wrote:
> On Fri, 2025-02-28 at 20:15 +0530, Nithyanantham Paramasivam wrote:
>> On 2/28/2025 6:20 PM, Johannes Berg wrote:
>>> On Thu, 2025-01-23 at 06:39 +0530, Nithyanantham Paramasivam wrote:
>>>> Currently, in NO_VIRTUAL_MONITOR mode, when creating an
>>>> AP/STA + monitor, there is a restriction: if the AP/STA is running,
>>>> setting the channel for the monitor is not allowed. For example,
>>>> in a scenario with three supported radios where the AP uses only the
>>>> 2 GHz and 5 GHz bands, the 6 GHz band remains available. However,
>>>> due to the restriction that rdev->num_running_ifaces must equal
>>>> rdev->num_running_monitor_ifaces in cfg80211_has_monitors_only(),
>>>> we are unable to create the monitor interface.
>>>>
>>>> cfg80211_set_monitor_channel -> cfg80211_has_monitors_only()
>>>>
>>>> static inline bool cfg80211_has_monitors_only() {
>>>> ...
>>>>      return rdev->num_running_ifaces == rdev->num_running_monitor_ifaces
>>>>           && rdev->num_running_ifaces > 0;
>>>> }
>>>>
>>>> To address this, add the new wiphy flag
>>>> WIPHY_FLAG_SUPPORTS_NO_VIRTUAL_MONITOR to advertise no virtual monitor
>>>> support to cfg80211. This flag will allow the creation of a monitor
>>>> interface by bypassing the cfg80211_has_monitors_only() function.
>>>
>>> I think it would make sense to call this differently in cfg80211, per
>>> what it actually _achieves_, rather than per the *mac80211* logic about
>>> it...
>>>
>>
>> Sure. Perhaps I'll rename it to "WIPHY_FLAG_AP_MONITOR_SUPPORT"
> 
> I don't think it's about "AP" either, really, it's about "concurrent" or
> so?
> 

Right. I will modify it accordingly

>>
>>>> There is no need for special handling after this, as
>>>> cfg80211_set_monitor_channel() will manage all interface combinations
>>>> and allowed radio conditions.
>>>
>>> This sentence just can't be right - you're changing
>>> cfg80211_set_monitor_channel() and there's no more code after it?
>>>
>>
>> Sure. It's better if i remove this sentence.
> 
> Well seems you should still explain what happens then - i.e. that the
> driver, or in this case mac80211, needs to check that it's possible?
> 

Sure.
> johannes


