Return-Path: <linux-wireless+bounces-33479-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ISNGWPau2k6pAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33479-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 12:13:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A3D2CA1CA
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 12:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BABA314B856
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA64C26AF4;
	Thu, 19 Mar 2026 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NTBdNZ9K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DcAb6Kh9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36638644E
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918513; cv=none; b=pl3faTFNfy5Ipr89fWyU/Re64Fu/XjMqP7egv5+n08s4WeKL7SHCjLs3lsMobnXDFmr2nR2GuvCKnS6NdXny/vXtYxsuLs1rB8l9FlgP4jJDjRwbvx500SV7sum6Xr0rVqIZOxZpJBlh8f8KqeVC3ii+VhHW8XIMcBNvAHG7aZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918513; c=relaxed/simple;
	bh=Dp9TSQ1yZI8cJ4gBblwJS/BHd4ekxHS25A88fqhbJxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thGHhCA5rrXo11zfnu1SHgLyVnmmUAYS2ScVMF4KurApXoB8EBla966hkQR4rtliAQKqle7J8EkufpWeD4lBMReUuqjM6vCs+IdUNhQgs79ZIEAFnmZ3DhXB/sn5yIj0Bq/HwJ/1E3SXdF9di4qsqRn//NFiQW9ucbYRM1kPNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NTBdNZ9K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DcAb6Kh9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J74Aee3369825
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 11:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YHDw3sqYCoQIpa9CGSywX3G6kMIJy12pGWh/ccVzB98=; b=NTBdNZ9KJA6+a+Ii
	nu6mLTp9zkiPZBD+QBNpLAwf+TIALo2wcysYARZirIAENFVhZkAURy8+a3MiQxBm
	KLfbgV3p6aZW6+IS3sQ4Ynp8snd080/31wBA7I5RaVJ8OF2Th4qVsX2CC9+jC+xg
	GLcwIXkbSUiaZ9Ux2/pb+RXVdx+2rT7KztF2ut/3C5yEY/SbDPjeFdzNKwDUVhq4
	bHmr7ktZDqaRu+TuInH1xjci+DZOGvqMFrFI+8o70GAJFtETF5hbpPPHeWnTPYpP
	t/eYTWECL2hr/jmBnEtOg8Y8IlceoZs1QZey7aHqijmWGDon19QZUtrsf9r+4dcP
	YaBZQg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d00f9jwbm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 11:08:31 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7385a1476aso459466a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773918510; x=1774523310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YHDw3sqYCoQIpa9CGSywX3G6kMIJy12pGWh/ccVzB98=;
        b=DcAb6Kh9sC6e0ZXus8DKcbs5pv0/L1h+yzlweZeZyfD97KNNjWme+iz9MS2cQeuQhY
         XSKDAbBTJFOeDKVffGNUNaK7TKH9oMvvNek8VrUluCEl7cRwV5D5v30waVbWwC+jFRnD
         u+prmc6uC7rLVeYKIKQjzFCg214oX30TgdJZ/LPZ8lJeMp572uJ5nyw5UQF6JhDULutl
         PiS7Q0hixNKKTcXHB2EQk1hLXfkOn1O6aDRebHj5HMweQ8orH1pubozAZ/Pxsj2mS98l
         /rpR1wW7vsS26J+lc04KS4m5uUfm26hFexFXntayb7iTr8bMZbwQkZLvGB4hR9pJ4dl9
         auVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773918510; x=1774523310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHDw3sqYCoQIpa9CGSywX3G6kMIJy12pGWh/ccVzB98=;
        b=LyCs7bFGpXz+LtmZo+cJhwdFJeYio7Z2/RDlXa6VGRjdFPAENTOt221qHoKAjPoWwH
         hXb8Resr5qZzsN0f1aGdFmFx5dlNw8BkNp9cHUS+AUDsUygCTjOSczL26Ww352JZz2SK
         H6UcpWP5Y9i6aem0uR70WN63eDMtcRjOfdaqgpQWqvg7VZdY8A9I6ozEcDJUzyJb4b/K
         alU5r9MJRYN1PX+TwITDMfpQPnEW7pks+sXemKswegP5ZSlzJ2hqs7MBOQb4A397Vnh3
         ti2aiFFgCSHUJ6BOkd8wvjOs63x90uxG/Q+n9/HuIcbVi/Bizs+Ot4rJV/3P0zjqI8ZX
         j76w==
X-Gm-Message-State: AOJu0YzvX8H6cpcJJ3h9gPolERXuVJahHEpmkVwLeUIoFyGCV32Q2NKE
	X3xpGB8fHYTeh5eECnnb3D99EJW59MGDpEbsVkGmxlfSVINuJj4myL6cxNROvHNKsnb5i81pkzg
	1WWXqlAPOkZm6BaSGSR9GiizTOWWfoMpqiRxUqJ0pUJ913XbXP24tP6tCNa2TKK3FHCej1w==
X-Gm-Gg: ATEYQzyCHA6LHIFMwpF27NaP+fnVe7f1U80jB7teensdC4G4JBx47aj6lVXGdUKvWwO
	Z7ILwHuacjnD71//R73FHgn2m2oc64P8fBFQ6V990KmYtoH25lcgFUZqFfWjYg8RX8mBnos3YeI
	PffW/tevwgt38fW3oYths2dD/XjMPBpJAZ7p7/BNYQHinGMetZqxaShhSvOggZkZKcmEvGFmBzO
	qt7QqAYPHFBnMwMUwqV3xxEcPV3McKWvI/a8ZDll/E2P9odB9CMhQYehPMiB5n1g/ghaS+QMPRi
	h1wGjlfx95VbeEB/8Ze2T74447pOJ9B4plHFVg4wC57i4d1rkRnDmD8w4zPdspqspnqH/DwJU6K
	+CKwBMcrendJB/DgiJB3X4eqbQ7CT+sTStu3kmB+ShaLmrNgp7vGVPOB2waeeOg==
X-Received: by 2002:a05:6a00:4648:b0:823:1276:9a86 with SMTP id d2e1a72fcca58-82a6aee1e65mr6183422b3a.39.1773918510140;
        Thu, 19 Mar 2026 04:08:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:4648:b0:823:1276:9a86 with SMTP id d2e1a72fcca58-82a6aee1e65mr6183396b3a.39.1773918509548;
        Thu, 19 Mar 2026 04:08:29 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b5308fcsm6838567b3a.9.2026.03.19.04.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 04:08:29 -0700 (PDT)
Message-ID: <36c1cae8-d6c0-4432-bc8e-57216c5ea3fd@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 16:38:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260317084740.3756880-1-nico.escande@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260317084740.3756880-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA4OCBTYWx0ZWRfX8Xq2Q7bFSz3g
 S7f9QXJybbZX2dlhtTgqa9f5RLu7h4ebfWtX+e0FdMRfmZmYzPP99wxwiKyWtkwV0CwaTpMvDxN
 JOdYf0cYkxs1vvWIOSupe9wiG/dl81Z+4OSmbBdtHB/1DFM0zsexH3jOnCesA0VNpjEB0fO2X0G
 kOKLAfBBH2rBVlTqQA622z9ov4RueCRmDDJMiqbwFh6JkEeSC++45Ijb3ihKUetsHN++J+f71BQ
 JmMFSRr5VZMbEB7Ab4nlSyByz4F0lQvtENSGgX6lnwXTbznDpc7TxQahSl4RhqDkXmDVPsJ++vV
 /7cNGugfHdDYJ0TKoeUxANITfMr8gEEpjtRzY8Rlh+zMJdIvnWT7Gh5J/mg5yDA+Xu3s5C2HX0f
 lKodENLdV8cTadGJwKoLI2ImTTPCoxO5EzGcEcQ9EE++SgbUQNHuSicaCz6hdZMPLTQEKW+5HUR
 FHibbJ2FlBFB1zIX4uA==
X-Proofpoint-GUID: H7DPiF6nQcj0Vm3wqjq7k7eNEoJF46Dq
X-Proofpoint-ORIG-GUID: H7DPiF6nQcj0Vm3wqjq7k7eNEoJF46Dq
X-Authority-Analysis: v=2.4 cv=MJttWcZl c=1 sm=1 tr=0 ts=69bbd92f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=YMnrxt29I6OX4gW8josA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190088
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33479-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B9A3D2CA1CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/17/2026 2:17 PM, Nicolas Escande wrote:
> On each WMI message received from the hardware, we alloc a temporary array
> of WMI_TAG_MAX entries of type void *. This array is then populated with
> pointers of parsed structs depending on the WMI type, and then freed. This
> alloc can fail when memory pressure in the system is high enough.
> 
> Given the fact that it is scheduled in softirq with the system_bh_wq, we
> should not be able to parse more than one WMI message per CPU at any time.
> 
> So instead lets move to a per cpu allocated array, that is reused across
> calls: ath12K_wmi_tb that lives in wmi.c of the ath12K module. To alloc &
> free we added two new module_init/exit functions for the module and two
> new wmi functions to alloc/free this memory.
> 
> ath12k_wmi_tlv_parse_alloc() and ath12k_wmi_tlv_parse() are merged
> together as it no longer allocs mem but returns the existing per-cpu one.
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
> changes from v3:
>    - simplified ath12k_core_init() with a single statement
>    - move perpcu.h include directly to wmi.c
> 
> changes from v2:
>    - removed now superfluous return in ath12k_wmi_event_teardown_complete()
>    - moved ath12k_wmi_tb declaration to wmi.c & added two functions to
>      alloc / free it
>    - removed useless error message on memory allocation failure
> 
> changes from v1:
>    - rebased on ath-next 27401c9b1432
>    - changed wording according to Jeff's comment
>    - moved alloc/cleanup to new module_init/exit functions in the
>      ath12k module as per Baochen's comment
> 
> changes from RFC:
>    - rebased on ath-next 8e0ab5b9adb7
>    - converted missing call sites ath12k_wmi_obss_color_collision_event()
>      & ath12k_wmi_pdev_temperature_event()
>    - changed alloc order & cleanup path in ath12k_core_alloc() as it seems
>      it confused people
>    - used sizeof(*tb) in ath12k_wmi_tlv_parse()
> ---
>   drivers/net/wireless/ath/ath12k/core.c |  13 ++
>   drivers/net/wireless/ath/ath12k/wmi.c  | 201 ++++++++-----------------
>   drivers/net/wireless/ath/ath12k/wmi.h  |   3 +
>   3 files changed, 78 insertions(+), 139 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index c31c47fb5a73..6c034071cc6d 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -2321,5 +2321,18 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>   	return NULL;
>   }
>   
> +static int ath12k_init(void)
> +{
> +	return ath12k_wmi_alloc();


Since CONFIG_ATH12K is tristate, a built-in boot can continue past a 
failed ath12k_init() and still run ath12k_wifi7_init().

Please ensure that later initialization path is guarded against 
allocation failure.

Or may be have this allocated on first device probe and free it on last 
device deinit ?


> +}
> +
> +static void ath12k_exit(void)
> +{
> +	ath12k_wmi_free();
> +}
> +
> +module_init(ath12k_init);
> +module_exit(ath12k_exit);
> +
>   MODULE_DESCRIPTION("Driver support for Qualcomm Technologies WLAN devices");
>   MODULE_LICENSE("Dual BSD/GPL");
--
Ramesh


