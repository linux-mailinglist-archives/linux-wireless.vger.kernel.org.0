Return-Path: <linux-wireless+bounces-4018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB69F867C4B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 17:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A426B23478
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AB4433C4;
	Mon, 26 Feb 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q5HcNr0K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BC412B171
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965817; cv=none; b=UUxot5FpQ8oI9U0/AlJaW++0wikcX+FF9T6n7Z8yOO8Ol7HIJR/a72mXWWD1i2hhapmEHAANn83JsruIT26rLqUR9JEDLsWo9ZJdB4ZsZiygAy7EQUHv3Xg8TP6Y0GfHp62h+Nky2YE728d90wko/rytEkVNDFtxVL/BST8IJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965817; c=relaxed/simple;
	bh=5Pufc59uTuPaWUa2CvQ5TPZZhKS9uV4qcZ/Boeyo//M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q6KzbBNgreVUuMiNKtTqErNRBNRNYgOwQBW9EHgzIhhPUOaGV9PI2pT4T8jh3YeLJtR4B4Zj2jokWENWg+HLUZ9VgCnFJT5aSGXnYxIYYRk4pcP/OLUYBmwpz9VGc+Qbd0mc4ixfFz41iiA4sZ7TwzHL4c92+nZjUIzb7JtgybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q5HcNr0K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QF8t8D011123;
	Mon, 26 Feb 2024 16:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pZFe0g5DRvWyGOglxouOL2l/YPX2FvPue30KFYEck9Y=; b=Q5
	HcNr0Kkr8cFq2n0ZkKj6pX60fXGZGafUbu6kOqBvFwaBRL7NEKx8MVNUzxOxYQZv
	4Gw4qjafwUw63tEvZGx48gAYoWek8O/AxFXphggbhrKCX6Is0Dj9ZqVUAY9wwJdX
	uR8S30MK71mVQJqH6u4CCEB5+RWz/oeNJQ3fsc565UzyYxSbDOCzjoHs++NOj31c
	QGXts98zyksZnO3W7npf2/t/hNeYDtI2gieXUfr69WWmLlGu3gHQZM14oHTwDr8J
	832br/gbDlQYsLpaucFytBCCHQLJ6G0wkX6omnNOJPId2n9lLsgmd+XpnpqTZ8Yv
	+iHEe+Y596gMFljpY/Xw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxpsfdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:43:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QGhUZT000868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:43:30 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 08:43:30 -0800
Message-ID: <e3039fbe-9c8d-4dc5-8196-f94104f1062e@quicinc.com>
Date: Mon, 26 Feb 2024 08:43:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What is the lifetime of an instance of struct
 cfg80211_chan_def::chan
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless
	<linux-wireless@vger.kernel.org>
References: <181138f2-77c2-47f5-94d0-28ccd52fb166@quicinc.com>
 <abb0c320d284581adc80ecf8328599df9bc2d688.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <abb0c320d284581adc80ecf8328599df9bc2d688.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5j79oqZUH3aZAGFEjkmqSMZc2nUmXJX7
X-Proofpoint-ORIG-GUID: 5j79oqZUH3aZAGFEjkmqSMZc2nUmXJX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=764
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402260127

On 2/26/2024 12:31 AM, Johannes Berg wrote:
> On Fri, 2024-02-23 at 14:14 -0800, Jeff Johnson wrote:
>> I'm concerned about a potential race condition in the ath12k driver, but
>> need to understand the lifetime of struct cfg80211_chan_def::chan to see
>> if there is an actual issue.
> 
> Almost certainly isn't - the 'chan' pointer in chandef is to a struct
> ieee80211_channel, and those are more or less constant and need to be
> around for the lifetime of the entire wiphy, at least. Often they're
> just in static memory in the driver module.
> 
>> This is the target of my concern, which at first glance looks benign:
>> static int ath12k_mac_vif_chan(struct ieee80211_vif *vif,
>> 			       struct cfg80211_chan_def *def)
>> {
>> 	struct ieee80211_chanctx_conf *conf;
>>
>> 	rcu_read_lock();
>> 	conf = rcu_dereference(vif->bss_conf.chanctx_conf);
>> 	*def = conf->def;
>> 	rcu_read_unlock();
>>
>> 	return 0;
>> }
>> Note: I've omitted some error code that isn't important to this discussion.
>>
>> This code starts a read side critical section, gets the config from the
>> BSS configuration, makes a copy of the conf->def and then exits the read
>> side critical section. What could go wrong? Well what is this conf->def
>> that is being copied?
>> struct ieee80211_bss_conf {
>> 	struct ieee80211_chanctx_conf __rcu *chanctx_conf;
>>
>> struct ieee80211_chanctx_conf {
>> 	struct cfg80211_chan_def def;
>>
>> struct cfg80211_chan_def {
>> 	struct ieee80211_channel *chan;
>> 	enum nl80211_chan_width width;
>> 	u32 center_freq1;
>> 	u32 center_freq2;
>> 	struct ieee80211_edmg edmg;
>> 	u16 freq1_offset;
>> };
>>
>> Note well the following:
>> 	struct ieee80211_channel *chan;
>>
>> This is a pointer to some memory. 
> 
> Right.
> 
>> During the time we are in the read
>> side critical section we are guaranteed that, if this pointer is not
>> NULL, the memory backing this pointer is valid.
> 
> Actually ... I would say since that pointer _itself_ doesn't even have
> __rcu annotation (and doesn't get copied via RCU), the RCU does nothing
> for its protection.
> 
>> But as soon as we exit
>> the read side critical section there is no guarantee, at least not one
>> enforced by RCU, that a writer might update, or even free, the memory
>> referenced by chan.
> 
> There never was though, since you didn't rcu_dereference(chan).
> 
>> So I'm trying to determine what else, if anything, protects the lifetime
>> of this pointer, and I'm getting lost in the mac80211 code, so any hints
>> would be appreciated.
> 
> See above. It's always pointing to an entry in the wiphy's supported
> band's channels array, which is around for at least the life of the
> wiphy. At least should be!

Thanks for that explanation!

/jeff


