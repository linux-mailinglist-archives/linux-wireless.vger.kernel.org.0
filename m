Return-Path: <linux-wireless+bounces-9637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3369F919DF4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 05:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA58E282EEF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 03:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834FC13AD8;
	Thu, 27 Jun 2024 03:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TNZ4dV6Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2732139CE
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 03:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719460022; cv=none; b=OKCD5ZLzqUtmXRDjObVXXukyCKb6oGx9gYz6/h6EgSAW/YMyxnffaSwpGyr0sNyWeTL8w5Ih98rZHMj7rZ4y8rohp0tQ/JrQhX5XiZdYgRKiGi1cGNdiW0L+nXwTAl8DE/Dh/LmtrZWGMXBeOBVeAKtzwnjH62ZblK4PFDxwYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719460022; c=relaxed/simple;
	bh=sAmrGjNQG5JYIXOx0RglWgfMGDE8VZLhYwcraPgYrYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=krwfmnRRWyietZxPQa/5w70pRu/adMaKuG1dFCveWyRY+XSVoU5XA5UexISZXDF5HURwJ8jJLz4dXQFlG6GhfM13iXPVr4Zpxi7amUSRQoJNkjS3eMq9ckdWuWFiS7ZLZVUgwxk2rEIKGBQQ6PtpmAw6p6Y2XtGXV1w/e1sxvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TNZ4dV6Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QN8u8Q010673;
	Thu, 27 Jun 2024 03:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Vm533NSxOx2EH5e1shwy0/+PMggdg0Dm3ELn9ZZapE=; b=TNZ4dV6Zo8yb+h41
	PCSojsLKhD0Cnb/vxULr/xNQgVu+QhbBZmLATNT15TG9AWvpcK6EfLNjVDY/tvo1
	qHx03UcFrWYZzJoU35Nw7HxB8r7MyJFSn6PcTUqUMjPcVo6RHTC4MIGiwzC8Ji19
	x34DrH1C+Uc9TSxxChaC27JkG24JkEvSh3saukhYShb9FtKA9+Br3Wb6txM9zEtJ
	QD39pwBOD6b6wc3c4gnOl/OhQPvt4BRq1XvN3GkWenWCQgh9blachOIJ/iiO8N24
	vTNPOzowIET/1B0LpSYLcinmq1+rRj67wYgbToK7jLrMrK5LWMSFFdaarymHE/hC
	Xt/UYg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400bdqaysf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 03:46:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45R3krIh010408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 03:46:53 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 20:46:52 -0700
Message-ID: <2d24ce0e-3673-4351-91ab-f7389564dc56@quicinc.com>
Date: Thu, 27 Jun 2024 09:16:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] wifi: cfg80211: move DFS related members to
 links[] in wireless_dev
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
 <20240626045216.3754013-3-quic_adisi@quicinc.com>
 <fe16681268e2a2c9a69867fc954f3d6e777dcaf4.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <fe16681268e2a2c9a69867fc954f3d6e777dcaf4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AO7PFWJgoKyCNyRBuVTp2osKAJJTwh34
X-Proofpoint-GUID: AO7PFWJgoKyCNyRBuVTp2osKAJJTwh34
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406270027

On 6/26/24 17:54, Johannes Berg wrote:
> On Wed, 2024-06-26 at 10:22 +0530, Aditya Kumar Singh wrote:
>>
>> Since currently, link ID is not known at all places, use default value of
>> 0 for now. If link ID is available, use that instead is such places.
> 
> I think you're playing with fire a bit this way ... now you can e.g.
> actually start radar detection but it'll use link 0 in
> nl80211_start_radar_detection(), but then start an AP and actually check
> that you're not doing radar detection on _that link_ in
> nl80211_start_ap(), all while mac80211 (only 'driver' possibly
> supporting any of this right now) still hasn't actually been updated to
> do anything per link ...
> 

Yeah I see your point.

> Now we could argue that it doesn't really matter since hwsim is the only
> driver right now (though iwlwifi will enable MLO soon now).
>

ath12k too will enable soon :)


> But also, it seems unnecessary? Why not add the link ID to APIs and
> mac80211 first, and then actually switch over to using it? I may be
> wrong, but naively I'd think it's just a question of ordering and/or
> recombining the patches differently, more or less?

Yes I could re-order the patches.

> 
> Certainly you could have patch 5 first, and just ignore the link ID in
> cfg80211 for now, and switch over to actually being able to start CAC
> etc. on links other than 0 (and checking against the correct link) as
> the last patch?
> 

Got it. Thanks for the suggestion. Let me do it this way and send next 
version.


