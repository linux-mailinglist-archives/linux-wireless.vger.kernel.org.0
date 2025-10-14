Return-Path: <linux-wireless+bounces-27968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5269BD8D0B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 12:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC7BD4FE44B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 10:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB9024468D;
	Tue, 14 Oct 2025 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ImhtqxR5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AE2FB97F
	for <linux-wireless@vger.kernel.org>; Tue, 14 Oct 2025 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439074; cv=none; b=X1nJTMpB4xRzaT1OBYh7aE5aQWTVA6bu82/b/Afg9sAA/HbRCOYSClLw2R4QdL8YKxmEmD7ccsPz158Fk7REdk2jRIwCtG8qGzE4m0X2NTIYK4hirLMmP0w9Y6/oNENQtw5HJKpPlujbLL6urMY6JTaJ9PwlCVzdRVc9prVUSJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439074; c=relaxed/simple;
	bh=r3SMO0hsVtpAMSQYEE8jNByy+5VAA1HUDi8Q7ydqB6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dyIM5Bxb2jhii/aOBGnO2vv+2ArpssrbKigpBpjopSkHtsz3dtt/0d6xxaaatACXcIpRvCRaiKR0CYoqClyMTqcT8kCsKxG2RTtMB3andCNibhNr1Pvr0VsEicix+YtI1S7PmAfCoKPGUuiwf4F9v3OpPG1hFAzLaYWlR+E1dWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ImhtqxR5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87JgZ030981;
	Tue, 14 Oct 2025 10:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HS/sLOlTMQ/ErfIxCptau1fJ7YiIPaYLDnJYut0AAPc=; b=ImhtqxR5dyPHLdbk
	MlFj0o/sOeX11iE4DPOunjrPaB5ROW1SOgAuXPCp3TZ6ltdC+ca9ByXhFTG7zOvx
	8lD+6AiRUdnCey2DeRBUOCtg2Glp9SqDPl2+KMrb3bJQX8kgLe5yinzEEJoSeTtR
	PZ9P1/K2jbrsHspa3isiKfO2UhtABPVMQq3ney71iaKuxr34Mbb3AS7zmFVDFTs9
	MHYKj/83C/CY6dkxB5N6J1TqT8DeB3sXC3fYtgXzyZ5L0WlaZEh0E7SZkl6Z0O5F
	N9vhF7smOlqhmZMivVitMBpucBjtGN8kmVtiWu/TcjFYEjJlk+Rcuhdw9Ahr3cbd
	rJHyOw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0r4q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:51:08 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EAp7oq003564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:51:07 GMT
Received: from [10.152.205.141] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Tue, 14 Oct
 2025 03:50:40 -0700
Message-ID: <753a7db5-c6d1-4255-aac0-12c5b61211a0@quicinc.com>
Date: Tue, 14 Oct 2025 16:20:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 1/2] wifi: nl80211/cfg80211: Add
 last_beacon_seen in station info
To: Johannes Berg <johannes@sipsolutions.net>,
        Maharaja Kennadyrajan
	<maharaja.kennadyrajan@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250812114029.23538-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <20250812114029.23538-2-maharaja.kennadyrajan@oss.qualcomm.com>
 <89df15828ef732a32b0681a3a7a2308170d80386.camel@sipsolutions.net>
Content-Language: en-US
From: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <89df15828ef732a32b0681a3a7a2308170d80386.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXzAVJSGtBOmkB
 UdaD2lWycZ+ffSaKoMq2xtPuvwA6Zi85dBByKipnv5Yvcg35T50pxV6S9BElytggPaaWMTxNKEe
 UVvKHeKNROchwva0acIHYfhrv+B9pIbJbIk+U7yo1kzt6u7e5DSZiGi4nGYNb63+6sg+WBXH1+9
 ugiNSJJQMFBCoX8+ir4AwFctua0LAApr6jpdnFItyOeW1CahvEmu4rmqqTgyYAYNLBLu+skx8qS
 88wL1PTa3kfGCBFW1LJW2uVELJs+lLCYNlKBKats7ky17WO58bAir6OGuaLpjXPznhtYE05kSGC
 BiN4OImFwEnkAP1m1jYyWr2cmCP8CZjvq16oj3rFvnRRlaK9IqtwKqMna1SaxYdxBAai1wGfSMy
 YjIybj+nsT8jt6s3HuVme+cNkxUoYg==
X-Proofpoint-GUID: TKYAPN3klBwSFBKQe4e5kerkWAXEw8Tn
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ee2b1c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8VBlgJUiRuiNAbeW9b4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TKYAPN3klBwSFBKQe4e5kerkWAXEw8Tn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018


On 9/4/2025 2:28 PM, Johannes Berg wrote:
> On Tue, 2025-08-12 at 17:10 +0530, Maharaja Kennadyrajan wrote:
>> Report the time since last beacon was received for each beaconing peer to
>> userspace. In MLO, this information is reported per link and additionally,
>> it is reported at the MLD level, the timestamp of the most recently
>> received beacon across all affiliated links to give a unified view of
>> beacon reception status.
> Is this really appropriate? We already have NL80211_BSS_SEEN_MS_AGO,
> which is updated per BSS/link and could be used. Perhaps it needs to be
> split over multiple values for probe response/beacon, but I'm not sure
> that's critical?
>
> Also, I'd say really that "seen X ms ago" is not a good value to give,
> and even in the BSS we later added NL80211_BSS_LAST_SEEN_BOOTTIME which
> is far better to use since it isn't subject to drifting between "when
> the value was taken" vs. "when the value was used" and such issues. For
> this reason alone I'm going to reject this proposal, but I'm also not
> convinced that something like "LAST_SEEN_BEACON" should be part of STA
> info, when the stated purpose could be achieved with the BSS info?
>
>> This allows applications to detect potential beacon misses and make
>> informed decisions.
> Also, this really calls for extending CQM instead and having signals on
> beacon loss, rather than userspace _polling_ for this information.


Johannes, as we already have the beacon loss notify 
NL80211_ATTR_CQM_BEACON_LOSS_EVENT in CQM, we are dropping this patch 
series.


>
> johannes
>

