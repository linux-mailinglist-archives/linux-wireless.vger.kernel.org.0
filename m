Return-Path: <linux-wireless+bounces-28479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFDBC29E10
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 03:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4AB3AFD1D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 02:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D80CEACD;
	Mon,  3 Nov 2025 02:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGEiX191";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SWgR95RC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6345334D3A0
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762137926; cv=none; b=LE4VMQWaOa7BSvse8gOkfPl1QoLbHD2Qeo2X0dQq5UwC3F/sozQiCZ6lxRqqMwTCYFO6Y8pHCO5qwCE6AeUC6pO4f5xlYEvQF6BJzwens64XFEnAB0KAG/i7snB03J3uxIDg2l5JPTkpe4sqovixD/a0v0IdqLzowp7SLv0IFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762137926; c=relaxed/simple;
	bh=SrvhFUwn1NWMZ0ClivPfucOpViRdD06TCJLi1gxqhQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WaDG1NrTEfCd7sHUTzZLqqTgPb47TZJeLyDj2kkjrlEZr00GDsgoSPbm60Cd+iRBF8EjrxZCpqQOVgcE6NDy+z+qo+Hy4WjtZlpfMfAfOYwLRN2OH9Qnputztf4jzi1mH7cBUh0JO1i4xZH9WO/sNI5r6faHUngtGm9zmN7pnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGEiX191; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SWgR95RC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2M0JLf1255496
	for <linux-wireless@vger.kernel.org>; Mon, 3 Nov 2025 02:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=St8TE2OHEhQyYwmvkJ5Xd4
	8GZGKr1wvQZLaduJDmOAI=; b=ZGEiX191X3WSDkct2flOnE6onMKRdsnQTon+YU
	qaBqQ9G504MK7JvTAP04ZMYI/wkRmBem7YjBNsTxvEgZVOr7XTaNN6qxbjhzPwGz
	BaEzek2qAyEeND5Q65mIxpAr7rxR42MOQN91/lPQasUV7LD//qIX+3AUz5B2TusS
	BmfbfQuybBTgzFLNMtSx3mfPAnnOtirOmPyY4yr7saIz3+izmx1pH+HVsVAVGKs9
	tKqu/Zxbe+H+fO00aRz76svAjsexqXfVeYPjUEEKI2K9sGxHnbq7QSD8gxBwAvr0
	zxTykJrzGze+14aLbbkDKQjWMF9vbO7qRcOlhfOuP5Hezbog==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a57web97a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 02:45:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2904e9e0ef9so96177425ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 02 Nov 2025 18:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762137924; x=1762742724; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=St8TE2OHEhQyYwmvkJ5Xd48GZGKr1wvQZLaduJDmOAI=;
        b=SWgR95RCd6EPSssm0qfR9+WetWsDegf8mnGdUCWgGORGpFGHmLcllEes150NzcqdDP
         pdQZjbcRBAbf9Iy1JkF3fqUQ3b54fn7JMrrN0GbBQMlaoksE8lelfPPzwQ4rVRcWs0ml
         zTbZ7gEjmidZv4W1Db6RmEqJXsKcgUE5pOdLOYcZ2VG+z8wrmyNLZhCeMAg4kQkSdBkN
         snATpeZgEbfIniH9k+2dyHxHi1uJs79kHNM/PRLgGwCF2sWyAK1Qd/KBaBpgKFRfqBhI
         EkcMNEZO21Bh3hTv+bFXr5VBwRuJvi5JSPBa7UIJgrT+jZiER4U+rKuG6qjVh47TF0Hg
         kk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762137924; x=1762742724;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=St8TE2OHEhQyYwmvkJ5Xd48GZGKr1wvQZLaduJDmOAI=;
        b=bkkRTr4Z0JpZfm0PIamlOQSrABoP98H2YOQ02/JKnTffMHxlLd0gz9MuQLxsYzeWH/
         aDALl5xHwexPsB0SKft6RURdvFJ2yx8YD1Z3ViaFOzm99QvTOQY6kuc/VmmcLNink4km
         u0baFym9ye9ZsRV8fNrOPAGVkA4fiSowIFNxBRSH43twa4pmkoJckgeK3ZiSGV9WfHji
         KSgBXAqTGpg+emJRyp6umrv/PYDZEGKP/eBkUVcU63H2VzP5wOt2hV4LHcCxFaj1P+fQ
         eA4dkGzTFGknNcO1EpGUzV8tHUgOg2lbo9GsXrg6BM/UuyEnDk8qX+VnGIGCkrC7zzJf
         GnAg==
X-Gm-Message-State: AOJu0YyEDc/k0DURWRFwyribCz8kgDuN2Vvel8tWW9BrIvQQ55x0GxyX
	76x+J0FiIPIncuQAXXVI0QKwhZ6o09hMiqtIS8yEA7hgkjy4A1Ioam/yly3SEPVmY7upIZVFQMH
	Aau2lQ9XmP1SBXOM5ENISBCFw9/CQYKwwo7KgtKA1jic/lels6q4fD0urojR9X9BBCEtXKw==
X-Gm-Gg: ASbGncvv6Jn+FaOBRPGxxu5bvvyv/QDsh6g8XzAAqm7mHj2CexTYdhqRgf9XDnIx/MZ
	AsuldKOEZqnYMZ9DgFb+o/sqsVlNoSULA1eaeeHDeW1RCOa2b+s3wUcmvDVFeiiUwh4b379SY5S
	oyYdjYk+dOv0bEnSrrKDifQA3cClhqVjIf+S21stk77LdILVV1JcuU73m9/To1X6jGSz6goa9U2
	F3le8M4mOl+7ZtqQQPY7fF/NXblL5kfw5RR1I+OygZYEp4bx0verHlj1pWs93NDtXjNU/RbkRMk
	sdErSIYOYJsSbBIxOodQsgnubtdfljKMj02/Liv6NCh6MQKY3+OsMZWz4PXRcXhmozmWjJc3E6q
	HevtZsV8TxY3kebKI52J1zuudV/Yv54Lx0Q/E/YyKrAQGk8EWf+ff
X-Received: by 2002:a17:902:ea06:b0:28d:18d3:46ca with SMTP id d9443c01a7336-2951a5449aemr134563225ad.49.1762137923744;
        Sun, 02 Nov 2025 18:45:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnqS0lDCyYdmp1X/MWQ5lHj0npVE6nLXW+QGXfUcuIxpZz6RlxM8UYVjLshPY8NExVC2fDsQ==
X-Received: by 2002:a17:902:ea06:b0:28d:18d3:46ca with SMTP id d9443c01a7336-2951a5449aemr134563055ad.49.1762137923221;
        Sun, 02 Nov 2025 18:45:23 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b8c8cdc0sm8746759a12.13.2025.11.02.18.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 18:45:22 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 03 Nov 2025 10:44:49 +0800
Subject: [PATCH ath-next] wifi: ath12k: do WoW offloads only on primary
 link
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-ath12-primary-link-wow-v1-1-3cf523dc09f0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACEXCGkC/x3MQQqDMBBA0avIrDvgJKkVr1K6iDrWQY0ykaqId
 zd0+RfvnxBZhSNU2QnKP4kyhxT0yKDpffgySpsaTG6eRLlFv/ZkcFGZvB44ShhwmzesHRcluVf
 ROQsJL8qd7P/xG5LBwPsKn+u6ASArxJdyAAAA
X-Change-ID: 20251103-ath12-primary-link-wow-b4e681476f43
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=M85A6iws c=1 sm=1 tr=0 ts=69081744 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=LP1QxI6-xhCX3emMPfsA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: g7VhJ5-RA0lVXZW4Pb7MEacHGXY2WTRe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDAyMiBTYWx0ZWRfX2/TJT7LPghlt
 N62KU+fJ7rdsCW+31D7ic80/U8c8vah/yI1OWRoJCdrBFE8Oih+GOQlPXJpc5OGm823fdT41Mel
 8xoN5PJ49gqbwxXYGpuwV8nnFVZGu1mvXxNun+v4wVSJ0TfLmuVWwYzo4IBkKdwoQatly2dWZvf
 U22lMMeG7/hQgVjq38+zLrXSIjwRxevuwTYPc7vtBI1DKX4R0fChlQ3NihDjsNSVz9V4yQDYv61
 ffinU36xEGfS4JlF823MGu+1m6ItofvZi34gQgOGRPJJqOkiOShg4OWYdDGeY3O/SlPaqguuzME
 CNV0Ww5XhXiF2THj4D4e/xo79jhVSv6T3IqrcJDC4YdK56H02aaF7BxfK+FT3O9QGkCdnxvhjJe
 Jkbmc72F03Eab3FpZiLHw/e7DuKDsQ==
X-Proofpoint-GUID: g7VhJ5-RA0lVXZW4Pb7MEacHGXY2WTRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030022

In case of multi-link connection, WCN7850 firmware crashes due to WoW
offloads enabled on both primary and secondary links.

Change to do it only on primary link to fix it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Fixes: 32f7b19668bd ("wifi: ath12k: support MLO as well if single_chip_mlo_support flag is set")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wow.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index e8481626f194040cf0728597272801dfd1f8fda4..6448378d85141c5a77c55565ccff1908014e2005 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/delay.h>
@@ -135,6 +135,9 @@ static int ath12k_wow_cleanup(struct ath12k *ar)
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif != &arvif->ahvif->deflink)
+			continue;
+
 		ret = ath12k_wow_vif_cleanup(arvif);
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to clean wow wakeups on vdev %i: %d\n",
@@ -479,8 +482,12 @@ static int ath12k_wow_set_wakeups(struct ath12k *ar,
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif != &arvif->ahvif->deflink)
+			continue;
+
 		if (ath12k_wow_is_p2p_vdev(arvif->ahvif))
 			continue;
+
 		ret = ath12k_wow_vif_set_wakeups(arvif, wowlan);
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to set wow wakeups on vdev %i: %d\n",
@@ -538,6 +545,9 @@ static int ath12k_wow_nlo_cleanup(struct ath12k *ar)
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif != &arvif->ahvif->deflink)
+			continue;
+
 		if (ath12k_wow_is_p2p_vdev(arvif->ahvif))
 			continue;
 
@@ -745,6 +755,9 @@ static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
 	list_for_each_entry(arvif, &ar->arvifs, list) {
 		ahvif = arvif->ahvif;
 
+		if (arvif != &ahvif->deflink)
+			continue;
+
 		if (ahvif->vdev_type != WMI_VDEV_TYPE_STA)
 			continue;
 
@@ -776,6 +789,9 @@ static int ath12k_gtk_rekey_offload(struct ath12k *ar, bool enable)
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif != &arvif->ahvif->deflink)
+			continue;
+
 		if (arvif->ahvif->vdev_type != WMI_VDEV_TYPE_STA ||
 		    !arvif->is_up ||
 		    !arvif->rekey_data.enable_offload)

---
base-commit: 6a5812e1623723adb18e6217d512274ef0d84015
change-id: 20251103-ath12-primary-link-wow-b4e681476f43

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


