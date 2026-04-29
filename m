Return-Path: <linux-wireless+bounces-35574-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAmtG2218WmjjwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35574-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 09:38:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DBE490921
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 09:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7A9C30021E6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DDE37E30F;
	Wed, 29 Apr 2026 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nDS20lTU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KHgu6PGa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EDC3A545A
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448299; cv=none; b=GIh/6LhmzeZ1JOCjbwxgrEwXO+kDA/aKFceLeB7Yv+qv25DUMVFwL20mm2KfaTCravy04ZGHiis6H5FtLHr1db6ChMBMU8IGp5pNnR4U11FlTSFiDW1n0XcL2kwKqbwmDm7dz4uG8NIAZGXpzcmp7DqjnXZ+EbY4S0OQfQLT2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448299; c=relaxed/simple;
	bh=rDq+zxbBhHGGNqc7oKTk0T2pHf9jkA9C58/PiWCh6Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRamAMVlb08SmpQm3cfLXaOdngbQpxY5h4KDYgbhlcpPznJ3yC/bOxPrzApCk63hNLgrZd41fdtFC1d90idt9zUKeWEGM8HbRH5pcCdGw4MDHcTGSNo8tvIzrfybGuhrQStZnvLd7AfEJadBWi2rxXKDaH8yZS1xCUc+QPeMyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nDS20lTU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KHgu6PGa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T56EFI3347481
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DXVaAU1x/VRaf2sNF3EoAOzNFxD9AonZN9toVdN7ibg=; b=nDS20lTULIkN0Q9b
	z1TAE6+NrHwNlwY1YHn+YfRCr/3Bcmz5uwOtoRIGXx/wOjS0+gF99u/TXmZ2X1Fg
	sdCxRuK+RHhP7g/pvMSbXpeHFN0C+oP9JSu1m2ooKj4gfsKb3I3fQ2lytFEta02L
	zpFd/Fnp2yB26NExg9RjzO+Cc3M5zRq2ZrSbq1rs9dqLmzHt9vrJnwBjtpAsISJn
	Nbb4fXg2QxlcCredh8hovnX00oPMuwjWcjVI1/VL4zeqBXTrcsicaRgOu/U973Lj
	JzbrrUzvaKcfEch9AkRpsyACJlpdxIRmKAJ3fwJ63qh9kZPm8BXhwTSEKaA7V4GX
	blfKQQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4t82v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:38:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so309447a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 00:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777448295; x=1778053095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXVaAU1x/VRaf2sNF3EoAOzNFxD9AonZN9toVdN7ibg=;
        b=KHgu6PGajuTtCzBIIe0qZWWaJYf/7U/ud2rH1c18UrMj7x/po/KH69xARNnPJcSmQH
         kUCYB0cVqxygPYssBK9NVKn2oUN3R0dEhIrnZnWKWzm4QpEnWvD/jsv+WjdGGdzGyjPF
         Eyt4Bn+VYU47TaVzcDXkEGqsp5gbH2/503kHvqND+dKgwMLdXTLspOQw+c7L3f5A4AAn
         XFjVCHedE4X/QXWWArd/ifE5VoJHS0fdMyF1KuMJV4TQRYdbns+4HNUWzdW1aDhhJfRH
         yrd8y4MV3mqG0ubwB23Z9te+UZ4JRB9BDJyn4W4Hsc6EjeehRayi+quiAg75/VKFI9rs
         CwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777448295; x=1778053095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXVaAU1x/VRaf2sNF3EoAOzNFxD9AonZN9toVdN7ibg=;
        b=Trthq2z8PFH4/0SlJ5zh980iBxCWOLRd8DrO50G/P4KIBBkb8GXi1AdNfIdO95ONxu
         LwqMJVQxITjlOu5FTkvueK31vW0RRUnukwhUQeWjEIU8zyYeFSPrJSAgBFr+Y36yGLwD
         qHfoR6ElDuc7L2TZqGQ+TSAdEE0oRVMluCH3gWMBKI3jr9M+uazLqWi94kEDkgpKbWIX
         rzrsiAMv53VPlI3fPMPc2ztl9njn2tB+IsUd0sqEUySG/vQ8nFOm8gAfb0X+WOgPxZaB
         OoPSmJFTTw0X+mQ6DDPweeUpJRikMdi9OzkGdrHEhr8H0teRkRJ2sEaM0NzqKbgiCfyJ
         7hBg==
X-Forwarded-Encrypted: i=1; AFNElJ8kBkAlxct+IWshSf2Tu5iM9zfw7STfxGuV9YkQoFhgOrjxI4jjmnTlpzdgZsj4F5XEEsyJetAVVZ2Jgw8t+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YykiOPY0mSOUxX3UOn9lpzQb+5T3CzKhP41YR0d6H/oK6zsku2T
	1D3VTYOLnhytP7bmM9ZyZgJGhCsyTPJizRRXRAwyc/SAjqxtS2KaWOeufuB5lv9XqHIonDKTVyQ
	pfhu8HC7+KrIpBmuUwomtTGB3bNvplCBmf59TsTmtNcuuNjapiPbm+BOh1TXA9dux28EvKg==
X-Gm-Gg: AeBDievFHaPCuyA68cV2R+x8B6SNuvNRBEXE/T+9MY2ucc9uvTlHNc/o/QpJTew2pqA
	yEIZwLJ7grPUfH8ZfWGbwi9ZHssYOlhG8TVugQfESrOpILNInuX5AlkEjZYfYb5T69ReLpEsAbD
	MaL+PcT4vkCvnJyf1I7q7b/W1m6snpb0+fZIFfZadZM8P9qk/dzViNPqXOrevYqOxDZonNOc5kW
	19yiHQM3OLlougGGxJlQbolnW9V/vcw/lbF0R431xsxzOwQM5A6BLTzzVnbSpkzbFeZdWUfunoj
	eK7dkMBqdh+zifeZDGKMSSBtmg2BQNK6fahf6hJsGZhpczp6UA4c0/QeSgomiNkLvEJrmQ8kL1R
	IDdZIJpRlnFypkqIUR13IkqpWgrbQ+Dl0Pex5vCwz6heVBguAqRpGCSlONJHfEmXVSzRYsr5n
X-Received: by 2002:a05:6a00:1950:b0:82c:6b16:c894 with SMTP id d2e1a72fcca58-834eb51b962mr1847889b3a.20.1777448295411;
        Wed, 29 Apr 2026 00:38:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:1950:b0:82c:6b16:c894 with SMTP id d2e1a72fcca58-834eb51b962mr1847855b3a.20.1777448294872;
        Wed, 29 Apr 2026 00:38:14 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed6debe4sm1089895b3a.36.2026.04.29.00.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 00:38:14 -0700 (PDT)
Message-ID: <525f1330-eed2-43ed-a274-ead57b928ae9@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 13:08:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: ath11k: fix monitor mode frame length by
 using correct descriptor size
To: Joshua Klinesmith <joshuaklinesmith@gmail.com>,
        linux-wireless@vger.kernel.org
Cc: ath11k@lists.infradead.org
References: <20260407024836.53871-1-joshuaklinesmith@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260407024836.53871-1-joshuaklinesmith@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA3NCBTYWx0ZWRfXz2z8XvYIcHWS
 zMETm1MV8mGu01K4FngEeM3f8s2CpSHhBS+HXH8zGPJL06w7UV5aAAFkMizz0MTA9441E3Bt4th
 NqZV5yqcuDxRUKpPvjl2sfs5wLKjfvbV/5hs81ZT1EYldGrTbI32qQxAfPXXK3MIX3ShnTm1Uz6
 4c3hUD4oRdTIoxl34RkCaocxWProLeDVMtBMhRfAa7LzXEFwYkWXSaww+7MDXIImrdRq9QQ9ZOv
 zp4m/gtefU6oGuwTvPXAKQLHChmlC0RgSnYeCg5P/2D+zP+oJMtMofuHTR2PbBxQGB4Fy/vanVR
 604yQA3nAZZgZZ9CaTTKc8qyHNuX3fP+WCCnymJtZaTztvVa8o6oKZp0z94GlUy4bsJZ8wR7zLy
 FDaF9pTlkNnRKPcY/h4p7KBtHvUpwlzaPpmnM001QZrrlGQXzQQqTtiTbOkclDtbXutY1Dja9uu
 d1eC0eFhLJjs39wC52Q==
X-Proofpoint-GUID: Kq0uDqaTRS7ZsMLReokTexsBWmq2jDXZ
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f1b568 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4T2M7ptt_QytPgkP2eEA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Kq0uDqaTRS7ZsMLReokTexsBWmq2jDXZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290074
X-Rspamd-Queue-Id: D1DBE490921
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35574-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/7/2026 8:18 AM, Joshua Klinesmith wrote:
> The monitor mode RX path in ath11k_dp_rx_mon_mpdu_pop() and
> ath11k_dp_rx_full_mon_mpdu_pop() uses sizeof(struct hal_rx_desc) to
> compute the packet buffer offset. This is the size of the union of all
> chip-specific descriptors (the maximum), not the actual descriptor size
> for the running chip. The later ath11k_dp_rx_msdus_set_payload() then
> strips only hw_params.hal_desc_sz bytes (the chip-specific size) from
> the front of the skb.
> 
> On IPQ8074 and QCN9074, sizeof(struct hal_rx_desc) is 392 but
> hal_desc_sz is 384, leaving 8 extra bytes of descriptor data at the
> end of every monitor mode frame delivered to userspace. On WCN6855 the
> sizes happen to match so the bug is not visible.
> 
> The same mismatch in ath11k_dp_mon_set_frag_len() causes incorrect
> fragment length calculation for multi-buffer MSDUs, under-counting
> intermediate fragments by 8 bytes and over-counting the last fragment.
> 
> Fix by using ar->ab->hw_params.hal_desc_sz consistently in both
> monitor mpdu_pop functions and passing it through to set_frag_len.

It would be useful to add a Tested-on: tag if this was validated on
affected hardware, as suggested in the ath11k submission guidelines.

> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")

Since the full_mon side was added later by 7e2ea2e94704, it may be worth 
adding that as a second Fixes: tag for completeness.

> Link: https://github.com/openwrt/openwrt/issues/16183
> Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
> ---
>   drivers/net/wireless/ath/ath11k/dp_rx.c | 27 ++++++++++++++-----------
>   1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 85defe11750d..c86ffc203f15 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -4511,10 +4511,11 @@ int ath11k_dp_rx_pdev_alloc(struct ath11k_base *ab, int mac_id)
>   	return 0;
>   }
>   
> -static void ath11k_dp_mon_set_frag_len(u32 *total_len, u32 *frag_len)
> +static void ath11k_dp_mon_set_frag_len(u32 *total_len, u32 *frag_len,
> +				       u32 hal_desc_sz)
>   {
> -	if (*total_len >= (DP_RX_BUFFER_SIZE - sizeof(struct hal_rx_desc))) {
> -		*frag_len = DP_RX_BUFFER_SIZE - sizeof(struct hal_rx_desc);
> +	if (*total_len >= (DP_RX_BUFFER_SIZE - hal_desc_sz)) {
> +		*frag_len = DP_RX_BUFFER_SIZE - hal_desc_sz;
>   		*total_len -= *frag_len;
>   	} else {
>   		*frag_len = *total_len;
> @@ -4658,19 +4659,19 @@ static u32 ath11k_dp_rx_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id,
>   
>   static void ath11k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
>   				      bool *is_frag, u32 *total_len,
> -				      u32 *frag_len, u32 *msdu_cnt)
> +				      u32 *frag_len, u32 *msdu_cnt,
> +				      u32 hal_desc_sz)
>   {
>   	if (info->msdu_flags & RX_MSDU_DESC_INFO0_MSDU_CONTINUATION) {
>   		if (!*is_frag) {
>   			*total_len = info->msdu_len;
>   			*is_frag = true;
>   		}
> -		ath11k_dp_mon_set_frag_len(total_len,
> -					   frag_len);
> +		ath11k_dp_mon_set_frag_len(total_len, frag_len, hal_desc_sz);
>   	} else {
>   		if (*is_frag) {
> -			ath11k_dp_mon_set_frag_len(total_len,
> -						   frag_len);
> +			ath11k_dp_mon_set_frag_len(total_len, frag_len,
> +						   hal_desc_sz);
>   		} else {
>   			*frag_len = info->msdu_len;
>   		}
> @@ -4792,7 +4793,7 @@ u32 ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
>   
>   			rx_desc = (struct hal_rx_desc *)msdu->data;
>   
> -			rx_pkt_offset = sizeof(struct hal_rx_desc);
> +			rx_pkt_offset = ar->ab->hw_params.hal_desc_sz;
>   			l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, rx_desc);
>   
>   			if (is_first_msdu) {
> @@ -4823,7 +4824,8 @@ u32 ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
>   			}
>   			ath11k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
>   						  &is_frag, &total_len,
> -						  &frag_len, &msdu_cnt);
> +						  &frag_len, &msdu_cnt,
> +						  rx_pkt_offset);
>   			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;
>   
>   			ath11k_dp_pkt_set_pktlen(msdu, rx_buf_size);
> @@ -5424,7 +5426,7 @@ ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
>   
>   			rx_desc = (struct hal_rx_desc *)msdu->data;
>   
> -			rx_pkt_offset = sizeof(struct hal_rx_desc);
> +			rx_pkt_offset = ar->ab->hw_params.hal_desc_sz;
>   			l2_hdr_offset = ath11k_dp_rx_h_msdu_end_l3pad(ar->ab, rx_desc);
>   
>   			if (is_first_msdu) {
> @@ -5439,7 +5441,8 @@ ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
>   
>   			ath11k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
>   						  &is_frag, &total_len,
> -						  &frag_len, &msdu_cnt);
> +						  &frag_len, &msdu_cnt,
> +						  rx_pkt_offset);
>   
>   			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;
>   

The code change itself looks correct to me.

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>



