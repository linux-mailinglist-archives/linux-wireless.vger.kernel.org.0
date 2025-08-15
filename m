Return-Path: <linux-wireless+bounces-26394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 879FFB2754F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 04:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF0C7B2CDF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 02:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5735564A8F;
	Fri, 15 Aug 2025 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D9lY/Bz0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567B1A9F9D
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223586; cv=none; b=TI26CauFMBWz21IyZIDSLBSTKPk/aJXZN2YcZNJSxqIkVZMKnOE1kzThH2UuIIOvMXpdyE+boyqP5P/7E5qm5A5wbkKnWcVAsp0PGMqxf/aHFNeYuKoRSPFeLWQLfCgdHz4I5PdFkO/kqJBbp99bAlXXqK0IdO/65pCwEFjEBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223586; c=relaxed/simple;
	bh=ey+Djyi7KnnM0ZX1t6GKLWA1EPB7+gI5c6GhQ8mADhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IpLGiFO69mqf55JBLHMbzeOHyi3HXnn5QEpTeTMkXi730YLtkgDbArbzr/nOMo/rnegIsNJI64J1seQtIjxI8omG9WKGvKdcemD7NlR1bU/k1ccdSWfA3yK4aQH/7BM9xc9NXsa6mOFQBGJIIEaqhqhahnc4mynCch4mAVC3uNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D9lY/Bz0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EHgEcl028898
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 02:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yaaM+XL5Gi6ry6IeNjfcOR
	LxBbF4Fo80QQCM6SflmPs=; b=D9lY/Bz0dtoZ9elsLZLHUqY1O5enfjIAmcK+t6
	/RNRRhCOAxn11MA3oUAK0MPKM/OO4eKSSxGARBbYt+WJBOoFlEk3P8S+9zaEAw27
	FB4DLqKuSCVLGhuFRTODlzYpraaewybXZ47u82Hhgn+BBxTj+tnB2olbux+K/gFo
	OiaXpr/cgYqfjSTLxK4jQDaVW16vmM3FpixVmlRG7UgbNHczqbJulwjRfWoPwKii
	eKrT1swk4dgUVmhT/b14n3TPgsPXOFbqC6PFkIa1d9uB1Rcv/XYxR6avrcceJ6fz
	eexLp03y+cV4zCO+UT1A7Fp3SCNK350x8OEZQAHYovHcM/Og==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9qa0s6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 02:06:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e5c4734so1404685b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 19:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755223582; x=1755828382;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaaM+XL5Gi6ry6IeNjfcORLxBbF4Fo80QQCM6SflmPs=;
        b=lTHafM8g2bnjNWgmwS/Jbqwzm6qvhpeZs45Kqn0sj41YWVfTDuQY/9VmIgULIS12I3
         0GSQ+F1unnTC6yalNhdFVMowjVUglbuM32evb/6xK5yZCAjNoMb8Zr1ykB72yb38f28J
         AKdmmsN8D9nIiLo5fpbViLWatJ3lL0SElD/hEnc767ORi606uKsDuPrrc+Ie+1EWsJoy
         WJv7EvIRpM4RxfLolxU2bpAmxPvO3bMVf39mWNJrmD0ScW7IskjsUv6EGHSKCKwUuoGT
         3FLqotNkXiEPTf/SUVHLNDA+1FUX0hk/shkoKrpKK0MwO2VGslyLu6fbpgkVCGQUNpJE
         iZ0A==
X-Gm-Message-State: AOJu0YykcBKU3uAHFabUta53lIHZbGaT63kxkHW2pwdqZaoAn2hgnAGZ
	0vR1w0X/IKtsz1c468BrWrdDqGbNunYbW7RpeEN1Wi8+JKndQ0b1A4WHRYV9Z4tA/5zPBNsKsGf
	3LOvIzw8aQXcY985n0nBpAGwBQftPgrRRCgHf1piNkewM+xI/rzfCZl/By4tpiSfw1FyKfS7qJK
	4SBdul
X-Gm-Gg: ASbGncuUHi1LjHNSu0MEz5QcSwVXZ1eFaQuvcLwD+3sDpAERFHEgEBFPt/5YfoN9EvJ
	/M5UN1TuAny1WgYI2rOB94MBAWW+UMcluxuHNCBdOEGB6T/uzsh98YBvH4L51PFOrvFqvs8paJW
	ArDwnC1WGN0thi1Cn5o3OqclxATK3BMLXuX9SJ6wDX1ecW5mLXARoShmdbmVvluBs5Od46Qie08
	D1qH5XL6niHcgwciKCecRcgJmpzxGA8pmRebJidBzYjlD5ANB4O/8US00sFjqSAOnUacp1733o3
	QwkqlljyCbh7eqFSwRhf5DQzTsSP5J9pRWDK0cZPCKrd46jE9C30MRinrg8X6GN2haHcASRmtin
	kzehcJttYHFBe2BS9
X-Received: by 2002:a05:6a00:3997:b0:76b:f1c0:224b with SMTP id d2e1a72fcca58-76e4485ae74mr372744b3a.23.1755223582234;
        Thu, 14 Aug 2025 19:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiOav9YzVv+68s1XTQezP9a0+HNLO7H+DTaN2Oo1vUFa2w/+pnDcr2oWE+MaetHJSTw+Y80g==
X-Received: by 2002:a05:6a00:3997:b0:76b:f1c0:224b with SMTP id d2e1a72fcca58-76e4485ae74mr372708b3a.23.1755223581711;
        Thu, 14 Aug 2025 19:06:21 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45593060sm35807b3a.86.2025.08.14.19.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 19:06:21 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 10:06:04 +0800
Subject: [PATCH 6.15] wifi: ath12k: install pairwise key first
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-backport-6-15-y-ath12k-pairwise-key-v1-1-d6c977acb35b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAyWnmgC/5WNQQ6CMBBFr2Jm7RCmUkBX3sOwqGWQCUKxRZQQ7
 m7DDdz85P2f/LdCYC8c4HJYwfMsQdwQgY4HsK0ZHoxSRwaVKp2WdMK7sd3o/IQ5ksYFzdSS6nA
 04j8SGDuOXVbXpjCKdWEgPo2eG/nulhvkCWmoYttKmJxfdvVM+/aXZSYkPJcNFSWXWZrbqwshe
 b3N07q+T2JAtW3bDzhL02/jAAAA
X-Change-ID: 20250813-backport-6-15-y-ath12k-pairwise-key-a4dda7a2e57a
To: Jeff Johnson <jjohnson@kernel.org>, stable@vger.kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, johan@kernel.org,
        gregkh@linuxfoundation.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689e961f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8
 a=EUspDBNiAAAA:8 a=bwSFjXmOb-h8CDtPQtgA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: ZlIdQ43pCmJOvKg5EfwvOaVhWoctn7No
X-Proofpoint-ORIG-GUID: ZlIdQ43pCmJOvKg5EfwvOaVhWoctn7No
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX5RGcOYYmC+8U
 GC8mTC/RT0lQDKIRxTrIehwbbqwg3lL4K9+IKAZdBhVF699R+57ERitx9Sf92wI87Lm+tghV6IR
 a69cmdIJyB8mm28deieusR0u9Et+c+Xcqz7a8nyyN6ReDPmljY/mYD+RFRDUUf2BMGMUOg5Ju52
 5dlUnUtl9CCPMqaNtx4JwNsKwJh+8V1XVyss7wTQ0OJqRILGBJDTVclp4iazgvNVhqDDgnO66q3
 tFvtF3hg+H/8tAWBNHzJAnKUafpfKdZbaJWOXOqnzI3KgOh3rSQvCP/795V1qzZf7RWqE47/NRv
 03hhWf5pD7Y40uewnbDIKxEzWffKqrvttPV6yj/iDn4nKbdG9w4j3BS1P45jubzspuue1b9HgNL
 zdTI2xHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

[ Upstream commit 66e865f9dc78d00e6d1c8c6624cb0c9004e5aafb ]

As station, WCN7850 firmware requires pairwise key to be installed before
group key. Currently host does not care about this, so it is up to kernel
or userspace to decide which one will be installed first. In case above
requirement is not met, WCN7850 firmware's EAPOL station machine is messed
up, and finally connection fails [1].

Reorder key install for station interface in that case: this is done by
caching group key first; Later when pairwise key arrives, both can be
installed in required order.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00217-QCAHKSWPL_SILICONZ-1

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218733
Link: https://lore.kernel.org/all/AS8P190MB12051DDBD84CD88E71C40AD7873F2@AS8P190MB1205.EURP190.PROD.OUTLOOK.COM # [1]
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
for stable kernel 6.15.y
---
 drivers/net/wireless/ath/ath12k/core.h |  4 ++
 drivers/net/wireless/ath/ath12k/mac.c  | 76 ++++++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/wmi.h  |  1 +
 3 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index f5f1ec796f7c55a8f06724380714d10ed28e9748..4cff5e42eb34d261cdc418e6a105f5f4c5ff79b9 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -303,6 +303,10 @@ struct ath12k_link_vif {
 	struct ath12k_rekey_data rekey_data;
 
 	u8 current_cntdown_counter;
+
+	bool group_key_valid;
+	struct wmi_vdev_install_key_arg group_key;
+	bool pairwise_key_done;
 };
 
 struct ath12k_vif {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d1d3c9f34372da18759c6b7801c5cd9d3f092d40..647543f5f360f2ede581274499668f272ff77042 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4641,14 +4641,13 @@ static int ath12k_install_key(struct ath12k_link_vif *arvif,
 		.key_len = key->keylen,
 		.key_data = key->key,
 		.key_flags = flags,
+		.ieee80211_key_cipher = key->cipher,
 		.macaddr = macaddr,
 	};
 	struct ath12k_vif *ahvif = arvif->ahvif;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	reinit_completion(&ar->install_key_done);
-
 	if (test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags))
 		return 0;
 
@@ -4657,7 +4656,7 @@ static int ath12k_install_key(struct ath12k_link_vif *arvif,
 		/* arg.key_cipher = WMI_CIPHER_NONE; */
 		arg.key_len = 0;
 		arg.key_data = NULL;
-		goto install;
+		goto check_order;
 	}
 
 	switch (key->cipher) {
@@ -4685,19 +4684,82 @@ static int ath12k_install_key(struct ath12k_link_vif *arvif,
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV |
 			      IEEE80211_KEY_FLAG_RESERVE_TAILROOM;
 
+check_order:
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    arg.key_flags == WMI_KEY_GROUP) {
+		if (cmd == SET_KEY) {
+			if (arvif->pairwise_key_done) {
+				ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+					   "vdev %u pairwise key done, go install group key\n",
+					   arg.vdev_id);
+				goto install;
+			} else {
+				/* WCN7850 firmware requires pairwise key to be installed
+				 * before group key. In case group key comes first, cache
+				 * it and return. Will revisit it once pairwise key gets
+				 * installed.
+				 */
+				arvif->group_key = arg;
+				arvif->group_key_valid = true;
+				ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+					   "vdev %u group key before pairwise key, cache and skip\n",
+					   arg.vdev_id);
+
+				ret = 0;
+				goto out;
+			}
+		} else {
+			arvif->group_key_valid = false;
+		}
+	}
+
 install:
-	ret = ath12k_wmi_vdev_install_key(arvif->ar, &arg);
+	reinit_completion(&ar->install_key_done);
 
+	ret = ath12k_wmi_vdev_install_key(arvif->ar, &arg);
 	if (ret)
 		return ret;
 
 	if (!wait_for_completion_timeout(&ar->install_key_done, 1 * HZ))
 		return -ETIMEDOUT;
 
-	if (ether_addr_equal(macaddr, arvif->bssid))
-		ahvif->key_cipher = key->cipher;
+	if (ether_addr_equal(arg.macaddr, arvif->bssid))
+		ahvif->key_cipher = arg.ieee80211_key_cipher;
+
+	if (ar->install_key_status) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    arg.key_flags == WMI_KEY_PAIRWISE) {
+		if (cmd == SET_KEY) {
+			arvif->pairwise_key_done = true;
+			if (arvif->group_key_valid) {
+				/* Install cached GTK */
+				arvif->group_key_valid = false;
+				arg = arvif->group_key;
+				ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+					   "vdev %u pairwise key done, group key ready, go install\n",
+					   arg.vdev_id);
+				goto install;
+			}
+		} else {
+			arvif->pairwise_key_done = false;
+		}
+	}
+
+out:
+	if (ret) {
+		/* In case of failure userspace may not do DISABLE_KEY
+		 * but triggers re-connection directly, so manually reset
+		 * status here.
+		 */
+		arvif->group_key_valid = false;
+		arvif->pairwise_key_done = false;
+	}
 
-	return ar->install_key_status ? -EINVAL : 0;
+	return ret;
 }
 
 static int ath12k_clear_peer_keys(struct ath12k_link_vif *arvif,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index bd7312f3cf24aa1352c807c5216dc010b7414058..d0cc697a418e10c70adc585d7e9e5759bd53d4ce 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3725,6 +3725,7 @@ struct wmi_vdev_install_key_arg {
 	u32 key_idx;
 	u32 key_flags;
 	u32 key_cipher;
+	u32 ieee80211_key_cipher;
 	u32 key_len;
 	u32 key_txmic_len;
 	u32 key_rxmic_len;

---
base-commit: 097aa9a71fd56cdc62c11bdf45a84f07acaa3604
change-id: 20250813-backport-6-15-y-ath12k-pairwise-key-a4dda7a2e57a

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


