Return-Path: <linux-wireless+bounces-26118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13C0B1A192
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 14:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37BE27AA1C4
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1084C2550A4;
	Mon,  4 Aug 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QkzzhEWM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035DA41
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311354; cv=none; b=rAQ3uC8Hsdgt505TxgGi/lLylrBV3miGH63fhcoT68XcheEPkG6QleLHvfsy13t5lLXw1LG/htBMxGNX4HZxkXCVB25LTnFk9mIrNHbTPeiI0Q+QHD0w0CYAl+Llg6RPh9Tah2Fo7grRAcqDKKEAETIYXY6yFAMfOiREvyuemxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311354; c=relaxed/simple;
	bh=5jNeAtqRlRHIfao+1ZBtyngNGOGyS2FzkafomVLdz1U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fg39b6BI9GhxnduZ2wJpODfuebrfUu4v13m2gfuuFZnIYRDEVJzYAUTDLAUITda1tt+3Q9Xchj88qIwFBseeu0uQs38wAWV8n6XmI8lSbJDiXCX06nVV6oq72/VYXvPeNZYfuK8Bos3yY1AW+QySWhPBpIWbNB7avLsM1XUOf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QkzzhEWM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748j3iS006900
	for <linux-wireless@vger.kernel.org>; Mon, 4 Aug 2025 12:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qND7eaxsDP2YPzCmQqdenq
	TRv6C53QulbhoZonDQY3g=; b=QkzzhEWMpf04esR7GHNFhWVzSRpYXF/4m6wB8g
	Jamr0hpExVesI04EoauCvUwjcrLLx5KXuSQWRyL3p2up5pK/sewZsLYa7wTez9r6
	OD6keTtzWGGZZMp4CvbswLsqbaw2WU2cNKewB7ymLBY4UL/a2/witv0RPvnSCucb
	ur+TzNpLhOI+Loem6mJN2uaMIN4d52GGUXn62bvXxx5Ro3cQf6ioIGceFDMJBCod
	GqqlXi3uB/XrRUphQxl1uQWstwYACP7L75FaMmZeS0/dzLR77UuJDJZOIudc2Her
	9bpVVOokDEX4P6EyCMlP3cjd4vvF0SzjLpkOr2nPceb1BnSA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48a2ke335a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 12:42:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23fd8f85dd2so34136685ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 05:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311351; x=1754916151;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qND7eaxsDP2YPzCmQqdenqTRv6C53QulbhoZonDQY3g=;
        b=DKUC35geHJ8uIFPTDeMXV+rNEPnSsXiEnhSity3yEKlKjjkRMvIbSQJOkmee+EN6Tb
         GvTt6ymtMfBpGvqn2Kw4GEl5t+yysmcjLKsDu+R6NWg3nTjrChHz+O0xyTlzX1/VO7ZP
         ttnnug7PtxebzM4+dCNMvtr2TnenRNPHf5SDn0M+Zg8XYj2+I2G7NxdMYA+qaUk5sEaG
         7NQwyqZH+YTY+YPTLvRz2P9P14/gihTXkZcLBCvcxjXgxJwcoaEYZbkIqn+X6cFAc9Fq
         7pS+i+VtBmG60rqloojldnUNsDMaVCJi+0MHFWu2tT2WxPADw4q/mY5IP1AUV/zI+X54
         VNJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/q3dx6ItWhwxJw6e8LWQz1WB+dLQbMyV0/LtsLpWI2EFBebpvwQMUEu6Jzm9ipHN3GIMtfNv4Wic7u2rNVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbr+3v2NKIxXGJstVkSq4YM8+JHyQJ4+W0UaL/3xpn8hTSn/C8
	sKOYdwTt6mvkf6TcPZR4XbOtO4iFBeF+Ec5IgNenwaRFIU1TloXpj+uHucfK8QARP9G2HQQwAUd
	mlQSUMwv/fRiMcLIB8r8DXOAqwCSlRwK62Exht+V5jrHiQWI43IiQdgqdAqfhHopcSDYFuw==
X-Gm-Gg: ASbGnctQjxP7P18E/yLwltw42Y92RqzHc+729GpksCFkRHM3cWqcq1xhip6Qa95OiJP
	SnsXZL4DuWx0n+8SQp2Y/7nLd7c1wlCaEsj4989S107MnV0jl6M2FOiwRAMGL5VVubCw1+mrTiT
	kIflJTwGMoP31LjWejVWTF528EoWhudzDFD8lB8Y8iW+v1VRSRfJzB+P93TQWMGFjHyuNGcgIs4
	lpnm89l2sN7pd6fODZJ+e2mudzLExOWWkIBaaEwrd+VtnGWLLtyaNY0YRn6LIo89GcPRjPYyOD1
	wIyJahJvNymO5BG42wv8RSxWwlQ3J0MlEBfw9kBCaLDzKhsivFjpa7UPct0doNqo6ug=
X-Received: by 2002:a17:902:f68a:b0:23e:3bdf:e3bd with SMTP id d9443c01a7336-24246f5af77mr145455335ad.22.1754311350799;
        Mon, 04 Aug 2025 05:42:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG07rzuN1fGkVlEDwaXMjcJKT4QW5T0QWL8B3N6dJhvgGjnkR3R+HIt1As8+4jwK2M5o5BtGQ==
X-Received: by 2002:a17:902:f68a:b0:23e:3bdf:e3bd with SMTP id d9443c01a7336-24246f5af77mr145454915ad.22.1754311350374;
        Mon, 04 Aug 2025 05:42:30 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef8204sm108876365ad.34.2025.08.04.05.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:42:30 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 0/3] EDITME: cover title for mdtloader-changes
Date: Mon, 04 Aug 2025 18:11:48 +0530
Message-Id: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIyqkGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwMT3dyUkpz8xJTUIl2IfLGuZWJyoqlpqkVymrG5ElBfQVFqWmYF2Mz
 o2NpaAFv6VxZjAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754311345; l=840;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=zP+SLmOOtTIzO9h/zziRzrIH5ayjpiu27qhU5x3QZj4=;
 b=rX93wR4WgVYLlBcmB1rP7toMI/2qOHb6pLI8G7KQoJvGrWbEZfhFvr4DTzgeHlDFnC12NCLsJ
 n3B4pD+68yEAYtaMDGR+A80oiHxe30L8LX/YjdLYpSdQVaMP+ZMUXf1
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: oeG4yTMJP1N4CBroVwP3KGyvSiE3UITg
X-Authority-Analysis: v=2.4 cv=TMNFS0la c=1 sm=1 tr=0 ts=6890aab7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=mWPGPCZChkjDq24jzmIA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OSBTYWx0ZWRfX3hLtv4Cri42e
 i3vx3HJ5DnCYr9qxS8qk9BYGwwltQfMdznzgRcXbDEyxu8N9mHWH99vxI6gtjXhbbxZCMmPvcD9
 2ToSiHwsylAppbcUyQkB2j7mLRyBZdHQNz9NrBNxnAJZNFgsm3CdqxVf10FXPV+nz6Qer+jG43Y
 HwFb0kz7jWxmBmy6saUtD0JNJ0AnTN5J6wS9AB8R+FgGHDhs3dqTw9uIAAeS5vSWoh5UQMwnepH
 PvYlqfXzTmtTALA9fr7GQwkwK2Bd4V5VB/e9k3ZtrGL0aN4W43bUJqNbG3jMj6mLM7NzykTO9F0
 9aI0NOpt/J3x1W4PraFXfLAeP4o4XKvLsgzhPHC1D7TgWkX6gI7A/dPFHHOsoe4F1WUNDXJk9C/
 d9D1JIBU7VYo3p1Q91cWmLUwsJOI99DGxrBw/4MTQAutUpQQxHXEixOLJfLPnXqbjqt1kkA0
X-Proofpoint-GUID: oeG4yTMJP1N4CBroVwP3KGyvSiE3UITg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=785 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040069


---
Mukesh Ojha (3):
      soc: qcom: mdt_loader: Remove unused parameter
      soc: qcom: mdt_loader: Remove pas id parameter
      soc: qcom: mdt_loader: Fix check mdt_header_valid()

 drivers/media/platform/qcom/venus/firmware.c |  4 ++--
 drivers/net/wireless/ath/ath12k/ahb.c        |  2 +-
 drivers/remoteproc/qcom_q6v5_adsp.c          |  2 +-
 drivers/remoteproc/qcom_q6v5_pas.c           |  7 +++----
 drivers/remoteproc/qcom_q6v5_wcss.c          |  2 +-
 drivers/soc/qcom/mdt_loader.c                | 22 ++++++++++------------
 include/linux/soc/qcom/mdt_loader.h          |  7 +++----
 7 files changed, 21 insertions(+), 25 deletions(-)
---
base-commit: 5c5a10f0be967a8950a2309ea965bae54251b50e
change-id: 20250804-mdtloader-changes-9aca55e8cf37

Best regards,
-- 
Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>


