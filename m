Return-Path: <linux-wireless+bounces-21408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B6DA851F4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 05:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E43019E7557
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 03:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89251853;
	Fri, 11 Apr 2025 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dmo5rb2Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D818A6A9
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 03:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744341431; cv=none; b=oe8YnPbe0pguIq97r+1SRKKJOoFXdmW+9S0OEL/Aq7B0Z2khMKhjSinboYG4QTG3CCDnFkDduu2yPZTUzelEsCpGyGrJY1cYTDrraDma2KWS+6Ejde0pG294que2onrlx+y9TTeOPePC5r7fUQqmoQvAwGaFvf+VRqX8y6J1W7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744341431; c=relaxed/simple;
	bh=3Gw/GQGHVIoCiJC/+TqiG1/GCTD92cTxCZ7LdR13c9c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z1s9GT7Dmqvti5YT3jF0OVgx706HFRxtjFhx5dRgV1/N6T0zav2vi4kLWjCKhMXdw0VJgmhTuKdoxGJQhfwcADgsm0U/GQiLVt25M1L2hYpQk0w0R10kTpu163V1WgB0DgDTwQblizjj+yvoPoAcTB9bQq+nzXdElFJ1hUlwu94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dmo5rb2Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGbfS9030616
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 03:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mboBzHvL8vMUQ8EmJb+LNY
	DAPWvdwe5urX2ZvSDTBmI=; b=dmo5rb2QpGODtRuzATbuJY82hOmaJHZHWtqlRe
	JkeTrk9HsXKcB8M3UHGSsY7cphUrEnjr2KJ95M5oNr5gNmjsZH343PxULDFFas47
	+YlYMTCH4pkqdxhWoiCGMXtberqilSODZ2YPRGmJi0/0gwIwQEEMHjb1E2sxevNg
	97o1iUCuG6z0PxoNkeW3dC+d257HM6ZzpS44FC/bNu3teaCOPkJZl2YPmnizITT2
	K7rrkeIGRYPfu4WJq2EO+fg7KnGid3iJZ0jLfTFuhCoz6r+huhr0znqciD3Wiww4
	cWBXzugEh261d+38g++3puDcp8McsqXIZowe5THaJOPI3VnQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftrsmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 03:17:09 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736c89461d1so2143935b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 20:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744341428; x=1744946228;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mboBzHvL8vMUQ8EmJb+LNYDAPWvdwe5urX2ZvSDTBmI=;
        b=mrF8JEJ9ZG6wuXOdgfQj3cVPCqAXfWmep9B0/7OrOI6uVjDjRmiyOdSFHqY/C7SZSW
         oGHK6ytwqQHv+Kwg55m8EI2OUPukvXd6wAHoQin3d35K4qJ1OtCLf0aiVN5/Y/k24ZSe
         fbhx4b+xQghXfd0MA201mngtGkAckrQ/iLqVRvwxN8OV9YunBKpr+QqhLs9p7yavFSvG
         TNyIhi4+TtmirIryYoFnkB985OOOYRlrrkBE3lchYvLnsMWLF45XUZEskt5J0f6QNzN/
         rR2S83aibNYHlCvLDS3VPAt9jBoTu0/1JDI5SfWBadDXyhHtX0IKJEIZhYsQWHF4A6xl
         4Imw==
X-Forwarded-Encrypted: i=1; AJvYcCVsfYIi2IuStkhAcqbA12As1glK5BuuV5eY8FkGscNvgz0HZRDhYm2oipEfW0HW9WZi8yXo9e5RJ7ryhIgnJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVoJgOgHnz0jyrqCDGDHNTRihCiIPr764IYi6eqD4ao1ujfBB
	ouXrYri4/v28f8IUxslsKGOEw0jvqJIsYqBetLu/55ndWw8YX9xf/nJ5fpi75TtYbbrwihAd+Wm
	fkKZHI3g1XUvcj8WmXAqZIxyPoL8jF+eNgKAHPqLDQ6UuFgmUeubiOlmq3BQDqK4gpk9x1/ZuCQ
	==
X-Gm-Gg: ASbGncuDFhz4AEOg3zOGKgIhFWQoydQ7sdyOQVy6zvf8fJAoNjYRoqK0zHs1jDqJOqB
	U6ub69JyUnPPJMmUtHRGYsX0stIL2vAYA2yxFzwy+5TTswZW+mY6WhWex4Jizx2pTpQI5OjuQd4
	ueTvdz0XfcsclJwboboLNYrFFQnaz+RuK500boE9Zxiw8psugG+s7MmGAK+b/QAgx1Z1BXwPQPN
	5OwhAew/a8bft7Unaax2hD6OgxCXozmDkZvYxvX2Gs4MSFXiDc6Wr5NJExELHhqV8/uJSsjun5c
	FHOMq4TquY2HIhsljaLKnzakyn1MTOtx6lg/9LP5J+/Vb0JEg7mxeIVTZBJyWXwM0+X+4tWLEyk
	z5j372NlgZ1bUxDkDIR2SZEbRmE7BFN7iAd2T
X-Received: by 2002:a05:6a00:1484:b0:731:737c:3224 with SMTP id d2e1a72fcca58-73bd11fa27dmr1522188b3a.10.1744341428063;
        Thu, 10 Apr 2025 20:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv+fKPnPgGK4Y7/uTWH4WTtAT5p4xK2gJKswdv0c71qBJjupR3Qap0nn0HR+oDeB4mvxZpyQ==
X-Received: by 2002:a05:6a00:1484:b0:731:737c:3224 with SMTP id d2e1a72fcca58-73bd11fa27dmr1522158b3a.10.1744341427613;
        Thu, 10 Apr 2025 20:17:07 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230da35sm375964b3a.131.2025.04.10.20.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 20:17:07 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH ath-next v2 0/2] wifi: ath12k: handle scan vdev
 consistently
Date: Fri, 11 Apr 2025 08:46:50 +0530
Message-Id: <20250411-fix_scan_vdev_handling-v2-0-b6740896c144@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKKJ+GcC/3XNwQrCMAwG4FeRnq20XUo3T76HyMjW6Ara6TrLR
 PbuhuHBg7sEfvLny1skGgIlsd+8xUA5pNBHDma7EW2H8UIyeM7CKGMVKCPPYapTi7HOnnLNFX8
 N8SLpbBsCa5oKKsHH94G4ucBHgWMnI02jOPGmC2nsh9fyMRfL/osXa3gupJKOSocOlC/RHvqUd
 o8nXtv+dtvxWOQMv5pb1YC1AhAJWvJW6RVN/2har2qaNeV82QBaryv/R5vn+QMUVkpIaQEAAA=
 =
X-Change-ID: 20250402-fix_scan_vdev_handling-ef5be452b949
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f889b5 cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=HtmLlQNqzqJkp9_W5pEA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: SdtTBimdOn7WBbc2iN4oDPfWMzrhepEG
X-Proofpoint-ORIG-GUID: SdtTBimdOn7WBbc2iN4oDPfWMzrhepEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=837
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110023

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
Changes in v2:
- CCed linux-wireless list as well.
- No other changes.

---
Aditya Kumar Singh (2):
      wifi: ath12k: handle scan link during vdev create
      wifi: ath12k: Use scan link ID 15 for all scan operations

 drivers/net/wireless/ath/ath12k/mac.c | 55 ++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 30 deletions(-)
---
base-commit: 1a7000fb8348e04ab486513d6ebd4b6074a94be2
change-id: 20250402-fix_scan_vdev_handling-ef5be452b949


