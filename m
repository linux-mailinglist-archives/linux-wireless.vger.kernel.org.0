Return-Path: <linux-wireless+bounces-20311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAB5A5F2A8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 12:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B0A19C08C9
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED085267718;
	Thu, 13 Mar 2025 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D7zcjwyd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4F2676FC
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866059; cv=none; b=Fua3kmYbQj027rWFF708h7iWKV2OxUxAVHm/KeO5G9OhohhvjbOW/grwDy0/n6tkHscPxj3ZBmjaPX7mhCKzD0MvTVU66oS0ZdpVqvRLpGBUs+mOmi8+DjoQtI3kHr3ffmuCat8zXay8iIOxmTRXVVZMpY1e7ynKNYjEEuD5dHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866059; c=relaxed/simple;
	bh=QF3t9Npqd6WDL13WAUYjPdc5+X7unsf6GqmoGDJ96Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/p5jkINrdWqF2LCRUPc3ZBRYNC/cHF5b96eOgnttSCFSv9U3gGx0zJaopscuwsDIQQDi9JHd+fvgTBLlVgbriq4w4F/iM5kQKvIUYur2OXA+jmhO990+TFLXeo6v5ypgI4JPL3rpK+02G1TpIA2cqmE+G4F0/4Poc7XpNHwi+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D7zcjwyd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DA57EO016250
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5GoHPsMjXm5WsDmWxnM0h27fytbmRrNNVtygHs2kjM4=; b=D7zcjwyd3nxjbkyD
	L8F5kMF6t5s4kPxVP+XefOlrFWqJVP91MKFJkhPTbX8xBSM9TXE4CQcrUe9tZ7Oo
	ombXmms9Y5wIkIlEJTa9nKMR+WUcPZIFm4Ajv5dDlRZ6w2fzz7wZkjDDlU3q8R1Y
	NsUTNAH0Q8vto8cgamYPDPfFXVpq6q9l/MNtGjQBzh/u1dHG2YpfKUdgxvdWjTvz
	Ytfwan9UYXjHB4JjLU6+EqFPO9NXNZzRU/hHnixiT4C650QHefjl9TPB/EqT3I4b
	DkQYbsuk/rvjAhYT+nFHm3711xSSonYRh9q8rswo66NgpvenpaqXV+1EiRCQJW4U
	z/r+cA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nwpur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:40:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso1634036a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 04:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866057; x=1742470857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GoHPsMjXm5WsDmWxnM0h27fytbmRrNNVtygHs2kjM4=;
        b=ABLuysS/2a7ZHpziorlDgj2uVC1x2j2iwCEmyZXDE89IA6vGBRcz3krhyCWYrCVKdn
         08XOMo/uMaIqknQZ1kgJBHy5dwIgpIcj3c1Mm7OBbT0czzSAJyPjLgobYmwd5m7lLKfh
         uNk+fS55b1LOcBA7jdAmG3mgcy5jk4hBIvfJkfVNwNT/F6pdKEE4aYbSB9MJgMWekyNi
         AibuFev9/MmE7V2yKOD9rkr1RU8NSnVgQiV17CR4/z3L/vj5yzeGJa3THIel16yBPDGd
         nzjV2Y8WsvOihNncQmvVZ9umrf11tAuDwR7mXI9+jCEy3h1rU4MIruux6wJ471MKg1t8
         bPJg==
X-Forwarded-Encrypted: i=1; AJvYcCWceK8rouLHd0O9rYyuqyF77aZ+/BD/OvVUadOoUnBkdrwAGNJ9IJEKmUYml7WzBNjgjLK+6UPkYzi/sAu41w==@vger.kernel.org
X-Gm-Message-State: AOJu0YynIUzzNC1+tvCjCHiVaNk8KMc61AED8KmMq1hLWZTNz00hBSAb
	ZBFFQ0MkSB9lV/p3VPJf7NvPdFA0M36pvnx4tEMyVI463A55VAh3dCOFCrRqyZtFsL4GUntpzwy
	Hz8vAuDCDJempipIlX+or3Fb29QAEqosKNmY+hCojKyC7hsRJGHhHyjttMymuUrPfdw==
X-Gm-Gg: ASbGncvSEQplf+vIfykuEoKazVAofOBmWAVFRMIwAHAM7UfnoPZ/T8KdksIH2QYG9kH
	IYqnt3b4nEdNWt2hLBC4N5Te0eSTIwhtaFlFUda6KGMfl72KCtr3fqtM5uFC1flpRDgh108sKgq
	/Vz7Usm/2YJRor45ZvXvNKikf9miW/Gkpb/GDjOCE2g24crn+r7RApzgoC3LGgPulm13rs/di9F
	+BnYjIoYOWyWk/A5b0QVC+Y9bOecy7wt3zMUKff2PmaTJrDMEAz8s12AiptX09dsirA3XQN+s9J
	BxWsWkbM6VIMF19U5lLkEYGfEfqTFEqpgh9QMycw68kLxhy83Us=
X-Received: by 2002:a05:6a21:6e01:b0:1f5:7873:3053 with SMTP id adf61e73a8af0-1f5787332c4mr25422497637.29.1741866056560;
        Thu, 13 Mar 2025 04:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVPPVaqt3ccoP6Qi6iR+F3/+FepdazbfVoBgBB08wJlm086Lrkra8NnpQV4ECmwIxgzuhyRQ==
X-Received: by 2002:a05:6a21:6e01:b0:1f5:7873:3053 with SMTP id adf61e73a8af0-1f5787332c4mr25422454637.29.1741866056162;
        Thu, 13 Mar 2025 04:40:56 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea964e3sm1063219a12.76.2025.03.13.04.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:40:55 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 17:10:09 +0530
Subject: [PATCH v2 02/10] PCI/bwctrl: Add support to scale bandwidth before
 & after link re-training
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-mhi_bw_up-v2-2-869ca32170bf@oss.qualcomm.com>
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
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741866038; l=3703;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=QF3t9Npqd6WDL13WAUYjPdc5+X7unsf6GqmoGDJ96Z4=;
 b=r9fy/TEQIugEusXyzLXabUGKObbPiDQA2y0cW3J/suds1DrMZVbsdRhS6C69uzJ4DGZnytm19
 VjGnvA/1AohDqYs2XNcrykXd1/23Tf2WTarVjm71yVNjL4/h/JZY91N
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: KxkmZS_CrwmZI8I-lbN5yKcf1NvlBjTV
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d2c449 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=p-QNkzJndyCg75AdzNkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: KxkmZS_CrwmZI8I-lbN5yKcf1NvlBjTV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130092

If the driver wants to move to higher data rate/speed than the current data
rate then the controller driver may need to change certain votes so that
link may come up at requested data rate/speed like QCOM PCIe controllers
need to change their RPMh (Resource Power Manager-hardened) state. Once
link retraining is done controller drivers needs to adjust their votes
based on the final data rate.

Some controllers also may need to update their bandwidth voting like
ICC bw votings etc.

So, add pre_scale_bus_bw() & post_scale_bus_bw() op to call before & after
the link re-train. There is no explicit locking mechanisms as these are
called by a single client endpoint driver.

In case of PCIe switch, if there is a request to change target speed for a
downstream port then no need to call these function ops as these are
outside the scope of the controller drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/bwctrl.c | 15 +++++++++++++++
 include/linux/pci.h       | 13 +++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 0a5e7efbce2c..b1d660359553 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -161,6 +161,8 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
 int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 			  bool use_lt)
 {
+	struct pci_host_bridge *host = pci_find_host_bridge(port->bus);
+	bool is_rootport = pci_is_root_bus(port->bus);
 	struct pci_bus *bus = port->subordinate;
 	u16 target_speed;
 	int ret;
@@ -173,6 +175,16 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 
 	target_speed = pcie_bwctrl_select_speed(port, speed_req);
 
+	/*
+	 * The controller driver may need to be scaled for targeted speed
+	 * otherwise link might not come up at requested speed.
+	 */
+	if (is_rootport && host->ops->pre_scale_bus_bw) {
+		ret = host->ops->pre_scale_bus_bw(host->bus, target_speed);
+		if (ret)
+			return ret;
+	}
+
 	scoped_guard(rwsem_read, &pcie_bwctrl_setspeed_rwsem) {
 		struct pcie_bwctrl_data *data = port->link_bwctrl;
 
@@ -197,6 +209,9 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 	    !list_empty(&bus->devices))
 		ret = -EAGAIN;
 
+	if (is_rootport && host->ops->post_scale_bus_bw)
+		host->ops->post_scale_bus_bw(host->bus, pci_bus_speed2lnkctl2(bus->cur_bus_speed));
+
 	return ret;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..9ae199c1e698 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -804,6 +804,19 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	/*
+	 * Callback to the drivers to update ICC bw votes, clock frequencies etc for
+	 * the link re-train to come up in targeted speed. These are called by a single
+	 * client endpoint driver, so there is no need for explicit locking mechanisms.
+	 */
+	int (*pre_scale_bus_bw)(struct pci_bus *bus, int target_speed);
+	/*
+	 * Callback to the drivers to adjust ICC bw votes, clock frequencies etc
+	 * to the updated speed after link re-train. These are called by a
+	 * single client endpoint driver, so there is no need for explicit
+	 * locking mechanisms.
+	 */
+	void (*post_scale_bus_bw)(struct pci_bus *bus, int current_speed);
 };
 
 /*

-- 
2.34.1


