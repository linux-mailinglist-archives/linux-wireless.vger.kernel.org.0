Return-Path: <linux-wireless+bounces-32141-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKyHJ3GGnWnBQQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32141-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 12:07:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B83185E2D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 12:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E12EE31A3E90
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699D736EAA0;
	Tue, 24 Feb 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RCAvJv6v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U5WQ7Xaf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB577F39
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930916; cv=none; b=YKLpN/bfcgPEA5Ia8/g99gYJLTBM3BTv/vBEXLH00AJiZ/QiY3Xngbay8nTCI9EOrEJwhyHWJDAmGEav2/Npv2ejiwEsFLMlQ1JZN7I6XqEiKPBHnHitwfwaXaBT3VGzFSOGj26J6TGwVGA1Ab5aRer57oY5RGfCPNk1jBGqtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930916; c=relaxed/simple;
	bh=mrRulaa/l4g7zZBwF/jqYg0CFQ92MLTTF1bJn7avP4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4qmZ3tZ2OcFlYtJ9GC29n8WaRU0lQWg70f+5V+DxqsNdOi6FL86Uh6Es8YiJV4AEGV2GfmDEgQCkB3nGrUvLnHCPfFCC8tUU5EHKW7G2x/XhVh+KhgdmPJxmJTw38pOf5euTy/8J7JUqsqK1yU5qYBTVLJe6/egGGCVHYE3mqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RCAvJv6v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U5WQ7Xaf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFZHE2774702
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 11:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RnUsHJSbAP+pZjOOAhK5dDeUbFNSuWJ7PmHwsoLuiNA=; b=RCAvJv6v4DoJuz8q
	2hz72yD/C+au1ZX+miO9PcYu6xDsG+Iqnrn7fFX0W+G8e5Seyg5QDqHJmxdfAr+r
	zHeepf0K6MUxKUZpVGFcvnbJqIoYfpyi6XEi04EI5CIwzLBSXoQ9N+AVJB8FACxu
	B+9YuQ3AazKcoY+Mn8gBvfW9sPlNXJB5avOqnjTK+52p6VHm33cchIzb8YnR6pdQ
	H6NFxZprNaYx22mbH9arIgSO2etpULSPLZmOMd0Npp9aGBJvtVPuijQbeX7iI7Kw
	ntyskiKY60kz8dU6K2HyRNKarQ2cSA2yF8h/uiXT5c7xE0c2Rx7TdC4iLgP7aBkp
	nUrW+g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgr69ke2j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 11:01:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35464d7c539so5260854a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 03:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771930913; x=1772535713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RnUsHJSbAP+pZjOOAhK5dDeUbFNSuWJ7PmHwsoLuiNA=;
        b=U5WQ7XafRn+BKy0Cco86E1fo/G8LjPM5b+z5j0LogVRJJd1L4rwRfHi5uUvw7H98ki
         N/KRtbMRee+e8Jwo5iiwVP1t3t3uPUt84o54r4bvlPMUeqGo+Zw4ZnsbPrbMcArUsgNP
         RBDHV7wgbF217YfILHwa2h96INsO2HEzA/ohdQDjNgGdlYQ+e7HII1ZwElfsvenzqc+6
         cOYbc34RdVTq/GSwgN1Oh0nZgCwJKGcMQUDsRiO+b7iH+gIRPY6ijYjmHCDpBnlRerDN
         RQwrN/9GGSIHXmZFYOwnp6TBi0lckWqdtlrXI1YLXZutvJCfyaZou0NEdbaoS4pxgYvB
         uB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771930913; x=1772535713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnUsHJSbAP+pZjOOAhK5dDeUbFNSuWJ7PmHwsoLuiNA=;
        b=ih9HgkKMiUjZ3e0FHeDG6VJk6VZSVsRWMRYAji6orWuKkoAf2oglp8FT2UB56pt5iU
         uLKgTwgXxm2XOvBjqd3SjY2995jyWc4ffZ3YklyKFBXMRxtKkKqmF+I76TZwsprB9rpW
         Cva2uPBnFrcvtqCaPOIs6DSFhz7VY4xjNaRDl80U8e1Qzv0zHkqbpQJLzpOjbsYpuUXz
         PVsGZRS9o/tjePIVmAYQrw50fiWhN9dwjQWb1OjbK3XwjT/CACk/AA025h96VUoBI920
         er+qfBUXmgeJWQn43xmf06xiYGX3ZsRly4Hx4A2G3KB+UK5zY4Xi//2DwdnrxfPgvI3D
         F8tg==
X-Forwarded-Encrypted: i=1; AJvYcCXiURU50FgtTb0dSjko0eZH0p0vDhWWSjs3FhDzQENR6yyplMtgVQiIIXkwg2uqZZWfuJU9f62KwQ8EXiZRvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoEQkKFQY9tWSlKGt3oDFgT5ZWWuNe/a1i+RVcw3+QC5PEtEt
	TSKjAwATBvCWq1H0WHQtwxLr4SKBewIOQ2Oay889S+Tuuti9tlGclpCnqvUFQ50nV1/+9Um3bVF
	2lk6elzOCTZfHS3y3vtPFXXaWAjKI6zd5TyEXP54Q+YXSaTE5FNbBLTsOyzQzAfp55Wolhw==
X-Gm-Gg: ATEYQzxSDjeaCHny3n2oeYAB2O1XyDXuTFJtOMyX2UC1v797KjO+qvwBqZAMv2WEsFc
	vjVSf5YO0ladgfEmBA6AC2mpAVZLu8l/qS+DaNY7VXHT3NDKIv20yAEKwG8hZfmJym6LyHJpcuU
	qO1xD3BDkDVvB3tfq48g5cXrzmX99xpAJ9vR/ih9S552LfFRVyB4k6z9hWMOkf38ufxeMfgsPPc
	RcgCo1+znBUFGCVgglQljtA3+wvGhnTnl4M36SEgBBrG4mc0u2S27cVVJbZruSagV6ogXsjVJPI
	cSIqbuZLNt2aZJtpdZlAfBhDi9PQ9ZdDMz2rJxU9snbsc5QhykuBhnA6Z7nOeEzLMTPVQTZ2Opg
	0X1S+7FgijOn/oO+C69Oc2httws2tXty/Baul1ON0LkC8hYUydvojLA==
X-Received: by 2002:a17:90b:2b8c:b0:356:2c7b:c010 with SMTP id 98e67ed59e1d1-358ae812409mr12203015a91.11.1771930913169;
        Tue, 24 Feb 2026 03:01:53 -0800 (PST)
X-Received: by 2002:a17:90b:2b8c:b0:356:2c7b:c010 with SMTP id 98e67ed59e1d1-358ae812409mr12202967a91.11.1771930912509;
        Tue, 24 Feb 2026 03:01:52 -0800 (PST)
Received: from [10.152.201.41] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358d79e47d9sm906963a91.3.2026.02.24.03.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 03:01:52 -0800 (PST)
Message-ID: <f3282007-a11a-4f68-86d8-0945e4979d65@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 16:31:47 +0530
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
        vasanthakumar.thiagarajan@oss.qualcomm.com,
        Lorenzo Bianconi <lorenzo@kernel.org>, ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
References: <20260130154259.265130-5-johannes@sipsolutions.net>
 <20260130164259.54cc12fbb307.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
 <f96125eeda23451c19067359eb9d10b4047bcdd3.camel@sipsolutions.net>
 <5d54feea-d0cd-4bd7-b0d2-02e42f0fe5e1@oss.qualcomm.com>
 <be9ab3c7f05b0f56f19aee0ffc7c2f96138b9a05.camel@sipsolutions.net>
 <156d6d48-d135-4acf-a5d7-c9ae80523864@oss.qualcomm.com>
 <0f4b34f0b529fd93fc608d8bbac0e98516b7a3d2.camel@sipsolutions.net>
Content-Language: en-US
From: Harshitha Prem <harshitha.prem@oss.qualcomm.com>
In-Reply-To: <0f4b34f0b529fd93fc608d8bbac0e98516b7a3d2.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O6A0fR9W c=1 sm=1 tr=0 ts=699d8521 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=yvEocR2s0TKtyDQkXLUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: DVLFrkGWGc8DiXZUGSHdcct61-OfjZrS
X-Proofpoint-GUID: DVLFrkGWGc8DiXZUGSHdcct61-OfjZrS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4OSBTYWx0ZWRfXw5P5IIr2hlrS
 T9jVcxdRucGmbSClT+fZQIgHRS4IK4b6Tv7FheGgX8crL79kITTJKT7fniE2C3t3jRHz20oT6sO
 z8bSnz5rWc66btasSfWkgEekwehyNCRYZ858m9TAl5KZbfZUmb6C7KoQkDKzxhFdVd+UdAKYC6j
 xt7nQ8F1r2qXCOwkISV2jvtpiLAbXDvRHFkuxvGuZ7j8YjiYB1F5P2WNWkcYsefDY5xoKh+jt2b
 tlHMpAj3Z+r97ozn6DC37hy3Zk0plCIAGnbjhxn+TJ5bfFQ+1p+gpUkcqkhE26m8+D1ntknFEU1
 Z2FgsIoxEtQzCDGX/EWmO8dxC0CKHAqgNH4ZrsqK3GFS5Hrvf29M8l6eYzEOs4TXhS8xtEj+PWA
 sFiRjgKDL2DVLWDPNm6gHRB36mfyQBPvV3BaPrE6LTxU9/CTWfPdonZtkzehK5EsVzIGyeyTHjg
 xNxGjH6M3Owjp0boE3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32141-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[harshitha.prem@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 01B83185E2D
X-Rspamd-Action: no action



On 2/17/2026 3:35 PM, Johannes Berg wrote:

Hi Johannes,

Thank you very much for your patience, and apologies for the delayed
response. We spent some time discussing this internally and wanted to
follow up thoughtfully.

> Hi,
> 
>> This approach looks well suited to handling overlapping update scenarios.
>>
>> To make sure I understand it correctly, I’d like to walk through a
>> concise example where a UHR critical update and a CSA overlap on link 0
>> of a 3‑link AP MLD.
> 
> Well, so honestly, you should probably treat what I write as equivalent
> to a paper napkin sketch during a night of drinking ;-)
> 
> I surely didn't think it totally through. I was just trying to
> illustrate that I feel like we need to have some kind of new design for
> all these overlapping updates (CSA, BSS color change, EHT and UHR
> critical updates?) than the piecemeal design we have now.
> 
> And, importantly, that perhaps I think that this means we need to have
> "post-update UHR operation" more than the individual UHR operation
> updates broken out - which after all is where we started from.
> 
> 
>> t1: A UHR critical update is triggered. hostapd sends
>> NL80211_CMD_START_MLD_BSS_UPDATE with an advanced notification (5
>> TBTTs), post‑interval (5 TBTTs), and the beacon template with UHR
>> parameters update element for link 0. Timers start in mac80211, and
>> hostapd receives cookie X.
> 
> Don't know if timers would be really in mac80211 - I guess if the driver
> pulls each individual beacon then mac80211 could handle the countdown,
> but otherwise this might just be given to firmware.

Yes, agreed.

> 
> Also I guess the counter would have offset(s) from the start, i.e. the
> beacon template would be in this operation already. Or maybe even beacon
> updates for multiple links? Don't know if that really matters much
> either way.
> 
>> t2: hostapd sends NL80211_CMD_UPDATE_AP with cookie X and offset where
>> the counter is updated for link 1 (and then link 2).
>>
>> the countdown values would be handled in mac80211 with the offset
>> mentioned similar to ieee80211_set_beacon_cntdwn().
> 
> Sort of, yeah. I imagined that the CMD_UPDATE_AP would come with a list
> of "cookie X: { offset X_1, offset X_2 }, cookie Y: { offset Y_1 }" or
> something like that.
> 
>> t3: Before the UHR advanced interval completes, a CSA is triggered (due
>> to radar or user‑initiated). Another NL80211_CMD_START_MLD_BSS_UPDATE is
>> issued with CSA countdown 5, including CSA and after beacon templates.
>> The after template carries cookie X and the offset. Since UHR CU is
>> already in progress, hostapd could also include an updated parameters
>> update element. 
> 
> Would have to, I think? I think in your example it's unlikely the _after
> CSA_ template still has cookie X / offset(s) X_n, since you only had 10
> beacon intervals overall for the UHR critical update and CSA might be
> longer, but we could also imagine the UHR critical update was advertised
> for a longer time.
> 
>> Also, an updated UHR operation element which can be
>> modified in after beacon template if CSA finishes after the UHR CU
>> advance interval. (why to provide the UHR operation element separately
>> is because the advance notification can be before or after the CSA
>> finalize).
>> hostapd then receives cookie Y for the CSA.
> 
> This could get trickier than I imagined - you now have three periods of
> time:
> 
>  - now
>  - after CSA but before UHR update
>  - after UHR update
> 
> and actually all three might need different UHR operation, since the CSA
> can change the bandwidth and therefore e.g. DBE/NPCA. The intermediate
> period ("after CSA but before UHR update") can be captured by the CSA
> operation (given a template/UHR operation for after) easily.
> 
> But I was imagining we capture all this in the operations already, so I
> guess to do that we would need a "NL80211_CMD_MODIFY_MLD_BSS_UPDATE"
> command that takes the cookie and updates the post-operation values, so
> that the changes due to the CSA could be taken into account in the
> previously started UHR update.

The idea of introducing an NL80211_CMD_MODIFY_MLD_BSS_UPDATE command
makes a lot of sense to us. In cases where
NL80211_CMD_START_MLD_BSS_UPDATE is already in progress, having a modify
path to update the current beacon seems easier to reason about and
manage. From that perspective, a pairing such as
NL80211_CMD_START_MLD_BSS_UPDATE together with
NL80211_CMD_MODIFY_MLD_BSS_UPDATE feels quite natural.

> 
> FWIW, I was also kind of imagining that we'd design this combined update
> command in a way that it replaces the CSA and color change commands,
> handles the proposed link removal thing from Lorenzo, and then we don't
> need to handle overlapping operations of all kinds, just of this new
> kind that can do many different things. Not a huge difference though
> since CSA/CCA would map to a subset of the new "thing".
> 

[...]

Please find below the envisioned design flow for the UHR CU and CSA
intersection.

Hostapd (User)          mac80211 (Kernel)           Air / Station
   |                           |                           |
 1 | CMD_START_AP [Adv Notif,  |                           |
   |  Post Notif, Upd Int]     |                           |
   |-------------------------->|                           |
   |                           |                           |
 2 | CMD_START_MLD_BSS_UPDATE  |                           |
   | [Link:0, CurTmpl+Offset   |                           |
   |  (All), Timer, PostTmpl   |                           |
   |  (All), Type:UHR_CU,      |                           |
   |  Post UHR Op element]     |                           |
   |-------------------------->|                           |
   |                           |                           |
 3 |                           | [Set Tmpl, Timer: Adv=10, |
   |                           |  Post=10, TIM Update]     |
   |                           |                           |
 4 |         Cookie X          |                           |
   |<--------------------------|                           |
   |                           |                           |
 5 | EVENT_UHR_CU (CU_START)   |                           |
   |<--------------------------|                           |
   |                           |                           |
 6 |                           | Beacons: 10, 9, 8...      |
   |                           |-------------------------->|
   |                           |                           |
 7 | [CSA Triggered: Link0,    |                           |
   |  Count 10. Sees Cookie X] |                           |
   |                           |                           |
 8 | CMD_START_MLD_BSS_UPDATE  |                           |
   | [Type:CSA, Link:0, Tmpls, |                           |
   |  Cookie X + Offset,       |                           |
   |  Post Tmpl (No UHR ele)]  |                           |
   |-------------------------->|                           |
   |                           |                           |
 9 |         Cookie Y          |                           |
   |<--------------------------|                           |
   |                           |                           |
10 | CMD_CH_SWITCH_STARTED_    |                           |
   | NOTIFY                    |                           |
   |<--------------------------|                           |
   |                           |                           |
11 |                           | Beacons: X=7, Y=10        |
   |                           |-------------------------->|
   |                           |                           |
12 | CMD_MODIFY_MLD_BSS_UPDATE |                           |
   | (Cookie X Post Tmpl w/    |                           |
   |  Chan Info, 3 Links)      |                           |
   |-------------------------->|                           |
   |                           |                           |
13 |                           | Beacons: X=1, Y=4         |
   |                           |-------------------------->|
   |                           |                           |
14 |                           | [X=0: Modify Cur Tmpl     |
   |                           |  w/ Post UHR Op element]  |
   |                           |                           |
15 | EVENT_UHR_CU              |                           |
   | (CU_ADVANCE_COMPLETE)     |                           |
   |<--------------------------|                           |
   |                           |                           |
16 | CMD_MODIFY_MLD_BSS_UPDATE |                           |
   | (Cookie Y Post Tmpl w/    |                           |
   |  UHR Op + Param elements) |                           |
   |-------------------------->|                           |
   |                           |                           |
17 |                           | Beacons: X=127, Y=3       |
   |                           |-------------------------->|
   |                           |                           |
18 |                           | Beacons: X=128/129,       |
   |                           |          Y=2/1 (CSA done) |
   |                           |-------------------------->|
   |                           |                           |
19 |                           | [Y=0: Set Post Tmpl       |
   |                           |  cookie Y, UHR Param      |
   |                           |  Off, X=130]              |
   |                           |                           |
20 | CMD_CH_SWITCH_NOTIFY      |                           |
   |<--------------------------|                           |
   |                           |                           |
21 | CMD_MLD_BSS_UPDATE_NOTIFY |                           |
   | (Complete Cookie Y)       |                           |
   |<--------------------------|                           |
   |                           |                           |
22 | CMD_MODIFY_MLD_BSS_UPDATE |                           |
   | (Cookie X Post Tmpl w/    |                           |
   |  UpdatedChan Info)        |                           |
   |-------------------------->|                           |
   |                           |                           |
23 |                           | Beacons Continue...       |
   |                           |-------------------------->|
   |                           |                           |
24 |                           | Probe Request             |
   |                           |<--------------------------|
   |                           | [Fetch TBTT]              |
   |     send_mgmt (TBTT)      |                           |
   |<--------------------------|                           |
   |                           |                           |
25 | send_mgmt (Probe Resp     |                           |
   |  w/ TBTT in UHR Param)    |                           |
   |-------------------------->|                           |
   |                           |                           |
26 |                           | [Post Notif Complete:     |
   |                           |  Set Post Tmpl Cookie X]  |
   |                           |                           |
27 | EVENT_UHR_CU              |                           |
   | (CU_POST_NOTIF_COMPLETE)  |                           |
   |<--------------------------|                           |
   |                           |                           |
28 |                           | [Continue w/ Updated TIM] |
   |                           |                           |
29 | EVENT_UHR_CU              |                           |
   | (CU_SESSION_END)          |                           |
   |<--------------------------|                           |
   |                           |                           |


The diagram uses a number of abbreviations, so an explanation is
provided below for clarity.

Step 2 – NL80211_CMD_START_MLD_BSS_UPDATE
	This would include:
		1. The affected link ID
		2. Current beacon templates for all links, along with the offsets
where counters need to be updated.
		3. Post‑beacon templates for all links
		4. The post‑UHR operation element
		5. Countdown values
		6. Type: UHR CU


Step 8 – NL80211_CMD_START_MLD_BSS_UPDATE
	This would include:
		1. The affected link ID
		2. Current beacon templates for all links, along with
the offsets where counters need to be updated
		3. Cookie X – { offset_A }
		4. Post‑beacon templates for all links
		5. Countdown values
		6. Type: CSA


Step 14
	The driver/firmware can update the current beacon template with
the post‑UHR operation element. Until the advance notification interval
completes, the UHR operation element would not yet be updated.

Step 12 & Step 22
	These steps are somewhat duplicate, but keeping the latest modified
state once hostapd receives NL80211_CMD_MLD_BSS_UPDATE_NOTIFY_COMPLETE
seems reasonable.

Step 24
	Reporting the TBTT count back to hostapd for attribute types such as
UHR_CU, LINK_REMOVE, etc.

Cookies act as identifiers for both the post‑beacon template and the
associated countdown values.


A few potential concerns to consider:

1. Carrying both the current and post‑beacon templates for all
affiliated links of an MLD might make the NL message fairly large. we
are not sure how well that fits with existing practice, since multipart
handling seems to be used mostly for dump commands. As an alternate, can
we have multiple commands with message id and reassemble it?

2. There may be a small sequencing aspect worth thinking through. For
example, if a UHR_CU operation is close to completion and we are about
to apply its post‑beacon template, but before hostapd processes
EVENT_UHR_CU with CU_POST_NOTIF_COMPLETE it issues a
START_MLD_BSS_UPDATE for CSA, we could potentially end up using an
unexpected version of the current beacon template. This may already be
handled by the existing flow, but it seemed worth calling out for
completeness.


Thanks,
Harshitha

> 
> Thanks,
> johannes


