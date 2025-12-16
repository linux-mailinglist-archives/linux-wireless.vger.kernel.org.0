Return-Path: <linux-wireless+bounces-29783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B114CC118D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D01303006F6D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B6534402B;
	Tue, 16 Dec 2025 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PUkOsNry";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZEVfxcVL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858834321C
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866463; cv=none; b=ia5wPchyyqoT+uvarRfM9pt6ulifx7VQCj7fz7QFbM3+T8KZX4ZvswFQ23pr+p3DlYWFPLWid0+p03KcYu1OYIG7/RkRVWXc5h07IFg7NIU2JOe3+mKg3g1MSnWnnkuQdAs1UV2X17l5mpWmphfa7W4RcynFzq+GyWWAr1BFkz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866463; c=relaxed/simple;
	bh=SNq5J0re2gJZtbc3eAtrRF4d9kjZXn83mOknqLQyodQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imVuSta49A2LZMw+iQ/E74h5sqIJECzdDK8bZ4T9t7wdyfy3E+XnoFv8wlDD1rTfnwxqicpssnXG3uN37wvA5SbamSULJKqlziuAwSF10zUvNbvGKgSPDxl7AKUYWEKTOrohp8BCvU1btYlVPZrweBJSuyInOvXStSdgQGl+bTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PUkOsNry; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZEVfxcVL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG2mbnD1682298
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5fppAENCcFx
	6zDNdJ8ehS4jHUopEmcWtHaIK/aL5CoY=; b=PUkOsNrybueunaHSImaY5FE4jcs
	mWyffz8XI/sb2ATpOHB7lgqDQ3/863du/aEpXKBpnScH2lOzTGRivviv13UFCkTn
	lvTtIyv4iuiRYGqf9unt2kINt2qLSx0J5aVsMMx1cAiinvOxPTqxWcTZa6hEzfg3
	JnGOvdlLYnWZ9QHss259XrXR43tSTfh0MtxgTMeo3yxp8WMaYBTD/V2V6siLQ25R
	L011SDlDyCdXK4w90Y298Hqn5vjpWZB/pQxRQoBbU6hDmqGg0DyiWvcG25hiLFZE
	fu6zjPR/sMsAAXlaZXh0FTSTHz1/2xuO3xo3ym5z0OIbLT9dU4+8n8UhgmQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2q7tjb2p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f1f79d6afso44699645ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866454; x=1766471254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fppAENCcFx6zDNdJ8ehS4jHUopEmcWtHaIK/aL5CoY=;
        b=ZEVfxcVLOs3hIIkJFQg5DGkDXzDmu1irJz/WJ0SlEM/QVOoicyZHZqfbD3FLAkeHbQ
         xX/XW2t4hwwZfqyeB4ozZedP04aPb9aK9oaXsVAVJ0fiTbZXCrEp4ZGkc/VlKdZP/vap
         rUJkkULiij7RzgFE+/EXPbKVsJhr2M1lAWXp8iLdLPQcpnS8w7n35wcBpCpfHSCgwgbr
         brPPSIfQ+CXWVExYP+KlNEpkDU/UyrjiTPyy3FM5wvja7MTOVB7VDh4Nv9wYAYCeyJ9U
         hB+H9d8Xh5d9D0l1qkwA7Rv5XMTm4+ZdsXtzglu+/yWUw8viqSwt77Dt66c1js7yQU5U
         z8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866454; x=1766471254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5fppAENCcFx6zDNdJ8ehS4jHUopEmcWtHaIK/aL5CoY=;
        b=eJLbGQJgbxMsslHDSGaHB4IdCJB+b/UCXlA1zD4qQONzpxy1fvxPO7fRen+EsPKkyt
         TC3VkjOQL2CmNABPXKQJu5n+8uoquf1VqNEfq3rdc+88CyiAcALstnh8uH9AqshSmoB/
         lIEV2eDkK4Oj8lzLgKzqux3zbjoVGEDnwiu0SyeU9pn5GbBQelwfDpwZ57fS01FJncU1
         BKGx3/UI9hdHk3tV4MtUz4/txgUz9rZ9ygsFryWqHs/5u1NMJi8w5ysXtv/wLrYPKeQO
         mjA0hR/LXfMlWR7enroTX7j4wEB/ystiuLSY6kpw6vh3/KFd0lHQrgza8lFaK1/eoV+7
         HgAA==
X-Gm-Message-State: AOJu0YzMD+v8s/v40aQfQVQBBwIrFgktRE9p7RXuC4DWP3Lum6pSC9Iu
	qtxgi3HEzGjPLE1GuhRF1a46BIJn2MN+QRz2fr5e0s4zeEdtBR8dpiy65Oa4FJcU7e6Ky786g8z
	j5VoQ7NMnrVoie2jxQMOmACm7nJtmjC8SfMV3O1twt1HYzI78UqJG9bHXZeTWggl4ULwhCw==
X-Gm-Gg: AY/fxX5vgAm0ph8hQ0SM5cGjcWkOnGUJwTIAh1kb3uT3chYVUP4YMb08cHZQta2PNfK
	JJ+CJLLfRPRE3rvuaCtchirJy2Lrq5vaNHpC3qF+Y6CFwnierx9aIh1cj3zZpIfEE5w9tpoWpar
	/avlvLHH1THOuxU6p3b7jdk0Ao1g+uHJDjkufk0qmRnuTiD1ViNBp7fIQ8GmeBiPAyImIBOA+5E
	hEVwghgSo/SR3tDlnHmQV+pKFOA9Glnadn/kTHpS+o9HkV9jif7HCwQOev6LrSo4fBaDsA9YY83
	zS2w4095A1vfZE4yoh92LRrc6fC0fH0BZgCNkGtK6st3JoLrrI91VfJr1vQKtXEIJF9WHqsDYqu
	TTHJEHngQxSB9fPUyQ9klTtMyz1bwpCcH97Y3aKh7Q5JjWDs7agxUuw==
X-Received: by 2002:a17:902:ea0b:b0:297:dabf:9900 with SMTP id d9443c01a7336-29f23bde313mr143421895ad.0.1765866453564;
        Mon, 15 Dec 2025 22:27:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErW8FZMVjNzFnouCsNOcT2PNqfEEYeDYG1NbzcPk+5Jm4vY/MQWM18cZTJnblnuc1kqyYhlw==
X-Received: by 2002:a17:902:ea0b:b0:297:dabf:9900 with SMTP id d9443c01a7336-29f23bde313mr143421565ad.0.1765866452975;
        Mon, 15 Dec 2025 22:27:32 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:32 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 09/13] wifi: mac80211: Add UHR capabilities to association/probe request for STA mode
Date: Tue, 16 Dec 2025 11:56:52 +0530
Message-Id: <20251216062656.1738022-10-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
References: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VyCA7jyHC9UHmS70JPRE01c2JvbODdUo
X-Proofpoint-ORIG-GUID: VyCA7jyHC9UHmS70JPRE01c2JvbODdUo
X-Authority-Analysis: v=2.4 cv=Qo1THFyd c=1 sm=1 tr=0 ts=6940fbd6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ZeiwEr-bWMY95ht15oEA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfX0MXz5HPJLSaG
 FhtOMdsz5GV33kXolVFrdxT+ZgbxkN9D7dvT68GaMrLhCdmqeE5B48mYjdyCQ29XBKdM66CVoRd
 GmVaTMSq39e0l1W9F4SWPeaV6rde+beClvhBOLKapLCEzXGFWJmimNbH03MVuOBtQRmi9fch4of
 9lFImkz1Hauv75iPNvylnUnZklylFAqSDBippriNuObrK1t/X27oDn22qXM3CG5JGE7K92YFo4r
 fyBEQ0UYB+TyonsTe/RuhbFvCrDTSmbdKj3Cai+v0lSR13Y0zxiS27d2KaPhBjG2Ok6V3mSfNHf
 9WyTyogcRA8W2Zj6BkT1qqLArFhg+qnamxkRkjndMMEc33xdfTGsbwzuOcUTUNMq+rWOwJK5GzR
 UFlAwPw8aCWzmf01bsyzb9GDnRwUpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

Add the UHR capabilities element to both probe request and
association request frames, if advertised by the driver.

Introduce IEEE80211_CONN_MODE_UHR flag to disable the UHR connection
if AP doesn't send UHR operation or the operating channel is not UHR
supported.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 include/net/mac80211.h     | 14 ++++++++++++++
 net/mac80211/ieee80211_i.h |  4 ++++
 net/mac80211/main.c        | 12 +++++++++++-
 net/mac80211/mlme.c        | 37 +++++++++++++++++++++++++++++++++++-
 net/mac80211/parse.c       |  4 ++++
 net/mac80211/util.c        | 39 +++++++++++++++++++++++++++++++++++++-
 6 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c2e49542626c..7f1d2953a074 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7236,6 +7236,20 @@ ieee80211_get_eht_iftype_cap_vif(const struct ieee80211_supported_band *sband,
 	return ieee80211_get_eht_iftype_cap(sband, ieee80211_vif_type_p2p(vif));
 }
 
+/**
+ * ieee80211_get_uhr_iftype_cap_vif - return UHR capabilities for sband/vif
+ * @sband: the sband to search for the iftype on
+ * @vif: the vif to get the iftype from
+ *
+ * Return: pointer to the struct ieee80211_sta_uhr_cap, or %NULL is none found
+ */
+static inline const struct ieee80211_sta_uhr_cap *
+ieee80211_get_uhr_iftype_cap_vif(const struct ieee80211_supported_band *sband,
+				 struct ieee80211_vif *vif)
+{
+	return ieee80211_get_uhr_iftype_cap(sband, ieee80211_vif_type_p2p(vif));
+}
+
 /**
  * ieee80211_update_mu_groups - set the VHT MU-MIMO groud data
  *
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 04f1df209cec..3a61710b1532 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -394,6 +394,7 @@ enum ieee80211_conn_mode {
 	IEEE80211_CONN_MODE_VHT,
 	IEEE80211_CONN_MODE_HE,
 	IEEE80211_CONN_MODE_EHT,
+	IEEE80211_CONN_MODE_UHR,
 };
 
 #define IEEE80211_CONN_MODE_HIGHEST	IEEE80211_CONN_MODE_EHT
@@ -2691,6 +2692,9 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
 			  struct ieee80211_sub_if_data *sdata,
 			  const struct ieee80211_supported_band *sband,
 			  const struct ieee80211_conn_settings *conn);
+int ieee80211_put_uhr_cap(struct sk_buff *skb,
+			  struct ieee80211_sub_if_data *sdata,
+			  const struct ieee80211_supported_band *sband);
 int ieee80211_put_reg_conn(struct sk_buff *skb,
 			   enum ieee80211_channel_flags flags);
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b05e313c7f17..ffe957eb0c8e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1123,7 +1123,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	int result, i;
 	enum nl80211_band band;
 	int channels, max_bitrates;
-	bool supp_ht, supp_vht, supp_he, supp_eht, supp_s1g;
+	bool supp_ht, supp_vht, supp_he, supp_eht, supp_s1g, supp_uhr;
 	struct cfg80211_chan_def dflt_chandef = {};
 
 	if (ieee80211_hw_check(hw, QUEUE_CONTROL) &&
@@ -1237,6 +1237,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	supp_he = false;
 	supp_eht = false;
 	supp_s1g = false;
+	supp_uhr = false;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
 		const struct ieee80211_sband_iftype_data *iftd;
 		struct ieee80211_supported_band *sband;
@@ -1293,6 +1294,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 
 			supp_he = supp_he || iftd->he_cap.has_he;
 			supp_eht = supp_eht || iftd->eht_cap.has_eht;
+			supp_uhr = supp_uhr || iftd->uhr_cap.has_uhr;
 
 			if (band == NL80211_BAND_2GHZ)
 				he_40_mhz_cap =
@@ -1325,6 +1327,10 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		if (WARN_ON(supp_eht && !supp_he))
 			return -EINVAL;
 
+		/* UHR requires EHT support */
+		if (WARN_ON(supp_uhr && !supp_eht))
+			return -EINVAL;
+
 		if (!sband->ht_cap.ht_supported)
 			continue;
 
@@ -1435,6 +1441,10 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 				3 + sizeof(struct ieee80211_eht_cap_elem) +
 				sizeof(struct ieee80211_eht_mcs_nss_supp) +
 				IEEE80211_EHT_PPE_THRES_MAX_LEN;
+
+		if (supp_uhr)
+			local->scan_ies_len +=
+				3 + sizeof(struct ieee80211_uhr_cap_elem);
 	}
 
 	if (!local->ops->hw_scan) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 73649d57d0c3..9b730aa5fc3a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -162,6 +162,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_vht_operation *vht_oper = elems->vht_operation;
 	const struct ieee80211_he_operation *he_oper = elems->he_operation;
 	const struct ieee80211_eht_operation *eht_oper = elems->eht_operation;
+	const struct ieee80211_uhr_operation *uhr_oper = elems->uhr_operation;
 	struct ieee80211_supported_band *sband =
 		sdata->local->hw.wiphy->bands[channel->band];
 	struct cfg80211_chan_def vht_chandef;
@@ -340,7 +341,12 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 		*chandef = eht_chandef;
 	}
 
-	return IEEE80211_CONN_MODE_EHT;
+	/* stick to EHT if STA or the AP don't have UHR */
+	if (conn->mode < IEEE80211_CONN_MODE_UHR ||
+	    !uhr_oper)
+		return IEEE80211_CONN_MODE_EHT;
+
+	return IEEE80211_CONN_MODE_UHR;
 }
 
 static bool
@@ -1091,6 +1097,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 				       IEEE80211_CONN_BW_LIMIT_160);
 		break;
 	case IEEE80211_CONN_MODE_EHT:
+	case IEEE80211_CONN_MODE_UHR:
 		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
 				       conn->bw_limit,
 				       IEEE80211_CONN_BW_LIMIT_320);
@@ -1152,6 +1159,15 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 				       IEEE80211_CONN_BW_LIMIT_160);
 	}
 
+	if (conn->mode >= IEEE80211_CONN_MODE_UHR &&
+	    !cfg80211_chandef_usable(sdata->wdev.wiphy, &chanreq->oper,
+				     IEEE80211_CHAN_NO_UHR)) {
+		conn->mode = IEEE80211_CONN_MODE_EHT;
+		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+				       conn->bw_limit,
+				       IEEE80211_CONN_BW_LIMIT_160);
+	}
+
 	if (chanreq->oper.width != ap_chandef->width || ap_mode != conn->mode)
 		link_id_info(sdata, link_id,
 			     "regulatory prevented using AP config, downgraded\n");
@@ -1887,6 +1903,9 @@ ieee80211_add_link_elems(struct ieee80211_sub_if_data *sdata,
 	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_EHT)
 		ADD_PRESENT_EXT_ELEM(WLAN_EID_EXT_EHT_CAPABILITY);
 
+	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_UHR)
+		ADD_PRESENT_EXT_ELEM(WLAN_EID_EXT_UHR_CAPABILITY);
+
 	if (link_id == assoc_data->assoc_link_id)
 		ieee80211_assoc_add_ml_elem(sdata, skb, orig_capab, ext_capa,
 					    present_elems, assoc_data);
@@ -1898,6 +1917,9 @@ ieee80211_add_link_elems(struct ieee80211_sub_if_data *sdata,
 		ieee80211_put_eht_cap(skb, sdata, sband,
 				      &assoc_data->link[link_id].conn);
 
+	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_UHR)
+		ieee80211_put_uhr_cap(skb, sdata, sband);
+
 	if (sband->band == NL80211_BAND_S1GHZ) {
 		ieee80211_add_aid_request_ie(sdata, skb);
 		ieee80211_add_s1g_capab_ie(sdata, &sband->s1g_cap, skb);
@@ -2132,6 +2154,8 @@ ieee80211_link_common_elems_size(struct ieee80211_sub_if_data *sdata,
 		sizeof(struct ieee80211_eht_mcs_nss_supp) +
 		IEEE80211_EHT_PPE_THRES_MAX_LEN;
 
+	size += 2 + 1 + sizeof(struct ieee80211_uhr_cap_elem);
+
 	return size;
 }
 
@@ -5808,6 +5832,7 @@ ieee80211_determine_our_sta_mode(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_sta_he_cap *he_cap;
 	const struct ieee80211_sta_eht_cap *eht_cap;
 	struct ieee80211_sta_vht_cap vht_cap;
+	const struct ieee80211_sta_uhr_cap *uhr_cap;
 
 	if (sband->band == NL80211_BAND_S1GHZ) {
 		conn->mode = IEEE80211_CONN_MODE_S1G;
@@ -5995,6 +6020,16 @@ ieee80211_determine_our_sta_mode(struct ieee80211_sub_if_data *sdata,
 		mlme_link_id_dbg(sdata, link_id,
 				 "no EHT 320 MHz cap in 6 GHz, limiting to 160 MHz\n");
 
+	uhr_cap = ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif);
+	if (!uhr_cap) {
+		mlme_link_id_dbg(sdata, link_id,
+				 "no UHR support, limiting to EHT\n");
+		goto out;
+	}
+
+	/* we have UHR */
+	conn->mode = IEEE80211_CONN_MODE_UHR;
+
 out:
 	mlme_link_id_dbg(sdata, link_id,
 			 "determined local STA to be %s, BW limited to %d MHz\n",
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index ed8411aa8b32..43fe1483c32b 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -190,12 +190,16 @@ ieee80211_parse_extension_element(u32 *crc,
 		}
 		break;
 	case WLAN_EID_EXT_UHR_CAPABILITY:
+		if (params->mode < IEEE80211_CONN_MODE_UHR)
+			break;
 		if (ieee80211_uhr_capa_size_ok(data, len)) {
 			elems->uhr_cap = data;
 			elems->uhr_cap_len = len;
 		}
 		break;
 	case WLAN_EID_EXT_UHR_OPERATION:
+		if (params->mode < IEEE80211_CONN_MODE_UHR)
+			break;
 		if (ieee80211_uhr_oper_size_ok(data, len, params->is_beacon))
 			elems->uhr_operation = data;
 		calc_crc = true;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0c46009a3d63..dc8706305ebe 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -47,7 +47,7 @@ struct ieee80211_hw *wiphy_to_ieee80211_hw(struct wiphy *wiphy)
 EXPORT_SYMBOL(wiphy_to_ieee80211_hw);
 
 const struct ieee80211_conn_settings ieee80211_conn_settings_unlimited = {
-	.mode = IEEE80211_CONN_MODE_EHT,
+	.mode = IEEE80211_CONN_MODE_UHR,
 	.bw_limit = IEEE80211_CONN_BW_LIMIT_320,
 };
 
@@ -1365,6 +1365,15 @@ static int ieee80211_put_preq_ies_band(struct sk_buff *skb,
 			return err;
 	}
 
+	if (cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
+					 IEEE80211_CHAN_NO_HE |
+					 IEEE80211_CHAN_NO_EHT |
+					 IEEE80211_CHAN_NO_UHR)) {
+		err = ieee80211_put_uhr_cap(skb, sdata, sband);
+		if (err)
+			return err;
+	}
+
 	err = ieee80211_put_he_6ghz_cap(skb, sdata, IEEE80211_SMPS_OFF);
 	if (err)
 		return err;
@@ -4475,6 +4484,33 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
 	return 0;
 }
 
+int ieee80211_put_uhr_cap(struct sk_buff *skb,
+			  struct ieee80211_sub_if_data *sdata,
+			  const struct ieee80211_supported_band *sband)
+{
+	const struct ieee80211_sta_uhr_cap *uhr_cap =
+		ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif);
+	struct ieee80211_uhr_cap_elem_fixed fixed;
+	u8 ie_len;
+
+	/* Make sure we have place for the IE */
+	if (!uhr_cap)
+		return 0;
+
+	fixed = uhr_cap->uhr_cap_elem;
+
+	ie_len = 2 + 1 + sizeof(uhr_cap->uhr_cap_elem);
+	if (skb_tailroom(skb) < ie_len)
+		return -ENOBUFS;
+
+	skb_put_u8(skb, WLAN_EID_EXTENSION);
+	skb_put_u8(skb, ie_len - 2);
+	skb_put_u8(skb, WLAN_EID_EXT_UHR_CAPABILITY);
+	skb_put_data(skb, &fixed, sizeof(fixed));
+
+	return 0;
+}
+
 const char *ieee80211_conn_mode_str(enum ieee80211_conn_mode mode)
 {
 	static const char * const modes[] = {
@@ -4484,6 +4520,7 @@ const char *ieee80211_conn_mode_str(enum ieee80211_conn_mode mode)
 		[IEEE80211_CONN_MODE_VHT] = "VHT",
 		[IEEE80211_CONN_MODE_HE] = "HE",
 		[IEEE80211_CONN_MODE_EHT] = "EHT",
+		[IEEE80211_CONN_MODE_UHR] = "UHR",
 	};
 
 	if (WARN_ON(mode >= ARRAY_SIZE(modes)))
-- 
2.34.1


