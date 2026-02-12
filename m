Return-Path: <linux-wireless+bounces-31764-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE/bFJ+0jWl96AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31764-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 12:08:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996C712CDCE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 12:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5553F30715FC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532712DC35A;
	Thu, 12 Feb 2026 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kcxJ6j1/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GFe50kN4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13289EEAB
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894492; cv=none; b=inw0fmNUvOUrl95q4+dFNH9vw9DqJHFE2gzwxRbljgzcb8qdjTh+SLEUw4m7VnhPZNHhGnKfuUeEI6dy331pmuKqmaruqgsKSB5s55ecOCh2mzTXbZzfikiuN1/m071AZnCtLONwm8MLkJSsY7hRZLfoiMzcCpnC3I0w782Bp3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894492; c=relaxed/simple;
	bh=y5ibW+TsMEb3cw1/JjlKLYr0+9kIJ0FxegKAmkhqcHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIPjsEGh4RLXm7Qbf5N2KEcQunen3whuI4s9GPEVcBS83dYB3LC5IVF7C/tF8LqrtV2x9vGqplaB0Y/NNeUyGT0ruujNwCvQkXofV8eX9/AdI8q76tyJGtYOPhjoVX2m4JmhhkQ8y7nhuDyGCgjVv4G5BeYAljxceQedaWkcr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kcxJ6j1/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GFe50kN4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CAOq413963707
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 11:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LwHltLk/PFgGRqKg/ugdj04yLSlwxL5ZFoo/7aVFXWw=; b=kcxJ6j1/xwWlLHZg
	d6sPkROHTTe0SeZFM+N/d27iFW3nZDkbEJXO5Ybe803xqXhtqZ0VZ+ooTqgGmHzm
	mwrhoLyqyeskCQlLf9E53uTZ+1tXLteYzfHSb7M8Oxtdys9/Isk5Exe9bELXyzxI
	p109or/XcZtrOeZM9eCfAYAZMVhSSmSZvOfK4l2GHy8bKore5AX33hx3oUvVaGu5
	RKLXPs1OneZiJDJ//tV0EixGpXzTcxSgedF8qI7MNBJ+muemD+TJjISAEZxOKnSn
	eub9mB3nAY5Zo9H2ThFr7d3dEK1YBMhtNuNr7kE1b+cO68MIYkXtnVOMWevmCQej
	Qj3A/Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8y8ntqv4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 11:08:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aae0d40a47so156725965ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 03:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770894489; x=1771499289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LwHltLk/PFgGRqKg/ugdj04yLSlwxL5ZFoo/7aVFXWw=;
        b=GFe50kN4fCzU4LkN+CzvXmFgw8NttDTssDjAdm2Jx67JZOdGn901R3ABW+3hzH9SgD
         is4NVH7ZeHOcZ9PP26AZFxRN4+uPi6xWDhD+X85yxcsmvG98PDdvbz56bcRrLRG9elcg
         Yv9/pflItadA8jtmQjhbrQZcS4ajIMfiTMqnmbVtlDTv6i3Z1PcrURfl3n3+GaFFjMRi
         e3tUZ7Meg6ewBPsqmNTvJGkB80PzpwSWPg9/OKaaocf7m+rLQUsc9x9bk4izjcw+S6EJ
         nileqdFxc/8K1Kt74ladjpdIJjzkHepx01jXlbixllCCRbgHNoVdP1tcTrVcL3zQE4am
         GKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770894489; x=1771499289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwHltLk/PFgGRqKg/ugdj04yLSlwxL5ZFoo/7aVFXWw=;
        b=fUl2GkU2JMHaMTYwmb9LBvcuJmraQFhBs04jQwvZ8AjW5cL+GeO8HKo2jBXlkuoSRT
         ae2iPR1j9Svk8umhXHht1/htWjDbJXLsWc79I1P1eudNhH2jxYekdb4kR4hvG0DoZVTK
         Drnt40hPYnY1MyV8mNdTFrRdgkA0aWbNSOtzrPv4UcBvbbNz/XpyHZ7k59tH+AtVGNVL
         GmLn0Uugvu8WpfDeQ8WO1MSJxqqEubGpGE0HbRd1fbC7cTYfjDZOkM90WCh84VoO+yYa
         Q1JECbnJ64eTGEJGQuczgkQsviBwkW/oqeUQXNpuS1v7W26lor3TRARsjcT9VszXExrI
         aG5A==
X-Forwarded-Encrypted: i=1; AJvYcCWKGQxMYmCdIh8lSLlmeD9ptANw+DX838KXI+JlVeAByjhy9mG6qnBL0oh5NTJsKzoIhKz1mkPhSwsDaQybzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/j4k5L56wX4qvyRTcEuWYvJRors9ep1QOBPg4cg+ZK6c4LET
	JjiltmDx1SrICu0dMCkudW1487v+uXS582PiPxEJYnghWOicTXJyQlVE4VrJ3dlyWUIlTifYXl0
	d953G+91ucTU8w3Lvb02GnXVODrmpx0cExMQHClYozlChjgzO7j0R7VDrM3T2H/ve4yNsLg==
X-Gm-Gg: AZuq6aIYc9WmQOcmPjGIVsDZEsjtHobogJvY1tM/MjebwLiyIMc/3rMLe4qBdDtDxRW
	ha9NJ2qRzTF4lE4ehlHzb7hnRrXyM8QLEHvfufSVrW9H7iKjWHMGTpcEUnuopqeFFVyZjoY3t3g
	i5BoGWKBbNyAl241QGuCiFDPA7WchJBeqfewEVYuiTT4RsKrHvm+3uW9gyQrKtEvGuzfSVoCPRC
	O53H2w3qsgg5+OPUUBTsyZm2odG1vrR1e9BjH8fikg9nA+eN7az7z54PRWjDf/vgeP3kF/MCeVv
	3jFWRAm6IBKMcr1Es30vL+6v/p7cuOCyP9A3KoCWecvWBQdMD1tMcnHZDEHTGWMNGR5GnUHn7Rl
	jVRIBlOnJkWsNawhdm9Jg7GnDsfoBVPh8RTpSzLaKLgJxj5Bpug8a4Q==
X-Received: by 2002:a17:903:360c:b0:2a0:acf6:3de9 with SMTP id d9443c01a7336-2ab39c89290mr26025475ad.58.1770894488718;
        Thu, 12 Feb 2026 03:08:08 -0800 (PST)
X-Received: by 2002:a17:903:360c:b0:2a0:acf6:3de9 with SMTP id d9443c01a7336-2ab39c89290mr26025195ad.58.1770894488169;
        Thu, 12 Feb 2026 03:08:08 -0800 (PST)
Received: from [10.152.201.41] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2986f0adsm47097975ad.26.2026.02.12.03.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 03:08:07 -0800 (PST)
Message-ID: <5d54feea-d0cd-4bd7-b0d2-02e42f0fe5e1@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 16:38:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 2/3] wifi: cfg80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>,
        vasanthakumar.thiagarajan@oss.qualcomm.com
References: <20260130154259.265130-5-johannes@sipsolutions.net>
 <20260130164259.54cc12fbb307.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
 <f96125eeda23451c19067359eb9d10b4047bcdd3.camel@sipsolutions.net>
Content-Language: en-US
From: Harshitha Prem <harshitha.prem@oss.qualcomm.com>
In-Reply-To: <f96125eeda23451c19067359eb9d10b4047bcdd3.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA4MyBTYWx0ZWRfX8SFO09nMowxv
 6SfzXih9S9HIOX7S+tDqKVCYdjFD1+EXSCsgZdFXNMFXLH42poNC9dFtqtE4V6ki/q51eGesKV/
 pi/dEb+xjTcljaLDatDnmsWiB4ROzJ6PaDM6Mtz0XbVD7QY4+YSUKaJiqp/9z27ofEdl1yGZF5m
 VG9v2/Du4tcEwZLx3HGiGLsY7ZHCfKPwO0ZKeygUDcjbY67uZFpmRJF7Tc1S7gCn+QiyUZacXeg
 wRkeSC7oUHL+r3VUrV+6szxk7l0JZ89SiCVl51XpSJPL8lmN5UCQIserCUp7HoxJND+rd7vTK+G
 6ZqKjImhKVqrxEV8ISuSVa/0AczhZlfh8dFPKgoR32b7Rry+yBoVzxPYAwWkC5VNDwIewUE60o4
 DUf+v1Y7G0qcu90dPDbhndqHSAF4DEjndrFud+qxgwILGxHpOjvLi0CqNTTlet9aSqN3ULoOkAy
 wFG4A/gPWbt/uqpXOlQ==
X-Authority-Analysis: v=2.4 cv=VNvQXtPX c=1 sm=1 tr=0 ts=698db499 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=7SQOmsPpbJYTtyHMIOIA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: gPJpPBnN6IdQanlS1yABAyNPlm4zIiBs
X-Proofpoint-ORIG-GUID: gPJpPBnN6IdQanlS1yABAyNPlm4zIiBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120083
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshitha.prem@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31764-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Queue-Id: 996C712CDCE
X-Rspamd-Action: no action



On 2/11/2026 7:49 PM, Johannes Berg wrote:
> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> 
> On Fri, 2026-01-30 at 16:21 +0100, Johannes Berg wrote:
>>
>> @@ -6462,6 +6486,17 @@ static int nl80211_calculate_ap_params(struct cfg80211_ap_settings *params)
>>                                               cap->datalen - 1))
>>                       return -EINVAL;
>>       }
>> +
>> +     cap = cfg80211_find_ext_elem(WLAN_EID_EXT_UHR_OPER, ies, ies_len);
>> +     if (cap) {
>> +             if (!cap->datalen)
>> +                     return -EINVAL;
>> +             params->uhr_oper = (void *)(cap->data + 1);
>> +             if (!ieee80211_uhr_oper_size_ok((const u8 *)params->uhr_oper,
>> +                                             cap->datalen - 1, true))
>> +                     return -EINVAL;
>> +     }
>> +
> 
> OK, I just basically copied this from EHT, but it's useless. Due to the
> reduced information in the beacon, we don't really have anything here
> (such as NPCA timings.)
> 
> Should we add a separate netlink attribute for the UHR operation, which
> hostapd would fill with the _full_ data like it appears in association
> response etc.?
> 
> That way, hostapd doesn't need to build a separate data/attribute
> structure but can just use hostapd_eid_uhr_operation(..., false) for it.
> 
> An alternative would be to add more attributes for everything, but it's
> probably more complicated on both sides?
> 
> johannes
> 


Hi Johannes,

Thank you for the suggestions.

We feel that using separate nested attributes for each feature is the better approach, as this allows us to reuse the attributes for the Enhanced BSS Parameter Critical Update procedure, where similar information is carried in the UHR parameters update element.

While this approach is slightly more verbose, we believe it offers better extensibility for the future.

Please let us know your thoughts.

Regards,
Harshitha

