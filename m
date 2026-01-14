Return-Path: <linux-wireless+bounces-30816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2AD1E5A4
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 12:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A64B300385A
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A6036A027;
	Wed, 14 Jan 2026 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AgMT9kaa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y+NK9Tfi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F8D38FEE3
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389576; cv=none; b=ac/5sMtFDYwUCUnar2gw4iJHs0NhRbjnC0NLWYyXVSEcVxUbZ/B0qdCD9UwEYsg4NnBx8RpmytvjyhXH9kZl252IjppQwgHwbNWA9TOgQusZf404JQMbnwOFkFjUQS8q9qUMtT1sLVxVRYBbji5HU8ySY7NFmvqKAbmCkxNqiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389576; c=relaxed/simple;
	bh=sWKY5QEWBhqZ18D9UZYyxLpuRcJMRu3GLgPtyucVZns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOMyK3O1j8Pz3WOx5sRbCMZtC+6xKsdJXCs1dmr7rfxkDiypLQMnHMKpYFEONAeaXJtBrfhJqgKl0cU0ItniSmKDsuFd7eQ21SxCpjYzx26DSRFNtRu+C8NY2j9QTYk/lRpbVpJMzI5tAGa0xRGZhXVK8QOE6jsk3DC5NC8yMKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AgMT9kaa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y+NK9Tfi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E85m6K1942984
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gMBpAvWxZCCjvNuUfYZb8KKgOBlhMYdnRN5bXqz6Tw8=; b=AgMT9kaaRafEzW6B
	znraKpwsLjqcryWRVIT5NLhDYHBSRseDKOVe+6Fu+kkrl14lsD64QcXjxQYsEYhm
	cJgC3VBc7DML69dZBx+8Lzl3bK4HvkiIq/nentfayo6VHfm5+RzaHdG5cJmzJ7Lz
	YnchRS6jvMr1eNGZxg/fYvJ2r/PMnw71TaBmRVlj7e3vnCf4Nf0Pccm1Xk7J0FrI
	vYKWm8Vo9mmXyKpmGdrIvrz7WalgAUSfrwLd/yj9lIQUC6NGaSyG3sB7Ju8CY/Ag
	oLrS9xnkHy5IGaqWImpF3KX6BlFZ5mgG4d6K7Kjes36/CBSVdr/olyrJjPqsHvHY
	BhkMSA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp7b6rry1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c5291b89733so3911660a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 03:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768389573; x=1768994373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMBpAvWxZCCjvNuUfYZb8KKgOBlhMYdnRN5bXqz6Tw8=;
        b=Y+NK9TfiKBcSzYCzKrdKNYzmVXIP9v1mMTpkhSmxspcZzf0udPEYwTCtr45vu8icY1
         Lz9ScQ4TMp3Em3CJLE/fc8Zec6U/bmSQRC/rcRW5Iu30vvlhR6yK8PPRg0jILY9kX8Gu
         w1+f7TOi9R1nrxVaUPcEIWXns45wKbldIQZpl6rRvyqYMhibjD/N8PxfW3veacKa21UY
         QjxcPk/OJ8eNKhflHIc6UzJ7LytB0akQCNfILUsf5DWZR5pxkHFjTEGr5T9NOPjZ+l5D
         z+nwAqCVKOVv2ZjD50EWhJNYKII56KWz2HhX42haTH8IUQq9/39W5LwqRGqCT2mpzvIA
         LDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389573; x=1768994373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gMBpAvWxZCCjvNuUfYZb8KKgOBlhMYdnRN5bXqz6Tw8=;
        b=YsCE3r3sjsdqC0TOoN3voYO1mj6F16krzF8mz4Cceu1Mqxzgfgh5GwNvemkRhgHfsD
         LUYYIiy3S5jdCzKv6k1JNBh+zZD8zPb2k7VsmG1t3j1+JRiChNLSQZgVQNo2Ns2CxYAZ
         psTVVNpmbgtRHeoi3x9zpmPGcjHEWpFljaHufLhQ7csp7MPpjQc2oSpRvg0hXp7OxnVu
         2NjRu4cvT1aKMoE/q5CRLAQ0AGw7vb+WjHBJB8tW/RWUxmvqqcBZVbHhWohDYEdwHSAa
         50yLpwzpIZgwjD1dZ6qdB0en6Et6aXzQLrsT/7ifx6RDf3o2y0wTnfTIKHf1gBpxRQsc
         ySSA==
X-Gm-Message-State: AOJu0Yxz8PJ0DlP9utfyvTFe5GDIkjOz87CQ4FFpLddLc8suHo2jrqxj
	uxvFKEMTXgBpEti4M4mKhbdK0d/LSkdZFUnDIk6BBKJ4qybJZCqhG5RqAvFFsJg6lUKKJw8fjmS
	5kk6dBmrHXFgIyOZs+QKF+uhKu+DXrtQGneDYgRWHuNPIJ8bA3f6QP7fSZX/NoPU7VDSkiQ==
X-Gm-Gg: AY/fxX4AQEUPuy8B5Six4oxf12kADaVLuzKWm8ztzFSzKBgJBegdv48Uct+BFwK8GAl
	UwBD+EqpJYuiJaMV1nMvmFJBNPw+u2ezKMBCiDM20Zj5Z3TWtxZrTTECfChAM7Q9ugbtknJ1rB1
	Xd7+R37twNrK+TPtptkg2JVhJrMutlXc4YITslGx5ypTy+bXggPV7NZ9LP+1CTQ+0TqNgZcIrxZ
	ppOc2bq1+RFcXqpDnMO9h5l7xvhmEr1YhaQ55Pn6SNI+VEOPON0qzyNlIJU4DFGsGJyC6Yp1ueA
	f0QO73i4bL/q/chgw2bq939/JAK5Z+IVYCd2OzFL184MRU1OYYEINmfWdLCrConvgWA9hCi8bso
	a1bHnUytffdVtRXXJLzoa+QCh+AlRVl6PvW9OCofg2Q==
X-Received: by 2002:a05:6a20:4326:b0:366:1e42:630 with SMTP id adf61e73a8af0-38bed0b35b0mr2520614637.1.1768389572862;
        Wed, 14 Jan 2026 03:19:32 -0800 (PST)
X-Received: by 2002:a05:6a20:4326:b0:366:1e42:630 with SMTP id adf61e73a8af0-38bed0b35b0mr2520594637.1.1768389572360;
        Wed, 14 Jan 2026 03:19:32 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm22402512a12.32.2026.01.14.03.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:19:31 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v4 5/9] wifi: mac80211: allow key installation before association
Date: Wed, 14 Jan 2026 16:48:56 +0530
Message-Id: <20260114111900.2196941-6-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
References: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GcIKiVvDZIDDOFYIHwDiviKDQx6stbWI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfX/0UIFl0w1tLz
 G7c1Xx5DllYMl2XJ2zeyCIVFGMqk25JEzoU5AtuHj29ROjoP+lvQhdEtotls0kz/2b++b+hb5so
 gOH4PE/D4MTaduey2lYrEFkpYKEVq+HDNQPtBOd/RjwRjE3cdWNeyJ/Gso0x/0VKQw5yLPUfBYo
 9hKtaWJO57yBirOBikrr0fCB3VwdIXlbUR1uEgrkG5RLz9OrnpOff1E/rnDu6dBsERcfCss6NYg
 wUy9nU195afIvbwWyslwRliaLBDCyX2QZdA7mMK9G9w/NV3h/J8OQ7Rs5RbP3XyGZUEVKd7Ibsy
 N70pNv9xAAxng1XQ+Iia6Qp6IUQAxB0Bupq2TdJmXTJ0xPEqaDM6kmJU9uUS0/yH5cFyu4jYx4W
 1V8cWxE6mCaeNClBHwfQD+t+2tWu6F2ygnEoaioNhQOfB+RQ0S1fVRi9d6fpxCTaZHU7u3qTms+
 I6kWsL161BhDbM7Lc5g==
X-Authority-Analysis: v=2.4 cv=W+w1lBWk c=1 sm=1 tr=0 ts=69677bc5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gT1Pn9sdE65pBECUQz4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: GcIKiVvDZIDDOFYIHwDiviKDQx6stbWI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140093

Currently, mac80211 allows key installation only after association
completes. However, Enhanced Privacy Protection Key Exchange (EPPKE)
requires key installation before association to enable encryption and
decryption of (Re)Association Request and Response frames.

Add support to install keys prior to association when the peer is an
Enhanced Privacy Protection (EPP) peer that requires encryption and
decryption of (Re)Association Request and Response frames.

Introduce a new boolean parameter "epp_peer" in the "ieee80211_sta"
profile to indicate that the peer supports the Enhanced Privacy
Protection Key Exchange (EPPKE) protocol. For non-AP STA mode, it
is set when the authentication algorithm is WLAN_AUTH_EPPKE during
station profile initialization. For AP mode, it is set during
NL80211_CMD_NEW_STA and NL80211_CMD_ADD_LINK_STA.

When "epp_peer" parameter is set, mac80211 now accepts keys before
association and enables encryption of the (Re)Association
Request/Response frames.

Co-developed-by: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Signed-off-by: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/net/mac80211.h |  2 ++
 net/mac80211/cfg.c     | 15 +++++++++++++--
 net/mac80211/mlme.c    |  4 ++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 36daccef6554..36ae7fe9ddf3 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2520,6 +2520,7 @@ struct ieee80211_link_sta {
  *	by the AP.
  * @valid_links: bitmap of valid links, or 0 for non-MLO
  * @spp_amsdu: indicates whether the STA uses SPP A-MSDU or not.
+ * @epp_peer: indicates that the peer is an EPP peer.
  */
 struct ieee80211_sta {
 	u8 addr[ETH_ALEN] __aligned(2);
@@ -2544,6 +2545,7 @@ struct ieee80211_sta {
 	struct ieee80211_txq *txq[IEEE80211_NUM_TIDS + 1];
 
 	u16 valid_links;
+	bool epp_peer;
 	struct ieee80211_link_sta deflink;
 	struct ieee80211_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index fe6be11a7f44..964f440e31cd 100644
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
@@ -2198,6 +2206,9 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	mask = params->sta_flags_mask;
 	set = params->sta_flags_set;
 
+	if (params->epp_peer)
+		sta->sta.epp_peer = true;
+
 	if (ieee80211_vif_is_mesh(&sdata->vif)) {
 		/*
 		 * In mesh mode, ASSOCIATED isn't part of the nl80211
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ddff090e7dce..977303fdfd9f 100644
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


