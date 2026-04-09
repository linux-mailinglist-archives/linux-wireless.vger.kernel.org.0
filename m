Return-Path: <linux-wireless+bounces-34555-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEWPGov212mrVAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34555-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 20:57:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 941903CEE4C
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 20:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF637300EAA2
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 18:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B0531D381;
	Thu,  9 Apr 2026 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQZM71dU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kgFCwncm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009292E7162
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761032; cv=none; b=H95piLTnDrDKxLdBv3xe/KsGv+GxiIiUDfKE4SxBtW7KLP1eX3ksyZT/1eDv0XsKW3Q/P7TQAYHt+jRmXXads1UplyVAe3b9LloXua3CTq30eRFO6FGajEOKmajowadIZ41MT46X2wvrfeDA8NlRo4kLepLfS+YwvsSSl/ekvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761032; c=relaxed/simple;
	bh=7FsMAM0r9borMcXncR0zsFlwsLdnrV47L552L0+XWV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brLnMXScpxi0dE0Uq56dy3uDHuCILexEnQmyFdzTsbPKLazSILoES5z19we+s03dqY+0QrYluOoBzRhsIfeDiPPnwyzNfYdHlWocr6cnUYKOb4hFa2Iy8gMGz0BfHVLpkpn+s0kvMI1lv3j9W/C5wcHJTU+nhQ2Pk4TGvPo541k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQZM71dU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kgFCwncm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639HkM4R2698273
	for <linux-wireless@vger.kernel.org>; Thu, 9 Apr 2026 18:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o8h8NVdUu73UGMZuxLRdl86c1/XB0y6zzDzk7/NW3Gw=; b=TQZM71dU4j4hDss9
	VSOf53PmqR45j+/HVK34wjHYFuVHF4/RSGquRm7LLWCiVsFtW4RZJy1ahLwpTMO4
	a4h093grSA76a/7pmmA31D1H6mdNvuRM+SRieIeS1Axu09faaouYJZwrFEk8DCIa
	H2hLX/KGWQosNuYw3JP4o6XDK04iNzQDTYIqrSQ/KYXgrRfP0b3Dcxh5N66vQRjH
	vxCpfAwJQXCyPouOqmWPMGi3ylGHAuFJw3B2u4Ys8mZebR8RAYTQcIgcdJ+M5G/R
	4O0weq0xARsOLoItBm5jotjwNjCbvZGJ/SjKRuqoCcZ+LQ6IOF6lXeNBgfrQ27HC
	86r0Vg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4degt9r827-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 18:57:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b249975139so27662135ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 11:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775761028; x=1776365828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8h8NVdUu73UGMZuxLRdl86c1/XB0y6zzDzk7/NW3Gw=;
        b=kgFCwncmTnjVjhIh9WSOPrwvOmdKtbzMlfme0EZ1DEGoDqVELOk4ufLoif9AxamS9Y
         tBK9aKf+AOpEsAjm8lErDxhjhiK03RcHeNpEgZu8HCfq3OntMFMbMKYzEf5ZtRO6cEQc
         du1ymWNWPCjxJ63Y7WHoAZ9yVVaOD16gBKkBXEZ89GcrnHdPu5kucc8XHYtPIKyGWwEE
         zsgkXf0FzfLF0cuW2Js9PxnwlGGdPodjG005/AicUHcuqojDKfWXq569A/CyopVA8ZLP
         llZLJOxwF1AURhDpi1t7hKN5ixfLohDuMP4NeixcWXfNukO5HEIoPOHrV/1uxDJo8vh7
         N+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775761028; x=1776365828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8h8NVdUu73UGMZuxLRdl86c1/XB0y6zzDzk7/NW3Gw=;
        b=AqVJRgmykBo+gZQl9F3r9b01Yh+vu77L5UEJFTURtPwqnMKWy/2dM6p3DSqPOjDJbj
         tEfMOZHLMjNZwCRZZFT+R2nBejotFDo9HI+RoR/2ihmVcrEQRDCut6FJrycfxnBissCV
         AkKXvj2cxwZ42lLebBgaAiwwL8OVLgh6RW6YycqjqQfLspajw0oWAYFk7+aHkQdR40a/
         fd/b0CnGQTmq+KPal3FeBz8YggNP7TLWnAl2/mLOWQa4Bgix9Ea/HYfj9AoX18C//Ib3
         Aim9MgpCKl6ZN1GMKRirNXwbFLNwev0TrpcSdOdWJwQJxWQHlyrUTUY/bIHiEvFvs2uK
         6IiQ==
X-Gm-Message-State: AOJu0YziMLoljpuizyizjV6qyidpsq53F+F9aRhxxEeOKoe5kc26Lv/f
	42j1c/g1OYfaG7uRyNsHHr2Su92xXQO8MqkmvwiSFz7E3yN7S4/qf6tvYGPszn6UKC43S7rsEyb
	IXCaNwQ7yjkyscLerZxjIkBEBBEh+1ZaufG+2gMZ7ziCxkdXZAoBA/xytGkMHnlJRdUU0/hU3LS
	AmZg==
X-Gm-Gg: AeBDieuvvBocuBoJkKAOI56eNB9yHDysWuULdCEq1U9pVai3pxbP/m3l2esOeCaPzNY
	mEqv5ajX6FqEsfIuD7RwayM+gfwoF8W6Jzu+OIGvqTlQlLIPQNmNgm/tgsB++7mhOYN/TY/Eh/R
	CuRDu2eQTINFle0zecvPXFWzQfqV5jpG5jJ1vsCK1sU29ygHpi3jrEWLdLJU2M8WfAYFGycaLdL
	abdVFEbUpGKm/gc3vlGIkRAOqQBOFRmhi4H6vu5wbW1E/67os2Rz4dpybnsZ8unkBYbAIMbqcb9
	/+n4pnhMTnaZp4oeAKj/FTqImboZ8XFNvP8LyYFUZ2EPLRkw09GUEQS6l9gWmf65B/t5RMTuBnG
	GylGOCjx0E3v11w6kGjYV5zcRiBUPcDCA3mvPfOXtuhHX0QuXYtrctCjExYqD4u8nsA==
X-Received: by 2002:a17:903:1a67:b0:2b0:41eb:165e with SMTP id d9443c01a7336-2b2d5a8ac9bmr975505ad.38.1775761027215;
        Thu, 09 Apr 2026 11:57:07 -0700 (PDT)
X-Received: by 2002:a17:903:1a67:b0:2b0:41eb:165e with SMTP id d9443c01a7336-2b2d5a8ac9bmr975035ad.38.1775761026345;
        Thu, 09 Apr 2026 11:57:06 -0700 (PDT)
Received: from [192.168.11.106] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0a67dsm2613215ad.43.2026.04.09.11.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:57:05 -0700 (PDT)
Message-ID: <0c07d77b-bbc9-4461-a2c1-6a3a361fbb99@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 00:27:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v7] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260407095426.3285574-1-nico.escande@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260407095426.3285574-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3NCBTYWx0ZWRfXxdJVyWE1hXtk
 OY+BwECynHZlNrJGkvmBuErbcQQH0LD7w2JkOD+PV54BMXCbZoOG9MX5TFax6fMdP7pWH7Ysz1A
 NT+6pVKCGaiWyf5VECfd+gEqDXoWFBItYA7lGpp46Tgckf9AT4kUphaKUpMNheSKU4A9KyY3TIr
 AHE5z5w99NRcWisAvfrsWSvmGKBhYU4tvT6WViVACCuNDlmhYCEqANQ6LNbibUHG27wmFrtVYa8
 W4IfsVW0JM9cPmHunTTsXY6J7OxtTbCzoysFpPMF14+Ut3/aRCPmD1IO4VKdq6qETb0LMcJmUio
 BfB6TjRAjtuV8BigxVyVUqg8GgUlmO2N6Ycf1hxeZodE0JXTZZ1si06454C3dppz7ohG/gfB0Mj
 vTF5tuwGMrPuXCgRV0/dCUT7ZLgpIZSAmXvYzlvHgD1a9b2YQN/oR/1linSHwbx7/sDnMlHzskx
 TwGoNlKJJFUAOLgGKLQ==
X-Proofpoint-ORIG-GUID: SycSe53MY0p7YqrlTgHUZ1Ck78PzGZqz
X-Proofpoint-GUID: SycSe53MY0p7YqrlTgHUZ1Ck78PzGZqz
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=69d7f684 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OdjN7X_cJNFRaugCuKwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090174
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34555-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 941903CEE4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/7/2026 3:24 PM, Nicolas Escande wrote:
> On each WMI message received from the hardware, we alloc a temporary array
> of WMI_TAG_MAX entries of type void *. This array is then populated with
> pointers of parsed structs depending on the WMI type, and then freed. This
> alloc can fail when memory pressure in the system is high enough.
> 
> Given the fact that it is scheduled in softirq with the system_bh_wq, we
> should not be able to parse more than one WMI message per CPU at any time.
> 
> So instead lets move to a per cpu allocated array, that is reused across
> calls. This memory is allocated as needed and refcounted to exist only
> as long as one struct ath12k_base lives.
> 
> ath12k_wmi_tlv_parse_alloc() and ath12k_wmi_tlv_parse() are merged
> together as it no longer allocs mem but returns the existing per-cpu one.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
> changes from v6:
>    - fix useless ath12k_wmi_tb NULL init
>    - do not use refcount_inc when refount is at 0, it can warn
> 
> changes from v5:
>    - use of the refount_t kernel api
> 
> changes from v4:
>    - moved to a single instance, refcounted per cpu memory alloc
>    
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
>   drivers/net/wireless/ath/ath12k/core.c |   6 +
>   drivers/net/wireless/ath/ath12k/wmi.c  | 217 +++++++++----------------
>   drivers/net/wireless/ath/ath12k/wmi.h  |   3 +
>   3 files changed, 87 insertions(+), 139 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index c31c47fb5a73..6f0f4bfbf699 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -2256,6 +2256,7 @@ void ath12k_core_deinit(struct ath12k_base *ab)
>   void ath12k_core_free(struct ath12k_base *ab)
>   {
>   	timer_delete_sync(&ab->rx_replenish_retry);
> +	ath12k_wmi_free();
>   	destroy_workqueue(ab->workqueue_aux);
>   	destroy_workqueue(ab->workqueue);
>   	kfree(ab);
> @@ -2280,6 +2281,9 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>   	if (!ab->workqueue_aux)
>   		goto err_free_wq;
>   
> +	if (ath12k_wmi_alloc() < 0)
> +		goto err_free_wq_aux;
> +
>   	mutex_init(&ab->core_lock);
>   	spin_lock_init(&ab->base_lock);
>   	init_completion(&ab->reset_complete);
> @@ -2314,6 +2318,8 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>   
>   	return ab;
>   
> +err_free_wq_aux:
> +	destroy_workqueue(ab->workqueue_aux);
>   err_free_wq:
>   	destroy_workqueue(ab->workqueue);
>   err_sc_free:
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 65a05a9520ff..484fdd3b1b7f 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -15,6 +15,8 @@
>   #include <linux/time.h>
>   #include <linux/of.h>
>   #include <linux/cleanup.h>
> +#include <linux/percpu.h>
> +#include <linux/refcount.h>
>   #include "core.h"
>   #include "debugfs.h"
>   #include "debug.h"
> @@ -134,6 +136,10 @@ struct wmi_pdev_set_obss_bitmap_arg {
>   	const char *label;
>   };
>   
> +static DEFINE_MUTEX(ath12k_wmi_mutex);
> +static refcount_t ath12k_wmi_refcount;
> +static void __percpu *ath12k_wmi_tb;
> +
>   static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
>   	[WMI_TAG_ARRAY_BYTE] = { .min_len = 0 },
>   	[WMI_TAG_ARRAY_UINT32] = { .min_len = 0 },
> @@ -289,29 +295,19 @@ static int ath12k_wmi_tlv_iter_parse(struct ath12k_base *ab, u16 tag, u16 len,
>   	return 0;
>   }
>   
> -static int ath12k_wmi_tlv_parse(struct ath12k_base *ar, const void **tb,
> -				const void *ptr, size_t len)
> -{
> -	return ath12k_wmi_tlv_iter(ar, ptr, len, ath12k_wmi_tlv_iter_parse,
> -				   (void *)tb);
> -}
> -
>   static const void **
> -ath12k_wmi_tlv_parse_alloc(struct ath12k_base *ab,
> -			   struct sk_buff *skb, gfp_t gfp)
> +ath12k_wmi_tlv_parse(struct ath12k_base *ab, struct sk_buff *skb)
>   {
>   	const void **tb;
>   	int ret;
>   
> -	tb = kzalloc_objs(*tb, WMI_TAG_MAX, gfp);
> -	if (!tb)
> -		return ERR_PTR(-ENOMEM);
> +	tb = this_cpu_ptr(ath12k_wmi_tb);
> +	memset(tb, 0, WMI_TAG_MAX * sizeof(*tb));
>   
> -	ret = ath12k_wmi_tlv_parse(ab, tb, skb->data, skb->len);
> -	if (ret) {
> -		kfree(tb);
> +	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
> +				  ath12k_wmi_tlv_iter_parse, (void *)tb);
> +	if (ret)
>   		return ERR_PTR(ret);
> -	}
>   
>   	return tb;
>   }
> @@ -3911,9 +3907,10 @@ ath12k_wmi_obss_color_collision_event(struct ath12k_base *ab, struct sk_buff *sk
>   	const struct wmi_obss_color_collision_event *ev;
>   	struct ath12k_link_vif *arvif;
>   	u32 vdev_id, evt_type;
> +	const void **tb;
>   	u64 bitmap;
>   
> -	const void **tb __free(kfree) = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ath12k_warn(ab, "failed to parse OBSS color collision tlv %ld\n",
>   			    PTR_ERR(tb));
> @@ -5714,7 +5711,7 @@ static int ath12k_pull_vdev_start_resp_tlv(struct ath12k_base *ab, struct sk_buf
>   	const struct wmi_vdev_start_resp_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -5724,13 +5721,11 @@ static int ath12k_pull_vdev_start_resp_tlv(struct ath12k_base *ab, struct sk_buf
>   	ev = tb[WMI_TAG_VDEV_START_RESPONSE_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch vdev start resp ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
>   	*vdev_rsp = *ev;
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -5809,7 +5804,7 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>   
>   	ath12k_dbg(ab, ATH12K_DBG_WMI, "processing regulatory ext channel list\n");
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -5819,7 +5814,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>   	ev = tb[WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch reg chan list ext update ev\n");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
> @@ -5849,7 +5843,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>   	if (num_2g_reg_rules > MAX_REG_RULES || num_5g_reg_rules > MAX_REG_RULES) {
>   		ath12k_warn(ab, "Num reg rules for 2G/5G exceeds max limit (num_2g_reg_rules: %d num_5g_reg_rules: %d max_rules: %d)\n",
>   			    num_2g_reg_rules, num_5g_reg_rules, MAX_REG_RULES);
> -		kfree(tb);
>   		return -EINVAL;
>   	}
>   
> @@ -5859,7 +5852,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>   		if (num_6g_reg_rules_ap[i] > MAX_6GHZ_REG_RULES) {
>   			ath12k_warn(ab, "Num 6G reg rules for AP mode(%d) exceeds max limit (num_6g_reg_rules_ap: %d, max_rules: %d)\n",
>   				    i, num_6g_reg_rules_ap[i], MAX_6GHZ_REG_RULES);
> -			kfree(tb);
>   			return -EINVAL;
>   		}
>   
> @@ -5884,14 +5876,12 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>   		    num_6g_reg_rules_cl[WMI_REG_VLP_AP][i] >  MAX_6GHZ_REG_RULES) {
>   			ath12k_warn(ab, "Num 6g client reg rules exceeds max limit, for client(type: %d)\n",
>   				    i);
> -			kfree(tb);
>   			return -EINVAL;
>   		}
>   	}
>   
>   	if (!total_reg_rules) {
>   		ath12k_warn(ab, "No reg rules available\n");
> -		kfree(tb);
>   		return -EINVAL;
>   	}
>   
> @@ -5993,7 +5983,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>   						      ext_wmi_reg_rule);
>   
>   		if (!reg_info->reg_rules_2g_ptr) {
> -			kfree(tb);
>   			ath12k_warn(ab, "Unable to Allocate memory for 2g rules\n");
>   			return -ENOMEM;
>   		}
> @@ -6027,7 +6016,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>   						      ext_wmi_reg_rule);
>   
>   		if (!reg_info->reg_rules_5g_ptr) {
> -			kfree(tb);
>   			ath12k_warn(ab, "Unable to Allocate memory for 5g rules\n");
>   			return -ENOMEM;
>   		}
> @@ -6046,7 +6034,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>   						      ext_wmi_reg_rule);
>   
>   		if (!reg_info->reg_rules_6g_ap_ptr[i]) {
> -			kfree(tb);
>   			ath12k_warn(ab, "Unable to Allocate memory for 6g ap rules\n");
>   			return -ENOMEM;
>   		}
> @@ -6061,7 +6048,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>   							      ext_wmi_reg_rule);
>   
>   			if (!reg_info->reg_rules_6g_client_ptr[j][i]) {
> -				kfree(tb);
>   				ath12k_warn(ab, "Unable to Allocate memory for 6g client rules\n");
>   				return -ENOMEM;
>   			}
> @@ -6096,7 +6082,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>   
>   	ath12k_dbg(ab, ATH12K_DBG_WMI, "processed regulatory ext channel list\n");
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6107,7 +6092,7 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
>   	const struct wmi_peer_delete_resp_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6117,7 +6102,6 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
>   	ev = tb[WMI_TAG_PEER_DELETE_RESP_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch peer delete resp ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
> @@ -6127,7 +6111,6 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
>   	ether_addr_copy(peer_del_resp->peer_macaddr.addr,
>   			ev->peer_macaddr.addr);
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6139,7 +6122,7 @@ static int ath12k_pull_vdev_del_resp_ev(struct ath12k_base *ab,
>   	const struct wmi_vdev_delete_resp_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6149,13 +6132,11 @@ static int ath12k_pull_vdev_del_resp_ev(struct ath12k_base *ab,
>   	ev = tb[WMI_TAG_VDEV_DELETE_RESP_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch vdev delete resp ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
>   	*vdev_id = le32_to_cpu(ev->vdev_id);
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6167,7 +6148,7 @@ static int ath12k_pull_bcn_tx_status_ev(struct ath12k_base *ab,
>   	const struct wmi_bcn_tx_status_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6177,14 +6158,12 @@ static int ath12k_pull_bcn_tx_status_ev(struct ath12k_base *ab,
>   	ev = tb[WMI_TAG_OFFLOAD_BCN_TX_STATUS_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch bcn tx status ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
>   	*vdev_id = le32_to_cpu(ev->vdev_id);
>   	*tx_status = le32_to_cpu(ev->tx_status);
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6195,7 +6174,7 @@ static int ath12k_pull_vdev_stopped_param_tlv(struct ath12k_base *ab, struct sk_
>   	const struct wmi_vdev_stopped_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6205,13 +6184,11 @@ static int ath12k_pull_vdev_stopped_param_tlv(struct ath12k_base *ab, struct sk_
>   	ev = tb[WMI_TAG_VDEV_STOPPED_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch vdev stop ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
>   	*vdev_id = le32_to_cpu(ev->vdev_id);
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6350,7 +6327,7 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
>   	const struct wmi_mgmt_tx_compl_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6360,7 +6337,6 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
>   	ev = tb[WMI_TAG_MGMT_TX_COMPL_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch mgmt tx compl ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
> @@ -6370,7 +6346,6 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
>   	param->ppdu_id = ev->ppdu_id;
>   	param->ack_rssi = ev->ack_rssi;
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6533,7 +6508,7 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	const struct wmi_scan_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6543,7 +6518,6 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	ev = tb[WMI_TAG_SCAN_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch scan ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
> @@ -6555,7 +6529,6 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	scan_evt_param->vdev_id = ev->vdev_id;
>   	scan_evt_param->tsf_timestamp = ev->tsf_timestamp;
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6566,7 +6539,7 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
>   	const struct wmi_peer_sta_kickout_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6576,7 +6549,6 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
>   	ev = tb[WMI_TAG_PEER_STA_KICKOUT_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch peer sta kickout ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
> @@ -6584,7 +6556,6 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
>   	arg->reason = le32_to_cpu(ev->reason);
>   	arg->rssi = le32_to_cpu(ev->rssi);
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6595,7 +6566,7 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	const struct wmi_roam_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6605,7 +6576,6 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	ev = tb[WMI_TAG_ROAM_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch roam ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
> @@ -6613,7 +6583,6 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	roam_ev->reason = ev->reason;
>   	roam_ev->rssi = ev->rssi;
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6647,7 +6616,7 @@ static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	const struct wmi_chan_info_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6657,7 +6626,6 @@ static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	ev = tb[WMI_TAG_CHAN_INFO_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch chan info ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
> @@ -6674,7 +6642,6 @@ static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	ch_info_ev->mac_clk_mhz = ev->mac_clk_mhz;
>   	ch_info_ev->vdev_id = ev->vdev_id;
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6686,7 +6653,7 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	const struct wmi_pdev_bss_chan_info_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6696,7 +6663,6 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	ev = tb[WMI_TAG_PDEV_BSS_CHAN_INFO_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch pdev bss chan info ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
> @@ -6714,7 +6680,6 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	bss_ch_info_ev->rx_bss_cycle_count_low = ev->rx_bss_cycle_count_low;
>   	bss_ch_info_ev->rx_bss_cycle_count_high = ev->rx_bss_cycle_count_high;
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6726,7 +6691,7 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
>   	const struct wmi_vdev_install_key_compl_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6736,7 +6701,6 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
>   	ev = tb[WMI_TAG_VDEV_INSTALL_KEY_COMPLETE_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch vdev install key compl ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
> @@ -6746,7 +6710,6 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
>   	arg->key_flags = le32_to_cpu(ev->key_flags);
>   	arg->status = le32_to_cpu(ev->status);
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6757,7 +6720,7 @@ static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct sk_buff
>   	const struct wmi_peer_assoc_conf_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6767,14 +6730,12 @@ static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct sk_buff
>   	ev = tb[WMI_TAG_PEER_ASSOC_CONF_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch peer assoc conf ev");
> -		kfree(tb);
>   		return -EPROTO;
>   	}
>   
>   	peer_assoc_conf->vdev_id = le32_to_cpu(ev->vdev_id);
>   	peer_assoc_conf->macaddr = ev->peer_macaddr.addr;
>   
> -	kfree(tb);
>   	return 0;
>   }
>   
> @@ -6792,7 +6753,7 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
>   	const void **tb;
>   	int ret, i;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6801,7 +6762,6 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
>   
>   	ev = tb[WMI_TAG_11D_NEW_COUNTRY_EVENT];
>   	if (!ev) {
> -		kfree(tb);
>   		ath12k_warn(ab, "failed to fetch 11d new cc ev");
>   		return -EPROTO;
>   	}
> @@ -6814,8 +6774,6 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
>   		   ab->new_alpha2[0],
>   		   ab->new_alpha2[1]);
>   
> -	kfree(tb);
> -
>   	for (i = 0; i < ab->num_radios; i++) {
>   		pdev = &ab->pdevs[i];
>   		ar = pdev->ar;
> @@ -8557,7 +8515,7 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
>   	const struct wmi_pdev_ctl_failsafe_chk_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -8567,7 +8525,6 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
>   	ev = tb[WMI_TAG_PDEV_CTL_FAILSAFE_CHECK_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch pdev ctl failsafe check ev");
> -		kfree(tb);
>   		return;
>   	}
>   
> @@ -8581,8 +8538,6 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
>   	if (ev->ctl_failsafe_status != 0)
>   		ath12k_warn(ab, "pdev ctl failsafe failure status %d",
>   			    ev->ctl_failsafe_status);
> -
> -	kfree(tb);
>   }
>   
>   static void
> @@ -8654,7 +8609,7 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
>   	const u32 *vdev_ids;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -8666,7 +8621,6 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
>   
>   	if (!ev || !vdev_ids) {
>   		ath12k_warn(ab, "failed to fetch pdev csa switch count ev");
> -		kfree(tb);
>   		return;
>   	}
>   
> @@ -8676,8 +8630,6 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
>   		   ev->num_vdevs);
>   
>   	ath12k_wmi_process_csa_switch_count_event(ab, ev, vdev_ids);
> -
> -	kfree(tb);
>   }
>   
>   static void
> @@ -8689,7 +8641,7 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
>   	struct ath12k *ar;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -8700,7 +8652,6 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
>   
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch pdev dfs radar detected ev");
> -		kfree(tb);
>   		return;
>   	}
>   
> @@ -8739,8 +8690,6 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
>   
>   exit:
>   	rcu_read_unlock();
> -
> -	kfree(tb);
>   }
>   
>   static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
> @@ -8751,7 +8700,7 @@ static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
>   	int ret;
>   	u16 length;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
> @@ -8762,14 +8711,11 @@ static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
>   	ev = tb[WMI_TAG_ARRAY_BYTE];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch ftm msg\n");
> -		kfree(tb);
>   		return;
>   	}
>   
>   	length = skb->len - TLV_HDR_SIZE;
>   	ath12k_tm_process_event(ab, cmd_id, ev, length);
> -	kfree(tb);
> -	tb = NULL;
>   }
>   
>   static void
> @@ -8782,7 +8728,7 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
>   	int temp;
>   	u32 pdev_id;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ath12k_warn(ab, "failed to parse tlv: %ld\n", PTR_ERR(tb));
>   		return;
> @@ -8791,15 +8737,12 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
>   	ev = tb[WMI_TAG_PDEV_TEMPERATURE_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch pdev temp ev\n");
> -		kfree(tb);
>   		return;
>   	}
>   
>   	temp = a_sle32_to_cpu(ev->temp);
>   	pdev_id = le32_to_cpu(ev->pdev_id);
>   
> -	kfree(tb);
> -
>   	ath12k_dbg(ab, ATH12K_DBG_WMI,
>   		   "pdev temperature ev temp %d pdev_id %u\n",
>   		   temp, pdev_id);
> @@ -8826,7 +8769,7 @@ static void ath12k_fils_discovery_event(struct ath12k_base *ab,
>   	const struct wmi_fils_discovery_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab,
> @@ -8838,15 +8781,12 @@ static void ath12k_fils_discovery_event(struct ath12k_base *ab,
>   	ev = tb[WMI_TAG_HOST_SWFDA_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch FILS discovery event\n");
> -		kfree(tb);
>   		return;
>   	}
>   
>   	ath12k_warn(ab,
>   		    "FILS discovery frame expected from host for vdev_id: %u, transmission scheduled at %u, next TBTT: %u\n",
>   		    ev->vdev_id, ev->fils_tt, ev->tbtt);
> -
> -	kfree(tb);
>   }
>   
>   static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
> @@ -8856,7 +8796,7 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
>   	const struct wmi_probe_resp_tx_status_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab,
> @@ -8869,7 +8809,6 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
>   	if (!ev) {
>   		ath12k_warn(ab,
>   			    "failed to fetch probe response transmission status event");
> -		kfree(tb);
>   		return;
>   	}
>   
> @@ -8877,8 +8816,6 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
>   		ath12k_warn(ab,
>   			    "Probe response transmission failed for vdev_id %u, status %u\n",
>   			    ev->vdev_id, ev->tx_status);
> -
> -	kfree(tb);
>   }
>   
>   static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
> @@ -8890,7 +8827,7 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
>   	struct ath12k *ar;
>   	int ret, vdev_id;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse P2P NoA TLV: %d\n", ret);
> @@ -8900,10 +8837,8 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
>   	ev = tb[WMI_TAG_P2P_NOA_EVENT];
>   	noa = tb[WMI_TAG_P2P_NOA_INFO];
>   
> -	if (!ev || !noa) {
> -		ret = -EPROTO;
> -		goto out;
> -	}
> +	if (!ev || !noa)
> +		return -EPROTO;
>   
>   	vdev_id = __le32_to_cpu(ev->vdev_id);
>   
> @@ -8926,8 +8861,6 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
>   
>   unlock:
>   	rcu_read_unlock();
> -out:
> -	kfree(tb);
>   	return ret;
>   }
>   
> @@ -8938,7 +8871,7 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
>   	const void **tb;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -8946,10 +8879,8 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
>   	}
>   
>   	ev = tb[WMI_TAG_RFKILL_EVENT];
> -	if (!ev) {
> -		kfree(tb);
> +	if (!ev)
>   		return;
> -	}
>   
>   	ath12k_dbg(ab, ATH12K_DBG_MAC,
>   		   "wmi tlv rfkill state change gpio %d type %d radio_state %d\n",
> @@ -8962,7 +8893,6 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
>   	spin_unlock_bh(&ab->base_lock);
>   
>   	queue_work(ab->workqueue, &ab->rfkill_work);
> -	kfree(tb);
>   }
>   
>   static void
> @@ -8978,7 +8908,7 @@ static void ath12k_wmi_twt_enable_event(struct ath12k_base *ab,
>   	const struct wmi_twt_enable_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse wmi twt enable status event tlv: %d\n",
> @@ -8989,15 +8919,12 @@ static void ath12k_wmi_twt_enable_event(struct ath12k_base *ab,
>   	ev = tb[WMI_TAG_TWT_ENABLE_COMPLETE_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch twt enable wmi event\n");
> -		goto exit;
> +		return;
>   	}
>   
>   	ath12k_dbg(ab, ATH12K_DBG_MAC, "wmi twt enable event pdev id %u status %u\n",
>   		   le32_to_cpu(ev->pdev_id),
>   		   le32_to_cpu(ev->status));
> -
> -exit:
> -	kfree(tb);
>   }
>   
>   static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
> @@ -9007,7 +8934,7 @@ static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
>   	const struct wmi_twt_disable_event *ev;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse wmi twt disable status event tlv: %d\n",
> @@ -9018,15 +8945,12 @@ static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
>   	ev = tb[WMI_TAG_TWT_DISABLE_COMPLETE_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch twt disable wmi event\n");
> -		goto exit;
> +		return;
>   	}
>   
>   	ath12k_dbg(ab, ATH12K_DBG_MAC, "wmi twt disable event pdev id %d status %u\n",
>   		   le32_to_cpu(ev->pdev_id),
>   		   le32_to_cpu(ev->status));
> -
> -exit:
> -	kfree(tb);
>   }
>   
>   static int ath12k_wmi_wow_wakeup_host_parse(struct ath12k_base *ab,
> @@ -9099,7 +9023,7 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
>   	const void **tb;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -9109,7 +9033,6 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
>   	ev = tb[WMI_TAG_GTK_OFFLOAD_STATUS_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch gtk offload status ev");
> -		kfree(tb);
>   		return;
>   	}
>   
> @@ -9119,7 +9042,6 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
>   		rcu_read_unlock();
>   		ath12k_warn(ab, "failed to get arvif for vdev_id:%d\n",
>   			    le32_to_cpu(ev->vdev_id));
> -		kfree(tb);
>   		return;
>   	}
>   
> @@ -9135,8 +9057,6 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
>   				   (void *)&replay_ctr_be, GFP_ATOMIC);
>   
>   	rcu_read_unlock();
> -
> -	kfree(tb);
>   }
>   
>   static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
> @@ -9148,7 +9068,7 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
>   	const void **tb;
>   	int ret, i;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse mlo setup complete event tlv: %d\n",
> @@ -9159,7 +9079,6 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
>   	ev = tb[WMI_TAG_MLO_SETUP_COMPLETE_EVENT];
>   	if (!ev) {
>   		ath12k_warn(ab, "failed to fetch mlo setup complete event\n");
> -		kfree(tb);
>   		return;
>   	}
>   
> @@ -9178,14 +9097,11 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
>   	if (!ar) {
>   		ath12k_warn(ab, "invalid pdev_id %d status %u in setup complete event\n",
>   			    ev->pdev_id, ev->status);
> -		goto out;
> +		return;
>   	}
>   
>   	ar->mlo_setup_status = le32_to_cpu(ev->status);
>   	complete(&ar->mlo_setup_done);
> -
> -out:
> -	kfree(tb);
>   }
>   
>   static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
> @@ -9195,7 +9111,7 @@ static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
>   	const void **tb;
>   	int ret;
>   
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>   	if (IS_ERR(tb)) {
>   		ret = PTR_ERR(tb);
>   		ath12k_warn(ab, "failed to parse teardown complete event tlv: %d\n", ret);
> @@ -9203,13 +9119,8 @@ static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
>   	}
>   
>   	ev = tb[WMI_TAG_MLO_TEARDOWN_COMPLETE];
> -	if (!ev) {
> +	if (!ev)
>   		ath12k_warn(ab, "failed to fetch teardown complete event\n");
> -		kfree(tb);
> -		return;
> -	}
> -
> -	kfree(tb);
>   }
>   
>   #ifdef CONFIG_ATH12K_DEBUGFS
> @@ -11239,3 +11150,31 @@ int ath12k_wmi_send_mlo_link_set_active_cmd(struct ath12k_base *ab,
>   	dev_kfree_skb(skb);
>   	return ret;
>   }
> +
> +int ath12k_wmi_alloc(void)
> +{
> +	guard(mutex)(&ath12k_wmi_mutex);
> +
> +	if (!ath12k_wmi_tb) {
> +		ath12k_wmi_tb = __alloc_percpu(WMI_TAG_MAX * sizeof(void *),
> +					       __alignof__(void *));
> +		if (!ath12k_wmi_tb)
> +			return -ENOMEM;
> +
> +		refcount_set(&ath12k_wmi_refcount, 1);
> +	} else {
> +		refcount_inc(&ath12k_wmi_refcount);
> +	}
> +
> +	return 0;
> +}
> +
> +void ath12k_wmi_free(void)
> +{
> +	guard(mutex)(&ath12k_wmi_mutex);
> +
> +	if (refcount_dec_and_test(&ath12k_wmi_refcount)) {
> +		free_percpu(ath12k_wmi_tb);
> +		ath12k_wmi_tb = NULL;
> +	}
> +}
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 5ba9b7d3a888..4a34b2ca99ea 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -6576,4 +6576,7 @@ int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
>   				       struct ath12k_reg_tpc_power_info *param);
>   int ath12k_wmi_send_mlo_link_set_active_cmd(struct ath12k_base *ab,
>   					    struct wmi_mlo_link_set_active_arg *param);
> +int ath12k_wmi_alloc(void);
> +void ath12k_wmi_free(void);
> +
>   #endif

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>



