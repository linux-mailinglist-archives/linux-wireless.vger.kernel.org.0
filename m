Return-Path: <linux-wireless+bounces-27633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05175B9A154
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 15:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A588617E0DC
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 13:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FC92DFF33;
	Wed, 24 Sep 2025 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kIKx5L/l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302342DC773
	for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721436; cv=none; b=WMlHFE+Xg8HVuE660xAPXAS4eQy+PCzx7suoXoIc8vVPpcx3yvkfcb0skXuqZKAUqXFcN65EIT0ddzpRFVLQuWIAlDSOl/r+gjW3qf5JxoaciF0dHonZdRPaFguf0hocLPsB53X/i4JxRndQQqDARXGUDRoprx5wrF/96eUoVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721436; c=relaxed/simple;
	bh=rKZD9n33xhLjm79nNaSRKE/aN+KRw9LR7vPAFyorlKQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EPS/VG/i3XBWO7LMjOU5KhXqOxXMy+XXbmPkPlqCESlRgbDfqq7IWHpKxAl3nuqI2t2SSyDdVY1xRMh0PRJU3kI6twi4nwL4YDz/mCrHLCvwFN8d6zjyae6cDSaGopul/Pmd9yNE64+6XJZ23+4BLUnGHhfmiUa9zCCui9QuaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kIKx5L/l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODFQf2024258
	for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 13:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=dZ9wQGPf+KSo
	hIWXGXa6QigUi1qxy4uiKfvXrU6/Dgw=; b=kIKx5L/lcWUrALkGObLJ/WzZ2Kk0
	Zxi+07p3Z4ZThVZeX4yUGNtq1zbHsj8NQLEHMLb5OOtvmvvXrYPn42xV8/mCDyHa
	j4ivSwZJ4Cmzo/PuRWFbjPdMvJKuuEu68Gdti6mSjvMT91wdvj6dpWVaw1Clok3H
	cxeuqtm7Tgcb4FPLM+rUSJBCa1Agx9WKcSRuqYhLWIYvwsVL9uAJFn37nAQmcvt8
	Pp8R5LyxT45TB1g5KrKOuIprtTh6KceSyomLn37kQIfIGbx+QWgSFAgKfxn2gjBB
	Kb5KudxVJt9FFfc28r68TE+0Npd2drqe8wgMd8vpelWCu4TIwVk0aPkhOA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0bgnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 13:43:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55436fff66so3000220a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 06:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758721426; x=1759326226;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ9wQGPf+KSohIWXGXa6QigUi1qxy4uiKfvXrU6/Dgw=;
        b=DwF2oOdEgRtRZeI0MaFsdwi6MFGQmx8XzCyNgD7F7LP1kgKav64+0PeYIyF6u2Zf53
         +UmXC4x8GFN1xiC1mAK8tE5Uzn3oL2OliZW2CVk+SLRldN7A4nkjC7TXF0eeDEeUwHe5
         CS/eF3aKw+SpDw3kvZHOb3j+lK6NWfeDmn0aw0n5ipqKfFMgIAN3cu1Al67nk2pLYe+W
         FtLW9XSCfGEzIFg+GdBu9VMULC2q/KN8SiZ35a9LPj/LShkI0A+qq1H5GcxD/OfHwtwF
         7MnhlJgQh7RIzwv3/ds89oGyA3z47L4XrjvxSbO4sEGl9wNmHtsYUzgUFWuIajR6OyQ3
         tm4Q==
X-Gm-Message-State: AOJu0YwUHQzotT3R7zzFnuwfkGlljQpsFPrDLq3y1SXLVFUdbxYqJaOZ
	ZwPNmLrMAQEf3zWY0a2dtgS31Z2IxCeylvxc4JEpB/9EC61LPieiiOuJCMCiaV+/4MMEIXy4Pae
	4TUZDlFZ3dUGuo4a2nhhL1PWZhLF8zu1gbV/TibhTYU5SVCVzk66ULVcXveFaf22no0O1p5hDlT
	Z+Gw==
X-Gm-Gg: ASbGncvJ/6+FTYxmK6Hz5J2kmL0dX8qCwxKQ0cMWMWB0DceRvSo6QNT3/RVoyspoE3m
	nBiZj0vqPfGGTgKOlhT9mNZFstqWWeZkQVkhV8fbx75xUjbTz0+bBTiazCx+DUqNDmRvi7aszSa
	ObtfM4J298XpzxkRu4VT44f/ZA64+Oo5y/XSti/VE4YQugu38Ci7XcbQtBJisgeqVongem1rMd0
	FMZP8+mmJyuszqIliVbfU1fk2udPtGOoj9imRgFz/z5T3W+eom79O6+LuxmuNjOctfS2sBS4otn
	WyCQrwglmk0L6wqEmTD3mcPb3qAH+Wghevq+uI51W05tBfwP5noXLg2sdXmozU4z9R6nMkWSp8c
	2zuigDH4=
X-Received: by 2002:a05:6a21:32a0:b0:2e5:655c:7f86 with SMTP id adf61e73a8af0-2e5655c80a3mr861153637.39.1758721425520;
        Wed, 24 Sep 2025 06:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEomo9mq4FaL/FwAxsbFJPIsuMpf16D3GpuEBhT12E/HRSTGA3k0wgUzpYoDkNFNWIKDVSpEg==
X-Received: by 2002:a05:6a21:32a0:b0:2e5:655c:7f86 with SMTP id adf61e73a8af0-2e5655c80a3mr861110637.39.1758721424956;
        Wed, 24 Sep 2025 06:43:44 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff413ba1sm17448360a12.39.2025.09.24.06.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 06:43:44 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Defer vdev bring-up until CSA finalize to avoid stale beacon
Date: Wed, 24 Sep 2025 19:13:36 +0530
Message-Id: <20250924134336.888-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d3f593 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ne_Weq33sHSohhLfQcAA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: WVntIVihN-HmjL5W3yJcmFfmxYck7SNX
X-Proofpoint-ORIG-GUID: WVntIVihN-HmjL5W3yJcmFfmxYck7SNX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfXzKqWvXFqj2o7
 GKDP9N6pxmB52H6xr2AhbGHvMBiq2XwnmV/Tke7fy4z7AU7ypJohtlTp+VnJvTaLW6wBEVIGkTV
 920n1HvXW/gWe8bSCdT8oDrFJqLeQnUu1WMGJhx27uz9UYDfLLhQ75BsMhHp+BRE9TsPZXvU5QE
 feF8wnhZRKTahCVd9LbJnhDGOvl2Gy9RaDX+1cVWt5463A2d/ppErHQna8QwIWspOcL3/Ih7gXM
 zTy5zGzGLTapj2+9UkeJY3a5HaflmNmNLv7ir49tQsjLBDmKEWs12BvhfwRKL3PAcgZ2HJKf2ya
 N8rlN2AInmbqv8eesElydxkRhFL7yNHGWoRJiAWPvd6uQgeZJ7lH5EyXkF7+gqcqVo/uN/Z20Yf
 tKqsoFwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Mac80211 schedules CSA finalize work twice during a channel switch: first
during the reserved switch phase and again during the finalize phase.
The beacon content is updated only during the second schedule, which occurs
after the reserved switch completes. However, the ath12k driver attempts to
bring up the VDEV during the channel switch callback
(ath12k_mac_update_vif_chan()), which leads to premature installation of
stale beacon templates before the updated content is available.

This premature VDEV bring-up causes outdated beacon information to be
broadcast, which can result in updated channel parameters during the
transition. In MBSSID scenarios, this behavior is particularly problematic
because the transmitting interface's beacon must be updated before
non-transmitting interfaces are brought up. Failing to do so can lead to
beacon mismatches across interfaces.

Introduce a is_csa_in_progress flag to defer VDEV_UP until CSA finalize is
complete. Set this flag during the channel switch callback when CSA is
active. In bss_info_changed(), check this flag and issue VDEV_UP only
after the beacon template has been updated.

Ensure that in MBSSID cases, the transmitting interface is brought up
first, followed by all non-transmitting interfaces. This ordering makes
sure correct beacon propagation and avoids stale beacon installation
during CSA transitions.

Additionally, move the call to ath12k_mac_update_peer_puncturing_width()
before VDEV bring-up during CSA handling. This ensures that the puncturing
bitmap and bandwidth settings are applied before the VDEV is brought up.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Fixes: 8c6faa56bfb2 ("wifi: ath12k: add MBSSID beacon support")
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 90 ++++++++++++++++++++++----
 2 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3d1956966a48..630f5dd56eb0 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -355,6 +355,7 @@ struct ath12k_link_vif {
 	struct wmi_vdev_install_key_arg group_key;
 	bool pairwise_key_done;
 	u16 num_stations;
+	bool is_csa_in_progress;
 };
 
 struct ath12k_vif {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1d7b60aa5cb0..84473dbf22e1 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4221,6 +4221,30 @@ static bool ath12k_mac_supports_tpc(struct ath12k *ar, struct ath12k_vif *ahvif,
 		chandef->chan->band == NL80211_BAND_6GHZ;
 }
 
+static void ath12k_wmi_vdev_params_up(struct ath12k *ar,
+				      struct ath12k_link_vif *arvif,
+				      struct ath12k_link_vif *tx_arvif,
+				      struct ieee80211_bss_conf *info, u16 aid)
+{
+	struct ath12k_wmi_vdev_up_params params = {
+		.vdev_id = arvif->vdev_id,
+		.aid = aid,
+		.bssid = arvif->bssid
+	};
+	int ret;
+
+	if (tx_arvif) {
+		params.tx_bssid = tx_arvif->bssid;
+		params.nontx_profile_idx = info->bssid_index;
+		params.nontx_profile_cnt = 1 << info->bssid_indicator;
+	}
+
+	ret = ath12k_wmi_vdev_up(arvif->ar, &params);
+	if (ret)
+		ath12k_warn(ar->ab, "failed to bring vdev up %d: %d\n",
+			    arvif->vdev_id, ret);
+}
+
 static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 					struct ath12k_link_vif *arvif,
 					struct ieee80211_bss_conf *info,
@@ -4228,6 +4252,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
+	struct ath12k_link_vif *tx_arvif;
 	struct cfg80211_chan_def def;
 	u32 param_id, param_value;
 	enum nl80211_band band;
@@ -4236,9 +4261,9 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	u32 preamble;
 	u16 hw_value;
 	u16 bitrate;
-	int ret;
 	u8 rateidx;
 	u32 rate;
+	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -4271,12 +4296,41 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 				   "Set burst beacon mode for VDEV: %d\n",
 				   arvif->vdev_id);
 
+		/* In MBSSID case, need to install transmitting VIF's template first */
+
 		ret = ath12k_mac_setup_bcn_tmpl(arvif);
 		if (ret)
 			ath12k_warn(ar->ab, "failed to update bcn template: %d\n",
 				    ret);
+
+		if (!arvif->is_csa_in_progress)
+			goto skip_vdev_up;
+
+		tx_arvif = ath12k_mac_get_tx_arvif(arvif, info);
+		if (tx_arvif && arvif != tx_arvif && tx_arvif->is_csa_in_progress)
+			/* skip non tx vif's */
+			goto skip_vdev_up;
+
+		ath12k_wmi_vdev_params_up(ar, arvif, tx_arvif, info, ahvif->aid);
+
+		arvif->is_csa_in_progress = false;
+
+		if (tx_arvif && arvif == tx_arvif) {
+			struct ath12k_link_vif *arvif_itr;
+
+			list_for_each_entry(arvif_itr, &ar->arvifs, list) {
+				if (!arvif_itr->is_csa_in_progress)
+					continue;
+
+				ath12k_wmi_vdev_params_up(ar, arvif, tx_arvif,
+							  info, ahvif->aid);
+				arvif_itr->is_csa_in_progress = false;
+			}
+		}
 	}
 
+skip_vdev_up:
+
 	if (changed & (BSS_CHANGED_BEACON_INFO | BSS_CHANGED_BEACON)) {
 		arvif->dtim_period = info->dtim_period;
 
@@ -10862,9 +10916,9 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			   int n_vifs)
 {
 	struct ath12k_wmi_vdev_up_params params = {};
-	struct ath12k_link_vif *arvif;
 	struct ieee80211_bss_conf *link_conf;
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_link_vif *arvif;
 	struct ieee80211_vif *vif;
 	struct ath12k_vif *ahvif;
 	u8 link_id;
@@ -10925,6 +10979,28 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			continue;
 		}
 
+		ret = ath12k_mac_update_peer_puncturing_width(arvif->ar, arvif,
+							      vifs[i].new_ctx->def);
+		if (ret) {
+			ath12k_warn(ar->ab,
+				    "failed to update puncturing bitmap %02x and width %d: %d\n",
+				    vifs[i].new_ctx->def.punctured,
+				    vifs[i].new_ctx->def.width, ret);
+			continue;
+		}
+
+		/* Defer VDEV bring-up during CSA to avoid installing stale
+		 * beacon templates. The beacon content is updated only
+		 * after CSA finalize, so we mark CSA in progress and skip
+		 * VDEV_UP for now. It will be handled later in
+		 * bss_info_changed().
+		 */
+		if (link_conf->csa_active &&
+		    arvif->ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
+			arvif->is_csa_in_progress = true;
+			continue;
+		}
+
 		ret = ath12k_mac_setup_bcn_tmpl(arvif);
 		if (ret)
 			ath12k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
@@ -10945,16 +11021,6 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 				    arvif->vdev_id, ret);
 			continue;
 		}
-
-		ret = ath12k_mac_update_peer_puncturing_width(arvif->ar, arvif,
-							      vifs[i].new_ctx->def);
-		if (ret) {
-			ath12k_warn(ar->ab,
-				    "failed to update puncturing bitmap %02x and width %d: %d\n",
-				    vifs[i].new_ctx->def.punctured,
-				    vifs[i].new_ctx->def.width, ret);
-			continue;
-		}
 	}
 
 	/* Restart the internal monitor vdev on new channel */

base-commit: 32be3ca4cf78b309dfe7ba52fe2d7cc3c23c5634
-- 
2.17.1


