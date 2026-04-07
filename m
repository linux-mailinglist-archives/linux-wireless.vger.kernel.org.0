Return-Path: <linux-wireless+bounces-34415-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO2EAi961GmxuQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34415-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:29:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7B03A96A0
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FDAA3017F8F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 03:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC59372EFF;
	Tue,  7 Apr 2026 03:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S08pbD0T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="juRXIwtm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B711A9FBA
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532588; cv=none; b=AqccUIqNvlyLJj++TCG0d5zUE/Oei8biPM2yyy/edSwO4qsPS/nPEHvyk4aJ+2C/vPLqGAo3vTnTlLfnptYdhGmDoX/zTjDjWUQhm4++RtdiD6Gh24U40h3XF5KSz4rUxzJaOSN88LW5w0T5QeldCRm0XRVHD8suvzdueRNMVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532588; c=relaxed/simple;
	bh=kBNWK+bNOtWUCUAysTlARD8yqbqUp7ThTxA7anFRAI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toZroo/+GshlEG1ArUIX3CS6q9BFv/4tZwuKmLGqdvNSUCjZuwcyoZtpmR4iY6wkrHw568/76cBnliiQe17/pfvb5RT3QrrtPWsyEt1WkrAZ9k1G1vQX9++yr3YsObMmDGQ4s77+SLIclT/py2fQWZJwGf4lDm529YPlk9rt2zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S08pbD0T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=juRXIwtm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQX1B3402354
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 03:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GWc+ASGX1YQZtVUl1/Lf//+V2S8wnblPcebhCa58dII=; b=S08pbD0TsQjGPDhF
	jl6qh+4x6WVhciY0ch7fk9irrzlG2vvw3K7q4jhPCWEJlpFYdbdPrdxxjnNFWAtB
	QKBr5FCfCP9VUTvZ10XRKU02tPT+oBpBtRg+3s1m3jorl4lsNUBVyvcxO1lGJRgI
	JRwgYiN+cujwIrs85kDZj6F/aernrGUxMoMYGYsZdKVonAZ4uR7T28p+nMlb70Sl
	6vL63Do07xPC0FNxrm5+csq2/x35aZg+pB/Shqijtr/5UkYu4hkdrstabrvCoLyE
	1JLFw08fueBkIxIVnVYPxmPlcCrHjX4T7aRVYw6LaiqzwEe/ZZnDAPkY0J33bw2S
	O/6pMw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhrtuh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 03:29:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35d90c7ec5aso11615367a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 20:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775532585; x=1776137385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWc+ASGX1YQZtVUl1/Lf//+V2S8wnblPcebhCa58dII=;
        b=juRXIwtm7aR5pE5Gm0KJBXIsjHo1N0N1eEgxStT47wI7xwmOJPVZvqaMV3l0H3N5Mx
         3J/v0bQv7J9P3d44o9ZyhdyJEqRb2FeajF9SpObaxlcf1FDVmoRWZJduNqMoJBHH9Yua
         E2zYwwXaQGT7ACFHQexCXq/Rs7lgy1sa8DdgvIblRixmVzwc4yVvSysv0Jkipm0lsYGu
         22CO83ZFWcMrAfp+h7hawr6TFg7FeeNe8XRgmrUHZvQH1jweOMSXvrN4ckEljTdViiVl
         7LhIjWK1ioPhyvJXFeCRdbVNFovDbXQVnrBu/z+l9gKwGeZ2fioRil2UkuZyZIIw8b6J
         pr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775532585; x=1776137385;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWc+ASGX1YQZtVUl1/Lf//+V2S8wnblPcebhCa58dII=;
        b=VKlwmThNEFYZj4AdXKU1nozaEzNZxdHg2nAt7pwP3i/4jeBXMBeev05Baebr3WJEM0
         M/IuOkB5bPMzuHU/Aro/cnwMlDifKCWwdSujP6LG4QIJYYafxFWlSmpi9EMTmS7XFZBx
         n9S+cY/a5+yAiak48h9/AAoyfGsbIcDcjwXNawGWBtU0U+xM5E3Lex3PA9TN3ImrAZcF
         X9iGzPwALkoO6ildIYXPyHgOuQbve2ToDBhAcAQhxI+l6s5ffLWtlFzoY+A2o9YK6yEl
         /L02RhHaPGhqW7doS3VsZgyNbcdvuM/KzVz0B2WVCZkxarHU//WtTAcYIXp02pA9XNnr
         TPRw==
X-Gm-Message-State: AOJu0Yx7nrY280kzY8IbmyM1wIyiHcxRj8rK/9/WldcF0ZBstzbAwKW3
	YtKMxVBBk2mAx7hpHz+OEAGhKkPQJglCMP8j7DCwvNHXpSmvL0jmieYtoS4T0Gaf2yyEC5/Su/z
	cnH0bkjvgH619GLwadR8l5LvaUuLFk06KoR3p3Gg/OLFBFdlJsSFOrFoA8PXP5ByztgVO/g==
X-Gm-Gg: AeBDietOQ8aGfJS8P4ZfyzjOawNSz/l/b11kldBKdKofuuUQNgrGpRhwF2ehNHutER1
	VDAQzPe54k3q+SL0EaRrvIAVydGiy+AhlqqcnwkqsG1wxrxx1rpCUGS1usLfk7o48B01Qlm0k6o
	SdDUFosTfT0+/VXLzz4d21A8b2qs01ElO3bGdfGRiENXJpmdLraOqy9epXWgS8Ns4/ZnYUsVSAN
	R5e8LvUcXcO/e2Un3LLb+AM5HrSuSzGf5/2aGLrbIYxUew/RoKYuWCmEHVdCz32YDQutJxZK3Ce
	ziuXJfQImz3/tF2d3XuoGmxU/TN5Yxcdo/ODkDF/GIAyRQK5DjVJdHCJlXwceuEqM8TXLkRVHop
	3WvwV2T5e0P/4IV+T70dtbti0t0sX5MHPKWwF5wAsZSorJNQq9zFFM8iZNYgmPfp+yIoxC7oY4h
	xURUBE7vOkKZJPBjfzpDk=
X-Received: by 2002:a17:90b:1d08:b0:35d:93ff:2856 with SMTP id 98e67ed59e1d1-35de6816850mr14346187a91.10.1775532584671;
        Mon, 06 Apr 2026 20:29:44 -0700 (PDT)
X-Received: by 2002:a17:90b:1d08:b0:35d:93ff:2856 with SMTP id 98e67ed59e1d1-35de6816850mr14346162a91.10.1775532584129;
        Mon, 06 Apr 2026 20:29:44 -0700 (PDT)
Received: from [10.133.33.204] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6476a81sm13764608a12.7.2026.04.06.20.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 20:29:43 -0700 (PDT)
Message-ID: <03c3da0d-4bea-49be-b0b3-4be6f408daaf@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 11:29:40 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Create symlink for each radio in a
 wiphy
To: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Harshitha Prem <harshitha.prem@oss.qualcomm.com>
References: <20260402051402.3903795-1-roopni.devanathan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260402051402.3903795-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAyOSBTYWx0ZWRfXyyxcghZ5+Efw
 qv5FxZJgyQc651pVKicsTBh1Ga/kZgCFyrw8EFjTRRUSOn6tCKutmUEAlhkZ0Iq2nNJG5z4ZQc8
 /RaS1G7NBmsjJLSC8PNey0/rnq97E4odwmMB8BZzkScF/Ypfe5K+lf6mhkulvPwhrc4KOgDnPrU
 fUg4FMFcCsKeYlOZ1ODlHdzUdjpWwwJEAYFkv8+LlnlztyqpzP8LTuShoUNcHtfM5Gd6t38TWgK
 QbzkJP9AfeZndwvvg7pJLpB45ASRhFNFieYHFb6FZ8WNOSOD4qTLHi9dCjdd84yxXkLkc2nE/uK
 y/NaAwrtKNTV6oBH3pZ1sxsWMOhiQSdbotMVhh3oUYGqcO0ZeUwxBU7+eCK9yFOlroDR/soGg0N
 6WDsyXDw2CEC/8XaMwOMcFhOGrNXxQJ8F0uEWOQ9gCisU54U5S+PIZMYnZARb+srnvQE2t64k2a
 sqbUhtr3BRevDrsriAA==
X-Proofpoint-GUID: HXmbAjmRCPCZp6OeK8mfWH2ypiVgai7d
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d47a29 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=lxJo2wgQVOyoRhA3UyYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: HXmbAjmRCPCZp6OeK8mfWH2ypiVgai7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070029
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34415-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 6F7B03A96A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/2/2026 1:14 PM, Roopni Devanathan wrote:
> In single-wiphy design, when more than one radio is registered as a
> single-wiphy in the mac80211 layer, the following warnings are seen:
> 
> 1. debugfs: File 'ath12k' in directory 'phy0' already present!
> 2. debugfs: File 'simulate_fw_crash' in directory 'pci-0000:57:00.0' already present!
>    debugfs: File 'device_dp_stats' in directory 'pci-01777777777777777777777:57:00.0' already present!
> 
> When more than one radio is registered as a single-wiphy, symlinks for
> all the radios are created in the same debugfs directory:
> /sys/kernel/debug/ieee80211/phyX/ath12k, resulting in warning 1. When a
> symlink is created for the first radio, since the 'ath12k' directory is
> not present, it will be created and no warning will be thrown. But when
> symlink is created for more than one radio, since the 'ath12k'
> directory was already created for symlink for radio 1, a warning is
> thrown complaining that 'ath12k' directory is already present. To resolve
> warning 1, create symlink for each radio in separate debugfs directories.
> For the first radio, the symlink will always be the 'ath12k' directory.
> This ensures that the existing directory structure is retained for
> single-wiphy and multi-wiphy architectures. In single-wiphy architecture
> with multiple radios, create symlink in separate debugfs directories
> introduced by mac80211.
> 
> Existing debugfs directory in single-wiphy architecture:
> /sys/kernel/debug/ieee80211/phyX/ath12k is a symlink to
> /sys/kernel/debug/ath12k/pci-0001:01:00.0/macY
> 
> Proposed debugfs directory in single-wiphy architecture with one radio:
> /sys/kernel/debug/ieee80211/phyX/ath12k is a symlink to
> /sys/kernel/debug/ath12k/pci-0001:01:00.0/mac0
> 
> Proposed debugfs directory in single-wiphy architecture with more than
> one radio:
> /sys/kernel/debug/ieee80211/phyX/radio0/ath12k is a symlink to
> /sys/kernel/debug/ath12k/pci-0001:01:00.0/mac0 and
> /sys/kernel/debug/ieee80211/phyX/radioY/ath12k is a symlink to
> /sys/kernel/debug/ath12k/pci-0001:01:00.0/macY
> 
> Where X is phy index and Y is radio index, seen in
> 'iw phyX info | grep Idx'. Two symlinks for the first radio are to ensure
> compatibility with the existing design. Add radio_idx inside ar, to track
> the radio index in probing order.
> 
> API ath12k_debugfs_pdev_create() that creates SoC entries is called more
> than once when hardware group starts up, resulting in warning 2. To
> resolve this warning, remove all other calls to this API and add one
> inside the ath12k_core_pdev_create(). This API carries all pdev-specific
> initializations and can conveniently hold a call to
> ath12k_debugfs_pdev_create().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Co-developed-by: Harshitha Prem <harshitha.prem@oss.qualcomm.com>
> Signed-off-by: Harshitha Prem <harshitha.prem@oss.qualcomm.com>
> Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c    |  4 ++--
>  drivers/net/wireless/ath/ath12k/core.h    |  2 ++
>  drivers/net/wireless/ath/ath12k/debugfs.c | 29 +++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/mac.c     |  2 +-
>  4 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index c31c47fb5a73..2519e2400d58 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -835,8 +835,6 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
>  		goto err_qmi_deinit;
>  	}
>  
> -	ath12k_debugfs_pdev_create(ab);
> -
>  	return 0;
>  
>  err_qmi_deinit:
> @@ -869,6 +867,8 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
>  		goto err_dp_pdev_free;
>  	}
>  
> +	ath12k_debugfs_pdev_create(ab);
> +
>  	return 0;
>  
>  err_dp_pdev_free:
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 59c193b24764..046249c8763e 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -588,6 +588,7 @@ struct ath12k_dbg_htt_stats {
>  struct ath12k_debug {
>  	struct dentry *debugfs_pdev;
>  	struct dentry *debugfs_pdev_symlink;
> +	struct dentry *debugfs_pdev_symlink_default;
>  	struct ath12k_dbg_htt_stats htt_stats;
>  	enum wmi_halphy_ctrl_path_stats_id tpc_stats_type;
>  	bool tpc_request;
> @@ -673,6 +674,7 @@ struct ath12k {
>  	u8 pdev_idx;
>  	u8 lmac_id;
>  	u8 hw_link_id;
> +	u8 radio_idx;
>  
>  	struct completion peer_assoc_done;
>  	struct completion peer_delete_done;
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
> index 358031fa14eb..8c81a1c22449 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs.c
> @@ -1473,18 +1473,35 @@ void ath12k_debugfs_register(struct ath12k *ar)
>  {
>  	struct ath12k_base *ab = ar->ab;
>  	struct ieee80211_hw *hw = ar->ah->hw;
> -	char pdev_name[5];
> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
> +	struct dentry *ath12k_fs;
>  	char buf[100] = {};
> +	char pdev_name[5];
>  
>  	scnprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
>  
>  	ar->debug.debugfs_pdev = debugfs_create_dir(pdev_name, ab->debugfs_soc);
>  
>  	/* Create a symlink under ieee80211/phy* */
> -	scnprintf(buf, sizeof(buf), "../../ath12k/%pd2", ar->debug.debugfs_pdev);
> -	ar->debug.debugfs_pdev_symlink = debugfs_create_symlink("ath12k",
> -								hw->wiphy->debugfsdir,
> -								buf);
> +	if (ar->radio_idx == 0) {
> +		scnprintf(buf, sizeof(buf), "../../ath12k/%pd2",
> +			  ar->debug.debugfs_pdev);
> +		ath12k_fs = hw->wiphy->debugfsdir;
> +
> +		/* symbolic link for compatibility */
> +		ar->debug.debugfs_pdev_symlink_default = debugfs_create_symlink("ath12k",
> +										ath12k_fs,
> +										buf);
> +	}
> +
> +	if (ah->num_radio > 1) {
> +		scnprintf(buf, sizeof(buf), "../../../ath12k/%pd2",
> +			  ar->debug.debugfs_pdev);
> +		ath12k_fs = hw->wiphy->radio_cfg[ar->radio_idx].radio_debugfsdir;
> +		ar->debug.debugfs_pdev_symlink = debugfs_create_symlink("ath12k",
> +									ath12k_fs,
> +									buf);
> +	}
>  
>  	if (ar->mac.sbands[NL80211_BAND_5GHZ].channels) {
>  		debugfs_create_file("dfs_simulate_radar", 0200,
> @@ -1513,7 +1530,9 @@ void ath12k_debugfs_unregister(struct ath12k *ar)
>  
>  	/* Remove symlink under ieee80211/phy* */
>  	debugfs_remove(ar->debug.debugfs_pdev_symlink);
> +	debugfs_remove(ar->debug.debugfs_pdev_symlink_default);
>  	debugfs_remove_recursive(ar->debug.debugfs_pdev);
>  	ar->debug.debugfs_pdev_symlink = NULL;
> +	ar->debug.debugfs_pdev_symlink_default = NULL;
>  	ar->debug.debugfs_pdev = NULL;
>  }
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 553ec28b6aaa..c2b747f1b9f5 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -15065,6 +15065,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_hw_group *ag,
>  		ar->hw_link_id = pdev->hw_link_id;
>  		ar->pdev = pdev;
>  		ar->pdev_idx = pdev_idx;
> +		ar->radio_idx = i;
>  		pdev->ar = ar;
>  
>  		ag->hw_links[ar->hw_link_id].device_id = ab->device_id;
> @@ -15132,7 +15133,6 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
>  		if (!ab)
>  			continue;
>  
> -		ath12k_debugfs_pdev_create(ab);
>  		ath12k_mac_set_device_defaults(ab);
>  		total_radio += ab->num_radios;
>  	}
> 
> base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


