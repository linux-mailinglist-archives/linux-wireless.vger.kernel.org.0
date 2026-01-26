Return-Path: <linux-wireless+bounces-31160-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jhNnFSH7dmkAaAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31160-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 06:26:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9006F84287
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 06:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BDF1300D948
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 05:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEAC221DB3;
	Mon, 26 Jan 2026 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vby3EC9c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S6lQj78l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C321D3C5
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769405214; cv=none; b=DcVmUDPPhOCA/SocKwiQpltY6KYcVsllo5zwNfQOvFb+4pYPKPXswsL/rqVvUN8GhVXrFTYEQoCaQc7qiyVxAja/9Z0h94zVX94Adb30waHBFoJLbN9yDgSQHhEYUJK1Ez+pAtv6IZ2PliaD94BOK9xfxArTAQPptJM1T4Aqn6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769405214; c=relaxed/simple;
	bh=wUNwsPTqscIuVr+OIpfrzwx7HA4/fWS64ZeUdoN4sSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdLm5SHiqp6hzo+/pxBZxmm0GUO1WyseEHp2au0phz9/XQC0HSL/CBPSb5gFO7IUn85B6Nv2Hn2GXCU9riuSGUOuFPoVmgFkb3VACMXxPQUYhvXcnenkfKg4bQiIJzHUI8UtAJAHaey31Y4IPNTVtFFtMnWwQMhxK2JvGSW/okM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vby3EC9c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S6lQj78l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PKpm0k389525
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 05:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6vYUzOA09W+SEgh2BVxJbTTr4nm8xihIvRSOrdGLGTE=; b=Vby3EC9c1Em22Bf6
	ud0VeeUUVfn2rYCOEfputgjgVShXaVf9JTTAHdc3vJwIt+yk5QhO6Fz5yC26IKeg
	ihGodmL3DIT2Av8LERlG8EfrdrPfFWxaiM42d+pnhtst1RW1xV7SNfXPsUi6M9KO
	/3yER6juEpiRmx1oMY4SvMbxQje/Ly9tsnDqtr+gtS459BbSJ3LLM0EwMT+Qlt5q
	4W3GG0nEf6FSRFmosYnUh6UL1bw2cCEPuF3L8urk9Y+Af3bDtTMIVJQYwMy9mDGQ
	gbq10aPsio3EO65cTPN2mS3D8Ed0WXAABbtJ6Y40ocFdYgJkEirV7In4fP2sWkQe
	BmlUyQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq6uufcf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 05:26:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ed2so3226557a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 21:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769405211; x=1770010011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6vYUzOA09W+SEgh2BVxJbTTr4nm8xihIvRSOrdGLGTE=;
        b=S6lQj78ltR+Qn3g42B1djbJXhzoEgiNklNMMcIXT9py7+D5D3mOYJABmUIX6hZNOjT
         R75JL61FU8LHZ4qTYVFpH4sAGpa9mjHnjN9cdYHXysId52RVQlTf58IxDKpQ70Cw4vHu
         wqzON1U8yrr6zzH9bjV1e+6T3vlbCpx4/2o2AYI1QqaqsrvQISWoqhuAinKitrViTi82
         XBST8IGpHSlKay+q6A7T81C9Xa4S40yM30JkshYKw0DHChuSk2VQ3IqKZ774vMXwudns
         Nf4UW9atWy5ZjXoYvy6DkLyATOO0l7jNkWnxoOFbBjFK7xNt4deTCFWK2aPYJeVC+5pk
         zIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769405211; x=1770010011;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vYUzOA09W+SEgh2BVxJbTTr4nm8xihIvRSOrdGLGTE=;
        b=MQX71Ag+JkXGOCaP0g8anJd+U5NL1d7XEki7AReXkwptGmLsZwXE92iA8qpDbiNS+C
         uTMuH/0+7u6qQoha1YIlUxqxc3/WLVuibq4dsUICvalbqabYpnmZG8mAPut8Ng2pWOL0
         kOBNbwd+k11S41dyaHy1KcU/EBegZOjVBNdQFoXsXw/PfpepLMsCRyQryl55mniyFluh
         tIpfqIDZk7O2nOe6AV75VIADt6XLcgLt1skyOungnmcHlcwHFPWVeWmWc90lllcGKTeT
         d2DPR2NI0mj0aidb2uoYqXfn07LLVS+YEfabFsOash7nycV3ru1JlsopX0Tne0L9WOh/
         aXqQ==
X-Gm-Message-State: AOJu0Yw0dz54T6P1iMnt+nzgcAPviGFVVEHMd0CRPYnOQ8WPVjvkFvex
	JeU8NXVfA1RTsIA/m8gGRK+yLGNjjMFRJTiKBxX0hlcmWpY3PuOTUdpFX8BdBwqeI7ZLvNc2bo1
	lROE0SKBw2FLVguBF0j1ig17za/qTyO4i1cnG0P990IBM+DJakO1tnoZKHDdi3U2tf1mKCQ==
X-Gm-Gg: AZuq6aLwi7Ve0Gn1FBtVy/sz0CR+pNAmBJGrIHA13juu6ZcKhPBfrtoQnjTrdUZinTx
	P3Swsl9Vz5hA8s5Y2RUMjxgMqzPTdo/6A24OgjWHDqyLzHZ6DFa+YsCbYknttyhNVhv3J2kG2jG
	1SFzAuimlUg3Dnm/pJbA7scNGbdx+mz6FZP52NgGTnKCYmuLth7QaVTu1ppbQ+wBm08Sj+udIml
	HTEQJPV9bfNir96ssBK+HPcukhPDSAp+ZSFIJyyy7XTGbTPfAeAP3G19CJ9cDJIZSF6UgNmiopS
	e2tCBOKV/tpVR01R+YO7h9JrQ8k7wbti+yJ+kuEk/53RbX+u7qn6sxLimPOurKcivvmmcknwZN5
	+gHB2k+wBnrFJqppIhQUE9NBDcATbRhvT/sYV25oELMeMwMRBRdLeEUy+Xo/mY1bTi8YcLps=
X-Received: by 2002:a17:90b:3f88:b0:34c:c514:ee1f with SMTP id 98e67ed59e1d1-353c40e95aamr2609651a91.11.1769405211248;
        Sun, 25 Jan 2026 21:26:51 -0800 (PST)
X-Received: by 2002:a17:90b:3f88:b0:34c:c514:ee1f with SMTP id 98e67ed59e1d1-353c40e95aamr2609638a91.11.1769405210716;
        Sun, 25 Jan 2026 21:26:50 -0800 (PST)
Received: from [10.133.33.199] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35335205a2fsm10672411a91.2.2026.01.25.21.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 21:26:50 -0800 (PST)
Message-ID: <e3892648-947a-48df-a23f-b4648f57b118@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 13:26:47 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Initialize regulatory frequency ranges to
 avoid filtering all channels
To: Saikiran <bjsaikiran@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
References: <20260123155750.6007-1-bjsaikiran@gmail.com>
 <20260123155750.6007-3-bjsaikiran@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260123155750.6007-3-bjsaikiran@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA0NCBTYWx0ZWRfXywKaMuXkFDVA
 Asvdzc/z+OqNa39BP+MqlKXZ18B5z9Qj5rQWwX9inlRAdDLUAYxsvfovLMcWbnoR5xhCSGdtEei
 y+QPkvLwiQm5u2YTlPSRy4Wz6iB4CdKlSShCmdDEvMjXPf8ZlIa+r6MfHe0QmWDyKKDoIYmQZLs
 9IWHYiehCZz7SE2t0QrzzKxhlPZ+0H+doxnb4KsGKa8WloJbABHEPFZTFxMsv7CnF9yW+KWKYY/
 XcgjFSAKk91s/buRBTVEse7iVOZc9VMGDhsob6pLzvOgfyb7IrMWLjjYGszs0vuQw1CUUKLfOo7
 shs9BmV+j7QSG+gLA1MGEpW4SLG0BeXbjsLnU33XEcMFbgIM4O86BzLHqQh2NJdbS7wt9ejKIEm
 b2UdgNtkTZAHJaLgcB4FK1uEIBsT00HUytbwjcu5Rq4XRc4O6WsTdb5mCHU/DDa+5zaPRcfGkUZ
 dqtODyvmvomiUOfSDEA==
X-Authority-Analysis: v=2.4 cv=UqRu9uwB c=1 sm=1 tr=0 ts=6976fb1b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=7bdGKr1Mna8dyHvEU74A:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: V5gEmfFsfYiYackg4mSVCyuhrqilK06G
X-Proofpoint-GUID: V5gEmfFsfYiYackg4mSVCyuhrqilK06G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601260044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31160-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9006F84287
X-Rspamd-Action: no action



On 1/23/2026 11:57 PM, Saikiran wrote:
> Commit 657b0c72c4ad ("wifi: ath12k: Fix frequency range in driver")
> added reg_freq_2ghz/5ghz/6ghz structures to intersect regulatory
> frequency ranges with hardware capabilities. However, these structures
> are never initialized for devices with self-managed regulatory (like
> WCN7850).
> 
> The WCN7850 firmware manages its own regulatory domain and never calls
> ath12k_reg_build_regd() which updates these structures. This leaves
> them at {0, 0}, causing this logic in mac.c:

No. That function indeed would be called for WCN7850.

> 
>   freq_high = min(reg_cap->high_5ghz_chan, ab->reg_freq_5ghz.end_freq);
>   // freq_high = min(6000MHz, 0) = 0
> 
> Result: ALL 5GHz channels are filtered out and 5GHz WiFi is broken.
> 
> Fix: Initialize reg_freq_* structures to full frequency ranges in
> ath12k_core_alloc(). For devices with proper regulatory domain
> updates, these will be overwritten by ath12k_reg_build_regd().
> For WCN7850 with self-managed regulatory, these defaults allow
> channels to work.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302
> Fixes: 657b0c72c4ad ("wifi: ath12k: Fix frequency range in driver")
> 
> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 4121dd14bbcc..99c26ba01304 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -2290,6 +2290,19 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>  	ab->qmi.num_radios = U8_MAX;
>  	ab->single_chip_mlo_support = false;
>  
> +	/* Initialize regulatory frequency ranges to full range.
> +	 * These will be updated by ath12k_reg_build_regd() when
> +	 * regulatory domain is set. For WCN7850 with self-managed
> +	 * regulatory, firmware doesn't call reg_build_regd so we
> +	 * need sane defaults to avoid filtering out all channels.
> +	 */
> +	ab->reg_freq_2ghz.start_freq = 2312000; /* 2.312 GHz */
> +	ab->reg_freq_2ghz.end_freq = 2732000;   /* 2.732 GHz */
> +	ab->reg_freq_5ghz.start_freq = 5150000; /* 5.150 GHz */
> +	ab->reg_freq_5ghz.end_freq = 5945000;   /* 5.945 GHz */
> +	ab->reg_freq_6ghz.start_freq = 5945000; /* 5.945 GHz */
> +	ab->reg_freq_6ghz.end_freq = 7125000;   /* 7.125 GHz */
> +
>  	/* Device index used to identify the devices in a group.
>  	 *
>  	 * In Intra-device MLO, only one device present in a group,


