Return-Path: <linux-wireless+bounces-24640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C10AED2D6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 05:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4023B517E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 03:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70674C6C;
	Mon, 30 Jun 2025 03:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NHhuR+Hp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166CBEC4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 03:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751253317; cv=none; b=js/c3Rc0glQ81fgSXXtcr3jWWNsDzzW7+GpS+1oXoBoknWVxqS0yeqoaRN4IitBD71c4UfSQZrTcNWXwoZOt+H7Hm4PT1E8lFVRwzIWxEfWgz9yvHdD8wuapgH1tP/tfFEMbznxdOi/MaUCKEOASzs2cHcBQLxAs5Hu2oHeVrio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751253317; c=relaxed/simple;
	bh=mE+yEpq3+hNh8HJbfo9b7r5P/debEfmJpBm5UtFFxLY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVVUqTeaLYg9h0UjS49C/pDiHmuS7EJOb9j2vuM3L2a/JhNvuS+XUw9lwHkjg8ht/A41qS0dDebX+KmF3d0PtRf8JBU/Z3ArolZ3RSEbXASbvQ05LBs4bPXUgVEivjQia0blpDrFaur7dwnvBjTRIzZnUd60msdlpdvHIs0FbW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NHhuR+Hp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TMJ979020075
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 03:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zouhYTDahyyqlN7l7LkNnQ0ijp4WMADMJKc
	PTqyHBZ4=; b=NHhuR+HpC+XlAXwStAUIXJmmpiTtEfdvXvYtG9fQ5oYal1Hgg2A
	7v+FL4zGlq2BHCpPDmMWENWSTEmOeemR6wMZbf6GLzAHVKGGYvoesNxFQ1/FmuEB
	ZWug7LSWX7vlEfNp5qvfbtOGgnMzHZc/smo/Eb+Ui6QRMRIaNw+kxl7u3jnU/jn9
	2TsklRmSfJ9+SI+QkoNlTyH2FV9Z/4R46uAs1JmiSaKPdgk4DccP+RlxMqcw1ChS
	cTqZoFM/Uq8+qn4vcgkmr5gXJH2NTnr0ENNn1qFC6Cs64HhT26wLds6F47PMRcFE
	6UUBW0tW4q1qP2PSy1xgaZhEWn/zuyGTzWg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9pck4k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 03:15:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313f8835f29so2130345a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jun 2025 20:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751253313; x=1751858113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zouhYTDahyyqlN7l7LkNnQ0ijp4WMADMJKcPTqyHBZ4=;
        b=gOdtnFgxaT//YkVnJQk3JecG4hWJ1lShGe8e8N8RO6j3JQoaS7k5cA4ILX+Z8ch8aR
         G9Hmkw9WT7BtSSgvSnPspW5emK3q0jctUxeCrCJIVEYjhljj5tSxIdJQCEmNCHO7sagM
         VlBVCGvyN9O+ADEx5bMmsMfmMlxIwS1wob0MUlVbn2AQ/FHsQvMUjJ8jhG7TcxNQMzdJ
         Kb/W5BQsuXgATkG7KyfD5piJPz8iAgLEYhpqY33u266qxC41meq+T2HznnCdh01TrfTf
         JtEEVG3rqdO4iZ1LOdZSazQ1Ulfwrap9eSUlPe2yJ6vaKxo66kZxLbS1SP7WxLtS8ixt
         RgXQ==
X-Gm-Message-State: AOJu0YzK7bDbHs+uN3t3hJ5pFOoCJJVrjyNsXrSDzHhCUgRJsysaDumV
	JX1hAaXywIReK0994fwJQUxOW1X04mm+TKVlB4ov2WI2NqPeJjQJJkwUyO+RuAiPU9jxeZGnPKK
	ESX9Z/555tzUHpXrfTwsG0sQsKI7bJECyP2lrC4iDFXUfIL5GGCF3SNa79zJB7sqYXMbwjg==
X-Gm-Gg: ASbGncsZ8oNARUJYlfzdnoRVVl6YaI3gnEF/3BpMVwGynex7v9Ogpw2kOfUZpAWyuWt
	49zGZ0jAbcGzZu2SMn7n5zBtR6nV6+OYtEfoAsfROpMDA5CLVo+FGFhJwQ80rVb1OSSQweHCFZ7
	Y7H3nRrwRJUkIV6SbZsvln1tgS04JTjc/EspdV4u2979lmnNSm29ZVwjMIVKi9ZTYPSOWffWnI2
	oMBCnV6h1gAo1ECHeEvLYdDEYeqoINpVLePln7pcCSiCY0bK4FMa8j3FRFD3ktEGM71qbTcolB+
	5lNwFpwKYsJOBYFuBXJDkgBMwIqdbq/dC8eIRRV/5Y4UyFvWktvT8X49xlRrQbYBAYZ95O9Oct4
	rwtt35jRN/KiTduMv7ThgfRw1gOYHe74RQVWfTOGXvTjT0A==
X-Received: by 2002:a17:90b:5823:b0:311:a4d6:30f8 with SMTP id 98e67ed59e1d1-318c8eecfcamr15544476a91.13.1751253312715;
        Sun, 29 Jun 2025 20:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2c9a+v7if/VyAPvMaNeR1gC+/LtweHuvaEBcZAbeOPnEZMDQC/yQ3gQukPSHNR4RIZWWfDw==
X-Received: by 2002:a17:90b:5823:b0:311:a4d6:30f8 with SMTP id 98e67ed59e1d1-318c8eecfcamr15544446a91.13.1751253312317;
        Sun, 29 Jun 2025 20:15:12 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f539e6ccsm12165421a91.17.2025.06.29.20.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:15:11 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Block radio bring-up in FTM mode
Date: Mon, 30 Jun 2025 08:45:02 +0530
Message-Id: <20250630031502.8902-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7PVl_tIsofUZlY7BibpKhZf3D5OqQfCk
X-Proofpoint-ORIG-GUID: 7PVl_tIsofUZlY7BibpKhZf3D5OqQfCk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDAyNiBTYWx0ZWRfX7BqVvXN7/01e
 65jFiv2iY8cTHSwSJSwxsTZbtRjeahLPwwuI4FdZJtCNtw1K0RUP6/KHvx+1+sspvR9jf6mEyQv
 bYlGbx43JBbnVsZP9y7p41dOBcLohs8p8fCU0h7IPuARs5Iq/g+UYlMK8H4N5zpeHcmsruawSNU
 im1sYbHqZq3Q3sxIchclEaxeIHVlVmEEZZ+i8anqN+mkQaTRO+Bakf8sL0zhp0IBDpamwFcTAjX
 H/ZJId3gZ9pzU/ggJPcqkT/qWam+QvM0DZTPRhlStymIC9UvvumwgX/iWR91mZta40BlRuf8qjo
 bPN9JYguNMINjr4rDNtIH6A5ibNmqz8dAzRN1rn78cEiqVTb8uk9XCOcr/ZUTc8PCKHHYTegWdD
 BKJUUmVkDps46rzrFnDjo7DZqgqh6hGPUHdBzQYE42HhH0OMfZSgkcqt03XQwfTE3vyiumHK
X-Authority-Analysis: v=2.4 cv=QMFoRhLL c=1 sm=1 tr=0 ts=68620143 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=ClpxArXO_HDk_Ajs1zgA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300026

Ensure that all radios remain down when the driver operates in Factory
Test Mode (FTM). Reject any userspace attempts to bring up an
interface in this mode.

Currently, the driver allows userspace to bring up the interface even
though it operates in FTM mode, which violates FTM constraints and
leads to FTM command failures.

Hence, block the radio start when the driver is in FTM mode. Also,
remove ath12k_ftm_mode check from ath12k_drain_tx() because FTM mode
check is already handled in the caller function
(ath12k_mac_op_start()).

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 3bc374cbc49e ("wifi: ath12k: add factory test mode support")
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 32519666632d..22a04b32c0ca 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8342,14 +8342,9 @@ static int ath12k_mac_start(struct ath12k *ar)
 
 static void ath12k_drain_tx(struct ath12k_hw *ah)
 {
-	struct ath12k *ar = ah->radio;
+	struct ath12k *ar;
 	int i;
 
-	if (ath12k_ftm_mode) {
-		ath12k_err(ar->ab, "fail to start mac operations in ftm mode\n");
-		return;
-	}
-
 	lockdep_assert_wiphy(ah->hw->wiphy);
 
 	for_each_ar(ah, ar, i)
@@ -8362,6 +8357,9 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 	struct ath12k *ar;
 	int ret, i;
 
+	if (ath12k_ftm_mode)
+		return -EPERM;
+
 	lockdep_assert_wiphy(hw->wiphy);
 
 	ath12k_drain_tx(ah);

base-commit: 4fb98d37afdac11db1f82c1d662e0fd3d209afaa
-- 
2.34.1


