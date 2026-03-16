Return-Path: <linux-wireless+bounces-33295-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN8+Eazet2mcWAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33295-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 11:42:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DA7298163
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 11:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CAEA300D904
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354E838E5D1;
	Mon, 16 Mar 2026 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BbIK3wyy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y+Ghq1UU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211F38F937
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657748; cv=none; b=cvheZ3aIXMQpz8xI/ZgqayxgRWthKxOQdvX0NlvLGf3SB7+eNnz4RoYV++tHqG3Rj/5Oy/DTZC+Rocg4yozb0IeWzA8Kvyyz7JCowkV9B3R89hFSpdse7TBNu3eQ4YfZr6wZ4LbUBOyGpVwyVpOFCkrIHIQ4GPBXD1nCuN7Q0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657748; c=relaxed/simple;
	bh=j36oSw8OeR2Mz+0+rCGMzWbo5IFd6jVPEIBO+506XMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIK1GP9SjER4iK5h2uwqQp+x6U9OEPIOyxWkmGp6stcVj+h7y56AevvlS7YbVPT9z4IdkXbFw7Wmy3I1FaSTSsT4g+ojlOu5EeVOcFy1krtBD33/l3AL4EVfw4PQraYDY565IkR52oVV28Ci6HBrCTu4Q09qkSy3z+uEHMudJJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BbIK3wyy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y+Ghq1UU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64eij1282071
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 10:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fFL00ILQpt8ZZD7ShfDXG3TNuwkrXjiEhVr5NIgrGpA=; b=BbIK3wyyHFM2F9uW
	OtGqhH7J1uE4QpXU67go78JdVhs1wNFEyReFiWYz8gs00DQdfsoP3Br/FDLDCvJJ
	CJVtWBNfyKoJ6i1jd0idbDKhh8CkPIJYzzyTaONRc9rp4G2yb5L9LtyDZRPFfMOM
	EXBucEA+B/xX0oQfI7YBRdF01roNS3UvsOkduPQOisqo5b8t8BqwSXZPzPKb9Qts
	PWYP4y1lMFvnzoNT04Z1Pz/LW5DqAt5Of7tJOMciuYsUKvdqldPzNdNBQGRe3ZoJ
	Ja4rjT2cK7lmSg/1pQX1zvTS6Qul6071WNA5Ns+FJIZXWc2un7WRn6pMdsKjs5VV
	NQE8Kw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvyyc56bp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 10:42:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b0554888cfso14212545ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773657745; x=1774262545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFL00ILQpt8ZZD7ShfDXG3TNuwkrXjiEhVr5NIgrGpA=;
        b=Y+Ghq1UUV6qR3KFRnURDBGY4P4mwWDe8YLpVUzhVpIccm/f0+uIHm9IriCJo4ZoQJ+
         RKh4xHRZu/KBaqGv1QDpPcvALny6s+q7/G8kvGbsQeUAk80dg0SS0lMUwDZYP/VIaivl
         ZVxJkSgenKXsmA2MIE3CYMdQ2hmsxMi3RscdSs9AJbu0CdnATV8z2wkaUxY5LavcP5u+
         jSX8RCswjR91wAeVATzzjtn0RL4yUaNxxjxr9uK6XbMWyJWBsv6fVHESvCId4bJN2QTA
         cddAmTcQ0r1b3p+34sPJY982oBRJyiw7/25py5v+iaJvoD/RlajtfN/LAg2u46qJVlNd
         TSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657745; x=1774262545;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFL00ILQpt8ZZD7ShfDXG3TNuwkrXjiEhVr5NIgrGpA=;
        b=OVZrPx8FIG93EEeigMF7TenynEAuQPHjoaE/WDyFaCqZXz0KiWFKwZHLQCMHuQA68I
         SLSsgTifbJJOao3p9vdIJnNrLyZfX7VR1MDDW4nWMK2jiIkMjJn7JYI3tD8vhuBrdArw
         ArYlHTql9HN9MQd9LdDpqbbbqAMWvvo20dEiHbGHocjb2Gq5CoxH2rOfV8FLzc1i37KK
         GUcm0+90csPnPTq8FxGtqQQ2VUVigZkk6qgkQowmg+uCXoH4mkxG21gPSECjyx9AYrrG
         j5pT2vdvPqIkdnSk24ciUV6sYmiAMkzBh+mutkd5/rJxrml+u55m4RqyhcU3kvcuXXE1
         Pq9w==
X-Gm-Message-State: AOJu0Yz93V9SM00HD3KsQlSHy8rwLrl2b5AqUb3K+MpyojENJW1P2OXr
	DNs4Ku9Xrxw1MjI6Bhp04sTuuTfZiJ0UKLRgHbrTJptmCmPhvJyl3XV3EveIGB5Nri+WpzEHaRv
	Vd0ZISWAJSQmOfR55IYV0UuplUTu8axmcA9+mPRIht+gsiZzVCC5UMeAbucT9HxdgJ1jMrw==
X-Gm-Gg: ATEYQzwPAoc09VEQhP11kWCmOCsl3XMnWXqfj0opjKkpHys3/DkICoZOVbs/ojBbY2I
	5N/qnmmsLqp42lM+BSxS7sBH/YdOxSXHqQetTV7CexHQeY2l8LiQKO/s/9H5M6O9xV/LQDaFbWm
	vpxhxt+vJAXcFpEOSQ2QWM4SwkBss4oMgxLm9ydIqKACiMqWwy3uglfTpWNQ8aCXBTKngkh3CoH
	tqwRpQIPb0OkNvkvKWA5yzjKTKkFnr6AFMUBP2vVGk8F5oTtYKw+8ZKsafCB17FzLa9Q7f/BoQV
	dAvPecBDCBBAGGgS3EOXbhcL26nzcYC21DouKZqEw1vKXy3Kly+MW26SqBQgMmE3BQbuZcPQidK
	AETYeHR6chJq9Lkzb4CXlK255WHPrp0MvcuwEtN83S+d8rFc8z+ZnRYN+WMp08NmIJvkW0T9h0s
	axfShEMwE++6bFq2SAA9k=
X-Received: by 2002:a17:902:e888:b0:2ae:a9c2:6aa with SMTP id d9443c01a7336-2aecaaf6060mr131499045ad.32.1773657745081;
        Mon, 16 Mar 2026 03:42:25 -0700 (PDT)
X-Received: by 2002:a17:902:e888:b0:2ae:a9c2:6aa with SMTP id d9443c01a7336-2aecaaf6060mr131498755ad.32.1773657744548;
        Mon, 16 Mar 2026 03:42:24 -0700 (PDT)
Received: from [10.133.33.128] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b055cb5d60sm34445145ad.30.2026.03.16.03.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:42:24 -0700 (PDT)
Message-ID: <d38acb9f-60dc-4d37-a3b5-8cd09f76939e@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 18:42:19 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260316103248.3042158-1-nico.escande@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260316103248.3042158-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=euXSD4pX c=1 sm=1 tr=0 ts=69b7de91 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=0k2Bv0oT3BV_p61_ltkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: zumdQlfvCZT4uaukdMKg_fVTP8tMrb5O
X-Proofpoint-ORIG-GUID: zumdQlfvCZT4uaukdMKg_fVTP8tMrb5O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4MiBTYWx0ZWRfXwvibSD7ozXCj
 0nYQI1PdPIzT98WF4oAzjYaM7Xtrf/CqQ1slirVQgN+yGAAS03wN69JUAYVthP6zGN6WijRTVKV
 2ylu9+b8MLNpxZUIj7WE3/vqAmHzd+zoMi/w1lyp84ZFZtPf2fnJVBOoJl93ZoH6AxXedFCyCUz
 j1Zwus7XMgJhQj6SfVYf6sw+zzL6d5NBV3ccPxjRehLLf8pbQrqJBJdc4oz3npdzPNKY95EARcY
 CVuwE8+nQdJrLxnATCn+/oMVLMMzhmIrnsNkMdmeqKT7IhUNijztVMWd//GRvVZr4jbprGB6VzW
 6scA0IRFmjlz63iurrgS2qh63bGaj9U3TqtQf5nqvBWAxrtNVWEzvBGoodwUAJIL5MPCSI0LGYV
 8HixS3Tt5TdSGyRL4Ewltuo710xaBA8vhbRzbZiFBpebH0iaAcouUbRF+R40U40pbrhnb2GGf6w
 nYTKCA5umfq7fBtOdEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160082
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
	TAGGED_FROM(0.00)[bounces-33295-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: B1DA7298163
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/16/2026 6:32 PM, Nicolas Escande wrote:
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
>  drivers/net/wireless/ath/ath12k/core.c |  19 +++
>  drivers/net/wireless/ath/ath12k/core.h |   1 +
>  drivers/net/wireless/ath/ath12k/wmi.c  | 200 ++++++++-----------------
>  drivers/net/wireless/ath/ath12k/wmi.h  |   3 +
>  4 files changed, 84 insertions(+), 139 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index c31c47fb5a73..16815a27f8f2 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -2321,5 +2321,24 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>  	return NULL;
>  }
>  
> +static int ath12k_init(void)
> +{
> +	int ret;
> +
> +	ret = ath12k_wmi_alloc();
> +	if (ret)
> +		return ret;
> +
> +	return 0;

nit: you can simply

	return ath12k_wmi_alloc();

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
>  MODULE_DESCRIPTION("Driver support for Qualcomm Technologies WLAN devices");
>  MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 59c193b24764..02ee6c718621 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -19,6 +19,7 @@
>  #include <linux/average.h>
>  #include <linux/of.h>
>  #include <linux/rhashtable.h>
> +#include <linux/percpu.h>

does it make more sense to add this to wmi.c instead?


