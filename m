Return-Path: <linux-wireless+bounces-28644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60656C38B90
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 02:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D789F34F616
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 01:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7041DF27D;
	Thu,  6 Nov 2025 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="liusBrOX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EnWyntmp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552213B284
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393276; cv=none; b=e4GxKARQdeOMfn56aeuMdsV4HiS/CKghprh8tIoVwwmgbW+NuZN4OIgsnD5VNnT+ZkxR3diq6joq0U5W5nxN56ycSYSLUxOfnkFU/W6WmpD7RCrVaD10TD/EeCoDPmPouOobMabkQbX0XvV9kokGCT7HK5t7iq8HU6mU1d2Ccag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393276; c=relaxed/simple;
	bh=bZwUGagUvFYAGz9RQ7aD70pC6yG9dE+wQazNMDUiIkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhUJh3hnLI7MKQU05TEBgZr5NnwSuwTDHh2wUVb7zwoqPmlt31Nht9O4DG0a+mHX5ofMR/mOeoIkb1pycvMV6Zu0ULVuuCOhiENXjYDOWnCupSuR1N+5lu0eLEqHEmF7dAP7jU9L/CoyXfPx3WCvAi7pM2rgR76JhQSszpjqFvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=liusBrOX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EnWyntmp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KFARP1938997
	for <linux-wireless@vger.kernel.org>; Thu, 6 Nov 2025 01:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nifKokH76T4zhRjj5YF4AXC0b1BHwVNT0qMq0CzQleo=; b=liusBrOXso3jmETS
	0Lf/XVQqc8wIiIMhRLdgNp4HH8I4EBX++OlychevAtpZcfxSr5cBwG8AIG8/HGnH
	wA1SB37rIxORi4+N8/SrXcCunZoJtd396TVsyL50g0vqo2yXt7mJnm8FNzUnYyoG
	TGDi2D8XA7AcS1depkYsAAupVoKYLIHPiV8rVfZiEHpvFpseOokFxT8x6rTC4c17
	74B6MGOc6XZAtWre3dfdtw5EYyUSbE1flLZiU6RiymLo5nq/mHpuhG4XUAerDXG7
	VBF0Jeb2Dc69lkh8QiL8WV0bWjYzWBkXh1oO1Tx+VgG3GQp2d77B1IBwMIJzJDp8
	btQQqA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8apgsa6g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Nov 2025 01:41:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a4c4eeeef2so998859b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 05 Nov 2025 17:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762393272; x=1762998072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nifKokH76T4zhRjj5YF4AXC0b1BHwVNT0qMq0CzQleo=;
        b=EnWyntmpiFs4uDGd+WKE4ZqkvYeYScxTwttg6iL3GNY1i9PXRbD+ks7lg149QFYnL/
         bPlppgfOCxYohN+jAJUyE7Is/DcU+PrL38LmE3SBEkvCgcDjXFaDr45I0R8nOhbAG48a
         EuDarUV/TISp4p3Ilr+96GRvfIsTYgssMk1By7Zd5rHMLn6tghiF+DiUy6rKpeM+z80W
         ZeY4jsiXDeDdjJQg+mqAhwGMqj4ZocYQdp2Fmize8gQ5BDOzT4JhK+66ubrS0zS9FaH+
         7x0ro0g1N8dXbvSjR/lsGCVcn2AbQHYbvY265Nk53qi42AQ5A5Dy6tXqntSnv2i9VrPo
         OImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762393272; x=1762998072;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nifKokH76T4zhRjj5YF4AXC0b1BHwVNT0qMq0CzQleo=;
        b=OJjxET51CzC14R8AHWFEW32co8NnxDCVoLZ9xp4Qwc3ogGe8Upms2wcXiE3voeXci4
         5T9t8E6xq6z1pjsYp8GF0shWSmzjTS1gF7+6f8gRbGH3m2jfyzqW1s8Zj1BLM7KjCIYA
         LSWi1v3tSxNSlmMNYGzGKeX+XybGgSbxuVJ+031GaYIkZKR3QHQ0Rm61RXMuJRIMJbBF
         9e/y9hP7akAHKmYVlGe6olrIbg96ESl3314XgPAcpva1YiWI+ECeFQX2aZKxXnSLxSS7
         FUMYQ2JiGO5cvFeNvdIhHQyZnmK6undxEihkgcD6Pt5vdaHweoXMatAIf/auduveWDVY
         mG9g==
X-Gm-Message-State: AOJu0YzfSRxiNMSuBX1MaYEyOvo9cCqvZ2wy2hY/6Wpl9avMiqGPlIS8
	r43CWNV4r7PmMtOIch4xirj3VgEjhQLBehrcALq0VRRqnNdxv0RMdCA4L6babvs6BNz45rLz+cY
	zgeAg4aNSXC/G/08kpz2LEB11oYjeV/x8fXgPg1fwO9+SX1TnjRgb7F0wEX/Ry1JC9XD+2Q==
X-Gm-Gg: ASbGncvhcUV/Lm9PC+fl3tm7iXKiXwunK7cfzIsU+8XWDKa5jDpG4gONEkahw8zCocs
	jlkWyxmDj8eA6/CbIdNsCgIqpfRVT04KktmIu3R/qEtshbEgrZumfvDot+j/bC68+2Oi04+CL+2
	R7cVgwDt9iOhoY8NASInV+FQsaOZzjeSkIvJR0Xk0XG2YR+u4bvz7smBbf2yrOYNlT1REFnADX+
	uQujp/vdtQkWNsw4GsGdXMo/mSn8sLwWo9McMVuwkQO2lm2dN7CxeJo9H+N8lrP5kO1iZE13e1L
	AeD6e/ifdzjRnp3bYpdkanCHAVivZG1GmQ0Dbhl9ukPim2VmgvRhCQ4z9OtfDM49DVU9CelPL6z
	+cEVtcotcBE44AjTWJY0SyLaclPlHc5QFcTWcihFi5zYiawpL7CRIC1tXSiHZnjE3t6Qlrbnt
X-Received: by 2002:a05:6a00:331a:b0:7af:16f1:b47b with SMTP id d2e1a72fcca58-7af16f1b4f2mr3904414b3a.17.1762393272307;
        Wed, 05 Nov 2025 17:41:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKp2Ag5tdLM6RA+At3ZylLTVkpkx9WsAdiG9EmMuTwVQQsXwhKyho07oC6IOv2IKLftdAk4w==
X-Received: by 2002:a05:6a00:331a:b0:7af:16f1:b47b with SMTP id d2e1a72fcca58-7af16f1b4f2mr3904383b3a.17.1762393271770;
        Wed, 05 Nov 2025 17:41:11 -0800 (PST)
Received: from [10.133.33.172] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7f7569cbsm794275b3a.4.2025.11.05.17.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 17:41:11 -0800 (PST)
Message-ID: <bd5340d8-15e9-4fd3-8dab-baa68f06c9cd@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 09:41:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath11k: zero init info->status in
 wmi_process_mgmt_tx_comp()
To: Nicolas Escande <nico.escande@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251104083957.717825-1-nico.escande@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251104083957.717825-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAxMiBTYWx0ZWRfX0USSlYRrXKDU
 vvGpQniJWzdILOvkI45ycMui6RDeDMSyqZ0iJP7hAtvQsSgd3ej3lBzyB1hrR4ordp54Sp1nb6L
 4uWPQYRnzbj0UR+ZArwpp25JHbjWO4YNxUuPbcAe0lM/k2ZC4+6giONjQ7dvQQoL5npDpcdN1Ze
 AnOj7y7g6H/87Vn1Nt7AoChPCA6mZs4y0ijf1CyQ2H441ea4pYpm3uAh40U3lYGRFAU5J18g+v7
 Wn2hFHvrzlmsuRWrP4lGw+C6Vrr6tV78cKWq/pQjQBC96LzT9iOULbr2I6KYj03Umisc1Xnyee3
 7gwukOjZD9Yu84rDB/7ht8u21YivlaDKuZ5h1iOImuc+vkx8f64kXPngohhJ+1TUhDK+0kEoMVm
 7Od4p+vBFc7Xi+ECfz9GJnrh7ED1vA==
X-Authority-Analysis: v=2.4 cv=LoCfC3dc c=1 sm=1 tr=0 ts=690bfcb9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=Gipo2f9WZfF9FUe0tr0A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: Nb6zWQEEIoNrA3eSYWSap20kVTOaYpL2
X-Proofpoint-ORIG-GUID: Nb6zWQEEIoNrA3eSYWSap20kVTOaYpL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060012



On 11/4/2025 4:39 PM, Nicolas Escande wrote:
> When reporting tx completion using ieee80211_tx_status_xxx() familly of
> functions, the status part of the struct ieee80211_tx_info nested in the
> skb is used to report things like transmit rates & retry count to mac80211
> 
> On the TX data path, this is correctly memset to 0 before calling
> ieee80211_tx_status_ext(), but on the tx mgmt path this was not done.
> 
> This leads to mac80211 treating garbage values as valid transmit counters
> (like tx retries for example) and accounting them as real statistics that
> makes their way to userland via station dump.
> 
> The same issue was resolved in ath12k by commit 9903c0986f78 ("wifi:
> ath12k: Add memset and update default rate value in wmi tx completion")
> 
> Tested-on: QCN9074 PCI WLAN.HK.2.9.0.1-01977-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>  drivers/net/wireless/ath/ath11k/wmi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
> index edff6fb61344..110035dae8a6 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -5967,6 +5967,9 @@ static int wmi_process_mgmt_tx_comp(struct ath11k *ar,
>  	dma_unmap_single(ar->ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
>  
>  	info = IEEE80211_SKB_CB(msdu);
> +	memset(&info->status, 0, sizeof(info->status));
> +	info->status.rates[0].idx = -1;
> +
>  	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) &&
>  	    !tx_compl_param->status) {
>  		info->flags |= IEEE80211_TX_STAT_ACK;

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

