Return-Path: <linux-wireless+bounces-28394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A7C1E597
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 05:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADCA3A4836
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 04:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A82218AA0;
	Thu, 30 Oct 2025 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kA3DCIDW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CZQLIBKp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2ECC2E0
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798715; cv=none; b=jcSLKqZV3BKmU6mVry56nhX/LTrmkPEK8Iaw5hB1YeRlruQUhdCGjhKH6/I1IsFbBPzoJEE6GH+DDOq7DoRTYFgUSd2K1H1Fcia5dD99cJoxZPIm5QvNoz+W4RsdxAkJPkobU4HnA8RPRnOzz4P2eHO6CR3dPP8pKYnAoh8GjJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798715; c=relaxed/simple;
	bh=UbxjGdGEtdW8RHOFPHVSxxs4guSmOVOe+uip3NFDHgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DxK2PET2j0ZUw4YtPV6KmSamlF1q+6dJIQFFWXduUalJq1iHSoxhXcDOjpYX4mWdkejwXNVlyforQ4GFdndk4yLnEnGbq9gD/5uwqYJxPr8206XPo7witlhW9zr8oUIbll8bHZboW5SbOABGErFJre2i8j+huq0MaaHSfW4+Ug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kA3DCIDW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CZQLIBKp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TKVLxV1501797
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 04:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aQEVU9tFm0FPokWAUJAaSI
	HV7/W0k+JNBaohFu7PGSQ=; b=kA3DCIDWn/FTqPumzpfbVV7oYTcdTJC7noZJeg
	rc8zr4Q9ZojbpX/3lrVbO61DmALh1o5fnimaZin7R12/UWaCm2dOON/QAap1IxQ3
	b3h2UqkDBZcxMJNVtbyGm20eZDU/y/uNwQh/MKDkPQm+3n/YmqnZBGau9O88kCoE
	8jYW18xz+l9I/oXe5EOEdDRvcYZuADOUZWLRfcxAbiPRRfoaDxuWa1Gq4dZX/U4d
	EgoDz/HCXlcLfkITi4RvnUV/t65hpc5iUlxA7QRpTU1xUAzqlm9ZitnQqcm+wkCx
	LNDL3ecMknngU9l5Nuv8UJJKYj5HJrU+gEtpN2yd07M0PJkQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3t1js5q4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 04:31:53 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78108268ea3so1517171b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 21:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761798712; x=1762403512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQEVU9tFm0FPokWAUJAaSIHV7/W0k+JNBaohFu7PGSQ=;
        b=CZQLIBKpnO5Q+NRqyfBsmWDsYagUM5OzCrqQxjjkcsJO4xRDzhdcrrSJFa6KscjZIx
         VamtJyarrlHvSzAaPs0eYXlTrfvmNy213kUJDXxliK8SSwWjI8KmtY5gXSR0qqvnZ0+H
         F8DUGLuL1MuuALqHDxlfgK7oAOSd6JE5F937wVHbnEuC11MJVKyb37yGw/qIgy6YqZV7
         FRb6FWNIXkbqsl+l4MLwCZw4JapOJKo0my99uhEEAWsEnTJIKQa9vVQlPfdZc+lDpfxf
         u6G59J7xSST0d6LarVyDuIqtjD0EvF/ETm3BxI3+sZCzLsePs8vjBgkamJqXhf5VEQy0
         tIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761798712; x=1762403512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQEVU9tFm0FPokWAUJAaSIHV7/W0k+JNBaohFu7PGSQ=;
        b=qut2tjcMKIJYRb+FSSZaOf6IjX37OLV/DYcHdiCuRF+Sb3KD3XpfrXu6N98qXOqmqB
         9s4cXNa5w4KCNlzRdj/Ybxt4Flohdk0y0XiI45xLJWAEUibYFXxJmTTwvN7OjbOiBto3
         HfoFckma1O/48SlGKfjwzvVPZGVEijXP4NNgcN2fw50T75jf4vhxLUG5fRC5DPlTleKP
         ILkIcG/8tER66DbuFGSqjanhKKwNV9bI7twA4gs65mr+OrTX2lhaYseBA/XN/PO4SjM6
         CtKbILgip6wVTzIu4slgbG+YluTDTbhmmdzw83MI4HtHPcbMdQYCpEWHOsWftz2CeSMQ
         fkKw==
X-Forwarded-Encrypted: i=1; AJvYcCXgU1WtZgDLB8ABDO6rXn469V/ku0iuXWBwkM/djPOkFxJvmYH5mRTPeQCm0h1aURcFoAZ5XZqc3He12qe81A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9m5fw3x1svsK5A3nvRaVKjB/Weoo+rq2xECgP9Mp9gevJzFOt
	is/cZxORy+u/JU1zd0DsJyZfhLRgTwhFcASwvKWJXdTJxvA3mTOEBNDFWFUOMBDi4qf+CDL2dIw
	fQW1YzUpEZdpTQXFQlTH5i/xg/nIIDJSB14vAdcVst07dWgQpHFitH/X5CUcVQkS+c3eayA==
X-Gm-Gg: ASbGncu/pVHr2L1/FqF8o0DqE+ryqF0G/RWy0c94qThPcdICsQ26bMgSPMtFxeiWlmP
	EjR3oKy73/ryxAqpgvSftkXB5RxR+3CRkbecxiyPJ5yqfreCrfcOhi9+u0BlBeQt6nllJJY7ozo
	qQ6kHai6yCV4qggU4UVeG9v7zOB6OgvTyb8DTofYYg25qLmn02a+HcWlLZjkORE581XhNoNTNTk
	tvxSpFn8RzDyrEs1S6J1kaukpId9d94IScyq4V8cGffuV0TdGYM+srxsZeaRUnGxEGdq4CoO64T
	SV39TZeyPWkQHUvXmAfKhmSRBNQidnF1QDy+bzX7W329XIY/vH+iZQSkwXbjGhqhBxJReNBq7xQ
	S+OysFIWmV+lASv0vQVtGMfLGA/s4LuEH3Kz4lqSwBZ8C
X-Received: by 2002:a05:6300:218c:b0:343:6c90:77aa with SMTP id adf61e73a8af0-3477c7dd7b8mr2428210637.29.1761798712208;
        Wed, 29 Oct 2025 21:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/z0VMIG9gpH8UZ6mNe5oR0sq4MImn1G2S9B/5BXOJDH9d1T5SvxKgUK7xufP2oppRGcUuQw==
X-Received: by 2002:a05:6300:218c:b0:343:6c90:77aa with SMTP id adf61e73a8af0-3477c7dd7b8mr2428185637.29.1761798711740;
        Wed, 29 Oct 2025 21:31:51 -0700 (PDT)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409e456sm16912161b3a.71.2025.10.29.21.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 21:31:51 -0700 (PDT)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: [PATCH ath-next 0/6] wifi: ath11k: Add single shot/periodic CFR capture support
Date: Wed, 29 Oct 2025 21:31:44 -0700
Message-Id: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hWcpXuhF9ok2S55FIi9DEHMMLL0Gc1nB
X-Proofpoint-ORIG-GUID: hWcpXuhF9ok2S55FIi9DEHMMLL0Gc1nB
X-Authority-Analysis: v=2.4 cv=M/lA6iws c=1 sm=1 tr=0 ts=6902ea39 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=AmXMZ5F67BFPE-8RLEAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAzNCBTYWx0ZWRfX4K+Vf1TZOC2i
 +B+wHAqfEoQ4W3Dy/8wpAteW6I6+vntXnMdYHc44KqQvcqqod9GfKKkqKf/RN+owZsfVRcxwP1G
 iLXmlfDHn1tYH2XfalX4bCJuTnkmQoTG48JWbiTPx/C0LhNXeTjtbh70r6W4QlfROgCETFfhcRx
 pmQW+bEE94A7qCKL6EztcvmCOdYAx0r9fkboz1qemvs3loUEkkdSL8C6WlSSeXMxfScCHRD/UGH
 kCHs9HVmnbZ0dG8+/4nsJ5k80SDXCPKn8AExMo3erKv3Wh0416cQehxSGlbxgJiQT/aWB2PXYb0
 dNMjlDwayBlCLKw5HJg3oreliUq/Uf7ULlX9wxXYjgNqvBgkd8hExRabvMdugmzWDCXxCGga/RR
 apru8YkchSzMg9J0axIjNZOajzO56g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300034

To enable/disable cfr feature use command,

echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr

where, val: 0 to disable CFR and 1 to enable CFR.

To enable CFR capture for associated peers,

echo "<val> <bw> <periodicity> <method>"
 >
/sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_capture

val: 0 - stop CFR capture
     1 - start CFR capture
bw: CFR capture bandwidth
     0 - 20MHZ
     1 - 40MHZ
     2 - 80MHZ
Periodicity: Periodicity at which hardware is expceted to collect CFR
dump.
     0 - single shot capture.
     non zero - for Periodic captures (value should be multiple of 10
ms)
method: Method used by hardware to collect the CFR dump.
     0 - from the ACKs of QOS NULL packets.

To enable CFR capture for unassociated clients,

echo “<mac address> <val> <periodicity>”
 > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc

Mac address: mac address of the client.
Val: 0 - start CFR capture
     1 – stop CFR capture
Periodicity: Periodicity at which hardware is expceted to collect CFR
dump.
     0 - single shot capture.
     non zero - for Periodic captures (value should be multiple of 10
ms)

To collect the cfr dump,
cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin

Previous link:
https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com/

Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
---
Venkateswara Naralasetty (6):
  wifi: ath11k: Add initialization and deinitialization sequence for CFR
    module
  wifi: ath11k: Register debugfs for CFR configuration
  wifi: ath11k: Add support unassociated client CFR
  wifi: ath11k: Register relayfs entries for CFR dump
  wifi: ath11k: Register DBR event handler for CFR data
  wifi: ath11k: Register handler for CFR capture event

 drivers/net/wireless/ath/ath11k/Kconfig       |  11 +
 drivers/net/wireless/ath/ath11k/Makefile      |   1 +
 drivers/net/wireless/ath/ath11k/cfr.c         | 991 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h         | 301 ++++++
 drivers/net/wireless/ath/ath11k/core.c        |  41 +-
 drivers/net/wireless/ath/ath11k/core.h        |  19 +-
 drivers/net/wireless/ath/ath11k/dbring.c      |  50 +-
 drivers/net/wireless/ath/ath11k/dbring.h      |   8 +-
 drivers/net/wireless/ath/ath11k/debug.h       |   8 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 143 ++-
 drivers/net/wireless/ath/ath11k/hal.c         |   3 +-
 drivers/net/wireless/ath/ath11k/hw.h          |   5 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  17 +-
 drivers/net/wireless/ath/ath11k/wmi.c         | 147 ++-
 drivers/net/wireless/ath/ath11k/wmi.h         |  97 +-
 15 files changed, 1816 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h


base-commit: 197498315de711140bcc4722fdeb7c1761777100
-- 
2.34.1


