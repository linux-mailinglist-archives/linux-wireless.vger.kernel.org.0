Return-Path: <linux-wireless+bounces-27666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E02BA2BFE
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 09:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814F21C0023A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 07:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C69299A94;
	Fri, 26 Sep 2025 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dd4lYgso"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A828C5AA
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871638; cv=none; b=GALtE7W+tFwdjhk2+PCm0585V7R8IkCYA220XwWHoYKOxsCyXYQ1Z4MPXzmxyksNfRF8d626y537gLqdXXcdGf7a9eeP+BIamyEECLHfkl0YCBz4PvbnRR8k6LNGsSV6HWMWC5AEOpztREnZbBGJOWu5Ld1oOvCrVqSdrZu/d8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871638; c=relaxed/simple;
	bh=RFJ20F/VsXsw+YV4x6PONqPe0lWq9NVW41q2auQeC4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpVf91AN51JzM7T9TEcboYwv1tV+5LeiWvmgm5QgSfnyrZdB4lLxrKEQGFFi/8599VQg6A/KK16Dwv+2WWO1JH3epTHdtLkwAuxPBTL0GJwBsPfXFH38vF7XII6sEAaXvUKvFEwFHz1hqgTw0uDckl70+6BYkRjw7+cloUap/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dd4lYgso; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q6jYau005850
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 07:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mRTTMC10gW7pg7wc4jjHUj9XGpKgR6moGigWHXu5GPQ=; b=Dd4lYgsoSUd3eeKF
	Ll4BxuoLxJXk06YdjCF6ZXub0O0QEqhTB90+D6PWqJ/wlK4BaRy6ZvqJUK2rXp6J
	Tp1aBcbqZs2Ge9FBMufmB2NlA4JyJFJ3BjY42GmSkd8gy+7utU7Se4AAhEdVDQqq
	9hgIL5GkMWUISBmgO8Ibdrwbzd+75ZLFih//nfV2gv7mxNna4rnnzQPEaMnPjVvl
	dvZLGHTZ+sxSrvwYWWyb0HP0dC+Tmr+cP+IHFIvU39otgPNEScZrZvpJN0KAcQOw
	kBKe+qR1I3YEyo+ShxiTrZPPmdEK3uRGOpe0q9K1cv9SnHQJZs3N8/akjjPq8gWw
	TtH/pA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db321vp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 07:27:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b57c2371182so1752739a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 00:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871634; x=1759476434;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRTTMC10gW7pg7wc4jjHUj9XGpKgR6moGigWHXu5GPQ=;
        b=QP/ZCno9shuut888sx7T8WmLy53DCS9bqHjNwFvZOL/0jw9fMiB53RelsGmtwsNkyh
         fVKD5bmG2CZ8TY7X8MKfblaO/wpzDv38wbHwQJM6+4ccvv2bX6eOguVLqhqDLH9RcHWV
         iNO4NCUqnnDdoO/uXMrBWnsnR3lUHLZsYS0YsfV2sMqhY5p+/Km0wCdJoOok6DtGCEQu
         1Ozf0cOjG+I8pqGTtUB5deT5Cd8zohhvw7wzXZiI7bh5igULKkp2zFN1BzzRwyyopWD2
         YClhORYWnxhlaPpWLx725bSYMJTyH0fM1RQcFaQR7c9H7Fhw1TTD5zgivdB+cBxTzVtj
         6lUg==
X-Gm-Message-State: AOJu0Yxt57yASs4kx8dh8K6mTFwJrOV0aFrarhb1mfgtI2WniP0Du3OD
	XdKWD8GOLptAoTLJq0CX++MXwP9A0F/SVLo630+pw+nh+qh++uHlut3SOv6RK2SR/Y9Du4kExXp
	AOF2uNaMXBFuZmBaduzgU0exeNsGEDCKwtERWnI/h1jJhMUWM49ZImUDKrhcfFNNxW3tf1Q==
X-Gm-Gg: ASbGncs+m+MkAy2eIo7KuGjTu9jtH0eF8THddtJVtK42AC9A8DlQR78JgBx6+HQlfK8
	36Y6EPdVzZ0dPwg/rRHXHUjEhJfGbi33Yf0gkuC7mLg8IaWi1fHkV6cxMrvp5KO7inN7rCz5+Fc
	0CPxqBimNUhkipal3bThxv1SB35eJunDcNH5S0LIUQPk12vzJPo/uHwlmLqvbkeK5SIhSkL9MvN
	xcqnLham2F5liuy+5nN6vOyHCeVtmKiwykENxHHMyYuXN9vnglKHqsZqAymvZV5Mu6LlaVtJnzq
	DV+IWzQLOOg6kXZAOqsQ00NThJDkdwBSej5qvynWgouhEfvpjvN4Uii6KWxiBMcOJVvBqxtSEuL
	1cmSuWEIJ/BDs2jNpxwQbgno4zkhsYYJ6NhMjQQ==
X-Received: by 2002:a05:6a20:7f98:b0:2b0:ff55:f830 with SMTP id adf61e73a8af0-2e7d9411f54mr6839651637.51.1758871634274;
        Fri, 26 Sep 2025 00:27:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1YmHQPNhEyp2ELtAqGOqtH3wPgpV+noxsscF3YY5NGTaiC84YxbqpHzs5+Gt61tFNcrrrsQ==
X-Received: by 2002:a05:6a20:7f98:b0:2b0:ff55:f830 with SMTP id adf61e73a8af0-2e7d9411f54mr6839627637.51.1758871633793;
        Fri, 26 Sep 2025 00:27:13 -0700 (PDT)
Received: from [10.133.33.196] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53cb975sm4046472a12.18.2025.09.26.00.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 00:27:13 -0700 (PDT)
Message-ID: <04b2d56e-7b1d-4ceb-9479-3ad97cb7132a@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 15:27:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng v2 5/6] wifi: ath12k: Add framework for hardware
 specific DP interrupt registration
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250926052218.893876-1-quic_rdeuri@quicinc.com>
 <20250926052218.893876-6-quic_rdeuri@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250926052218.893876-6-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ao6/yCZV c=1 sm=1 tr=0 ts=68d64053 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=LDVpCoHNsb-ULt4mha4A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Vc0xb0FXxqoWS2bbDLMIdiH73nj6oahy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfX0wN5EQ+s/rTs
 aLWsLi3hQA+Ha7CAdvg/eVMwAgHs8JD31z6sWL7BbLPe+/NMi/CI6BWKGGWaSVZeXjZNFZaC/CL
 MQ0ApbOhPDwAnX04ZXUgZ7r4dvYNy7YbU2UhVJ0XFEBwQOeOcM3BsB+neNapSyzHn33T/AMYZZi
 pogEtSjSRP76djgxDum2exFvpjPsuWXM0Xl8hGYENHXyRuDoz0VxMgPLz838KGLBYb+qO9nlinR
 UNzJ3dEcrs+QugxUq1eSTR3/Gg/QT6+Yf6LbpwpovJmwPeQeKWqrkmcBxd7altJwf9M0EeEdohq
 +he3WqamJyBMjVl5YhcY0oO3BQrMQ6ujKYKsxOJavhtwD++z1pZpQqZSAZycNYPaC3Ad58jLGWx
 w8OaYNRP6fISyucqyUctOtjxw7iwFQ==
X-Proofpoint-GUID: Vc0xb0FXxqoWS2bbDLMIdiH73nj6oahy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172



On 9/26/2025 1:22 PM, Ripan Deuri wrote:
> Currently, the DP service SRNG handler is invoked directly from the NAPI
> poll handler, which prevents using different handlers for different
> architectures. To fix this, introduce a framework that allows registering
> architecture-specific service SRNG handlers.
> 
> Also, add PCI and AHB hif_ops to manage IRQ setup and cleanup from DP.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/ahb.c      | 16 +++++++-----
>  drivers/net/wireless/ath/ath12k/core.h     |  3 +++
>  drivers/net/wireless/ath/ath12k/hif.h      | 30 +++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/pci.c      | 23 +++++++++--------
>  drivers/net/wireless/ath/ath12k/wifi7/dp.c | 20 ++++++++++++---
>  drivers/net/wireless/ath/ath12k/wifi7/dp.h |  2 --
>  6 files changed, 71 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
> index c545bea18935..4bacdaa62f83 100644
> --- a/drivers/net/wireless/ath/ath12k/ahb.c
> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
> @@ -524,10 +524,9 @@ static int ath12k_ahb_ext_grp_napi_poll(struct napi_struct *napi, int budget)
>  	struct ath12k_ext_irq_grp *irq_grp = container_of(napi,
>  						struct ath12k_ext_irq_grp,
>  						napi);
> -	struct ath12k_base *ab = irq_grp->ab;
>  	int work_done;
>  
> -	work_done = ath12k_wifi7_dp_service_srng(ab, irq_grp, budget);
> +	work_done = irq_grp->irq_handler(irq_grp->dp, irq_grp, budget);
>  	if (work_done < budget) {
>  		napi_complete_done(napi, work_done);
>  		ath12k_ahb_ext_grp_enable(irq_grp);
> @@ -553,7 +552,12 @@ static irqreturn_t ath12k_ahb_ext_interrupt_handler(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> -static int ath12k_ahb_config_ext_irq(struct ath12k_base *ab)
> +static int
> +ath12k_ahb_config_ext_irq(struct ath12k_base *ab,
> +			  int (*irq_handler)(struct ath12k_dp *dp,
> +					     struct ath12k_ext_irq_grp *irq_grp,
> +					     int budget),
> +			  struct ath12k_dp *dp)
>  {
>  	const struct ath12k_hw_ring_mask *ring_mask;
>  	struct ath12k_ext_irq_grp *irq_grp;
> @@ -569,6 +573,8 @@ static int ath12k_ahb_config_ext_irq(struct ath12k_base *ab)
>  
>  		irq_grp->ab = ab;
>  		irq_grp->grp_id = i;
> +		irq_grp->irq_handler = irq_handler;
> +		irq_grp->dp = dp;
>  
>  		irq_grp->napi_ndev = alloc_netdev_dummy(0);
>  		if (!irq_grp->napi_ndev)
> @@ -652,9 +658,6 @@ static int ath12k_ahb_config_irq(struct ath12k_base *ab)
>  		ab->irq_num[irq_idx] = irq;
>  	}
>  
> -	/* Configure external interrupts */
> -	ret = ath12k_ahb_config_ext_irq(ab);
> -
>  	return ret;
>  }
>  
> @@ -702,6 +705,7 @@ static const struct ath12k_hif_ops ath12k_ahb_hif_ops = {
>  	.map_service_to_pipe = ath12k_ahb_map_service_to_pipe,
>  	.power_up = ath12k_ahb_power_up,
>  	.power_down = ath12k_ahb_power_down,
> +	.ext_irq_setup = ath12k_ahb_config_ext_irq,
>  };
>  
>  static irqreturn_t ath12k_userpd_irq_handler(int irq, void *data)
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index ff99d5ae6226..6a36dfdf5b17 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -166,6 +166,7 @@ enum ath12k_firmware_mode {
>  #define ATH12K_MAX_TCL_RING_NUM	3
>  
>  struct ath12k_ext_irq_grp {
> +	struct ath12k_dp *dp;
>  	struct ath12k_base *ab;
>  	u32 irqs[ATH12K_EXT_IRQ_NUM_MAX];
>  	u32 num_irq;
> @@ -174,6 +175,8 @@ struct ath12k_ext_irq_grp {
>  	bool napi_enabled;
>  	struct napi_struct napi;
>  	struct net_device *napi_ndev;
> +	int (*irq_handler)(struct ath12k_dp *dp,
> +			   struct ath12k_ext_irq_grp *irq_grp, int budget);

commit message says IRQ handler is architiecture specific, then why not put it in
ath12k_dp_arch_ops? Replicating irq_handler in each irq_grp seems kind of waste.

>  };
>  
>  enum ath12k_smbios_cc_type {
> diff --git a/drivers/net/wireless/ath/ath12k/hif.h b/drivers/net/wireless/ath/ath12k/hif.h
> index e8840fab6061..1f9781f6d564 100644
> --- a/drivers/net/wireless/ath/ath12k/hif.h
> +++ b/drivers/net/wireless/ath/ath12k/hif.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>  /*
>   * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
>  #ifndef ATH12K_HIF_H
> @@ -32,6 +32,12 @@ struct ath12k_hif_ops {
>  	void (*get_ce_msi_idx)(struct ath12k_base *ab, u32 ce_id, u32 *msi_idx);
>  	int (*panic_handler)(struct ath12k_base *ab);
>  	void (*coredump_download)(struct ath12k_base *ab);
> +	int (*ext_irq_setup)(struct ath12k_base *ab,
> +			     int (*handler)(struct ath12k_dp *dp,
> +					    struct ath12k_ext_irq_grp *irq_grp,
> +					    int budget),
> +			     struct ath12k_dp *dp);
> +	void (*ext_irq_cleanup)(struct ath12k_base *ab);
>  };
>  
>  static inline int ath12k_hif_map_service_to_pipe(struct ath12k_base *ab, u16 service_id,
> @@ -162,4 +168,26 @@ static inline void ath12k_hif_coredump_download(struct ath12k_base *ab)
>  	if (ab->hif.ops->coredump_download)
>  		ab->hif.ops->coredump_download(ab);
>  }
> +
> +static inline
> +int ath12k_hif_ext_irq_setup(struct ath12k_base *ab,
> +			     int (*irq_handler)(struct ath12k_dp *dp,
> +						struct ath12k_ext_irq_grp *irq_grp,
> +						int budget),
> +			     struct ath12k_dp *dp)
> +{
> +	if (!ab->hif.ops->ext_irq_setup)
> +		return -EOPNOTSUPP;
> +
> +	return ab->hif.ops->ext_irq_setup(ab, irq_handler, dp);
> +}
> +
> +static inline void ath12k_hif_ext_irq_cleanup(struct ath12k_base *ab)
> +{
> +	if (!ab->hif.ops->ext_irq_cleanup)
> +		return;
> +
> +	ab->hif.ops->ext_irq_cleanup(ab);
> +}
> +
>  #endif /* ATH12K_HIF_H */
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 672cf2899681..a28bea5c1d40 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -319,8 +319,6 @@ static void ath12k_pci_free_irq(struct ath12k_base *ab)
>  		irq_idx = ATH12K_PCI_IRQ_CE0_OFFSET + i;
>  		free_irq(ab->irq_num[irq_idx], &ab->ce.ce_pipe[i]);
>  	}
> -
> -	ath12k_pci_free_ext_irq(ab);
>  }
>  
>  static void ath12k_pci_ce_irq_enable(struct ath12k_base *ab, u16 ce_id)
> @@ -478,11 +476,10 @@ static int ath12k_pci_ext_grp_napi_poll(struct napi_struct *napi, int budget)
>  	struct ath12k_ext_irq_grp *irq_grp = container_of(napi,
>  						struct ath12k_ext_irq_grp,
>  						napi);
> -	struct ath12k_base *ab = irq_grp->ab;
>  	int work_done;
>  	int i;
>  
> -	work_done = ath12k_wifi7_dp_service_srng(ab, irq_grp, budget);
> +	work_done = irq_grp->irq_handler(irq_grp->dp, irq_grp, budget);
>  	if (work_done < budget) {
>  		napi_complete_done(napi, work_done);
>  		for (i = 0; i < irq_grp->num_irq; i++)
> @@ -517,7 +514,12 @@ static irqreturn_t ath12k_pci_ext_interrupt_handler(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> -static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
> +static
> +int ath12k_pci_ext_irq_config(struct ath12k_base *ab,
> +			      int (*irq_handler)(struct ath12k_dp *dp,
> +						 struct ath12k_ext_irq_grp *irq_grp,
> +						 int budget),
> +			      struct ath12k_dp *dp)
>  {
>  	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
>  	int i, j, n, ret, num_vectors = 0;
> @@ -538,6 +540,8 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
>  
>  		irq_grp->ab = ab;
>  		irq_grp->grp_id = i;
> +		irq_grp->irq_handler = irq_handler;
> +		irq_grp->dp = dp;
>  		irq_grp->napi_ndev = alloc_netdev_dummy(0);
>  		if (!irq_grp->napi_ndev) {
>  			ret = -ENOMEM;
> @@ -651,10 +655,6 @@ static int ath12k_pci_config_irq(struct ath12k_base *ab)
>  		ath12k_pci_ce_irq_disable(ab, i);
>  	}
>  
> -	ret = ath12k_pci_ext_irq_config(ab);
> -	if (ret)
> -		return ret;
> -
>  	return 0;
>  }
>  
> @@ -1483,6 +1483,8 @@ static const struct ath12k_hif_ops ath12k_pci_hif_ops = {
>  #ifdef CONFIG_ATH12K_COREDUMP
>  	.coredump_download = ath12k_pci_coredump_download,
>  #endif
> +	.ext_irq_setup = ath12k_pci_ext_irq_config,
> +	.ext_irq_cleanup = ath12k_pci_free_ext_irq,
>  };
>  
>  static enum ath12k_device_family
> @@ -1691,6 +1693,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
>  	ath12k_fw_unmap(ab);
>  	ath12k_mhi_unregister(ab_pci);
>  
> +	ab_pci->device_family_ops->arch_deinit(ab);
>  	ath12k_pci_free_irq(ab);
>  	ath12k_pci_msi_free(ab_pci);
>  	ath12k_pci_free_region(ab_pci);
> @@ -1698,8 +1701,6 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
>  	ath12k_hal_srng_deinit(ab);
>  	ath12k_ce_free_pipes(ab);
>  
> -	ab_pci->device_family_ops->arch_deinit(ab);
> -
>  	ath12k_core_free(ab);
>  }
>  
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
> index adc3480b282b..df9696549d06 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
> @@ -10,13 +10,15 @@
>  #include "../dp_mon.h"
>  #include "../dp_cmn.h"
>  #include "dp_rx.h"
> +#include "../hif.h"
>  #include "dp.h"
>  #include "dp_tx.h"
>  
> -int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
> -				 struct ath12k_ext_irq_grp *irq_grp,
> -				 int budget)
> +static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
> +					struct ath12k_ext_irq_grp *irq_grp,
> +					int budget)
>  {
> +	struct ath12k_base *ab = dp->ab;
>  	struct napi_struct *napi = &irq_grp->napi;
>  	int grp_id = irq_grp->grp_id;
>  	int work_done = 0;
> @@ -138,6 +140,7 @@ int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
>  struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab)
>  {
>  	struct ath12k_dp *dp;
> +	int ret;
>  
>  	/* TODO: align dp later if cache alignment becomes a bottleneck */
>  	dp = kzalloc(sizeof(*dp), GFP_KERNEL);
> @@ -148,12 +151,23 @@ struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab)
>  	dp->dev = ab->dev;
>  	dp->hw_params = ab->hw_params;
>  
> +	ret = ath12k_hif_ext_irq_setup(dp->ab, ath12k_wifi7_dp_service_srng, dp);
> +	if (ret) {
> +		ath12k_err(ab, "failed to setup ext irq, ret %d", ret);
> +		goto free_dp;
> +	}
> +
>  	return dp;
> +
> +free_dp:
> +	kfree(dp);
> +	return NULL;
>  }
>  EXPORT_SYMBOL(ath12k_wifi7_dp_device_alloc);
>  
>  void ath12k_wifi7_dp_device_free(struct ath12k_dp *dp)
>  {
> +	ath12k_hif_ext_irq_cleanup(dp->ab);
>  	kfree(dp);
>  }
>  EXPORT_SYMBOL(ath12k_wifi7_dp_device_free);
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.h b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
> index 2300fda65786..72fdfb368c99 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
> @@ -13,8 +13,6 @@
>  struct ath12k_base;
>  struct ath12k_dp;
>  
> -int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
> -				 struct ath12k_ext_irq_grp *irq_grp, int budget);
>  struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab);
>  void ath12k_wifi7_dp_device_free(struct ath12k_dp *dp);
>  


