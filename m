Return-Path: <linux-wireless+bounces-31684-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGxhBgmoimlBMwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31684-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 04:37:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F51116C2F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 04:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C5923009FA4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C061E1A3D;
	Tue, 10 Feb 2026 03:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GaQH7BMs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vl6k07fv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553A33043D2
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 03:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770694662; cv=none; b=e2TTqyXHtF9gVrt97L/qnIgVI1jc6wr5FMFfGywtbrMX6QbJ+6H8CR+jYRYpKHm9x9+PgP+xhT+2XCOZh2995my9wMwqcftN9oDvKQcGpW4y4G+wufISa6AvuE6stw65qzObPVaHsznsMdu8uAb4sJEbuutrUhe2Lr+Emq19ds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770694662; c=relaxed/simple;
	bh=W9o0A4pAgjNP+T/d5lcurHPGYk7HYnMORq2wFXKDJaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+kDBx74WYzL2P39/qAwLfagHxcyMGXgNghoBLmwuFnJQYDOv/KMmgb7i4IuOpfYjZ53+DRwduH8eYiFi7zaZWN+Wivdj/B/tKnqY6hCWieTflyhJLpIbcfEAh9wFeemWz2DUryZ/Kc14N1HU6WtqGAyztLIW2/mIXATCMatGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GaQH7BMs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vl6k07fv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619M48Qe4003666
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 03:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RCvZKli0Aao8G3OQ069vZ3CA8WH0FQZqZOD/rpVWq0s=; b=GaQH7BMs9VIMxx5Q
	EM7C4gAPiDtgqIrVXiorTgPJ/RKXwlicsm6xS+kk/pqUBG1/b9yk+YR5xWkWzjAH
	0WknMZ2qFcgrGT1wK7w+W0M5XqYiIuqc2m9g+v4lGB0rr8gNnzNGjenF9LraBsuO
	ZWU4NaxL69fDVYrSGAG/1PolAg+Jq8guMJ3mTnOPk90upTbGftAWPyHeqanoamdV
	5qDVJygPwsZUMvUgbS1UFLJIe41v+ygyBGFY6gb5mRM0bSxizvPEfHI6X6VXgOAq
	xMwBMgNq6rDQCx7tFv653z2cqavAGdGcOtXNfu6joKCysr0D8X3g8tfuN+f3VGFp
	gbLB7A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7r23gwnt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 03:37:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81e81fbbb8cso5335575b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 19:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770694660; x=1771299460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCvZKli0Aao8G3OQ069vZ3CA8WH0FQZqZOD/rpVWq0s=;
        b=Vl6k07fvhsxdXQ/PUDUkUPn+41FZpCjE0fOTzQUq2+9aRQGcVS+TEO5K+i5mMLpMHi
         XJQq+Rb/MEAeZVoS+vQ78vkivcE4WuSlkxjzFhs1N+p7+jZIiTlQz5NU9l9udG2NFCt9
         D45DiAqCONwM9N3Qf8gRpTs+0zNaU2bo2oeXlcLmltjiirRRZJ6cZhc2KSmFQLWqYtfD
         u0sWeRn5eB4pHMOJudbK62z0ANta02UkzTGANtdrPmiQGJtcr9B0PH9ExZ+8FbMtxTmf
         nInU32rELeyotG5V+h/bTQ+9q5KWFJJiHgAPBQ/KJrRYmtE/ecGS4Nb96lnyDIX6eLll
         rLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770694660; x=1771299460;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCvZKli0Aao8G3OQ069vZ3CA8WH0FQZqZOD/rpVWq0s=;
        b=YG0OSRS9jTiv+Vggy0x2r4T9F/IgAsc3VomHNS/d04A6h2B+6xaO/sDPJu9cs4FiVw
         4qxtO4mbikyjiOxxyAsAQ5nyYLMiU41U9CcKzExZXTlri+JoT5znJ1mNUJcJuf4t+o7A
         eHBkkfos1WHaILBX540ZzRfsPJ1eiOiwwrQBHc6kjrzXQhJ8WvjV8KOJPePR1hQitwP2
         FHdxceBPeQT9vlZC4CiD5wUFWSRYdnL6wRn9iCNNDcS1MT2W126JVeuG70yzBojrheIR
         jNgm0XcWe7IFhyGTx3XhQG0+NZwIU4FNI+BtEvl2aQHXS2793Ag0IOAJmZcWwzrWUVI5
         yHbQ==
X-Gm-Message-State: AOJu0YztnZ2YqA4iqXNfHfJqa0As0TOqUPM8o+MeW2RBiwFqYYmIe7JU
	+Xnf5HRbkchjRAKoViFjeUmJPsDWyRIC7NIhT0jNxKlmai1Ag4RLql06VzFNMpnJaBHLqw5HHPo
	/wiOLxozJv9YYkPCGh4kCfXyny56zbQT2JCOx+snaFhknGTzJoHaje2qgQ+uj3oGVHyCDIQ==
X-Gm-Gg: AZuq6aJqRlFW1PkSf8iazHop/Spjuz6889Yn7Hs2mZV2c5/VtvtZdCXmoeoWRJEIPhO
	qM2U0plwBKzO3wZzs62v8lwZI6/JtPrSoQ+g+WgPC+wnFYZh1K6fGP3WO6IkKd/zWvKAXJfQMCj
	JSifMLy3nlx2do1DJKT2znTqCIHGdoDbbSP1C3YiGnv4FvFS5ZrtBojpKTj/agKh96RKz24HsyS
	epoFWkM0OngGfErL8j9H7NGiO1pEF1j48VKKyX4T59dBWSfhBga4F7FvwGioRh0T1juJGCyaOYB
	NLBxYrz95jKpRxgBpRJbmj57foZCpPC99aOZ/emxZl5yBn9b44r+VVn3ZZiBIoU/2eBxI3r12lL
	Ju48cCm7zhiWzSb7WyoYHio7r3Jv3yDH9obFIY5Uzb4+THzB9ncenFHUMrLg5V+EAoJc/yNdcC/
	tMLIs2hT3urOWQPMh9qw==
X-Received: by 2002:aa7:9a8c:0:b0:822:f928:fd97 with SMTP id d2e1a72fcca58-824879b83bamr1028633b3a.22.1770694659778;
        Mon, 09 Feb 2026 19:37:39 -0800 (PST)
X-Received: by 2002:aa7:9a8c:0:b0:822:f928:fd97 with SMTP id d2e1a72fcca58-824879b83bamr1028606b3a.22.1770694659311;
        Mon, 09 Feb 2026 19:37:39 -0800 (PST)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418b842dsm14149370b3a.52.2026.02.09.19.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 19:37:38 -0800 (PST)
Message-ID: <a4d404da-c8c0-45c5-9097-42280c4891d6@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 11:37:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/4] wifi: ath12k: validate survey index when
 frequency is not found
To: m.limarencko@yandex.ru, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260209030243.1530075-1-m.limarencko@yandex.ru>
 <20260209030243.1530075-2-m.limarencko@yandex.ru>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260209030243.1530075-2-m.limarencko@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDAyOCBTYWx0ZWRfX6E1SVRSzXwwk
 sO6c3g53sreRUMH/5EX0rF9zCou/zXap+swV2SBCpHgthX0adH2Iei9GpfkuPPqpZOg5xY2ojSF
 JNiAjyAxZJhKA3h+wO1FAFsVHUT5E6fRWamwDZIrA+wJkpdKIP2tIpmd+pHjU14DK8GWQ4ZV6+8
 qCanCOIfXCnJI9x8toql22P9Cf2166N2JAIo7gmyA2JQu4Y3aZ7IjWP1mj2PxdKf3llwUiZ9d2T
 mA5a6k1Zvv/8ZWgiRMdSt/pfkDPHBxF8V3jIPNy0pcCCH/hTZp/cXawytKG1yz7MKxN4L5I2Il9
 NTMxIlbPANlrjqXQX3/ZYFc2uUus8kdfGMqziMA+uRdKrEKPD0f7/6C5Ek0geMlUmyhWX3wVd8n
 +hpeA5Bgu/5LTYU9iIYnRHM8dr9boMlKbQhZd1N+Y9LakT7cVxhGT/z5VP5u9ct9unBFN98e+I9
 pY2lH9gyiadrBwfFBwg==
X-Authority-Analysis: v=2.4 cv=MLRtWcZl c=1 sm=1 tr=0 ts=698aa804 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=vaJtXVxTAAAA:8 a=bbBjNLaf5w195QMG7moA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: xY0adwHKs_BafiG0sbqz5MNKNaw8Hyj3
X-Proofpoint-GUID: xY0adwHKs_BafiG0sbqz5MNKNaw8Hyj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100028
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31684-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 71F51116C2F
X-Rspamd-Action: no action



On 2/9/2026 11:02 AM, m.limarencko@yandex.ru wrote:
> From: Mikhail Limarenko <m.limarencko@yandex.ru>
> 
> freq_to_idx() currently returns a monotonic index even when the
> 
> frequency was never matched.
> 
> In chan info paths this can lead to out-of-bounds survey indexing

how can out-of-bound index happen? there is already the ARRAY_SIZE(ar->survey) check there
to prevent this, no?

> 
> for unexpected frequency events.
> 
> Return -EINVAL on no match and make callers reject negative
> 
> indexes.
> 
> Tested-on: QCNFA765 (WCN785x), kernel 6.18.5+deb13-amd64
> Signed-off-by: Mikhail Limarenko <m.limarencko@yandex.ru>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index e647b84..422e3f8 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -6520,7 +6520,7 @@ static int freq_to_idx(struct ath12k *ar, int freq)
>  		if (!sband)
>  			continue;
>  
> -		for (ch = 0; ch < sband->n_channels; ch++, idx++) {
> +		for (ch = 0; ch < sband->n_channels; ch++) {
>  			if (sband->channels[ch].center_freq <
>  			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
>  			    sband->channels[ch].center_freq >
> @@ -6528,12 +6528,13 @@ static int freq_to_idx(struct ath12k *ar, int freq)
>  				continue;
>  
>  			if (sband->channels[ch].center_freq == freq)
> -				goto exit;
> +				return idx;
> +
> +			idx++;
>  		}
>  	}
>  
> -exit:
> -	return idx;
> +	return -EINVAL;
>  }
>  
>  static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
> @@ -7475,7 +7476,7 @@ static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
>  	}
>  
>  	idx = freq_to_idx(ar, le32_to_cpu(ch_info_ev.freq));
> -	if (idx >= ARRAY_SIZE(ar->survey)) {
> +	if (idx < 0 || idx >= ARRAY_SIZE(ar->survey)) {
>  		ath12k_warn(ab, "chan info: invalid frequency %d (idx %d out of bounds)\n",
>  			    ch_info_ev.freq, idx);
>  		goto exit;
> @@ -7550,7 +7551,7 @@ ath12k_pdev_bss_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
>  
>  	spin_lock_bh(&ar->data_lock);
>  	idx = freq_to_idx(ar, le32_to_cpu(bss_ch_info_ev.freq));
> -	if (idx >= ARRAY_SIZE(ar->survey)) {
> +	if (idx < 0 || idx >= ARRAY_SIZE(ar->survey)) {
>  		ath12k_warn(ab, "bss chan info: invalid frequency %d (idx %d out of bounds)\n",
>  			    bss_ch_info_ev.freq, idx);
>  		goto exit;


