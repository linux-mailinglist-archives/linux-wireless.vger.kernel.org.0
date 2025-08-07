Return-Path: <linux-wireless+bounces-26196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA817B1D392
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 09:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCC618A5721
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 07:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605882405EB;
	Thu,  7 Aug 2025 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nBdaCbm5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B523D281
	for <linux-wireless@vger.kernel.org>; Thu,  7 Aug 2025 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552608; cv=none; b=EDkyP4Pa2Z9GL+wVFdameL3sAK+1ASZOX85GlwVv193vigqd3yXKai3QjrdR1eqfl0TUQRY1BhrJn+mBstWPidkacd8LQEl8ZzEZBePVjbqt9IgE1bBbCGlWZVx70E+2daoRVopibxpD7W4+T6m71rMm0yLpyXmuw0gQdpKSe68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552608; c=relaxed/simple;
	bh=aJf8dgH4dYz4FeXdIaB9wlD7Vgy/o7rrXh0zl/XsgWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0Qz63KVW+BY5ZccRMEyuAv6EYh4W9u201WfG+YIncrbq4Aa2WM2MDQF49gQpU26gfScG6RlNAyb4oMRVsjXDnxsK/W2pakfJxBNl4XRUStIaMasoTma0gPp8fNaSZwKbaRNTi8ZKvycNtyJ3/zadaJj8B8v/pdBV611WIueNrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nBdaCbm5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5771N72P020912
	for <linux-wireless@vger.kernel.org>; Thu, 7 Aug 2025 07:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SdrbuuxHkEeQigeY7KFKAwRwQZ1v06KXS3A
	qG305+AI=; b=nBdaCbm5x8LI4sQsiTXL6sdEItOKhtIwIR4NWJd9vFS8SIpVBAM
	N+RzVIvi2W0ZmCoak2/+cJO/0KH4qzIviQZcXra7qc69fbVc0UvuiCCKqItUzlJQ
	lvH2/THLqc1P9DInQse5YBUs7Mwn/9M+ee90lRJf0VOkfeP+F5mY47BPHZNsR1u0
	m11Eu2vVsTZN8DvVRq4qAkIz7AP3hjqbalATTEHHqiQJnU98uVpT8pTkaR359kTF
	bKnwshfhDwMFwaFbPMHaraW6/UMZYEpWB2g9JXAqKgvnJqp2UTW+JQqVG4C/HkD4
	KzwjHLWvZkAqXuwWUzb0VxGNfJcqkgaqWGQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw1dgyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 07:43:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso1295857a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 00:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552604; x=1755157404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdrbuuxHkEeQigeY7KFKAwRwQZ1v06KXS3AqG305+AI=;
        b=T73mj85cLVsuxd80kLebLd6ZVei+YTibbBYkoytF8bLGAOTt9xT5NEawj+7qM1+JZm
         qO0tVUSpkMSzsvglZfR7uSN7VwhoPoZJu6rMUaVWSsuT0JHBXTqXJ0hMbS1gVQiBFwas
         o+YZa+t/ynql+I+JJ3Snh0zsVvaRTq4JA/H1f45IIH7HF/HIjEKfxfZNpqu6d5HQZ9fp
         pW0p4JlvWjqKdTscMoertrifou4sdBMtyYc1RrWzFF432V+2D0WdLVOfCVanP61RYgfc
         bJU+rH921lJ8f5L+V96AlaSl0Fm2+JINwZ3+9SgFP7rzmnCsdPVM+4SAbYXxEfAPLhPh
         mBsg==
X-Forwarded-Encrypted: i=1; AJvYcCXe+pEUHLzJR8n5vDT4Kf09jEmKBC4Qrr5Fbjkz5LsWPIDSz9Hx+QOGtSHqLDn52DA+kGB2Reo08JgwAQvJiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzBXuVPSgCJ4G6QVPhw7bC1adhNKerrh+CW1qMJlin5qpsQPQN
	yv7OsDXuKCqKO+M/Y+FNDu6au9UcI0Pi9gduhb8xUKOribkcVcK6KipQ4Ngkj5Yms1bbOwpK8CZ
	tVxSyVxTIUzrdaVAiM9HYSlGqJuml68asqT9xtgwfprL+ilvkWLF+4hwuEWKJiqgyGb7ARQ==
X-Gm-Gg: ASbGncsSlZbz2hYXNoaO5vi9vVjK9k1YuR0HsoVB5VLuCUUFXc9T8dOHblmypuHzPTL
	lUwSPMgcbgZEHfIAdeT0dcebDkz8bCAOfCynMnaDfba2yHb5pZRQrSF6r+cKrtN5vG8O6Cz61Aj
	9wXMP315BQsSkZ8FyH0hKNdbioPAI0IuHBGZl/GRiHMI7jVjgDrFhBdZ79iykx1TfRXj5hZOFHo
	I0eG0z2EB02SSWK3Y9Cf+YJRtOTPLHSeHF4IO6qNu+R1V+NlrXZUO0+GlzU31Hm+ve9iGzqCuB6
	8UShWqiM+HjRJXdyV02rNgLzdtj9d7qhBpYeX0gAyvjCkjw/vrrL51ywvCPc5IJLY1Y=
X-Received: by 2002:a17:902:d2c2:b0:242:9bca:863f with SMTP id d9443c01a7336-2429f5bbc5fmr72030815ad.57.1754552604163;
        Thu, 07 Aug 2025 00:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHANSCJfj5IWevcX9I21BsXg/+4n+zB41jVKkCMdFHRNuqkAEqf/i9yKeqzmpgMCnYVJaYulg==
X-Received: by 2002:a17:902:d2c2:b0:242:9bca:863f with SMTP id d9443c01a7336-2429f5bbc5fmr72030435ad.57.1754552603705;
        Thu, 07 Aug 2025 00:43:23 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm178166395ad.39.2025.08.07.00.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:43:23 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [Patch v3 1/3] soc: qcom: mdt_loader: Remove unused parameter
Date: Thu,  7 Aug 2025 13:13:09 +0530
Message-ID: <20250807074311.2381713-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX3a0H0Wg6jcW3
 DMt6NllQkMJYb34PlVUVqa2ryJqrPDw9oF1mehzHecoiqwq8QmjdRLIK2/4VVUnQin3gCb2xt6z
 kKNUcpcrAn58Q0E29JwXuhkNGSQW2Myc6QZdz3/mkva1L2XYIm7bo3rNdoPhl/mVI6mMnxytk7A
 ewLIQ0DXDRSObS30feEpGT5Fc/mkO/M1zQfSKEUnbcIMHItC5+3xkTKgYit2snM7Aup5JHwivjP
 t1lVKi9KR3p940x9LOKU34lm34mxy3nZGU8oq8T4bEqO7IQqD8EfLqYdLBBm+9kB69QGWydyb+p
 ZZYkjjXdK3T27qVglynwm9NIPAwRO1q2gs21TXx1zveXyP1H1J465aNe5XvO5DgxkhYF56zjLqp
 QANMUijw
X-Authority-Analysis: v=2.4 cv=Ha4UTjE8 c=1 sm=1 tr=0 ts=6894591d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qLU0tmo_xPokh9XVZMUA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: -bKkQfs5SJVyb24EAENgUjz8VUkpRW4K
X-Proofpoint-GUID: -bKkQfs5SJVyb24EAENgUjz8VUkpRW4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

commit f4e526ff7e38e ("soc: qcom: mdt_loader: Extract PAS
 operations") move pas specific code from __qcom_mdt_load()
to a separate function qcom_mdt_pas_init() after which the
pas_init variable became unused in __qcom_mdt_load().

Remove pas_init argument from __qcom_mdt_load().

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v3: https://lore.kernel.org/lkml/20250806172531.1865088-2-mukesh.ojha@oss.qualcomm.com/
 - Because of the drop of 1/4 in earlier version this becomes first
   patch.

- Changes in v2:
 - Added R-b tag and its order in the series.

 drivers/soc/qcom/mdt_loader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 0ca268bdf1f8..dfd15d189087 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -333,7 +333,7 @@ static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_na
 static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 			   const char *fw_name, int pas_id, void *mem_region,
 			   phys_addr_t mem_phys, size_t mem_size,
-			   phys_addr_t *reloc_base, bool pas_init)
+			   phys_addr_t *reloc_base)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_phdr *phdr;
@@ -459,7 +459,7 @@ int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		return ret;
 
 	return __qcom_mdt_load(dev, fw, firmware, pas_id, mem_region, mem_phys,
-			       mem_size, reloc_base, true);
+			       mem_size, reloc_base);
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_load);
 
@@ -482,7 +482,7 @@ int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
 			  size_t mem_size, phys_addr_t *reloc_base)
 {
 	return __qcom_mdt_load(dev, fw, firmware, pas_id, mem_region, mem_phys,
-			       mem_size, reloc_base, false);
+			       mem_size, reloc_base);
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_load_no_init);
 
-- 
2.50.1


