Return-Path: <linux-wireless+bounces-30350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 462E5CF234B
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 08:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8ABD3002897
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 07:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BC72D9792;
	Mon,  5 Jan 2026 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DLjYls6S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uiz2yhrh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A42D9494
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597933; cv=none; b=Jq3gFOVxp7uQD2HcHhNuX9RjibBQXv7QMztuuVrrXa04uCOy6CZzVFpPZKFBSjME8cUbufM/LHrSt+ENvvy/DKxZ/uMTvxE37ZvbHMZY8LQdEsIK8YudxS3RQZnQRzoxBrdiGEHG8egGChewfX3MyK27z7gLZ9Qdy1RaV1OFZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597933; c=relaxed/simple;
	bh=2DPdI+hEo7Cdi5jbNNJ5k/PGeUGAs1koI+uaFfFDFtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aemjqkcceJrd9pFZBaA5Zy48sQD+cJt920sUGXWvsjTF+BaqjiN2HGAN0wDURWvVWVrhGIcFYRfRKcttRcvQi4+NLA3NE4w39uLOf5qvy6msEGRjIH4q3J+Sx0DHPkX1tVvuHLeAveodjAkGbGt1DthBAg3oK++Rj0rm5Fn/JzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DLjYls6S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uiz2yhrh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6052onUp092865
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 07:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0QRaV9QhyMP
	hNnc5SrI5LoFY32T0CDX34qbmx4xdbJo=; b=DLjYls6SqqpUuW+70Cugqmfqh28
	xbEp2OWqn7grEGLowqXgANgv6zzGaCqAsk2TEq/rwxEtY2mS/bWCN230TsKMY3lo
	F2AnxXumQdCJObjmQVzjVnNOuxd5YmptQ80lTX4lQoXKHihexz7/fK8rHqAPgE16
	AAf0semct54NtQYm3aZi3G62zkYycwm2yxLIB141tRjJWajbnCgHW4ztltIDbun1
	EK6Ijrvj6B71z86ruKkPUSjpQw+XRByo2Fhi+VVlAqQudIRXjgHMFssSCuBYSRMc
	DSvExounqAJ7WZ7FUDKlsSHzVAbZvrd0Jv46TPKSPj9kuA11k9MsYl3NGSg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg4v60mpt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 07:25:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a089575ab3so174699805ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 23:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767597924; x=1768202724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QRaV9QhyMPhNnc5SrI5LoFY32T0CDX34qbmx4xdbJo=;
        b=Uiz2yhrhA29QqBgoMMJU7M2S1PKNx0chRRhrfRnvxduwFO0ya2p3J5KT4UtvW45QKE
         kFgtOUpoH3vW1SqXMtnsL8MUH6U0xPI0BLhAAnyKa7H5CT803cX+pNb7Oz1uLj0aPsD7
         kfoy/wh8mCF/DvAtNq3iR8XXG7PMSOsQ6jRYWD4QkgTcFHLv1ND+ZR14Bf4Oq2Mgb6GN
         UiAQ1gfqhQC1+vEDBb1mfUSCWNT6ZqrIgdiDwwrx3vH/6s6xuVeMRSh9CJvfANb/rnxe
         OFox5EM+B4QvsxfWgnDZ/c/t4AJ+YmWblpp0GnAcgQa94E6g51VSod379seu+ULnRnRS
         mVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597924; x=1768202724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0QRaV9QhyMPhNnc5SrI5LoFY32T0CDX34qbmx4xdbJo=;
        b=p4BmiAdmBdxYtPMt8o61mX+zcBl/8cnHYa6g6BY6Cgnc8ZCUrzNIm/2JU8/j4gwtNC
         MBWSpZkv5ZSMNxKqlL7ObuH8NIkx+9bLsaonQbENQGlKxK/8u73F3Brqg4f9wkZfknrX
         LrjXlffJ2ePAMe564o/bb9/OaMpNwMuy+opei2gzokjjXpDii31G3zkdxCse6SNvm6YJ
         Rxz4QLL6EatCCsBPK0WDV8/QV/jpS5wAINSDZlro+sgLFjYatg4lFc33guYsSozfYECI
         pjoepfCWRsqRpQb4ABYmINnIg6N//SenD6eHvwo1gqNCpA3g+TSmQf55FG1V3Ky0G4lt
         a1IQ==
X-Gm-Message-State: AOJu0YwfEOiM/HArdWCaGpwF6xO38NQRCfZH8xszKqhA5n2OQgx8kB9i
	8EIWQavhz+Y3nugDE8ly39tkPxCkxwzY9hhAjXrBYZEormZLcy/fiX7UT0pDkB5MkgYj05FdSzX
	6iXBkxaxcpKaKbCQH9kYljrupO2v55G7QrON8dD8EmBq4D7oXKXjm924JvZK6WMmQD1IB5g==
X-Gm-Gg: AY/fxX4pQebV6G6CxIWBSFdSXjsBzhb4c5sYzBUtZOLESJyga0LfHtSJo8O01gNHxe6
	KKFkiMv7I8LhytHNGK/IH+5rPnezukDVauCPdyEAXSwCb6v+XBBiJ0Q0U0QEtglq8sPO99l86oU
	g9d00xe3vzn2MpTbzcyERW2eN07p3TWv+93ve19G2zbLESM1ii3z5RQJeoE3mDJtLd3pqffrptS
	+3oW+isFf5ZLygHhk6z1qlH299nGSWAdWE1h+S4mAVKhpBGZpdgm78TAuJ82XPJ6mO25mNRW/j1
	d4Z9o2STdVjD1MvTsqL5kA/MZn2O+zdEWlqGOGsNWX0+Zp6vSylpdhAxokzwRd5f8zUemU7SPYg
	B6rPIXBEZP1nFP5kGCZrJBC6pkjVJ4SN86YSMZHxFFA==
X-Received: by 2002:a17:903:2342:b0:2a0:d5b0:dd80 with SMTP id d9443c01a7336-2a2f2a3ae13mr434477485ad.54.1767597924421;
        Sun, 04 Jan 2026 23:25:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+UYOg4oaviQA7wVVHNd9uf2RtVEuOgVUhuQ7cSFTMmBJO33W45j69a/Hr+ByJ2yhrgqRIiA==
X-Received: by 2002:a17:903:2342:b0:2a0:d5b0:dd80 with SMTP id d9443c01a7336-2a2f2a3ae13mr434477385ad.54.1767597923889;
        Sun, 04 Jan 2026 23:25:23 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm445201205ad.34.2026.01.04.23.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:25:23 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 8/9] wifi: mac80211: add support for encryption/decryption of (Re)Association frames
Date: Mon,  5 Jan 2026 12:54:14 +0530
Message-Id: <20260105072415.3472165-9-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
References: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA2NSBTYWx0ZWRfX4gmRH3Tpq6CT
 I4a4QUr8cwj7Tc9wkVESxy+rmXuemg2f77MTBDCc+TrRMjR+IlgJIRJgY53cPuAi4GJ7HKeGQF5
 OirqqdOkN98rat3Wry5ChDXo92o2JkD2sXL2L+i5vZIHuMQ9R5nIom4hJay4fWOAlNgDOvmshjD
 RK8+ALqndJbYKQrhoiJLBIkoKdJOMaiEY5OoYoB/K9r76E1OFLC4Isrbb9MxazfPIM6UF8H0zWA
 PJGQgEyxCtaBKGLEzg0c4ikiMu7+sAYkPyTTQgcSnU+2jdagWWY8GCJni/TmuWqGhfYNopqfy32
 T+bi50obj9FnL70AiksA5l5/gcsdi9C/hsXkmfGz+U+8WLJlUwrCK/kqqUsNpOY5fN69/rFQAS8
 422xc8yA83KInTDtY6mvv67phlxTkSmoR59oT/v6uFliAQKm4bOhtZNSk0Wx7erB/1NuEXCdugE
 7ocBIWYkmZ5Gg/Iz4HQ==
X-Proofpoint-ORIG-GUID: LJuKpuQPgQbams_KBQmB2rqz6HehFvVV
X-Authority-Analysis: v=2.4 cv=c4ymgB9l c=1 sm=1 tr=0 ts=695b6765 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=8giNfzjRwmsRsLzGhRgA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: LJuKpuQPgQbams_KBQmB2rqz6HehFvVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050065

Currently, mac80211 does not encrypt or decrypt (Re)Association frames
(Request and Response) because temporal keys are not yet available at
that stage.

With extensions from IEEE P802.11bi, e.g. EPPKE, temporal keys can be
established before association. This enables the encryption and
decryption of (Re)Association Request/Response frames.

Add support to unset the IEEE80211_TX_INTFL_DONT_ENCRYPT flag when
the peer is marked as an Enhanced Privacy Protection (EPP) peer and
encryption keys are available for the connection in non-AP STA mode,
allowing secure transmission of (Re)Association Request frames.

Dropn unprotected (Re)Association Request/Response frames received from
an EPP peer.

Co-developed-by: Sai Pratyusha Magam <quic_smagam@quicinc.com>
Signed-off-by: Sai Pratyusha Magam <quic_smagam@quicinc.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/ieee80211_i.h |  8 ++++++++
 net/mac80211/mlme.c        | 13 ++++++++++++-
 net/mac80211/rx.c          |  8 ++++++++
 net/mac80211/tx.c          |  4 +++-
 net/mac80211/wpa.c         |  6 ++++--
 5 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 50fd5e83ed6d..0ff145a04aa0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2393,6 +2393,14 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb, int tid, int link_id,
 				 enum nl80211_band band);
 
+static inline bool ieee80211_require_encrypted_assoc(__le16 fc,
+						     struct sta_info *sta)
+{
+	return (sta && sta->sta.epp_peer &&
+		(ieee80211_is_assoc_req(fc) || ieee80211_is_reassoc_req(fc) ||
+		 ieee80211_is_assoc_resp(fc) || ieee80211_is_reassoc_resp(fc)));
+}
+
 /* sta_out needs to be checked for ERR_PTR() before using */
 int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
 			    struct sk_buff *skb,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4f3ef3d3d4ec..1dce7dae89bf 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2155,6 +2155,8 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_prep_tx_info info = {};
 	unsigned int link_id, n_links = 0;
 	u16 present_elems[PRESENT_ELEMS_MAX] = {};
+	bool assoc_encrypt = false;
+	struct sta_info *sta;
 	void *capab_pos;
 	size_t size;
 	int ret;
@@ -2335,7 +2337,16 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	info.link_id = assoc_data->assoc_link_id;
 	drv_mgd_prepare_tx(local, sdata, &info);
 
-	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
+	sta = sta_info_get_bss(sdata, sdata->vif.cfg.ap_addr);
+
+	if (sta && sta->sta.epp_peer &&
+	    wiphy_dereference(sdata->local->hw.wiphy, sta->ptk[sta->ptk_idx])) {
+		assoc_encrypt = true;
+	}
+
+	if (!assoc_encrypt)
+		IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
+
 	if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
 		IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS |
 						IEEE80211_TX_INTFL_MLME_CONN_TX;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e0ccd9749853..3fd5885c7f69 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2609,6 +2609,14 @@ ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 	    (!rx->sta || !test_sta_flag(rx->sta, WLAN_STA_ASSOC)))
 		return RX_DROP_U_UNPROT_ROBUST_ACTION;
 
+	/*
+	 * Drop unprotected (Re)Association Request/Response frame received from
+	 * an EPP Peer.
+	 */
+	if (!ieee80211_has_protected(fc) &&
+	     ieee80211_require_encrypted_assoc(fc, rx->sta))
+		return RX_DROP_U_UNPROT_UCAST_MGMT;
+
 	return RX_CONTINUE;
 }
 EXPORT_SYMBOL_IF_MAC80211_KUNIT(ieee80211_drop_unencrypted_mgmt);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 9d8b0a25f73c..2aabab6cc0ff 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -640,7 +640,9 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 			if (!ieee80211_is_data_present(hdr->frame_control) &&
 			    !ieee80211_use_mfp(hdr->frame_control, tx->sta,
 					       tx->skb) &&
-			    !ieee80211_is_group_privacy_action(tx->skb))
+			    !ieee80211_is_group_privacy_action(tx->skb) &&
+			    !ieee80211_require_encrypted_assoc(hdr->frame_control,
+							       tx->sta))
 				tx->key = NULL;
 			else
 				skip_hw = (tx->key->conf.flags &
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 4a858112e4ef..fdf98c21d32c 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -527,7 +527,8 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 	hdrlen = ieee80211_hdrlen(hdr->frame_control);
 
 	if (!ieee80211_is_data(hdr->frame_control) &&
-	    !ieee80211_is_robust_mgmt_frame(skb))
+	    !ieee80211_is_robust_mgmt_frame(skb) &&
+	    !ieee80211_require_encrypted_assoc(hdr->frame_control, rx->sta))
 		return RX_CONTINUE;
 
 	if (status->flag & RX_FLAG_DECRYPTED) {
@@ -723,7 +724,8 @@ ieee80211_crypto_gcmp_decrypt(struct ieee80211_rx_data *rx)
 	hdrlen = ieee80211_hdrlen(hdr->frame_control);
 
 	if (!ieee80211_is_data(hdr->frame_control) &&
-	    !ieee80211_is_robust_mgmt_frame(skb))
+	    !ieee80211_is_robust_mgmt_frame(skb) &&
+	    !ieee80211_require_encrypted_assoc(hdr->frame_control, rx->sta))
 		return RX_CONTINUE;
 
 	if (status->flag & RX_FLAG_DECRYPTED) {
-- 
2.34.1


