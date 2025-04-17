Return-Path: <linux-wireless+bounces-21626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0722A91342
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 07:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F55B3AD694
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 05:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4FE1DE2DB;
	Thu, 17 Apr 2025 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FQCq3C4u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B71A264A
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868973; cv=none; b=NwZWal0oQYLuYsNNJNxpPsU9bYsorPw50xolSZvlmKTGEtRmR7xEbENc6xgsu6Jz+oQaUHJ+DP5g6dnusWWkeX08skq9ADGzNMWgn2/zz59ymnXBX+prtQpdZMSzT8I2ILA03T5k1iU46gAWAcoxOuF37RJegh9vRXCwfKiBas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868973; c=relaxed/simple;
	bh=j/2ieG9iQ2+8oAb6WoUUUdyZGzYbIIGcpPfkfihw2rM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BZnqxFQvkhOKlA0x6lCWkJHCogJ4uunfq8okeORjQpjgyvFd5t1mJUOm/PBz9j0MlATmcU6cj+nRTx0OTfGi8i33NSZ2tnYYzHSxRe6FJcRYGIa7FrjUlUASCWAo+9FH9zZH6QjDlh6Iky326yc+hR71XFnjPgbtkhQOs58cps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FQCq3C4u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5l4LM006450
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 05:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ttTa73WkTcOZWGbKb5821p
	i0YyqaxdkghvCg4Lt9j84=; b=FQCq3C4uV9KhOrAJY6H/88PwYhZw34zur04L/Y
	K7zGc07Pcr1w1VozWLCUVYS3713a+eJlRryQ8G8Fm0RJvpmFqtNJbW0H/JDGCpbd
	Hs/XV7to2wtjnF3VeIHrC2843xms++071ikrZJIlu/ScYHjITiJDrkns/7yeqFCL
	JPUG961AQuHS/Zd5y6wh0N1+RStSG2x1GzluzblUYBwWrueb8Lm+wPVlYnkdqLpT
	5XQFPpo80R7DWvLZ1IJn+MEzWlykbDt+hO8TysnjCwICCu6mEZgniHS8TI6ehPmA
	A7ItO5UuPBQwfy1sVA4x95kPQtKSj67TaIfHka97wlEwGWDA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydhqe0ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 05:49:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so375659a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 22:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744868969; x=1745473769;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttTa73WkTcOZWGbKb5821pi0YyqaxdkghvCg4Lt9j84=;
        b=CL2ACnztxhmKJC8E4vJQnyM8q0v6Tr2LNDIlR3G3C063qvk8qdtHsf4Mb/Xrp0+zgV
         M7ufEGQ2HDbvcZedatDbTjndg1ARRFHnmBJwwtwR24GDfMaHaLpsFeucapIQDABXgpFs
         9LJA6inRZUprP/kQ+Vn1bapWkK3yzuCxAsyHeUB3EAjfwNnzCM44XjgAVoHuJJvcq3V7
         wtDO9Ah0siPy5wBCDOCYby1LTlyVa4m7irvjPH8u0mv9WwGr56j83mCAsZSxiZZp+b1O
         y4MoVY2dbHIDRt3GXRzQt2U4xOOu96YbaqkPFYLDJ9Fy8FyM/KfcYoS/A329wPOgsyCv
         T4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW7/upGcs+erUUypNueujXQxckIY6oLjwuu4Td6lXvIVnruC82bVgtElmoHzcAT7qsl4NnMC49KVdec/GavCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CbeQrM4d0fMZziOzGXTiXWByltPkofV9Pyqp/70W51m8JlW/
	zQu4sONw1Q9cbxjSIeIXDTcgn9KwzKyqT18SOQmXAadgtVeCz3Ads3b3R4D0izr26CbmEsc2q4A
	n7FWSXeEyMpn0jO+liMOq8UZLjQue9NwPA1MnDIm9OwqvJ6RfQT6jzg0CNEmBkyW5oQ==
X-Gm-Gg: ASbGnctoVKHXw3uwZ1drOD8Znfu/+/xBQbOBNtEw7sQm19L2lzdShVxPFvXu7eKe/ZE
	nnDKkX5TQsW1NnWJ0mI6+pAEbJ7NzsQtowZahzf4Z+ykKliKGArZSI4az6bgOOUAJRzsps/BGYG
	eajzE0uHOcVPM2w4FykKCLnNKoTfrztuvHtJrmrr0VTiVImW9ai56WvytplunbdwpTVh2zQkr74
	Xj9vY+qbEnaC0Kz6cQ28WQqeLlHzpaqJ47jGykDKXW8CnFLyBzS14e/Zum+P2Bu9BNe3gVsJmWy
	PWZOB57wtw5iUxk4l+7WHIjBFImzM+4k/cpMTEKjDttWUGYYeQg0qYQkAoQQROZDq6voKI3BlBF
	0d74lZJoR1emWeCjsyTsBJ2jotnaDnSt3lo0l
X-Received: by 2002:a17:90b:4ec6:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-30863f1a0admr6945424a91.13.1744868969100;
        Wed, 16 Apr 2025 22:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK3GAi2aYavpOLGvxBAktOxHdMPkHBYyy0K0QhpFaR5OgCOTt0l+Kzx3QK0O86NXB8BoUAEg==
X-Received: by 2002:a17:90b:4ec6:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-30863f1a0admr6945393a91.13.1744868968679;
        Wed, 16 Apr 2025 22:49:28 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fc47e0sm24745715ad.167.2025.04.16.22.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 22:49:28 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH ath-next v3 0/2] wifi: ath12k: handle scan vdev
 consistently
Date: Thu, 17 Apr 2025 11:19:12 +0530
Message-Id: <20250417-fix_scan_vdev_handling-v3-0-9ec42513d26b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFiWAGgC/43PzYrCMBAH8FeRnDeSj4lpPe17LFLSZLQBTbWpw
 UX67jsUDx4M7GXgz8z8hnmyjFPEzPabJ5uwxBzHREF/bZgfXDohj4EyU0IZAULxY3x02bvUlYC
 lo5FwjunE8Wh6BKP6FlpGy9cJaXKFf5ibB57wMbMDdYaY53H6XS8WvfZfuK7hRXPBLTbWWRChc
 eZ7zHl7u7uzHy+XLZVVLvCu2aoGpGlwDsFjMEJWNPmmSVnVJGnChqYHZ4JsQ0VT/9MUaf2O3mz
 anZcAH7RlWf4Aaa+bNLcBAAA=
X-Change-ID: 20250402-fix_scan_vdev_handling-ef5be452b949
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: rJhpY9V40-Md_B3rGfa9l94wBOWQU_uZ
X-Authority-Analysis: v=2.4 cv=C7DpyRP+ c=1 sm=1 tr=0 ts=6800966a cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HtmLlQNqzqJkp9_W5pEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: rJhpY9V40-Md_B3rGfa9l94wBOWQU_uZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=938
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170043

This series of patches addresses the handling of scan links in the ath12k
driver to improve consistency and functionality. The changes ensure that
link ID 15 is correctly used for scan operations across both ML and non-ML
interfaces. Additionally, the patches prevent scan failures by fetching
link_conf only when the link ID is valid and setting appropriate default
values for scan vdevs.

Currently, no issues have been observed; these changes are intended as a
cleanup and to ensure proper handling. For split-mac these changes are
pre-req change.

---
Changes in v3:
- Rebased on ToT.
- Link to v2: https://lore.kernel.org/r/20250411-fix_scan_vdev_handling-v2-0-b6740896c144@oss.qualcomm.com

Changes in v2:
- CCed linux-wireless list as well.
- No other changes.

---
Aditya Kumar Singh (2):
      wifi: ath12k: handle scan link during vdev create
      wifi: ath12k: Use scan link ID 15 for all scan operations

 drivers/net/wireless/ath/ath12k/mac.c | 60 ++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 32 deletions(-)
---
base-commit: d0bcc5eaaa611aacbffe6b2cc2fb64bfc3bdfcbc
change-id: 20250402-fix_scan_vdev_handling-ef5be452b949


