Return-Path: <linux-wireless+bounces-30959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0871CD3AB10
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 15:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 106C230012CF
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF1E376BC1;
	Mon, 19 Jan 2026 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fJFE0a/p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ULos0r9o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735937418B
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831374; cv=none; b=o31TewYgTmOno3/JxNjWxBN+95SGBrcLb0vaUpAxCA25Z5e+1vCbZKeJJcnHy9ra5uM7udhS4omBYW5JxSl90LNwzB0x8TyIuONKVLEarxK81B0hwxH8kdjMRrQYP58uPrApYkbZB72aD+ZA/WYQ8yucwP+Ja16uC7zWavvg9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831374; c=relaxed/simple;
	bh=Vf3whddBTdV7xjptVAcFKDPou5R77L8fHdI9ZXlEbW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KpGcB8kar67JFdKO7LihmXPsCwg516s5b2SnodtTY/10XtPryOZ5SqEsmX8DG0i7mkgniKggRPK9cbP2KHYiF3eiEaBdXAGm8V37JxfNuFfOCW5PYIOnPC+fPlAwVaueEVegcgQvGL43zGml7akovVWlX2q1+WS/dIQDpQajtRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fJFE0a/p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ULos0r9o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JAJjMa1531255
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 14:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9lX1BPtTqqh
	G7Gi/G9hTfEQjmDYEFYWw7UxUB8RToE8=; b=fJFE0a/pbHMR91J1XWTIBZ27muO
	Yt7G0LdCNKLDe2Jg8LRzUx2KlPBgu0FgDyjNfCJa3YDfXGIMfeByYJUVqwnIzgmz
	h0utKjEYojyQxe43WVjsEH3NQEK7cOnCKXoYAkVYRn/pGRQZy4Ik0S0f2DIBS0SK
	ifpyFIZN0sAh8TzHKrUQKCGjGaffhYNVwDXv+3PKbTA1sY9+anIWemySeVPCxPr0
	agS9c1n1y7Se76aDaDuil32ah91GSGfB9MxNq4JIx4CC9uili5wP08Wb4Yg6q4Vz
	lx5T3dSb3HUHpERisEvIGNbnXt1vZXflKf0DRWdVP+4utDy/NtWpnZx/y2A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsjrxrk91-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 14:02:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c52ebdd2d43so2430837a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 06:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768831371; x=1769436171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lX1BPtTqqhG7Gi/G9hTfEQjmDYEFYWw7UxUB8RToE8=;
        b=ULos0r9oJMn/Uz3z911mQDRdDaAqk4Pbz2/16QV62kDrBahuaqoFmwGnDH5q34B3pz
         gKj3LalH1gDnVP+thCI7foRZh7tUAE9bWT1tZz7OF7wsqeaNiDeIuYGHUMQvukljwCHF
         D0eY99om0rvRFDi58xHg46Xxrsk1Zmb7hbngl0FIjpo/XQs6t/8cow03GPJpYKLFjCke
         oAckXwLoX0XLvnuCZLH/vT71D843ipr05Mde9QU0JChdEiBe+XxnG8UiRP+1LiFg6M1y
         EXTbMu0A0i3HEiazSIFLcpVHTgZn7awbgsgcR39smrc+U364Xq2c7nhe+7m+Eo0feyU6
         4hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768831371; x=1769436171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9lX1BPtTqqhG7Gi/G9hTfEQjmDYEFYWw7UxUB8RToE8=;
        b=d7odhY/iCBtP+SjmHs8x1uZnEWwk1o0fjQP0C1D87leXi2RNId0z5ERPOUO79/81yg
         Crlbjjh07QhB+Gt5iNibf457F0d95J1Il03eKDF2gktHJvpKEgCebg5rayhETpfB7esZ
         6LFFdcB5weBT0Onrytfc7y703Yq+7cnF5gDRL45mQd2FMJPp2QYNA7aXmYzurs2CP8M+
         RzI2bg0wKxGxIwVDCwFJJ3uEry2W6RbRLZDN1zhxBHPFv7znP5Hyy4ZKiJUpG9v/9m2M
         8EZ1/lf6DTuFALclX5E3W+SaqCr1D+snNQ+5ROZY0fNSiiNvAdOZNmdF2Kwxpz3QWCjX
         UZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAYepYPlYP9zeg83TnnQk9egMdFrsWQzzT8oU98e0rNRdBj1g4G6LIuxkobOdLauoXVdPnJzA0KEzaTS5ezw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI1h/OZes+nj2jWlpQMrNcUIWe/IZ7bGFExrMixNv53D3CV5Xd
	jLA8LWyIaxaBy2FQ90wRLqoHbLbaOb9KXwM8kk1gLdmyRua3C/cPACn4ADC4yN/1Cjt8rwMT0ES
	P3N1A0SwSGQweSfS06mKgQmOZr7XZ/Drbg+MOo31jN7e9vqok2q+dwPRPwdeFQ8f2vHw1Ow==
X-Gm-Gg: AZuq6aITvPouySj0F+Ry7fygcmCNS9iXLHxcgK7p80WS7T5+xNR/8U5H3I5pafy1v88
	xbVZzboYD7Dz6+ahSsFFgxManTenV6BBDZ8CDxEGX1XZhQCkZnquyN2ZIOq6nyD6cmgal3gZfTJ
	MPYBFDKj8YTYQ6zoqHASGtyE/G+N+E6N0OLUsCByE23XLYre3bv5R9XCVHQOhvVa+d4m7J+5ZOw
	F+nHJkfexauivNAZveS5ppLE3kyKXj/y1phyAliCPuzAPB+NrTf3Ict+JKg+r7mK6EjEZ4EA0YU
	f6Af2IEAnr7vfhPp/BD6lXrUsi5yeJt8o9mtjjsOwzeOsZrRnwddHtpWRGWLXytz5l8KADCNnEG
	Mzc9Ikasj0AEqWkp+dzp40A2z0gGJP5kvcCHqOg+bu9SUgph5d1tCde+Plt743hXyT90B
X-Received: by 2002:a17:903:1a8b:b0:29e:9387:f2b9 with SMTP id d9443c01a7336-2a71751c69emr112215135ad.24.1768831371059;
        Mon, 19 Jan 2026 06:02:51 -0800 (PST)
X-Received: by 2002:a17:903:1a8b:b0:29e:9387:f2b9 with SMTP id d9443c01a7336-2a71751c69emr112214645ad.24.1768831370365;
        Mon, 19 Jan 2026 06:02:50 -0800 (PST)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a71941b915sm97416715ad.90.2026.01.19.06.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:02:50 -0800 (PST)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzk@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH v3 ath-current 1/2] wifi: ath11k: add usecase firmware handling based on device compatible
Date: Mon, 19 Jan 2026 22:02:37 +0800
Message-Id: <20260119140238.3360658-2-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119140238.3360658-1-miaoqing.pan@oss.qualcomm.com>
References: <20260119140238.3360658-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDExNyBTYWx0ZWRfXwO5eDPc4kzj9
 uN1KVfMI5CCHj5IUbLAPP2BYxyypktw+wExJc9ejXek4JxcepSLShXhtzXFh1KqYSd3KbNZm4Fo
 mo18dRBvLDT1J7d2PdkWd2JcUi/XmwNHhiU1OstH3RnGKGvHbomUy0IkyegydaaWqyyepdxNS/3
 28xnUrrIwZrcmSNa5nLyP3X6ulQNVeCAso2kcpya1CpJFaYm3vNEipgplreZIi7Gy5ICjVVB7/B
 qs2Ef1l/H5zGej4J9l7k95hI+YXl7BKyuk8ZRrxjITAsflsXnrG19XQc8xKcutQ/qPxRjLTeSXQ
 kJJN9WDO1d+9KxKIy25MdSfD/8nzG6j5dnaw3g/7yxeZYGvoZl+9bUnZpJTKamFQSTqvf7XR0bp
 20Xyk1fzcG32EdpIvIYlk+uz/BIXgXja7Y7lbYEMMLYEKVTtV1bEBtuEMYCP7V6Up9X06QMud1D
 UDHTD5Nku/50amD8GCg==
X-Proofpoint-GUID: GprKH9DO0uwFkvNAD0z3UUggaypcXxHu
X-Authority-Analysis: v=2.4 cv=PPUCOPqC c=1 sm=1 tr=0 ts=696e398c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JAFltXB-HLbv1eA7pZkA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: GprKH9DO0uwFkvNAD0z3UUggaypcXxHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190117

For M.2 WLAN chips, there is no suitable DTS node to specify the
firmware-name property. In addition, assigning firmware for the
M.2 PCIe interface causes chips that do not use usecase specific
firmware to fail. Therefore, abandoning the approach of specifying
firmware in DTS. As an alternative, propose a static lookup table
mapping device compatible to firmware names. Currently, only WCN6855
HW2.1 requires this.

However, support for the firmware-name property is retained to keep
the ABI backwards compatible.

For details on usecase specific firmware, see:
https://lore.kernel.org/all/20250522013444.1301330-3-miaoqing.pan@oss.qualcomm.com/.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Fixes: edbbc647c4f3 ("wifi: ath11k: support usercase-specific firmware overrides")
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 36 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  4 +++
 2 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index de84906d1b27..1cf7f4e601c3 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1044,6 +1044,42 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 	{}
 };
 
+static const struct __ath11k_core_usecase_firmware_table {
+	u32 hw_rev;
+	const char *compatible;
+	const char *firmware_name;
+} ath11k_core_usecase_firmware_table[] = {
+	{ ATH11K_HW_WCN6855_HW21, "qcom,lemans-evk", "nfa765"},
+	{ ATH11K_HW_WCN6855_HW21, "qcom,monaco-evk", "nfa765"},
+	{ ATH11K_HW_WCN6855_HW21, "qcom,hamoa-iot-evk", "nfa765"},
+	{ /* Sentinel */ }
+};
+
+const char *ath11k_core_get_usecase_firmware(struct ath11k_base *ab)
+{
+	struct device_node *root __free(device_node) = of_find_node_by_path("/");
+	const struct __ath11k_core_usecase_firmware_table *entry = NULL;
+	int i, count = of_property_count_strings(root, "compatible");
+	const char *compatible = NULL;
+
+	for (i = 0; i < count; i++) {
+		if (of_property_read_string_index(root, "compatible", i,
+						  &compatible) < 0)
+			continue;
+
+		entry = ath11k_core_usecase_firmware_table;
+		while (entry->compatible) {
+			if (ab->hw_rev == entry->hw_rev &&
+			    !strcmp(entry->compatible, compatible))
+				return entry->firmware_name;
+			entry++;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(ath11k_core_get_usecase_firmware);
+
 void ath11k_fw_stats_pdevs_free(struct list_head *head)
 {
 	struct ath11k_fw_stats_pdev *i, *tmp;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 3f41e6569a78..a0d725923ef2 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1292,6 +1292,7 @@ bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
+const char *ath11k_core_get_usecase_firmware(struct ath11k_base *ab);
 
 static inline const char *ath11k_scan_state_str(enum ath11k_scan_state state)
 {
@@ -1346,6 +1347,9 @@ static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
 
 	of_property_read_string(ab->dev->of_node, "firmware-name", &fw_name);
 
+	if (!fw_name)
+		fw_name = ath11k_core_get_usecase_firmware(ab);
+
 	if (fw_name && strncmp(filename, "board", 5))
 		snprintf(buf, buf_len, "%s/%s/%s/%s", ATH11K_FW_DIR,
 			 ab->hw_params.fw.dir, fw_name, filename);
-- 
2.34.1


