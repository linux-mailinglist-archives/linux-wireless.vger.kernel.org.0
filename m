Return-Path: <linux-wireless+bounces-3856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C2D85D7E0
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 13:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2081F21BCB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA4651C5D;
	Wed, 21 Feb 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LhqdI4M1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF150271
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518281; cv=none; b=NiKWtsIknYm5Li/nS5fTbAlvCKhUQ8XrpetiRNSsvAt65hCUp0uKXrolfLDBUVR+pP8syKTcOePQuRd1AMAJiSs5jXzD6Q+aECsZIBZk5J7eCCSO8ZvieCV4q+tIewhdROy7b0wTRE2LGBYqfFFODStLNFD+nI2k+NuChuSnHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518281; c=relaxed/simple;
	bh=v37Ghc7rTfudiqOEx9M56CHv48PXUxFQerCxByWJ1xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QzLs2nXkSlnem3yAI2/U+fLp9wk+DCNAMsbzdrjLNJUvqeKCBH4NkOHchn1Y+D05HzQ4pRGQHwVlyGPryNJGkjB3t0LRMHG4DSshdn4qjF8jlQgMpVn2Ny1saH6e5qDz3BDHd2LgzcGCqLpDQZtTicz0aYancOcp2kCE5P1NiUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LhqdI4M1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L7DvJf020074;
	Wed, 21 Feb 2024 12:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=21CaNDprtMTVNCQaa6C/qd6lgm36uIAWeOBYu4suAr8=; b=Lh
	qdI4M1fQyMgM1qiAtMTcFX9ilYVlXIk0vAjpv38ibvQDnMezMqWlUeYxaBUWZqeC
	D75vyWEO4W1av08cd1rAitfYem4Wz5JbPmSDftdmG82tIDuEtFrqRqtxRq8k3rh2
	7YJp0KVxCIbO2ODjqjyPKx16aQCCYT+2P2jYOFNtLFZta0l1MhJwboZVHoHYePjy
	zo3Hv9YjnML4+3n8o/p8xYChFEl7BWJnJht9v5i9F4bpFTaqsVAtEuIXNjFer9CK
	e27WEZV680fJ2VNKT1WusL4v6NagN0rH+8LPyTKZguNNfJJEq6UXb0lcU5Fkgw0e
	7z7eKlHsuNGzuSxBu/7g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdckv8n5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 12:22:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LCM5HH023462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 12:22:05 GMT
Received: from [10.216.12.189] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 04:22:02 -0800
Message-ID: <65baf7f4-c309-47df-8577-7d0c518da642@quicinc.com>
Date: Wed, 21 Feb 2024 17:51:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Ping-Ke Shih
	<pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>, "Jouni
 Malinen" <j@w1.fi>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Arend van Spriel
	<arend.vanspriel@broadcom.com>,
        Felix Fietkau <nbd@openwrt.org>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
 <20240130140918.1172387-5-quic_adisi@quicinc.com>
 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
 <5a89e63fb7644d12be72154c90c96199@realtek.com>
 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
 <df711a5978b84856a54953a32e4b05923b48870a.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <df711a5978b84856a54953a32e4b05923b48870a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TGDX76RV4qr0j543NNndo9AtuD2D8uFu
X-Proofpoint-ORIG-GUID: TGDX76RV4qr0j543NNndo9AtuD2D8uFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 mlxlogscore=906 impostorscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210096

On 2/21/24 15:12, Johannes Berg wrote:
> 
>> I guess then for Qualcomm we'll need to just add an extended feature
>> flag for "FW_HANDLES_PARTNER_LINK_CSA" and then hostapd can just not
>> update the parter link templates, or so?
>>
> Or then again ... Maybe the other way around, since it works for
> Qualcomm now, assuming it all works at all? Doesn't really matter, we
> can call it "WANT_PARTNER_LINK_CSA_TEMPLATE" too and have it inverted
> logic.
> 
> johannes

Yeah anything is fine. Basically this flag should be visible till 
hostapd (so probably some wiphy level flag), so that it may skip forming 
beacon templates of partner links in CSA case. Based on the flag, those 
drivers which want it, it should form and send.

