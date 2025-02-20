Return-Path: <linux-wireless+bounces-19185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DACA3D4E7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 10:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B798A18943EA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36881EF0B4;
	Thu, 20 Feb 2025 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZFHkYaPe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A21E04AE
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044216; cv=none; b=cJZxxN1PCDZusXxfiHEK8Nj6jIbmMjYIZCP6W9zKS7KnEdZvpu1Y/wUPRO7w9CzBJwI8t72dTadMgI5/epQcl4TlEIz8NMfXLFF2X5ygS8W03z9FH5rBRLzePCjeNuXM8mSHmlBKJQSOnl12N5inZq4UOLoQDsZWqGwFfJSc7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044216; c=relaxed/simple;
	bh=nePWxrEYVfMdXeUV0KQkCwSFK9fHxS78MWx4X/MxDDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=apwDyqMRw4narPXHjL13ZabwhTOBCHWu8woX0YnzOLw6++7ULAPjN69rXIYgQ8fkgl5YnxpHDKWochmpQWyUhnXGo7WpbzVHRy/40BZFS8MIR7OP2o43RX330YHUTw1kBWcoujxrlejyZbjnsPfUM7nNcUtC6Mt+uR03UewOPt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZFHkYaPe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K62xBO023221
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 09:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5Ha66MvqNoZqX/Zen8LYEqzzHd5YQENJb7y
	j1q/J5J4=; b=ZFHkYaPeJyeKBb6XePEGz20ZEZ31tJQ6BXK0VoeZl49/1spZTi8
	gSDsm20SKjnoKPZBgARjNUJPH0pYp+iF/t65lyiV3MWAu6G5Sn8Gqi3a0PkRhF+3
	qjUrOtQexYoAVR7Ye+yNa5Tnsr3mQV41SfF7LWdnliXYK8y5Zd0cICEsZziV7PvW
	gHmCZHE5TA+QT83ZAYbEf5mfVIPuow61k47PEICmClkop48XrvS6mmo6wj8RgnoH
	sLNvthrn2Mg82/Z/vMxEAYqNX0BglPO16RRJsO1CmwSSHXH+YAxo2+xiaK6LTumq
	cEVyv3jYJ5eEM7h+zow9oqK9EDKGqndOgyw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3nq98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 09:36:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220e62c4fc2so16609235ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 01:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044212; x=1740649012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ha66MvqNoZqX/Zen8LYEqzzHd5YQENJb7yj1q/J5J4=;
        b=ehqYocw+HnIN+JwDx9eR7to1e47a0iF9wi/hQyDv/kQz3gQrOtIyTMoVINZtZdtGnO
         VXReUAQmlcKJz1KSDZvTPwOeR2Hqa/1dAqKHR1sBopCtIe1G4F7hOGg4oDyzwCxAp8yw
         PXO13QfSepYlJ71VJCcdOrOHASX98u8gLrJl6H6TGnvjHbp9xzQ92hrXeaA8q3X0zY/z
         iJDrTQ0mVzZZFIyVjbIYPUTxduKVbPtf+mFvpFWTw52qdAgnZ54zARft222+J/ZGEWyi
         A9BoH6Xp8B3An+bRQhdwr8VJM7xPbv+KQFCsTZBnJUweDP4Q4EOmyKeqoq6Yr8+SJXv3
         zDLQ==
X-Gm-Message-State: AOJu0YzfUqphpe91ZRyr4xIBURR1A1j+eAwnsgmAYXq/yQpWyLQf9x+w
	9kuYbJPzTIpgYV98v1+Otn2Me25u+PVlEk3DxrrFiOoV1QxUOvUgZTWlBe/fYrqehcLIJETXdSJ
	WaKWUOHtXYZUVmrllj5v1hkxT+jkQKewL/jahfSt3zPduA21bFWX/1HcbpPfQwyN6HKnx3q8sIg
	==
X-Gm-Gg: ASbGnctkGshF+u1lyFgTb2rJPyjUjR+tJjvJ5RvnZpVbRvp9XGX0Dyz29btBg1xS5Ij
	1qMidX8iiMFu9a0txC5EtAQ2PbQt6meKbkRy2Hz9dxREr+1tieX7dj10+LyBZWyVnaw8+qzOW/n
	FNgH7ZX7zea+NVpSVVRBfH8lwmNs+ibI8tzeyS8DjbliHloK96GTa/cjDOVo7IiYaQnYZAnWgAm
	LSXrowVRi9TTB4l62/Rn4E0d/zEWARRga5Xgq5gfKsgfqD6mkXK+Kw2Znz5NN8R1yVczMNGYvJz
	3SmwR9kTatbaF69FmLTfdVOXnXkrCIDv7GEbkVGjjVmCE6AvruNWl7GMQ3xj4at089bnIr7dSec
	my7zwUNvxCt/W3z9TB40+KXQ=
X-Received: by 2002:a17:902:ea08:b0:220:c9e5:f94e with SMTP id d9443c01a7336-221709894d6mr114473575ad.23.1740044211750;
        Thu, 20 Feb 2025 01:36:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZvK6bQGNak3Ju4bplSXeaPuAiVc8U3pDH2U8/Vn9gthyHRkWoWIpa++hddU3Ck7T4Ge1xnA==
X-Received: by 2002:a17:902:ea08:b0:220:c9e5:f94e with SMTP id d9443c01a7336-221709894d6mr114473265ad.23.1740044211356;
        Thu, 20 Feb 2025 01:36:51 -0800 (PST)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220dacfc769sm115440265ad.201.2025.02.20.01.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:36:50 -0800 (PST)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: Fix double budget decrement while reaping monitor ring
Date: Thu, 20 Feb 2025 15:06:40 +0530
Message-Id: <20250220093640.2443907-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Vnvy2qlsnRaUb9Pcsej7ZeKk9rOJpMpR
X-Proofpoint-ORIG-GUID: Vnvy2qlsnRaUb9Pcsej7ZeKk9rOJpMpR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200070

Currently, the budget for monitor ring is reduced during each ring entry
reaping and again when the end reason is HAL_MON_END_OF_PPDU, leading to
inefficient budget use. The below mentioned commit intended to decrement
the budget only for HAL_MON_END_OF_PPDU but did not remove the other
decrement. Fix this by eliminating the budget decrement for each ring entry
reaping, ensuring the driver always reaps one full PPDU worth of entries
from the monitor destination ring.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 394a3fa7c538 ("wifi: ath12k: Optimize NAPI budget by adjusting PPDU processing")
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
v2:
	- Added base commit tag.
	- Removed empty line between Fixes and Signed-off.
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index d22800e89485..6d1fa6a6c9bb 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -3259,7 +3259,6 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	ath12k_hal_srng_access_begin(ab, srng);
 
 	while (likely(*budget)) {
-		*budget -= 1;
 		mon_dst_desc = ath12k_hal_srng_dst_peek(ab, srng);
 		if (unlikely(!mon_dst_desc))
 			break;

base-commit: f22471c17f5849b2f20e2c56ec9fcd9dd8d5bf28
-- 
2.34.1


