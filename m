Return-Path: <linux-wireless+bounces-26119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BF5B1A195
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 14:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB08188A0AA
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325B1FBEB9;
	Mon,  4 Aug 2025 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c7exVIPz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ADD25CC40
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311358; cv=none; b=dJJyZqRKvWkExc+pWzlMkj+/kmWbIiZIiD+EGxFNUpr3TpolqyACDot8Tiwf2t9B6uiXKmwssBNI26TolJb19kn8dnGg25npT11LfgcfaU4VRuTW04kZgfvnudwRa93uL3sEUQryC7KAO13YB2DIVQBmtWjLaOOHwroEM1oyHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311358; c=relaxed/simple;
	bh=Zji6gWmkzbwh5PxX+NoZLoedb69oac3dHlD8eqjUIwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6ATf39+NcCwoZBM7QyggCqPkQHLh1zdEkjeQK5zIi2UcPAq3c+RpV5QYMXQdYDlS9gSs9trnUCv8s6lJ/RyNJaoKRyLJl42+T0ohTiThqCEGJP7JtjiFSQvICLmZKbq7BimEKGd8wSltYSw+iHJEjn3uJR/n+ydUMyKOj9Gd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c7exVIPz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748vrtR027409
	for <linux-wireless@vger.kernel.org>; Mon, 4 Aug 2025 12:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YQrPurq3NapPqGpZBcgGv8vx6+jrShJaV70ukg80F1s=; b=c7exVIPzI2CFB4ls
	Ro2N6hcdmo5XpVL72/kGHGM1JKERmRO4KImd5QS1fA7jOvTTIQ2Brk0otr0TH4Rm
	SDNB2zfApdSXkumuBKqeN1whURkT/4lvJxaFmPX+u/kcfDxe5pkHEb1WP1vQlscG
	W/uO/ySu9aq6UwXZmdLMKik37WxNJqPJRh6qJ9O7+LzJl8d9ydl7O26qTx1+PbNw
	6jZDf/tvqQJkCFIcrHZjNJPv4U5UHz5Pm1XZ6wJ38OxGyW+g0rZLiXuF5g2IXkBM
	wAs8v9UKV9g+ZJdhuhz3qoPet/nEJwQxDUrSxGG3TDQwGum3MXwFZHCi41Z1KSDy
	tk8wSQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489buqmwxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 12:42:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-240012b74dfso27104845ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 05:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311355; x=1754916155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQrPurq3NapPqGpZBcgGv8vx6+jrShJaV70ukg80F1s=;
        b=CzG9tInjxiLQPw+Jd/dzsqh3JUrN3H6pHASAIjeJjl5C77tUm+uN7ZDB7sgItwfu+o
         AGlUjpjQxMG2nRgtrjj0SHC+85nQ0TGqNnw5hSF/6WtN9oYBK1mp4vh3itGWNOYu6c68
         nz+iionkhCiU7dIWmDo+HkEhiAmX9zgo9pCHaOToikIksO/fUNje/7yX+bhHeEqvpvg1
         06WbZbR4MZuaE+XatovLujcCev81dhu9ew3bIGkjv/gWVRaQgwqpDjdR6QxSRG4gGv9H
         RkGx7mW7HmSd+4PQ5SmAejOevPx3KFpo7D2n9pkkX0lpTJHRcOWbxjWHugAuIKS0z5jd
         tsfA==
X-Forwarded-Encrypted: i=1; AJvYcCWSrL04q3a/Ox2wVxfxvFu7jz+0rOwDmtfDBcjfHWEYKimGHjHNu+VzfXk7ziEtcX4dn9Jl0y05kph9yfGnGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59HVNs17/GykmVUhC3rvRoThIN0IyvPwKIY7S524UACrxsoHs
	T43wdeNSCuymH7b0vJfsld5KdKmtzNYGxaxiMp0kPTQn6wzafHIsPj1nFcOdAjkJDq5bV6pCxdn
	p/3SFqb9mU/ZXpP2ber555MJyS6Y5ReCQ7H6/9mPKLhSO862G/r565olywBM989pa8iIfJw==
X-Gm-Gg: ASbGnctn4HbjXvGRLmV1nlioc8KARUjaSOK0bc7g9X80+rAyOTzLvaoS5/k4/Dxcb2k
	CUlflBdYequIzaS+XwhUA4woOrg/is9233CdGBmwuPmFp/e95j8cyDYPd42xMF+sEg5Xn/caxeC
	w9L1wJw9hD0kcNKRaVgIA83Q036q4KwJ+8MLa78VIuz43P6y8rGYP3lqTsrHjmB9z7at96I40Ch
	gvVZoNxxbHzaeu9mdjEN+eSuhrT/Dyx0wlQuiH8hC02YZXCUz2nmPdkTZYcLIq3iU+52tStFftF
	IAO99lwBrfRhpmrPxqudvEy3qqBxPE8S2yeRJ90fGzIN1PMgWC/RCROxDSAbS1ANLhI=
X-Received: by 2002:a17:903:228c:b0:240:468c:83f1 with SMTP id d9443c01a7336-24247058a7amr131957075ad.44.1754311355592;
        Mon, 04 Aug 2025 05:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwWJixm0otAsJ9qW2cKHM5TCYbaZzSEpD0epevLuvlVXQCQHHBcVIx7oFmDiJtStYDErVyGA==
X-Received: by 2002:a17:903:228c:b0:240:468c:83f1 with SMTP id d9443c01a7336-24247058a7amr131956605ad.44.1754311355161;
        Mon, 04 Aug 2025 05:42:35 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef8204sm108876365ad.34.2025.08.04.05.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:42:34 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 04 Aug 2025 18:11:49 +0530
Subject: [PATCH 1/3] soc: qcom: mdt_loader: Remove unused parameter
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-mdtloader-changes-v1-1-5e74629a2241@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
In-Reply-To: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754311345; l=1741;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=Zji6gWmkzbwh5PxX+NoZLoedb69oac3dHlD8eqjUIwc=;
 b=5CMkHAbsehPVIWOSELTxsgownCEReC5ZwglVfyzW/9eIgQs/XNLDj6ZF1qXsM5VdS+WuGlu9N
 zC2G+4/yH1sBnaZYv/g3O4obeXNlNDL75iSPYKBPO+lObmjTYAqQATn
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: EBmaNf--w6drGsstUbmHwl4ZnQZ1okg0
X-Authority-Analysis: v=2.4 cv=VZT3PEp9 c=1 sm=1 tr=0 ts=6890aabc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=4mQorhOTa8Yjjd-mLDMA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OSBTYWx0ZWRfX5ABgspLuZ0Iy
 j/HQyjVSQCf+MJ/dLT5xU4QOLDPnHwSWQyns2wWBm7FWFxCcjnLJZNLXTyNPqIRnLTB/2Enlk5+
 hd7rZg/z/PExwnAshsHf2/32chPhRNFm+5quK8ECg42sDDyVbdQBEA+1x9DHInX3O3yfpWpZF1B
 CNkrE9ahTEMeMS1Fp4eIvIziEIJbYAJ3Ps9em3KJ1lHUfNB6sw83kLeI5Nd0WW4uz7yO7HF2U2t
 CL34nTplPl/WrNMMQQxPae3wG4xOzxUQ1knA2vyYK+cdE56yvC32zl+jVXMxUR2cWYg6YlnjyQn
 Zlq2ZQd7k84Mm+OfW4XYRimA+0/PRfps1RYZrC3C6jgiApB0HSJeDKJa8eY3n4atTIkYWgjA9xr
 OVvEELDE+pmm2PlVDyrfgptBvCVe9aPusbVR0cVvjWeICKpJLY7VWcCkAVlYM8MYgtwl+B0T
X-Proofpoint-ORIG-GUID: EBmaNf--w6drGsstUbmHwl4ZnQZ1okg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040069

commit f4e526ff7e38e ("soc: qcom: mdt_loader: Extract PAS
 operations") move pas specific code from __qcom_mdt_load()
to a separate function qcom_mdt_pas_init() after which the
pas_init variable became unused in __qcom_mdt_load().

Remove pas_init argument from __qcom_mdt_load().

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
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


