Return-Path: <linux-wireless+bounces-18252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B385A2436C
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 20:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E385164529
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11561F0E49;
	Fri, 31 Jan 2025 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LViBRENS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C492154C0F
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352259; cv=none; b=q1ONwUoav9S8z2Zs5JNPFTWyYJYbqmjKBqiuux4hIhU6QmfL59Ry4A1Ek45Zh1cB/D0IoRu+GALgzynHyjq8sQIhHQ9E0dC3pVRXW90uWzMCrNr2LWFvy+IyTgJEOfdjJCcMng1TLHVOUi0Gvzw6F2CDFvSDJydLcf6Im1hMY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352259; c=relaxed/simple;
	bh=+05//GkIOaU4SO9A7I6dH6d6bjLF8+8KZTQOsafkWX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TdGXtvPozcu3EXzXa241cSYEmAEiZ+vnn81UVxcgEaAe0IzDWk7NrvVkC8S3R06KjjzZ2yYU1HjH0bqNVpXbooS7s7xZgw9AHcoYAkjphXDt96tZGzeBkcW0b6Wa8NnXlXGofhJKWrW+G+XUOKHl7j4pNoPKFrB+6TOUbxkBwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LViBRENS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VEWpep023220
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=rWPq2Jy5dpq1rPEuULWQ5kKIrsTzJW/zkhi
	KWPv7fzM=; b=LViBRENSzlfqIeGneT4cQxFPBK0gZDwDSCU5EgYFdH1jHeErTxD
	nCl+UjAjpXacXxhEP5f47hK6o6tO9L9vGJsnwhPMV/KKssHCIJLtJs4jv+V4OAUj
	h55Dqugphl4/D3avONScHvwwXSBx+olQ7dKfS0+FybUKrp757yz29yXK4ryzataT
	O9mMKrtMyZ6nSNz5pMKwrwfb3pVuqeE4Fhp6c2ArlW1dBPoWgxP+KZu8jQgQ4eZ0
	M+/yW4h/lpgzG2J6cX2hlw1rKJ3gD+wgmFCCIOYU4tom4vSQMtH06F7b2KstC0cw
	2M9wozfZ/rimZ/mHNrkHMtfpSXq74xdEcAg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44h0cgrqbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 19:37:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef9e38b0cfso4548468a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 11:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738352255; x=1738957055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWPq2Jy5dpq1rPEuULWQ5kKIrsTzJW/zkhiKWPv7fzM=;
        b=pedGjS4I+61NofkQSP6iztnCN0ATHlTK1YlNnWCzg/Oc3FqsznUIEmsB36Er20u0XW
         GbNEWWQAbXLW5/5zkvCOyVdteGJQxUXi9a8fikJqsKRulKXc5a97/k9wXbjUhTZxzelW
         APrzxfgpiEEhD61mwrzcw0J/T9F5ktBLtGRpgIbOcoiJ5robPAA5GZYfehdngIEMi/Oh
         U8BBWNSBxHHYRMxKV1dznHm0w2lHvBeHpVXbY8RW8JKgbEn7c10xCi0eaGgRTrk71Sno
         ecR9vZcrdYhGtTq5sc+RUhUVBgH8jZK9pbmOyhnRG1lWIWRCplluEh3xyyQy5Ch9QbC8
         KGsQ==
X-Gm-Message-State: AOJu0YxoUWDMHopn435MyjhfzMdU/H9NTv2k/7NejYMYxV+YyyZiTmIX
	ADMbSvxxtgmHCewtJQiKVx6F5yJ1CIPFOyD5yn/f5WLCrGIWl0wWbTD+lhfK6bKhjC5M6Fh2gvP
	8yjUrKtILWyRlxNzhH5hdofqxUsWqyzhTipUVfFZX34CWCXyMufRGSIQefcmSa4ar6S+F+Kvkkw
	==
X-Gm-Gg: ASbGnctdvb9LTGQETPdCMych694VA/JLt3AMJdF9Ho5AaMwkaa60mVoIlC09UHRmDE+
	6bKrUHv3nlNbmBCNL+gREdkMhL/6bf+KDLeGOVZWeyP0n8hCafT4vBf58Fnas9ibjRrfQVaxKt4
	q6U8g7x3pW106WX3pm+U+Sux8b7LQivnvVuOehxjJ3WEud4FuHYswNyYcLefEqvKAdZ4jsc0rop
	fCivrn0SWtnj46pXw53A9CY+zMNxHhWZtNZQRValWuvMoVWphU8qCi2KKHd6ec76+zGmQOK61jr
	aw4q8pQkJm6qwB7i2ThYJ+0z9gYzqH9YyqDqqNOvEJXL3LgEroBPj21LSB6z69RcP8RziiVtCD9
	SzCitZjZAIFNoODOnTGGXvxfyKTJARJDDsA==
X-Received: by 2002:a17:90a:dfc5:b0:2ee:9d65:65a7 with SMTP id 98e67ed59e1d1-2f83ac86a84mr18019418a91.29.1738352255571;
        Fri, 31 Jan 2025 11:37:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmPr6BfdjnFSbOf+DrFBr5qlvQ41u8Gh9NUr3+eZhVMFlHNR+G1jN8bwYsF6UhTEBs/k42cg==
X-Received: by 2002:a17:90a:dfc5:b0:2ee:9d65:65a7 with SMTP id 98e67ed59e1d1-2f83ac86a84mr18019395a91.29.1738352255184;
        Fri, 31 Jan 2025 11:37:35 -0800 (PST)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848acac43sm4019271a91.40.2025.01.31.11.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:37:34 -0800 (PST)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH v2 0/2] wifi: ath12k: add support for get_txpower mac ops
Date: Sat,  1 Feb 2025 01:07:24 +0530
Message-Id: <20250131193726.3568086-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8MDk1IND_EBXNWI11-MpC1ILKolqsrUM
X-Proofpoint-ORIG-GUID: 8MDk1IND_EBXNWI11-MpC1ILKolqsrUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2501310149

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


base-commit: a10b8b584b8bcb7559f068ce247fc27d0c4850ca
-- 
2.34.1


