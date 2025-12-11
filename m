Return-Path: <linux-wireless+bounces-29653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F136CB5E4B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 013DB30019C0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002EB1DFFD;
	Thu, 11 Dec 2025 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nImxPYvq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="diVTtCe4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8D30FC1C
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456606; cv=none; b=nxxVq+8930wIK0cpRjq07HS2NidMudcmp0Hse9G9IrSLS5W1l49wE9aIRDn7XMXhTOF2bzZfoyiJ3p1wE8pgbmGhi3+wf4Anc/olNOeXs3QpADTx2QV18X7an6TgTMTcsWkA8C1Flu9fqThUezIV7CJBz4yRfhWqqPC1U/+RSxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456606; c=relaxed/simple;
	bh=I1GoPQ6QHk43abPBfQj+WtyOdH5jVQewvwP9yzAIZDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JJgHOf9r5VqOwqutRdswSRtoaKB1vfxm2SfwoNPUH5MobQZDIvqAzu/FXUGZapCC9Z3zGgAwuetMnGX6dMiU3QwnF0OMHyHNUBvjTh6ssvy5kaQX8lBdMinY82vDezgdFPFtivy9i83iS//Bb2MnvldBy3eZkFTCqXcO9Ea9ges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nImxPYvq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=diVTtCe4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBBlRMv1687207
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QNahNY9ogKzqwFWATkzL1yoJuRJTf3VAoc7
	9gvtnyN8=; b=nImxPYvqeky6sJYtO5JVnYiOHn9Er0YsTLyhIYyaXERKXSTFzUd
	9MPcqvVo3DYSN9ppYH4Vu6PRHPx1tWjtkOH52cd4PT/PvhgvIBY4M80+7xagdgSu
	3sHBzh6KJM41nUvl+gbbokVthGNJBdM0UwcgsCb5zSCHu+xMP3zD0g1p3QRRVLoZ
	9tZ6nqIUDkCpdEu/P+7cPQpAdKgH6xlZZHfrmeTsb8cr4zL2dmujMMojukEs/5g2
	jb/MGchVJDf43FA1XE/kaMLmlut6JjaJkvEov/YRt4TQCw5VJl5eBxTxnmZgVWCs
	SetyJPEC8HWLUo5j/EifEKn15m+m0jzY4Pw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aywcxr444-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:36:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343daf0f38aso1144721a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456602; x=1766061402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QNahNY9ogKzqwFWATkzL1yoJuRJTf3VAoc79gvtnyN8=;
        b=diVTtCe4GpaKFR9tpx/DxhAK2bJruWsI+ceYl6WaC+BiyS9N5vPBZa3sZPAJWCy+jd
         nGc3c0OTyIsU4uXaW1CiITyk8O01AfB8XNpLFJq1GEMgvS0AvL9jegK2+YFzmhE74nd9
         xGytiD+ceCs/4MI1nvTk29rL/fbr2uNx2SskJV0waJJnjPRlkFF0Ymzjm2ag/J+/zRiK
         YmvMO3U4hdwQ/49mTw7Yxi3rWh16lvNrIXIIyXEdvPGzOCd2XxqIw4KEP8tMAtagdQrU
         Bl+UnFYzoUdad1Gu511aB06QVP24CPlhoThyWHCbpTLgh0xgn2Q0VWD893x6e10/QVv8
         AkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456602; x=1766061402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNahNY9ogKzqwFWATkzL1yoJuRJTf3VAoc79gvtnyN8=;
        b=kws4S9i4Pl8PyBuH512VMZclOK3CIofCLOqoh/79rR5wgCgl2Rav2sElpuXxOIU10u
         YWj2zxjVmDUTghhEH+ZI0u2rkGxKaoWwh7RAf/v2IrXUUSmNMIzu0+InW4naBKyABJC+
         Tpp15MaIXcOCJIEaBYzQ4Puw8zBxVR93mHZOvIW7XTnopBKcw8xgtqM2Re/NrJLgClYV
         WUZRW8kwCLtqPViTV6DgRCTYwL11tlaaJl8ksddDRWTJGepQdWgnBfbNeIbJY7Ai5U8T
         V7i/THLNExVjd2Af2DZtJA7RpAfsQGQ/DH/NdYT1xYW1fp6zu1E9/2/NoYWurnxyyS7M
         /fFg==
X-Gm-Message-State: AOJu0YxpxdPXecc/d7rf4u99PhDW0t2GgkqYjOWO3fLJ48eZ/WCjWf+Q
	YsdNGp9vuLjLqLRPYI8nMNwGekfBIaoNv9YX7/f5f5AWhCR7sgM7fHQ+tzxAv01kMynhWz3emwZ
	ynOXzeeopq/YwX4b5TNYgwZNlL5hwVT38O6oq/a+ZZU/P/2R6Ms26ff1oGoMlPC23hOlrqA==
X-Gm-Gg: AY/fxX6KHZNqEszW4cp4FvARZmt51JpfMY9sEmP/mLbcahcnGqdLWBOB6Sbw4IhCmuL
	FSM3s9OmdkQVkv90B9rNgyPAtZRmEHoKgcvYWDOF30ytY7mjJgYno511b2skMkOWqamBQTQKd++
	KrYeyoTV4NK1EOeW3xcWGn0ahRIHqOuuzfhoVoAjEBIGNR8YmprmeSiVg4WZpwOEtCk1dSlbQJU
	wteUAqDfi/wqZHaEM8NNfHDneURL0BuQnmTsddCIrvjrXE1OKOSP5EXUhLLVloxzBvQfbDNi0fv
	OwqFKV7s0gl6NdKdnRR1uTmoG05KISp4PxN0NS/FVpOlob7gxlkmqO2QqlwGIeNipnO/bZYsJLZ
	LlD1rjUEiz58fK2UWbpC8kHsXYKwz8FmmwBuAqNIOKixtV04PLmMjJvwaoZOWWcwXQkFap5BtGe
	WVIVD68FlcRaoyofPwqmRmo5M=
X-Received: by 2002:a05:6a21:e083:b0:35d:53dc:cb52 with SMTP id adf61e73a8af0-366e01c2996mr5586955637.11.1765456602043;
        Thu, 11 Dec 2025 04:36:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCsls0jlAJvVoTlIbEb/IAJplYe56r+baoazPoB/VnO7OskQ0EwyQNRoXbpYz3sjuVq8NVOg==
X-Received: by 2002:a05:6a21:e083:b0:35d:53dc:cb52 with SMTP id adf61e73a8af0-366e01c2996mr5586934637.11.1765456601498;
        Thu, 11 Dec 2025 04:36:41 -0800 (PST)
Received: from hu-smagam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c26fa703asm2274863a12.16.2025.12.11.04.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:36:40 -0800 (PST)
From: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>,
        Rohan Dutta <quic_drohan@quicinc.com>
Subject: [PATCH wireless-next] wifi: mac80211: Fix AAD/Nonce computation for management frames with MLO
Date: Thu, 11 Dec 2025 18:06:12 +0530
Message-Id: <20251211123612.2470117-1-sai.magam@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S/rUAYsP c=1 sm=1 tr=0 ts=693abadb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=fEA6x38eVT21M8dpCI4A:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: AEG3rF7Oic-eMLAnDBzeEhLYzZPjhkbm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OCBTYWx0ZWRfX445tV2mc5+YP
 3p65NXDVLXRVnhqj1DnS6o2fpi5/cizd2zaNz/i0xUghUViNNP8F92MTtE9+uf/qx+GwIYtjS3m
 OCEDnEekXkNGkf3kGTzbpFfmgWrfoKRbhHMTTZOywti7vTcrwMJPXr42h4QPPbf7sPn7ziFwGYy
 9rrlyTc+wSyp0dK9dCRK6EtTC0UMddiWLUImjiY3SxdrGuk3nb/mU4IOIAohk+YOcFglL46V/re
 n9MrcLiWXefXmVdkr42Qqn2t2o0t4UxF2EH0kD+XlQCOX77zFXnG1ETq6iresF5sY+jNonCohgu
 JddRUmp6dmx8KE/IejW60gCTNEUlcVd+knlJNELxtbwYUzcaAoyF0szpE7bRYrfkD6H8Azg2sLZ
 ojOV9U4gD8q16yhqOBh5t7QJmEDMzA==
X-Proofpoint-ORIG-GUID: AEG3rF7Oic-eMLAnDBzeEhLYzZPjhkbm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110098

Per IEEE Std 802.11be-2024, 12.5.2.3.3, if the MPDU is an
individually addressed Data frame between an AP MLD and a
non-AP MLD associated with the AP MLD, then A1/A2/A3
will be MLD MAC addresses. Otherwise, Al/A2/A3 will be
over-the-air link MAC addresses.

Currently, during AAD and Nonce computation for software based
encryption/decryption cases, mac80211 directly uses the addresses it
receives in the skb frame header. However, after the first
authentication, management frame addresses for non-AP MLD stations
are translated to MLD addresses from over the air link addresses in
software. This means that the skb header could contain translated MLD
addresses, which when used as is, can lead to incorrect AAD/Nonce
computation.

For management frames, ensure that the AAD/Nonce computation is solely
using the cached link addresses, avoiding dependence on potentially
translated headers. To achieve this, add an additional layer of address
translation to link MAC addresses to be used in both encrypt/decrypt paths.
For data frames, the existing behavior remains unchanged.

Co-developed-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
---
 net/mac80211/wpa.c | 167 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 155 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 4a858112e4ef..3f73c6286f03 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -311,11 +311,110 @@ ieee80211_crypto_tkip_decrypt(struct ieee80211_rx_data *rx)
 	return RX_CONTINUE;
 }
 
+static bool ccmp_gcmp_aad_nonce_addr_translate_rx(struct ieee80211_rx_data *rx,
+						  u8 *aad, u8 *b_0, u32 cipher,
+						  __le16 fc)
+{
+	struct ieee80211_link_data *link = rx->link;
+	struct ieee80211_bss_conf *bss_conf = link->conf;
+	struct link_sta_info *link_sta = rx->link_sta;
+	struct ieee80211_vif *vif = &rx->sdata->vif;
+
+	if (!rx->sta || !rx->sta->sta.mlo ||
+	    (vif->type != NL80211_IFTYPE_AP &&
+	     vif->type != NL80211_IFTYPE_STATION))
+		return false;
+
+	/* Address Translation for AAD computation */
+	ether_addr_copy(&aad[4], bss_conf->addr);
+	ether_addr_copy(&aad[4] + ETH_ALEN, link_sta->addr);
+
+	if (!ieee80211_has_tods(fc) && !ieee80211_has_fromds(fc)) {
+		if (vif->type == NL80211_IFTYPE_STATION && bss_conf->bssid)
+			ether_addr_copy(&aad[4] + 2 * ETH_ALEN,
+					bss_conf->bssid);
+		else if (vif->type == NL80211_IFTYPE_AP)
+			ether_addr_copy(&aad[4] + 2 * ETH_ALEN,
+					bss_conf->addr);
+	}
+
+	/* Address Translation for Nonce computation */
+	if (cipher == WLAN_CIPHER_SUITE_CCMP ||
+	    cipher == WLAN_CIPHER_SUITE_CCMP_256)
+		ether_addr_copy(&b_0[2], link_sta->addr);
+	if (cipher == WLAN_CIPHER_SUITE_GCMP ||
+	    cipher == WLAN_CIPHER_SUITE_GCMP_256)
+		ether_addr_copy(&b_0[0], link_sta->addr);
+	return true;
+}
+
+/* This function is called with the caller held under RCU Read Lock */
+static bool ccmp_gcmp_aad_nonce_addr_translate_tx(struct ieee80211_tx_data *tx,
+						  struct ieee80211_tx_info *info,
+						  u8 *aad, u8 *b_0,
+						  u32 cipher, __le16 fc)
+{
+	struct ieee80211_vif *vif = info->control.vif;
+	struct sta_info *sta = tx->sta;
+	u8 link_id = u32_get_bits(info->control.flags,
+				  IEEE80211_TX_CTRL_MLO_LINK);
+	struct ieee80211_bss_conf *bss_conf;
+	struct link_sta_info *link_sta;
+
+	if (!sta || !vif || !sta->sta.mlo ||
+	    (vif->type != NL80211_IFTYPE_AP &&
+	     vif->type != NL80211_IFTYPE_STATION))
+		return false;
+
+	/*
+	 * When link_id is IEEE80211_LINK_UNSPECIFIED, use default link
+	 * for AAD computations and update the control flags to encode
+	 * the default link_id. This is to make sure that the driver
+	 * also uses the same link to transmit the frame
+	 */
+	if (link_id == IEEE80211_LINK_UNSPECIFIED) {
+		link_id = sta->deflink.link_id;
+		info->control.flags &= ~IEEE80211_TX_CTRL_MLO_LINK;
+		info->control.flags |=
+			u32_encode_bits(link_id, IEEE80211_TX_CTRL_MLO_LINK);
+	}
+
+	bss_conf = rcu_dereference(vif->link_conf[link_id]);
+	link_sta = rcu_dereference(sta->link[link_id]);
+
+	if (!bss_conf || !link_sta)
+		return false;
+
+	/* Address Translation for AAD computation */
+	ether_addr_copy(&aad[4], link_sta->addr);
+	ether_addr_copy(&aad[4] + ETH_ALEN, bss_conf->addr);
+
+	if (!ieee80211_has_tods(fc) && !ieee80211_has_fromds(fc)) {
+		if (vif->type == NL80211_IFTYPE_STATION && bss_conf->bssid)
+			ether_addr_copy(&aad[4] + 2 * ETH_ALEN,
+					bss_conf->bssid);
+		else if (vif->type == NL80211_IFTYPE_AP)
+			ether_addr_copy(&aad[4] + 2 * ETH_ALEN,
+					bss_conf->addr);
+	}
+
+	/* Address Translation for Nonce computation */
+	if (cipher == WLAN_CIPHER_SUITE_CCMP ||
+	    cipher == WLAN_CIPHER_SUITE_CCMP_256)
+		ether_addr_copy(&b_0[2], bss_conf->addr);
+	if (cipher == WLAN_CIPHER_SUITE_GCMP ||
+	    cipher == WLAN_CIPHER_SUITE_GCMP_256)
+		ether_addr_copy(&b_0[0], bss_conf->addr);
+
+	return true;
+}
+
 /*
  * Calculate AAD for CCMP/GCMP, returning qos_tid since we
  * need that in CCMP also for b_0.
  */
-static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad, bool spp_amsdu)
+static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad, bool spp_amsdu,
+			bool is_translated)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	__le16 mask_fc;
@@ -358,7 +457,8 @@ static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad, bool spp_amsdu)
 	 * FC | A1 | A2 | A3 | SC | [A4] | [QC] */
 	put_unaligned_be16(len_a, &aad[0]);
 	put_unaligned(mask_fc, (__le16 *)&aad[2]);
-	memcpy(&aad[4], &hdr->addrs, 3 * ETH_ALEN);
+	if (!is_translated)
+		memcpy(&aad[4], &hdr->addrs, 3 * ETH_ALEN);
 
 	/* Mask Seq#, leave Frag# */
 	aad[22] = *((u8 *) &hdr->seq_ctrl) & 0x0f;
@@ -377,10 +477,10 @@ static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad, bool spp_amsdu)
 }
 
 static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad,
-				bool spp_amsdu)
+				bool spp_amsdu, bool is_translated)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	u8 qos_tid = ccmp_gcmp_aad(skb, aad, spp_amsdu);
+	u8 qos_tid = ccmp_gcmp_aad(skb, aad, spp_amsdu, is_translated);
 
 	/* In CCM, the initial vectors (IV) used for CTR mode encryption and CBC
 	 * mode authentication are not allowed to collide, yet both are derived
@@ -395,7 +495,8 @@ static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad,
 	 * Nonce Flags: Priority (b0..b3) | Management (b4) | Reserved (b5..b7)
 	 */
 	b_0[1] = qos_tid | (ieee80211_is_mgmt(hdr->frame_control) << 4);
-	memcpy(&b_0[2], hdr->addr2, ETH_ALEN);
+	if (!is_translated)
+		memcpy(&b_0[2], hdr->addr2, ETH_ALEN);
 	memcpy(&b_0[8], pn, IEEE80211_CCMP_PN_LEN);
 }
 
@@ -435,6 +536,8 @@ static int ccmp_encrypt_skb(struct ieee80211_tx_data *tx, struct sk_buff *skb,
 	u64 pn64;
 	u8 aad[CCM_AAD_LEN];
 	u8 b_0[AES_BLOCK_SIZE];
+	__le16 fc = hdr->frame_control;
+	bool is_translated = false;
 
 	if (info->control.hw_key &&
 	    !(info->control.hw_key->flags & IEEE80211_KEY_FLAG_GENERATE_IV) &&
@@ -487,8 +590,15 @@ static int ccmp_encrypt_skb(struct ieee80211_tx_data *tx, struct sk_buff *skb,
 		return 0;
 
 	pos += IEEE80211_CCMP_HDR_LEN;
+
+	if (ieee80211_is_mgmt(fc))
+		is_translated = ccmp_gcmp_aad_nonce_addr_translate_tx(tx, info,
+								      aad, b_0,
+								      key->conf.cipher,
+								      fc);
 	ccmp_special_blocks(skb, pn, b_0, aad,
-			    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU);
+			    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU,
+			    is_translated);
 	return ieee80211_aes_ccm_encrypt(key->u.ccmp.tfm, b_0, aad, pos, len,
 					 skb_put(skb, mic_len));
 }
@@ -565,9 +675,21 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 		if (!(status->flag & RX_FLAG_DECRYPTED)) {
 			u8 aad[2 * AES_BLOCK_SIZE];
 			u8 b_0[AES_BLOCK_SIZE];
+			bool is_translated = false;
+			__le16 fc = hdr->frame_control;
+
+			if (ieee80211_is_mgmt(fc))
+				is_translated =
+					ccmp_gcmp_aad_nonce_addr_translate_rx(rx,
+									      aad,
+									      b_0,
+									      key->conf.cipher,
+									      fc);
+
 			/* hardware didn't decrypt/verify MIC */
 			ccmp_special_blocks(skb, pn, b_0, aad,
-					    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU);
+					    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU,
+					    is_translated);
 
 			if (ieee80211_aes_ccm_decrypt(
 				    key->u.ccmp.tfm, b_0, aad,
@@ -592,14 +714,15 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 }
 
 static void gcmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *j_0, u8 *aad,
-				bool spp_amsdu)
+				bool spp_amsdu, bool is_translated)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 
-	memcpy(j_0, hdr->addr2, ETH_ALEN);
+	if (!is_translated)
+		memcpy(j_0, hdr->addr2, ETH_ALEN);
 	memcpy(&j_0[ETH_ALEN], pn, IEEE80211_GCMP_PN_LEN);
 
-	ccmp_gcmp_aad(skb, aad, spp_amsdu);
+	ccmp_gcmp_aad(skb, aad, spp_amsdu, is_translated);
 }
 
 static inline void gcmp_pn2hdr(u8 *hdr, const u8 *pn, int key_id)
@@ -635,6 +758,8 @@ static int gcmp_encrypt_skb(struct ieee80211_tx_data *tx, struct sk_buff *skb)
 	u64 pn64;
 	u8 aad[GCM_AAD_LEN];
 	u8 j_0[AES_BLOCK_SIZE];
+	__le16 fc = hdr->frame_control;
+	bool is_translated = false;
 
 	if (info->control.hw_key &&
 	    !(info->control.hw_key->flags & IEEE80211_KEY_FLAG_GENERATE_IV) &&
@@ -688,8 +813,15 @@ static int gcmp_encrypt_skb(struct ieee80211_tx_data *tx, struct sk_buff *skb)
 		return 0;
 
 	pos += IEEE80211_GCMP_HDR_LEN;
+
+	if (ieee80211_is_mgmt(fc))
+		is_translated = ccmp_gcmp_aad_nonce_addr_translate_tx(tx, info,
+								      aad, j_0,
+								      key->conf.cipher,
+								      fc);
 	gcmp_special_blocks(skb, pn, j_0, aad,
-			    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU);
+			    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU,
+			    is_translated);
 	return ieee80211_aes_gcm_encrypt(key->u.gcmp.tfm, j_0, aad, pos, len,
 					 skb_put(skb, IEEE80211_GCMP_MIC_LEN));
 }
@@ -761,9 +893,20 @@ ieee80211_crypto_gcmp_decrypt(struct ieee80211_rx_data *rx)
 		if (!(status->flag & RX_FLAG_DECRYPTED)) {
 			u8 aad[2 * AES_BLOCK_SIZE];
 			u8 j_0[AES_BLOCK_SIZE];
+			bool is_translated = false;
+			__le16 fc = hdr->frame_control;
+
+			if (ieee80211_is_mgmt(fc))
+				is_translated =
+					ccmp_gcmp_aad_nonce_addr_translate_rx(rx,
+									      aad,
+									      j_0,
+									      key->conf.cipher,
+									      fc);
 			/* hardware didn't decrypt/verify MIC */
 			gcmp_special_blocks(skb, pn, j_0, aad,
-					    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU);
+					    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU,
+					    is_translated);
 
 			if (ieee80211_aes_gcm_decrypt(
 				    key->u.gcmp.tfm, j_0, aad,

base-commit: f9e788c5fd3a23edecd808ebb354e2cb1aef87c3
-- 
2.34.1


