Return-Path: <linux-wireless+bounces-14438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985C69AD8F0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 02:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C89A8B21BC2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 00:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04358D53C;
	Thu, 24 Oct 2024 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H5aXogzV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA1C125;
	Thu, 24 Oct 2024 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729594; cv=none; b=dk9R0YKJYqXdm3lhjKu4aGvjE7oNZy0AfXI6E8YIQwZHT4T66v8HViC81hKC/G13BrlXz/N8mFm281LI0U2q8Ot0gl9/qVvkwCb5WJpj28GjJeCsljHPC5wIPSpjV1AJYkLBm95BAobdP9zGPy6BdtJIc1ar8INfrclw+nygnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729594; c=relaxed/simple;
	bh=qsRqvK76S3ups7ElipLSRytsqF4KKob6IkpG+FZ+TcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyN8wMWt1imbAUXNs9bekBluJicEXwWE0SalCFHuIiXJQPsR3c59Q1Q+zRf6lqkJRJuQxCCE1RDNGih56vORJsHqgSb+AIH9OqwjRGK5Z3Lw/Kley5VsLjKM3vPGI5kAfWobSFz8D4GJvlpCsCc6AhnPsJgzDlWqKcRxVeZP5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H5aXogzV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKTYem023371;
	Thu, 24 Oct 2024 00:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bh6viNY/CMUSxXuYICO/0PagqIHUhjSm/VjBvclHGP4=; b=H5aXogzVegbdiFrZ
	PKLCGwe/GAUMMsa4Dmdy2MkAWlGZ5LOjZv1bVqn3QBh4Dw1FBm9lO2GbyLpb/Nm/
	6stx44pY8MQQbd4IMNTdy/xCjz5N0uTmNwExiJEbZEJg4DRYzlcxtyUoVx+MDZly
	HeQYdo0WszaM9laypy9wGS2zRJiGKd13Ril6cPxNUJmNMwEphkOjrm4ioVdPLnPt
	OjekC8zBfkwvJsI/ZZasyNcas5j/lkKIz2+l8rPBFvwt7tqN9uuWJ2/kwm5mvaq7
	k14oJZTCF5ZJsAPpKxbGQ+wjZPR11XuV22jwTawwCH86rc+Fq1VkiMfMJw+BfkRw
	SfXoVw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3ukx4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 00:26:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49O0QRU9001328
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 00:26:27 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Oct 2024 17:26:25 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH v2 2/2] wifi: ath11k: support board-specific firmware overrides
Date: Thu, 24 Oct 2024 08:25:14 +0800
Message-ID: <20241024002514.92290-3-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024002514.92290-1-quic_miaoqing@quicinc.com>
References: <20241024002514.92290-1-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z-WDuQEx-v8ZR6VZ5evom6odRkvxKhjN
X-Proofpoint-ORIG-GUID: Z-WDuQEx-v8ZR6VZ5evom6odRkvxKhjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240000

QCA6698AQ IP core is the same as WCN6855 hw2.1, but it has different RF,
IPA, thermal, RAM size and etc, so new firmware files used. This change
allows board DT files to override the subdir of the firmware directory
used to lookup the amss.bin and m3.bin.

For example:

- ath11k/WCN6855/hw2.1/amss.bin,
  ath11k/WCN6855/hw2.1/m3.bin: main firmware files, used by default

- ath11k/WCN6855/hw2.1/qca6698aq/amss.bin,
  ath11k/WCN6855/hw2.1/qca6698aq/m3.bin

Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04402-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 16 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h | 11 +++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index be67382c00f6..775e48551522 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1178,6 +1178,22 @@ static int ath11k_core_create_chip_id_board_name(struct ath11k_base *ab, char *n
 					       ATH11K_BDF_NAME_CHIP_ID);
 }
 
+void ath11k_core_create_firmware_path(struct ath11k_base *ab,
+				      const char *filename,
+				      void *buf, size_t buf_len)
+{	const char *board_name = NULL;
+
+	of_property_read_string(ab->dev->of_node, "firmware-name", &board_name);
+
+	if (board_name)
+		snprintf(buf, buf_len, "%s/%s/%s/%s", ATH11K_FW_DIR,
+			 ab->hw_params.fw.dir, board_name, filename);
+	else
+		snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
+			 ab->hw_params.fw.dir, filename);
+}
+EXPORT_SYMBOL(ath11k_core_create_firmware_path);
+
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *file)
 {
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 09c37e19a168..ce4102cfed4d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1249,6 +1249,9 @@ bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
+void ath11k_core_create_firmware_path(struct ath11k_base *ab,
+				      const char *filename,
+				      void *buf, size_t buf_len);
 
 static inline const char *ath11k_scan_state_str(enum ath11k_scan_state state)
 {
@@ -1295,14 +1298,6 @@ static inline struct ath11k *ath11k_ab_to_ar(struct ath11k_base *ab,
 	return ab->pdevs[ath11k_hw_mac_id_to_pdev_id(&ab->hw_params, mac_id)].ar;
 }
 
-static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
-						    const char *filename,
-						    void *buf, size_t buf_len)
-{
-	snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
-		 ab->hw_params.fw.dir, filename);
-}
-
 static inline const char *ath11k_bus_str(enum ath11k_bus bus)
 {
 	switch (bus) {
-- 
2.25.1


