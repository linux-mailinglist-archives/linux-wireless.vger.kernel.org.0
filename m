Return-Path: <linux-wireless+bounces-21031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD60A78194
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 19:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893D77A3AF6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 17:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05871C6FE8;
	Tue,  1 Apr 2025 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lW6ylEhh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223719461
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743529092; cv=none; b=FfSfnFGHTv94uNBgXVCW1tUNhoEBZDHKPIXJ7H9VY1+QuFWZVVsAmH66K4lYoLwxlm7riJuRbG/GfdQ6gMRrIujqbrOuVTxLuA90Mbu/fzi1GOGPxelMRa8OUDF25GXZUFb73myADmnvqDGFI5zxqnURtMUA/03Fw0SETz6ZnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743529092; c=relaxed/simple;
	bh=F03PNzsaHnMgnRm7bXOed3Pnp5tUeiN1o0IearLkbKQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XoMF5ke2509VsdqKWcj74kKUpcQT9/qLRPRxOj+aK3fWSjM07ZxAT19a0FGwUyL7BA4AkEjz0YYowDPsMKlwFbQKv8dvEDxu+POAR5fjzdxiKDSOiRb2SKTut0Hj1urc2GRiF4XZPc8lkRP1qfsQ8XUGVhld3QNYrljGW+IQNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lW6ylEhh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531BQdXs002553
	for <linux-wireless@vger.kernel.org>; Tue, 1 Apr 2025 17:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=42USD6xLBFhY
	YaeFkXybXR4DDGWjXP3SE1bsfsaPzF0=; b=lW6ylEhhevBUV+ni6kNijbDGvNF/
	U3Exd5D9VomGzqbq3xsnoD+iHDkXtEJIV9/Oi3DvaqiLyXJWk3yQjAqcw5nMqyBy
	mbZNvLKb2CKQCrx0a9WTa6yPvkPCaaDOGsIPdU/KTE9Puc+nOSXruHLlzLAv3N5y
	8i9xS6537MbHLOExTwYa/PpTe2IFC+zN9A7n0OTEVAAkDOpYgxWos5f2cmlflDfE
	FuP8s4DQfeTe2G64ZRbigO4HHS8zRMxgXuYNJ1Wo2jtk3SB92tUol+Wv+vyErNjz
	oj7QsFvt7aqhkEKxbY/sl7lYj98ijVAFpsEDCU97yPDVpxBU3kVfwr5Gnw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45pa5brrhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 17:38:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22650077995so160653595ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 10:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743529089; x=1744133889;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42USD6xLBFhYYaeFkXybXR4DDGWjXP3SE1bsfsaPzF0=;
        b=i2ruHplRH+Mp/I/BiS3ZNXrVWgj0mgeHQwH/qGKRqw+wZPD4561D6xiwhAzccWQPDN
         FiyoCC84G66Xj3oa5otfLnpjkX88EScvNxwAOzdkIOy2vGUZISCC8iZ6SZPJKl/rpKE5
         DHWmxFZ+uwQXWeGjvtiigqACaX3MS7nFK1s/PeeKXz1+TWJG4WC3+Sb5RuRzMmkV3FBp
         tyCqARC2ptzukvq84x7Wgu5LuW0z2pIt3WPi7QeCOWmVtUwH+uj0qiEmjOBgr/6O0dCh
         CgAdmxnuZo45QigpNpqj2maCcWEYtJ87fu3hgqoIFKcDsgsSbEZ+qadvIdVyMGFcSPzS
         tc6w==
X-Gm-Message-State: AOJu0YzUd/vG6qW2WeGlRaD9tkmdknaAmVaSTLiC60qgLB2eM2j9G2fo
	hYe01Q+giStZaonVmPM3EbcVCycvrM4Xh6Ljql3ZRRmRCP3HKEjwMjS30rWWz5cHwFHSKcok7om
	htReMkuexg0j6InIC7uc3drgFaUf/cpotysRAF5ZTwICBP+JjfbymkwUJz4ZG0/1u9A==
X-Gm-Gg: ASbGncuQL6BmzZKU0xMMEMc3gHbJfendDoz26SlkkarAxdM2UJjk3DQmeU7ag9HTP3t
	n/Q5gxJLF48+vX7i3ysBLWl2QvAid6tIMDuGVD5Ai2UCEvKquLztN4IQhA/uMzpOFG4onMq0fZU
	F/qp5gLa0p2TUXQQE3LU+9Iu1N1DedDa3CB1R5E/k3zLE25ETw/qLfvMCMDWsyml1Bv1No9AtVC
	U8Qthz4q+foquAnYHJvgCQOLFds90eRcXqC5g3FE3R5HwCLGe54WbEPmvcBPfPLQ7wE2gGLBen8
	30OTksu5F+QAw9ZIN+I2jZrL3iYzCQjcjq2R/jxomLNv236aIUF9nd1Y4GuTCOs55cXFYSuCEhj
	oruVneFvKXlTLvH/wJKHhKRmSeprQxGVRCh7aGpaU15XgX+fiaA==
X-Received: by 2002:a17:902:d487:b0:223:fd7f:2752 with SMTP id d9443c01a7336-2292f9747fbmr248468245ad.29.1743529089229;
        Tue, 01 Apr 2025 10:38:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq+vypP+NaSsVeb6Jphfm9hixv9zWPpkB+7GSItWhCFf3xx62asR82rkaiYyFZtR29kSFx6Q==
X-Received: by 2002:a17:902:d487:b0:223:fd7f:2752 with SMTP id d9443c01a7336-2292f9747fbmr248467955ad.29.1743529088795;
        Tue, 01 Apr 2025 10:38:08 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d3e125sm9597434a91.5.2025.04.01.10.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 10:38:08 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Fix spelling errors in mac.c file
Date: Tue,  1 Apr 2025 23:07:55 +0530
Message-Id: <20250401173755.1982382-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: DzmU7PDxRKFeUjwPHIikUsBknMm1QwJq
X-Authority-Analysis: v=2.4 cv=YqcPR5YX c=1 sm=1 tr=0 ts=67ec2482 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=jOCyixPqWrj1a_6UGRIA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: DzmU7PDxRKFeUjwPHIikUsBknMm1QwJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_07,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010108
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Fix spelling error correpsondig -> corresponding in
the comments within the file mac.c

Compile tested only.

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f2fddf213afb..98bda931724c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4462,7 +4462,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		return -EINVAL;
 
 	/* check if any of the links of ML VIF is already started on
-	 * radio(ar) correpsondig to given scan frequency and use it,
+	 * radio(ar) corresponding to given scan frequency and use it,
 	 * if not use scan link (link 15) for scan purpose.
 	 */
 	link_id = ath12k_mac_find_link_id_by_ar(ahvif, ar);
@@ -10438,7 +10438,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		return -EINVAL;
 
 	/* check if any of the links of ML VIF is already started on
-	 * radio(ar) correpsondig to given scan frequency and use it,
+	 * radio(ar) corresponding to given scan frequency and use it,
 	 * if not use deflink(link 0) for scan purpose.
 	 */
 

base-commit: ba613742db305037ca2193b2b552b769c4f2a5f7
-- 
2.17.1


