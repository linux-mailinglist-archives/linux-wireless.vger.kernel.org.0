Return-Path: <linux-wireless+bounces-25710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8328B0BAC2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 04:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6127A112D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 02:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88B3225419;
	Mon, 21 Jul 2025 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8rmCEky"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9C225414
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 02:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064876; cv=none; b=ryTm0mdb62AJwDy98BDp+SXi8ASbKlUzJRO1hksLY9+slzfYrKgG6G30CM2V2Rh1Ud9Dav/7isXw6f+6UYsZL3L8soCZ7ClHamtCt7tqwLK1Q8onCgbiLXrvDsSIhgg6rEnnC4vEcAVwGxrquPkMDS51j9vdDKFqL1CQ0tKI83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064876; c=relaxed/simple;
	bh=IXPGnQ9UfJ4suK+gSl3AFZDmkHK2DtvB44NifkKZUns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YCxpbd/IAdX1D6lJG1Ug2cX0y3IW/0x9ODTtUkiSQ4EmoHwn9JW9uX7wi09v+rzjHOL/eUzgJwtQDsSK82RRWy75Gb6WXuGS+d07fLf+7gO4EAC71a54Yeg6qVObxBgm0EEKnIgGbI6jZFdApLUvb0eetTVWfItbSRXAPU1gWOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8rmCEky; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KNOQEn006509
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 02:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PlESFODkg2/n6CKXRrQsrv
	crzkq/qeENX4SwJDn1k5I=; b=l8rmCEky0qziIw6wiRSH/cB8ooDGWljJGzSlJR
	codoLzGXOc3wsk/e2fr7KlFpdW9LZxiQthLCw2BNc47KsOdm9WufbZGT7vxzQzST
	tVQR4WC5pmEY9Sc6LcqQ4EORIqap5ve9m5Fs0U0j5uTdbQWV8lw8mAcmWFBv0be0
	vawCT/mgQbSYYTWzyCyJ+2TFvYHzkH0/+McRS6Zg7w5Aznrpin0ZPA2f0lwiJA0c
	aJh3S4mNnEeJw0ft6jU0yqv3P3CrN+96rYIInhiB1grhSH6JlKOON++2vWv7K9Fa
	VBJV+zgcw4Ju9JSGVLzB02AH7NYq503h5ZyYlvl+HnhDYv/Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045hb3hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 02:27:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31c38d4063so2711678a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 19:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753064872; x=1753669672;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlESFODkg2/n6CKXRrQsrvcrzkq/qeENX4SwJDn1k5I=;
        b=dqjdxydBKwFpQuazujjeWThglryZp3VBJcn5XFnaY6rwk8bw6EUHzM0Js0VtJOevXd
         GJ2HMf5CQkkH1j7MTkMZgRsOosirm66waybIeKfxGvAHPcsd3blNgKLf9Z5cdG7MabzY
         rBOnQddFgptbFLDs3/0PoeqxwCPK8Gl+NjKGXrMSjXU3c5A2RKxkKi5T+URlDZIpzYMh
         ZjAMSEqXzJN2fyUL1RW8UJ1xNS0CajGKUzljYyozG8W6Y3LzriPzBw4W507CxJfbqGiY
         AGOsAsO0XW2Iha6XKLd1wpkibkcW2FkWrMmC2vYJmQVZsT5PTBmMAd+fqVSLkNiewxhi
         4LuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMA4Kjz2dp4o/ISq74w/Cld1IxVRANjoNtxb78rU8G6pcIuJa4UYbwyKR0nBJwmlExPkmWPbwTTVp9VxT2nQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gfKy6nqFmufdW0k9NPUIlDVxYLiGJABes2noudhpvNVG1bch
	oTH30IF+q1PqsUGTNtrXUQQ6wdwPbcuToBWASTK4YPmek+StxBOS0udqAOA7zkfdNhIyYE+RAIP
	9egd1l4+6tIzTu1nNAPkFKWVN5bEQnYd1PyVbAVLpWUHudY856K4tDPKstsEN3cwosV1oqQ==
X-Gm-Gg: ASbGncuBcein7WlQOB1KvNMlPW5LwMnPGge1WcovCvp1Cvp/FWgfBOQ0j6mTLaz84CS
	6FOKe0fPK1eG09detnKG9XeXh/OxNL2ajNgkIiiTU+NEAqu5Zwy0Fx9icaioolIdx0tuROfCXhr
	ddmiUC95jbmmSJUL+Aco+mV8HB3rSXShWZ5I9x3gaar4GMqzBsOL689hencn93c6WopW7H28qQo
	KbEfW4NV/9F+2ScQ7sbYl8SpCwAlEg5l9SVNh+cuocuCUMXYRwgIj1e7m/78FTmdN7L6ahQvE6F
	vS2TyB8oVGEbDt/bWuTriqwKsQQXBLQyLrFKUeWfPI2uamZpP+gvD3HlQZGIH4pGpEBei9BPcbM
	qpOn7uUp+G1CPCl991g==
X-Received: by 2002:a17:902:e751:b0:235:225d:3098 with SMTP id d9443c01a7336-23e257706f7mr297068725ad.46.1753064871995;
        Sun, 20 Jul 2025 19:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdLbfWV0WIH6gdMWFXAbj48U52Qby9ezjzObx5YEv+xoAivqbUdo2qXTW8a4OuwKQNGg5T9g==
X-Received: by 2002:a17:902:e751:b0:235:225d:3098 with SMTP id d9443c01a7336-23e257706f7mr297068425ad.46.1753064871552;
        Sun, 20 Jul 2025 19:27:51 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4cedsm47541335ad.120.2025.07.20.19.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 19:27:51 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 10:27:26 +0800
Subject: [PATCH ath-next] wifi: ath12k: bring DFS support back for WCN7850
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-ath12k-dfs-v1-1-065c31454f91@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAI2lfWgC/22NzQ6CMBCEX4Xs2SVsI3+efA/DobSLNArVLhIM6
 bvbcPYyyWRmvtlBODgWuGQ7BF6dOD8nQ6cMzKjnO6OzyYMqVFnU1KBeRlIPtINgo861MkPftpW
 FNHgFHtx2wG6QejjztkCXktHJ4sP3eFnpyP8BV0LCigtLpu6rsuerF8nfH/00fpryJNDFGH8Ci
 w+OtQAAAA==
X-Change-ID: 20250718-ath12k-dfs-82472cfb996d
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mihai Moldovan <ionic@ionic.de>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=ZtDtK87G c=1 sm=1 tr=0 ts=687da5a9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=La950oh4TLMd4KyFD9QA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDAxOSBTYWx0ZWRfXz6LSGlLnUtOd
 IfxozNrInfpd2J7N1f3/QV6zkhIC20sCqBMfdKPN1koHBplHO+lJ2f0hfgiaOvyEogDf6b4uvwj
 31iKdo0Ho17ahx5WqCSRUf6o692T9jR5ftuEX6UmRAiU2/YXtZyVYVMKGdhYutaiQ2vvi2Oty/B
 CIIP/4mKh4bcu0jI3SeOk9c8GBKRMzALfl2zgaLmxvXwrzDOvH/RvPvPJhrWGs3dAxVRWnqZGue
 +wnyiS6UqIA+ccJ6ssPvGvrA2OlwxvEvl2mF1nBsjaLcF4tWVGq1muTUCZU3kGdrJ8dBm99PN4X
 v3TCrE+wnuBieSB8n+MSzyadPYdOsK11LmN0fdSb7r9DNMgOAHg6RCNeQwyoR18WkweAVq4nX6O
 xyzMmlwnokPHr+xGiL0Y+bJe5RvO6YPGN+30DKl3Bel25V3K3wzN5Ezf1EAmNVsm7QvcI6cI
X-Proofpoint-GUID: zDGvuAJx_2YQnKSllaBFZjbmX4Kj-iXH
X-Proofpoint-ORIG-GUID: zDGvuAJx_2YQnKSllaBFZjbmX4Kj-iXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210019

Due to the restrict in MAC80211 that DFS (Dynamic Frequency Selection)
can't be enabled on multiple channels, commit 176f3009ae59 ("wifi: ath12k:
support 2 channels for single pdev device") removes DFS support in order
to support 2 channels concurrently, making AP mode not working on DFS
channels [1].

Revert portions of that commit to bring DFS back, and add a new
combination to support 2-channels concurrency. This is valid because the
MAC80211 restrict works on each individual combination, but does not care
about them as a whole, as far as DFS is concerned.

This change applies to WCN7850 only, other chips are not affected.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 176f3009ae59 ("wifi: ath12k: support 2 channels for single pdev device")
Reported-by: Mihai Moldovan <ionic@ionic.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220346 # 1
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 47 ++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index bf612079b8bdae18a043913dbfe1ff7cbd9eaa34..97d8b4e287fc361516e93c7d32436f07e4728896 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -13364,16 +13364,12 @@ ath12k_mac_setup_radio_iface_comb(struct ath12k *ar,
 	comb[0].beacon_int_infra_match = true;
 	comb[0].beacon_int_min_gcd = 100;
 
-	if (ar->ab->hw_params->single_pdev_only) {
-		comb[0].num_different_channels = 2;
-	} else {
-		comb[0].num_different_channels = 1;
-		comb[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
-						BIT(NL80211_CHAN_WIDTH_20) |
-						BIT(NL80211_CHAN_WIDTH_40) |
-						BIT(NL80211_CHAN_WIDTH_80) |
-						BIT(NL80211_CHAN_WIDTH_160);
-	}
+	comb[0].num_different_channels = 1;
+	comb[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+				      BIT(NL80211_CHAN_WIDTH_20) |
+				      BIT(NL80211_CHAN_WIDTH_40) |
+				      BIT(NL80211_CHAN_WIDTH_80) |
+				      BIT(NL80211_CHAN_WIDTH_160);
 
 	return 0;
 }
@@ -13456,25 +13452,42 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 	struct ieee80211_iface_combination *combinations, *comb;
 	struct wiphy *wiphy = ah->hw->wiphy;
 	struct wiphy_radio *radio;
+	int n_combinations = 1;
 	struct ath12k *ar;
 	int i, ret;
 
-	combinations = kzalloc(sizeof(*combinations), GFP_KERNEL);
-	if (!combinations)
-		return -ENOMEM;
-
 	if (ah->num_radio == 1) {
-		ret = ath12k_mac_setup_radio_iface_comb(&ah->radio[0],
-							combinations);
+		ar = &ah->radio[0];
+
+		if (ar->ab->hw_params->single_pdev_only)
+			n_combinations = 2;
+
+		combinations = kcalloc(n_combinations, sizeof(*combinations),
+				       GFP_KERNEL);
+		if (!combinations)
+			return -ENOMEM;
+
+		ret = ath12k_mac_setup_radio_iface_comb(ar, combinations);
 		if (ret) {
 			ath12k_hw_warn(ah, "failed to setup radio interface combinations for one radio: %d",
 				       ret);
 			goto err_free_combinations;
 		}
 
+		if (ar->ab->hw_params->single_pdev_only) {
+			comb = combinations + 1;
+			memcpy(comb, combinations, sizeof(*comb));
+			comb->num_different_channels = 2;
+			comb->radar_detect_widths = 0;
+		}
+
 		goto out;
 	}
 
+	combinations = kcalloc(n_combinations, sizeof(*combinations), GFP_KERNEL);
+	if (!combinations)
+		return -ENOMEM;
+
 	/* there are multiple radios */
 
 	radio = kcalloc(ah->num_radio, sizeof(*radio), GFP_KERNEL);
@@ -13517,7 +13530,7 @@ static int ath12k_mac_setup_iface_combinations(struct ath12k_hw *ah)
 
 out:
 	wiphy->iface_combinations = combinations;
-	wiphy->n_iface_combinations = 1;
+	wiphy->n_iface_combinations = n_combinations;
 
 	return 0;
 

---
base-commit: 5a1ad8faaa165028dfcce650e20868c8fb7148cb
change-id: 20250718-ath12k-dfs-82472cfb996d

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


