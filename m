Return-Path: <linux-wireless+bounces-31638-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDyFIgRHiGnhmwQAu9opvQ
	(envelope-from <linux-wireless+bounces-31638-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Feb 2026 09:19:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE39F10817C
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Feb 2026 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA21530099BF
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Feb 2026 08:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA6D2836B1;
	Sun,  8 Feb 2026 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bTCB67XH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AK6H9fFN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9222339
	for <linux-wireless@vger.kernel.org>; Sun,  8 Feb 2026 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770538752; cv=none; b=VmWFwedgMiT85ZzdZ6UkgsEsfvLbK9C61JFFfgTe+w6TCe31spZECcQsoOo8ssK+WG2k2zHGgiR177RY2sAcE6Kh3qwil3InCfdkdienhst6HMXpzcDU+LldptbRPvK6KiQ9SZHvy1nkdl6f2S2Zbk4azgV1KR/UugHM2c1+AgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770538752; c=relaxed/simple;
	bh=u64B/zm+YjloAFkZcUJUzOfdciS9KZXGLI1ltNDtwcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DnW7jDaBIsNL/VfyXd2JOhAioRLbMF7aAOxBl2XmqPaT89ZzeIYXdNel/Xb9+YGeQm0ftrrtkKmFL1r5+qrgDI5SJBqd5V1Ji9gASZj1YTM96AoFwOo8JEx5yRFE4y8SPnG10NVpxdpnB1v6X4CV4YpG5aUkThnpZKODqNPj82Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bTCB67XH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AK6H9fFN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6187sVng4143705
	for <linux-wireless@vger.kernel.org>; Sun, 8 Feb 2026 08:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qBQvyr+7/vQ+6EBjUfgFkESAIB3iRDQVq4y
	UHHwLJaQ=; b=bTCB67XHEbNpFaF8ufnNPQS2oc/3zZjBg48+E2uiUU2JNHxTqId
	TsKwMunYoB1ftuAky/fG8LqrX2xKX6vJopJCULa/bWizl0Yt7G6QAOBz7I0IOtpV
	1SvrtFhUVcvwpT/0PRyUPJBfNb6uzoaRI1ZmnOgdEkcmZAT+4tACG7qcH+JM9PgC
	cltn21WvvpoPEeMiPdyEP37TAZpVvb++AA6BTkDvneo5MgTR96+n7RCCV2+zaz5x
	fp5Pgkz6pIwybIYqqcfyL927H5qKOuXtgsy4gmWey8sfSG3V5wdGYbTAlKRp8fW1
	8O4eTsAzgBPS5RqhCKcbyahCZgYEvaiDGKw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xcct2s2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 08 Feb 2026 08:19:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c337cde7e40so2184219a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 08 Feb 2026 00:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770538750; x=1771143550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qBQvyr+7/vQ+6EBjUfgFkESAIB3iRDQVq4yUHHwLJaQ=;
        b=AK6H9fFNLJshv1DrdRKt23qoU+etdWY3PFlTQ2s7ZS6XCMRzIWAUI7WL0rEAPcOpil
         WhOEJyfmFx4aQwEXMNIMy1o0eOvniG6Yf8bvUQYyvfJ2pK8qXdgxgQXJ7d4DjCK5X2Hm
         hIWeR2cNW28dXK2VgvQ34wQdiINyH/ZTw2R2mzx50CNmwt9+YsJ29YnxZkWsEDbZ4+9V
         fVdTK+QIYX/XKH7SMdxSdO3D7K0P+VBksk/vg+cUSwW5jpryH7H8TrL1kK3NOZoikLNX
         1IRAPuXDYkZyHASaR8tDoYClaJrtowhszyZKz7ojfxc5KY/QY3h0P051NfXZCxXfqFea
         ooKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770538750; x=1771143550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBQvyr+7/vQ+6EBjUfgFkESAIB3iRDQVq4yUHHwLJaQ=;
        b=NIMtGAKPzUDIacQxs3/xEF+hAkg5XTmSztM+b04ErO7GZHUza9t4HmcYztwxfaU21j
         vrDDVvJY1LCiyxfnvwYKtk2yyWA14z8MilUgYNSy4EZubMfpR2sOIpvTr1ZzeGBbvYAS
         fTgsHYSyHPHVz+lPKOvEBaR5A1zcd5SoxKz9b2WFIyTMQ3X5aMi0actjep6bF+02cGIh
         7xzHbHzK8TZioAJOdR4gMCCnCyN93CzEITSHHVjziKzlhnYoNGq1Em4XZqDRjZfLNxxj
         ax4AuWcEou7MUsq8m4woKHj90RYjDG81X7Rw4ktuzC2GWGHWjj8THyGqMpJZ86bj4b+1
         /5ug==
X-Gm-Message-State: AOJu0Yyhd0h88a9RVdP1j6OHXw/WxdkB8uYGgmKqtBRXKVtAeBIefWb4
	u6sljHIMmGrILwl6ABzPKsud9YVGBhmF02MP63wcxOWWEliqXHQoqxM64RHBG4nTqe97Fdg0vgO
	AtQlZjb8RbuzIWN1C1j9WzkAdWfFMmwyEEokLwRO9RSVAELxSODpv35gHUtfSWz8iEEJOZg==
X-Gm-Gg: AZuq6aLBuNz2iZJnMwa2PSyZwGK3cY0II/VE5hOnOLr/y1hmblnqB2EOk5B6pfn7mjq
	6m+hgW7rJonEfIET/o+8xHeTDPaKfLO0M93QHtR4x83yghHO+mJWlCrp0QARRNaJnvT0lByi3xv
	ZFVn6gG60t0IuMk2C/UoUem70AFzwki3MM7F0YzPRnZAw8y076DvO9TnQHq67NeP0Itu/bYzT1+
	c49/vAvLMWirdRQkZrFfGubVuqG9TOSP78x0/30f9qunXnCLPokR0+jA7qK8hJRm1oJ042jAoEz
	F95wfGKKYRASyEsafzzMYs/pfM9V5SUi7smi6gVihDP1Z5O8b4RbWpH68zKaQWPmolQsHWYlka2
	POOUoEpqY1LoAGPLOhe7fWlymhn9H7Vyk2XyXS1hlkoMv15CNoCrFigDaZPHTenr0vzEEI2ALn7
	be4TSAmbaBqsG1EONYAj0Anvg=
X-Received: by 2002:a05:6a20:72a2:b0:38b:ecae:6713 with SMTP id adf61e73a8af0-393acff6c80mr7960190637.19.1770538749770;
        Sun, 08 Feb 2026 00:19:09 -0800 (PST)
X-Received: by 2002:a05:6a20:72a2:b0:38b:ecae:6713 with SMTP id adf61e73a8af0-393acff6c80mr7960175637.19.1770538749207;
        Sun, 08 Feb 2026 00:19:09 -0800 (PST)
Received: from hu-smagam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb520f1csm6731178a12.9.2026.02.08.00.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 00:19:08 -0800 (PST)
From: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2] wifi: mac80211: Fix AAD/Nonce computation for management frames with MLO
Date: Sun,  8 Feb 2026 13:48:54 +0530
Message-Id: <20260208081854.1080048-1-sai.magam@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDA2OCBTYWx0ZWRfX9mHKVQLEkm5w
 EGT6++mQepQBppC4aGAOgdGWM3cNQE95k6ATW96RG4Oa5A28f53QQm7qVXF6E9sQ8pMx7j++269
 AnfurRPy7SMrb5tNKll+pyMvGap+4P2yAOpFIt0eOr1T2MokmCQC54vY9eTDXBoKusSdKSJXGmF
 GM09q4QmjNQf7hyqkyqZNf+4rivsVNW59WSFoPKM29kZtdJdP+tOv7OapkXtzi2HvecRFz/SFYk
 reUBv+kQgdqL/srt86ec7TFnNHDgcxtUvlAVWFW8Pf6ov2ty/cgzbCqtYxBpukqjHB5NuK8NGc+
 +y3Lssrh9WUSTV6srL180vizcnSy/M9FiuJRZQNd3ygxyeCYjaSlMaVLM5jzQeU4n4Vj2CfTLmk
 gS8vG1hOXvb7SFr9C+Pk09xUM6QISJK3eCTjMKkb+aNLrPYbRe1ByydQIJwOF0LXLbXX+rccbuQ
 pTBIuM1N3z1nvOljo1A==
X-Proofpoint-GUID: N2TIAN6IBb9PQ-gQW-cCsnrX0HZkrPuI
X-Authority-Analysis: v=2.4 cv=ft/RpV4f c=1 sm=1 tr=0 ts=698846fe cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ZKlVqHB7-Z5ocRE61TsA:9 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: N2TIAN6IBb9PQ-gQW-cCsnrX0HZkrPuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_02,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602080068
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31638-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sai.magam@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EE39F10817C
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
ieee80211_rx_data and use them for the AAD/Nonce computations in the
decrypt path for robust management frames (MFP) and (Re)Association
Request/Response frames that require encryption (EPP)

In the transmit path, offload the encryption of robust
management frames (MFP) and (Re)Association Request/Response
frames that require encryption (EPP) to the hwsim driver that
can then ensure that encryption and hence the AAD/Nonce computations
are performed on the frame containing the link addresses.

To do so, register the set key handler in hwsim driver so mac80211 is
aware that it is the driver that would take care of encrypting the
frame. The key flag IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD selectively
offloads only encryption of management frames, while keeping the
encryption for data frames and MMIE generation for a AES_CMAC or a
AES_GMAC key still at the SW crypto in mac layer

The hybrid way of having both HW/driver based crypto for certain frames
and SW crypto for others require that the fast-xmit path be skipped
when the above mentioned key flag is set, since data frames still rely
on software based crypto and also that sufficient tailroom is always
reserved in the skb for ICV/MIC addition.

Co-developed-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
---
v1 -> v2:
Removed the additional address translation to link addresses approach
in the encrypt/decrypt path for management frames and instead the rx 
path uses the stashed pre-translated link addresses for decryption and
in the tx path, encryption for mgmt frames is offloaded to hwsim driver

 drivers/net/wireless/virtual/mac80211_hwsim.c | 19 ++++++
 include/net/mac80211.h                        | 11 ++++
 net/mac80211/cfg.c                            |  4 +-
 net/mac80211/ieee80211_i.h                    | 15 +++++
 net/mac80211/rx.c                             |  3 +
 net/mac80211/tx.c                             | 60 ++++++++++++++++++-
 net/mac80211/wpa.c                            | 57 ++++++++++++++----
 7 files changed, 153 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..9a364c6774a5 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1955,6 +1955,16 @@ mac80211_hwsim_select_tx_link(struct mac80211_hwsim_data *data,
 	return NULL;
 }
 
+static int mac80211_hwsim_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta,
+				  struct ieee80211_key_conf *key)
+{
+	key->flags |= IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD |
+		      IEEE80211_KEY_FLAG_RESERVE_TAILROOM;
+	return 0;
+}
+
 static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_control *control,
 			      struct sk_buff *skb)
@@ -2060,6 +2070,13 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (ieee80211_encrypt_tx_skb(skb) < 0) {
+		ieee80211_free_txskb(hw, skb);
+		return;
+	}
+	/* re-assign hdr since skb data may have shifted after encryption */
+	hdr = (void *)skb->data;
+
 	if (WARN(!channel, "TX w/o channel - queue = %d\n", txi->hw_queue)) {
 		ieee80211_free_txskb(hw, skb);
 		return;
@@ -4189,6 +4206,7 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
 	.start_nan = mac80211_hwsim_start_nan,                  \
 	.stop_nan = mac80211_hwsim_stop_nan,                    \
 	.nan_change_conf = mac80211_hwsim_change_nan_config,    \
+	.set_key = mac80211_hwsim_set_key,                     \
 	HWSIM_DEBUGFS_OPS
 
 #define HWSIM_NON_MLO_OPS					\
@@ -5621,6 +5639,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			    WIPHY_FLAG_AP_UAPSD |
 			    WIPHY_FLAG_SUPPORTS_5_10_MHZ |
 			    WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 	hw->wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR |
 			       NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 			       NL80211_FEATURE_STATIC_SMPS |
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7f9d96939a4e..69530aa913be 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2242,6 +2242,9 @@ static inline bool lockdep_vif_wiphy_mutex_held(struct ieee80211_vif *vif)
  *	number generation only
  * @IEEE80211_KEY_FLAG_SPP_AMSDU: SPP A-MSDUs can be used with this key
  *	(set by mac80211 from the sta->spp_amsdu flag)
+ * @IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD: This flag should be set by
+ *	the driver for a key if encryption of only management frames (MFP)
+ *	is offloaded to the driver
  */
 enum ieee80211_key_flags {
 	IEEE80211_KEY_FLAG_GENERATE_IV_MGMT	= BIT(0),
@@ -2256,6 +2259,7 @@ enum ieee80211_key_flags {
 	IEEE80211_KEY_FLAG_NO_AUTO_TX		= BIT(9),
 	IEEE80211_KEY_FLAG_GENERATE_MMIE	= BIT(10),
 	IEEE80211_KEY_FLAG_SPP_AMSDU		= BIT(11),
+	IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD  = BIT(12),
 };
 
 /**
@@ -7962,4 +7966,11 @@ int ieee80211_emulate_switch_vif_chanctx(struct ieee80211_hw *hw,
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
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5d04d7d550b0..d48a53ebb98f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -885,7 +885,9 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 			     offsetof(typeof(kseq), gcmp));
 
 		if (key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE &&
-		    !(key->conf.flags & IEEE80211_KEY_FLAG_GENERATE_IV)) {
+		    !(key->conf.flags & IEEE80211_KEY_FLAG_GENERATE_IV) &&
+		    !(key->conf.flags &
+		      IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD)) {
 			drv_get_key_seq(sdata->local, key, &kseq);
 			memcpy(seq, kseq.ccmp.pn, 6);
 		} else {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e60b814dd89e..5fe561fd09f2 100644
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
@@ -2404,6 +2406,19 @@ static inline bool ieee80211_require_encrypted_assoc(__le16 fc,
 		 ieee80211_is_assoc_resp(fc) || ieee80211_is_reassoc_resp(fc)));
 }
 
+static inline bool ieee80211_require_sw_tx_enc(__le16 fc, u16 flags,
+					       struct sta_info *sta,
+					       struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	bool unicast_robust_mgmt = is_unicast_ether_addr(hdr->addr1) &&
+				   ieee80211_is_robust_mgmt_frame(skb);
+
+	return ((flags & IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD) &&
+		!unicast_robust_mgmt &&
+		!ieee80211_require_encrypted_assoc(fc, sta));
+}
+
 /* sta_out needs to be checked for ERR_PTR() before using */
 int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
 			    struct sk_buff *skb,
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
index 007f5a368d41..ca756868594d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -632,6 +632,11 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 		case WLAN_CIPHER_SUITE_TKIP:
 			if (!ieee80211_is_data_present(hdr->frame_control))
 				tx->key = NULL;
+			else
+				skip_hw = ieee80211_require_sw_tx_enc(hdr->frame_control,
+								      tx->key->conf.flags,
+								      tx->sta,
+								      tx->skb);
 			break;
 		case WLAN_CIPHER_SUITE_CCMP:
 		case WLAN_CIPHER_SUITE_CCMP_256:
@@ -645,9 +650,13 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 							       tx->sta))
 				tx->key = NULL;
 			else
-				skip_hw = (tx->key->conf.flags &
-					   IEEE80211_KEY_FLAG_SW_MGMT_TX) &&
-					ieee80211_is_mgmt(hdr->frame_control);
+				skip_hw = ((tx->key->conf.flags &
+					    IEEE80211_KEY_FLAG_SW_MGMT_TX) &&
+					ieee80211_is_mgmt(hdr->frame_control)) ||
+					ieee80211_require_sw_tx_enc(hdr->frame_control,
+								    tx->key->conf.flags,
+								    tx->sta,
+								    tx->skb);
 			break;
 		case WLAN_CIPHER_SUITE_AES_CMAC:
 		case WLAN_CIPHER_SUITE_BIP_CMAC_256:
@@ -655,6 +664,11 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 		case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 			if (!ieee80211_is_mgmt(hdr->frame_control))
 				tx->key = NULL;
+			else
+				skip_hw = ieee80211_require_sw_tx_enc(hdr->frame_control,
+								      tx->key->conf.flags,
+								      tx->sta,
+								      tx->skb);
 			break;
 		}
 
@@ -3205,6 +3219,13 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 		if (!(build.key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
 			goto out;
 
+		/* Only management frame encryption is offloaded to the driver,
+		 * So skip fast-xmit
+		 */
+		if (build.key->conf.flags &
+		    IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD)
+			goto out;
+
 		/* Key is being removed */
 		if (build.key->flags & KEY_FLAG_TAINTED)
 			goto out;
@@ -5299,6 +5320,7 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 	}
 
 	if (!(tx.key->conf.flags & IEEE80211_KEY_FLAG_SW_MGMT_TX) &&
+	    !(tx.key->conf.flags & IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD) &&
 	    tx.key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
 		IEEE80211_SKB_CB(skb)->control.hw_key = &tx.key->conf;
 
@@ -5316,6 +5338,38 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
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
index fdf98c21d32c..9d10e82fcf1c 100644
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
+
+			if (ieee80211_is_robust_mgmt_frame(skb) ||
+			    ieee80211_require_encrypted_assoc(hdr->frame_control,
+							      rx->sta)) {
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
+
+			if (ieee80211_is_robust_mgmt_frame(skb) ||
+			    ieee80211_require_encrypted_assoc(hdr->frame_control,
+							      rx->sta)) {
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


