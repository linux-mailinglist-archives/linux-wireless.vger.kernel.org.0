Return-Path: <linux-wireless+bounces-34302-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Fh7FAzpzWkLjAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34302-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:57:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D75FB3834E1
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9548530B8CC7
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 03:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489235B634;
	Thu,  2 Apr 2026 03:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S1/LWTYZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fdZjSt9E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4C33F37A
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102068; cv=none; b=SRrNlvqbwPhlz3fy55BA2etpczDTSyouX7rkb+1pQKdolQ4EmbTHDsloGOcRsf9Lm4HYeGpjkdwmKuIGvBIx+izenRNZYFkgiHjkJYArdenDGXRgMOu7gNJAqQfI5zhncECVOLhzwN0rRYxYHO9Jcy8zmQ+wsStDPh4CZBDjles=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102068; c=relaxed/simple;
	bh=NwRUhlRAtpZ7mb+eclK2BJKeHhhHjFl+FadQlbqFxVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnuplCA7FCVZPrMQtUxcnRSPKuHbgqOjGb6EYET4+3qhw8AzpnrLFMMTSnBKnXAwpojAED+KVz1hD+BFRLZiqabMxgPMAYA2h+/YrjK9CbjSuwvNsC8/bHKD6btMAfChray4D3dkExzd+1IPfKs0y0MT6MMrO25ol3xBDim3gYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S1/LWTYZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fdZjSt9E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M3uTw1424160
	for <linux-wireless@vger.kernel.org>; Thu, 2 Apr 2026 03:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sYYhjMFDVSGGdtAN/NncaSVaOw76bJQ6T7loTIJqlLA=; b=S1/LWTYZx34EFLTN
	mfJ5G7UhneHFIpJMFnnhJiEeQ3FEr/IdP3dMxPgayt5wqFC3LDTUTng25t2VetLN
	psNKVNLzAFpiCGug5XjyRuM0vvxqswEBPdQluXEcWdNaOHGaCz1pNOLJnhDb0oEG
	8OYh5m0ZRmGxwPTHQ+ltptDYGEYiUoNnMY4XUk2h4S5w9fk+/ya+UiNtoHcl5RPE
	K+oHh8Kpkbfi00eGrReqZBgiBzBkJd2QWnvwZ4KXgTaIf3avjKlwPpD+Hup3I2TI
	Tg79ug51SP6YDAX0hdPYNkxkzu7yjuyl5zAUrXAGjNsVpusOnJuqswJt1NEAL5Kf
	bihCpw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9511aqpw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2026 03:54:26 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82cf0130d17so255890b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 20:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775102065; x=1775706865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYYhjMFDVSGGdtAN/NncaSVaOw76bJQ6T7loTIJqlLA=;
        b=fdZjSt9Ei9CZ8s6cpkAvbgrKUOAJLKch9MBk9qY2CcbzlVewfX/XF4m60WUjU22qjp
         ptfI/KGSr5XMDmPIj6DeyuZsXGTmr5XJ5RSrju50FOfjaKFYo4MlsJ+hH4FuY1v83NX6
         3pAv/JQ7ypGmGfIM93lavFAiEfvcQqXZIRf6ZDJmfiBk/LMeTLVXwnnW9oHIX0mrjKTC
         fxcTtExE4XcBgOqwTpONi3an0YPIKn9unKxIiWl/N6iEhsjNuD11Yu80T65Arxzc0Enm
         rh/1WnIuyGVyscI7Mye/p8gGu68zlGgxYhL4wrFGbmYsGOla0ZG2MoHDgo4aoBw8EExU
         /mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775102065; x=1775706865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYYhjMFDVSGGdtAN/NncaSVaOw76bJQ6T7loTIJqlLA=;
        b=JSCHq92FfEGOMvJKUfMDQkZzwZ12Nem4zJeqJT54MhyHkvJTa/1aA7ro3iiB01ZIU8
         Ft5s8ulFxOVndGttTPNFtcs/Wc2kWLVnxjGkdXj/9J5/RgBb7tUhBown0OkTUf7mA9St
         p738Y9vIfg7Ct1z0cgZMmQJ2sQx657QAVvP8QityHmdVLMG/25i0szczmYURyMlLn2PT
         20E9AKvAWqJisuiFbEUev2aELHNc8yyy0wc8ib3DR2+sfp35ngsTRyY1UWul0PoK6NYE
         q/JI6nNKYRVM+ZSg+F5ojv29DopoXV9XBKgzO5LqOQZx9afDqpOQUr/GyJyER/yYm+ng
         5BCQ==
X-Gm-Message-State: AOJu0YzXJzv2+nEHIzRNKogDS62upnbfbyIhjlqte+Ien3zMFWXkmxc6
	MYkoQ3a1mEM97OMep0vUwjBKYmTioIEBqMr7CATIYPJIBwWVnAa8fTZyrmrtLHMfZ5eEvkWXYuW
	0P7vXUJsPxbIZtia70gpgXan8WRI/wwvAPlp3gq8k4gCWCXjj0KAyIKmnunZFoPOXv4ztJvpF7I
	QSGg==
X-Gm-Gg: ATEYQzyNVrEOmBYxJ/9Qx75hMY5hI3D+ZKDhMnTVw9YdAzBdOQZangba6qx/6TnNNbH
	zxIoATbk+ek7V/Nk6hSZrREk+PDYien7lZ3UnpzL9DmPmUcMpcxxebqwLNT45NFxJ0aaWOspxXM
	z8YfFSqUDW0U5od/bXdcoKLKcYYIvtTyEBFjSG55S2RHc0PQ0bzmtUv6ukusu7mG1EsI+Gd9qOX
	Tv+QudMNYj7pGrzvUp98xB2G3lNLY7PbkyFNv6a9H9JRjhygl/u7ae4UVz+lRSeXLPCMclsjnLj
	L3lEsethyd28TjzipLeM38LQCZc0p32MXYZJYPagL4zPyEuztsi/27f2jk2L7sH//wni3Xnl1hs
	PMmbBwS/kz8qhK/CI00sG97jmoDVmqrv/vv25Apah/4YRgxMANQnt+jK/42XrxcHEQALlOqPmTE
	sLE8wG9z8VjiKPLx7eaoFbibKnE8miDkRh/RU6/sA=
X-Received: by 2002:a05:6a00:6c86:b0:82a:6f69:7f72 with SMTP id d2e1a72fcca58-82ce8b05a2dmr5616472b3a.47.1775102064882;
        Wed, 01 Apr 2026 20:54:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c86:b0:82a:6f69:7f72 with SMTP id d2e1a72fcca58-82ce8b05a2dmr5616413b3a.47.1775102063385;
        Wed, 01 Apr 2026 20:54:23 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b272bdsm1456189b3a.12.2026.04.01.20.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:54:23 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 09:24:00 +0530
Subject: [PATCH ath-next v4 2/6] wifi: ath12k: Add ath12k_hw_params for
 IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-ath12k-ipq5424-v4-2-cd1e0f0a6c88@oss.qualcomm.com>
References: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
In-Reply-To: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzMSBTYWx0ZWRfX/LlYSdEBwlp9
 kYcMIkzPeVkzDQ848nZTxxjJqg3dYPRJqc3ptqb9XG21Nwn+kR0V3dVt86eEoFxyFwwPh04tYUT
 1RuSZ4og6n7kUgQBy++vF4IZaxrCYYOkMEJi2laEXzBiS+ipI5Ug8TLhPakP1zk/DH6HikDnSMy
 TPwPEcYumny5L1vK9ErhLa4I2qA9HO/qPmC2iNuN0Dy9XEqhPs8YnsT2kPVkhzbnGjZJuOFQ0ln
 N0NhZHcUldozFHfUT4V3k0+4Apz53Uoep8sPpp9DdwKxnaQMFpu2soBMOFxuqwVrXIek+U/bYHE
 UR96Hb2mgG4RLPmpOzWlkHoIKOPZQ1V/p8e6z7NJSC1NDFyiABEc7l5ZmNID6oimdQyEqW/uxik
 iCi/5Ljycdo6FFke5ukg65ZI234gctYDuCGr91BUK9XwwS0AZpng+NOiEpXGF3dRybZ+I9HHj02
 yVNelAOjdbKsgZvvjIw==
X-Proofpoint-GUID: lVU1MzqnDuQtVSqbpcdoYYgTa41RsdMw
X-Proofpoint-ORIG-GUID: lVU1MzqnDuQtVSqbpcdoYYgTa41RsdMw
X-Authority-Analysis: v=2.4 cv=F8pat6hN c=1 sm=1 tr=0 ts=69cde872 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=vBmMNsOPyRzkxF6eNBIA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020031
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,quicinc.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34302-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D75FB3834E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>

Add ath12k_hw_params for the ath12k AHB-based WiFi 7 device IPQ5424.
The WiFi device IPQ5424 is similar to IPQ5332. Most of the hardware
parameters like hw_ops, wmi_init, ring_mask, etc., are the same between
IPQ5424 and IPQ5332, hence use these same parameters for IPQ5424.
Some parameters are specific to IPQ5424; initially set these to
0 or NULL, and populate them in subsequent patches.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h     |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 75 ++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 59c193b24764..68453594eba8 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -157,6 +157,7 @@ enum ath12k_hw_rev {
 	ATH12K_HW_WCN7850_HW20,
 	ATH12K_HW_IPQ5332_HW10,
 	ATH12K_HW_QCC2072_HW10,
+	ATH12K_HW_IPQ5424_HW10,
 };
 
 enum ath12k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index ec6dba96640b..9b9ca06a9f45 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -753,6 +753,81 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 
 		.dp_primary_link_only = false,
 	},
+	{
+		.name = "ipq5424 hw1.0",
+		.hw_rev = ATH12K_HW_IPQ5424_HW10,
+		.fw = {
+			.dir = "IPQ5424/hw1.0",
+			.board_size = 256 * 1024,
+			.cal_offset = 128 * 1024,
+			.m3_loader = ath12k_m3_fw_loader_remoteproc,
+			.download_aux_ucode = false,
+		},
+		.max_radios = 1,
+		.single_pdev_only = false,
+		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ5332,
+		.internal_sleep_clock = false,
+
+		.hw_ops = &qcn9274_ops,
+		.ring_mask = &ath12k_wifi7_hw_ring_mask_ipq5332,
+
+		.host_ce_config = ath12k_wifi7_host_ce_config_ipq5332,
+		.ce_count = 12,
+		.target_ce_config = ath12k_wifi7_target_ce_config_wlan_ipq5332,
+		.target_ce_count = 12,
+		.svc_to_ce_map =
+			ath12k_wifi7_target_service_to_ce_map_wlan_ipq5332,
+		.svc_to_ce_map_len = 18,
+
+		.rxdma1_enable = true,
+		.num_rxdma_per_pdev = 1,
+		.num_rxdma_dst_ring = 0,
+		.rx_mac_buf_ring = false,
+		.vdev_start_delay = false,
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				   BIT(NL80211_IFTYPE_AP) |
+				   BIT(NL80211_IFTYPE_MESH_POINT),
+		.supports_monitor = true,
+
+		.idle_ps = false,
+		.download_calib = true,
+		.supports_suspend = false,
+		.tcl_ring_retry = true,
+		.reoq_lut_support = false,
+		.supports_shadow_regs = false,
+
+		.num_tcl_banks = 48,
+		.max_tx_ring = 4,
+
+		.wmi_init = &ath12k_wifi7_wmi_init_qcn9274,
+
+		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
+
+		.rddm_size = 0,
+
+		.def_num_link = 0,
+		.max_mlo_peer = 256,
+
+		.otp_board_id_register = 0,
+
+		.supports_sta_ps = false,
+
+		.acpi_guid = NULL,
+		.supports_dynamic_smps_6ghz = false,
+		.iova_mask = 0,
+		.supports_aspm = false,
+
+		.ce_ie_addr = NULL,
+		.ce_remap = NULL,
+		.bdf_addr_offset = 0x940000,
+
+		.dp_primary_link_only = true,
+	},
 };
 
 /* Note: called under rcu_read_lock() */

-- 
2.34.1


