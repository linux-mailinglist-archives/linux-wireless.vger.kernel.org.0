Return-Path: <linux-wireless+bounces-21953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DF2A9A0A4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 07:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC34444DAE
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 05:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B13FE7;
	Thu, 24 Apr 2025 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ney3IKpU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3332701B8
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745473929; cv=none; b=SUInF5yB6JqNOmwpT6FI2ifzCXzHf76QUam4FxJkA9324KXKk75Tshel8HLrc0xdhUtmByN94KYUmvNQgtIomcKqNs8p9I5WA5Us3xuOAXi8nZNAPrciFO0Y9lx+nly2fO17vyTRGkBt/MdZfOgj2DVd65qyKwdE3M8AJ6tuDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745473929; c=relaxed/simple;
	bh=pulX93AvWxSmNWA8PfmtOGNaDjubBQFWQzwkNSywNDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XXGU62x6U9KpSLcK7GBKl+3riASTQCcj+KoJvZ/jVoGN1Lh5A9HwmVo4j3AZzL/jVYFtzYiPrUd5SdWFWPod2tibcSTw4E/7y8ilayvwRCmFnm+YCMmNfwF3cFugzfQ58AI6ahWbvQpiliYnqXXV7Q1KErDEEuxaSAl26zNVK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ney3IKpU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0FEpU011414;
	Thu, 24 Apr 2025 05:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RVKAYRgRsCPe2jz13cTbtRdtfyuAuOPsPxJR3dzqW6c=; b=Ney3IKpUt6OnDYtp
	GfIg6tktLNVVAj5ojp6d4GmQJecCjXcp8dLahA9vH2OxWBwqPOp2cc6VUj1HaabP
	x/SecSAOXr5Ixc3StoZOeM6isDz4EYiICKAPTsKia30BSBy2UbeJr3Ycg2PfkJ6N
	NGc+TTCRUmESH/zd4NoAP01xhMltuTxS1m1/7HKxrH8duCJMoZXnjpQkBQkhhdyD
	8wY9LTfBerCAW/UDPgXwzJsSwr3z8w6ef57WccOxF3+NfldyHaqjNbF3D9wIbrEk
	XuRnq4KpdzaYdYJ1dMRytD4nn2Y0AOZMB4/3Da0gR0uN7EKdKA6xy5vLa1DYLliQ
	PiogaA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh24cd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 05:52:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53O5q15n017665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 05:52:01 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Apr
 2025 22:51:59 -0700
Message-ID: <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com>
Date: Thu, 24 Apr 2025 13:51:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
To: <balsam.chihi@moment.tech>, <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250416100939.282481-1-balsam.chihi@moment.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EtLSrTcA c=1 sm=1 tr=0 ts=6809d182 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=jtIo-V0p2nIdXHBmWg4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: K0_O3d10wGDbkVtJIW4EzkXgV9lilgiV
X-Proofpoint-ORIG-GUID: K0_O3d10wGDbkVtJIW4EzkXgV9lilgiV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAzNSBTYWx0ZWRfX/BC4liv1kO8y wdMwZFlMbrLeBjcuC4q25nympxWD5lJt/31QcV5tJ6zBnzZrYK9FCA0FvqpFmii4taDopoTUhIQ Fv7mtTjzNIbcFvLQaIbIoIeYX7mQd3SHwqI1RywlXbaeJ5H/6SfWxahs+V+XbKDhdfav0JGsaCI
 72uVwCK85FEWUXAbY2vbEgT9Puv1PeBOKeakqvzZa/rLFrxX07C9m+D1AwWN4hTgMEoNNEao+Ue 5YOwiCnjLn/NiTvynhwzqSuz28Tj5a0fr129XucTK3dHM+7HGccwwel4fy5kNEsFhhlrAvGDaSl nx1g2B4MIbYbgTaFYuJ7mtWJKB3r4QL0oKCalu0r5oBgPKI+oqsG+AHzIi/nbpNosy98iJYypdq
 PoGp3MjqItYusiZN5p4pHO+qQjI+Z7s5XdoMmHXy5hXHlQJJf2SP/992X4RE5kY99D6iwoFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240035



On 4/16/2025 6:09 PM, balsam.chihi@moment.tech wrote:
> From: Balsam CHIHI <balsam.chihi@moment.tech>
> 
> This patch addresses a crash issue that occurs when unloading the
> ath11k_pci driver with QCN9074 PCIe WiFi 6 modules.
> The crash is caused by the driver attempting to perform reset
> operations during unload, leading to a synchronous external abort

Do we know the root cause of the synchronous external abort?

> and kernel panic, as indicated by the error log:
> 
> [ 5615.902985] Internal error: synchronous external abort: 0000000096000210 [#1] SMP
> ...
> [ 5616.056382] CPU: 7 PID: 12605 Comm: procd Tainted: G O 6.6.73 #0
> ...
> [ 5616.069876] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 5616.076841] pc : ath11k_pci_get_msi_irq+0x18b4/0x1914 [ath11k_pci]
> [ 5616.083035] lr : ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
> [ 5616.163712] Call trace:
> [ 5616.166153] ath11k_pci_get_msi_irq+0x18b4/0x1914 [ath11k_pci]
> [ 5616.171993] ath11k_pcic_init_msi_config+0x98/0xc4 [ath11k]
> [ 5616.177583] ath11k_pcic_read32+0x30/0xb4 [ath11k]
> [ 5616.182391] ath11k_pci_get_msi_irq+0x528/0x1914 [ath11k_pci]
> [ 5616.188143] ath11k_pci_get_msi_irq+0x147c/0x1914 [ath11k_pci]
> [ 5616.193983] ath11k_pci_get_msi_irq+0x1764/0x1914 [ath11k_pci]
> [ 5616.199822] pci_device_shutdown+0x34/0x44
> [ 5616.203923] device_shutdown+0x160/0x268
> [ 5616.207847] kernel_restart+0x40/0xc0
> [ 5616.211512] __do_sys_reboot+0x104/0x23c
> [ 5616.215436] __arm64_sys_reboot+0x24/0x30
> [ 5616.219447] do_el0_svc+0x6c/0xfc
> [ 5616.222761] el0_svc+0x28/0x9c
> [ 5616.225817] el0t_64_sync_handler+0x120/0x12c
> [ 5616.230174] el0t_64_sy
> [ 5616.233839] Code: f94e0a80 92404a73 91420273 8b130013 (b9400273)
> [ 5616.239932] ---[ end trace 0000000000000000 ]---
> [ 5616.244547] Kernel panic - not syncing: synchronous external abort: Fatal exception in interrupt
> [ 5616.253343] Kernel Offset: disabled
> [ 5616.256827] CPU features: 0x0,00000000,00020000,1000400b
> [ 5616.262138] Memory Limit: none
> [ 5616.265188] Rebooting in 3 seconds..
> [ 5620.268926] Unable to restart system
> [ 5620.272503] Reboot failed -- System halted
> 
> The fix involves adding a conditional check for the power state before
> performing the reset operations in the ath11k_pci_sw_reset function.
> This ensures that the reset functions are only called when loading the driver,

The ath11k_pci_soc_global_reset() is called to make sure the device is in the expected
state, such that after machine restart, the device can be successfully enumerated. If
skipped, the chip may be not detected. At least this is the case for WCN6855, for others I
am not sure.


> preventing the crash during driver unload.
> 
> Signed-off-by: Balsam CHIHI <balsam.chihi@moment.tech>
> ---
>  drivers/net/wireless/ath/ath11k/pci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index 78444f8ea1535..b9c8963c17047 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -368,9 +368,12 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
>  	}
>  
>  	ath11k_mhi_clear_vector(ab);
> -	ath11k_pci_clear_dbg_registers(ab);
> -	ath11k_pci_soc_global_reset(ab);
> -	ath11k_mhi_set_mhictrl_reset(ab);
> +
> +	if (power_on) {
> +		ath11k_pci_clear_dbg_registers(ab);
> +		ath11k_pci_soc_global_reset(ab);
> +		ath11k_mhi_set_mhictrl_reset(ab);
> +	}
>  }
>  
>  static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)


