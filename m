Return-Path: <linux-wireless+bounces-18429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CEDA277C7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5AB163ACD
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456B621577F;
	Tue,  4 Feb 2025 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q58w1E2d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FE215769
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688722; cv=none; b=uqKaV/mBhFJxTFKr+V9EoZzUErkpvL4mLgMmeHlhvNP4Vcvyz8N3mvpN3Lt1uONeZs4TgOa/PlfJmFpmckOf91TLC2gq8FX235E5g+bme0ui6MlGw6vEX0eqXvcrVAVC4wI6LoA4tdfCAk7f8E2d7Wv7FyVXZUnI9VHTgUvL5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688722; c=relaxed/simple;
	bh=JBOD6fiobxs4q41gPKaifDLaESDFdozFHZlmiIleJsQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KWKVyUJ/VXcBJjdwd7E9lxS50XyTlyXf6h48dsE2cUQtraX8bO8AwK2a+nCPBp7IHpLjDsybjgbY5/VltcEp92EciQCkCRSApTE9n6ZnBqIE6ml2nsPYG7wrUJGXBxAcNE7IqlVml5IJoEz40yMjWM/QrX+GhxXcbF/umDAcONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q58w1E2d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514G1bMa001689
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 17:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BT7DXHGHa0zEjrmQrPCEWv
	JNmClmGtUduvzIInTQO7M=; b=Q58w1E2dpFUbKgrhcah0e2V/ckonktGv/4SdHY
	2eF8YWtf77wFXutIPocpQFyxSFOfkaO8cu88KBMcrNy836aYI4mmyfMbKxK3nLNk
	UkT+Y1+e6+CGprJ89j6qM9Izza1owiq+7HOhPl8DSSKdlhL0zem93vv1Bls7Ukl5
	VXHarVMr8VsTwnWjEyflirOK4Iza5HmPIRbzQhlsLH344FP9UJF0McYbCOQ7Cow/
	YEMHri0CFcMJSxiIKLNFEt2upDaVrUkveo9o1KzoPpsQUqS1jW4LLbcj7En0Imt9
	rt6TB92l89+ePVEwZg00NPNARrxl0IfMd0RNmzHrRX4MpTyg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kffnh8ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 17:05:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso10714582a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 09:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688719; x=1739293519;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BT7DXHGHa0zEjrmQrPCEWvJNmClmGtUduvzIInTQO7M=;
        b=beCijjCK6v/DMbzROPwefM+ubml2E/JXbAL1MRax/Ae4BXIBOwneCAYTyXgYbrfYAJ
         KS/JuMTsirD5xwlvobaQVb8z5P/sc6f4m6qhHkXITQYJpPudL2Nwr5++0OrVWevzlAY2
         rLvq/pLTPsa/n2UGHS6CBnaGNPJm7tbN4Zg3ceK6ZK6RTDDXXJqtqMTcJP8QZjRTEkCi
         Qi3VKcDTpHXSHByFwxkOCqOcVqVffz12cgBG8LLQKMGw0FxadEGnJT0/WxX4EUkjU2D+
         KMyY4vhkhtfL8oKN+rGv9xkxNOvPcspJCt91UJUR+C66qnC12Ubm2QtWIKaEG7c87Ks2
         xr8g==
X-Gm-Message-State: AOJu0Yx7ycfkIyZ2iau3TmgEFuVxGDFaNd+cGMv+AmaGLFNGq7cZ8jy7
	NuYZSPglzPWZQ6Vhi6JbzxrqRUE/IHgxef8ANKbWeGG9Guc4v14qcbdwX/B/+fPWPE84CBPKTVa
	6JYlMZisv9w/BM0qu44bp8dLlvZuMKXn6dIPMomx739sGgZCQZdH1RFtk7WkwwWkIUQ==
X-Gm-Gg: ASbGncuuE3TiJWR7H5FZqjtMJbRb0r1VqWaHlw8+L71Jybxs90CP1shrH4hjNXPJ1pO
	jtufAW2vGaNfgBjXQCfB6kqq5ua69v7eFQiGjNjNBEGi4K5f2BRyJdmQKVFNgba/odoF9stJn4U
	BuBPYom6GH0Aeu8h4Uzy2S043r1Vw0NRc7wIRUcgFsk5EVKUzTVkWKTPRM3OMvE3bMOLHfPnCMz
	ajBz2US/jrJJ/TFK+A3vofn/uGClD4HlSnut/MZTjATuzjWrsIXvVoaF7EhN8/rTqn1vjLL//2t
	9g69UWflaepXDBvM1lYfwcWtxd2ihg6oJVKe99ZW4qrVJ5rofAGWgRvrDd5OxoQ7ii0YChphVSu
	fahPmLKHXKc4YI7fmSF0HgRahvs16/Q==
X-Received: by 2002:a05:6a00:1411:b0:727:3fd5:b530 with SMTP id d2e1a72fcca58-72fd0c60405mr34524834b3a.15.1738688718646;
        Tue, 04 Feb 2025 09:05:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGycQOxaUw26jx2t1l1m1gaa7VJ8kN4iUr7ydQDkLeDLysG/ehAID5o72Qqi2wmqGDsOu70Gg==
X-Received: by 2002:a05:6a00:1411:b0:727:3fd5:b530 with SMTP id d2e1a72fcca58-72fd0c60405mr34524791b3a.15.1738688718037;
        Tue, 04 Feb 2025 09:05:18 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cddbbsm10772788b3a.125.2025.02.04.09.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:05:17 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH v2 0/8] wifi: ath12k: handle change_vif_links() callback
Date: Tue, 04 Feb 2025 22:35:06 +0530
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJIomcC/43OTWrDMBAF4KsEresgjTz+ySr3KMXI41EjGtuNZ
 JuU4LtXdglpocXdCN4gvvduIrB3HMRhdxOeJxdc38UATztBJ9O9cuKamAVISBUomYzd2XVv1fo
 YPzlbWd+31fKZhmuiFSosCQ1lWkTk3bN117Xg+eUre76MsWd4HE8uDL3/WEdMarne+9RW36QSm
 dRlSbVFMKzoGHFyHe2pb5cBEUIJMv0XlOVYNymx0bo89iHsL6M5R6hdtWXqBN/nwaYKUc3rBog
 aRrT8Y94K6juIUkG+CeoI2szKBo21dWb+mJk+VJB6U02jioUE1jYvuMh/Ued5/gQExm0LLgIAA
 A==
X-Change-ID: 20241210-unlink_link_arvif_from_chanctx-315159c5ac63
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 1AJniu_GJ-URSHwYG3lH8V1bDEL-r35x
X-Proofpoint-ORIG-GUID: 1AJniu_GJ-URSHwYG3lH8V1bDEL-r35x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040132

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
Changes in v2:
- No changes in patches 1-5, 7.
- Relocated ath12k_mac_remove_link_interface() as well in patch 6.
- Properly handled peer create and peer delete symmetry in patch 8. This
  unsymmetry was the root cause of the DFS channel bring up as reported
  with v1.
- Link to v1: https://lore.kernel.org/r/20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com

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
 drivers/net/wireless/ath/ath12k/mac.c   | 302 ++++++++++++++++++--------------
 3 files changed, 180 insertions(+), 135 deletions(-)
---
base-commit: 48a62436540224f57013c27519dd2aa3ddd714c9
change-id: 20241210-unlink_link_arvif_from_chanctx-315159c5ac63


