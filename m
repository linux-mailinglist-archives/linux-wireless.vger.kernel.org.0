Return-Path: <linux-wireless+bounces-3852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934785D6D2
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 12:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04ED91F2210E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 11:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44D23FB14;
	Wed, 21 Feb 2024 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FOBX59L9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C03F8C0
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514855; cv=none; b=CEqFrKEeIKPBVyZqGltO/61BgffamtX90v09vA2SYQNok63uy88A1hFxkcKuY+q7g1QbbtHs4h3Ktffw2BCgX2IQf76xaFXSkZnlWVqElxZHcHaJDz923bBO4uMSdeCdk7X0u7jjpYXMP6jRTMVpJudUawdo3RXOJEKgZFiIPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514855; c=relaxed/simple;
	bh=DYbyU6aoc/iQRoZYPxg73GIiHmc4RsWtN0G9gMhJR24=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GvZACRXZpO9PBb3hIwTuCMZiUbeHuhHo8op81JVDmPN9KJMAg/DQTWPsZ819h4ilA70OVYNTL0h/CiXxfaEKXRlR2T6wi4koQ9Qskyz7sjx0dP5B5htfZe41tr4yrR5gOcGD4EDPchY4O4mJAwx5tJKoJ9nji3X29BEc+ausEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FOBX59L9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L88itM005529;
	Wed, 21 Feb 2024 11:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XRQkGfW81Mo82JM0fTDOnvBtE39o/WmyMIqEshGCspo=; b=FO
	BX59L99uGCORrf2VvaS5GI8dZ8N9otITlfPPzzoz1aTbMHlWyqsZ8kJw4oaFsIir
	HZL69RZpobxjSGSZ+ALvcKjHaDSl3AyYFOha00alBDKfKAqJIiZaGHc4oaa0WDIC
	WjhgliMkWX4/dPKyv+IX0KEiV0RfXk/MHGscjUV3dZg2xFfZznhVggKGPcO7tg2h
	ehdcxq0/WRjBBHUPZ88V5BkQpkY5XNbdje237c1QkhwYwzRkvicUTFI1dHtCYEB/
	S+G0R3xWIkkoRPC8eNeYzF/UT0ieXHfMVCYmImYdQFKz1zYPm/LMsVKq0pZBTrm/
	uy6sO/n+gZnYWEgxqBYg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdddg0e7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 11:27:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LBRT53000728
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 11:27:29 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 03:27:28 -0800
Message-ID: <55af0488-7b3e-42f6-8013-263c63458366@quicinc.com>
Date: Wed, 21 Feb 2024 16:57:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] wifi: mac80211/mac80211_hwsim: support MLO CSA
 test case
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240216144621.514385-1-quic_adisi@quicinc.com>
 <83af2d42df024032d1bd1c200c774b7ef10f1705.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <83af2d42df024032d1bd1c200c774b7ef10f1705.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HMgJ8_NUu3uiuoMrhMk2Ax6l0lT04ECZ
X-Proofpoint-ORIG-GUID: HMgJ8_NUu3uiuoMrhMk2Ax6l0lT04ECZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=913
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210088

On 2/21/24 15:38, Johannes Berg wrote:
> Hi Aditya,
> 
>> Recently MLO CSA is enabled on the stack. Add test infra support in
>> mac80211_hwsim in order to support basic MLO CSA test case.
>>
> 
> Can't apply this right now as we're pushing wireless-next up to net-
> next, but looks fine to me. I'll probably drop a 'return -EINVAL' on the
> warning case, but no need to resend for that.
> 

Sure, thanks.

> I also wanted to ask though if this needed any hostapd changes?

Yes there is hostapd test case to validate MLO CSA. Will get those for 
review to Jouni soon.

> And I guess for real multi-link we need the CSA update things we've been
> discussing, I'm guessing you're not going to want to work on that in
> either hostapd or kernel since the ath12k firmware handles it all,
> right?
> 
Yeah at least template update for partner links, not really inclined 
there but I like the idea of controlling it via some flag as you 
suggested so that driver can choose. Currently checking with team 
internally on how to do that. We'll get back soon :) We do have some 
points to add to the discussion thread, will send that as well.



