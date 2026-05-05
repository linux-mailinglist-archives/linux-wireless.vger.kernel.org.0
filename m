Return-Path: <linux-wireless+bounces-35952-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULHNCDox+mlXKgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35952-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 20:04:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7153E4D276F
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 20:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B3F73069EA2
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 18:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6C03A641F;
	Tue,  5 May 2026 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WqFg7khn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EjMBNkHM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BEA42188D
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004251; cv=none; b=X4wdFCLAQZATms9FPqFFqqD2mFSfO/iNnTwMvmcaT+vmD1VzLdDznyqm0umsTKp9Hff1WH6YUqJ6XT0vfiiaGcA5vCcZ9bBfJa7mTBvMceCk3a0Z0lXIa3RPZsqGVgywrRJamaJ6W+UK2gGqk9WTrTZpsqRyTktQlZmRwBxfiVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004251; c=relaxed/simple;
	bh=WG7RH8StGpF7r2cLZvN/oQzq/1iDQ4ftH4Yo4moje94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1qdWcp3KBZapfAwcJN+LgulAuxDBAoJt+Qpi5mfqPBZOdh/z853N1YIZh7tjI7N63gLNeejnsGfCoSDHqtOk+EgmdliH/jnCg6Oiu2PzRthu2lcYID2lSilWWe49YLS5A0v72BrHM/E2U0m8kMnZ52FPEvXaszkuM/3XeGNPbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WqFg7khn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EjMBNkHM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645Do4UF3475816
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 18:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5lLU7l4kSZccBRLUQ+eRQMvrUbzRZ6NblzN59DJLrog=; b=WqFg7khnwMkaCy+b
	So/l/lhXbUU9APkAK8j+tILv36J2V/Qe7Z9A5K2SfDF5hss74maq2+Fxl+1DZIXx
	foaOxzmZQig+RJZvssMSeQOMudueJ6di9jUQExjQ8bDSXY4soN8tlw0C8dPq7F3k
	KXSekL6skyU0Ck9ISQQd2zdqAwo7j/p5RlDKUkEqIFz7m4KjigK76nt8J2J0IRVd
	mFg9TDxH+OfEpGTcdg4hTqeaUK0FBOU0QyZNI7iJL0xIV1hMjR0FFpljY97eCnTo
	rsBuWNr/ZWY/05FfVsEJM+N4Q+cTiAsT+iQ/zi1B8KWLH++gOjM4Mdaj35rBKi8S
	d9NcmA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhsgs4ag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 18:04:09 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f525565b33so400561eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778004249; x=1778609049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5lLU7l4kSZccBRLUQ+eRQMvrUbzRZ6NblzN59DJLrog=;
        b=EjMBNkHMz9djzOj3pS+HKqUGjD3VdaDrSl7nk8YPrjYP44jzb9Nr2cTG/CPP1MN+Jg
         xm/uPsAzUyKW29Tkx2LGKm4rpIVeXrg5MNet7Mm53BMMExPCSoJCGxU9+zPNbDEd9Nbr
         vPF5Q59OMHNXHtUDMqdgYIYpdY5IjoH5a7w0eS0LtN6hZMAuSk3oO6VJ/ZrF3I9VGRG2
         CsUjGdpG+zs2FxmmMa9DutyH+bQOFil1F4VvDVltL2PneQDtQ4m3joEyBJpTdOcO7HDN
         koIWHKFfonwf8b/KsQIqR6QBvng/AJQUiy5ioJhGJ1cIKqtjFYphG1GPqdjj2R1Cwy7Q
         ftSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778004249; x=1778609049;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lLU7l4kSZccBRLUQ+eRQMvrUbzRZ6NblzN59DJLrog=;
        b=Oa6Din3II+kp32KPdL3Fw03R6i3r6e2C0p1Rd2C49y++Xu+67RcSbBIWeeUbyE1M1E
         PEsPhBLXaTOq5OEV+KSnHLOteo9MxpEffK0dRE08dY0u/1izaHoN7Lb/fk0oXQCefJJk
         OwdEvjd3egHl+EPZwXMImir0b1Sw0vBCJ/R0ay5HzjhKu1RHN19HcX2i4Kl/VmYrKFFg
         P+xH86kKzFOi45S5lQNJ2xPzH41xnbYMMBuoz9eAy4Pq3pQS5gG90FNkZTdP3ym7QHAM
         FVH1AZ+YwvfbtOSPe7FVWBEAvfAt6W9ZhNkUt4QBTLluMA0ZQgE0pv9wuhAImCdds0NH
         Kqlg==
X-Gm-Message-State: AOJu0Yy9jA1iOS2DCk8WoTqwKcYkh6HoW+AatenosMWmqExKcTVG1fIZ
	G9u/O5+zHyiMR2QPKm3QI7UMp4tYu0oazAti5+uG9Gp99MGrPeCdl2hUBWbiXIDJI0kyDqvRxPf
	H5LdZSCqAXlVWpL3EWh81POlkmRMG7FeEEmo2WSancUXJgCYPAMQ6E6PYYER91kmN6RmgiwyP8c
	XVZQ==
X-Gm-Gg: AeBDietp/kJAWysKHv5gDH0dI8N4zb4urzuOBQP/Sn1VsR6eE7z3VNYS5HQP8vfkjBX
	00lg182jMQGxnLD7FL/o+5uRhNWMWBZ1CSQbL9w9SRVeAGECDujoKjZoFywXT2Kb+uPDAH4MpD5
	TD2bDCK28e0JA99muy68WJrwH05XJ6vRHFL7mhDMqTGC+WaXDnTVjswWvacvyXP6vv63NqHSRa3
	qAd2NkbjMPgj3CGi8/UQiwPh8Ywf2gq+C4nV+Mz9cCBsNbvb/tiXGfGREh9ZYFS3OyzjFuWEm7q
	j1pCpxgK6v58NjxkQoyNwhLZDcer8EL7BtgO/IcOn7dJpltqtUMMzFW00haEP83IvCEkmSH6jhD
	+irA2SZmKfLT24kzXR/ytLG3Qm6IIYDP+5NkuLTjEtcR1BY8ossyOYC6gaEV4zNAj4M0K7COd3W
	QESBlsvYC9yJPyo5wK
X-Received: by 2002:a05:7300:b507:b0:2e0:909a:b9c with SMTP id 5a478bee46e88-2f54e09e275mr154389eec.15.1778004248422;
        Tue, 05 May 2026 11:04:08 -0700 (PDT)
X-Received: by 2002:a05:7300:b507:b0:2e0:909a:b9c with SMTP id 5a478bee46e88-2f54e09e275mr154367eec.15.1778004247747;
        Tue, 05 May 2026 11:04:07 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d611sm28455624eec.1.2026.05.05.11.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 11:04:07 -0700 (PDT)
Message-ID: <6a55e7b8-4392-407b-bf22-36585dc12d0c@oss.qualcomm.com>
Date: Tue, 5 May 2026 11:04:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: fix use after free in
 ath11k_dp_rx_msdu_coalesce.
To: Willmar Knikker <willmar@met-dubbel-l.nl>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260505171709.547274-1-willmar@met-dubbel-l.nl>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260505171709.547274-1-willmar@met-dubbel-l.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3Q_ruNAz78wElWgLMyswVpu_9RQyl-wW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3NSBTYWx0ZWRfXww16ZXkFJHeZ
 OnbF0VfnTSmHi5yhAD9cvsM9I8aDk/SU4ska4kfLNfDPP4W5aVsftBcHgwha+/nnfW+ZLfa942p
 Owe9QRm1z7PMvGCgyoZnab8Cn8b/HK6lhoG3tdxwAIIqTVhcXgHfzJEs7gm3Hv3Upc57td6kbbI
 FLJkkfQbVBF0cXl1lF9ahxP41vbtY9xddvnw9cuuOJi8ZUy/Hf30exiaTQYx0fMXGflxO+Jx95t
 1GUTZXHDR3yPhMpt0Q/bh2eZAc2CFDv34aNnWekYjThBoJj/YA7Fy5MWlbUKyPOElg8KyTEPz9P
 PyGFiCgvwNp5Z/mqFwsuFjOUsC1IWqFvTUjKX5Sotmynfrn87o+s17iGVl6RkxnSlR+MaZJhvjg
 wNMWxr7UxcLcT3C7tXEnNKN4zvAzdszwrGHKmQITGNUM/nIM5bPy/QSpDw05bB8KtYLcynJk6Dd
 8hwv/7ZSiVbV6TcqzPw==
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=69fa3119 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=9B1uR9gGAAAA:8 a=_Q5U1Uv4BMVt9x7mxWMA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=8R3p93Tjo66ouot214C2:22
X-Proofpoint-GUID: 3Q_ruNAz78wElWgLMyswVpu_9RQyl-wW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050175
X-Rspamd-Queue-Id: 7153E4D276F
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[met-dubbel-l.nl:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35952-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,met-dubbel-l.nl:email,qualcomm.com:dkim];
	GREYLIST(0.00)[pass,meta];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_SPAM(0.00)[0.290];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Spam: Yes

On 5/5/2026 10:17 AM, Willmar Knikker wrote:
> In ath11k_dp_rx_msdu_coalesce the loop uses ->is_continuation after
> the dev_kfree_skb_any. This can cause a use after free kfence.
> 
> Use flag for caching is_continuation for use after the
> dev_kfree_skb_any.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Willmar Knikker <willmar@met-dubbel-l.nl>

for future reference the revision history should come after the "---"

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#commentary

no need to re-submit for this; I can clean this up in my branch

> Changes in v2:
>  - add bool _is_continuation for use after the free.
>  - Add Fixes, label to commit.
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index fe79109adc70..16364f76fc3c 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -1761,6 +1761,7 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
>  	int buf_first_hdr_len, buf_first_len;
>  	struct hal_rx_desc *ldesc;
>  	int space_extra, rem_len, buf_len;
> +	bool is_continuation;
>  	u32 hal_rx_desc_sz = ar->ab->hw_params.hal_desc_sz;
>  
>  	/* As the msdu is spread across multiple rx buffers,
> @@ -1810,7 +1811,8 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
>  	rem_len = msdu_len - buf_first_len;
>  	while ((skb = __skb_dequeue(msdu_list)) != NULL && rem_len > 0) {
>  		rxcb = ATH11K_SKB_RXCB(skb);
> -		if (rxcb->is_continuation)
> +		is_continuation = rxcb->is_continuation;
> +		if (is_continuation)
>  			buf_len = DP_RX_BUFFER_SIZE - hal_rx_desc_sz;
>  		else
>  			buf_len = rem_len;
> @@ -1828,7 +1830,7 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
>  		dev_kfree_skb_any(skb);
>  
>  		rem_len -= buf_len;
> -		if (!rxcb->is_continuation)
> +		if (!is_continuation)
>  			break;
>  	}
>  


