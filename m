Return-Path: <linux-wireless+bounces-20567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16365A691F5
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 15:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6533AA3BD
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A82211A1E;
	Wed, 19 Mar 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoNjbZBq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF01B4F15
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395412; cv=none; b=miE/S6SsdbLMB8q+2ZIPadYzBabEA5HGeyvE26RoURmh9tiVvte5X/5P2qcKyYxti6JEEdFkazRcs3aCVIqvAFip6zDgDduuaCpUkqrgzrh3D8COfibo9XBVjqeG1GkHKFEt71XxV8+3xz5I7Et2doxxSTte8nKFTC4UAuPkpiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395412; c=relaxed/simple;
	bh=AanE0vCV38O/FAuVLfDGbo+3+cOqv7QLM9XwLXPBASk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f+7EvZUkVrZM/kgtYfWiX7K18Ao7O8EmZIKEfYb7iJSD8d3zIZH4CpZzFPakxBzUzEyKT2D5m20vWbo4aesMcv0kZZGRevz7Nm1znt4K+ua01bt6VD7ervVbGnW8tygGlpSiHK70rPYkzQipSTk8KLBmo2KU0JoP1oWKsgiFSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UoNjbZBq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JDcdus020421
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 14:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fDks5bNiL4TTAIcOPwADQX
	cQw6NbYQj8DQwp8LVt+vk=; b=UoNjbZBqA4OhTgbOjOojqE2me6qvca7X9xX89V
	pDmymhE2M0tYQ6r98OGHX7KLJzIpcLBweA71BhSt6VA5/GtQCjQACQZ786bVyMo/
	p/RF1QAGV6rfd8CAk2gNk9VE4nbI7dv7wWN2yFeviOPENE7t9Pfj3Fjr2lxJQCKQ
	k548ORLFbFvYle7Othd4v4U6Ytj3h4dtTjyjUMVQzyScb1KM13w2QK6bR6QZHUIW
	z4cw7AHPR2KV8INiFKxwxriD7RaOYQB193vzjKi5XyKhsKrA9oJ/L+rziZ5S8I8U
	Osq9SqZtZ7r0wlKj+5XEh/EjLBcxj8OKZ7IEQOHNXLMP+ixg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdmwu0g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 14:43:29 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so12044047a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 07:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395408; x=1743000208;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDks5bNiL4TTAIcOPwADQXcQw6NbYQj8DQwp8LVt+vk=;
        b=RVqd4mV3BeRVJbkXLZKcRhXSfLWSWRpYthD0ANdmkULhsqlr1Nw+LQSUJq85DaodC3
         3sOvCCirZ76Z5IHICj4kTUivqQQK1SWyIzjwfO58nAfg696kr296im57lQqcOdOPpJfx
         6c73mG+heq9yo4sXW1Ed9sebOYM3sxtpTlz3oGMC+6y/a6+C9VgbpVrDhffqhD3+s9TN
         /C2xtkOljLjIdCtCoOiTy0+r67dQAieVWynJACKKJkUXHtq/+fT/Jgg8pTS7eR2Rubo9
         7MsAr2fE7i4q4QMMlX4VVbtf2Arep8vsb7aBF6kHQFRjGu1BIVbakQ0YFe9r2DGEYvhZ
         doXQ==
X-Gm-Message-State: AOJu0YyDnfIu4hs+O4XwaIAg8sFlUR57OJzVLicFrS106CPPgO8TG1aB
	/6X5h4WUQiusDsvk9jaXFtZiv1b/rngrHvQohcTbvwPadZ0v8Lkcgzn/yWdGF1dT4m3h8jrMjKz
	dx4vyFTZ6jfOOsIfiHXqJE+7+Ks5yvkAIDy9UwhKsIbZpUdrQH2ct1+GC4hmnksWu5Q==
X-Gm-Gg: ASbGnctRnqoBXI1WdV6ZIipgPt7sQSgge9Y48FpPiq7//CwrxBgMclm1p3KrkNKZkb6
	v+FaD0whl5SGLlIq/480/GgVsvm4Xe2FMbab+sqDMXpk+bavHAWRUhMmvWfiQ7CsYFl+SiQYLWw
	fZbV/esY6MDA/vl2azVwaMjH4dpib6ULPQ4WslYDovkHM4h74/vyZhqw4R6zEu/IO6259n7r/zh
	WWvu4r5caEUIfZFPqjH/IquXYEgHvGIyVRToiQiUYSTFzGCwtYovAexdm++Cco2CJAfJFh1Z/zS
	c8VtYETS1oDACnaK8ohc+zGEgFuROC0VIHhKtVscO9xQnytTOa+8
X-Received: by 2002:a17:90b:180f:b0:2fe:ba82:ca5 with SMTP id 98e67ed59e1d1-301bde6cf2amr4834254a91.11.1742395408445;
        Wed, 19 Mar 2025 07:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg3Q75Qci5DvweZ40CsDBT7ekjQ3khqPBr2grYqgGrv6LYAsW+kKMMcACW6fjXgPFyqBx8Bg==
X-Received: by 2002:a17:90b:180f:b0:2fe:ba82:ca5 with SMTP id 98e67ed59e1d1-301bde6cf2amr4834215a91.11.1742395407906;
        Wed, 19 Mar 2025 07:43:27 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576acasm1659988a91.2.2025.03.19.07.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:43:27 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Wed, 19 Mar 2025 07:37:37 -0700
Subject: [PATCH] wifi: iwlwifi: Add short description to enum
 iwl_power_scheme
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-iwl_power_scheme-kdoc-v1-1-2033ae38b178@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALDW2mcC/x3MQQqDMBBA0avIrDtgIgXtVUqRmIzNUE1kpjSCe
 PemXb7F/wcoCZPCrTlA6MPKOVWYSwM+uvQk5FANtrXXtjMDclnGLReSUX2klfAVssd+8HPfTcF
 Y46C2m9DM+/97f1RPTgknccnH362w0EKqmGh/4+o4wXl+AZ+BOFyMAAAA
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: Jc7KseFNpJqzSJkp3h6vbWZ4SsP3SbLc
X-Authority-Analysis: v=2.4 cv=ReKQC0tv c=1 sm=1 tr=0 ts=67dad811 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=mtRy20iSeC98bK40_qsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Jc7KseFNpJqzSJkp3h6vbWZ4SsP3SbLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=863 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190099

The kernel-doc script flagged the following:

drivers/net/wireless/intel/iwlwifi/mvm/mvm.h:130: warning: missing initial short description on line:
 * enum iwl_power_scheme
1 warnings as Errors

Add a short description to address this warning.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f6391c7a3e29..59483fbaaab0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -126,7 +126,7 @@ struct iwl_mvm_time_event_data {
  /* Power management */
 
 /**
- * enum iwl_power_scheme
+ * enum iwl_power_scheme - iwl power schemes
  * @IWL_POWER_SCHEME_CAM: Continuously Active Mode
  * @IWL_POWER_SCHEME_BPS: Balanced Power Save (default)
  * @IWL_POWER_SCHEME_LP: Low Power

---
base-commit: 3fd552b2658eb6bf2a3b531553fe563340d37fdf
change-id: 20250319-iwl_power_scheme-kdoc-89cf83bd121a


