Return-Path: <linux-wireless+bounces-29813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 517B6CC429C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 17:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCB563064901
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 16:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DBA33D6EF;
	Tue, 16 Dec 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R2XmGRfb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CpjzJnNu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24833D6F5
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897800; cv=none; b=dk0NGCAuYnsSG2zSpdiLnjnnXRO5JGdR+MiqJ5zlyMlSXVSjnKnhN8njtlv3BqAOno1P+FxDgjPAFTmv9/v3G28TKDJ8VmBiSnXAS4flCGphcQJnORafJdp3HE90x6Dqz25nF0pUf4zX/lOvo6RaJL28/6vv60VxVdaJknXwZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897800; c=relaxed/simple;
	bh=kG0smSzdoD5dvYecUtCjN4p70aZZ/KKsmxF4nCy6eSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atRTXR6KW/XZR2NismwnwWbC6sXkXHur1ZDTaSXw4thfA9BsVxOLvJF31Nm2nfy1+ECBe9ntP3NI/QMfNhse/k1ksugz749n05yGStuH+lVFMfdMoZ7WNyvpm1ckz65b3XkdR9NKcbkS/mw7cY8fsUkpRGhBYTDt5tPs1esr5PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R2XmGRfb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CpjzJnNu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGAXkBZ3598772
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2cv3BOucNS6em4Fs8pLZaSpMlsGU8mbrmtdop+J5AY4=; b=R2XmGRfb/iz/ukMQ
	D2rmaim7oRnNsHWYtuXSjPDfnhY9KpzhIiLfyMRsJOxoekQUOkRo4c6/TrI9eL52
	YOhl/QgGRwb5K52c54coT4fgC64dWGg1J/tbdSHZ0m0v0wrYZH9rYFZGUjNuAsHR
	U/eg8OsyWWhgFa15gcBmjEmIqiPzS8WdcumVatx8qUlrH7m6aJfJ5gOUoQr8aq6M
	5yGEDIq8D71WMHv06h45aiJvg+u+fs6aCfGluRBGnen651Zull+ujFhB6ioCWnhS
	NfgM/WY3T9HmT2tyALTBxVAZ5hx1kCtcUS43Up4dnxhF0sk/8OX6siZSpmSkulhV
	uY3XUA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b35se0yf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:09:57 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7f89d880668so3854503b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 07:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765897796; x=1766502596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cv3BOucNS6em4Fs8pLZaSpMlsGU8mbrmtdop+J5AY4=;
        b=CpjzJnNux9skbxqLcbgEySW4rlB/k/dKATSEuw30JuI2g9jshaTXZVkjlj1GenZANe
         h24VbNwZXO4e0mnhjLr4w9sg3uxQoqsgFV5GyBIl8LSXmfVWca877H/NvOi3NqCA+JHH
         VPceKKLOAR1T0+v38/7IiaxEiuxsIuJ7T6cL8YZgbV0ql4o3C/MHa4VyRDLfBQ8i//GR
         ZnBymuAJlTBYsqeA/nWKvsjHVAPgAlQsq49rc7Tzm/sCV6FYacFKRmx4sqlDwCEQizHN
         FxoL6TWc3Pl0d9BFKuNhYdE83mqJAxkr+R6Y3TBLvZMraa+ABhu5IIu9Hp5M9fwduGaX
         coUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765897796; x=1766502596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cv3BOucNS6em4Fs8pLZaSpMlsGU8mbrmtdop+J5AY4=;
        b=bqj4BDo4jieBB1FC0uCuap1rj7Xs78MWCEsB7e06cR8yXv2m4VJOyO5TkZ9/KyJEQ/
         Kgs6sAzQcOSLa4p4HCmy9K32yXqsaOq2Ci3go4yt4/PtWUL0J8E6s0r+Qtfht5E7Ii+M
         SKqX9hb/F5iUEFtQ4AzTQrHY4tXfR6xgv3epkVAOyxDnPsG9NV+nBFbn/DUGFnc5NCPy
         9gKmb6am9I0iSS11p8rcC+9p4zqdh+0NgJgVKwLa2hg1DtDpnQ+I+ni52mYzjqe8Au5o
         j+sMwuofhFlgCUeeJ5AcsbpxFLfq/n1cecNe/mBfvqImMROT/7UHaKHm1pLu0Asg53oO
         5IDw==
X-Gm-Message-State: AOJu0YxJm7heTlIqvCQInmxo7v284xM6iMGfVjOoqtTBzbioHHsL/LA5
	uLosMhWq/fRFt/h8EOigBsbr0HluFBy+wQ5nod2fmm+FhdTfgbURlz97KXM7rssunPqYmphmhFp
	pzMf21+Mo/tNJpRRuWePSI3r5OeFJgCKjCsg77STvTQYvOtoyiIkcAszA0y0Q/iJmrr7cnw==
X-Gm-Gg: AY/fxX6Fu8utM/QQ4XjseXgxcz8ovwRzr+iwdXZUCNMrO86KcShWXmdJ2QPpasNUBiD
	NfdD5nI0GQqFtsYzgPpwYkYxESJCew48uOYqNkVyncKUAdRfI4XBh+IdvRvEI1yC67R+zU8QuiY
	EKoHT05CZLjZhJKpXKnV03NBn4jdrtLkhgAjkkQWkW6oApUMhiGKd3qvYr4IUf+1KPmTFh07q1G
	VurRbBq+/89NIjkejK9txTgI5q/4fljPqyOA3pzHIB/H41pywEeeZw7c/A32OgCcaS5lOX56mac
	u5qbCtYphk6MiOPErrHQFaUFfnwV6iGTHz3+IHe/8t7kk0dBnBEyZyMhRcSPoJmMvsJEhKe7ZFA
	f9EBb5sCJk2FMMTb84lMqOiBj8Yl1zxD8FsEa6HVx8C0=
X-Received: by 2002:a05:6a00:908e:b0:7ac:3529:afbb with SMTP id d2e1a72fcca58-7f66793002dmr13976531b3a.20.1765897796386;
        Tue, 16 Dec 2025 07:09:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVng3bCFK1y8azGchVWsNp6JiZlbOSxwjwOsFWmPwBK/gE/V16VJVY9Ow8UbEuADWznurfug==
X-Received: by 2002:a05:6a00:908e:b0:7ac:3529:afbb with SMTP id d2e1a72fcca58-7f66793002dmr13976481b3a.20.1765897795695;
        Tue, 16 Dec 2025 07:09:55 -0800 (PST)
Received: from [192.168.1.10] ([122.177.242.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c5093c4bsm15895417b3a.48.2025.12.16.07.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 07:09:55 -0800 (PST)
Message-ID: <ae3d6612-ab08-4b74-8e41-03e50178cf83@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 20:39:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_wireless-next_05/14=5D_wifi=3A_mac80211=3A?=
 =?UTF-8?Q?_allow_key_installation_before_association_in_non=E2=80=91AP_STA_?=
 =?UTF-8?Q?mode?=
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com,
        sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
 <20251211124051.3094878-6-kavita.kavita@oss.qualcomm.com>
 <1da46c84d32dfa1458dc3c60e18f16d3a6defaf7.camel@sipsolutions.net>
 <b6c7ce2d4fbe1b2c2db1dadcaf99b77a738d7944.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <b6c7ce2d4fbe1b2c2db1dadcaf99b77a738d7944.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Zihw-WikjzB_-Is7F9BjjAQxDfkLhBWz
X-Authority-Analysis: v=2.4 cv=ar2/yCZV c=1 sm=1 tr=0 ts=69417645 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=vaJ6/3d+63OnhzhRW74whA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=5KLPUuaC_9wA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=mOB96Zhyi-8_NA9pIgcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: Zihw-WikjzB_-Is7F9BjjAQxDfkLhBWz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEyOSBTYWx0ZWRfXyK0s9HMtXgT9
 3cTu8y5ImgqQLGxpYkjZ3ObZooUWPAvMx+9R/wgLkTZ2rcMvixdtiCecGFNLggLvl5/gaOBBpb+
 F9wJSkj786C63wV0qNQytoMVkbt2q7Ry/ZGBRtsTpLcE+6NeyYsLSv4b+AD+hI9/TrDYFGR8pIh
 +nViqZ51sMZtLX4DM9hzTLjCVhM/kSWQCrkc8xR7HtJxR+CyACEG1FhQWjaaMgNF8LAV3JG5JCp
 A3X//LTIp3em4vB9+Gq8DoY+g+oWz2YUQnPB9Vc9dxNTcObnRtT2FIBrOgLifzhX7i5AWsfaHft
 aoZuMwm9VfPKahwPUB/DbQ3eB1uDGdwdjXed5VrBwn1QWtzeBUxumcTa4uhHKHj8mavXeZwpfW5
 CFNbHIF8RuXiTigyOrjwxvotV1UQyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160129


On 12/12/2025 6:00 PM, Johannes Berg wrote:
> (Sorry, keyboard handling error with my hands ;))
>
> On Fri, 2025-12-12 at 13:29 +0100, Johannes Berg wrote:
>> On Thu, 2025-12-11 at 18:10 +0530, Kavita Kavita wrote:
>>> +++ b/net/mac80211/cfg.c
>>> @@ -680,12 +680,29 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
>>>   		 * association has completed, this rejects that attempt
>>>   		 * so it will set the key again after association.
>>>   		 *
>>> +		 * With (re)association frame encryption enabled, cfg80211
>>> +		 * may deliver keys to mac80211 before the station has
>>> +		 * associated. In that case, accept the key if the station
>>> +		 * is in Authenticated state in non‑AP STA mode.
>>> +		 * If (re)association frame encryption support is not present,
>>> +		 * cfg80211 will not allow key installation in non‑AP STA mode.
>>> +		 *
>>>   		 * TODO: accept the key if we have a station entry and
>>> -		 *       add it to the device after the station.
>>> +		 *	 add it to the device after the station associates.
>>>   		 */
>>> -		if (!sta || !test_sta_flag(sta, WLAN_STA_ASSOC)) {
>>> -			ieee80211_key_free_unused(key);
>>> -			return -ENOENT;
>>> +		if (!sta)
>>> +			goto fail;
>>> +
>>> +		switch (sdata->vif.type) {
>>> +		case NL80211_IFTYPE_STATION:
>>> +			if (!test_sta_flag(sta, WLAN_STA_AUTH) &&
>>> +			    !test_sta_flag(sta, WLAN_STA_ASSOC))
>>> +				goto fail;
>>> +			break;
>>> +		default:
>>> +			if (!test_sta_flag(sta, WLAN_STA_ASSOC))
>>> +				goto fail;
>>> +			break;
>> I don't understand why you (later) introduce this asymmetry between AP
>> and client modes? Couldn't mlme.c just set the (introduced later)
> ... sta.epp_peer flag, and then the code can - regardless of mode - just
> be whatever you add in patch 12 for AP only?


Agreed, the sta.epp_peer flag check works fine for both client and AP modes.
We can keep a single check for both instead of handling them 
differently. Thanks.


>
> johannes

