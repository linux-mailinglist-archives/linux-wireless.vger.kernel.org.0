Return-Path: <linux-wireless+bounces-38044-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +7RHAZCLO2obZggAu9opvQ
	(envelope-from <linux-wireless+bounces-38044-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 09:47:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D46BC495
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 09:47:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=EKNzaJAN;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=J3Kg7t3l;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38044-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38044-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7E1E300A66D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D752390CAB;
	Wed, 24 Jun 2026 07:47:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB93876CF
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 07:47:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287242; cv=none; b=UzbC44DLH5VP+Pclr24A3tkw/kTpVs6PZJ9j1YzrlFZK6r9PTE1ELk3jrvCSwQunQovVvIB/ts7hwxmq15hPHr7uY6kqz9lIo/iuBYfFn9nEXT2DwM1xQFebrVO7S6TIDlYbn6HPyHprJxf27WqNdj+R2H1IsY0E1k69ngb7ZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287242; c=relaxed/simple;
	bh=NGJ0rrweZjKkiD+Cmnu1kTCdyjyPjWp1z8L80XvPfko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIvXVvmSEdxZcWmOF05oY9EJjnA2d6RAiz1mtVNAjO9P4c58E3+SkJZ1AuUF8BL+BuCoUhLzn6E2E46WHUHtKAvYvGz6jh/pQZAnUjq1PGKoGZoW/Ck3hXlNr71mksB9gwT7mod2TsGQenukMCgNKvcC5c3So5ZjyumY04A2fTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EKNzaJAN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J3Kg7t3l; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5uBT82439078
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 07:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uyO/oxy6yOszauGRa3+ycH46BEmZ6m/DyI0yY1OAvNo=; b=EKNzaJANf1T/xYRC
	xJ23FK4GIyni/i9EsLzVYv9VTaMwY9Pra/uHTHJrR4ebZeA34TYUsXTBLKiTzHgE
	1QB5QnCQ5wLUlBa9n7Lxzocco9k2j6tKICXEqd6unBbUDA2WRzmwNUM4VRQYjL6G
	IHwWQrQ8C+Tea8a0tcKoco7M5YPYec8VLPW2ks6nVNkFs0MAB2kP33hqEzOHt2jv
	1pJAlpc0AJ2ItvsIXORTkOgq/9dzKlCfi0X19SHHXIL0djBFzIA1FRPHS50Ko4mc
	cRbiDneV2y911jfJsoCwRL2tV/6f1AXOx6nD5OdEYDmcYT45gpAV3wcVC5Vx5z7o
	EWBKxg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05ar158v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 07:47:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8422382178bso640888b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 00:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782287238; x=1782892038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uyO/oxy6yOszauGRa3+ycH46BEmZ6m/DyI0yY1OAvNo=;
        b=J3Kg7t3lkBwaNvnRXhD/awD1WoCl0uuhJWXnMeP73hEqn36qp5kMHK3yBVu1wnnI5G
         YU+IREPHxwjtXq9oteAa1+FUjPnP5+f71VtWYxhUhRVdSshdhvG+k1at7ZxVfbSL5qWK
         qGRTUyiAGrI3dO3d26I7OHeZfak3E0j2aVtpID+DYIWuT1KXTn5OXMAmJJg1A1/iS+my
         Rfc7tI/us5OlxNdxaKRm10/ukcoO2dfYGFlL0gagpse9HuIbMHwCKBucDBe23o3fqeon
         /9Ppa446wGJ8bYbHKNSHGCpIkjL89o+/RiTq7FNJEqKQYftVDM0CoFlqKiQvzUpAazEf
         5+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782287238; x=1782892038;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyO/oxy6yOszauGRa3+ycH46BEmZ6m/DyI0yY1OAvNo=;
        b=XHly90Vx4TD3+J+EAYp72CY6U5ujn25uiS2oMofgHQKVtwrqCB02d9qPDWilFsS12l
         XNRyQfESW597FMCvfCaqHc5NONBq7qf8a/BelOtOKg4wq4lXnhHEO+sDJzzinsfmEbVa
         zf8yoj9pnR07EEubFD5afxc6BFWv2LmVsZssLfNGg9Ig0/Do5EAB71WTSNBNoY4rHNkg
         yeaukvoAS4UYVui0cKohKjNxwkqlqzGtgFA4I1xttJHKoStPJ4LKJxoZ8FA7KJkoMyq7
         1u6XH0dwaBBEpzJdiSQjfQiS8ifTVrXVHnXq81Cp6CyTSuW9RBg2AAL2lgtxfJ+OpA/3
         bslg==
X-Forwarded-Encrypted: i=1; AFNElJ/ddqgy2pEhvF6Fn3XA9qCmPM2eFiNqAnpYA863t0OEiAVusc25SWWzK1llj8oxswMy5vVCMcq8xZt+YvtZag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0TM5OdF6sX94s5A5BudDZEjI4lN2LpDAsopYVDZB1iLEptqh
	rGMYJRnKjvxeMUlz+sTFK84CNUax1iv7pYXuq0KKCVOp5asvDDZU9yh/AQFk3YfhUePHS22kt5F
	3grXCTD5LLwCkSbKeDpyb4Oso/HXC1tElBM/V7F16YEtmLu+AkKNeNVDP0YN5baeaG4Mx4Q==
X-Gm-Gg: AfdE7clgHtLYTMhrokobMxFv5amer4YLDOJe3+YRuM7ieIIuk1VuyT1wmiGPwllz2Eb
	DJs84eWr/N/j8Z3aaLqyjrYeE9lrSVMRGM0Di73lUJTzfYnTUSaVR9aTjDtqImYIYlbNiRwnDih
	lY3fDLnYK2qVffJ9y+xV/MSV+TabONQ10P+33KT9KwR7LSHNdY0oiDxT1fRvQdKDbZg4oFQBaai
	7xT58pMiaGfl+Dt4uOLVNeZ8FwmRP/0GQarm6+IQM6HYiY/4ZXGxB+jk8NC4TKsHP8YZWc7EP5/
	Mjoz1KkGJZiXbBUwqKPy5d4I0QhGExXPezqnuWna+J+R+l73iJs2FVA8u10wYDl7R8qzwdpJx6f
	YbRdT97P5JqGKh43hzyMLW7aznWanWjv/ylz3zvgjR0lg7wwoHHEU8Axo3ntDmc79/fQ2UDS0Fj
	smWvTAUqgJ
X-Received: by 2002:a05:6a00:17a9:b0:841:edb9:4ea2 with SMTP id d2e1a72fcca58-845a2c58284mr3191056b3a.32.1782287238166;
        Wed, 24 Jun 2026 00:47:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a9:b0:841:edb9:4ea2 with SMTP id d2e1a72fcca58-845a2c58284mr3191019b3a.32.1782287237687;
        Wed, 24 Jun 2026 00:47:17 -0700 (PDT)
Received: from [10.133.33.165] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3feb775sm1345215b3a.20.2026.06.24.00.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 00:47:17 -0700 (PDT)
Message-ID: <4cdfb71b-2ef8-4985-8294-c4a29e37faa3@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 15:47:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] Add device-specific reset for Qualcomm devices
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, bhelgaas@google.com,
        alex@shazbot.org, mani@kernel.org
Cc: jjohnson@kernel.org, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, mhi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260623183115.1585273-1-jtornosm@redhat.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623183115.1585273-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: I3ePB2oFvsOjwpH2yIYu9oL3mCHy3w81
X-Authority-Analysis: v=2.4 cv=EuLiaycA c=1 sm=1 tr=0 ts=6a3b8b87 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=rq6MREiLanR6HC4oPXQA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX8/1hGfXAEcak
 ZVB5yguTNotCcjC7X5KGJN+q6NQem+bWl8mY2W1Qlcgp0C9xpsm8VUjqbvFtAm/lF4EcW7TJUwi
 Qu31FyzhvZXQGQYWPl7puhzchJ4sHr0=
X-Proofpoint-GUID: I3ePB2oFvsOjwpH2yIYu9oL3mCHy3w81
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfXyxxLE2m1rzms
 5nZT0uQIy+WFqeb2VqmB4pYqTCs9i3wfTeJ0q/wlANm8mmmwP+/Erflom7s3goXblEU1d5JiCG9
 2CLh2n0b54XAbTwmDKXs/yduuyLnYvuYO5Q6E/QUHT+1DbF9z3OrFZuYDAsh2EHTZxwxlHPXbjX
 DPjqn2N/1SGHQaxa8avINn6/NR8TxDg0/Nxuk2iAOowEbtw1qZxDm5vmtziwMvl2loR5kd13WJv
 GwyieKeeRQTmVMUcfilSSqQ+qd6zcNp1YpouCZdKFdXPyaZW9sx/HH8J3cyhtdg80Mvv/ie2XDo
 oWvvfqc1CcrFEOCuqDRsuQayqhD44NEAJ+b11a4ovWmrV8xB9SAUh0BFkykBs6skNLpQfejBBl+
 XLB2iO5xwt1zvTHZwIb026RRhce5PoNjnF/RatR85D2PiNdpfxImHMTpO2NCN6H3n6UikjpLeA2
 FFZlpuOCgl+7pbpPicA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240063
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38044-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:bhelgaas@google.com,m:alex@shazbot.org,m:mani@kernel.org,m:jjohnson@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE9D46BC495



On 6/24/2026 2:31 AM, Jose Ignacio Tornos Martinez wrote:
> Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems)
> lack working reset methods for VFIO passthrough scenarios. These devices
> have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
> broken bus reset.
> 
> The problem manifests in VFIO passthrough scenarios:
> 
> - WCN6855 (17cb:1103) and WCN7850 (17cb:1107) WiFi devices:
>   Normal VM operation works fine, including clean shutdown/reboot.
>   However, when the VM terminates uncleanly (crash, force-off), VFIO
>   attempts to reset the device before it can be assigned to another VM.
>   Without a working reset method, the device remains in an undefined state,
>   preventing reuse.
> 
> - SDX62/SDX65 (17cb:0308) 5G modems: Never successfully initialize even
>   on first VM assignment without proper reset capability.
> 
> Add device-specific reset methods using BAR-space hardware reset registers
> that exist in these devices:
> 
> - WCN6855/WCN7850 WiFi devices use SoC global reset via BAR0 (sequence from
>   ath11k/ath12k driver: ath11k_pci_soc_global_reset(), ath11k_pci_sw_reset(),
>   ath11k_mhi_set_mhictrl_reset()):
>   - Write/clear reset bit at offset 0x3008
>   - Wait for PCIe link recovery (up to 5 seconds)
>   - Clear MHI controller SYSERR status at offset 0x38
> 
> - SDX62/SDX65 modem devices use MHI SoC reset via BAR0 (sequence from MHI
>   driver: mhi_soc_reset(), mhi_pci_reset_prepare()):
>   - Write reset request to offset 0xb0
>   - Wait 2 seconds for reset completion
> 
> These are true hardware reset mechanisms (not power management or firmware
> error recovery), providing proper device reset for VFIO scenarios.
> 
> Testing was performed on desktop platforms with M.2 WiFi and modem cards
> using M.2-to-PCIe adapters, including extensive force-reset cycling to
> verify stability.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v10:
>   - Complete redesign based on maintainer feedback (Manivannan Sadhasivam,
>     Alex Williamson): use actual hardware reset registers from
>     device drivers instead of D3hot power cycling
> v9: https://lore.kernel.org/all/20260612142638.1243895-1-jtornosm@redhat.com/
> 
>  drivers/pci/quirks.c | 118 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 431c021d7414..8ad3f214e520 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4240,6 +4240,121 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>  	return 0;
>  }
>  
> +#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET	0x3008
> +#define QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V	BIT(0)
> +#define QUALCOMM_WIFI_MHISTATUS			0x48
> +#define QUALCOMM_WIFI_MHICTRL			0x38
> +#define QUALCOMM_WIFI_MHICTRL_RESET_MASK	0x2
> +
> +/*
> + * Qualcomm WiFi device-specific reset using SoC global reset via BAR0
> + * registers.
> + */
> +static int reset_qualcomm_wifi(struct pci_dev *pdev, bool probe)
> +{
> +	bool link_recovered = false;
> +	unsigned long timeout;
> +	void __iomem *bar;
> +	u32 val;
> +	u16 cmd;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (pdev->current_state != PCI_D0)
> +		return -EINVAL;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> +
> +	bar = pci_iomap(pdev, 0, 0);
> +	if (!bar) {
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +		return -ENODEV;
> +	}
> +
> +	val = ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);

QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET is beyond the first 4K bar area hence requires MHI
wakeup before accessing, see [1]. the wakeup callback for WCN6855 is
ath11k_pci_bus_wake_up() which calls mhi_device_get_sync(). Not sure how this can be done
here. Maybe Mani can provide some hints?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath11k/pcic.c#n216


> +	val |= QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V;
> +	iowrite32(val, bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +	ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +
> +	msleep(10);
> +
> +	val &= ~QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET_V;
> +	iowrite32(val, bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +	ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +
> +	msleep(10);
> +
> +	timeout = jiffies + msecs_to_jiffies(5000);
> +	while (time_before(jiffies, timeout)) {
> +		val = ioread32(bar + QUALCOMM_WIFI_PCIE_SOC_GLOBAL_RESET);
> +		if (val != 0xffffffff) {
> +			link_recovered = true;
> +			break;
> +		}
> +		msleep(20);
> +	}
> +
> +	if (!link_recovered) {
> +		pci_err(pdev, "PCIe link failed to recover after reset\n");
> +		goto out_restore;
> +	}
> +
> +	/* After SOC_GLOBAL_RESET, MHISTATUS may still have SYSERR bit set
> +	 * and thus need to set MHICTRL_RESET to clear SYSERR.
> +	 */
> +	iowrite32(QUALCOMM_WIFI_MHICTRL_RESET_MASK, bar + QUALCOMM_WIFI_MHICTRL);
> +	ioread32(bar + QUALCOMM_WIFI_MHICTRL);
> +
> +	msleep(10);
> +
> +out_restore:
> +	pci_iounmap(pdev, bar);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +
> +	return link_recovered ? 0 : -ETIMEDOUT;
> +}
> +
> +#define MHI_SOC_RESET_REQ_OFFSET		0xb0
> +#define MHI_SOC_RESET_REQ			BIT(0)
> +
> +/*
> + * Qualcomm modem device-specific reset using MHI SoC reset via BAR0
> + * register.
> + */
> +static int reset_qualcomm_modem(struct pci_dev *pdev, bool probe)
> +{
> +	void __iomem *bar;
> +	u16 cmd;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (pdev->current_state != PCI_D0)
> +		return -EINVAL;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> +
> +	bar = pci_iomap(pdev, 0, 0);
> +	if (!bar) {
> +		pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +		return -ENODEV;
> +	}
> +
> +	iowrite32(MHI_SOC_RESET_REQ, bar + MHI_SOC_RESET_REQ_OFFSET);
> +	ioread32(bar + MHI_SOC_RESET_REQ_OFFSET);
> +
> +	/* Be sure device reset has been executed */
> +	msleep(2000);
> +
> +	pci_iounmap(pdev, bar);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +
> +	return 0;
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -4255,6 +4370,9 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_chelsio_generic_dev },
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_qualcomm_wifi },  /* WCN6855 WiFi */
> +	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_qualcomm_wifi },  /* WCN7850 WiFi */
> +	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_qualcomm_modem }, /* SDX62/SDX65 modems */
>  	{ 0 }
>  };
>  


