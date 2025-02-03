Return-Path: <linux-wireless+bounces-18320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 793BEA265F5
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 22:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CDC97A1A30
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BAF20F094;
	Mon,  3 Feb 2025 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qc5fHFvb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97DE20FA9A
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619097; cv=none; b=cmLhRmBzco3jFidS5AHtnOMPkXKxI0o5w4QnZZhZ8tpI6gsu6ztRw5HndSp9gpnynv5C0p0Y/TUr8e0RU28xkrR+TbHJNtD7TpqNvpBk6sMQJON0XkisE89lEikZ87wIkWYSjcGnPi8vpepXCBPL/jGrJANgNBpoe4Eo4eylRf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619097; c=relaxed/simple;
	bh=EjuqOb/9hB4bp/U7/qA25LxXmhs63vZTHQfODXH8Kvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tMnLB4OJfJUbOMSMQN3dq4qL0Bp47z6IT7864vDsfJNPVnhGbaSCkPJ8RkTkNmfweUCLZC3lkNBbk8IaK1q8x1UJEO+cDr28NvcruM1HjS3IPzNAZIoMadSMwBGzCdPLcwSRUrc6r2mV4bVFl7tsaQ815ly6ThmrslzdvKriKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qc5fHFvb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JlUOs028499
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 21:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LDahZQj7Tg4
	JSWeS/TSyZQmgNDpEbC9fI2EuhqXABCs=; b=Qc5fHFvbD4IzSjCyHMpT4Zb2KrY
	S/XjFG+R1ZbZXZWY/AKK/eKlOE+zurBGMKBoZcqumlFB4rKv/nrUCBkEXVOJCTwu
	D8zSXffjCPBQxbQjE50cbNUIh+1WbtD7ORiAM1b62GvyQGwNqFVif8JmdhxXDnrP
	KX/IdSWstsxqnmPigFLmSSM3L9+pTTJtuCkWe2S3/LlbAatTKWjTbUb7U9yqPPil
	LraUnDl7BYa0LMGazOeoOdta9plGRhgyoDNZWcRbhsXNxo8B8xFhI7/RqX4qwh/i
	yxrj4+BiKyAs9wdQ9zoUa6bR/HM0a3+8OYQC9EhWh0AUSyAjWEYru9h817w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k492g741-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 21:44:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2167141e00eso115746555ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 13:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738619094; x=1739223894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDahZQj7Tg4JSWeS/TSyZQmgNDpEbC9fI2EuhqXABCs=;
        b=K3gA5bYqKdTXnPgzo1yl71JlqWKo7zMMmRFvy5KY6feeNoPatB8usUldVp+VsMyzKd
         J4V3Qt0WoLdZxznrPPUDQ8humB3hTf9RDVVdBUDW2gMXocYDSZn70Os+dgwxiGptJgP1
         B3XEILQi2k7KpoXFaUwD1TGKlCfx+IUN7/c1kGRz7xDraZf53X0BeuagYG2vTmxW3m8j
         ihIzC7tvxGkXLLpzNokQMRu+gGtzCLykVyJ4DzB8E2BWZs2WPbwXP2l09RJGDTZbKQHi
         7AFQ8ZmJrfVhZcaYwFPJ9i9mNvbJSd9meJsSN1Kd/1Jw6dNQHU62+ffFIEo/M8Kj7JcP
         aBOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhzYHrhjsSp350VXIYq2ExMty5PC/t5GNnUJ4bA7VL29cc93DYBcRy2jLyWyXflN133Lhmyr6GVowOFi8HfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrquR9lv58S7pXC4y4jjkbrd5ISAVWF9qFY4ZaH3viufQ59z+c
	uIc0MuWmQz+BOslcqUv1aXKCqYqH6/MzhwhA5LQoLxoeZHaew2jou2O/N6ZPc5r5GKVCQE25QA5
	234SEatOnnQVxlJi1bJHOauErN0o37gnZWJEdRMwHQaCnat3kKXNzN+g832yTjfB0eg==
X-Gm-Gg: ASbGncvT3BTX+uczyK2ujoGOYT3+XsPMuVQXvo5kpmwRiaxDt5gMJcylwJKJxiSibHm
	sPdcvninax2aR/AFkFie7GsicWJoU5MHbCdhbavfV8gHWTK1aTxIXGKQU9hNbAbyOLDGhjRf1lQ
	AjLnybQMEWPxZGdQrBDReGNkhFbC9OrMoIhjjvyR88i/zb10RrPMGWH7dlrJoiPmdPxIIYjHruA
	C5SKa25ytAK9UMqRuIgeKBUPCWhTzSST2OGS3mrEbBfDGqMOoZpAmq8VkDdWLZe6X4U19zZgODQ
	HNJPXqKSyKGsJaOM05QxS8vKzdeoBQqa6zUvITPr668JGIR0Bwv4/8ZIe+ug
X-Received: by 2002:a17:903:247:b0:216:3dc5:1240 with SMTP id d9443c01a7336-21dd7dd5339mr372681395ad.45.1738619094105;
        Mon, 03 Feb 2025 13:44:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGigjZfzxDKHl/nhSzaApNAcEsschatItTybiToZ1tQxWCU7pGocBtA+MUgi/U6h/Pr0vkLbQ==
X-Received: by 2002:a17:903:247:b0:216:3dc5:1240 with SMTP id d9443c01a7336-21dd7dd5339mr372681155ad.45.1738619093749;
        Mon, 03 Feb 2025 13:44:53 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331ce6asm82357895ad.209.2025.02.03.13.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 13:44:53 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v3 4/5] wifi: ath12k: pass tx arvif for MBSSID and EMA beacon generation
Date: Mon,  3 Feb 2025 13:44:47 -0800
Message-Id: <20250203214448.1978156-5-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
References: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Tb4WNBwpI_4Ww9rI6m1csd-1KsSHjhb1
X-Proofpoint-ORIG-GUID: Tb4WNBwpI_4Ww9rI6m1csd-1KsSHjhb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030157

Add new input parameter to ath12k_mac_setup_bcn_tmpl_ema() for
'tx_arvif' as the caller ath12k_mac_setup_bcn_tmpl() already
stores it locally. Avoid duplicate retrieval.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index efd155031feb..90823b85b714 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1642,13 +1642,13 @@ static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif, struct sk_bu
 	}
 }
 
-static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif)
+static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif,
+					 struct ath12k_link_vif *tx_arvif)
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_bss_conf *bss_conf;
 	struct ath12k_wmi_bcn_tmpl_ema_arg ema_args;
 	struct ieee80211_ema_beacons *beacons;
-	struct ath12k_link_vif *tx_arvif;
 	bool nontx_profile_found = false;
 	int ret = 0;
 	u8 i;
@@ -1661,7 +1661,6 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif)
 		return -ENOLINK;
 	}
 
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
 	beacons = ieee80211_beacon_get_template_ema_list(ath12k_ar_to_hw(tx_arvif->ar),
 							 tx_arvif->ahvif->vif,
 							 tx_arvif->link_id);
@@ -1731,7 +1730,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 			return 0;
 
 		if (link_conf->ema_ap)
-			return ath12k_mac_setup_bcn_tmpl_ema(arvif);
+			return ath12k_mac_setup_bcn_tmpl_ema(arvif, tx_arvif);
 	} else {
 		tx_arvif = arvif;
 	}
-- 
2.34.1


