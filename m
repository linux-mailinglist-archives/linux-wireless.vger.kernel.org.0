Return-Path: <linux-wireless+bounces-34992-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OISbKo2V5WnrlgEAu9opvQ
	(envelope-from <linux-wireless+bounces-34992-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 04:55:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C92054266C7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 04:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8857E300C01A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 02:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C820468E;
	Mon, 20 Apr 2026 02:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UNwIVKys";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kfU7Suf4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76DD33C532
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653707; cv=none; b=OOVtyh0kCrmnYEFqrdO1TKJgK7shZuWrQMeb/JL0uZI1CSb2bwl/HkMgJWgOaGNt+kY/PvPFZOiPSy9YrEWbaP5iFkxdrlic4qgQd+OkeGfBiE+vQWfgG+z7GRAfalXohDkgUzAvJqJ+O4GZVU6nyJRfL/vj4JYa88cy6vySJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653707; c=relaxed/simple;
	bh=5S5oPPYS7MZOAiEpcI2Z+I0W7i4MuGLacknYBaNBElQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmByEXG3s028bCtNiKvPPi/wNfNesBOQt7aMYDGZWVp282Im9QqRlCN1vzSWnpw9Y9JdC/xv9rrYXNcuMxsAtAPCHPRgb7tccpbqq1y4eJgl7+Aw0aNy2Nf6Rq9Ut0VcxEFOQKGeW5lxD/62QoWiDilTEwOclPKp+XM1jMcPLM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UNwIVKys; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kfU7Suf4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JMISdO1398645
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8ke/Wtb4q17dqFQowkNz1oZz9+IjyVbzRZwHzDjvZAM=; b=UNwIVKysyw5XaRKz
	SqHH5iZ/+Dje7xoafkmX1CgLIofPRyMNzP7VcJndZUxtSUk7/li6+ssV/Zkhp8nU
	HYsOnqehXlMOSo1btErnNduaoByUXpHlyrqRPI+lVhoPbg9Gx3oIIiHQJ9+WuSZv
	/gWOeAUbbtLR38DihbuswEnCWekenM3Ua6CZ9EJf5P9AH3rjZdSXp6e5obfAY69f
	eOK0xSIizjUTktVdyyP97GoM2GRYwm3bQXkn//yr3K3+IwDMmEjU82cwYxmG0I0o
	k7+gVvxS94xOxNarfD0R+cyz02zk6p7RUIbQXQ1dJ7xF+3B0TWLUbXPBRSMAo1rN
	SceP8g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0wr3wcc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:55:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b249541063so22147725ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 19:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776653704; x=1777258504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ke/Wtb4q17dqFQowkNz1oZz9+IjyVbzRZwHzDjvZAM=;
        b=kfU7Suf4P6aQZBnBsjpU06hZ4CEGBee11oQbeCUfVBEGEPa6PI83LybRRIS5uN8bWy
         sk9obicmetZ4NTDLYwbRuVPuiOtyYpYcbjNHb6ltbMRn+XsUcOz5fN1nJbhz507FfGAo
         68a3w4CtUBEW16tSHNmQxoy4HG2Vp87QS1jX8pseLAGPXgA9/coQSpvjGVJMieXEx5nV
         7+CdDq/IXtw+aG0DwLe5IHFwbwVB+8EzMG/guhp7/oyXSOrT8nHaQKZjLdKxWupHMlly
         gbBP/XPOUg612a6Xdw/KUwGNXPp3BjMBEbNtQ+OUImfrPWcroZu1HZIV2DPy8GkvE7Sx
         Pm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776653704; x=1777258504;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ke/Wtb4q17dqFQowkNz1oZz9+IjyVbzRZwHzDjvZAM=;
        b=fvpEI9PL0v+67fGvtxUjvLJ9/x3jM6HBcqHx39hyWx1XMrirxa4kazYJ3vj+X7uOvW
         Zf5WBEzMnl9M/Qq2JHptNwKluerUtGfz4V3Egun7rrDLpC77lvoX1sYY+hEagHNeal4D
         IvsfBbsGDrHJE9dwS5efPLan/mwYFpZtzDnhTWfkv/mtde3sUQ/pkowqO3C9T73AiXu4
         wOaM9J0gPR357w14XTbn+nku2bHUFXOQin5ml7u30oJQO9k5ELVX85ZExfMiu2KNuJSe
         fDemWdFzj2ihsxfexUSvyj7jpl4ZKFGLR8bE0gA4Kf6C+Cf6Xn1zIvfxTqWpSCwogIWT
         msFw==
X-Gm-Message-State: AOJu0YzOogHvBBfmOILOXVcuBRJuEocQzs9s9AAgqN1BQabUHeaU1keS
	h/pcogWvh1knIqYC/QuDqnQNlVEy35/5fomwzRaimy07tNTHSMsNezyK9gtHnUq260V3D6EJAHX
	ryMZ0ms9iPtSSR0Eq0p61dCj00d8C+OPRMA4bG0MT4+AGJ2RyaaLXGTFWpAsI6R6bWyPvOw==
X-Gm-Gg: AeBDieuEGjFQsmWVPAPHuS4lRDgc2icrXKL7UYhzrUUCuus3GzIJNy7KC3zNz2aWS30
	uz7Id3oRat1r8ILQPB6NnRb/RJwD3BmGNHze0qzTDYsHMr9inATkYyn+qWCtG1311t2ViqrMB4J
	Cwp4nq8dVNIXEjK4Zqf9Ke00Z3sdX8K6By1onipJK8KhivimXO5pu20zAGC8vQ0ecB3MHNGbBID
	ob3Rg62PW5kSasyc87YkGJ7cpKD9+5ZRbvfXo1Zrm4SL8VYE64ygYScs/+0nseIDW31/yu9Ylco
	UdwRaYfSgdFkHwwMueKs8ZrbIm8u1JxHiu48IjpBjGaz7f509RfOc1AAGL8I7o//MNDbwRT5ATJ
	ELUzZ/PP2qrt7qpkSxHnQ0fW/DkShqh3P868hR276XODlWHk3TVQqw6Q56Fmo7mY/SK+yRSnjcM
	drHtjKlapEhzM4nhG/pM23ONRbQC6JvA==
X-Received: by 2002:a05:6a21:3288:b0:398:6461:688c with SMTP id adf61e73a8af0-3a08d687640mr13204993637.2.1776653704377;
        Sun, 19 Apr 2026 19:55:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:3288:b0:398:6461:688c with SMTP id adf61e73a8af0-3a08d687640mr13204970637.2.1776653703835;
        Sun, 19 Apr 2026 19:55:03 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703059fsm6627677a12.24.2026.04.19.19.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 19:55:02 -0700 (PDT)
Message-ID: <881f2840-6585-4439-b5e9-90cbe47096bb@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 10:55:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix invalid IRQ requests during
 AHB probe
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260414062829.2371761-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260414062829.2371761-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyNCBTYWx0ZWRfX/MFHVt4FN4ic
 HbFayttWLPqLv9N/YS2Aejk8YZezCgBtSpqV7oTjofs4ZN2Pgdnt7t5x+5cSnxwDhVYPAVSmRAz
 9Dw584AmrB9tEs1XmzQvKtSWhbGSkC52BtBtjBYCnejRHA4h+q1X8N5UW4M7/WRw/jh+1ZK2xyT
 OZpYSa0cbRaB+jAXs4O/nhrDZblqZgLhrUN3/n8oZl63FMbXUWxGax2r9Gf6LtZGLYtA06YKsNU
 HWGbv2yNmduFSnjRVeOSOw4PgWscXvh1rQ+a2l/fAQG1dPwGxaC+61zRouU5XyD/RoCyH4fJRoI
 WRcmGcpLlXJaaGDpOQvKocu3t07wTNkruOq1mSUNMOcmsq9mm+r5Flu/L/UY+O19WwGmOnWZ7bV
 Z7kSteP2qQ6FksOSHMoI8XY05/JKTU0gcJ4siH3GcVNcdNToY1f6zLWWU6XfQSr3Ok1dS1+mUjx
 OEo3F1UvjWCY0qK5lOQ==
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=69e59589 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Rz3G870NILOoTZsrui0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: egqZp4wzAk5vCORAb83FTtHGFd_HfxAA
X-Proofpoint-GUID: egqZp4wzAk5vCORAb83FTtHGFd_HfxAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200024
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
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34992-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
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
X-Rspamd-Queue-Id: C92054266C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/14/2026 2:28 PM, Aaradhana Sahu wrote:
> ath12k_ahb_config_ext_irq() iterates over ATH12K_EXT_IRQ_NUM_MAX (16)
> entries while checking TX ring masks, but the tcl_to_wbm_rbm_map array
> contains only DP_TCL_NUM_RING_MAX (4) valid elements.
> 
> When the iterator (j) is greater than or equal to DP_TCL_NUM_RING_MAX,
> it accesses tcl_to_wbm_rbm_map[j] out of bounds. This results in
> reading uninitialized memory for wbm_ring_num, causing the driver to
> evaluate incorrect BIT() conditions and request IRQs for rings that do
> not have an assigned interrupt line or device tree entry.
> 
> This leads to request_irq() failures with -ENXIO or -EINVAL during
> ath12k AHB probe.
> 
> Fix this by splitting the loop into two separate loops: one iterating
> over DP_TCL_NUM_RING_MAX for TX ring, and another iterating over
> ATH12K_EXT_IRQ_NUM_MAX for remaining IRQ entries.
> Also add a bounds check for num_irq.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 6cee30f0da75 ("wifi: ath12k: add AHB driver support for IPQ5332")
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/ahb.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
> index 2dcf0a52e4c1..30733a244454 100644
> --- a/drivers/net/wireless/ath/ath12k/ahb.c
> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
> @@ -583,31 +583,36 @@ static int ath12k_ahb_config_ext_irq(struct ath12k_base *ab)
>  		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
>  			       ath12k_ahb_ext_grp_napi_poll);
>  
> -		for (j = 0; j < ATH12K_EXT_IRQ_NUM_MAX; j++) {
> -			/* For TX ring, ensure that the ring mask and the
> -			 * tcl_to_wbm_rbm_map point to the same ring number.
> -			 */
> +		for (j = 0; j < DP_TCL_NUM_RING_MAX; j++) {
>  			if (ring_mask->tx[i] &
> -			    BIT(ab->hal.tcl_to_wbm_rbm_map[j].wbm_ring_num)) {
> +			    BIT(ab->hal.tcl_to_wbm_rbm_map[j].wbm_ring_num) &&
> +			    num_irq < ATH12K_EXT_IRQ_NUM_MAX) {
>  				irq_grp->irqs[num_irq++] =
>  					wbm2host_tx_completions_ring1 - j;
>  			}
> +		}
>  
> -			if (ring_mask->rx[i] & BIT(j)) {
> +		for (j = 0; j < ATH12K_EXT_IRQ_NUM_MAX; j++) {
> +			if (ring_mask->rx[i] & BIT(j) &&
> +			    num_irq < ATH12K_EXT_IRQ_NUM_MAX) {
>  				irq_grp->irqs[num_irq++] =
>  					reo2host_destination_ring1 - j;
>  			}
>  
> -			if (ring_mask->rx_err[i] & BIT(j))
> +			if (ring_mask->rx_err[i] & BIT(j) &&
> +			    num_irq < ATH12K_EXT_IRQ_NUM_MAX)
>  				irq_grp->irqs[num_irq++] = reo2host_exception;
>  
> -			if (ring_mask->rx_wbm_rel[i] & BIT(j))
> +			if (ring_mask->rx_wbm_rel[i] & BIT(j) &&
> +			    num_irq < ATH12K_EXT_IRQ_NUM_MAX)
>  				irq_grp->irqs[num_irq++] = wbm2host_rx_release;
>  
> -			if (ring_mask->reo_status[i] & BIT(j))
> +			if (ring_mask->reo_status[i] & BIT(j) &&
> +			    num_irq < ATH12K_EXT_IRQ_NUM_MAX)
>  				irq_grp->irqs[num_irq++] = reo2host_status;
>  
> -			if (ring_mask->rx_mon_dest[i] & BIT(j))
> +			if (ring_mask->rx_mon_dest[i] & BIT(j) &&
> +			    num_irq < ATH12K_EXT_IRQ_NUM_MAX)
>  				irq_grp->irqs[num_irq++] =
>  					rxdma2host_monitor_destination_mac1;
>  		}
> 
> base-commit: e6630ad4c58f89ba72e64fca5989ecf1e06319c9

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


