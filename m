Return-Path: <linux-wireless+bounces-30347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7D2CF238D
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 08:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65A6C304817C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 07:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1782D8793;
	Mon,  5 Jan 2026 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mLLzd/bt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HWhQZBOl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECD2C027F
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597925; cv=none; b=NqkvJXQM7dzNd7hQW1BnIVEYKqislUkkuYVNJcgTDSjC9Y/3cWmpjK6bt00LGrTxTqPF5p2J+SilTdegBz0RC7qX2sWXA8Kgs6yqGa2nIDV3bjJ87Bp9jXUubkW7faH3O7ZRjQsPDMChpCTwhNdIJDT/exQrQnUWjNWjJfJsyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597925; c=relaxed/simple;
	bh=moSSl4uZn9UFiVxcCKZO8UECKei6vrFUpqASCb3JvCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuLdq/dpgLTBgP7BKHJyhNTHosdQS9mmUuydffNdKhB+zAM9Pp2u/2O/DQVfi+BIrbxp+shOIonr4aSrr9HjmumqD4u6VOmHgNCH4d7OcjsyeUdxUR4cMoC5DEjmmVQOzQigrZ2WzScJsAyb+xN5PPcKPgpgaMXYe+A+LOqMYHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mLLzd/bt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HWhQZBOl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6053ExYA3541749
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 07:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lvutWKI7TKt16StpCuzmvGLizpsf+0/4btbqFsNvdR4=; b=mLLzd/btNiVsLPo5
	bh0vsYPXSLr0U05Fn1r0yuiXWQHCTnaRv79pJ15f2cVc5drIjrOofzVWp+Pvxbkz
	IqfsQ4uXf7HXG0M+wxsZg5hlzv+csfyuwAZAIAL/Ju+tkGkJV9TDVtFJpPHqntew
	b/X3FFKfoRrAsq0qzf0+78Pz66tFZiYyMLnZkGEWl5Oif2uFGEe9frJivbrG8PES
	mPbiB1C1kkQIYtMtPde0LKK4wkViu1I0+7fH0X2sELqBTI41BOvSXLxf8BvRMMCf
	dTUIrUbY3yWizOLyoLLZp0c2sUg7tPvcNpl8uoWxhgvVM9dRkum1StWU5Qf6vc3w
	QEctKA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg57sgku1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 07:25:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f1f69eec6so173314845ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 23:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767597917; x=1768202717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvutWKI7TKt16StpCuzmvGLizpsf+0/4btbqFsNvdR4=;
        b=HWhQZBOlIDhivly8cfH+TrPUDbXNkQ5S563Hw6KhbYKSZo/VDQksn9u2jCoOA4Wvki
         joXcNeR20Nk7lDyKNDK8f+pniyn0VJSgHuT5qdNjRG3I1yBa5Pxci9xFJR/Fra2YfPvq
         i3Rvgd+4JbnsgVU71aTDhUAlzvK7Y7TxZuja/5g894bOGeSIdgTMm8KQcfgSRJ4Ac/UV
         GNfQEK6ksM6AjoxxHp+0qKLcXkxucBS2al19cqUpfFZklPpZw75Ip3j+GE3grEjWYbnh
         udvES/Wg/gLRXKw7lsA+YKYOhABtEwTQmNr1xlUpLAhKXz8xWnKWEi6ac1SB0mf1THGn
         KGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597917; x=1768202717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lvutWKI7TKt16StpCuzmvGLizpsf+0/4btbqFsNvdR4=;
        b=ihDI3C7O+vhHbwAYu3OWroqMce4tTD4MVYisHSlcjnZYxUDH5vcRikAafhXnOtXxyW
         cCLGhWLJsTgnQMAC8ROZF8vHb65MyiN8hMacGpweFVhggNy04hh67KOgfKe05whHfO0K
         TvTCVauV5+RqbxE7R4RZ6Sp3//ZkxhHr1fIOJcHbCjwK7H3IrWTKOB8EkYRMPCKQCAIp
         RhPUkWc8mptB/bvhSB4gvslSmkYXJ+/TmXJzOA1UYP2OTT7SLhE7vLQe3VoO601aiYGP
         qH2JMBGLgkwxG5JOFNhFgRevHJz3IWaMzZiBEEqfthSI0Hp1nPWK6COkQDIXlVxDgkhp
         OX5Q==
X-Gm-Message-State: AOJu0YxnfmEK72y4fJKiPpmT7qY/RVKxbLXi9KH5f7Rmk8nEg4LFZFeW
	4uzhp6OQACp9F8aDHfkqbRSvu6XbPwZNlzQrH08w+P78+TvNLroNhpM50VxxXX9suPGrCn6AzD6
	EyVOrObND8Cch3dBgsUTr2uf9jSnJH603K0K3MgLAjwdg9HMkiqZyfN9SAiBIngMHKzAHTNZ0AG
	FGCQ==
X-Gm-Gg: AY/fxX6ctPZ5lO2Y0gNGR9rQ0FPfgp4tCILsdJ/ML+GGrsnzif/kNhQ0n5S5OQyyfPr
	9CZYQn6lIG3nmebq7sZ1RlU/XYT2eRx1e6giXGzNGKqv83nsLesgJAr77v4xnEywpHjF3Gxpg1S
	oIuD2Uzgt3JKSTD29auLpLgqigABfgsqhq00pnoZ1/dpcTPU/GLHW5h5OfAMjfYiwWzANZla4gj
	O/KABQmmhu6AQr9RVTXgz6vs4PstZphBBYPtEdSjNnzdG7wmGgP+8iEmgf8TzN8T2FkbQTjsFX3
	NtoCNnMN4jPLUaPXtBVYo0DqWDm2BHAvHRucx3hNYHQCXdgYBGvnW5+sd1omOJSjlYM1K4zQSB7
	0wmlRDg9hoHDr4qJNTiRSXXLMk7qhygBKxDIJHF6buA==
X-Received: by 2002:a17:902:e804:b0:2a1:388d:8ef5 with SMTP id d9443c01a7336-2a2f222be85mr451934765ad.19.1767597916908;
        Sun, 04 Jan 2026 23:25:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+MJaXa4atrQFdOSW/1hjfNN0xN6uSKPZogo3tKelEBarqqlMixJnmDAH+pI79WnFz10pb3Q==
X-Received: by 2002:a17:902:e804:b0:2a1:388d:8ef5 with SMTP id d9443c01a7336-2a2f222be85mr451934605ad.19.1767597916379;
        Sun, 04 Jan 2026 23:25:16 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm445201205ad.34.2026.01.04.23.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:25:16 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 5/9] wifi: mac80211: allow key installation before association
Date: Mon,  5 Jan 2026 12:54:11 +0530
Message-Id: <20260105072415.3472165-6-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
References: <20260105072415.3472165-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UJ/Q3Sfy c=1 sm=1 tr=0 ts=695b675d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=NJNI8byFtPwFAtEfovoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA2NiBTYWx0ZWRfX4nN9+To7nb7J
 KtgixvRgAYAPc3RGmD6aK11xqsnejnS7BNKIc73UYOW+sPa0lwByLrj2KxeToeadmE5O9xfhVBG
 BOaQIY0cpyAGzKFm+5TVLc8knaTPAzH2NLXTUBx4tE0y8BN7MMY4zwE/EtzXNwSrQHQ44/UCMfZ
 IvJcYGtSxF2yCWFP7fraaal23E3rXlJ5H341U4Z5iniKowYEIYhTQCGdvQd2KIdjOCR2oAdxuBF
 76z8dZWsjGnDjZdc+YZ7JO0SK59jrjWCeIRQgcX/0OJ/9tH8vFhPEXJ9+iSHyUyEGsfc9C5+Ks0
 pAUij5y6fVIlrL5x8RIj6nvnBbRzadyNy5+9eAticrQbSf85D8LjNbG84uboPmkFBMadR89KDjo
 96c5HetzNUhlScBfkAg+V1QNpzzp/mrAXSxnTuaXSCd2nrAGByCHlZZKpeI12YIH3AfBk+xGbHL
 PVgcYPx5Mw3wuku0tsg==
X-Proofpoint-ORIG-GUID: aK_yKs7J69m-_kR99WwyRWHnJqiOxjBh
X-Proofpoint-GUID: aK_yKs7J69m-_kR99WwyRWHnJqiOxjBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050066

Currently, mac80211 allows key installation only after association
completes. However, Enhanced Privacy Protection Key Exchange (EPPKE)
requires key installation before association to enable encryption and
decryption of (Re)Association Request and Response frames.

Add support to install keys prior to association when the peer is an
Enhanced Privacy Protection (EPP) peer that requires encryption and
decryption of (Re)Association Request and Response frames.

For non-AP STA mode, the existing "epp_peer" parameter is set when the
authentication algorithm is WLAN_AUTH_EPPKE during station profile
initialization. For AP mode, it is set during NL80211_CMD_NEW_STA and
NL80211_CMD_ADD_LINK_STA. When "epp_peer" parameter is set, mac80211
now accepts keys before association and enables encryption of the
(Re)Association Request/Response frames.

Co-developed-by: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Signed-off-by: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/cfg.c  | 12 ++++++++++--
 net/mac80211/mlme.c |  4 ++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index afc636a31f57..ba7b1110c2f3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -680,10 +680,18 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 		 * association has completed, this rejects that attempt
 		 * so it will set the key again after association.
 		 *
+		 * With (re)association frame encryption enabled, cfg80211
+		 * may deliver keys to mac80211 before the station has
+		 * associated. In that case, accept the key if the station
+		 * is an Enhanced Privacy Protection (EPP) peer.
+		 * If (re)association frame encryption support is not present,
+		 * cfg80211 will not allow key installation in non‑AP STA mode.
+		 *
 		 * TODO: accept the key if we have a station entry and
-		 *       add it to the device after the station.
+		 *	 add it to the device after the station associates.
 		 */
-		if (!sta || !test_sta_flag(sta, WLAN_STA_ASSOC)) {
+		if (!sta || (!sta->sta.epp_peer &&
+			     !test_sta_flag(sta, WLAN_STA_ASSOC))) {
 			ieee80211_key_free_unused(key);
 			return -ENOENT;
 		}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ad53dedd929c..cfb87ae81bb8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8964,6 +8964,10 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 			goto out_err;
 		}
 
+		if (ifmgd->auth_data &&
+		    ifmgd->auth_data->algorithm == WLAN_AUTH_EPPKE)
+			new_sta->sta.epp_peer = true;
+
 		new_sta->sta.mlo = mlo;
 	}
 
-- 
2.34.1


