Return-Path: <linux-wireless+bounces-35634-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHm3MkUQ8mmPngEAu9opvQ
	(envelope-from <linux-wireless+bounces-35634-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 16:05:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCDA495532
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 16:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F1F8301488B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0D83CA499;
	Wed, 29 Apr 2026 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WWGy19Z+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c9mHBJpI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634C175A81
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471320; cv=none; b=bAVMcgmhp/twmuxM3M99cp7FoDvtWG9JrZyZ/MsVW+6sLXQbrmNBp5gtS4wkxkjjRZclyWLiEcK+B2jlzF8p0o0F/5+JUbOLq7Ncw2XGyjYSqmCH1wBR2eWoPuEQJp5zHzT/uTBhuw2UsRsfiyxRiFrWMN4uT+0rDssO+N23TNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471320; c=relaxed/simple;
	bh=MNGYMmeqBOQxVsxEkcS8NnFIYf28WObPcvQt4ldTRxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpLYB5uxvHNAQcSrXJv7xZ9TALTZBpKSt0fmGuXLDzGqU1mHUoVpCaIdUxWcEK9u3kWsKIcaX7irb0pvBb2quCyXUpUAXR8jyfCA3BzN26vHa5ylZHgRO/8XTbAb1OOlKdKyKOeGGSOz8K/0EJK+RGoTXzDqqvSL0TDBbTal2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WWGy19Z+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c9mHBJpI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8q3M53752640
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PrevJoBYJRBQ+Rd3PK3/FvJhEmNF9YjBCAP8JTX20n0=; b=WWGy19Z+wlX7VRjc
	wCNru7Jq7lqTFwdkPfpT0z2Hsic+fMfn1+tiSuQ8krc7JN+SbrX4LWYPnMRP4OkJ
	mOOvwAOiIA/ynI2AvoYd1YCyaG+7OAsgfhiUeardcFHL9MNZO2kX74NYuW9fNUm5
	7WJ/icXpxEa3iJCijFQ+URaeSa++n9sKSx6CM6378auwwQJ/7mjnca5WY+mtc9ca
	vJi8xg1GvsINRS+1zRMgLKnjln0gqGY74d0u+QGtkyUZL1+UFvihXBdf11hGMBv3
	iLtAo1WaB6cJ/ig1wiQRmtRp9mkp95kqy/LQcHcBaydM2CbeO4I5u9xl+Uf5/hkZ
	v4Gopg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duch1htbr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 14:01:55 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dce0f50eeeso17950247a34.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471315; x=1778076115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrevJoBYJRBQ+Rd3PK3/FvJhEmNF9YjBCAP8JTX20n0=;
        b=c9mHBJpIAqUQYsYH85/HRJD4vv0Ny4M1QtvzyW+017KzdmEv0FPBFADcWA6XX1JiXu
         V+19B4z2M8mDDMN7lRSieKDSodBWQ6SJV8//2kwISCi7zFcl6N05v/GgOfvbDRkfLR7+
         hQusUIi2ptxLv1rnw2M5/9M8aRX6w1p4TaiqZwFljT33n3IhRTAivl72xUTQ7fP/a36k
         +ERNUXdu6lUYEKh/Nlw8oPwXbgXPnK8gAlMWAaPzGTZvDX80sspAC2V5e6ejP0B8xjWW
         0sN2LgWSo8wiAut9jVDgbNqBNOfUY4e3TIzvrt7v7JWx+CNNtG7aRyUT/Nkkcm2M8nus
         r6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471315; x=1778076115;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrevJoBYJRBQ+Rd3PK3/FvJhEmNF9YjBCAP8JTX20n0=;
        b=RGBgRwuUJz3gQAwU99PMlvIrN6Bgi4D9/npcPfBzFlOmzZmNP5Pa4rSp2JFUphT8zB
         13ZtSzDouHuE1LRxdgITX0p4LPrAlmTIiLdmIIWwPfW6+iRlADnWpAwLOb6jqM0/fY/2
         WufQrJ/YLA/eHYe03DpetfvHeIHwkbaIQnkaNn54gn523aJMuF/DJWc9wnCL/Qv0phFg
         x+jVZ7+YuN9gLYb2UE7WTaT+hWGsxrlQMwrNNOUg2HpUX5iQKoepKhKSVDsDaySUOzsq
         DiBaQcrbcv1tC56lnMJOw96/wcudczlyIXua/1C0nV57Y0EFcRh5awXVqiGu1JT7/bJ9
         NS4A==
X-Gm-Message-State: AOJu0Ywu47ebJxlMhBorBK6ATAtUfPvzKfM/wCjS09Dh2jwSp6MIaJ9m
	UnHFXKW2yj4RAUXjPI4LLs0WFf9lIDtVX+/i3E+Z7TCrT/yMPot1Qx1JrBq+Vupu8Am0Z/0By1r
	NRJu6QM6lz9nBhbCq3EWwGhInUU0VvWioOk5ajvS/jQgaXdibsFMREVhD9ygL7fkfn2ErR3+nKL
	bB0g==
X-Gm-Gg: AeBDieuIVWPplQ42q83dlnFhvScpQ8a3Kgsyk+gR2jwtS1jzZsOrJzRhejmeDl5r/ZV
	Z2XinN4B6oxbLcvcrueK6U9EAAbNSdPR8bLiTX7KeyIdzdwB0W8/y/MQVbdI47QQKzh6S14grRB
	jsvh2BPoFk9tox6O112AXIswfXSSDaRdX0YW01MOlbRqOhvTTn+9sey00np5i9bgRUsTe3eHHy6
	Ryvlvk80viFCI8bs6L9u5S9At7k/tSjF2RIua9rU/YL3n+ZEWd+305rR9B+3KpUpoo8mQbBTTWE
	Oe6NXLFcTu2ZzIddHkmTuEAzhytSaHA0CAbJtqMlIlgqZXIob7WgFdiBB7lke+HZydDfdqQuGt2
	c7KJxPe7h/2d2+bx3fbcWl2tnfokvYpU2kNxvCdzKxrda6LP+DjGJiSPuYT0Hm3PZTi+AzUrjYv
	3FNSJJKDatizLtkYoe
X-Received: by 2002:a05:6830:82e9:b0:7dc:d0cc:91b with SMTP id 46e09a7af769-7dea68be508mr2331491a34.26.1777471314438;
        Wed, 29 Apr 2026 07:01:54 -0700 (PDT)
X-Received: by 2002:a05:6830:82e9:b0:7dc:d0cc:91b with SMTP id 46e09a7af769-7dea68be508mr2331344a34.26.1777471313080;
        Wed, 29 Apr 2026 07:01:53 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deab990323sm1400957a34.14.2026.04.29.07.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 07:01:51 -0700 (PDT)
Message-ID: <310b536e-fcdb-473f-a498-8c6ef9e983cb@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 07:01:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath9k: use kmemdup and kcalloc
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgens?=
 =?UTF-8?Q?en?= <toke@toke.dk>,
        open list <linux-kernel@vger.kernel.org>
References: <20260223224445.27352-1-rosenp@gmail.com>
 <2e123142-b931-45e1-98e4-dc7283266d10@oss.qualcomm.com>
 <CAKxU2N_jjaO9_+795za5Qt8FxkO_sSdbEUPjeBEvFKwuAH+3Lw@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAKxU2N_jjaO9_+795za5Qt8FxkO_sSdbEUPjeBEvFKwuAH+3Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=arGCzyZV c=1 sm=1 tr=0 ts=69f20f53 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VRSxEhDT_9TDMmBRrE0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MiBTYWx0ZWRfX3A9hCzDXiKAQ
 r5wjmncFzeiPx0ijm7PQX04EPbWlABcUO4IoVeGueWqt6tfggc4XEcxywnH6JVmltr6GypphHc8
 RRgOMwdW16LonI2RX1WwOk6jXxdO5v1hUE66vIG565F++/gAa1qCfcWZwmmFScq9LQmfQFJcNIh
 3Uzlvnip73+zx8X/W4WZ7xvV0WBTHHHwe8aU1QrVhmpDBuHFVH+49MVNaqjrNjPcKvbK4BorLFK
 8Q6+2VdwmhTtE6g/UTdSWs5+0Nh8suxM2w0VXWahECKoVrz7Xf1sl+FsRUXgUgcYhit7wzEARwQ
 TxZQF/sJlfknGChGWTNlkiiTGiRyjTkqt8Ry3xSqnUez8mRm4Y0k9YZy0dNRE5J7/6ncPTRabbO
 9F9eRmqamSW5TPUsIni4qcpHjnlesg==
X-Proofpoint-GUID: opJtJ2MBDav3rCRFaT5Qyf094hfNsyY0
X-Proofpoint-ORIG-GUID: opJtJ2MBDav3rCRFaT5Qyf094hfNsyY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604200000 definitions=main-2604290142
X-Rspamd-Queue-Id: 0CCDA495532
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35634-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/16/2026 4:42 PM, Rosen Penev wrote:
> On Thu, Apr 16, 2026 at 4:09 PM Jeff Johnson
> <jeff.johnson@oss.qualcomm.com> wrote:
>>
>> On 2/23/2026 2:44 PM, Rosen Penev wrote:
>>> Simplifies the code slightly by removing temporary variables.
>>> multiplication overflow is also gained for free.
>>>
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>> ---
>>>  drivers/net/wireless/ath/ath9k/ar9002_hw.c   | 6 +++---
>>>  drivers/net/wireless/ath/ath9k/common-init.c | 8 ++------
>>>  drivers/net/wireless/ath/ath9k/init.c        | 8 +++-----
>>>  drivers/net/wireless/ath/ath9k/recv.c        | 4 +---
>>>  4 files changed, 9 insertions(+), 17 deletions(-)
>>>
>> ...
>>> diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
>>> index b52ddb237dcf..e52775dda6a7 100644
>>> --- a/drivers/net/wireless/ath/ath9k/init.c
>>> +++ b/drivers/net/wireless/ath/ath9k/init.c
>>> @@ -297,7 +297,7 @@ int ath_descdma_setup(struct ath_softc *sc, struct ath_descdma *dd,
>>>  {
>>>       struct ath_common *common = ath9k_hw_common(sc->sc_ah);
>>>       u8 *ds;
>>> -     int i, bsize, desc_len;
>>> +     int i, desc_len;
>>>
>>>       ath_dbg(common, CONFIG, "%s DMA: %u buffers %u desc/buf\n",
>>>               name, nbuf, ndesc);
>>> @@ -351,8 +351,7 @@ int ath_descdma_setup(struct ath_softc *sc, struct ath_descdma *dd,
>>>       if (is_tx) {
>>>               struct ath_buf *bf;
>>>
>>> -             bsize = sizeof(struct ath_buf) * nbuf;
>>> -             bf = devm_kzalloc(sc->dev, bsize, GFP_KERNEL);
>>> +             bf = devm_kcalloc(sc->dev, sizeof(*bf), nbuf, GFP_KERNEL);
>>>               if (!bf)
>>>                       return -ENOMEM;
>>>
>>> @@ -382,8 +381,7 @@ int ath_descdma_setup(struct ath_softc *sc, struct ath_descdma *dd,
>>>       } else {
>>>               struct ath_rxbuf *bf;
>>>
>>> -             bsize = sizeof(struct ath_rxbuf) * nbuf;
>>> -             bf = devm_kzalloc(sc->dev, bsize, GFP_KERNEL);
>>> +             bf = devm_kcalloc(sc->dev, sizeof(struct ath_rxbuf), nbuf, GFP_KERNEL);
>>
>> use sizeof(*bf) here as well?
>> If so, I can fix this in my pending branch
> Sure
>>
>>>               if (!bf)
>>>                       return -ENOMEM;
>>>
>>> diff --git a/drivers/net/wireless/ath/ath9k/recv.c b/drivers/net/wireless/ath/ath9k/recv.c
>>> index 34c74ed99b7b..93b41a1bb2af 100644
>>> --- a/drivers/net/wireless/ath/ath9k/recv.c
>>> +++ b/drivers/net/wireless/ath/ath9k/recv.c
>>> @@ -202,7 +202,6 @@ static int ath_rx_edma_init(struct ath_softc *sc, int nbufs)
>>>       struct sk_buff *skb;
>>>       struct ath_rxbuf *bf;
>>>       int error = 0, i;
>>> -     u32 size;
>>>
>>>       ath9k_hw_set_rx_bufsize(ah, common->rx_bufsize -
>>>                                   ah->caps.rx_status_len);
>>> @@ -212,8 +211,7 @@ static int ath_rx_edma_init(struct ath_softc *sc, int nbufs)
>>>       ath_rx_edma_init_queue(&sc->rx.rx_edma[ATH9K_RX_QUEUE_HP],
>>>                              ah->caps.rx_hp_qdepth);
>>>
>>> -     size = sizeof(struct ath_rxbuf) * nbufs;
>>> -     bf = devm_kzalloc(sc->dev, size, GFP_KERNEL);
>>> +     bf = devm_kcalloc(sc->dev, sizeof(struct ath_rxbuf), nbufs, GFP_KERNEL);
>>
>> here as well?
> Sure
>>
>>>       if (!bf)
>>>               return -ENOMEM;
>>>
>>> --
>>> 2.53.0
>>>
>>>
>>

FYI I'm going to take your patch as-is since there are other instances of
ath9k using sizeof(type). These can be cleaned up separately.

/jeff

