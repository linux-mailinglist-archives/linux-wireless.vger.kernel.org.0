Return-Path: <linux-wireless+bounces-15588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9BC9D58D0
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 05:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 473D0B21EE2
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 04:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCD5230987;
	Fri, 22 Nov 2024 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SvX32g86"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7968376F1
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732249506; cv=none; b=SRANc4Mimcp0UKwZv7nFcmoiv+TS4LNSjIYpX0koQ7bDiMVTKAdYFY0XEFAgKV4GUPtla7QzuI1TTofhIMbng35LkkCu9Qm6l0rwc0L4e/T+Pj00iI/eao2lz7ZwR1Vtzj5od/cE4JlJp4w9GU7oI5koUKn3Q1VP8x7gJxAezyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732249506; c=relaxed/simple;
	bh=oFzHYvVTasdOAybvkhkftNt/dcM2o3P6x3/D7Z5s9Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CNalBnC5ScY2HnxuDRSEu+0N5qKltq0Hq3dlInZqrJ2BOGArWU/ij7TBfh8xFcz37Ql/GXorFk02vE83ELMkreafeW7mOYTviL5Menp4zTFZuhLq+4NbCizktzTDV0jyjH2VJnF3uIQcmnXmqzW35+XIq69PyXXEAhh27mOGwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SvX32g86; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALGYkOa015637;
	Fri, 22 Nov 2024 04:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	17GR7OAPPSZ6IdE4TASKbjtYygRUm6puyBNcB9OaUUw=; b=SvX32g86CjJoOWnY
	lJhV+b3TdRpylsWbMwZpS5/UiacjlFXgQI6vv1Q+Sla2JkwvtoO1+ulb/XcXlVrZ
	mVTdMIv9jfwIHH3lhF9BTcAEkCNS19tpGUXEw2Q8QukqsboFPC6ojpqYoGpRjo9S
	CflHu4biFVP4Nn6YmbfOw8+VgvroR9jFZMqn0zCzJSP9v/NHjzi+E74nZutq7405
	TBVL+LsBLM4tMcYjgJ+04te7VmDqJjrmjBZ29p92KEaMzsBGtDRkD4/4YKTkChiP
	UmKVXwOFgnjGLe2PRWYz/NGaBcSeP+BAHq/xz81Y2GgVZv2cZxo6vhDuabMV/uh9
	f1cfeg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4320y9jy4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 04:24:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AM4OmFk023074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 04:24:48 GMT
Received: from [10.111.176.168] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 20:24:47 -0800
Message-ID: <e981ae54-dc47-41bf-9cbf-18d0f4f58fa6@quicinc.com>
Date: Thu, 21 Nov 2024 20:24:47 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: cfg80211: define and use wiphy guard
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
References: <20241121231136.4fede74dcb60.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241121231136.4fede74dcb60.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ym9gW9MTgX5xchBYxgymN_OwNBPbTffD
X-Proofpoint-ORIG-GUID: ym9gW9MTgX5xchBYxgymN_OwNBPbTffD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220035

On 11/21/2024 2:11 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Define a guard for the wiphy mutex, and use it in
> most code in cfg80211, though not all due to some
> interaction with RTNL and/or indentation.
> 
> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  include/net/cfg80211.h     |   4 +
>  net/wireless/chan.c        |   4 +-
>  net/wireless/core.c        |  53 +++----
>  net/wireless/mlme.c        |   8 +-
>  net/wireless/nl80211.c     | 195 +++++++++--------------
>  net/wireless/pmsr.c        |   4 +-
>  net/wireless/reg.c         |  49 +++---
>  net/wireless/scan.c        |  40 +++--
>  net/wireless/sme.c         |  12 +-
>  net/wireless/util.c        |   7 +-
>  net/wireless/wext-compat.c | 316 +++++++++++++------------------------
>  net/wireless/wext-sme.c    |  43 ++---
>  12 files changed, 284 insertions(+), 451 deletions(-)
> 
...

> @@ -1007,10 +1003,10 @@ int wiphy_register(struct wiphy *wiphy)
>  	rdev->wiphy.features |= NL80211_FEATURE_SCAN_FLUSH;
>  
>  	rtnl_lock();
> -	wiphy_lock(&rdev->wiphy);
> -	res = device_add(&rdev->wiphy.dev);
> +	scoped_guard(wiphy, &rdev->wiphy); {

bad semicolon?

> +		res = device_add(&rdev->wiphy.dev);
> +	}
>  	if (res) {
> -		wiphy_unlock(&rdev->wiphy);
>  		rtnl_unlock();
>  		return res;
>  	}

the rest LGTM, thanks for the guard
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>





