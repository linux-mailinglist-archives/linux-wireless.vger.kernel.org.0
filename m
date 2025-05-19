Return-Path: <linux-wireless+bounces-23151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AEBABBA37
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 11:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A4D18861A9
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642ED278174;
	Mon, 19 May 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cofpnuv/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6C27815C
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647838; cv=none; b=Dl25lC/+wElL6o1YextL2qCHBb70CrbV/3LHWM+UXoZxqebsn0c/v7PgpAmWJlLwuWXVU56skptGZpfZ98qG0hQX7Pw1+7Yqd8ZrknEi0TXu7CscH2ceGiar+8M5yQu8OR3+rdl++mrB7nxuWqndPZYQMFxmT/HFjeDNu1aW0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647838; c=relaxed/simple;
	bh=T0NWxEeit0FkTClv+OgVI5h2belfjblWs7pI02lhyuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MptZyr204NzrtFN8ryIk0PtwHsXXefba7YUPV2MoPXwqcqVDsNV4b2nuls223MDE1AaZPQOXq2lqzWRaXAo7GcuNvpEwxzpOlj/YruyLWrbSKfp2A/tNgwUQuUtgn5e3GJgunhE8kVNFJwu5wVW0G9OO+ZOItN2fWk7+ee0PWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cofpnuv/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J4F8f2014390
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qRVHI8/PRu42Vqh4HuSgclK2SbkQHWxggBlquWyWIxQ=; b=Cofpnuv/SbPbPmum
	mOg/azUhsuV9+yaOnOWWnXp43mis01mYqJ/AuFutf9LrYHERSJD6HZqK+FAIIoc+
	0dsW3IVCzIBrX4xqZEx4iwcFNvOUcUmmlUTwkCaY7KeK3vydbcj9gVFPr7LoLMMm
	8PpTb8iyq5gKfYDwoooQrOfoAcssj6cxlpjQiJlHwjP/A8TxnyJQLzJxm4VWaorP
	fR8m3uLyoh9mctfKKm0vpL+QTCElfnLatCKGL/NNDkCS8yFsEXB1Gxvfh5zghEA2
	aV9MChn3tpJsjz/mAF+Jpaw2uT05ew/JKG8UtKqVGS74hAMZEElrkd1wQZ6ZhDCm
	y4v1UA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46qwengx8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:43:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74292762324so3150430b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 02:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647816; x=1748252616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRVHI8/PRu42Vqh4HuSgclK2SbkQHWxggBlquWyWIxQ=;
        b=nrE0WrXiWhFA8e73TTqlrZ+9vED8JEnif6DFnj8ikFfatuKGLwXeQ7In4F0HWHgPfT
         0c9eJYNeJi6LUVWyrt29q4WphjTKvtVq2pY+lfeSx7RgVP1JjA9xBqAuSThkQ/pRpIzI
         44zueBDMo9tZedNLU+/8j4hF0vjJOnaEJs1IYChg4nC6SyhHzurzFmzvw9Y/OnjU0K5J
         uuOsQb6Sb5g4CGHChoR9J+xxYSWNt2rSlHGFEJxC4IbtnPj4N/PVqh/vpol82Gv1wUpr
         lyIU+IdnusCCPUnM+v5gLswrAQ3zOVie74mTAB+Z0e8Ki6YJzlxur8qoc58ellwwa3EO
         ClWg==
X-Forwarded-Encrypted: i=1; AJvYcCUkW4dj+co6gBb/32hm3UazsuHVkTzOrLfSdmw3ASYNstVDBXl8QQVvDeQV531yfpJfzlYmOD8UGlzG+QYZWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUbEnxyZnm/R616Lh7pdre63vEWKrFVrYLvjtsf/9a9/rO5jXo
	LnWLdpYuButxNvO7bgIxZjVz7kEkacGPcdUFwIdZDwZ/p+8g07sX6l6Ak3/nErvoCp8Zedo4C17
	rxUUMoY1TjMZsan3d4+gMIhin/Y7hSLRSv7O5lK/T6STKEDFlSpnaL6kE/IHBeAZGH6rAqg==
X-Gm-Gg: ASbGnctjPQBZ6rY/IjbqiV1EwxuFFDZ/GGH/VtGP9mV/QUBUOjt3sxi49Oy6eHAE/wW
	up5P8k9kSqnf4NnwIglB88T2Nqdbf0P/TvLkHZKpvSwfEA2wWk6h+4fkMl3umQzSx37GwT8uzMG
	rYGRoMmv15qsEMLwQCqRXtRQVI8pVn3rm/lwXOqiXliKElkmgYiBFzETy5E/6lOe7OlFnNEz01R
	UCN1ltgS4frInhDB5kSSbQMbveaHx+0q+QjhZCY9D86RQuOgLmrfb0HIRlui1lvgj1LOK7CrYxB
	HRAFlrXRbfcDeMlUB3a3T7sXOsvIIbGbRtwEXIuyRExil3I=
X-Received: by 2002:a05:6a20:258e:b0:1f5:7fcb:397d with SMTP id adf61e73a8af0-2162189eedemr17085539637.16.1747647815825;
        Mon, 19 May 2025 02:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBn3YQuItzmOTeDJuwyBkkScPtNvgmsDQnEm68ODCFtCJxD6yFeqm20eMNewUKrXrunStz3Q==
X-Received: by 2002:a05:6a20:258e:b0:1f5:7fcb:397d with SMTP id adf61e73a8af0-2162189eedemr17085507637.16.1747647815410;
        Mon, 19 May 2025 02:43:35 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm5809092b3a.78.2025.05.19.02.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:43:35 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 May 2025 15:12:24 +0530
Subject: [PATCH v3 11/11] wifi: ath11k: Add support for MHI bandwidth
 scaling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-mhi_bw_up-v3-11-3acd4a17bbb5@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
In-Reply-To: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747647743; l=3170;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=iRU0Yv6S7aDJfgJ0sXHZ6i8h1thDD71OEAeHK48lWWg=;
 b=pXC6t6KaeeBZiubaUAqowVVgtQcd663spifrqVy/Jik6wxRwizcXUr66OHogqm7b7P17DWCKX
 VrPMhEfEqf+B12YjfPKGzQBoQhF857+WH09MfRydBuondK7ulCXpE33
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 0apaF2KRUWlGiL_dU0B6oGLdz9nERpAW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5MiBTYWx0ZWRfX5br0NkqqmWlF
 nQAtoNF2hg3FB6dezLTIKIY+SZfszizdCc9a3b/xdBTJ0PceZRj4ccGbk5AQtmNbonTTTnTBmss
 wiJIIGIuRbYLDz1joGiwG++zXvlx1kN1SK1+DF/16v+JHvbqSeAmerFqK8PvwSyWbV9OEnGn31e
 3i54bHWWWMYqYXwMF9HbVWFhtQSUP8m6AIqApPQ+7JCfKTWCJfZNghQXQiUiQWzJyBqXwy5C0k5
 aBTCj2N0Pk8ysJTNRx13TzOPLsM51Jbw6XFm8a/u/mLatwLBWPciDz3A2JGLUE/KwM8EornPp3q
 6c2859K5Zo/WLY8sumMPB27DtlWfGMQoS6J/Yiuf1vIyiwgPfgG/CWVl9k8qQ3MrAnVrYm2DOJU
 RjUGmtnYIT+mYCtfOX9fPjUmb/onvKNlNPAxeeYDVRyC2uHioPYjKx3v3GZDqlTlTymW5Kb7
X-Authority-Analysis: v=2.4 cv=Wd8Ma1hX c=1 sm=1 tr=0 ts=682afd5b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=262QNBeyodYRG1lUGOYA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 0apaF2KRUWlGiL_dU0B6oGLdz9nERpAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190092

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
index fc77eac83e953148b96cad096d26b32222157b24..8057031d654d794f9e882a975f99083c193e492c 100644
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


