Return-Path: <linux-wireless+bounces-39123-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MUoxGHT7VmrKDwEAu9opvQ
	(envelope-from <linux-wireless+bounces-39123-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 05:16:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D57F75A3CF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 05:16:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Y97+WZNo;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=TNKi0k3B;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39123-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39123-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82C22302E7D8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 03:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122CA274B5F;
	Wed, 15 Jul 2026 03:15:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD76245019
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 03:15:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085359; cv=none; b=XjFb12KyCyoVxc0noARvdKw5IODeawhyMzEMlYlceJOF04NEERP2VRNqnZagEPulZVPmey/QSohQLxaKafZ3YNGJ1QV4UnFsitwgBT7KSZO30wazrhw0b0BZket9mn6oGwhmcX1raBfrJXQKnqrCYls0rrgwcZ+BsMOHXsbeN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085359; c=relaxed/simple;
	bh=yURs3R/X6zfDVBSe5EB9d9wyeV9Vpx7Z7ayKRaWIoeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2QgJaQOonLKXv2AOHpokyv/ZTcuhpukdEPsnYErDDLzT55ksET1fkCjAb2Ox5w9SayY8TW1/JK2QoL3a94IWWcjwBFVRCXGgsDFsXZw2Eiz850BE0L6+50/pophORK466sLgt1KnGUwKWhmdRMbk7YEQlmTDyapcsBXFA5WyW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y97+WZNo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TNKi0k3B; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F0I0jr2222558
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 03:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	59dtjn3uigWcqD04FKFVloeTaBJk83JWYja0Nk1JPpA=; b=Y97+WZNoYirbt+yU
	Dmgjh2qwKrggfixGQGRCQckh72F2BOR2Vi4k1BOBouCPewvPKol8pC9w4/VRnn0a
	MW5WCUFtcat8PwimEgRCLW1HstzdZBFPlSO7CsJ/gGGLggpxMGbsw4Q2qxuu0dMs
	6SB5QDKI1O4qNscZuEBIXwq7E0X71GlKOia3G7ukIXKyAJI+ZczCVjZO5oh/bogf
	/L/VTfEKteCs4eMZUnhy/yJVURbGhRWl9mlKv/R4Rp3/K1jNCwlQp0A+dAcrUFys
	xw7gF5IMk+Bq6qAFsXM/E5UE6S6cXY3uW14zNkDhrZEwI8T68OIz9Az36v8yc8bZ
	I+5SiA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnutre5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 03:15:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37fca5f21b1so273544a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 20:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784085356; x=1784690156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=59dtjn3uigWcqD04FKFVloeTaBJk83JWYja0Nk1JPpA=;
        b=TNKi0k3BOoa5PjbxIsZMoBFtwyuug4Fz+Nfy1PViCSonRfr3va+F8+454Y8uhmrLw0
         4YkLmAjjkAjcEKi0i+8WZtbGQHKsYh8BBeLEzDsLUBTCFYpYUeNK7xslgsq8z9Q4YDBn
         vrltGYi+oCDNUwG8KBxJ1Z47mk0U0S9sDeYzHJbjmWqTHqS4h8Nd4718eK79b5a7lIl8
         8CH53bYw3fD8rBGrdqmu8r3ceLmuxStymVDz1pKsbVL4iKRUYi3Tl/aPygvlOQJIyppi
         AHzNfoa0yiyUfymEWqmKS7daCO7Cm+L1Lwr0Qg59goKsIYQ379UKDis5pnRp6EGfFpMG
         T+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784085356; x=1784690156;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59dtjn3uigWcqD04FKFVloeTaBJk83JWYja0Nk1JPpA=;
        b=V0Xxvcx4999oRB6xf3Cs1l0hWZ7jU0wT6PIGP/8mEFL9R3ssPYug69OsnSxwmbU5Nt
         F6SLVSzgM5IZF9uR6HR1mUGh1wrKO7ZSQ5pzpJ8GoTllS3FcJGgZ/rQSaFW5eU7x3tCw
         SvVhQzbmDFFO1jWdH1WeBUNPfPBmuHFAHBqFnBhqCHzAlziRZVrPS1Wiao8/inCcWs6X
         /lvabYhFB1j3i5hL6DpGlDjFhsvCJggB9kApiDy0CInQtqnEBb2LzhHBcTWVLXieJ0gL
         K38J5we3Fi8jxGP+FWTVd+l/wZJ5qptqYCf+boe3TbLDRNMHIReAs0urRATxLvRefsrT
         JWbg==
X-Gm-Message-State: AOJu0YwXdhL9sLYi0bT4Gf1K4qvSSpBdJgWZG9TVj2+Wu/KYOBlGBj+Q
	1iLd6QekLmTdhyRaRyM8SQNuQVU0Ja1kFZwoAjRI0cmruojzQETyRTIZkPmgYT4myrBunirjx9T
	i6x5XwB2ijxUC63SCmngpRmcPtYg6hfN84Z3udnSpP8V+1isCApkV7e5Vlrxo2YnVv5dmYe6O0X
	jjGRDT
X-Gm-Gg: AfdE7cmQSiDG3wIeCv998cl9HbYxmrTFsPbCPbztkDpJhSnhBRwRUfHr53QBsnlBgUM
	xQ43v3oDdbvkWNh+A+jfwQwW5zoPke3XznCynIg97++DUtcrYRyfhYaJn7A0sekh7NKEyQosKSU
	mYVE84rtPL/Xt+wFSHfute7EQfyrys4QviZLlCWIxmaoZSOI21zXxtTYnZtCUXXaLJAOQ8xlF8Z
	orZG5GLpcz8nWFue+VTCLVyGeABo3Z1kmVs7c0ims7TbUFT1BS1YWefsbk93+d6X8ThSitIFKy5
	p5yK0Q/QOpYwRSaVEkWAOSu4EkqN+wCYArcZmOt84QD6YQh6DbytkYZjC+flmJ7h2DP1VtuMgFa
	0kyk9PDCjR7cBEhi3U/409Eick8IAjXZGcKahJ2zeWaQsuUWuzX5ZViMyeJ9becw3zzAixn6Bp0
	nEs45GCjY=
X-Received: by 2002:a17:90b:2248:b0:37f:fd70:6790 with SMTP id 98e67ed59e1d1-38dc81c1b09mr11421806a91.9.1784085355768;
        Tue, 14 Jul 2026 20:15:55 -0700 (PDT)
X-Received: by 2002:a17:90b:2248:b0:37f:fd70:6790 with SMTP id 98e67ed59e1d1-38dc81c1b09mr11421788a91.9.1784085355202;
        Tue, 14 Jul 2026 20:15:55 -0700 (PDT)
Received: from [10.133.33.98] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e1745a86esm2287488a91.16.2026.07.14.20.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 20:15:54 -0700 (PDT)
Message-ID: <3c67115f-5aea-402a-987b-c3092e0c3386@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 11:15:51 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: fix resource leak on error in ext IRQ
 setup
To: ZhaoJinming <zhaojinming@uniontech.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <e94de910-0a15-4b82-b006-03da98305e9b@oss.qualcomm.com>
 <20260713105912.20095-1-zhaojinming@uniontech.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260713105912.20095-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dHzWBpo7K_b5uVoAMFoBz9jTCXyobx9o
X-Authority-Analysis: v=2.4 cv=E+v9Y6dl c=1 sm=1 tr=0 ts=6a56fb6c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=iHwBjlyiAAAA:8 a=EOvvyNets2oEhnj6SMYA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=uNSKXYNwxGiU6LD0JREI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAyOCBTYWx0ZWRfX/9NABhz/20CG
 LfhsAgG62dmSdx5c8Cb+lXUMNtZ9eydh4nzsUFQKMJSclmFZtu/Y5yalIjOiDhbqH6NaGaSPE1g
 7aleVYvDqXOY5Gzdok+9bWY98Y/pIy/8JJldexGyReqgPJlK3qtEvKogi+GqNGDEEL1dr/c8yW6
 XxeEH0V0glVel5pYovdzFoeW4tujov6R1cHotvVgy0rUv4OVpvBO/Y1KYMUqOE7VP0rdwoHwYFX
 53NYV6yavb4j2y+JtgLfwOPRvUA5bNEeoUiCn7zmCHhiRACM8bcPn2zlULHHRxgUtPYt63YlGK3
 ysAYB4xDKmY1AQXZJI09coKWP+arOpUSP4Qpq0WmAJm5cIZsmsoja+L6EL0dRNVbNRSHnkkgM9U
 ONp7Fxq6rJB0RxPIZUD5AaU/z8Irnr6rNMYU6DFc39E6Ukh4og4mMDrGk3xJqAxXaCHVuNirGV5
 AEtItVhOtT//K9yJbIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAyOCBTYWx0ZWRfX/ElgxCmMPsBz
 HOU1BxWnM0OlXotLs2/9Y8xF3h4OoCwvMW74NZQiBe8wxy+1U+Pb01ewlQydhU6qfXa0tMQuGkY
 Y95e26IutwWjglVViZkcB2w6v5EqeCw=
X-Proofpoint-GUID: dHzWBpo7K_b5uVoAMFoBz9jTCXyobx9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150028
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39123-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,uniontech.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D57F75A3CF



On 7/13/2026 6:59 PM, ZhaoJinming wrote:
> In ath11k_ahb_config_irq(), when a CE request_irq() fails, the function
> returns the error immediately without freeing the CE IRQs that were
> successfully registered in previous loop iterations. The probe error
> path does not call ath11k_ahb_free_irq() either, so the previously
> registered CE IRQ handlers remain attached to the interrupt lines and
> are never released.
> 
> In ath11k_ahb_config_ext_irq(), when an external request_irq() fails,
> the error is only logged and the loop continues. The function then
> returns 0 indicating success, leaving the device in a partially
> configured state where some external IRQs are not registered. This
> causes enable_irq()/disable_irq()/free_irq() to be called on
> unregistered IRQs during runtime and remove/shutdown, triggering
> WARN_ON(!desc->action), and missing interrupt handlers lead to data
> loss.
> 
> Additionally, if alloc_netdev_dummy() fails for a later IRQ group, the
> function returns -ENOMEM without freeing the ext IRQs and napi_ndev
> that were successfully set up for earlier groups.
> 
> Fix all three issues: propagate the error up to the caller and unwind
> all successfully registered IRQs and allocated resources on failure.
> 
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
> 
> Changes in v2:
> - Move `irq_grp` declaration from for-loop body to function scope to fix
>   compile error in err_request_irq error path.
> - Set ret = -ENOMEM before goto err_request_irq on alloc_netdev_dummy()
>   failure to avoid returning uninitialized value.
> - When ath11k_ahb_config_ext_irq() fails, unwind the already-registered
>   CE IRQs via a shared err_ce_irq cleanup path to avoid leaking them.
> 
>  drivers/net/wireless/ath/ath11k/ahb.c | 48 ++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index f566d699d074..11bafbd94aff 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -524,20 +524,24 @@ static irqreturn_t ath11k_ahb_ext_interrupt_handler(int irq, void *arg)
>  static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
>  {
>  	struct ath11k_hw_params *hw = &ab->hw_params;
> +	struct ath11k_ext_irq_grp *irq_grp;
>  	int i, j;
>  	int irq;
>  	int ret;
>  
>  	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
> -		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
> +		irq_grp = &ab->ext_irq_grp[i];
>  		u32 num_irq = 0;

declaration after statement. better to have num_irq declaration at the beginning of the
for loop.

>  
>  		irq_grp->ab = ab;
>  		irq_grp->grp_id = i;
>  
>  		irq_grp->napi_ndev = alloc_netdev_dummy(0);
> -		if (!irq_grp->napi_ndev)
> -			return -ENOMEM;
> +		if (!irq_grp->napi_ndev) {
> +			ret = -ENOMEM;
> +			irq_grp->num_irq = 0;

the ath12k_base is allocated by kzalloc, so the ext_irq_grp array, as a member of
ath12k_base, is already zero'ed, hence this re-initialization is redundant. But I am OK
with it since it improves code readability.

> +			goto err_request_irq;
> +		}
>  
>  		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
>  			       ath11k_ahb_ext_grp_napi_poll);
> @@ -600,11 +604,25 @@ static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
>  			if (ret) {
>  				ath11k_err(ab, "failed request_irq for %d\n",
>  					   irq);
> +				irq_grp->num_irq = j;

with this forcing to the number of successful irq request ...

> +				goto err_request_irq;
>  			}
>  		}
>  	}
>  
>  	return 0;
> +
> +err_request_irq:
> +	for ( ; i >= 0; i--) {

then with the index starting from the failed loop ...

> +		irq_grp = &ab->ext_irq_grp[i];
> +		for (j = irq_grp->num_irq - 1; j >= 0; j--)
> +			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
> +		if (irq_grp->napi_ndev) {

and with the guard ...

> +			netif_napi_del(&irq_grp->napi);
> +			free_netdev(irq_grp->napi_ndev);
> +		}
> +	}

at the cost of above three, the centralized err handling is working. Yeah this simplifies
the code, but makes it hard to understand.

what about:

1. refactor the existing ath11k_ahb_free_ext_irq():

ath11k_ahb_free_ext_irq_grp()
{
	for (j = 0; j < irq_grp->num_irq; j++)
		free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);

	netif_napi_del(&irq_grp->napi);
	free_netdev(irq_grp->napi_ndev);
}

then we can have

ath11k_ahb_free_ext_irq()
{
	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++)
		ath11k_ahb_free_ext_irq_grp(irq_grp)
}

and the complete err handling of ext irq can be

ath11k_ahb_config_ext_irq()
{
	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {

		irq_grp->napi_ndev = alloc_netdev_dummy(0);
		if (!irq_grp->napi_ndev) {
			ret = -ENOMEM;
			irq_grp->num_irq = 0;
			goto err_request_irq;
		}

		...

		for (j = 0; j < num_irq; j++) {
			ret = request_irq();
			if (ret) {
				irq_grp->num_irq = j;
				ath11k_ahb_free_ext_irq_grp(irq_grp);
				goto err_request_irq;
			}
		}

		irq_grp->num_irq = num_irq;
	}

err_request_irq:
	for ( i--; i >= 0; i--) {
		irq_grp = &ab->ext_irq_grp[i];
		ath11k_ahb_free_ext_irq_grp(irq_grp);
	}

	return ret;
}
	
> +	return ret;
>  }
>  
>  static int ath11k_ahb_config_irq(struct ath11k_base *ab)
> @@ -629,15 +647,30 @@ static int ath11k_ahb_config_irq(struct ath11k_base *ab)
>  		ret = request_irq(irq, ath11k_ahb_ce_interrupt_handler,
>  				  IRQF_TRIGGER_RISING, irq_name[irq_idx],
>  				  ce_pipe);
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			ath11k_err(ab, "failed request_irq for %d\n", irq);
> +			goto err_ce_irq;
> +		}
>  
>  		ab->irq_num[irq_idx] = irq;
>  	}
>  
>  	/* Configure external interrupts */
>  	ret = ath11k_ahb_config_ext_irq(ab);
> +	if (ret) {
> +		ath11k_err(ab, "failed to configure ext irq: %d\n", ret);
> +		goto err_ce_irq;
> +	}
> +
> +	return 0;
>  
> +err_ce_irq:
> +	for (i--; i >= 0; i--) {
> +		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
> +			continue;
> +		free_irq(ab->irq_num[ATH11K_IRQ_CE0_OFFSET + i],
> +			 &ab->ce.ce_pipe[i]);
> +	}

this is also a duplication of the CE part of ath11k_ahb_free_irq(), consider refactoring
the exsiting helper and reuse it.

>  	return ret;
>  }
>  


