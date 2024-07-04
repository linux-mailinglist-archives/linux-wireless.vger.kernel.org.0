Return-Path: <linux-wireless+bounces-9980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C679270AC
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 09:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B441C21323
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCADE1A0B02;
	Thu,  4 Jul 2024 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HQgz3IkC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B391A2FCF
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078318; cv=none; b=NwcISGLEAbKe1cA+uDFbuB1gfvtH1bRsQHEgV0a95ct12U4H5bBybl2VJfrcoNqeaTMgpCEwZXn1SsFj1mHK5tlwB9MIG45vwo1RZp6gUOhKj1hlto5rtgog40eR6ihmLx9egqYLQejHZOwyvzlw+LDRNlXbtMjApwNkCz/hwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078318; c=relaxed/simple;
	bh=6A9EEoqCq4zGo4PbKW0PDa1qFQQlRDGys59guC59sKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ojq8cLJdtW7B4mrt+IVdnaoa7gIPkTL8rVb5CRu+x5PeaGzsnyKxaJmgeczfRAQbRzz48yh6THYTDbbwxay+0Lt7hVlbSNBrfoNT+cFuxJVSgxluaO5AOfOS6qkgUNL8JXVwaNcP50HniG0tcOV5Ts7SZnOO4XKkHErsClRY1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HQgz3IkC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46442iCV028831;
	Thu, 4 Jul 2024 07:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KwF5v0N5DtlkmMGp0Esdfxs/brVYayMKsNNKI9dXmSU=; b=HQgz3IkCSLPNfUsk
	eoJO3NBTQrkbaFrsjMLGeYXad3ncx7Lg9FwO4KcPqeMz5UMeschg1VKUQYvGGCH2
	XkhnGxfz1WeHxOCCiP6s1PeG4ASr2MXE1IVGJY+wokNxDF9hXAagCwJDcDiNJDyw
	i6fi3tv1svb9LruAuV8FMrk21PtKPh6XMh899IHInOYtSGpviVn7BGxheTopcswT
	8VycBuSSm7ePV3asQduFUwV3sLIlQCW4kJo/9juiCI5ZV6lv3p11eOZYutsMOVFZ
	aJ0RnFKzfE4ZyLi4KvO1jH2herC60SSCmtTgru5KCYkUHjlwqxiugz2zwCKy/35E
	HsKGAQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404kctmy8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 07:31:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4647Vkxx013548
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 07:31:46 GMT
Received: from [10.152.203.156] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 4 Jul 2024
 00:31:44 -0700
Message-ID: <ad821e08-b6d7-1355-6665-e96af668bd2e@quicinc.com>
Date: Thu, 4 Jul 2024 13:01:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] wifi: nl80211: allow MBSSID Tx VAP bringup without MBSSID
 IEs
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
References: <20240621074038.3938005-1-quic_ssreeela@quicinc.com>
 <dc5f37a389d05881f2b2120e0ccbb60aa64c6490.camel@sipsolutions.net>
Content-Language: en-US
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
In-Reply-To: <dc5f37a389d05881f2b2120e0ccbb60aa64c6490.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3wEc4XsOF0AtLmVH_8am8gh7Z8TNmcMv
X-Proofpoint-ORIG-GUID: 3wEc4XsOF0AtLmVH_8am8gh7Z8TNmcMv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=891 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040051

On 6/26/2024 5:45 PM, Johannes Berg wrote:
> On Fri, 2024-06-21 at 13:10 +0530, Sowmiya Sree Elavalagan wrote:
>> From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>>
>> Current implementation of MBSSID configuration parsing mandates
>> MBSSID elements for Tx BSS (index 0). However with ML link addition
>> it is possible that Non-Tx BSS'es can be added at a later point in
>> time after Tx BSS is brought up. Hence allow bring up of MBSSID Tx
>> BSS even if no Non-Tx BSS are present at that time. Later when new
>> Non-TX BSS are added TX BSS beacon can be updated with MBSSID IEs.
> 
> nit: I tend to think we should mostly use "element" instead of "IE"
> since the spec changed (subject and text), except where historically we
> have variable names etc.
> 
> I'm also not convinced this actually works without further changes down
> the stack? Think ath11k/mac80211 for example, where
> ieee80211_beacon_get_template_ema_list() is called but would now return
> NULL because 
> 
>                 if (ema_beacons) {
>                         *ema_beacons =
>                                 ieee80211_beacon_get_ap_ema_list(hw, vif, link,
> 
> but the list is empty.
> 
> But you can still set NL80211_MBSSID_CONFIG_ATTR_EMA so it would be an
> EMA AP, and have config->tx_wdev set ...
> 
> So I don't think this can be correct?
> 
> johannes

Hi Johannes,
 
I agree, but based on the current hostapd implementation, this flag NL80211_MBSSID_CONFIG_ATTR_EMA is set only when num_bss > 1. This flag will not be set when we do not have any non Tx BSS.  
Even if this NL80211_MBSSID_CONFIG_ATTR_EMA is set when no TX BSS is present, can just fill beacon template in 0th index of ieee80211_ema_beacons structure, if mbssid_ies are not present.  
Shall we handle this in mac80211 layer in ieee80211_beacon_get_ap_ema_list function like below
 
ieee80211_beacon_get_ap_ema_list(struct ieee80211_hw *hw,
                                 struct ieee80211_chanctx_conf *chanctx_conf)
{
         ...

-       if (!beacon->mbssid_ies || !beacon->mbssid_ies->cnt)
-               return NULL;
-
-       ema = kzalloc(struct_size(ema, bcn, beacon->mbssid_ies->cnt),
+       if (!beacon->mbssid_ies || !beacon->mbssid_ies->cnt) {
+               ema = kzalloc(struct_size(ema, bcn, 1), GFP_ATOMIC);
+               total_beacons = 1;
+
+       } else {
+               ema = kzalloc(struct_size(ema, bcn, beacon->mbssid_ies->cnt),
                      GFP_ATOMIC);
+               total_beacons = beacon->mbssid_ies->cnt;
+       }
+
        if (!ema)
                return NULL;
 
-       for (ema->cnt = 0; ema->cnt < beacon->mbssid_ies->cnt; ema->cnt++) {
+       for (ema->cnt = 0; ema->cnt < total_beacons; ema->cnt++) {
           .....


Thanks,
Sowmiya Sree

