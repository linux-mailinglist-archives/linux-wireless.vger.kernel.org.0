Return-Path: <linux-wireless+bounces-26308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C74B225AF
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 13:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4ECC16D25A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F20578F5D;
	Tue, 12 Aug 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fgL4vRrD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821CF2ED160
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997448; cv=none; b=Cj4Xs6KqNKPELcvpn8Okczue8AvHVwrN/nnqww0kB3weBHiDZVry8ml/i3ZWXC/JSm2zX4ysDc3JE4eET2mDO6Kkyh5rLfKh9FtPU8jaRmCaJgnX+bhbDzVd0XyueI0kM7KCV+FtjtX8OM6LJM3rGB3loQycPMPiOhglZ2UCLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997448; c=relaxed/simple;
	bh=Ga++0E5uYbf2uAxkD3XSy/v2Rcpf07fYZSDNi7k5hYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HbcnlzB1hsjJ4lg3WSZ9IsBQIMjT+M8Osno0CDhMLdXcCVWZ4EOmexAXGi1hbNjkg7jp60sUBxg3yQe7cRAxpyzCPb7Qa40FbIK0EyBFbDcNYKZsd+U7xTT4yublZMis/hkKdtcN3/CDNVNOzof1VecPeff9zDEC8se8zzlAWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fgL4vRrD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvaFS017548
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=WBfzaKcYETNsmTx+YH0KMvZNp8T5+9xb8kw2PQKwLdY=; b=fg
	L4vRrDha7S6mxMczkQZkZlodrc976EQtiiA5BpH3QokUn8RKGJZoMhUWWMsXZqg7
	alOJudEOw+42e9q1Kug/+wwPJ8FhePdSn5l/yBGcnxyNSZ/VNyAFTCOM2Q3EKd82
	eM7Uwajpf1fthx57Jrm6Z9zaoeBSiOPU6Bd3Y8RRWeApbnCgtii6ArOc1Moir4vv
	TKCYe1BSsT5GzfAFgMSjzqCPDWOa4yJStz5N2c82yBnf2Va09wzol57hoKY/Q/EV
	utP/NrhyULwpkOWj05/XXqjjE+Ri5e63IOMqevVQxWpDUYiv3MdzlP5qLGl2j+Nt
	+lS5ZC7xxMBRLN0ZBftQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4bw4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 11:17:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24283069a1cso59374295ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 04:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997444; x=1755602244;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBfzaKcYETNsmTx+YH0KMvZNp8T5+9xb8kw2PQKwLdY=;
        b=BwHevarq1OgWiK3yipGC4odPFiMA/bZaTe6fuY2FtO7F4jLk8140cWcY7K+J76E/zv
         WmriEjZ8AfGGk0IHbUU3FVE+GJIR8nTn7e7534lWSj9qaJP9dE+pLyCak6NlXvkfPXoQ
         WeJy0IibSHRQ4emDvBwAtfyvSxmSZr0sBv25MLKK624CEqVOFYFD74GUnFEgTJq67yui
         mew2sPb1bgBUbAZwBOqxZYa+4hs8j7OfutSs0zqXi4+ee7vtcyq6Qr5GFQqlOZu6Ti6f
         /GulcwGuv3hmLus1Qlqe9163xQX8uerlsGrvQA6/dGZnSl/cg2bCKtkpzQ3WnvvQMCCi
         gFug==
X-Gm-Message-State: AOJu0YyM1frVEGTeKYbXTD5VGUXwAfl/Xg0SbyCJhZI3mdrgecWep9g3
	U8lufN05Xe6lQruwU08EP+varzTngrSTgwzuD5Zf7wrwvC6l5MJCGWa0zvWrCrHNl3CtQtQYZQC
	lyjKbsJpqa7zHOl8Ya7NkuHQXg4ex8bCB70C0iy3U2T03TMc9MEVtbU3kGtWkM/PIpy85gw==
X-Gm-Gg: ASbGncsUq3WvNLMvQoWuz2PzxJXoIz7EWIi6wdUazV/r0xqvtUs0u0KVDSJd2sOzebY
	ysWIuxcwmwJTX84s1XUTxtHlhG7FvwUtPCrQ0DspSaU8GLxaeviZzAFQ8QY20Bir0+2waM4czQM
	F9GcpMHTaEfCtjOWPqbEBEPNzbnRumNfLI5g0RDCMHuSJb1/fCP+6/Vhio/xb6E0x18MtDQlKU7
	I/2p45WqlMT/ivhnOrMpfzTicMk3q24ThXbZZ/12veUKyH2HfqCXlCq9cJK0lcmwC33InkU1x/K
	6gf/jBbkNLVasxjF6YRGzA/Uh+meevKG/sIumNCsfTnf5TcvJ6BoJNNLDyVknmsKP/mo5rmAM3g
	EO/SRu3Q=
X-Received: by 2002:a17:902:d48a:b0:240:9cf:99a8 with SMTP id d9443c01a7336-242c1ecbe3fmr212855615ad.11.1754997443913;
        Tue, 12 Aug 2025 04:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6S27eWRBiKQyx4wW9kDYBhDFE3GmPmiB4Q8YGVtRjZ5I/95I+WqjXrDDAkS1J8uup57m4iQ==
X-Received: by 2002:a17:902:d48a:b0:240:9cf:99a8 with SMTP id d9443c01a7336-242c1ecbe3fmr212855225ad.11.1754997443311;
        Tue, 12 Aug 2025 04:17:23 -0700 (PDT)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1ebc1sm296048935ad.67.2025.08.12.04.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:17:23 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH ath-next 3/3] wifi: ath12k: Extend beacon miss handling for MLO non-AP STA
Date: Tue, 12 Aug 2025 16:47:08 +0530
Message-Id: <20250812111708.3686-4-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250812111708.3686-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-GUID: QB08I1hvnb20orFMVI-wr3WgTIXkN4-6
X-Proofpoint-ORIG-GUID: QB08I1hvnb20orFMVI-wr3WgTIXkN4-6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX8JaQfZGiUAfM
 dpaXago9KmiL0K6+im2ZZNOiQ/R+skLDjabcg1XEnQDmb1hYWug/cSBdic9N7Wz9a0MFZ+fvUYU
 HoQOYmqy/c9WLOQKAVwy3/aqOxLVtmozyKf+jEwQ1o0qs5bR1zQ3fY9376arDHJ5rjjUG7H56Np
 hK404PFhKrkqD0XJuAqTDXMS916/MIibuEuKpOQNp/kUn3x1u39IRc3ZdtEI/3UCEDlsAQuaPYO
 vQq3UiuoI5zwfvCAblXB7SQnJ6rbSBT6NLTh6zIFm9FjiZ+zr8CUQ3kOmKcyy2Mkc4cCjFpwkFQ
 DYm2Jc6Bfv69Zi927z89sY6fozKh0sQ6zGwMEOO6Z9BRBcBZxHolnz9Am1Ews//4PX0oeAkdHBj
 uP41Bc2w
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689b22c5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=-zu_XDMuf0vKP4TfBIsA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, ath12k_mac_handle_beacon_miss() does not handle the beacon
miss for the MLO case.

In MLO scenarios, the host fails to process the beacon miss because the
vdev_id comparison in ath12k_mac_handle_beacon_miss_iter() does not match.
This mismatch occurs since arvif always points to ahvif->deflink, which may
not correspond to the actual vdev_id associated with the event.

Fix this by retrieving arvif from vdev_id instead of ahvif->deflink which
will work for both MLO and Non-MLO case.

Also refactor the ath12k_mac_handle_beacon_miss(), by passing arvif
directly instead of vdev_id and remove ath12k_mac_handle_beacon_miss_iter()
which is no longer needed.

ath12k_mac_handle_beacon_miss() is called from ath12k_roam_event() for WCN
chipsets and ath12k_peer_sta_kickout_event() for QCN chipsets.

So, refactor the ath12k_roam_event() to pass arvif instead vdev_id to the
ath12k_mac_handle_beacon_miss() function to align with the
ath12k_peer_sta_kickout_event() and change the rcu_read_lock() to
guard(rcu)() in the same function ath12k_roam_event().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Co-developed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 24 ++++-------------
 drivers/net/wireless/ath/ath12k/mac.h |  3 ++-
 drivers/net/wireless/ath/ath12k/wmi.c | 37 ++++++++++++++++++---------
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index bd1ec3b2c084..ea13c5e0a4f7 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1822,22 +1822,16 @@ void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb)
 						   skb);
 }
 
-static void ath12k_mac_handle_beacon_miss_iter(void *data, u8 *mac,
-					       struct ieee80211_vif *vif)
+void ath12k_mac_handle_beacon_miss(struct ath12k *ar,
+				   struct ath12k_link_vif *arvif)
 {
-	u32 *vdev_id = data;
-	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
-	struct ath12k_link_vif *arvif = &ahvif->deflink;
-	struct ieee80211_hw *hw;
-
-	if (!arvif->is_created || arvif->vdev_id != *vdev_id)
-		return;
+	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 
-	if (!arvif->is_up)
+	if (!(arvif->is_created && arvif->is_up))
 		return;
 
 	ieee80211_beacon_loss(vif);
-	hw = ath12k_ar_to_hw(arvif->ar);
 
 	/* Firmware doesn't report beacon loss events repeatedly. If AP probe
 	 * (done by mac80211) succeeds but beacons do not resume then it
@@ -1848,14 +1842,6 @@ static void ath12k_mac_handle_beacon_miss_iter(void *data, u8 *mac,
 				     ATH12K_CONNECTION_LOSS_HZ);
 }
 
-void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id)
-{
-	ieee80211_iterate_active_interfaces_atomic(ath12k_ar_to_hw(ar),
-						   IEEE80211_IFACE_ITER_NORMAL,
-						   ath12k_mac_handle_beacon_miss_iter,
-						   &vdev_id);
-}
-
 static void ath12k_mac_vif_sta_connection_loss_work(struct work_struct *work)
 {
 	struct ath12k_link_vif *arvif = container_of(work, struct ath12k_link_vif,
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 18c79d4002cb..c05af40bd7a2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -168,7 +168,8 @@ int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable);
 int ath12k_mac_rfkill_config(struct ath12k *ar);
 int ath12k_mac_wait_tx_complete(struct ath12k *ar);
 void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb);
-void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id);
+void ath12k_mac_handle_beacon_miss(struct ath12k *ar,
+				   struct ath12k_link_vif *arvif);
 int ath12k_mac_vif_set_keepalive(struct ath12k_link_vif *arvif,
 				 enum wmi_sta_keepalive_method method,
 				 u32 interval);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 113ce1390eb1..392377bb5471 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7302,6 +7302,7 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
 	struct ath12k_link_vif *arvif;
 	struct ieee80211_sta *sta;
 	struct ath12k_peer *peer;
+	unsigned int link_id;
 	struct ath12k *ar;
 
 	if (ath12k_pull_peer_sta_kickout_ev(ab, skb, &arg) != 0) {
@@ -7330,11 +7331,23 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
 
 	ar = arvif->ar;
 
-	sta = ieee80211_find_sta_by_ifaddr(ath12k_ar_to_hw(ar),
-					   arg.mac_addr, NULL);
+	if (peer->mlo) {
+		sta = ieee80211_find_sta_by_link_addrs(ath12k_ar_to_hw(ar),
+						       arg.mac_addr,
+						       NULL, &link_id);
+		if (peer->link_id != link_id) {
+			ath12k_warn(ab,
+				    "Spurious quick kickout for MLO STA %pM with invalid link_id, peer: %d, sta: %d\n",
+				    arg.mac_addr, peer->link_id, link_id);
+			goto exit;
+		}
+	} else {
+		sta = ieee80211_find_sta_by_ifaddr(ath12k_ar_to_hw(ar),
+						   arg.mac_addr, NULL);
+	}
 	if (!sta) {
-		ath12k_warn(ab, "Spurious quick kickout for STA %pM\n",
-			    arg.mac_addr);
+		ath12k_warn(ab, "Spurious quick kickout for %sSTA %pM\n",
+			    peer->mlo ? "MLO " : "", arg.mac_addr);
 		goto exit;
 	}
 
@@ -7345,7 +7358,7 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
 	switch (arg.reason) {
 	case WMI_PEER_STA_KICKOUT_REASON_INACTIVITY:
 		if (arvif->ahvif->vif->type == NL80211_IFTYPE_STATION) {
-			ath12k_mac_handle_beacon_miss(ar, peer->vdev_id);
+			ath12k_mac_handle_beacon_miss(ar, arvif);
 			break;
 		}
 		fallthrough;
@@ -7360,6 +7373,7 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
 
 static void ath12k_roam_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
+	struct ath12k_link_vif *arvif;
 	struct wmi_roam_event roam_ev = {};
 	struct ath12k *ar;
 	u32 vdev_id;
@@ -7378,21 +7392,22 @@ static void ath12k_roam_event(struct ath12k_base *ab, struct sk_buff *skb)
 		   "wmi roam event vdev %u reason %d rssi %d\n",
 		   vdev_id, roam_reason, roam_ev.rssi);
 
-	rcu_read_lock();
-	ar = ath12k_mac_get_ar_by_vdev_id(ab, vdev_id);
-	if (!ar) {
+	guard(rcu)();
+	arvif = ath12k_mac_get_arvif_by_vdev_id(ab, vdev_id);
+	if (!arvif) {
 		ath12k_warn(ab, "invalid vdev id in roam ev %d", vdev_id);
-		rcu_read_unlock();
 		return;
 	}
 
+	ar = arvif->ar;
+
 	if (roam_reason >= WMI_ROAM_REASON_MAX)
 		ath12k_warn(ab, "ignoring unknown roam event reason %d on vdev %i\n",
 			    roam_reason, vdev_id);
 
 	switch (roam_reason) {
 	case WMI_ROAM_REASON_BEACON_MISS:
-		ath12k_mac_handle_beacon_miss(ar, vdev_id);
+		ath12k_mac_handle_beacon_miss(ar, arvif);
 		break;
 	case WMI_ROAM_REASON_BETTER_AP:
 	case WMI_ROAM_REASON_LOW_RSSI:
@@ -7402,8 +7417,6 @@ static void ath12k_roam_event(struct ath12k_base *ab, struct sk_buff *skb)
 			    roam_reason, vdev_id);
 		break;
 	}
-
-	rcu_read_unlock();
 }
 
 static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
-- 
2.17.1


