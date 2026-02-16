Return-Path: <linux-wireless+bounces-31891-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BigtH1BWk2m73gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31891-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 18:39:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AFD146C27
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 18:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 390BD3019F02
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4022C326C;
	Mon, 16 Feb 2026 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KlBz+HH9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ii3ZDAV4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA626FA5B
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771263565; cv=none; b=pfmHKtiAw/TjKHMu7wgyfiYwFdZneGsXYxwp1d38/cV92c0T4tL0/9BqsVUiEGG/IbIybdTFrbMMBfLmdEsos5clhVB3zmRDcYN1zhN+cZICcQT1ksKBcFNEMPMoWI/s18CnF25hOd+OlKLtd7WxPkQDGA9SdpGwUNzq8CLvDBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771263565; c=relaxed/simple;
	bh=dYy5+9APNTPAvh7iReA2dS73qehnMgH2kDKJRIBbejE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqEvAZxY7gQ4xZJlsfVLbiCmAMYyqR52HTs9wFpZoU1JBgI8bNFhHK7I73hfc1qr0Sz2tyfwlLCO9g3rhlfFLltoVll4Ep4c37piUx4qH5K2prCIwIZ3y75KxcA4KEb1DIPJcoKZUTodw003LlNW7CihgtzJ+W15kq7OYGOClQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KlBz+HH9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ii3ZDAV4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GBCMbj2522870
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 17:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l+kXw8zZVr94f7kLbxHGuxmssQSmZZ4vIEtDBBFxxzA=; b=KlBz+HH9eUgp/apu
	hloYt5fRwEFlwLpEXvEjSGIWW8S/NG/8peCKHSOlAPs+0vS4UuSmF0lfvoPzV16p
	QxSTxp5uCn3ovmoNLof/NZPxnx9utZek2m9V+L/Tl9BRdArCHm8GBU+ot4LVGekV
	a2kLWzzRNSZ0ER/M0X6D0hLnnuoIafZfR5y2oRQVDa0C9j0JhRxwvFG2kHqqzAmb
	evONlz45ET9Y7WPgPmf7Bs+1DLaVWld6vu0FEIX41YLUYtREtG3yRdXAb8AiXTrp
	qXuJk2GRAAfIMxR4p8oWK1gcJseeudf5EtgCiV/XHa+5huFkiz5+ukbvsirQL4F4
	Xuwv+g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cb6bukmch-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 17:39:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c65d08b623aso2812877a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 09:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771263563; x=1771868363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+kXw8zZVr94f7kLbxHGuxmssQSmZZ4vIEtDBBFxxzA=;
        b=Ii3ZDAV4n6LBKW+5B19eBLDrFCD5u3JAK2ed+AkYU1NSKYzypT5hojT0ka1o4TMUHy
         KUj39cTVy8cK+oxntvlHYFIA9wSomUJBR79eEJYraQr8E0dxGoepC9idX0jVPw78/Gbf
         8/jp5TPDiJHtXmNbWZlyWTkWBXqRu52xctv+J1n9bfZ/rM7vvBnFM3PGGFxSvSqWfiFw
         AkGyl2ZhSc6n7nN1qKuC9k3khJlRukh+diPXEDYZG1mI/L3Cy68tvQLEkFZ/in3R57v4
         fy+7oWYXZTJDMzc2hGP1PyzBPa9j9tGQFkCtFwvLY1yXIoX3uZHa8pM6EDlzpNhAPbko
         GDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771263563; x=1771868363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+kXw8zZVr94f7kLbxHGuxmssQSmZZ4vIEtDBBFxxzA=;
        b=CDNYXdFND6AzjyTyD/HdHNCykhD/YAbEq8PVpZpznxaJ++Bcjetl0t32J3FrKWBtNY
         GTDmUJP+JHfv1mrVLHrP2KP/sHbE8Shrk0lLjIpPWhRV55kJp3lVJdXTEDhJQoMUhyaR
         D2guPvxSmnMFnpIrx8tZpymHk7hbxshCo2DfzbKAYLpnXOJzvUkNsE38U7iDHvo7qQl/
         o90P64yazqBBsO7cAaTX0B1/iWto6SCHZ9/HV5Msh5Kwg6+w5LDrUR2UQ+R6KY0bwEia
         lFvITz7eKQZjtVpkIaTQx70bEweLvb25AQMY0Tjf6pA50bL3SIrHC6XkoZ6wogKX2GJV
         kAaA==
X-Forwarded-Encrypted: i=1; AJvYcCUu7m751opEVU81ML1FuKGjLHmW9cN0KgMCn0fNmVI+5LmVCZFmcQ996bkhffOCoFknSA+9n/yLdNnZs3GWlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGAqEzQ2Nrv/NT8L0DKda8zduSTjVMgtOwVuFxHiV73iTLcN/
	j+LqbMdkVA8MRvFHhzBBGNFXAauVdAauYV8KVYEBCDYkB/8VcWhdANE9suuuhslXbA0eZMjrLPr
	OFQzc40BVatnQ/dD3S/g25XJheljqA/p6P4QYkDT07wwPC3nHJsrEhAPHTw5EFycp13ku3qnS+g
	rCnA==
X-Gm-Gg: AZuq6aKKSNk9ZLD2DWa/VY8/TAILUGanAoH0QrtY96QQFGwAvjS7K1ZsmUC2snEBsvJ
	Nc64OspzJsBJorKjmNt4ycECZk4PvHefIKBAviC0MdkASSXuyLritXrthIkYGbAHOFeSuPL/YY2
	wK7YNscGr8DN5QYwLhZJTiAwqwYRPbYFjMI+Kj+40WWuThiqx5FBDn1bvcj87QWnDM8oliGmlkq
	31bKvoOVDnSvV/cOxX5JzZGjkYOB2iXgphPDIEh60PE1Es01WG77KcCY9GT4GdJqOBp82ZYBse0
	PLXghbd5XngxprYBzSd4anCQZ/bBQXnG3pfwD7GUtTXfRksHRqc38JFS5FTK6b0tYr5La8+cCj8
	GwA4QXOrZNrW+6avRR6jeSL7XehfI51Wd5hBX1FB7uhyKIcOLdPkD
X-Received: by 2002:a05:6a00:bd92:b0:81f:3a05:8a84 with SMTP id d2e1a72fcca58-824d5ce9beemr6820970b3a.11.1771263562619;
        Mon, 16 Feb 2026 09:39:22 -0800 (PST)
X-Received: by 2002:a05:6a00:bd92:b0:81f:3a05:8a84 with SMTP id d2e1a72fcca58-824d5ce9beemr6820953b3a.11.1771263562116;
        Mon, 16 Feb 2026 09:39:22 -0800 (PST)
Received: from [192.168.1.2] ([115.97.96.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb5596sm10757838b3a.58.2026.02.16.09.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 09:39:21 -0800 (PST)
Message-ID: <4efd11af-dea1-49a6-9df0-1c7fd84f6c82@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 23:09:17 +0530
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
        Ping-Ke Shih <pkshih@realtek.com>
References: <20260130154259.265130-5-johannes@sipsolutions.net>
 <20260130164259.54cc12fbb307.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
 <f96125eeda23451c19067359eb9d10b4047bcdd3.camel@sipsolutions.net>
 <5d54feea-d0cd-4bd7-b0d2-02e42f0fe5e1@oss.qualcomm.com>
 <be9ab3c7f05b0f56f19aee0ffc7c2f96138b9a05.camel@sipsolutions.net>
 <9576fdbc0b9b62caba88e05716d7c7028512130d.camel@sipsolutions.net>
Content-Language: en-US
From: Harshitha Prem <harshitha.prem@oss.qualcomm.com>
In-Reply-To: <9576fdbc0b9b62caba88e05716d7c7028512130d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ASCfjNuaRIofpysLmX91wAJRpJboEbK5
X-Proofpoint-ORIG-GUID: ASCfjNuaRIofpysLmX91wAJRpJboEbK5
X-Authority-Analysis: v=2.4 cv=M8dA6iws c=1 sm=1 tr=0 ts=6993564b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=6sPDMptOXngzVA0SphYZxQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=UQeIIjOO5qqIzHpyNngA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE1MSBTYWx0ZWRfXw4SH4deXPvf0
 aC6LA+sSOEVkDZ3K6Eycx6EvGYRaYFvaUs6bisPAJRdd1+BOyYf7FRiJzw0IgB2AacGweYh8GNy
 s929p8wyxjNozVw4AHOZv+H7meV7ybq8RNu/1SdrsDf+dhvAbTyUAXfluDj+e0dWJB/72iJP7/j
 dLAYyVoybB2D5lAj7NounBbeL/4Jjye9kTHkZZjVIyAwiqU+nFq3A99/DZCIAN7E5CQnIDLMVF9
 vlAwVwKv9rM9KTOz70wI53ciWTpPFmEowgbTdV8bgyF1mgZnsqQK8wj4VMNT/cTvWFtKjdSgpg/
 tzMnPPPy1IIZcS1Z0+fKInH58n61mNKMgNLbmzlV/3ekLBjahIcOIalQ302lVXF+SiDjUKP8rRE
 bG7Xe1FIln8HSpTk+AVJElggL/jinVFcUri9MQ+Hrv962lLx5QMs8Wn0F8f7S0zX3zGK4GwdaRv
 1WIonDNE7qYF/PjCn4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_05,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160151
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31891-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshitha.prem@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C3AFD146C27
X-Rspamd-Action: no action



On 2/13/2026 3:56 PM, Johannes Berg wrote:
> On Fri, 2026-02-13 at 11:11 +0100, Johannes Berg wrote:
>> Hi Harshita,
>>
>>>> Should we add a separate netlink attribute for the UHR operation, which
>>>> hostapd would fill with the _full_ data like it appears in association
>>>> response etc.?
>>>>
>>>> That way, hostapd doesn't need to build a separate data/attribute
>>>> structure but can just use hostapd_eid_uhr_operation(..., false) for it.
>>>>
>>>> An alternative would be to add more attributes for everything, but it's
>>>> probably more complicated on both sides?
>>
>>> Thank you for the suggestions.
>>>
>>> We feel that using separate nested attributes for each feature is the better approach, as this allows us to reuse the attributes for the Enhanced BSS Parameter Critical Update procedure, where similar information is carried in the UHR parameters update element.
>>
>> Heh, I'll admit I'm surprised - I'm usually the one advocating for
>> finer-grained attributes, and here I didn't ;-)
> 
> Wait, so I wrote a lot and forgot to circle back to this question ...
> 
> Basically I think that it's not going to be useful to split it up. I
> have no objections to it, but it complicates the code (especially in
> hostapd) quite a bit, because it's going to be either
> 
>  1) include each thing (NPCA, DBE, ...) in its own attribute, so that
>     e.g. NPCA would be 4 or 6 bytes per spec format, but then we need
>     separate validation for each in nl80211
> 
>  2) we really break it all down to each individual value, so e.g. NPCA
>     would have separate attributes for minimum duration threshold,
>     switch and switch back delay, initial QSRC and a MOPLEN flag; this
>     is a bit easier to capture in a policy, but a LOT of parameters
>     overall.
> 
> The thing - and why I wrote so much - is that we basically only need a
> single current, and in the case of updates additionally a single post-
> update, UHR operation.
> 
> So unless we're going to completely design away from beacon templates
> and create an API where including the UHR Parameters Update element is
> fully the firmware's (or driver's) responsibility across all the
> different frame types, then the split isn't really needed. And even if
> we _do_ design it completely that way, giving the post-update UHR
> operation and comparing to the pre-update one isn't a huge stretch for a
> design that just required fully rebuilding all the frames (parsing all
> the way into fragmented elements and putting them back together in a
> completely new way, including re-fragmenting elements and subelements
> etc. which all sounds very messy to me.)
> 

For beacon‑offloaded drivers, we initially thought a separate NL command
for the UHR critical update, with dedicated nested attributes, would
make it easier to trigger the firmware/driver. At the same time, we’ve
been having ongoing discussions around CSA and the UHR critical update,
especially around the overlap with post‑beacon template handling in CSA.

Thank you. The proposal to introduce CMD_START_MLD_BSS_UPDATE gave us a
different perspective and helped us rethink how best to handle this.


> johannes


