Return-Path: <linux-wireless+bounces-24970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6B4AFD62A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71771C25734
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 18:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F4E21C9E1;
	Tue,  8 Jul 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SSuyCbWH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0914A60D
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998273; cv=none; b=i0iOAtDD267ODA82wkl1E3LLn7tug/2TswQ998b04f2yLb87nK+mcPXLX93L3GNLpEhdIu+lEVkYLuSkBqo7457okoWq81BMGvH/2ug4XdlpfRNmBtuPUzMKx2gWuEqnHxsLFUdTSFYBTjxnKfpA+aPckSIXDW/+xURDwjZMtJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998273; c=relaxed/simple;
	bh=sRnic47gOisiQeYmCGj99DWqqk3FYBDk8heDnOoDly8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s1hMB5kEh9L/ydhgnA/uuoykm+ValAa/66Kc7PzxnQI/k3fVpv2OM6jEiu133Iemsn979ig7FOlPBjPa+26WkXq03G4OEUZN0iWV/Yl6laMw9WUW8GhsZB54BisyR0jANfvd2wX5Hv95+w0JioUZM+fyrbwO0MI7l5WiAeu5pWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SSuyCbWH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAF4r008236
	for <linux-wireless@vger.kernel.org>; Tue, 8 Jul 2025 18:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=4E2HopDvCEYMxYy5QUIC1pqbdnEaZ0r2Pd3
	FywJkK7I=; b=SSuyCbWHXZ4UzoWm27+9MLLt/DUv6Z00J8OqjyzlPPmM2JU8O88
	Hl85yQ5zAwJ99K2D7x30QTEyGbJdDWosC94xwyBvJjd8RR/9cihYFT6H3Cpffgx2
	YI7cvVTFZJ5hADmQzTLwMAcAfy60Yo8kh+D+ABty4yt0VRzVMGB0UrZDeF77Mh0d
	p1DEeg86bjNWCPS113Lw6IEsmSDXH/0B7gG+R4Yp3fV19xg1mOGnsgsmDtZqOFhi
	1Dnapzr/Sxr2fTYFwvZMYEvl+bSCS6PiudbEQjF4ulL4UvgYwy1GAooSxPrvZxyi
	kS03+79m1+0Wd/e8lqKOFCPOr5RSkBdoXLQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn169x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 18:11:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2354ba59eb6so70876245ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 11:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751998270; x=1752603070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4E2HopDvCEYMxYy5QUIC1pqbdnEaZ0r2Pd3FywJkK7I=;
        b=c0/im0IWKcVjJSrlFolg3KC2ZpEIJqWUBdXKp6nSAmf0wNMO/WD1O84gQAvSYsX3d4
         +ecoulWSiZ5G0kZA7yQXz3eMS7NwEhU0EH8RN8qig4/wjwhJy9nFRd+V36Qh0ZI2bdA7
         umiqYeqKs3OZNMx3E27EGalRvI6dNu/0sqUvDS8QT6LXmv38haViqJo010NyOGJzNDGh
         FNbZ4j27kjf/MDpiz3E18xpk8F4D2Bw5H5CXQAs/5Itt5PhpoJzjNkzn0YrTJz1BSduY
         LUd7I7Oy4zto72HqFmqCldJJ9xdzTteJ1ayfG7S8pN9THpH+oN6A5c/U0ZdWzo1kr+B+
         GMMg==
X-Gm-Message-State: AOJu0Yz1qm2FWyF6Ahlc3n4HQxNr0u4KFvJoeDVeTNPiw/M5YbsxJ5PV
	2P74/kwOLQp+uaoRqnftlFOhryk9AbnZ+rrjiXAy1eG/cawa3/h80h6KcvhS79AAgz9CUVqQKBP
	hQ5mNv4idOvi7GvDZfcLxMES8/WvdcSQfa/SOJh01aerqtJ0IQwAGgV7q7JXxLpFhJkhOqlgDCw
	iBAw==
X-Gm-Gg: ASbGnctmeblo3Vx/J67woSUfuvz2HUlodtlIVRCGBz7pIbg7hyB/bMG+p8SkySWXY2P
	DWGFtRoJroKskV2UyE+N5ZMmmAVku2QxvRGOyDA1SxlJMz3mCpOF0tiAa1JkrZO4SShhNWEGL+n
	c8sxNkrxkDP+HKh6kR5uh0p44m6POlA/T9HXQhr34t67yqvGetUOyvcDxDuMm2H6xnPsFrb98E9
	SCOhpSJ+gPkbHWkVyzE8KI9ZbCg5dEK8f6sh7/UWiHzMewe/QnJnYo2314MwX4cveqLAybOfLiH
	brS10pcAFrzUmDimbK0TYSP47BhLpJ1AehYlEqepCEsaBywe+HilEpqadAsXR/OaumfgfoEI1qR
	Iw6MA6nAU3q6K4p4XNdaeJUsLckUrGTrKGT3goxj7R5VAOQ==
X-Received: by 2002:a17:902:bd8c:b0:23d:d9ae:3b56 with SMTP id d9443c01a7336-23dd9ae3e36mr4196635ad.22.1751998269965;
        Tue, 08 Jul 2025 11:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfA8fzKZIxQyfqiIAD77GQgV9UQtugyfL1NTOEmOSJVmtZteuzPXo7mRxPjcsYH+MBmbjx7Q==
X-Received: by 2002:a17:902:bd8c:b0:23d:d9ae:3b56 with SMTP id d9443c01a7336-23dd9ae3e36mr4196225ad.22.1751998269559;
        Tue, 08 Jul 2025 11:11:09 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455d0a9sm115980425ad.95.2025.07.08.11.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:11:09 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 0/4] wifi: ath12k: Add low-memory profile support for QCN9274
Date: Tue,  8 Jul 2025 23:40:58 +0530
Message-Id: <20250708181102.4111054-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686d5f3f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=JZ-guBkKCIPA0SeDaMsA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: SqSorTAsYmRqKdVNVpVDUdq8-uXzxAb7
X-Proofpoint-ORIG-GUID: SqSorTAsYmRqKdVNVpVDUdq8-uXzxAb7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE1MiBTYWx0ZWRfX1+JLuHgvxjqA
 x6Zq9CIwlPxQVht7zULb3oqcFYAPGpar4onw86xOwjfvszjs/nuohxwyU7I8ppTT0slr9O2HgHp
 AAt6a9NCENox1IikWWTRwucAuJdtvKusAdrjd74V0d0Zi4cutIPtNy2jApqy/6IxwzW0mYDcx4x
 OWp0u3zOKjwJ9LXAsxsQfWClHMD80ed1nvomdi75QhPbG6Kzlm3zb/03bwEof3JcLp6bSjmQf/t
 WYIiTtJgUkwjEeVg0YgkSiZJ3aX1lN4S/N++7Xf/ByoUEXZxhla27GCdY0m5+7/viEUC3Wzm22z
 u+U9D0YNUMkD7j1DEY1rsqwJKjtwOxygf6L/om2pO0TaTyj89l1VXZTHCRNWjlSe/IyuUoEUfoM
 VX72NsF2w86bxWl/iODBzd4yVlPkeZjrLu86MXUBPQ/Qoq1UiyQXnghnFsPWAwjfD9tDflHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=776 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080152

The ath12k driver currently assumes availability of ample DDR memory
and configures internal buffers and descriptors accordingly.

Introduce support for a low-memory profile to optimize memory usage in
constrained environments. This mode is useful in scenarios where
memory constraints are a concern.

To add support for low-memory profile make below changes:
- Introduce module load time memory profile selection based on
  meminfo.
- Add logic to configures internal buffers and descriptors according
  to memory profile.

Aaradhana Sahu (4):
  wifi: ath12k: Add a table of parameters entries impacting memory
    consumption
  wifi: ath12k: Remove redundant TID calculation for QCN9274
  wifi: ath12k: Refactor macros to use memory profile-based values
  wifi: ath12k: Enable memory profile selection for QCN9274

 drivers/net/wireless/ath/ath12k/ahb.c   |   1 +
 drivers/net/wireless/ath/ath12k/core.c  |  76 ++++++++++----
 drivers/net/wireless/ath/ath12k/core.h  |  20 +++-
 drivers/net/wireless/ath/ath12k/dp.c    | 129 +++++++++++++++---------
 drivers/net/wireless/ath/ath12k/dp.h    |  37 ++++---
 drivers/net/wireless/ath/ath12k/dp_rx.c |   4 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c |  13 ++-
 drivers/net/wireless/ath/ath12k/hw.h    |  30 ++----
 drivers/net/wireless/ath/ath12k/mac.c   |  11 +-
 drivers/net/wireless/ath/ath12k/pci.c   |   2 +
 drivers/net/wireless/ath/ath12k/qmi.c   |   2 +-
 drivers/net/wireless/ath/ath12k/qmi.h   |   6 +-
 drivers/net/wireless/ath/ath12k/wmi.c   |   3 +-
 13 files changed, 211 insertions(+), 123 deletions(-)


base-commit: 45bbd91fc41b7cb6319e45e6fd732c5c8a0c44e3
-- 
2.34.1


