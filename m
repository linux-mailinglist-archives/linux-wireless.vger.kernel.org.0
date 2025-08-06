Return-Path: <linux-wireless+bounces-26181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CC6B1CAAC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 19:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8FF04E378C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 17:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08A329CB24;
	Wed,  6 Aug 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VD9wmOYD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07629AB1D
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501151; cv=none; b=uQ3EYmyD9BWcaHCAHoU8uMV8VetP9ceuAnaAk8jn5FEH2CDKRtCwM+0MjoDqtp0NIjwZ61+m/Y+V+MtZWeJesNiqY+WF7V+TzgiJr8dthJvzkTs+BoFprK5iOu4xlqOF1ZvQy8rcV6obpY6ZC+KdyGn5iT8wgR3S9t7SD8+viUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501151; c=relaxed/simple;
	bh=Cnfe81ebyCIk8w/h4ZV2DZyd5yj+BwIO3eFpimyJFZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDlqW/L9BisU6hIQN813+s6NCuDgXeVjP+yeOx+x1YAZ+yYnr96awIFPWIv5CFVoJwx6gKGGZ2NEwc0XCxa2bd35G4W9/DmN+hqPAqqequdx07StQV7/fPI//hQdYX0gfOIe2uSwOXQmRP9lBi9XnBe/OTs0Ptk5Z3fcMAmlQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VD9wmOYD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576ANgLo019477
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 17:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eVYjI3rygCGwLfBirqa4CEGJ+oQnrEt/kpH
	x3wnKFJA=; b=VD9wmOYDlZZ+wc29v4hP/QvVEoydomsDECUYB5Y1zl0BtGGRDkJ
	P+YAyEndBnMQ8OHhYtRBrutJ3y1n7Vg2c9VVg9zodZSMZm2lS3gOB702edLcEwhV
	E2D6zOV7TNDtfFiqe2UfHIWSc6cCQ64SK0Jm5kRXvjDncqBYfROTPdVWFicJpIpk
	F66Ul9V0uOENdBAjNAu/Xfm3jAacB5wcA3g9UP5P6asEGd6bNeW01uO3GcV/F11i
	9RMyMZUIucIJ9rnBNGT5sKR7kWVN9RA11ng2t3qB0R1RJdh6JGnlT8AyxuPCZ1h1
	YIeMkReASIUPcqxqd7h+QObQIS6nD23A2qQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c58695kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 17:25:48 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b42218e4a59so39419a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 10:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754501147; x=1755105947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVYjI3rygCGwLfBirqa4CEGJ+oQnrEt/kpHx3wnKFJA=;
        b=f66UnyffIDMsbQLh4asZiYC2duy0TN5dsckXze4DP3uLRr6qBtWm7+TQdjWuf57hvS
         ryJZJsAYmESsdGcFmFT2lbHejYzkGtDQvxHBn+qN1SCYqKsMSJd3CRmcYF/vUB0FDRMi
         lDIcE+dGPf3VdjU5TptDR0Ag3H5h74qxxcDzklWeInv71pl5GOdFD0n9LI3+iPACAc/a
         qKz2rCTHPQov9UoE6KnH+NMWLKzUPlcBsjQzjLBCyr0CE6izuAwPaTQzuDk85Rwlm6++
         6C515Rg+nwV91f5UXCEpp1W35+uYa1XyN2vMbZRxLNSPxOVsTafHNOWOPl8ATd4Mrxl9
         2F1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXk7QA4Gu/UY0tS1NVmeJvaEktZGvAySu0LTzp7kwIQWB4HHNorXdlbVEpFfQF9dj5UZCNK+kyDEJrqyf8KTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUZ6FrHfQwpEgBWRyF+BTWzejBeqNQ/2tH3f3D22lYTzVP5IMY
	LTuqjxMsqGJJLDVqjEb9jnmf1cDdb6EGyGqcHvuQmXYLtTcKPIrfxJYK2k+tvSSrRo3iLOX0zJ6
	JkXy7431FLVmZTsCfO4UiHp1nS+RZI8MRJcW/K6JpfQOHlajq82iDHtSxhZ80EjTy0yvKpQ==
X-Gm-Gg: ASbGncsK3g5sou/Pwc4ub5tfCrH4fPCzn3NdbxAojgatPLX3UM1coGPC0vWi8tJZMlT
	w9AR6L+i8et9/QmnTUNe4qCyMDEjWddKxvDm6NqOdziIa+3LXLVV7AkmyCEKuQUwsNE1N3Ir6Nl
	4XqiVREqdNRYAt+zd3i2S+8qjmjl1mctBuKrSEw6zdfduW2mXLjWGg1YlLMCbD9gJ/wCABHD6Mz
	heUtQZM6PibJ9wJahlYRj6/yKi0E1ozO9AmFDvi1QIgB+wtG9O4ZcwHpg6iDqm0TkCInC9clSSS
	mzXn/QQikeVMXRrBj9zBRNDN3p3SzO17SFDjQSoq2qpiaJx0nRYcGZc5dqKgsCYtNEE=
X-Received: by 2002:a05:6a20:6a26:b0:235:2cd8:6cd1 with SMTP id adf61e73a8af0-240314f8cc4mr5563442637.34.1754501147504;
        Wed, 06 Aug 2025 10:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu+nPMT7IIoSPFhOuYdFJmJMRBwrZH5TbAT34dZUvgIdZmjKpP2Xiim6bvjiybrcOPhuzQjQ==
X-Received: by 2002:a05:6a20:6a26:b0:235:2cd8:6cd1 with SMTP id adf61e73a8af0-240314f8cc4mr5563397637.34.1754501147071;
        Wed, 06 Aug 2025 10:25:47 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f417sm15866210b3a.44.2025.08.06.10.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 10:25:46 -0700 (PDT)
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
Subject: [PATCH v2 1/4] soc: qcom: mdt_loader: Fix check mdt_header_valid()
Date: Wed,  6 Aug 2025 22:55:28 +0530
Message-ID: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iunazInwkmFraVHE54CyRYfFqMlbBlNy
X-Authority-Analysis: v=2.4 cv=MZpsu4/f c=1 sm=1 tr=0 ts=6893901c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=o9fwi_DDGJO2X54_KKEA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: iunazInwkmFraVHE54CyRYfFqMlbBlNy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA2NCBTYWx0ZWRfX2v58xG+w3D1n
 dWxMHG/dyJ0DhDplCmNkqfzSnJlQuFYvbdKxh/IOoT+9mmWRxJQZplA33buJ65IziWuQPs0pTdE
 hbnSP0K2KNqXGAQ6OTLsPfoSyIvAfxHBxZaDy4nAupjxMiARISsqwLtR/vw33L4bZQY4nuilYF7
 oEI7FTF/NuTzP7PpRz02w5Sbx2t9fNBhoieg4BTtE5zX/om3cLcsRZd6XoyOZHLj67t0EZ8VPmD
 Xoq2yqWIQgRP4da1aHY7/HAyn8ReH0Qy2zmZC/JKOUix+lWOnb3I1xo3rJ19N0H2FgYMJTc278o
 bQq3oqVn/OOBtNB+qbILNL4lxEEHxicyLzOl5duR6oMr6BwykpgokNyI/Pop1TehfqJDj9Xtdgq
 72W63pKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060064

Firmware binaries may lack section headers, in which case
the e_shentsize field in the ELF header can be zero.

Update mdt_header_valid() to correctly handle this scenario
by adjusting the validation logic accordingly.

Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2:
- Make this patch as first patch of the series.
- Added R-b tag

 drivers/soc/qcom/mdt_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 0ca268bdf1f8..2a14ba9b0fb6 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -39,7 +39,7 @@ static bool mdt_header_valid(const struct firmware *fw)
 	if (phend > fw->size)
 		return false;
 
-	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
+	if (ehdr->e_shentsize && ehdr->e_shentsize != sizeof(struct elf32_shdr))
 		return false;
 
 	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
-- 
2.50.1


