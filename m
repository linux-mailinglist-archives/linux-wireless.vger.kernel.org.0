Return-Path: <linux-wireless+bounces-30819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 646ECD1E5BF
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 12:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D033D304067B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE5C378D86;
	Wed, 14 Jan 2026 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VMt8r5BQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FIIYFVw9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D93793C0
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389584; cv=none; b=eL/f3qWBpDjk0uX59vtahAl5QpSYkDDpoGxCo/d2nDjOvA+2BzpcNNRc/TadYIWAL0FFhR9AefnD3OkahDBqhZm438WOtCujYIc83eBx4BkMUOqcD1DXlBqNPbkTI5G6U7FG5Kg0aA6zSS/nqq4ha8VJV3f+9d/tEMkNnP++B0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389584; c=relaxed/simple;
	bh=UubYj8jIiSMMCR/6Jwb/ekRsWi681njyyXkT9gC3SiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EOXdO603Zbzw+Agkj34dqxc8oBq6pItTbg3SZAjJy290BhhIaZ6TnKwpcfH1dNZ0tOFwB+DWYU2u3IL706prMvU2qxFvocI1BkajDgSywWnU9K7ZyxKZD+thBrdwn7MgzMK8+nLJHKRtjhz/LtcJ6epiKcQairm5SxijmeFpi2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VMt8r5BQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FIIYFVw9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E7jGA9147882
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Pz8Q5FZNdoD
	ucjLkXwg5cixn2Cee06qPb1fM4Py+j9k=; b=VMt8r5BQUlkDpTzlmwue0HSDhMq
	XMG6Lwm9CjcYmdsK7PboH9CfibVylVBn5e6GEPqx3Q2O3gRrjB5neZezPl69igly
	UdIiuEeS5CPeynvANNhDyGdBSQVEcLNCXYtACzBOEFLXEjyLXFGQnds8t6eAAGc8
	t/20f26mBIjF6pDhAfgfOXEYqdq6tV7CKKloBpxW/m8XWD3jBwNZFmwPbBVTe6Ry
	IihOCgqG2yDFtwEcy3FIWI9oxCQne7NIhiOtdTylndBt1flTJbvGXhR/rlUOQ/tE
	Oli5MSpjruyJnAyKC2MPTCgDIp44bHx4MqhlMlPX4SESboQDKwCa3SeLzQg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp6raguhd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d203988so5474811a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 03:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768389581; x=1768994381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pz8Q5FZNdoDucjLkXwg5cixn2Cee06qPb1fM4Py+j9k=;
        b=FIIYFVw9tV0WwjGsadCUmSAPr2oXWP9FkGcvJ9OyiRdH583zm1W2cuO6Z3P3iUONxk
         CFtcUR1g3WYXpL3/fSYXeneeNZAOYv/FrZwoB7oS4dnPJ4zc/AUstGXKeTIlN/uwY/IM
         XAo8submEcnDO8pcQCupDCmQvMotlB06xWJeXSte63blSkUxSh8WGduPdqf6C2VXeSwC
         E7zKMG7gQf+jzjL92MZYzPT68ML6Gt3GP7ad/5/+Ull8dMY+cFRHUvOxxCXy6Bd62PBI
         LggR82YaGfEdengJrbyhH1ALrMpBf33f78mZViFC3ruOodVT+lizOSp8zotGnxKSX7gZ
         pgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389581; x=1768994381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pz8Q5FZNdoDucjLkXwg5cixn2Cee06qPb1fM4Py+j9k=;
        b=juP3vHab8g5baumzX14+/gAr7NtDEIVtekXs3DEyzJqKV88NINdiGWUkLHJ/k3SfDF
         oEtItffWlWiiC/F2Ck3vBRIF29megjcGXlzMtOx4qaXtKFueF9KBiOVcRexEfQOi8Jjm
         qXrGwy65pZFFP11mWILmd9wIjhhg4ZiLLAOE+5yhAr/VUKkZUWKz20Wj+itfQYO9UeIk
         AfNTk+Lwey+D3q/N/EKBKBFhQfRsAXfUHCYzKV4uJsMEXNDmezQ+/+9EmF+ozkauUHKz
         qPhdQX5SHuGNYSYPPaG1PtsDU+kkHO2Htu2arc812BSQws3um43MDc8G9Ea+Hra+IIeb
         0OGQ==
X-Gm-Message-State: AOJu0YxRPM8knqrqFV0HDsZ+ak7+DGV0utw+hHA1GTxdndCn56WhF7K+
	ZXHpPBywbVAC5+yE4SJMbsZLDmErpSYJKyQY/Go1WNLLBJohD+ShxGddMjyYJ8BZStRFT+6fyoT
	WptKpxduf5ZYLcvm3MBEoazI2GPAaTN5RQVybPgVKd6SHveLz7sLtjzb2YVPJ72OW5k8TbDF23Z
	Kl3A==
X-Gm-Gg: AY/fxX7MgnzNKYATjv1KAbi4kUlQVSeJJT7gE7nvDMJUVfD62/sV+XiXISxied2WOtJ
	9rl67mIsLyu08tSj1UVIwLQcEexTqyVp3VlzJzroB0i08BzxlIyQu1gy6uAY42sx17G6Z7Gp8zs
	qkkQYJPF26QwAwnWU1Au5mOW26PiETeWRIysogmDUdmIAvHWqn0qkWtPtrM4kvMUI2jTmJdi36Q
	nNqV4SToEeiT85TfbaxIkwSxbtzQSl8RoDw6q/enMFP6zX0KjMcs/ila62y+W8U7wEdAwC0AkSP
	zqEkHm7ftG8mqxZQW687DHQF6echYlDb9moSbh83xoLT/Lceo4fNV1uX8lgguw79+R69H8Db/hw
	w4g5wq32Is4uTe2WvS7QGVQk/C8/4CsnIBN4hEcw5rg==
X-Received: by 2002:a17:90b:134b:b0:34c:fbf0:fa55 with SMTP id 98e67ed59e1d1-3510b12929amr1750383a91.21.1768389581377;
        Wed, 14 Jan 2026 03:19:41 -0800 (PST)
X-Received: by 2002:a17:90b:134b:b0:34c:fbf0:fa55 with SMTP id 98e67ed59e1d1-3510b12929amr1750355a91.21.1768389580884;
        Wed, 14 Jan 2026 03:19:40 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm22402512a12.32.2026.01.14.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:19:40 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v4 8/9] wifi: mac80211: add support for encryption/decryption of (Re)Association frames
Date: Wed, 14 Jan 2026 16:48:59 +0530
Message-Id: <20260114111900.2196941-9-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
References: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfXxKMqZDXRKd4f
 Hs2CQaPT6LoyqEKS/k2wES+66F+jq3HQtNoVREyve86Yv7KMjHYXiaJ9G8nDny3pHlaoj9aFx1v
 J70x8YJaz60Pi+lJU7JPZ18sr314RvLvAHfaXnRSQzQctqSAS4txytpNXRRqiyxrGWZZIdmJ/3Q
 vLFsPj0mC7VMRrlFKonz2A8DaitL1xJ2IKJex4Z8Kot/qreXEdhSzQfxdqN6kyQVusnE4L0xj+y
 RtKMokLqw03L/Ac+kTLWddDi6rGf1LKo9IiO9Jw4nVDZyO5yQ1Mfcclxfu/HbMnxeN1IaU/sd8G
 KT+d0+w9ACUBnXDk4Ce/ZT1FXIK3E8/qmDabrH5PWl1q9N3I6q1wjOiGfU6FJtTjHdJRdg0PI/j
 SVSBzVnx9e+RXr56vMOGvOruANpW7CK0rcmC+NODKCMsvevgpZuLYGQBSzAzPoJay6yBJ1lXzxk
 q94FojBs3V4vxH/1WyA==
X-Proofpoint-GUID: x5vL4CPN-cm64VQ_6h8WpTTgh3b8VJa8
X-Proofpoint-ORIG-GUID: x5vL4CPN-cm64VQ_6h8WpTTgh3b8VJa8
X-Authority-Analysis: v=2.4 cv=L/EQguT8 c=1 sm=1 tr=0 ts=69677bce cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=IsckVGhRMFeyOBZFPTYA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140093

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
index 0a8875e0709b..dc757cb32974 100644
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
index f7af6750f8d9..6f2217dc7ec8 100644
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
index 1b55e8340413..007f5a368d41 100644
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


