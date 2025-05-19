Return-Path: <linux-wireless+bounces-23141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F00ABB9F9
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 11:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208F617095B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D2C26FD9E;
	Mon, 19 May 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JsMyobqf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FEC26FD84
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647759; cv=none; b=bjV3Alrd5L/JfkvIPBRXjQpg2y6iYx+zXrbT3CthZ/UkQHo1TuZ6ByalWRI/gQuCz3Y5EvuO5GPo2R09HkmAAoBM9YpIfvri0tHYaaSb6MbkEkyrIiVyolM3P2GzDbPfY0t1Nm7oaMd8vt1nLoCcGX2Ppt4axqzXiZqBg1raaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647759; c=relaxed/simple;
	bh=uFH7gvcXfq8PXUbSnW4zFmBHt5LxnpwhDzcE1X+yWFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6YFoOHVWUh+1r/JjXmKVrLHy54G/1EN+jMoL7Pqc43x0xQFqwp4p1zYtNUrdk3h0MUR6SOSh2BvXsDDFBSdpqUBgYvSAPPULsAcma28o0dn5SwL50ko1m/AHB5xKVF+Pbi+LnNqrZRkeSs3kG3E/11FSzsXfK3i/amOJJjTaug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JsMyobqf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9Xomi023467
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uU7PofubsUvHU2URxMpgS+EVNoeW1gK8KIbpSjZ8wvs=; b=JsMyobqftJleRTbj
	B11FC/2JAVgMNtjie8qW+mRAiSMr00ZwBIKJaCtY3K7PJC1hvmlA+odTItz9mkCP
	GIU5Beb95mBvQF1MoNpLuAZAKckt3FHFHBhceDgDSiLuQSndTkJrh3vfHvxrVIyp
	5Y+5+bEuE1WQC5majbNemPAgNASOi3DER8bcp3B5C0fCH4hSP1TxY/fEQJYUKzPF
	uXoHW6oUhwk4bFr8uqL/aKBxxmsApl1JfFXI1U6EDfPjcYkiq/nG3RWA99sCIJtj
	ZtvMxwTMCxFSyfvqeexb0VY2onCr+1/JBfnbs5Tb36ISaKeTEGQGtL6FR/1P+pCX
	4KULVQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pju7burm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:42:36 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7377139d8b1so3489464b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 02:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647756; x=1748252556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uU7PofubsUvHU2URxMpgS+EVNoeW1gK8KIbpSjZ8wvs=;
        b=ltcd0Yk5fkUT/JpRxouXOx0J33HHDj4CdYsDm+qFFdUuMBW1dWWM1K78Rri8BdIZZ8
         iN01XSbWupbj5K315/gYVAUC/NlKx+lDYS/ozL9n+DfhXg2eXX1rYe9AdeBXC4M4ZVek
         /a/zbJYJszKRVF1R9RWDsU2r6Vm8RypGnDwa8xN62WBEbRI7Oe3qJsW4lBLJ3dVeRuvu
         ymnBk26ea5paPZJnFwvPnwcNYffjfKcKZRugwaA+oF0oXr6sO4RFUrRf8nlwlCr9NjiM
         tRbxf7LcnJZ8DxvqkNJd7plnnNk82KJKVyz8pryHdi4lx2jmCsRaZFdkwLj/dQPbEAik
         15kA==
X-Forwarded-Encrypted: i=1; AJvYcCVBfx/0GUhxEfg4QMHstXD7oXsHX5gV30OyRTXxYrWWAuJ0pEvsBv8Lc9HH4Zs1up4Z2H3zGnaAARWFucuJeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyraMHysjyIe6oGIPv9ndx87VHQvEcknsUtKBLErjT8O6AaLxYE
	gL+b6JhkUAMnsfTsDeNmhq6zwQrk8GGMIp2KuCetmXRWZxP+XXl2+FgB1XuXU7hUOklUD86TNG1
	DtSGZIS85Hb6wcTWw/tBeLiRh95GiXnDX1FGSGi1y2NNX6Q0nnHOSsR4tLFvIilGNj/LcLw==
X-Gm-Gg: ASbGncuzFoO/cVF1WRf9qmskCLj7F6XyJnmYrUaXPycm6s1UE7zStW5h57xUeYLWyLL
	XUN8zyLVqg4SfCQ/dw2zKZ1q2BbiLc3RL+HPttKEzKML38Tnm6OS4I/MGWyDwtaP/ReDV3msIv9
	yhjz34DUm8Whr2iWaT7BvMnRGCCP7XLYoALsKQd5NvLEgkffdv2Qz7w2IMhQFiet0slH35r46VX
	NNpoavhFfb1n3nC/BlVpC6R8OdiUR4UpyOlReqfJ3J8dm6Z9pJBYErbi/6f+SXSFlcg8jTuRm2z
	cMdVWnXBTBtKbn6dB6PcBb3ah8+zxNYu+jmYSha0U9bax4Y=
X-Received: by 2002:a05:6a00:ae1c:b0:742:b3a6:db10 with SMTP id d2e1a72fcca58-742b3a6dc2bmr11994269b3a.18.1747647755740;
        Mon, 19 May 2025 02:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE99iUQ+YVc/maiKCsxdLZP8n8nikcwdzK+f/VpTPSVQgsMwchfjJqT1QzUS2xVouHmoYvWTQ==
X-Received: by 2002:a05:6a00:ae1c:b0:742:b3a6:db10 with SMTP id d2e1a72fcca58-742b3a6dc2bmr11994251b3a.18.1747647755364;
        Mon, 19 May 2025 02:42:35 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm5809092b3a.78.2025.05.19.02.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:42:35 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 May 2025 15:12:14 +0530
Subject: [PATCH v3 01/11] PCI: Update current bus speed as part of
 pci_pwrctrl_notify()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-mhi_bw_up-v3-1-3acd4a17bbb5@oss.qualcomm.com>
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
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747647743; l=1353;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=uFH7gvcXfq8PXUbSnW4zFmBHt5LxnpwhDzcE1X+yWFo=;
 b=lXyiRKWe2dUM/NoKi98YA2ST4iD+GyJH/JWFyhdLHqiaIoNSFdOEcmMxv7oVHUvW2lVe0h7ZL
 UYVeLSPwgrlBOdS2f0m/xziM1YsPsEV3QKXX1cYho1bhDVgeJ3/rrYA
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=XKEwSRhE c=1 sm=1 tr=0 ts=682afd0d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=3phiJa3m8EW-4BHYHVwA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: uBsc1nFBglyG28KyLcv8kVA1c7l_I-1r
X-Proofpoint-GUID: uBsc1nFBglyG28KyLcv8kVA1c7l_I-1r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5MSBTYWx0ZWRfX5TQHDE0gVKhY
 cvmcbE/Xgmh8RjRDb7NLrFPHGPMv4KfVumFubE8H5R4ftWrvMWpVW1M5rV/yEFuwKwn8XrkM6Lj
 RNZ8j+w39R8n3oSRUPmEYrONfvgLjf64B9OQZeeaVCnwtopKMoyhB+WixvN9VLA0kKzPrNsJU5C
 cImjVYdeK7yzZiS+uV4QBu7paaz02UEb/6UtfPnKRprCmfxtbtXqVFctVRlyS0d2sfFoSiFwnBV
 9+ddk32ar1IBtoPeOiE/a2AClY1dhxNL2YJCZiyXi4B3htsJ+YpdwElaB+QRHX3DlxJnyi+/yiR
 3l6U4oPH1RdOULiwYpcL6eEMx9nmgUMhiljW/vTqqWV7yrTY5JNeW3cOeGSdxpcIfANCHDR+PC0
 UlRiX8DJS1b8zh42SyukHjFzzI9JgtVtOXn3sFzmLCoxwRzopCknbU6+2FNKVdBFnZNmAPgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190091

If the link is not up till the pwrctl drivers enable power to endpoints
then cur_bus_speed will not be updated with correct speed.

As part of rescan, pci_pwrctrl_notify() will be called when new devices
are added and as part of it update the link bus speed.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 9cc7e2b7f2b5608ee67c838b6500b2ae4a07ad52..034f0a5d7868fe956e3fc6a9b7ed485bb69caa04 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -10,16 +10,21 @@
 #include <linux/pci-pwrctrl.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include "../pci.h"
 
 static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 			      void *data)
 {
 	struct pci_pwrctrl *pwrctrl = container_of(nb, struct pci_pwrctrl, nb);
 	struct device *dev = data;
+	struct pci_bus *bus = to_pci_dev(dev)->bus;
 
 	if (dev_fwnode(dev) != dev_fwnode(pwrctrl->dev))
 		return NOTIFY_DONE;
 
+	if (bus->self)
+		pcie_update_link_speed((struct pci_bus *)bus);
+
 	switch (action) {
 	case BUS_NOTIFY_ADD_DEVICE:
 		/*

-- 
2.34.1


