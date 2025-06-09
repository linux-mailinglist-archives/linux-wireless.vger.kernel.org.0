Return-Path: <linux-wireless+bounces-23848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DAAAD1BD6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 12:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFBF188CB61
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF05253F1E;
	Mon,  9 Jun 2025 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OzEaZCQR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C7255E40
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466307; cv=none; b=uEJ+345ZEOmiLyjkLSbpNAE7vGttJAFB6uPdaUF8s3ZFC/1eAsQo3ldPgtCgFCQ+KeMDpAUVTrL0gyWg6lTxG6tv5x7lrInNNSJs2+2MXv9XgILvaleYBnLuTbOE/Cg3j8zXrTe8Hi2iAksBXxrk0n2ar4Zuviitm2kd2FlCW6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466307; c=relaxed/simple;
	bh=s3BgbObr46Znv5BUzFNNNM+2F0k3oFKX2PcPm3YAn5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqpLxyw8s2dRISWbcCeJ3zA8kIht7Psxs+kE7ZtSHA6DU24G6gtOzZHysIBnri1BbeWnTqao//KIYXF1Q1WHJck6xeHG8pH3SI0uDmjp6mhRraLiuIwGx2Mdmw/Td7gsXlqXtEDAlIMIPy/DMkHGP3Ww/Zp+79EUMfpt4CG0dtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OzEaZCQR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599UKwI006963
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 10:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w7A6tRGMDv2qa8hQq+J0NjE48UHIfnawBC6GPkL/QNI=; b=OzEaZCQRh5beUg2l
	57uAEDGAK6nHLFQlooM13k0An8SFSSSGT7k8kkNIzAwc0Nv525iQDnxT38oGuY54
	BBw3J59ZmaivQR+F4t0OiTyDSWhAbVtkCZIRU0ssAN0eNYG4JBI/owGjBUhwhSe4
	cZlln4K+91q9uGj+B3GC01j/QzwV316vrqzUrV2O7FodsfvToHgYUQeBzkUTWsrU
	x3iN9YDBmVyS+Xceb3rZf4Z8VgT1JMYasVfEb0SfSS8o6i0p3yzml4U0/AFNZj44
	CnFYC7HokpxN8k5FdlxfXixckwQXNhb0OCm4biOJd9u6XN2qEJUMs6eHan6t+Qxz
	vTnFAg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ce9nwp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 10:51:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235089528a0so42467055ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 03:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466303; x=1750071103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7A6tRGMDv2qa8hQq+J0NjE48UHIfnawBC6GPkL/QNI=;
        b=mw6wKojx+KhdwXRs00nuz/HugmuDoe3pMEe5liiRr3nuuUrfMmHF+leRgsqeTL+tWT
         g4BGJ5Gc1gKVYI83kgqu6FEw8DFrFdv+IQY738kBZCXgjhilWBRcQeXBS+BbV8hBZ+Gl
         5stgNDhnqXgajqGzDeIqQcawsHwp+b1uH54CB7cjX0B0ajHxF2ojPbpb7OITax3VtAF5
         QlaykeIkaqaDkxxNgB2SgCimLjZu14XXfSTzXHNEpZGtKOJzylN+DVGG2IuOlr7QaHqM
         QMLLOP+94O8ntvwTl10/fq6lSCjxVLFC2rHAZ9vdnXG7MtbmBDSkqxGJRVnf4onTEyPz
         hU2A==
X-Forwarded-Encrypted: i=1; AJvYcCWHmNiUWgIgcRuYIb0O0/jlFwV9ZghsEEwV4XqcAYY6cv+HLnvo8Mf+ukAjGlDrXqcBDkpIBgjePsoYECeE7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOISdPZrHMSBVvBscgd2HnWPGyjHL1IUcIkx/QHzQGcmTenHxb
	TCQQu/iwyIDxtKPY86XMyCTkG9dEsz2tNa22QgNVMKtaYF1ExDYHlCH1Pg69aWmWvdP+QzngAq5
	li9+lJg4mpYRRxxOSg+K5NvXoppQb3xAvP/JgmY8H2h1Wg10a3mgCgkK1fJvN8U17pejJDA==
X-Gm-Gg: ASbGncvoay5iDnyJIU7TL6qvIp/o6AYmzprHw/p3JnP1CfGRKdzlw9SgGx69oMGw0I+
	3v5pKRQoCsrmwy7bfhcdpFWOK/UJM4n+YBF+LacVrDsBIdqfW3B/iFennMfNi/qkGxkuJXt6/Xd
	+Ou5OZMc56hIEChzD3JU0/LUNMngumaKun3CfKBHFNY/TZFfGfzFAAKhAr3UJGd4GnZpYwgUsB7
	7b7Umz2Pfw/8mwQrKk6tPNHsB1yQi2iYpflpHxPXzVfOAXfkPnbQ5DdcGbxclxA7/EpnjdKgchn
	KUtNP8pnnA+1Re2h8MmtjiHqP+CYJDptgnqVXj4BilqPD74=
X-Received: by 2002:a17:902:c941:b0:234:986c:66cf with SMTP id d9443c01a7336-236020d715dmr193522625ad.16.1749466303522;
        Mon, 09 Jun 2025 03:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGLzOtRKOSJqf7NTxp/jA1tIZZWcn7SzcOC28q5ajezBWgKmY9lqYSDR8i0Dk7f/REuQx1ZA==
X-Received: by 2002:a17:902:c941:b0:234:986c:66cf with SMTP id d9443c01a7336-236020d715dmr193522275ad.16.1749466303160;
        Mon, 09 Jun 2025 03:51:43 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:51:42 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 09 Jun 2025 16:21:22 +0530
Subject: [PATCH v4 01/11] PCI: Update current bus speed as part of
 pci_pwrctrl_notify()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-mhi_bw_up-v4-1-3faa8fe92b05@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=1335;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=s3BgbObr46Znv5BUzFNNNM+2F0k3oFKX2PcPm3YAn5I=;
 b=ZfB1rQO8asuRz4N6P4tN0plpJ2JrMF1tt5D4/AjjMGr84OpeBvswukdYc5xJoV20WCuxq+p/5
 w/L+uUEC7JdCs9uZ6zUtriA3WQtBD1w122UYq7IZ4ufsrkQ8qgVr/cL
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 2TJVdeGIMjRsDFIynJ8phmxzDm18y1Pi
X-Authority-Analysis: v=2.4 cv=drjbC0g4 c=1 sm=1 tr=0 ts=6846bcc0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=3phiJa3m8EW-4BHYHVwA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 2TJVdeGIMjRsDFIynJ8phmxzDm18y1Pi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfX3BCR7aUI9HKN
 ImfObf3HYx0BcHzdTNieZuQ9X43jS+jx07imKa1oCNgXpAbeC01G/3/U+VcLn2vaOLK34Sgk3bU
 3NwQ5wywoZytFvwL5wLMUsXR4E4uRUp4CPmPPiVXXY5DjMqq9izbu9vVrV/jEZxv4SYQEzrO9a/
 WR/3o4KLWQ1EmiP/Glt3PnQ20/j+4D1yqAaEwENn2nCB1Uxf5Q54nxVMDEpB2beZQZPFClzn236
 4pw7fuodHcWVc37mHJl+JkPXrPdGAddF8XZfLL1p7E1++44rhYOwIHFg7VboV7cp2/2CNFi9eCH
 6U9Xm8aQ7uydMfT25PkoDK5dgr7cfnjxKQs6waoAmZ763W4SfpEPM+KGa/RiTVgWzLlKKSdW6bf
 GFLVYQ5pU8Cf5CzsRQ0hK3ws66dBCTbNDzwhOLrO/qM5LH1Butgz9LY1uz2rgL8H2GS8UPBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090082

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
index 6bdbfed584d6d79ce28ba9e384a596b065ca69a4..4c1d3832c43503a7e434a3fe5e0bf15a148434dc 100644
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
+		pcie_update_link_speed(bus);
+
 	switch (action) {
 	case BUS_NOTIFY_ADD_DEVICE:
 		/*

-- 
2.34.1


