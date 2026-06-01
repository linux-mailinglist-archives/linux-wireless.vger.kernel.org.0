Return-Path: <linux-wireless+bounces-37227-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JRtENEAHWq9UwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37227-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 05:47:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5995F6194B4
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 05:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2439B3000A64
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 03:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC0302750;
	Mon,  1 Jun 2026 03:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vnc3x50D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TEFelau3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CB1ADC83
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780285645; cv=none; b=lTYqlicm4VVfqySkVdOY6//33Oc2SxbzNWHaxP5OmNfe6MY/iKvFmuhz7VQtglNjDLFrVjhvG8lhz1jJ0Ed2PhZwyFubWvI+PBB3nY34uqnLsskaOCjw3Fv+LTq2oFF/1nlvtqQS8dKNxzyhI08BbPmnFAVS2YfJunYhqmTE2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780285645; c=relaxed/simple;
	bh=l2FLpPWqcyP+8WWVKleL7AInZCZdnX/IspnCXVfkSJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/O34jI8+a+EI7DESyWKj4KwWzVYqVmW95vTjUJSAuubCL2BaSMBtjJ8qA8eVeBO9OJ3HzThX1ClpZohVF6GYcy0yQZ35fu4yL9Hw/HO+oeOQA1vlnTE9gCn9qiTdiR04RxxzANK8PczaWaypyi5lnYwjghKsibIcFs1/AfcklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vnc3x50D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TEFelau3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VB9oRD2753261
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 03:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kLQaNwgFzPvUJk0AnhaNubQuSeLF1I/jBvaeiZsg7YM=; b=Vnc3x50DzjBsGBs2
	RXwMgtUT9dQkze11gNokbEkHuvDNIRKXN1JcJZ9ohnUxqw9ubD9aSMkQrj3BaWyp
	pPFrHa8bPuFeHHU9UH+0QNFbxwlrh9lLkKDrEYOw4NMYiqatB5hHqEFoI85FV6ng
	PdwIZrtmah7xH1+CMddOu31LVh7Kst7KWEDwUXSCLItRpqP4WKlsIvYV0mhgUFwJ
	P8IkIVh83C5jOHhcwIygaKb5tIaz5UFRj9g/OP7tPicW1tcLC1SDVM++jQpd73fp
	tFSIMMHt7upuQ2zD4xGd2hIRfwOHOaEBE9igyCJ27q1Umnuj+xwlLznI7wH2YNW8
	tBzBlg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efux551hv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 03:47:23 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84256bee9a9so230334b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 20:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780285642; x=1780890442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLQaNwgFzPvUJk0AnhaNubQuSeLF1I/jBvaeiZsg7YM=;
        b=TEFelau3ib2+48kR6gHESr0Wd0ObNoQRXaxwNF3kXai5/Gb97f7HLGOkgfuqb0UuTG
         XJl/KQo+YY65dGa1Evt9o6tVnPMbHJUUTFW/GEqD6Ypzhitc3KmI3yfH5e9a61Q+Q4Ey
         5huZAxPBKCBL2KhYmkeH1GO5laV82pZFjYV0ovXyeEgvhN2An7gr0M5Bb+pEJTykOBE5
         6lq9UhM+Fr3Q+PBa9n37k9tdrP0MyHL+hLBViLs4o0sorqNh0Yz2pEvxQWehXC7k0fVb
         ZDl5rEviP2BKM/TrQX05IjZssIHcH/jzUn5e4cS7hQ7k5g7RR/sH5VOd8jtj+DN8dkoO
         iDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780285642; x=1780890442;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLQaNwgFzPvUJk0AnhaNubQuSeLF1I/jBvaeiZsg7YM=;
        b=o/WlcMSmSAPhyGHRBPnUZJ4AXuKdtvEm+WdjaLzd8WYy53T8zBj2PdOnVdSEecleGk
         eaUV7GLoRI+V9F/r0n2iZW9sYHeAhkW1SypgXBUoM17ghCSlPVgW6KryXV9c6Roo30ni
         fEwYFe7q/YgK3udmOd20zgVlJyiq0CPEwA1Xyn1CXXcMBVNiKbicRSfAFGgBjcHP7wp/
         sldjkvYCJqhLN/hiObTMsJKbSl9cR1xmM3Biw4vgeUgaL34GM6R0HfVU1E/gsNR4aSG+
         SobofNsNy/YSyJcxlG8pMt2W9/uTQEgn5Oiw3YuE5Q8/M2FGbLyUsO1XoYyTXQlU0hJg
         k9YA==
X-Forwarded-Encrypted: i=1; AFNElJ823KDqL7vHUXiNet7IwVwZ6PrF8IAJpre7myNzoH018GgRYIiST7RsTR2LQKro1FleXoRrudSlZzX7hiohRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt9J/zaIvfPzQszOgiAbWXnc2zdHokL908Mhfv20PEWsmf3nWk
	E/WA2ZZjfFJXWtFJPDFXEHiu+tyyzo2vWGEA1RHMNtqQPLcmaSnDir2keZnFKghHq/u5qUcaHhD
	3ppouTX0MT9fHIapQFuZ4ANIKqQontrg6kR/3R6PWkf5TstT/NlczZO1vE9qs/JtFS1he8g==
X-Gm-Gg: Acq92OHiPylT1MnpboUP5XVZFoLLET8Qy3/4mSxr+DuHjk7aUblnrglThRz5GrthyIo
	TT5lGXLd9U+qT1YcOtG147zT0SZGnlTSDeiJbgYva7rCphd3fe6sROdairhgaoo/Vtd2S4yKw8Z
	+kCilgM+eJ5cyxjRaqFqFmMr2fl8Kt/nEneNPlf664UGAjuqMt5skvqTDcWjCDi0oeTxYyvPyXh
	H/pG0f8AOnten+ZUppC+XgBA70q9tdIl/ba0fPoVU01HdyxIuwXmJHvZ3CHtRfKsMjgwyeviDdE
	9ZOXUQaJSfaqW3lqUEu/imyK8XxpciG3KrxPvKAq9Es+WB/CK3oukNrTP7fBfdqR9DuRWvK48IN
	EsR5btg2StF107QBeJZRaPx92JvEReKW2+zf1OJ9l2NJKGypPjn0rhg0VK3vaWkxsQMc5SbY2xA
	M0z48KZ6ZBQvU7f7ZlpbVNgSYd6wxm
X-Received: by 2002:a05:6a00:2188:b0:83d:b11f:7979 with SMTP id d2e1a72fcca58-842256d7549mr8612546b3a.29.1780285642373;
        Sun, 31 May 2026 20:47:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:2188:b0:83d:b11f:7979 with SMTP id d2e1a72fcca58-842256d7549mr8612495b3a.29.1780285641738;
        Sun, 31 May 2026 20:47:21 -0700 (PDT)
Received: from [10.133.33.22] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8423bdd217csm3897340b3a.49.2026.05.31.20.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 20:47:21 -0700 (PDT)
Message-ID: <f89f90ea-a9f2-4f1c-b55f-2b77ddc505e1@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 11:47:18 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/2] wifi: ath11k: fix invalid data access in
 ath11k_dp_rx_h_undecap_nwifi
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
 <20260512022351.2033155-2-miaoqing.pan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260512022351.2033155-2-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Y34x3HbBQEAACOp8rY0dX9jONlt6DCNT
X-Proofpoint-ORIG-GUID: Y34x3HbBQEAACOp8rY0dX9jONlt6DCNT
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a1d00cb cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EU6IV83DWVWhS13MJAEA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAzNSBTYWx0ZWRfX6Cuag5TjjjXG
 vJsS5xh8LYTJyN069aDHEGpDwlMroWwPXHA3yMCrmUPifsguk1q8QIML20tZ9rrWTwBeW7reJF8
 un4Jkt7vMDN2tHpg0iYRWyhIlQPqnhThAXlG1Y8UCsj9vLQg8vzAEVGqAbOHUqy1Yyc9KIkiiL9
 B6P2zVpU7hpxmZvUCT0tOfSR5I6Co7aFdwjf97b2FLtk2TXp0xCSVp2QXqtB09mTMkrQ5Eq2FqO
 Eo7EmHO8IO47e3Q9xmegYYGWMTZ+6yzPByKF0JoK3c9raI4Ks0QjgRr5XTTvyn2o5CVztGsjCAX
 tsTG1E9XdLiXgxslFkfN3bXCK5BZTb1AtxEAyW+bm841vTdyyzHs33wdMCkHDei1dLTdxO/0e3w
 dH04paWfS9XMT1KGxyqSKVG2hTJ0tAtTZRUnHn3zNTl9426j1IeVh6iQyGg1esPO7NswrGcH/AO
 qmxvvXVjLIi7Ny9ZTSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010035
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37227-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5995F6194B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/12/2026 10:23 AM, Miaoqing Pan wrote:
> In certain cases, hardware might provide packets with a
> length greater than the maximum native Wi-Fi header length.
> This can lead to accessing and modifying fields in the header
> within the ath11k_dp_rx_h_undecap_nwifi() function for the
> DP_RX_DECAP_TYPE_NATIVE_WIFI decap type and
> potentially result in invalid data access and memory corruption.
> 
> Kernel stack is corrupted in: ath11k_dp_rx_h_undecap+0x6b0/0x6b0 [ath11k]
> Call trace:
>  ath11k_dp_rx_h_mpdu+0x0/0x2e8 [ath11k]
>  ath11k_dp_rx_h_mpdu+0x1e0/0x2e8 [ath11k]
>  ath11k_dp_rx_wbm_err+0x1e0/0x450 [ath11k]
>  ath11k_dp_rx_process_wbm_err+0x2fc/0x460 [ath11k]
>  ath11k_dp_service_srng+0x2e0/0x348 [ath11k]
> 
> Add a sanity check before processing the SKB to prevent invalid
> data access in the undecap native Wi-Fi function for the
> DP_RX_DECAP_TYPE_NATIVE_WIFI decap type.
> 
> This adapted from the discussion/patch of the ath12k driver [1].
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Link: https://lore.kernel.org/linux-wireless/20250211090302.4105141-1-tamizh.raja@oss.qualcomm.com/ # [1]
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 50 +++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index fe79109adc70..fbe2061a544d 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2502,6 +2502,29 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
>  	ieee80211_rx_napi(ar->hw, pubsta, msdu, napi);
>  }
>  
> +static bool ath11k_dp_rx_check_nwifi_hdr_len_valid(struct ath11k_base *ab,
> +						   struct hal_rx_desc *rx_desc,
> +						   struct sk_buff *msdu)
> +{
> +	struct ieee80211_hdr *hdr;
> +	u8 decap_type;
> +	u32 hdr_len;
> +
> +	decap_type = ath11k_dp_rx_h_msdu_start_decap_type(ab, rx_desc);
> +	if (decap_type != DP_RX_DECAP_TYPE_NATIVE_WIFI)
> +		return true;
> +
> +	hdr = (struct ieee80211_hdr *)msdu->data;
> +	hdr_len = ieee80211_hdrlen(hdr->frame_control);
> +
> +	if ((likely(hdr_len <= DP_MAX_NWIFI_HDR_LEN)))

nit: Double parentheses on likely()


