Return-Path: <linux-wireless+bounces-20863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A8CA720DB
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 22:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F933BB274
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24341F460E;
	Wed, 26 Mar 2025 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lkNrU57q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FDB17A2E6
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024947; cv=none; b=On7ztyCk3H8FlYx7oRVomvce+A/PWNxPYhvGYZlUjpbP+Mc3UlKnSWFxQWMNWDnQfGFgT+jYGzmO2V3lYc7QxOd13757GwjpUbVSfye2C/nOzPpOZ6yx6agUD08pkdWSoVR9+gjt8fqb+HOmGaC/QrAdwnVAXN/tJdNJjy9fKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024947; c=relaxed/simple;
	bh=6yZGiKh611Tn9L/ya6nVYcQl1znz7UyHIbsuCha6bJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qYoaQg1Iz1F8Q/kmQPAW+1RB7Vy++EOklyQIQ7Ckb55zi6P+VSRyY2QvbNsdA795+fXN84K2xSshTWIIlGFANB63JvAzBsovotPA9OqVI6Y5tE1l9G7TsQ2e9j2ELXb/PdLkMIXEhd6SGJsrUP1jyO8k378/v35SM48E4WWMIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lkNrU57q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QEnqTo004071
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 21:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wTpmiNrvScDshMA2Xa6+2A5oFuulYighfjG
	SBQgXOLY=; b=lkNrU57qivuAar3a/GMXvckn21JGPhxtPgx3j66yn8eLlDqoBE/
	Gt7eRC9+hVJ9LbG8AgCzAlYf31SKWb3zqVmBTrPXNAJlyeLsrlXmsL+iTK+fp15I
	ArdWOUKUq1LFvdWxEVLgZB7PGG+wMRtI78ciiHIPvlZ3sD7XmxGesqYFEdBiGhEN
	hrhutgL37rSLIxURi93Shd/X9/jOYwB83QKrO+22eBUmcM6yk4Y9AiOTrNPvfTcf
	pddPa9wmf6KJHAxvwn6j8W9gNHHYjgg417/d2hEsfYK07vh4bQZfbkqM9tl92UbN
	eMc2/epZVr507PzmAyLea5I6NnFJZt3DuIg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmcyefxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 21:35:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so566585a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 14:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743024943; x=1743629743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTpmiNrvScDshMA2Xa6+2A5oFuulYighfjGSBQgXOLY=;
        b=Beh8xcoCvsGq/dR0F3XVeWBw94s9+ZzvfsHuZA82KJBNzDrfBiaWWQyqvdtjfa4PyC
         abdAVh6FPUQ+yTd7zcPsktA/ljrgvqz8ACtR0BtowHa3+brPVRbOJuh5vhyDEF1jRBwv
         yGCt1sV2eifvMU7YWY5hT2TH9Akl9SxreeGWknNFE9MAcWp47v2mt74UjS0jPiXeYWf+
         Ikh5ujC4as8eh+Z7So33lf3DPPG6uFKnIUBhmd+sFLqPAJvZbTkA8huHilSjZob58MVB
         q/+vZcqM1+CgUIfCrLrfzNDRDi9Rty6YLD4pMLCQ1oEJw4nX5LKAxrWr5OcKObCE5jTs
         +Kyg==
X-Gm-Message-State: AOJu0Yw2i46mlROjrai1Q4fLw8Tb0Hmk0+pHx6fkkgs23btxwucW6JrI
	HqCBAMmYhDbc/eXGxFxHnDcmJygXYUroFgDwsbWlFHUNLXvjSISpTqNc+OS+TWK2oJchDl6cHyz
	SAj408FYh3peD8qXYbknkUIdLnQ9IrRWgfPz4Vk9mkg3YIbjwZaYkZGewD1LWH+BgPUOPujAykQ
	==
X-Gm-Gg: ASbGncvQ8bbIb8y7KECPr1rt5TLohv7ogAPJJvDiEdYd1zvOcWxOGxx9j9xoZ4+OmlR
	kz+xC82V2leh9m9S7HCeZ5MrgyrcdqLA/PNtQ0GN99RTUM75sJs2OREj9Vpq9PbgvaRLQ/JFHKf
	YCuvfh/xMs8hJkSoYp/H1Z04R3xDZp/S0zjkHysX30ljazuD9L3Ul1CoiDX5WlxUZVblwLZ7Hx9
	RKDNy+oI2PM3wdY1Qr+F1rT/kGCzFfJtKP1ZfTJ346uy6ZdBl/PVtoDOrZ4sALxoz7DRhsKND/I
	lZBnuqJ/Hk3a98G2uVwV6wkFUdHZm5qTAl6QNpXLGcTRaK8S0D4o8dZ9Zw62eeCsa5IYfLye
X-Received: by 2002:a17:90b:39cc:b0:2f1:2fa5:1924 with SMTP id 98e67ed59e1d1-303a85c19dcmr1426657a91.26.1743024942664;
        Wed, 26 Mar 2025 14:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3PTRmySKpMHkK8ePn89GyLRspSje27x86TVoVISqp3TJAN1rvFxOOocWxhn/FGmNWbuHlhg==
X-Received: by 2002:a17:90b:39cc:b0:2f1:2fa5:1924 with SMTP id 98e67ed59e1d1-303a85c19dcmr1426629a91.26.1743024942067;
        Wed, 26 Mar 2025 14:35:42 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3037c8de90csm1099902a91.0.2025.03.26.14.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 14:35:41 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Fix memory leak due to multiple rx_stats allocation
Date: Wed, 26 Mar 2025 14:35:38 -0700
Message-Id: <20250326213538.2214194-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EZ3IQOmC c=1 sm=1 tr=0 ts=67e4732f cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=R-JEC9_UMzOm0rXJ7CcA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: oGbuauCDDeRDHPTDAcbbu9bNcb8aIoDR
X-Proofpoint-GUID: oGbuauCDDeRDHPTDAcbbu9bNcb8aIoDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260133

From: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>

rx_stats for each arsta is allocated when adding a station.
arsta->rx_stats will be freed when a station is removed.

Redundant allocations are occurring when the same station is added
multiple times. This causes ath12k_mac_station_add() to be called
multiple times, and rx_stats is allocated each time. As a result there
is memory leaks.

Prevent multiple allocations of rx_stats when ath12k_mac_station_add()
is called repeatedly by checking if rx_stats is already allocated
before allocating again. Allocate arsta->rx_stats if arsta->rx_stats
is NULL respectively.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 842eda56c8b1..f157a85111d9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5663,10 +5663,13 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 			    ar->max_num_stations);
 		goto exit;
 	}
-	arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
+
 	if (!arsta->rx_stats) {
-		ret = -ENOMEM;
-		goto dec_num_station;
+		arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
+		if (!arsta->rx_stats) {
+			ret = -ENOMEM;
+			goto dec_num_station;
+		}
 	}
 
 	peer_param.vdev_id = arvif->vdev_id;

base-commit: c0dd3f4f70918cbcdd8da611811036a91b7dce33
-- 
2.34.1


