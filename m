Return-Path: <linux-wireless+bounces-21780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB47CA94B13
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713FC1888AD0
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD018256C6C;
	Mon, 21 Apr 2025 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dDKngCLw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C92561D7;
	Mon, 21 Apr 2025 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202956; cv=none; b=FtEiIXcVveABfhCBUpyQM0L9VZ9RYjej3q+jAcIaRcYUz3/450wKJOmUhCHxPxUaSab7L+HvXQdul1jC6oxPqfzePsJgaGs0QPRsLsVixzYMrwwW6mREOr9TDJxXmK6czesp7MVwaurw7YpMOJSLuYkpZa1ZZ9K4Xvj1jRJSvA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202956; c=relaxed/simple;
	bh=I7MKXNrfG2zqbTtsaLm3rf3loAJb0LPM7GdDSe9SxsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=brV7rFo/2sYavPB3qguD0F6sTCgRlCH9mQtOrNdIC/EkzAOWIGd8rtwccfh4hU6C3gyKDI1yw+kLEiCkIHBxj9J3Qhs8FhDhy5vG+Ra/ZMjbcxojaMxKShgrvhoyGwCN2V0LoZE9neU0GHrgWAgYs5XWfT27Wu+NMqMofCMfK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dDKngCLw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53L00i3J007848;
	Mon, 21 Apr 2025 02:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rDhN8/o/jwW0pjOarVpaVBL+AtxtduMrkf0Ndv/LEN4=; b=dDKngCLwI3nCVJjU
	+zH8tAhlUOiTi/Nvc9KBQRtIsiw5/lsdGjqmKay1KUH4vNOct2h1iqKw1WRVvojA
	WJYfFnlOIVEzMtJ1qW2m7rqH88up9xWt6VVDefRVZqbLHXe+8pMUeC0gl/Ya8N45
	x4tKR2vHM0epuYriA4t6YJbb5Td03eQtcQgGxbRbyqybVObjSEQDYxUAT6lD+2qj
	0ed+hBRA//hqgS6v9gYEfYDfeG9R4do5H6faDXo3OJ/bEygOhz/W1h1K5wbwfo6X
	gLhBTehsobqruM7P9vTZ52bbpaeSy0ISeUA85/KIQTp/sH64PAJ4aTxFBAAhcwYE
	TRtwlw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46454bjpuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 02:35:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53L2ZmrU008172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 02:35:48 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 20 Apr
 2025 19:35:46 -0700
Message-ID: <e4477f1b-6d87-4715-b768-717173fbda0d@quicinc.com>
Date: Mon, 21 Apr 2025 10:35:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: Constify structures in hw.c
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>
References: <504b4d5276d13f5f9c3bffcfdaf244006312c22b.1745051315.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <504b4d5276d13f5f9c3bffcfdaf244006312c22b.1745051315.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=cdrSrmDM c=1 sm=1 tr=0 ts=6805af05 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=eY5I1qcjwe6lrjljmsoA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NOxxnUuqgh4JZRF64RiqHaHhctHPefng
X-Proofpoint-GUID: NOxxnUuqgh4JZRF64RiqHaHhctHPefng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210018



On 4/19/2025 4:29 PM, Christophe JAILLET wrote:
> Structures defined in hw.c are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   10357	    951	      0	  11308	   2c2c	drivers/net/wireless/ath/ath10k/hw.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   11125	    203	      0	  11328	   2c40	drivers/net/wireless/ath/ath10k/hw.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> ---
>  drivers/net/wireless/ath/ath10k/ce.c | 28 ++++++-------
>  drivers/net/wireless/ath/ath10k/hw.c | 62 ++++++++++++++--------------
>  drivers/net/wireless/ath/ath10k/hw.h | 34 ++++++++-------
>  3 files changed, 64 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
> index afae4a8027f8..c6ee0cbb58e2 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.c
> +++ b/drivers/net/wireless/ath/ath10k/ce.c
> @@ -80,7 +80,7 @@ static inline u32 shadow_sr_wr_ind_addr(struct ath10k *ar,
>  
>  static inline unsigned int
>  ath10k_set_ring_byte(unsigned int offset,
> -		     struct ath10k_hw_ce_regs_addr_map *addr_map)
> +		     const struct ath10k_hw_ce_regs_addr_map *addr_map)
>  {
>  	return ((offset << addr_map->lsb) & addr_map->mask);
>  }
> @@ -203,7 +203,7 @@ static inline void ath10k_ce_src_ring_dmax_set(struct ath10k *ar,
>  					       u32 ce_ctrl_addr,
>  					       unsigned int n)
>  {
> -	struct ath10k_hw_ce_ctrl1 *ctrl_regs = ar->hw_ce_regs->ctrl1_regs;
> +	const struct ath10k_hw_ce_ctrl1 *ctrl_regs = ar->hw_ce_regs->ctrl1_regs;
>  
>  	u32 ctrl1_addr = ath10k_ce_read32(ar, ce_ctrl_addr +
>  					  ctrl_regs->addr);
> @@ -217,7 +217,7 @@ static inline void ath10k_ce_src_ring_byte_swap_set(struct ath10k *ar,
>  						    u32 ce_ctrl_addr,
>  						    unsigned int n)
>  {
> -	struct ath10k_hw_ce_ctrl1 *ctrl_regs = ar->hw_ce_regs->ctrl1_regs;
> +	const struct ath10k_hw_ce_ctrl1 *ctrl_regs = ar->hw_ce_regs->ctrl1_regs;
>  
>  	u32 ctrl1_addr = ath10k_ce_read32(ar, ce_ctrl_addr +
>  					  ctrl_regs->addr);
> @@ -231,7 +231,7 @@ static inline void ath10k_ce_dest_ring_byte_swap_set(struct ath10k *ar,
>  						     u32 ce_ctrl_addr,
>  						     unsigned int n)
>  {
> -	struct ath10k_hw_ce_ctrl1 *ctrl_regs = ar->hw_ce_regs->ctrl1_regs;
> +	const struct ath10k_hw_ce_ctrl1 *ctrl_regs = ar->hw_ce_regs->ctrl1_regs;
>  
>  	u32 ctrl1_addr = ath10k_ce_read32(ar, ce_ctrl_addr +
>  					  ctrl_regs->addr);
> @@ -313,7 +313,7 @@ static inline void ath10k_ce_src_ring_highmark_set(struct ath10k *ar,
>  						   u32 ce_ctrl_addr,
>  						   unsigned int n)
>  {
> -	struct ath10k_hw_ce_dst_src_wm_regs *srcr_wm = ar->hw_ce_regs->wm_srcr;
> +	const struct ath10k_hw_ce_dst_src_wm_regs *srcr_wm = ar->hw_ce_regs->wm_srcr;
>  	u32 addr = ath10k_ce_read32(ar, ce_ctrl_addr + srcr_wm->addr);
>  
>  	ath10k_ce_write32(ar, ce_ctrl_addr + srcr_wm->addr,
> @@ -325,7 +325,7 @@ static inline void ath10k_ce_src_ring_lowmark_set(struct ath10k *ar,
>  						  u32 ce_ctrl_addr,
>  						  unsigned int n)
>  {
> -	struct ath10k_hw_ce_dst_src_wm_regs *srcr_wm = ar->hw_ce_regs->wm_srcr;
> +	const struct ath10k_hw_ce_dst_src_wm_regs *srcr_wm = ar->hw_ce_regs->wm_srcr;
>  	u32 addr = ath10k_ce_read32(ar, ce_ctrl_addr + srcr_wm->addr);
>  
>  	ath10k_ce_write32(ar, ce_ctrl_addr + srcr_wm->addr,
> @@ -337,7 +337,7 @@ static inline void ath10k_ce_dest_ring_highmark_set(struct ath10k *ar,
>  						    u32 ce_ctrl_addr,
>  						    unsigned int n)
>  {
> -	struct ath10k_hw_ce_dst_src_wm_regs *dstr_wm = ar->hw_ce_regs->wm_dstr;
> +	const struct ath10k_hw_ce_dst_src_wm_regs *dstr_wm = ar->hw_ce_regs->wm_dstr;
>  	u32 addr = ath10k_ce_read32(ar, ce_ctrl_addr + dstr_wm->addr);
>  
>  	ath10k_ce_write32(ar, ce_ctrl_addr + dstr_wm->addr,
> @@ -349,7 +349,7 @@ static inline void ath10k_ce_dest_ring_lowmark_set(struct ath10k *ar,
>  						   u32 ce_ctrl_addr,
>  						   unsigned int n)
>  {
> -	struct ath10k_hw_ce_dst_src_wm_regs *dstr_wm = ar->hw_ce_regs->wm_dstr;
> +	const struct ath10k_hw_ce_dst_src_wm_regs *dstr_wm = ar->hw_ce_regs->wm_dstr;
>  	u32 addr = ath10k_ce_read32(ar, ce_ctrl_addr + dstr_wm->addr);
>  
>  	ath10k_ce_write32(ar, ce_ctrl_addr + dstr_wm->addr,
> @@ -360,7 +360,7 @@ static inline void ath10k_ce_dest_ring_lowmark_set(struct ath10k *ar,
>  static inline void ath10k_ce_copy_complete_inter_enable(struct ath10k *ar,
>  							u32 ce_ctrl_addr)
>  {
> -	struct ath10k_hw_ce_host_ie *host_ie = ar->hw_ce_regs->host_ie;
> +	const struct ath10k_hw_ce_host_ie *host_ie = ar->hw_ce_regs->host_ie;
>  
>  	u32 host_ie_addr = ath10k_ce_read32(ar, ce_ctrl_addr +
>  					    ar->hw_ce_regs->host_ie_addr);
> @@ -372,7 +372,7 @@ static inline void ath10k_ce_copy_complete_inter_enable(struct ath10k *ar,
>  static inline void ath10k_ce_copy_complete_intr_disable(struct ath10k *ar,
>  							u32 ce_ctrl_addr)
>  {
> -	struct ath10k_hw_ce_host_ie *host_ie = ar->hw_ce_regs->host_ie;
> +	const struct ath10k_hw_ce_host_ie *host_ie = ar->hw_ce_regs->host_ie;
>  
>  	u32 host_ie_addr = ath10k_ce_read32(ar, ce_ctrl_addr +
>  					    ar->hw_ce_regs->host_ie_addr);
> @@ -384,7 +384,7 @@ static inline void ath10k_ce_copy_complete_intr_disable(struct ath10k *ar,
>  static inline void ath10k_ce_watermark_intr_disable(struct ath10k *ar,
>  						    u32 ce_ctrl_addr)
>  {
> -	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
> +	const struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
>  
>  	u32 host_ie_addr = ath10k_ce_read32(ar, ce_ctrl_addr +
>  					    ar->hw_ce_regs->host_ie_addr);
> @@ -396,7 +396,7 @@ static inline void ath10k_ce_watermark_intr_disable(struct ath10k *ar,
>  static inline void ath10k_ce_error_intr_disable(struct ath10k *ar,
>  						u32 ce_ctrl_addr)
>  {
> -	struct ath10k_hw_ce_misc_regs *misc_regs = ar->hw_ce_regs->misc_regs;
> +	const struct ath10k_hw_ce_misc_regs *misc_regs = ar->hw_ce_regs->misc_regs;
>  
>  	u32 misc_ie_addr = ath10k_ce_read32(ar,
>  			ce_ctrl_addr + ar->hw_ce_regs->misc_ie_addr);
> @@ -410,7 +410,7 @@ static inline void ath10k_ce_engine_int_status_clear(struct ath10k *ar,
>  						     u32 ce_ctrl_addr,
>  						     unsigned int mask)
>  {
> -	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
> +	const struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
>  
>  	ath10k_ce_write32(ar, ce_ctrl_addr + wm_regs->addr, mask);
>  }
> @@ -1230,7 +1230,7 @@ void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id)
>  {
>  	struct ath10k_ce *ce = ath10k_ce_priv(ar);
>  	struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
> -	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
> +	const struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
>  	u32 ctrl_addr = ce_state->ctrl_addr;
>  
>  	/*
> diff --git a/drivers/net/wireless/ath/ath10k/hw.c b/drivers/net/wireless/ath/ath10k/hw.c
> index 8fafe096adff..84b35a22fc23 100644
> --- a/drivers/net/wireless/ath/ath10k/hw.c
> +++ b/drivers/net/wireless/ath/ath10k/hw.c
> @@ -212,40 +212,40 @@ const struct ath10k_hw_regs wcn3990_regs = {
>  	.pcie_intr_fw_mask			= 0x00100000,
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map wcn3990_src_ring = {
> +static const struct ath10k_hw_ce_regs_addr_map wcn3990_src_ring = {
>  	.msb	= 0x00000010,
>  	.lsb	= 0x00000010,
>  	.mask	= GENMASK(17, 17),
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map wcn3990_dst_ring = {
> +static const struct ath10k_hw_ce_regs_addr_map wcn3990_dst_ring = {
>  	.msb	= 0x00000012,
>  	.lsb	= 0x00000012,
>  	.mask	= GENMASK(18, 18),
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map wcn3990_dmax = {
> +static const struct ath10k_hw_ce_regs_addr_map wcn3990_dmax = {
>  	.msb	= 0x00000000,
>  	.lsb	= 0x00000000,
>  	.mask	= GENMASK(15, 0),
>  };
>  
> -static struct ath10k_hw_ce_ctrl1 wcn3990_ctrl1 = {
> +static const struct ath10k_hw_ce_ctrl1 wcn3990_ctrl1 = {
>  	.addr		= 0x00000018,
>  	.src_ring	= &wcn3990_src_ring,
>  	.dst_ring	= &wcn3990_dst_ring,
>  	.dmax		= &wcn3990_dmax,
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map wcn3990_host_ie_cc = {
> +static const struct ath10k_hw_ce_regs_addr_map wcn3990_host_ie_cc = {
>  	.mask	= GENMASK(0, 0),
>  };
>  
> -static struct ath10k_hw_ce_host_ie wcn3990_host_ie = {
> +static const struct ath10k_hw_ce_host_ie wcn3990_host_ie = {
>  	.copy_complete	= &wcn3990_host_ie_cc,
>  };
>  
> -static struct ath10k_hw_ce_host_wm_regs wcn3990_wm_reg = {
> +static const struct ath10k_hw_ce_host_wm_regs wcn3990_wm_reg = {
>  	.dstr_lmask	= 0x00000010,
>  	.dstr_hmask	= 0x00000008,
>  	.srcr_lmask	= 0x00000004,
> @@ -255,7 +255,7 @@ static struct ath10k_hw_ce_host_wm_regs wcn3990_wm_reg = {
>  	.addr		= 0x00000030,
>  };
>  
> -static struct ath10k_hw_ce_misc_regs wcn3990_misc_reg = {
> +static const struct ath10k_hw_ce_misc_regs wcn3990_misc_reg = {
>  	.axi_err	= 0x00000100,
>  	.dstr_add_err	= 0x00000200,
>  	.srcr_len_err	= 0x00000100,
> @@ -266,19 +266,19 @@ static struct ath10k_hw_ce_misc_regs wcn3990_misc_reg = {
>  	.addr		= 0x00000038,
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map wcn3990_src_wm_low = {
> +static const struct ath10k_hw_ce_regs_addr_map wcn3990_src_wm_low = {
>  	.msb	= 0x00000000,
>  	.lsb	= 0x00000010,
>  	.mask	= GENMASK(31, 16),
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map wcn3990_src_wm_high = {
> +static const struct ath10k_hw_ce_regs_addr_map wcn3990_src_wm_high = {
>  	.msb	= 0x0000000f,
>  	.lsb	= 0x00000000,
>  	.mask	= GENMASK(15, 0),
>  };
>  
> -static struct ath10k_hw_ce_dst_src_wm_regs wcn3990_wm_src_ring = {
> +static const struct ath10k_hw_ce_dst_src_wm_regs wcn3990_wm_src_ring = {
>  	.addr		= 0x0000004c,
>  	.low_rst	= 0x00000000,
>  	.high_rst	= 0x00000000,
> @@ -286,18 +286,18 @@ static struct ath10k_hw_ce_dst_src_wm_regs wcn3990_wm_src_ring = {
>  	.wm_high	= &wcn3990_src_wm_high,
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map wcn3990_dst_wm_low = {
> +static const struct ath10k_hw_ce_regs_addr_map wcn3990_dst_wm_low = {
>  	.lsb	= 0x00000010,
>  	.mask	= GENMASK(31, 16),
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map wcn3990_dst_wm_high = {
> +static const struct ath10k_hw_ce_regs_addr_map wcn3990_dst_wm_high = {
>  	.msb	= 0x0000000f,
>  	.lsb	= 0x00000000,
>  	.mask	= GENMASK(15, 0),
>  };
>  
> -static struct ath10k_hw_ce_dst_src_wm_regs wcn3990_wm_dst_ring = {
> +static const struct ath10k_hw_ce_dst_src_wm_regs wcn3990_wm_dst_ring = {
>  	.addr		= 0x00000050,
>  	.low_rst	= 0x00000000,
>  	.high_rst	= 0x00000000,
> @@ -305,7 +305,7 @@ static struct ath10k_hw_ce_dst_src_wm_regs wcn3990_wm_dst_ring = {
>  	.wm_high	= &wcn3990_dst_wm_high,
>  };
>  
> -static struct ath10k_hw_ce_ctrl1_upd wcn3990_ctrl1_upd = {
> +static const struct ath10k_hw_ce_ctrl1_upd wcn3990_ctrl1_upd = {
>  	.shift = 19,
>  	.mask = 0x00080000,
>  	.enable = 0x00000000,
> @@ -344,25 +344,25 @@ const struct ath10k_hw_values wcn3990_values = {
>  	.ce_desc_meta_data_lsb		= 4,
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map qcax_src_ring = {
> +static const struct ath10k_hw_ce_regs_addr_map qcax_src_ring = {
>  	.msb	= 0x00000010,
>  	.lsb	= 0x00000010,
>  	.mask	= GENMASK(16, 16),
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map qcax_dst_ring = {
> +static const struct ath10k_hw_ce_regs_addr_map qcax_dst_ring = {
>  	.msb	= 0x00000011,
>  	.lsb	= 0x00000011,
>  	.mask	= GENMASK(17, 17),
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map qcax_dmax = {
> +static const struct ath10k_hw_ce_regs_addr_map qcax_dmax = {
>  	.msb	= 0x0000000f,
>  	.lsb	= 0x00000000,
>  	.mask	= GENMASK(15, 0),
>  };
>  
> -static struct ath10k_hw_ce_ctrl1 qcax_ctrl1 = {
> +static const struct ath10k_hw_ce_ctrl1 qcax_ctrl1 = {
>  	.addr		= 0x00000010,
>  	.hw_mask	= 0x0007ffff,
>  	.sw_mask	= 0x0007ffff,
> @@ -375,31 +375,31 @@ static struct ath10k_hw_ce_ctrl1 qcax_ctrl1 = {
>  	.dmax		= &qcax_dmax,
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map qcax_cmd_halt_status = {
> +static const struct ath10k_hw_ce_regs_addr_map qcax_cmd_halt_status = {
>  	.msb	= 0x00000003,
>  	.lsb	= 0x00000003,
>  	.mask	= GENMASK(3, 3),
>  };
>  
> -static struct ath10k_hw_ce_cmd_halt qcax_cmd_halt = {
> +static const struct ath10k_hw_ce_cmd_halt qcax_cmd_halt = {
>  	.msb		= 0x00000000,
>  	.mask		= GENMASK(0, 0),
>  	.status_reset	= 0x00000000,
>  	.status		= &qcax_cmd_halt_status,
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map qcax_host_ie_cc = {
> +static const struct ath10k_hw_ce_regs_addr_map qcax_host_ie_cc = {
>  	.msb	= 0x00000000,
>  	.lsb	= 0x00000000,
>  	.mask	= GENMASK(0, 0),
>  };
>  
> -static struct ath10k_hw_ce_host_ie qcax_host_ie = {
> +static const struct ath10k_hw_ce_host_ie qcax_host_ie = {
>  	.copy_complete_reset	= 0x00000000,
>  	.copy_complete		= &qcax_host_ie_cc,
>  };
>  
> -static struct ath10k_hw_ce_host_wm_regs qcax_wm_reg = {
> +static const struct ath10k_hw_ce_host_wm_regs qcax_wm_reg = {
>  	.dstr_lmask	= 0x00000010,
>  	.dstr_hmask	= 0x00000008,
>  	.srcr_lmask	= 0x00000004,
> @@ -409,7 +409,7 @@ static struct ath10k_hw_ce_host_wm_regs qcax_wm_reg = {
>  	.addr		= 0x00000030,
>  };
>  
> -static struct ath10k_hw_ce_misc_regs qcax_misc_reg = {
> +static const struct ath10k_hw_ce_misc_regs qcax_misc_reg = {
>  	.axi_err	= 0x00000400,
>  	.dstr_add_err	= 0x00000200,
>  	.srcr_len_err	= 0x00000100,
> @@ -420,19 +420,19 @@ static struct ath10k_hw_ce_misc_regs qcax_misc_reg = {
>  	.addr		= 0x00000038,
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map qcax_src_wm_low = {
> +static const struct ath10k_hw_ce_regs_addr_map qcax_src_wm_low = {
>  	.msb    = 0x0000001f,
>  	.lsb	= 0x00000010,
>  	.mask	= GENMASK(31, 16),
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map qcax_src_wm_high = {
> +static const struct ath10k_hw_ce_regs_addr_map qcax_src_wm_high = {
>  	.msb	= 0x0000000f,
>  	.lsb	= 0x00000000,
>  	.mask	= GENMASK(15, 0),
>  };
>  
> -static struct ath10k_hw_ce_dst_src_wm_regs qcax_wm_src_ring = {
> +static const struct ath10k_hw_ce_dst_src_wm_regs qcax_wm_src_ring = {
>  	.addr		= 0x0000004c,
>  	.low_rst	= 0x00000000,
>  	.high_rst	= 0x00000000,
> @@ -440,18 +440,18 @@ static struct ath10k_hw_ce_dst_src_wm_regs qcax_wm_src_ring = {
>  	.wm_high        = &qcax_src_wm_high,
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map qcax_dst_wm_low = {
> +static const struct ath10k_hw_ce_regs_addr_map qcax_dst_wm_low = {
>  	.lsb	= 0x00000010,
>  	.mask	= GENMASK(31, 16),
>  };
>  
> -static struct ath10k_hw_ce_regs_addr_map qcax_dst_wm_high = {
> +static const struct ath10k_hw_ce_regs_addr_map qcax_dst_wm_high = {
>  	.msb	= 0x0000000f,
>  	.lsb	= 0x00000000,
>  	.mask	= GENMASK(15, 0),
>  };
>  
> -static struct ath10k_hw_ce_dst_src_wm_regs qcax_wm_dst_ring = {
> +static const struct ath10k_hw_ce_dst_src_wm_regs qcax_wm_dst_ring = {
>  	.addr		= 0x00000050,
>  	.low_rst	= 0x00000000,
>  	.high_rst	= 0x00000000,
> diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
> index 442091c6dfd2..7ffa1fbe2874 100644
> --- a/drivers/net/wireless/ath/ath10k/hw.h
> +++ b/drivers/net/wireless/ath/ath10k/hw.h
> @@ -289,19 +289,22 @@ struct ath10k_hw_ce_ctrl1 {
>  	u32 sw_wr_mask;
>  	u32 reset_mask;
>  	u32 reset;
> -	struct ath10k_hw_ce_regs_addr_map *src_ring;
> -	struct ath10k_hw_ce_regs_addr_map *dst_ring;
> -	struct ath10k_hw_ce_regs_addr_map *dmax; };
> +	const struct ath10k_hw_ce_regs_addr_map *src_ring;
> +	const struct ath10k_hw_ce_regs_addr_map *dst_ring;
> +	const struct ath10k_hw_ce_regs_addr_map *dmax;
> +};
>  
>  struct ath10k_hw_ce_cmd_halt {
>  	u32 status_reset;
>  	u32 msb;
>  	u32 mask;
> -	struct ath10k_hw_ce_regs_addr_map *status; };
> +	const struct ath10k_hw_ce_regs_addr_map *status;
> +};
>  
>  struct ath10k_hw_ce_host_ie {
>  	u32 copy_complete_reset;
> -	struct ath10k_hw_ce_regs_addr_map *copy_complete; };
> +	const struct ath10k_hw_ce_regs_addr_map *copy_complete;
> +};
>  
>  struct ath10k_hw_ce_host_wm_regs {
>  	u32 dstr_lmask;
> @@ -328,8 +331,9 @@ struct ath10k_hw_ce_dst_src_wm_regs {
>  	u32 addr;
>  	u32 low_rst;
>  	u32 high_rst;
> -	struct ath10k_hw_ce_regs_addr_map *wm_low;
> -	struct ath10k_hw_ce_regs_addr_map *wm_high; };
> +	const struct ath10k_hw_ce_regs_addr_map *wm_low;
> +	const struct ath10k_hw_ce_regs_addr_map *wm_high;
> +};
>  
>  struct ath10k_hw_ce_ctrl1_upd {
>  	u32 shift;
> @@ -355,14 +359,14 @@ struct ath10k_hw_ce_regs {
>  	u32 ce_rri_low;
>  	u32 ce_rri_high;
>  	u32 host_ie_addr;
> -	struct ath10k_hw_ce_host_wm_regs *wm_regs;
> -	struct ath10k_hw_ce_misc_regs *misc_regs;
> -	struct ath10k_hw_ce_ctrl1 *ctrl1_regs;
> -	struct ath10k_hw_ce_cmd_halt *cmd_halt;
> -	struct ath10k_hw_ce_host_ie *host_ie;
> -	struct ath10k_hw_ce_dst_src_wm_regs *wm_srcr;
> -	struct ath10k_hw_ce_dst_src_wm_regs *wm_dstr;
> -	struct ath10k_hw_ce_ctrl1_upd *upd;
> +	const struct ath10k_hw_ce_host_wm_regs *wm_regs;
> +	const struct ath10k_hw_ce_misc_regs *misc_regs;
> +	const struct ath10k_hw_ce_ctrl1 *ctrl1_regs;
> +	const struct ath10k_hw_ce_cmd_halt *cmd_halt;
> +	const struct ath10k_hw_ce_host_ie *host_ie;
> +	const struct ath10k_hw_ce_dst_src_wm_regs *wm_srcr;
> +	const struct ath10k_hw_ce_dst_src_wm_regs *wm_dstr;
> +	const struct ath10k_hw_ce_ctrl1_upd *upd;
>  };
>  
>  struct ath10k_hw_values {

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>



