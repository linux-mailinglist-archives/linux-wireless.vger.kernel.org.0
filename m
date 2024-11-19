Return-Path: <linux-wireless+bounces-15489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713059D1FC5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 06:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6B7280CD0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 05:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E2814A4E1;
	Tue, 19 Nov 2024 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nxxy5Ca7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F9142E7C;
	Tue, 19 Nov 2024 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731995616; cv=none; b=lr6fYcua3LOMzOYy0x3ZdDza5PQZENZtDSjGDDLOMC6Rzo5OzXoQr7bdbVCANDhhdDQ4tGc40HHmPsokMjIZwbTjgcOzemdQHJbXvza72wFBqRIL4csL1vJzElexGrUMu5DWh1W/LGXWLdzjCzWYOSgYtJu9ljH//gxZshdxixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731995616; c=relaxed/simple;
	bh=Zbgyk8pZ1Lora2aoDUmW5t1Jbx58jfY+ZpsD2tsbsHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EvaJg4CsdzhTlBXCVHr9SW45WtniRmm6rLLvipmNch/ut9/pwerKjgfygHUPStDJRkNExECiAU/6LiF+BjqrNL+aKd/R3lKkTkWWaf2dUkFaJYexrkFufwRBYEFP46VzwE09962ohaGQxDfpc0C8HWvtssTW/0wMKkiSJL+FTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nxxy5Ca7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGhxn028577;
	Tue, 19 Nov 2024 05:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	anXaYGat0ZqPPjixzcCHBJBoPF9QSwCe5E/2T3SVI3g=; b=Nxxy5Ca7EsCukkCX
	YaiidYD+ytqPQGY3sg5bJ4JoSQHxxtRLVUc4+IKT2rZVTyhURxB+HEvSEuQCZeJl
	v1wwZfOc9gdk0GGbFgvdKPU412KoYohGMV/14tTSC1oUXah611pWceqYLfFCcEl2
	jvhgvodLpDpQKD81U4nSvw8Hjh0F6QgZKDI6LCYl6BJKmn2tCYB8pRmCXmZy+GiS
	E55totihCBULxiXZk+0lJxqV/aPCv6/aM20gcfOfU25eX2bPkZeFQTzx1TF7VUf8
	yDH4aH6kK0k5iM093u6JNzpQPyH887Jsjoh85eyBkDPUPP+WR9B/CYIUA56WmKhD
	vjy+eg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y81hff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 05:53:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ5rTgl017558
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 05:53:29 GMT
Received: from [10.216.29.74] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 21:53:28 -0800
Message-ID: <a074905b-34c5-4cc3-a38f-a2c4bc281e5d@quicinc.com>
Date: Tue, 19 Nov 2024 11:23:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: fix WARN_ON during CAC cancelling
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241113-mlo_dfs_fix-v1-1-e4326736347b@quicinc.com>
 <d0eb18d4a302e4be5251106fbfa8f5e10dd36477.camel@sipsolutions.net>
 <383a616d-50c7-4538-9e94-fc8526405c94@quicinc.com>
 <6b59e7a5f90b85dfc9146fa2cbdfe56c0a307a3e.camel@sipsolutions.net>
 <f383c25d-fb76-4e3e-b900-7156f608bef0@quicinc.com>
 <c30bde94d07e4984c02e0e329df7032f95b00a4a.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <c30bde94d07e4984c02e0e329df7032f95b00a4a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1BWmbus--cZJ3pB-Ydga8lKjP0qwfRC5
X-Proofpoint-GUID: 1BWmbus--cZJ3pB-Ydga8lKjP0qwfRC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=746 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190043

On 11/15/24 13:44, Johannes Berg wrote:
> On Wed, 2024-11-13 at 21:50 +0530, Aditya Kumar Singh wrote:
>>
>> Because link ID is cleared from the bitmap well before link stop is
>> called. As mentioned in commit message, this is the flow -
>>
>> nl80211_remove_link
>>     > cfg80211_remove_link                -> link ID gets updated here
>>       > ieee80211_del_intf_link
>>         > ieee80211_vif_set_links
>>           > ieee80211_vif_update_links
>>             > ieee80211_link_stop         -> this ultimately tries to stop
>> 					   CAC if it is ongoing.
>>
> 
> OK, but why does it have to be that way? It's all under wiphy mutex, so
> perhaps we could just clear it later?
> 

Yeah. I tried below diff, hwsim test cases shows no regression.

--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5046,10 +5046,11 @@ static void ieee80211_del_intf_link(struct wiphy 
*wiphy,
                                     unsigned int link_id)
  {
         struct ieee80211_sub_if_data *sdata = 
IEEE80211_WDEV_TO_SUB_IF(wdev);
+       u16 new_links = wdev->valid_links & ~BIT(link_id);

         lockdep_assert_wiphy(sdata->local->hw.wiphy);

-       ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
+       ieee80211_vif_set_links(sdata, new_links, 0);
  }

  static int
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 040d62051eb9..65c8e47246b7 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2843,10 +2843,9 @@ void cfg80211_remove_link(struct wireless_dev 
*wdev, unsigned int link_id)
                 break;
         }

-       wdev->valid_links &= ~BIT(link_id);
-
         rdev_del_intf_link(rdev, wdev, link_id);

+       wdev->valid_links &= ~BIT(link_id);
         eth_zero_addr(wdev->links[link_id].addr);
  }

So I will submit this as patch then?

> There's necessarily going to be some temporary inconsistency here, I'm
> not sure it matters too much if it isn't very visible?
> 

Any particular case you suspect and want me to test?

> Alternatively, could do something like
> 
>    wdev->valid_links &= ~BIT(link_id);
>    wdev->removing_link = link_id;
>    ...
>    wdev->removing_link = -1;
> 
> and accept the wdev->removing_link in these APIs like CAC?

Umm.. will work for CAC stopping from user space. But if radar is 
detected, in this flow (driver -> mac80211 -> cfg80211), valid_link 
bitmap is still valid and hence valid_bitmap check works and there will 
be no removing_links set.

So then may be both needs to be checked? Like either the link_id should 
be present in valid_link or it should be the removing_link?

if (WARN_ON(wdev->removing_link != link_id &&
	    wdev->valid_links && !(wdev->valid_links & BIT(link_id))))
	return;

I'm more inclining towards the first suggestion you gave - clearing the 
bitmap later. What's your suggestion?

-- 
Aditya

