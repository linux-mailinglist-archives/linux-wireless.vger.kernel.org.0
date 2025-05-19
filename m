Return-Path: <linux-wireless+bounces-23142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CA5ABB9E8
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 11:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC497AC439
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAE2701C9;
	Mon, 19 May 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ExbS2gRR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99D2701B6
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647770; cv=none; b=YU305382L4msavkO3v4GBJT1pBmNz5kOsNzvZ1Q3tx6SDkiULqRelSINKRHyGrJTuGm/lSqvAOTByOmwAqA28aqwby5BqKGf3+wEQkh3eFQCzkaasEp59lIc56AS7lnetYDxMZEOzmVqtJyFiZzZTzuEn8qYRN2pAEBRhwi6Q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647770; c=relaxed/simple;
	bh=LW6uUZFGqD1UyYUFU68Xi6WQWlLczbA/2FzJMIC0YvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cWe+P5HIteXVd4bPwuNY3U+Zvfb2Dm2Y+TU34J6zRp07BwuD4yw+E90EK4g/n0851osBE9CSbIE8AlHw8c4haZ+k6YGhcbe9TAKxwyte4FeuL7T2qiPPT2Q1CDaQkJcSJz1tyLGprYhIlA+sw5OOpWJRESvwqIbJ1E8Q1PXv/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ExbS2gRR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J98952020941
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qaEhlMZNRK2NLwdfwilZTHaAPGsfv+pU1e/jm5Z+ob0=; b=ExbS2gRR+sO6HL9d
	j9rfgQ5wlpGb0F82HJE006JlxlF+RTyNz7lYfsH3p4v+klgFFW7Qbi7UHWbX/+17
	C2DmOvkRrwK6LSo0hsTAy+fHZasoC7n6XF3JagCfnsEhkFX9IRyt23d73+N/phGd
	dfnpE7QAWwYSKt9rw/cXWQv6A5QXcLDah7GzhSVYHK8R4IAYonjD/8CgRsZLcXBt
	VOCoscgIOrvXEGQdhU5ZshNzITpSgE4JHVWlkKoSOfUp0xgNL1X09QMjf49Fm3vf
	mCVSx5lS1+7yf3g4ZDNh1OJto0E52EyFisDBQxPN2gqCkKez/xlgW0Qd4BTotZ4w
	UcdpRA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjnykw37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:42:48 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-73e0094706bso5792528b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 02:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647767; x=1748252567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaEhlMZNRK2NLwdfwilZTHaAPGsfv+pU1e/jm5Z+ob0=;
        b=cX9RmJ4x18JLKh4RPLDFDjMltTjqHj7DbN5YcHAWXY+O7FE2j8mNOiTLEfCqKGAWR7
         FsKrA2iwwaVj84A6a5nNBHDsnsV2V9P0yyStEQQK/oZnJ0+e0jeHP0DtqrocvrfdHyQe
         PLauodj+QWZoY9w9dTM93WKO973LOiYrM9FbKdmoc8mFlyO/mnWxFFacpis1nd71X+5c
         weLMK8dtn6NKtYd14AJ2kX2uGZCN/lOQG94mckrn36rOXB9VM1mEK8PzURYENIOvSRB8
         FalJ7M8zsSPXVVTi2FqPhQba4Pq3lgCki6M8jygtWdO14PFBucClJfnvd1hmkw86qwM4
         FSnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhWgp3wkBUjwB0owINdKPqS94r6UAn0uhUNk9sQTEOm+Rbo1uAv3VU19PVYeKZKvy8XAKUaFS3gJBS2bCuqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzSmR1j3kMIMhWOEILMzpMUrcOZxkPoH9dHG0ydK9Ft6At71jH
	mYuyaQ+0WHv3yWf3nw80Fsw2lS+pQ/Gu1fQc88NXt+PiucKyLrb2gqw/X9SdxTyebyMf3+c+Gco
	ebDbq9+KqCt9RQC8okGcZHz6ioQ5TCBxT/2vvjGSGZhZ42+iyxFS8vxs0KBJOtTew8Z7g9w==
X-Gm-Gg: ASbGncuMGK045hdocTDU8zk5EFPA4oY1YU8cKiMxzOqtCb3jlm8NxR4jHqhyB6IlV6u
	Vee+HwU5wLlnaua0oSPKFcJzWztsTpoXi2zoBYJtv/K9tBs1gvSTnfkveDfI0uyPyiEI/kZAr/j
	w7mL87zr59n66P3YImjA8P8WN3OqkBHg5zatz/FNg/4LFNNgyWHMrQOkdRVSTpZw09P6UGN5ruz
	cc7irlH7wBdpFP9C32ZeT9sTHk8bAvYTsj2AftFxc5KdR720TRDRHENKGISCFN0n6JguPn11Npv
	TkDjneccPYd2QJhJn135oWkI/0SU9YtORoHTNItdkSU/9so=
X-Received: by 2002:a05:6a20:2d21:b0:1f5:8eec:e516 with SMTP id adf61e73a8af0-216219c83c7mr20960846637.32.1747647767000;
        Mon, 19 May 2025 02:42:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPivW2uuHer/futXB6CATvxy78IsEmfKwkUhEBc2jqHppm0UtJRVQovLwVfQwoCRtaYVtxaA==
X-Received: by 2002:a05:6a20:2d21:b0:1f5:8eec:e516 with SMTP id adf61e73a8af0-216219c83c7mr20960821637.32.1747647766601;
        Mon, 19 May 2025 02:42:46 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm5809092b3a.78.2025.05.19.02.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:42:46 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 May 2025 15:12:16 +0530
Subject: [PATCH v3 03/11] PCI/ASPM: Return enabled ASPM states as part of
 pcie_aspm_enabled()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-mhi_bw_up-v3-3-3acd4a17bbb5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747647743; l=2254;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=LW6uUZFGqD1UyYUFU68Xi6WQWlLczbA/2FzJMIC0YvA=;
 b=CeH1rqozNMSAmO9N8S8eg5Dl36biG9HcHhnJfMpzs/VU2cnmb7kh/fdVzeA1DzlaweGbH0UQg
 KwlHYmQmjGXABbM8yXmUPJRmsh+iFpFd/GgRSJ5Np41KR2CV1JFVSLP
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5MSBTYWx0ZWRfX9j9fFRq+wnLX
 aHRo0UJLTUgF7XRYbyb5a1GYjqDdjl8ZS+kSqF39J+hstMoPGdc3lQLH58F5p9CUMsTS5Gkgwlb
 hSv6YP2as4CRjBLUU7lxbI7U5gtJkygadgoS3G3Dg8qAbKLElMZaj5QE31Wz5Z6HRGCv3tDcKiH
 LtRtfFbjHLiNVM5CQhUr4d/OByYx1q/Rc3BSok5QXO4SvaZ6noeIEBTEWSBmIZjm9+vpjBchPCo
 Zy9voOqkvQz9VL5f8Hwm1UoIQ0Pp5ihnOj3lzLg66dWiZNDA7OKwqJts9sWfdyd1JNmu5EHyaHv
 YiIWn3HgYfNXmzB6Pl44vdGSqnPseGcgLJuabAfkj7eFfvuHv0wrThh0bc0VQdFMqJLL/eV/zAp
 k8wu9PzKmR7MzzP/zfehqX/RYH9pb+aKpBu9PgxmbKB1NimPP+dtaJ12e84V+9MRHJ407xcR
X-Authority-Analysis: v=2.4 cv=Z9XsHGRA c=1 sm=1 tr=0 ts=682afd18 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=wuQQqu7ThqwHlQwkt1oA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: __q48Vt1SrDbATYWiiCiH4hF4vqYZpmT
X-Proofpoint-ORIG-GUID: __q48Vt1SrDbATYWiiCiH4hF4vqYZpmT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190091

PCIe ASPM states can be also controlled by userspace using exposed sysfs
entries, if drivers wants to disable and enable ASPM at runtime they
need to know enabled states for correctly enabling them back.

So return the enabled aspm states as part of pcie_aspm_enabled().

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 4 +++-
 include/linux/pci.h     | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 29fcb0689a918f9cb123691e1680de5a1af2c115..94324fc0d3e650cd3ca2c0bb8c1895ca7e647b9d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1555,8 +1555,10 @@ module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
  * is deallocated only when the last child of the bridge (i.e., @pdev or a
  * sibling) is removed, and the caller should be holding a reference to
  * @pdev, so this should be safe.
+ *
+ * Return: Enabled ASPM states
  */
-bool pcie_aspm_enabled(struct pci_dev *pdev)
+int pcie_aspm_enabled(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7eb0856ba0ed20bd1336683b68add124c7483902..ce9d0812a61c2337ba533ef246393a0101e617ee 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1849,7 +1849,7 @@ int pci_enable_link_state(struct pci_dev *pdev, int state);
 int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
-bool pcie_aspm_enabled(struct pci_dev *pdev);
+int pcie_aspm_enabled(struct pci_dev *pdev);
 #else
 static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
 { return 0; }
@@ -1861,7 +1861,7 @@ static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
 { return 0; }
 static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
-static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
+static inline int pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_PCIEAER

-- 
2.34.1


