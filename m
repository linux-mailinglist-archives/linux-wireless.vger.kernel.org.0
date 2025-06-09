Return-Path: <linux-wireless+bounces-23850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C19AD1BDE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 12:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2520188D2E4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 10:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CA82580DD;
	Mon,  9 Jun 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9zComcs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE8257AFB
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466319; cv=none; b=i7KYf7v1gMNmxwpMDIhF9RdlkE+0QiAJF7Djmz10EYxPtfYXc8Fo1D7j17S59BQt33lS1EAknCtC2aY1WVm3nHLXsebbPkOcDbhn8GSyvmZEGMv/GFPI9O5VY1xI7l7DX0dbymzdH4SYR7VpSFm5F+q3QKf8ho3dvehevr+S3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466319; c=relaxed/simple;
	bh=a92PRGNUNrfHcs8KDpNTetPfxsdyIy5osxzi+vJe1No=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uY0QwFGAESjiTHIeMsjEWR8EmbV1fjLzxGm9FIljcZV7cCIYvzVzm9kSebDe0N8vtUJQy6nDgFUVd6p90D3dEfHOUWFFdNS0TuzBcaAdFY6QxWDlDtiIK47HixqiS5wxJfZy7629pJtHN6l6g/9fpz3ev+m5UmuEwCgxhfEcSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9zComcs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55995iqm017514
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 10:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+WnB7SCx1sSjpKFGf2TGgRqSA56lOzErLbFukBFtOrU=; b=E9zComcsbVuP74kv
	F5FxwcDfUY71bl5ezAMP2a7SDHlkQbj0b6ztptvsN923Z4XT4H6WM65AmGIMtzko
	BsxU/+SLLgOXmpEc2fMYm2eZbJXHoT6tEPpd0Tk4C0w33eDGqyYkiH56z7cyJq6e
	0DwtndcFJmu7q2UajswYtNjTJNkcpeblZpvgZLKVQ1WDyXCWQNMMxlYcNSs03iFS
	q2g+lsq/R3b6SuwHfVe0XJ73bSlLHqHw08Hvv6u9inmKX21juutSNLaWfxcY4Pmv
	y1Gg5Ar31tsnA/ktW4UraRZ4N8ulSlP8Yu2H07H+JcFis7rBatmIp3C9Dl9sz/I1
	9oBWiw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475g75t1cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 10:51:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234dbbc4899so67847705ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 03:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466315; x=1750071115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WnB7SCx1sSjpKFGf2TGgRqSA56lOzErLbFukBFtOrU=;
        b=mxWTTK9lxCJ0GqKGff27mnRCnE/R8/qvmVghqhYJQFpR5BafaWNC1IbfNA+wlX7rUg
         k8J2vqR2Fay5Akp9/gy6H1wu4sQhf1QqXgy8EH3u92dH9wWDqAnMRGQ6g+R3S05nDN0m
         FM2ZRvjOxoYhePfEsavVwqRkkTHSr7lkDjT5gNtpPvAOPz6G4w/JWMbr0K3cIs4nqGqI
         p4j85PDcqbX6gQJrLnn7m9yLyeW7nXvI4hE/+1YW+8RHl4pMRGhzge9Man6W5zYXn43g
         nUGm3wVba2cEir9tTzYc4XnGlGHQdMTJvodm1CdANUq+w5tV7di1gLNhykJ7I56HPCbD
         MsbA==
X-Forwarded-Encrypted: i=1; AJvYcCVFA5iGKObwWUImF8Z7MQy3WamFCe3u22BhwVEUqd0GAineFDi7Aga+K8mmMBpjeDNE2f3kk/0AgEpVWCYmOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpn6VJOrvsoe2Utfs3J5sW175hmICGAMYfU9eHDXFb2LCzyhGF
	56GOSQphMCrwShluOrff4cn39d7c2CbcYjmpAzKqw7MahTFRhMfsaZYIttaXfyUlapl/jTpXZSj
	uluTTWq4vGNwyHQZFy5q3nGB6cv3Lk7Mf7He/sbwP6hj5qd7XeXBmKb0sn+Wy1MA3lEHnvw==
X-Gm-Gg: ASbGncsjdLSjL1x8VuD1E5uxHtcrRF6FeFm6IwF8ai7Kj6XsSwOcvgT9rSQJybYdOVe
	7vHP2ThOVYPfUeuNjRqDVV1ljA3Y8miQ/jIi4XJX85wjBIbGBa73ZFJlDpZLT1vnYd8FQ4SSDet
	7pLUsLmZhCV2takTQ5FXLs2z9PlIyzMORjrqhO9tyGiRYQa6tU9hGZDMKPsFxHSTMtCvzcCr5Cd
	Yfo3ZimG9wRMhEusw0kP7jwwr0W1TAPu7krhLQrSMepLmcJbwHota9UnnwTgxBRzosK8PZrsvk8
	hEdYztHQqj+u7W9qtUOpmD9iAcUnBeXLlPYdKTB29i6QeNAdT3i+oJSUCw==
X-Received: by 2002:a17:902:ced0:b0:224:24d3:6103 with SMTP id d9443c01a7336-23601d7129bmr193945885ad.35.1749466315154;
        Mon, 09 Jun 2025 03:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZzNGiSveCaXAGmwtao4h3zyuFCWnr+dvJQS7X9x0EspRwQDlYIe+sfocOUBtwpZVbvfenNw==
X-Received: by 2002:a17:902:ced0:b0:224:24d3:6103 with SMTP id d9443c01a7336-23601d7129bmr193945685ad.35.1749466314751;
        Mon, 09 Jun 2025 03:51:54 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:51:54 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 09 Jun 2025 16:21:24 +0530
Subject: [PATCH v4 03/11] bus: mhi: host: Add support to read MHI
 capabilities
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-mhi_bw_up-v4-3-3faa8fe92b05@qti.qualcomm.com>
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
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=3193;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=YHDxvxn32l4GiIqpkw0a5BDQyd01kwaHJ7Ari+cyZhw=;
 b=DP+yy3+lpPTfsiVUb0XvmLVgjM8De6zxu8hdMbo96oYzwD6QES2VKKMQTmLaH1CE6MUJzipa+
 DTAoju4J5e6DK6smrc+9F8YhHpnmnbR7S5Yt6qFi2oNVysn4xALurSH
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 1Vsf8sleixzys4k7r9ozX_eGZ4YHOzVn
X-Proofpoint-ORIG-GUID: 1Vsf8sleixzys4k7r9ozX_eGZ4YHOzVn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfX3H+D+W4oZyCH
 8NDav3a2wi76PdeCYGYCBx377Aa7090v7s7NjCnefOjo+d6rNYErAFvYNHsdWIvU0YXfCWZSOj7
 /lsj45Qrpdxrs1958vz/RQhFqXYufAfZ0OfqC820aLg2MjeZOjxr68gWZz2ZyZ2oYDYiPl0+KGc
 SpcyEhoDprmDUDZviL6mVXKXqzwklXrLcg5E+l7uM+rlphWQe5Gz59887XXmKpEJ73m7TpFOLvc
 jwu7YxO5DlvanVFLnbNDsQw6WSaXfIM95y1hTiZLqhUovEUX3YRPWOEZbLvizQG8x+2RDZ5hOMC
 cbzr0UM9KMLlHbevdqK1A7omRBg1ykALSJF3IuQDjSTXDPv0lABfSAdUXn5rxtbNWseNM1U04Qb
 XiIvqvWUO7WtlV46oLzpGg8AtY4mgmOMijGdpQ94AsWxOdaPe9U0/oYKPs+aC1pvsiYuJb7D
X-Authority-Analysis: v=2.4 cv=TeqWtQQh c=1 sm=1 tr=0 ts=6846bccc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=CnzCB1l8zP_khqs2e6IA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
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

From: Vivek Pernamitta <quic_vpernami@quicinc.com>

As per MHI spec v1.2,sec 6.6, MHI has capability registers which are
located after the ERDB array. The location of this group of registers is
indicated by the MISCOFF register. Each capability has a capability ID to
determine which functionality is supported and each capability will point
to the next capability supported.

Add a basic function to read those capabilities offsets.

Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/common.h    | 13 +++++++++++++
 drivers/bus/mhi/host/init.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index dda340aaed95a5573a2ec776ca712e11a1ed0b52..58f27c6ba63e3e6fa28ca48d6d1065684ed6e1dd 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -16,6 +16,7 @@
 #define MHICFG				0x10
 #define CHDBOFF				0x18
 #define ERDBOFF				0x20
+#define MISCOFF				0x24
 #define BHIOFF				0x28
 #define BHIEOFF				0x2c
 #define DEBUGOFF			0x30
@@ -113,6 +114,9 @@
 #define MHISTATUS_MHISTATE_MASK		GENMASK(15, 8)
 #define MHISTATUS_SYSERR_MASK		BIT(2)
 #define MHISTATUS_READY_MASK		BIT(0)
+#define MISC_CAP_MASK			GENMASK(31, 0)
+#define CAP_CAPID_MASK			GENMASK(31, 24)
+#define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
 
 /* Command Ring Element macros */
 /* No operation command */
@@ -204,6 +208,15 @@
 #define MHI_RSCTRE_DATA_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
 							       MHI_PKT_TYPE_COALESCING))
 
+enum mhi_capability_type {
+	MHI_CAP_ID_INTX = 0x1,
+	MHI_CAP_ID_TIME_SYNC = 0x2,
+	MHI_CAP_ID_BW_SCALE = 0x3,
+	MHI_CAP_ID_TSC_TIME_SYNC = 0x4,
+	MHI_CAP_ID_MAX_TRB_LEN = 0x5,
+	MHI_CAP_ID_MAX,
+};
+
 enum mhi_pkt_type {
 	MHI_PKT_TYPE_INVALID = 0x0,
 	MHI_PKT_TYPE_NOOP_CMD = 0x1,
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 13e7a55f54ff45b83b3f18b97e2cdd83d4836fe3..9102ce13a2059f599b46d25ef631f643142642be 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -467,6 +467,40 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
 	return ret;
 }
 
+static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability, u32 *offset)
+{
+	u32 val, cur_cap, next_offset;
+	int ret;
+
+	/* Get the first supported capability offset */
+	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF, MISC_CAP_MASK, offset);
+	if (ret)
+		return ret;
+
+	*offset = (__force u32)le32_to_cpu(*offset);
+	do {
+		if (*offset >= mhi_cntrl->reg_len)
+			return -ENXIO;
+
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
+		if (ret)
+			return ret;
+
+		val = (__force u32)le32_to_cpu(val);
+		cur_cap = FIELD_GET(CAP_CAPID_MASK, val);
+		next_offset = FIELD_GET(CAP_NEXT_CAP_MASK, val);
+		if (cur_cap >= MHI_CAP_ID_MAX)
+			return -ENXIO;
+
+		if (cur_cap == capability)
+			return 0;
+
+		*offset = next_offset;
+	} while (next_offset);
+
+	return -ENXIO;
+}
+
 int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 {
 	u32 val;

-- 
2.34.1


