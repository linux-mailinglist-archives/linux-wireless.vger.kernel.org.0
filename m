Return-Path: <linux-wireless+bounces-30818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C93E1D1E5BB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 12:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB3083038050
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 11:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE20378D86;
	Wed, 14 Jan 2026 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fSBljTQg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gbebo7Mt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8C3793C0
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389581; cv=none; b=iDDP4uLvyvmQxpFBv5z55GJ7gieGSSXW5Yme01zUD5LX2N3bjVv9iPQ4be9Mw7xw7srAu3BCgnFrTGBahtr2fxEypqMEXcVNkLfxJtYT/glIhTx7BLmvyPTYOAZwnj4lAX2tEHZwr7VxEXWw6P80dbkO1pVSrFpkTjUOnz/xn4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389581; c=relaxed/simple;
	bh=AKjn9kUYrciWdpLgM3VycWOQyrvUf8bCAkHnUaYvhNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZ04luaDuGWryoOdIWC5e0wKbSIUT3THUIjb68BYFZsrt/4ssLLja11yQFo5P9hm3fOJuRytLVDmdCAp8kF0LuavDIgDQJwZUsNOPrHFyKmBgbvmcaymJ94Lej3N0hvqRSvHw4RBLeyjKJAEEwRcjVrIyAdSDWt4LsKrHtkhbwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fSBljTQg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gbebo7Mt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E9I9gD2552834
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=E2GpiPFcLoW
	E5HMahrybDmJm3DsYfFlMOh6/xOZl+v4=; b=fSBljTQguaP6i+Amm5zgAxe1RH4
	vdzDq8EplIwgsJAg/54QhBJp24KpkeLnV3gBb1JullZrrNM4CqaPLI0O7zZ8vNMQ
	/544pl50/t0RNK8jW/SiVzaIqLfP/uJM5t+QRdHpzbEVUY2IZZy2hd+TRQD9lEmd
	Ls0NI8nWVkaZwh+7+is0Ok4356Fgun6n7kjlMrU2Jlu6Bi/igAB5HCYAc8Sf5FnH
	CPA2JWjxAgW5C++h9RwUAAfQ7V29hWyXe2ZKGGALQQqRJ3P0AB3mBnF6dzhlTKog
	AvQicFow9bzOXWi9ufpjr1zs7BGd0Cnm476ULKNvLVR4PCgrKcywb54wH1g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp8d30fgu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:39 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34abd303b4aso17047199a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 03:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768389579; x=1768994379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2GpiPFcLoWE5HMahrybDmJm3DsYfFlMOh6/xOZl+v4=;
        b=gbebo7MtBiMR02MlAMy+dWGHbpgYj+/srArKpp7LEZCDkYCUTD/Sp8EkNtCViW/0/6
         JbItOCUexjfCRLeQF0VUQUsOmwILCtMrKzqTJgLBK0sIktgs7RuXVupLZaeQQ5zXvbWZ
         WqYl+ohpqUcwnSrxYtadWlJHa8LiSo+217YWJo8x/fwmdm5FpVW8m7CUuJ4PPiFshnCU
         3beA7HemaIA5Id1WE9EV4DGytgX/07VuGC4HlmJ0xC1003AP1DCinQfxE26zZ6ERj3mA
         7pKBUuLLe3EC2aYHUycPjuc3Ka8O9qHJhxQJY7KFaQV+EpvrqKPQuAN5tXf8hfpgx+45
         DYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389579; x=1768994379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E2GpiPFcLoWE5HMahrybDmJm3DsYfFlMOh6/xOZl+v4=;
        b=V2dX+1RIKgN6DC7G/d3E9RXpxtbnhiWv4tGdfi53pKG+XJUZgxWfO+iMo/k4S8uYna
         +2bD19GimWb4WpdoTXlpf/rfj3+nldfAemc5ogXe9mRpC+bIQuMYXtS8eHeskasztR3L
         W5QYJjbdgPcfxIc2SwMsQZBjIU1HPGb1vh47s/qulMmyhgR7rQ4X6Vt5Y/qIRsaRBApk
         AJYl6cvmNxj0FmRSSD4EBKNhJ/kfVy3c6X1OAScG27pAfYELyRybTPKOSFLn8tqdYjVa
         44oJulO8xii1BSqqWD3KI2hHdv4Nemzur/Noelesis2k4ZtJQgCs8fIoAta6vau5PRo8
         MxAQ==
X-Gm-Message-State: AOJu0Yz6o6lTayp+3qcRq5K8lQ8gpN2VG1pcBbuMwfYZbw2up186ID7X
	hygdWjDfq2fp33Pw9tdXK9g6K+K5VDl1jkjQdF4DbrQC0114OPlFLYtiE+xmq+efrRGKLM7CU8d
	WdUV8+aGYwKN5CFYKJg9c+V5jMVlJprTbjPQ+Scmq0RVDnc7oY0GhWPVkxrJ3DdS1rMDeaw==
X-Gm-Gg: AY/fxX4TJYziBhpNWN3mkdJlYxmRslaAa1gStOyCB4BP7V92fxnuAtZdpE1oKZYziI9
	EnBi3jx8rL2h9yCGXSrRgpUPFqR8BDLnUNamdFPtVSnINRY/mVWwfhFDcD4yK6ulTLc6+Ar5jdS
	042QYWpcRQs7UMArOIIVGyX7/8kCVGM3N0/7voMnp9a05H3CvJEzWobxiAf/1kWH7I0CaU4YPj5
	T0Uq3DjJuIUpo2cYazVmniDZ34adTzz8A0qW088YRf+TsFKT+t8ejxOjp6lD0g8fn0kM5jYUZ88
	Y5mDMBsLUdnNew9dMf4A//4NgGtPYOypvQXmuz4ediISBk7wE96PeK1ZKbZERQkiorg1gj3pzMG
	3vlFPzHp3+Wb6qxGzoKi9WS4R00fgeR6rd9ekdwTj7g==
X-Received: by 2002:a17:90b:514d:b0:340:e517:4e05 with SMTP id 98e67ed59e1d1-351090b1653mr2710302a91.12.1768389578585;
        Wed, 14 Jan 2026 03:19:38 -0800 (PST)
X-Received: by 2002:a17:90b:514d:b0:340:e517:4e05 with SMTP id 98e67ed59e1d1-351090b1653mr2710280a91.12.1768389578159;
        Wed, 14 Jan 2026 03:19:38 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm22402512a12.32.2026.01.14.03.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:19:37 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v4 7/9] wifi: mac80211: add support for EPPKE authentication protocol in non-AP STA mode
Date: Wed, 14 Jan 2026 16:48:58 +0530
Message-Id: <20260114111900.2196941-8-kavita.kavita@oss.qualcomm.com>
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
X-Proofpoint-GUID: p5Uy_WoyRaAI31kd8o6Bs5DHlf4p4tsm
X-Authority-Analysis: v=2.4 cv=fbWgCkQF c=1 sm=1 tr=0 ts=69677bcb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=UINr_V146bfacmMmwVQA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: p5Uy_WoyRaAI31kd8o6Bs5DHlf4p4tsm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfX+JPtbHcW8m0k
 r/IZ8nDubPu4EYLc23F423KthpynczAWx+C2nCYnNp1jQ4tzMMapZyMoZ/vGXBUQwyV8uPg1qyP
 41yushmVkyEXKwW31Fz2d0fKNf9r22+LADjPlrzo2a2C+eS8Y9vzvdEf+gCGYhvK0dkvCr1gCI8
 wGaM7iGoB233nWXov7IMFUcUjxCL31WcURhiaSQUVe8JGPK0UbcGXdjOI/dEnPOSDwF5xVlle83
 B/+vm8dYb7PErHtPb6cncODtZu9xRRXQTzqcLpU3MFyX8XcaoCBco+IcahkZeaFfcXUs+xk8AMV
 wpJ9d6ERAW0nhSHdEdo2uTb3L1HNbtuaZ/NBoFDEmvgj70sz1DslloUpvCyWumHT69plDgy8HGI
 b5tX/WU8YZfiSyoH5uMTsRz/VumlaUX6dmgfOPggho9cr9/3gMQx+3UC0Tzb0aJGvYWGQRQHOsW
 7WyL+5mY8AbGyG9M4oA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140093

Add support for the Enhanced Privacy Protection Key Exchange (EPPKE)
authentication protocol in non-AP STA mode, as specified in
"IEEE P802.11bi/D3.0, 12.16.9".

EPPKE is an RSNA authentication protocol that operates using
Pre-Association Security Negotiation (PASN) procedures. It consists
of three Authentication frames with transaction sequence numbers 1, 2,
and 3. The first and third from the non-AP STA and the second from the
AP STA.

Extend mac80211 to process EPPKE Authentication frames during the
authentication phase. Currently, mac80211 processes only frames with
the expected transaction number. In the case of EPPKE, process the
Authentication frame from the AP only if the transaction number matches
the expected value, which is 2.

After receiving the final Authentication frame with transaction number 3
from the non-AP STA, it indicates that both the non-AP STA and the AP
confirm there are no issues with authentication. Since this is the final
confirmation frame to send out, mark the state as authenticated in
mac80211.

For EPPKE authentication, the Multi-Link element (MLE) must be included
in the Authentication frame body by userspace in case of MLO connection.
If the MLE is not present, reject the Authentication frame.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mlme.c        | 31 +++++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 649ea9d2ae9b..0a8875e0709b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -430,7 +430,7 @@ struct ieee80211_mgd_auth_data {
 
 	u8 ap_addr[ETH_ALEN] __aligned(2);
 
-	u16 sae_trans, sae_status;
+	u16 trans, status;
 	size_t data_len;
 	u8 data[];
 };
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 977303fdfd9f..f7af6750f8d9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4911,6 +4911,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	case WLAN_AUTH_FILS_SK:
 	case WLAN_AUTH_FILS_SK_PFS:
 	case WLAN_AUTH_FILS_PK:
+	case WLAN_AUTH_EPPKE:
 		break;
 	case WLAN_AUTH_SHARED_KEY:
 		if (ifmgd->auth_data->expected_transaction != 4) {
@@ -8277,6 +8278,12 @@ static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
 	if (WARN_ON_ONCE(!auth_data))
 		return -EINVAL;
 
+	if (auth_data->algorithm  == WLAN_AUTH_EPPKE &&
+	    ieee80211_vif_is_mld(&sdata->vif) &&
+	    !cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
+				    auth_data->data, auth_data->data_len))
+		return -EINVAL;
+
 	auth_data->tries++;
 
 	if (auth_data->tries > IEEE80211_AUTH_MAX_TRIES) {
@@ -8305,9 +8312,12 @@ static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
 	auth_data->expected_transaction = 2;
 
 	if (auth_data->algorithm == WLAN_AUTH_SAE) {
-		trans = auth_data->sae_trans;
-		status = auth_data->sae_status;
+		trans = auth_data->trans;
+		status = auth_data->status;
 		auth_data->expected_transaction = trans;
+	} else if (auth_data->algorithm == WLAN_AUTH_EPPKE) {
+		trans = auth_data->trans;
+		status = auth_data->status;
 	}
 
 	if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
@@ -9222,6 +9232,9 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	case NL80211_AUTHTYPE_FILS_PK:
 		auth_alg = WLAN_AUTH_FILS_PK;
 		break;
+	case NL80211_AUTHTYPE_EPPKE:
+		auth_alg = WLAN_AUTH_EPPKE;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -9246,12 +9259,14 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	auth_data->link_id = req->link_id;
 
 	if (req->auth_data_len >= 4) {
-		if (req->auth_type == NL80211_AUTHTYPE_SAE) {
+		if (req->auth_type == NL80211_AUTHTYPE_SAE ||
+		    req->auth_type == NL80211_AUTHTYPE_EPPKE) {
 			__le16 *pos = (__le16 *) req->auth_data;
 
-			auth_data->sae_trans = le16_to_cpu(pos[0]);
-			auth_data->sae_status = le16_to_cpu(pos[1]);
+			auth_data->trans = le16_to_cpu(pos[0]);
+			auth_data->status = le16_to_cpu(pos[1]);
 		}
+
 		memcpy(auth_data->data, req->auth_data + 4,
 		       req->auth_data_len - 4);
 		auth_data->data_len += req->auth_data_len - 4;
@@ -9302,7 +9317,11 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	 * out SAE Confirm.
 	 */
 	if (cont_auth && req->auth_type == NL80211_AUTHTYPE_SAE &&
-	    auth_data->peer_confirmed && auth_data->sae_trans == 2)
+	    auth_data->peer_confirmed && auth_data->trans == 2)
+		ieee80211_mark_sta_auth(sdata);
+
+	if (cont_auth && req->auth_type == NL80211_AUTHTYPE_EPPKE &&
+	    auth_data->trans == 3)
 		ieee80211_mark_sta_auth(sdata);
 
 	if (ifmgd->associated) {
-- 
2.34.1


