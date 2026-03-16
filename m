Return-Path: <linux-wireless+bounces-33266-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJNIEUJst2kYRAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33266-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 03:34:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1095294265
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 03:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47BC93087681
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 02:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8396830BBBC;
	Mon, 16 Mar 2026 02:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mrov2drx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J2bTX0ux"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712230C37C
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773628086; cv=none; b=K6a0K1lOLSkEqK6BLGeG4i26JzHXrIpYgJbWMX9LLqslk01WIndUK8f7JAF9eSj1069DbwwEwvfE7Mkmse8ntoozzm0VOtnqtB/PNZvdxkKB8AG0NPFk8kufr19I9ZBjg4UteodguY/QtlCeC8zIEWR63oxC8zjf1FFX2t7xQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773628086; c=relaxed/simple;
	bh=bRcNSnyOdGO5oL5iFtObJlVEE+GxnPVpKpa+6h72iCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtSPnWRwGlBAGT23Jlzc+tu18uL6T48QJQUKg1u0vdmM9cfaYcgeWg0WQoOlSi7B6yIxaL4B/YVZQL8FehY+Y6uRhQmlJm1cGWqedPXLerl0ShjoxzI4Yw60rfmN69aqUIIhs3Jsi8NXBzZGt1soLgSScyDDGxX+u+Bjw06wR/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mrov2drx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J2bTX0ux; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FAIpsU1362409
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 02:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aYdfsIEUjKYKUFr0R8Fwpax3o7fUn8pvEl2MBl7vK/0=; b=Mrov2drxy/mSkYWa
	1XwzX4eTE6R80UWhInSIYyBsv8P7kx/QhowVkYDVhYAz8N9efeLerYild1s3EbPT
	z5e2DFzQFQVTd1ymQH9k6/TUo3z8VKnt07dkhAvUl8L5jbgXUQLw1EIigvbJfUT7
	JIUBdQruAOxXw2mhS7y/qlHKwcufM9aXGUx8VsPeb3sJCI3SXVdfq7zhlZuhZoSd
	TRSI4xjy1ILp4R3tMMIcMtPrPZ8gPx8WZdHSJG2NXySY4VB24P0DKuO0lnT+hJ+L
	SBNkiz3wMpY/tqJKHc2ZenNmNr5W9AckRCiqMMAEJ1Sp6CD2cLCHKMZ3GZkKIhXV
	C4guog==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0y7unbs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 02:28:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b05370ec01so67294725ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 19:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773628084; x=1774232884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYdfsIEUjKYKUFr0R8Fwpax3o7fUn8pvEl2MBl7vK/0=;
        b=J2bTX0uxyyhd+JOyAn6uFNheVNMOCPXUhf9pmJ078kKnbE8ZxprlcG37yOw4Y7+OAn
         y1oM47bKWaSbXftxEsYGN9QBhY8DLFbBaQa92VyLMICbHiAMsDQt7FeatW1by3q6RWEB
         MC7J0K/RGPhhJzaqawNQ55cmnrzICF+u7eRS5n2Oboa/g1EIh2soKsLi3vPcIv/dbHK3
         t4yjItLFEYk5Uqgi4zutqjlJN4gVhrEUHycVx4Y9G+eFwVRS8H5xVbQN58U56yVAk4zN
         rlmCb3MQQhiMa2diQwj+g6tilV786umRAlp093cNC6BazbkWzHSRNabkMK5xssgdRRTE
         W3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773628084; x=1774232884;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYdfsIEUjKYKUFr0R8Fwpax3o7fUn8pvEl2MBl7vK/0=;
        b=OT5fE9v7SvhHKhyCDmnjVajh+R/X1ZSHB9RBOfsuKQADZaOIU7x+/aat/nxJNbeHpU
         PjjSWKNfexqh3Yty96hAauPpkz2GEvTBrZvpX+5XAdNTy5HGJ0Km5EPCRTQRiuDZP5wN
         Azd0TZofaka4ec1MlIomDxhMkyqVsj7JzMP5pEePZWYZuxT0qatBDrVG0oLLF/u6S/qV
         bW+bvHPGnetsSuUE5sx90cX3fzVO4m977HNMPQntCInX0oEgJerO/ma9cs2+t1LFCdDf
         vRm21CoFD2aX3oIc1eYJaYiKg2e7jViIkR9nnf3zaDozjYLcMEIuHYv0k71HOtBQ1e1x
         1Oxw==
X-Gm-Message-State: AOJu0YwD+enNTGoNWLNyIBDiMbe+ELi6NgF3+02k9Oj+x8wr7cf278EX
	3RJ4R12ndcNmOyAk0Wh0CQAag2JVk/7oGuP6xWDO4GUyh6G5r91ghfgNXufZvYkmx77i24diHWH
	BHAeyaNAWEwr8VN6l21NT/YxcWhVXbM2e06A6PXf+r+SVXD0FxJ3ph5a3hoGLi18Rx+NxPw==
X-Gm-Gg: ATEYQzxykqAP3akbVaROnSajgmfA6xwQR1xoly5oJirOzpIRmFgUiKJGV19ThkAZNmu
	KidOx9700whHfqAtYr2vPp7pO0vXLJpKZBGzx+hro5ybqzdLf8Q+7wK8Gqf5KeUu1vqbYM4/1sx
	9Q9R1Sk1IdRYhFlRvGyCa9I301LMjwJDD8L4mBfuzeEcpsBI3FHG43Q/tWFCA71lNDg0tjyzcEc
	cGofCwSlP5mNS6z9wzxjdm7iCur3pKlGlu7P52tIJrmUhrcK2NQZuh+QBqcvxWA/Zequ3J+irAh
	qz+q7etTvPOJ16OFoC9znbUTzMFwo7VzMvWIi4YGQnQb2r15ZJTw0GxqSmi1klxAMel1nUtuOkw
	igl6e7h7joID4/ZE2C2mO+VpldhE/B+ab3CH8wtfM4QHJSsMUULTS3Ufkp+0wf/lLqcLbCjSIHM
	Vt+Sw2Q7KQ6rWDadu40aY=
X-Received: by 2002:a17:903:3b8e:b0:2ae:6205:2345 with SMTP id d9443c01a7336-2aecaabcf9cmr104368465ad.35.1773628083746;
        Sun, 15 Mar 2026 19:28:03 -0700 (PDT)
X-Received: by 2002:a17:903:3b8e:b0:2ae:6205:2345 with SMTP id d9443c01a7336-2aecaabcf9cmr104368275ad.35.1773628083277;
        Sun, 15 Mar 2026 19:28:03 -0700 (PDT)
Received: from [10.133.33.128] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece63133fsm87549275ad.41.2026.03.15.19.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 19:28:02 -0700 (PDT)
Message-ID: <55358f82-f0ba-4671-90ed-8061f6ffbabf@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:27:58 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260313113831.3053586-1-nico.escande@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260313113831.3053586-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6B1cVNAXH1RIFM4PoKMxTxItelu36reC
X-Proofpoint-ORIG-GUID: 6B1cVNAXH1RIFM4PoKMxTxItelu36reC
X-Authority-Analysis: v=2.4 cv=D9xK6/Rj c=1 sm=1 tr=0 ts=69b76ab4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=B37bNE8LRjw87ndVZx8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxOCBTYWx0ZWRfXx7OMbAukzr+r
 7NgUzXm50hSSPIN3VKm/4eSgBIWOaOApAOZrixSgmanRXDPJtdq3Dbj+/UFvJfzunPFnPt+iQ0S
 6cJ7NfPfyU2a4Jr/LBdZiq9nxcEadF/9kA11sqZaIV2ukNiLQxmzeP3iM1u8EAsgdkjVmnvxJDA
 Mrh7UJr/cs+0x5+9VkWZR71IV/0smuap69w064EAbfXju1BxZfacJ7d8yV/N8d7HlmVs+k7sCTf
 qwOtpm2WiBnVYc78CTuFG90DhmBZNvDLM/G8fUz6+SvZqNpJkm66fN5lON3G0AY4JsF5ltiO3Lr
 e0r60lJUEZjSgBG8CHQ4gLrUaFXXKr+gBx0/PMXy/Npvt3s12OZNKftzWUhdtsa30/USn+Y5vxk
 10rmX5ZKYJkP+0fav+V04DHxk/EwFtY3adVqfi3wNhyJp3rQolBWCY6EJKF19vn8PltgeIBYVdr
 veILZg95iVDvtbyUx9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160018
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
	TAGGED_FROM(0.00)[bounces-33266-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B1095294265
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/13/2026 7:38 PM, Nicolas Escande wrote:
> On each WMI message received from the hardware, we alloc a temporary array
> of WMI_TAG_MAX entries of type void *. This array is then populated with
> pointers of parsed structs depending on the WMI type, and then freed. This
> alloc can fail when memory pressure in the system is high enough.
> 
> Given the fact that it is scheduled in softirq with the system_bh_wq, we
> should not be able to parse more than one WMI message per CPU at any time.
> 
> So instead lets move to a per cpu allocated array, that is reused across
> calls: ath12K_wmi_tb that is global to the ath12K module. To alloc & free
> we added two new module_init/exit functions for this module.
> 
> ath12k_wmi_tlv_parse_alloc() and ath12k_wmi_tlv_parse() are merged
> together as it no longer allocs mem but returns the existing per-cpu one.
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
> Small note on the new ath12k_wmi_tb variable. It is located in core.c and
> I did not exported it in core.h (nor is it exported with EXPORT_SYMBOL())
> as it is only used in wmi.c and should not be used by sub modules like
> ath12k_wifi7.

agree

or alternately you can define ath12k_wmi_tb in wmi.c and add alloc/free functions in
wmi.c, then call them in core.c. this helps modularity IMO?

either way works for me!

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
>  drivers/net/wireless/ath/ath12k/core.c |  22 +++
>  drivers/net/wireless/ath/ath12k/core.h |   1 +
>  drivers/net/wireless/ath/ath12k/wmi.c  | 181 ++++++-------------------
>  3 files changed, 68 insertions(+), 136 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index c31c47fb5a73..c9a5baf41845 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -34,6 +34,8 @@ module_param_named(ftm_mode, ath12k_ftm_mode, bool, 0444);
>  MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
>  EXPORT_SYMBOL(ath12k_ftm_mode);
>  
> +void __percpu * ath12k_wmi_tb;
> +
>  /* protected with ath12k_hw_group_mutex */
>  static struct list_head ath12k_hw_group_list = LIST_HEAD_INIT(ath12k_hw_group_list);
>  
> @@ -2321,5 +2323,25 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>  	return NULL;
>  }
>  
> +static int ath12k_init(void)
> +{
> +	ath12k_wmi_tb = __alloc_percpu(WMI_TAG_MAX * sizeof(void *),
> +				       __alignof__(void *));
> +	if (!ath12k_wmi_tb) {
> +		pr_warn("Failed to alloc ath12k WMI tb\n");

generally we don't log memory allocation failure

> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ath12k_exit(void)
> +{
> +	free_percpu(ath12k_wmi_tb);
> +}
> +
> +module_init(ath12k_init);
> +module_exit(ath12k_exit);
> +
>  MODULE_DESCRIPTION("Driver support for Qualcomm Technologies WLAN devices");
>  MODULE_LICENSE("Dual BSD/GPL");


[...]

> @@ -9205,7 +9117,7 @@ static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
>  	const void **tb;
>  	int ret;
>  
> -	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	tb = ath12k_wmi_tlv_parse(ab, skb);
>  	if (IS_ERR(tb)) {
>  		ret = PTR_ERR(tb);
>  		ath12k_warn(ab, "failed to parse teardown complete event tlv: %d\n", ret);
> @@ -9215,11 +9127,8 @@ static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
>  	ev = tb[WMI_TAG_MLO_TEARDOWN_COMPLETE];
>  	if (!ev) {
>  		ath12k_warn(ab, "failed to fetch teardown complete event\n");
> -		kfree(tb);
>  		return;

nit: better to remove return as well

>  	}
> -
> -	kfree(tb);
>  }
>  
>  #ifdef CONFIG_ATH12K_DEBUGFS


