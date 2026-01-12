Return-Path: <linux-wireless+bounces-30678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DE6D10E8B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90C1D3015024
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5019133064E;
	Mon, 12 Jan 2026 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jhDTpCO5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QtjqpbYS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81F433290B
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203427; cv=none; b=TaTzQtVqwgeaYxcebsa87wWDF5x7i/1q0xDhTMm/QQ0qxkfWtGvEeHD22qCSLG5OQJA7MtBN3bwCymC1wkssHHh67lpQNP+zuwaoV/5e/7hRS0MCizQj/fOTiDCJl1ZYrlulNy99wkPn2UZVggRlh4UUZVjmQN0YWjeB1kIyo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203427; c=relaxed/simple;
	bh=PZ1loelXSV8VStq1VOj+ZSkM1L2Ph03JndsmGy09Zig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4uS1iUruKlIicqAYmGPQDtT3gUPkJp7QERiUs5HS6Cwd/fLTBgOrnOZOy6JGc71g44wk2fludF2DE1ZnRAOhQPc/EjaB5gZsTOTH2C3aXiuOyOFbRbSlpRpN0uluatwLH+p/IhLfqlby5OEBsx3hIC/TfmornsX+Cpa3Pyr3Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jhDTpCO5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QtjqpbYS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BLJSpP1086432
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	crijy/JfQgHYXn/804LQESxfgfEFdcgLFtKHH3i78UA=; b=jhDTpCO58ZM3E5EI
	ru1VY8DFlvPyeK/2EHTgUE+U8L4oyG89EFgMlxYFdgHHCEOzReXk3xNMyvw52hFz
	z2H0iiz8KPoIP8orLl6b/sOOwG89cim5twxC2ti2nZvr0UKMhO5TW85rEYD0lE6t
	X3SxZ8YwTr7oLRIlU097q69RwskGoRoMeHr+xdAm7LIepVKL1EuoV5cqj1XEjDR/
	OLjv+AI4agRoL04YlF8A3pZ8JLcG3JaldT8eoDJ/FyromtLRzscDKluzxqnCdVdE
	dvZHRTF6f5NM0XOdoRxfIIdz91BQbRt9r/3+E3BwpmS+yBWkqvd/fdy8dQmzTP2I
	XWagEA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkfxfuwpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c3dfa080662so2674108a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203423; x=1768808223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crijy/JfQgHYXn/804LQESxfgfEFdcgLFtKHH3i78UA=;
        b=QtjqpbYS+3f2RSY9LYrb8dcOFUqLwg3IpslhAvHKWbcheZsfhIjvEsLzdciTWGv+Tr
         Jf+s7B7BIQGfEjgm2Wez95lTqaScLYq4sH9abcYaK+UVRTatHX6EOGR6VBw0iw4S3NaB
         8HnA8JrBBTtYsbrJ3YSv7uLss3mfxRc4CrzYhqSpxKH/vOH3J7L75r3UK8jDB8pdl0uO
         KjBPwp4VrcPElF5BVjLOY0fH3JVM7wqh/JyEGx8axGheJzuedW4aeMfC9uBS3+UNuiC9
         aiXkJPpYGQABlnaUn2sbnM5bFnWf1rX0ZeTXhn03JyzZ9uR0jroM/1VRPRa9cF+0Zt7M
         1ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203423; x=1768808223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=crijy/JfQgHYXn/804LQESxfgfEFdcgLFtKHH3i78UA=;
        b=T5gklZn8XJIDboa5zN6fW3QYwJ08Lgn62WiyDmEZD4fLqVMdAyiVQLm1rH8Y8MABwW
         /IOErMQ/BpZX94aJwC6A1N4SqD1XrEW0vFhsqgyVuoKASknb7QPzBPCkq7wN+0pWUfQE
         o3c/r2lVX1DHW77tDrhXfglCcye86abdsXogoJQZT1lUZpKdKDSstKXQv/a20A843o1S
         3vF1J3KiJs0BmskiNJO+miCNXz/Pvi25BYExq8euCjTSQ54szZbOcSDecyQrdSw681hN
         FCAKhsICAGLH4kXGuwQf1Xqf3h8cFu3wHuPeL3gGStHdAVfxQ+rkmbJhvQN3Xe2dQCNP
         nfoQ==
X-Gm-Message-State: AOJu0YxUVwJw2+vEHobueyiZrEU7M2wd+OpxdD2eFwwlqBRZUt3w0x4w
	UBwiqQP2zP/72mVBgpaXwkl6geFmMF8I2QRAE5+c3hJr1j8m060rQ/Qp1addFFvprlsot1QEzh+
	IjFFA1aOymXLzzuqlOjQtrUUuCutfqt8xDuaLY/sQRuctfE2welVcCOawTAzm8XfxlcdwHVbo9J
	PkBoXK
X-Gm-Gg: AY/fxX5MFeE4dkWn/zuQd14aS7PCi2DMXOPIffVzIlEISX7Ad1uGZtKuRgm09K+u6+B
	p1l95NqQUizZa+ZlR4XK6G6wKQzlOqXFKDPJEj2UfxIJw72vbrbug67P4+Y8Yz2z0SUnecgFldr
	tKIPEMpLPHm8Dfak+i/XXapjB3+/HHRL0L/t41PIWWtYp1b0Zxcz7/5PraS0Niyoga4BxoqTZC1
	/q+JY5GLsnFRD8fKRPWhv6omT8Fxwq/NV+KjKy9F/MdVaBzN9xDBe6pCf5ViGXCOBvKSC54NF4f
	LBgC0Loqdmev1I6PJGTXzPWr3p4SslUpwq0KzvfWYIdoTo1q6nWZaY01NzAOLZAwNUM3bYaTGOS
	WYnOqCV7oqPdZXdDfh6mMLcL+yp0AEQUK0+gq4VfwFwH+C6YGXf3aiQjma7RrQg4=
X-Received: by 2002:a05:6a20:748f:b0:342:2a1b:870f with SMTP id adf61e73a8af0-3898eaadd03mr17048272637.20.1768203423099;
        Sun, 11 Jan 2026 23:37:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDYnBEWa02oUYRMDUftjkmlUw+D3qC727crK+T/F8vrJ3a1geLv3RvJdq7Hu7TdHjN6YmKIQ==
X-Received: by 2002:a05:6a20:748f:b0:342:2a1b:870f with SMTP id adf61e73a8af0-3898eaadd03mr17048256637.20.1768203422595;
        Sun, 11 Jan 2026 23:37:02 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:02 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:25 +0800
Subject: [PATCH ath-next v2 05/18] wifi: ath12k: refactor 320 MHz bandwidth
 support parsing
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-5-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: qW-4ADAKA2-AwbFSoiG4_gxIcQnSzj-N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX5Bc/S83vrBFj
 Nj/1qgnK6MVnbnMXBwAEslxwVghLY43PtrKKWP6xQTyREpnYmD4AAnWAM+F5/hGIKAMOum5YRCC
 hlACRxIWKUWWepkzAZRQYVuaaPO2DnsIMeT7HQ6CWVRdapyyJUZqVo3UmuG8VCETzCIOgCZVqPx
 2Tt3BW0YXEFwUpm9bZkuWGTSFyuAnpo+WwURnZymvpg2CYeKdVrdrdR2K4Iy9KYtYnWOxkoV61J
 COchEnWW6UmDc/oDeTqePTEpyanUwYqdMyDJncuBH0pZsqUCBlQGV+GWXm0/T34s7T0ZeQE0PdG
 ts4Abyk1UCSoG1EzWcfksiH1PQbywIVnqIuwLeajc7IJq2GxwWLGeu1EFf2NnRLQ08skIAozDR1
 AH4tfsMiVLG7ZCXI6HU/c/xGFNInC/Ho2torx0lUF3eYBEU6PCw0noKOjjXAZRSgo5cAyDJjX/i
 dotJTqzvxsrulgLTRTg==
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=6964a4a0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=iGNyLxvpPC8n4FyEg3QA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: qW-4ADAKA2-AwbFSoiG4_gxIcQnSzj-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120058

For single pdev device, 320 MHz bandwidth support is reported only in
capability of WMI_HOST_HW_MODE_SINGLE mode, hence commit d4e244c85e45
("wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band in EHT PHY
capability for WCN7850") relaxed the condition check in
ath12k_wmi_tlv_mac_phy_caps_ext() to allow SINGLE mode getting parsed in
ath12k_wmi_tlv_mac_phy_caps_ext_parse(). Since SINGLE mode is not assumed
to be preferred, the function returns unconditionally after parsing 320
MHz support.

This works for WCN7850 because it prefers another mode indeed, while it
breaks QCC2072 since it prefers SINGLE mode. Due to the unconditional
return, the subsequent EHT parsing is skipped. Consequently EHT related
features are disabled.

Refactor it by moving 320 MHz parsing to ath12k_wmi_tlv_mac_phy_caps_ext(),
before the mode checking. This makes the code more straightforward, and
work for both WCN7850 and QCC2072.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 32c4e7fe03c4..248933eac061 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4918,19 +4918,10 @@ ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
 				      const struct ath12k_wmi_caps_ext_params *caps,
 				      struct ath12k_pdev *pdev)
 {
-	struct ath12k_band_cap *cap_band;
-	u32 bands, support_320mhz;
+	u32 bands;
 	int i;
 
 	if (ab->hw_params->single_pdev_only) {
-		if (caps->hw_mode_id == WMI_HOST_HW_MODE_SINGLE) {
-			support_320mhz = le32_to_cpu(caps->eht_cap_phy_info_5ghz[0]) &
-				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
-			cap_band = &pdev->cap.band[NL80211_BAND_6GHZ];
-			cap_band->eht_cap_phy_info[0] |= support_320mhz;
-			return 0;
-		}
-
 		for (i = 0; i < ab->fw_pdev_count; i++) {
 			struct ath12k_fw_pdev *fw_pdev = &ab->fw_pdev[i];
 
@@ -4983,14 +4974,22 @@ static int ath12k_wmi_tlv_mac_phy_caps_ext(struct ath12k_base *ab, u16 tag,
 					   void *data)
 {
 	const struct ath12k_wmi_caps_ext_params *caps = ptr;
+	struct ath12k_band_cap *cap_band;
+	u32 support_320mhz;
 	int i = 0, ret;
 
 	if (tag != WMI_TAG_MAC_PHY_CAPABILITIES_EXT)
 		return -EPROTO;
 
 	if (ab->hw_params->single_pdev_only) {
-		if (ab->wmi_ab.preferred_hw_mode != le32_to_cpu(caps->hw_mode_id) &&
-		    caps->hw_mode_id != WMI_HOST_HW_MODE_SINGLE)
+		if (caps->hw_mode_id == WMI_HOST_HW_MODE_SINGLE) {
+			support_320mhz = le32_to_cpu(caps->eht_cap_phy_info_5ghz[0]) &
+					 IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+			cap_band = &ab->pdevs[0].cap.band[NL80211_BAND_6GHZ];
+			cap_band->eht_cap_phy_info[0] |= support_320mhz;
+		}
+
+		if (ab->wmi_ab.preferred_hw_mode != le32_to_cpu(caps->hw_mode_id))
 			return 0;
 	} else {
 		for (i = 0; i < ab->num_radios; i++) {

-- 
2.25.1


