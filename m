Return-Path: <linux-wireless+bounces-37892-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NgVLAeq2M2qHFQYAu9opvQ
	(envelope-from <linux-wireless+bounces-37892-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:14:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D52B69EC38
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:14:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nkPtvtMu;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=K5qQ1BNf;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37892-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37892-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F19A430209F3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F153A27B35B;
	Thu, 18 Jun 2026 09:13:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8E23624D9
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:13:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774015; cv=none; b=CdzPw2B7jnwPzWWDzdRxGI8uzOWh/j672Mtk0rlySwg1Lxqt/9OH5bjV/M/5qOeFjO5GRIneHEy2iHyaghVdI4rOJ1vwi/sWIgErxxskqNKLRY1gjkeisUX+iCNG+ri52htS7TKnXsMPCkHMHj0M9WHWga9WnwBY4GQXwurVsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774015; c=relaxed/simple;
	bh=/w4CB7GcvIWDyJS0PapK7N/e3QhIIIP/17Q08eJ8NHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgYEKqNR9cefh8E8I0SeM6sYH8glMBPB7QWWpCQjSzL/FyrSx+dCWRRB+vfbS9nKM4XCcTjuGISXdx0S5cVx5ICK2aaovQGA5SFBx+SCS3em80sHP+Dfqsq6GItMHyf6O0QuZnM74WCNuwE/F2TpSnbWl+DnLYBkTAzLBN3Jth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nkPtvtMu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K5qQ1BNf; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I9CnTo1371885
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pp3Uk0k/hYv7bLf1WuLS440HbLEWQGU3+m2R2+M1BZI=; b=nkPtvtMuwab0Ggeq
	DnQD5qI3a2BJYOf2E7FkGsb15asBARDWV+rLqOGCf3jF45rLpU3I4ZQqw/IOmE7h
	0hfJwzUzVf+tnrjMbS2pHHazAthB5ghgdCu60AW+2vTUWbseTsleOPgdPtB9pp3M
	16Lm8GxVyrJf8xfYpE4PY4ZSubPtiOWGGFsw2WWcRLN8nrjULtqmZzoFQdj8r8gc
	hIAs09g0e51WBmMAuNHrMZJ1EligUvKDwPrE7sTVRqfOPjThdTAWpylw46e/kF8X
	D/X0orsqF8gwKYp/gBF3OhTNcbOgSftRKlnctWe81qcOwO9zTC8Cf6ColyyIw77S
	tpFOLw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2juusm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 09:13:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c36f1cc0so16751075ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 02:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781774012; x=1782378812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pp3Uk0k/hYv7bLf1WuLS440HbLEWQGU3+m2R2+M1BZI=;
        b=K5qQ1BNf4pw5cDxdn7NWbXPk31jhYa7/slW1/GkKeF2uerAajxcyjQ8o9koRvHALVc
         lqu/ye/3tDzY8zj+Z3DbcnBrGPbHwM92YLf70GluwkkHX0IIYeUIsw1V1k5FU6t5l/ev
         hRUZUgF2GvnOPYD1aMZ8x2Ek6cijrrULGssVJd+7RxVkUMG06RQyqB+VWkv8LP/QnX/V
         biSt7v8PCSDiO3QNZIZgyX4LNKea4EzWmRmlufi1LLuUL+9J08WuTVNQvUM7ESmndI9q
         mF+fEaMnQ+UfYUR+lFHkvei0yjEfLKfD2V7xR1qM12equ23jtp5ruas/x25Oa5nEvoEX
         Ta0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781774012; x=1782378812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pp3Uk0k/hYv7bLf1WuLS440HbLEWQGU3+m2R2+M1BZI=;
        b=INQPYDD1jJSgWGCuh8WD965xMjr4smfIeiSIKM+YOyC/hFGv/V39qHMaXnNWuxJRlp
         570xi5y2IBayMicL1OTE9PdGE/nI5iuKctlKe7HzJoGUxdB7jKZiSSfk/ITwoztB7Zao
         yhlTZo0/FJwYnwbnELXqFMaJQbjRLWPTpsYqFIltrGjbvslpowEVPc/hU5yrMrCgSJj1
         HL5w0Q/aTK2XzwlwbROywYzirDodVbHx6VOfRagk8pOl44q0JiLPvcy/waA0OhqkzwW+
         tfllQimBC5K1YkdhDREknqeyVr6RdAqw//ZpcrS0Crhh9LYaAh3Rndz0FGUCLf0KWLml
         v3mw==
X-Forwarded-Encrypted: i=1; AFNElJ9pSBVA+Oyu3fHK34gm3WNzLHZWopB5h4Hg7Oh6/ubmUTYGoTmStEQAdV4G7bEHPpu8sVbFpBeHb3ihjePhTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDuJd3AxShFP1G023bxiRv52L/cQsg/UoJ676/hSVhkRI0G5j8
	rXtIh9A1fY5zymyjtq81ejqpd2cSUD3R73gKz1JkGNtLKkDhDtJW0HPZoPKHNyCM1f+aklIcFsC
	ESQBCbEO+h6uNtp4gTzIowTj9B2ilnnnv9u2PgrgdSthWI7BJVNP0IrRKrnx37y/FS1PUvw==
X-Gm-Gg: AfdE7cni7XLBh0yVjzyijwUcrgav4BwO4DOL5yLY4RaE2ggsd5vtKi3mjDk3htEJh5K
	nGRoVGn8FhYczoeWZKB4BVIKlzaw/rYUO+0ji6N7vwXPY8y/HvZPSjaY6P6rXxLVPdNEfFYb3ww
	VQ0SJs8dYzoVRupw7TbIo6APiUiFcPG7ttARV0qsG0g2lfaiuXrxBu54gTek/phvIFVmdTQhB41
	p5LH1c2Kn8saYLywX64ejUKJ3lG3PVjRA3exLRmfN6VHTLFAKOPt0Z8wnboPybBA6m1UBNxE3mL
	1GBexxAbc+uNCQ80nSdfvz4l1IWY2PQNJcRAuIe/fEj8gxPCBq10xLIr5OxnwdfMB7xbV9LSWt8
	wlN47VxcNXZLJU2BKBuReBZlRRZL7nLH4tSDPEZqjdEzq5+mxsDF1eofsVqk=
X-Received: by 2002:a17:902:ef43:b0:2c6:d5da:838d with SMTP id d9443c01a7336-2c6d5da84cdmr48324685ad.33.1781774011882;
        Thu, 18 Jun 2026 02:13:31 -0700 (PDT)
X-Received: by 2002:a17:902:ef43:b0:2c6:d5da:838d with SMTP id d9443c01a7336-2c6d5da84cdmr48324355ad.33.1781774011395;
        Thu, 18 Jun 2026 02:13:31 -0700 (PDT)
Received: from [10.137.71.130] ([106.197.93.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432f77479sm191501365ad.63.2026.06.18.02.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 02:13:31 -0700 (PDT)
Message-ID: <aa5e214f-2d9e-4c97-b45f-7181c81cf023@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 14:43:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 3/5] wifi: ath12k: add HAL ops for monitor TLV
 header decode and alignment
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
 <20260509025819.1641630-4-miaoqing.pan@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260509025819.1641630-4-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4NSBTYWx0ZWRfX2eWEjYRs5bAT
 72p7fIrBT9i/+ktLS8y26zoyDpHTJqJlgSxNlNSvxpdM4+bGitU7lp/vBearxZYMqNVUnetl2Ea
 mlj0TYcWkmMXUjjcVputCMXIKaNnD7ftNpFpIH2ytUGWNSVdJITnVaN4aNVudiXle/nGEeb9p1+
 9t9pHiWyXBKuDZf2/r7/nxH3SdZMtY4XzCcJZJSCPr5N51WeshDHfYoOxnbw1fYjCRzdh9r2+vq
 LmB9ip+AYmAcODln0BpmFdZ5BjhPS4xvfLsHc/ttbmtEzybeklNwJuMiuiUTr66C4Wc/FDjq3Hb
 9bC3WsTdguljhn/uIPzBDj9iFIi1GiwJRNy3/51SK96xC4ZNRvsohijPYgr4mN0JbxLuFGbYTvt
 MnsIPLb3vDViEXcoXBigltFgC5OmxBi6RuB11xZjTuZF1PV3iEgRXjm56CCPu42f2wqlH91rxX4
 Z5JNrG725nrza6gtR6A==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33b6bc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=wlpA7Av3g41Jdys7FXR3eg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=T2WGhnzAuiY_ZRgizcIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: hJexyFw2oU63_D8uByR7AbuAxcLrs38o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4NSBTYWx0ZWRfX+0emSPc0bjh/
 WpO45eTOUwvr/hULAwNnH4XtgVDgmoiXP+lmzs9Fyc30NRUDFIKSS1+EmcdtM2qPEW73nadU+p3
 4Mo2njSM5hVfov7hORSHRyXgMLut5fY=
X-Proofpoint-GUID: hJexyFw2oU63_D8uByR7AbuAxcLrs38o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180085
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37892-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:miaoqing.pan@oss.qualcomm.com,m:jjohnson@kernel.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D52B69EC38



On 5/9/2026 8:28 AM, Miaoqing Pan wrote:
> Wi-Fi 7 monitor RX status TLV parsing needs to decode TLV headers and
> advance the pointer with the correct header alignment. Different targets
> use different TLV header layouts (32-bit vs 64-bit), but the HAL ops for
> dp_mon RX status header decode and header alignment were not populated
> for all wifi7 targets.
> 
> Add dp_mon RX status TLV header decode callbacks and TLV header alignment
> helpers to the wifi7 HAL ops for QCC2072, QCN9274 and WCN7850. Export
> helpers to query the required TLV header alignment for 32-bit and 64-bit
> TLV headers so the caller can align the TLV walk correctly across targets.
> 
> Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00068-QCACOLSWPL_V1_TO_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/hal.c               | 12 ++++++++++++
>   drivers/net/wireless/ath/ath12k/hal.h               |  4 ++++
>   drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c |  2 ++
>   drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c |  2 ++
>   drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c |  2 ++
>   5 files changed, 22 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> index d940f83cd92f..c0c3d2f047ef 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -875,3 +875,15 @@ void *ath12k_hal_decode_tlv32_hdr(void *tlv, u16 *tag, u16 *len, u16 *usrid)
>   	return tlv32->value;
>   }
>   EXPORT_SYMBOL(ath12k_hal_decode_tlv32_hdr);
> +
> +u32 ath12k_hal_get_tlv64_hdr_align(void)
> +{
> +	return HAL_TLV_64_ALIGN;
> +}
> +EXPORT_SYMBOL(ath12k_hal_get_tlv64_hdr_align);
> +
> +u32 ath12k_hal_get_tlv32_hdr_align(void)
> +{
> +	return HAL_TLV_ALIGN;
> +}
> +EXPORT_SYMBOL(ath12k_hal_get_tlv32_hdr_align);
> diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
> index 3158c1881c76..312993d3d5d4 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.h
> +++ b/drivers/net/wireless/ath/ath12k/hal.h
> @@ -1439,6 +1439,8 @@ struct hal_ops {
>   					 u8 *rbm, u32 *msdu_cnt);
>   	void *(*reo_cmd_enc_tlv_hdr)(void *tlv, u64 tag, u64 len);
>   	u16 (*reo_status_dec_tlv_hdr)(void *tlv, void **desc);
> +	void *(*mon_rx_status_dec_tlv_hdr)(void *tlv, u16 *tag, u16 *len, u16 *usrid);
> +	u32 (*get_tlv_hdr_align)(void);
>   };
>   
>   #define HAL_TLV_HDR_TAG		GENMASK(9, 1)
> @@ -1553,4 +1555,6 @@ void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len);
>   void *ath12k_hal_encode_tlv32_hdr(void *tlv, u64 tag, u64 len);
>   void *ath12k_hal_decode_tlv64_hdr(void *tlv, u16 *tag, u16 *len, u16 *usrid);
>   void *ath12k_hal_decode_tlv32_hdr(void *tlv, u16 *tag, u16 *len, u16 *usrid);
> +u32 ath12k_hal_get_tlv64_hdr_align(void);
> +u32 ath12k_hal_get_tlv32_hdr_align(void);
>   #endif
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
> index c0583c3a2191..80ffadc47d48 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
> @@ -490,6 +490,8 @@ const struct hal_ops hal_qcc2072_ops = {
>   	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
>   	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv32_hdr,
>   	.reo_status_dec_tlv_hdr = ath12k_hal_reo_status_dec_tlv_hdr_qcc2072,
> +	.mon_rx_status_dec_tlv_hdr = ath12k_hal_decode_tlv32_hdr,
> +	.get_tlv_hdr_align = ath12k_hal_get_tlv32_hdr_align,

ops get_tlv_hdr_align() seems unused, may be patch 4/5 is supposed to
used this ops instead of removing the alignment?

Vasanth

