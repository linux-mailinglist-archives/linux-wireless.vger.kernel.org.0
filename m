Return-Path: <linux-wireless+bounces-32287-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA5vG4NzoWkPtQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32287-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:35:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C514E1B60D8
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6949F303429B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A73396B7B;
	Fri, 27 Feb 2026 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QdNQ7pkA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GWPF13jP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42B39526C
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188535; cv=none; b=sayzCvGq9GE96X5tOSxGdbFz5XZX28+cZ71aATS/ptcGtojFWJOM7aCU6BZx2tJL1Cp0eDNY71EDdl47BSckaL/husTHrsnP4DqREXYwpyfe5gpydUilT2gLj8woMR4+8eFVlqDehYkD/+wIptbDB28Ak+0MTbIueeKypK+iX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188535; c=relaxed/simple;
	bh=9vckjiUwr2QCkBeNq5pRzUhccCk0m9uHJxz170OfeeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WaOjzjnTaHOyUTM/dhArDFpBbwYcmUdJN9V3oee4bEZeNwOLPn+zN8BE0UcHIMPW1sCtWUp24UKuVDMTqNW8w8TPHntBLQEV/c7WZxhjRWw7phXRHgUo356zThd8gFB+H4bkVgzKjuUhOyACDgwuRwR+YYjG9oC4aQ/08TR5pdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QdNQ7pkA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GWPF13jP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9ufFH3746993
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H0Lc1eqGejEKqbReUge3UeZ1gxHJB7/DI9+f5ViN17s=; b=QdNQ7pkA05zumX1s
	TQ4WaOmA7RK5Qa6zgvmjAGxmnVKYJ82djZlbHt+zELrTCEKQ3ULBvWUfEug1vHoD
	nSbE9b9WGluI/anv/aua3LdhTSu8LGP4K6gf7DVelNvibMoAYi6HkcUkhIt4D8f6
	ym1cWCZgHXlwaiSu7q4gRQhTcyjkKnmdbQXzfSX9oxA/k3Fuq5VTj4y+2n7oUYoL
	ZKSaPeWQ8E+wbU+C2JMwf9KaqYLvZxLd6rQQZRCT6a/yLAcjjFsvPCbH3M+8bUXZ
	gj7tWR9vw3wSbiq+3C6J3SH8WAcjvrv4JJdchblzbGuQPnBLnhJBR5LYRDAXJ8sT
	tjm5Ig==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuur2mnn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:35:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c7febaefso6428417a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 02:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772188531; x=1772793331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0Lc1eqGejEKqbReUge3UeZ1gxHJB7/DI9+f5ViN17s=;
        b=GWPF13jPMeqnwuYKx1WE5M8FRyDav7/ixFRyKaq7/oOrNZo8wFHJWAA5NAL1B0r7dH
         fZ0RiARlNckuXuWLPNJ5ELGi8GAd+ItnVHfvGx6SHGTDhSYU2s2Df+gzCcDC86X8Ww6b
         PZdqJgUrcQHXM5Kb78RHMBk+bAP2BCYPWRzB3JAOcPc3xl22BhhoT/2RhqL9ZIuC4kPO
         f99K/gYC23xnu/NSTXxRNI1kHK00TSQOjxouHxDo9P5QP18mwvTafynuwmFQ3vt4I/XS
         fwefja2Z5gP1qESQBWqh2ea4e0QjYB8j6ZZUlI6KituuG3ekGDeY5SJu8AX0cYK67nPw
         f4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772188531; x=1772793331;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0Lc1eqGejEKqbReUge3UeZ1gxHJB7/DI9+f5ViN17s=;
        b=LB2p50ePbr3M0jWi3oUUmMJcHyF3a93I8d96djrylSsQRH0HBssmhZUB035JBVdsvJ
         W6nz00EQpSmqPAtobgEnAVpzhCaoLW8LLjcO0annENA2sgJ0YTRXtpgeAf8+s43qb4tO
         EP5HJYNm1i7mQikbRvRURSa4jd8T/0KES68T4NZOewRfRM9f8Qw8lc/wx1hTEVpgS1cy
         K6rcWkgmkMsB9ryD6Zkre/fCuDFydBXn3PgnGSXit3/OpdQbslBD0V9L2vKfGUBYngdN
         ZlEAPGj8IYu3i4D74Cs97xRMGu4vEqvimnK+HteFFTD2hIJiFOICmgD6rGSGJmRqNGZ/
         KWAw==
X-Gm-Message-State: AOJu0YxQa/xyLj16TnrXKphXjORNdp3disPlf+UjkKjQDeQs0Xn+epC3
	yEewNBT86lXvbbEzT2Haqb8qMFptNNJkKdiHqx+prmScSZdn5XGVhk87uPhVSYavRA1POFh1A0u
	3upJXuvUqxzDc6sU5XAqzPuuABnwE0XUaGEXi16AqRGfcdZjS5+KWr/LqaHq7/C4b22aaXg==
X-Gm-Gg: ATEYQzzKaPVRUZkXGDH9qBdAU1FJXShMN5Fx1AohFyNWxl1eFROsYM3nyzo3UQaWgmG
	xeqa7NxS8P/MpoL4ugefMdfmq/rP5KAZmpyFXup1B1n08AmlD+BfsWN1pWGXYtIIQ15x2KvMcJk
	mznQvs0dJyCkGYmO7XPGbS38ebA0MwU0nRml+PyvIjOicwc9n4Sxpz5JE0Bf8nUleVc9J7Ll9Dw
	HRzGQq8HTySSTXDlcHbRhdIcmzcvgGPcJT73O/InpEsvoYeugoqfN89vgCTSFpa7IrLieKTTLz9
	2e+voXyUYSACTfIw6qWjE3Gu8Hp8zveiIgWmKIz3oPmfvtjCh+V9q0bIq1tGJmBYVxAUAI9JJqU
	8qDobxLaQa1D4wjeY1cQ1B/i8SXM2t/tuJlpte7nn+xHLS5j2NC6abDy1T/evw9ZcdHq9mXPoDi
	GDC1cUIDsdqCsNf4xqTg==
X-Received: by 2002:a17:90b:3501:b0:354:c7f8:6d7b with SMTP id 98e67ed59e1d1-35965cf8152mr2475048a91.27.1772188531513;
        Fri, 27 Feb 2026 02:35:31 -0800 (PST)
X-Received: by 2002:a17:90b:3501:b0:354:c7f8:6d7b with SMTP id 98e67ed59e1d1-35965cf8152mr2475028a91.27.1772188531067;
        Fri, 27 Feb 2026 02:35:31 -0800 (PST)
Received: from [10.133.33.12] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f8a3sm8044969a91.2.2026.02.27.02.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 02:35:30 -0800 (PST)
Message-ID: <60467511-80a7-4c56-8e6c-04b2f3eb971b@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 18:35:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Set up MLO after SSR
To: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
References: <20260227041127.3265879-1-roopni.devanathan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260227041127.3265879-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7tC2bU4Zx2h91YiYqOfYZXntxjgTqMNB
X-Authority-Analysis: v=2.4 cv=PN8COPqC c=1 sm=1 tr=0 ts=69a17374 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=X4JEpTBpwg_adTgisIIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA5MSBTYWx0ZWRfX6ggyahdASJdl
 M7tqDEZlUUwFfR/Pef+Pdu4aNNcH14/gI/Q3r2Iaxrc4gkJ1zUElXH0zqlvoSzmn44H0SgOKWHI
 e/6efdjkKBizApuMMJmNQ2dhTEkdts8tnSlXTy9KMp7NFoIYq+tK/4XIRsWjzrtGUR/THMO3Cnd
 tTDSFwsbGf5frS+yYKHwyyecSc10FPKSwbcNt9tZ/azuSsz/D7YTgtRXO+SyloTLR0LK9lIRLV8
 iVJv5hKk3Om5LppQftK4VbcGX1OOYjnlR0vwQTzjYFAzT3EJsORm6Rpbzc4z0xhyRpO3WTroaC1
 krk25TQglMN36nxD+HxeMSOY5xbwvc6fcHuYmFLne++F9Z0Fqmd77QAw4sg76NX+G4APSVUbdkJ
 HY3VCirK4pa9t3B3Uh8uUnYAt4VIAcirvmpyM7w+EDGddtKmEo42p4iknHCdqMyA/Lml1EdJ8Og
 paCJJJv5kqSXLKNTfGw==
X-Proofpoint-ORIG-GUID: 7tC2bU4Zx2h91YiYqOfYZXntxjgTqMNB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270091
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32287-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C514E1B60D8
X-Rspamd-Action: no action



On 2/27/2026 12:11 PM, Roopni Devanathan wrote:
> From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
> 
> During recovery of an MLO setup from a core reset,
> ATH12K_GROUP_FLAG_REGISTERED is set because ath12k_mac_unregister is not
> called during core reset. So, when an MLO setup is recovering from a core
> reset, ath12k_core_mlo_setup() is skipped. Hence, the firmware will not
> have information about partner links. This makes MLO association fail
> after recovery.
> 
> To resolve this, call ath12k_core_mlo_setup() during recovery, to set up
> MLO. Also, if MLO setup fails during recovery, call
> ath12k_mac_unregister() and ath12k_mac_destroy() to unregister mac and
> then tear down the mac structures.
> 
> Also, initiate MLO teardown in the hardware group stop sequence to align
> with the hardware group start sequence.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
> Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 9dca1a0af73e..218c0a0c9699 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1017,6 +1017,8 @@ static void ath12k_core_hw_group_stop(struct ath12k_hw_group *ag)
>  
>  	ath12k_mac_unregister(ag);
>  
> +	ath12k_mac_mlo_teardown(ag);
> +
>  	for (i = ag->num_devices - 1; i >= 0; i--) {
>  		ab = ag->ab[i];
>  		if (!ab)
> @@ -1134,8 +1136,14 @@ static int ath12k_core_hw_group_start(struct ath12k_hw_group *ag)
>  
>  	lockdep_assert_held(&ag->mutex);
>  
> -	if (test_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags))
> +	if (test_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags)) {
> +		ret = ath12k_core_mlo_setup(ag);
> +		if (WARN_ON(ret)) {
> +			ath12k_mac_unregister(ag);
> +			goto err_mac_destroy;
> +		}
>  		goto core_pdev_create;
> +	}
>  
>  	ret = ath12k_mac_allocate(ag);
>  	if (WARN_ON(ret))
> 
> base-commit: 20ad0d58517073b3b683ff786c65dd3142321707

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


