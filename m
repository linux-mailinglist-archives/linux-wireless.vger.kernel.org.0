Return-Path: <linux-wireless+bounces-29815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C10CC3FBC
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2C913061371
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 15:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4E3346A06;
	Tue, 16 Dec 2025 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q8LF7unt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CuZfhBA1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023423BF9B
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898453; cv=none; b=edJtlQMYb/hX8ucO5ABoB522siWY5Aa/yfp4fM4oZFJyROPc3djk/A4sUkN8Mj6e6POj2SXPlIi/k8EvhbxyFJyjbU6wzUwrzEBGW/A7QKaGwy+VGQ7VD365qTXaH+G7zeLC1HqcxvtIa/XnM296oLSuApbk3xOQkx8QfDzTCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898453; c=relaxed/simple;
	bh=Rt4Zmty9MQqv6YQBGUrJoVe/ukHxvLkEktE5aVwJyhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKBUIUxyNzdZzger8MVA0A8dB1OeZ0/ywx7n7lol4msIEdCV1uVEvEYmSiEWy4A8igdV3UgFgCkRNbaH8Wc0l/dLRbIbaa9VBhlRMgZQ29qv6kFO9fbotD1LfmkQZORlJwuxvOBtf5YRDdfbktPuYnPIwrxYZFScuLSiZu4cDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q8LF7unt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CuZfhBA1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGC7B4R3708459
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	psuVQzRneqWjPM1U5AwkoargHFJyZN9w0T7CWJ3ukXU=; b=Q8LF7untbyZaaMTM
	+qZS05XLt9oMT3wW6la/VaKHP7EtApMf0BwgnL7zKzE3advauS++USarTXEVMrPN
	A0O7dKSeBDoyGrrBN8AqP6sJBOrTaW4URa28ClYpMhEorM4jhzFwT7NuvnQ9c3lF
	QI77mF3lHqD6fZpscww6Ki2+xsBgYKPJrjXRwvYqbov0DRWGA2IYwzKGFCPhF1fs
	J1MrtgJh0gAAYk1+KX1x9hzPM+C6d2oVrqaBhxaRSVRrmUtABjJZ/ZNTvJXdxsC/
	FDTY7yR25qF4dxl0Ood2Ej3KQPHStny5gKz3XLBKPiTdGmO5gQrSRGjQh7jyHauM
	n6fOdQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b375b0qd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:20:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a07fa318fdso71105815ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 07:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765898450; x=1766503250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=psuVQzRneqWjPM1U5AwkoargHFJyZN9w0T7CWJ3ukXU=;
        b=CuZfhBA144g1z9zja5uYCoP1pDjPeVbp33OVJOQ3thtbkvsZzwf17IESoESM1Oot/U
         J3Z92wFoxCwFx5oJsn6bxRxg/Tr38tmHsfFZLlVWLaZq0oI52YHikVOgt+UM98XqmaVA
         kWGy15QEi4Xjdwp2RvdwioRWAz8OUXcmAqBgXveRFJcX54NRYhcY15Vt414VgTiW1zuw
         3RJJpvj5QM3K4zDiiSY5vgStfha9CLcW58TJcnaPjW4+xABnwq5ALGwKYq5wTH41t1JY
         9Ulc7eBzDNKhC9PdN58asb6pKL6yaYBihYBVbO/PdQhhen/k+2fujmG0ubTLeUKKxgOU
         Ci7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898450; x=1766503250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psuVQzRneqWjPM1U5AwkoargHFJyZN9w0T7CWJ3ukXU=;
        b=OAvT9jFXOJQ1PAFZIcTismd20rtOkzKYj2gfjSwf7BwhhnvgXHIil+NPjXtwn4dMXJ
         JB97+YObPFSSQ0kguBsa9xpXqIF5OpugSPMP3CHU3zW57Bpq+PgRKtm8ZHaGTy1zpjqQ
         PjmXOtjIZ9iX3KXtpPTTG8YfdCk6xZtC4AFTiZVArWpVzEo8G835NZgnYqQi7ZDiiu95
         Pc28lR8XuXXWhJOTapzzq4QyJyE9QPnWqb6uBuuakr14AlAlMg+ftnqbu8CZ+ZL3QQ8P
         PeIF0i/ZPt0WAD0fRDTwNbIPydFroUM4eF9Hgn36uDY+kyEvpoejInUQnlE/F7zF/c2+
         CRyw==
X-Gm-Message-State: AOJu0Yy68DXzaX3NqZwCauT/owA7+n4VXavX3Zkb5ICu2N6N1am3tDNk
	bBrIVRcDeF6J3NgL5so6NRZT9zS2W+R+X/82gvuxWdLWkwj8fjVVTIh4kS51r81kB/bpE+Kozbe
	Ze8WJ24HUaJeyA7w/c8P6gH4NDK5+6wqvxoC4W1MA2Hh9fO0hGR3Cx2yROpoM9ANQlXRZKlDjcc
	oP3A==
X-Gm-Gg: AY/fxX6TBUHF1fMYW9pucTkB7S8t4fPuJBcWN0zspoF81fmaL2ApnpcjMqGGkr+uJ7Z
	dyzrn2AjKdSfA8d0MT86EDb3fSkiPwO9+KV8ec6WgoPEUpBXm437lu3Ff39V9LdLKzNv3bsyvKJ
	0/bms+zQq9wIfxesBLYS8tQWyPUZuBzBxh+zRn4J35/HLgNxemnSB4Hl8IULbBbZOZdt9Gct+MA
	G+E9jGlzX6GfMY4XDFtxVGNl/7fguZk+AZijxph0NbJeuEkFJRvYm4fA3nykKX6MDGC+Vn6v8GK
	ZLHmmeH8zT/69y3xykRGKdl+vkaVMM+G2uGWnoxBSZpimIl3tJHGF6Bs8xN+4Ll/HeLrZ6rU8qC
	8f9mHDcvQjBLTgctRM6RAB2pgKWDs8pGYuC7uqOa/kIA=
X-Received: by 2002:a17:903:22c4:b0:295:290d:4afa with SMTP id d9443c01a7336-29f26d12fe5mr129786895ad.23.1765898449618;
        Tue, 16 Dec 2025 07:20:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEddmgU3t3Q3SzKnfFfjh5DWI6M11aQVHZGwIqxr9WjP6Am+Yzf21yHTbFbrl7otNWuxOWI3g==
X-Received: by 2002:a17:903:22c4:b0:295:290d:4afa with SMTP id d9443c01a7336-29f26d12fe5mr129786465ad.23.1765898448998;
        Tue, 16 Dec 2025 07:20:48 -0800 (PST)
Received: from [192.168.1.10] ([122.177.242.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea06ae3bsm172484475ad.93.2025.12.16.07.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 07:20:48 -0800 (PST)
Message-ID: <826b98e1-720e-40c8-92ff-b0d79674fa5f@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 20:50:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 10/14] wifi: mac80211: add support for
 encryption/decryption of (Re)Association frames in non-AP STA mode
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com,
        sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
 <20251211124051.3094878-11-kavita.kavita@oss.qualcomm.com>
 <6234932474d27f27924e5ee8527f717af3d390e4.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <6234932474d27f27924e5ee8527f717af3d390e4.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEzMiBTYWx0ZWRfXy1rmWfpku39t
 4I7joHNz6Wg9L4OJYXyX+ogy2RJ/BSjV77blM16d1Tds++ZsdqiLfsqqmft7YoqjuH2jSjp6KP9
 Kn3pk7IvBOvXgBFB0X4F3xGwXV1DXNGb5nxx9jv4YMAr/yLY3MY1mFy04gbcrousKDccVJU+b0e
 6r6oqHS7Yg2JcUfaG/jdrM4rmKXPHPfNPZO1Kbk2wGiHWf23PFZAEL8/0Zs7XTJHFXVTyl+dCo4
 0EgF8bfg6Is9hMtWALs0OAoy80J8OaN5gImEThz0pkG3RtY0vNNLGEOGNdXlKxTWJC1Iq91KScP
 lGOc+uq3MFK8cmTgaBy46ZYD+XQ6B9Bg7xwzPIToO72jVaVpqOwjtqUGzqryQnA6JlyVePgIkub
 FT29RzQbjXl2fgUlBRJOYfaRSFHmBQ==
X-Proofpoint-GUID: 0FC6RRo2ePq5mxSunF2kuE0dwUrNclma
X-Proofpoint-ORIG-GUID: 0FC6RRo2ePq5mxSunF2kuE0dwUrNclma
X-Authority-Analysis: v=2.4 cv=T9qBjvKQ c=1 sm=1 tr=0 ts=694178d2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=vaJ6/3d+63OnhzhRW74whA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z4lJQlw30IK5XAzUxUUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160132


On 12/12/2025 6:14 PM, Johannes Berg wrote:
> On Thu, 2025-12-11 at 18:10 +0530, Kavita Kavita wrote:
>> +++ b/net/mac80211/ieee80211_i.h
>> @@ -2397,6 +2397,26 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
>>   				 struct sk_buff *skb, int tid, int link_id,
>>   				 enum nl80211_band band);
>>   
>> +static inline bool ieee80211_epp_assoc_resp(__le16 fc, struct sta_info *sta)
>> +{
>> +	return sta && sta->sta.epp_peer && ieee80211_is_assoc_resp(fc);
>> +}
>> +
>> +static inline bool ieee80211_epp_assoc_req(__le16 fc, struct sta_info *sta)
>> +{
>> +	return sta && sta->sta.epp_peer && ieee80211_is_assoc_req(fc);
>> +}
>> +
>> +static inline bool ieee80211_epp_reassoc_resp(__le16 fc, struct sta_info *sta)
>> +{
>> +	return sta && sta->sta.epp_peer && ieee80211_is_reassoc_resp(fc);
>> +}
>> +
>> +static inline bool ieee80211_epp_reassoc_req(__le16 fc, struct sta_info *sta)
>> +{
>> +	return sta && sta->sta.epp_peer && ieee80211_is_reassoc_req(fc);
>> +}
> I think these names ought to be improved, from just the name I'd never
> guess that the implementation should be that.
>> +	if (!is_zero_ether_addr(sdata->vif.cfg.ap_addr)) {
> What? Is that checking something that's never the case (zero address),
> trying to handle some kind of re-assoc situation in a bad way, or
> something else that nobody will ever understand? :)


The address will never be zero. I added this check only as a safeguard,
but it doesn’t actually serve any purpose and I’ll remove it.

Instead, we can simply check for the presence of the PTK and the
sta.epp_peer flag. If both are set, we can allow the encryption of the
(Re)Assoc frame.


>
>> @@ -8965,6 +8977,10 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
>>   			goto out_err;
>>   		}
>>   
>> +		if (ifmgd->auth_data &&
>> +		    ifmgd->auth_data->algorithm == WLAN_AUTH_EPPKE)
>> +			new_sta->sta.epp_peer = true;
>
> And you _do_ even set this, so you don't need the whole patch 5 vs. 12
> difference?


Yes, since we already set sta.epp_peer here for client mode. We will 
keep a single sta.epp_peer
check for both client and AP mode for key installation in mac80211.


>
>> +	/*
>> +	 * Drop unprotected (Re)Association Response frame received from
>> +	 * an EPP Peer.
>> +	 */
>> +	if (!ieee80211_has_protected(fc) &&
>> +	    (ieee80211_epp_assoc_resp(fc, rx->sta) ||
>> +	     ieee80211_epp_reassoc_resp(fc, rx->sta)))
>> +		return RX_DROP_U_UNPROT_UCAST_MGMT;
> Even the use of them is rather non-obvious.
>
> I'm not convinced the individual ones add much at all really, might be
> better to just add a single ieee80211_require_encrypted_assoc() function
> that checks the station and all four frame types? Eventually you add all
> four here and in all other places anyway (patch 13.)


Agreed. A single helper function would be cleaner. Instead of having 
multiple individual
helpers, i can consolidate the logic into one function that checks the
station type and all four frame types. I will update this in the next 
version.


>
> johannes

