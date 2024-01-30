Return-Path: <linux-wireless+bounces-2752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CBE8419B3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 03:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A5C1C234BB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 02:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414BA3717D;
	Tue, 30 Jan 2024 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YSOe1eID"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60336AFD
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583410; cv=none; b=EF3yYiYfKQac1XtdXOeT+HjRrbaXCHvyi0aOqOfpT2qBoF9QwhZrh5/lX7Ca/cURSZBDIjbZjYukiFBkATJ68WnamVYPYMc0/79XAfx4kuFX9Rp3KmPb8ugxVhiH2b69mxMI/jVumdxr31gjfBepRyz6pJV6FIhsQdxjH9i+fps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583410; c=relaxed/simple;
	bh=7RDfuRX8bEvqrK7033paXnK7a9Z5pUsEOW8QOfHnPyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EdPS74l+nhmZmrIAl8s/a0F+SCB53vq1qGWfoiURn5igW6bWRJtKrMVikTMWhCutEdrAUD6tMWH7fzx/iJdPWE0DlQ15XSseSYz94FtGbOOXi1B0kRqRVYjhn+tnS16ff1+vn8sLoH5hIgdv9gdcVGX+vI8AmCTAfUEzRB73nHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YSOe1eID; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40TNbOto008002;
	Tue, 30 Jan 2024 02:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nTBFwx/BG1qh8E5cdTVAv2YDcoMUtFTBE6RTzzC/Dz8=; b=YS
	Oe1eIDDHGDGw/wDEM9B1dRXAMsI9VL4jeqkLaBzbHbHmrD4HSGS/aFPNnvUSdp07
	y7yhyALn2C0E1mCf3MsZf9z3Ov5KGqh3iRuu3URJGo25bOXlUtmTcx58x9U6U1lS
	Sj8xd3u5qA00RRP13vYUY/G+ML0zZ6yIiYUBVvZ2nw0lpbqJL03OTaPWwMGAvPLz
	bg3otnn7V5dEcawPPLiy5LD/2mR0l75pxuAnABOfDAVo+qfWjYnUxC6BGKdSAWqy
	NZ2AMmh7cIFhn/M4ZBNh4B3CowYj+ZwtkdQXZhbjzkN0QQRkdNiIiNTzESybWC1n
	Kxmq1B0fmgXxUTNLN2jA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx23kay64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 02:56:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U2ueQQ023731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 02:56:40 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 18:56:38 -0800
Message-ID: <6194c8a6-89c5-4c14-aaa9-b20a7b8a7d99@quicinc.com>
Date: Tue, 30 Jan 2024 08:26:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] wifi: mac80211: update beacon counters per link
 basis
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240129052832.905113-1-quic_adisi@quicinc.com>
 <20240129052832.905113-3-quic_adisi@quicinc.com>
 <44350e13-7903-47ee-bae9-11b2072146be@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <44350e13-7903-47ee-bae9-11b2072146be@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qPbmwv-7t86Oy62sC4LnT96vUyB8v1uj
X-Proofpoint-GUID: qPbmwv-7t86Oy62sC4LnT96vUyB8v1uj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=919
 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300019

On 1/30/24 06:53, Jeff Johnson wrote:
> On 1/28/2024 9:28 PM, Aditya Kumar Singh wrote:
>> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
>> index 68a48abc7287..504db497df06 100644
>> --- a/net/mac80211/tx.c
>> +++ b/net/mac80211/tx.c
>> @@ -5030,16 +5030,24 @@ static u8 __ieee80211_beacon_update_cntdwn(struct beacon_data *beacon)
>>   	return beacon->cntdwn_current_counter;
>>   }
>>   
>> -u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif)
>> +u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif, unsigned int link_id)
>>   {
>>   	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>> +	struct ieee80211_link_data *link;
>>   	struct beacon_data *beacon = NULL;
>>   	u8 count = 0;
>>   
>> +	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))
> 
> shouldn't this be >= ?
> 
> aren't the arrays size [IEEE80211_MLD_MAX_NUM_LINKS] and hence indexes
> must be 0..IEEE80211_MLD_MAX_NUM_LINKS-1?

Yes correct it should be >=. My bad. Will rectify in net version. Thanks 
for pointing it out.

> 
>> +		return 0;
>> +
>>   	rcu_read_lock();
>>   
>> +	link = rcu_dereference(sdata->link[link_id]);
>> +	if (!link)
>> +		goto unlock;
>> +
>>   	if (sdata->vif.type == NL80211_IFTYPE_AP)
>> -		beacon = rcu_dereference(sdata->deflink.u.ap.beacon);
>> +		beacon = rcu_dereference(link->u.ap.beacon);
>>   	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
>>   		beacon = rcu_dereference(sdata->u.ibss.presp);
>>   	else if (ieee80211_vif_is_mesh(&sdata->vif))


