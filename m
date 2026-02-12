Return-Path: <linux-wireless+bounces-31755-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GQGCYhWjWnK1AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31755-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 05:26:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7198912A4EA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 05:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB976303E484
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 04:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D8D1DB125;
	Thu, 12 Feb 2026 04:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tkaeg3SK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OJlObwEM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAAF56B81
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 04:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770870399; cv=none; b=eMAtK1sHSxRIkz5d4XY5cP9dLneNLzVYbU47Bh3ysnNL8cZFu38T1QWcWCU5htRN65mdnbwZCJT7DhUPRejuvuyXHMhqu/lTq4uTYgVi5HqtmvM9jAF5FMjGFjq8ibggXAv1pxUm/NthDgPvxX/gJm6r2tKiA8b3AxWNUmNMTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770870399; c=relaxed/simple;
	bh=m+7qnPFpO4SEgx8YYmwW1I/SdxD8Ltkf36MPQyS1uD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IBZ0e3dtwpolkIUk/n+R8jf4cPjwYRZNslef/kjRkTiqaFvNkQtGwArr5WynS7xKBnxCBTWlhY4Z6SGW9DLgf82rUXvdcMnZ9B54uTj58E0XsJb5RovqJzs+b4pNeTpy9ZHcBbcfUZ9qjum2nd5/OZ2cZR3YhCPzqpMCy/ip0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tkaeg3SK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OJlObwEM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61C3Rn0O2640722
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 04:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=e5yaUmbSluTAEAfF1hrZo3lVdy6xSzVSZZy
	4tB47Gys=; b=Tkaeg3SKTTDV1fqdXZltuz89poeq1XTKiMMHQt2NIVWGGjj3Emu
	wUdoaMBIOZ1dyeiNPGfCk5VUOyhMoCmGZpGR/wyhpMwoYH8QO8zAylgGPojqoPv1
	fWC/HDpDXvl0Q/8rxkbvkwZGJeohaLlmNd94g7iIRJ4Il5TOnhsVCDMBuy7Wfvp4
	qjiVZ/GLmaXLo9OIXFqrEd7QeSmXU283wFkxKFfzdd22dQaYYnPBTGD16jTQM+fF
	RjItRbkSKKiiZdphpmGLSXKcpD17TLFM2WwA6zYQ/TRrv78oHM/6xt4thaQomE+V
	ypRNteRTYaADElejgfRM5XnTbxc/LiuP6NQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c90d6s7wn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 04:26:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c52d37d346dso1671914a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 20:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770870396; x=1771475196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5yaUmbSluTAEAfF1hrZo3lVdy6xSzVSZZy4tB47Gys=;
        b=OJlObwEMw/1m3YChbYJcJgpLUCi2J5ZZYHQEOoA02AxRUmp+FPCm3OjvVNQfRpU/EM
         weiRM/p9H3oJ8xM9YEwAz606I52RsOQbp0S+sUJKzqU/oJWBINLcNiqZxEWB01Qn4Hr7
         WGYecgkdRcKeOAmWeEfamBJNdQv9laB1hq825D1aTvv+NT3WJSatKm5mG3dbCNsgOJC8
         OYr+Mg2vTuE0jT5bvcl3zrS+se1vJbWSrB3LND9M1/WIuhfPQVWeFrazl3BEIa5VsX4j
         7EVWI8Rk7tmlI/JHA+1OqAYKiYAb7OZKJltkh1JCrbSZ69Zon3ls3e/daNqpF5GjHLeA
         O7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770870396; x=1771475196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5yaUmbSluTAEAfF1hrZo3lVdy6xSzVSZZy4tB47Gys=;
        b=OdKmMLY+PmudIJVdg2Na68G5y7i7BFoF4lfyo7Ffulnh+2G2o6Aqi+/qh8y624Dy3A
         OD6vxkg71U8mhlJYu2i2rq1UL1oxLy6FYRR5H9A8x34YSpuOpLmgHoQjJqGlY118RQuW
         hQ+gbqmqR0AY5pwa5JsLvQIgbXP9pR2EzUL5EjBYMDxvmOscrlSzN2q0vl0URIZl917y
         Xc+fuho2YdubRAFpo/Gknq3zbxYZ7AEze12cVbm17+EzvRJ3N8dHFSUx3JsM6V3Kf1Oc
         k11eBvWE58djCu4xfsX6Wlb5B3f2sJ7mGgrVmoT/KEQNMw1+tx7QqscNyTaCgZokcWU8
         dXeQ==
X-Gm-Message-State: AOJu0Yw/TCbK+f0enTVzYPzD6tn/oTIT5uZV5vJrOnzAO8LU/h2MjH4X
	vF60MsNsPRPulJbSFXD7XOhsGW/I6wsaucS7ThRxewRCL7gLr0vJ00thoL9PDuHI7kgAnvKcKaE
	UlhAaTQ9xULHhY9OiqwlIYoYQpS3uixL2rvGYcPttoBw4hgXHYUTPT4hNgH+ymfkYlmuEcg8V7e
	fP/Q==
X-Gm-Gg: AZuq6aLYle7xeQS44eYmOd4y1xqgYNTHoQ9brNJixXA4dI66j3KjSXypw0X7gGDO+5X
	b69tJtIqwhtXsj6CD1RmDljK/345VWeMCh7Fq4kR2U1Q98/TWDww3WcyUocGNq0HABxm/U4TUPG
	ihbs7Z2DVtR/jwBFgknfWbmg016F6RSpfCgp8U5GOsLiSEPj1D1SJtEzsz4AH5ONtVYNK2VZ9p0
	khrlYmk6xMj/HyhyIWlaSqpaaqhcR9gDDQtX5REkoDy5rt2QZ/mAOsOmQ/KnzHnedfwnqLDXb/B
	Yywdd32cd2H7LU2QLGZYyZ87lzyfuffzTDqpskmJP92FCkzcW4Gu3cR0XB6skbUMnR7xg5bH4A5
	0EmJohVsx2U9tV8LXow1TgTPrKcz4iHCHbjGeJ23pTNmorTyKPEfHVhePpQyPLhoSrESqEEs1Zy
	Lr+i4z6Crd6AoIXvD7LygUoQQlZL4Fot9wfIs=
X-Received: by 2002:a05:6a21:7a48:b0:38d:e87c:48c8 with SMTP id adf61e73a8af0-3944cfb9071mr925965637.60.1770870395559;
        Wed, 11 Feb 2026 20:26:35 -0800 (PST)
X-Received: by 2002:a05:6a21:7a48:b0:38d:e87c:48c8 with SMTP id adf61e73a8af0-3944cfb9071mr925942637.60.1770870395040;
        Wed, 11 Feb 2026 20:26:35 -0800 (PST)
Received: from hu-smagam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2997b3d8sm38722605ad.68.2026.02.11.20.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 20:26:34 -0800 (PST)
From: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3] wifi: mac80211: Fix AAD/Nonce computation for management frames with MLO
Date: Thu, 12 Feb 2026 09:56:01 +0530
Message-Id: <20260212042601.2250514-1-sai.magam@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rbxfAP-00PlS4WBg68KaTNa_6ZCAgkcQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDAyOSBTYWx0ZWRfX79fzS5qSHTAO
 ltKNON0DeFhdtPxoy8xPJ7vvtPq8WawMOKr1Zzoqs/nF2G907PVr/QgIFGNyfkp3rfjnNJKXoQr
 KOVQjcB5bwrAZ+LitAqPOrsZ+9gKXyhCnNs3fQcb76StBKOmsdkugB1ys6MevWwkcM2zHFSvsYe
 yEMNAN6Q8nR7IVOf3KlZQCQ5z3eBINcW4cnU5EdjILNhjVEPZ5sLZ7npj0DNaRJKw9LtZebIhAA
 nj0fAMomZVOVIcg8FlvmvqLg80IfZSD85NyvxF1N379NIlPi3Lv6x/43MwQNT6BelyJsJiZnw0O
 RArGqdW85q0uPqYVETwBRzOViTQ+VgoKn9rIJRaC8vd1mV3Y3mRHiJa0Y40LIzBgaxeI4Lp86Ki
 HDezDW8FUnd75NW7bd3NT7Kvd7GNhEKzcUpMIaOlBFda5tbA6Ei5DPH2Quegv9JY4j8QsKRTYz6
 fM5RT9algVdnvqAb9Rw==
X-Authority-Analysis: v=2.4 cv=ZaMQ98VA c=1 sm=1 tr=0 ts=698d567c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=7MNK-_SZza1dlcEbIjoA:9 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rbxfAP-00PlS4WBg68KaTNa_6ZCAgkcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_01,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120029
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31755-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sai.magam@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quicinc.com:email,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7198912A4EA
X-Rspamd-Action: no action

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

In the following manner, ensure that the right set of addresses are used:

In the receive path, stash the pre-translated link addresses in
ieee80211_rx_data and use them for the AAD/Nonce computations
when required.

In the transmit path, offload the encryption for a CCMP/GCMP key
to the hwsim driver that can then ensure that encryption and hence
the AAD/Nonce computations are performed on the frame containing the
right set of addresses, i.e, MLD addresses if unicast data frame and
link addresses otherwise.

To do so, register the set key handler in hwsim driver so mac80211 is
aware that it is the driver that would take care of encrypting the
frame. Offload encryption for a CCMP/GCMP key, while keeping the
encryption for WEP/TKIP and MMIE generation for a AES_CMAC or a
AES_GMAC key still at the SW crypto in mac layer

Co-developed-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
---
v2 -> v3:
Added support for data tx encryption offload and removed the
logic around additional key flag(IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD)

v1 -> v2:
Removed the additional address translation to link addresses approach
in the encrypt/decrypt path for management frames and instead the rx
path uses the stashed pre-translated link addresses for decryption and
in the tx path, encryption for mgmt frames is offloaded to hwsim driver

 drivers/net/wireless/virtual/mac80211_hwsim.c | 40 ++++++++++++-
 include/net/mac80211.h                        |  7 +++
 net/mac80211/ieee80211_i.h                    |  2 +
 net/mac80211/rx.c                             |  3 +
 net/mac80211/tx.c                             | 32 +++++++++++
 net/mac80211/wpa.c                            | 57 +++++++++++++++----
 6 files changed, 128 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..293603faf748 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1955,6 +1955,25 @@ mac80211_hwsim_select_tx_link(struct mac80211_hwsim_data *data,
 	return NULL;
 }
 
+static int mac80211_hwsim_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta,
+				  struct ieee80211_key_conf *key)
+{
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		break;
+	default:
+		return 1;
+	}
+
+	key->flags |= IEEE80211_KEY_FLAG_RESERVE_TAILROOM;
+	return 0;
+}
+
 static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_control *control,
 			      struct sk_buff *skb)
@@ -1965,7 +1984,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *channel;
 	struct ieee80211_vif *vif = txi->control.vif;
-	bool ack;
+	bool ack, unicast_data;
 	enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
 	u32 _portid, i;
 
@@ -1975,6 +1994,16 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		return;
 	}
 
+	unicast_data = is_unicast_ether_addr(hdr->addr1) &&
+		       ieee80211_is_data(hdr->frame_control);
+
+	if (unicast_data && ieee80211_encrypt_tx_skb(skb) < 0) {
+		ieee80211_free_txskb(hw, skb);
+		return;
+	}
+	/* re-assign hdr since skb data may have shifted after encryption */
+	hdr = (void *)skb->data;
+
 	if (vif && vif->type == NL80211_IFTYPE_NAN && !data->tmp_chan) {
 		/* For NAN Device simulation purposes, assume that NAN is always
 		 * on channel 6 or channel 149, unless a ROC is in progress (for
@@ -2060,6 +2089,13 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (!unicast_data && ieee80211_encrypt_tx_skb(skb) < 0) {
+		ieee80211_free_txskb(hw, skb);
+		return;
+	}
+	/* re-assign hdr since skb data may have shifted after encryption */
+	hdr = (void *)skb->data;
+
 	if (WARN(!channel, "TX w/o channel - queue = %d\n", txi->hw_queue)) {
 		ieee80211_free_txskb(hw, skb);
 		return;
@@ -4189,6 +4225,7 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
 	.start_nan = mac80211_hwsim_start_nan,                  \
 	.stop_nan = mac80211_hwsim_stop_nan,                    \
 	.nan_change_conf = mac80211_hwsim_change_nan_config,    \
+	.set_key = mac80211_hwsim_set_key,                     \
 	HWSIM_DEBUGFS_OPS
 
 #define HWSIM_NON_MLO_OPS					\
@@ -5621,6 +5658,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			    WIPHY_FLAG_AP_UAPSD |
 			    WIPHY_FLAG_SUPPORTS_5_10_MHZ |
 			    WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 	hw->wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR |
 			       NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 			       NL80211_FEATURE_STATIC_SMPS |
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7f9d96939a4e..bfd7d2a781ec 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7962,4 +7962,11 @@ int ieee80211_emulate_switch_vif_chanctx(struct ieee80211_hw *hw,
  * Return: %true iff the vif is a NAN interface and NAN is started
  */
 bool ieee80211_vif_nan_started(struct ieee80211_vif *vif);
+
+/**
+ * ieee80211_encrypt_tx_skb - Encrypt the transmit skb
+ * @skb: the skb
+ * Return: 0 if success and non-zero on error
+ */
+int ieee80211_encrypt_tx_skb(struct sk_buff *skb);
 #endif /* MAC80211_H */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e60b814dd89e..a4babf7624e5 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -256,6 +256,8 @@ struct ieee80211_rx_data {
 			u8 pn[IEEE80211_CCMP_PN_LEN];
 		} ccm_gcm;
 	};
+
+	u8 link_addrs[3 * ETH_ALEN];
 };
 
 struct ieee80211_csa_settings {
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 11d6c56c9d7e..e8eb38cbafc6 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5127,6 +5127,9 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 		hdr = (struct ieee80211_hdr *)rx->skb->data;
 	}
 
+	/* Store a copy of the pre-translated link addresses */
+	memcpy(rx->link_addrs, &hdr->addrs, 3 * ETH_ALEN);
+
 	if (unlikely(rx->sta && rx->sta->sta.mlo) &&
 	    is_unicast_ether_addr(hdr->addr1) &&
 	    !ieee80211_is_probe_resp(hdr->frame_control) &&
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 007f5a368d41..3562d9a6b70a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5316,6 +5316,38 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 	return 0;
 }
 
+int ieee80211_encrypt_tx_skb(struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_sub_if_data *sdata;
+	struct sk_buff *check_skb;
+	struct ieee80211_tx_data tx;
+	ieee80211_tx_result res;
+
+	if (!info->control.hw_key)
+		return 0;
+
+	memset(&tx, 0, sizeof(tx));
+	tx.key = container_of(info->control.hw_key, struct ieee80211_key, conf);
+	/* NULL it out now so we do full SW crypto */
+	info->control.hw_key = NULL;
+	__skb_queue_head_init(&tx.skbs);
+	__skb_queue_tail(&tx.skbs, skb);
+
+	sdata = IEEE80211_DEV_TO_SUB_IF(skb->dev);
+	tx.sdata = sdata;
+	tx.local = sdata->local;
+	res = ieee80211_tx_h_encrypt(&tx);
+	check_skb = __skb_dequeue(&tx.skbs);
+	/* we may crash after this, but it'd be a bug in crypto */
+	WARN_ON(check_skb != skb);
+	if (WARN_ON_ONCE(res != TX_CONTINUE))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ieee80211_encrypt_tx_skb);
+
 static void
 ieee80211_beacon_get_finish(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index fdf98c21d32c..2a66765b5c88 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -315,7 +315,8 @@ ieee80211_crypto_tkip_decrypt(struct ieee80211_rx_data *rx)
  * Calculate AAD for CCMP/GCMP, returning qos_tid since we
  * need that in CCMP also for b_0.
  */
-static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad, bool spp_amsdu)
+static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad, bool spp_amsdu,
+			bool aad_nonce_computed)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	__le16 mask_fc;
@@ -358,7 +359,8 @@ static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad, bool spp_amsdu)
 	 * FC | A1 | A2 | A3 | SC | [A4] | [QC] */
 	put_unaligned_be16(len_a, &aad[0]);
 	put_unaligned(mask_fc, (__le16 *)&aad[2]);
-	memcpy(&aad[4], &hdr->addrs, 3 * ETH_ALEN);
+	if (!aad_nonce_computed)
+		memcpy(&aad[4], &hdr->addrs, 3 * ETH_ALEN);
 
 	/* Mask Seq#, leave Frag# */
 	aad[22] = *((u8 *) &hdr->seq_ctrl) & 0x0f;
@@ -377,10 +379,10 @@ static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad, bool spp_amsdu)
 }
 
 static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad,
-				bool spp_amsdu)
+				bool spp_amsdu, bool aad_nonce_computed)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	u8 qos_tid = ccmp_gcmp_aad(skb, aad, spp_amsdu);
+	u8 qos_tid = ccmp_gcmp_aad(skb, aad, spp_amsdu, aad_nonce_computed);
 
 	/* In CCM, the initial vectors (IV) used for CTR mode encryption and CBC
 	 * mode authentication are not allowed to collide, yet both are derived
@@ -395,7 +397,8 @@ static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad,
 	 * Nonce Flags: Priority (b0..b3) | Management (b4) | Reserved (b5..b7)
 	 */
 	b_0[1] = qos_tid | (ieee80211_is_mgmt(hdr->frame_control) << 4);
-	memcpy(&b_0[2], hdr->addr2, ETH_ALEN);
+	if (!aad_nonce_computed)
+		memcpy(&b_0[2], hdr->addr2, ETH_ALEN);
 	memcpy(&b_0[8], pn, IEEE80211_CCMP_PN_LEN);
 }
 
@@ -488,7 +491,8 @@ static int ccmp_encrypt_skb(struct ieee80211_tx_data *tx, struct sk_buff *skb,
 
 	pos += IEEE80211_CCMP_HDR_LEN;
 	ccmp_special_blocks(skb, pn, b_0, aad,
-			    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU);
+			    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU,
+			    false);
 	return ieee80211_aes_ccm_encrypt(key->u.ccmp.tfm, b_0, aad, pos, len,
 					 skb_put(skb, mic_len));
 }
@@ -566,9 +570,23 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 		if (!(status->flag & RX_FLAG_DECRYPTED)) {
 			u8 aad[2 * AES_BLOCK_SIZE];
 			u8 b_0[AES_BLOCK_SIZE];
+			bool aad_nonce_computed = false;
+			bool unicast_data = is_unicast_ether_addr(hdr->addr1) &&
+					    ieee80211_is_data(hdr->frame_control);
+
+			if (!unicast_data) {
+				/* AAD computation */
+				memcpy(&aad[4], rx->link_addrs, 3 * ETH_ALEN);
+				/* Nonce computation */
+				ether_addr_copy(&b_0[2],
+						&rx->link_addrs[ETH_ALEN]);
+				aad_nonce_computed = true;
+			}
+
 			/* hardware didn't decrypt/verify MIC */
 			ccmp_special_blocks(skb, pn, b_0, aad,
-					    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU);
+					    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU,
+					    aad_nonce_computed);
 
 			if (ieee80211_aes_ccm_decrypt(
 				    key->u.ccmp.tfm, b_0, aad,
@@ -593,14 +611,15 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 }
 
 static void gcmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *j_0, u8 *aad,
-				bool spp_amsdu)
+				bool spp_amsdu, bool aad_nonce_computed)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 
-	memcpy(j_0, hdr->addr2, ETH_ALEN);
+	if (!aad_nonce_computed)
+		memcpy(j_0, hdr->addr2, ETH_ALEN);
 	memcpy(&j_0[ETH_ALEN], pn, IEEE80211_GCMP_PN_LEN);
 
-	ccmp_gcmp_aad(skb, aad, spp_amsdu);
+	ccmp_gcmp_aad(skb, aad, spp_amsdu, aad_nonce_computed);
 }
 
 static inline void gcmp_pn2hdr(u8 *hdr, const u8 *pn, int key_id)
@@ -690,7 +709,8 @@ static int gcmp_encrypt_skb(struct ieee80211_tx_data *tx, struct sk_buff *skb)
 
 	pos += IEEE80211_GCMP_HDR_LEN;
 	gcmp_special_blocks(skb, pn, j_0, aad,
-			    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU);
+			    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU,
+			    false);
 	return ieee80211_aes_gcm_encrypt(key->u.gcmp.tfm, j_0, aad, pos, len,
 					 skb_put(skb, IEEE80211_GCMP_MIC_LEN));
 }
@@ -763,9 +783,22 @@ ieee80211_crypto_gcmp_decrypt(struct ieee80211_rx_data *rx)
 		if (!(status->flag & RX_FLAG_DECRYPTED)) {
 			u8 aad[2 * AES_BLOCK_SIZE];
 			u8 j_0[AES_BLOCK_SIZE];
+			bool aad_nonce_computed = false;
+			bool unicast_data = is_unicast_ether_addr(hdr->addr1) &&
+					    ieee80211_is_data(hdr->frame_control);
+
+			if (!unicast_data) {
+				/* AAD computation */
+				memcpy(&aad[4], rx->link_addrs, 3 * ETH_ALEN);
+				/* Nonce computation */
+				ether_addr_copy(&j_0[0],
+						&rx->link_addrs[ETH_ALEN]);
+				aad_nonce_computed = true;
+			}
 			/* hardware didn't decrypt/verify MIC */
 			gcmp_special_blocks(skb, pn, j_0, aad,
-					    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU);
+					    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU,
+					    aad_nonce_computed);
 
 			if (ieee80211_aes_gcm_decrypt(
 				    key->u.gcmp.tfm, j_0, aad,

base-commit: 333225e1e9ead7b06e5363389403bdac72ba3046
-- 
2.34.1


