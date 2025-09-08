Return-Path: <linux-wireless+bounces-27069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D705B48247
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 03:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4040D7AC675
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFBA199931;
	Mon,  8 Sep 2025 01:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="niZo6xw0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F462146593
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 01:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296250; cv=none; b=A+AuAaOj2Uw1a5ZthOja8mOhLFhjl4cD3UZQnBT8qaCpf0CdqPneVIz1UTvq36SkODeC9A8sKhfKmQ/MyY+wdZ8OeUwveZNMbHdSzkfNK496TtpelrdCfGz9/RTobmSxLvYxHoOvYTydcXaNR6Aoiolix3s/LROawGKooixGm40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296250; c=relaxed/simple;
	bh=Oor7BlvjUAlk/PY2KVf4xP3BW6CINKyVy3+/76T/Ygo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CntWaCC8SrBGjqtUJVfzqKtm7YpIChfpEtt73WbYxsxVeHb2kSwhXkouF2CW9lqBWdMwPWPkQ2BH59/fZ8/Ni5aYBCOSnRszZQHs3pUPZWCflO7nNqZPduTVTqtzbPu0NO6xiaEv0fNTWu3bx3TRBc64Bb7VdceQhvoZGT1ETgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=niZo6xw0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587NQJJ4007203
	for <linux-wireless@vger.kernel.org>; Mon, 8 Sep 2025 01:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tuSiT6IHKC8eyHl1HYGERUP1bY+x7+xWSlh
	+LrRLgK4=; b=niZo6xw0r3VTz3xU4co+n4AKQ8v8ypE+hhtXlSbtess9LT0yvof
	tWubFj4w6dUZ7xXIYAQwyN28VTuYxsP4x1a5uvG6ADY0g2lH5BmUahYEsjp3CIQ/
	pN3I7VwmC/Q5o9SnioXYcZ9uBL9D0eU9u20BnSTjM31skMIwzre0PqUVP+cMsIeB
	pt/Ra6acb676xPc4wH3jnObwm2FXVTr5MurHJ9lgkbWItiH07gF3GQIYAp2HGKfq
	JueX1BmCEfZhum6D7z6sHx/rxs74NtF4g6KWD1JXV+X2ZPSpNgHyC46kFa53dhq2
	lKikHAuF5KGtJLq3FZz/S394K+sM+xQg0qg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d63avbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Sep 2025 01:50:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244570600a1so48393585ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 07 Sep 2025 18:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757296246; x=1757901046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuSiT6IHKC8eyHl1HYGERUP1bY+x7+xWSlh+LrRLgK4=;
        b=Oe0iOzqKdFHym17HhSyyBUlnfRCoFdswxmibDeom0ZXRKsSZBxBauZ5TawB55b9slo
         EBAV5MdQftqrzf3u1vF08YgowXoYGtdiGXjCNxOlaABzzcob9k2izmqsNexnPuq+y7op
         8YyogfHcjzPjc/QLjIW/iCQUhi1xFMW01ZjAOW2AGS87zjSh6tyqSdxcR+NwJo2q6ZRJ
         rMjAF4RjNUlYrJaZBFtmPgxBMpaTksA5sofDRwAKdJ/SGsOuroTsl29oZdTZBBXPGEir
         y6iAwd33c2dHhmZlLOfWzPJIYuti/psXIRzV1R0+76ONxFmZA9Oix4YKnINSXwKqJUEl
         a5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWUztXzUnK/tXD1Q1vSKcoYYLgv/kR/WBuoKIv4CRGgzMjmE4MkMUIAmTDV1Z8twB1f6JAIJT77GMT7A8JB5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIN7XX0sUWqElCs7yffion6/DruaX0d2ljqfArIBER1hGfgotF
	pl1wJZJ1IIUQfdoK9ygcVK8AFYS7JlZ9o/MysQBmDGxaIl/fbzKMTpqzH/ST7YIO6MVLEkRFYBP
	m+xp5Uij7VHs23bfXvpaVEGLpqb2WHzv7OwkxOyMai9wOcx9rJ9QimntWrrhY34iZH7yjrg==
X-Gm-Gg: ASbGncty5ekzMmamz5FqG3+tjHw6dmEFu/9VCjd0B19G7IkBwULKQHxJ1yhNgosA8fL
	vkoym4vM6IRHSzdXKzYQi+Dns3AQdHHk8BLDDPs+Vl5ciRL7dGdUOR7H5DtZ2eeDsGpkXK2DH1d
	r0HI6kufoUcCW0SP7N511wZ+vbR5Rw04d5cKLq96elZieg4lFqcQ+j5FMho2AeYgRWjhZjHsnWO
	rwVYoIqoirbC4F4racspCPLN5ifmmlD2tKVbuTfkoaNR23ttFt6W2hyxKUUPG+njxZFF8GEI6S4
	OBvPaYbdToLEbFpHIzndlMyHtDhgR0/if6KB6J60T2I6BaTrJ1Cn7JQJ8LLv2sogInC25qVo8G/
	FSVxhfS2llV/2NMOsWAB/2nw=
X-Received: by 2002:a17:902:d4ce:b0:246:571:4b51 with SMTP id d9443c01a7336-2517a7dc8d1mr88578925ad.29.1757296246222;
        Sun, 07 Sep 2025 18:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/66tg8rllQbakUBONUB+tBZD9yFBmoJbh2aMvQlKw0BACgvAH43//KwIRgdKS5/R/InyMbg==
X-Received: by 2002:a17:902:d4ce:b0:246:571:4b51 with SMTP id d9443c01a7336-2517a7dc8d1mr88578715ad.29.1757296245655;
        Sun, 07 Sep 2025 18:50:45 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2527e7a49a2sm41861815ad.14.2025.09.07.18.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:50:45 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-current] wifi: ath12k: Fix missing station power save configuration
Date: Mon,  8 Sep 2025 09:50:25 +0800
Message-Id: <20250908015025.1301398-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyOSBTYWx0ZWRfX8afoVrriFGp0
 CgUAwdgf7VMfwcI0CjkfzghnQw5UzUeVH3KQze7pwsj3A7vxlPJQ2fbj14PEBtPDhlNYSht/GT+
 jpvj1mDp65nI3V4BS4ui/H7A42U375IB4ShiZTOiqv0o606RtpEByPuRbBoQOtXhu0CIWiY0yRL
 /Nv7sE/bjPflKAEAWvpbwVC4I317WFWy8wBwzlihsXj9CyKlt6FGRwsQLN/nqp3YXgYK7j0KT5Z
 V/EByY6cO/51nYu0tuvseiYzQmYvtD8AX0pN9aoxOu0R2sC/0Lt6p8V86QfPTReBh+fscENbZl7
 FKc7L1llavLTEd9NI7d5MgLqw42utPKb22JmlZxJmxTi/ernvh/UtXlBCvhCYtBRUQZ6uoG4sya
 61Ya0QNv
X-Proofpoint-GUID: nJ82_yG15OFuD64NfD_6csTcZN8X6gLE
X-Proofpoint-ORIG-GUID: nJ82_yG15OFuD64NfD_6csTcZN8X6gLE
X-Authority-Analysis: v=2.4 cv=DYgXqutW c=1 sm=1 tr=0 ts=68be3677 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=L_1LzjPufVM5mkcSVOQA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060029

Commit afbab6e4e88d ("wifi: ath12k: modify ath12k_mac_op_bss_info_changed()
for MLO") replaced the bss_info_changed() callback with vif_cfg_changed()
and link_info_changed() to support Multi-Link Operation (MLO). As a result,
the station power save configuration is no longer correctly applied in
ath12k_mac_bss_info_changed().

Move the handling of 'BSS_CHANGED_PS' into ath12k_mac_op_vif_cfg_changed()
to align with the updated callback structure introduced for MLO, ensuring
proper power-save behavior for station interfaces.

Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Fixes: afbab6e4e88d ("wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO")
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 122 ++++++++++++++------------
 1 file changed, 67 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index bd1ec3b2c084..3a3965b79942 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4078,12 +4078,68 @@ static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
 	return ret;
 }
 
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
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	enable_ps = arvif->ahvif->ps;
+	if (enable_ps) {
+		psmode = WMI_STA_PS_MODE_ENABLED;
+		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
+
+		timeout = conf->dynamic_ps_timeout;
+		if (timeout == 0) {
+			info = ath12k_mac_get_link_bss_conf(arvif);
+			if (!info) {
+				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
+					    vif->addr, arvif->link_id);
+				return;
+			}
+
+			/* firmware doesn't like 0 */
+			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
+		}
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
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
+		   arvif->vdev_id, psmode ? "enable" : "disable");
+
+	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
+	if (ret)
+		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
+			    psmode, arvif->vdev_id, ret);
+}
+
 static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 					  struct ieee80211_vif *vif,
 					  u64 changed)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	unsigned long links = ahvif->links_map;
+	struct ieee80211_vif_cfg *vif_cfg;
 	struct ieee80211_bss_conf *info;
 	struct ath12k_link_vif *arvif;
 	struct ieee80211_sta *sta;
@@ -4147,61 +4203,24 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 			}
 		}
 	}
-}
-
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
 
-	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+	if (changed & BSS_CHANGED_PS) {
+		links = ahvif->links_map;
+		vif_cfg = &vif->cfg;
 
-	if (vif->type != NL80211_IFTYPE_STATION)
-		return;
+		for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+			if (!arvif || !arvif->ar)
+				continue;
 
-	enable_ps = arvif->ahvif->ps;
-	if (enable_ps) {
-		psmode = WMI_STA_PS_MODE_ENABLED;
-		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
+			ar = arvif->ar;
 
-		timeout = conf->dynamic_ps_timeout;
-		if (timeout == 0) {
-			info = ath12k_mac_get_link_bss_conf(arvif);
-			if (!info) {
-				ath12k_warn(ar->ab, "unable to access bss link conf in setup ps for vif %pM link %u\n",
-					    vif->addr, arvif->link_id);
-				return;
+			if (ar->ab->hw_params->supports_sta_ps) {
+				ahvif->ps = vif_cfg->ps;
+				ath12k_mac_vif_setup_ps(arvif);
 			}
-
-			/* firmware doesn't like 0 */
-			timeout = ieee80211_tu_to_usec(info->beacon_int) / 1000;
 		}
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
 	}
-
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
-		   arvif->vdev_id, psmode ? "enable" : "disable");
-
-	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
-	if (ret)
-		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
-			    psmode, arvif->vdev_id, ret);
 }
 
 static bool ath12k_mac_supports_tpc(struct ath12k *ar, struct ath12k_vif *ahvif,
@@ -4223,7 +4242,6 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
-	struct ieee80211_vif_cfg *vif_cfg = &vif->cfg;
 	struct cfg80211_chan_def def;
 	u32 param_id, param_value;
 	enum nl80211_band band;
@@ -4510,12 +4528,6 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	}
 
 	ath12k_mac_fils_discovery(arvif, info);
-
-	if (changed & BSS_CHANGED_PS &&
-	    ar->ab->hw_params->supports_sta_ps) {
-		ahvif->ps = vif_cfg->ps;
-		ath12k_mac_vif_setup_ps(arvif);
-	}
 }
 
 static struct ath12k_vif_cache *ath12k_ahvif_get_link_cache(struct ath12k_vif *ahvif,

base-commit: 27893dd6341b929f87d45fc4d65c5778179319dd
-- 
2.34.1


