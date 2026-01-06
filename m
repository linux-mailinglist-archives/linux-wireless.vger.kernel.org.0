Return-Path: <linux-wireless+bounces-30409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89264CF90BA
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 16:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F77C301EA25
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EE1345743;
	Tue,  6 Jan 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZh2Sxwx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CVkBAACz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BE1345740
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713137; cv=none; b=Q/x4fHTKdixz6B6nEB+ypqvATw5BkqNWZ9cgzMjgC6aNoISgGD4FIBIgNKH7vMXGFEtkogaz/GLGDyS5uqIho0deJ/tfAP++3qlHtraS4mVUo9re1Hi1SdjOeAE9UUTK/QVJgWp2xSub9Qhk5zK1B8e09w5+mk0zqg+2jRn0wEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713137; c=relaxed/simple;
	bh=1rjypmI+eRHYjR3MerOjvOPP2DiyAagi4nwai9nSWAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3/9VbKvUpyBlS0KgVoQlcEGjALzPnPjyfcAnCwMCx6dgObTho+2O1U5+9kbl+sdESudO/+g2tbntoLYb+s4OVFzaUrjB4LBWAPWdox1p4gZkME9cOFba/ZpL0TxDX3moFR32ULreZfUYdaJra2cx9+61lMEK+EoV9Ez9/LbkzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pZh2Sxwx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CVkBAACz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606B1WPI3272106
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 15:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yA6Ge1z/k9J
	tXguyU5oXMvEq67PowjWtFd8Dyd4vZcM=; b=pZh2SxwxkOtv8UayEVcMonTMUBC
	cBjGF/VTUJNDcUZSzISgPQRLF1DzgB1lZGS8DGGWTD9X/IB9IHQWyn6lECScI2XJ
	AtShwoU9y0t+8zDDKCH65aHZi60H+O5zPOMrL8VvtygvF+zMS6/NwtKFHjfL/agt
	vQuQwLD7TmLEbEkMDENNhjCxySKvypHOEl+rUwmuobc7B6ytR9FDGz++28ObCwpy
	IolMaxxF/WBB/ee0MNo4ydvmoTaaNkLCEnLvPmPHQJVhWa7aRhdh5BLnkmgtr9+8
	SKY8BandMsc0fBiSaVBq7tJPgdo+h4vhsDUjH2LPbxuuqU9KjPlN8svBbkw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv03r5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 15:25:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f13989cd3so30826085ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 07:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767713134; x=1768317934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yA6Ge1z/k9JtXguyU5oXMvEq67PowjWtFd8Dyd4vZcM=;
        b=CVkBAACzWP5lFrQTwmtK7iICoWBpum87+8iClNnkTqSucCmI3HPaK4+GVq9aIQWllf
         JSqM4An6WW5NHICfzeFXoITLTjgSRUR6bGK19b30BqZCwAQylOThM5jiMWz8oUXt2H5y
         pahasda12ra09L6aDPgZS8HxOE8TvKkw5pahSk6iR4woUl1D6rzy57G+LFBkdQ7vhPMS
         sgyQz0EtbH1CP4thy1T9FqIx/GTiWESm7UfWzA6WA1ieaWnOoK8mJ7ikaOkfLU6FmaB5
         fnxKoOu7PTaSsMwG6k85J0X9smJnOupX07q5XDt5K4I+ba4W9GU4Gr2rwuH5nz0/EaBj
         CWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713134; x=1768317934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yA6Ge1z/k9JtXguyU5oXMvEq67PowjWtFd8Dyd4vZcM=;
        b=emR+B5uxLU9pegC8ZCuQSQJFfSKgKbRJho+8PI7bDiKB1+1V2HL3kQmnfUXF9KOEBM
         0QL5+LbvZ3RLFPjY2hgf1fJoq3yOdoVR09IGIrl0FAhAhFKYJV7qaSuyKjPlAqNbpJs1
         3MSUs9yqHoKGRop3FsWXpgh1XxtOcUztR0xnKvmvUtdD7iWw9qOlnuO3Fz8uSCKh8aC6
         VsUCE685WexQRvpuDEaADf6d8AFhyv9EY0juXGym+TE0GWqp4VV822ZzJVFoXNZPzI0Q
         IlTUDIIgWU5V+kQWaUn9sjzYNmc7nzJYAm7ZVh98V4Fgw71XdF817syngpoD/gSS/+n+
         6cFw==
X-Gm-Message-State: AOJu0Yw5NyaurERVnXbAxkVZ7h9INE0NwdRTzAmrIlDY1Z8BLrQH4d7d
	prWA05KPLdmdIqn9b2/q+gjBwiMDrnNmONVBMMo2oJBJU+fruu5laZe2Xp7oFsOFwCsT/TG3Z0n
	40Ll33j8CT4d2VjQejTNP/yHB7UQzcGaiOCDaq2gVW+7PB2uZqLfLwLgOCFXfq8Jvet4kdA==
X-Gm-Gg: AY/fxX65K7wZ7S8iQbSIX+ZFyrm13w8OXcE4d5z33B3QJjGF9TSAC4pE2Zo2DMLLZSA
	b4mNb8gjMH7WQZ3matchEvLb02pr8W01Co7X0igZIU1Cjtgf9tu0CwVX+8sIQI11T0jMXdQitFt
	J5453P2gtWWzZ/2CQpqvqsQzOPCh0ltulw8DbvynGcKKDfnU7jHnIGM4GTrtO2iEfud5X9bMj/h
	VhVFQ96mzTpyySt9bSThokBegjTwrl2HCe7jySVJ3ZrLo7x0Ux1A/w7eoo6i52YPP2K3hEUmzHd
	cjCLy76aHUlDhGPinkkkSTSBYRebkWmvEGT4Q53Gj4cw0gdVpEUw55pGu3Bc6olsz7seQr50Sfo
	euUg2CqTe1BRxpV/xolagbcJe/Sf0eB3rwM3jYeoAgQ==
X-Received: by 2002:a17:902:d547:b0:2a0:d692:5681 with SMTP id d9443c01a7336-2a3e2da7892mr33987805ad.24.1767713134253;
        Tue, 06 Jan 2026 07:25:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/67CazUrMcoDfBuKdCkZODvg94bGEzunGaPPEitAGyZWc31BWVVHMfoFZAJicv00LEVtdYA==
X-Received: by 2002:a17:902:d547:b0:2a0:d692:5681 with SMTP id d9443c01a7336-2a3e2da7892mr33987555ad.24.1767713133737;
        Tue, 06 Jan 2026 07:25:33 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2ea0sm26343595ad.62.2026.01.06.07.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:25:33 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 8/9] wifi: mac80211: add support for encryption/decryption of (Re)Association frames
Date: Tue,  6 Jan 2026 20:55:02 +0530
Message-Id: <20260106152503.223216-9-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695d296e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=IsckVGhRMFeyOBZFPTYA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: t9eSsco7DnR6zS36VEgSZlZUqENQ2ZGH
X-Proofpoint-ORIG-GUID: t9eSsco7DnR6zS36VEgSZlZUqENQ2ZGH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzNCBTYWx0ZWRfX/f/g/LvQ3/Jd
 80xMusbmWChZSU18BalbAA/2eHlZQOJt6l/SvmmWUKCNy8D9qA+bJSxgwYAoMvJMdgflIk4bF0d
 Hhn2F3elc94fROAxsjHCw4oCshUp5gHe9hQg/MIbp8odBuBGvUj/0gC09f3+N4NZtQvjqyhzJnU
 RBC3zApg+qUwQ7IZCST4BmWw+kvCqRmz1eCvwcOJP8OC/J/cFvLwy40Eyy5PZpvGwIlDpecxL4g
 m4fT7IULCK9wkAa54PS9HR0Z/cmfyjc9RcGx5rITPUTd5nIuZc/miOrWOrKFzMVTdXykM6ex4bt
 fvzjlQgVGk3zmXhhXFdx61vr3YQHLvj5B9+KsgC8Tee3qIV0idn434C+RlF2H4ACTuzzrOl4lMU
 Hue0UnS2soKPF1AbmnYHBw6LWPk8MGNZzKgG7AyyXZTWCVWuL46h2smfqYl04kk1trm3bafOujS
 FVsscjPlDeK6rbQTl5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060134

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

Drop unprotected (Re)Association Request/Response frames received from
an EPP peer.

Co-developed-by: Sai Pratyusha Magam <quic_smagam@quicinc.com>
Signed-off-by: Sai Pratyusha Magam <quic_smagam@quicinc.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/ieee80211_i.h |  8 ++++++++
 net/mac80211/mlme.c        | 12 +++++++++++-
 net/mac80211/rx.c          |  8 ++++++++
 net/mac80211/tx.c          |  4 +++-
 net/mac80211/wpa.c         |  6 ++++--
 5 files changed, 34 insertions(+), 4 deletions(-)

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
index 54d088623b1f..77e9873d5e6e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2155,6 +2155,8 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_prep_tx_info info = {};
 	unsigned int link_id, n_links = 0;
 	u16 present_elems[PRESENT_ELEMS_MAX] = {};
+	struct sta_info *sta;
+	bool assoc_encrypt;
 	void *capab_pos;
 	size_t size;
 	int ret;
@@ -2335,7 +2337,15 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	info.link_id = assoc_data->assoc_link_id;
 	drv_mgd_prepare_tx(local, sdata, &info);
 
-	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
+	sta = sta_info_get_bss(sdata, sdata->vif.cfg.ap_addr);
+
+	assoc_encrypt = (sta && sta->sta.epp_peer &&
+			 wiphy_dereference(sdata->local->hw.wiphy,
+					   sta->ptk[sta->ptk_idx]));
+
+	if (!assoc_encrypt)
+		IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
+
 	if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
 		IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS |
 						IEEE80211_TX_INTFL_MLME_CONN_TX;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e0ccd9749853..9a2b0ef2f21a 100644
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
+	    ieee80211_require_encrypted_assoc(fc, rx->sta))
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


