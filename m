Return-Path: <linux-wireless+bounces-23858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EE7AD1BFF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 12:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2290316B1B5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E5725D200;
	Mon,  9 Jun 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oOmf0hh3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC32571A2
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466367; cv=none; b=fQfPGrdn7QYptrFspKV5LRjERTJw5+9LPBlpl06vfL0xQwW8s+1+ANzB9x7lG+HmJJjvbsRojLScU+vfNW/4En5PauMIiW+tyw2qi+V3uBwIXEy/4uKbLrcL1y44o/lhN//rF7Rr/h9gqdvQK2gsivefKvSkx01WuWI/hR80ro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466367; c=relaxed/simple;
	bh=SCzRjnsF82IPQ+p5OMRJvQtpgb4O/1tjQ+rlEoSNyUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N0s4w0Oz8HAu8fa2X/0AC+7dqOEEZmvRYC+9083nRiZwcLrPQ3bT11lZmYNJcD+qx6JlFFB7/sx2rn+h/hVeF6Fn/LLyfPM3AXqOTMfRk0sec8rUEelyBhfNWnc7sL/titVdx2pf14vC06s027FtqV2EcyzbrU3E2zWTz96JNpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oOmf0hh3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599dHhk000483
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 10:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XMSKmDs8UZabzmzJG8jBh2aHanEhhhPV+f/N8Ve7e2c=; b=oOmf0hh3N51YlmXq
	ZKEYmu08rgyq2kYpbz5jERVIzqb/rPyo186IJnjtxAdf/TDDkbDqPzshfEWuB4O2
	yzv12cwASwYq1BLmbM3MGO/XGzX98O8NVeVjrQkRIKDsQjUQSpMXbf6qNGFO2XPS
	pt0e+cuDzwQ8ilo+kqBxhFCdIuXaSsA1ij5I2mBvGoOxVRxvB8h+fcgsOGTTDk1m
	d4d3VGQ+pwfA57im0kH2nB2clEBFfH1CRvzMYSoQH2LdzY8oX+2/hEeXYCObAkp6
	iwCfeaNKgd9ggvcZ/MgXQNEOrLPvvtvNERfEftE/DE9nD5BdabJOpAm+VxnMtmuH
	U5OW4A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475g75t1fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 10:52:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235c897d378so39658565ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 03:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466362; x=1750071162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMSKmDs8UZabzmzJG8jBh2aHanEhhhPV+f/N8Ve7e2c=;
        b=mRIUUDfTBowq26CNQrPcdh/zFGytrYrWKUNrFlK6dQ+dJLduTXQT8tsAKdTXGUaZjz
         RE/Qjo7F1pi+nYyWXZPpgNvs0nqK2Z+ympVC36qSNDxJx0q+O2C2C9MmNBe0282aVYE/
         TU6yGgw/3uNjrFYtYGAgG0uSrRI92ZotXvbyyUMBktUiqQHxw2a9aw5BTs/brPBnRkAk
         flpjNw2LNSH5YpoJaDySWFE1gtcvSCXPpgy/rfW/+bxK7lVj2cq+AZhrgSylyOLJHAOR
         ccIVKd63/oswTdzT4+dMuXXRzCgBuYAdnCXVyUlsAANzISpTcFl6OyW/GGtONv1nuQQS
         nJFA==
X-Forwarded-Encrypted: i=1; AJvYcCVGX0AbRTKIygJRHju42a0cfzTL6eyhUDtTjdi86K5rFye6bX2p5olHCpsEoaqEIL+PJepAENaM7zN0LacTcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlTia3A0N89nuV8gfBlwOJdJSA9sa3q1jeMpKBELa4XZu7ogu2
	hL4pNuLIjtlk1E8H4810FoNr0bPYsncJHUIjy1bxNnmyoABpNtTOG8VG8S//Dn9vDls0/9QUPmI
	HY8UR6s7m2b6rMWhg4F+5VmRrrBVYffxA1bWMJcd2dTgovcgjo9+VCHHYvZn8vH9bJ3G6vA==
X-Gm-Gg: ASbGncvwt6akd94o4yRUGDzHV7nNBslJjifAARwY2lGXEOiQtb726SUnum4YjcDx/Wf
	c2ThiQ699TpHVNzPYcMAUXfwlbN7qc/wXSWv4Ae23TtX3aFnnxvD5chvV8U02MYa2VxnZdiAeVa
	8jNDqawk4h7Quaob2KbLptCSEg9SqzAZ0WwO2AzUVcgSob9S8DiegrqwvHtgc2wN/Vh01bB/+TA
	mqXyIjglMKlHdvL0pK65fYdILQnwqCPszw/xUZqB1GDHu1GswJyZ7XBwm7UZPdpRuBFcZ2ZPktJ
	OX5AwcqrY8rCzWPMF2tcW7BMZPJ/7oVb/gaVL68u95dXPb8=
X-Received: by 2002:a17:903:22c6:b0:234:986c:66bf with SMTP id d9443c01a7336-23601e21e73mr197952395ad.11.1749466362156;
        Mon, 09 Jun 2025 03:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWPyhHD9XxH9T4qz5fLsYDL+SED/9vTigep2ZpbnbET9oeQcBqBu94wuXuHPx0ZtmVvPvTAQ==
X-Received: by 2002:a17:903:22c6:b0:234:986c:66bf with SMTP id d9443c01a7336-23601e21e73mr197952025ad.11.1749466361751;
        Mon, 09 Jun 2025 03:52:41 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:52:41 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 09 Jun 2025 16:21:32 +0530
Subject: [PATCH v4 11/11] wifi: ath11k: Add support for MHI bandwidth
 scaling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-mhi_bw_up-v4-11-3faa8fe92b05@qti.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
In-Reply-To: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=3170;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0RMRGjVQy5V22bePXtjwsrcyRhPyFXhPokQ5rNoOCPo=;
 b=MNDXA2dYcwLCousStsTKANlp0JTVnaDX94/mS+I9WznZ/upyqZYAq8u535wBq2VkfOsmV9Zfl
 piw6Pg4EfGsDSrpvmNY6Ys/M4EwuMHln7+S6/tyI1nv1Le/XJ1OYyRe
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: l67TQeb9sB6jHwg479Q5qVbWN31kYrHH
X-Proofpoint-ORIG-GUID: l67TQeb9sB6jHwg479Q5qVbWN31kYrHH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfXxUJhcLQ6LIPq
 w2Ibce5I+BTxAHGmNHqYxSnLhLoDnWd/6stgT0LQ1iBZRC8kunP/3xmLgZJWsBYEi1GhINZ9OlE
 exepKCCralgu2b2Eud7aPuQzPqRso15+3op8ofdopFGSic/luduw1waoxBLzX+eOOP10Hx2sMMX
 Tm43xQZI41VC4xR7wC7b24ijEEjBjAkN3jc3Qh8sNq/k2NUV3/Qqgde2dmgrDqM0S7MDzpQpxly
 0kexwiuviI/z0EeJvb+UKsCtmQ7ysLmcDTEkmfsJkPBr7HQq7cZpZPEEnGRZlfWefIupuemouWZ
 gNHgqPIpw4Ija/wIJFnQmG8FoCd9kdAtQwFN/cEWOaxSC3KeL7VSzWpzScUe8eov8rq+6s86jL9
 9nT3xiaSy49QnD0vrY9xSLKTeCx0PQdNZNC2KCXzlXjzOjv8MSxLMYi75otiN4SG4a7epgYo
X-Authority-Analysis: v=2.4 cv=TeqWtQQh c=1 sm=1 tr=0 ts=6846bcfb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=262QNBeyodYRG1lUGOYA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090082

From: Miaoqing Pan <quic_miaoqing@quicinc.com>

Add support for MHI bandwidth scaling, which will reduce power consumption
if WLAN operates with lower bandwidth. This feature is only enabled for
QCA6390.

Bandwidth scaling is initiated by the endpoint firmware based upon the
bandwidth requirements, if there is high bandwidth data endpoint requests
for higher data rates or if there is less bandwidth they request for lower
data rates to reduce power. Endpoint initiates this through MHI protocol.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index acd76e9392d31192aca6776319ef0829a1c69628..f79507c7a82244f9e9d8a3ae6765df3f9432ae8c 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -20,6 +20,7 @@
 #define MHI_TIMEOUT_DEFAULT_MS	20000
 #define RDDM_DUMP_SIZE	0x420000
 #define MHI_CB_INVALID	0xff
+#define MHI_BW_SCALE_CHAN_DB 126
 
 static const struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
 	{
@@ -73,6 +74,17 @@ static struct mhi_event_config ath11k_mhi_events_qca6390[] = {
 		.client_managed = false,
 		.offload_channel = false,
 	},
+	{
+		.num_elements = 8,
+		.irq_moderation_ms = 0,
+		.irq = 1,
+		.mode = MHI_DB_BRST_DISABLE,
+		.data_type = MHI_ER_BW_SCALE,
+		.priority = 2,
+		.hardware_event = false,
+		.client_managed = false,
+		.offload_channel = false,
+	},
 };
 
 static const struct mhi_controller_config ath11k_mhi_config_qca6390 = {
@@ -313,6 +325,33 @@ static void ath11k_mhi_op_write_reg(struct mhi_controller *mhi_cntrl,
 	writel(val, addr);
 }
 
+static int ath11k_mhi_op_get_misc_doorbell(struct mhi_controller *mhi_cntrl,
+					   enum mhi_er_data_type type)
+{
+	if (type == MHI_ER_BW_SCALE)
+		return MHI_BW_SCALE_CHAN_DB;
+
+	return -EINVAL;
+}
+
+static int ath11k_mhi_op_bw_scale(struct mhi_controller *mhi_cntrl,
+				  struct mhi_link_info *link_info)
+{
+	enum pci_bus_speed speed = pci_lnkctl2_bus_speed(link_info->target_link_speed);
+	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
+	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
+	struct pci_dev *pdev;
+
+	if (!pci_dev)
+		return -EINVAL;
+
+	pdev = pci_upstream_bridge(pci_dev);
+	if (!pdev)
+		return -ENODEV;
+
+	return pcie_set_target_speed(pdev, speed, true);
+}
+
 static int ath11k_mhi_read_addr_from_dt(struct mhi_controller *mhi_ctrl)
 {
 	struct device_node *np;
@@ -389,6 +428,8 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	mhi_ctrl->status_cb = ath11k_mhi_op_status_cb;
 	mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
+	mhi_ctrl->bw_scale = ath11k_mhi_op_bw_scale;
+	mhi_ctrl->get_misc_doorbell = ath11k_mhi_op_get_misc_doorbell;
 
 	switch (ab->hw_rev) {
 	case ATH11K_HW_QCN9074_HW10:

-- 
2.34.1


