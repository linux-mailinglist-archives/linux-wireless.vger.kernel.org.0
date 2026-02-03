Return-Path: <linux-wireless+bounces-31487-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIc8OLVigWn6FwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31487-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 03:51:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB4FD3E1E
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 03:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E34E302DE07
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 02:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317E2230264;
	Tue,  3 Feb 2026 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CDWNTqpU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WaxZHuMl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969812F363E
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087076; cv=none; b=u2hbG3F6vcvPDlJWWGReLMpje1tnS8S4wCcPX4u+AVXjD+d7Ihiv5CoZn0t2j+ZQUPCXhzgoStzVa91nh0MxoaUQFWiiizApOozTz1eu5Cy85m6BEQD3o/gHe3uyhu7px5jituxiLnrTwl/PS17AxCLzJsOR8uFy7UeulTl5OdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087076; c=relaxed/simple;
	bh=3RVhIHfJaJ0Sbuw4hJxBerQ9kkHrooWsvog0QFBpaaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taRI5UqCJhyUw4RG1YxUlv0f3AHneRViYZYA7ce3/h9/Rftmq+7cOH9Xq4gtrXqK7Co9u7NR3yX7xoq10ElahmBbsr7oGgtO8GPypTXfvMaNd2kkUDOe5SsLFqdOVe8ziN1BxBzaSl1XKWRr/Edq34yExlW7qOp9of9vBlqfwOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CDWNTqpU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WaxZHuMl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612K7eTM3459139
	for <linux-wireless@vger.kernel.org>; Tue, 3 Feb 2026 02:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9zRpTKaQE4Hsgsve7rWWRdaOLoxINXvg2jaj1Jl+N9w=; b=CDWNTqpU8jZQt7TC
	29C0WswuRMp0sVkGD5QqOiAStR97M6EfZNmnBxfwJHeHM7DuzWuuBbsDjDpC5MHQ
	eevv2auRdRoaoibk/kjvfHUN9jJmPYkbyO0dIUqkQy3UT4CkOHQLqttjhwP/ozt8
	bFPqc5WmZh1Yc5i+9UbHKwYXx48kku19kQrPi22nzysAD573hrsTYONDHIIANdCF
	NBphsLxxwhJ9q26CqyLUTDi+7yPTxM/5eeXFJFvTK0Cx7Dx8ycwlkWUfcm4nYSAM
	V/fzqFky9kMRugeZkf7Ktz50ySIDFlJEKVrIU3QuU46/DQUKsEht4QrEROLyH3Ad
	O4IVgg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2trbjjrk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 03 Feb 2026 02:51:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a76f2d7744so49506015ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 18:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770087072; x=1770691872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9zRpTKaQE4Hsgsve7rWWRdaOLoxINXvg2jaj1Jl+N9w=;
        b=WaxZHuMldjd4rMOsFHSeq6qCQHkpDGsgteS6mkBHU1aKtRqrGrws8aX82MDJPUNuGQ
         udJchUkzj21OC5oaSHQY7UrvTiMbXwLBPm+jLKJm+sugPbldwCWT2hbOIXnLCMUeWIYf
         oKikOeZvkpYT6KhWZm/l30llUiVBJ0iIaqruNXCXrGAH97hprRKvVB3j6HYgv/AeIqeE
         oBmQLNqwX3aHxNc0/kgcQutDFf0KcRr4bu4Xw1cX+Xv2EqiPc1mrdTUZ8gxBisCRPuLz
         W0D6A4V6fLrKMUm9Z/3ZL+z7IuNhYTofb1cBkOFn4ka6I6pOfYIoAspaA3Y2INtQKbjF
         hOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770087072; x=1770691872;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zRpTKaQE4Hsgsve7rWWRdaOLoxINXvg2jaj1Jl+N9w=;
        b=qKd9XoIFLj7hdKz8tUFlfyGspTUtSdPqkRd/k2cMoH4qarygAJUeKJfw1tcwJeiwqs
         YpxPD+a6zSdvApfhJqcZ1V10ICUlRUTCKYGdfFW3xJkQomm1q4Ma/p3E5Myy5bfY88Dd
         Le6h2Tgji8YK6YGrph+fXSI/no2or8pmaRKRPDHcg0J6c1ELgrbBZu6PP208ncFZWkD1
         9bKeQZ2J4TXkN6KmZheSP2nn7u4I3BWPV1O6H5RRgmgT6DWQcfm1iezPEHm9Ri7z72O2
         dyrBvbsX2M6UWS5kXYzzkUGwA+vzQKP5mKnKmnLuNS1GXMmSAb8uJCiycl50lwhFqtRF
         iTLg==
X-Forwarded-Encrypted: i=1; AJvYcCWR2qQsWtbx/1XpzHQEC1pGU4uu0YPNVf+hQWr9+c2X4rJ7lFswDzx3MJ7zrOFxL8JbLbdGCPK6gBlNqkU2eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyunfFUmFYm2Jdy09uVtmOUhpzV0OgHpjZkQtkC/luNcry/EH/6
	Fp6osXaE8INm2yb7y53B9lKuEP0sFhM35xltlZ5Nx+l0RX6KHAjJi/b+xxS/rLJ/WZ+8GMH5kso
	qXQDeLRhU/pwobUIcurqgsAiJ7lTC1eeqkoRN8NGsJIHPKpB+nZASR9akSQjMtz7y8OATLA==
X-Gm-Gg: AZuq6aLcq7CoMub61q7lclzNGf+GYNFbt13+GtIjO7x5i/dTBIsvm6Y7X8vPcbMqjcz
	BhHCb3hOyWK+6A2qL5w7Y4VWLVgXWKAMiUp2+fQqer2reT2Bc5r4/G6CrQlzrflzmj7/WvHrtjQ
	5jGEyjN1uplXX4v42xLzea9GupCluxduPCHo0pA3dGY2iIct4IDA2Q/tjVVfTrR0ZqBq2X0MTH/
	gFQaxmqIX4MRe1fK1unB01uTBbyTCHqARQs7rk5jEbn2RwwofiTB4NEPi7Ff3EH1/UAr0QLuTHL
	jAowktmQfhIdZh6fYPMlvkx5OMZT/hVKXAE3f3Es4TZ+92n8RGVQmUYCzH16Vq9RIu0oyT/SbSx
	5MnrT5PFEqMa20kn/gq/IDfOdlBjgALAtlnNq4q1Pbnh4Q/VCSvxLGrFyErF2TLhdYkiBx5BBbT
	WlCaBaxw==
X-Received: by 2002:a17:903:b4e:b0:295:24ab:fb06 with SMTP id d9443c01a7336-2a8d7ee71e8mr129794935ad.22.1770087072349;
        Mon, 02 Feb 2026 18:51:12 -0800 (PST)
X-Received: by 2002:a17:903:b4e:b0:295:24ab:fb06 with SMTP id d9443c01a7336-2a8d7ee71e8mr129794715ad.22.1770087071876;
        Mon, 02 Feb 2026 18:51:11 -0800 (PST)
Received: from [10.133.33.50] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eec76sm161929225ad.19.2026.02.02.18.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 18:51:11 -0800 (PST)
Message-ID: <125f0ecb-79a5-4806-aa93-aecaf937885e@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 10:51:05 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix CMA error and MHI state mismatch during
 resume
To: Saikiran <bjsaikiran@gmail.com>, jjohnson@kernel.org, kvalo@kernel.org
Cc: quic_bqiang@quicinc.com, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260202151720.49904-1-bjsaikiran@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260202151720.49904-1-bjsaikiran@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: V7s_WJLvGHYsVaUaHFt2SsqzIBWB453P
X-Authority-Analysis: v=2.4 cv=dcmNHHXe c=1 sm=1 tr=0 ts=698162a1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=RdEeBsXcWOgqNyDsrIIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: V7s_WJLvGHYsVaUaHFt2SsqzIBWB453P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDAyMSBTYWx0ZWRfXyC912UyNUFO5
 mXgSr6gEd6x4Kpdhvtp7f2ZoDlUoS2d45b0RVfdtFF4QrIr6T7YdmdHcQxRiBk8fUoFvtD5kxJx
 JbdHCkQ6RgGCuqNxfE60KC/Ll2l6Gfd0InWu4b6YUfO67d7L+uHaxseu2L0uXAXrWXaUL8r6EjC
 RLbEvK2XApiVYwWs1Fcbnq/EvuvJGSLBSI6TX9jf+0vQAKQKJazUK05PaTE8RAwi9CEz2QaPfKo
 Agt0FwoKacVIiaZR6Wk1jwA90/ToFfQgPD8YWkoko8SSSycmgLoZE/CuB6LKrOiNlpT3jT9sTvL
 fkPChWGuwW2aqhpsv1+l3/u7MZQ5H0rEFEoqPrSIxmySE2tn/DIJjupnD7nhWlxpOhyX674oOh9
 e/JLprBdQKWTprAQ1tKxMPs58VbsSe+k5cmrKWotFEnAb19rcl2xFIcvDuVC568QS0MyLZ/tCQy
 T06roTmZ8ryYv44Yrgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_01,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030021
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31487-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5BB4FD3E1E
X-Rspamd-Action: no action



On 2/2/2026 11:17 PM, Saikiran wrote:
> Commit 8d5f4da8d70b ("wifi: ath12k: support suspend/resume") introduced
> system suspend/resume support but caused a critical regression where
> CMA pages are corrupted during resume.
> 
> 1. CMA page corruption:
>    Calling mhi_unprepare_after_power_down() during suspend (via
>    ATH12K_MHI_DEINIT) prematurely frees the fbc_image and rddm_image
>    DMA buffers. When these pages are accessed during resume, the kernel
>    detects corruption (Bad page state).

How, FBC image and RDDM image get re-allocated at resume, no?

> 
> To fix this corruption, the driver must skip ATH12K_MHI_DEINIT during
> suspend, preserving the DMA buffers. However, implementing this fix
> exposes a second issue in the state machine:
> 
> 2. Resume failure due to MHI state mismatch:
>    When DEINIT is skipped during suspend to protect the memory, the
>    ATH12K_MHI_INIT bit remains set. On resume, ath12k_mhi_start()
>    blindly attempts to set INIT again, but the state machine rejects
>    the transition:
> 
>    ath12k_wifi7_pci ...: failed to set mhi state INIT(0) in current
>    mhi state (0x1)
> 
> Fix the corruption and enable the correct suspend flow by:
> 
> 1. In ath12k_mhi_stop(), skipping ATH12K_MHI_DEINIT if suspending.
>    This prevents the memory corruption by keeping the device context
>    valid (MHI_POWER_OFF_KEEP_DEV).
> 
> 2. In ath12k_mhi_start(), checking if MHI_INIT is already set.
>    This accommodates the new suspend flow where the device remains
>    initialized, allowing the driver to proceed directly to POWER_ON.
> 
> Tested with suspend/resume cycles on Qualcomm Snapdragon X Elite
> (SC8380XP) with WCN7850 WiFi. No CMA corruption observed, WiFi resumes
> successfully, and deep sleep works correctly.
> 
> Fixes: 8d5f4da8d70b ("wifi: ath12k: support suspend/resume")
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/mhi.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
> index 45c0f66dcc5e..1a0b3bcc6bbf 100644
> --- a/drivers/net/wireless/ath/ath12k/mhi.c
> +++ b/drivers/net/wireless/ath/ath12k/mhi.c
> @@ -485,9 +485,14 @@ int ath12k_mhi_start(struct ath12k_pci *ab_pci)
>  
>  	ab_pci->mhi_ctrl->timeout_ms = MHI_TIMEOUT_DEFAULT_MS;
>  
> -	ret = ath12k_mhi_set_state(ab_pci, ATH12K_MHI_INIT);
> -	if (ret)
> -		goto out;
> +	/* In case of suspend/resume, MHI INIT is already done.
> +	 * So check if MHI INIT is set or not.
> +	 */
> +	if (!test_bit(ATH12K_MHI_INIT, &ab_pci->mhi_state)) {
> +		ret = ath12k_mhi_set_state(ab_pci, ATH12K_MHI_INIT);
> +		if (ret)
> +			goto out;
> +	}
>  
>  	ret = ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_ON);
>  	if (ret)
> @@ -501,16 +506,21 @@ int ath12k_mhi_start(struct ath12k_pci *ab_pci)
>  
>  void ath12k_mhi_stop(struct ath12k_pci *ab_pci, bool is_suspend)
>  {
> -	/* During suspend we need to use mhi_power_down_keep_dev()
> -	 * workaround, otherwise ath12k_core_resume() will timeout
> -	 * during resume.
> +	/* During suspend, we need to use mhi_power_down_keep_dev()
> +	 * and avoid calling MHI_DEINIT. The deinit frees BHIE tables
> +	 * which causes memory corruption when those pages are
> +	 * accessed/freed again during resume. We want to keep the
> +	 * device prepared for resume, otherwise ath12k_core_resume()
> +	 * will timeout.
>  	 */
>  	if (is_suspend)
>  		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_OFF_KEEP_DEV);
>  	else
>  		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_POWER_OFF);
>  
> -	ath12k_mhi_set_state(ab_pci, ATH12K_MHI_DEINIT);
> +	/* Only deinit when doing full power down, not during suspend */
> +	if (!is_suspend)
> +		ath12k_mhi_set_state(ab_pci, ATH12K_MHI_DEINIT);
>  }
>  
>  void ath12k_mhi_suspend(struct ath12k_pci *ab_pci)


