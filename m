Return-Path: <linux-wireless+bounces-30690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B1BD10E9D
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 701B83007882
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8BE32E154;
	Mon, 12 Jan 2026 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cv2aVyKh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EyB/BoFx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5CB2652B0
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203448; cv=none; b=rSSc0SJ0hmLaU7RhsPlki6I5FrsaZpaAeil5fbB8vDgfT2VIHK0QjHFrlOR2z2RZNsmr2zGKjpxlDP/V29fHXEPC+pel/g8A6XG+Lao0MHsuCjvMWHQwSlKHgZvTelkRKHcUphe8D+j6mu7YZdOm6OrXNH1vB3ijs6Vy2Vve3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203448; c=relaxed/simple;
	bh=6KzWa6R68qeoFG3faCDND3NNJffW01aKDfuhsmQc60U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bs0bIusDaXw45FlNJ4YSMFz5bmZh2LhELPXfgU7D2uFQBKWae8HxIZaag6ecoxaVLkzjJeLhuedYee8/mrSHVska08fyTZyiAmPdePKTavgHHALmMk1+xMJFH4As5ZBq1SXDEJtnO3o59lSjoP6LvB9rpRghTYZ29zzF+wK6kTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cv2aVyKh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EyB/BoFx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BNpG6i3246798
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gRYX8YVK4IhobYJuFw94CAvEwbDe36ncjXdGfdxpUb0=; b=Cv2aVyKh3mNG97p2
	QaJLfCSXKimwJhFv6yrJpUTtyJi7TQbO0kfIhL3E0slkkVrYOG0AnxrZimHL+wYc
	U+3+vSOGHyhCq/xchX7Pqf2+OjtZcjm/n6X6YdAoPfr2/hemikRJ/zuDk3kBsBfI
	iafYMEHJfYdhk43lS0Koas5B9ouIsK39ZlOJB5ClMtk06s+ipc3kbeMagSeIb4Zq
	lvdyQfEvuVz1avfOx4Ui1TGdybDY4yI3UhjYIDlD184whzmMbdUjUm8XjpypY1HI
	c6d33rsm59ujmzDpQL6kneF3oS8SjJ658Oyo62xDYG4Hb03Kfk0kfTwVQY3WcqDv
	gsRDrQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkf57by9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c5269fcecdeso2285446a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203444; x=1768808244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRYX8YVK4IhobYJuFw94CAvEwbDe36ncjXdGfdxpUb0=;
        b=EyB/BoFxzOIKlUyGw/tNhhD8N9XTpzuLCtFN8YwF2GqdGfc9zewe+sI235/vW0SwM3
         3DM3rN2e1H2Tad2PUTGt+UTOeQeYmgRfG4S+66eOziyN92WTVzKrC2i8gtO3T66jE0F2
         dfvOQ2FahTaYbey7WFyxaOr3tCAjZFg2XTPc/imixoifP6WeuHbYAQdg1NmUeDNxprIv
         f41kWKGUam80Z9iIQM0SnHRShZD/jb/+MOeCtkjnzunU2O6l2Ow5tenES6S9QfFZNMMb
         RenKZDrlsp94zTALA8wcAZ7qntyuPLhStqtxF9q/XrH8TsCQW9iloKLehqGCq8DaCz9m
         OYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203444; x=1768808244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gRYX8YVK4IhobYJuFw94CAvEwbDe36ncjXdGfdxpUb0=;
        b=UmKN9dOIBWltBp8o2FVtgY1DysCGBhXWOpZY3tdJ8v6un+CImQZW4iybBg1T04aAms
         z17BEE7oWWpKp1xBFVr/UFHeHGNTjS4ng4Mqes97snnjzMqy/U3o8myFmkJZhQzP14NY
         UxEGoddXN5CZPJCZYKxbLokoKtt1ti8iyASXSv9jyEjVVftZu23jdemRZ41QiKgz+mBV
         B8y1JoJ+ogRwcTansCFjomR1HIR5M8hivFl9aCOyjEGmVtYmuFGGzmCEnQDMNgVL6zek
         xUjDVCV0itYkUlGWhcd6kDgbJqXA6qgCW8M/m8a1tTaOC7ljdoSppKH1YSYbEHaUYv24
         09xg==
X-Gm-Message-State: AOJu0YzIINYTQ+E6TEr1KcsF9sV5y3FzheJf5TyOQf7sxD3tYEyiMBZX
	0NNL6ds01xbSHFhgf6Qt6uYYX5neMtB7/JcZq/uB2+lrVLp9ZbYmCbYz0fBM6NR1SLWgIXVM9g7
	t5TxyL5CiAqMZa9edoQxbSNukMNNxVOX1CkrkKqlvNgiqi++WqdmFBYz2VwygouvsQ/jAQg==
X-Gm-Gg: AY/fxX41xsTCNeo4BhH6mTOMuYBCIi+7tSBzBsEsuPLp1UaEt99yILBdrpSzyJHYGWA
	+pGGej+Rz9uYQVwKX70foMvT4S5kflFCuk/S/iU+jzOAhdXQgkzdbpMJaKWjcbiRWYE0zzyszq1
	Tcxz2bVWnmrAsbUvpeGlEDVT9U7jcB7PA+z42jAPiLaBEoL4gzy7mtaeR15JBdaRMU6Ff6KJilJ
	oKlgkofRw7aV0FlsKcZE/ga1LH71YrO1KiTNxNsY0hYWGCM+VLAdIcPmcF5v5ElIoGNRgNzoPNn
	cUTQG4w8uCSplrgN69DYZBNYC3DAuFm3oQXpyZdlw1+AKSIVhKTBsK2Hbr9qGAz0624PTGOb2Aq
	Gig4JO7vOxrl7PlqAyip80GVEFNHMFHs4bwU4Ny3cMQ1Bldd+pBM/DNI5Zhsi0o4=
X-Received: by 2002:a05:6a21:6da1:b0:33e:eb7a:4465 with SMTP id adf61e73a8af0-3898f8cc022mr16140620637.22.1768203444497;
        Sun, 11 Jan 2026 23:37:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNBp3ADETjybZc8krnk+zrEAINBJ30KbTMvu7SVE2uIOY0qEet+yZXYtaJi6JHidGbHLeaYQ==
X-Received: by 2002:a05:6a21:6da1:b0:33e:eb7a:4465 with SMTP id adf61e73a8af0-3898f8cc022mr16140602637.22.1768203443998;
        Sun, 11 Jan 2026 23:37:23 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:23 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:37 +0800
Subject: [PATCH ath-next v2 17/18] wifi: ath12k: fix
 PCIE_LOCAL_REG_QRTR_NODE_ID definition for QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-17-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=K/sv3iWI c=1 sm=1 tr=0 ts=6964a4b5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YBsQQ0GhBToZ_qaIIOwA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfXx/tLwjE5z/04
 mimhjukdurOcoQO/P5n0M0JqcNTLRpO9V0d0yWxWHtlhB0MZjlSZuj+JSq77BG3CaWHlRwdImFa
 K5Z/wul7FL61zOeJZYZuxWi+3C91fqYfOs2ubPTrU/is2hWZdvGl9kVugdMn20jpFGs1jmUorEV
 4BiZtmCu1kL/O8dlb/9ePD8oZ6vyR3GEIA53k+c5XugeJvF3Fjm59CrPg8/0RPT8nDpuoEN/VqW
 vLyg9/bDZ6kf7K1LQYkStmC5QQFkrhdiHmyzcYjMbch2qchfBHhn7s/O6O//YuqCMaIRb80FYiS
 fs3RJIZBFDcYNxGAj1VcIO4MWJwRNmjhONllXKGoyI4Qbf3FZuBSy+of31Sq+pFP0wMP3sSXJZ/
 UYCR3SkV52yc/UGSJiheMHxkGEADpOUDMUK6/RoDdhZ55tBrSoLXA0CW+7lfQa7CG/cFIUMqZBF
 vGIZpM44tPUaGDuaOmw==
X-Proofpoint-GUID: tEeFBaWN6DuH7VFJcLHCzFgVpDT8SBsY
X-Proofpoint-ORIG-GUID: tEeFBaWN6DuH7VFJcLHCzFgVpDT8SBsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120058

From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

The definition of PCIE_LOCAL_REG_QRTR_NODE_ID in QCC2072 is
incorrect, which causes the QMI connection to fail when
ATH12K_FW_FEATURE_MULTI_QRTR_ID is enabled. To resolve this
issue, move it to the hardware register table.

Note IPQ5332 is not affected as it is not PCIe based device.

Tested-on: QCC2072 hw1.0 PCI CI_WLAN.COL.1.0-01668.1-QCACOLSWPL_V1_TO_SILICONZ-9

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.h               | 2 ++
 drivers/net/wireless/ath/ath12k/pci.c               | 6 +-----
 drivers/net/wireless/ath/ath12k/pci.h               | 5 +++++
 drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c | 2 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c | 4 ++++
 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c | 2 ++
 6 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 520587305dfa..43e3880f8257 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1201,6 +1201,8 @@ struct ath12k_hw_regs {
 	u32 reo_status_ring_base;
 
 	u32 gcc_gcc_pcie_hot_rst;
+
+	u32 qrtr_node_id;
 };
 
 /* HAL context to be used to access SRNG APIs (currently used by data path
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 4bc30d86c1a7..fb597f063614 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -34,10 +34,6 @@
  */
 #define ACCESS_ALWAYS_OFF 0xFE0
 
-#define PCIE_LOCAL_REG_QRTR_NODE_ID	0x1E03164
-#define DOMAIN_NUMBER_MASK		GENMASK(7, 4)
-#define BUS_NUMBER_MASK			GENMASK(3, 0)
-
 static struct ath12k_pci_driver *ath12k_pci_family_drivers[ATH12K_DEVICE_FAMILY_MAX];
 static const struct ath12k_msi_config msi_config_one_msi = {
 	.total_vectors = 1,
@@ -918,7 +914,7 @@ static void ath12k_pci_update_qrtr_node_id(struct ath12k_base *ab)
 	 * writes to the given register, it is available for firmware when the QMI service
 	 * is spawned.
 	 */
-	reg = PCIE_LOCAL_REG_QRTR_NODE_ID & WINDOW_RANGE_MASK;
+	reg = PCIE_LOCAL_REG_QRTR_NODE_ID(ab) & WINDOW_RANGE_MASK;
 	ath12k_pci_write32(ab, reg, ab_pci->qmi_instance);
 
 	ath12k_dbg(ab, ATH12K_DBG_PCI, "pci reg 0x%x instance 0x%x read val 0x%x\n",
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index a74b09d23a6a..0e0e2020c6ae 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -59,6 +59,11 @@
 #define QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB	0x1E20338
 #define OTP_BOARD_ID_MASK			GENMASK(15, 0)
 
+#define PCIE_LOCAL_REG_QRTR_NODE_ID(ab) \
+	((ab)->hal.regs->qrtr_node_id)
+#define DOMAIN_NUMBER_MASK			GENMASK(7, 4)
+#define BUS_NUMBER_MASK				GENMASK(3, 0)
+
 #define PCI_BAR_WINDOW0_BASE	0x1E00000
 #define PCI_BAR_WINDOW0_END	0x1E7FFFC
 #define PCI_SOC_RANGE_MASK	0x3FFF
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
index ee2427fadfc1..1eefb931a853 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
@@ -92,6 +92,8 @@ const struct ath12k_hw_regs qcc2072_regs = {
 	.umac_ce1_dest_reg_base = 0x01b83000,
 
 	.gcc_gcc_pcie_hot_rst = 0x1e65304,
+
+	.qrtr_node_id = 0x1e03300,
 };
 
 static void ath12k_hal_rx_desc_set_msdu_len_qcc2072(struct hal_rx_desc *desc, u16 len)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 95850e6dc6c7..41c918eb1767 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -297,6 +297,8 @@ const struct ath12k_hw_regs qcn9274_v1_regs = {
 	.umac_ce1_dest_reg_base = 0x01b83000,
 
 	.gcc_gcc_pcie_hot_rst = 0x1e38338,
+
+	.qrtr_node_id = 0x1e03164,
 };
 
 const struct ath12k_hw_regs qcn9274_v2_regs = {
@@ -390,6 +392,8 @@ const struct ath12k_hw_regs qcn9274_v2_regs = {
 	.umac_ce1_dest_reg_base = 0x01b83000,
 
 	.gcc_gcc_pcie_hot_rst = 0x1e38338,
+
+	.qrtr_node_id = 0x1e03164,
 };
 
 const struct ath12k_hw_regs ipq5332_regs = {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 88f51a3828aa..e64e512cac7d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -256,6 +256,8 @@ const struct ath12k_hw_regs wcn7850_regs = {
 	.umac_ce1_dest_reg_base = 0x01b83000,
 
 	.gcc_gcc_pcie_hot_rst = 0x1e40304,
+
+	.qrtr_node_id = 0x1e03164,
 };
 
 static inline

-- 
2.25.1


