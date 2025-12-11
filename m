Return-Path: <linux-wireless+bounces-29664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F13CB5E9D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B7063049B0F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679EF3101A0;
	Thu, 11 Dec 2025 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OWtV3BBx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MF4IdVin"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5583101DA
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456906; cv=none; b=jmYmeaMo8q3c3XreHjCNmnvW70VwgUqOiz14rht2/vg6UBcn9oQ2FYjhYMGHDZaf7yiaUHSfR15PrQaewaCZxQbq6GIWHtO4GMMH8YP0B1Z6YKUCv9gu3xdP8Y3mEaqp8pJ2jSVSObuf6f1cZ4MIotYktLGJa57ZtxlYRYKwjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456906; c=relaxed/simple;
	bh=z0YxGr1SEXAjOKdwwrEt12icyJdYVMD5HzgPoW3+6I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ml40I4yKe3EPQODMQY0S+bYvqmse/xHW/XglIKtcC1D94yYxdGc7MBh7aAfdnnt2SYJgbR2IHUcnWxbeGoNLGXdHrqKuAcYavhEIHw98z0YhWj3ZCaeY3jMt+iRQ3JsOE5beDRu2i4AQL5RRqQB7ji5jjJvTt4uLMmBZcohcRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OWtV3BBx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MF4IdVin; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBB4eRm1956264
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=grv93vKu+Az
	PdU7rjwnyJjg8l9WMNLKLNcdGzvADomw=; b=OWtV3BBxQ1hw5WvqxzdkqZkIg06
	H5GYku5F1NSQoYqMQFdH8YhsdoRGl2f009OjgRtdO+p/DX2gnLP8k+SxJzXs8w66
	GDYe19HKgYL0z2Vn65xgoJxTQ65k7DLkvw1b6eJ/8NxzDru1yl6XdCOjt38FSre4
	a4uXZwuTWl4h+JY8wWSi6n7ZJyvD0uBJR+flSKlQgxhlFEdk8/6Xxz2GUVpVRjEu
	tFHBaxyleHRqGmtL51cQzgDD5FavJ3w8B3neq/3ojbjSL0yy87giukBhncxJM129
	lGdUfN7exJrS89WvMY7XB/pT2Pd7mmekDLLoBlF6JzTcZkyOXwDKhLZAMXw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayvryg8w6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a9fb6fcc78so6852b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456899; x=1766061699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grv93vKu+AzPdU7rjwnyJjg8l9WMNLKLNcdGzvADomw=;
        b=MF4IdVinxMSUm+kfMJXJvSmsU1CMoiDIF3ckXh0YVYKke8/MEdlp5H5zoGhPBjO4i+
         NsrtsHjdmDn8PgiPnkXLyi9ZDaVJWDj2lRrwxq4PZ2fuv7k8BuaxfQ6Ph0AiUwPA6+j8
         JumAtLj8w7Pcb4nmMO8QjarPZHT1161Xo1edUOFnx0qJPlmckcYc4K3E0IJgUkkhp5V6
         P/vTFBxSkXQapJTvaOKTzVZyFQHLz1cErZwithzzXorv+Rte1ddH78x+xz88udFlvG0o
         wBpVdS0zkVPZ/p6AgmKkTW5QZRxNFGzOc9agZX7wXetdLBZQyDRm+iL3ifUbxPAfSoef
         02Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456899; x=1766061699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=grv93vKu+AzPdU7rjwnyJjg8l9WMNLKLNcdGzvADomw=;
        b=NgCWGTLSS+Mea6wp8k/dfSHodRu33bh7qJMcvRxLvj04RBVkECNY3AN3iqpCUDqREX
         TMLFpYYzst72uxPW9toM+9+P+gflpprlFcTS7jK3bWdS4xWdgeJAOa4MJLDrH6GJe2le
         6PH2ud8JAAetVcJd9x3LJqb9SSvs6czk0KNZX2NNdzXM1kLVZ1S0+XpYAcLdAnL3XXH0
         7OFOksYag6Hea1JzDjtg2K7vbVbsT27qxjoETeDdIS5TINbOem+lPgtTQub8Ki7wsElA
         DFe93pCClYHvtnJRx3jS/LF9tnyDk1YEebjTfnhxlIAM1xVLWvLjjrW62gTTrxad9ZQF
         eD+g==
X-Gm-Message-State: AOJu0YyFHkjtcmmmMXVShK7SUiaUFIIBO0oJorHxsXmVz2ib/+qDAlvK
	wBRsiBpJXI7CRqj4PHx9j54NxcjkVJDadXVdqp5ZKOVJZ8D03wT4IZEIwqzpqCSTSJJZlos0Lh/
	CXfPJ2bSbnKRb5b+XIFo8lV4Ud/bbhV7rkec4uJs3WlAFvy6c08t21U3hwGYKCRfGTe3t0Q==
X-Gm-Gg: AY/fxX5ybr6i7tpO1ewUf+fUNnY7BGJAKf7kw+HR1xapVOj24ItQ6wFedbLZer39qdc
	b31fiH/LpmUEVBQqsCIR8tQh9FaP6Qtza3+mh5mdYrIh3dTDQlhcoF+E/StKTQtnIfRZTQqHuCK
	k87Tagmx1UB6UdIUxK3z7oVl8txxnRnbwnXhg24YftU3H7ryhxbvZzY5dX3lAAb+ePk84vcD89m
	5tLKJ0DTmnLXqX7t4WaRF42/Ami+vFsc3I9yj0WK0DE3UYBJzHqUCtCyUu0KQq6j+aa3llUqYPd
	8cwBOU8pHd0lZ2Pzq4sqGychIqEmJ0SKVR+e7RISKyumWYYoLqAIYIj+yGfwidXNF3/7o3JtqxB
	BNgtp7Hr2Yre7johHqSiHP5pBTf/14NX+M2qIF0NuqQ==
X-Received: by 2002:a05:6a21:6d9a:b0:35b:4f5c:4adf with SMTP id adf61e73a8af0-366e2988fe2mr6467098637.43.1765456899082;
        Thu, 11 Dec 2025 04:41:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8o51yITX/r8los4OewrFM0UbFXmubAiQdHFmH4gPmCBpG0g9oQjbezeP8qJvZ1OP/RUclaQ==
X-Received: by 2002:a05:6a21:6d9a:b0:35b:4f5c:4adf with SMTP id adf61e73a8af0-366e2988fe2mr6467058637.43.1765456898517;
        Thu, 11 Dec 2025 04:41:38 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:38 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 10/14] wifi: mac80211: add support for encryption/decryption of (Re)Association frames in non-AP STA mode
Date: Thu, 11 Dec 2025 18:10:47 +0530
Message-Id: <20251211124051.3094878-11-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P9g3RyAu c=1 sm=1 tr=0 ts=693abc04 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=kwESY7jZG9iTq2bj9dIA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: IV5JfmQhPwgqVmSU6nZKcSSN0l0hrRsB
X-Proofpoint-ORIG-GUID: IV5JfmQhPwgqVmSU6nZKcSSN0l0hrRsB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfX8owIeZV7bEK8
 Rk8ASOVGvb8XSXeYyZBVr3ao445cCTz1lHksZ9APL7GPPoPL6kQH2Q/bRIDHoclde76EwkYje8I
 7dN3COzDf4AGBnPc3j7ud3j6U78XeJldlzf23Ry7Zt4lB+3IRrvCH9yg1rFEhkvzSqmaD/dGJfA
 g3BapMSgR/iVB3YNvcAZVdl0GbMdTT8XnpQF88IUoaJQ2jm0Bt2A/vcK8+0vYtxx1IRDjHrwyOG
 NE5QgAMeSqzgXWKubjqsYmhK6UqKdlTLIc9xzP8nTpvPBvvKlWOeeo7P7mVVR6eRIiMUKqKB9dY
 Bg7UtTyh6tI1dtMELZ3KJL/FhtXswFIspubPSE98vERz8ZiLmVmdg5G0Dv1q2VXpkJv4PYz3vO9
 GoK9iA+J3rSMTPg2rlw1bpHHZ6tK9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

Currently, mac80211 does not encrypt or decrypt (Re)Association frames
(Request and Response) because temporal keys are not yet available at
that stage.

With extensions from IEEE P802.11bi, e.g. EPPKE, temporal keys can be
established before association. This enables encryption of
(Re)Association Request frames and decryption of (Re)Association
Response frames in non-AP STA mode.

Add support to unset the IEEE80211_TX_INTFL_DONT_ENCRYPT flag based
on key availability for the connection, allowing secure transmission of
(Re)Association Request frames.

Introduce a new boolean parameter "epp_peer" in the "ieee80211_sta"
profile to indicate that the peer supports the Enhanced Privacy
Protection Key Exchange (EPPKE) protocol. For non-AP STA mode, this is
set when the authentication algorithm is WLAN_AUTH_EPPKE during station
profile initialization. When set, encryption of the (Re)Association
Request frame is enabled.

Unprotected (Re)Association Response frames received from an EPP peer
are dropped.

Co-developed-by: Sai Pratyusha Magam <quic_smagam@quicinc.com>
Signed-off-by: Sai Pratyusha Magam <quic_smagam@quicinc.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/net/mac80211.h     |  2 ++
 net/mac80211/ieee80211_i.h | 20 ++++++++++++++++++++
 net/mac80211/mlme.c        | 18 +++++++++++++++++-
 net/mac80211/rx.c          |  9 +++++++++
 net/mac80211/tx.c          |  6 +++++-
 net/mac80211/wpa.c         |  8 ++++++--
 6 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c2e49542626c..5154002f2534 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2497,6 +2497,7 @@ struct ieee80211_link_sta {
  *	valid if the STA is a TDLS peer in the first place.
  * @mfp: indicates whether the STA uses management frame protection or not.
  * @mlo: indicates whether the STA is MLO station.
+ * @epp_peer: indicates that the peer is an EPP peer.
  * @max_amsdu_subframes: indicates the maximal number of MSDUs in a single
  *	A-MSDU. Taken from the Extended Capabilities element. 0 means
  *	unlimited.
@@ -2533,6 +2534,7 @@ struct ieee80211_sta {
 	bool tdls_initiator;
 	bool mfp;
 	bool mlo;
+	bool epp_peer;
 	bool spp_amsdu;
 	u8 max_amsdu_subframes;
 	u16 eml_cap;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 76682933f4fa..560584ea83b2 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2397,6 +2397,26 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb, int tid, int link_id,
 				 enum nl80211_band band);
 
+static inline bool ieee80211_epp_assoc_resp(__le16 fc, struct sta_info *sta)
+{
+	return sta && sta->sta.epp_peer && ieee80211_is_assoc_resp(fc);
+}
+
+static inline bool ieee80211_epp_assoc_req(__le16 fc, struct sta_info *sta)
+{
+	return sta && sta->sta.epp_peer && ieee80211_is_assoc_req(fc);
+}
+
+static inline bool ieee80211_epp_reassoc_resp(__le16 fc, struct sta_info *sta)
+{
+	return sta && sta->sta.epp_peer && ieee80211_is_reassoc_resp(fc);
+}
+
+static inline bool ieee80211_epp_reassoc_req(__le16 fc, struct sta_info *sta)
+{
+	return sta && sta->sta.epp_peer && ieee80211_is_reassoc_req(fc);
+}
+
 /* sta_out needs to be checked for ERR_PTR() before using */
 int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
 			    struct sk_buff *skb,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 73e7f76e92ef..ea3103f2f646 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2152,6 +2152,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_prep_tx_info info = {};
 	unsigned int link_id, n_links = 0;
 	u16 present_elems[PRESENT_ELEMS_MAX] = {};
+	bool assoc_encrypt = false;
 	void *capab_pos;
 	size_t size;
 	int ret;
@@ -2332,7 +2333,18 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	info.link_id = assoc_data->assoc_link_id;
 	drv_mgd_prepare_tx(local, sdata, &info);
 
-	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
+	if (!is_zero_ether_addr(sdata->vif.cfg.ap_addr)) {
+		struct sta_info *sta = sta_info_get_bss(sdata,
+							sdata->vif.cfg.ap_addr);
+
+		if (sta && wiphy_dereference(sdata->local->hw.wiphy,
+					     sta->ptk[sta->ptk_idx]))
+			assoc_encrypt = true;
+	}
+
+	if (!assoc_encrypt)
+		IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
+
 	if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
 		IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS |
 						IEEE80211_TX_INTFL_MLME_CONN_TX;
@@ -8965,6 +8977,10 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 			goto out_err;
 		}
 
+		if (ifmgd->auth_data &&
+		    ifmgd->auth_data->algorithm == WLAN_AUTH_EPPKE)
+			new_sta->sta.epp_peer = true;
+
 		new_sta->sta.mlo = mlo;
 	}
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6a1899512d07..bd2d57b4360e 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2609,6 +2609,15 @@ ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 	    (!rx->sta || !test_sta_flag(rx->sta, WLAN_STA_ASSOC)))
 		return RX_DROP_U_UNPROT_ROBUST_ACTION;
 
+	/*
+	 * Drop unprotected (Re)Association Response frame received from
+	 * an EPP Peer.
+	 */
+	if (!ieee80211_has_protected(fc) &&
+	    (ieee80211_epp_assoc_resp(fc, rx->sta) ||
+	     ieee80211_epp_reassoc_resp(fc, rx->sta)))
+		return RX_DROP_U_UNPROT_UCAST_MGMT;
+
 	return RX_CONTINUE;
 }
 EXPORT_SYMBOL_IF_MAC80211_KUNIT(ieee80211_drop_unencrypted_mgmt);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 9d8b0a25f73c..de117663cb6a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -640,7 +640,11 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 			if (!ieee80211_is_data_present(hdr->frame_control) &&
 			    !ieee80211_use_mfp(hdr->frame_control, tx->sta,
 					       tx->skb) &&
-			    !ieee80211_is_group_privacy_action(tx->skb))
+			    !ieee80211_is_group_privacy_action(tx->skb) &&
+			    !ieee80211_epp_assoc_req(hdr->frame_control,
+						     tx->sta) &&
+			    !ieee80211_epp_reassoc_req(hdr->frame_control,
+						       tx->sta))
 				tx->key = NULL;
 			else
 				skip_hw = (tx->key->conf.flags &
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 4a858112e4ef..660d5bac2188 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -527,7 +527,9 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 	hdrlen = ieee80211_hdrlen(hdr->frame_control);
 
 	if (!ieee80211_is_data(hdr->frame_control) &&
-	    !ieee80211_is_robust_mgmt_frame(skb))
+	    !ieee80211_is_robust_mgmt_frame(skb) &&
+	    !ieee80211_epp_assoc_resp(hdr->frame_control, rx->sta) &&
+	    !ieee80211_epp_reassoc_resp(hdr->frame_control, rx->sta))
 		return RX_CONTINUE;
 
 	if (status->flag & RX_FLAG_DECRYPTED) {
@@ -723,7 +725,9 @@ ieee80211_crypto_gcmp_decrypt(struct ieee80211_rx_data *rx)
 	hdrlen = ieee80211_hdrlen(hdr->frame_control);
 
 	if (!ieee80211_is_data(hdr->frame_control) &&
-	    !ieee80211_is_robust_mgmt_frame(skb))
+	    !ieee80211_is_robust_mgmt_frame(skb) &&
+	    !ieee80211_epp_assoc_resp(hdr->frame_control, rx->sta) &&
+	    !ieee80211_epp_reassoc_resp(hdr->frame_control, rx->sta))
 		return RX_CONTINUE;
 
 	if (status->flag & RX_FLAG_DECRYPTED) {
-- 
2.34.1


