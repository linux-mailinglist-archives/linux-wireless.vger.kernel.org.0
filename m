Return-Path: <linux-wireless+bounces-17685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF58A16053
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 06:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F527A3070
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 05:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F018C928;
	Sun, 19 Jan 2025 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EI6FwcuI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B816BB5B
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737264183; cv=none; b=NL6JvhmpI0Lt8aOiXUe9ZYkIYGPYlsoSdxaC5BfHCyF6NPLAv9xGZQy/I7DKFMT564UgQbK5xQlbRVryfAp/Cn7IxmC1jJUo+Ipwu3Q6MpNkaPcBnSDiMp0nnKnGUkWVNZg8EV9k4w9XvtWCoBRu6GbgHh5vOLbudbCEta08pWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737264183; c=relaxed/simple;
	bh=O3tnDvlY3NiiItXFBAMbsFNx69UGr7VCwswyYBS8InU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpoDGud8NQ2aKvH/NpCbIpvvX1C4aThIH39u/YyGdWcauEx2kfzn69WlTnVc/PugUiD40jpbJnNNav64yLvURrXwRs3JhI4HP84hUb13HQCvwy4hruS9Zt2hxy9mnbhkRMUtXwrrn1VCu0luMUTVTGi/GBQyPw106FqDgzptb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EI6FwcuI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50J5Cj35015894
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8C0b7AYRgqc
	Y96BugJgxG5W46OpAEDFb3MbuCSajnwM=; b=EI6FwcuIjMhG8eWZ+ALgxOOKK0I
	tdSpDWmnVGhIxFm18D5sAZY5qYa0JgIPSXuauYlfrIuCVbUZJlw2n7vfNg+sEFSV
	+ncKcEWKD9brIkhJhUblSxWbSve27TFRVezU4egAUmY6kplkmSWfPPikB8/a6uKO
	olcslWz+glHsgvi5xVPGd6cx55oZP0QaVgS23kHpXIkoF/uMSFaWSr7v/0uaZqwx
	lu0gVyXCXbAmZ++0e2hcy9mj6GhM2dB9K+y51ilSNEacAC9MU47fI3KWINFKJsbH
	Z5GoQoMqw9KcgSx0oKLEYKhiuqdKwv4T8DmFKKh1MFv7U/QEA2HD+fLqYFA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4484h19juy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 05:23:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef9e4c5343so9592800a91.0
        for <linux-wireless@vger.kernel.org>; Sat, 18 Jan 2025 21:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737264180; x=1737868980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C0b7AYRgqcY96BugJgxG5W46OpAEDFb3MbuCSajnwM=;
        b=Hr98wgmgA0e6szz1nP5OdfP6UFA8cT8rQlEKkYeridJBAu8GxYwVJZ1PpFSeftR4BR
         RPnoa/0dP43tnxFxNqPROyD7VVWu57ibK3e/hFY/A+z0ZqtKkMnVOLOkf9Sd7kfCq4S5
         WLN5AsSrhZXUgACBWIO1jPqqaQsaJlYO7q/GNBrGzApJeFEToIAHoBt9v2yOVp1LhN0s
         e2sV1LxPKbhXelj5J4Wwi+tSvruTCo9txUyWMixOxLukV015PZwTZj0yXoCa0KSX2Q1i
         Tifpgcb1RRUdPir4IQifGgdKiJXyOpWZXrmMz2+MxyNqRz5LIPyWCQs2f3qy/7KbXDDK
         q57w==
X-Forwarded-Encrypted: i=1; AJvYcCVa9bLqotsanfM0QI4h5NPMhP4hOGC+NL+BWpgSQG71bileZ4IMqVmIPVCh6kxEig7vLa6Fxz2B3oDXY5t22g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIy3qDmBU7UlzZWpcB+mkODVuf/bSgWftI0Xp7ERfF4zhW5L7d
	iHt5fdOaDtAZS37DB6OyB1glHmgLTbMKTmRRaDaXb0uoHT/lT7T88tw/zD/1zypu/k1wUb82Q6b
	+5zbBk5KRyM2XoyUvRYIi422jbQSxbYp3ElSLgoX+9A6ElwwclpGNNwKVlp3ey0UPxA==
X-Gm-Gg: ASbGncuuPpSUtprVxyHH0gF0kRla5hBhXawDW9fzhy7X1hoeyAQh4rruNtZ17rzXqcE
	FOj0pK0eiVy8kzgHduvB97eCLKoDtEBCgiMgCwvadtV305+utcu+JrCpVAbNnOYWzAw7C44/uBe
	cCWk94DziJPUohJFdP7fa1LqCAmhHEv7er75lK0VEiA/4+e195++VQ6s4JOW/QKriYC4MCEmkvU
	NrObx07MBPzuWefyGJXKJE1ngNgRYfwrrApXuDYo5xyOocEHEgC7BBqKFPeqfofdpkDBuZ59P8O
	vb03I4YhbwwXwXYLudoZ02BegDPrOJozIMaaKvIxBB9fFPlDgA==
X-Received: by 2002:a17:90b:4c06:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-2f782d4ed29mr11908733a91.27.1737264179968;
        Sat, 18 Jan 2025 21:22:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENc7B+HoPGEEKk4Pd69z1iWgwP551nWnln3SXSfO2+MqehG3HMf2oVBJ1VJ8o/QYexWRI+pA==
X-Received: by 2002:a17:90b:4c06:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-2f782d4ed29mr11908713a91.27.1737264179645;
        Sat, 18 Jan 2025 21:22:59 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77611a295sm5062553a91.7.2025.01.18.21.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 21:22:58 -0800 (PST)
From: aloka.dixit@oss.qualcomm.com
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v2 4/5] wifi: ath12k: pass tx arvif for MBSSID and EMA beacon generation
Date: Sat, 18 Jan 2025 21:22:49 -0800
Message-Id: <20250119052250.3488343-5-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250119052250.3488343-1-aloka.dixit@oss.qualcomm.com>
References: <20250119052250.3488343-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xUAopQGM3bH_1FrUabciJtv5KYRweets
X-Proofpoint-GUID: xUAopQGM3bH_1FrUabciJtv5KYRweets
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501190042

From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>

Add new input parameter to ath12k_mac_setup_bcn_tmpl_ema() for
'tx_arvif' as the caller ath12k_mac_setup_bcn_tmpl() already
stores it locally. Avoid duplicate retrieval.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f189ee008226..8a856cc1d801 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1562,13 +1562,13 @@ static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif, struct sk_bu
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
@@ -1581,7 +1581,6 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_link_vif *arvif)
 		return -ENOLINK;
 	}
 
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif);
 	beacons = ieee80211_beacon_get_template_ema_list(ath12k_ar_to_hw(tx_arvif->ar),
 							 tx_arvif->ahvif->vif,
 							 tx_arvif->link_id);
@@ -1651,7 +1650,7 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_link_vif *arvif)
 			return 0;
 
 		if (link_conf->ema_ap)
-			return ath12k_mac_setup_bcn_tmpl_ema(arvif);
+			return ath12k_mac_setup_bcn_tmpl_ema(arvif, tx_arvif);
 	} else {
 		tx_arvif = arvif;
 	}
-- 
2.34.1


