Return-Path: <linux-wireless+bounces-23551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D2FACC470
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 12:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3493A422D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF88C221D94;
	Tue,  3 Jun 2025 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ix/UjVx5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931E53365
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946958; cv=none; b=Pu1AQFkmve2Sh0A+/pLRKLkn7q5lT5uo03ZKbBFU6+WtkSns4rk8UWDzHtuE34sSkAwmXpsHPZ/L66hLGVNMH1txWDdsNLKxbietHa9CjkTK2MoXLFO3ZK/1J1aA6heLA+XmTXIPqmOpk2fCCEpfwYqcd9lmExnOR/WawwNSo1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946958; c=relaxed/simple;
	bh=NyHww299N0/hONh8xEXsMQQifxDiY4eN8T6jTQPHT2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C1PhKH5CVRWPJwqu/56fkL31p7N6f2dOX+aMJ5nx1/VcEXojX0vTpAIVPLB4iNCgTvS7WMPqSKxeKDrZ2+0qqoIalD1QQcVMLA0NUQzZi5YEDUnY8mHCc1UV0W/l4kIfaR/i8gDAbQ2tcbKUJ9GGndc/FspM29PkvPjW+WBA4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ix/UjVx5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5539JEs0032287
	for <linux-wireless@vger.kernel.org>; Tue, 3 Jun 2025 10:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Fa99oeqBEVDBB20FC594I9GHAUPXnM34rcW
	ckS+ZDsU=; b=ix/UjVx5y9Mi9CQpCTBHkeufX6PaaD9YkJs9tsfaYJVp67SCXph
	ZyWTSDSZV2pa1v/6hMqxg4Ms+xEUq0XdjrfXIrn90rlPGZf8QfZauyWpRYJD+Wfp
	1q4i88zqRHX5OrelePLxwmB/ff9g6uZrsPGIJ/KmOJLsovWioZ2DhMGTZWpJsSRA
	A87PDMggDgYRXkAOwdMZWD5sf23TsidSeRtSExZ+BRC7mezxZfjZq0EO6cGlolpH
	1HzYnvglE4hQhzzvXAc1iB5YlYGMjeY1/U5AUje/4kOWjeaf0HHRavsel7Prx8BF
	sSSaCMPJijAKKa0eW7bfjA9UPmYOmuCbEEg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471sfus2jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 10:35:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2c38df7ed2so3801772a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 03:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748946954; x=1749551754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fa99oeqBEVDBB20FC594I9GHAUPXnM34rcWckS+ZDsU=;
        b=D7ESYRqzFlQbENVGmEEE7G64fenNiM9VgrIFnoYRj4gVsiLt2vq1aIEsMppVAw+GRc
         SlGfoJV63LUPNirDPZYF4MbWE37ZAFGekJSnVtUZNZG/q1cvG/Dr9LMsw4yOQ7c0F7iU
         AUDYoeRmdSQTiPnOxGexANu3X7QwHuklL+cLnAvhFTgBoA8ACmSkxPaqAtaDbmNAPWVG
         wmzRqOue1UzFe6dKpxBnDQn7HZWVaqJtuuLyVv2CqLLep9HCQOkFmLW56yVdFB4VcS8/
         7a2vIVcwalYdRE/5VerzOqXfS7Ml5vPDPg4KY1kdQSl/oVA/fbDirlyQpHGa64BhT3P7
         EBdQ==
X-Gm-Message-State: AOJu0Yz49I77V32vWtCHDxpNsLmMi5ybFZwAnACwhQSm4XZXjjnYkXPk
	mYf9IxVboDTdNQEaFBSaB4UYHkPaT0qHoQZcC9l/QmePHSPzoZSG0EU76QPN7Laqx9S34BffI7K
	OE4j9EhCaRrJMO7gRC7h4AEsTVQlhviuzyZGgf3rMVb8imJxdeXp428zsPSqJMlRurCN+s9dHzI
	D0sQ==
X-Gm-Gg: ASbGncuITs9hmaZXyM/n7/OLHz/DUoWoXy7iCc2jUG87zSmy0BKxsAP4nb0tk3gyihD
	iy2wopNOysfe6X7Wobq/oNwuXEckaavZeDYFoUMmc6GTZLB2ZY09BW7JUN3T0OIX9OMv/nwiJs7
	pIhhP1p7CJd979Vbttw5bQlJ6C4yS+ujlmbvDsegpReS/omHS8uFQ2xoMDQSes2tYRc8LVQ/aSr
	4s+oWa5XUzVgGH5xmxjOLlS7cmuYhDb+vnS12YsZHD9GXR/AxtPXmR80OZtZDQuAKVX/mZOJgMN
	ixe0Rl+uasGjfUZcLWapl76xuyKyaESeAjcqST12QXuOuCmv95YonuG3TqBBK0enwZNz0Vx+HER
	m02WCxBGuQbx5O4O+ly/lzQLPqr9D2jTAbcXwPo4i
X-Received: by 2002:a05:6300:8e04:b0:21d:fd1:9be with SMTP id adf61e73a8af0-21d0fd10cbfmr1564518637.12.1748946954279;
        Tue, 03 Jun 2025 03:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+NtkerCpzTqcy+q3F3VHXlKBglNwScvJ2CaLnNLZQEAIJIkcg0ytkp7YMd5eBjDiq4w6HpA==
X-Received: by 2002:a05:6300:8e04:b0:21d:fd1:9be with SMTP id adf61e73a8af0-21d0fd10cbfmr1564500637.12.1748946953911;
        Tue, 03 Jun 2025 03:35:53 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f038898f6sm1112149a12.52.2025.06.03.03.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 03:35:53 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Subject: [PATCH ath-next v3] wifi: ath12k: Fix double budget decrement while reaping monitor ring
Date: Tue,  3 Jun 2025 16:05:42 +0530
Message-Id: <20250603103542.1164713-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CY8I5Krl c=1 sm=1 tr=0 ts=683ed00b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=PAAuEJLs8KcRaXcz7g4A:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: IGWW8D53cODWg9dqOhnHmi2ZYUqSH5iI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA5MiBTYWx0ZWRfX04o1psp8HAMQ
 wntAwglkOQO1zkGJ89eFyCIXQ5u/9MWYJFoYNUmFxuWKrC+08WlwSOx9Cxgd0zz2kjfCBhjbxIG
 BcqWehwuwxsZy4cH6LXNjocAMoOqTFLwUP7PAo1P6tJOhOy3T25X0Wzm2KRkj+wT+6vWNpJGvwo
 NubFrmjt9VTSd3I5H8N8Yp1Xj5maN5ZIsYU3Pu8ilqs6whePgbuaqoJWd75QMULxJvMzUa2CGnS
 ZWSfvO9RkuVQxFDEO3MU9uYfjE9aMZDfrr+xvxdP0fpKst9IG+8kJYOvJj9jBHFpVFNk7VZ6vgh
 skPCDadkNVx+/v4mtCVbicEo6mgiLARfsOAbBI2pJxFyL1tRHMUALvPEACFKX/FgutylsE2+pX6
 qu+fr2AmuwF4+fQVovAy+eV4u0DzqQ5BPIgvjt3VRE/Sf8//1jYEcitn5MV90AxbdXh5HaV6
X-Proofpoint-GUID: IGWW8D53cODWg9dqOhnHmi2ZYUqSH5iI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030092

Currently, the budget for monitor ring is reduced during each ring entry
reaping and again when the end reason is HAL_MON_END_OF_PPDU, leading to
inefficient budget use. The below mentioned commit intended to decrement
the budget only for HAL_MON_END_OF_PPDU but did not remove the other
decrement. Fix this by eliminating the budget decrement for each ring entry
reaping, ensuring the driver always reaps one full PPDU worth of entries
from the monitor destination ring.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 394a3fa7c538 ("wifi: ath12k: Optimize NAPI budget by adjusting PPDU processing")
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
v3:
	- Subject updated to include 'ath-next' as the target branch.
v2:
	- Corrected version log.
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 28cadc4167f7..91f4e3aff74c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -3761,7 +3761,6 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	ath12k_hal_srng_access_begin(ab, srng);
 
 	while (likely(*budget)) {
-		*budget -= 1;
 		mon_dst_desc = ath12k_hal_srng_dst_peek(ab, srng);
 		if (unlikely(!mon_dst_desc))
 			break;

base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
-- 
2.34.1


