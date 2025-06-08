Return-Path: <linux-wireless+bounces-23830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2BFAD12CE
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jun 2025 16:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9901D16940B
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jun 2025 14:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9106019F137;
	Sun,  8 Jun 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WSSEHPf8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECEF26ACD
	for <linux-wireless@vger.kernel.org>; Sun,  8 Jun 2025 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749394621; cv=none; b=otyqeklHBmuMXp/RxjxELNH7O4q3XdFaohg2HV0JfCD6rfeDGnYwKqMFq6ul8eG2nnPFZ+PJQGpHN5G2OviWXsRYAKE24SSTyWaNTrPfQniAmZV7phfXUaT5LXBZRfHZe7Muuqo+RFmz/k78HM84TuFQS6YSMhqSlCWfgKYZT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749394621; c=relaxed/simple;
	bh=ZhNZHf9zug80IQzb33EECox1/TXVad+1Wpl3yYiWnWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f3eDAP5iPDloduQiHv+VYmdrlxhv+zCx9+qp7cJoePssiy3yBPC8IqcEhSahNqiSkxr54IkrHWiRJUjzw/1dGWoIpYBsmS/vxoi/DMQmspmeAGm6eLQygAOszX5lp5oVrCXuOww+ljXRaPicmwOEH5rI+xJit6IAhU4YNIBaJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WSSEHPf8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5585ebGm020865
	for <linux-wireless@vger.kernel.org>; Sun, 8 Jun 2025 14:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2NdFZblz24zzgD5Ttc2TUmLu2/a4R5f3Rkx
	KbIXCUWU=; b=WSSEHPf8pU7Ae2/BhFFrbXzKx7xf/4CU48c2x4GNLIkm5cyyy2C
	vRmBRUUPyh0feXlijs62rkpx1+fJcI4nErCgKKi4wXNXWiym2SCmCLlICw+8vXOa
	m60JKU4gVaTombLaZLEtLyHKxjmGDAjAASa52OMwNMkQiOoIr0/ueStarQzMUCaM
	uWD2jjdYHaQkopWzucFP61EVZYjV1cpLZnJGIsthfnKJHk82MPqVKzIpdtakhNSo
	fR1RfaGMO9GvaHZASQEWKrE0fVBqMtYu0mxJpfUbyzx54TSJnyJOUON1fatBsX6z
	fUwMT7YYvL3LtHCEO+ZcM4Y1xrYxueWGhzQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474e6jay7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 08 Jun 2025 14:56:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso2582746b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 08 Jun 2025 07:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749394618; x=1749999418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NdFZblz24zzgD5Ttc2TUmLu2/a4R5f3RkxKbIXCUWU=;
        b=rzqb2cIybf03ksaIx3dOmTJMGT3I5/Q2qPa9IEVPLWzIUBd3tLTBqSYG0hjpdviCFv
         f4nXvmExJApgbfLDUhNb9JUkWzT/wQhDDQBGCKEdEMEJTJKshs/fCY8+VQltBVygc5HI
         DXS9Qo9Xt0HflUUZRAEcTYmLhI61Newords3ew2WSCCnvSYzSh/YnVM+iRDT9i2AvbBC
         dLzgP7Ko+m16DFc4PwjPDPpV6BDTmsiKiLBMcUNmdTLpaLxmPmwcfacYsqRphoU9gzGn
         ydBz9bV2QZeLb6nt56o/uWL+zVSJ3l3toEWTncjdgb4uwNbK5fOr6dmsUlL8ga9QwMty
         E8kQ==
X-Gm-Message-State: AOJu0Yz4O55CbrAv12fX0miagZDVuubn4ej/AWpZnHMw789CH64TtaWU
	IMr6Uu62dk2D5khcKh66MRU3oAmq0HoM9/4g+hS3kFU9sdvk5TSZatbqxcFz45gOJb3/9ZKhLVS
	uUL5qHTHfIjDEzfE/uXVtxlgVmkEHKYB5VQG3HI8DX3lScPhjAXt2YZdpLSZGFOIiXJCPDQ==
X-Gm-Gg: ASbGncvyNNFw15H+t7WAdTIKEpseau08APOkngjJlF+R5xIwG2dSQsnH2oT0i5Aqg8P
	l5/eiR1zQOfdJMBn2B5BYP11vmOKgzWksc5znnx8pCV/ng3oZ2E0u0tfK7luiKQ73Szl8L5Dy+D
	O598JS4Rru8DpCJPuuFnh6ERQf4fXhMMXNBfOeLUqIBor672luHA9es1An83wjmK70zgtKcFdNg
	mH0HHwl/ufbv+uIXGQtBMsXSExqMSuydYY0lv8VuJuXMVxybF3JtjHNbbX4cx5OF8DP4MwmbeGN
	rQ8uWoJVqTt1cuq66yTCfHVIFjacSqD7uEvmTeacUbA5exqXkltp1x8+H7WFr1vcD/xumAs/M2G
	RrGdG75MqC7l8p0YfVRE0FXpOQcsB4JI4mg6apPMZ
X-Received: by 2002:a05:6a00:17a5:b0:73f:ff25:90b3 with SMTP id d2e1a72fcca58-74827f375d7mr14902378b3a.24.1749394617878;
        Sun, 08 Jun 2025 07:56:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYuOPqtoPHVanhl6OAMoSE2pkHm6sgTiy5IfZo/+b7mC74vpCE+pItroKbCPWJvHtN0hbPKA==
X-Received: by 2002:a05:6a00:17a5:b0:73f:ff25:90b3 with SMTP id d2e1a72fcca58-74827f375d7mr14902357b3a.24.1749394617426;
        Sun, 08 Jun 2025 07:56:57 -0700 (PDT)
Received: from hu-rkaliapp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af38386sm4179519b3a.6.2025.06.08.07.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 07:56:57 -0700 (PDT)
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>,
        Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Clear auth flag only for actual association in security mode
Date: Sun,  8 Jun 2025 20:26:51 +0530
Message-Id: <20250608145651.1735236-1-ramasamy.kaliappan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Id6HWXqa c=1 sm=1 tr=0 ts=6845a4ba cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=QbhYrX8MiZuTvZd2UzcA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: UZA88ouBeXD534X6i9P_zNwG_6N3KKh3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA4MDExOSBTYWx0ZWRfX9eFqeYYyXBn1
 TWNbgrunO+x6A+vf/9WjWVTIje4AaCebHLOQx0+xnxRgVGPmGEV7nxlRtv7xBNcUgJ8ok84XDcM
 vwZsCTZGa6nNwI2oFQ9MpaeHjEvvhQMC4TU1gx02Hk+LSGURlDcuuPjIWAIKOaeWv2iydN7mHse
 oCLUh2WGC31Ma10BDiZBePelwPhkJPEhJaJYMcZjj7xaq2xQFHgOZx1JnyGDhBdkZhj3+ZifE02
 838P7Oa6KhBVztQYP0uUEg91qGk2wlkx84GN0iRbCkQ83uQnE2XvGkDP7k8rXwRa91dZAhBGf2U
 UoF6u8MagW3mF2MQnCrdWc92dPA9YE3S5qhg+2Dwgydw+YPeMMQBYwCWtZW9f1bFoUxYAgnajoH
 rwIsdqgFZt3KSdXG8xVaNhsrJJz/nrRI1dVS1LbAqT8hd66GStBIlaPhqjm+OwcZQ9aiLcrK
X-Proofpoint-GUID: UZA88ouBeXD534X6i9P_zNwG_6N3KKh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506080119

From: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>

When setting a new bitrate, WMI peer association command is sent from
the host without the peer authentication bit set in peer_flags for
security mode, which causes ping failure.

The firmware handles peer_flags when the client is associating, as the
peer authentication bit in peer_flags is set after the key exchange.
When the WMI peer association command is sent from the host to update
the new bitrate for an associated STA, the firmware expects the WMI
peer authentication bit to be set in peer_flags.

Fix this issue by ensuring that the WMI peer auth bit is set in
peer_flags in WMI peer association command when updating the new
bitrate.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Thiraviyam Mariyappan<thiraviyam.mariyappan@oss.qualcomm.com>
Signed-off-by: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++++
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87a..d8c14954d8d2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3232,6 +3232,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 
 	rcu_read_unlock();
 
+	peer_arg->is_assoc = true;
 	ret = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to run peer assoc for %pM vdev %i: %d\n",
@@ -5174,6 +5175,8 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 			    "invalid peer NSS %d\n", peer_arg->peer_nss);
 		return -EINVAL;
 	}
+
+	peer_arg->is_assoc = true;
 	ret = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
@@ -5420,6 +5423,7 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 			ath12k_peer_assoc_prepare(ar, arvif, arsta,
 						  peer_arg, true);
 
+			peer_arg->is_assoc = false;
 			err = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
 			if (err)
 				ath12k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 60e2444fe08c..8f3bba4fe4ac 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2147,7 +2147,7 @@ static void ath12k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 		cmd->peer_flags |= cpu_to_le32(WMI_PEER_AUTH);
 	if (arg->need_ptk_4_way) {
 		cmd->peer_flags |= cpu_to_le32(WMI_PEER_NEED_PTK_4_WAY);
-		if (!hw_crypto_disabled)
+		if (!hw_crypto_disabled && arg->is_assoc)
 			cmd->peer_flags &= cpu_to_le32(~WMI_PEER_AUTH);
 	}
 	if (arg->need_gtk_2_way)

base-commit: 3d933084a072fd5fb5da54c06a017abc0412c86f
-- 
2.34.1


