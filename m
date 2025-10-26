Return-Path: <linux-wireless+bounces-28281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B02C0B023
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 19:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0C344EC3F5
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 18:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E076C2566D3;
	Sun, 26 Oct 2025 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cfssedO6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125C2E8B83
	for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761503019; cv=none; b=BRywx5Zi2Y+/t2xfm+NNOfF5fRoPC4tvwSp6NmxjXzk2Qm2ufSIicY5uIE5/7exmxRccE1Qtyi0LtZGBtf9XzjdiSJjHI1hJjIRMp5K81iepVUMBPoLwK5W9sMQQJ4V1SdJYHj/pYHygWq+SW7tTZWE6q+KXNJb+XmuE3uMGRNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761503019; c=relaxed/simple;
	bh=t5CkQ5mQdskBQE1z1RrwUzLdt6gfpoZkrmIi4IO1FM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABpQXKFADmbNjexjHm8j7Kw7tWQyHj+6W7xM9YM0HSCT3W9ThiAHxQ1haXPlJG6PArhSj40hOcXYI4K8rnXpgQMHlGym37QwRPhMSwTb/xuoKf+ggt15l9FZvo2UUkYBHOeVuvZGaiG9DOkNufJ89fHCgbc1Dwa9aBtjoLjhBrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cfssedO6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59Q6jmCV3334096
	for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 18:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mG+RYsLT98t
	O9MCLjpeevtNsKHifcEXrsuza3lazY6c=; b=cfssedO6I8veDU/wU3Qpqjfkkw8
	Am2L8sCx8auU8RNOxIeyXLi8LMkR+3FU1LvG9DyFMZqxh8HzXkRY+qG0VMzZME3E
	Dd6lBkuYbqpHYDvrOg/EbCFhRMmpBw9jJ0Frcq4LDGJyDunQFOb9ucXfRHD35eFA
	m+8cPm41I7TsaYmz0iRbkvnU7GvT6bcLLizRoPaT5n3MBlTQVx7TP8UJxK0TIOTi
	WccRZLLVJbpoYCmix/aTOReE9KJE7mbN6X1L+svJHd519sryXZZlJRuZvkLnZ8Qf
	jH54molFMtj7ZW9ZY/XexHCJKTgTbUgnm2mOd9ejXgGsjMhyV6i98qDeG1A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0px6jbgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 18:23:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so2798409a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 11:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761503016; x=1762107816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mG+RYsLT98tO9MCLjpeevtNsKHifcEXrsuza3lazY6c=;
        b=wZcyGoLfMXl+dl0N1NpUPzT4A7y6cc5QJmmO3p7e4lUhdMlLySpCYK4Pp2Wfq6hdlz
         +utFw0ugV44fCKXfg+hY7e8MOtQ4Hs34Ps5+5ubVrvVEny29DhW/NbubaNWgortac0N9
         tQILezuiPNezJ87Crq5PChx9cPmmLH4K68U3mdqrZHJddYNp88wJEpshsqupJrFKfAhs
         mZgQeJSrGvlskMsT1GxiRwhiD//p8u5gvd3/KIvv70O/Tqb1yq4PEuYzo16BkPq3Fzqi
         jnNLkemE0kfZ3B4bwwfWI97QdMAL1CnQwOU+h7Vy/RcDwIekFH30BmtIflZ/GggGPIRy
         YB5g==
X-Gm-Message-State: AOJu0YyUpgNwOSx38oQB6297xVv7l1j3uddxi+TY/j3rW+L9/X5sI1dr
	0FUrh1PjBAyRtjztfsDoKSjaBQD1vuV6nzZ9LSusfq+/J60yTlbRg0KCJwOPLHg4QV03f1UyJ9L
	zD7bUf1FIeD69naD6YQuyV8AoqdTRmIGx/0ddw4vACFMUfKmxUNLFWU5cBHmJy1uItvWXNg==
X-Gm-Gg: ASbGncuQiBeE5Dpcaq7ki1GUd7aKPzB1ddu8aqTH7CocGo+HaYsBInwQ7TgHeuSBtk2
	DxKqpYquWGvk/C/kgrQFWghtDaVCd7R1CJIeD1frRJi6z48KFoutuGd04d+ovfPuQk8hDhvawyF
	w1H6fHCaD872YvW0zdiQeXDTkc8Qoq0WBFtFaVkv0Q71PlaIwheEqjBxnAToriAWGR1Nxla+stV
	PBTf8IOD3hlB/CBvgdJFISoaAJpiEBDMTScR3ARPHMbMuCfggcPuYSmNcLGWyhcx6+EjoXygtZM
	2AqiKP9C3+sVbXV61fPi3nSKQhco/ZzCrlqNW4z6QvMr5QQgO8gaHMn5KfEeosj1ZS/3raFNwy2
	WPoMyohSPADs2lk6VtuxpTgiaE6mhArMYeLfBNXvmEm6Rf3OBW+OB5DzVpJ+kAxvYUUgviRjTmx
	r+3ALYYu4RH48B+6edwhGoaYjzysU=
X-Received: by 2002:a17:903:1a4c:b0:267:ba92:4d19 with SMTP id d9443c01a7336-290c99a8ed3mr435861195ad.0.1761503015972;
        Sun, 26 Oct 2025 11:23:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHswKgrqRdmMzEaLmyHg/B3sPp31a13mYJaP42VLJaQB0/JCuphSY2wn+y7KiotSh1X+pry9g==
X-Received: by 2002:a17:903:1a4c:b0:267:ba92:4d19 with SMTP id d9443c01a7336-290c99a8ed3mr435861025ad.0.1761503015470;
        Sun, 26 Oct 2025 11:23:35 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm55208655ad.100.2025.10.26.11.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 11:23:35 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next 1/2] wifi: ath12k: enforce vdev limit in ath12k_mac_vdev_create()
Date: Sun, 26 Oct 2025 23:52:53 +0530
Message-Id: <20251026182254.1399650-2-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026182254.1399650-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20251026182254.1399650-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDE3NiBTYWx0ZWRfX7JAjfavo7+Cg
 WSdgS3FlhPWZDHHn4AvbC4oJskxLao8qiCF5zfaqYsHweqQncKikjIO0t8StMwnyZOiSRRROXv3
 jcFITvS7C/pW1TbZKWET5F0DvdMekKgvDnReho8EsXFPt9mfY5MB9BUbr7v66+9k2FNLkOlZNQN
 ohGCCWt3VO/bDVIM+VGuSyHxY7y9WqHeBUMl2Ax+1DuIZk4y043kzdEusT9bB2kU3mdIuMT8Bff
 K/cn0pK0XfleOIPd96yEgoVkYO0lYoO0LLc0WRSzNhQ6MYSnXwVpOY59xXXwdBpgsrFKPUKbkjD
 0LGqoXOSGnwB5K/0UhqR6fHGbvLkG8RSX1VNAnhvVFmNO2g74q+jcy/n2rknaSZtaH5rCsv/VRV
 tWVCgfqFHEFJBGygTGV9VyM6hHIwsg==
X-Proofpoint-ORIG-GUID: AATb9ZFF81lzZtl9JSpR9vzfoJ2sINwb
X-Proofpoint-GUID: AATb9ZFF81lzZtl9JSpR9vzfoJ2sINwb
X-Authority-Analysis: v=2.4 cv=WqMm8Nfv c=1 sm=1 tr=0 ts=68fe6729 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=9mMTWwSXXuGFS-eWrSwA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510260176

Currently, vdev limit check is performed only in
ath12k_mac_assign_vif_to_vdev(). If the host has already created
maximum number of vdevs for the radio (ar) and a scan request
arrives for the same radio, ath12k_mac_initiate_hw_scan() attempts
to create a vdev without checking the limit, causing firmware asserts.

Centralize the vdev limit guard by moving the check into
ath12k_mac_vdev_create() so that all callers obey the limit.
While doing this, update the condition from
`num_created_vdevs > (TARGET_NUM_VDEVS(ab) - 1)` to
`num_created_vdevs >= TARGET_NUM_VDEVS(ab)` for clarity and to
eliminate unnecessary arithmetic.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: 0d6e6736ed9f ("wifi: ath12k: scan statemachine changes for single wiphy")
Fixes: 4938ba733ee2 ("wifi: ath12k: modify remain on channel for single wiphy")
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 86b79deacf03..931aff85d35c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9753,6 +9753,12 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	if (vif->type == NL80211_IFTYPE_MONITOR && ar->monitor_vdev_created)
 		return -EINVAL;
 
+	if (ar->num_created_vdevs >= TARGET_NUM_VDEVS(ab)) {
+		ath12k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
+			    TARGET_NUM_VDEVS(ab));
+		return -ENOSPC;
+	}
+
 	link_id = arvif->link_id;
 
 	if (link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
@@ -10112,12 +10118,6 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 	if (arvif->is_created)
 		goto flush;
 
-	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS(ab) - 1)) {
-		ath12k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
-			    TARGET_NUM_VDEVS(ab));
-		goto unlock;
-	}
-
 	ret = ath12k_mac_vdev_create(ar, arvif);
 	if (ret) {
 		ath12k_warn(ab, "failed to create vdev %pM ret %d", vif->addr, ret);
-- 
2.34.1


