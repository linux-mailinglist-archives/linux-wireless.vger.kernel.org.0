Return-Path: <linux-wireless+bounces-26184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD943B1CAC0
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 19:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46350566EE1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC862BD015;
	Wed,  6 Aug 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a1ETTCVE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7429E10C
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501173; cv=none; b=CIbeTXcoeNvr1rGyfzzS02Ph0/B2dc5/UNQ7Kl/zAXMyZvak/xhipBKq8xDOGVBOzEej2bD/YDQtPGRf3KWPLgytcYsnHqhghCi46cW0lYdur5Q1tJVmRVXT/0aiwpV63GI0BNbPAuKgy9Mk3aOhbO9Zhnmt5+++LdiWzxMvu1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501173; c=relaxed/simple;
	bh=ISijb1E0+ZD77bkKk24Ne4W33w2AVxTmXoDiNWMIs5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZD1/3QS6qjiQ7DZYdO1nGXDkb543yp+pIFG3cbkYGSo04j1/rFOtnTkeTTLMJfhrMQ/mLezxJN0i3UPj40hp27/0ZLehLTgeY78vqgZN+ihItKNfJas8o+XbCpVYYL9mcAcl4sX7br2vUkW/UK7/QJxDJz+XksNeTPMb1z0TAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a1ETTCVE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576C6H3c025397
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 17:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5V4MfdEEJjF
	qpxnuJxY+w9W+JqTRsjaxsk3+BJSZB8s=; b=a1ETTCVE3M5VttGfMhCLvribLSA
	V4YlRLkXvHdLKyegh+w89ShSkseZsFeEU3LABX5s/QN+a5Gr5l9xBneU8bCPju24
	3L23tP2zJUvKmYeqraXw3oBhtCpPf3rm3LRZtwY1FkHHKQtu6cyRjj3atDddp3EQ
	zm1IIko37h2pG/INl1SpHLGs29wu7NgosGTwYSU0AVGiuSO5H+Ux1Dc3MFr9Gwt9
	B5FGrcZc+1WxNsOeA4PnhUXLPGNSHjGAlkswAm5cueZziRrEh/QHb6EB2Z6o/4yh
	rRrJkhkD5+sSN7CcxrerbMd4onb5CxSMJtOe3Bn20Qye74m7zuJylCDNgqA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvyundf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 17:26:09 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76be6f0bbfdso235463b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 10:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754501168; x=1755105968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5V4MfdEEJjFqpxnuJxY+w9W+JqTRsjaxsk3+BJSZB8s=;
        b=CbZJWffMsKUfSH5ml0M5DMimiqyxORU2W91AryX4kHmwOU9bXPwIV+9x5lV324XHXW
         iavVYzoExcajK97AKv41zgNjjc1sfNhkckaLVvjLIYgJTYBc4cactb15LQVt2XyzKjZ8
         PBSx1zYy7mtFghYjUQgWV2gxILgUrzH6JACZvxxYAy41A7ZyoGPGEBGno1bSKhfvxcuh
         UMxfdqiQNrZwcJeN+SUqKWUZjGJrejRTsyyajLQa7IHQzCLjn2/X9BMZgdYsBnyl2rxC
         6dqzcAB2dyxdXcNliZjIAHx0DzRTwbCIblEo4LbK9W7DNlozGoeyGhca7wwT84hCjKS2
         +6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCU03vezitdXu2+0gjbz539SO5CAzg0iaJ6Sa7rggQjWNJT397R+knWwakKe9MvSjrHLYqn8hD7hiZUAFlYX8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+FU26uz6AaHLyU7wgkaIDkNDPCsf7j0cMqfUQFKO6z8gPtfz
	ePeR0RXhYliCgfMmBN15ruWpW5gtQ78G38Q0IlWkBSn/JIQxjspbCYdXQAQmJF7UpjfPVHdDlPM
	oWrEegjn7pwiVBYLDfr9hHjj9QrF5BhKqZsH8aC+D3EIzEhXk4M6UKSsxpM6XKGZZ7carTw==
X-Gm-Gg: ASbGnctSoZdFyqS37AZYUcW/N5gfE2qFNCSjuyL013yacGWl+6Y7FiVfEsmN5gnI4vU
	3QZ8Yh9fRQmiohdQLGprVy+6wX5XCFjtuyy1qum0hPb5IT5n1lKQPDBqZFLNOrLdmr0H0r//SQT
	aND0Cpfjz9y5nu8Zm8DbNvvjI92Q10fu1kJH/ugN1JNTclCSpGHTgaMZ84es/9m06TFZ0DL/RBG
	mNcYp2xSGs0eTnE/QEeEXjZv8zg9eshbVZKGxyxscZhL/9A3PhjlJgApyRwECL0/A0ctkiwzAoL
	sLIYicBx6I0BDPtc5Gg70k5ojuM7lY5ThAKItZ1g4ou40VgYgxOkERClIW6ZvuWpA2g=
X-Received: by 2002:a05:6a00:8d2:b0:76b:2c12:334c with SMTP id d2e1a72fcca58-76c2b06edb7mr4844981b3a.23.1754501168298;
        Wed, 06 Aug 2025 10:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJeF+hA3Sf4UAVGOsX40s2DjOot938v+1PjGjJpA2MdTWEdlqDKL/EvOlgI7sVXx1RVnBAQQ==
X-Received: by 2002:a05:6a00:8d2:b0:76b:2c12:334c with SMTP id d2e1a72fcca58-76c2b06edb7mr4844944b3a.23.1754501167795;
        Wed, 06 Aug 2025 10:26:07 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f417sm15866210b3a.44.2025.08.06.10.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 10:26:07 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 4/4] soc: qcom: mdt_loader: Remove unused parameter
Date: Wed,  6 Aug 2025 22:55:31 +0530
Message-ID: <20250806172531.1865088-4-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
References: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GuG_Daa9ECqL94ysEan1Yf1TZVmczpQh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX9JqgTVUossTt
 1XBMd//1ij5eorIiFRhKNeRGl93RAaY3nYxwwhBfxECRFyKs+aclJOan7xyhZ1radnfgnM0HNkb
 hMQTirLJKhrlpxkQJFHaj5VyNsbMiYbMXCsOs1kiz8ArklCGFOLfO5Q/2fWjc+2kycmQtE8dDUe
 r/40qtJc6dQaHu0iPPasFe38vVVTCyJEStAoBvUPIXtnbDCFUe6cm9jLftfJ9JS/GVHALeZNkxO
 itM3ECzupB9f2njoOZXUXKWxXkyIL0qHfEy3ByuersojNZZklgp8kUz5uALFuoeDVj5Kz1ajlDP
 lXhBnpZPzg0GGv3MJibusuU94DDwA7BHn0dnT6fjaWuxD4QpjHdzLyIdSenSp++o1De1ZZfQDf0
 KKQYU28t
X-Proofpoint-ORIG-GUID: GuG_Daa9ECqL94ysEan1Yf1TZVmczpQh
X-Authority-Analysis: v=2.4 cv=NsLRc9dJ c=1 sm=1 tr=0 ts=68939031 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=QQi8RNdjS96tJPzaHcwA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

fw_name in qcom_mdt_bins_are_split() seems unused now, it may have
used in the past for logging it but due to code refactor this parameter
is unused now.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2:
 - made this as separate patch.

 drivers/soc/qcom/mdt_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 145bd1374f07..8210fb3dd51a 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -302,7 +302,7 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_pas_init);
 
-static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_name)
+static bool qcom_mdt_bins_are_split(const struct firmware *fw)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_hdr *ehdr;
-- 
2.50.1


