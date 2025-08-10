Return-Path: <linux-wireless+bounces-26234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB9FB1FB3B
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Aug 2025 19:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E467F3B0BBE
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Aug 2025 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAAC2727F3;
	Sun, 10 Aug 2025 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A4OFE8Rl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073623BD01
	for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754845331; cv=none; b=HpROZXo3Cy2nHdCHAIlbnJu1k+047hpU7LUYBIfjZW9Jre88qQIqsHDEzFikeD8sMT6MzixWvKifiBsObjzA0Zwm7pMkzQetOE36BOoftcmTKlV6KaKVmyXzeBJ0O0Db2+X9x6UQk9433G1tEZzdQ67OwfwmqnTyI/B9k4YprIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754845331; c=relaxed/simple;
	bh=v/GsagvZjNTe1Kg9L0CkDs64exxXA4yBS5CiLrZaR4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M1c9ZJSWiX2s4nSCIuDVyqpgHXLnfNZOhQuS74r3FaW9fdTjwaHQ6I2Gzg+j1yb/j+n4HSmoLOUv2RQ22KEIAfUONUHjEgOrhN5VupWOJe4RQry/PzpbKgSEwkkwoeE5hQJ0cnD2M0OG/Qvz3j6sDHWwfiUa/utIx57T7MenC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A4OFE8Rl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57AFj93R001156
	for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 17:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4h9YmX5bgFUDWuxv9D4v9M
	gWHuFFtxtGCWyNUkSBTPk=; b=A4OFE8RlZeA8/dm/FORXYENTD9xGn+LHHtvGzu
	y4Nu8v3C2ZF/968+QuJr7ne725yjpGqG/h9XDH7968Sfqn5ch7EQIU5ru3Gnpc4g
	HQ2HEibuJA+ILgI3k/Vfxv899gFWqIejtro+WOnf4f+NHJfOis9gQmumLuiTicz9
	VSRCHvtd3hGYihxSIlAdmYAgofu9pPThiuIOt73FiZILaVvBiw7i6GHcgz2PE1bA
	RTCADUrLHnL9vy34HQooHk0v5vmICx9x3W8d7hva0Q3MaPTkcAegaHsesetgvuPY
	4BktiwiGGb8tb8nfeDxfaUmm/RWe9i2Cwj1GJcuVaXC6o0UQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dwb729ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 17:02:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2400b28296fso59808075ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 10:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754845326; x=1755450126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4h9YmX5bgFUDWuxv9D4v9MgWHuFFtxtGCWyNUkSBTPk=;
        b=ARUhIhmt/aHgG1iDPxR2qyTi0mzAtSmBdhxwB/3IIdddoI85Aq5MGYTXex064H8kS8
         81cdsB86/2tfCYlUbVP5k7p7DM+HPWwqWdLiXTMbdDP2baldLlBejcCK8jim+7cC9GOU
         joI9dF8SUFgpbr95ge7cEkt8YVr56Arr3/S8fDJ441LqIOJLx9/+UryYkaBI34RrtXwo
         gXI6jq3NFhF0UL1dGV7mAHTIhhAK5M8aEdhWFQTBLWjkIBsrxDLaMIFmI91hwzEHcNf+
         NIiVxDPf0AGy4XkIpY4lqYo2d9UQuTL1g9eaa74HrFFiBUBPhKDsdxnq14T5H2dkx2/h
         CU9g==
X-Gm-Message-State: AOJu0YzOPkiz1WBUpZuiS4f+eyEQ1OM0yAZVEK3gdYu+hQJzZDHxxwKD
	mJNIooWtirujbICKq8DzGGzX5Th2Wv2IIk1ZCGmb90Ww4PPWwZTvNXm1VSoh94Y0bu6o69i784g
	IzsH6HaYDpQD06371bqcoVisFR6Kg0QuloMDskL+qFHZ44tq/huuqxl0wWrmSexpXlxXze43iGY
	zQxA==
X-Gm-Gg: ASbGncvXjafG90fzG8G+QV7bsQBqA0u1LLM+p/das+N1eZ0RPMym5ckAEOUfPLY7jja
	kCs8NhE7TC8Hxg6eFiZrOk2bl+7vENugp3oc6nYoYbOz9LrcfSFFI7N8ZbP11pKZ6IUTPrEZ1UF
	XSAW/nuowQSpFXkIdoOpoQdc0mP9Fr19hEA68cXeyPGXCebIIYQgYDIF1jF7Yv4s8We5ysinBbS
	hCwPAHwcWT0Kb4Tt9/UOPirdUOVGJXPY9qMdI5FOhBgm5mOUGLu/mXjQ3WIR9GUCKnyj6ghOJi6
	o4M/sFBM4cGZTTPuEXUqwA4W54u0jf4mBVPoYg2U34RTm5ctWa+wo7ebMc+b0ZD8/W87qspI2fR
	xsgOhbowmqpYMULx0i9M+JsWx8Pxd5j41DT7U7ooWpxlNPv8ldc3AEAxWts9tDzVVuWZ/
X-Received: by 2002:a17:902:d50e:b0:242:9bbc:6017 with SMTP id d9443c01a7336-242c2276a77mr122282245ad.55.1754845326332;
        Sun, 10 Aug 2025 10:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeAHYDlK+Vq16Kaq0mArhH6pVAbOI3w8Aa7zAQNc40O+t/8yYGN3RmPW2Vjcx2TvpxKJ2Szg==
X-Received: by 2002:a17:902:d50e:b0:242:9bbc:6017 with SMTP id d9443c01a7336-242c2276a77mr122281745ad.55.1754845325529;
        Sun, 10 Aug 2025 10:02:05 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef67e8sm255072665ad.8.2025.08.10.10.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 10:02:05 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Steffen Moser <lists@steffen-moser.de>
Subject: [PATCH ath-current v4] wifi: ath11k: fix group data packet drops during rekey
Date: Sun, 10 Aug 2025 22:30:18 +0530
Message-Id: <20250810170018.1124014-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K6oiHzWI c=1 sm=1 tr=0 ts=6898d08f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=SPZcrJulSsLfHTziI8sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: -v81R_iTp_7Nvn0KMJOUgVAL0WmYg1Tk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxMyBTYWx0ZWRfX3N2r7EiNnoHF
 ix6O+/bUEriy2YyOJAWRbc+cBeHQOOy0DQqEDBoqTMQA5PyFvbzw3/ruGvm5F9VC1m4k6M0ZXOp
 xmwsqIobshsVi2bCoPl+Yaeu6t5ycoV7MI7hzCcBCaqUuWsTmru44/UYIe3zyzX7K5PkQSFp6ck
 w0QNTv74z80l8fecWJJ163zthmrjfmXwA/rCjaz5TR+idwH/EY0glWphM1cZGiQe29jHU2wGyag
 pzyOGMAV+g8rDsGANB9UOKELRyv0gDcBso+bmCF6GY6/dXeDtQhwhYEJPbbLbA96iFqLGcIhTqW
 D1ECOwFXBIAEUX+CyqarseIrDOTbZ8p+CnUz7+2GF9NxqVxjLZmJc23GdiCl7K0pH8pJGlChLh2
 DgKbZ2/l
X-Proofpoint-ORIG-GUID: -v81R_iTp_7Nvn0KMJOUgVAL0WmYg1Tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090013

During GTK rekey, mac80211 issues a clear key (if the old key exists)
followed by an install key operation in the same context. This causes
ath11k to send two WMI commands in quick succession: one to clear the
old key and another to install the new key in the same slot.

Under certain conditions—especially under high load or time sensitive
scenarios, firmware may process these commands asynchronously in a way
that firmware assumes the key is cleared whereas hardware has a valid key.
This inconsistency between hardware and firmware leads to group addressed
packet drops. Only setting the same key again can restore a valid key in
firmware and allow packets to be transmitted.

This issue remained latent because the host's clear key commands were
not effective in firmware until commit 436a4e886598 ("ath11k: clear the
keys properly via DISABLE_KEY"). That commit enabled the host to
explicitly clear group keys, which inadvertently exposed the race.

To mitigate this, restrict group key clearing across all modes (AP, STA,
MESH). During rekey, the new key can simply be set on top of the previous
one, avoiding the need for a clear followed by a set.

However, in AP mode specifically, permit group key clearing when no
stations are associated. This exception supports transitions from secure
modes (e.g., WPA2/WPA3) to open mode, during which all associated peers
are removed and the group key is cleared as part of the transition.

Add a per-BSS station counter to track the presence of stations during
set key operations. Also add a reset_group_keys flag to track the key
re-installation state and avoid repeated installation of the same key
when the number of connected stations transitions to non-zero within a
rekey period.

Additionally, for AP and Mesh modes, when the first station associates,
reinstall the same group key that was last set. This ensures that the
firmware recovers from any race that may have occurred during a previous
key clear when no stations were associated.

This change ensures that key clearing is permitted only when no clients
are connected, avoiding packet loss while enabling dynamic security mode
transitions.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Reported-by: Steffen Moser <lists@steffen-moser.de>
Closes: https://lore.kernel.org/linux-wireless/c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de
Fixes: 436a4e886598 ("ath11k: clear the keys properly via DISABLE_KEY")
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
v4:
  - updated branch tag, CC'ed Reporter and linux-wireless
  - Removed internal version history details.
v3:
  - first public version (should have been v1)
v1 & v2:
  - Internal review versions
---
 drivers/net/wireless/ath/ath11k/core.h |   2 +
 drivers/net/wireless/ath/ath11k/mac.c  | 111 +++++++++++++++++++++++--
 2 files changed, 104 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 220d69a7a429..e8780b05ce11 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -411,6 +411,8 @@ struct ath11k_vif {
 	bool do_not_send_tmpl;
 	struct ath11k_arp_ns_offload arp_ns_offload;
 	struct ath11k_rekey_data rekey_data;
+	u32 num_stations;
+	bool reinstall_group_keys;
 
 	struct ath11k_reg_tpc_power_info reg_tpc_info;
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1fadf5faafb8..106e2530b64e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4317,6 +4317,40 @@ static int ath11k_clear_peer_keys(struct ath11k_vif *arvif,
 	return first_errno;
 }
 
+static int ath11k_set_group_keys(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ath11k_base *ab = ar->ab;
+	const u8 *addr = arvif->bssid;
+	int i, ret, first_errno = 0;
+	struct ath11k_peer *peer;
+
+	spin_lock_bh(&ab->base_lock);
+	peer = ath11k_peer_find(ab, arvif->vdev_id, addr);
+	spin_unlock_bh(&ab->base_lock);
+
+	if (!peer)
+		return -ENOENT;
+
+	for (i = 0; i < ARRAY_SIZE(peer->keys); i++) {
+		struct ieee80211_key_conf *key = peer->keys[i];
+
+		if (!key || (key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+			continue;
+
+		ret = ath11k_install_key(arvif, key, SET_KEY, addr,
+					 WMI_KEY_GROUP);
+		if (ret < 0 && first_errno == 0)
+			first_errno = ret;
+
+		if (ret < 0)
+			ath11k_warn(ab, "failed to set group key of idx %d for vdev %d: %d\n",
+				    i, arvif->vdev_id, ret);
+	}
+
+	return first_errno;
+}
+
 static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 				 struct ieee80211_key_conf *key)
@@ -4326,6 +4360,7 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_peer *peer;
 	struct ath11k_sta *arsta;
+	bool is_ap_with_no_sta;
 	const u8 *peer_addr;
 	int ret = 0;
 	u32 flags = 0;
@@ -4386,16 +4421,57 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	else
 		flags |= WMI_KEY_GROUP;
 
-	ret = ath11k_install_key(arvif, key, cmd, peer_addr, flags);
-	if (ret) {
-		ath11k_warn(ab, "ath11k_install_key failed (%d)\n", ret);
-		goto exit;
-	}
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+		   "%s for peer %pM on vdev %d flags 0x%X, type = %d, num_sta %d\n",
+		   cmd == SET_KEY ? "SET_KEY" : "DEL_KEY", peer_addr, arvif->vdev_id,
+		   flags, arvif->vdev_type, arvif->num_stations);
+
+	/* Allow group key clearing only in AP mode when no stations are
+	 * associated. There is a known race condition in firmware where
+	 * group addressed packets may be dropped if the key is cleared
+	 * and immediately set again during rekey.
+	 *
+	 * During GTK rekey, mac80211 issues a clear key (if the old key
+	 * exists) followed by an install key operation for same key
+	 * index. This causes ath11k to send two WMI commands in quick
+	 * succession: one to clear the old key and another to install the
+	 * new key in the same slot.
+	 *
+	 * Under certain conditions—especially under high load or time
+	 * sensitive scenarios, firmware may process these commands
+	 * asynchronously in a way that firmware assumes the key is
+	 * cleared whereas hardware has a valid key. This inconsistency
+	 * between hardware and firmware leads to group addressed packet
+	 * drops after rekey.
+	 * Only setting the same key again can restore a valid key in
+	 * firmware and allow packets to be transmitted.
+	 *
+	 * There is a use case where an AP can transition from Secure mode
+	 * to open mode without a vdev restart by just deleting all
+	 * associated peers and clearing key, Hence allow clear key for
+	 * that case alone. Mark arvif->reinstall_group_keys in such cases
+	 * and reinstall the same key when the first peer is added,
+	 * allowing firmware to recover from the race if it had occurred.
+	 */
 
-	ret = ath11k_dp_peer_rx_pn_replay_config(arvif, peer_addr, cmd, key);
-	if (ret) {
-		ath11k_warn(ab, "failed to offload PN replay detection %d\n", ret);
-		goto exit;
+	is_ap_with_no_sta = (vif->type == NL80211_IFTYPE_AP &&
+			     !arvif->num_stations);
+	if ((flags & WMI_KEY_PAIRWISE) || cmd == SET_KEY || is_ap_with_no_sta) {
+		ret = ath11k_install_key(arvif, key, cmd, peer_addr, flags);
+		if (ret) {
+			ath11k_warn(ab, "ath11k_install_key failed (%d)\n", ret);
+			goto exit;
+		}
+
+		ret = ath11k_dp_peer_rx_pn_replay_config(arvif, peer_addr, cmd, key);
+		if (ret) {
+			ath11k_warn(ab, "failed to offload PN replay detection %d\n",
+				    ret);
+			goto exit;
+		}
+
+		if ((flags & WMI_KEY_GROUP) && cmd == SET_KEY && is_ap_with_no_sta)
+			arvif->reinstall_group_keys = true;
 	}
 
 	spin_lock_bh(&ab->base_lock);
@@ -4994,6 +5070,7 @@ static int ath11k_mac_inc_num_stations(struct ath11k_vif *arvif,
 		return -ENOBUFS;
 
 	ar->num_stations++;
+	arvif->num_stations++;
 
 	return 0;
 }
@@ -5009,6 +5086,7 @@ static void ath11k_mac_dec_num_stations(struct ath11k_vif *arvif,
 		return;
 
 	ar->num_stations--;
+	arvif->num_stations--;
 }
 
 static u32 ath11k_mac_ieee80211_sta_bw_to_wmi(struct ath11k *ar,
@@ -9540,6 +9618,21 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 		goto exit;
 	}
 
+	/* Driver allows the DEL KEY followed by SET KEY sequence for
+	 * group keys for only when there is no clients associated, if at
+	 * all firmware has entered the race during that window,
+	 * reinstalling the same key when the first sta connects will allow
+	 * firmware to recover from the race.
+	 */
+	if (arvif->num_stations == 1 && arvif->reinstall_group_keys) {
+		ath11k_dbg(ab, ATH11K_DBG_MAC, "set group keys on 1st station add for vdev %d\n",
+			   arvif->vdev_id);
+		ret = ath11k_set_group_keys(arvif);
+		if (ret)
+			goto dec_num_station;
+		arvif->reinstall_group_keys = false;
+	}
+
 	arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
 	if (!arsta->rx_stats) {
 		ret = -ENOMEM;

base-commit: 95bf875b89b48a95a82aca922eeaf19d52543028
-- 
2.34.1


