Return-Path: <linux-wireless+bounces-26198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AD5B1D39C
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 09:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B17721297
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 07:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09402405EB;
	Thu,  7 Aug 2025 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kq23wH5D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353D23F405
	for <linux-wireless@vger.kernel.org>; Thu,  7 Aug 2025 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552617; cv=none; b=nYnQwED11Lc8mykrQK7tTKSmfCcjsnXKQQlc151JGZsVCl6vAxsJwIPyNYwl8BoweIYM0fvYdlGiKvIH+Bey4DNJ8cKGCGSW1nLYjEllezp1gCZBFLRfrWmKBol1vJWgKzQhSVjugwhVkvrQssGiLUSFVUxdBk3HJpoz/q2HOjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552617; c=relaxed/simple;
	bh=RRxiBs16r7KTIHUs8Zak5jbdXnfM3F+ay1jRs1C93GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPXXH5tciBAFIcwuIJFMds5DNLl7QNR7EjKAfVmmaxM7h46Q0JJ0mik5DI7CHvD5wfSA/4jVG7mqlhVC3bNTWcJiP9hCsWVii2gzAIHRD7X3ye3XEVB5jhF7qjHHZ34nXhnFUKh1FbZxjYFgYyuA0XWQUdCny6iI2+T66iLQsmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kq23wH5D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5775biLg032385
	for <linux-wireless@vger.kernel.org>; Thu, 7 Aug 2025 07:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IAd5Ze4vzEv
	wh8CRNYeZ2qA7tHf7jWkHfXPtXA/b2Zg=; b=kq23wH5DE2+oLegmUvtX/zF+xtk
	g/FzoL6TijTXlnE32k18k+uqSgh8GeqMAlROGd8glIE9JimOn/gvrPY6p1yT/M6c
	hvUYYjy4mKzw+PWBhlybCB5wlRK4tCqB0FCGCASdh1dyJ9cLEs6wAAtNrJ2azJPT
	SKfMOV/BLmhYZPeropj9mMsLU39N7O348ny4KPgPgyf2PN8cRiTk9ExORGz8YT64
	ueOIL8NOdJKbRwlbVIpTO626RO+4buwTgyDjSliJXBp/cbm1jPai0e721awRoUc5
	WYQjTUZUMkAhiXrnLddJIHwL6ITOAcnK7Y4a4wYDy9lIm9U/VAf+qaVK4Og==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw2whmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 07:43:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b321087b1cdso1092045a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 00:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754552614; x=1755157414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAd5Ze4vzEvwh8CRNYeZ2qA7tHf7jWkHfXPtXA/b2Zg=;
        b=BLWAI6y3ErEWxdMw22oCv7lF/UoP5hP7BmPK3lsOyWmH1ifNzU+F1JLwEHb4oTXqd1
         ck5td8BSWVsUe11rkIhFqZibLeyYgbI/Svp0ObOnMvUbaxGzHMNFG4+A8uQtAU4uy7NN
         5hNo5UJ7kdHzqCKJghaoxU4JdEhBq65c2Ns2G5fJgQZzj3URoWqXB+Qikt/puA1LYP2h
         tpKbjMlzBVI626eyyWhiz6/r3FKSSXNAbcJzPABqZXfVWtCLJKJXUbxa23FJzcNAUeQn
         ooYfv0ZA446JUgHIt7vHB2hhEoe916PThlTmkL1sABeNzmMV82aHFmiNsc7Rra2ErFDi
         mNRw==
X-Forwarded-Encrypted: i=1; AJvYcCXtxg+weOcBYvs1WPemUPfkenAX2ikYe/CyGPR59SU0ixcfeVBbuOtDhrYQNHc7rS290i6lRhMmtOzg8OHBKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVGZSACEqyI7Ri/584e8OP3E0Icfy7aEp4cVe5CjV2op9EOjc
	PdD9POZMGMrsWvhUjjL8ALfBfDB5XL39LAvvmXPfOD7Vu9EI8g8IdctCAAc25UdWORtPWk9v+Rx
	SSr4u4uwHRFd61l86VWcxVkobzhTzJlsF6bnk7WsK/7VGYCo02tGMu9PrH4t/woCcf3jHEw==
X-Gm-Gg: ASbGncv8/SI3m9kvaGKgxre51fUwbnwZlsPPl1JZNOL4u69ntcOpdb2lOsfd99nqlOS
	i+5YRJrAvgQ2AtyVoguYnffoaODY1YuMVjt/gVrd4KgVeTwd9P1r1e4s/YzMyzHufxjHiaks4gT
	0XL6lr4r0QKEmWQo5c7Io8LVCc9oO7tNCiNKeJ0ZxZJzCWzGE6rfh74BdTqzM25+XsRx3Sj8fRg
	JgdUfhKPoM4Kt+dzGvT4wr/P02PHHzlL0t6TS/DiLtGq+f/Iy1ulSuJrqjD5plLt2mwj/78KrFx
	SSySB9dPQ7bf7sxRDz1MguCEatUyyt+LS8RGCOf1m/Td4T//jlRv11yY5nB9wH6f7kg=
X-Received: by 2002:a17:902:f68f:b0:240:3915:99d6 with SMTP id d9443c01a7336-2429f4abfd4mr86270775ad.33.1754552614143;
        Thu, 07 Aug 2025 00:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmQ70xW0VJBqeSlIUWMJPARL1fYQTkCAlkasjy9//oof5xTgkO6mW9mVoX4c12poiyfQ7JHg==
X-Received: by 2002:a17:902:f68f:b0:240:3915:99d6 with SMTP id d9443c01a7336-2429f4abfd4mr86270555ad.33.1754552613777;
        Thu, 07 Aug 2025 00:43:33 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm178166395ad.39.2025.08.07.00.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:43:33 -0700 (PDT)
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
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [Patch v3 3/3] soc: qcom: mdt_loader: Remove unused parameter
Date: Thu,  7 Aug 2025 13:13:11 +0530
Message-ID: <20250807074311.2381713-3-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807074311.2381713-1-mukesh.ojha@oss.qualcomm.com>
References: <20250807074311.2381713-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vbz3PEp9 c=1 sm=1 tr=0 ts=68945927 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wln2f8d1oZJPYHCAfSYA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 6SXuMac_OLXHdL9X99JFKJi9K_2nYYvz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX/y4Urn1Qw+fU
 mXM5g9WqOywBE2yGI1FX8sd8nc1cOcWyAroBKefDWiNtqLyDSfBjP3GMl08oeOP/YLmJzrKlhL7
 cjAKG0yaOvkhuhtYhUbGMEYhK52GMcsF5x7pF1x2D8USTwsN4tl0YV0PWBJIGYvrlt9k0p3Zr8L
 EQr506HSfzPrGRLklkf8Lst6tcFfAgygHA616/88dan5gojEyfP3MXEvRD74BdRUukMBfcJl1fB
 Ob3BvI2MbK3AJKJNP6c0+dGegXtfbqJuZIwvEfQbk8Nm8o0aY5jEwo0GxFZniYM9IyTrOeic+DY
 8hRXOpKy5jq2+Q5q5tPUBmcP0zXz0YoGktu4TLKyh/6zpba058Dm9qNb2IWQWX66VWBt+BUOzhi
 QhKQffzR
X-Proofpoint-GUID: 6SXuMac_OLXHdL9X99JFKJi9K_2nYYvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

fw_name in qcom_mdt_bins_are_split() seems unused now, it may have
used in the past for logging it but due to code refactor this parameter
is unused now.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v3: https://lore.kernel.org/lkml/20250806172531.1865088-4-mukesh.ojha@oss.qualcomm.com/
 - Caller of qcom_mdt_bins_are_split() was modified in 2/2 of this patch in
   earlier version, bring the change here.
 - patch order changes due to drop of one patch from earlier version.

Changes in v2:
 - made this as separate patch.

 drivers/soc/qcom/mdt_loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 74c415774657..7522223835f5 100644
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
@@ -353,7 +353,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (!mdt_header_valid(fw))
 		return -EINVAL;
 
-	is_split = qcom_mdt_bins_are_split(fw, fw_name);
+	is_split = qcom_mdt_bins_are_split(fw);
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(fw->data + ehdr->e_phoff);
 
-- 
2.50.1


