Return-Path: <linux-wireless+bounces-7550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E16368C3682
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D82DB2182F
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B48210FB;
	Sun, 12 May 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S2B3oO0O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE650210E4
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516920; cv=none; b=RYmPAmIN6FFKY70y0OME0x/ufNro1Ap5NvVu+95/jI6NAYK/Q06d/kY2jW049xcCP7WdtY70oesHRJZ9RIhpS5l7oz5xu9b1dz7EPV2vKujrngqBa7yevl0uK3CNGsyMrWUM7AXTMG5hpcxwrc8uQvVnKwKlkpAcEFsHWYFQueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516920; c=relaxed/simple;
	bh=3zsZck2oIjbs0GoQu6yupDyMAmHSE94P11FKPr7DA8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fpggq+une6kRocLEjg4zmgz+1XlyNoP2QY8Aw475O09QmQHkUwrjvQZ2j448RDWmBa8j98OkQsZKUv9bFD8ScM99XbqNB3LsHg0h75/k3T1rg2QYv01/7uMjME3jhid+h8+yW22DTQIB//c2T+IrGVXzubrtSNcSz7ydZabZLtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S2B3oO0O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44C70DnF005907;
	Sun, 12 May 2024 12:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uh+n5DS/orZEViM9u57KNZm4CTwaavbqONfvUIl4YWY=; b=S2
	B3oO0OPkQuZKoM4tuGKK8DxydjKWrSj8HOmJmLxRz/kcAE7TntDA85ysjfwpxOkH
	L+v3LJCCbVzWgOUE0Jv8NVSo+OZmUETMYuTwbQdtUvtRCWCkhtfO257UW4eeR+aN
	mNd7k9rp8hyGcDTSel7ow4VN1x7lmnUUcr+o9EpCAo/1izt10EU+84Ulnh7Jr5Mn
	O5vL9TB5udhmfta/J4uF7K99DCoaLmCN5AI5EtHdvyVM4K1UgT0KwOBtFIe5Poix
	13HRsh3QaHQIrUaxyKTnuFx102MdUSwIyygvsPZMGR5MAks0Y0ixClwh/820x7kI
	SNlDDWLkgF+be8fDdWkg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y200f9r3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 12:28:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44CCSVO8002982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 12:28:31 GMT
Received: from [10.216.54.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 12 May
 2024 05:28:29 -0700
Message-ID: <b1cf7a1c-7f96-4c00-a9b5-da5f2648fe7c@quicinc.com>
Date: Sun, 12 May 2024 17:58:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: move radar detect work to sdata
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
References: <20240506211311.43bd82c6da04.Ib39bec3aa198d137385f081e7e1910dcbde3aa1b@changeid>
 <4dd39edb-cd23-482a-8c94-b09142d92198@quicinc.com>
 <88b36efce036ad4f0316ffb434a5352bbe4f1599.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <88b36efce036ad4f0316ffb434a5352bbe4f1599.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SK5jHw2-JVut4oxaBLwJmTnAsv_Dbl_w
X-Proofpoint-ORIG-GUID: SK5jHw2-JVut4oxaBLwJmTnAsv_Dbl_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_08,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405120093

On 5/10/24 19:57, Johannes Berg wrote:
> On Thu, 2024-05-09 at 09:52 +0530, Aditya Kumar Singh wrote:
>> On 5/7/24 00:43, Johannes Berg wrote:
>>> At some point we thought perhaps this could be per link, but
>>> really that didn't happen, and it's confusing. Radar detection
>>> still uses the deflink to allocate the channel, but the work
>>> need not be there. Move it back.
>>
>> I'm currently working on MLO DFS support. It is better if the work can
>> be left in per link structure. With proper support, instead of deflink
>> it will use appropriate link.
> 
> A number of patches I have actually depend on this (though only by
> patch, not semantically), so it might be better to leave it and just
> move it back.

Oh I see :)

> 
> In any case, your work will likely have (simple) conflicts in some
> places with the other patches I posted.

Yes correct. Those are minor as far as I saw them and those seems fine 
as well. But this one, felt like I will be reverting it soon so if 
possible let's not merge it unless it is affecting the code base.

> 
> But we have a couple of weeks to decide, I guess, given the release is
> around the corner.
> 
Sure. I'm doing testing as of now with my changes so it will take some 
time to appear here. If your changes gets merged by then, I will rebase it.

