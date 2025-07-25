Return-Path: <linux-wireless+bounces-26012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C52B11709
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 05:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76E21CE0041
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jul 2025 03:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D18319F420;
	Fri, 25 Jul 2025 03:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B9epV11F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248086329
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 03:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753413947; cv=none; b=GhTtZh0bM6GTRGSAGxEmE89sp/IPVJHexLItY14o0BStcrI0wavBCappgr3CH0xLt1IzLztruo0Py+t/b5NDDE9xs7WSjbrvwgz8sYwPbmy8S+TObZOuteHvnFje1pOFIfoHidaqgA565aUxJnf9p0O7KkXSMGfXnPd1Iyv/dZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753413947; c=relaxed/simple;
	bh=hQXtE3eLy1FPwQC1a/YorlNMz8N3y0ApF5Yms7jdIjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgLSk46W6kgD3WH9u/7EauSb7LwdQ/BvJqWtQI8a9wlTE9VhYr1Um6xUIJSBBdQgs4GZWJgHPydLALvzMbrXYQ5N2ygKJpV6m+cQkr/1d91w3sU5duCiKcX8tpGeLaBvqj+k8beUpZOb0fAlKGgA3qP4ibtQLQCXWVq+2n8vSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B9epV11F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLn8uP025956
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 03:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gAgCxVEFH4EwgekZ7jqlaF3NdXCGkoGWDEW1KVwMxh8=; b=B9epV11FfCQV+COt
	gJAr7LOIZ4aRCYBQTj8saWj3U8Y0OR55jUoP1WBW+SvDp76jxvLMlTEe6NG0q7Ry
	Wi9xl79T9HVthEeFdiKAnXuujjzon6l7O6WgeQyqJqOr35+Jb3ZbgTZZ3b0hdLFK
	7rSMc46i6wgDeRRxviG0fGrZvyX7GAMxLWyBZBT+4y1IzAzAtoSPf7oGaZNMQK62
	o/v4gCXs9WDQTk5UNomjUKrP9IfXYpGSckILUkKYL8qVVryQHRDqNgi3vAIjgRD2
	ERh5oxK3m/6jABvHbDrd26Z0my3QBQqAG2gM5KZ86mQbbo7O6Az0Ac8igtvRe8Mu
	en1y9g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w30rmeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 25 Jul 2025 03:25:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74d12fa4619so1543249b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 20:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753413942; x=1754018742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAgCxVEFH4EwgekZ7jqlaF3NdXCGkoGWDEW1KVwMxh8=;
        b=bNq0qN/Fpp4b4qqPvKATUaoQx2wkbKDetdHrCn/rgk3YVOe/aD0ChxsXWxGmalbxgn
         lfGt2TB0Ps/oU5HA7daGC360wBiZefBLx4zyLcVLiuZmUFh8f2NbiZk2vvyLz2CT6d8J
         3r2E40jHMUFr5tV891zg3Lf6ko5biU/thn/yS0bJzVbTj8FYZqdZTFafwW279FPnJLOW
         llDttmBpKONALcrITjt6x1My87cljS5Xn6VQK1O3AFAKr2WbZ8Fy2IpTEH2e7yBgwT4D
         zMDum6rzSSHzUaF37RkqUxUBTEGp2PhsAc1Lh4YaN/CrZWHAPZNC7tA+kHdYW37UBKbD
         QBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVXOdcl84neYl5xqycRzPJrdQBVf6CcbucBPc1GjCf4BZFFoNnJCaWCge7Z4X35Q/nx6/CTZKxDyrbtI5e4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+ZLyIqUIE6Z/9WL/B7SFZyu3ujVReviE6Ct7usgs3NoAlG8m
	5pm8UXsqds6v1pjx10fU/NKHxjRMCKkVj0Tpj9F1Q1hBMUfPJEvFYRVXnvU1mv3vFl5KS8plK4Q
	3zwWpX1WbaOKdMal0ZqmwoLNoQZjsOSPFTf0MLxExJGuWAZG2VKffNrSc2yj/5YD+W5lniNXV/a
	w7MQ==
X-Gm-Gg: ASbGncsTHZELWU17qn+ciYRA2BX418AKtTgmmQUewXRs99qp+iPRfCcjKcey8iw7z6m
	p0EUALi03KjAsQq8N6KrZoc3+SOkAEsXy8v77dF/G66+ID4V70e7p9Qn1kdRciRHhQhVFUMHVL2
	qqoGC3mNAxLDSoamHDEV0KpPCmPQrD616TDfzWdncpuM1s2DUz+hySh1rd7e9L/kM9Oe9wZZRF+
	54sEOs1VHH8HpIu4KJOMyTro93buJM5kFUT8PTTFTxqSzxj711yPH+Pkl0GMDy1RbbOxFb42I0w
	Ry1G46c9WTuLkOCrBFuRmj0QEAXjZ7lip7BLN83eChjTtXH4kdCqXPl0Ix5yp/JcgsxZp8+fhX4
	nfJYtv5HnHeR3ZLArpDSYMlCOZ9JzMY0=
X-Received: by 2002:a05:6a00:13a8:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-763382d6fbcmr607455b3a.11.1753413942280;
        Thu, 24 Jul 2025 20:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHncZoW5RENbDvszxFyfWEajWqb1Oi9KTnRhml7Lt1AqE/V3LJWkfgGNgBvnGH1vpwvtqghiQ==
X-Received: by 2002:a05:6a00:13a8:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-763382d6fbcmr607426b3a.11.1753413941794;
        Thu, 24 Jul 2025 20:25:41 -0700 (PDT)
Received: from [10.133.33.68] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b0622bedsm2770417b3a.120.2025.07.24.20.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 20:25:41 -0700 (PDT)
Message-ID: <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 11:25:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
To: balsam.chihi@moment.tech, linux-wireless@vger.kernel.org
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250611164004.38580-1-balsam.chihi@moment.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WtArMcfv c=1 sm=1 tr=0 ts=6882f938 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7G27ipKfusndooSKQysA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 5O0gPOmWszK9euCMEC6gKUI1u_CiW-T_
X-Proofpoint-ORIG-GUID: 5O0gPOmWszK9euCMEC6gKUI1u_CiW-T_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAyNSBTYWx0ZWRfXwz2PErb0ZLfd
 Q/jowCen/Awx/J3Lwqcb8yR7VbmDod3u2DsvdVKWecW1JY5bQgbgyVtCwgFcV1MpGCvLeY6pn58
 QAVvWuYTyX2vvVfok9yJZiTy3l9ruLKi3qbsNk1c4SLKwayfSl8DAnBA2B+kcpiRWBRnuQVrG6X
 MvRGnfVL3iS6J0tOBGhTVJKq0KXnjNTGgSN6F4fOC0qj0hhJ82Bw+9CIW76xPMU1aPmK2dsA2lq
 gpEbCHhXZwuFeV+p+BlF/b7pqoKJSb1dNwtgz08Z8GCuYrMFbjOg1Qown92Dg6ei5ARJbB5BE/a
 lMIV9+XCAxjcVNwUeh/IV61By4AHCZ129uvOkEyAIhzLMKI4cltVyoTJyh8gStbC1AHz/CMh1eq
 BCPORGvtgbApfHFOdKydKWJ8kH/BNrUZsunN99MrVOfyI+OvYhq2DBWss7f6l5s1x2xkmv+T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250025



On 6/12/2025 12:40 AM, balsam.chihi@moment.tech wrote:
> From: Balsam CHIHI <balsam.chihi@moment.tech>
> 
> During system reboot or module removal (rmmod), a crash was observed
> due to a synchronous external abort caused by invalid register access
> in ath11k_pci_clear_dbg_registers(). This happens when the device is
> already powered off and the driver attempts to read debug registers.

What does 'powered off' mean exactly here? is WLAN powered by an internal/external supply
that will be removed during rmmod/reboot?

> 
> The crash log shows:
> root@OpenWrt:~# reboot
> [  343.663492] Internal error: synchronous external abort:
> 0000000096000210 [#1] SMP
> [  343.670992] Modules linked in: [...]
> [  343.842432] CPU: 7 PID: 9435 Comm: procd Tainted: G O 6.6.86 #0
> [  343.849746] Hardware name: LS1088A
> [  343.856969] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  343.863933] pc : ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]

I don't see any relationship between ath11k_pci_clear_dbg_registers() and this PC pointer.
So how did you locate the problematic register access then?

> [  343.870125] lr : ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
> [...]
> [  343.950800] Call trace:
> [  343.953241]  ath11k_pci_get_msi_irq+0x18a0/0x1900 [ath11k_pci]
> [  343.959080]  ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
> [  343.964671]  ath11k_pcic_read32+0x30/0xb4 [ath11k]
> [  343.969477]  ath11k_pci_get_msi_irq+0x528/0x1900 [ath11k_pci]
> [  343.975230]  ath11k_pci_get_msi_irq+0x1460/0x1900 [ath11k_pci]
> [  343.981068]  ath11k_pci_get_msi_irq+0x1750/0x1900 [ath11k_pci]
> [  343.986906]  pci_device_shutdown+0x34/0x44
> [  343.991004]  device_shutdown+0x160/0x268
> [  343.994928]  kernel_restart+0x40/0xc0
> [  343.998594]  __do_sys_reboot+0x104/0x23c
> [  344.002518]  __arm64_sys_reboot+0x24/0x30
> [  344.006529]  do_el0_svc+0x6c/0x100
> [  344.009931]  el0_svc+0x28/0x9c
> [  344.012986]  el0t_64_sync_handler+0x120/0x12c
> [  344.017344]  el0t_64_sync+0x178/0x17c
> [  344.021009] Code: f94e0a80 92404a73 91420273 8b130013 (b9400273)
> [  344.027102] ---[ end trace 0000000000000000 ]---
> 
> This patch adds a `power_on` flag to conditionally skip debug register
> reads when the device is not powered, preventing invalid memory access.

why is only 'read' concerned here?

You are skipping several 'read' in this change, could you help narrow down which
individual read instance causes this?

> 
> With this change, the system no longer crashes on reboot or rmmod,
> and the driver continues to function correctly when reloaded.
> 
> Tested-on: QCN9074 hw2.0 PCIe on LS1088A
> Tested-on: OpenWrt 24.10.1
> Fixes: crash on reboot/rmmod due to invalid register access
> Signed-off-by: Balsam CHIHI <balsam.chihi@moment.tech>
> ---
>  drivers/net/wireless/ath/ath11k/pci.c | 36 ++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index 78444f8ea153..0c1b55957557 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -203,16 +203,18 @@ static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
>  		ath11k_warn(ab, "link down error during global reset\n");
>  }
>  
> -static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
> +static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab, bool power_on)
>  {
> -	u32 val;
> +	if (power_on) {
> +		u32 val;
>  
> -	/* read cookie */
> -	val = ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
> -	ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%x\n", val);
> +		/* read cookie */
> +		val = ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
> +		ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%x\n", val);
>  
> -	val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> -	ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
> +		val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> +		ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
> +	}
>  
>  	/* TODO: exact time to sleep is uncertain */
>  	mdelay(10);
> @@ -223,14 +225,18 @@ static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
>  	ath11k_pcic_write32(ab, WLAON_WARM_SW_ENTRY, 0);
>  	mdelay(10);
>  
> -	val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> -	ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
> +	if (power_on) {
> +		u32 val;
>  
> -	/* A read clear register. clear the register to prevent
> -	 * Q6 from entering wrong code path.
> -	 */
> -	val = ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
> -	ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", val);
> +		val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
> +		ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
> +
> +		/* A read clear register. clear the register to prevent
> +		* Q6 from entering wrong code path.
> +		*/
> +		val = ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
> +		ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", val);
> +	}
>  }
>  
>  static int ath11k_pci_set_link_reg(struct ath11k_base *ab,
> @@ -368,7 +374,7 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
>  	}
>  
>  	ath11k_mhi_clear_vector(ab);
> -	ath11k_pci_clear_dbg_registers(ab);
> +	ath11k_pci_clear_dbg_registers(ab, power_on);
>  	ath11k_pci_soc_global_reset(ab);
>  	ath11k_mhi_set_mhictrl_reset(ab);
>  }


