Return-Path: <linux-wireless+bounces-27723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08AABAB282
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 05:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6583AE0B6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 03:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9533A8F7;
	Tue, 30 Sep 2025 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G60IGFpU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344F227BB9
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759203049; cv=none; b=bchoX7gJURmKb4UymJls80k9Np1ixKO+PM/wzJZTJ76mD1oPs/zjgL02zZLX99B9fxE3tfJSuhfkP1OCm2iGtd75AlYRXdcoSJRJGDylwrwkr+oMCNHcL7yswEqvePMfqBo9+BPALCugqN+SmufSzfhgwWJQfjvgDfk2vnlgSks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759203049; c=relaxed/simple;
	bh=z+n1UseQZdPo8eMKQ/Om3u92r2Xk/lFFOx56kYCQXhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLZKvVryVfPZbg8T9mrVUL9JKeleux2l/KkHXloY95B2Ng28rR+njkDEkFY7qgxkanhTwHbXY8152/j+uOrs3ay6/qOP3XduOtnXTvH5sL7C3tv/+jJ61HJn1m1QVp81fFBwKUXIF0Ask2K4AMemZFuC1DJHjUPFCyKXU3NE6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G60IGFpU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TI13mM028756
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 03:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	brOCBlDY46dipdDeXww+agPSZ1wAHzxnSZuPebl2Evc=; b=G60IGFpUxhePuAQd
	lD8Yt6zSeqPGYefdVJTT7fu0WG6Xlo0ePeFyErGp9knGLLxmfUS3uGRvo9rwb3dp
	ejqTDuNAGMKpYW5Mw5DVDixMSYr8dl76JhTDhek8OgUcBM45XIJVc/uzlGLDMY6Y
	65qqiOfnnDmZKPeEOKKEYkL7S5MCfQrtMsjk3qhoKS8Py1kg3PN/O0QydZMHru5C
	2Tvau76GtzZk054Y+ok+MEsFk60sZ8J+GXdPfhhYAaymlL9soJXtMXww1Qhwu4Wj
	/LwNro4vqRu8timwbC6oB1gpGt+BQSTYvxb0pzE3Wh2G1IBoBUQBUrJtRkYgSmWB
	QPZX3g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tqju2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 03:30:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-336b9f3b5b0so2943374a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 20:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759203045; x=1759807845;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brOCBlDY46dipdDeXww+agPSZ1wAHzxnSZuPebl2Evc=;
        b=BVqTmy7nYA22fNL/41BA1txl0JL6VnUVptcxgHxL2Ky2z3uY8gbI+SLw6gCbtMOXUW
         u9SniwpjYGA1Y49fVBwh44SnAI+NPZGp9ZOt9NDGpqJGHG93hes+lYazVu/CI40npSde
         ngZTWuv7DtYv29Mn5GxKX66zhdcz/Xh4RvPxz3Z9vTdQEKdrkJ/cVaQN39W91wn2KLfa
         eC7Ow5Q0z20tGHyohnx4gkAS03U+AKqzRMbNdxyX2JQre7OTA7Vwl+nagkocHTrQmmyQ
         +AcZ4++dzj+zOxLHqVYQQZAnS4EvXL6cao3Yk1GwfH7BEPoJr09gpjYJ3WZhYEMz31cL
         wtOA==
X-Gm-Message-State: AOJu0YwrZxk7qrwZFf1x0dD0OIE9Y3gbUCIBJte8q7+uSVyDYdMC3OUV
	bQBXGyqKwXPJs8j1eZbVfnDyTXH19z7EZYCr6G3ALVrqNkP/CayHS0UFtygUX8ACovNB76FBfdE
	e+/vYxGVkElJZTexiahKKdP9cY4sh8MmHp276KCtNNKFpJJgyO856ikq36kNFsTmeag0aCA==
X-Gm-Gg: ASbGncv2hOzIs2+FdJ7KFzCOcimpzbjIzgXu9CuFd4beiH4w0ShyCE8hNtW9OpNrWtc
	lA+sTVl8zhz2f6IxywwYI07Rq9pdJrTzlPNHf3Qv/B0Xyr2VReqU/jbS7mt8W3MwY5ync/B2F1K
	LIn690WMI84vabbpz0bBYk4vnCDbJ9MYyvDjjnpTwZSBreH+f87PuIwfm6h8VMJtxqvJwjBgcmD
	Su1Z5AMteo2a4mnspUQ6n5b2L89RaXY+S1qFl952eXZFiDk8xIQIZ5sZmEaoBXs3S31r0r3Auhj
	4wQr2yxxpP2cNzVxUZf8W5YRR2aakqIqA5xe+H6agm+dhh4LODyb/0wU/4zhrYaEUWa2e7tJv4M
	EBz2LoXNSO1lhaPZ6Rye2NoAnZ+3iNcknFiD99wf1wgE=
X-Received: by 2002:a17:90a:bf0f:b0:32e:3830:65d5 with SMTP id 98e67ed59e1d1-3342a3013e9mr12967915a91.36.1759203045409;
        Mon, 29 Sep 2025 20:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmzhRm2yKLf/LvWqB19YTdagnUlAt9ONjeSefFwwWs0m/ewON8e9U8J7qVNQgu1b69BzaRng==
X-Received: by 2002:a17:90a:bf0f:b0:32e:3830:65d5 with SMTP id 98e67ed59e1d1-3342a3013e9mr12967895a91.36.1759203044884;
        Mon, 29 Sep 2025 20:30:44 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd90327sm18797359a91.3.2025.09.29.20.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 20:30:44 -0700 (PDT)
Message-ID: <39facf12-c452-4fa4-9b76-3da6a0ce3230@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:30:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng v3 6/6] wifi: ath12k: Refactor ath12k_vif
 structure
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250929115102.512719-1-quic_rdeuri@quicinc.com>
 <20250929115102.512719-7-quic_rdeuri@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250929115102.512719-7-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfXwatay/3IkPZf
 Kgxq9PeoPTn9pHRpMMQCGcH2tN9W6mQYI5ePRjDe7RryyPtsVxmLWcL8ogl95Iv0HcoAb6nUXWm
 1a5ce/NKXdaMCjtSrAYEkmFTKe+v0ZCwLCm/7+L0qByhHzuxMvNGkzGWBb5ENzFMHXwNvyCeKPC
 HoGxBkKXoB52aGp5y0junvyHdUBvHzpsM9oCz2dUJWRSazpYsuuajS9RKsdjvr9nihXbdllCBj5
 ykB5BhBB0SEkIOnJSajXSjnnmKd9hE64MWdwaoOwciIZxHQXJTO7kT5rD6wOMQlVvOshfd7eTsF
 VTYMF/hLWCr8w7zwBALA6EvcB17v86rrKvaheA1bPZ+iUA4EevwLCisq4QOY3NtNpxs72287xVz
 9lF77z14hgFFeK5bnVWb+MT5hqKc2w==
X-Proofpoint-GUID: FyNJZCf8ZCjPynZZAHPP5qhq31rO54b6
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68db4ee6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=P2Nd2P8nHlY44GcJbF0A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: FyNJZCf8ZCjPynZZAHPP5qhq31rO54b6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029



On 9/29/2025 7:51 PM, Ripan Deuri wrote:

> @@ -938,15 +944,19 @@ int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
>  
>  static void ath12k_dp_update_vdev_search(struct ath12k_link_vif *arvif)
>  {
> +	u8 link_id = arvif->link_id;
> +	struct ath12k_vif *ahvif = arvif->ahvif;
> +	struct ath12k_dp_link_vif *dp_link_vif = &ahvif->dp_vif.dp_link_vif[link_id];

nit: consistently use ath12k_dp_vif_to_dp_link_vif()

> +
>  	switch (arvif->ahvif->vdev_type) {
>  	case WMI_VDEV_TYPE_STA:
> -		arvif->hal_addr_search_flags = HAL_TX_ADDRY_EN;
> -		arvif->search_type = HAL_TX_ADDR_SEARCH_INDEX;
> +		dp_link_vif->hal_addr_search_flags = HAL_TX_ADDRY_EN;
> +		dp_link_vif->search_type = HAL_TX_ADDR_SEARCH_DEFAULT;
>  		break;
>  	case WMI_VDEV_TYPE_AP:
>  	case WMI_VDEV_TYPE_IBSS:
> -		arvif->hal_addr_search_flags = HAL_TX_ADDRX_EN;
> -		arvif->search_type = HAL_TX_ADDR_SEARCH_DEFAULT;
> +		dp_link_vif->hal_addr_search_flags = HAL_TX_ADDRX_EN;
> +		dp_link_vif->search_type = HAL_TX_ADDR_SEARCH_DEFAULT;
>  		break;
>  	case WMI_VDEV_TYPE_MONITOR:
>  	default:

[...]

> @@ -318,12 +318,14 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
>  		       struct ath12k_wmi_peer_create_arg *arg)
>  {
>  	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
> +	struct ath12k_vif *ahvif = arvif->ahvif;
>  	struct ath12k_link_sta *arsta;
>  	u8 link_id = arvif->link_id;
>  	struct ath12k_peer *peer;
>  	struct ath12k_sta *ahsta;
>  	u16 ml_peer_id;
>  	int ret;
> +	struct ath12k_dp_link_vif *dp_link_vif = &ahvif->dp_vif.dp_link_vif[link_id];

same here, use ath12k_dp_vif_to_dp_link_vif()

>  
>  	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
>  



