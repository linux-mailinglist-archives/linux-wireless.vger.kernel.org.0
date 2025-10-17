Return-Path: <linux-wireless+bounces-28006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE0FBE6433
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 06:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810FD1A64DF1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 04:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5257230E0E5;
	Fri, 17 Oct 2025 04:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1ZXj4Gr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3CC30DD27
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674098; cv=none; b=Xz32WhtYW5JFQRUVC3FIwnWBEnuZnZZURq/6QjIOsjg5gmUOAhdKpGq2AkelwdBIA0/DWMYzvt3kd8bhJzIroPACOHK2dcHsQ9IdzgNuonys+rlenj3avQ1Am83KTkULDnhdv/mDrmW/eP8puyZMqnKtteiLOmY22Tw0/UW9PHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674098; c=relaxed/simple;
	bh=3PCgNAWoDGSnLHmbTyI/u/LdOj2mopBhYs1h1lRSsw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eNO9pVdPEAR6jAZlgbcKtpXNEMgTmOZcICK7i6rDdJUGRFl9glvs4BenTqVZols+wVTxaxBjdoL3JYuZvOp05hsC76eKzWMDXBtl+JcngvigFLf476REPIsiP+4Avndk72PRDgWZaE+vM5+a+jfHgNsRtXXtrwTVyvRG0a0OSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1ZXj4Gr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLOkm020186
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cWolfLazVFYT84mp58WCfAKVs/5R8s1zPglUdTg+gis=; b=F1ZXj4GrM3fQPJjk
	7g331XXg15LcXc21lt/oKyWMFI3ecoFwHEWcIYJdR8Um0Mav7jhvX8Vox/PnqxxM
	ItfTIquI/zS464lt2wFloU3nAKdOTssQwIv2bP5PIgAV/E4P+gYZxP17yeo5f36x
	gHOhet6a4g//2be958W8eqqnGNl0cnm/XWRgObW3YbhMEph5xK7ubI0L3O+eJJ6K
	AXhaarQguSlLQT3ImgXPw0qhpDSyRkLZlYd/ILb9f3A9x2R0T3y909cGg0hM7meh
	uJ5AgzMLzXcX+R77X193YPDCAB6xe3KB1SkasGmP/1St6waPCWgC1xLJMKq6pmXR
	hUPxgA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpm648-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:08:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27ee41e062cso21376915ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 21:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760674093; x=1761278893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWolfLazVFYT84mp58WCfAKVs/5R8s1zPglUdTg+gis=;
        b=SrA82qpvlVjZrTS8UvCczVQtQ1KsCP2aZSGyZycnY9XcXSn2pxK7FM5R/iT05lq/7R
         8PKsij8v2RJU/GsdufZnYEWTeXHZst/s91Tsp53JuhbUXEEFAWiXRv6h2TdgPqAQe5w3
         lVleHULVh34AM20D12xfcIDO833xtOuAMAox6u5aRHYuYiAjHjr9+ISPRTLc+T1NWElR
         o2mOEVM5Np0wnUI72TK/X8rCuwLONjj6yAbv4d3gdmrjDfDfVbCUD/XYSv+ThTlujqQz
         VGQrJdc1plstxquHmpl9nNh11xfJFh2Dwh5GT0d/iZfff3Xwz9bzHRleDeZU8Nx71008
         Dikg==
X-Gm-Message-State: AOJu0YyCrpvr7IyZIFwtO28uUi11By9Esx8oEjnr/RSEeA1SJ8o9WmNX
	+LpIB1FIQwaDDzq8flm5+4brXWIYSiTWdW7SJwzejOn3Kidr8UEFC9XKUszDdbGHfUUb9pLUuxl
	uT55pF1aTH2duu0xvDCNZMyWVdbTKVQGUmAHn8mDjiYbXPVeG7rx6xysVX2688LDwQMT1mjNDBc
	NCrw==
X-Gm-Gg: ASbGncthiFQ8sgQ1/reaQ10T7Wq2GsJDxF9qIpgFC3Ed7Byhk+kCNUFmLwh1i0z9azk
	i2fofehYoS8/paJBgd+VPTtWYpO7MnrUGVr7/lkHpGIsfPSsZ1TQqegSOG/2k4Bh2fsk3Wf88dG
	7pEdg6riIDUV1hcVfI+h86EHBjHyFL3pDMuFIEl1bwoypn0McdiO4LvlsMURpc5fWVnO/NrU1YC
	kxbzWhzSeJCGzqMOA3UGX99e9Ts21bR+Vb3XvmqqM3SeTZUV6LaSON0CQ/5L9pO9AuB8XXsHwdq
	Zk0qmvVTHIG0jBA5/kVcZ25kwPvbDksUdIoriVVGmcK9LMn9uQJsMztVU1XMPFi6fQSo6uEtZjY
	Dk9NHZkx1Ihm/C5K05txVP6Le0v++v/VNXHjuwH3koWWX6Eqe5ixz6XVBCQVJ5fWfm7wC9V56S3
	6XrSR7zHosmE6Qu+VgmnbC+rM=
X-Received: by 2002:a17:902:ec87:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-290cba481bemr29330375ad.56.1760674092884;
        Thu, 16 Oct 2025 21:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXQc/rF6+4aCLOlalhTrIqG/9+ZR208dHO2zKfTlxMoTdojrxoUaPi3LlK1PsMdL9w63V5vA==
X-Received: by 2002:a17:902:ec87:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-290cba481bemr29330005ad.56.1760674092376;
        Thu, 16 Oct 2025 21:08:12 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7afcbsm47635345ad.76.2025.10.16.21.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:08:12 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 09:37:58 +0530
Subject: [PATCH ath-next 2/4] wifi: ath11k: wrap
 ath11k_mac_op_get_txpower() with lock-aware internal helper
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-add_tx_power_insertion_support-v1-2-f08feacfca93@oss.qualcomm.com>
References: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
In-Reply-To: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f1c12e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=HHL2EbrfMguBWQQB2GUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfX2n5Sz/cz+LTP
 imXF8Kvf5uB2LjHNAhHpPzbsNawnVOTYjunsX7EfnSSriesvfffnDOqyeiUguXhbkdf0OqJViM4
 9UjdckWdxiNVZcAb3AhMiE1j+rKsEvhomJOG4PlWCrxJQes07J4CJuQJkWYhTYRdIXs6d5Y2tF7
 DslUbCprfE9cjbBkecOzq8tGTL9KFeLgLCWgqYsrEm2M738MS5UVVugm9bmj+N1UcocJB32QYHw
 hNZgAqnWrbs8eDutLYtwKjzHOlnRX417RwO8br86MXeQ9/JrjLDuEg/fYIS4w6TuN8EX/TcbdpR
 lnJJqmwoMpjjY7vW+TS0rIlDtfdXQmkej0H9gHsNFv9qtFHKwWvwFIzTkdqRUHf6xazQoztDzus
 FbMJDxwmnDZIriYot5gA0NYXkpiBMA==
X-Proofpoint-ORIG-GUID: sE8NGcpmnmgxvcYtY9j24gQEkHTn7_i9
X-Proofpoint-GUID: sE8NGcpmnmgxvcYtY9j24gQEkHTn7_i9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017

Refactor ath11k_mac_op_get_txpower() by introducing a new internal function
ath11k_mac_handle_get_txpower(), which assumes the caller holds the
appropriate lock. This prepares the codebase for future change where the
internal function may be invoked directly with the lock already acquired,
improving modularity and lock handling consistency.

No functional change intended.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a7bd0ddf5fdf..cd6e98ee1232 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4103,12 +4103,10 @@ static int ath11k_mac_get_fw_stats(struct ath11k *ar, u32 pdev_id,
 	return ret;
 }
 
-static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
-				     struct ieee80211_vif *vif,
-				     unsigned int link_id,
-				     int *dbm)
+static int ath11k_mac_handle_get_txpower(struct ath11k *ar,
+					 struct ieee80211_vif *vif,
+					 int *dbm)
 {
-	struct ath11k *ar = hw->priv;
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_fw_stats_pdev *pdev;
 	int ret;
@@ -4119,15 +4117,13 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 	 * of these. Hence, we request the FW pdev stats in which FW reports
 	 * the minimum of all vdev's channel Tx power.
 	 */
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_held(&ar->conf_mutex);
 
 	/* Firmware doesn't provide Tx power during CAC hence no need to fetch
 	 * the stats.
 	 */
-	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags)) {
-		mutex_unlock(&ar->conf_mutex);
+	if (test_bit(ATH11K_CAC_RUNNING, &ar->dev_flags))
 		return -EAGAIN;
-	}
 
 	ret = ath11k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
 				      WMI_REQUEST_PDEV_STAT);
@@ -4148,14 +4144,12 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 	*dbm = pdev->chan_tx_power / 2;
 
 	spin_unlock_bh(&ar->data_lock);
-	mutex_unlock(&ar->conf_mutex);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware %d, reported %d dBm\n",
 		   pdev->chan_tx_power, *dbm);
 	return 0;
 
 err_fallback:
-	mutex_unlock(&ar->conf_mutex);
 	/* We didn't get txpower from FW. Hence, relying on vif->bss_conf.txpower */
 	*dbm = vif->bss_conf.txpower;
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware NaN, reported %d dBm\n",
@@ -4163,6 +4157,21 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     unsigned int link_id,
+				     int *dbm)
+{
+	struct ath11k *ar = hw->priv;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+	ret = ath11k_mac_handle_get_txpower(ar, vif, dbm);
+	mutex_unlock(&ar->conf_mutex);
+
+	return ret;
+}
+
 static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_scan_request *hw_req)

-- 
2.34.1


