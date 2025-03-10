Return-Path: <linux-wireless+bounces-20116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A7EA5A451
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 21:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39D57A2DCA
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 20:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FF11C5D40;
	Mon, 10 Mar 2025 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSENz7Un"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123B15B971
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636965; cv=none; b=k6VYu+8vBA9OVBkax1K7OJRcoZJkuc5HgiVIO2AjA+zy1ya7IMfmwCJyJFcqAOy5ZFhf81rVJg3Ox5ZhRq3xGNNHMsyjiUfZODfUcv1TTHhrSTnl8c41Oe4uriWYgQ/mcfm9qdrHBwBojdH2lvBYJXtlC1caoV9DoBTwsgLCMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636965; c=relaxed/simple;
	bh=lC8dy0n4da/v+Rg0aDe1N7NVZK+CduQEXy3bSoDvp54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hSnMvx7uTE2nOyFyW5UDOOCa3Fm6nuhBy4bB7fteChM5hFdp57EONhLWinbhKzFRoiFCtNyp3BiQXIqvfn3DYjv9ukx7cyK61oKBMc8yRgC0urtNVSkNg9iwXhUXhKpuYg2Et0tgXiTc9qnn92eLodMOM8LmObxPXiiNorJZ0jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSENz7Un; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJPWxK015477
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5oUX7Uf0XBJGHkWsmznzvbRQqVZNW6xVAGM
	ulJmOaps=; b=dSENz7Un/Ph8cWTiN7COayg0Yxh8eVcWO7uAB7S613LDemZeyS2
	KsQdniwJ3bnBRPC4naTmtxv/0o7lP3BhelWYo27HSbAZGcnnP7+5Werr0OPBxrGm
	hHaQPbFPJb/VniJ8j0IswNZ6o6doOfP2uPMYVN231ZkVsWeB5YJL58GzgrdsFbo6
	OCclPTP9GiU/H0/Inn/3s+OlailqkOH2ziESGvN9Ht/OAmSNV4DrfwA3vuKgG5R+
	NWVOb/Ty/P4x0eKJI+YDxb9D+E8Irj/lFTldBGNH+JxPLsinNGgWdVwv4v+gOy1V
	xakt9pUGLfhh69LLE3mq1phEZlXQX+6wblw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ex0x2kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 20:02:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2242a6d5775so40304565ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 13:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636961; x=1742241761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oUX7Uf0XBJGHkWsmznzvbRQqVZNW6xVAGMulJmOaps=;
        b=uHAc9RqH4Hc1k8puRHI68tCXsv9n2BjYUmf/zdL3cWfMWzQFIof8x8Fk2/8fxWJl8Z
         vmldBVn7c/aNJO+96hsBhQUX/970gX2JQR2gOFtEmAzoYftD5G2dxImZgFun6nMTWA2b
         gwilEPdnn2cQNmhCwELwcOsljUIpOXt/YyZdgE12QYPLcS4Bb8ZZ/e/rcgq1b4XhZoVR
         xIv3MHGDGsgweADS34ZJa01BI+LANrncHVGl3okWy3syZGpX0I9W1VU3jyDEv20VWhaH
         Jj1UcRHcMvvUrp5sGdBXYQl+7Co2B/FSzO4LxSL62aPZ+BGDhLkL09hmwnQEd3IooYMf
         lpJg==
X-Gm-Message-State: AOJu0YxEv/2fT1fOh6l1VPDN5CtbvsILvwDxeeKuSAL2HeS000x7nKv7
	xfCtodl/IV89XWZDRM2WRNSu+lmTntV4+x+0wolxt7MXlRR/8VswPrrSlHPTLMX88+tjCSMQjbQ
	0+p2PqyXvuJCvVphT9i9nkxsRG1Bk8Wh3RuA7aJFVUPt0Gp/ApRVZkSmXnxLLKRE6LDHKsn75aA
	==
X-Gm-Gg: ASbGncsjsu/i0RERJPD3LIilqfsfng3Q4FyBCwDP3qTbZX8nWpZKlx+EDdWZqWXvmtC
	HKYX6dFGv/B4EQPwDwFV4mumwPnV4bEYKtzX9MEod425lT6pjYLuVE4fP4+V3MpoubJeW4PMhT6
	ylsalbHzEZADmVMMeQSQZwnlgJO/i9FhCRpTjGrCdugUFwLhr+mk1Rf2UwdtpM5aLMlU9udPoVY
	zVelrOvHlB9my+6n2H6uE5PdvlS23boEkNapEbqPU/ZH3XUeiDCC7Jtf5klXGy6iEV+zyKZgu7b
	z2PSClkvlxXUI97C6BlNXFo06msOu0gDteMyGVX1XznlJNqF2IX53QR3Y+WI9hBSSYCx6Q4=
X-Received: by 2002:aa7:830c:0:b0:736:5486:781d with SMTP id d2e1a72fcca58-736eb87c1f4mr1113765b3a.19.1741636960909;
        Mon, 10 Mar 2025 13:02:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHccAPmFHmrmLUpz0x0Yfyl2POultnDTom8ngSQxyThbFZtUXEn6Y2yz7Q9egfA1gSiBqweeA==
X-Received: by 2002:aa7:830c:0:b0:736:5486:781d with SMTP id d2e1a72fcca58-736eb87c1f4mr1113742b3a.19.1741636960491;
        Mon, 10 Mar 2025 13:02:40 -0700 (PDT)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cbe3fb3fsm3730419b3a.83.2025.03.10.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:02:40 -0700 (PDT)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v4 0/3] wifi: MBSSID support in MLO
Date: Mon, 10 Mar 2025 13:02:34 -0700
Message-Id: <20250310200237.652950-1-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rwTMwQ7I4EdEYNNA0rIWdyIYzTigV_rD
X-Authority-Analysis: v=2.4 cv=f/qyBPyM c=1 sm=1 tr=0 ts=67cf4562 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=AlxVFHAfxkVxK-neCP4A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: rwTMwQ7I4EdEYNNA0rIWdyIYzTigV_rD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=319 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100154

During non-transmitted (nontx) profile configuration, interface
index of the transmitted (tx) profile is used to retrieve the
wireless device (wdev) associated with it. With MLO, this 'wdev'
may be part of an MLD with more than one link, hence only
interface index is not sufficient anymore to retrieve the correct
tx profile. Add a new attribute to configure link id of tx profile.

Similarly, storing 'vif' of tx profile inside 'vif' for nontx
profiles is not sufficient for MLO, instead store tx link data
inside each nontx link data structure.

v4:
(1) Pre-requisite driver patches are merged in wireless-next
    hence this series should apply cleanly now.
(2) Refactored possible driver changes into a separate patch.
(3) Found a change missed in HWSIM causing compilation errors,
    replaced mbssid_tx_bss by tx_bss_conf and confirmed
    successful compilation.
(4) Replaced vif->bss_conf->ema_ap by link_conf->ema_ap.

Aloka Dixit (1):
  wifi: ath12k: pass link_conf for tx_arvif retrieval

Rameshkumar Sundaram (2):
  wifi: nl80211: add link id of transmitted profile for MLO MBSSID
  wifi: mac80211: restructure tx profile retrieval for MLO MBSSID

 drivers/net/wireless/ath/ath11k/mac.c         | 10 ++-
 drivers/net/wireless/ath/ath12k/mac.c         | 35 ++++++---
 drivers/net/wireless/virtual/mac80211_hwsim.c |  7 +-
 include/net/cfg80211.h                        |  2 +
 include/net/mac80211.h                        |  7 +-
 include/uapi/linux/nl80211.h                  |  6 ++
 net/mac80211/cfg.c                            | 64 ++++++++++------
 net/mac80211/ieee80211_i.h                    |  2 +
 net/mac80211/iface.c                          | 73 +++++++++++++------
 net/wireless/nl80211.c                        | 14 ++++
 10 files changed, 158 insertions(+), 62 deletions(-)


base-commit: fc56639937ce95a73c9876e39f8d18d1a8dd6a95
-- 
2.34.1


