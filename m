Return-Path: <linux-wireless+bounces-31598-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGn3A7rOhGk45QMAu9opvQ
	(envelope-from <linux-wireless+bounces-31598-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 18:09:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5879CF5AD6
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 18:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3923D300D447
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD3B436361;
	Thu,  5 Feb 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NWTHpPkP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="csbZxvOL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6D6425CCD
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311080; cv=none; b=XWUQyPz1GddhY0H9fXJEpmvN8HY3kVPauCJPJSGB95zubfyAYTM7qI3IrGNYMcsmq1Gwxf8/otg3tItpTmuvv7CIjlhBcitxTQy7KMe3I1o5zOdaYONy9SRpM3cnXztI8Tdyce1qw9VMtqUSO3+5PFrOR7azIDHcx9PDHAZeHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311080; c=relaxed/simple;
	bh=K+hbOtrOGAGCbKKkCRcfIyTgfOLi1O9hK0+fbnwnr2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLYusUDRtvMRrZpmXYC5iy/vOlgeaiCmQLGkRZIf/mU7Uyv5FVFQ8rm5DaSv8dfBUEHhMZ+HpuPRrXlIWw316Fb0X167jh8hl3tCmDjdMQa1ko6GyjIyw0LWQofTbhuQbMmoObNs6QXjkiOUTVbTeJ4VdzQBgsqo9zR/8oQT80A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NWTHpPkP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=csbZxvOL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615BjhRF4125660
	for <linux-wireless@vger.kernel.org>; Thu, 5 Feb 2026 17:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2De/znTYMhzkdjSNkKqV21D2B11RQIsOZE/AbzdnL00=; b=NWTHpPkPkoQ3AYiE
	fN1UBg8VcKoApSUA3cRjMAPRndL+MBfG9H6Jgsn1Id7sk4Q64iFPZOYmwU7B6BLP
	DUN3gp7r7H1axFmkN6MKHWux8cAng5hwesjR3iJwUHmfPgRINP1mf62GI7kVlv+0
	zvLCn0BxEqzuDtYV4pd3Fty9IkIbQ/Ap8xK2LFW+0lmklDmWKvF1xeNvTLaUC4kz
	P2xAyEuYaOZWKwagskqEQ9A0ALVoyOWame684wH0K1QZ+TN6kGRHIAetmt+ujdVv
	jK5ywUU5G27osUNFSwgj8YnF6clhiJM3TYUNh6cBZw2QVo7gLgG2NsHx52GK+g2r
	kn7kbQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4tm8s102-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 17:04:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a94369653aso10279325ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 09:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770311078; x=1770915878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2De/znTYMhzkdjSNkKqV21D2B11RQIsOZE/AbzdnL00=;
        b=csbZxvOLzXJg1EN5+C3BMqSsHqyq+gB/ywZHnMRtceLLyObPRhbnxNDprdr97vB2tM
         czajItzo4CJmQ8D9gBSjwZVhILuouVNTXocS3JNB9Lwg65JzHxkINg2PgaeB+SmsYJg+
         G4PKtAOwk3QYpnDTWkM5NsyTDNIavu12ai4PgGm8BNdcaEjxz9vrVxt0bz58J/9b64ka
         1VvsAmlbmrYI83SnND20gxmntifl7MUcoe1Xf5N+WF89h3V6t0ey0skoEE58PAPwaGQ6
         tDTfIr5jCLUmCwyNv0HBBVMhM89GJGAns+bBoDc16LRrIKgURhei8LGYynly26+CcXae
         jRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770311078; x=1770915878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2De/znTYMhzkdjSNkKqV21D2B11RQIsOZE/AbzdnL00=;
        b=g6VZDRG6Z5tWEP7duvRqFi3Dxq1Bzq4wxIh7Ry52BHu+HfttFynubYGqT6tKIZCNP1
         y8bu8I7XzL/0ece7wGKv3v+yl3MNA299rZYzBaGkg1XJL747rr/iwrC213YU4uIQkBAQ
         Gj7lBFOlLtvFPL1zPScZ0Gcb2h2t+rqdCciGbQETvwVq9yG2I1IE15IstLn42U8nHhI3
         BXxGpJsCj9OSsrAhKaiY+/os1KV4DWs5CP/a4D3I1gyW6itZxv4jNAiwnl7ZFHvcqrrt
         v3f98lr87SWJONLRiCURhBQyU3bGzYFFx1quk3n0F988BXqouxrfJt+P8o061DoeyZzJ
         jFag==
X-Gm-Message-State: AOJu0YwIqa4SLv8l4cjr4SHXpxXJ1mxx8baMsLwzKGq/Z7dY4305vfNR
	WHz9gL2q3HWivQ04xZT/dAn0U6KejRh5oHx08yWrUGpzLDYPowP5AysltMbdhDgBOSC+jBsvbtC
	m378Q7PBDdJHADt0u8Ry6aR2xuXuHr1x2jM7hHtBCrOJJ3NygITitpgNjOOIky/9bR8Sx8lmU2M
	3YuQ==
X-Gm-Gg: AZuq6aKFPEsLlLPkEclnoGcxp+pbxwBNAeyfMjUCzGBPze2opE7GFRQ8NGZcMgeEr1u
	8gnoe7D4PiODaFp4d6fP23ReuxQDj2HzB8ZO6u+XH4wA7kbuCAxCGBfOgyQqFmaEDtWUFMjyuzg
	iNvJDBzUUDu3cQfZKdxJ4q/clgzRvGU2Yun/L9gfYmppQ1K4kVEpuIpa25q5/U5wbb0tLdRm6oJ
	53Mql9hI0PIrT26bDdxJdCw/JEWi3v8yAsevph8cfNr/IWbls3ZNPbv9Hc0wK3apvkfeh2OC1kE
	O+ZBKC9KejXqXUttJMRXeH/CWJV1L2/3Y+0B+e8coEcaOZePvpIJk1bDrZ3hqeJ18XrGeDKb0ux
	HdKWoqLO+P1eNwiLzd9IMgXYl/TKsgSqLwGa1Qc7mTV9Q5OAr
X-Received: by 2002:a17:903:178b:b0:2a7:d93a:a3b2 with SMTP id d9443c01a7336-2a9510effb5mr154865ad.0.1770311078080;
        Thu, 05 Feb 2026 09:04:38 -0800 (PST)
X-Received: by 2002:a17:903:178b:b0:2a7:d93a:a3b2 with SMTP id d9443c01a7336-2a9510effb5mr154545ad.0.1770311077440;
        Thu, 05 Feb 2026 09:04:37 -0800 (PST)
Received: from [192.168.1.11] ([122.167.102.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93386cb2bsm59463945ad.25.2026.02.05.09.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 09:04:36 -0800 (PST)
Message-ID: <0c167905-6ba7-4e6e-8a4e-455507d8497e@oss.qualcomm.com>
Date: Thu, 5 Feb 2026 22:34:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] AP: Always re-add stations that use MLO
To: Benjamin Berg <benjamin@sipsolutions.net>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        hostap@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>
References: <20260126160300.2600380-5-benjamin@sipsolutions.net>
 <20260126160300.2600380-7-benjamin@sipsolutions.net>
 <612a2814-216d-435b-a58a-1f17169a944b@oss.qualcomm.com>
 <707fe82d66e77aed06002c529322eb9689db027b.camel@sipsolutions.net>
 <fcef3c86-5384-4211-9f6b-be6ef562cef5@oss.qualcomm.com>
 <97511b524cecf4862d8a83038017c23bc7d715b8.camel@sipsolutions.net>
Content-Language: en-US
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
In-Reply-To: <97511b524cecf4862d8a83038017c23bc7d715b8.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vd76/Vp9 c=1 sm=1 tr=0 ts=6984cda7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Zdx7mwdUnoiiwKr2bH3pYA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=AMFRnIaHFEXoGJ1ZBQIA:9 a=dH9ygP-o-3LtbT-l:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNSBTYWx0ZWRfXwrr9Cr40YNx3
 VCLY7pOLENSV+Ex3hS+kmeuxo1Gsrw0+c3LOBYBASL8swKyWsehE+6nWvg0l/H1VxPwxiE0KwYB
 kdf6GrnAqvdyHBqcV89AS6rzJWkRMu2xWgO/ZBYXHRJwg1B5Fm3QwoZvEOqhWy8lvazKjL+2ozO
 RpOlBeqZexMN7Uztt42q216e0/9c1HTfW+Irng/xoFcraOMp36bXe0z91ZzWHhakUIiYCVB6U4X
 lf8o+3pUm3iGeBrdkBOaYYZIoChlNMDEIMDa52frrzy3ECwdXgJBcBcB7Ff3/wg/jaOnsP8+9xq
 ZUN+qtgVhSyPPh+vWhczY1nkOGnan3D5ARGrkAH0HCLF/e5t34kE6WAnwPeJhdyGbhYndFmq+v2
 l6ZItpV5c7aJARuBHr9HitnLxGLdUfSIlW3v/Zj0dx3cYZsAWqH/chhszRThTASNcR5P5bk3JYK
 MN77WaAiT70XkEY706w==
X-Proofpoint-ORIG-GUID: rarNzIqQyEL7IYb6LYzKihgg8uavxnJT
X-Proofpoint-GUID: rarNzIqQyEL7IYb6LYzKihgg8uavxnJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31598-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ramasamy.kaliappan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5879CF5AD6
X-Rspamd-Action: no action

Hi,

On 1/30/2026 5:32 PM, Benjamin Berg wrote:
> Hi,
> 
> On Thu, 2026-01-29 at 22:56 +0530, Rameshkumar Sundaram wrote:
>> On 1/29/2026 3:38 PM, Benjamin Berg wrote:
>>> [SNIP]
>>> That said, to properly fix this we need an nl80211/mac80211 API that
>>> permits us to disable address translation for the frame. Otherwise we
>>> would still get the address translated to the old link address should
>>> the new link address match the MLD address.
>>>
>>
>> That's true—even probe responses get translated when the old link
>> address matches the new link MLD address.
>>
>> Few other cases I encountered:
>> Consider an ML STA with ML address M associated with link A and link B,
>> using link addresses X and Y respectively. If the STA sends an
>> authentication frame with address Y on link A, it gets translated to M
>> (even though link A has no STA with address Y) and forwarded to link B.
>> As a result, hostapd is unaware of the actual TA and queues the
>> authentication reply to the MLD address on link B. This frame will
>> eventually be transmitted over the air on link B with address Y.
> 
> Honestly, that type of link confusion seems like a bug. We should be
> able to avoid that as we hopefully know on which link the frame was
> received.
> 
>> This will be true even if STA associated in one link and tries to roam
>> to other link of MLD using same link and ML addresses.
>>
>> There also cases where an ML STA roams/re-associates as legacy (non-ML)
>> STA with ML address as link address. The reply would go out with old
>> link address.
> 
> Yes, I think that case is similar a station using its MLD Address on
> the association link and returning on another link.
> 
>> It seems that address translation at the driver/mac80211 level for
>> management frames could be avoided for both TX and RX, allowing hostapd
>> to handle these frames and their replies more efficiently in cases of
>> roaming and address reuse.
> 
> Doing address translation in the TX path is required if the
> hardware/driver should decide on which link to TX the frame. For RX, it
> seems sensible to me to do the translation when it is possible.
> 
> I talked a bit to Johannes about this today, and my current proposal
> would be add a new flag that is set when mac80211 did not find (RX) or
> should not use (TX) a STA for the frame.
> 
> More specifically I think that we could:
>   * Fix the link address based STA lookup to only work when the frame
>     was received on the correct link (the bug from above).
>   * Make sure we drop robust management frames without a STA as we do
>     not want to get into trouble with the next change.
>   * Change ieee80211_rx_for_interface so that it uses only
>     link_sta_info_get_bss if we are an MLD and sta_info_get_bss
>     otherwise.
>     Right now, we will find the station if we see the MLD Address in the
>     frame even when it is not a valid link address.
>   * Add a new nl80211 attribute NL80211_ATTR_FRAME_NO_STA to be used
>     together with NL80211_CMD_FRAME for both TX and RX.
>      - In the RX case, add the attribute if we have no station. If the
>        attribute does not exist, then hostapd should assume the address was
>        translated.
>      - In the TX case, plumb the information through to mac80211 and avoid
>        doing a station lookup based on the address.
> 
> I think this would be enough to then solve the problem in hostapd.
> 

I feel this approach should work. I'm trying to understand how it 
behaves in the following scenario where the STA reconnects with the same 
link address but a new(different) MLD address.

Consider a situation where an already associated STA sends a reconnect 
request using the same link addresses but a different MLD address.

For example, assume the station was originally connected using M as the 
MLD address, with L1 and L2 as its link addresses. When the STA 
reconnects (or roam back), it may use a new MLD address B while still
using the same link addresses L1 and L2.

In such a case, mac80211 will still find the existing STA entry based on 
the link address, and address translation would map the link address to 
the old mld address. Since the STA lookup succeeds, 
NL80211_ATTR_FRAME_NO_STA would be set to 0.

How is this expected to be handled in hostapd? I believe hostapd will 
also need additional logic to correctly handle this case, since the
link address maps to an already‑known STA, but the MLD address has changed.
Otherwise, hostapd may end up replying to the old MLD address or 
associating the frame with the wrong MLD context.

> Benjamin
> 

Thanks,
Ramasamy

