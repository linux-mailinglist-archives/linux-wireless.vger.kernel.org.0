Return-Path: <linux-wireless+bounces-31666-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDt9G6n2iWl7FAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31666-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 16:00:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC98011161E
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 16:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3F3C301BB86
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B27E3446C7;
	Mon,  9 Feb 2026 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sm0T8W+t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+QruVoX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFAA2750E6
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649014; cv=none; b=WncTJD0gJymhWtJQaFx5FA29RA/JU5VPts8krBZXh5eKlfihLIVGnESgI0JGgu7N5+DVpXOThdr9L8s+u85nWSc1KPmwmUYygYI1HD3sHG59M1jlpVngk969ZeiFUT2O+nSBX0y42Aq70qYVx0kBfz9U/unGM4vUcEQkusc00f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649014; c=relaxed/simple;
	bh=iyusyYgFovKZWEsPF5MfBDTcuNpzhGuqZnx0PUahKis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAPZxt8iBNbGL5HHG1buF0iQUcI41ZqKUf/1935lPrBdk5JXM/0VaMXlJ3N6teC2MDLkvDQ9y3rDXUfjze7PNOwkRwEdItNBtJtwgSoh7xuMqzKcih6x4XELWnLjstiaNlX3T9NL0VH5zyTkDWQAgPvOXyUMux4S2CxoKQrzvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sm0T8W+t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+QruVoX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619DFFVD857204
	for <linux-wireless@vger.kernel.org>; Mon, 9 Feb 2026 14:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NRZDwUW9scXoOD9HREFP2bc3KVHzz5IsLH9jtoURN+A=; b=Sm0T8W+t8HOnQa38
	SJMvwgTLjezQKY55hnhd94g4Y38kOh4TXtyl6egpnhC5Nxo/3mww6qnEGh0P8jOD
	kMi6SX/8IIEzTKJMweseMjJCz4qJOBk4ohi8ri3LA2FLyyx7SpIRAn6w9FY4brQU
	2GAoatMvRr+8ZSEPclvxp+TxijwmhkBbDwBxuzUuIejfGe1eUXpMOFRdHKhc2/9b
	F8F7EcYvCSmxVJBkkdh7/NuzCi/ZY4xAqFywRnBnPJk1JpY17mlF/0T3//DLA+kC
	SN6P+u8fOmcwZHogvLKgGne/BFWLlwSzRX/bwRADkMuJIKJco6wOgIajAMe9KwjN
	GKdnvQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7ga60aqx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 14:56:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a79164b686so58027365ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 06:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770649012; x=1771253812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRZDwUW9scXoOD9HREFP2bc3KVHzz5IsLH9jtoURN+A=;
        b=K+QruVoXs9MZE5WkmZL8FVo3nCMQ2Zws1+ROANm9TkyvlWv4Z0rLxZtSrnGATU1LLn
         0cOQ+fJhMIw2lujQKEqNIGuhpbmZzMepy6eHqmD8/4/EKxhdSi+a6YYCWDGhdRP3aSUQ
         zju0R9jUbie1T4eMKHIxVbSbiq9KSUibSV4BaqHJW3ycKlaxHoOsfBcb9NTkyddTxq5+
         vBCRweeZ5s+uR7D43Uy+bP4ulfZOi3w7TJ4TbbGU41tkhl+Z+HQVWAz7QAYF4f9xi58P
         ObIKLUrDv5LOllTdoyz8aLlxXddtZz6NtkPzq613WFLmUJTnIgQyQjSiKCkS/SHSLJbl
         cR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770649012; x=1771253812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRZDwUW9scXoOD9HREFP2bc3KVHzz5IsLH9jtoURN+A=;
        b=G6rv6yBFPjySl1p9vYLTVZeNmp7SkwdEDO37DUZlJDklFzfewHghsfMOTIWfECzeu/
         lS0jZqJPmFCn3SU7xpbCJvBxXjeOU5A8cGhsOI+1G4GYYMmK/s87i5k5/TdHeSNXfqfS
         jRK8ixjCM/9swzKqEwZ52Cg3eLr+oi46bXyikvKMMmltlN2TMZ5Usm1FLb6nHS50fL8J
         FOh2Q6iZerbaDgov596uYRnp3STzwTqEmZI+Fvr1c9M5d8N2FbO9rijbxKT1Di81WbkA
         UcNwL9lk7UzONyj5We8C0HjET1rnBaS83SDYTIleIgjlz9sHljchbXl4A6P1uSstH359
         d4Ng==
X-Gm-Message-State: AOJu0YyrkKZPgmfK/5rwdOFqRbBXZDnTeJtcCrwihAgu7TDXt00vqada
	hVcFGQzgs1rdHcMTHMC01SMF9CqNZe2YVlwm1iBMIFSieyFTWJbRIgfwdtMPtyqKmY6rP9gJKbX
	mdoAVcLuGJeCMJrOrfWCgJ+Qt+xztQfHJ1Qwy+ulBz3oDPw8pwmEcCyjJF06qJljue89uow==
X-Gm-Gg: AZuq6aKlu3HJ7FOi0HqcoLDsHYmE6UuYJs8f07cEhF0qBPdh+N6TYppSD4DTVqXA+q7
	b0X8a3mfyglA7wh7P79/MINl5ywAjokB5FnMXBr5RT/zd3fK+ocYdLmFWYWGwJlnswSLG633qrN
	9Op2SWhSSoc9J01clOqhr3NEnRjgYNCQeujG7cRAu6H3fDVW8B5cldQ7bIdmVR7XkQotO/1F+AF
	D1TwY+ThRjI4rtCLya0O/2RankZuwLobX+W/rzwV0q+thM2ZKFx2MpSFS6yI09vUxTEeFBmLZ/E
	M6RO7JTyuwvVJNAq3GNDufWJ8b7J/HLcBpR2hBGZMZkUCHPrDaX/RWzVcLmysCQroF45TvMvg4r
	rdlfTQkxnmEMA7hs3vqRQLURuKY6shVyto+1bgTMzQv43t+F4RRz8S8euHUnvh/gvqSo2j2Z5kq
	Odf9KDoEk=
X-Received: by 2002:a17:902:cf03:b0:2a8:d469:9b2c with SMTP id d9443c01a7336-2a95170bd94mr122410175ad.44.1770649012105;
        Mon, 09 Feb 2026 06:56:52 -0800 (PST)
X-Received: by 2002:a17:902:cf03:b0:2a8:d469:9b2c with SMTP id d9443c01a7336-2a95170bd94mr122409965ad.44.1770649011470;
        Mon, 09 Feb 2026 06:56:51 -0800 (PST)
Received: from ?IPV6:2401:4900:8900:f8f:791e:716c:1b4f:44dc? ([2401:4900:8900:f8f:791e:716c:1b4f:44dc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c7a342sm108659645ad.26.2026.02.09.06.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 06:56:51 -0800 (PST)
Message-ID: <0779a514-7fa0-45a4-b153-2273bdb8b905@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 20:26:47 +0530
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
        hostap@lists.infradead.org, jouni.malinen@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>
References: <20260126160300.2600380-5-benjamin@sipsolutions.net>
 <20260126160300.2600380-7-benjamin@sipsolutions.net>
 <612a2814-216d-435b-a58a-1f17169a944b@oss.qualcomm.com>
 <707fe82d66e77aed06002c529322eb9689db027b.camel@sipsolutions.net>
 <fcef3c86-5384-4211-9f6b-be6ef562cef5@oss.qualcomm.com>
 <97511b524cecf4862d8a83038017c23bc7d715b8.camel@sipsolutions.net>
 <0c167905-6ba7-4e6e-8a4e-455507d8497e@oss.qualcomm.com>
 <3643c9d1111a0076c7d420a16d0f97c29ac6575d.camel@sipsolutions.net>
Content-Language: en-US
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
In-Reply-To: <3643c9d1111a0076c7d420a16d0f97c29ac6575d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5DFMhlTAqxy_6e_Nhvlgz0WQ9pORY34P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEyNiBTYWx0ZWRfXzzZ7cVAr95AL
 pfp3yRxAH/TkCaS+c8mlpfnlKWFofApPvx1LpiQc2Weq8n6KNOTHC78Q6x9kFZQdOZmUEAavj43
 +FNS+vhqjg9dbMYK9xf5Fhr5fh/NOEqg0v7ZSHQRr2PTrIQ3K8CcBMag6W6VCBkZD5S8P83jmy4
 Dtll+WCz5m7NDyza/zcIM7O2Z6pxquruZBVr8MKbkWw4itwS+zsb6FdogB/u+4OEFHsFukEwDTc
 L9+hKhmhVrZfe3BxOGVKTdcj3xSEvOcHdOqZq7lQlnMekk1Q1ffuhp4vnP6aIi8QNEZi9qxhGFV
 XHtTUtNpSfAyD+7Z6FqOuCA2bmU/AKiMNZiAaLr4Z3LfV/SXGYcHgwoyAoYzgFf8Urg4NEpYEjg
 Or/oDU3nc7YA/NlNuy9lyuTVcSZlW0mdK8fA00cwTDTZsTGQqCItxGIDD2qQVUMqqhqSl79q0Vu
 7K2zMEiKvfeSa4v1e7w==
X-Authority-Analysis: v=2.4 cv=WK1yn3sR c=1 sm=1 tr=0 ts=6989f5b5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=doj6ZWKXABqyKjoThNsA:9
 a=JrzreMYRJUGHUExM:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 5DFMhlTAqxy_6e_Nhvlgz0WQ9pORY34P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090126
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31666-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim];
	RSPAMD_URIBL_FAIL(0.00)[qualcomm.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ramasamy.kaliappan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC98011161E
X-Rspamd-Action: no action



On 2/6/2026 2:35 PM, Benjamin Berg wrote:
> On Thu, 2026-02-05 at 22:34 +0530, Ramasamy Kaliappan wrote:
>> Hi,
>>
>> On 1/30/2026 5:32 PM, Benjamin Berg wrote:
>>> Hi,
>>>
>>> On Thu, 2026-01-29 at 22:56 +0530, Rameshkumar Sundaram wrote:
>>>> On 1/29/2026 3:38 PM, Benjamin Berg wrote:
>>>>> [SNIP]
>>>>> That said, to properly fix this we need an nl80211/mac80211 API that
>>>>> permits us to disable address translation for the frame. Otherwise we
>>>>> would still get the address translated to the old link address should
>>>>> the new link address match the MLD address.
>>>>>
>>>>
>>>> That's true—even probe responses get translated when the old link
>>>> address matches the new link MLD address.
>>>>
>>>> Few other cases I encountered:
>>>> Consider an ML STA with ML address M associated with link A and link B,
>>>> using link addresses X and Y respectively. If the STA sends an
>>>> authentication frame with address Y on link A, it gets translated to M
>>>> (even though link A has no STA with address Y) and forwarded to link B.
>>>> As a result, hostapd is unaware of the actual TA and queues the
>>>> authentication reply to the MLD address on link B. This frame will
>>>> eventually be transmitted over the air on link B with address Y.
>>>
>>> Honestly, that type of link confusion seems like a bug. We should be
>>> able to avoid that as we hopefully know on which link the frame was
>>> received.
>>>
>>>> This will be true even if STA associated in one link and tries to roam
>>>> to other link of MLD using same link and ML addresses.
>>>>
>>>> There also cases where an ML STA roams/re-associates as legacy (non-ML)
>>>> STA with ML address as link address. The reply would go out with old
>>>> link address.
>>>
>>> Yes, I think that case is similar a station using its MLD Address on
>>> the association link and returning on another link.
>>>
>>>> It seems that address translation at the driver/mac80211 level for
>>>> management frames could be avoided for both TX and RX, allowing hostapd
>>>> to handle these frames and their replies more efficiently in cases of
>>>> roaming and address reuse.
>>>
>>> Doing address translation in the TX path is required if the
>>> hardware/driver should decide on which link to TX the frame. For RX, it
>>> seems sensible to me to do the translation when it is possible.
>>>
>>> I talked a bit to Johannes about this today, and my current proposal
>>> would be add a new flag that is set when mac80211 did not find (RX) or
>>> should not use (TX) a STA for the frame.
>>>
>>> More specifically I think that we could:
>>>    * Fix the link address based STA lookup to only work when the frame
>>>      was received on the correct link (the bug from above).
>>>    * Make sure we drop robust management frames without a STA as we do
>>>      not want to get into trouble with the next change.
>>>    * Change ieee80211_rx_for_interface so that it uses only
>>>      link_sta_info_get_bss if we are an MLD and sta_info_get_bss
>>>      otherwise.
>>>      Right now, we will find the station if we see the MLD Address in the
>>>      frame even when it is not a valid link address.
>>>    * Add a new nl80211 attribute NL80211_ATTR_FRAME_NO_STA to be used
>>>      together with NL80211_CMD_FRAME for both TX and RX.
>>>       - In the RX case, add the attribute if we have no station. If the
>>>         attribute does not exist, then hostapd should assume the address was
>>>         translated.
>>>       - In the TX case, plumb the information through to mac80211 and avoid
>>>         doing a station lookup based on the address.
>>>
>>> I think this would be enough to then solve the problem in hostapd.
>>>
>>
>> I feel this approach should work. I'm trying to understand how it
>> behaves in the following scenario where the STA reconnects with the same
>> link address but a new(different) MLD address.
>>
>> Consider a situation where an already associated STA sends a reconnect
>> request using the same link addresses but a different MLD address.
>>
>> For example, assume the station was originally connected using M as the
>> MLD address, with L1 and L2 as its link addresses. When the STA
>> reconnects (or roam back), it may use a new MLD address B while still
>> using the same link addresses L1 and L2.
>>
>> In such a case, mac80211 will still find the existing STA entry based on
>> the link address, and address translation would map the link address to
>> the old mld address. Since the STA lookup succeeds,
>> NL80211_ATTR_FRAME_NO_STA would be set to 0.
>>
>> How is this expected to be handled in hostapd? I believe hostapd will
>> also need additional logic to correctly handle this case, since the
>> link address maps to an already‑known STA, but the MLD address has changed.
>> Otherwise, hostapd may end up replying to the old MLD address or
>> associating the frame with the wrong MLD context.
> 
> I am not sure we really need to care about this case, but, I think we
> can handle it just fine if we want to.
> 
> In this case is mac80211 would translate the address to the MLD Address
> and would not include the NO_STA flag. hostapd can look up the MLD
> Address in its database and translate the address back to the link
> address for its internal use. It can also explicitly TX the response to
> the link address by setting the NO_STA flag.
> 
> So, I think it is an interesting corner case and we need to make sure
> to not get confused by it. But, hostapd should be able to handle it.
> Either by simply rejecting the AUTH or by making sure the MLD addresses
> are all correct if the association succeeds.
> 
> Btw. I did start looking into doing the mac80211/cfg80211 changes. How
> should we do it with hostapd? Is someone on your side maybe able to
> work on the hostapd part?
> 
Sure, we will work on the hostapd side once you post the 
mac80211/cfg80211 changes.

The below few test scenarios we have observed with various IoT client 
behaviors. These are cases hostapd/mac80211 must correctly interpret the 
frame origin and address mappings.

These scenarios involve address reuse, link address swapping, and mixed 
MLD/legacy reconnection patterns seen during roaming or second 
connection request:

1. AP MLD with 3 links (wlan0): a legacy (non‑MLD) station initially 
connects on 5 GHz and later roams back legacy station to the 6 GHz link 
of the same AP MLD.
2. AP MLD with 3 links: a SLO station initially connects to 5 GHz using 
link address L1 and MLD address M1, then attempts to reconnect on the 
same 5 GHz link using only the MLD address M1.
Incoming probe/auth/assoc frames use the MLD address → link/MLD address 
swapping occurs.
3. MLD AP with 3 links: SLO STA is initially connected on 5 GHz (L1, 
M1). Second connection same station attempts to connect on 6 GHz using 
L1 address(5GHz link address).  it sends probe/auth/assoc frames on 
6 GHz using the 5 GHz link address L1 with the same MLD address M1.
4. MLD AP with 3 links: Initial SLO station connected (L1, M1 on 5 GHz). 
Second connection same station attempts to connect on 6 GHz using the 
MLD address M1.
5. MLD AP with 3 links: an MLD STA is connected on 5 GHz + 6 GHz. A 
legacy STA later attempts to reconnect using the same MLD address on 
5 /6 GHz.
6. Initial connection: 2‑link MLD STA (L1, L2, M). Second connection: 
another 2‑link MLD STA using (L1, L2, M1).
7. Initial connection: 2‑link MLD STA (L1, L2, M). Second connection: 
another STA using (L2, L1, M) (links swapped).
8. Initial connection: 2‑link MLD STA (L1, L2, M). Second connection: 
STA uses (L1, M, L2).
9. Initial connection: 2‑link MLD STA (L1, L2, M). Second connection: 
STA uses (M, L2, L1).
10.Initial connection: 2‑link MLD STA (L1, L2, M). Second connection: 
STA uses (L1, M, M1).
11.Initial connection: 2‑link MLD STA (L1, L2, M). Second connection: 
STA uses (M, L2, M1).
12.Initial connection: 2‑link MLD STA (L1, L2, M). Second connection: 
STA uses (M, A, M1) (A = a new link address).

We need to clarify how NL80211_ATTR_FRAME_NO_STA will be handled in each 
of these cases.

@Jouni- These corner‑case behaviors were observed with some of IOT 
clients. Handling this attribute within hostapd introduces some 
additional logic to find appropriate sta, source address for received 
frames and destination address to response.

Please share your thoughts on this approach?

> Benjamin


