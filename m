Return-Path: <linux-wireless+bounces-31161-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFqMG4v/dmnzaAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31161-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 06:45:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D668436A
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 06:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A54A4300C01A
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 05:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA212253AB;
	Mon, 26 Jan 2026 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U/8sLtZs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fZE4hSB3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B22AF1D
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769406320; cv=none; b=uAgQUodBcBJzmxrMaDmysGsby+6jitiiM712rEDx7Yzqd09i7FfL57ZH2eYPCZTvEWZufJyJp5iHMJSTdE+bFL6cKMcSg2KjZa5l6sgGT0uHYZpVXT3J4Y8SmM6nMHwy1GvC7t8A+iwJ1s2B55MmURUjNGITYzD0IjsrDpM7vlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769406320; c=relaxed/simple;
	bh=0vyk4BeEhFan4kBjsTMElQwDGrupsEk9MhneSxl8JhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JK8QdDHArCtCOTbxxULzsGeLEEgrz7hBo3WIe2n1G/byQvhUhupd+yw7VCRZls6vtxRG2HlYNKZCDtNY/xN8mi4Y79PuP/w+TtVTcTyjssW3nrkpNpQx0GGefeOrqCNCHSzaSGFo40dbbQu5GP6mgmj6QkQSXEwZ2XMBVg7TJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U/8sLtZs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fZE4hSB3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PLhbMo808500
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 05:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E980NRlSWDqjUtTK2n3I5/m+bNTdIxQQ8hrwhq3KLJs=; b=U/8sLtZsntzeohGT
	AWvmDOyAGT6dVJROHZRjJhhaElaa2EBEc1XtOUzGZg/xSqRNGEds7bqorpzr72Uj
	pT4mg4BHTPcI6bWRlZfP5f3/KTaj7B75DxuXyB9+zJo8gWOc58DdyvlvFKR1tyeQ
	TmYI0eUCsl/p/dhRQu9Dz157awo93fM+IOK4+i2HlTgAObFiglEEJ8WUwgMvfBEF
	f52EOpe+nndeIq/NvW6rQFFmxhulsslOkrjURCXSUOSepg3mGnCH6CgxXRJl/zGM
	6Lzji7dPSgD1uuOwNOujxFRQmbSra+I/gmVL9Y3lDqmoIzMWg2abvxQXIg6N1Pad
	stVGxg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq9f3gja-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 05:45:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8234ea73bdeso532040b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 21:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769406317; x=1770011117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E980NRlSWDqjUtTK2n3I5/m+bNTdIxQQ8hrwhq3KLJs=;
        b=fZE4hSB3T8HsNISz4zlaacgA8OIVd8S4kuGIB/fDbBDMiUiosRnzJ2jdB6wdQY72jU
         XOnFvoiQHqh9+81i7z1i/OBxlnk7spF44buL4KtSkQrPTB3tPV9iHdw2xGavWm5rhFT3
         uPFur4UhWGApfuLlCT0EkuEY5J3dOqftN4PYn7C7w770IehFh780OmibqLZo4Fycunrn
         Sfml3ckw/HmV5YrcgiUgMZOKgyHYhgUoJBWZ5nKR8STXjyp7v/i3GglEnPXQ2Shtihaj
         uXdoZx+VYWjG8BXbrDQ8pseUmzsK1LwNchH5In3jwuFQQXqy4YYEcvBuk2FfY7AjpFiq
         z31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769406317; x=1770011117;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E980NRlSWDqjUtTK2n3I5/m+bNTdIxQQ8hrwhq3KLJs=;
        b=GEOIJSILvKqorx2QUoxHcnaVh6Ae2JXTWng/FrnchsdQeg9/T1i1eQwViZpKFrjQ9g
         5jEQdRMKstfCpVoc0/sxdXs8v6XHytyDf/Vwie/Gp1fUthew4CYjmrZ2BIY8k51zDQrp
         zGPNGQRUn+BeA+/4Pew6/avI/BOR8CmMDU0Do5fpiBNihWzL8qKCsdvyAKuS4Wp3pcvP
         xj8ArS07bVh/r1fKfKsnJsmvhcgvSesqSkDTfgdWSUVeCChkSBWlviKWGBUZu+sy9fz3
         hx9miAjNhiVRU6zPFc/sTHZrNxwPLVeIFV27aznVSQHmT+Gz3XG0rlfPsGxQXMlMJNyE
         IP9w==
X-Gm-Message-State: AOJu0YwajbB+yFW3zFtC0o3636ndPOxoSHcDO9fco5Bp4jRSVDTxprPP
	YPlHUbH91LL/9iD6Rd0uVLVAhEww7diaTjoTIDaZNZuH/NRROBKa4UeIMx29QO17xgJfVz9lF6I
	1dvkApJdetm2vRqf+OlkymFLMTfQEwP8owVsDwEDjr52wTtEU1N/0hKJcpiz0Mpl9yBLFKQ==
X-Gm-Gg: AZuq6aJ7HXCAyHVTMGAuPx1rlN2JfO3tNjYDQlD8a3jdugArPFoopT/0eUhLUEXyIIl
	K5rMqv2dDbmBvbfP9x4QHQhL16b5qrjdjwq1C1H2bN/dB2pCWc6I+gL2/xDk2RyWlNMJJ5HClt0
	5iN7aj5qwHPU+ICz9GdCkVmcbGgjfwfDSzYD9Z6KLF7Ka0XxFFKjAjg8ftUUergOSF+hxEYTOOm
	m3klBrUp/XN4DV7zCgWAVxHX2oC+g3GL0ppVFm4JfNLMxE/5JaHz0hpn7rRywzox+7Mog9nEj0y
	ZMI/w4o3ragSOyn6bj6QAKsl15naZ1KgbZPSr8GKuOrxA3dzbbJ+dONEtKaykRk+lo+71DbwPCd
	8ArEl3OxRrhmPQVSx5hSI3xkfnuo2QijQJkMWHTsg84NDfL4HC64Q+YX6FCCyTWSiAS6Ulug=
X-Received: by 2002:a05:6a00:6c85:b0:823:f51:192e with SMTP id d2e1a72fcca58-823412b5b1bmr3145656b3a.51.1769406317540;
        Sun, 25 Jan 2026 21:45:17 -0800 (PST)
X-Received: by 2002:a05:6a00:6c85:b0:823:f51:192e with SMTP id d2e1a72fcca58-823412b5b1bmr3145641b3a.51.1769406317071;
        Sun, 25 Jan 2026 21:45:17 -0800 (PST)
Received: from [10.133.33.199] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231877012csm8329122b3a.65.2026.01.25.21.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 21:45:16 -0800 (PST)
Message-ID: <ec1a3721-a17c-47dc-85d3-0e0b97004c2c@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 13:45:14 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Remove broken frequency range filtering
To: Saikiran <bjsaikiran@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
References: <20260123155750.6007-1-bjsaikiran@gmail.com>
 <20260123155750.6007-5-bjsaikiran@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260123155750.6007-5-bjsaikiran@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YLGSCBGx c=1 sm=1 tr=0 ts=6976ff6e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=YGz6NkLsH7gTjuWo1MwA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: ufQk3EhEzgC_zxvZDKLkudL0NaQUfW_4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA0OCBTYWx0ZWRfX/TeFT+vOkypE
 Fy7NDoh1SJq5kxjB1X3wV6bM5S13V9jDU+fkkGKyOuDeXcCc4P1+7xjoSXR+3wjv8FuC3Xja2Us
 Xee/O0BHaCTUYw9sYFKAfLAh0YCmUZit16xR6XUoK+7AX4v1djtou6D6pEEKsKyQaRwNePzdvO0
 BkmIm7FCHsC1mIJjEoDgmt1YeCtCDRCLIdTOvE7Z2fEVuPQD7a7Adgdfjjk+2uibBfvkF6NpYJp
 n4wwMNNVoff1ia1abE+6raslFoDVPOj0SYMhTypNAss8fyIKhUVAqRnXxuUv/FLJL6Jsbht+qpf
 ezammgDTDRUU/lbfxpClIqlINW/S44jQDr9QwHV75Gpf7VMkwRJAqYCAep5K8hSLQGWJ+nKA0m9
 Kl5+B5MuxbX8M8Cp7AMGQ7DKNwcENz/qla79SQLbNeDst2wy90vuLohalePdPjZVpje8xPG6PXZ
 +Q2rj+azMAeopZN5HcA==
X-Proofpoint-ORIG-GUID: ufQk3EhEzgC_zxvZDKLkudL0NaQUfW_4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260048
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31161-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B1D668436A
X-Rspamd-Action: no action



On 1/23/2026 11:57 PM, Saikiran wrote:
> Between kernel 6.16 and 6.17, ath12k added frequency range filtering in
> ath12k_reg_update_chan_list() that filters channels based on
> ar->freq_range.start_freq and ar->freq_range.end_freq.
> 
> However, these values are reset to 0 in ath12k_regd_update(), causing

Yes, it is reset at the first, but it get re-calculated later. See
ath12k_mac_update_freq_range() called in ath12k_regd_update().

> the filter to skip ALL channels:
>     if (channel_freq < 0 || channel_freq > 0)  // Always true when end_freq=0
>         continue;  // All channels skipped
> 
> This results in no channel list sent to firmware, causing 5 GHz Wi-Fi
> to stop working.
> 
> Fix by removing the broken frequency range filtering. The firmware
> itself handles frequency range restrictions based on hardware capabilities.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
> 
> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/reg.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
> index 2dfcef013277..2d9adc74ac6e 100644
> --- a/drivers/net/wireless/ath/ath12k/reg.c
> +++ b/drivers/net/wireless/ath/ath12k/reg.c
> @@ -153,12 +153,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
>  			if (bands[band]->channels[i].flags &
>  			    IEEE80211_CHAN_DISABLED)
>  				continue;
> -			/* Skip Channels that are not in current radio's range */
> -			if (bands[band]->channels[i].center_freq <
> -			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> -			    bands[band]->channels[i].center_freq >
> -			    KHZ_TO_MHZ(ar->freq_range.end_freq))
> -				continue;
>  
>  			num_channels++;
>  		}
> @@ -190,13 +184,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
>  			if (channel->flags & IEEE80211_CHAN_DISABLED)
>  				continue;
>  
> -			/* Skip Channels that are not in current radio's range */
> -			if (bands[band]->channels[i].center_freq <
> -			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
> -			    bands[band]->channels[i].center_freq >
> -			    KHZ_TO_MHZ(ar->freq_range.end_freq))
> -				continue;
> -
>  			/* TODO: Set to true/false based on some condition? */
>  			ch->allow_ht = true;
>  			ch->allow_vht = true;


