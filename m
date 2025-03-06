Return-Path: <linux-wireless+bounces-19861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7540EA5479A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC51171703
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C16F1F63E1;
	Thu,  6 Mar 2025 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JgoCirfN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD917B50B
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256553; cv=none; b=Ii6NJO4HPCCqI9EiHcOPfH73v4NhUV3WzKCqS1uoVDy6gO7+v6hPw2me0BSCzzTuS5+n5fFT3wLGUPxjekIw40tr4RcA65J6vs34uijjo75BXKUO4LDHsgkS9z9We6hoFNE7XZ2NcThFGAlQkJLPeCrhrpFkR3xHeGsaHed6Ufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256553; c=relaxed/simple;
	bh=X00IzEQ28QslI46KOYgLneN7bZprjgsDm5tTP3XlBVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oC4rKhew3GCUmlrgKcEKDtkD5zvXdZT2qcIXhO29K0hs4YtqtSKvoC4TFmwZfPuvTElFrEMq4WzJP5Wf3egODJ3OdNMHYzCkpS5nq7UonikNwEdeurClICEODcrvLc4i5fTvGoREYTqldiPrQsP/XoPW5pVtPxH+DIObMh/C2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JgoCirfN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5268stWe027093
	for <linux-wireless@vger.kernel.org>; Thu, 6 Mar 2025 10:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mjXUleZqTEfN/C/LZajGZsmaBHaz6JmQbcU
	3tNgRJJA=; b=JgoCirfNa3uM0clILZaZI1sU6yr8pf0wqVIC6+qZcm3uxd/LD40
	T82JWT8DWaAjtbB4re2fWoq4iLtyxjmmlickcOjw3SbW7C1NV+MMLlyEM+9WPXfZ
	Nz6M9ntUSXoNx6RxqgKjPE0ETxlxKerMYPArtnltElfaIXqrGNvqXCTj3x5WN1e3
	+et6d4vPfjTwmc0vL/U21dX7nYSTJtDf8VVzMW6CDU4AyBaKtnhGVllfM5jJoUw2
	nsiMuYhzmW+NtyOOSVBaaHo18TmlAAvSKL1FkbX0csQPEG/FabX8gTY0xtJaHOAX
	iChRaTvmf+mLGiZejN/LEVNXoCsPXMVaylA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6trm07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 10:22:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22379c2e96aso17043575ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 02:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256548; x=1741861348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjXUleZqTEfN/C/LZajGZsmaBHaz6JmQbcU3tNgRJJA=;
        b=DPF3O8edfTx46KJF10oztwiIAQwXmVhbDnRaViZ0zSnWJ9nzqiLH/5PzYZZCgbamMl
         haDcCAfHOZ9xG9D02UzRCWietZdV01ki85CYOWYw/X+ciVf7Pxuql07C1viFqt/z7lgs
         6E8qCpx+PgxyOOwbBttEbh9/0chNJF9swHwsunPEDDnSuJOk5jWfAx7TX+5KlEuKzplt
         Ww+5uovd46aFc5xw3nUJmJG4ISYlt8pX6e7EFo77Af0A5sSks9V6+fc5C19vr3fdAgYW
         3quhA5lJW9E8EDSWR1M7R7jpBsw1vGBR75SRRNKNECnA6D5qdD4mCDkwONtfQ17jhUUp
         i7yA==
X-Gm-Message-State: AOJu0Yx3P1Y/bzv4jWG2LjoXdsIEdWy89YnabIcsEBPRMU2+ahbiVv98
	ZAvZv8Syu6t/oOv9slClYxAIttv6fsmPfKQvtsIHFJraLJWO0xwPYluPr7GiDclyqxaMvIg4ewB
	1opQFwB3jpZX8UZN9Fc72s5lgqzc0Ym3RW0qWOhdUJWBzF1ZezFCZQe4DAKEU0OcwSQ==
X-Gm-Gg: ASbGncsLShQw3HNPmUFncZMABwRUo0mcVIiJMLePCwnTxcF3pvkPmu4lJnPzNpw9TKa
	LKlOcjK98vTIIeiS+ZN3gmc1AnpY7NUD7KZvBJp7SF9FP2UcYRCv6qw+qqltLRHihL5iPPqzEJd
	+EIYO8eaBuPArN1FpU7DO9Dzm5kC8+A+3IwLoor6hCVqLQgTr8CrWGUBZu7PggKf265eTw8jEpw
	Se9b4o+L5IMf3Vp+JgQtJvRTtKX+jnggiY/HFBA7CKjcqWUPU8rTi8fndWEUumWf8SAYdgTCvhf
	Q6NHVK5huvjp5/0695MiEZ+eFtS3ySJeMeIIjY04+PbzUNJDrSAbIBKEfJqymqr8gh8XVAAfPmi
	qIIs7i/8wAXWZ/02NGfwBARiGaxlt1uRUIGzN1dJFRdGP
X-Received: by 2002:a17:902:d511:b0:223:fd7f:2752 with SMTP id d9443c01a7336-223fd7f2b74mr77536135ad.29.1741256548688;
        Thu, 06 Mar 2025 02:22:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4kzypG6Kp3TpQntY2VNnfIigwepdapNs5G/uuxifg0RFmeMQa9GArBvqIenvxk+GgKCmouw==
X-Received: by 2002:a17:902:d511:b0:223:fd7f:2752 with SMTP id d9443c01a7336-223fd7f2b74mr77535655ad.29.1741256548261;
        Thu, 06 Mar 2025 02:22:28 -0800 (PST)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddfa6sm8814785ad.33.2025.03.06.02.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:22:27 -0800 (PST)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next v3 0/2] wifi: ath12k: add support for get_txpower mac ops
Date: Thu,  6 Mar 2025 15:52:13 +0530
Message-Id: <20250306102215.1300522-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HZbuTjE8 c=1 sm=1 tr=0 ts=67c97766 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=Vs1iUdzkB0EA:10 a=PGcRVBYcp0WH4tafFE8A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: GZhR3x90w7mUykAJjb7KlZifW_lrQ-is
X-Proofpoint-ORIG-GUID: GZhR3x90w7mUykAJjb7KlZifW_lrQ-is
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060077

Currently, driver does not support get_txpower mac ops because of which
cfg80211 returns vif->bss_conf.txpower to user space. bss_conf.txpower
gets its value from ieee80211_channel->max_reg_power. However, the final
txpower is dependent on few other parameters apart from max regulatory
supported power. It is the firmware which knows about all these parameters
and considers the minimum for each packet transmission.

Firmware reports the final TX power in firmware pdev stats which falls
under fw_stats. But currently, fw_stats is under debugfs.

Add support for get_txpower mac ops to get the TX power from firmware
leveraging fw_stats and return it accordingly.

Also, move fw_stats out of debugfs so that get_txpower mac ops can
function properly even when debugfs is disabled.

v3:
 - Rebased on ToT, added tree tag
v2:
 - In PACTH 1/2
   * added sanity check for stats pointer in
   ath12k_wmi_tlv_fw_stats_data_parse()
   * Moved ath12k_debugfs_fw_stats_reset to core.c
   * Removed ath12k_debugfs_fw_stats_request() and reused
     ath12k_mac_get_fw_stats() of mac.h as both are serving
     same purpose
 - In PATCH 2/2
   * Modified ATH12K_PDEV_TX_POWER_INVALID to hold u32 max
   * Saved power in dbm units in ar->chan_tx_pwr

Aditya Kumar Singh (2):
  wifi: ath12k: move firmware stats out of debugfs
  wifi: ath12k: add get_txpower mac ops

 drivers/net/wireless/ath/ath12k/core.c    |  53 ++++++
 drivers/net/wireless/ath/ath12k/core.h    |   5 +
 drivers/net/wireless/ath/ath12k/debugfs.c | 112 +------------
 drivers/net/wireless/ath/ath12k/debugfs.h |   5 -
 drivers/net/wireless/ath/ath12k/mac.c     | 188 +++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h     |   4 +
 drivers/net/wireless/ath/ath12k/wmi.c     |  99 +++++++++---
 7 files changed, 294 insertions(+), 172 deletions(-)


base-commit: 3148fc3cf193dbbd2e14eee59468a510a38bf604
-- 
2.34.1


