Return-Path: <linux-wireless+bounces-27999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33EDBE60EB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 03:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9149148184E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 01:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152551553AA;
	Fri, 17 Oct 2025 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lZSIMxXe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0911758B
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760665760; cv=none; b=HkGczpJ5coDD43INOuebjMh3L6r7HPyPmceqZkPYiJ9ddsZ+qaqqcOahgWNIlsbqr65JqMycbTdaTRvO92UbzavPB0SbOIVFnqrsuiwL1IGzKwbPs79cjDe7ivSsvD+eO99OADaw1BxIn/4Ab0rg3FFiyMlb19Qi0hcv0X2VtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760665760; c=relaxed/simple;
	bh=pPK7XPvzkCq8kzcdw7w5pToMvEKQmXVplDYWRjUdHko=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VPtI7uhXMZuI+TGVc8CnCXKe7s5Taz30ihRtSaJ1HpIasImUrwC+xuh4v0+d+65RmmM6J1+dQzkv1Ja0B+f1IctlhaEG94NIC0jvLwQ1tU0o5XhjdVxolAUutY2ZoC5DzMqAAuVsd/1A1BNFQkseLygpn/TcCwVmPHRvMtnDMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lZSIMxXe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLYh6002626
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 01:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bIVbDWRzimFDTaTG3mzRaw
	ATBmOXe/h2r+nkD+RHIxU=; b=lZSIMxXeOyWRv3OCn4K+W3Y8kB/usQn9EIXawV
	X3BW6bxVcnBa3xt94eJW4Y80Fj3vNZ+L4ka8/uULC/g2TwUbC3AlFw0GAsW/eeDT
	gt3YGlodtCWWcnb+gyMFzhMx/uwwqFlSTgfqTumJzwFxHE+5nIBiW64E2UAlL8r/
	5n71m12survih/Vk3zTWHm0fhIBHcZBydmaUifpL8H/zmVzfmFxclij+fsLY3WzF
	gGeJ98Fb+aeOMwDN5LXn8MkhGnLvMRQv75cb8G1HcFsQXuSk2W/eVitHyf3ygpA9
	UQPqeGL3oR8r7vUNWFzrPmH8atAbmUNXgP47Yj9qf3okWajQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd9ah8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 01:49:17 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b67e14415dfso1177549a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 18:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760665756; x=1761270556;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIVbDWRzimFDTaTG3mzRawATBmOXe/h2r+nkD+RHIxU=;
        b=eL37gBI6hbGCkuG26MFZvVmlxBTMs3a0jkmev5IzEN0K2hm+pNm/ZSmrDEj2tW3EVh
         8G7kpSQj0LShgrwTqZAA5JXsF6b0+633OM4wvNdU6VyCgHTJ5yof8rFu2TBWqQpVFtot
         VMEH5KB1Q1bAkFdobI3J6LZglqqGe4lgXYePcUZXnxrco+uNiESavYMbWYB0pM9pq4x4
         lSVApvy4OLQ5M5e25GBMNwgagdhWSScUCMn5/Dfg0zJAxNUjJc6W17dMcum3Q+1KwwMB
         /0BHCmGfQR96uHgCwS4ixBf/BqH9o57RHbgdaEnv3EA7SDzHiQZixg3bykoabthTX4az
         i45Q==
X-Gm-Message-State: AOJu0YygZs17XBb+j/vXkFJ2HLogT/CxQCE2WVpIeqdSPhEwbrMTSGHm
	6gbWgIuJUwaTe8YkgzZyQGsiHw9jjVhjn7gQJk4aNFsUT5/yn7f2DG4XafzALeQZotn/cUJ4kEq
	0kEQS/CqLDDSRcdBTZANU1K/9LdTHSid541CpfeQPxFyth1rH3JcgzkoraP97LNrdKWP1R4eSaG
	G/KS3N
X-Gm-Gg: ASbGncuLLTRnaNQvPte8YcZPddMTsWPNssYeJ8VDhrxrkjBjLE+8n7+yLkOl+Q3L/mO
	xMNEQJgjZeW/T9eLl8b6MVfa6iWMmew5P2iSz1gIpPAmRXckekMa5ephRPL0Z+sbJYdQBliFL3P
	vTcD3W38xfa5ehMWfaNzykLLXgRAqKqeS7X+NetZf68ZuFLI9ghmRb6qaXaudrk51XVbqbtQeC7
	lzBOelVW/2SfBAFdTofD6vYYwDV1VkYUIoQxaXioRWiwl2j+VwPWdvjXPUUHvTu18qFHaAr/Hwi
	DguXxUL0Ek5/tP8MobFzspnUyP4+gu52PFE+gTj4DZiNcv7x6JEoGAGAd9UPsEzmVyQETB2HcmH
	S2e9LkK5VKEQf4OTge4PJaChdHyFJhcGrFVt9uwrgg0mVMxqjh0p2
X-Received: by 2002:a05:6a20:1585:b0:2fb:2e04:eeae with SMTP id adf61e73a8af0-334a854783emr2583384637.21.1760665756498;
        Thu, 16 Oct 2025 18:49:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4jRKRiQwDwGDChCQIJLJWOE5GV/XGwfAcol1Y8/0ZMz4s+xYCuZUXNHu7YLqoR6coYgSYyQ==
X-Received: by 2002:a05:6a20:1585:b0:2fb:2e04:eeae with SMTP id adf61e73a8af0-334a854783emr2583353637.21.1760665756006;
        Thu, 16 Oct 2025 18:49:16 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22bbe7a0sm4181475a12.38.2025.10.16.18.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 18:49:15 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath11k: fix MCS assignment
Date: Fri, 17 Oct 2025 09:48:58 +0800
Message-Id: <20251017-ath11k-mcs-assignment-v1-0-da40825c1783@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIqg8WgC/43OwW6DMAwG4Fepcm4q20kg2WnvMe0QQijRStgwQ
 50q3n0Zh56K1oulX9b/2TfBcUqRxcvhJqa4JE5jLgGPBxF6n89RprZkQUAGHJL0c4/4IYfA0jO
 ncx5inqVtHOm6cmixE6X7OcUuXTf3TZSKzPE6i/ey6RPP4/SzHVxw2/9jLyhBovdgXGNqBPM6M
 p++vv0ljMNwKmODF3oKo4I5Q9q2USlFe5h6ClN/GHWhBdKtdbSD6TuGAG4P0wWrgyXwVYUNPvp
 sXddfOv2gb7IBAAA=
X-Change-ID: 20250912-ath11k-mcs-assignment-8b924769181f
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: exAgBcKeoR8vjS8DsCOABLWg2g9V-6h4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXzg/ZgnYF6ebb
 Ou5amZoPIjrQoIYq9TIqhbURcmPXi9aHteILacQ25p4ey0MrO7MKROrBLEEjQJ5gFzRxSttt5/a
 bok0kfPAHVdGSeimx8P4ei4OV/+twnTF89CouoOA47C3EmBEpe0+ebl2SgyckabknAoksqEn5Kr
 HGujc2wm3uNqE2N6V42IN1j/sLzgUmLOLNWTI3VbMj/A5Gcr0m4IdrpfZzh35i5NPu1PLXCQe/K
 BG9OX5hHVI3A+orzsuQn2ZPpkj/nMRVQ0gDUVc8/ux/Gdh/TGG/YVbG3B/dShFgJaAn92M9hggQ
 r+XW2RV5j+WsSqiZLsrmcoXDpwBIA1hGfd/cxkNfdewmItH36t0IlBE11uLDdtllvdi5f4+HwsX
 xKhLiXlnDd00LgYO1g3RPOANVlozwA==
X-Proofpoint-GUID: exAgBcKeoR8vjS8DsCOABLWg2g9V-6h4
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f1a09d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=9Y66H1pTm1UaMIwK48kA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

VHT and HE MCS handling are wrong, fix them.

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Baochen Qiang (2):
      wifi: ath11k: fix VHT MCS assignment
      wifi: ath11k: fix peer HE MCS assignment

 drivers/net/wireless/ath/ath11k/mac.c |  8 ++++----
 drivers/net/wireless/ath/ath11k/wmi.c | 20 +++++++++++++-------
 drivers/net/wireless/ath/ath11k/wmi.h |  2 ++
 3 files changed, 19 insertions(+), 11 deletions(-)
---
base-commit: d5ce93f136fbee2b7afbe221f34ca881036f8de3
change-id: 20250912-ath11k-mcs-assignment-8b924769181f

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


