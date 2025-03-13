Return-Path: <linux-wireless+bounces-20319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13BEA5F2E0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 12:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607ED7ADF91
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 11:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23B268FEB;
	Thu, 13 Mar 2025 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FhyFqFtj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF742661B8
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866107; cv=none; b=WlA23iZ/XI4DRtzo+w3mmiv0QMQxm3oaQGFQca48Ubg4FtIPsqwG14c5s2wspwgnFNhX3sErbNrhHTcmp1qFICIJ8QRCvKfO3+lT9QawylyQu60k5SYn5qQIZ+g2CqK0i+O7Kp60lbyw+quPg6wUSvguTZdxuskZU2hb7MaMyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866107; c=relaxed/simple;
	bh=YwmsO4C4jzMys3yOFXfr4pKkNHJr9gwQXUbncX4449Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPGsj/JqyKksgPK6VyAWd7et1se2+z7AcdoBB1xfUjaD3fbpvTTRqitVFMm4yxJGrihRxiXV9nkeSZPSvYqVD5xgjn3vTq3fGiHx3CS2Uf9cbEEqPakKW4vpyuunnD+Ep4Bj7DMQzvWrtWNnxgMAL/5t4MIrqG3Wm89887NHh+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FhyFqFtj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DALZ8b003496
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d9qoisNOG/J+QBYyjCN2S8XuP76MA1VccskcGW+lCGw=; b=FhyFqFtjZKeb7Tme
	9j7nwFU6jIELF+7849JGGhbLgkzQyEYYxfwvnp+6CwsqP2ImuhrQ6IkdhMd/cNzL
	NBEo/2zBc3eIRCeKe778/VPjyF+ixwOLnyOItKkqNQbnEWpe4LM3Ub0XKqXQux9f
	x65A1I+qg+TAX4w12ujZXutnRYgV+Epuv6iELyjZNmF9s9pLkMCGDMdepxOhq10N
	OPOzlfD4YcsJ1xmofyEXTwk88zFpv4YwFUvdmlfnZ9LorYkelan+PSKTjAg3Lhr/
	pdPc+rjWodzuT8RTW+kxMVKmAL9hR7gTELCCw2JvO9hJlACS48osyHHJb1qBuUzV
	Wwg/3g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45b96ybkd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:41:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso1607620a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 04:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866103; x=1742470903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9qoisNOG/J+QBYyjCN2S8XuP76MA1VccskcGW+lCGw=;
        b=O5UNaJfGepO8Z2tACllWHofL/czTHm1e5YZsSZwydho8p0uo8WhPB/yYu3K/pGJdvE
         lBAJ+rf6rHUzIY9GHEQaPDLG0OvpQxQdDIDxyIoBXzsqpSUA2Bql0bCEHYeSTFLCHuZU
         Rhgte29T8iwrWm3UneHWOJt4mIPpsX2lp/Dnics+Z//L8PqbePAcCyIPkTH0dJote14B
         7MG8K1ZMuhOpUpvEOVcCYAw0y8+vXA3+dlHfgzxDBv7EqONP2XOugi8RSjkN7bwi/Dxg
         XUYivHtFELE6ZkGkN3zIlkBDmN4U2mZ9gbqsM9eEAh6/OKYiIHrM7aouTCx3xyvGESxJ
         kV7w==
X-Forwarded-Encrypted: i=1; AJvYcCWBVvC13gIv9wG/Kp2vnrC5QXSFtplXQBfIhUJ0JOAU6aNKfuT59ejloZtF/wADxLqtxccWfuzeHns/zuhajA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytaYSfY0tgSe77vgUsVOqEGlkiLl28GrxJ7VOKH1cXLwNYPJ/b
	Qzo/UrjGUk4neSRS8xq1dSjomLWC6TnIEOr5Yw+YjVdXdNPnmPHMTL+EKRWNk4m/kaDI6Ej/Ba5
	kxKlXaECrOWzMIJATuZNXQP1gqrWqBJok/kKkCyI62tqlFDyU+o4YvtwDaPb8C6GtVA==
X-Gm-Gg: ASbGncvd6s9iZ8GauHI1yzguHSJlp+jwFmCrMt6lmqfCYN9KBgqSOFiqzrQYo6Vmpbd
	7NEg8g4mp+URrvsb905G3EmyWE/ive3FSO+jjvaIXRjOD8sUXwJRsW3Gl/IpACB/x0OJvp/Uxes
	yM7dwXDbEsZynfjSqohcMdeaOKe2IPyoozl6xusdUMJqCKSHvG0Mc5gUEHvF32KSpeaJoPTTWAB
	ai5dYfc6771CxYQCpCeV6oUdVjTd//MzKbwzZUD3WnPhOL31Aw2xItRjchmnDPsq9kI+9WWYNeY
	lgwhQIu2iMro7lzxL5sTasOpe/fx5O8yGdy33dMWkRHuKSdo51A=
X-Received: by 2002:a05:6a21:a4a:b0:1f5:769a:a4c0 with SMTP id adf61e73a8af0-1f58cb40d0fmr19674111637.22.1741866103023;
        Thu, 13 Mar 2025 04:41:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4KS059o50FJ3zNErZOLROVvjQZDc2HgJ5OaS3d/rE1XNS/o6bFbi0r6LR6J9lgfSFiRTe6g==
X-Received: by 2002:a05:6a21:a4a:b0:1f5:769a:a4c0 with SMTP id adf61e73a8af0-1f58cb40d0fmr19674070637.22.1741866102667;
        Thu, 13 Mar 2025 04:41:42 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea964e3sm1063219a12.76.2025.03.13.04.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:42 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 17:10:17 +0530
Subject: [PATCH v2 10/10] wifi: ath11k: add support for MHI bandwidth
 scaling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-mhi_bw_up-v2-10-869ca32170bf@oss.qualcomm.com>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
In-Reply-To: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741866038; l=2735;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=UDj4phVy/DG+9hjqxt6EGxZVpcx8i+kJ4nOzNceABAI=;
 b=hqdCuLeJn0OqieMuIehjgOVSVH10bKZwuK9rz+XDm+BSXBAIpRQvbjfXjpv4/+/BYkNxW94aN
 OFUd0jheytFBkp8l/OA96dvuqcapnrWdXf6JwA+9nMflIMTRzatgsbn
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 4Czn3cK9mEb6LXqIZugrIYMzZ6Wlkmbt
X-Authority-Analysis: v=2.4 cv=I+llRMgg c=1 sm=1 tr=0 ts=67d2c477 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=PcFPl4qhhl0nOZx1bFwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4Czn3cK9mEb6LXqIZugrIYMzZ6Wlkmbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130092

From: Miaoqing Pan <quic_miaoqing@quicinc.com>

Add support for MHI bandwidth scaling, which will reduce power consumption
if WLAN operates with lower bandwidth. This feature is only enabled for
QCA6390.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04546-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 6e45f464a429..74769c0993ae 100644
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


