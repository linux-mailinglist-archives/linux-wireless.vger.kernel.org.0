Return-Path: <linux-wireless+bounces-34201-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFalLQU1y2l1EwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34201-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 04:44:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49260363871
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 04:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC1ED3013FC7
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 02:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB0B36681B;
	Tue, 31 Mar 2026 02:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ex5FfE2l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fGNdjYlV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A96364E83
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 02:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774925055; cv=none; b=QOK4RdmFCFR4HU6sUBNkjBLiVavMcjHwjfx0AdZ8+u7iNo1DBvjKVi6RC4iJ7T03oDYK/9ruu60zI4XCcynsA9POYE2Vy0gbyZcljIHW+zPgbrZJmzFYzLZ1OfiJ+XP0BXP2L7fTFMN5Vk1BiFXqT6ZE7c1bkovY6+g5R2ytBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774925055; c=relaxed/simple;
	bh=eNMGQ5qgQkBQWGBC018tu5qukqFbhuXT1f3JEnMUNjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZJpzoXgd2b7/e+/GC5PtdsyJKmkOWeQCgrot1ZaIjDVObNj126S2ahLwJ3E1ZaL9VnJ4zPnxrWE7jQEu8Nz3u+5L+8GN9TcX/uuSPsoXIYYYItJ8lRWdqWibBLWFnBhgyi8xHtlIxxvBUF1FYmrfeefQfUek0BjMnsCr1a8CSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ex5FfE2l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fGNdjYlV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V0deJG3174240
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 02:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7vHv8n+7B7O/PAjlK8G+JNFeMs4mGY/4FVifq3Ppe+8=; b=Ex5FfE2l/WRg7s8O
	qsYtwbpxDeCuiUyCpQyznKFF8jak4DrJNyvpIGAC4xyGjQCYqRrHYkuypRCEHk+y
	nLKsAteGJDL3FRZFhCeJjrXt80S5JZt//+DVt+FK7iE2VSiN/Z8D0AZ/pmCMrpqo
	OyPcklubdbotiws/oaDZvNA+dAPTReJjNeQq3OzW3/a5WJmb2WDEpcln/zSzFCOT
	T6RhwzdgUNGVgBEHLR7sO7w2mq+MwaVOeyP2XUaU1Qm4RSyHmmylLkQuF0DrGPQL
	HbrX0MCbg+JDPoscGcwG8A5bZHImKGVuqdPhqrDi3MQ2Gqi9Kz8plIfNrGeMWNtB
	VXnyMQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7q9h3ajx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 02:44:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b242f76113so33304975ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 19:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774925051; x=1775529851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7vHv8n+7B7O/PAjlK8G+JNFeMs4mGY/4FVifq3Ppe+8=;
        b=fGNdjYlVtq4QEpj9bUvsAS/izGj/rbPNS4fJ+2MT9Oo4RFIMypJUVu/FtRNTRgaxo+
         282XyobKCWpNckXeqmV2XXt92gmqznOTzvY59j5bRPtAmRByiz5fzSJBkbREXaEL6c3X
         zwGbpPNYq5jyJdM+8NTH/M2pX5SzMmC8fAB6BCB9RJlDt8LCX8GN8/jXgLzLlqNQXlrv
         B6zbWJRCJaXYovqAY6NJTnYZA7W9eLjKLIRHr/jFjiqPXRZAmEAvNEhk3745kScS+c49
         0MLjolBalfjSh6BrT2ubXlHI+8tQbRplZJiGtekweCwizhypw2qZgPh9nO+Y5dZXug7J
         gRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774925051; x=1775529851;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vHv8n+7B7O/PAjlK8G+JNFeMs4mGY/4FVifq3Ppe+8=;
        b=mUNt0d4f7R1fgvw/sIWbXOjH4omez7rVOBv6PDhlAAD0objyAOGOErewZ+LQ0cuH4w
         6fRwaRm5oCnZPUfHUm63O3Mf4czDQIYA5n/YnGtPBZHIvNkuKLAJt/L/uhsrUY7HDHyK
         HEZKNDiMriqkYRuJl1uqKt5ijzDwqPckYM6Jc8MoXjuWXRdzc0gjCbwtBFbWaioavH8q
         2VjkSJN+OdnjnSfmb2y96g2+YnQ+dWUQt6CG5K8fLeGi4z1Pm8FU9rX+69iTUtNEo7kH
         XR/4UWKhwNRePg1eBjfDSDTKLh7RvSizTvK5c3kkk6T1mIsygXEvNNI0Mcvb8toS7pn0
         t1pw==
X-Gm-Message-State: AOJu0Yyi5WthlHpoWHw3PjshUNSfibZsXUYb4QDgL/dYO7SClFFapfI4
	P9hu6Fk4XkUqUGcn8wD/JxnTBa8Qlw2OxwsPj4XQtb0hSdm7TDKWphNb8LJj+f8YFLzHAfBw6Av
	BoFiSketVYjPekrVAABqj5KSE7bSwTPxDFBS9yDnalsj6HkaCu1EwwhGMMTD9JlE2O4r+Fw==
X-Gm-Gg: ATEYQzwAo8dnuDLYGJEjn6m9RyMIiSwHpbpOv+jymKtYIcQqYR5vWbzm5dzHcBw6lGm
	pXW9DBDlMkrIXEtm8TYnNqt4kX31UGtDwo5h4DBJQOjfW05whFh/JvvNTgNuddNUPWYcoFShOHI
	aFJmYHqqFGsdepFaYjWua+xtIE65i+MQw39wlkXo5zo6ZiOeSk9RMWfHJ4zs70gPEC39L0ULtA9
	EgUeLdTBT56MZCZa9CXrnpTxtK0LJkLmqeQZJmjVrmdMJQLYtaypisyD15mNC1Tcd6Qx9mJjM1T
	aft664a14AUHIbLeYJOPVp95Yn7LWe5hvFE9dPRuDlti7OIOBIwSwCx2DTcRO/q8hb8GksiiNQk
	nS7FgyjzJE9BOnOwOmOh5t9ZK+xnhC33Nmfj3TwQH+EiHt98M/I8U91nE6M2DrR4IANbbDdv4+d
	7cFodcmfG7KsWGDDgkpw==
X-Received: by 2002:a17:903:1a06:b0:2b2:462d:9a0b with SMTP id d9443c01a7336-2b2462dbb4dmr99085315ad.49.1774925050526;
        Mon, 30 Mar 2026 19:44:10 -0700 (PDT)
X-Received: by 2002:a17:903:1a06:b0:2b2:462d:9a0b with SMTP id d9443c01a7336-2b2462dbb4dmr99084915ad.49.1774925049707;
        Mon, 30 Mar 2026 19:44:09 -0700 (PDT)
Received: from [10.133.33.81] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427ae07fsm97263035ad.69.2026.03.30.19.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 19:44:09 -0700 (PDT)
Message-ID: <b066de0a-71bc-4d03-8ce1-c6ff22eddda1@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 10:44:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260330102434.13136-1-nico.escande@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260330102434.13136-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAyMyBTYWx0ZWRfX0hFauAYwwN+u
 /Wg6HDtUPN9O+PiHRjNdQ/a3426AvDTUKb2gdL+iDUGWCMjd3a8a6+U3OyJaAqQswH6/HWDOluH
 hCds0O2hmYocQEZiB+msD+aZMxzOJDS0T2biMhkwqNzt0SMOUBvEg9K14u7EoTXHWAHJfxz4zMC
 BOLWhuoiZQVQiRwLTV3iWlKVJGJzZ/Srl0mngImq5HyX1ZH7xzbjNhVZ8a+/aUDRs4xn3Es+AHI
 xteKYdf6vifFTObnYzfrAYBvXyyRXYN7VSCRhtc/W/2e6RuUS16eljVt6oVpgTuW8uaSVFXRujz
 a1DWW2i7sCkFG+G6TDRJHt+PPxFGts2K8enfLH169Ej8E+c16CpuAkXD/iqZ3rDSwjPoVsTy5yH
 uGZktuz3yrhyssTjIBv3Q7Ow9FRtge78meBk+fhwBTyr9bZdE5nmB4fGX6YuK95ylOPnXlrF8xh
 eoHU9+H2iEFru5wP1Fw==
X-Authority-Analysis: v=2.4 cv=AZS83nXG c=1 sm=1 tr=0 ts=69cb34fc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=yA9rEFzvgfH8ElKNbE4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: AroVQbff9ztBSdGN2mlPniq4kgt4TmIl
X-Proofpoint-ORIG-GUID: AroVQbff9ztBSdGN2mlPniq4kgt4TmIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310023
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34201-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 49260363871
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/30/2026 6:24 PM, Nicolas Escande wrote:
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
> changes from v4:
>   - moved to a single instance, refcounted per cpu memory alloc
>   
> changes from v3:
>   - simplified ath12k_core_init() with a single statement
>   - move perpcu.h include directly to wmi.c
> 
> changes from v2:
>   - removed now superfluous return in ath12k_wmi_event_teardown_complete()
>   - moved ath12k_wmi_tb declaration to wmi.c & added two functions to
>     alloc / free it
>   - removed useless error message on memory allocation failure
> 
> changes from v1:
>   - rebased on ath-next 27401c9b1432
>   - changed wording according to Jeff's comment
>   - moved alloc/cleanup to new module_init/exit functions in the
>     ath12k module as per Baochen's comment
> 
> changes from RFC:
>   - rebased on ath-next 8e0ab5b9adb7
>   - converted missing call sites ath12k_wmi_obss_color_collision_event()
>     & ath12k_wmi_pdev_temperature_event()
>   - changed alloc order & cleanup path in ath12k_core_alloc() as it seems
>     it confused people
>   - used sizeof(*tb) in ath12k_wmi_tlv_parse()
> ---
>  drivers/net/wireless/ath/ath12k/core.c |   6 +
>  drivers/net/wireless/ath/ath12k/wmi.c  | 215 +++++++++----------------
>  drivers/net/wireless/ath/ath12k/wmi.h  |   3 +
>  3 files changed, 85 insertions(+), 139 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index c31c47fb5a73..76060d448920 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -2258,6 +2258,7 @@ void ath12k_core_free(struct ath12k_base *ab)
>  	timer_delete_sync(&ab->rx_replenish_retry);
>  	destroy_workqueue(ab->workqueue_aux);
>  	destroy_workqueue(ab->workqueue);
> +	ath12k_wmi_free();
>  	kfree(ab);
>  }
>  
> @@ -2280,6 +2281,9 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>  	if (!ab->workqueue_aux)
>  		goto err_free_wq;
>  
> +	if (ath12k_wmi_alloc() < 0)
> +		goto err_free_wq_aux;
> +
>  	mutex_init(&ab->core_lock);
>  	spin_lock_init(&ab->base_lock);
>  	init_completion(&ab->reset_complete);
> @@ -2314,6 +2318,8 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>  
>  	return ab;
>  
> +err_free_wq_aux:
> +	destroy_workqueue(ab->workqueue_aux);
>  err_free_wq:
>  	destroy_workqueue(ab->workqueue);
>  err_sc_free:
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 65a05a9520ff..b75491d51831 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -15,6 +15,7 @@
>  #include <linux/time.h>
>  #include <linux/of.h>
>  #include <linux/cleanup.h>
> +#include <linux/percpu.h>
>  #include "core.h"
>  #include "debugfs.h"
>  #include "debug.h"
> @@ -134,6 +135,10 @@ struct wmi_pdev_set_obss_bitmap_arg {
>  	const char *label;
>  };
>  
> +static DEFINE_MUTEX(ath12k_wmi_mutex);
> +static int ath12k_wmi_refcount;
> +static void __percpu *ath12k_wmi_tb;
> +
>  static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
>  	[WMI_TAG_ARRAY_BYTE] = { .min_len = 0 },
>  	[WMI_TAG_ARRAY_UINT32] = { .min_len = 0 },
> @@ -289,29 +294,19 @@ static int ath12k_wmi_tlv_iter_parse(struct ath12k_base *ab, u16 tag, u16 len,
>  	return 0;
>  }
>  
> -static int ath12k_wmi_tlv_parse(struct ath12k_base *ar, const void **tb,
> -				const void *ptr, size_t len)
> -{
> -	return ath12k_wmi_tlv_iter(ar, ptr, len, ath12k_wmi_tlv_iter_parse,
> -				   (void *)tb);
> -}
> -
>  static const void **
> -ath12k_wmi_tlv_parse_alloc(struct ath12k_base *ab,
> -			   struct sk_buff *skb, gfp_t gfp)
> +ath12k_wmi_tlv_parse(struct ath12k_base *ab, struct sk_buff *skb)
>  {
>  	const void **tb;
>  	int ret;
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
>  		return ERR_PTR(ret);
> -	}
>  
>  	return tb;
>  }
> @@ -3911,9 +3906,10 @@ ath12k_wmi_obss_color_collision_event(struct ath12k_base *ab, struct sk_buff *sk
>  	const struct wmi_obss_color_collision_event *ev;
>  	struct ath12k_link_vif *arvif;
>  	u32 vdev_id, evt_type;
> +	const void **tb;
>  	u64 bitmap;
>  
> -	const void **tb __free(kfree) = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ath12k_warn(ab, "failed to parse OBSS color collision tlv %ld\n",
>  			    PTR_ERR(tb));
> @@ -5714,7 +5710,7 @@ static int ath12k_pull_vdev_start_resp_tlv(struct ath12k_base *ab, struct sk_buf
>  	const struct wmi_vdev_start_resp_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -5724,13 +5720,11 @@ static int ath12k_pull_vdev_start_resp_tlv(struct ath12k_base *ab, struct sk_buf
>  	ev = tb[WMI_TAG_VDEV_START_RESPONSE_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch vdev start resp ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
>  	*vdev_rsp = *ev;
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -5809,7 +5803,7 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>  
>  	ath12k_dbg(ab, ATH12K_DBG_WMI, "processing regulatory ext channel list\n");
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -5819,7 +5813,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch reg chan list ext update ev\n");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
> @@ -5849,7 +5842,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>  	if (num_2g_reg_rules > MAX_REG_RULES || num_5g_reg_rules > MAX_REG_RULES) {
>  		ath12k_warn(ab, "Num reg rules for 2G/5G exceeds max limit (num_2g_reg_rules: %d num_5g_reg_rules: %d max_rules: %d)\n",
>  			    num_2g_reg_rules, num_5g_reg_rules, MAX_REG_RULES);
> -		kfree(tb);
>  		return -EINVAL;
>  	}
>  
> @@ -5859,7 +5851,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>  		if (num_6g_reg_rules_ap[i] > MAX_6GHZ_REG_RULES) {
>  			ath12k_warn(ab, "Num 6G reg rules for AP mode(%d) exceeds max limit (num_6g_reg_rules_ap: %d, max_rules: %d)\n",
>  				    i, num_6g_reg_rules_ap[i], MAX_6GHZ_REG_RULES);
> -			kfree(tb);
>  			return -EINVAL;
>  		}
>  
> @@ -5884,14 +5875,12 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>  		    num_6g_reg_rules_cl[WMI_REG_VLP_AP][i] >  MAX_6GHZ_REG_RULES) {
>  			ath12k_warn(ab, "Num 6g client reg rules exceeds max limit, for client(type: %d)\n",
>  				    i);
> -			kfree(tb);
>  			return -EINVAL;
>  		}
>  	}
>  
>  	if (!total_reg_rules) {
>  		ath12k_warn(ab, "No reg rules available\n");
> -		kfree(tb);
>  		return -EINVAL;
>  	}
>  
> @@ -5993,7 +5982,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>  						      ext_wmi_reg_rule);
>  
>  		if (!reg_info->reg_rules_2g_ptr) {
> -			kfree(tb);
>  			ath12k_warn(ab, "Unable to Allocate memory for 2g rules\n");
>  			return -ENOMEM;
>  		}
> @@ -6027,7 +6015,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>  						      ext_wmi_reg_rule);
>  
>  		if (!reg_info->reg_rules_5g_ptr) {
> -			kfree(tb);
>  			ath12k_warn(ab, "Unable to Allocate memory for 5g rules\n");
>  			return -ENOMEM;
>  		}
> @@ -6046,7 +6033,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>  						      ext_wmi_reg_rule);
>  
>  		if (!reg_info->reg_rules_6g_ap_ptr[i]) {
> -			kfree(tb);
>  			ath12k_warn(ab, "Unable to Allocate memory for 6g ap rules\n");
>  			return -ENOMEM;
>  		}
> @@ -6061,7 +6047,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>  							      ext_wmi_reg_rule);
>  
>  			if (!reg_info->reg_rules_6g_client_ptr[j][i]) {
> -				kfree(tb);
>  				ath12k_warn(ab, "Unable to Allocate memory for 6g client rules\n");
>  				return -ENOMEM;
>  			}
> @@ -6096,7 +6081,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>  
>  	ath12k_dbg(ab, ATH12K_DBG_WMI, "processed regulatory ext channel list\n");
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6107,7 +6091,7 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
>  	const struct wmi_peer_delete_resp_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6117,7 +6101,6 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
>  	ev = tb[WMI_TAG_PEER_DELETE_RESP_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch peer delete resp ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
> @@ -6127,7 +6110,6 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
>  	ether_addr_copy(peer_del_resp->peer_macaddr.addr,
>  			ev->peer_macaddr.addr);
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6139,7 +6121,7 @@ static int ath12k_pull_vdev_del_resp_ev(struct ath12k_base *ab,
>  	const struct wmi_vdev_delete_resp_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6149,13 +6131,11 @@ static int ath12k_pull_vdev_del_resp_ev(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_VDEV_DELETE_RESP_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch vdev delete resp ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
>  	*vdev_id = le32_to_cpu(ev->vdev_id);
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6167,7 +6147,7 @@ static int ath12k_pull_bcn_tx_status_ev(struct ath12k_base *ab,
>  	const struct wmi_bcn_tx_status_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6177,14 +6157,12 @@ static int ath12k_pull_bcn_tx_status_ev(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_OFFLOAD_BCN_TX_STATUS_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch bcn tx status ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
>  	*vdev_id = le32_to_cpu(ev->vdev_id);
>  	*tx_status = le32_to_cpu(ev->tx_status);
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6195,7 +6173,7 @@ static int ath12k_pull_vdev_stopped_param_tlv(struct ath12k_base *ab, struct sk_
>  	const struct wmi_vdev_stopped_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6205,13 +6183,11 @@ static int ath12k_pull_vdev_stopped_param_tlv(struct ath12k_base *ab, struct sk_
>  	ev = tb[WMI_TAG_VDEV_STOPPED_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch vdev stop ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
>  	*vdev_id = le32_to_cpu(ev->vdev_id);
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6350,7 +6326,7 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
>  	const struct wmi_mgmt_tx_compl_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6360,7 +6336,6 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_MGMT_TX_COMPL_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch mgmt tx compl ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
> @@ -6370,7 +6345,6 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
>  	param->ppdu_id = ev->ppdu_id;
>  	param->ack_rssi = ev->ack_rssi;
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6533,7 +6507,7 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
>  	const struct wmi_scan_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6543,7 +6517,6 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
>  	ev = tb[WMI_TAG_SCAN_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch scan ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
> @@ -6555,7 +6528,6 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
>  	scan_evt_param->vdev_id = ev->vdev_id;
>  	scan_evt_param->tsf_timestamp = ev->tsf_timestamp;
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6566,7 +6538,7 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
>  	const struct wmi_peer_sta_kickout_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6576,7 +6548,6 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
>  	ev = tb[WMI_TAG_PEER_STA_KICKOUT_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch peer sta kickout ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
> @@ -6584,7 +6555,6 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
>  	arg->reason = le32_to_cpu(ev->reason);
>  	arg->rssi = le32_to_cpu(ev->rssi);
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6595,7 +6565,7 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
>  	const struct wmi_roam_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6605,7 +6575,6 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
>  	ev = tb[WMI_TAG_ROAM_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch roam ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
> @@ -6613,7 +6582,6 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
>  	roam_ev->reason = ev->reason;
>  	roam_ev->rssi = ev->rssi;
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6647,7 +6615,7 @@ static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
>  	const struct wmi_chan_info_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6657,7 +6625,6 @@ static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
>  	ev = tb[WMI_TAG_CHAN_INFO_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch chan info ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
> @@ -6674,7 +6641,6 @@ static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
>  	ch_info_ev->mac_clk_mhz = ev->mac_clk_mhz;
>  	ch_info_ev->vdev_id = ev->vdev_id;
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6686,7 +6652,7 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
>  	const struct wmi_pdev_bss_chan_info_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6696,7 +6662,6 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
>  	ev = tb[WMI_TAG_PDEV_BSS_CHAN_INFO_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch pdev bss chan info ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
> @@ -6714,7 +6679,6 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
>  	bss_ch_info_ev->rx_bss_cycle_count_low = ev->rx_bss_cycle_count_low;
>  	bss_ch_info_ev->rx_bss_cycle_count_high = ev->rx_bss_cycle_count_high;
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6726,7 +6690,7 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
>  	const struct wmi_vdev_install_key_compl_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6736,7 +6700,6 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
>  	ev = tb[WMI_TAG_VDEV_INSTALL_KEY_COMPLETE_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch vdev install key compl ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
> @@ -6746,7 +6709,6 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
>  	arg->key_flags = le32_to_cpu(ev->key_flags);
>  	arg->status = le32_to_cpu(ev->status);
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6757,7 +6719,7 @@ static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct sk_buff
>  	const struct wmi_peer_assoc_conf_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6767,14 +6729,12 @@ static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct sk_buff
>  	ev = tb[WMI_TAG_PEER_ASSOC_CONF_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch peer assoc conf ev");
> -		kfree(tb);
>  		return -EPROTO;
>  	}
>  
>  	peer_assoc_conf->vdev_id = le32_to_cpu(ev->vdev_id);
>  	peer_assoc_conf->macaddr = ev->peer_macaddr.addr;
>  
> -	kfree(tb);
>  	return 0;
>  }
>  
> @@ -6792,7 +6752,7 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
>  	const void **tb;
>  	int ret, i;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -6801,7 +6761,6 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
>  
>  	ev = tb[WMI_TAG_11D_NEW_COUNTRY_EVENT];
>  	if (!ev) {
> -		kfree(tb);
>  		ath12k_warn(ab, "failed to fetch 11d new cc ev");
>  		return -EPROTO;
>  	}
> @@ -6814,8 +6773,6 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
>  		   ab->new_alpha2[0],
>  		   ab->new_alpha2[1]);
>  
> -	kfree(tb);
> -
>  	for (i = 0; i < ab->num_radios; i++) {
>  		pdev = &ab->pdevs[i];
>  		ar = pdev->ar;
> @@ -8557,7 +8514,7 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
>  	const struct wmi_pdev_ctl_failsafe_chk_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -8567,7 +8524,6 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_PDEV_CTL_FAILSAFE_CHECK_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch pdev ctl failsafe check ev");
> -		kfree(tb);
>  		return;
>  	}
>  
> @@ -8581,8 +8537,6 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
>  	if (ev->ctl_failsafe_status != 0)
>  		ath12k_warn(ab, "pdev ctl failsafe failure status %d",
>  			    ev->ctl_failsafe_status);
> -
> -	kfree(tb);
>  }
>  
>  static void
> @@ -8654,7 +8608,7 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
>  	const u32 *vdev_ids;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -8666,7 +8620,6 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
>  
>  	if (!ev || !vdev_ids) {
>  		ath12k_warn(ab, "failed to fetch pdev csa switch count ev");
> -		kfree(tb);
>  		return;
>  	}
>  
> @@ -8676,8 +8629,6 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
>  		   ev->num_vdevs);
>  
>  	ath12k_wmi_process_csa_switch_count_event(ab, ev, vdev_ids);
> -
> -	kfree(tb);
>  }
>  
>  static void
> @@ -8689,7 +8640,7 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
>  	struct ath12k *ar;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -8700,7 +8651,6 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
>  
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch pdev dfs radar detected ev");
> -		kfree(tb);
>  		return;
>  	}
>  
> @@ -8739,8 +8689,6 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
>  
>  exit:
>  	rcu_read_unlock();
> -
> -	kfree(tb);
>  }
>  
>  static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
> @@ -8751,7 +8699,7 @@ static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
>  	int ret;
>  	u16 length;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
> @@ -8762,14 +8710,11 @@ static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
>  	ev = tb[WMI_TAG_ARRAY_BYTE];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch ftm msg\n");
> -		kfree(tb);
>  		return;
>  	}
>  
>  	length = skb->len - TLV_HDR_SIZE;
>  	ath12k_tm_process_event(ab, cmd_id, ev, length);
> -	kfree(tb);
> -	tb = NULL;
>  }
>  
>  static void
> @@ -8782,7 +8727,7 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
>  	int temp;
>  	u32 pdev_id;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ath12k_warn(ab, "failed to parse tlv: %ld\n", PTR_ERR(tb));
>  		return;
> @@ -8791,15 +8736,12 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_PDEV_TEMPERATURE_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch pdev temp ev\n");
> -		kfree(tb);
>  		return;
>  	}
>  
>  	temp = a_sle32_to_cpu(ev->temp);
>  	pdev_id = le32_to_cpu(ev->pdev_id);
>  
> -	kfree(tb);
> -
>  	ath12k_dbg(ab, ATH12K_DBG_WMI,
>  		   "pdev temperature ev temp %d pdev_id %u\n",
>  		   temp, pdev_id);
> @@ -8826,7 +8768,7 @@ static void ath12k_fils_discovery_event(struct ath12k_base *ab,
>  	const struct wmi_fils_discovery_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab,
> @@ -8838,15 +8780,12 @@ static void ath12k_fils_discovery_event(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_HOST_SWFDA_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch FILS discovery event\n");
> -		kfree(tb);
>  		return;
>  	}
>  
>  	ath12k_warn(ab,
>  		    "FILS discovery frame expected from host for vdev_id: %u, transmission scheduled at %u, next TBTT: %u\n",
>  		    ev->vdev_id, ev->fils_tt, ev->tbtt);
> -
> -	kfree(tb);
>  }
>  
>  static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
> @@ -8856,7 +8795,7 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
>  	const struct wmi_probe_resp_tx_status_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab,
> @@ -8869,7 +8808,6 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
>  	if (!ev) {
>  		ath12k_warn(ab,
>  			    "failed to fetch probe response transmission status event");
> -		kfree(tb);
>  		return;
>  	}
>  
> @@ -8877,8 +8815,6 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
>  		ath12k_warn(ab,
>  			    "Probe response transmission failed for vdev_id %u, status %u\n",
>  			    ev->vdev_id, ev->tx_status);
> -
> -	kfree(tb);
>  }
>  
>  static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
> @@ -8890,7 +8826,7 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
>  	struct ath12k *ar;
>  	int ret, vdev_id;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse P2P NoA TLV: %d\n", ret);
> @@ -8900,10 +8836,8 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_P2P_NOA_EVENT];
>  	noa = tb[WMI_TAG_P2P_NOA_INFO];
>  
> -	if (!ev || !noa) {
> -		ret = -EPROTO;
> -		goto out;
> -	}
> +	if (!ev || !noa)
> +		return -EPROTO;
>  
>  	vdev_id = __le32_to_cpu(ev->vdev_id);
>  
> @@ -8926,8 +8860,6 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
>  
>  unlock:
>  	rcu_read_unlock();
> -out:
> -	kfree(tb);
>  	return ret;
>  }
>  
> @@ -8938,7 +8870,7 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
>  	const void **tb;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -8946,10 +8878,8 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
>  	}
>  
>  	ev = tb[WMI_TAG_RFKILL_EVENT];
> -	if (!ev) {
> -		kfree(tb);
> +	if (!ev)
>  		return;
> -	}
>  
>  	ath12k_dbg(ab, ATH12K_DBG_MAC,
>  		   "wmi tlv rfkill state change gpio %d type %d radio_state %d\n",
> @@ -8962,7 +8892,6 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
>  	spin_unlock_bh(&ab->base_lock);
>  
>  	queue_work(ab->workqueue, &ab->rfkill_work);
> -	kfree(tb);
>  }
>  
>  static void
> @@ -8978,7 +8907,7 @@ static void ath12k_wmi_twt_enable_event(struct ath12k_base *ab,
>  	const struct wmi_twt_enable_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse wmi twt enable status event tlv: %d\n",
> @@ -8989,15 +8918,12 @@ static void ath12k_wmi_twt_enable_event(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_TWT_ENABLE_COMPLETE_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch twt enable wmi event\n");
> -		goto exit;
> +		return;
>  	}
>  
>  	ath12k_dbg(ab, ATH12K_DBG_MAC, "wmi twt enable event pdev id %u status %u\n",
>  		   le32_to_cpu(ev->pdev_id),
>  		   le32_to_cpu(ev->status));
> -
> -exit:
> -	kfree(tb);
>  }
>  
>  static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
> @@ -9007,7 +8933,7 @@ static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
>  	const struct wmi_twt_disable_event *ev;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse wmi twt disable status event tlv: %d\n",
> @@ -9018,15 +8944,12 @@ static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_TWT_DISABLE_COMPLETE_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch twt disable wmi event\n");
> -		goto exit;
> +		return;
>  	}
>  
>  	ath12k_dbg(ab, ATH12K_DBG_MAC, "wmi twt disable event pdev id %d status %u\n",
>  		   le32_to_cpu(ev->pdev_id),
>  		   le32_to_cpu(ev->status));
> -
> -exit:
> -	kfree(tb);
>  }
>  
>  static int ath12k_wmi_wow_wakeup_host_parse(struct ath12k_base *ab,
> @@ -9099,7 +9022,7 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
>  	const void **tb;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
> @@ -9109,7 +9032,6 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_GTK_OFFLOAD_STATUS_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch gtk offload status ev");
> -		kfree(tb);
>  		return;
>  	}
>  
> @@ -9119,7 +9041,6 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
>  		rcu_read_unlock();
>  		ath12k_warn(ab, "failed to get arvif for vdev_id:%d\n",
>  			    le32_to_cpu(ev->vdev_id));
> -		kfree(tb);
>  		return;
>  	}
>  
> @@ -9135,8 +9056,6 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
>  				   (void *)&replay_ctr_be, GFP_ATOMIC);
>  
>  	rcu_read_unlock();
> -
> -	kfree(tb);
>  }
>  
>  static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
> @@ -9148,7 +9067,7 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
>  	const void **tb;
>  	int ret, i;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse mlo setup complete event tlv: %d\n",
> @@ -9159,7 +9078,6 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_MLO_SETUP_COMPLETE_EVENT];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch mlo setup complete event\n");
> -		kfree(tb);
>  		return;
>  	}
>  
> @@ -9178,14 +9096,11 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
>  	if (!ar) {
>  		ath12k_warn(ab, "invalid pdev_id %d status %u in setup complete event\n",
>  			    ev->pdev_id, ev->status);
> -		goto out;
> +		return;
>  	}
>  
>  	ar->mlo_setup_status = le32_to_cpu(ev->status);
>  	complete(&ar->mlo_setup_done);
> -
> -out:
> -	kfree(tb);
>  }
>  
>  static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
> @@ -9195,7 +9110,7 @@ static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
>  	const void **tb;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse teardown complete event tlv: %d\n", ret);
> @@ -9203,13 +9118,8 @@ static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
>  	}
>  
>  	ev = tb[WMI_TAG_MLO_TEARDOWN_COMPLETE];
> -	if (!ev) {
> +	if (!ev)
>  		ath12k_warn(ab, "failed to fetch teardown complete event\n");
> -		kfree(tb);
> -		return;
> -	}
> -
> -	kfree(tb);
>  }
>  
>  #ifdef CONFIG_ATH12K_DEBUGFS
> @@ -11239,3 +11149,30 @@ int ath12k_wmi_send_mlo_link_set_active_cmd(struct ath12k_base *ab,
>  	dev_kfree_skb(skb);
>  	return ret;
>  }
> +
> +int ath12k_wmi_alloc(void)
> +{
> +	guard(mutex)(&ath12k_wmi_mutex);
> +
> +	if (!ath12k_wmi_tb)
> +		ath12k_wmi_tb = __alloc_percpu(WMI_TAG_MAX * sizeof(void *),
> +					       __alignof__(void *));
> +	if (!ath12k_wmi_tb)
> +		return -ENOMEM;

better move the second testing inside ?

	if (!ath12k_wmi_tb) {
		ath12k_wmi_tb = alloc();
		if (!ath12k_wmi_tb)
			return -ENOMEM;
	}

> +
> +	ath12k_wmi_refcount++;
> +	return 0;
> +}
> +
> +void ath12k_wmi_free(void)
> +{
> +	guard(mutex)(&ath12k_wmi_mutex);
> +
> +	if (!WARN_ON(ath12k_wmi_refcount - 1 < 0))

better to use refcount_t and its APIs?

> +		ath12k_wmi_refcount--;
> +
> +	if (!ath12k_wmi_refcount) {
> +		free_percpu(ath12k_wmi_tb);
> +		ath12k_wmi_tb = NULL;
> +	}
> +}
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 5ba9b7d3a888..4a34b2ca99ea 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -6576,4 +6576,7 @@ int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
>  				       struct ath12k_reg_tpc_power_info *param);
>  int ath12k_wmi_send_mlo_link_set_active_cmd(struct ath12k_base *ab,
>  					    struct wmi_mlo_link_set_active_arg *param);
> +int ath12k_wmi_alloc(void);
> +void ath12k_wmi_free(void);
> +
>  #endif


