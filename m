Return-Path: <linux-wireless+bounces-21609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE9A911BD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 04:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0924A19021A1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 02:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA9818B0F;
	Thu, 17 Apr 2025 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSzJjRkE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49871320F
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744857762; cv=none; b=NzFURSKSH09Js+dLBSN5JQ5gssdGCYfzSn84YMh24RfSQWhgzbu0t37wS77z1YHRipJSszRh7laxcLuK4W8PQmMWOiveev8ghh0nMpjR5pDKGh0kzmZdRFD8tRUpoTVAZbVt+5m7KVGm8ihYLQv8VYP33iAvGrSeDP/oMSLv7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744857762; c=relaxed/simple;
	bh=Hsw7J/UNoZR09q8/z+B/3Xe9kdJv1Mq3DJNmze1/vX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IF1DwbLaKlg+GfIurBSse5xSvAyBJC89kakO3kzC4i4t1WiNRt/x87whU8H3x4ns8S3IpiOufst+stdpPw2HPmy5a9MXYS67/vssKIjwRBSin+/aCZAve2bXAwjz7KVJBJNPtssBIpdbBMxaG//VgyCCHXMHtjny9HC6H2XRuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NSzJjRkE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GMh47W022343
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 02:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ASYzim3p5yrHHmTbnyWG7PX18Zybk55cIIm
	GoC+1/+E=; b=NSzJjRkE0LVVHcgMUYXtBgJ2om/sRQ1I0oAbd6QwAwQw75GYxQd
	xZQw8jQ8Q8k/XO/M/OvYndVTS0wl+JOefLlj/JgcphsYi6M6ufdsVHgV7AzKGxyg
	bkt62YqD+lcFHg1UQrJ8UO1whMB2+/7yRoroNv7ylIFMy+i7+RWBjSkbjeKnkK48
	TXUE15YOPzoabL9adozNzq09FiKuHTg6eSpRTtLV2DAGrCae9lE6apZI/SwyzQSp
	MFlJYm8dGSswV8RQDO3wlTnMmYzUe9WTnv2WA/tw99Nmf/+mNVBgmYy0em9re1Ot
	G02oqUkYWvAtAzwN8c0GrK4i84KOvDlzUlA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj9dcur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 02:42:38 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-73c2f5c284cso288714b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 19:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744857757; x=1745462557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASYzim3p5yrHHmTbnyWG7PX18Zybk55cIImGoC+1/+E=;
        b=gs4xaAXFOOipiUfMdXwAsNIcoNmzHYYQtcVs9lHYs0U51Xf9CqkuzURDC75fuq78Ey
         Fe1uqscTl29jBMXPva/98vDh5aJfsGoi7ppaHhLqmMJDN5TDIVdDXE3qlA+XCOlFr1Tk
         0tRSJZaOsd1F744Td0lC/LN9opH6jMX3MMJ5wwylrJXaWmKmRbIpLZrwW75UfZ6MQ0r4
         LASPPXoma39o/DoHfiMg3LfWlJUMA4YJOnWnCJu5BwsQiTJQUEssJJC/cpZlH9EnGQ8k
         dSI0nAV31OdZGa9iAv/OkaI5BNiAv9eOCbxI3eIgKdBcfSlQXXdiM4Biz5wNuzlU2XOG
         13qw==
X-Gm-Message-State: AOJu0YwJLfH4QV4jzWVruJfiIJe8LWo1JA5hVN5dQsnSdRdkDP03fcjR
	10y1HYzsOFh4N9AG8LQXeaMZr1zVwQJDTVKOtpm+udpzmA9O5wIKTqNWvdgQyggNEk4FidgJq7H
	Py5vgLRm7SYDZH8XzzgRv2+jUB2f0GkEgikxuTV7mgoO5iYbR4+BcrgApxlqk72iEzA==
X-Gm-Gg: ASbGnctXK5MoZmt8Efyv7TeatS8Mw2s6Eq/4QWo3NiuPpAonvAKrq+04o0vAd3+1Pfj
	tKJMP6LlEBSFOHM0FE4Bc8x9O/RWNI+rPmNhPqncc4MKlu5oTwHNHAPECRfPWZmibaugoD004/n
	TCJIYYacnEDJ3bDEHvxWJZhfjh+4aTXzM9whpGgDlTRf/JDlUjP92XLyV6dG2In7OYj++uuf6xq
	D36FJ9Tp7GabDahr0C4V1NEHEQnUn1BTFZBcsLZmNYpGI+tejgKRlX9iyauY1NViaK/wnn+7C/f
	32KPNq9FIqZb9g+M8qMgeMJfBxvdE9rIqHm7sLmGN3G4ZzjJPhy5Nz/7bk/wDiA7RhJCe7ahuDb
	6I6DePpRaXII=
X-Received: by 2002:a05:6a00:9a3:b0:736:ff65:3fd0 with SMTP id d2e1a72fcca58-73c267d216cmr5556376b3a.16.1744857757283;
        Wed, 16 Apr 2025 19:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG87CM+UZg61WXhoib693PD+ztU6wM16QU3CaKwJqrC0dPa0iRB6bWTRZ0iXosgFCNj56NMKw==
X-Received: by 2002:a05:6a00:9a3:b0:736:ff65:3fd0 with SMTP id d2e1a72fcca58-73c267d216cmr5556343b3a.16.1744857756781;
        Wed, 16 Apr 2025 19:42:36 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c3263sm11235324b3a.38.2025.04.16.19.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 19:42:36 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>
Subject: [PATCH ath-next v5] wifi: ath12k: read country code from SMBIOS for WCN7850
Date: Thu, 17 Apr 2025 10:42:27 +0800
Message-Id: <20250417024227.1712-1-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XTodieptMJWPqVn5y7w0U7B7MWW1JfdS
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=68006a9e cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=c2OH02f2B1J9eqCLxTwA:9 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: XTodieptMJWPqVn5y7w0U7B7MWW1JfdS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170019

From: Wen Gong <quic_wgong@quicinc.com>

Read the country code from SMBIOS and send it to the firmware. The
firmware will then indicate the regulatory domain information for
the country code, which ath12k will use.

dmesg:
[ 1242.637253] ath12k_pci 0000:02:00.0: worldwide regdomain setting from SMBIOS
[ 1242.637259] ath12k_pci 0000:02:00.0: bdf variant name not found.
[ 1242.637261] ath12k_pci 0000:02:00.0: SMBIOS bdf variant name not set.
[ 1242.927543] ath12k_pci 0000:02:00.0: set current country pdev id 0 alpha2 00

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-02582-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---

Note: This patch is an old patch in public review written by
Wen Gong. Just resend it for him.
Link: https://lore.kernel.org/linux-wireless/20230913105156.17618-1-quic_wgong@quicinc.com/

v5:
    1. fix "From" header.
    2. rebase on tag: ath/main(ath-202504141512).
    3. change quic email to oss email.
v4:
    1. fix assignment error for case ATH12K_SMBIOS_CC_ISO.
    2. rebase on tag: ath/main(ath-202503251458).
v3:
    1. rebase on tag: ath-202503172347.
    2. add branch tag.
    3. add descripition for Wen Gong.
v2:
    1. rebase on tag: ath/main(ath-202502181756).
    2. rewrite commit message.

---
 drivers/net/wireless/ath/ath12k/core.c | 26 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/core.h | 27 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.c  | 11 +++++++++++
 3 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 9b23329f1bf2..b5ade9c7530d 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -697,7 +697,7 @@ static void ath12k_core_stop(struct ath12k_base *ab)
 	/* De-Init of components as needed */
 }
 
-static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
+static void ath12k_core_check_cc_code_bdfext(const struct dmi_header *hdr, void *data)
 {
 	struct ath12k_base *ab = data;
 	const char *magic = ATH12K_SMBIOS_BDF_EXT_MAGIC;
@@ -719,6 +719,28 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
 		return;
 	}
 
+	spin_lock_bh(&ab->base_lock);
+
+	switch (smbios->country_code_flag) {
+	case ATH12K_SMBIOS_CC_ISO:
+		ab->new_alpha2[0] = u16_get_bits(smbios->cc_code >> 8, 0xff);
+		ab->new_alpha2[1] = u16_get_bits(smbios->cc_code, 0xff);
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios cc_code %c%c\n",
+			   ab->new_alpha2[0], ab->new_alpha2[1]);
+		break;
+	case ATH12K_SMBIOS_CC_WW:
+		ab->new_alpha2[0] = '0';
+		ab->new_alpha2[1] = '0';
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios worldwide regdomain\n");
+		break;
+	default:
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot ignore smbios country code setting %d\n",
+			   smbios->country_code_flag);
+		break;
+	}
+
+	spin_unlock_bh(&ab->base_lock);
+
 	if (!smbios->bdf_enabled) {
 		ath12k_dbg(ab, ATH12K_DBG_BOOT, "bdf variant name not found.\n");
 		return;
@@ -758,7 +780,7 @@ static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *data)
 int ath12k_core_check_smbios(struct ath12k_base *ab)
 {
 	ab->qmi.target.bdf_ext[0] = '\0';
-	dmi_walk(ath12k_core_check_bdfext, ab);
+	dmi_walk(ath12k_core_check_cc_code_bdfext, ab);
 
 	if (ab->qmi.target.bdf_ext[0] == '\0')
 		return -ENODATA;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 44e02ebb1071..3f9fcd4d6f20 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -175,9 +175,34 @@ struct ath12k_ext_irq_grp {
 	struct net_device *napi_ndev;
 };
 
+enum ath12k_smbios_cc_type {
+	/* disable country code setting from SMBIOS */
+	ATH12K_SMBIOS_CC_DISABLE = 0,
+
+	/* set country code by ANSI country name, based on ISO3166-1 alpha2 */
+	ATH12K_SMBIOS_CC_ISO = 1,
+
+	/* worldwide regdomain */
+	ATH12K_SMBIOS_CC_WW = 2,
+};
+
 struct ath12k_smbios_bdf {
 	struct dmi_header hdr;
-	u32 padding;
+	u8 features_disabled;
+
+	/* enum ath12k_smbios_cc_type */
+	u8 country_code_flag;
+
+	/* To set specific country, you need to set country code
+	 * flag=ATH12K_SMBIOS_CC_ISO first, then if country is United
+	 * States, then country code value = 0x5553 ("US",'U' = 0x55, 'S'=
+	 * 0x53). To set country to INDONESIA, then country code value =
+	 * 0x4944 ("IN", 'I'=0x49, 'D'=0x44). If country code flag =
+	 * ATH12K_SMBIOS_CC_WW, then you can use worldwide regulatory
+	 * setting.
+	 */
+	u16 cc_code;
+
 	u8 bdf_enabled;
 	u8 bdf_ext[];
 } __packed;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7af12733a1ff..aee3080a934c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11550,6 +11550,17 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 			goto err_unregister_hw;
 		}
 
+		if (ar->ab->hw_params->current_cc_support && ab->new_alpha2[0]) {
+			struct wmi_set_current_country_arg current_cc = {};
+
+			memcpy(&current_cc.alpha2, ab->new_alpha2, 2);
+			memcpy(&ar->alpha2, ab->new_alpha2, 2);
+			ret = ath12k_wmi_send_set_current_country_cmd(ar, &current_cc);
+			if (ret)
+				ath12k_warn(ar->ab,
+					    "failed set cc code for mac register: %d\n", ret);
+		}
+
 		ath12k_fw_stats_init(ar);
 		ath12k_debugfs_register(ar);
 	}

base-commit: b80c52642c1159c2596776b39b06eb1c2e36baff
-- 
2.34.1


