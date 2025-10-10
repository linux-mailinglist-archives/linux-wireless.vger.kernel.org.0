Return-Path: <linux-wireless+bounces-27931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33653BCDFAA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 18:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6C6425FA9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4E81FBCA1;
	Fri, 10 Oct 2025 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mNsikZVo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D7321C16A
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760114795; cv=none; b=gy+W0qs6Dez7wLly60gyjwXeRYizhakt1YyqCdFlL6w5lCH/++Q+pAdfL0wikOnOLig9BggmQc1xIQE4iTRQsTlz2TZ72TCarEtCb8aN/YBP4DlWDArEXGByuey85xei8LKKxJmeYHG/Qs9u44nb5fIJhVa3l1c30bkcaJwg1+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760114795; c=relaxed/simple;
	bh=Uco9O1s+Z0nETMe4wo2Hqli+tBmo6Vhv86UjwJBIzAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I47x2DgTjHRj5laGy1APNbqjKAnYJVq1kyllor7k1OwH+fAJX7JMeZuSODl56mESwi/jfoe3gU0Ny0fh0qlLZZ4DpZMfAuqMGX2Z+j6bDsZmAJVDwWCndt6ZuNTM6CV9gO2ZQNg9ESvaDbL/SN1n2C5cd7qaQmicD00o1Mpctt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mNsikZVo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFHEe4025148
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 16:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kh9iEsij45plAaoQh2Xc29
	0ky/7j3jYE95CHbVbG25E=; b=mNsikZVoe5M/oxcLYiOMu1TlLhRHTRlu9Ae5AW
	Awhg61idruVfkNKBHktD4DK29ggixRwj3heXjEKJJeaRlTyEPhqac/0CITvlmmwt
	4if0YRZWkJMRmtNSBOwGmOWliJMAbSfd+quYndS6XymL53peRvp2AutAZN7v7aIm
	lvWZIUZzoyveuJdnBHSTRQLAOIki7wZCvmZH9JaRWyrE2VjRoxrWXazQ1zf2yq+u
	Bfplw5EOrp7CvC9RWfq5w/iz5OrgmC/lvbz0vv4OUFyGZj28IyUMDzYXJkFL54oY
	1+X+pZ/J3QI2A32X1GAudQO+s6FzKd7ajeCdEC92w0qQ+hng==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ky3qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 16:46:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27356178876so29682675ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 09:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760114791; x=1760719591;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kh9iEsij45plAaoQh2Xc290ky/7j3jYE95CHbVbG25E=;
        b=rGmzCdbrFmJYyF27IOJW9N+cpWn/oZQkq0iDpvcRN564ma8mKMk2Stuv5s+QdVt+IH
         9I0UxGRLEBifHwQJDpT/XI6UusM1l+KcEVbqOmIDfkzwbwS9yYfipQnWUJJC7ocrN/nK
         X1XRXUbZNghm9JLj9xLqMvvvwSAEWwFYw0js9Q0m/QA2jlBIHR9i8wdqOPXQKK7mdWbB
         6317e9sEaw0cQeTmSOP2KZ6cYumdCeMbqcrWHgXtusbW5+u2LzBcOJyg7VojZWZTy/Q3
         GEOzpZa8mD4iO9aeGOSOi1+CCHwbjANqlJtTkotITLGenQ0owh8u4Mclb0KnYmdV3su4
         vWzA==
X-Gm-Message-State: AOJu0YwbDMa6aCOzBpMmHX1E/9a0ajJjt91i+O6vxjvH3SgFDHytV5NN
	Shs40YR0Sb1iacsXxygJMkS1fxg+29pK4zhxnicS8kTJoV3wCU7GEKTuebAdO9lsLM5nVOS6j8a
	EArYiQReyJeAX3XND5lj1SIeBwMN/0OyhybXsZWNK1HQJP8IkJ/jtvkRdstop4XcGvI5h3Q==
X-Gm-Gg: ASbGnctTy09zu3FEPZq7lplehp1oNUL3Ur5c3WVGEcTyf8LNuP9QkX/iOR1Gk0Ee2in
	ZKezP27A/ibrFzt0NNaWbTfpxLwi/Nn3MAgu4/npuzaXZbwjIn+Kt11mXn7Jebi6WtGDj0J0gpC
	z9XgJfq5dr5Svnz7asMumLyF7OFc2145fxLAMGzKdLwM9pHgX2HfxDY04qOQkgH+j7TcQW40l32
	ob7eTT43lPsx1E0ZR4qjNWuvjttLrkElfxj5rf85cxwBsGlF3aCOTyiYvnyfDJHsPIjnqLUJkql
	klcppM6iMcgshX4sA5UgyFJOM06gvNMHDN3+LUDQiyTaDivqVKGGXAtZlL6avh7Q0zIDOXcv1W5
	B
X-Received: by 2002:a17:903:1aa5:b0:269:96db:94f with SMTP id d9443c01a7336-290273ffec4mr164572425ad.49.1760114791456;
        Fri, 10 Oct 2025 09:46:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsxeyikdMvc9n3cRyalMxLlb1YcFKQRAqMJOZUbfHHv0r/1PIx3oESwUGS4QtjuZ977iaUcQ==
X-Received: by 2002:a17:903:1aa5:b0:269:96db:94f with SMTP id d9443c01a7336-290273ffec4mr164571885ad.49.1760114790829;
        Fri, 10 Oct 2025 09:46:30 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c07sm61831635ad.1.2025.10.10.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 09:46:30 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 09:46:27 -0700
Subject: [PATCH ath-next] wifi: ath11k: Remove struct
 wmi_bcn_send_from_host_cmd
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-ath11k-nuke-wmi_bcn_send_from_host_cmd-v1-1-bfb5118d9018@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGI46WgC/52OQQ7CIBREr2JYS8MnthVX3sMYAvQrRAGFWjVN7
 y5h7UY3k0wmeW9mkjE5zGS3mknCyWUXQymwXhFjVTgjdUPphDPeAmOCqtECXGh4XJA+vZPaBJk
 xDPKUopc25lEaP1DFOG5BcBTYkwK7JTy5VxUdSGHQgK+RHMtiXR5jetcHE9T9V9kEFKgApQdoT
 ac2233Mubk/1NVE75sS1TTx/+i80HvdCdSKdUybL/RlWT5wFwSCSwEAAA==
X-Change-ID: 20251009-ath11k-nuke-wmi_bcn_send_from_host_cmd-a02e8192e9e7
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX1elOZevN7POV
 hFKPv2LYgPkeBUCfpJkZGudX/5NTVcVb46r3fVQbf78CjNQeKJAnvHiX+EaqRR+DQNXzjCk0Gm6
 /Q0gM3+QKa65oOQJLoPqBCsSVjBdb5FtOWqcqYIrhQ6aOLtbSPIZxGFtKzO21GXbDvpJQY6al9y
 Nt2URsLU9LakyTRwne0jaEH7SXrFObrJqn85lAPluFlJfyO9Hr6/e+Zurj6qDBGEyj1Ao6NoHXo
 ZdlDD/A6NWdHFpZIULZGFTRWXuarwIf7DLt7VPt7RZY+vCXAP6bwNX9ZJXvnJHnhijes9TJ22wB
 wP6vgj3QOsgsQDcV6rQ8PyqY7YtsWOsIQNQv8sicDryVFa1vhPg0DqaaK0NkazQFvELhxF/ZNLt
 I2n8rAfiQdmyRgV4yuIoKBF68vsyzw==
X-Proofpoint-GUID: qlnrG4ZDOkJGD8ASXHHrc--IZ_wmWUZ-
X-Proofpoint-ORIG-GUID: qlnrG4ZDOkJGD8ASXHHrc--IZ_wmWUZ-
X-Authority-Analysis: v=2.4 cv=SJxPlevH c=1 sm=1 tr=0 ts=68e93868 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=IK4e_bFUgs84OYqGAtIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

struct wmi_bcn_send_from_host_cmd is unused, so remove it.

Compile tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 9fcffaa2f383..3c4885a12855 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH11K_WMI_H
@@ -3463,20 +3463,6 @@ struct scan_cancel_param {
 	u32 pdev_id;
 };
 
-struct  wmi_bcn_send_from_host_cmd {
-	u32 tlv_header;
-	u32 vdev_id;
-	u32 data_len;
-	union {
-		u32 frag_ptr;
-		u32 frag_ptr_lo;
-	};
-	u32 frame_ctrl;
-	u32 dtim_flag;
-	u32 bcn_antenna;
-	u32 frag_ptr_hi;
-};
-
 #define WMI_CHAN_INFO_MODE		GENMASK(5, 0)
 #define WMI_CHAN_INFO_HT40_PLUS		BIT(6)
 #define WMI_CHAN_INFO_PASSIVE		BIT(7)

---
base-commit: de7674ee69a0023a2dd1c6f0cb66f3cbbba89923
change-id: 20251009-ath11k-nuke-wmi_bcn_send_from_host_cmd-a02e8192e9e7


