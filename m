Return-Path: <linux-wireless+bounces-29383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBAFC8EB1E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 15:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B118434AB69
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 14:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6223328FB;
	Thu, 27 Nov 2025 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HtbHrGYn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L6sLbs2K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E133290D
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252395; cv=none; b=F1Bl5ebRqYJ6EUfNfS/ySzNo7FtfpsP/pGF9ADHJ07TNxcOqsF7kccdmKaRJdkZA61tD7yxZQhuY1PctgBZzVZ3CuN63E5TFkjqbvp04HtakZ+1TBrrJvebL/aW0SVfNvXJjvMHENIGlFkElG2mmbViYo7uQ9gF0p5/V6vuTNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252395; c=relaxed/simple;
	bh=bH0yZ3+iR1mwll1Kv7+qV4snT9py+Y/YbAQ0qRMBxrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RyKc1lxU4leqg6nHIaIHsN84TnHrE6UkQOGvs5VLSiTqGZn/weNUTBXsFhqet2hjAEXF4Z8Hhv64doMG3sWRqmJuQrb5wyzdhggGDVDSJ+5tC+rNr+AZH8Pw5qhldrJmXa5ESvXxQWe5GzyFAAQkH3KSKS90GNJBraOlYNCu/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HtbHrGYn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L6sLbs2K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR65oOf2855075
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 14:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=e726wCDNerf
	H5O8W52clXMJw73vLWrYrQPXWDspdSr0=; b=HtbHrGYnSf61JRDVOBUaOf3z4VR
	dtavOjbc/Ij2uOQyDnIyn4JaLo+e4BoP4RQ8ZQ7Z3c3h7aabOkN1bSLMta+tau/i
	9hQ12rmnCwHUXE0AGIruQxukgDKkWm9VvZTt9jkxzDuftucI33FdbADZwDnXtGMp
	yMaGNkuPlhiW6f6OXOipaNT4kGW1x5T5eLe+e6FLlRfcrTvvW7MWE7qGY/IxPQ8g
	uxbWgjgo6+z5wosTuIAbWcHcR5E/methvKXC2sjJKBkBJRX3JKGAhDgb5nkONwO5
	qLIQjTrfZVnAkx8yPXRQw98R8QK9p9cAev1c+rjgsIbWhGUgIU3Lfel875A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap4vhb3yf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 14:06:32 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7aa9f595688so1283358b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 06:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764252392; x=1764857192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e726wCDNerfH5O8W52clXMJw73vLWrYrQPXWDspdSr0=;
        b=L6sLbs2KPsfN2mOlEpV/wIKoWZzIDcKpHHxTNgktCQKKW1BdQXViXeaidqK0zd7HJ9
         pDLDhONh3jBXB4L2iov6jqHvTZI1pRPgiX7utheF3ljjNMYsi5VwIPdjTEIoWFOoONOd
         t//OP5BFC9c4eu797vcdEv2owNx+67WiRcs+S20PT0HaeoY3eAE02JAjfUwFRDnT2Ohh
         UgSQItJPfVUczJsre4Bfa+zNmoUEGjVZhSuG2D0aV/gjtCM7M4/ZE4jWIBM0LINgIGmw
         2PpAG3T98HN6dIYFvusftdgflrLNnnGB5OCwktwTrDInARw0ojWHYwVuYiJimosQ3wJ1
         +tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764252392; x=1764857192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e726wCDNerfH5O8W52clXMJw73vLWrYrQPXWDspdSr0=;
        b=dbw6y5kV3wsuKucN0M+Cu7CauIPYLtwyUXxheGqeGmz/eld5vXXJcoMPUZAysHX5cb
         fC9cwpLTNZg2zbbSZDtDeZcwPUv6i1iIpWhXrFXJNHWHnJ5Ws5hi2lwKejJDzzZyrNlD
         ZxWdAv7ePRQES2Rn/ofpXmOi9PFurUptXQTllGPCmDt4Sv7AfXBvAGLzKEihEgTwH/rP
         9P5E95LEe35Bool58jFXnIvwgs7MRMGstjHMJ3XUbxCi6rbxFH+iuj/KmyqCj1hM8/Kg
         7yckBRUPEZRaLxB7fI3F+oeE3UI7nb3z7DXFIlZQw4iRRrtu/q4mYS2Lyin8WhM/q85V
         fW7A==
X-Gm-Message-State: AOJu0YySToWYsvmfdRmUgiXXgqIs/yFQmZ8fSqSHmqj+82mLKYEhuHaF
	kLj2PIj/RRk/3ezukr6qChGu47d2AuOj1O1iAHC6kLyEBWzBBCOeWbxAUWNqH55cXCZAjq4qI+A
	RWfXwptspTMSbD7vZr0y11WQ825UCxAllyA7g/pbrmJ0GqK4rNQW5Jr7QgQWeCwJY3sqThmBQ7G
	5Esw==
X-Gm-Gg: ASbGncvInkxZnCU4hcRQKtai3Urp5T5c8HNG+Y1kWCz9zprLyEBhg3Pb7ncLZLCGpLj
	rCMRDkH33zoXu6w54v6VC2HvrmFyX+Exe2jxgjxwg040pTxavaCV6a1Kr2rlVzheEDXoBDr/9V2
	Mpqb+JVp82NF7Gt/lUDZyxSt7JCYK8Ft0M7DhG04OtWDMZ3hBwC/g6Xb8fuTnlwfuMFUvvf6M0w
	YTkdJXghSGN4pZgyvBu5jeX3/3cr9NK6aSvC+MwpvRcdcUT2EYayvvpqOyffRJTMfblvtuaCWHj
	nSA1KJJDiv4sje1nKac8HTY6/CESxew908St4hEcB6EO+hq5ruPXsYUHg7xk/Ikf3zXhxWW4zGh
	+/Xl4Xzhv6/A19GEPU69/mD0FS5HpBnjEfZJbf/DbrMeLsnNYN57NyYJE8DUYWbGGyi7WyVcJzO
	3H6f4wU90H3yK45Rults3/n9cRtf4cQya/8Z0=
X-Received: by 2002:a05:6a21:328d:b0:35d:1bcd:6877 with SMTP id adf61e73a8af0-3614edf12bbmr29078452637.42.1764252391530;
        Thu, 27 Nov 2025 06:06:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWiomLNaQJfLe3JSLkPhV6sY4hC63jpbug3NYS7qfzcoyhf00gNB7o+RoR8nJCaUMEnyA3zw==
X-Received: by 2002:a05:6a21:328d:b0:35d:1bcd:6877 with SMTP id adf61e73a8af0-3614edf12bbmr29078396637.42.1764252391024;
        Thu, 27 Nov 2025 06:06:31 -0800 (PST)
Received: from hu-surapk-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fb24942dsm2125631a12.6.2025.11.27.06.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 06:06:30 -0800 (PST)
From: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>,
        Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH wireless-next 2/2] wifi: mac80211: set addr2/addr3 to link address for NULL packets to non-MLO stations
Date: Thu, 27 Nov 2025 19:35:55 +0530
Message-Id: <20251127140555.472327-3-suraj.kizhakkethil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251127140555.472327-1-suraj.kizhakkethil@oss.qualcomm.com>
References: <20251127140555.472327-1-suraj.kizhakkethil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEwNSBTYWx0ZWRfX8+pGORFUxFH+
 dVTqI9mV/b8KOSnOK9PdCw7ejmSDeWKGtWwUPAXFKtpx9hcPAjgL16+EoSLs+gj20HP3GMPPb1I
 h24iQCCkrFWPyz2h0+Nm4zZ7JMCyEEkC94O3R+O8YnIB7SYsyRcIk8tph4ao1JO6kEpJDpj+obN
 0jKrNxC4dHxr5ldLZS2xXnrgg+9MH03r50Clrv9OA7PsTCUxc96JbgZ93VcThS42Z2sqXityXn0
 fn7bYqKvno+LZmB2UmXAhm1YbUKq7j6l+LzvQOW5dU6ii3SN7HM0Uh/6Q0uotbiuCnFle+kIvrO
 TUQLgXZcMmlTvMM3hm/kJtV4aEWFsaMAoWwwDCs1jcccIF/0JCx5hDRjHsdYGXDiRuLQOdzxB1o
 dlFBLt79oc0Hnz+ZM+Fs9Bk1GvuqCw==
X-Proofpoint-ORIG-GUID: uLXmOvp5zCWbuM4nET2OKbQww8sak-Mf
X-Proofpoint-GUID: uLXmOvp5zCWbuM4nET2OKbQww8sak-Mf
X-Authority-Analysis: v=2.4 cv=Lt6fC3dc c=1 sm=1 tr=0 ts=69285ae8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=vY42MFZz5H39fPUu7hEA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270105

Currently, for non-MLO stations connected to an MLD AP, addr2 and
addr3 are set to the MLD address when a NULL packet is triggered to
probe the station, which is incorrect. Set addr2 and addr3 to the
link address for the NULL packets sent to probe non-MLO stations.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Signed-off-by: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9554b25b8fc6..dc31b1b1ba95 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4595,6 +4595,8 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	struct sta_info *sta;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	enum nl80211_band band;
+	u8 link_id;
+	struct ieee80211_bss_conf *conf;
 	int ret;
 
 	/* the lock is needed to assign the cookie later */
@@ -4610,6 +4612,21 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	qos = sta->sta.wme;
 
 	if (ieee80211_vif_is_mld(&sdata->vif)) {
+		/*
+		 * For non-MLO clients connected to an MLD AP, band
+		 * information is not used; instead, sta->deflink is
+		 * used to send packets.
+		 */
+		if (!sta->sta.mlo) {
+			link_id = sta->deflink.link_id;
+
+			conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+
+			if (unlikely(!conf)) {
+				ret = -ENOLINK;
+				goto unlock;
+			}
+		}
 		/* MLD transmissions must not rely on the band */
 		band = 0;
 	} else {
@@ -4646,8 +4663,13 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	nullfunc->frame_control = fc;
 	nullfunc->duration_id = 0;
 	memcpy(nullfunc->addr1, sta->sta.addr, ETH_ALEN);
-	memcpy(nullfunc->addr2, sdata->vif.addr, ETH_ALEN);
-	memcpy(nullfunc->addr3, sdata->vif.addr, ETH_ALEN);
+	if (ieee80211_vif_is_mld(&sdata->vif) && !sta->sta.mlo) {
+		memcpy(nullfunc->addr2, conf->addr, ETH_ALEN);
+		memcpy(nullfunc->addr3, conf->addr, ETH_ALEN);
+	} else {
+		memcpy(nullfunc->addr2, sdata->vif.addr, ETH_ALEN);
+		memcpy(nullfunc->addr3, sdata->vif.addr, ETH_ALEN);
+	}
 	nullfunc->seq_ctrl = 0;
 
 	info = IEEE80211_SKB_CB(skb);
@@ -4656,8 +4678,15 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 		       IEEE80211_TX_INTFL_NL80211_FRAME_TX;
 	info->band = band;
 
-	if (ieee80211_vif_is_mld(&sdata->vif))
-		info->control.flags |= IEEE80211_TX_CTRL_MLO_LINK_UNSPEC;
+	if (ieee80211_vif_is_mld(&sdata->vif)) {
+		if (sta->sta.mlo)
+			info->control.flags |=
+					IEEE80211_TX_CTRL_MLO_LINK_UNSPEC;
+		else
+			info->control.flags |=
+				u32_encode_bits(link_id,
+						IEEE80211_TX_CTRL_MLO_LINK);
+	}
 
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 	skb->priority = 7;
-- 
2.34.1


