Return-Path: <linux-wireless+bounces-33753-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKrJMZcEwmnOYwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33753-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 04:27:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 609FD301ABF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 04:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C6BC3016AF7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 03:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC815B0EC;
	Tue, 24 Mar 2026 03:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mrUKC9PA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I/wWv85K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72C396591
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774322815; cv=none; b=McnKkihCg3bJAEm8/8rU8a0isgLwAks2fCeg8GXvA0tiiLf3oX+U+U7mQnsUAez5zsG5ldvAKfLDzaMk2JSpQqVZ6hZda5BXeim2ZK60zATxVWEG/+yKwPa4IP8OoLqqaADYV461WiWR31atYaC9g0q0S03Y/Dqy4sn772jLHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774322815; c=relaxed/simple;
	bh=qip1ZHuqo6oda8jDW4v+wYIiOqh3DuObfIFFC8KExeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ofajo0JWT5+RvvSGq9d7ZEYHwqLCgCAqlnaQ9sAPX220YNzDmZRH4d8HdqK1mvx/FuYggrHLUAIvatrlLK+N8hFhKP3L9X44RkqcV7dNUfBa12laVyzgixSc2qlSlVI+YCAHLtc5b6YYjHCG6W+tUSERfh+4qWWt6Svf87ANWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mrUKC9PA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I/wWv85K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHqZUI2971865
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 03:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z9bDgd2rrZOk8w719cYMGjoo4mCCtQZY7pIySHyCXsI=; b=mrUKC9PAAXFi9e2A
	4tLOmVn6jdBjc3UNWzpk5bZRELR4xBCk7QAlLYeGfEWxFt3J2KM04v/0ZfGOp8V0
	tcf09el/5V6TB712L4FVuPPR4iT6KVbWz0/9xrGQT0HXlWulzuouSpKSfwQgKdkw
	/nFZNm0aX53QYaUcQBiuSQmgdwdM2iNYww293x2c+UIbICDnXOuNfjCWR/iQDwwx
	UIFlMPeziA07BEug7A1dvEfebSYKCgssrtEbkUfv1uWp307+fnjesGdO5rDjFj+C
	emJDcJzbcSNM9x8SwLigGQv6D6fymBz51TQmoWXT1Sr2bZH1QSA9JfOJGSQeL262
	dv8N9Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jc3ukq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 03:26:53 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c73a4983fc0so3601910a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 20:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774322813; x=1774927613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9bDgd2rrZOk8w719cYMGjoo4mCCtQZY7pIySHyCXsI=;
        b=I/wWv85Kj9xyqSHB41q1H+0uDtoikOpiphBRoH27mxeps+G1j789Va61GlwgSkL+Vb
         EjUsyRPuLLH3a7fEDIwP8fmFKRGoIXbCxxeaIJPqW2gzWjdGNI/GIraosyZP/7fNOeJo
         /MlhkLJqzMafYCkTc2DZUCyJU2VXApgayQerYfs+jg6sUC8ZS5Zj7ls9G/uIpvrWJTN9
         DttfrzT0+RIfRAqEaPen2IRx3aKeq7uHCucwlc3p4Oa0FXhU/DgHQouCffyDPlEuj3xK
         MSGubzSprC+wv9aM58/RhgN/uqD7Hifnkss0LjEnVYtY+GE/finZ6xjwFUoXQnJhntxN
         6vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774322813; x=1774927613;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9bDgd2rrZOk8w719cYMGjoo4mCCtQZY7pIySHyCXsI=;
        b=c4oqTo4oPhphHGxQF2/kh3C8+G1oSAc/PaiiCcUOtN1zmAvmcmHiQMwgj/Y2b6EHRm
         GcNgD4ksQDvvKvFIrsCLDbo8mCLAfzQlN3k2wIO6K7VmqszDQiW4kCf83LWuzBNYQlRJ
         b8lbKvRlQNiDtqyhq5GAVq8xXY4V02XoWiKFzSGolfYBrVKpomWCT3Fzre3dUvoukWWC
         YygZGzPEok2rC2QNYuBkQjevoOTg0bksTJ9Mp8YPXcbNF4VyL1FYh91E2v6XAZp6s3Aw
         fGPCbKPGJXBVKvS0nl6M3PGvvOOy7+jbDj6Ypwk2ToW4uFMnoOl+sR/V36n28hCtI1qy
         t1CA==
X-Gm-Message-State: AOJu0YzaDjUuzpLO5n0eQvO3wZY8qpWQZv5m2GYckIzUnc0sEVPpCXRc
	sD/JjfErRLo0xYUOYcQFtbk2enG2FVvdL0KcKUNZSnFqf8zyKnIJ/h0bRs1Az9QgtF/lyhFqZxW
	B65bRLzL06A32lZ7xSO/67XGURQeSc/ZcUHKkqKtmbcTz+n3r6gpV8jGYmrYU06hXhTrz4w==
X-Gm-Gg: ATEYQzw6MJekFe/9Ph/Kh7w6M4JIsAmQ8FCSjmwQiu2khi5Zi4sxvZf+fK7JAYreyLU
	hvgGo+P1AJ1ii0CaizfNeLKQ9TQCPBV2fIoQmFix7qiYU6lfVnmNdTVFbg0F72MQfnZgaDld1Uz
	7ybn4WpPHiQRSqhyl82wsFl+t4jGDCxqal+X7Q8UEEP+rCa3d74Sfn71XleM+yEf7knvlUbW6s1
	stEzf0vPRblOmSDhSY1s14c5qQfHsN1kB3cKyKdZ0Ew9my76MmQ6Okdowk68H2M27CWbEWCBDAl
	K5TIjEg7WdyKG8wfGooDR4+FMrNdhC1tkmcjiWsR5fZnNf3VJ0nYmyTACJPM6EthMbtNcdtcboT
	jTpL4KJ1RXPk+KRe3hGwo1cWEPYYzPVrl+Q81ZUOaAG8MvMlHAaKeog9bZLQ7fBQmNMPO94k1rI
	zFBJ0TLkM9i74g44NIWv0=
X-Received: by 2002:a05:6a00:3a18:b0:829:8139:d5cc with SMTP id d2e1a72fcca58-82a8c394369mr11912390b3a.62.1774322812542;
        Mon, 23 Mar 2026 20:26:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a18:b0:829:8139:d5cc with SMTP id d2e1a72fcca58-82a8c394369mr11912356b3a.62.1774322811935;
        Mon, 23 Mar 2026 20:26:51 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bbf050sm10367619b3a.16.2026.03.23.20.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 20:26:51 -0700 (PDT)
Message-ID: <424fe007-3426-49ca-9129-09bedebaa0b6@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:26:48 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath11k: Pass the correct value of each
 TID during a stop AMPDU session
To: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>,
        ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260319065608.2408179-1-reshma.rajkumar@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260319065608.2408179-1-reshma.rajkumar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fKc0HJae c=1 sm=1 tr=0 ts=69c2047d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=vkfXM0Oplov9zySb:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=SuUSrtddnHl0rAUyDDgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: A0IPCvg5AI7tuAk3ITN0fGslputWDqGg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAyNiBTYWx0ZWRfX2AccxT4iiJ2W
 QDrdUqFQrkkFcJBRJQL17ZcFMrehmSLRyZB0AVIqMEJAgLyphpDouuf3ezgZ9IsEAPPU6awT+qm
 UHykMHFjIsM5ZekGriZTI+L6IMIFnw7DW3credKKqgq5Q5GY637KsMiyfuLj1EOPlobHFYsKXB2
 zh/4tTWHQDHZhhYk/LKxADX2f/N5wCy+ZSfShq6t07RZ/YiIWzvTwu+DLUkHHrmywvfSYn024vL
 TvC29U8KfTyzsQ7pBWyP8Tuy0+0+CKUMVyF6BUizHgj7cMuEH4Zv6wO4aPc/PYrqops4+yfDEea
 LaUWlIg2fKR7yrSSNSrImg5T9JZtLiyLyxU5bRaq44ii3orhPL1+NeTxzImPd9Nj0WJWFPc7qly
 mXDk32FxtNxS5xtY/kyu5Zc1Hsh4zu5Gxdx8M7q1/HLB+FT8ZmT3+8pY1c3ICXXn7g6FUsnYBag
 MSkR2mimO8b7ypk98SQ==
X-Proofpoint-ORIG-GUID: A0IPCvg5AI7tuAk3ITN0fGslputWDqGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240026
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33753-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 609FD301ABF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/19/2026 2:56 PM, Reshma Immaculate Rajkumar wrote:
> During ongoing traffic, a request to stop an AMPDU session
> for one TID could incorrectly affect other active sessions.
> This can happen because an incorrect TID reference would be
> passed when updating the BA session state, causing the wrong
> session to be stopped. As a result, the affected session would
> be reduced to a minimal BA size, leading to a noticeable
> throughput degradation.
> 
> Fix this issue by passing the correct argument from
> ath11k_dp_rx_ampdu_stop() to ath11k_peer_rx_tid_reo_update()
> during a stop AMPDU session. Instead of passing peer->tx_tid, which
> is the base address of the array, corresponding to TID 0; pass
> the value of &peer->rx_tid[params->tid], where the different TID numbers
> are accounted for.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f2895 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
> ---
> v2:
> * Added QTI yearless copyright
> v3:
> * Removed QUIC copyright information
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 49d959b2e148..85defe11750d 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
>  #include <linux/ieee80211.h>
> @@ -1110,9 +1110,8 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
>  	struct ath11k_base *ab = ar->ab;
>  	struct ath11k_peer *peer;
>  	struct ath11k_sta *arsta = ath11k_sta_to_arsta(params->sta);
> +	struct dp_rx_tid *rx_tid;
>  	int vdev_id = arsta->arvif->vdev_id;
> -	dma_addr_t paddr;
> -	bool active;
>  	int ret;
>  
>  	spin_lock_bh(&ab->base_lock);
> @@ -1124,15 +1123,14 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
>  		return -ENOENT;
>  	}
>  
> -	paddr = peer->rx_tid[params->tid].paddr;
> -	active = peer->rx_tid[params->tid].active;
> +	rx_tid = &peer->rx_tid[params->tid];
>  
> -	if (!active) {
> +	if (!rx_tid->active) {
>  		spin_unlock_bh(&ab->base_lock);
>  		return 0;
>  	}
>  
> -	ret = ath11k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
> +	ret = ath11k_peer_rx_tid_reo_update(ar, peer, rx_tid, 1, 0, false);
>  	spin_unlock_bh(&ab->base_lock);
>  	if (ret) {
>  		ath11k_warn(ab, "failed to update reo for rx tid %d: %d\n",
> @@ -1141,7 +1139,8 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
>  	}
>  
>  	ret = ath11k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id,
> -						     params->sta->addr, paddr,
> +						     params->sta->addr,
> +						     rx_tid->paddr,
>  						     params->tid, 1, 1);
>  	if (ret)
>  		ath11k_warn(ab, "failed to send wmi to delete rx tid %d\n",
> 
> base-commit: 7bbb578fc43e7dcb8690cfc98844bd67bc311e8a

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


