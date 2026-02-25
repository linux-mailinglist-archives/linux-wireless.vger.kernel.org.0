Return-Path: <linux-wireless+bounces-32188-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GqOB6N2n2nScAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32188-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 23:24:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FC619E3EE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 23:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 445D0303A84B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 22:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFE332ED24;
	Wed, 25 Feb 2026 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o3xf4W2I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DXDKs3TA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE832AAD3
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058251; cv=none; b=bd4PWxnT1a97QP5eMECi1I8Ka/uNT5ULrksjn1pd7U47BrGOjD5TL2Txx6dJZmvCFixucG3MbzQPcBA6axIGwqjDfpir7tr4CiiNR8xoPaeiz8xxmgH3tISjhtwwhraMsCpQ86N+y/dHWT1CyUT9m/xyityvVcc1YSU4y89PH/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058251; c=relaxed/simple;
	bh=f3e35Ez6uhgZgPH5U0fc93eG4IVguXA81SEeT4cMkR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nU8suV1N5IhrPGDSpcdqnPumza7akarSwEtgfkvf7fe74RYuPDcjR2f1ABYKIEBgRbAW7rAbvIDSlAVHOPCzrFnn+Vsk8EgujCoF+xF7EulEKFzAceX5DEieqaFeRvdOz9d95J7n1rSUsRP9xuzhaOaGJ0/y7Og0VgZI9F07SQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o3xf4W2I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DXDKs3TA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PKMnQt788486
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 22:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	svccUThHe/dQLGWL4PYVHbZ8LS96Vy6iNyhhAR9sFEM=; b=o3xf4W2IYukQzGJl
	3df3jhgP884OdcdX1k5XXFAtEMraxac66VwBsunfsiQKOv8aGP1STPiZAeiRwkZG
	ImjJZ+bRX+WdZ+10ewE26vB7jKw+NxKtNdQkhsVThJ0ibdlFwXpXg84mrOddhJle
	LVjmjjw8rRHKcofL4yWz+EknVDYeeyzddkfRJuemfxLvvEeibDRul8uSXCOtF06N
	PubpnaLbQfOVFIiGaGa6V8JLgPtl2b+VrUCy5517kHl9SOoPwKkaLPSfCkDXDlnZ
	k0nWlQBjTbWdytzCdDanUNa7jXA00/wQ6mn6y0fxvzncrjwN9+F51pXV6Smfsuu9
	ojASyQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chyv9j04t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 22:24:08 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4638cb0bc65so3742541b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 14:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772058248; x=1772663048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svccUThHe/dQLGWL4PYVHbZ8LS96Vy6iNyhhAR9sFEM=;
        b=DXDKs3TAywpfyiMhKZUHic3JvQFWDA4TFmWwBKj0L7Glv6BSNg2JeAGWoXBI7WkfGs
         75POzC/4FzTUVXgrpNxR3gYBDax6sXfqUjQGdJwwCMrxSOKsmJ2un+IV4oFIYlEVygGw
         EMaz5+ijFeJNdHIY5MGmIl2d5byN+Cdn0Ws7K1JjsdMhn4zso5S9QrbSO4YJT8NBuDkn
         dszRrUWRFzvBXMm8BJDnkWx2b5yeTKfEb/RC4KCsNZf2SbGZQyNAaxxg7zVW+d1Q4BXV
         1NkbUXevYm6Gz1B/J4/rG18x+OM0PJC1wQ/swWq83qm2ktCyUxXNt70fuN+NueADWHGX
         xFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058248; x=1772663048;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svccUThHe/dQLGWL4PYVHbZ8LS96Vy6iNyhhAR9sFEM=;
        b=D4frL7tFD7xCkQTgg0EeLotmIxys7JgDUBUG7Ti0RAjD9af6SG7Oc/W3vZBxAg3AQq
         n9iymtdlsDH457m65P7sMzlcpisrXzYaTUngMVlgeok7P3Hp53e8inldwvwjOjmGuYy1
         i7xLBT2qzAO52baMpeBAyFTJwXGUvbOR/aO9B0RV0OWrSlqvvhKO0hFM2OXaLlMqRaLn
         35UvkWGut3uqzj6Kk95L+t7kZIeXJDjqZqsvAMqN3mqkUneRwTXpPfruO+htGVxkBPLr
         CMEhFhJBX5k5dmq3UbiMIPRxNKXpOpYEzJcWcD1oNHqYRqteNTNwoJKLHYPHVy3GffB3
         a6Yg==
X-Gm-Message-State: AOJu0YynPSgg6Ppi8no0oObG/PccBgx4yS6iQuCKcx/8zLtrNY9xmmyc
	tVQp/6Cq+L4oXd6/UUakZdQYa+UtB/dYmTsvd7e5qfPf9RpGYwknJ9R8KGoHT6V4pgvcPd1LPyP
	0TO13Qpo0YRYQUOaAXN45NHHr4DDjIbGXYBg2/hcc7Sy0etVCvcm2LmpvYtVx+HxOVPODxA==
X-Gm-Gg: ATEYQzyr5x4Aaexv+ymCSaXBDj2QTiEQZz+inmnw5+eZRlp4bEJJC3Im+ssuBBZNR2d
	B2yCLHC0EEEYKKS07Tp4/eg72zRDsYD7FKhix5c0pDHHC2+kcKBp8OpYfJipmXW22vB++9lfi/Q
	wCmtSEOB2EdllZwqJXzzMAHOUfXv37xQ55BkXiElz/Jzu/3JJ6yLNlEqAYZkFkUk596OwnQDypv
	x8eiK3j8LRcUn0LMr62i+mGHiasK9QLPYEDtTY5GjojUhAlw8/6YFvXFpUKjYH83zUuWT/u2DDb
	4MZIW11hji1yeuaIvBlFljnzosgyQA3p0TiBx2gJEt6prRhOOC29/Urhs8tfKvEhEK6IGEJei4P
	fHz/Wupk9CiP6GSP5z+/0FNk7KudgB0dgJQWu1aknjHx2JGBgIT5DQ5kfMFDDWuGoriVfaWO0P1
	FLDB70YzMatZ72bw==
X-Received: by 2002:a05:6808:c2ab:b0:45c:90d6:9911 with SMTP id 5614622812f47-4649efebc95mr1146807b6e.36.1772058248102;
        Wed, 25 Feb 2026 14:24:08 -0800 (PST)
X-Received: by 2002:a05:6808:c2ab:b0:45c:90d6:9911 with SMTP id 5614622812f47-4649efebc95mr1146791b6e.36.1772058247726;
        Wed, 25 Feb 2026 14:24:07 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46460661eeesm7255226b6e.13.2026.02.25.14.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 14:24:07 -0800 (PST)
Message-ID: <704dc2ae-cc22-463b-b858-060fe7d35f9b@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 14:24:02 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 0/4] wifi: ath12k: harden stats/rate handling
 for WCN785x stability
To: m.limarencko@yandex.ru, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260212121746.329619-1-m.limarencko@yandex.ru>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260212121746.329619-1-m.limarencko@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6sLwQ3cPh06NQb3mW326nqtZG8DplOYl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIxNCBTYWx0ZWRfX5eD6w+7in5kf
 pD3n6yFNkQAJWTVbBbrmvXNHj3we/4dAVsPomfmHrq409dk1L3OMbg+aXqHUVw88TeOwbYLN2Yj
 siXQYXMZt/lwXOo2MnTcbJyH01k/Wjdxgr/TlwgcErFcp4448xPdxIwjZuxo4VcfOublDaoT5zT
 yrgOU0ygAYPjPc7mOij8oSgeXKN+ZTHzi31F7PNLOh1eJ6vuDbKG7bF7HmNB5sPvgOWzMSqud5p
 xqYPq/dDmtoAq5Urhx3cDhAu36nBubz5km7NgRxYVHxPywXYYbfLsKu1cLMZnA+E4kz9F0l2Fv9
 dkNGMm9JCkXGhciqoLroxTtS7h2GGOdUoda/LFmO+hIx8l0teM0DjGMQhJ9y481ZMNk5IT40s+3
 dspXlQ7q8TMaMhfyQ4Swn4ZQhLiW3VJZ4mt/K/O3Um+a2HArC6Lkd49nZ3OmEihZbietkW81PXc
 ORFOi/MrdagJvqeRV8Q==
X-Authority-Analysis: v=2.4 cv=GZwaXAXL c=1 sm=1 tr=0 ts=699f7688 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=vaJtXVxTAAAA:8 a=fa93lz8o_VCnTWEDYAwA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: 6sLwQ3cPh06NQb3mW326nqtZG8DplOYl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250214
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-32188-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[yandex.ru,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 69FC619E3EE
X-Rspamd-Action: no action

On 2/12/2026 4:17 AM, m.limarencko@yandex.ru wrote:
> From: Mikhail Limarenko <m.limarencko@yandex.ru>
> 
> Hi Jeff, all,
> 
> On QCNFA765/WCN785x (PCI, kernel 6.18.5) we observed three recurring
> issues:
> 
> - chan info events with frequency not present in local survey range,
>   producing invalid idx warnings;
> - frequent VDEV_STAT polling can block for 3 seconds on fw_stats_done
>   timeouts and cause visible hitches;
> - occasional invalid MCS metadata (for example HE MCS=12) propagates
>   into mac80211 status handling and correlates with ieee80211_rx_list
>   warnings.
> 
> This series addresses those cases by:
> 1. returning an explicit error from freq_to_idx() when no channel
>    matches, and rejecting negative indexes in callers;
> 2. reducing the wait on VDEV_STAT fw_stats completion and skipping
>    unnecessary waits for stats types that do not require it;
> 3. sanitizing invalid MCS metadata in both dp_rx and dp_mon paths by
>    falling back to legacy metadata with ratelimited diagnostics.
> 
> Tested on:
> - hardware: QCNFA765 (WCN785x)
> - kernel: 6.18.5+deb13-amd64
> - AP mode: 5 GHz (802.11ac)
> 
> Observed after applying this series:
> - station dump polling no longer shows multi-second stalls in test runs;
> - no fresh ieee80211_rx_list WARN was observed in the same windows.
> 
> v2:
> - patch 1/4 commit message no longer claims OOB in chan-info paths
> - patch 1/4 keeps matched-frequency index progression unchanged
> - patch 1/4 returns -ENOENT on no-match and callers reject negative idx
> 
> Thanks,
> Mikhail Limarenko
> 
> Mikhail Limarenko (4):
>   wifi: ath12k: return error when survey frequency is not found
>   wifi: ath12k: avoid long fw_stats waits on vdev stats hot path
>   wifi: ath12k: sanitize invalid MCS metadata in rx path
>   wifi: ath12k: sanitize invalid MCS metadata in monitor rx path
> 
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 38 ++++++++++++++---------
>  drivers/net/wireless/ath/ath12k/dp_rx.c  | 39 ++++++++++++++----------
>  drivers/net/wireless/ath/ath12k/mac.c    | 22 +++++++++++--
>  drivers/net/wireless/ath/ath12k/wmi.c    |  9 +++------
>  4 files changed, 70 insertions(+), 38 deletions(-)
> 

This series does not apply cleanly to ath/main (or ath/ath-next).

Please make sure the issues you saw have not already been fixed since there
were substantial changes from 6.18 => 6.19.



