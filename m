Return-Path: <linux-wireless+bounces-34321-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCsqBmdHz2luuwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34321-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 06:51:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E212390FC0
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 06:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D881A301A780
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 04:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B03630C35F;
	Fri,  3 Apr 2026 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JkKoAt4m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YytMETsA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871317081A
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775191907; cv=none; b=o6aUZd4kSvosuEp1X1QbiTvZmV6WxSUmwUxYt3b/x9d9kxI4370g2laTX6btzb3YdnEFiyOCQATvt1TLtowjrCxoQghGsCfKYiubnQae0osk70Gb2ZCk0XNyU5WA0Zkyup4Ub1WlonQFWUP87775AwGpq7kh+e3VSOB63fCNfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775191907; c=relaxed/simple;
	bh=4D6ePz4Hq88HcwX2Ji+Kmw9BNGtUwVuoQ9qLJY3qrOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8WsB8ntZD+3N7YByxgT3VFV4KPgeJN8TNi26WpsCdxLUmJuXClZVnHSZrKAj/endloU086LS84hBPz4LAaVywgq5SdsLwOH19kxEMGMEjQAuMyc571CrBrIuc6lHMAiPMTa1bOlUKXUj7JEQlGmNNI3JBQoYYXUxucWaTQX9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JkKoAt4m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YytMETsA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6332H4IO2528256
	for <linux-wireless@vger.kernel.org>; Fri, 3 Apr 2026 04:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tu61AyGnBgVejknoekX3DnvPA8bTJAUFSOc67PDNgPg=; b=JkKoAt4m4oyzZY/q
	Yl8dx5N8/FrAIBIZEVtwt7JLJpIN6C0YEXR/81VCPRt23Av6y+n2B1sXtNuJNayS
	bIGmeTpygv+XU4OrvPkwsUGUthsD6LYjvyyhcVvEV2cxch4uCm8v9mTb/cqLDszc
	4KULkGHbvDsRJw3AOMNNTHrK6FxDEAXTbchTBhp8EElESA2Wufo0hfYjroZs98e6
	0LvaghURFs4zwRi7NwQrn9PJnyuDnIyICmTQ05lelHNr6mR8e+eyA2n0X3P3EQCR
	5ZB2TG29QdK9rJO/W2gL4vK/vV4ycLkAq1Zgd/d3a9iOoLAjEVofPwcmLEFjMmH8
	SkdOWA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9txca7u7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 04:51:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35d9467e85aso1427807a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2026 21:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775191905; x=1775796705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tu61AyGnBgVejknoekX3DnvPA8bTJAUFSOc67PDNgPg=;
        b=YytMETsA0neuPPSMByu4nxbSJPX+Vo13LSNJMAISp4RyCY15rAmJsJFmasv47W7G9U
         uLh47d4kziGU4yhOjTAgKvH8zSJWrtCP5TeaTZUHIigAgsupvV6vPt6mc+zAUNaSmDEz
         PPEM+pSYS7HvJaDOFsxuPzRCL7WnFuCRhPuOyDkGa13OPEvTB+9tdk3dIxfNmLStHP95
         pujBXtKRuDZu1Vp4rBaLxW+xywok4XbCkK2IrXjZOoQuUGpAl6Vr0xOETuoocyawUUY7
         AHsm+YxPF4x6vmsqfz/Zz8URIWQt0KiAh4guQBLWvHLuoQcnjBmOErcrSwgGHDXNaZTV
         eZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775191905; x=1775796705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tu61AyGnBgVejknoekX3DnvPA8bTJAUFSOc67PDNgPg=;
        b=pavPF5e5ujZ2vr6gmKtpIKJpkewMZV3HR+r7XY1Ogen4RiP3wC/e3n2XQsG9qliOVz
         Q3U90G9GmcMogzxZvfpnO/MlIMkkyQg/dP0NvVfw1J2WWMRnmJa6bhr2ivv+kkQOEKlw
         oyEPfKWXzUi3mrY2zUhXnbSoR04sMd7f+CQy4NCWJi+eC58S2A6jFoG99bQ4Exac1uiy
         bsxSjJa7DhqnMp8NYoU4uFmLY8UDrlm3LGRpTqasCqnmU5pFGiABaaSdXCkIXSwrgkUH
         ZvFdrkWwoAEzBtP/qP6DaqBT/BxRHYU0uFXaCgOMf+FiJu/aH/2pdmGAy9bSiEOr4qCH
         KUnw==
X-Gm-Message-State: AOJu0Yy6luAZ+l35iPGHPwPFz2Z+ARztOgINUnEDmxfRmq0yy3dfsTTy
	tALZs10f8JaTCp/AL0zgELgHZgZy1MUv/vQaPCdmpPY04VljlnBG7Vhb5wn5HYeQ1b98CtKCICw
	A+INszokX/pNrVY3NdUO1xrgek04TyiE/g+D/A3UI2HZE5GBkHTs35TfSK+/vKYJzqxSroBYn+M
	xCSg==
X-Gm-Gg: ATEYQzxjQ4kTqbMz/ZnZsDc8L0QKl7WZ5FMOMnOD1AhrbL0seGQoPMgYVmq3S+21rC4
	Q5oCeeo8Hd9YxDyX+Ai2MX9otq8Z6rJdlkBXruF3C68zbyEOvQNc2wP8a1jRccac9499q+mBYCZ
	6YP3UVi4H/cAeKjLNDe7TfbPewrI7P1yTYyqTfySfUpliB033u1LfoHIK8Ak+L1BtjRo0d2OGNn
	taA5Swz93/QQo9oA8NvMfzIYJJM6azIqg1YmBWZ0dOcuDQYd0xXVv6URhkc1Z4ZuezH+Y+Wc7aT
	KoV2S+j6VMvd75Gf1R/9aW4k0WAPNqyxCgjpW7MvHORQV6upKDi5dPFfFbfueFnTw0urQQF0+yE
	wwc2tWWnePZjTEV1bSwg304ufmJ98oUSw9yIAhapzUS1Y9Zy1XQPN5wcfsKrWmw==
X-Received: by 2002:a05:6a20:7d8a:b0:398:9c94:2033 with SMTP id adf61e73a8af0-39f2ef837acmr1535111637.11.1775191904700;
        Thu, 02 Apr 2026 21:51:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d8a:b0:398:9c94:2033 with SMTP id adf61e73a8af0-39f2ef837acmr1535077637.11.1775191904138;
        Thu, 02 Apr 2026 21:51:44 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b6113dsm4258227b3a.23.2026.04.02.21.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 21:51:43 -0700 (PDT)
Message-ID: <8588fd02-55a2-482d-87f4-1db8e696bad0@oss.qualcomm.com>
Date: Fri, 3 Apr 2026 10:21:40 +0530
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
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260402051402.3903795-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GKONE5thS6jDCvdUcskvP8c2lgtYunBx
X-Proofpoint-ORIG-GUID: GKONE5thS6jDCvdUcskvP8c2lgtYunBx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA0MCBTYWx0ZWRfXyzXzSNSU0TFO
 DX4+GmTCwEiO6oYR2oN+4Sm31uneOF/K7XrFFCVfVyELjCqaQVozhxa1SU13FaKQ48Hy4FoijI1
 ba9Us/eYIR8XunthetNFKtHcYIUzdw2x6lR1s2djPKH6Y9B2f/2D8b7wmLyUpJw9DOmQ8QZ2Tx1
 BkTSOXOwcHw9ZGQ6M725xmaee8myP2rdBIlX9rmzOu0c+EwD3tKOHAmL0AncxBRux9unRJKfOjf
 IHsayu46vqxWr76vZJJ7MalWaZKAmCfF86jXibs1a+87Yf8cSxjBn5R3mOqlzHjlejz5XVtuNxY
 e4g3p0CpvWhJ2C0+R6q57XS5oJEtwsdN9Hxp/shDM3n3wwd3tCHAEuttRPsOZdxFIk+rH1u01lv
 lqHnPIz3aHsvOB+A6afIo0zSL34FqRVzulHOItp5OgnvKCwGlKw+7wax3EUu3wlFAlJpeoHSq+q
 JQWKlGT2inzvTyA78ZA==
X-Authority-Analysis: v=2.4 cv=HKXO14tv c=1 sm=1 tr=0 ts=69cf4761 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=lxJo2wgQVOyoRhA3UyYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_01,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030040
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34321-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9E212390FC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/2/2026 10:44 AM, Roopni Devanathan wrote:
> In single-wiphy design, when more than one radio is registered as a
> single-wiphy in the mac80211 layer, the following warnings are seen:
> 
> 1. debugfs: File 'ath12k' in directory 'phy0' already present!
> 2. debugfs: File 'simulate_fw_crash' in directory 'pci-0000:57:00.0' already present!
>     debugfs: File 'device_dp_stats' in directory 'pci-01777777777777777777777:57:00.0' already present!
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
>   drivers/net/wireless/ath/ath12k/core.c    |  4 ++--
>   drivers/net/wireless/ath/ath12k/core.h    |  2 ++
>   drivers/net/wireless/ath/ath12k/debugfs.c | 29 +++++++++++++++++++----
>   drivers/net/wireless/ath/ath12k/mac.c     |  2 +-
>   4 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index c31c47fb5a73..2519e2400d58 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -835,8 +835,6 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
>   		goto err_qmi_deinit;
>   	}
>   
> -	ath12k_debugfs_pdev_create(ab);
> -
>   	return 0;
>   
>   err_qmi_deinit:
> @@ -869,6 +867,8 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
>   		goto err_dp_pdev_free;
>   	}
>   
> +	ath12k_debugfs_pdev_create(ab);
> +
>   	return 0;
>   
>   err_dp_pdev_free:
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 59c193b24764..046249c8763e 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -588,6 +588,7 @@ struct ath12k_dbg_htt_stats {
>   struct ath12k_debug {
>   	struct dentry *debugfs_pdev;
>   	struct dentry *debugfs_pdev_symlink;
> +	struct dentry *debugfs_pdev_symlink_default;
>   	struct ath12k_dbg_htt_stats htt_stats;
>   	enum wmi_halphy_ctrl_path_stats_id tpc_stats_type;
>   	bool tpc_request;
> @@ -673,6 +674,7 @@ struct ath12k {
>   	u8 pdev_idx;
>   	u8 lmac_id;
>   	u8 hw_link_id;
> +	u8 radio_idx;
>   
>   	struct completion peer_assoc_done;
>   	struct completion peer_delete_done;
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
> index 358031fa14eb..8c81a1c22449 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs.c
> @@ -1473,18 +1473,35 @@ void ath12k_debugfs_register(struct ath12k *ar)
>   {
>   	struct ath12k_base *ab = ar->ab;
>   	struct ieee80211_hw *hw = ar->ah->hw;
> -	char pdev_name[5];
> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
> +	struct dentry *ath12k_fs;
>   	char buf[100] = {};
> +	char pdev_name[5];
>   
>   	scnprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
>   
>   	ar->debug.debugfs_pdev = debugfs_create_dir(pdev_name, ab->debugfs_soc);
>   
>   	/* Create a symlink under ieee80211/phy* */
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
>   	if (ar->mac.sbands[NL80211_BAND_5GHZ].channels) {
>   		debugfs_create_file("dfs_simulate_radar", 0200,
> @@ -1513,7 +1530,9 @@ void ath12k_debugfs_unregister(struct ath12k *ar)
>   
>   	/* Remove symlink under ieee80211/phy* */
>   	debugfs_remove(ar->debug.debugfs_pdev_symlink);
> +	debugfs_remove(ar->debug.debugfs_pdev_symlink_default);
>   	debugfs_remove_recursive(ar->debug.debugfs_pdev);
>   	ar->debug.debugfs_pdev_symlink = NULL;
> +	ar->debug.debugfs_pdev_symlink_default = NULL;
>   	ar->debug.debugfs_pdev = NULL;
>   }
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 553ec28b6aaa..c2b747f1b9f5 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -15065,6 +15065,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_hw_group *ag,
>   		ar->hw_link_id = pdev->hw_link_id;
>   		ar->pdev = pdev;
>   		ar->pdev_idx = pdev_idx;
> +		ar->radio_idx = i;
>   		pdev->ar = ar;
>   
>   		ag->hw_links[ar->hw_link_id].device_id = ab->device_id;
> @@ -15132,7 +15133,6 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
>   		if (!ab)
>   			continue;
>   
> -		ath12k_debugfs_pdev_create(ab);
>   		ath12k_mac_set_device_defaults(ab);
>   		total_radio += ab->num_radios;
>   	}
> 
> base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c


Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>


