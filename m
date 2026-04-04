Return-Path: <linux-wireless+bounces-34345-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vL+bNX3e0GklBgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34345-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Apr 2026 11:48:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B5639A94D
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Apr 2026 11:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD141300F1B8
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Apr 2026 09:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3A036164E;
	Sat,  4 Apr 2026 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZZ3WIDfI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LwyCoE7Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B72DCF62
	for <linux-wireless@vger.kernel.org>; Sat,  4 Apr 2026 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296123; cv=none; b=GS/oAdAK2YHAGk+8lFxc/FPjnM9lAVPY9g4HZXwxBYN6nuK/bIfc0v70iS1xHQfgHvt9qd4hpVbs/1T9Aqbk54p1jyGvb6DfmeIQhaz/NCFlUgin8i4M+6gEc9KRDSc/8Mu2e86RFdUndGVfEUOEk7W5xVGzhHjJ3qJ2U/BKbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296123; c=relaxed/simple;
	bh=n2gEfMX0AF3r4Rxu9jV5Za8tTkjiwRJzMC2F3a7v+6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOkdBlVOEdQXxA1ACS6P98uebCJJAdKv+dfdUqV7Ofx7NiAEGt8CnI9K3QRHo6m7ABAR3QE3rJ39gYyT+R7xlguMl/MFsJfWRYWrLVncUadGcousvvXm62wPg6AWOFk+SwXlyfZbQN12uvw33iqEPMpzafkY3Oa/wqlofw4fshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZZ3WIDfI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LwyCoE7Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344Bl7R3884158
	for <linux-wireless@vger.kernel.org>; Sat, 4 Apr 2026 09:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jtDNNuSKOZBB5V6+bQrzq6rkDFhJJoX5xUxFSKV4Tok=; b=ZZ3WIDfImTHZqpmQ
	nqL5w5toRynr2znEPI7Pfv3BNI+8QQspQL824SSttwQgqVZ41EX3sVYiDGj0OJrC
	rgagX1LoiamF+A0BGVK19M9Q/Aoe9gAcD9lUB3fpUod4NqN+nGDc52ByeGlyTcVl
	/FubH2UWLOhGzTSDN9FQbQySm+oQNklAr1Fm8e7S1r5/OlvzKJxQADEGtvz0FWDV
	Q9Dv2blVqBxQmTpwEzwKDLuZ6IwvganWKO/U6fsChmp1sqwa9efG45WFY7tdfYJV
	VEz3VDreI80E4JFG85TjY2syoYFlJOrZ/tcfdzGNWsNOqH0bhkWiXhvGR0eV2xpd
	77xBmA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daudd0h5e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 04 Apr 2026 09:48:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da1c703d1so2459839a91.1
        for <linux-wireless@vger.kernel.org>; Sat, 04 Apr 2026 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775296114; x=1775900914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtDNNuSKOZBB5V6+bQrzq6rkDFhJJoX5xUxFSKV4Tok=;
        b=LwyCoE7Yv+AbWNKwMDyS000h9FUcL6JsAHDfaVRWH705TGOMaAnXqGO/+tetl/iAKx
         GrA3esZZ7bnQ8KR/FVl9QRsyZNr2NTcs0ZDffgRnLnfHE6aFbroCBxiRFPfgF23aWyyk
         BnVWVvZdTdo8y9rgIlPhnj50DuXzrHcQGouey4iQyFFZKxlrVe+wcovFDFA+pgYLIF+4
         kiDj8LRleXJ1kQvZRp3lpR2vbvs2kJE8B9i2tH7zTDSm9ldyjA1jY5r/IxA2g5Afg5Wj
         M4uoG3bqDevrULoFGLKRKKxiwWJfHXsV1Re3Ryu7JV6CkGZ3W/cyuOd2wlwj93RVoDqo
         e+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775296114; x=1775900914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtDNNuSKOZBB5V6+bQrzq6rkDFhJJoX5xUxFSKV4Tok=;
        b=Ut67bLFmlEbU1IKtqZscNCvgR9RDBpD8Hir6wWdV6ZRnEHrMf0eg9nnA0sh7lghpI3
         U+4jVu7JTTYjzKJh5VclSllziy8LXWJ+EDyIEDc6YSbYHjJ87VwVVJnSXZTiMFY7CD8X
         SVGII693c0Pf5XSJ3no3MVEIknwd3OG9UkOnjyHEzS1zUA1td23ol4d7gP7QPXLNapyF
         GC9wU8jG4+4tQCYTTYGl4NLawk8/AbM7+loiJe9KJ2MoGkxGmXs/pvLJZjbHQo86V0y7
         BLDpsLTLmdgejYsu1F5F6C39OcdzpKxzC+EVJAdhl6J/8/ZKc4bNdlV9Jg0m9rS6OAGP
         UKVQ==
X-Gm-Message-State: AOJu0YwczHwX2W6QGwHeZSJckM/yt/D+Ir03KPZei4OOVjGZN7puI7le
	aFvYwebL7yaNtd7PHGRNMjb32BC+gXKx2GCHV4HOcV9ycb5szE3ENJCklz8YjwodzqbTw0Wwe/J
	0MZqI6rvTgdjwHEX4RKtpBrSXhnj/3PWA7M5Pbgl9qpcMysBF3VX3DqaCBY3WkNbPd6eU+Q==
X-Gm-Gg: AeBDievfnhzkVIyIjjYorvgz+rv+7qdD5zSdq3VP28yeZYX3hDwXCwVt7vcqpgtUeuT
	zjENhX7VAVTimdaNm4RsmDiN4R9oqxQ6IyQ511LRUXwJ+D/mdYHgAXP6JBk6AMXhI7CRnbenRL0
	6i37/zg8+oKSRNz08eFbocRy9uKh/XpM8CLN1oF9CNNIdplVlDEClg7QIfzVZt29RI9b0PesMQU
	/YReUfCNYeVWUbSa8Y2w1r1S0KtkRT5T4QizwBts+evXXK/R3lJxlY9tgEBECI1q5E0zwKVXr8f
	7bwxmFYtPCqFt9BlWZeLmFV1boIaVxsXwQ6ASV0JNcuE9hFi6y0R7tn7l1C7O/4BJkEjrwxY/at
	XweiIPrv+47N7/tpUPBgNoUTFUUjnQ6ITZlBjJ0eoI09iwgws1k1DPkrKIAtQ8Oa8ag==
X-Received: by 2002:a17:90b:3f4d:b0:35d:9482:2233 with SMTP id 98e67ed59e1d1-35de69a66e1mr5802233a91.24.1775296114300;
        Sat, 04 Apr 2026 02:48:34 -0700 (PDT)
X-Received: by 2002:a17:90b:3f4d:b0:35d:9482:2233 with SMTP id 98e67ed59e1d1-35de69a66e1mr5802222a91.24.1775296113829;
        Sat, 04 Apr 2026 02:48:33 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.81.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35e34f9sm7809468a91.1.2026.04.04.02.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 02:48:33 -0700 (PDT)
Message-ID: <54887455-3ae5-4dc9-a0cf-80726a1d8465@oss.qualcomm.com>
Date: Sat, 4 Apr 2026 15:18:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v6] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260403142841.1105780-1-nico.escande@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260403142841.1105780-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YmepiP2lWpPyqRwKpVTliPlz7h7F--uL
X-Authority-Analysis: v=2.4 cv=JZ2xbEKV c=1 sm=1 tr=0 ts=69d0de73 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=R7zuFBDiW8lgADV909h7jA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=J1t7JbMFkQZTC4NLg28A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA4OCBTYWx0ZWRfX29muJTsPSpYd
 HMflaDYirDcBpl+Jf/dRDH67TLV3USKbMb5gpJssmTYMbuY1jQzxG0yRajuvbHJPO77VJi5V0Ql
 whHoC03h9BnKeDSgxxuQm6uKUcvn58MtBWP/MS2Hvrsdgq85tw6/VjlKX59x8SeQZHR+nx6nFKD
 D64g+uaXq3ROxfyqLxQXW6Pg8gMa+5farCNmeNS7idJfheB3b/8o+YHMTu5PmE7yci64vMhkp1x
 vOj1MzeqEAR6mp3NpW5uJabhIsoy74mRbvxO1wnr+XADNWBYXvaSP34pJZjPeJ/3NgTKkWP924Y
 a6bayuPyc+E3w+Eu3dtufEUcYHbNnT/F7DCJQfWfwOhQrIp+ECPWNIhiQNIrdzPcdXyctDfP+zN
 /PNxwL+Lhx7s4YFhIa6ji103CM9CaZe29SbsbuSwdFe1MB278iSSFzXo3tSU+BTXdVVvrJDCRcC
 zTdNYgj+99ptles+GPQ==
X-Proofpoint-GUID: YmepiP2lWpPyqRwKpVTliPlz7h7F--uL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040088
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34345-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 45B5639A94D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/3/2026 7:58 PM, Nicolas Escande wrote:
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
>   drivers/net/wireless/ath/ath12k/wmi.c  | 214 +++++++++----------------
>   drivers/net/wireless/ath/ath12k/wmi.h  |   3 +
>   3 files changed, 84 insertions(+), 139 deletions(-)
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
> index 65a05a9520ff..2641a76e9543 100644
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
> +static refcount_t ath12k_wmi_refcount = REFCOUNT_INIT(0);
> +static void __percpu *ath12k_wmi_tb = NULL;

Checkpatch complains:
drivers/net/wireless/ath/ath12k/wmi.c:141: do not initialise statics to NULL

> +
>   static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
>   	[WMI_TAG_ARRAY_BYTE] = { .min_len = 0 },
>   	[WMI_TAG_ARRAY_UINT32] = { .min_len = 0 },
> @@ -289,29 +295,19 @@ static int ath12k_wmi_tlv_iter_parse(struct ath12k_base *ab, u16 tag, u16 len,
>   	return 0;
>   }
>   

{...}

>   #ifdef CONFIG_ATH12K_DEBUGFS
> @@ -11239,3 +11150,28 @@ int ath12k_wmi_send_mlo_link_set_active_cmd(struct ath12k_base *ab,
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
> +	}
> +
> +	refcount_inc(&ath12k_wmi_refcount);

With ath12k_wmi_refcount initialized to zero, this will trigger addition 
on 0 - use-after-free warning in refcount.

We may have to do refcount_set(&ath12k_wmi_refcount, 1); on tb alloc.


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


--
Ramesh


