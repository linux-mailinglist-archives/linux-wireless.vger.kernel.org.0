Return-Path: <linux-wireless+bounces-20315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88AA5F2BD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 12:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E81619C0D00
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 11:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC53267F6B;
	Thu, 13 Mar 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eg5R5OUd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567E5267F5D
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866082; cv=none; b=lSiV2VpljXuj1ACgaGgNuPtWaQEhKQeJUtH/t+J8yaLxR8ay57Q585CaeEGO9McP/QVuBmj2UftOTXRE5XsxSLeu1wLnRAEPuRvunNIAIuO2wG4n/dpM+9yZTp6S/Pkg+1H6kPtqmQ0Gem3udQEFWutg6Wf/bs1m9hQPAmnXG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866082; c=relaxed/simple;
	bh=YqqLhB2sDmeRf0yvSJdYtwvNNWc93ZsNkQgc1bLXWOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=larBZJFA5nN17FMAKgQwRU0BpmR9KIyE6As0KtfIM05JcvCuiNwperdbx1/RW6DgcQicFotKQhCqCBH9Ll8F+Q4OUi7qHQPr2Z+5gzQu7/MXaOYtv+9yc8ZT4RZLd+pWrZWxySC/BHpL0ArN7zfPsT8LyuL3hoqjcsAkIO2yLnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eg5R5OUd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DAVHtI016430
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b66c7trNFzZoQyrgHszRHq0+mVYbdCkWT7Z8WHwPyWo=; b=Eg5R5OUdQy8jNCEN
	0VRV4pCIdH2ZAv4vYoi8UxipxY+HxxUIvBIxlkFhfNyJLpZ++iaUASj9L7nnAKuk
	9agqdC9uTJnmnfiTgx8boHYqwtafRDLhGII1MBBD+Cf46BUB/+L+8cXelXc7tUCh
	0gB6G+j1Wo55WTPJZbU2JGfy7tlR0MMWMeS4qtBCqGVz7oOHctsA6KQQYS9nQJT/
	yM5UWOizBiQo8K+5Hh54P0xzQiCBHLiyBL77UxjHcjUSvlWX1bNMGnltvV0drNT4
	ntTGelCrpYvOLN1wKu+yDx+i5bSt1j02XN90i4+GJyqOqItDeCVBWyj59vcN7Ek/
	RCdQZA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nwpwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:41:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so1566288a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 04:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866079; x=1742470879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b66c7trNFzZoQyrgHszRHq0+mVYbdCkWT7Z8WHwPyWo=;
        b=c8biFJ5Atf+NWWU2d3gIlwhQ2jmCtA7FRZXtnrzBSlj0aIvUSwdTVsG34CXwYUVfrF
         CLuoTl831Ksa6C5H92uN1rODxkijJkfajHm774CGCSJ6YeiyV/p8+/t3SzSK/qp/QPU3
         68VlydIUYmRkCb/C58G4LSW/Cnlwl2zJ/oLhX/4PLl21UxsQA3g5xKQ/lhz5R4ARw3MK
         clh0e0jQsm3ouNoEP3XijDWTM5eKtd1YsDO/vBT5EljF7STlNkyzMgAH5O+oIxKC2ECM
         PXqN/49p1MHoJs+WWx2Hg943/TfDsEIgC+PEtGvHggmkWHGxjRxDEQSaMwTdRZyZE8m0
         8AQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXSCNtweTDGZtRtCdUD1rYHiMHX/lg8B1zLFNNPSHvrNGkC/v88P/ImMleC20r/7+YNnVQyTF2xOCzHwfa0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRcr/aMi7zxX9l3wFWPGeuHzmKoV2Q1MGEEPBvsFPOx3xKNdpy
	uQjJs+g/E3YfhLgfJVALhhgXtaopjXX1qkO7zR15RD1N5p/P95S8pNaDlIB6jqxddK5szPq2aYE
	zHv5GL3CqkqLWEqZ3d0Citkq3ghq1XaubZAmOtdk0NoxBEC5t5GD4IH/6fvUGxQjQ0A==
X-Gm-Gg: ASbGncvEIJSJx9De/bUnUbP/cHCiqfGaiaqJEDqzOiz7IKPojeNV0NWb2dNZsjz/B5X
	UAiaW+bcH/xge6VYwgRqJkjl6tA2hWSQqFUQwXP3thJWnzhNqVKp3Z6acZQvhKsGcfELB9aLAJN
	H0yhcG9xVkywNXW9rx2AIZP6PzFJFtmLVK7n5tVVDt40wI0BVyCLo/jUUlQ88RXsW5ty3zzFfQF
	vVoGLkuiSNnyS9wrS83sPU43aFg2lnH281bsSo5gC1gREzCtKD5frum8RANQ2KSfTfmUpO/Q005
	qVQYF4iKWT0guqk7wMNNjOoP8dD/Y3qkX4EqXYiFZoRcKpDqIFE=
X-Received: by 2002:a05:6a21:150d:b0:1f5:51d5:9ef3 with SMTP id adf61e73a8af0-1f551d5a599mr32029781637.20.1741866079474;
        Thu, 13 Mar 2025 04:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyqb7Zqga/alnBVVjkfYTwBJb/FL7B8cMycyybsa0F6n3AwQrzJM7hwVPKpY5cioC6dQOrZQ==
X-Received: by 2002:a05:6a21:150d:b0:1f5:51d5:9ef3 with SMTP id adf61e73a8af0-1f551d5a599mr32029748637.20.1741866079107;
        Thu, 13 Mar 2025 04:41:19 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea964e3sm1063219a12.76.2025.03.13.04.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:18 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 17:10:13 +0530
Subject: [PATCH v2 06/10] bus: mhi: host: Add support to read MHI
 capabilities
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-mhi_bw_up-v2-6-869ca32170bf@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741866038; l=2486;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=nMXDxyNhjI58pEdLUQqctmcAdSRLINO8la+ypV3eSj8=;
 b=IQFrsWjbiSFkhhFBnz/9ECFoXIf7GbLmM1L6/nMA8GY8bq3hdf6o2GCxsl0IkRddYfEnufKMF
 7l0la06C7++BPXkI71ClW+XSU+tDbkr2gtqK0EIF/oHROpwpoeEt/nS
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: EYudj1HqZMOyvVYM06VvSDq6r6g_smQ6
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d2c460 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=8tVK0NU1EB3xojDYR3gA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: EYudj1HqZMOyvVYM06VvSDq6r6g_smQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130092

From: Vivek Pernamitta <quic_vpernami@quicinc.com>

As per MHI spec sec 6.6, MHI has capability registers which are located
after the ERDB array. The location of this group of registers is
indicated by the MISCOFF register. Each capability has a capability ID to
determine which functionality is supported and each capability will point
to the next capability supported.

Add a basic function to read those capabilities offsets.

Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/common.h    |  4 ++++
 drivers/bus/mhi/host/init.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index dda340aaed95..eedac801b800 100644
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
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index a9b1f8beee7b..0b14b665ed15 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -467,6 +467,35 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
 	return ret;
 }
 
+static int mhi_get_capability_offset(struct mhi_controller *mhi_cntrl, u32 capability, u32 *offset)
+{
+	u32 val, cur_cap, next_offset;
+	int ret;
+
+	/* get the 1st supported capability offset */
+	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF,
+				 MISC_CAP_MASK, offset);
+	if (ret)
+		return ret;
+	do {
+		if (*offset >= mhi_cntrl->reg_len)
+			return -ENXIO;
+
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
+		if (ret)
+			return ret;
+
+		cur_cap = FIELD_PREP(CAP_CAPID_MASK, val);
+		next_offset = FIELD_PREP(CAP_NEXT_CAP_MASK, val);
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


