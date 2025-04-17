Return-Path: <linux-wireless+bounces-21627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6086FA91344
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 07:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9007A4DEF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 05:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E731EF0B9;
	Thu, 17 Apr 2025 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RzBYpxgZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7FB1E5714
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868976; cv=none; b=DeNtWyptFXgT2E+WwKkxMI8u/FrtltGV7Zhwwk20KDaeNmymb1CuhDQnoJOawYDx/eiDRDx00QJ/aUxk/ClNOoxipP5kN3Sk/w0YfAidJxMFo1Bk4Ov93UWyAzBAd4yw5BMIpBL1j8yU5B/wbBP/wb3IxSrVK1PZva4tb4SzpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868976; c=relaxed/simple;
	bh=KPVZESR1YwL7Gu1wcBkJxBXCYSlDcgPHM4VX8hoFCbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfwy9Y43DZn1P94xoDINW5GYd0/IUvFiGBZhNZ4pApDdeuan2UIWJRFwnzPEGY9ld7uil+/RaxL8AagMWlda3s+N7znvWcJUZf/uI9/hmi0x2jas0rU6qCk/9zNevKHyAW4bciNChWmbZYB1doeHf5hQi6k5EP7r/qs+WVIyHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RzBYpxgZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5lEJI030237
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 05:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KY4DrBghMwtTahQM4d6UO66pLjRLPs99V5LIXxHJ/Mk=; b=RzBYpxgZ6A6zCPW1
	g9u2KchZIN9KHVRbJeboCC5g3UTaRRIClGaWIbGH45f2PV1xX3IzTWHX8ddMCdEL
	X7qhX1pEeOhGFUG3AOYMnO8VQSDaYwq0bFt/UFB4+EjN23qHOZSi0cB6xD7wHMtq
	X0xJzEQ7uNm5A0S4fQclue9N6Ykuw/dHU80emQ74qIOjYxQoKex9RKg7FswpPPB9
	nO6NakEBWWb63jVMe7XgCx8PWVKWupoEewL21hgMUeo3vaz29lUDtjrsuLGYyegx
	aJ/7G6l+PHDkJlXUalg5P6wF+cmZclC+FFE31aq8YTZUrfj4PLEeVNeXpkAfU7xJ
	B6qKeg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69wt1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 05:49:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-224191d9228so6450625ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 22:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744868971; x=1745473771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KY4DrBghMwtTahQM4d6UO66pLjRLPs99V5LIXxHJ/Mk=;
        b=L14KQFjFaM/6EWEN33FehyqcTETE1TR5u5jYC+Saxuq+yU1xJ2CM7KbPTXia+jRXcC
         tRgXAXTdIqC7OrsU+X11BkKMQbw4ICKpDWQvZv9U8sOdf4quK4neOwPITzqSbY1DY/YB
         COGCtRB3Dzct2RLfoeQgO92c51TV5bIEEwnG1O5eEvNuUGmvOkayZz8LARaTU8qAVf5Q
         +PWGzn2qKp3sOhAN4Ha3ulK+QKe3DI/oezeYP7mc0hXbBgbWBf6TmgDHZ9CsSx6adfSd
         8zVF+7ZaJo3LHaTXeiwB/+Ilx4Wh09jNav/0bNHCenQqqYktN1DaNgBQEVnce+1WSkFA
         ljvw==
X-Forwarded-Encrypted: i=1; AJvYcCWZmxbVfnlST4R9mc71oc1nYGaAOvm/PANCV/2xKoRQDO388P5Z88nldwd1cBZNCD1qRRUqcP4Fo991oYhNTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFLtA5I4k6y8fuL/BWKCbbCVenkTSRy7rY7LZaxWaljhKRcUki
	34xZmtAlsacwcqYbqApeB+xRBxZHaqPe15cagIP4wMV6clQuVuN1/4TWyaU17EZGfPcpy4wefnj
	mZu/+c00FpMDVA84t6oPQTzIgq02IfyDTXd7WrNX6HrcXTp6ZZHGy8qXFW26GSoVaZA==
X-Gm-Gg: ASbGncsOmuMqrCODZRMbmP9gtTltCvNN4RC8BQ4jWscco7VEK8sMcil7Q/CrZwSKS9Y
	0boii5At2LODwtFR+GCVZtll60ZxeMRZ2W0vt4nIUK058bEBDrhidwSo9H4rZZiXnIv6MnzNw5m
	SOvGB6+IeLNKwh+93MEDFagLfFjnVDlLGNAMkEfm9WKX1/kMiZdlUuA5AYSm9Xydx+RztibTf3Z
	M33NP9P+eofDosutqF5hl7pAv8SF02ZthjrhUK8yp0nOtrajmP1Zc7Q3x/CQ6BGA8jm4aHy8fwq
	UP+VmCD5xCDhvMekypxQpvWC01xJtnsVmGi4FFSeQuBp4VDReUB+6xAyeSuCX3t3pMnfMLgR0e/
	zcTPOUTszAqjHPujme57aamT2u88AL8yAUTBX
X-Received: by 2002:a17:902:e5c3:b0:224:f12:3734 with SMTP id d9443c01a7336-22c359194d0mr63687075ad.30.1744868971457;
        Wed, 16 Apr 2025 22:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgUIRYQK9CQySZDLp9fCj9zmVxHD4QcP7G3RLpCYsbt/OVETw+o1p5ug4k3wOR1o29Qii2YQ==
X-Received: by 2002:a17:902:e5c3:b0:224:f12:3734 with SMTP id d9443c01a7336-22c359194d0mr63686895ad.30.1744868971092;
        Wed, 16 Apr 2025 22:49:31 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fc47e0sm24745715ad.167.2025.04.16.22.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 22:49:30 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 11:19:13 +0530
Subject: [PATCH ath-next v3 1/2] wifi: ath12k: handle scan link during vdev
 create
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-fix_scan_vdev_handling-v3-1-9ec42513d26b@oss.qualcomm.com>
References: <20250417-fix_scan_vdev_handling-v3-0-9ec42513d26b@oss.qualcomm.com>
In-Reply-To: <20250417-fix_scan_vdev_handling-v3-0-9ec42513d26b@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: O9AEEBJ74zjPgKB9qchI3b104K8QtPxC
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=6800966c cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=dhThNb0MqnHfOkfGsx8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: O9AEEBJ74zjPgKB9qchI3b104K8QtPxC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=966 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170043

For scanning purposes, the driver can use link ID 15 (scan link). A future
change will make non-ML interfaces to select the scan link. In this
scenario, arvif->link_id will be used to retrieve the link configuration in
ath12k_mac_vdev_create(). However, link ID 15 is not recognized as a valid
link ID in the upper kernel, which will result in a failure to fetch
link_conf and subsequently cause the scan to fail.

To avoid this issue, ensure link_conf is fetched only when the link ID is
within the valid range. Since link_conf cannot be retrieved using the scan
link, use vif->addr as the Ethernet address for creating the scan vdev.
This address will serve as the source address (address 2) in the probe
request frames during scanning. Additionally, use the automatic Tx power
value for the vdev. As this is a scan vdev, these values do not affect the
scan functionality.

Note that vif->addr will only be taken when a valid link_conf can not be
fetched. Otherwise, link_conf's address will be taken as address 2.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index dfc803879028deaa0bb02ced892238086b2687c9..d219c5b07a79c9829a1de12183e298d24eb5336a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8310,7 +8310,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 	struct ath12k_wmi_vdev_create_arg vdev_arg = {0};
 	struct ath12k_wmi_peer_create_arg peer_param = {0};
-	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_bss_conf *link_conf = NULL;
 	u32 param_id, param_value;
 	u16 nss;
 	int i;
@@ -8325,22 +8325,21 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	if (vif->type == NL80211_IFTYPE_MONITOR && ar->monitor_vdev_created)
 		return -EINVAL;
 
-	/* If no link is active and scan vdev is requested
-	 * use a default link conf for scan address purpose.
-	 */
-	if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
-		link_id = ffs(vif->valid_links) - 1;
-	else
-		link_id = arvif->link_id;
+	link_id = arvif->link_id;
 
-	link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[link_id]);
-	if (!link_conf) {
-		ath12k_warn(ar->ab, "unable to access bss link conf in vdev create for vif %pM link %u\n",
-			    vif->addr, arvif->link_id);
-		return -ENOLINK;
+	if (link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
+		link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[link_id]);
+		if (!link_conf) {
+			ath12k_warn(ar->ab, "unable to access bss link conf in vdev create for vif %pM link %u\n",
+				    vif->addr, arvif->link_id);
+			return -ENOLINK;
+		}
 	}
 
-	memcpy(arvif->bssid, link_conf->addr, ETH_ALEN);
+	if (link_conf)
+		memcpy(arvif->bssid, link_conf->addr, ETH_ALEN);
+	else
+		memcpy(arvif->bssid, vif->addr, ETH_ALEN);
 
 	arvif->ar = ar;
 	vdev_id = __ffs64(ab->free_vdev_map);
@@ -8495,7 +8494,11 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 		break;
 	}
 
-	arvif->txpower = link_conf->txpower;
+	if (link_conf)
+		arvif->txpower = link_conf->txpower;
+	else
+		arvif->txpower = NL80211_TX_POWER_AUTOMATIC;
+
 	ret = ath12k_mac_txpower_recalc(ar);
 	if (ret)
 		goto err_peer_del;

-- 
2.34.1


