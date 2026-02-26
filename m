Return-Path: <linux-wireless+bounces-32190-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA2CF5Cmn2mHdAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32190-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 02:49:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A116A19FEF4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 02:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA0353010DA2
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 01:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82B83624DB;
	Thu, 26 Feb 2026 01:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RDOzlmTe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FBM+CYsl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7556A339868
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 01:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070499; cv=none; b=NJ5zTkbjPl4ub11WfzdMJ8tO08k9etQcPcMd7i+9D94h4Y6Tljy9E1YA/kHzbS3OADJ3WcVmw1zAKNPfAP5HloBFM82a7RtxRPXhp1+B7BE3DNUeBC8kfLl38XJDmkYIKAmCl51JK0dfRaZm9yQdUYtE/YTniZ+qzpUH5VSLJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070499; c=relaxed/simple;
	bh=LiO3glrcw44IOecKUikA742Sy1wB5j5l6N88i+plXvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOE3IASEl5Lo4aTzIt/jyEDFODef/iPrAY4JjuR9qfFjvlE6BkLaQBkbuGDo9ajL0BDGwkBfycJAJTvv9UXYSM4c6CJS8/aKWH1vv2No2xbl8nwVu6FJ87EDiGQuKNglaYxERw6BolklqB18h+eycvAgA4cR99a2gIbFoZelIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RDOzlmTe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FBM+CYsl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PH3p1c1196101
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 01:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rl1QbDI2+JWHspZXnzLzk/O8BOFPU/eDoUansuFH5dI=; b=RDOzlmTedvUDGExE
	ILHmazNwAggxV1LVn+Cp0Vse7glxIS8Fbq4dPnQLkzRI3/dekwT+bR5y4kcpawMZ
	ShCr6HQNs9POIjLg8fSNI14EOh+BIdm22dvPYRDtTSsWwjpc5pZVGkRlp/lo3lMK
	0bMgTjPbsvxHmor9L5aoutjGIIW02MTzR2/Gt7V3KDT5MWeBeZ5XTUIKGDETC8Tl
	Fyfq+hr2uIgefOApeOarMISu7CxZ+WNZcC2FkPG/95eV3NLu8O4WTZvYsbtsKm1l
	4d/7hMu3fhsieA6LqAjdHUAmIskE4OeO5iBDHTuaV4rFfN95Snxc/ZDx6QpnoO98
	2zm86Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj559haqr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 01:48:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-358f4ed4eceso202240a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 17:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772070495; x=1772675295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rl1QbDI2+JWHspZXnzLzk/O8BOFPU/eDoUansuFH5dI=;
        b=FBM+CYslMQR1aWTjIjecTPFu+Ddi47oioQxcITx/2n4fKemDyQxYfZPqW/epNYdmf1
         axcR3o4msLUXZmXXaUPIfCCqyC0Ajm1xezWZbTZe8zvznl5u4viAlVKTGq7AYXPYne4G
         HMiV90s1SG2+XnfYbHXE7PDhKn/vSvF15BUlLF16Bn43sY6r7taUBrnz3oqm1a0nhUol
         X/JY/AQy5hY8xmQosvDpejCUIIsk8riEZAyh95+BfrGqQtIuGihEYGffddAakPWlP2BR
         pDs0mUXNgT0rZjHjH6UFAU/3UIasCH5RgOrrpQQy671kPl8rf9DOxHhfJOoAeSc87CRQ
         EfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772070495; x=1772675295;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rl1QbDI2+JWHspZXnzLzk/O8BOFPU/eDoUansuFH5dI=;
        b=w3okXBHT9Q75h/ChZb+COqYAQqAiHQIEY0/wF55SiI/hptmGLsY2Tj0Smjsl/Tai23
         8kj8pKGx/JrdHbP+IR2FNuN5/DNXl3u1BnTpJY5Alf/bU/ZMpU9UFRf6AX5e/FM+Ogc3
         LTv5AsHhP7Eu84Zq9JMCtNmhRLutgMSx15TSeqlVbCLZtLm4gUs0hRhG0HB0uCyXgqVy
         9Lq8Qg2PY+nj744DapCyUghd1X1QrP4qQr9IB8NkcJIIAbVHF8odVoqJYip3zwdBmAQq
         oqT5mF9xsj2ebwkbtZLqN73rP5Yr+SBQfglZxSbZnosPawPMkLIDTyBJdHxhwweroN7C
         8lCw==
X-Gm-Message-State: AOJu0YxKdTsbPoj0LQdenv5446s429B6Ix/4g5TUYWc4BM9sV9l302lT
	87jwaA/TXlZNHx3BpIPGxVdK4cPcEpKnHDA4vc4YLInE5bmTF1/keZBi+jqQU+6ODmgk7z6dsR6
	B67U+Yo/X/wmBeT/dOcvRTjr3pCVmfAvUEhdavngzjv8SyZLjL4WdQTdPYlx5PqBibkxqog==
X-Gm-Gg: ATEYQzyQ71Uv1HPt/1YQMOcjZsRj50UJv5HIps+3/1Ro5UJk9PlqPns9jq9Ph9PRCgx
	VrkS8G8lyxReT/K6kZGDOsqAKbpZpjlEJ+icm3GTE+VZOrezmSKBh60XLooSZqNsNu8gvz1njbI
	PwprIWeASSUeP/sTYCToCRO7wDl/MeBuVlxJUrT0lP4B6QI7XaqsqCUXBX9smRZbq+ACFXPSc6w
	LDHlhaSnCAcmqOGteCQXblhCl6ZICYwFQY+cuLBTFo+r14HwLwzZl9uo/0kHv+bKwmwyAL8HL2t
	M/GYCk+GdCC54FGC+jJ8z+C1OXSleN6xNCaaqNjcoIU91ybDiQtf0zq70WqGObIbx8ZtQzQZBLx
	R6T36ABka7XR54hrWDwk+9WSP6azLvwEJcqCDIPpmAKVDrTarXSL3/cWzcqW+o0yyGEw0ciwr41
	RxEzunM4Q9N9NN1nLUs2w=
X-Received: by 2002:a05:6a20:2d0e:b0:395:3677:675a with SMTP id adf61e73a8af0-395b48da4e4mr707470637.35.1772070494513;
        Wed, 25 Feb 2026 17:48:14 -0800 (PST)
X-Received: by 2002:a05:6a20:2d0e:b0:395:3677:675a with SMTP id adf61e73a8af0-395b48da4e4mr707434637.35.1772070493751;
        Wed, 25 Feb 2026 17:48:13 -0800 (PST)
Received: from [10.133.33.106] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa3756dbsm290210a12.0.2026.02.25.17.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 17:48:13 -0800 (PST)
Message-ID: <eca60324-aed3-4c97-a8ea-14aaf910543c@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 09:48:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix legacy rate mapping for
 monitor mode capture
To: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <praneesh.p@oss.qualcomm.com>
References: <20260209054924.2713072-1-thiraviyam.mariyappan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260209054924.2713072-1-thiraviyam.mariyappan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZxfGiZuHOK0Rx4_4uT__VBaDfAigr8nI
X-Proofpoint-GUID: ZxfGiZuHOK0Rx4_4uT__VBaDfAigr8nI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAxMyBTYWx0ZWRfX5Lnv3/lV5G7C
 2yvz3QWcjLLJRD6vbdRbIvsxg3s4LEU5eprhxGixx2yw5uVa1XPvXlQ+NT9kefoDVWbDEgOuuNV
 J73bo63rniumZ3LIRmhWGlFZX5pwYnjEvcVZY/uwtg/NqTxVGOOW3IBhazPXgAdlVZQu3cODKpI
 OussDo6G6HmUlJjtLjLwjDIlDuuTnqI0zId09Sprg74Rgd7F3dXVi+NHfUPm0YNsi/7kn/+Ppym
 oIIlvL33K6KZM4LtPDuDNjfDHuYWV8g03OMQqbUUjSdup5lzIpVl4vDx/JqPYGraMxkbU4BnxnC
 oV1fYsPz0TscRM1aBkfQZSVJAjeAew3gIP+lrl17SmrgqIzmMUq/D1kPY5vAg8mtGFD5+KsORlV
 KHJW/2aTb2beRxi5/PsbVeQP6WxUOOyMjLByTw6s99OGXIDcYHjq/cRQz2n3RzrbK97Ad+K6vTb
 4IwWW1kyktceJSfCtvg==
X-Authority-Analysis: v=2.4 cv=TcybdBQh c=1 sm=1 tr=0 ts=699fa65f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Xiczk5uq6A01BK9_cRwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260013
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32190-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: A116A19FEF4
X-Rspamd-Action: no action



On 2/9/2026 1:49 PM, Thiraviyam Mariyappan wrote:
> From: P Praneesh <praneesh.p@oss.qualcomm.com>
> 
> The current implementation incorrectly reports legacy CCK and OFDM rates
> in monitor mode radiotap headers. The rate field displays wrong values,
> for example showing 11 Mbps when the actual rate is 1 Mbps. This occurs
> because the HAL layer uses a unified enum for both CCK and OFDM rates
> without distinguishing between long/short preamble variants and proper
> rate mapping to hardware rate indices.
> 
> The root cause is threefold:
> 
> 1. The hal_rx_legacy_rate enum conflates CCK and OFDM rates into a
>    single enumeration, making it impossible to differentiate between
>    802.11b CCK rates (with long/short preamble variants) and 802.11a/g
>    OFDM rates.
> 
> 2. The L-SIG-B parsing function maps hardware rate values to the wrong
>    enum values. For CCK rates, it incorrectly combines long and short
>    preamble cases (e.g., cases 2 and 5 both map to 2 Mbps), losing
>    preamble information critical for proper rate identification.
> 
> 3. The mac layer's rate-to-index conversion function does not properly
>    handle the precedence between long preamble, short preamble, and
>    OFDM rates when matching hardware rate values.
> 
> Split the hal_rx_legacy_rate enum into two separate enumerations:
> hal_rx_legacy_rate for CCK rates with explicit long preamble (LP) and
> short preamble (SP) variants, and hal_rx_legacy_rates_ofdm for OFDM
> rates. This separation allows proper identification of rate types and
> preamble modes.
> 
> Introduce a new mapping ath12k_wifi7_hal_mon_map_legacy_rate_to_hw_rate()
> that converts HAL CCK rate enums to hardware rate indices defined in
> ath12k_hw_rate_cck. This ensures the rate field in ppdu_info contains
> the correct hardware rate index that matches the mac layer's expectations.
> 
> Update the L-SIG-B parsing to map each hardware rate value (1-7) to its
> corresponding CCK rate enum with proper preamble designation:
> - Cases 1-4: Long preamble (1, 2, 5.5, 11 Mbps)
> - Cases 5-7: Short preamble (2, 5.5, 11 Mbps)
> 
> Update the L-SIG-A parsing to use the new OFDM-specific enum values,
> maintaining the existing rate mapping for 802.11a/g OFDM rates.
> 
> Refactor the mac layer's ath12k_mac_hw_rate_to_idx() function to
> implement proper matching precedence:
> 1. First match OFDM rates using the IEEE80211_RATE_MANDATORY_A flag
> 2. Then match CCK short preamble rates
> 3. Finally match CCK long preamble rates as fallback
> 
> Add helper macros ATH12K_MAC_RATE_A_M and ATH12K_MAC_RATE_B to improve
> readability of the rate table initialization and ensure the mandatory
> flag is set for OFDM rates.
> 
> This fix ensures monitor mode captures display accurate rate information
> in the radiotap header, correctly distinguishing between 1 Mbps and
> 11 Mbps, and properly identifying preamble types for CCK rates.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
> Signed-off-by: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/hal.h         | 31 +++++---
>  drivers/net/wireless/ath/ath12k/mac.c         | 51 +++++++------
>  .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 76 +++++++++++++++----
>  3 files changed, 108 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
> index 43e3880f8257..bf4f7dbae866 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.h
> +++ b/drivers/net/wireless/ath/ath12k/hal.h
> @@ -268,21 +268,28 @@ enum hal_rx_reception_type {
>  };
>  
>  enum hal_rx_legacy_rate {
> -	HAL_RX_LEGACY_RATE_1_MBPS,
> -	HAL_RX_LEGACY_RATE_2_MBPS,
> -	HAL_RX_LEGACY_RATE_5_5_MBPS,
> -	HAL_RX_LEGACY_RATE_6_MBPS,
> -	HAL_RX_LEGACY_RATE_9_MBPS,
> -	HAL_RX_LEGACY_RATE_11_MBPS,
> -	HAL_RX_LEGACY_RATE_12_MBPS,
> -	HAL_RX_LEGACY_RATE_18_MBPS,
> -	HAL_RX_LEGACY_RATE_24_MBPS,
> -	HAL_RX_LEGACY_RATE_36_MBPS,
> -	HAL_RX_LEGACY_RATE_48_MBPS,
> -	HAL_RX_LEGACY_RATE_54_MBPS,
> +	HAL_RX_LEGACY_RATE_LP_1_MBPS,
> +	HAL_RX_LEGACY_RATE_LP_2_MBPS,
> +	HAL_RX_LEGACY_RATE_LP_5_5_MBPS,
> +	HAL_RX_LEGACY_RATE_LP_11_MBPS,
> +	HAL_RX_LEGACY_RATE_SP_2_MBPS,
> +	HAL_RX_LEGACY_RATE_SP_5_5_MBPS,
> +	HAL_RX_LEGACY_RATE_SP_11_MBPS,
>  	HAL_RX_LEGACY_RATE_INVALID,
>  };
>  
> +enum hal_rx_legacy_rates_ofdm {
> +	HAL_RX_LEGACY_RATE_OFDM_48_MBPS,
> +	HAL_RX_LEGACY_RATE_OFDM_24_MBPS,
> +	HAL_RX_LEGACY_RATE_OFDM_12_MBPS,
> +	HAL_RX_LEGACY_RATE_OFDM_6_MBPS,
> +	HAL_RX_LEGACY_RATE_OFDM_54_MBPS,
> +	HAL_RX_LEGACY_RATE_OFDM_36_MBPS,
> +	HAL_RX_LEGACY_RATE_OFDM_18_MBPS,
> +	HAL_RX_LEGACY_RATE_OFDM_9_MBPS,
> +	HAL_RX_LEGACY_RATE_OFDM_INVALID,
> +};
> +
>  enum hal_ring_type {
>  	HAL_REO_DST,
>  	HAL_REO_EXCEPTION,
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 6c534f0d59ce..035937dde5c6 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -164,30 +164,31 @@ static const struct ieee80211_channel ath12k_6ghz_channels[] = {
>  	CHAN6G(233, 7115, 0),
>  };
>  
> +#define ATH12K_MAC_RATE_A_M(bps, code) \
> +	{ .bitrate = (bps), .hw_value = (code),\
> +	  .flags = IEEE80211_RATE_MANDATORY_A }
> +
> +#define ATH12K_MAC_RATE_B(bps, code, code_short) \
> +	{ .bitrate = (bps), .hw_value = (code), .hw_value_short = (code_short),\
> +	  .flags = IEEE80211_RATE_SHORT_PREAMBLE }
> +
>  static struct ieee80211_rate ath12k_legacy_rates[] = {
>  	{ .bitrate = 10,
>  	  .hw_value = ATH12K_HW_RATE_CCK_LP_1M },
> -	{ .bitrate = 20,
> -	  .hw_value = ATH12K_HW_RATE_CCK_LP_2M,
> -	  .hw_value_short = ATH12K_HW_RATE_CCK_SP_2M,
> -	  .flags = IEEE80211_RATE_SHORT_PREAMBLE },
> -	{ .bitrate = 55,
> -	  .hw_value = ATH12K_HW_RATE_CCK_LP_5_5M,
> -	  .hw_value_short = ATH12K_HW_RATE_CCK_SP_5_5M,
> -	  .flags = IEEE80211_RATE_SHORT_PREAMBLE },
> -	{ .bitrate = 110,
> -	  .hw_value = ATH12K_HW_RATE_CCK_LP_11M,
> -	  .hw_value_short = ATH12K_HW_RATE_CCK_SP_11M,
> -	  .flags = IEEE80211_RATE_SHORT_PREAMBLE },
> -
> -	{ .bitrate = 60, .hw_value = ATH12K_HW_RATE_OFDM_6M },
> -	{ .bitrate = 90, .hw_value = ATH12K_HW_RATE_OFDM_9M },
> -	{ .bitrate = 120, .hw_value = ATH12K_HW_RATE_OFDM_12M },
> -	{ .bitrate = 180, .hw_value = ATH12K_HW_RATE_OFDM_18M },
> -	{ .bitrate = 240, .hw_value = ATH12K_HW_RATE_OFDM_24M },
> -	{ .bitrate = 360, .hw_value = ATH12K_HW_RATE_OFDM_36M },
> -	{ .bitrate = 480, .hw_value = ATH12K_HW_RATE_OFDM_48M },
> -	{ .bitrate = 540, .hw_value = ATH12K_HW_RATE_OFDM_54M },
> +	ATH12K_MAC_RATE_B(20, ATH12K_HW_RATE_CCK_LP_2M,
> +			  ATH12K_HW_RATE_CCK_SP_2M),
> +	ATH12K_MAC_RATE_B(55, ATH12K_HW_RATE_CCK_LP_5_5M,
> +			  ATH12K_HW_RATE_CCK_SP_5_5M),
> +	ATH12K_MAC_RATE_B(110, ATH12K_HW_RATE_CCK_LP_11M,
> +			  ATH12K_HW_RATE_CCK_SP_11M),
> +	ATH12K_MAC_RATE_A_M(60, ATH12K_HW_RATE_OFDM_6M),
> +	ATH12K_MAC_RATE_A_M(90, ATH12K_HW_RATE_OFDM_9M),
> +	ATH12K_MAC_RATE_A_M(120, ATH12K_HW_RATE_OFDM_12M),
> +	ATH12K_MAC_RATE_A_M(180, ATH12K_HW_RATE_OFDM_18M),
> +	ATH12K_MAC_RATE_A_M(240, ATH12K_HW_RATE_OFDM_24M),
> +	ATH12K_MAC_RATE_A_M(360, ATH12K_HW_RATE_OFDM_36M),
> +	ATH12K_MAC_RATE_A_M(480, ATH12K_HW_RATE_OFDM_48M),
> +	ATH12K_MAC_RATE_A_M(540, ATH12K_HW_RATE_OFDM_54M),
>  };
>  
>  static const int
> @@ -732,11 +733,17 @@ u8 ath12k_mac_hw_rate_to_idx(const struct ieee80211_supported_band *sband,
>  		if (ath12k_mac_bitrate_is_cck(rate->bitrate) != cck)
>  			continue;
>  
> -		if (rate->hw_value == hw_rate)
> +		/* To handle 802.11a PPDU type */
> +		if ((!cck) && (rate->hw_value == hw_rate) &&
> +		    (rate->flags & IEEE80211_RATE_MANDATORY_A))
>  			return i;
> +		/* To handle 802.11b short PPDU type */
>  		else if (rate->flags & IEEE80211_RATE_SHORT_PREAMBLE &&
>  			 rate->hw_value_short == hw_rate)
>  			return i;
> +		/* To handle 802.11b long PPDU type */
> +		else if (rate->hw_value == hw_rate)
> +			return i;
>  	}
>  
>  	return 0;
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
> index bd741532b7dc..074df2ab6bbf 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
> @@ -405,6 +405,42 @@ ath12k_wifi7_dp_mon_hal_rx_parse_user_info(const struct hal_receive_user_info *r
>  	}
>  }
>  
> +static __always_inline u8
> +ath12k_wifi7_hal_mon_map_legacy_rate_to_hw_rate(u8 rate)
> +{
> +	u8 ath12k_rate;
> +
> +	/* Map hal_rx_legacy_rate to ath12k_hw_rate_cck */
> +	switch (rate) {
> +	case HAL_RX_LEGACY_RATE_LP_1_MBPS:
> +		ath12k_rate = ATH12K_HW_RATE_CCK_LP_1M;
> +		break;
> +	case HAL_RX_LEGACY_RATE_LP_2_MBPS:
> +		ath12k_rate = ATH12K_HW_RATE_CCK_LP_2M;
> +		break;
> +	case HAL_RX_LEGACY_RATE_LP_5_5_MBPS:
> +		ath12k_rate = ATH12K_HW_RATE_CCK_LP_5_5M;
> +		break;
> +	case HAL_RX_LEGACY_RATE_LP_11_MBPS:
> +		ath12k_rate = ATH12K_HW_RATE_CCK_LP_11M;
> +		break;
> +	case HAL_RX_LEGACY_RATE_SP_2_MBPS:
> +		ath12k_rate = ATH12K_HW_RATE_CCK_SP_2M;
> +		break;
> +	case HAL_RX_LEGACY_RATE_SP_5_5_MBPS:
> +		ath12k_rate = ATH12K_HW_RATE_CCK_SP_5_5M;
> +		break;
> +	case HAL_RX_LEGACY_RATE_SP_11_MBPS:
> +		ath12k_rate = ATH12K_HW_RATE_CCK_SP_11M;
> +		break;
> +	default:
> +		ath12k_rate = rate;
> +		break;
> +	}
> +
> +	return ath12k_rate;
> +}
> +
>  static void
>  ath12k_wifi7_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
>  				  struct hal_rx_mon_ppdu_info *ppdu_info)
> @@ -415,25 +451,32 @@ ath12k_wifi7_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
>  	rate = u32_get_bits(info0, HAL_RX_LSIG_B_INFO_INFO0_RATE);
>  	switch (rate) {
>  	case 1:
> -		rate = HAL_RX_LEGACY_RATE_1_MBPS;
> +		rate = HAL_RX_LEGACY_RATE_LP_1_MBPS;
>  		break;
>  	case 2:
> -	case 5:
> -		rate = HAL_RX_LEGACY_RATE_2_MBPS;
> +		rate = HAL_RX_LEGACY_RATE_LP_2_MBPS;
>  		break;
>  	case 3:
> -	case 6:
> -		rate = HAL_RX_LEGACY_RATE_5_5_MBPS;
> +		rate = HAL_RX_LEGACY_RATE_LP_5_5_MBPS;
>  		break;
>  	case 4:
> +		rate = HAL_RX_LEGACY_RATE_LP_11_MBPS;
> +		break;
> +	case 5:
> +		rate = HAL_RX_LEGACY_RATE_SP_2_MBPS;
> +		break;
> +	case 6:
> +		rate = HAL_RX_LEGACY_RATE_SP_5_5_MBPS;
> +		break;
>  	case 7:
> -		rate = HAL_RX_LEGACY_RATE_11_MBPS;
> +		rate = HAL_RX_LEGACY_RATE_SP_11_MBPS;
>  		break;
>  	default:
>  		rate = HAL_RX_LEGACY_RATE_INVALID;
> +		break;
>  	}
>  
> -	ppdu_info->rate = rate;
> +	ppdu_info->rate = ath12k_wifi7_hal_mon_map_legacy_rate_to_hw_rate(rate);
>  	ppdu_info->cck_flag = 1;
>  }
>  
> @@ -447,31 +490,32 @@ ath12k_wifi7_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
>  	rate = u32_get_bits(info0, HAL_RX_LSIG_A_INFO_INFO0_RATE);
>  	switch (rate) {
>  	case 8:
> -		rate = HAL_RX_LEGACY_RATE_48_MBPS;
> +		rate = HAL_RX_LEGACY_RATE_OFDM_48_MBPS;
>  		break;
>  	case 9:
> -		rate = HAL_RX_LEGACY_RATE_24_MBPS;
> +		rate = HAL_RX_LEGACY_RATE_OFDM_24_MBPS;
>  		break;
>  	case 10:
> -		rate = HAL_RX_LEGACY_RATE_12_MBPS;
> +		rate = HAL_RX_LEGACY_RATE_OFDM_12_MBPS;
>  		break;
>  	case 11:
> -		rate = HAL_RX_LEGACY_RATE_6_MBPS;
> +		rate = HAL_RX_LEGACY_RATE_OFDM_6_MBPS;
>  		break;
>  	case 12:
> -		rate = HAL_RX_LEGACY_RATE_54_MBPS;
> +		rate = HAL_RX_LEGACY_RATE_OFDM_54_MBPS;
>  		break;
>  	case 13:
> -		rate = HAL_RX_LEGACY_RATE_36_MBPS;
> +		rate = HAL_RX_LEGACY_RATE_OFDM_36_MBPS;
>  		break;
>  	case 14:
> -		rate = HAL_RX_LEGACY_RATE_18_MBPS;
> +		rate = HAL_RX_LEGACY_RATE_OFDM_18_MBPS;
>  		break;
>  	case 15:
> -		rate = HAL_RX_LEGACY_RATE_9_MBPS;
> +		rate = HAL_RX_LEGACY_RATE_OFDM_9_MBPS;
>  		break;
>  	default:
> -		rate = HAL_RX_LEGACY_RATE_INVALID;
> +		rate = HAL_RX_LEGACY_RATE_OFDM_INVALID;
> +		break;
>  	}
>  
>  	ppdu_info->rate = rate;
> 
> base-commit: 2c1ba9c2adf0fda96eaaebd8799268a7506a8fc9

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


