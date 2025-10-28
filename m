Return-Path: <linux-wireless+bounces-28333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D298C13131
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 07:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB321AA64EC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 06:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA35296BB6;
	Tue, 28 Oct 2025 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AHGNaB9p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E2277819
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631696; cv=none; b=Q/IZH3uhOY25zyo9qWO4PsZTmyqJ2ipGFOIVhWIE9C+SB6Q2gEBwXjU7IuQQGUnS5eBIdANNysacE7VBo8Y3mmbg3zQmWqsJXxC97QpGl8sggLPkk5Ht3NCcwQKAqNipMVSuwPxjLuj6isW9BXRlu+m3TKVUB5xHrClLz179uHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631696; c=relaxed/simple;
	bh=W0c8R10SoHWGGlerj/TVivFgOQeuC3ZQvjeAXshqRTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=krKR7lDVxNaaujALmmfkR3o2qZds3ZP5NsRJ0+amR+tFgweqbst8rvsM4C9qs5BItJxngr0DV/I9UXH+7r180XAVvqshvhDzEM3M5PDBT/7ZJ1yNWzixh8fEtsxH73oWU8GWx/gbz5/HqRrRQcZxM74eeSXShBGqvodShfQEC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AHGNaB9p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S0cMAi2881766
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 06:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YFQernyphzUokXIV/+I70uHICPm/RP+xKMy
	m6taPSU8=; b=AHGNaB9pEUoM29BMQpWF6/trsZW1rS5KDocyjzV8W/vz2j4q31H
	ESPuVsfd68gX/V4mkTkOL9wgY4lCXzbJ0aV4Ub810hB/4P7nsPLk+KjdVdgQFkE8
	0KTFCwyUCwd6ZwLWs14EZTyorviFMDvmzOMFjz7lfpwqJ82AxbC54C9mW2wl9Zxp
	o99XC+/nZ1KwF6BKoFFEvRwx++MypnucKh/XX9q/eikQwcFuSQn0J93lkXsWD6zB
	S8lTfhGAGLW73wU91vZ94ai/Ol8RCs21NeMA4+umq7WTZLv60aALwT374kLQqAyj
	BcZNbgVasZGCp886nqiBa2Xtc//dyLT+Zyg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a29uham8k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 06:08:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a27d7b0195so8776970b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 23:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761631693; x=1762236493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFQernyphzUokXIV/+I70uHICPm/RP+xKMym6taPSU8=;
        b=lOVzG6haxqBXyePEhVj/ZkDVQUNk9oxJ999q6mGphqMFz/fJpN1J5Go3EoaYYDXub2
         sLMV5pK2+7TPWjUfwY2AwZ8quFsS44GoDgL7tLU33aPhBR4ouIB3y26Nx3Z98jXJH4Me
         tLS13tBnJYvxH8/MP0Ob7S99VG7NIiNZJ69TOer52sYLD61043LgLmYGNuAYUB5U4R2t
         j7YxE3RKDuaL6wHNkoToJIZtRzTL0qPcfkXzwzaPlvHf1QslMRflAPJjpp/VcJhN83HN
         De7RurQAmsUYH8jNefdzJa4Gi3RCRYc8hxVoTBgmD7ijhQRdnpmTKK5vubPD+aRy4j+X
         jzpA==
X-Forwarded-Encrypted: i=1; AJvYcCUxDDQLMYhWXzdLG+8RF9ZnRz+1lxGTrs6NrPRZBwG4jq0Ch68HWI6tFUVVqkuVrgZGj5Q+w28aYVRdokFuJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuyOMbxCt4+K0KhUx2NXJGbITDSBX3A/EspujVdkGPmfQ/Z/Zi
	bjA9e3sxsFFphafKCAuNAe7LHZBAfQKOn0Y1T4+KjWFrj/8sGGkK4tMZcl2NVUt/8rE3LqNVF+c
	aVoreIjYrZ8G7e0VLdeX6/NOv7wO5hG4PhN0cBlsPpk5jQrLlx3z7ho5VviZ0pbYoZjx7dCP6OT
	qNt2cfI5U=
X-Gm-Gg: ASbGncs9sea0JVtbFgzcOsDkHdxxeqCk/bBktzuICcsRIQf/5mBsG1yWXabXaReoXUb
	I362/FjmbwYNUl/PffcmvJtEQ1UklTqzgFIOzEyJXg28H2lyinAddf/WTebb4ub76CSV9PiGroH
	ZG1Il0RSw4PKfQdvezUvq1Ow8LCSe2tNtWTfbmfkrRM3TUAc+2ks7n+8EfIYR1PgcbHRBnbhtw7
	TX7oFU+FTZLBD5ZrlrdlpjvGpaEmL4BiSjcKcu8pl5LcEaR/r9S01LUtmOsIMTI28wPNEOHjZ//
	0hTRnv8d/xdnXnUNwiyS6oT83kBaidcM6W6GpW8ddNAtBhJ9kFymIhzw4Jb1IwFOiVKQ+kSNimq
	vm1G29qs5IYNEfrHGOJQ2VLZxs+gRJcdVxXWmCiMJZw/MDo7BKSXiJ86lxQ==
X-Received: by 2002:a05:6a00:9281:b0:7a2:721b:adb6 with SMTP id d2e1a72fcca58-7a441c47627mr3120285b3a.28.1761631692847;
        Mon, 27 Oct 2025 23:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5IdZmG+yfCiDsulIMrTHpgRc/xNK0DVqnVio5NHUD8R1SXXmWIe+eXbbrig1qqDs8Z+/EJA==
X-Received: by 2002:a05:6a00:9281:b0:7a2:721b:adb6 with SMTP id d2e1a72fcca58-7a441c47627mr3120253b3a.28.1761631692335;
        Mon, 27 Oct 2025 23:08:12 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414011acdsm10204566b3a.13.2025.10.27.23.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:08:11 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Ross Brown <true.robot.ross@gmail.com>
Subject: [PATCH ath-current] Revert "wifi: ath12k: Fix missing station power save configuration"
Date: Tue, 28 Oct 2025 14:07:44 +0800
Message-Id: <20251028060744.897198-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: o7W694ohT40Nbc6_-s_AU7lpAvnaqzrC
X-Proofpoint-GUID: o7W694ohT40Nbc6_-s_AU7lpAvnaqzrC
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=69005dcd cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=rFrEXt6fRIhDJ_V8PpwA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA1MSBTYWx0ZWRfXzRUhR958qQCy
 CjpUuHjQKP3KUPvCoo84tK/wqCVmhnyXe/URgv1NYg+krus2Ic0Y3Qug67pRhVX7FNCYg72pemA
 F+wOWr/XDenfesjqWeSjkPyF7PnNectTT+I8tTFCcZxrn+GszgPueNa2N/P9T0YLahP5LOhd3qL
 WEv0aNFAmunW0ofwTAnkUFL2bqmOsuzwZpTUQvrrYnGXBEropQcx8Txa34Y9gvRyv8imVcCyWNf
 G51iiua6b7LVCIaGeavf0c+LZYR0ZmIKXImwKgz8UzxYiv6rsbJ/TZhqmW0JyHeFy110v46YHNi
 JPhAS64xboPfziSODXvBc+es1rfRFuzxZ3RFNabDGsZOwAEqzw5eZWWQ87tSoZiAEPoi9eOHJzC
 LP6G69cyq15s9s2I2Rg9dPYMAxrlwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280051

This reverts commit 4b66d18918f8e4d85e51974a9e3ce9abad5c7c3d.

In [1], Ross Brown reports poor performance of WCN7850 after enabling
power save. Temporarily revert the fix; it will be re-enabled once
the issue is resolved.

Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Fixes: 4b66d18918f8 ("wifi: ath12k: Fix missing station power save configuration")
Reported-by: Ross Brown <true.robot.ross@gmail.com>
Closes: https://lore.kernel.org/all/CAMn66qZENLhDOcVJuwUZ3ir89PVtVnQRq9DkV5xjJn1p6BKB9w@mail.gmail.com/ # [1]
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 122 ++++++++++++--------------
 1 file changed, 55 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index eacab798630a..db351c922018 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4064,68 +4064,12 @@ static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
 	return ret;
 }
 
-static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
-{
-	struct ath12k *ar = arvif->ar;
-	struct ieee80211_vif *vif = arvif->ahvif->vif;
-	struct ieee80211_conf *conf = &ath12k_ar_to_hw(ar)->conf;
-	enum wmi_sta_powersave_param param;
-	struct ieee80211_bss_conf *info;
-	enum wmi_sta_ps_mode psmode;
-	int ret;
-	int timeout;
-	bool enable_ps;
-
-	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
-
-	if (vif->type != NL80211_IFTYPE_STATION)
-		return;
-
-	enable_ps = arvif->ahvif->ps;
-	if (enable_ps) {
-		psmode = WMI_STA_PS_MODE_ENABLED;
-		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
-
-		timeout = conf->dynamic_ps_timeout;
-		if (timeout == 0) {
-			info = ath12k_mac_get_link_bss_conf(arvif);
-			if (!info) {
-				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
-					    vif->addr, arvif->link_id);
-				return;
-			}
-
-			/* firmware doesn't like 0 */
-			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
-		}
-
-		ret = ath12k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
-						  timeout);
-		if (ret) {
-			ath12k_warn(ar->ab, "failed to set inactivity time for vdev %d: %i\n",
-				    arvif->vdev_id, ret);
-			return;
-		}
-	} else {
-		psmode = WMI_STA_PS_MODE_DISABLED;
-	}
-
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
-		   arvif->vdev_id, psmode ? "enable" : "disable");
-
-	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
-	if (ret)
-		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
-			    psmode, arvif->vdev_id, ret);
-}
-
 static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 					  struct ieee80211_vif *vif,
 					  u64 changed)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	unsigned long links = ahvif->links_map;
-	struct ieee80211_vif_cfg *vif_cfg;
 	struct ieee80211_bss_conf *info;
 	struct ath12k_link_vif *arvif;
 	struct ieee80211_sta *sta;
@@ -4189,24 +4133,61 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 			}
 		}
 	}
+}
 
-	if (changed & BSS_CHANGED_PS) {
-		links = ahvif->links_map;
-		vif_cfg = &vif->cfg;
+static void ath12k_mac_vif_setup_ps(struct ath12k_link_vif *arvif)
+{
+	struct ath12k *ar = arvif->ar;
+	struct ieee80211_vif *vif = arvif->ahvif->vif;
+	struct ieee80211_conf *conf = &ath12k_ar_to_hw(ar)->conf;
+	enum wmi_sta_powersave_param param;
+	struct ieee80211_bss_conf *info;
+	enum wmi_sta_ps_mode psmode;
+	int ret;
+	int timeout;
+	bool enable_ps;
 
-		for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
-			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
-			if (!arvif || !arvif->ar)
-				continue;
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-			ar = arvif->ar;
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	enable_ps = arvif->ahvif->ps;
+	if (enable_ps) {
+		psmode = WMI_STA_PS_MODE_ENABLED;
+		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
 
-			if (ar->ab->hw_params->supports_sta_ps) {
-				ahvif->ps = vif_cfg->ps;
-				ath12k_mac_vif_setup_ps(arvif);
+		timeout = conf->dynamic_ps_timeout;
+		if (timeout == 0) {
+			info = ath12k_mac_get_link_bss_conf(arvif);
+			if (!info) {
+				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
+					    vif->addr, arvif->link_id);
+				return;
 			}
+
+			/* firmware doesn't like 0 */
+			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
 		}
+
+		ret = ath12k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
+						  timeout);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set inactivity time for vdev %d: %i\n",
+				    arvif->vdev_id, ret);
+			return;
+		}
+	} else {
+		psmode = WMI_STA_PS_MODE_DISABLED;
 	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
+		   arvif->vdev_id, psmode ? "enable" : "disable");
+
+	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
+	if (ret)
+		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
+			    psmode, arvif->vdev_id, ret);
 }
 
 static bool ath12k_mac_supports_tpc(struct ath12k *ar, struct ath12k_vif *ahvif,
@@ -4228,6 +4209,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
+	struct ieee80211_vif_cfg *vif_cfg = &vif->cfg;
 	struct cfg80211_chan_def def;
 	u32 param_id, param_value;
 	enum nl80211_band band;
@@ -4514,6 +4496,12 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	}
 
 	ath12k_mac_fils_discovery(arvif, info);
+
+	if (changed & BSS_CHANGED_PS &&
+	    ar->ab->hw_params->supports_sta_ps) {
+		ahvif->ps = vif_cfg->ps;
+		ath12k_mac_vif_setup_ps(arvif);
+	}
 }
 
 static struct ath12k_vif_cache *ath12k_ahvif_get_link_cache(struct ath12k_vif *ahvif,

base-commit: 2469bb6a6af944755a7d7daf66be90f3b8decbf9
-- 
2.34.1


