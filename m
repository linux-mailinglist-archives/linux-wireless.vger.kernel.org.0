Return-Path: <linux-wireless+bounces-32804-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEkLK7l9r2kXZwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32804-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 03:11:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BC624411A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 03:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1304314B797
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 02:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94D92F6193;
	Tue, 10 Mar 2026 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K2thYM93";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZAOjdndW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558312EC0B2
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108320; cv=none; b=lzMPHiFY/CEeHUMK4OupNs0VxTFu10Mvr3Dk5I/+CxyTZ13yJ4APkhi0FG0JShcxYhlnFNdCNvDqalArymADKoZjz60HExSFwMmPZ9rYJJWCqE1eDxgkuNQRzw9hoedWYeJYb03W9hOhdZ+IxOlBvht/ODb54yxTGYbD4y9R91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108320; c=relaxed/simple;
	bh=q2J1gj6kx/n+11YNWhIXSchii5A981hBLuFx0sojaFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIaSho6FS9Ft+Tzcc9RpfsaF4ShoCcpxCbR74bKNdjqVfDVtOfipJz74EDAfgCa/yT/b27gDntBHWIVSBXiYvE+Y50fg0bPGRl+ZuMR/cYh3GOXGF1cacQn1f2yDqqDj9WAECUVVTyTDzlg3ObAYuf4getXh4qTtqJ4eRYrOeBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K2thYM93; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZAOjdndW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBqRB1203564
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 02:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sjo55PMniYin80scVthrrQgh0/F0zOAgx7H2SP9TB3k=; b=K2thYM93w3r+zvMs
	gRtTe/tsgudrsfuefPuXeXfsw6qQsn/zOreV3yuIbnn4zStQFZB7qQZMf2s52Y9+
	FuqYNn16F0pfKnezjYcq6DCsomeAE2Ru86T9ErPqzk3K6oYsiYLwFrppGDiY5rri
	9tle/tuVId/7quhHa9JsX1UzFhl8Ehslgd1fU6eEI0MzfKAZi+rHWI36BFwjyKPB
	WdnDxq3UK+96E5g+6hObemQqlgSMUn1rQu2E4e7LmZZA5jOyCF0qw1sCUnzSsV+f
	qtFTkA7EzLG4BGamO/8+9QlGPm6Xha3xBMhjVHFIbPkM2tYKm5lG1yRrlMeFt3Mk
	1nASZg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct032a3rc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 02:05:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c7381a9a932so2977442a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 19:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773108318; x=1773713118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sjo55PMniYin80scVthrrQgh0/F0zOAgx7H2SP9TB3k=;
        b=ZAOjdndW72djAb/DoHEAf9msRxBMZQwgW3TTjglbPjU0nOrOl6bwrc54O9zANRvdhf
         0QCOfalWYE878DnxwGv1euhCYE8PEjMK1xS+muFIE81dBMcVxioZhmD1aPXWQ6ja7yy9
         j2WDLirlV3RmLvaDzPiz31MkodWLPzZIFCZEe/vxz75XTgdbzHnwgQww7V2U77GFhPaQ
         BZkLAciyGQgbI4+qSr1ZXS4NfTWe5SvJqrMBuadNN9e4tfdIkC0ztGNe4+fj+rOaQe9k
         aNjNSCP7JHUp8LNywfX4/5BVB08IGglCh60ZmeZ/TusjbPFKLddRsZz3Ne0mXfEXzeBt
         R8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773108318; x=1773713118;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sjo55PMniYin80scVthrrQgh0/F0zOAgx7H2SP9TB3k=;
        b=fDNeYC8blVAHQk/zBTbyJ6f44wsN7ZJNsp4S+XE+NanuKXJRr6QTIN7dPsvzP3n2BQ
         q8src4jufyK8xHUOFIeDN0L9Ezw+JB712naWF9/xlyKj2+q8fOy+Ev5ivESkl7M3KeUA
         gRuJIjzyfAxhn9afDoeOZFl+oKwGASBVKKAv1Mhl8coBJBGN3vIT6Ca9KKlqK83X74J6
         mxlZkrjYG1HU69g58HU4Mjs7VIeHlYSzu0s09/MdD3I6niN2g8zDACzRhgtiT6LQiA7X
         cIrGTGkTg8j/V/WTtlanCecwpxyi4NfzOaYlEUFHXq1IRYabeoJFrv48YFRfZgfQDSrU
         GbSg==
X-Gm-Message-State: AOJu0Yw/Dwn6aWLWBun0XRCBgzhHe5DxIBg7gPxy67JTujsJnTwN1Fng
	9MfgTZeoq7ffXhD61FyOI99PK8RbaDLYhePta/jg/jMWZmzo2D3U4kJEsE9xPJPoRzC/GlcBSSp
	FNpHFBAEn08089cUB5VvR+wLMgbxcbitZftnqEqxPlaBQ2KeW5SzfBa1NVBnkUAmrvrda5ITbKT
	ff5uCH
X-Gm-Gg: ATEYQzyu8B71OwRqFp968wRXFpxHESygdWQF21zRyrIDK0dy0Vy4szqYLZpwOhncfIx
	XghlD+ntt4eq3rk6UMS9dXpg/9fOD1t8HAYdlAbQOpvmIHZZN67g2ua8J/dPrCywVShD4TtbZ6T
	2g6QEOXIVkfdoAq0RkByx1uejRBDLOcnoq/omwlEKiaZLVzurCDYry0JIxBHB5+47hNmkrgcelZ
	UKslNSA40d6EjZlJvTeC1QSb1j48JRYpKx80ceCXcaOnkFi5pDTZXv9CGmKaYfmAC4NDuJab+Fa
	7M6ZP08ZApFtMqcdQK8fbWbvMZOwgA/TXRBwOiMjABDz2+3HlrOSG629HDXqqkl9Bkk+QI25l7K
	0KU/vv8CouF64pvtZp69LsikXpvDsR2yIE7E/1CIJ/GfnCht6HhXLNxO2HPmj8SuEas45HH2T+l
	Dt5F/W+MfJ1em+rJK6hQ==
X-Received: by 2002:a05:6a00:1acd:b0:81c:c98c:aeb7 with SMTP id d2e1a72fcca58-829a2d92f11mr11007271b3a.7.1773108317638;
        Mon, 09 Mar 2026 19:05:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:1acd:b0:81c:c98c:aeb7 with SMTP id d2e1a72fcca58-829a2d92f11mr11007244b3a.7.1773108317087;
        Mon, 09 Mar 2026 19:05:17 -0700 (PDT)
Received: from [10.133.33.46] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b702sm11609577b3a.20.2026.03.09.19.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 19:05:16 -0700 (PDT)
Message-ID: <04d268a7-8f6e-4aa4-b366-0dc38c355de7@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 10:05:11 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid dynamic alloc when parsing
 wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260309152050.191820-1-nico.escande@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260309152050.191820-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAxNCBTYWx0ZWRfX1vvDdgOv5BGu
 eJRSMhfUF2ErtLhstsTrnFQSY/2rR9Y3DqoVZEu427HhbrOQuAI2G2lcDfHS6epKYdDCHG2DY/K
 foXQjtsaJxQrmvv4eagAk0rSoyD9t/10jnSXmHilxE3AK8ciie2SvUut0Rl9lWLiItZ0RwQ5TsK
 l8kaiVOxccsdMaoEfLNYnPZGe6q25vg6wmOdUkYYIhbB3Up0gy7fpmS9D7RVjHSmabtvOjDjzEG
 OkUnEJAmqMTLrvwsMkYDOtvpdQDEbrv1V777bUd0jYtJlBrH6bfcPoWO6bWlJyv7Xkzo+KZAkIe
 nkChKmF+YCmDSa0w5xvQi2t85S2iQh9aN9T+lkfcV2XJaNlSnkO/Fu+aRZl54/2mggS7t3cClGc
 YYucaurbSgrwS35Jmzb4q625y1CmzOUMOB65YBIv6lK1XJYfnECDV90KzIwGOhVx4fAjNuBtY4R
 R3iciV7U1bDK2ZvXCjw==
X-Proofpoint-ORIG-GUID: MUmsiMG5IXRkZ_q8yimPIWWjtwuXaW5v
X-Proofpoint-GUID: MUmsiMG5IXRkZ_q8yimPIWWjtwuXaW5v
X-Authority-Analysis: v=2.4 cv=WtEm8Nfv c=1 sm=1 tr=0 ts=69af7c5e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=LKyZ4EzgJUtLA7xHa9UA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100014
X-Rspamd-Queue-Id: 00BC624411A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32804-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
X-Rspamd-Action: no action



On 3/9/2026 11:20 PM, Nicolas Escande wrote:
> On each WMI message received from the hardware, we alloc a temporary array
> of WMI_TAG_MAX entries of type void *. This array is then populated with
> pointers of parsed structs depending on the WMI type, and then freed. This
> alloc can fail when memory pressure in the system is high enough.
> 
> Given the fact that it is scheduled in softirq with the system_bh_wq, we
> should not be able to parse more than one WMI message per CPU at any time
> 
> So instead lets move to a per cpu allocated array, stored in the struct
> ath12k_base, that is reused accros calls. The ath12k_wmi_tlv_parse_alloc()
> is also renamed into / merged with ath12k_wmi_tlv_parse() as it no longer
> allocs memory but returns the existing per-cpu one.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
> changes from RFC:
>   - rebased on ath-next 8e0ab5b9adb7
>   - converted missing call sites ath12k_wmi_obss_color_collision_event()
>     & ath12k_wmi_pdev_temperature_event()
>   - changed alloc order & cleanup path in ath12k_core_alloc() as it seems
>     it confused people
>   - used sizeof(*tb) in ath12k_wmi_tlv_parse()
> 
> Note I did try to move to a DEFINE_PER_CPU() allocated array but the module
> loader complained about the array size. So I stuck to the per ab alloc. 
> ---
>  drivers/net/wireless/ath/ath12k/core.c |   7 +
>  drivers/net/wireless/ath/ath12k/core.h |   2 +
>  drivers/net/wireless/ath/ath12k/wmi.c  | 178 ++++++-------------------
>  3 files changed, 51 insertions(+), 136 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index c31c47fb5a73..c1de70b24828 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -2258,6 +2258,7 @@ void ath12k_core_free(struct ath12k_base *ab)
>  	timer_delete_sync(&ab->rx_replenish_retry);
>  	destroy_workqueue(ab->workqueue_aux);
>  	destroy_workqueue(ab->workqueue);
> +	free_percpu(ab->wmi_tb);
>  	kfree(ab);
>  }
>  
> @@ -2270,6 +2271,11 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>  	if (!ab)
>  		return NULL;
>  
> +	ab->wmi_tb = __alloc_percpu(WMI_TAG_MAX * sizeof(void *),
> +				    __alignof__(void *));
> +	if (!ab->wmi_tb)
> +		goto err_sc_free;
> +
>  	init_completion(&ab->driver_recovery);
>  
>  	ab->workqueue = create_singlethread_workqueue("ath12k_wq");
> @@ -2317,6 +2323,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>  err_free_wq:
>  	destroy_workqueue(ab->workqueue);
>  err_sc_free:
> +	free_percpu(ab->wmi_tb);
>  	kfree(ab);
>  	return NULL;
>  }
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 59c193b24764..ebe7b94fd712 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -19,6 +19,7 @@
>  #include <linux/average.h>
>  #include <linux/of.h>
>  #include <linux/rhashtable.h>
> +#include <linux/percpu.h>
>  #include "qmi.h"
>  #include "htc.h"
>  #include "wmi.h"
> @@ -937,6 +938,7 @@ struct ath12k_base {
>  	struct device *dev;
>  	struct ath12k_qmi qmi;
>  	struct ath12k_wmi_base wmi_ab;
> +	void __percpu *wmi_tb;

any reason why my v1 suggestion is not considered?

instead of allocating it per device, how about making it global and define/allocate once
when loading driver. This way we may save some memory in case where more than one devices
get probed?

