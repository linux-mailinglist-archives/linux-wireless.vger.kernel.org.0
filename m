Return-Path: <linux-wireless+bounces-34991-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N+WHdqN5WnXlQEAu9opvQ
	(envelope-from <linux-wireless+bounces-34991-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 04:22:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62F42634D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 04:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B36EB3001FAE
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 02:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C415377574;
	Mon, 20 Apr 2026 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WnUfbfkW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R84MFJNa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17E3750CA
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651732; cv=none; b=rpTYp/ddCbleXzgswDTyMiwScPTZ/iG1kkfzNxPrybCx0FtZ1g2p+3HQhuythOG+xPmXuKwoE46yv9GueMwh/PE30Y73iOvL4lIhhrJGCcaSxo+HDeX2d0XXx8R1QSCvGV+3uwTTW+KpkMKhZmvv5VVoEEZK7buNxqfxsPpMlFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651732; c=relaxed/simple;
	bh=5BcjVB3MqrcBSEqqNeG07ugHlj0CHm1xOFBeDB33dMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYx+qXBQoFK0pU/CJmlLh+MN4nu5NiU8j65bO5wyzDSiYjprmJxDNb5Ph+0ltwaK5szxG3wX0SWBGk+LzvcYQ5ssCsPKr3TDgbJUrUhXmtgRqaBBLZyMB5F1sYmrjRB8LUkfXMaUdpavO5jzqsVx925K4W+KldJu1LXgX13qgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WnUfbfkW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R84MFJNa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K1PH3N2386683
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5xXtD8l8YqLF0HZdr+8U1U57kN59Gw5OqLqwwXN9jN8=; b=WnUfbfkWTrTf2ikC
	6sqd2t3rhWYMO+07Lqwi5JWBB1anc2qy4nIQOYE5sHOTPlcIifznNfziScfRRrpe
	lQvB8TjinNgA0MyrFDtdXb3WNDOCM2192TrIuRPHUii6uCzlwyW1uiNVFv2+HIkc
	SKLUE0D34Iw/R1ykfYql/qAhBrjfxRwCMgMQKopVvsCI2YB5yiZe5Xz5b47uhciq
	q6Kdq7a6bId7Al8m4vGz+vJKSXZpfEflAV3AOMmGnZAcVHVDKjjcZlKViCAYljoA
	YspjB3YZZhqmDAmkCTL7b3uKyL0ol1GnSKFeWienY3umS/gfJt9VYwDH4MTIAZnd
	MKOFyA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm34hbknp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:22:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3568090851aso6014163a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 19:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776651730; x=1777256530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xXtD8l8YqLF0HZdr+8U1U57kN59Gw5OqLqwwXN9jN8=;
        b=R84MFJNaslxB7++gixc62+vcmCK6QYgEX5KMU3T7xLcUAIk1PgHhpBEOhVo+f8GPHO
         L5oRH4u0m1+mn3C+trnwucI6yqOY8obFX5xcjb5JL+9y0LeeCS18i5aPGDRSkNT+OTnc
         wjzYHUqPUqQXTWyWzMtzop9wURYr7p5564RVR9S3Z1tzGOSgPkBYrXWWruCTowi0SCvg
         /XRtaH2lDoYwXXMDb+JQ2VdBxtNZTBLmM6hx9Ndqdcd3GbN5FTXiBjYkjsgs16HnkqnF
         BA5eRNoS8Loz4pPy133+J32JXWandJ8zpoh6Q2Rz6Ul71sTK57Sl2lVYn6Eb9AKv26P/
         Rl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776651730; x=1777256530;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xXtD8l8YqLF0HZdr+8U1U57kN59Gw5OqLqwwXN9jN8=;
        b=ZwYAIIH1zSi8pvgOqB28x/UIyMz90xKATYVtM5WCq83l80rQd0HfLG3T6/4L96bAFj
         LFQ+jNhNtEGEv7tnPL9VfndK1f/g/RthfqoWG/b8vY33QWCIDb8WcjljrspN5HHyw+rZ
         bNKcqaQGLTWAtNIKL7kumFnmesTCCngkbjBTs1GPw0fTsqErIa525z7xG680qxqyiFzX
         Zc0Yz35WNiCeAXVKYQL+rAQwszUBfPYbIspnGg059iN+OIypBU8yGIzC2KLePwfa5taw
         OORnQR9u9xxLlq6mfz8b5Ph+4tFJNlvgLXZkyD+yrZE/jnBPULQEevH/GbkG+dXIJ029
         z+Xw==
X-Gm-Message-State: AOJu0Ywo6WyoXpWwHZI14Nsx64rDdkUWP8dpPl3h27DaWmglOIp11qSU
	UzjcYyGHTeeDaEsygDlEpbmLrcCViWnhNc101LTNyoHVdAHin2mKKtm0NTdltfKS1iN6MZ5HoZb
	a3cPagOpGffT/APZMltmmasdTf33TGmE2WspZwsb4Ii8jWDtIgPgL/mlqQvVHzJ9yJxTnPQ==
X-Gm-Gg: AeBDies4LKO0A+050TBcP/SkEj8c1pDAxoKS9se+CV67lA7EnQTJhmWUDPa1+NtmU+I
	WngWrgbTO40xje6DUaGPousSnWBp8WXLe2bNBDxwqfipDUpC9AfPfzlTxh+6m6y9jdZRT/fKl5r
	Ii4lq98kgC+dSMiXziN3pScybQz2r6I25uzU+7cG3aYgB3YgApXWGMooiq71XfGEiNaz7c65X1x
	6CnQQV7//IUIdn/0cXOqctj7BpaUHvzJWWe6h+Eox42RC7BtjyCANibF8v4BSRLvC2mIncRqfHN
	Czd0t734edkNKW53y2T6T/Cwh8gt8oHMdWhK9qF9YpiWK4ZaGBTo9964AyqhSGmnNGDnY3NDtuC
	a1x+x5Ld3fjyXpjtFdX+e2qtNiT9EU/VQTkP2unqoKsO9kKF/XS/H1Y6hohmvCHpgHbTPlS1qi5
	b4ej1d4OrSvz2ruFXzamlCGnOz0zYmRg==
X-Received: by 2002:a17:90b:1a8d:b0:35f:b987:4dac with SMTP id 98e67ed59e1d1-361403fa894mr11911249a91.12.1776651729600;
        Sun, 19 Apr 2026 19:22:09 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8d:b0:35f:b987:4dac with SMTP id 98e67ed59e1d1-361403fa894mr11911243a91.12.1776651729112;
        Sun, 19 Apr 2026 19:22:09 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fb7118esm4336837a91.4.2026.04.19.19.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 19:22:08 -0700 (PDT)
Message-ID: <44c5e877-15eb-4a89-8498-328b77d27d0f@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 10:22:05 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ath11k: fix peer resolution on rx path when peer_id=0
To: Matthew Leach <matthew.leach@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20260417-ath11k-null-peerid-workaround-v3-1-d04302284486@collabora.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260417-ath11k-null-peerid-workaround-v3-1-d04302284486@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J46aKgnS c=1 sm=1 tr=0 ts=69e58dd2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=QX4gbG5DAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=EUspDBNiAAAA:8 a=H35CScFOu-zhalx1qioA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: Nlksd31O2o0Z96V2cRr-EJWp-pmaGhSR
X-Proofpoint-ORIG-GUID: Nlksd31O2o0Z96V2cRr-EJWp-pmaGhSR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyMSBTYWx0ZWRfX2zWd9UL3o/Dl
 lUyRiLvnFYHNYspGL+vOTsAsaEXffJFt7JFOesnzpLOasy7Yf+IO8EvPHrAXCEBTtkylM/REUw6
 J0+d2/GT0be1xceyK0KgoEmvTEYALVs5BMOTvZOifj8y9hVaPqwUmCYL22MuUJ7ObUBlQO+Zw3P
 1AHqcD2iq9psStq+AFXavA15kdklRsWemS5X6YgnA0eGXuApx48ovnzEoLvN764pIbcD9ugr2xg
 vQe5Zqwi9UZYtmacSE3ZpNT928aAyEN8Q953ypKAGXZIoq7EmPd2GaaEN11CntEMPvv6Azsl/9i
 qgDq9yIIXi8Hdf3Ks3EtPYhZI3KPzUs+RiWXf86D7ieqfw+ALiVQ7vaV0p9EOCNEFx6d+h2GEu1
 oEBOc4TMwh4wT9ExUys1kgb6fQU79IoJD13eD++h7ZCHoH2Us3XwZ/UxUnUvWlcAmP6IpD39v6p
 KbYDCMlS6av8dVPogBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200021
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34991-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,msgid.link:url];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7A62F42634D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/17/2026 7:07 PM, Matthew Leach wrote:
> It has been observed that on certain chipsets a peer can be assigned
> peer_id=0. For reception of non-aggregated MPDUs this is fine as
> ath11k_dp_rx_h_find_peer() has a fallback case where it locates the peer
> based upon the source MAC address. On an aggregated link, the mpdu_start
> header is only populated by hardware on the first sub-MSDU. This causes
> the peer resolution to be skipped for the subsequent MSDUs and the
> encryption type of these frames to be set to an incorrect value,
> resulting in these MSDUs being dropped by ieee80211.
> 
> ath11k_pci 0000:03:00.0: data rx skb 000000002f4b704d len 1534 peer xx:xx:xx:xx:xx:xx 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d1a fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 1 last_msdu 0
> ath11k_pci 0000:03:00.0: data rx skb 0000000038acd580 len 1534 peer (null) 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d00 fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 0 last_msdu 1
> 
> Remove the null peer_id checks in ath11k_dp_rx_h_find_peer() and
> ath11k_hal_rx_parse_mon_status_tlv(), allowing peers with an assigned ID
> of 0 to be resolved.
> 
> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
> ---
> Changes in v3:
> - Clarified that the mpdu_start header isn't populated by the h/w for
>   all sub-MSDUs in the commit message.
> - Fix second null-peer check in ath11k_hal_rx_parse_mon_status_tlv().
> - Link to v2: https://patch.msgid.link/20260415-ath11k-null-peerid-workaround-v2-1-2abae3bbac16@collabora.com
> 
> Changes in v2:
> 
> - Since peer_id=0 is a valid condition on some chips, remove the guard
>   that prevented the peer lookup.
> - Link to v1: https://patch.msgid.link/20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com
> 
> To: Jeff Johnson <jjohnson@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: ath11k@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c  | 3 +--
>  drivers/net/wireless/ath/ath11k/hal_rx.c | 5 +----
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 49d959b2e148..ff2c78a4e5f3 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2215,8 +2215,7 @@ ath11k_dp_rx_h_find_peer(struct ath11k_base *ab, struct sk_buff *msdu)
>  
>  	lockdep_assert_held(&ab->base_lock);
>  
> -	if (rxcb->peer_id)
> -		peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
> +	peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
>  
>  	if (peer)
>  		return peer;
> diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
> index 753bd93f0212..51e0840bc0d1 100644
> --- a/drivers/net/wireless/ath/ath11k/hal_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
> @@ -1467,11 +1467,8 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
>  	case HAL_RX_MPDU_START: {
>  		struct hal_rx_mpdu_info *mpdu_info =
>  				(struct hal_rx_mpdu_info *)tlv_data;
> -		u16 peer_id;
>  
> -		peer_id = ath11k_hal_rx_mpduinfo_get_peerid(ab, mpdu_info);
> -		if (peer_id)
> -			ppdu_info->peer_id = peer_id;
> +		ppdu_info->peer_id = ath11k_hal_rx_mpduinfo_get_peerid(ab, mpdu_info);
>  		break;
>  	}
>  	case HAL_RXPCU_PPDU_END_INFO: {
> 
> ---
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> change-id: 20260326-ath11k-null-peerid-workaround-625a129781b1
> 
> Best regards,
> --  
> Matt
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


