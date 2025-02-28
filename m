Return-Path: <linux-wireless+bounces-19593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68875A49C5A
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 15:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0B83B8F22
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F4A25DAF0;
	Fri, 28 Feb 2025 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Be9ugt0f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55C26FDBA
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753951; cv=none; b=W2hOLJUc67+bccBc8ZYQyJUqDVhJ/Z3D1ju5orXSm62E9wWG3GwGktUG8vuW7gYYZaEuj9c1cqtf3/J/O1+W0/FiXUzFuOAqY2Z/y9sGBJvJKq0pTd+hIDJI/30J/HuQ2Jt0EMg+LhPTMptMvR4CA2uFxcmRZMHVwPjPMOO8A5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753951; c=relaxed/simple;
	bh=XF2Ivg14mTNzalvta/3XlanrD/nR5ST2VbKagAwXFGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n+W9gzA5wR6go6nKGl5BBiQr7FE1pAge8mN5kwXqos0TGY83Scncw6ln5b5c4I5zhVxoAVAkkAeBp6xapv/X5SfsWszs35c5+hSnNrVn4WpNRaUkYOSy2TH3n057SBfb9C0raQLRsBYVIUB5DztBIwWKSHbs1Xzt/TEsXwQWn9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Be9ugt0f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXKYB022217;
	Fri, 28 Feb 2025 14:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QFEldpkt7ackOvqamt8+fKV69DTMAyew7BiiIQU3sLk=; b=Be9ugt0fJWfavjb3
	8v5DW51E8fXYAMMKUOFNp1mfKpCVTk6qxkmrpGx7T2As/o4yCYXsLEVhaPQG0BGZ
	xiagqyqFFxbDTFiqRG6s4nzFVPPKHgYV4HWJ8leGivSLYMsFenpVj7gblQqIGrPC
	Pqd3ui+mT1BKPvcA/AI9OIsHBbPtOfrLqd3Jv+ZlZsDaLXig9ERAnNCY2L3xUZZu
	OtcwDclNPrNpG4My3ZcCb9LAexOODudtX3zNmvtGrjL3Y7GkpfsPLEzQ6W74Bdso
	BbICw+HlyvFu9p9BpA2dL1arpQSwSxOvxsXx+A5l5oEaMTJcO2s9hBsXILdRNGN6
	6Nk2bw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451pu9hth0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 14:45:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51SEjiGx026686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 14:45:44 GMT
Received: from [10.50.45.196] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Feb
 2025 06:45:42 -0800
Message-ID: <ad67cbfc-e158-8fb2-c94f-e1e3b01a5c28@quicinc.com>
Date: Fri, 28 Feb 2025 20:15:38 +0530
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
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
In-Reply-To: <61c22a40a2b8bfe28175c2e7031b0a22fff2ca06.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NG1eWrykcHUB1D0NpQ6L5ek2-XEN7G-p
X-Proofpoint-ORIG-GUID: NG1eWrykcHUB1D0NpQ6L5ek2-XEN7G-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=895 malwarescore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280107

On 2/28/2025 6:20 PM, Johannes Berg wrote:
> On Thu, 2025-01-23 at 06:39 +0530, Nithyanantham Paramasivam wrote:
>> Currently, in NO_VIRTUAL_MONITOR mode, when creating an
>> AP/STA + monitor, there is a restriction: if the AP/STA is running,
>> setting the channel for the monitor is not allowed. For example,
>> in a scenario with three supported radios where the AP uses only the
>> 2 GHz and 5 GHz bands, the 6 GHz band remains available. However,
>> due to the restriction that rdev->num_running_ifaces must equal
>> rdev->num_running_monitor_ifaces in cfg80211_has_monitors_only(),
>> we are unable to create the monitor interface.
>>
>> cfg80211_set_monitor_channel -> cfg80211_has_monitors_only()
>>
>> static inline bool cfg80211_has_monitors_only() {
>> ...
>>     return rdev->num_running_ifaces == rdev->num_running_monitor_ifaces
>>          && rdev->num_running_ifaces > 0;
>> }
>>
>> To address this, add the new wiphy flag
>> WIPHY_FLAG_SUPPORTS_NO_VIRTUAL_MONITOR to advertise no virtual monitor
>> support to cfg80211. This flag will allow the creation of a monitor
>> interface by bypassing the cfg80211_has_monitors_only() function.
> 
> I think it would make sense to call this differently in cfg80211, per
> what it actually _achieves_, rather than per the *mac80211* logic about
> it...
> 

Sure. Perhaps I'll rename it to "WIPHY_FLAG_AP_MONITOR_SUPPORT"

>> There is no need for special handling after this, as
>> cfg80211_set_monitor_channel() will manage all interface combinations
>> and allowed radio conditions.
> 
> This sentence just can't be right - you're changing
> cfg80211_set_monitor_channel() and there's no more code after it?
> 

Sure. It's better if i remove this sentence.

> johannes
> 

Thank you for reviewing the code!
Nithi



