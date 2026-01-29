Return-Path: <linux-wireless+bounces-31289-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGQiBQLFemmY+QEAu9opvQ
	(envelope-from <linux-wireless+bounces-31289-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 03:25:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B7DAB198
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 03:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 507AD3038AE1
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 02:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059C83559D2;
	Thu, 29 Jan 2026 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fuPzggkh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jt5p0IxI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78727345750
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653468; cv=none; b=bGLiceUaTm7xO9+Qu+7NQEHBd92nyro8/ama0C2ZSD0RavVelFLhXVieaEWdgVTPNaWn5QUwBcg8Cnb8tKOStiifOEr/k8RrlERoZK4rgUfml+lWs/xQ4rrzUmX+3HyJkpJY3FEFGs6nlQvwXigIM9SHcgYycUSXPb0AQ6yxfoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653468; c=relaxed/simple;
	bh=lEJG+cOqnJNnOdFmRWydc1oWu2EAdKvSqQQ94MAySrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRZcVaWl2gisgFtZjriUuWdUWg2hFu2alBPQ1D9xdXo0qJNov6HCoZS6UAaXfra+IAE/YyydVO1zZU2BDyA2L5ekW3itE57q3Z2wVbR+ZD50CNVm6kV/NOzWkfe8zCQEjH2xb/TtNg3IIV8b1F4gfuKeWDXi391LE395EYgF7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fuPzggkh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jt5p0IxI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SLp63P1397973
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7qCXUIpVaz/FWsfJXyE0wx3UZw3tMasE32Or3Jgl450=; b=fuPzggkhVq/GYPnN
	OQ1RXMtceOCyRNw1l4aIS8BVz7sjlCzGFElxFKhZ185syuVE9tmcIuuv7r24edwj
	N1/b4EpXRGwUlMNUMICg38lfeUBQkMEBF25uCJHpzOVn47vZPKEx+osiY+tKp6sw
	IFADVRazTV4p9liF+HQQ9qbn/arR2UHKNK7mIuqWjCZBm3SN/LPygSY444EERU3r
	LrMWM5Qx6oDsjLIjH4apn7KNOFxT/ZRaBUSCWFXBOwS//WZ0OhI49ljS47oPE8Ku
	L4KOZ1sv8mSPc+c1z0NdV1eAKrn7RXRs5z92Em19/za1Ljb9GeukjRwgKwtZEcs1
	NdKXSw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bytqy0nc1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 02:24:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a78c094ad6so4959505ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 18:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769653465; x=1770258265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qCXUIpVaz/FWsfJXyE0wx3UZw3tMasE32Or3Jgl450=;
        b=Jt5p0IxIM8/dV0lDNPpj3xIia/riJhXkS98eHXN51GRm5ShFGCaQFh8FWx2/vT6pZv
         rabzHRaQ2sa4/iMw4x/af8r5evQpNAq05MBGuhsU0iVKT2WFhqYSK6lKC8OAwA3uoXg3
         joQcqckFfMLykuWng/6/7rPuXdwvVNr9DJzuUGZJnHO6H57mLpVo2BI2gZyv+m4Dx9op
         4FdUNmhGgxWLSO7BEGs+WXcb/9BvtIrfGiGhXUj1U7FYIVrNneWDxga2pxYJhQg9fyfA
         APbr0dsBShbxhp2ogvz1RmwcXMnCSdXu//PtIJxaWd0HaMV6CJmpBZ1Nf18nwU7LSvAV
         kkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769653465; x=1770258265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7qCXUIpVaz/FWsfJXyE0wx3UZw3tMasE32Or3Jgl450=;
        b=kAI0YvjcOaO97SvSoqZ063u7bZA7YtlZdvdcdC8+qZNmEEFh0+ysAbM4Gt90PNbzpZ
         BiEQjYZdYi5UE0A4XJQdXdT1f/YBW/YtQIARa83t3Xf2uUmMP6aCsLBLyibRnwu55CPT
         QiSaPL5obqRy9JOvjqXmxxZK6rfPnR1ZkWqy0YWaZ7m6s+3qQKSiPNmq+TUcHmhKtl+F
         NdimnlyQVzboNIW8aEkzFsPg2RSfR5ipXVkqqaqVYNoeEpsjrAeSmLbAXWqMrYXz+Eln
         PJsE4JU2oQnrnR235VMcREj8C63FBIgQG/IRYhEEgxeBmZjVjHRmV9WDc7poyRxM3j/r
         w5TQ==
X-Gm-Message-State: AOJu0Yyhh3k3Lh9rs7/9JDvuj9oNTpcN6J7GqxvxrcuUXeew8A1Yw0Wi
	WcFZRWQrwtu2i9c3d69hM5572xXZYnLLGYkaEyKT24TIXrpyRnuwPN9B1f+Nx3RMFPW8H0LcsfP
	C9rQUSJ3f3r1zS5mpRp5KPafRqAWso55LAs+iW74DKyfr4a5gP7DC9ehsNQRH8b0qnZevXiT/4u
	a5M2ji
X-Gm-Gg: AZuq6aKeM5pu38F+WDzeB62Z8m05UofMMbkHADvM8E6GMNBZa7G0RF19V0NX7qC8/sP
	QZ5j9HLS2skG1+F9IWarSBACoFf5xPuM5yy8ZNewIiBW9G9XiNCOq3KjcrSdA+YAdX5tCIUdx6D
	4A6Ci1LlSjC5AxOw70L4b4zcU3SPNgLusUFF7KXExUGqDqj3m7xRvXjsqZx/7f3j70b/9YHNd8P
	iBAfRhWHfCqFKc1yF6Jf6tLJZAwQrJ/5LA2NHPt2fl+APuDMPLquvtbnfTe8aEQXECMrz8Ou0BR
	yO40CEGmX0uUHJAemeJclJN5Nb7XPsukoECrVAx5SORgp+lZnCsH9fZEexCe4mryapJ5Xo3oQwt
	Iv4bP9xQFOtV0M7QLS9FG9YNsY55bzkb2dUjmKzWsLAquZKiNfhiSxTzoEgtaIoY=
X-Received: by 2002:a17:902:da4f:b0:2a0:92a6:955 with SMTP id d9443c01a7336-2a870d66543mr76808085ad.23.1769653465027;
        Wed, 28 Jan 2026 18:24:25 -0800 (PST)
X-Received: by 2002:a17:902:da4f:b0:2a0:92a6:955 with SMTP id d9443c01a7336-2a870d66543mr76807815ad.23.1769653464512;
        Wed, 28 Jan 2026 18:24:24 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d92a9sm33851035ad.69.2026.01.28.18.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:24:24 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 10:24:06 +0800
Subject: [PATCH ath-next 2/2] wifi: ath12k: fix station lookup failure when
 disconnecting from AP
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-ath12k-fw-stats-fixes-v1-2-55d66064f4d5@oss.qualcomm.com>
References: <20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com>
In-Reply-To: <20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAxNiBTYWx0ZWRfX+5brB+8Xhb8i
 5GImzXw4Kk8hv0jIcwtby0fov3NJ0kye18TqOx3ip6D7o4aEDToSlBhsY7CdXYl5QX6xPNKgxTM
 L82OOfOKhvcLCaWAiep/17YQJ/u95yl2umKX/NMx3he0919RfL21o7Z0Y9cFXZT85Qtc+4Ojayo
 naRSER+Cyf/Gij/Mrb1VNWQ6KGf62/7QEmt0R/rIA+bKS31CTXMmO0Cxq3AYcRJ2lL0TnVdX8Rq
 5gEfcrEHDjgiaOQnQ/sv9sHuylYhv1UTfB73Cqyqv20CAShamyEcqTRqAxDlke68UUcs8NUq+RT
 oYjNiKy/qp/mllfqc0Ugdl9qh+1FVWi/EkYsOFHl3yUFeYNXO6OTuS4GXUKoWOSu/dP7BmM+2l/
 jQN9zGOa8eWZ5OG5mx+AGLmwl5WGB2HQLwcQXnWsOnDHxZAaq0FsTKYGBUO7B3ohrLorpEMGORo
 CLCgMR2ydi94jmeGJ/g==
X-Authority-Analysis: v=2.4 cv=Je2xbEKV c=1 sm=1 tr=0 ts=697ac4da cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=c0rEsw2Pbq29Pm4qmBMA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: qazG_DvNgW6g0hv5tM-VIqFnUXg8tQ62
X-Proofpoint-GUID: qazG_DvNgW6g0hv5tM-VIqFnUXg8tQ62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290016
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31289-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A5B7DAB198
X-Rspamd-Action: no action

In ath12k_wmi_tlv_fw_stats_data_parse() and
ath12k_wmi_tlv_rssi_chain_parse(), the driver uses
ieee80211_find_sta_by_ifaddr() to look up the station associated with the
incoming firmware statistics. This works under normal conditions but fails
during AP disconnection, resulting in log messages like:

 wlan0: deauthenticating from xxxxxx by local choice (Reason: 3=DEAUTH_LEAVING)
 wlan0: moving STA xxxxxx to state 3
 wlan0: moving STA xxxxxx to state 2
 wlan0: moving STA xxxxxx to state 1
 ath12k_pci 0000:02:00.0: not found station bssid xxxxxx for vdev stat
 ath12k_pci 0000:02:00.0: not found station of bssid xxxxxx for rssi chain
 ath12k_pci 0000:02:00.0: failed to pull fw stats: -71
 ath12k_pci 0000:02:00.0: time out while waiting for get fw stats
 wlan0: Removed STA xxxxxx
 wlan0: Destroyed STA xxxxxx

The failure happens because the station has already been removed from
ieee80211_local::sta_hash by the time firmware statistics are requested
through drv_sta_statistics().

Switch the lookup to ath12k_link_sta_find_by_addr(), which searches the
driver's link station hash table that still has the station recorded
at that time.  This also implicitly fixes another issue: the current code
always uses deflink regardless of which link the statistics belong to,
which is incorrect in MLO scenarios. The new helper returns the correct
link station.

Additionally, raise the log level on lookup failures. With the updated
helper, such failures should no longer occur under normal conditions.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 79e7b04b5388 ("wifi: ath12k: report station mode signal strength")
Fixes: 6af5bc381b36 ("wifi: ath12k: report station mode per-chain signal strength")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 36 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index cce3d699112d..92e4f820005e 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -8099,8 +8099,6 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 	struct ath12k_fw_stats *stats = parse->stats;
 	struct ath12k *ar;
 	struct ath12k_link_vif *arvif;
-	struct ieee80211_sta *sta;
-	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
 	int i, ret = 0;
 	const void *data = ptr;
@@ -8136,21 +8134,19 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 
 		arvif = ath12k_mac_get_arvif(ar, le32_to_cpu(src->vdev_id));
 		if (arvif) {
-			sta = ieee80211_find_sta_by_ifaddr(ath12k_ar_to_hw(ar),
-							   arvif->bssid,
-							   NULL);
-			if (sta) {
-				ahsta = ath12k_sta_to_ahsta(sta);
-				arsta = &ahsta->deflink;
+			spin_lock_bh(&ab->base_lock);
+			arsta = ath12k_link_sta_find_by_addr(ab, arvif->bssid);
+			if (arsta) {
 				arsta->rssi_beacon = le32_to_cpu(src->beacon_snr);
 				ath12k_dbg(ab, ATH12K_DBG_WMI,
 					   "wmi stats vdev id %d snr %d\n",
 					   src->vdev_id, src->beacon_snr);
 			} else {
-				ath12k_dbg(ab, ATH12K_DBG_WMI,
-					   "not found station bssid %pM for vdev stat\n",
-					   arvif->bssid);
+				ath12k_warn(ab,
+					    "not found link sta with bssid %pM for vdev stat\n",
+					    arvif->bssid);
 			}
+			spin_unlock_bh(&ab->base_lock);
 		}
 
 		data += sizeof(*src);
@@ -8221,8 +8217,6 @@ static int ath12k_wmi_tlv_rssi_chain_parse(struct ath12k_base *ab,
 	struct ath12k_fw_stats *stats = parse->stats;
 	struct ath12k_link_vif *arvif;
 	struct ath12k_link_sta *arsta;
-	struct ieee80211_sta *sta;
-	struct ath12k_sta *ahsta;
 	struct ath12k *ar;
 	int vdev_id;
 	int j;
@@ -8258,19 +8252,15 @@ static int ath12k_wmi_tlv_rssi_chain_parse(struct ath12k_base *ab,
 		   "stats bssid %pM vif %p\n",
 		   arvif->bssid, arvif->ahvif->vif);
 
-	sta = ieee80211_find_sta_by_ifaddr(ath12k_ar_to_hw(ar),
-					   arvif->bssid,
-					   NULL);
-	if (!sta) {
-		ath12k_dbg(ab, ATH12K_DBG_WMI,
-			   "not found station of bssid %pM for rssi chain\n",
-			   arvif->bssid);
+	guard(spinlock_bh)(&ab->base_lock);
+	arsta = ath12k_link_sta_find_by_addr(ab, arvif->bssid);
+	if (!arsta) {
+		ath12k_warn(ab,
+			    "not found link sta with bssid %pM for rssi chain\n",
+			    arvif->bssid);
 		return -EPROTO;
 	}
 
-	ahsta = ath12k_sta_to_ahsta(sta);
-	arsta = &ahsta->deflink;
-
 	BUILD_BUG_ON(ARRAY_SIZE(arsta->chain_signal) >
 		     ARRAY_SIZE(stats_rssi->rssi_avg_beacon));
 

-- 
2.25.1


