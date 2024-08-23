Return-Path: <linux-wireless+bounces-11869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CF195D4E4
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 20:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5111F22FFF
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50578191499;
	Fri, 23 Aug 2024 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iuNFuf5v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3441918BBB9;
	Fri, 23 Aug 2024 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436610; cv=none; b=bUSpdEiBup1wa361MPmARQmIRAOG0fyYROAo3w22p2ZMc3qrKtXQ1hElccWOHWgU38l0X34xNJSGiCGRvea/a13LGrk/Gnu7wLaiX2tgXC7qAl80Sex2keEAulr6um+s4BXRqwIK4enDdS/NZ6Yi/qN+XKdlEzws0/DuBMSPyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436610; c=relaxed/simple;
	bh=gD1pEko5Dng4/515untwuajMYraF0bj5us9lTSecl3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nV13VyE2eIgMBzlJYYdPEWiFprnlkTct15dpg0Jn/OBixXE5CvuZr2NJZq7oD5A2QN8qdgS1A/chy1K61iERWOzqCj+4RDRoK5omvRRgTIyEp8bKhE0vt/NiTUQGe0DuyVH2I+n44Xw1RhfeSrhXEd61FtOdvs+Se0GvtZ7h2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iuNFuf5v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NAbhNr006699;
	Fri, 23 Aug 2024 18:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ULYQELyVUyWgHfDeuJJCwuYVuaLB/jXSe8cof8/NKCg=; b=iuNFuf5vKc+4W+UH
	yl7J1ef4WDEF4ofV7+IrdeV4dfsZk8KhoDl+rMTtusynM2jnn9xol0cQG62CTWyy
	VPlbiY+34koZXmkDyjwuIoJrwT4n4izcPgQFaDmtSlWpu/dgLRHkb04NvHtfXPkT
	73ssfNwdepgkFFupA4gnGRLCL3mJNJncS3Ry8QwoDdRVbV0AU51LJB0cOXp1mZgf
	5aP4pkfX3vuCPAoJAfAjU3SJhvvQ4anlSQHDYJeKc54EFAYMa71FI8rBKgFIWom1
	71cdiRrgfJa2g21YHJW2RDtT1ktIzaew6FAWgg9rI0Swg+Zj5jY02YRriJVgAlwa
	9mt7FA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 415bkwgsbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 18:09:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47NI9wSF029057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 18:09:58 GMT
Received: from [10.111.180.26] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 23 Aug
 2024 11:09:58 -0700
Message-ID: <2890dfef-bd0a-41df-b269-72bccead2046@quicinc.com>
Date: Fri, 23 Aug 2024 11:09:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: Set IRQ affinity hint after requesting
 all shared IRQs
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <kvalo@kernel.org>, <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
References: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
 <20240823155502.57333-2-manivannan.sadhasivam@linaro.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240823155502.57333-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ROxrMKPjdxDr5nLfShA7QOMwArct1_Bv
X-Proofpoint-GUID: ROxrMKPjdxDr5nLfShA7QOMwArct1_Bv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_14,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230134

On 8/23/2024 8:55 AM, Manivannan Sadhasivam wrote:
> If a shared IRQ is used by the driver due to platform limitation, then the
> IRQ affinity hint is set right after the allocation of IRQ vectors in
> ath11k_pci_alloc_msi(). This does no harm unless one of the functions
> requesting the IRQ fails and attempt to free the IRQ. This results in the
> below warning:
> 
> [   29.804276] ath11k_pci 0000:01:00.0: failed to power up mhi: -110
> [   29.810564] ath11k_pci 0000:01:00.0: failed to start mhi: -110
> [   29.816566] ath11k_pci 0000:01:00.0: failed to power up :-110
> [   29.847202] ath11k_pci 0000:01:00.0: failed to create soc core: -110
> [   29.853735] ath11k_pci 0000:01:00.0: failed to init core: -110
> [   29.859745] ------------[ cut here ]------------
> [   29.864486] WARNING: CPU: 7 PID: 349 at kernel/irq/manage.c:1929 free_irq+0x278/0x29c
> [   29.872529] Modules linked in: snd_soc_hdmi_codec ath11k_pci(+) venus_dec venus_enc ath11k videobuf2_dma_contig videobuf2_memops nb7vpq904m lontium_lt9611uxc mcp251xfd mac80211 can_dev libarc4 hci_uart
>  btqca btbcm ax88179_178a usbnet option leds_qcom_lpg usb_wwan led_class_multicolor usbserial crct10dif_ce qcom_pmic_tcpm tcpm venus_core aux_hpd_bridge qcom_spmi_adc_tm5 v4l2_mem2mem qcom_pon qcom_spmi_a
> dc5 videobuf2_v4l2 bluetooth videobuf2_common msm qcom_spmi_temp_alarm rtc_pm8xxx qcom_vadc_common ocmem snd_soc_sm8250 gpu_sched snd_soc_qcom_sdw videodev drm_exec phy_qcom_qmp_combo drm_display_helper s
> nd_soc_qcom_common qcom_stats mc i2c_qcom_geni llcc_qcom spi_geni_qcom drm_dp_aux_bus aux_bridge icc_bwmon typec qcom_rng coresight_stm coresight_tmc coresight_replicator stm_core coresight_funnel soundwi
> re_qcom qrtr pci_pwrctl_pwrseq qcrypto pci_pwrctl_core soundwire_bus snd_soc_lpass_va_macro pinctrl_sm8250_lpass_lpi snd_soc_lpass_wsa_macro authenc lpass_gfm_sm8250 coresight slimbus pinctrl_lpass_lpi
> [   29.872610]  snd_soc_lpass_macro_common qcom_q6v5_pas libdes qcom_pil_info qcom_q6v5 qcom_sysmon qcom_common pwrseq_qcom_wcn qcom_glink_smem mdt_loader pwrseq_core icc_osm_l3 qmi_helpers qcom_wdt socin
> fo display_connector drm_kms_helper cfg80211 rfkill fuse drm backlight ip_tables x_tables ipv6
> [   29.990067] CPU: 7 UID: 0 PID: 349 Comm: (udev-worker) Not tainted 6.11-rc4 #50
> [   29.997564] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> [   30.004446] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   30.011591] pc : free_irq+0x278/0x29c
> [   30.015355] lr : free_irq+0xb4/0x29c
> [   30.019030] sp : ffff800081f236e0
> [   30.022441] x29: ffff800081f236e0 x28: ffff64630d260000 x27: ffffd8d89a8c3458
> [   30.029764] x26: ffff64630d26ac00 x25: 00000000000000d6 x24: ffff6463029c58dc
> [   30.037086] x23: ffff6463029c5990 x22: ffff64630d261c58 x21: 0000000000000000
> [   30.044408] x20: ffff646301431c00 x19: ffff6463029c5800 x18: 0000000000000010
> [   30.051730] x17: 0000000000010108 x16: ffffd8d8f1d8b840 x15: 0763072007740769
> [   30.059051] x14: 000000000000030d x13: ffff646306b35ae8 x12: ffffd8d8f3852b80
> [   30.066374] x11: ffff646306b356c0 x10: 0000000000000000 x9 : 00000000000000d6
> [   30.073696] x8 : 000000000000000f x7 : 1fffec8c605626a1 x6 : ffffd8d8f2e602b8
> [   30.081017] x5 : 0000000000000030 x4 : ffff646302b13580 x3 : ffff646301431c98
> [   30.088339] x2 : 0000000000200880 x1 : ffff646301431c00 x0 : ffffd8d8f2b2c1b8
> [   30.095662] Call trace:

refer to:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages

per that guidance can we remove the "distracting information like timestamps, module lists, register and stack dumps"

removing the module list will fix the checkpatch issue:
WARNING:TYPO_SPELLING: 'fo' may be misspelled - perhaps 'of'?

> [   30.098183]  free_irq+0x278/0x29c
> [   30.101595]  ath11k_pcic_free_irq+0x70/0x10c [ath11k]
> [   30.106800]  ath11k_pci_probe+0x800/0x820 [ath11k_pci]
> [   30.112081]  local_pci_probe+0x40/0xbc
> [   30.115934]  pci_device_probe+0x1d4/0x1e8
> [   30.120049]  really_probe+0xbc/0x268
> [   30.123727]  __driver_probe_device+0x78/0x12c
> [   30.128204]  driver_probe_device+0x40/0x11c
> [   30.132505]  __driver_attach+0x74/0x124
> [   30.136445]  bus_for_each_dev+0x78/0xe0
> [   30.140383]  driver_attach+0x24/0x30
> [   30.144059]  bus_add_driver+0xe4/0x208
> [   30.147910]  driver_register+0x60/0x128
> [   30.151849]  __pci_register_driver+0x44/0x50
> [   30.156238]  ath11k_pci_init+0x2c/0x6c [ath11k_pci]
> [   30.161242]  do_one_initcall+0x70/0x1b8
> [   30.165182]  do_init_module+0x5c/0x1f0
> [   30.169034]  load_module+0x19f0/0x1abc
> [   30.172884]  init_module_from_file+0x88/0xc8
> [   30.177273]  __arm64_sys_finit_module+0x1c4/0x2b0
> [   30.182102]  invoke_syscall+0x44/0x100
> [   30.185953]  el0_svc_common.constprop.0+0xc0/0xe0
> [   30.190783]  do_el0_svc+0x1c/0x28
> [   30.194196]  el0_svc+0x34/0xdc
> [   30.197335]  el0t_64_sync_handler+0xc0/0xc4
> [   30.201635]  el0t_64_sync+0x190/0x194
> [   30.205399] ---[ end trace 0000000000000000 ]---
> [   30.432731] ath11k_pci 0000:01:00.0: probe with driver ath11k_pci failed with error -110
> 
> The warning is due to not clearing the affinity hint before freeing the
> IRQ.
> 
> So to fix this, let's set the IRQ affinity hint after requesting all the
> shared IRQ. This will make sure that the affinity hint gets cleared in the
> error path before freeing the IRQ.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Cc: Baochen Qiang <quic_bqiang@quicinc.com>
> Fixes: e94b07493da3 ("ath11k: Set IRQ affinity to CPU0 in case of one MSI vector")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Actual patch LGTM but I want Baochen to give a Reviewed-by before I ack

