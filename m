Return-Path: <linux-wireless+bounces-18362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77845A26B01
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1503A165EA9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E1515A868;
	Tue,  4 Feb 2025 04:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y8CfpeCH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01A14A095
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 04:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643041; cv=none; b=ABXU35jdwpQ1ljLjqGFw8MbsYLKjWtRtkXV9G90OT5Dn5M3b5A/qVkF1o+DFoGLkTWpvgLFHzbGfNNiIylWH9GD6+3cX47EGZourwdNi4KiH/yqiu4wUTltifDu4reo2VLCCKxd1dRXBXMnWimuNH6khNkZ/M4+ZE6f6xtV/vnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643041; c=relaxed/simple;
	bh=DjulSAYrYJCEjH3DrbfMMDtzoP9JxlAuj8u5u3d8Xr0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qJdXisZWeAndaJrL67rC93Elnl+hAI8HXeEQLsHtfiJ1Ysy4WuQ7SN3UEFFXpVKnGFFaciSbt5aUqeN0YSXX+hcCJQo+3u3KFKt/Y9Q/scOkTO69DWfj/dsTZtKh6RKpjoeT6Sm4tIV4lJoD934+Q2wivP5ChT1vhLts43gouJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y8CfpeCH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQhfT026980
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 04:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CqvkxK+SNLJysbcVSZEZQE
	kaJodv4unEi5m5JjNLSLs=; b=Y8CfpeCHg0JTZWZaVv6jX/y9rbQq05oKNVuWuL
	6YWFB6zoYP1a4jkoyHpYpDgqgV1SAcZAUmL563EYb5E3lhSso7CceZy9ODh/zz51
	VnKZ6srXfHuQtVpI11G93e0Mq28zrhLLzsR83PeSuHIOiwP1jJbNbL+8ciYgiBeX
	e+ZJNbK8dj6ulzXraq8euvDXiBszUVIXxaqGOM/yCl8+7ptqbntf473uXYOeGl9u
	EqmzfA/03anfw00bttA6BDr9buOT9xYGNXEy11jWtIr57M0SdKZHcWDj/F0LLS5+
	MkITmqZ7F8DIcZk3O3jADaa2m1gyWRkBH4i5DaUamIVmlRMg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k4ufrtcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 04:23:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166464e236so166569575ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 20:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738643038; x=1739247838;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqvkxK+SNLJysbcVSZEZQEkaJodv4unEi5m5JjNLSLs=;
        b=fyPJ+YEPOZf0m8K5QKPd+grRyXznH95mStcFYg/dhzpMjc1rhsCbmujpaSjf90F6LY
         +qOdAhqe3yNxe+OK3j347PTRq3RWuSVdD8XsuRAqG9vHxRVgOVvKd3XL+6TlG2Nq7/8c
         TY6n3k/Q6327Wb9WgnvpTST7wSliGJUmVz3EW+qlJvkQkxiBQLjQL/QOKG2oST6VOYoW
         hgDXTBEx89chx9xCYXIX9zWtpACyNZYkx2hkbEq6g8PUMCHeO0Sf1xFUkmRtS/LcF/T/
         klqoWil/LBueyZDVDsHzW1gl+bqKlH+UNv8PlrffAgBv4BqQ8pQPFEE0VLfrvmkgyY48
         2PdQ==
X-Gm-Message-State: AOJu0YzZ0eK5jxBuSViG/EZADQKOjz4TniH8Xkhux4fouDIuoPxvG2kB
	pGObTCt84bw9vLNtPkmIHDQ6FFU9v8dcScNvInlS/iF5+DeSw20WEb6s+LFPnjfmW0qoQXEsCNV
	b77/313pyYosZFIz65b+E2hORH19ryLtlgsmBVNo5nh1lNc7fnJeHRwSf/Jqhr8RG6gJoiTA3qQ
	==
X-Gm-Gg: ASbGncvXHmvbXtkny359XIBPA76MrPzWaq53S9ecOZGf2NGIDcXRHYwhkF7NJeHeScA
	JbYgN/Ss8FCO/pEnyJjw6ibNPIvE7hhuHFF/f3uTYa4k7FDnVRXdOlQdq8GlIzSA+dFS+j0VKrt
	1JpjPWDZ/qtJKiYyQorBsbHcjpcPnEUfVZeiN8ssYgqYGdAbwO8GP+AEk05vbdnNm/SozOy42Fz
	OMH2Uys9vro0DGaqcmCG07oD55YbgzfM2Uble/UvYaNSTcfhV0GcAujl0wq0pZMwrY4dPupO//n
	vYhCmb28becSvmWbKkY32vtFwNJ5F3aWZR3rSwt9AidP48ygw5Rmy3EHcX51veozK1IPLI0v1ij
	bUfeY83sau6nXs2sF5kJ4eyJALBGZWQ==
X-Received: by 2002:a05:6a21:692:b0:1e1:a0b6:9872 with SMTP id adf61e73a8af0-1ed7a4c9997mr38255266637.11.1738643037879;
        Mon, 03 Feb 2025 20:23:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8s6FjVpcitG1aB9paVinc5QFNVofAJU3AhuDdzFoQ/QdzJvX/aEBHqNo07SQpe9ZCeW3Z/w==
X-Received: by 2002:a05:6a21:692:b0:1e1:a0b6:9872 with SMTP id adf61e73a8af0-1ed7a4c9997mr38255240637.11.1738643037526;
        Mon, 03 Feb 2025 20:23:57 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04796e1sm8897144a12.58.2025.02.03.20.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:23:57 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH 0/8] wifi: ath12k: handle change_vif_links() callback
Date: Tue, 04 Feb 2025 09:53:40 +0530
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE2WoWcC/4XO3WrDMAwF4Fcpvl6KLcf56VXfY4zgKPJq1tirn
 YSOknefk1Ey2CA3giPEd/RgkYKlyE6HBws02Wi9S0G8HBhetHunzHYpM+CQCxA8G93Vuo9mHTp
 M1jQm+L5ZjnG4Z1IooWpUGgvJEvIZyNj7WvD69pMD3cbUM2zLi42DD1/rE5NYts8+sdc3iYxnb
 V1jaxRoEnhOOFqHR/Q9W/AJfoOwC0ICy7YDxI6UMvQXlE9QcQHlLigTaArDO6WNaQt99jEeb6O
 +JrDf1HxTgctdNU+qqjiQNGVFVfmPOs/zN2T8OB7gAQAA
X-Change-ID: 20241210-unlink_link_arvif_from_chanctx-315159c5ac63
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: g2DIjEK0pYFo7r7GwoE-kUovgOz8T4mr
X-Proofpoint-ORIG-GUID: g2DIjEK0pYFo7r7GwoE-kUovgOz8T4mr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040032

Currently, links in an interface are allocated during channel assignment
via assign_vif_chanctx(). Conversely, links are deleted during channel
unassignment via unassign_vif_chanctx(). However, deleting links during
channel unassignment does not comply with mac80211 link handling.
Therefore, this process should be managed within change_vif_links().

This series aims to add support to handle links in change_vif_links()
callback.

Patches 1-2 are making debug infra to work without device info.

Patches 3-8 are the ones changing the code to handle as mentioned above.

NOTE:
* A new ath12k-check warning comes which probably needs to be added to
ignore list

drivers/net/wireless/ath/ath12k/debug.c:69: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ... then dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...

This is because, since device info is not known can not use netdev_ or dev_
dbg family. pr_debug() is an option but that will require DYNAMIC_DEBUG
and then ath12k needs to be probed with dyndbg=+p which we don't want in
ath. Hence, only option left is to use printk() directly.

---
Aditya Kumar Singh (8):
      wifi: ath12k: eliminate redundant debug mask check in ath12k_dbg()
      wifi: ath12k: introduce ath12k_generic_dbg()
      wifi: ath12k: remove redundant vif settings during link interface creation
      wifi: ath12k: remove redundant logic for initializing arvif
      wifi: ath12k: use arvif instead of link_conf in ath12k_mac_set_key()
      wifi: ath12k: relocate a few functions in mac.c
      wifi: ath12k: allocate new links in change_vif_links()
      wifi: ath12k: handle link removal in change_vif_links()

 drivers/net/wireless/ath/ath12k/debug.c |   6 +-
 drivers/net/wireless/ath/ath12k/debug.h |   7 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 288 +++++++++++++++++++-------------
 3 files changed, 182 insertions(+), 119 deletions(-)
---
base-commit: 48a62436540224f57013c27519dd2aa3ddd714c9
change-id: 20241210-unlink_link_arvif_from_chanctx-315159c5ac63


