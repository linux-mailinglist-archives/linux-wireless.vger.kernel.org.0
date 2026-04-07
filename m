Return-Path: <linux-wireless+bounces-34484-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAzvDQsw1WmU2AcAu9opvQ
	(envelope-from <linux-wireless+bounces-34484-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:25:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2963B1CF4
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 18:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DD83300D350
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139F35BDBB;
	Tue,  7 Apr 2026 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eIoZTLVo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EIh8pzs7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145C38947D
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578923; cv=none; b=gAMLohsbo9WYeEjFK0AB9Sn9q7G+GP33IK/LapvU5xNuI/C1m3bjpjHuE7qHK/lhhm/J/9tC3ACCcg54dnz5mPkgB47G9dbTzFdju3w7xesEiyIn4C3Q2eFkTO66Bklu93ffNeeNSdf3qnQp3bgFMVntlCS6uK6iWHLgZG/JGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578923; c=relaxed/simple;
	bh=R1v4ESg4zs5cpKbWsrIGjrYbBgdH0so8Apl4Tz5gbeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUVmWmoQl88OjaXtE+ox+yb2DxDKdkA+0wVwaADzyiTeVLgBYv1hst130mwIW7Tm/c+RfcfXDKsJEnljCnCPXzeUdb8BS1RI1YzlvGaYwWoc/9NYIApMLEMh6cwzqcPMZPAiDFaSYhlkahKONtjN2cpHE+4msrex8qrPJF0tc6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eIoZTLVo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EIh8pzs7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CUaIl493331
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 16:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aZ30nZnkzUWmAjcLPNF6a6T9pjqKEFiBBlMT7XZwp7w=; b=eIoZTLVoLPSr81cL
	+q44q76Z5BMyMlSlCQwEP1duZsFwM8VAC0Mb7n+h72ob+p65xFEZkR3CyTAKZVjp
	G/cZKD5IIqEGFEWUThJrpO0fjqVfPD+VaRO0Z/5ZCTaw7jLGO1zFAy4dKK75GeQ4
	oWvIAjg4tEjRbi+eGshrJGlStCcDo2jOHNlb15Yn51ajeCSC/lsDle84mjWZ+vtS
	tlRN+gnj4B2V2JNnjRdQODomiesbYAU2JRxZFqf0ApL6Gd/0GJg7Z3AJUrbka8Hj
	iF4NecsHQKCMYNGJYT2Ctz2aJT/4JTq8tT6M5GlKJQqeaI6K/NwOdTLsRxm6rVTG
	TPjOFg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8ujf7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 16:22:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c76bd4feb9fso2095904a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 09:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775578921; x=1776183721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZ30nZnkzUWmAjcLPNF6a6T9pjqKEFiBBlMT7XZwp7w=;
        b=EIh8pzs760y56jypUICsRyDEWc1OXdQuB5KhCHNhGS8pO17uaHfbw3DxirT4IJ5Ibe
         JZ5i442Qw7OOtt/Urm3HJIz2UDym9WZtt+8sCef4DgO12vUvTRVqC/AYgIJY3BVfLLQ2
         cphHT5VL5EUbB/e8oE/K57q5NZAPi52UFoa2Dgt0f9bbNU9dbC5mSvyz8OX4PUa6j9NQ
         vsVVWEBZ3BUHvu5bdxJvxaFMbrKNxmZggmnOL2R5/8ziIrytfddN18BSdNRXHN35ny+R
         RDQ4i17xQJJEmTW79JjfAUBfnyAHAnHQo8BIwTKljjY3nlcMDABedp6f0Ffe8y9Z99FY
         mKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578921; x=1776183721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZ30nZnkzUWmAjcLPNF6a6T9pjqKEFiBBlMT7XZwp7w=;
        b=OpHn3JbXkEMqmX3V+LFjPHojrV0/G1UEx3kxibJC8jgYIFC+gMOF+kBldI+Oi7xLQ4
         fKE8N0wrkifAOfsyGQ/IzLeyZ/YCWjSJWsO3ROhW/1DctAuAynW+68LMl4fb0EbbzGBj
         emXMS38zoRTVdFiJYF3hENZlv5ybDCO/t1LkZk7yOvsVQMG+3HUMi0FCunsBYVU2trTp
         Bh4ZUFLsBoVDzyb5N8Abb42cMbe2iQ9F1pSwXNbvHmRbZ9zbUcAs4G+HVV3UIJQhp/ix
         AiYDSCY0I/WvljX8dEPCpLe8oqhYxVYKZFp8BSi00Sgzg0hP3ePw8BRUWOFdDSz202qG
         kX2w==
X-Gm-Message-State: AOJu0Yyhdd2DS5K6yBIjKCAnyBY0SPvNcpqa949SjvJREJhChFTdNxii
	NqoT6Cnbfx+YwJ8koE2uTy/vovecD3+wiK+UFt2yFBQpOi/gggiG5JKinfL5nMvZDhp2URHSwWF
	TYrJGbcSU8CF8BRiwE5XJ0wqQF2RSSO7iIB+gVO53Ot/n9g70G17lVWhjP660GTG95aSfeQ==
X-Gm-Gg: AeBDievs0W/4X9tS/nRYZfRaZ39aZ/aUDrnFXskxJxVx+s9oWTuiZtP0tyjcSCusV5w
	HErChsZnC35g3Kk2IFafyXfzRvHPjr7K8awiM5WyMd0Mms9F341OMQ9fhyKu5eo5xJoc03zDEi4
	byZnzS7Xc6vdi8Yz1kcIku7Q1VoUNdp/2otMONcKBGoEagBmPk/WkrJ3v+UTD8kGfdB5SdQaF5t
	HmAUQzpbiALosFH4icaGc1PKbhp82WHpQ2B35KyXl2u9loDS7Lz64Lj7fZ99NJSq7FR1BkLcAMr
	MlbPw37Bgbkbz2IFt9ruaQuKLilMoZWqCgJoe3lbXzsJX99lyEsyaGLfqf4ExdZDEtOcuiB6Dus
	Mx3tj06EZ3RA+PjpJ8BvXBByyeEX7IRp3y2QWFfDBJ7dvJUHXfhckDRmW3X5UXYy1PQ==
X-Received: by 2002:a05:6a00:13a8:b0:82c:d5be:d28a with SMTP id d2e1a72fcca58-82d0db6ac92mr16146583b3a.31.1775578920677;
        Tue, 07 Apr 2026 09:22:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:13a8:b0:82c:d5be:d28a with SMTP id d2e1a72fcca58-82d0db6ac92mr16146545b3a.31.1775578919884;
        Tue, 07 Apr 2026 09:21:59 -0700 (PDT)
Received: from [192.168.11.106] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3d439sm19025087b3a.35.2026.04.07.09.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 09:21:59 -0700 (PDT)
Message-ID: <ffce1c33-d8e3-412c-b681-a980b405aa42@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 21:51:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5 3/6] wifi: ath12k: add ath12k_hw_version_map
 entry for IPQ5424
To: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
References: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
 <20260407-ath12k-ipq5424-v5-3-8e96aa660ec4@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260407-ath12k-ipq5424-v5-3-8e96aa660ec4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KotKDtWjXR0NkRBTNaNvkeRmefeiv0IF
X-Proofpoint-ORIG-GUID: KotKDtWjXR0NkRBTNaNvkeRmefeiv0IF
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d52f29 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=AiuA0lUDFxK_Uw9U_U0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0NyBTYWx0ZWRfXwlXMKU5gmhln
 De1uoTDxCLxJKJmMPQk8FQEUI1tc51HZ3HQnr5tUgPSM96mM8ydRbvQ+oD1C83FI9dAArmNK5ye
 AWphkCaxh4jfAWC8wGgYYWjcgljiOedukUQLdGVsj8NxhdHuh82BhvBCP1FU/lAQzIhhfNdHG18
 mnBjWDfwCN1KnjSxZ5ONarar1KWM+Y34LM92hl2YCYWqVao8FXGQo9zCEnsw4NqYti7VZh3FvXy
 71jP1nFH/GQmhj/Ki/3r8BanUTDB6m+zGZPeKBz+OZTKFJcXmH17/k4jPrHLNi+L+IvwaiPseGd
 nFzKAIYTp3B6uMp6kYTzbpemALvp3JhTK0vss41lg/us6rR1PoQSDr6rnD1ZN7BaAorAyhanzxb
 RuHW+iRrW+BYO8IJTwGS6iGFHZxCpcx6IuHmRlvho6Hpjpaw+hFr/ua0LtJ8my9iGbfrQiFgjzU
 6gyciTUiOGs65wVX+fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070147
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34484-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EA2963B1CF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/7/2026 10:56 AM, Raj Kumar Bhagat wrote:
> Add a new ath12k_hw_version_map entry for the AHB based WiFi 7 device
> IPQ5424.
> 
> Reuse most of the ath12k_hw_version_map fields such as hal_ops,
> hal_desc_sz, tcl_to_wbm_rbm_map, and hal_params from IPQ5332. The
> register addresses differ on IPQ5424, hence set hw_regs temporarily
> to NULL and populated it in a subsequent patch.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/wifi7/hal.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
> index bd1753ca0db6..c2cc99a83f09 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
> @@ -50,6 +50,13 @@ static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
>   		.hal_params = &ath12k_hw_hal_params_wcn7850,
>   		.hw_regs = &qcc2072_regs,
>   	},
> +	[ATH12K_HW_IPQ5424_HW10] = {
> +		.hal_ops = &hal_qcn9274_ops,
> +		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9274_compact),
> +		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_qcn9274,
> +		.hal_params = &ath12k_hw_hal_params_ipq5332,
> +		.hw_regs = NULL,
> +	},
>   };
>   
>   int ath12k_wifi7_hal_init(struct ath12k_base *ab)
> 

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

