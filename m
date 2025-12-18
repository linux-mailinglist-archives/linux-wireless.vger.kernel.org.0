Return-Path: <linux-wireless+bounces-29869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA69CCA048
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E235830562FA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE8D26F296;
	Thu, 18 Dec 2025 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c62tDHhW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UclLuAC6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B92701B1
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022924; cv=none; b=NOnz0AbbTRMbVMGMuYDAzaCQUg03Ml8G2FCZuSabt/XChWQ6zMZMaUEdsY8KiS8QKkh1pIFUYuePMYv01svcjWM2yZrj/JyE+Z4byA+sRteyK9VYiPemHt9vf5xeZe+gDEei2NW2gMrhV0uuKg9+79Tx1uvbiPOYaaWMaY8PpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022924; c=relaxed/simple;
	bh=G6paLG5KDdsC5R/LchKZCiUgi/mHfEpBp/Up1SpOVg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/wzhCDM/mOLscazMyP425K97s/37kkbwluOkWd76EH8bMlF42FHszbgMYKvokUG6aRzi10NkOI9SX/VbWK5j+9a1vU/f0EIpmi9ekdl4fWp8ZoQbKpg/9suXU4C4OOsuqzIIe/O2jEWvR10Q9M0oyERgIHP3LWYrnRERTrOcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c62tDHhW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UclLuAC6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Yqea493212
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4oyZx8sGXc/TDrKQgwByArrdL9wJQD6lqgZ5uNXttzY=; b=c62tDHhWTrl2fRBz
	3G0FRLtj5ebFOk8c0PfqfU/Y0zNHTr/lAigQvaYqE2y3QM2aSkb8qlozCT+yK3EJ
	9aCe+v30ltta2jS3z2PIfjTxmybLyFzvIlq+WVnh6pC/CHprxvMsRXNL5HevEFGG
	oHrUfCsTP73yKEN0BHot4a2Ku+TdL7cjCemdisepNqGfqb49+f6y91azvMLe2EPD
	OeEFl15Ij9FR5jakAkyMl9moPNWFYSGAL/nDkgBYsQL1FtoLmJ9s73aO5Z3IgYHo
	0b3jWw/4a30MS1pc8UHsVVblD4Y1KNYRJ+YRJ4oeGWha6qFcJBen/ad4rgnkGeKV
	vuRq6Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3n333qy9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0f47c0e60so3324775ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022921; x=1766627721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oyZx8sGXc/TDrKQgwByArrdL9wJQD6lqgZ5uNXttzY=;
        b=UclLuAC6RtLnZfocg5aFqrw2ioSTkDUdIJ1HjVyZlfyamZHHQX10PnknuA+OajtPil
         3DraO1MYipvBnUQOXrG/OWriJCMU8Z/b+4Ah/A/zdfwiItAdfSOzfO1JaMezG51tpWhD
         P+G0RWMq4ELd4ccIMU/2AyUHc9X4V2rAmX5awmTRwiBVNfvS3XCL2pM1Eam3gDqHYHFt
         Gg7mjNEL5TDAM0BZiLsB52rnLPDYNh61M0p+UEX3NFkyKz/u/3UQv9pLtmN++8Hv8Zbm
         Cm1CYPgkG/lhFfcxJtIba/JVCkFWvBZAdwj7z2mgP9a5QOJM41jgRWrbt/AePHAEOO2q
         /+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022921; x=1766627721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4oyZx8sGXc/TDrKQgwByArrdL9wJQD6lqgZ5uNXttzY=;
        b=YgKHLeMfmMY5p6toXyBpg5Ni3uNDea4twkqVEK37FGuCVt1x+rtm77tdsx/nLfJjWV
         uCTH+tpC1eMOMsGkU6VYtQPt0AbsRe4utH7xadrQ7i/+fJKOj3zBYLaF3EODjdDl0WMM
         y+ZR55WjMwTpPs6H+6amRRfn0V+/xUrVXBe6MEvDLBaEYCVrK7qj+vga0ABX+A0ma5yD
         LhHg3VXkOihX6AblbDLLBKxJhULsh6Bu6ZE1Y/MBj2iZ+KKGzxPQNme7Bl5Vqx9ewA82
         NeJWp7LIwj3nyeqfFEUgfg32r9HI2Ip4hbZausXjaJ9JHb9JUsyiDaFAeyF51ejf6Ygy
         S5Qg==
X-Gm-Message-State: AOJu0YwEmjK6M8F2V9+YUEjAB4ej8q7JX13h6wMSos0kkB05429JR9Oz
	36yXyOe29eXuFu5GvGuMaB1ceb5ghGxWAb0hIGo8CWkXRn7trj9Lr2BU68+/71sqEupXZK7Expg
	lIQeYCL5i5qodD9B9mvd8F34xcxdH+GuRBEIjjofbyRrDiN30n+cS7JHQko9U+9/6fZA6KT9YHj
	d+S/ZE
X-Gm-Gg: AY/fxX5EvFPqMCtVK7IUKMzFEwh/i59M0WfbgNKH9jh1w1WaYz8WiDDuO5PvZnFSYFS
	oQqCFHKcDDfi3YFg4w5EX2KnTfEi+FwMAVOGUkIz2PNOTr5CmLCg5Sq0oE8llRkihNYjLZZ2mS6
	7WGhEEMlHaXF59j4IcJ7ko2PA6KRPSazkaopbFpmOSMfMXjczbRio1Aw02qm2hr7KAagM3j/Lae
	zlVxCNUJk0ZcYPzifPi7ouG2dhb8md9BVUXuzt4UG+5OxWaFaiLeoMeBijLUsI4YPcbhNdNz4F1
	iQ2o4Yg6uVk1INreJh0dRKK7Jhwy6bxRX/+k/xiv0j/eRX1abh2JmsrXFejoKdFclDJt12l9LAU
	plB3QPJungnpnZ5y0UwClv/wuN/p8hPRUGUpQVs4Y5bcckk3eARvneHPobAAInow=
X-Received: by 2002:a17:902:d490:b0:2a2:bff6:42f2 with SMTP id d9443c01a7336-2a2bff64378mr24309775ad.6.1766022920572;
        Wed, 17 Dec 2025 17:55:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3Px8twSsRitxmjrtB7q5yOTMmb6O/jCsV7sNZHG4shQRn0KzCcUfsGQ8RGG+SR+686UdMeA==
X-Received: by 2002:a17:902:d490:b0:2a2:bff6:42f2 with SMTP id d9443c01a7336-2a2bff64378mr24309575ad.6.1766022920112;
        Wed, 17 Dec 2025 17:55:20 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:19 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:22 +0800
Subject: [PATCH ath-next 08/19] wifi: ath12k: add hardware parameters for
 QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-8-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX+1yE9YwaosIS
 buflx5TfRjIxk8W7W5FUlwWJ8vyUQK4YNrIlcIHa1oPCamvzuljCFf/vxBEeTCLyXU7z/xyy0bs
 DfqO8QI+1ZkVsPHoPWTKh6OCj4oLRffutNHt+MfTOAz+bekFAUmeqPgXqkKNF7Api8ebFgVVu6F
 do5XYRT+AkACOKtxhLZ+q9yFpmlPTZfnL/TnmTeTwDzaxOvohPAHDHAY9NYSNfvqI7nDkVjzRNm
 kLR/msW2ixHEXDN6R0S4PFqJdoAVzx+ehEqhasCIsam9ZNJiEUruv4A2zKdRdPRrMDzm6RAxI1F
 KqikuAw3Ftc1QZrBIwe9gnRhsi8HMhFiksr62nfkAWhgh+W9y+sWDvq0CUexnXvsReUwwWrRhH9
 N3UWxjfThK4HsoM5K22aBe9cb5NiGA==
X-Proofpoint-GUID: t5FANpXsd81gj4Zpvv9zLPBxCQ1AsDMu
X-Proofpoint-ORIG-GUID: t5FANpXsd81gj4Zpvv9zLPBxCQ1AsDMu
X-Authority-Analysis: v=2.4 cv=U82fzOru c=1 sm=1 tr=0 ts=69435f09 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=yc6Qm1rWrO3FlAV6bLMA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

Add hardware parameters for QCC2072, these parameters are directly taken
from WCN7850, with exceptions to hardware name, revision, firmware
directory, iova_mask and RFKILL parameter set.

Compared to WCN7850, QCC2072 doesn't require aligned IOVA when
transmitting packets, hence iova_mask is set to zero.

Besides, WCN7850 has a dedicated GPIO for RFKILL purpose, however QCC2072
has it coupled with WLAN_EN pin. For QCC2072, host is not allowed to send
any RFKILL configuration info to firmware, or firmware crashes. Hence
those parameters are all cleared to skip configuring command.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 85 ++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 1f5dda73230d..ef0a59f6339c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -652,6 +652,91 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 
 		.dp_primary_link_only = true,
 	},
+	{
+		.name = "qcc2072 hw1.0",
+		.hw_rev = ATH12K_HW_QCC2072_HW10,
+
+		.fw = {
+			.dir = "QCC2072/hw1.0",
+			.board_size = 256 * 1024,
+			.cal_offset = 256 * 1024,
+			.m3_loader = ath12k_m3_fw_loader_driver,
+		},
+
+		.max_radios = 1,
+		.single_pdev_only = true,
+		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_WCN7850,
+		.internal_sleep_clock = true,
+
+		.hw_ops = &wcn7850_ops,
+		.ring_mask = &ath12k_wifi7_hw_ring_mask_wcn7850,
+
+		.host_ce_config = ath12k_wifi7_host_ce_config_wcn7850,
+		.ce_count = 9,
+		.target_ce_config = ath12k_wifi7_target_ce_config_wlan_wcn7850,
+		.target_ce_count = 9,
+		.svc_to_ce_map =
+			ath12k_wifi7_target_service_to_ce_map_wlan_wcn7850,
+		.svc_to_ce_map_len = 14,
+
+		.rxdma1_enable = false,
+		.num_rxdma_per_pdev = 2,
+		.num_rxdma_dst_ring = 1,
+		.rx_mac_buf_ring = true,
+		.vdev_start_delay = true,
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				   BIT(NL80211_IFTYPE_AP) |
+				   BIT(NL80211_IFTYPE_P2P_DEVICE) |
+				   BIT(NL80211_IFTYPE_P2P_CLIENT) |
+				   BIT(NL80211_IFTYPE_P2P_GO),
+		.supports_monitor = true,
+
+		.idle_ps = true,
+		.download_calib = false,
+		.supports_suspend = true,
+		.tcl_ring_retry = false,
+		.reoq_lut_support = false,
+		.supports_shadow_regs = true,
+
+		.num_tcl_banks = 7,
+		.max_tx_ring = 3,
+
+		.mhi_config = &ath12k_wifi7_mhi_config_wcn7850,
+
+		.wmi_init = ath12k_wifi7_wmi_init_wcn7850,
+
+		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01) |
+					   BIT(CNSS_PCIE_PERST_NO_PULL_V01),
+
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
+
+		.rddm_size = 0x780000,
+
+		.def_num_link = 2,
+		.max_mlo_peer = 32,
+
+		.otp_board_id_register = 0,
+
+		.supports_sta_ps = true,
+
+		.acpi_guid = &wcn7850_uuid,
+		.supports_dynamic_smps_6ghz = false,
+
+		.iova_mask = 0,
+
+		.supports_aspm = true,
+
+		.ce_ie_addr = NULL,
+		.ce_remap = NULL,
+		.bdf_addr_offset = 0,
+
+		.current_cc_support = true,
+
+		.dp_primary_link_only = false,
+	},
 };
 
 /* Note: called under rcu_read_lock() */

-- 
2.25.1


