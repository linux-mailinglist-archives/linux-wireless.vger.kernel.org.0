Return-Path: <linux-wireless+bounces-30682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F50D10EAA
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA6413097D42
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F17331A4B;
	Mon, 12 Jan 2026 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g3JLkI/w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gul01dt5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D432E154
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203432; cv=none; b=WYOpLnBCWgMw+YAPmsg28OhIKGrs4CI00nGPNxgxINknXtptanLPreqzyeVN76+/qrS0Cz9W2+XSmb/bfQO6KhAIwZ57yodt6rHvnfGwu3efcg8tgnM0z2UIoboIG8WrPEn+TwltNlq6h7Kqco7svhAZus6zQfgHalLBuNSgCrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203432; c=relaxed/simple;
	bh=G6paLG5KDdsC5R/LchKZCiUgi/mHfEpBp/Up1SpOVg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sb5R9NhgzSo7A1CxUKpEAWVOY01Slx6ripGnlk4vlN3PbziIId5o1YGPxzZVTiyOyFgJFuOiAIVRT307kVZ/SEGkz7lxdVf9mXH1nIhgXEHkV1gCe8vlnsfXFFg0mZPlUIWBwhM04SUtmApfvPVLcWFM+hH7v/LMO4i8Spg+05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g3JLkI/w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gul01dt5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BNFbuF4097398
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4oyZx8sGXc/TDrKQgwByArrdL9wJQD6lqgZ5uNXttzY=; b=g3JLkI/wXvEkGnBv
	4eaZrNvTyWcKWE9lQYvZX2fj86r7ZFyyYXM0/rmWuH674+3D/YnfseRrI3IC3ce8
	rQdrPklT870FvDiw2583WkoVJfpH2xYckflwuLWI9+NXGBMAUOnq1U/wvUVqIRPG
	xd8V3Jql6YoY4jKM0NaHizO7mzTbT62O0ayuLgT3vSAVJsfI80An2r2p+UP49gHj
	JlYP+6y98XxzAdsh8zdPjY9tpOYeGTdu4TxX2HW+5XKpRPra8WB4GmG4669kZcxd
	iHC0VXDWMmv/Vwm2SK5YbtIL39k5Hrma+uGr9+rBRCK09xs447OiLzBRZ+PQZ+gn
	ngeN2A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkfhakxbq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:09 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so8192915a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203428; x=1768808228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oyZx8sGXc/TDrKQgwByArrdL9wJQD6lqgZ5uNXttzY=;
        b=Gul01dt5AMaq7hGCRQynyEuEfqN5aC4WxUPpqupgU+1lEnLM5aDjuF1BKohla+St20
         5wVOA6/hU9Y/K9KRMkVXfigjFnV0Mstm0ycqmkn48aXhW4V8h+2WUeMcCMg+qij+i9PV
         3gp9ZRw7U4lwmyfWSDaluzV1gQySUep3sJl6TK7sA5IhlWUxZnviBrU0+1C4FENOZCGm
         zyIUD4HOi8X3Gil+/zCvHYhffiltM+bUK6OVMhWfmsglprEUQh/N8QCctDvQ4OiO+3oB
         N56JvRcldeobUmGF/Lpm6CuhRVBM4G6slREsYjGyVA+BeLDaVpeG/LAHKyn8xGntdaba
         Ydiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203428; x=1768808228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4oyZx8sGXc/TDrKQgwByArrdL9wJQD6lqgZ5uNXttzY=;
        b=L0DXLiKE4c0JNSUZB+UzfXJdvvtxaKjh2pBca6l0V7Tsy2BlI3edJ3Xshl4j9YUV9P
         jBrHpKhYzSgHNv97/wkyXwUQM1sMBxn8q7+L6JKxz9Buam1OvxvUUh2tEC9DBOgUclvG
         LcjljVMav0AuBonBUve7UI5PZCH1EpgALCM5DbHs0Ej8l20agzce0WSmMDf+oDLOS9CT
         yan2Iiq9HDAGwJLFgyhhVNUiQuwK7eXadekhkJ7IbP8kdrdsX3aspUlgRrEzrTmk3ReT
         lxLHgABWssswvR6nBtONXZWnFTROV5OiS8RMckL2M5jFy1WTUoLY673Lk1MhvuSCptxA
         jk2Q==
X-Gm-Message-State: AOJu0Yw11xcE9wtL8bAhtwhTwpcK7OXsSkowi4ktaMBWW697LtTQBihX
	PRWBFIjPJ1xWxsC0q4EpYoJ/ZZfg1V3i+AuhoSB71qWyP08wUu5irBVvg0UBpwajNbzv//b7xc4
	J6/YkyFMxlktdFN89tuQErLnCEHAJIx1bHYEmZ2Qy/oJ22U2zjFlD2zt64B2lHybYgH9osA==
X-Gm-Gg: AY/fxX79mONLwEbh4/1Ngu/aGgbzf9VaGiy2ed6nSQQxCivJcmC//+CXqX3+Lrn/sC1
	k3inKw94XnK6n11bfqYGEnXrWhGuynI3LeQwHTXPdHxWg/V6kCasxl6tgv3t9T3rUP9Y3cXJa0b
	bN1OZnYZfntLpeJ9a7qh3xykm6Zm16dG7+ZFWhfYsOOz+l9aLJQ/FWrjHDqrn+x1t/PYOZEoN9+
	ZC3bsNwEnLUkSqTFe7pHxjvgF5SGuqgbiZ41GWSAdJuZPceDKKteu468KdoWqAPsjc+TC8XGw/y
	e68sRGVZNlecsQ4dHjv2Kfv07jrFSpcMZL3sXTMv95JfFdhfEzAgXuggvu1q4EVWzksG7Xue//G
	cW+wTWtaTFNbZ5XZPI+nvGTl4fcMmVo1iCPkRHJGak6UOdydYu7kAFPnE0foRp18=
X-Received: by 2002:a05:6a20:430e:b0:34e:e0ba:7ab with SMTP id adf61e73a8af0-3898f990453mr17785283637.40.1768203428267;
        Sun, 11 Jan 2026 23:37:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFObpRy3i0YiC0P/7viEWWS7gfgZYygI1YzssxqK9ri5qKv3Vs/+PR4QVSrlDhotLJvg2jr6g==
X-Received: by 2002:a05:6a20:430e:b0:34e:e0ba:7ab with SMTP id adf61e73a8af0-3898f990453mr17785267637.40.1768203427807;
        Sun, 11 Jan 2026 23:37:07 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:07 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:28 +0800
Subject: [PATCH ath-next v2 08/18] wifi: ath12k: add hardware parameters
 for QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-8-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: FChPyUGB0DmL34bywz2hIsSz34tueEnT
X-Authority-Analysis: v=2.4 cv=bOEb4f+Z c=1 sm=1 tr=0 ts=6964a4a5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=yc6Qm1rWrO3FlAV6bLMA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: FChPyUGB0DmL34bywz2hIsSz34tueEnT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX6eRziBJ6Xf4C
 ZxqqU803yu9H/Z456kIoZapj4UhfEUrISXQlVGUoJ+hrMvw4ECjw0k5ld+mQJ6melolTXuvRJzB
 zCxVFdQDa/4St9Pp8/34+KjnZ3Rzc0jUFmZ4c49qpV27AKtJHXS7RQ0QqtPB5QfcKanJgHPmE+9
 TkR6arA+D3yFHcOXTNcLd/4YVIXxPiZEjNNVwB3uy8y1iLx5MIEij4g2iMSWuV7ObyP+4GFXsY2
 GIUqXAkEPFlJZ014DvUwSHOmH//hhog9T5G0PjOAe8YLYrsW2ru67k9e12KnfySfGsyd0a8QAn+
 4fhfgFVmuCrFgrRy9crzyLuIy5Xv3rzoRGerfR00dGlTLE7a9fwSTRlvAtGSc1m+0NqZX5/YEM3
 oTH2abtjiHi16eAjtWevSC/o9h6Zv22M+rpZlxBJA4WpEkDUTOCKHbs2eTIUImBJtgqwpHDIlcu
 w4Mj+g0B1w1CMEH7pCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120058

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


