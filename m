Return-Path: <linux-wireless+bounces-26121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EF0B1A1B0
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 14:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F23B18E7
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331FB26059D;
	Mon,  4 Aug 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QrwY1oeF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F82260563
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311369; cv=none; b=mWR6RrWhQ1dxL+ghVIle1bQSuLMfOBpwzrDiCJbHz6JmbGFRrrvTdmPpRhHbExIoPCQpDhx1WweeoLK+7kH5VbNMt36KhSXDH7EcUhfBV2qAuOqQ4s12Ca3jcLwOjN58I3B0qS62ymwJz3LOeD4EJVLWXBkZ7xjczWAodpIZQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311369; c=relaxed/simple;
	bh=ZD2cfNOpHxwkRMCN7+js1vyBb1FTVU2dFAlUapNz9qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BwyFMoBO2XakgkyIYQ8VWdYORSC6uUmwQgwTp3+83KSkwEkw5kDweRRgMhuuWTwCxS1VBhITBUNBw7qvQAOvm+RBE+ktSWJ0T1h7uw1tGIZGQuw+YOIhz+scSFhjx2EB4W7+MPCuB0LhbpON3eqzngGSFI2O/9EAy7+VvUL0Hac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QrwY1oeF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748PLtU028463
	for <linux-wireless@vger.kernel.org>; Mon, 4 Aug 2025 12:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E7khlvNNDuoulE+J6oEwv77nicTb/IEKyXaurbG6alM=; b=QrwY1oeFsDIdUUZt
	h+veGqFgX2T0df+pc0yih0yBxRl8y1jGxqQ/NV5o04cHaybiU5MCubmOddioLmkL
	mDGn1KsoDGSPT4iLTXY1fsEiJxkuoWF/KCZBeTvppJv0LL27S5+BNj2bGHgMQChB
	jZM5GVJcL6/68lc6LKdY45Vy5iB1qVpB3SKiCBImC0Db1MJUxZwnQBTpHQ7h8RgY
	I3BlVHQua+S8sDEeGPu9Wi2nxjw3JGyM3Hcgo33Bv1G8HYdNKzibG8K6Vn4xuDHF
	ucWOuAQgJv7E75Q1bSsEzgNQwcoMgaxGgU89Z9Ej00/OCoGsDGb4hXBkXpX+/cjH
	7TE+Wg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489byc4wyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 12:42:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23fd8c99dbfso34459675ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 05:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311365; x=1754916165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7khlvNNDuoulE+J6oEwv77nicTb/IEKyXaurbG6alM=;
        b=DacQl/qXawx3QDVXTMBqd+aGeQnK9e1a+VW+nXHkEk+KuHnWunT3BjgqS/CwoBkm57
         Bh6AEIRGs4UY9QD6foeW9MZ2Fy69+xAuYDbuskgh6264obCfBpJw1AeyBgamhWDUGmSA
         wdMPiJCU/d030f1RvydS6th6u8qT1hKq/2slPGXe7GA7kcZcT4j65eejNjEW2Axx12Mt
         /LEotdyWQ3rYYjcp4RvUuiZFa+3ORZD2E23LkeFZ/6J/jSKzmhDHB+OZP8Uvw9vjH6+Y
         IuQh6snTrlpHgObsC7GJUbXZoQrhrlEdfdH3ofwR+bskgqKSv7C3r13HOhhFh1oWDAbp
         QZUg==
X-Forwarded-Encrypted: i=1; AJvYcCWTNfiA6wq4XgS382KtJnEALREH/3aPz2h7veOwo/UDa7qE0XhE5k/wabgtmvlfyXfEh+C1CyUvTTjlBpqlcA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmz03CmOLa5oFDVb/J4eid6xC357UmvOiAWZ/8SpbW4UsgiWHR
	gvIwkCd7tEeREzqcYQkjhJcaZ1ttpLf8O/2fHSaHgkBuEPQpFZ+bvPugjtuiAU8n93pMlUP3sQK
	UcYWlqIeSdWCst4xVAihwVfFMQwPF+5yQjIADCXl8GfkC/PFDlMUpIXKOO4JKID8GC3BhPw==
X-Gm-Gg: ASbGncvwYd0Aql5BMAiNyfNDPpyn8gBwHCYet558eBgdmjnv3PvH2S4knCGnJCD4oBQ
	5edhko56YPo/2qwOVzB/NKUGBZQZXvBJMgQTLt+Fycdo8q9ha29C5OFDts0OZ0sYibBpQFGfkww
	UCrfFxIBGn/bFWq+ZtzQbfoIyWaZM4JMDoP/7JPq6M0czp8xQThNx1YmG1HfiMrgQ8f0bdpPErA
	vJW6pQb7VLIVQveMstNI8YlMHGhfTir4uUEbL7T8btXpiApPYWhFx9xHns5gk1STgCwarhVkNKE
	eQ9+xYqvu9wPeBX2JwzsYl9P9qb+4OqfwASgpSQjKKndD+txUtruhqqBfkrkCAGyT5I=
X-Received: by 2002:a17:902:dac3:b0:240:6ae4:3695 with SMTP id d9443c01a7336-24246f461e1mr130978985ad.4.1754311365211;
        Mon, 04 Aug 2025 05:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeOucmT72G4obyRlN+ZWNcH5Q2iHFWuRsaszukVqVSTemP28S1LdiDIliCYgYSEqOFKiYRGQ==
X-Received: by 2002:a17:902:dac3:b0:240:6ae4:3695 with SMTP id d9443c01a7336-24246f461e1mr130978495ad.4.1754311364777;
        Mon, 04 Aug 2025 05:42:44 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef8204sm108876365ad.34.2025.08.04.05.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:42:44 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 04 Aug 2025 18:11:51 +0530
Subject: [PATCH 3/3] soc: qcom: mdt_loader: Fix check mdt_header_valid()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-mdtloader-changes-v1-3-5e74629a2241@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754311345; l=1035;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=ZD2cfNOpHxwkRMCN7+js1vyBb1FTVU2dFAlUapNz9qo=;
 b=mtBwG5naW5sNpYeSB0s+MuWu8v5N3eNWKJQxjUkuVslBWPyqweBsrkgRKZIKRu6ocioTpjV+E
 38wGTOcs9trB0+XJueeCQ+8YMfYUL4Njd8SL8xUVCDRnhbU8P0YfH6V
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: dSKSntxwbhdYhTH33oYcxKhIYhHYajMj
X-Authority-Analysis: v=2.4 cv=Y6D4sgeN c=1 sm=1 tr=0 ts=6890aac6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=o9fwi_DDGJO2X54_KKEA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: dSKSntxwbhdYhTH33oYcxKhIYhHYajMj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OSBTYWx0ZWRfX8vpiFwW/Q9d3
 cYScs5oAQxkwXZ8RAeclU53iDGWXsPN/QrmzDVSGIW0ZK/jwC6y/bPGUCtVcCWnVQG4Y1aQOl13
 raPfbWmjez7ZqJoCU+PU4/yVWYBINJozQUHpYX2dpQg4awtEIHSf0AxLkEVYbzWCb6aHdKVv8xd
 /TbdxpCzZarQBqXBRdi9IeOhfYLUOt2YZdO3+7tM3JGOUbU4eUis71+/A/AY4jvaPQGgJg0jajR
 xnhcReoZBQM9h5aom6pQDSfYxlleF8xvTLcTstnnhK3ErEZstNRjrbQnQHhyhikl0fBlNw9mzxM
 tAPegYa+54JFoCfb8UGusZkit7V3WZzTEHFzFh0dZ4FAwxUjoDxjSyqohhBKmi4Y0tRDEdbPHpS
 wohG/uS85FwSV+t3TfPSYRNxHlWPyQD2UF8L+NdcaKRq43AuSF1qGqmtdRYGjgaKJOEMLxm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040069

Firmware binaries may lack section headers, in which case
the e_shentsize field in the ELF header can be zero.

Update mdt_header_valid() to correctly handle this scenario
by adjusting the validation logic accordingly.

Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/soc/qcom/mdt_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 7522223835f5..8210fb3dd51a 100644
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


