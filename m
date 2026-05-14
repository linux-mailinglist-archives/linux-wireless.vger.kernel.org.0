Return-Path: <linux-wireless+bounces-36416-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA3SF6/pBWr5dQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36416-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 17:26:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9940544020
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 17:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74688314E9DB
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B3042982D;
	Thu, 14 May 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ER0twsuI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ARI30k8i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA442DFF0
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771810; cv=none; b=OYihRn0T7N6p3WP+QjuaLqoXGrwbJ5T/+JqcXdYE7J7XCYcigmldoZKYiyzFzD5jwdDN+3tETnT2pmxY9EIduMZCAHWXZWMWgeHp/Pvp4Yg+R1RzB/EekCEllg7V+OEoTT0yyFxsG6CUcsqMPFBMacfLSzgzbjp3FZo3koe/Br0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771810; c=relaxed/simple;
	bh=r6yyn9c+pEGCGrRnbGng9gWHUTiASkQtVSpMtwRZf7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ib1wqp9/ayN4ZToXVy6QGGqN1cnHFlKtF4sLfFvOskhrVZ80d78uQ2nEJc1vFpYLFMfN/CfYPigYVSso0bL8PTlAXPAsw0EVGPA1qXSqegHo19oEw5zjsXkyFJBgO7MGFDM0kkvVbfzq9nmjxSgOQQqQrAETW85fOQ1KQc0brIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ER0twsuI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ARI30k8i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeWcA3061936
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 15:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bPlHXawxs1R9kEavnhYmyNHAkkm5AEaUrclL97PXn8s=; b=ER0twsuI+A0m6XO0
	E7jy7MRvRULwj5LPJZvuvPQEMDozE9LqMkGh6M4hatVZV270ufHKN8XXJ5fmKo3C
	zu+GZNoSXn7YGBLhUQ2lMDYrTbWs/5uRshdzYC0VZqS6E7SEYzr5A10PSNdwdgy/
	3Bltea42BMH6cpzJkjy0NLtCUUVLMEJwVCBolhTKklJE0AYcePx/TcUE4ELq/O5R
	qs8egG8mcrv8Ygl7AOY4eDXM40KXqV9enDvQoRwsRyIX58Z0iY05UxD0Nkb0Bq7Z
	JJiqOE2zbTKZWrEXBuWXuUfrwvIdudEfJV91/siIOyYi+cSxg5D9SAtwdcM8s37X
	Vnfh4w==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e554aamr3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 15:16:47 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-130aab78a09so8079595c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778771807; x=1779376607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPlHXawxs1R9kEavnhYmyNHAkkm5AEaUrclL97PXn8s=;
        b=ARI30k8iYeDsquCAkoOxc1ES5Hvhc49IWzdxSjUazkd2uPi3/TJS1gVGwgglCzvLFr
         FsbxhacidD+905Bikt7Zv/r5g0nd/y9LXRpB5WFUJa9Ps87QpnNwtEG+LzaANOmF7TfH
         aTRz4TUnxWb5I2SeHPLPOOUgs1r0VYr7yHdpmNB8Q8SMlrsQ+OyuabUpYqGOm6JrO7vN
         yqWdLAXF9Cvxl7FCbdHOTuU2Z69tV+ZyFlbR4DjEW/vyUzUEynSAMNkNhIF9ThbP5iDh
         gT7eW/Tmwbtjpf/EP73OA8qy74zNiyisp/ZSigO5DA/jB+3ZcNxlgu4lsp6JjjC3KFuQ
         f6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778771807; x=1779376607;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPlHXawxs1R9kEavnhYmyNHAkkm5AEaUrclL97PXn8s=;
        b=eH/+uAdS5/4Kt9/M2omdXJvQo0EwV5xPVBJnovf3Ih8SKc3cdAmeEjbKqKbC+pv11U
         unhy/cA4px15Shzz35Moarx6c+23enS68dNFk43n2eiUTW6U76eokh8Cm5r/NOEuWiLc
         g/FeFlekVnCF6CiBUi2mBTxVYNcHGJTmCfWeEngv10dfVaP8BlOxIlgp8ViOwRIATrps
         /Xlz1kIiBhZLwlA0JM6GJQ7j3pFlHkdRVl9f0oth0WbBjgvQklxdx2xbMREnbbg8zESd
         WuN2pD81c5dj9vPrp3MhrqP86JLY4yYSF4iLldg10tBLCowySL/Ip4NCkyNjkrRTObog
         vJZQ==
X-Gm-Message-State: AOJu0YwoJTLRdN7XXo6LhemO6p+ryVJtuwv6eQ63qfvY8flllEd2BrFf
	9WwFxGs2CADRtivr3MYHI8cT8HdOdI4q4I6ChDslwEaw5ubf5xaq28GHrv+jy97lRKOvzCnHl/K
	Y+9x/lSM8nUXX8FzDl3e2JkLI1iq9x4FZW74MRzJzvVedp6hpQi5Sf1JVdYPBRnN1WEznsQ==
X-Gm-Gg: Acq92OHjQHsgsHJUXJefBf8IPZs1OFFq3m6XYXFT4TuKX7v3w6jnxUgNzkLt1fZVy1E
	J9UrIfQOhoy7nDE7ZGQCwj79PBsPQ3t7rSDkSeKiXWAX8kbuhGjmQ5ajPpRUXZkMCPeOlB/I08T
	YbFpg6t1habgkir3/s7hfddvbkAAV3nm6pOClYBUl91MM2yyljtDhKkWL3mYc1jdOxCqXmyiI5y
	A3LLbFhGG9xg5WLDe68fyXhY2YvYUlKwdVLtd9GE3kddH4QHujJHeI1i38qda3GEsO+3AQfd8we
	CckcBe8qmgZC2vPBQgedwurzDOtesmNeeALTYuWRXluXlSMfc06wymf7JzdWW2XQJqbCPbYHA/v
	kKpCJHykmZSich+t0MxdZkoKV10Y8DA5CDM0WtakoSuqXSSV1a27RCGSa+8+EpaIi2QLZaC0Pg7
	Lku0QYnQ==
X-Received: by 2002:a05:7022:618a:b0:12d:de3f:f3d9 with SMTP id a92af1059eb24-13436ba610dmr4727838c88.35.1778771807082;
        Thu, 14 May 2026 08:16:47 -0700 (PDT)
X-Received: by 2002:a05:7022:618a:b0:12d:de3f:f3d9 with SMTP id a92af1059eb24-13436ba610dmr4727809c88.35.1778771806398;
        Thu, 14 May 2026 08:16:46 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed531esm4920679c88.8.2026.05.14.08.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 08:16:45 -0700 (PDT)
Message-ID: <ddd1601d-2eef-4a52-af16-594223449c8c@oss.qualcomm.com>
Date: Thu, 14 May 2026 08:16:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: clear shared SRNG pointer state on restart
To: kfarnung@gmail.com, Jeff Johnson <jjohnson@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, santiagorr@riseup.net,
        stable@vger.kernel.org
References: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _Sp4-ePM8ncm4ergAWV4rNWMidmQIZvj
X-Authority-Analysis: v=2.4 cv=Wag8rUhX c=1 sm=1 tr=0 ts=6a05e75f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=xNf9USuDAAAA:8 a=yURyTq39TCQ5d30jD7MA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=3w6iy9BqfFbDrj__1GvT:22
X-Proofpoint-ORIG-GUID: _Sp4-ePM8ncm4ergAWV4rNWMidmQIZvj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE1MyBTYWx0ZWRfX9e9aiPb95UjV
 iv00I66+2e7YrJjIAo43ss8Axp4Xepefx7CgQAxu4QTUUE4zfYuH8R27RQwBansPvDlSCmJtZDS
 Atw+srnuwFBpHZfBe1qADp6qQ3vf7fqziyi9ny9bA87FA+GMyv8JUmxYiYW+36LyX0gIjcI8UdV
 eCvkpojXiLW1hmLfjfTgwCi/Zu99TW+Qw3u8LdN2PJS/2sja2qPi1AXaBXgtHudv2B81c3bcf/Z
 h+FSBXs8h3HXTApmOgy8fbX60M1LJFTmCkSJJsTFraVV1dLOmwffg1L/o4d4WyTmouDCHo5ZpdN
 d/hbT9zcI2//7xM5LvvzZHyOY3bwEO5w6lPfckOckGxOyvWW4Hv2jJM5tK5gBFvmzghRgmR6cZx
 b7kc2M25ldqvJdmIPDuqu/jJ7XDNUAHcbmLsJ85VhKSwYbzRUTJQdNwqcYtAO05HjTbbk4xgkq4
 N8vxuE4wqwa+QSqz5oQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140153
X-Rspamd-Queue-Id: D9940544020
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36416-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,arm.com,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/13/2026 9:52 PM, Kyle Farnung via B4 Relay wrote:
> From: Kyle Farnung <kfarnung@gmail.com>
> 
> LMAC rings reuse the shared rdp/wrp pointer buffers without going
> through the normal SRNG hw-init path that zeros non-LMAC ring
> pointers. After restart, ath11k_hal_srng_clear() can therefore hand
> stale hp/tp state from the previous firmware instance back to the new
> one.
> 
> Clear the shared pointer buffers while keeping the allocations in
> place so restart still avoids reallocating SRNG DMA memory, but starts
> with fresh ring-pointer state.
> 
> Fixes: 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=o9wVcFMc6f-yhmSBcZqQ@mail.gmail.com/

I'm going to change this to a Closes: tag in my pending branch

> Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
> ---
> This patch is the result of investigating suspend/resume failures on a
> Lenovo ThinkPad P14s Gen 5 AMD with ath11k.
> 
> I originally proposed extending the existing ath11k PM quirk for this
> platform, but after discussion in [1] and bisection the issue appears to
> be a regression introduced by [2]. There is also a parallel report in [3]
> that appears consistent with the same root cause. This patch keeps the
> intended no-reallocation behavior from that change, but clears the
> preserved shared SRNG pointer state so restart begins from a clean state.
> 
> Testing so far has been limited to local suspend/resume cycling on the
> affected system. The issue was originally reproduced on v7.0.4, and the
> patch was also built and tested on top of ath-current with repeated
> suspend/resume cycles on a Lenovo ThinkPad P14s Gen 5 AMD.
> 
> [1] https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=o9wVcFMc6f-yhmSBcZqQ@mail.gmail.com/
> [2] 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again")
> [3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1132343
> ---
>  drivers/net/wireless/ath/ath11k/hal.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index e821e5a62c1c0..0c0aeb803018e 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -1387,14 +1387,21 @@ EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>  
>  void ath11k_hal_srng_clear(struct ath11k_base *ab)
>  {
> -	/* No need to memset rdp and wrp memory since each individual
> -	 * segment would get cleared in ath11k_hal_srng_src_hw_init()
> -	 * and ath11k_hal_srng_dst_hw_init().
> +	/* Preserve the shared pointer buffers, but clear the previous

Since you are touching it I'm going to change this from the obsolete
networking block comment style to the universal block comment style with
/* on a line by itself

> +	 * firmware instance's hp/tp state before handing them back to FW.
> +	 * LMAC rings reuse this shared memory without going through the
> +	 * normal SRNG hw-init path that zeros non-LMAC ring pointers.
>  	 */
>  	memset(ab->hal.srng_list, 0,
>  	       sizeof(ab->hal.srng_list));
>  	memset(ab->hal.shadow_reg_addr, 0,
>  	       sizeof(ab->hal.shadow_reg_addr));
> +	if (ab->hal.rdp.vaddr)
> +		memset(ab->hal.rdp.vaddr, 0,
> +		       sizeof(*ab->hal.rdp.vaddr) * HAL_SRNG_RING_ID_MAX);
> +	if (ab->hal.wrp.vaddr)
> +		memset(ab->hal.wrp.vaddr, 0,
> +		       sizeof(*ab->hal.wrp.vaddr) * HAL_SRNG_NUM_LMAC_RINGS);
>  	ab->hal.avail_blk_resource = 0;
>  	ab->hal.current_blk_index = 0;
>  	ab->hal.num_shadow_reg_configured = 0;
> 
> ---
> base-commit: 54a5b38e4396530e5b2f12b54d3844e860ab6784
> change-id: 20260513-kfarnung-ath11k-srng-clear-pointer-state-91d8ab07e5e2
> 
> Best regards,


